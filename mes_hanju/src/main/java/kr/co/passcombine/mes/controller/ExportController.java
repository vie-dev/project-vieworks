package kr.co.passcombine.mes.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

 


 

import kr.co.passcombine.mes.svc.LogStatusService;
import kr.co.passcombine.mes.util.ExportExcelUtil;
import kr.co.passcombine.mes.util.ResponseUtils;
import kr.co.passcombine.mes.vo.LogStatusVo;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/export")
public class ExportController {
	
	private static final Logger logger = LoggerFactory.getLogger(ExportController.class);
	@SuppressWarnings("unused")
	private static final String MAIN_PATH = "/export";
	
	@Inject
	private FileSystemResource fsResource;
	
 
	@Resource(name = "vmesLogStatusService")
	LogStatusService logStatusService;
	/*
	@RequestMapping(value = "/export_client_jqgrid", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	@SuppressWarnings({ "unchecked", "unused" })
	public String goExportClientJQGrid(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("ExportController.goExportClientJQGrid() is called. ");
		JSONObject resultData = new JSONObject();
		
		String excel_down_seq = request.getParameter("excel_down_seq");
		String fileName = request.getParameter("file_name");
		String sheet_name = request.getParameter("sheet_name");
		String sheet_title = request.getParameter("sheet_title");
		String header_col_ids = request.getParameter("header_col_ids");
		String header_col_names = request.getParameter("header_col_names");
		String header_col_aligns = request.getParameter("header_col_aligns");
		String header_col_widths = request.getParameter("header_col_widths");
		String body_data = request.getParameter("body_data");
		
		boolean result = false;
		String filePath = null, return_filePath = null;
		
		try {
			UUID uid = UUID.randomUUID();
			SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
			SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
			SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
			String yyyy= formatter_yyyy.format(new java.util.Date());
			String mm= formatter_mm.format(new java.util.Date());
			String dd= formatter_dd.format(new java.util.Date());
			
			String strDir = fsResource.getPath() +"/excel/export/"+yyyy+"/"+mm+"/"+dd+"/";
			File d = new File(strDir);
			if(!d.isDirectory()) {
				d.mkdirs();
			}
			
			String[] arr_header_col_id = header_col_ids.split(",");
			String[] arr_header_col_name = header_col_names.split(",");
			String[] arr_header_col_align = header_col_aligns.split(",");
			String[] arr_header_col_width = header_col_widths.split(",");
			Hashtable<String, Object> ht_header = new Hashtable<String, Object>();
			ht_header.put("sheet_name", sheet_name);
			ht_header.put("sheet_title", sheet_title);
			ht_header.put("col_id", arr_header_col_id);
			ht_header.put("col_name", arr_header_col_name);
			ht_header.put("col_align", arr_header_col_align);
			ht_header.put("col_width", arr_header_col_width);
			
			filePath = fsResource.getPath() +"/excel/export/"+yyyy+"/"+mm+"/"+dd+"/"+uid+".xlsx";
			return_filePath = "/excel/export/"+yyyy+"/"+mm+"/"+dd+"/"+uid+".xlsx";
			
			JSONParser jsonParser = new JSONParser();
			JSONArray listBodyData = (JSONArray) jsonParser.parse(body_data.toString());
			
			result = ExportExcelUtil.createXls(filePath, ht_header, listBodyData);
			if(result){
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("file_path", return_filePath);
				resultData.put("file_name", fileName);
			}
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("file_path", null);
			resultData.put("file_name", null);
		}
		return resultData.toJSONString();
	}*/
	/*
	@SuppressWarnings({ "unchecked", "unused" })
	@RequestMapping(value = "/export_server_jqgrid", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
  @ResponseBody
	public String goExportServerJQGrid(@ModelAttribute Object obj, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("ExportController.goExportServerJQGrid() is called. ");
		JSONObject resultData = new JSONObject();
		
		String excel_down_seq = request.getParameter("excel_down_seq");
		String fileName = request.getParameter("file_name");
		String sheet_name = request.getParameter("sheet_name");
		String sheet_title = request.getParameter("sheet_title");
		String header_col_ids = request.getParameter("header_col_ids");
		String header_col_names = request.getParameter("header_col_names");
		String header_col_aligns = request.getParameter("header_col_aligns");
		String header_col_widths = request.getParameter("header_col_widths");
		String cmd = request.getParameter("cmd");
		
		boolean result = false;
		String filePath = null, return_filePath = null;
		
		try {
			UUID uid = UUID.randomUUID();
			SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
			SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
			SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
			String yyyy= formatter_yyyy.format(new java.util.Date());
			String mm= formatter_mm.format(new java.util.Date());
			String dd= formatter_dd.format(new java.util.Date());
			
			String strDir = fsResource.getPath() +"excel/export/"+yyyy+"/"+mm+"/"+dd+"/";
			File d = new File(strDir);
			if(!d.isDirectory()) {
				d.mkdirs();
			}
			
			String[] arr_header_col_id = header_col_ids.split(",");
			String[] arr_header_col_name = header_col_names.split(",");
			String[] arr_header_col_align = header_col_aligns.split(",");
			String[] arr_header_col_width = header_col_widths.split(",");
			Hashtable<String, Object> ht_header = new Hashtable<String, Object>();
			ht_header.put("sheet_name", sheet_name);
			ht_header.put("sheet_title", sheet_title);
			ht_header.put("col_id", arr_header_col_id);
			ht_header.put("col_name", arr_header_col_name);
			ht_header.put("col_align", arr_header_col_align);
			ht_header.put("col_width", arr_header_col_width);
			
			filePath = fsResource.getPath() +"/excel/export/"+yyyy+"/"+mm+"/"+dd+"/"+uid+".xls";
			return_filePath = "/excel/export/"+yyyy+"/"+mm+"/"+dd+"/"+uid+".xls";
			
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = "";
			
//			if("grid_goods_detail".equals(cmd)) {
//				LogStatusVo logVo = new LogStatusVo();
//				List<LogStatusVo> listLogStatus = logStatusService.selectLogStatus(logVo);
//				listDataJsonString = ResponseUtils.getJsonResponse(response, listLogStatus);
//			} 
			
			JSONArray listBodyData = (JSONArray) jsonParser.parse(listDataJsonString);
			result = ExportExcelUtil.createXls(filePath, ht_header, listBodyData);
			if(result){
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("file_path", return_filePath);
				resultData.put("file_name", fileName);
			}
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("file_path", null);
			resultData.put("file_name", null);
		}
		return resultData.toJSONString();
	}*/
	
	/*
	@RequestMapping(value = "/export_file_info", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	  @ResponseBody
	  @SuppressWarnings({ "unchecked", "unused" })
	  public String export_file_info(HttpServletRequest request, HttpServletResponse response) throws Exception {
			logger.info("ExportController.export_file_info() is called. ");
			JSONObject resultData = new JSONObject();
			
			String excel_down_seq = request.getParameter("excel_down_seq");
			String fileName = request.getParameter("file_name");
			String sheet_name = request.getParameter("sheet_name");
			String sheet_title = request.getParameter("sheet_title");
			String header_col_ids = request.getParameter("header_col_ids");
			String header_col_names = request.getParameter("header_col_names");
			String header_col_aligns = request.getParameter("header_col_aligns");
			String header_col_widths = request.getParameter("header_col_widths");
			String body_data = request.getParameter("body_data");
			
			boolean result = false;
			String filePath = null, return_filePath = null;
			
			try {
				UUID uid = UUID.randomUUID();
				SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
				SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
				SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
				String yyyy= formatter_yyyy.format(new java.util.Date());
				String mm= formatter_mm.format(new java.util.Date());
				String dd= formatter_dd.format(new java.util.Date());
				
				String strDir = fsResource.getPath() +"/excel/export/"+yyyy+"/"+mm+"/"+dd+"/";
				File d = new File(strDir);
				if(!d.isDirectory()) {
					d.mkdirs();
				}
				
				String[] arr_header_col_id = header_col_ids.split(",");
				String[] arr_header_col_name = header_col_names.split(",");
				String[] arr_header_col_align = header_col_aligns.split(",");
				String[] arr_header_col_width = header_col_widths.split(",");
				Hashtable<String, Object> ht_header = new Hashtable<String, Object>();
				ht_header.put("sheet_name", sheet_name);
				ht_header.put("sheet_title", sheet_title);
				ht_header.put("col_id", arr_header_col_id);
				ht_header.put("col_name", arr_header_col_name);
				ht_header.put("col_align", arr_header_col_align);
				ht_header.put("col_width", arr_header_col_width);
				
				filePath = fsResource.getPath() +"/excel/export/"+yyyy+"/"+mm+"/"+dd+"/"+uid+".xlsx";
				return_filePath = "/excel/export/"+yyyy+"/"+mm+"/"+dd+"/"+uid+".xlsx";
				
				JSONParser jsonParser = new JSONParser();
				JSONArray listBodyData = (JSONArray) jsonParser.parse(body_data.toString());
				
				result = ExportExcelUtil.createXls(filePath, ht_header, listBodyData);
				if(result){
					resultData.put("status", HttpStatus.OK.value());
					resultData.put("file_path", return_filePath);
					resultData.put("file_name", fileName);
				}
			} catch(Exception e){
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("file_path", null);
				resultData.put("file_name", null);
			}
			return resultData.toJSONString();
		}*/
}