package com.andamiro.gammi.chatting.vo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public class ChatRoomRepository {

    private Map<String, ChatRoom> chatRoomDTOMap= new LinkedHashMap<>();

    public List<ChatRoom> findAllRooms(){
        //채팅방 생성 순서 최근 순으로 반환
        List<ChatRoom> result = new ArrayList<ChatRoom>(chatRoomDTOMap.values());
        Collections.reverse(result);
        return result;
    }

    public ChatRoom findRoomById(String id){
        return chatRoomDTOMap.get(id);
    }

    public ChatRoom createChatRoomDTO(String name){
        ChatRoom room = ChatRoom.create(name);
        chatRoomDTOMap.put(room.getRoomId(), room);
        return room;
    }
}