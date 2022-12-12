package com.andamiro.gammi.member.controller;


import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;


@Component
public class GoogleLoginAuth {
	/* 인증 */
	private final static String CLIENT_ID = "134558823520-a17885r67qf7ftfv8t7v2pbu4s4ul7lo.apps.googleusercontent.com";
	private final static String CLIENT_SECRET = "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";
	private final static String REDIRECT_URI = "http://localhost:8080/foodstagram/gcallback.do";
//    private  String CLIENT_ID;
//    private  String CLIENT_SECRET;
//    private  String REDIRECT_URI;
    private final static String SESSION_STATE = "state_google";
    /*네이버 프로필 조회*/
    private final static String PROFILE_API_URL ="https://www.googleapis.com/oauth2/v2/userinfo";
    public String getAuthorizationUrl(HttpSession session) {
        /* 세션 유효성 검증을 위하여 난수를 생성 */
        String state = generateRandomString();
        /* 생성한 난수 값을 session에 저장 */
        setSession(session,state);        

        
        /* Scribe에서 제공하는 인증 URL 생성 기능을 이용하여 네아로 인증 URL 생성 */
        OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID)
                .apiSecret(CLIENT_SECRET)
                //.scope("profile https://www.googleapis.com/auth/drive.metadata.readonly") //여기 바꾸고싶은데 ㅠㅠ                  
                .callback(REDIRECT_URI)
                .scope("email profile openid") //여기 바꾸고싶은데 ㅠㅠ                  
                .state(state) //앞서 생성한 난수값을 인증 URL생성시 사용함
                .build(GoogleLoginApi.instance());
        
        final Map<String, String> additionalParams = new HashMap<>();
        additionalParams.put("access_type", "offline");

    	String authorizationUrl = oauthService.getAuthorizationUrl(additionalParams);
    	
        return oauthService.getAuthorizationUrl();
    }
    
    public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException, InterruptedException, ExecutionException {

        /* Callback으로 전달받은 세선검증용 난수값과 세션에 저장되어있는 값이 일치하는지 확인 */
            String sessionState = getSession(session);
            System.out.println("세션지정");
            System.out.println(sessionState);
            System.out.println(state);
            if(StringUtils.pathEquals(sessionState, state)){

                OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID)
                        .apiSecret(CLIENT_SECRET)
                        .callback(REDIRECT_URI)
                        .scope("email profile openid") 
                        .responseType("id_token permission")
                        .state(state)
                        .build(GoogleLoginApi.instance());
                /* Scribe에서 제공하는 AccessToken 획득 기능으로 네아로 Access Token을 획득 */
                
            OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
            
            System.out.println(accessToken);
            return accessToken;
        }
        return null;
    }
    /* 세션 유효성 검증을 위한 난수 생성기 */
    public String generateRandomString() {
        return UUID.randomUUID().toString();
    }

    public String getAccessTokens(HttpSession session, String code, String state) {
        return null;
    }

    public String getUserProfiles(String oauthToken) {
        return null;
    }

    public void logOut(String oauthToken) {

    }

    /* http session에 데이터 저장 */
    private void setSession(HttpSession session, String state){
        session.setAttribute(SESSION_STATE, state);     
    }

    /* http session에서 데이터 가져오기 */ 
    private String getSession(HttpSession session){
        return (String) session.getAttribute(SESSION_STATE);
    }
    
    /* Access Token을 이용하여 네이버 사용자 프로필 API를 호출 */
    public String getUserProfile(OAuth2AccessToken oauthToken) throws Exception{

        OAuth20Service oauthService =new ServiceBuilder().apiKey(CLIENT_ID)
                .apiSecret(CLIENT_SECRET)
                .scope("email profile openid")  
                .callback(REDIRECT_URI).build(GoogleLoginApi.instance());

        OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
		oauthService.signRequest(oauthToken, request);
		Response response = request.send();
		return response.getBody();
    }
}
