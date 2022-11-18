package com.andamiro.gammi.search;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

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

@Controller
public class SearchController {
	private Logger logger = LoggerFactory.getLogger(getClass());
	@RequestMapping("imgSearch.do")
	public String imgSearch() {
		return "search/imageView";
	}
	
	@GetMapping("result.do")
	public String searchResult() {
		return "food/searchView";
	}
	
	@RequestMapping("camSearch.do")
	public String camSearch(){
		return "search/camView";
	}
	

	@PostMapping("imgTransmission.do")
	public String imgTransmission(@RequestParam("imgFile") MultipartFile file
			,HttpServletRequest request, Model model) {
		String imgFilePath = request.getSession().getServletContext().getRealPath("/resources/uploaded_foodImage");
		String fileName = file.getOriginalFilename();
		String renameFilename = "up_food." + fileName.substring(fileName.lastIndexOf(".") + 1);
		
		//파일 저장
		File renameFile = new File(imgFilePath + "\\" + renameFilename);
		try {
			file.transferTo(renameFile);
			logger.info(renameFile.getAbsolutePath());
			model.addAttribute("imgPath", renameFile.getAbsolutePath());
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "이미지 등록 실패");
			return "common/error";
		}
		
		return "food/searchView";
		
	}
	

	@ResponseBody
	@PostMapping("camResult.do")
	public String camSearch(HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception{
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
			model.addAttribute("snap", filePath + "\\cam_food.png");
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "촬영된 이미지 저장 실패");
			stream.close();
			return "common/error";
		}
		
		return "food/searchView";
	}
}
