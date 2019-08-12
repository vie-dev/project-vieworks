package kr.co.passcombine.mes.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.passcombine.mes.svc.SYFileService;
import kr.co.passcombine.mes.util.ResponseUtils;
import kr.co.passcombine.mes.util.SessionUtil;
import kr.co.passcombine.mes.util.StringUtil;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.mvc.AbstractController;

@Controller
@RequestMapping("/file")
@PropertySource("classpath:/app.properties")
public class FileController extends AbstractController{
	
	private static final Logger logger = LoggerFactory.getLogger(FileController.class);
 
	@Resource
	private Environment environment;
	
	@Inject
	private FileSystemResource fsResource;
	
	@Resource(name = "vmesFileService")
	SYFileService syFileService;
	
	/*
	 // just download
	@RequestMapping(value = "/attach_download", method = RequestMethod.GET)
	public ModelAndView fileDown(@RequestParam("file_path") String file_path, @RequestParam("file_name") String file_name) {
		ModelAndView returnMV = new ModelAndView();
		returnMV.setViewName("download");
		returnMV.addObject("file_path", fsResource.getPath() +"/" + file_path);
		returnMV.addObject("file_name", file_name);
		return returnMV; 
	}
	*/
	
	// excel file make -> download
	// @RequestMapping(value = "/attach_download", method = RequestMethod.GET)
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String output = ServletRequestUtils.getStringParameter(request, "output");
		
		//dummy data
		Map<String,String> revenueData = new HashMap<String,String>();
		revenueData.put("Jan-2010", "$100,000,000");
		revenueData.put("Feb-2010", "$110,000,000");
		revenueData.put("Mar-2010", "$130,000,000");
		revenueData.put("Apr-2010", "$140,000,000");
		revenueData.put("May-2010", "$200,000,000");
//		
//		if(output ==null || "".equals(output)){
//			//return normal view
//			return new ModelAndView("RevenueSummary","revenueData",revenueData);
//			
//		}else if("EXCEL".equals(output.toUpperCase())){
			//return excel view
			return new ModelAndView("ExcelRevenueSummary","revenueData",revenueData);
			
//		}else{
//			//return normal view
//			return new ModelAndView("RevenueSummary","revenueData",revenueData);
//			
//		}
	}
	
	@RequestMapping(value = "/attach_download", method = RequestMethod.GET)
  public ModelAndView fileDown(@RequestParam("file_path") String file_path, @RequestParam("file_name") String file_name) {
		ModelAndView returnMV = new ModelAndView();
		returnMV.setViewName("download");
		returnMV.addObject("file_path", fsResource.getPath() +"/" + file_path);
		returnMV.addObject("file_name", file_name);
	  return returnMV; 
  }
	
	/*
	@RequestMapping(value = "/makeListFile", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public ModelAndView makeListFile(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		try {
			String docName = "";
			String data = request.getParameter("csvBuffer");
			String fileName = request.getParameter("fileName");
			
			// header
			String header = request.getHeader("User-Agent");
			if( header.contains("MSIE") )	header = "MSIE";
			else if( header.contains("Chrome") ) header = "Chrome";
			else if( header.contains("Opera") ) header = "Opera";
			
			if( data!=null && fileName!=null ){
				data = URLDecoder.decode(data, "UTF-8");
				fileName = URLDecoder.decode(fileName, "UTF-8");
				response.setContentType("application/vnd.ms-excel");
				
				if( header.contains("MSIE") ) {
					docName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
					response.setHeader("Content-Disposition", "attachment;filename=\"" + docName + ".xls");
				} else if( header.contains("Chrome") ) {
					docName = new String(fileName.getBytes("UTF-8"), "ISO--8859-1");
					response.setHeader("Content-Disposition", "attachment;filename=\"" + docName + ".xls\"");
				} else {
					//
				}
				OutputStream out = new FileOutputStream(localFile);
				response.setHeader("Pragma", "no-cashe;");
				response.setHeader("Expires", "-1");
				out.write(data);
			}
		} catch( Exception e ) {
			e.printStackTrace();
			out.println(e.toString());
		}
	}
	*/
	/*
	@ResponseBody
	@RequestMapping(value = "/file_select_nopage", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String file_select_nopage(@ModelAttribute SYFileVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.file_select_nopage() is called.");
		List<SYFileVo> listCode = null;
		listCode = syFileService.selectFile_nopage(sVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,	listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}*/
	/*
	@ResponseBody
	@RequestMapping(value = "/file_select", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String file_select(@ModelAttribute SYFileVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FileController.file_select() is called.");
		List<SYFileVo> listCode = null;
		int currentPage = Integer.parseInt(request.getParameter("page")); 
	    int pageRows = Integer.parseInt(request.getParameter("rows")); 
	    int startIndex = currentPage * pageRows - pageRows; 
	    int totalRows = 0;
	    
		sVo.setPage(startIndex);
		sVo.setRows(pageRows);
				
		totalRows = syFileService.selectFile_count(sVo);
		listCode = syFileService.selectFile(sVo);
		
		JSONObject resultData = new JSONObject();
		JSONParser jsonParser = new JSONParser(); 
		JSONArray listDataJArray = new JSONArray();
		try {
			resultData.put("status", HttpStatus.OK.value());
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
//			resultData = ResponseUtils.getJQGridJsonResponse(response, listCode, currentPage, pageRows, totalRows);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	/*
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/file_upload", produces="text/html;charset=UTF-8")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String file_upload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("FileController.file_upload() is called. ");
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;	
	    MultiValueMap<String, MultipartFile> map = multipartRequest.getMultiFileMap();
	    SYFileVo resultVo = new SYFileVo();
	    
	    String file_group = request.getParameter("file_group");
	    String file_cate = request.getParameter("file_cate");
	    
	    JSONObject resultData = new JSONObject();
	    JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		if(map != null) {
			Iterator iter = map.keySet().iterator();
			while(iter.hasNext()) {
				SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
				SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
				SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
				String yyyy= formatter_yyyy.format(new java.util.Date());
				String mm= formatter_mm.format(new java.util.Date());
				String dd= formatter_dd.format(new java.util.Date());
				
				String strDir = fsResource.getPath() +"/files/"+ file_cate +"/"+yyyy+"/"+mm+"/"+dd+"/";
				File d = new File(strDir);
								
				if(!d.isDirectory()) {
					d.mkdirs();
				}
				
				String str = (String) iter.next();
				List<MultipartFile> fileList =  map.get(str);
				for(MultipartFile mpf : fileList) {
				try {
						UUID uid = UUID.randomUUID();
						String filename = StringUtils.trimAllWhitespace(mpf.getOriginalFilename());
						String fileExt = filename.substring(filename.lastIndexOf(".") + 1, filename.length()).toLowerCase();
						File localFile = new File(strDir + "_"+uid+"."+fileExt);
						
						OutputStream out = new FileOutputStream(localFile);
						out.write(mpf.getBytes());
						out.close();
						
						SYFileVo fVo = new SYFileVo();
						if(file_group == null || file_group.equals("")){
							file_group = syFileService.selectFileKey();
							fVo.setFile_group(file_group);
						} else {
							fVo.setFile_group(file_group);
						}
						fVo.setFile_repo("1");
						fVo.setFile_cate(file_cate);
						fVo.setFile_path("/files/"+file_cate+"/"+yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
						fVo.setFile_name(filename);
						fVo.setFile_ext(fileExt);
						fVo.setFile_del_yn("N");
						fVo.setFile_size((localFile.length() / 1024));
						fVo.setCreator(SessionUtil.getMemberId(request));
						fVo.setUpdater(SessionUtil.getMemberId(request));
						syFileService.insertFile(fVo);
						resultVo.setFile_group(fVo.getFile_group());
						resultData.put("status", HttpStatus.OK.value());
						
						logger.debug("flow log : listDataJArray : "  + listDataJArray);
						
		 			} catch(Exception e) {
			 			e.printStackTrace();
			 			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			 			resultData.put("rows", null);
		 			} finally {
//		 				if(fis != null) fis.close();
//		 				if(wb != null) wb.close();
		 			}
				}
			}
		}
		return resultData.toJSONString();
	}*/
//	
//	@ResponseBody
//	@RequestMapping(value = "/delFlagFile", method = {
//			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
//	@SuppressWarnings("unchecked")
//	public String delFlagFile(@ModelAttribute SYFileVo sVo,
//			HttpServletRequest request, HttpServletResponse response,
//			HttpSession session) {
//		logger.debug("FrontendController.file_select() is called.");
//		List<SYFileVo> listCode = null;
//		// sYprodService.insertSapProdOrd();
//		sVo.setUpdater(SessionUtil.getMemberId(request));
//		int result = syFileService.delFlagFile(sVo);
//		JSONObject resultData = new JSONObject();
//		JSONArray listDataJArray = new JSONArray();
//		try {
//			JSONParser jsonParser = new JSONParser();
//			String listDataJsonString = ResponseUtils.getJsonResponse(response,	listCode);
//			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
//			resultData.put("status", HttpStatus.OK.value());
//			resultData.put("rows", listDataJArray);
//		} catch (Exception e) {
//			e.printStackTrace();
//			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			resultData.put("rows", null);
//		}
//
//		return resultData.toJSONString();
//	}
	
	 
	/*
	@ResponseBody
	@RequestMapping(value = "/delete_file", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteFile(@ModelAttribute SYFileVo fileVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FileController.deleteFile() is called.");
		JSONObject resultData = new JSONObject();
		int result = 0;
		try{
			fileVo.setCreator(SessionUtil.getMemberId(request));
			fileVo.setUpdater(SessionUtil.getMemberId(request));
			fileVo.setFile_del_yn("Y");
			result = syFileService.deleteFile(fileVo);
			if (result < 0) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			} else {
				resultData.put("status", HttpStatus.OK.value());
			}
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	
	@RequestMapping(value = "/editor_attach_download", method = RequestMethod.GET)
  public ModelAndView EditorDown(@RequestParam("file_path") String file_path, @RequestParam("file_name") String file_name) {
		ModelAndView returnMV = new ModelAndView();
		returnMV.setViewName("download");
		returnMV.addObject("file_path", fsResource.getPath() + file_path);
		returnMV.addObject("file_name", file_name);
	  return returnMV; 
  }
	/*
	@RequestMapping(method = RequestMethod.POST, value = "/editor_file_upload", produces="text/html;charset=UTF-8")
	@SuppressWarnings("rawtypes")
	public String goEditorFileUpload(@ModelAttribute SYFileVo fVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("FileController.goEditorImgUpload() is called. ");
		String file_path = "";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;	
    MultiValueMap<String, MultipartFile> map = multipartRequest.getMultiFileMap();
		if(map != null) {
			Iterator iter = map.keySet().iterator();
			while(iter.hasNext()) {
				SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
				SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
				SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
				String yyyy= formatter_yyyy.format(new java.util.Date());
				String mm= formatter_mm.format(new java.util.Date());
				String dd= formatter_dd.format(new java.util.Date());
				UUID uid = UUID.randomUUID();
				
				logger.debug("flow log : fsResource.getPath() : " + fsResource.getPath());
				String strDir = fsResource.getPath() +"/editor_file/"+yyyy+"/"+mm+"/"+dd+"/";
				File d = new File(strDir);
				if(!d.isDirectory()) {
					d.mkdirs();
				}
				
				String str = (String) iter.next();
				List<MultipartFile> fileList =  map.get(str);
				for(MultipartFile mpf : fileList) {
					String filename = StringUtils.trimAllWhitespace(mpf.getOriginalFilename());
					String fileExt = filename.substring(filename.lastIndexOf(".") + 1, filename.length()).toLowerCase();
					File localFile = new File(strDir + "_"+uid+"."+fileExt);
					OutputStream out = new FileOutputStream(localFile);
					out.write(mpf.getBytes());
					out.close();
					
					fVo.setFile_repo("1");
					fVo.setFile_cate("editor_file");
					fVo.setFile_path(yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
					fVo.setFile_name(filename);
					fVo.setFile_ext(fileExt);
					fVo.setFile_del_yn("N");
					fVo.setCreator(SessionUtil.getMemberId(request));
					fVo.setUpdater(SessionUtil.getMemberId(request));
					// fileService.insertFile(fVo);
					file_path = "/upload/"+fVo.getFile_cate()+"/"+fVo.getFile_path();
					logger.debug("flow log : file_path : " + file_path);
				}
			}
		}
		String ckeditorFuncNum = request.getParameter("CKEditorFuncNum");
		request.setAttribute("ckeditorFuncNum", ckeditorFuncNum);
		request.setAttribute("urlfile", "/" + file_path);
		return "manager/sitemap/data/editor_callback";
	}*/
}