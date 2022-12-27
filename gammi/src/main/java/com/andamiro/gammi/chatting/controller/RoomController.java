package com.andamiro.gammi.chatting.controller;

import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
        HttpSession session = request.getSession();
		Member user = (Member)session.getAttribute("loginMember");
        ChatRoom selRoom = new ChatRoom();
    	selRoom.setGroup_no(gno);
    	selRoom.setM_id(user.getM_id());
        ModelAndView mv = new ModelAndView("chat/rooms");
        mv.addObject("rooms", service.allList(gno));									//전체 채팅방목록
        mv.addObject("joinrooms", service.joinRoomsList(selRoom));			    //로그인유저의 가입된 채팅방 목록
        mv.addObject("gno",gno);
        return mv;
    }
    
    //사이드바메뉴에 출력할 채팅방 정보
    @RequestMapping(value = "roomsside.do", method = RequestMethod.POST)
    @ResponseBody
    public String rooms2(@RequestParam("gno") int gno, @RequestParam("m_id") String m_id , HttpServletResponse response) throws Exception{
    	ChatRoom selRoom = new ChatRoom();
    	selRoom.setGroup_no(gno);
    	selRoom.setM_id(m_id);
    	ArrayList<ChatRoom> rooms = service.joinRoomsList(selRoom);
    	response.setContentType("application/json; charset=utf-8");
    	JSONObject sendJson = new JSONObject();
    	JSONArray jarr = new JSONArray();
    	for(ChatRoom room : rooms) {
    		JSONObject data = new JSONObject();
    		data.put("chatroom_name", URLEncoder.encode(room.getChatroom_name(),"utf-8"));
    		data.put("group_no", room.getGroup_no());
    		data.put("chatroom_no",room.getChatroom_no());
    		jarr.add(data);
    	}
    	sendJson.put("rooms", jarr);
		return sendJson.toJSONString();
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
        ChatRoomJoin roommem = service.findRoomMember(members);
        model.addAttribute("room",service.findRoom(chatroom));
		if( roommem ==null)	{//첫 가입이라면
			service.createChatJoin(members);
			roommem = service.findRoomMember(members);
		}
		model.addAttribute("roommem", roommem);				 //ChatRoomJoin
		model.addAttribute("messages", service.findRoomMessages(members));	//Messages
		model.addAttribute("gno", chatroom.getGroup_no());
        return "chat/room";
    }
    //채팅방 나가기
    @RequestMapping(value = "secessionroom.do", method=RequestMethod.POST)
    public String secessionRoom(ChatRoom chatroom, Model model, ChatRoomJoin member){
    	if(service.secessionRoomJoin(member)>0) {
    		return "redirect:rooms.do?gno="+chatroom.getGroup_no();
    	}else {
    		return "common/error";
    	}
    }
    
    //채팅방 삭제
    @RequestMapping(value = "roomDelete.do", method=RequestMethod.POST)
    public String roomDelete(ChatRoom chatroom){
    	service.roomDelete(chatroom.getChatroom_no());
    	return "redirect:rooms.do?gno="+chatroom.getGroup_no();
    }
}