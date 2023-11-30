package com.jackpot.controller;

import java.security.Principal;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jackpot.domain.DogVO;
import com.jackpot.domain.MemberVO;
import com.jackpot.service.DogService;
import com.jackpot.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/dog")
@Log4j
public class DogController {

    @Autowired
    private DogService service;

    @Autowired
    private MemberService memberService;
    
    //개 등록
    @GetMapping("/register") // 로직이 없어서 Test X
    public void register(@ModelAttribute("dog") DogVO dog) {
    	log.info("register");
    }

    @PostMapping("/register") // POST 요청의 리턴 타입은 String
    public String register(
            @ModelAttribute("dog") DogVO dog, Principal principal, Model model,
            Errors errors) throws Exception {
        log.info("register: " + dog);
        
        String loginId = principal.getName();
        dog.setMemberId(memberService.getMemberIdByLoginId(loginId));
    	//model.addAttribute("member", memberService.getMemberIdByLoginId(loginId));
    	
        if (errors.hasErrors()) {
            return "/dog/register";
        }
        service.register(dog);
        return "redirect:/security/mypage"; // 요청 url
    }

    //개 삭제
    @PostMapping("/remove")
    public String remove(@RequestParam("dogId") Long dogId) {
        log.info("remove..." + dogId);
        service.remove(dogId);
        return "/deleteForm";
    }

    //개 리스트 조회
    @GetMapping("/list") // View이름: notice/list (앞뒤 "/"과 확장자는 prefix, surfix가 붙여줌)
    public void list(@ModelAttribute("dogId") DogVO dog, Model model) {
        log.info("list: " + dog);
        model.addAttribute("list", service.getList());
    }

    //개 상세 조회
    @GetMapping({"/get", "/modify"}) //get : 상세보기, modify: 수정 화면으로 가기
    public void get(@RequestParam("dogId") Long dogId, Model model) {
        log.info("/get or modify");
        model.addAttribute("dog", service.get(dogId));
    }

    //개 정보 수정
    @PostMapping("/modify")
    public String modify(
            @Valid @ModelAttribute("dog") DogVO dog,
            Errors errors) throws Exception {
        log.info("modify:" + dog);
        if (errors.hasErrors()) {
            return "dog/modify";
        }
        return "redirect: /dog/list";
    }
}
