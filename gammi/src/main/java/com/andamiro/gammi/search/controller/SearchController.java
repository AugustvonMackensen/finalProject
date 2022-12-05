package com.andamiro.gammi.search.controller;

import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.plexus.util.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SearchController {
	private Logger logger = LoggerFactory.getLogger(getClass());
	@RequestMapping("imgSearch.do")
	public String imgSearch() {
		return "search/imageView";
	}
	
	@GetMapping("result.do")
	public ModelAndView searchResult(@RequestParam("keyword") String keyword, ModelAndView mv) {
		mv.addObject("keyword", keyword);
		mv.setViewName("food/searchView");
		return mv;
	}
	
	@RequestMapping("camSearch.do")
	public String camSearch(){
		return "search/camView";
	}
	

	@PostMapping("transmitImg.do")
	public String transmitImg(@RequestParam("imgFile") MultipartFile file
			,HttpServletRequest request) {
		String imgFilePath = request.getSession().getServletContext().getRealPath("/resources/uploaded_foodImage");
		String fileName = file.getOriginalFilename();
		String renameFilename = "up_food." + fileName.substring(fileName.lastIndexOf(".") + 1);
		String msg = "";
		//파일 저장
		File renameFile = new File(imgFilePath + "\\" + renameFilename);
		try {
			file.transferTo(renameFile);
			logger.info(renameFile.getAbsolutePath());
			msg = "success";
		} catch(Exception e) {
			e.printStackTrace();
			msg = "fail";
		}
		
		return msg;
		
	}
	

	@ResponseBody
	@PostMapping("transmitCam.do")
	public String transmitCam(HttpServletRequest request) throws Exception{
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
			msg = "success";
		}catch(Exception e) {
			e.printStackTrace();;
			stream.close();
			msg = "fail";
		}
		
		return msg;
	}
}
