package com.study.spring;

import java.io.File;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.activation.CommandMap;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.study.spring.service.BoardService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "home";
	}

	@RequestMapping("/login")
	public String login(Model model) {
		return "/login";
	}

	@Resource(name = "BoardService")
	private BoardService boardService;

	@RequestMapping("/list")
	public String list(Model model,@RequestParam Map<String, Object> map) {

		if(map.get("pageNo") == null) {
			map.put("pageNo", 1);
		}
		map.put("listSize", 7);
				
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = boardService.list(map);

		int total = boardService.total(map);

		
		int pageNo = Integer.parseInt(map.get("pageNo").toString());
		int blockSize = 3;
		Map<String, Object> pageMap = setBlockRange(pageNo, blockSize, total);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMap", pageMap);
		
		return "/list";

	}
	
	@RequestMapping("searchAjax")
	public String searchAjax(Model model,@RequestParam Map<String, Object> map) {
		if(map.get("pageNo") == null) {
			map.put("pageNo", 1);
		}
		map.put("listSize", 7);
	
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = boardService.list(map);
		model.addAttribute("list", list);
		
		return "/searchAjax";
	}
	
	public Map<String, Object> setBlockRange(int currentPage, int blockSize, int total){

		int totBlock = (int)Math.ceil(total / blockSize);
        // *현재 페이지가 몇번째 페이지 블록에 속하는지 계산
		int curPage = (int)Math.ceil((currentPage-1) / blockSize)+1;
        // *현재 페이지 블록의 시작, 끝 번호 계산
        int blockBegin = (curPage-1)*blockSize+1;
        // 페이지 블록의 끝번호
        int blockEnd = blockBegin+blockSize-1;
        // *마지막 블록이 범위를 초과하지 않도록 계산
        if(blockEnd > total) blockEnd = total;
        // *이전을 눌렀을 때 이동할 페이지 번호
        int prevPage = (currentPage == 1)? 1:(curPage-1)*blockSize;
        // *다음을 눌렀을 때 이동할 페이지 번호
        int nextPage = curPage > totBlock ? (curPage*blockSize) : (curPage*blockSize)+1;
        // 마지막 페이지가 범위를 초과하지 않도록 처리
        if(nextPage >= total) nextPage = total;

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("totBlock", totBlock);
        map.put("blockBegin", blockBegin);
        map.put("blockEnd", blockEnd);
        map.put("prevPage", prevPage);
        map.put("nextPage", nextPage);
        map.put("curPage", curPage);
        map.put("totalCount", total);
        map.put("currentPage", currentPage);

        return map;
    }

	@RequestMapping("/write")
	public String write(Model model) {
		return "/write";
	}

	@RequestMapping("/writeok")
	public String writeok(@RequestParam Map<String, Object> map) {
		// 기존에 하던 방식(request 로 파라미터 불러오는 방식)
//		String name = request.getParameter("name");
//		String id = request.getParameter("id");
//		String subject = request.getParameter("subject");
//		String content = request.getParameter("content");
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("name",name);
//		map.put("id",id);
//		map.put("subject",subject);
//		map.put("content",content);

		int insert = boardService.insertBoard(map);

		return "redirect:list";
	}

	@RequestMapping("/content_view")
	public String content_view(@RequestParam int seq, Model model) {

		int uphit = boardService.Uphit(seq);

		Map<String, Object> map = new HashMap<String, Object>();

		map = boardService.content(seq);
		model.addAttribute("content", map);

		return "/write";
	}

	@RequestMapping("/modify")
	public String modify(@RequestParam Map<String, Object> map) {

		int modify = boardService.modify(map);

		return "redirect:list";
	}

	@RequestMapping("/delete")
	public String delete(Integer[] checkbox) {
//		for(int i=0; i<checkbox.length; i++) {
//			System.out.println(checkbox[i]);
//		}
		

		List<Integer> list = Arrays.asList(checkbox);
//		int delete = boardService.delete(list);

		return "redirect:list";
	}

	@RequestMapping("/food")
	public String food(Model model,@RequestParam Map<String, Object> map) {

		model.addAttribute("map", map);
		
		return "/food";
	}

	
	@RequestMapping("/upload")
	public String upload(Model model,@RequestParam("file") MultipartFile files,MultipartRequest multipartRequest) {
		
		List<MultipartFile> upload = multipartRequest.getFiles("file");

		for(MultipartFile mfile : upload) {
			System.out.println(mfile);
			String url = fileUploadService.restore(mfile);
		}
		
//	    String url = fileUploadService.restore(files);
		
		return "redirect:list";
	}
	
}
