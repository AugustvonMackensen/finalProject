package com.andamiro.gammi.gammigroupgal.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.andamiro.gammi.common.Paging;
import com.andamiro.gammi.gammigroup.vo.GammiGroup;
import com.andamiro.gammi.gammigroupgal.service.GammiGroupGalService;
import com.andamiro.gammi.gammigroupgal.vo.GalleryImg;
import com.andamiro.gammi.gammigroupgal.vo.GammiGroupGal;


@Controller
public class GammiGroupGalController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private GammiGroupGalService service;
	
	
	// 갤러리 리스트 페이지
	@RequestMapping("groupgal.do")
	public String groupgal(Model model, @RequestParam("gno") int gno,@RequestParam(name="page", required=false) String page) {
		GalleryImg gal_img = new GalleryImg();
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		int limit = 10;
		int listCount = service.selectListCount();
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (currentPage / 10) * 10 + 1;
		int endPage = startPage + 10 - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		Paging paging = new Paging(startRow, endRow);
		
		ArrayList<GammiGroupGal> list = service.groupAllList(paging);
		if(list != null) {
			model.addAttribute("listCount", listCount);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("limit", limit);
			model.addAttribute("groupgals",list);
			model.addAttribute("gno", gno);
		}
		return "group/groupgal";
	}
		
		
	//모임 생성 폼으로 이동
	@RequestMapping("creategroupgal.do")
	public String moveCreateForm(@RequestParam("gno") int gno, Model model) {
		model.addAttribute("gno",gno);
		return "group/createGroupGalForm";
	}
	
	// 갤러리 생성
	@RequestMapping(value="groupgalinsert.do", method=RequestMethod.POST)
	 public String groupgalInsertMethod(GammiGroupGal gammiGroupGal, Model model, @RequestParam("gno") String gno,
	         HttpServletRequest request, MultipartHttpServletRequest  mfile) {
	      gammiGroupGal.setGroup_no(Integer.parseInt(gno));
		if(service.insertNewGroupGal(gammiGroupGal)>0) {
			GalleryImg gal_img = new GalleryImg();
			int filenameCount=0;
		    List<MultipartFile> fileList = mfile.getFiles("file");
		    String savePath = request.getSession().getServletContext().getRealPath("resources/groupGalImg");
		    for (MultipartFile mf : fileList) {
		          String fileName = mf.getOriginalFilename();

		          if(fileName != null && fileName.length() > 0) {
		               SimpleDateFormat sdf = 
		                     new SimpleDateFormat("yyyyMMddHHmmss");
		               //변경할 파일이름 만들기
		               String renameFileName = sdf.format(
		                     new java.sql.Date(System.currentTimeMillis()))+filenameCount;
		               renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
		               
		               //파일 객체 만들기
		               File renameFile = new File(savePath + "\\" + renameFileName);
		               
		               //업로드된 파일 저장시키고, 바로 이름바꾸기 실행함
		               try {
		                  mf.transferTo(renameFile);
		               } catch (Exception e) {               
		                  e.printStackTrace();
		                  model.addAttribute("message", "전송파일 저장 실패!");
		                  return "common/error";
		               } 
		               gal_img.setGal_ori_image(fileName);
		               gal_img.setGal_rename_image(renameFileName);
		               service.insertNewGroupGalImg(gal_img);
		            }
		          filenameCount++;
		      }
		    return "redirect:groupgal.do?gno=" + gno;
		}else {
			return "common/error";
		}
	}
	

	
	// 게시글 상세보기 처리용
		@RequestMapping("groupgaldetail.do")
		public ModelAndView groupgalDetailMethod(ModelAndView mv,GammiGroupGal gammiGroupGal) {
			
		//해당 게시글 조회
		 gammiGroupGal =  service.selectgroupgal(gammiGroupGal.getGal_no());
		 ArrayList<GalleryImg> gal_img = service.selectgal_img(gammiGroupGal.getGal_no());
		 if(gammiGroupGal !=null) {
			mv.addObject("gammiGroupGal", gammiGroupGal);
			mv.addObject("gal_img",gal_img);
			mv.addObject("gno",gammiGroupGal.getGroup_no());
			mv.setViewName("group/groupgaldetail"); //디테일만 바꿈
			
		}else {
			
			mv.addObject("message", 
					gammiGroupGal.getGal_no() + "번 게시글 조회 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
		
		
		   @RequestMapping("updategal2.do")
		   public String moveBoardUpdateView(
		         @RequestParam("gal_no" ) int gal_no, Model model) {
		      //수정페이지로 보낼 Board 객체 정보 조회함
			   GammiGroupGal gammiGroupGal = service.selectgal(gal_no);
			   
		      if(gammiGroupGal != null) {
		         model.addAttribute("gammiGroupGal", gammiGroupGal);
		         return "group/updategal";
		      }else {
		         model.addAttribute("message", 
		               gal_no + "번 글 수정페이지로 이동 실패");
		         return "common/error";
		      }
		   }
		
		
		
		
		   //게시 원글 수정 요청 처리용
		   @RequestMapping(value="updategal.do", method=RequestMethod.POST)
		   public String updategalMethod(
				 GammiGroupGal gammiGroupGal, Model model, 
		         @RequestParam(name="delFlag", required=false) String delFlag,
		         @RequestParam(name="upfile", required=false) MultipartHttpServletRequest mfile,
		         HttpServletRequest request) {
				GalleryImg gal_img = new GalleryImg();
				List<MultipartFile> fileList = mfile.getFiles("file");
				logger.info(fileList + "여기");
				int filenameCount=0;
		      //게시 원글 첨부파일 저장 폴더 경로 지정
		      String savePath = request.getSession()
		            .getServletContext().getRealPath(
		                  "resources/groupGalImg");
		      
		      //첨부파일 수정 처리된 경우 --------------------------------
		      //1. 원래 첨부파일이 있는데 삭제를 선택한 경우
		      if(gal_img.getGal_ori_image() != null 
		            && delFlag != null && delFlag.equals("yes")) {
		         //저장 폴더에서 파일을 삭제함
		         new File(savePath + "\\" + gal_img.getGal_rename_image()).delete();
		         //board 의 파일정보도 제거함
		         gal_img.setGal_ori_image(null);
		         gal_img.setGal_rename_image(null);
		      }
		      
			    for (MultipartFile mf : fileList) {
			          String fileName = mf.getOriginalFilename();

			          if(fileName != null && fileName.length() > 0) {
			               SimpleDateFormat sdf = 
			                     new SimpleDateFormat("yyyyMMddHHmmss");
			               //변경할 파일이름 만들기
			               String renameFileName = sdf.format(
			                     new java.sql.Date(System.currentTimeMillis()))+filenameCount;
			               renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
			               
			               //파일 객체 만들기
			               File renameFile = new File(savePath + "\\" + renameFileName);
			               
			               //업로드된 파일 저장시키고, 바로 이름바꾸기 실행함
			               try {
			                  mf.transferTo(renameFile);
			               } catch (Exception e) {               
			                  e.printStackTrace();
			                  model.addAttribute("message", "전송파일 저장 실패!");
			                  return "common/error";
			               } 
			               gal_img.setGal_ori_image(fileName);
			               gal_img.setGal_rename_image(renameFileName);
			               service.insertNewGroupGalImg(gal_img);
			            }
			          filenameCount++;
			      }
		      
		      //-------------------------------------------------------------
		      
		      if(service.updateOrigin(gammiGroupGal) > 0) {
		         //원글 수정 성공시 상세보기 페이지를 내보낸다면
		         model.addAttribute("gal_no", gammiGroupGal.getGal_no());
		         model.addAttribute("gno",gammiGroupGal.getGroup_no());
		         model.addAttribute("gal_img",gal_img);
		         return "redirect:groupgaldetail.do";
		      }else {
		         model.addAttribute("message", 
		        		 gammiGroupGal.getGroup_no() + "번 게시 원글 수정 실패!");
		         return "common/error";
		      }
		   }
		   
		   
			//갤러리 게시글 삭제 요청 처리용
			@RequestMapping("galdel.do")
			public String groupgalDeleteMethod(
					GammiGroupGal gammiGroupGal, @RequestParam("gno") String gno,
					@RequestParam("gal_no") int gal_no,
					@RequestParam(name="rfile", required=false) String renameFileName,
					Model model, HttpServletRequest request) {
				logger.info("여기 : " + gno);
				gammiGroupGal.setGroup_no(Integer.parseInt(gno));
				if(service.deletegroupgal(gal_no) > 0) {
			
					if(renameFileName != null) {
						new File(request.getSession().getServletContext().getRealPath(
									"resources/groupGalImg") + "\\" + renameFileName).delete();
					}
					model.addAttribute(gno);
					return "redirect:groupgal.do?gno="+gno;
					
				}else {
					model.addAttribute("message", 
							gal_no + "번 공지 삭제 실패!");
					return "common/error";
				}
			}
}
