package com.andamiro.gammi.chatting;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChattingControl {
	
	//@MessageMapping : @RequestMapping과 비슷한 역할
	//WebSocketConfig의 setApplicationDestinationPrefixes에서 설정한 /app prefix와 합쳐진 /app/hello 메시지가 들어오면 처리해줌
	//@SendTo : 가공처리된 메시지를 전달해주는 곳으로 WebSocketConfig의 enableSimpleBroker에서 설정한 /topic을 붙어 있으므로 Broker로 연결해서 전송해줌
	@MessageMapping("/hello")			
    @SendTo("/topic/greeting")
	public OutputMessage send(ChattingMessage message) throws Exception{
		String time = new SimpleDateFormat("HH:mm").format(new Date());
	    return new OutputMessage(message.getFrom(), message.getText(), time);
	}
	
	@RequestMapping("chatting.do")
	public String chattingmove() {
		return "meeting/freechatting";
	}
}
