package com.study.spring;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.spring.service.BoardService;
import com.tobesoft.platform.PlatformRequest;
import com.tobesoft.platform.PlatformResponse;
import com.tobesoft.platform.data.ColumnInfo;
import com.tobesoft.platform.data.Dataset;
import com.tobesoft.platform.data.DatasetList;
import com.tobesoft.platform.data.VariableList;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MipController {

	private static final Logger logger = LoggerFactory.getLogger(MipController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */


	@Resource(name = "BoardService")
	private BoardService boardService;
	
	@RequestMapping("/hellolist")
	public void list(Model model,@RequestParam Map<String, Object> map,
				HttpServletResponse response,
				HttpServletRequest request) throws IOException {
		
		System.out.println("시작");

		VariableList vl = new VariableList();
		DatasetList  dl = new DatasetList();
		PlatformRequest req = new PlatformRequest(request, "utf-8");
		req.receiveData();
		vl = req.getVariableList();
		dl = req.getDatasetList();

		
		String search = vl.getValueAsString("search");
		String startdata = vl.getValueAsString("startdata");
		String enddata = vl.getValueAsString("enddata");
		String option = vl.getValueAsString("option");

		System.out.println("search : " + search);
		System.out.println("startdata : " + startdata);
		System.out.println("enddata : " + enddata);
		System.out.println("option : " + option);
		map.put("search", search);
		map.put("startdata", startdata);
		map.put("enddata", enddata);
		map.put("option", option);

		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = boardService.miplist(map);
		model.addAttribute("list", list);


	
		
		Dataset data = new Dataset("javalist");
		
		data.addColumn("SEQ",ColumnInfo.COLTYPE_STRING, 100);
		data.addColumn("MEM_NAME",ColumnInfo.COLTYPE_STRING, 100);
		data.addColumn("MEM_ID",ColumnInfo.COLTYPE_STRING, 100);
		data.addColumn("BOARD_SUBJECT",ColumnInfo.COLTYPE_STRING, 100);
		data.addColumn("BOARD_CONTENT",ColumnInfo.COLTYPE_STRING, 100);
		data.addColumn("REG_DATE",ColumnInfo.COLTYPE_STRING, 100);
		data.addColumn("UPT_DATE",ColumnInfo.COLTYPE_STRING, 100);
		data.addColumn("VIEW_CNT",ColumnInfo.COLTYPE_STRING, 100);
		
		for(int i = 0 ; i < list.size(); i++) {

			String SEQ = list.get(i).get("seq").toString();
			String MEM_NAME = list.get(i).get("memName").toString();
			String MEM_ID = list.get(i).get("memId").toString();
			String BOARD_SUBJECT = list.get(i).get("boardSubject").toString();
			String BOARD_CONTENT = list.get(i).get("boardContent").toString();
			String REG_DATE = list.get(i).get("regDate").toString();
			String UPT_DATE = null;
			if(list.get(i).get("uptDate") != null) {
				UPT_DATE = list.get(i).get("uptDate").toString();
			}
			String VIEW_CNT = list.get(i).get("viewCnt").toString();	

			int upload = data.appendRow();
			data.setColumn(upload,"SEQ",SEQ);
			data.setColumn(upload,"MEM_NAME",MEM_NAME);
			data.setColumn(upload,"MEM_ID",MEM_ID);
			data.setColumn(upload,"BOARD_SUBJECT",BOARD_SUBJECT);
			data.setColumn(upload,"BOARD_CONTENT",BOARD_CONTENT);
			data.setColumn(upload,"REG_DATE",REG_DATE);
			data.setColumn(upload,"UPT_DATE",UPT_DATE);					
			data.setColumn(upload,"VIEW_CNT",VIEW_CNT);

		}
		
		dl.addDataset(data);
		vl.addStr("ErrorMsg", "SUCC");

		
		PlatformResponse pRes = new PlatformResponse(response, PlatformRequest.XML, "euc-kr");
		pRes.sendData(vl, dl);

		System.out.println("통과");

	}
}
