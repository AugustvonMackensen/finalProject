package com.andamiro.gammi.chatting.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.andamiro.gammi.chatting.service.ChattingService;
import com.andamiro.gammi.chatting.vo.ChatRoom;
import com.andamiro.gammi.chatting.vo.ChatRoomJoin;
import com.andamiro.gammi.member.vo.Member;


@Controller
public class RoomController {
	
	@Autowired
    private ChattingService service;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
    //채팅방 목록 조회
    @RequestMapping(value = "rooms.do")
    public ModelAndView rooms(@RequestParam("gno") int gno, HttpServletRequest request){
        log.info("# All Chat Rooms");
        ModelAndView mv = new ModelAndView("chat/rooms");
        mv.addObject("list", service.allList(gno));
        mv.addObject("gno",gno);
        return mv;
    }

    //채팅방 개설
    @RequestMapping(value = "roomP.do", method=RequestMethod.POST)
    public String create(ChatRoom room, ChatRoomJoin members){
        log.info("# Create Chat Room : " + room);
        int no = service.selectChatNo() +1;
        room.setChatroom_no(no);
        members.setChatroom_no(no);
        if(service.createChatRoom(room)>0 && service.createChatJoin(members)>0)
        	return "redirect:rooms.do?gno="+room.getGroup_no();
        else
        	return "common/error";
    }
    //채팅방 입장
    @RequestMapping(value = "room.do", method=RequestMethod.POST)
    public String getRoom(ChatRoom chatroom, Model model, ChatRoomJoin members){
    	//모임번호, 채팅방번호, 채팅방이름, 로그인유저정보
        log.info("# get Chat Room, chatroom : " + chatroom);
        log.info("# get Chat Room, ChatRoomJoin : " + members);
        ChatRoomJoin roommem = service.findRoomMember(members);
        model.addAttribute("room",service.findRoom(chatroom));//ChatRoom
		if( roommem ==null)	{//첫 가입이라면
			service.createChatJoin(members);
			roommem = service.findRoomMember(members);
		}
		model.addAttribute("roommem", roommem);				 //ChatRoomJoin
		model.addAttribute("messages", service.findRoomMessages(members));	//Messages
		model.addAttribute("gno", chatroom.getGroup_no());
        return "chat/room";
    }
    
    //채팅방 삭제
    @RequestMapping(value = "roomDelete.do", method=RequestMethod.POST)
    public String roomDelete(ChatRoom chatroom){
    	service.roomDelete(chatroom.getChatroom_no());
    	return "redirect:rooms.do?gno="+chatroom.getGroup_no();
    }
}