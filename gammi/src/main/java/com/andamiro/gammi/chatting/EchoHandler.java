package com.andamiro.gammi.chatting;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

public class EchoHandler extends TextWebSocketHandler {
	private static final Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	 
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	private Map<String, WebSocketSession> sessionMap = new HashMap<String, WebSocketSession>();
 
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		String chatMember = (String) session.getAttributes().get("user");
 
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>" + chatMember);
		
		
		// 저장! 둘중에 하나 사용하면 되는데, 선생님은 둘다 넣어두심
		sessionList.add(session);
		// sessionMap.put(chatMember, session);
 
		logger.info("{} 연결되었습니다.", session.getId()+":"+chatMember);
 
		System.out.println("체팅 참여자 : " + chatMember);
	}
 
	@Override	//메세지보내기 			//누가보냈는지에 대한 정보저장↓
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
 
		// 현재 로그인된 멤버
		String chatMember = (String) session.getAttributes().get("user");
		
		logger.info("{}로 부터 {}를 전달 받았습니다.", chatMember, message.getPayload());
		
		
		Gson gson = new Gson();
							//json으로부터 객체를 만듦		//이 message클래스를 기반으로 json이만들어진다.
		Message msg = gson.fromJson(message.getPayload(), Message.class); 
		// ↑ json을 java의 객체로 바꿔주는 것.		// user, to, articleId, articleOwnver(방장?), message;
		
		System.out.println(msg);
		
 
		// 전달 메시지
		TextMessage sendMsg = new TextMessage(gson.toJson(msg));
		
					// sessionList 모두에게, afterConnectionEstablished에서 들어오는 인간들 저장했었음
		for (WebSocketSession webSocketSession : sessionList) {
			// 상대방에게 메시지 전달
			webSocketSession.sendMessage(sendMsg);
		}
		// 자신에게 메시지 전달
		//session.sendMessage(sendMsg); 
		
	}
 
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		// 현재 유저 - 로그아웃
		String chatMember = (String) session.getAttributes().get("user");
		sessionList.remove(session);
		logger.info("{} 연결이 끊김", session.getId()+chatMember);
		System.out.println("체팅 퇴장 : " + chatMember);
	}
}
