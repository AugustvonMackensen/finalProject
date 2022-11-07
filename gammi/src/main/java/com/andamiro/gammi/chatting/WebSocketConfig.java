package com.andamiro.gammi.chatting;

import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer{
	
	@Override																				//STOMP에서 사용하는 메시지 브로커를 설정하는 메소드
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.enableSimpleBroker("/queue","/topic");								//내장 메시지 브로커를 사용하기 위한 메소드(지정한 prefix "/queue" || "/topic" 붙은 메시지 처리)
        																						//"/queue" => 1대1로 송신, "/topic" => 1대 다
        registry.setApplicationDestinationPrefixes("/app");							//메시지 핸들러로 라우팅 되는 prefix를 파라미터로 지정-> 가공처리가 필요한 경우 '가공 핸들러'로 메시지 라우팅 되도록 하는 설정
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {	//웹소켓 configuration의 addHandler 메소드와 유사. 핸들러 클래스를 따로 구현할 필요없이 Controller 방식으로 간편하게 사용할 수 있다.
        registry.addEndpoint("/gs-guide-websocket")			//"/gs-guide-websocket"는 처음 웹소켓 Handshake를 위한 경로
                .withSockJS();					
    }
}
