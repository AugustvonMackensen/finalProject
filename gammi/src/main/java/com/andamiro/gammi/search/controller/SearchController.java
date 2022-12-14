package com.andamiro.gammi.search.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.plexus.util.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.andamiro.gammi.recipe.service.RecipeService;
import com.andamiro.gammi.recipe.vo.Recipe;
import com.andamiro.gammi.search.foodinfo.vo.Foodinfo;
import com.andamiro.gammi.search.service.SearchService;


@Controller
public class SearchController {

	@Autowired
	private RecipeService service;
	
	@Autowired
	private SearchService searchService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	@RequestMapping("imgSearch.do")
	public String imgSearch() {
		return "search/imageView";
	}
	
	@GetMapping("result.do")
	public ModelAndView searchResult(@RequestParam("keyword") String keyword, ModelAndView mv) {
		ArrayList<Recipe> list = service.selectTop5(keyword);
		Foodinfo food_info = searchService.selectFoodByKeyword(keyword);
		
		mv.addObject("food_info", food_info);
		mv.addObject("recipe_list", list);
		mv.addObject("keyword", keyword);
		mv.setViewName("food/searchView");
		return mv;
	}
	
	@RequestMapping("camSearch.do")
	public String camSearch(){
		return "search/camView";
	}
	
	@ResponseBody
	@PostMapping("transmitImg.do")
	public void transmitImg(@RequestParam("file") MultipartFile file
			,HttpServletRequest request, HttpServletResponse response) throws IOException {
		String imgFilePath = request.getSession().getServletContext().getRealPath("/resources/capture_foodImage");
		String fileName = file.getOriginalFilename();
		String renameFilename = "dnd_food." + fileName.substring(fileName.lastIndexOf(".") + 1);
		String msg = "";
		//파일 저장
		File renameFile = new File(imgFilePath + "\\" + renameFilename);
		try {
			file.transferTo(renameFile);
			logger.info(renameFile.getAbsolutePath());
			msg = trainData(renameFile.getAbsolutePath()).replace("#", "");
		} catch(Exception e) {
			e.printStackTrace();
			msg = "fail";
		}
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.append(msg);
		out.flush();
		out.close();
		
	}
	
	@PostMapping("upImg.do")
	public String upImg(@RequestParam("imgFile") MultipartFile file
			,HttpServletRequest request, Model model) {
		String keyword = "";
		String imgFilePath = request.getSession().getServletContext().getRealPath("/resources/capture_foodImage");
		String fileName = file.getOriginalFilename();
		String renameFilename = "up_food." + fileName.substring(fileName.lastIndexOf(".") + 1);
		String msg = "";
		//파일 저장
		File renameFile = new File(imgFilePath + "\\" + renameFilename);
		try {
			file.transferTo(renameFile);
			logger.info(renameFile.getAbsolutePath());
			keyword = trainData(renameFile.getAbsolutePath()).replace("#", "");
		} catch(Exception e) {
			e.printStackTrace();
			return "common/error";
		}
		
		ArrayList<Recipe> list = service.selectTop5(keyword);
		Foodinfo food_info = searchService.selectFoodByKeyword(keyword);
		
		model.addAttribute("keyword", keyword);
		model.addAttribute("food_info", food_info);
		model.addAttribute("recipe_list", list);
		return "food/searchView";
		
	}
	
	//훈련 데이터 리턴(매핑 없음)
	public String trainData(String filepath) throws Exception {
		
		String result = "";
		String command = "C:\\Users\\8031k\\.conda\\envs\\yolov7\\python.exe";
		String arg1 = "C:\\yolov7-main\\yolov7-main\\detect.py";
		String arg2 = "C:\\yolov7-main\\yolov7-main\\best.pt";
		String arg4 = "--save-txt";
		String sum = arg1 + arg2 + filepath;
		logger.info("인자확인 : " + sum);
		
		int idx = 0;
		int exitVal = 0;
		
		ProcessBuilder builder;
		BufferedReader br;
		
		
		String[] cmd = new String[] {command, arg1, "--weights", arg2, 
				"--source", filepath};
		
		builder = new ProcessBuilder(cmd); //파이썬3 에러
		builder.redirectErrorStream(true);
		Process process = builder.start();
		
		//자식 프로세스 종료까지 기다림
		int exitval = process.waitFor();
		
		//서브 프로세스 출력 내용 받기 위해
		br = new BufferedReader(new InputStreamReader(process.getInputStream(), "euc-kr"));
		String line;
		
		while((line = br.readLine()) != null) {
			System.out.println(">>> " + line); //표준출력에 씀
			System.out.println(line.indexOf("#"));
			if(line.indexOf("#") == 0) {
				result = line;
				System.out.println(result);
			}
		}
		
		if(exitval != 0) {
			//비정상종료
			System.out.println("비정상종료");
		}
		
		
		
		return result;
	}
	

	@ResponseBody
	@PostMapping("transmitCam.do")
	public void transmitCam(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String msg = "";
		String img = request.getParameter("img");
		FileOutputStream stream = null;
		try {
			System.out.println("binary file : " + img);
			if(img == null || img.trim().equals("")) {
				throw new Exception();
			}
			img = img.replaceAll("data:image/png;base64,", "");
			byte[] file = Base64.decodeBase64(img.getBytes());
			String filePath = request.getSession().getServletContext().
					getRealPath("resources/capture_foodImage");
			stream = new FileOutputStream(filePath + "\\cam_food.png");
			stream.write(file);
			stream.close();
			msg = trainData(filePath + "\\cam_food.png").replace("#", "");
		}catch(Exception e) {
			e.printStackTrace();;
			stream.close();
			msg = "fail";
		}
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.append(msg);
		out.flush();
		out.close();
	}
}
