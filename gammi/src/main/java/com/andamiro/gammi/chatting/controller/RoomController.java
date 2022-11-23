package com.andamiro.gammi.chatting.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.andamiro.gammi.chatting.vo.ChatRoomRepository;


@Controller
@RequestMapping(value = "/chat")
public class RoomController {
	
	@Autowired
    private ChatRoomRepository repository;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
    //채팅방 목록 조회
    @GetMapping(value = "/rooms")
    public ModelAndView rooms(){
        log.info("# All Chat Rooms");
        ModelAndView mv = new ModelAndView("chat/rooms");
        mv.addObject("list", repository.findAllRooms());
        return mv;
    }

    //채팅방 개설
    @RequestMapping(value = "/roomP", method=RequestMethod.POST)
    public String create(@RequestParam String name, RedirectAttributes rttr){
        log.info("# Create Chat Room , name: " + name);
        rttr.addFlashAttribute("roomName", repository.createChatRoomDTO(name));
        return "redirect:/chat/rooms";
    }

    //채팅방 조회
    @RequestMapping("/room")
    public String getRoom(@RequestParam("roomId") String roomId, Model model, @RequestParam("username") String username, @RequestParam("name") String name){
        log.info("# get Chat Room, roomID : " + roomId);
        model.addAttribute("room", repository.findRoomById(roomId));
        model.addAttribute("username", username);
        return "chat/room";
    }
}