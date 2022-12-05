package com.andamiro.gammi.chatting.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.andamiro.gammi.chatting.service.ChattingService;
import com.andamiro.gammi.chatting.vo.ChatMessage;


@Controller
public class StompChatController {
	
	@Autowired
    private SimpMessagingTemplate template; 
	@Autowired
	private ChattingService service;
	
    @MessageMapping(value = "/chat/enter")
    public void enter(ChatMessage message){
        //message.setMessage(message.getM_id() + "님이 "+message.getChatroom_no() +"번 채팅방에 참여하였습니다.");
        template.convertAndSend("/sub/chat/room/" + message.getChatroom_no(), message);
    }

    @MessageMapping(value = "/chat/message")
    public void message(ChatMessage message){
    	//메시지 db에 저장
    	service.setMsgDB(message);
    	//메시지 전송
        template.convertAndSend("/sub/chat/room/" + message.getChatroom_no(), message);
    }
}