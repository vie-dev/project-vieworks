package kr.co.passcombine.mes.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.passcombine.mes.util.SessionUtil;
import kr.co.passcombine.mes.util.ResponseUtils;
import kr.co.passcombine.mes.sap.VmesJcoConnectVo;
import kr.co.passcombine.mes.sap.VmesJcoConnection;
import kr.co.passcombine.mes.svc.SapMasterService;
import kr.co.passcombine.mes.svc.SYProdService;
import kr.co.passcombine.mes.svc.SYMesService;
import kr.co.passcombine.mes.svc.SYHubService;
import kr.co.passcombine.mes.vo.SYEisVo;
import kr.co.passcombine.mes.vo.SYHubItemManagementVo;
import kr.co.passcombine.mes.vo.SYPoRequirementVo;
import kr.co.passcombine.mes.vo.SYReqmMatnrTblVo;
import kr.co.passcombine.mes.vo.SYScmRawProcVo;
import kr.co.passcombine.mes.vo.SYSernrManageVo;
import kr.co.passcombine.mes.vo.SYStockVo;
import kr.co.passcombine.mes.vo.SYVendorVo;
import kr.co.passcombine.mes.vo.SYProdVo;
import kr.co.passcombine.mes.vo.SYHubBomVo;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;
import com.sap.conn.jco.JCoStructure;

@Controller
@RequestMapping("/sap_master")
@PropertySource("classpath:/app.properties")
public class SapMasterController {
	private static final Logger logger = LoggerFactory.getLogger(SapMasterController.class);
	
	@Resource(name = "vmesSapMasterService")
	SapMasterService sapMasterService;
	
	@Resource(name = "vmesProdService")
	SYProdService sYprodService;

	@Resource(name = "vmesMesService")
	SYMesService sYmesService;
	
	@Resource(name = "vmesHubService")
	SYHubService sYhubService;
	
	@Resource
	private Environment environment;
	
	@ResponseBody
	@RequestMapping(value = "/ziffm_mes_pp002", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String ziffm_mes_pp002(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.ziffm_mes_pp002() is called.");
		
		JSONObject resultData = new JSONObject();
		String func_name = request.getParameter("func_name");
	//	String iv_matnr = request.getParameter("IV_MATNR");	 
		String iv_date = request.getParameter("IV_DATE");	 
		String iv_werks = request.getParameter("IV_WERKS");	 
		String iv_if = request.getParameter("IV_IF");	 
		
		logger.debug("func_name"+func_name);	 
		logger.debug("iv_date"+iv_date);
		logger.debug("iv_werks"+iv_werks);
		logger.debug("iv_if"+iv_if);
		
		int result =0;
	 
		try{
			resultData  =  sapMasterService.ziffm_mes_pp002(func_name,iv_date,iv_werks,iv_if);
			
//			resultData.put("return_status", result1);
//			resultData.put("return_count", t_tab.getNumRows());
			
			int return_status =  (int) resultData.get("return_status");
			int return_count =  (int)  resultData.get("return_count");
			
			if(return_status ==1 || return_status ==2 ){
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", return_count+ "건 SAP와 동기화를 성공했습니다.");
			 
			}else if (return_status ==0  ){
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "동기화 건수 0 건");
			}
		}catch(Exception ex){
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", ex.toString());
			ex.printStackTrace();
		}
//		resultData.put("rows", listDataJArray);
		return resultData.toJSONString();
	}
	/*
	@ResponseBody
	@RequestMapping(value = "/ziffm_mes_pp003", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String ziffm_mes_pp003(@ModelAttribute SYProdVo prodVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.ziffm_mes_pp003() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		List<SYProdVo> listCode = null;
		
		String funcName = request.getParameter("func_name");
		String iv_fdate = request.getParameter("IV_FDATE");	//	FROM 일자	DATS	8
		String iv_tdate = request.getParameter("IV_TDATE");	//	TO 일자	DATS	8
		
		try{
			logger.debug("flow log : jco.ashost : " + environment.getProperty("jco.ashost"));
			
		//	resultData = sapMasterService.ziffm_mes_pp003(prodVo, iv_fdate, iv_tdate, funcName);
			
			JSONObject resultObj = new JSONObject();
			
			listCode = sYprodService.sapProdCode(prodVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("rows", listDataJArray);
		} catch(Exception ex){
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", ex.toString());
			ex.printStackTrace();
		}
		resultData.put("rows", listDataJArray);
		return resultData.toJSONString();
	}*/
/*
	@ResponseBody
	@RequestMapping(value = "/ziffm_mes_pp004", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String ziffm_mes_pp004(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.ziffm_mes_pp004() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		String aufnr = request.getParameter("IV_AUFNR");
		String iv_if = request.getParameter("IV_IF");
		String funcName = request.getParameter("func_name");
		
		try{
			HashMap<String, Object> hashObj = sapMasterService.ziffm_pop_pp004(funcName, aufnr, iv_if);
			System.out.println(hashObj.toString());
			List<SYPoRequirementVo> pVoList = (List<SYPoRequirementVo>)hashObj.get("voList");
			resultData = (JSONObject)hashObj.get("resultData");
			System.out.println(pVoList);
			if( pVoList.size()>0 ) {
				sYprodService.po_requirement_tbl_insert(pVoList);
			}
			List<SYPoRequirementVo> resultList  = sYprodService.matr_select(aufnr);
			System.out.println(resultList);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, resultList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("rows", listDataJArray);
			
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData.toJSONString();
	}*/
	/*
	@ResponseBody
	@RequestMapping(value = "/ziffm_mes_pp006", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String ziffm_mes_pp006(@ModelAttribute SYZmmfmMatMasterVo materialVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.ziffm_mes_pp006() is called.");
		JSONObject resultData = new JSONObject();
		try{
			String funcName = request.getParameter("funcName");
			String pordno = request.getParameter("pordno");
			String pordno_pop = request.getParameter("pordno_pop");
			String routing_no = request.getParameter("routing_no");
			String dept_cd = request.getParameter("dept_cd");
			String wkctr = request.getParameter("wkctr");
			
			String user_id = SessionUtil.getMemberId(request);
			
			resultData = sapMasterService.ziffm_mes_pp006(funcName, pordno,pordno_pop,routing_no, dept_cd, wkctr, user_id);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/

	@ResponseBody
	@RequestMapping(value = "/ziffm_mes_pp007", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String ziffm_mes_pp007(@ModelAttribute SYProdVo prodVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.ziffm_mes_pp007() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo); 
		List<SYProdVo> pVoList = new ArrayList<SYProdVo>();
		try {
			String funcName = request.getParameter("func_name");
//			String params = request.getParameter("params");	// json list : object String
//			String pdsts = request.getParameter("pdsts");
//			String sessId = SessionUtil.getMemberId(request);
//			pVoList = sapMasterService.ziffm_mes_pp011(funcName, params, pdsts, sessId);
//			
//			sYprodService.updateProdOrdConfirm(pVoList);
//			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
		}
		
		return resultData.toJSONString();
	}
	/*
	@ResponseBody
	@RequestMapping(value = "/ziffm_mes_pp008", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String ziffm_mes_pp008(@ModelAttribute SYZmmfmMatMasterVo materialVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.ziffm_mes_pp008() is called.");
		JSONObject resultData = new JSONObject();
		try{
			String funcName = request.getParameter("funcName");
			String pordno = request.getParameter("pordno");
			String pordno_pop = request.getParameter("pordno_pop");
			String routing_no = request.getParameter("routing_no");
			String user_id = SessionUtil.getMemberId(request);
			resultData = sapMasterService.ziffm_mes_pp008(funcName, pordno,pordno_pop,routing_no, user_id);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	/*
	@ResponseBody
	@RequestMapping(value = "/ziffm_mes_pp009", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String ziffm_mes_pp009(@ModelAttribute SYZmmfmMatMasterVo materialVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.ziffm_mes_pp009() is called.");
		JSONObject resultData = new JSONObject();
		try{
			String funcName = request.getParameter("funcName");
			String pordno = request.getParameter("pordno");
			String pordno_pop = request.getParameter("pordno_pop");
			String routing_no = request.getParameter("routing_no");
			
			resultData = sapMasterService.ziffm_mes_pp009(funcName, pordno,pordno_pop,routing_no);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
/*
	@ResponseBody
	@RequestMapping(value = "/ziffm_mes_pp011", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String ziffm_mes_pp011(@ModelAttribute SYProdVo prodVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.ziffm_mes_pp011() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo); 
		List<SYProdVo> pVoList = new ArrayList<SYProdVo>();
		try {
			String funcName = request.getParameter("func_name");
			String params = request.getParameter("params");	// json list : object String
			String pdsts = request.getParameter("pdsts");
			String sessId = SessionUtil.getMemberId(request);
			JSONObject result = sapMasterService.ziffm_mes_pp011(funcName, params, pdsts, sessId);
			pVoList = (List<SYProdVo>)result.get("list");
			
			System.out.println("############################################## :::::: pVoList");
			System.out.println(pVoList);
			
			sYprodService.updateProdOrdConfirm(pVoList);
	
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
		}
		
		return resultData.toJSONString();
	}*/
	/*
	//vendor data 조회 rfc
	@ResponseBody
	@RequestMapping(value = "/zmmfm_ven_master", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String zmmfm_ven_master(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.zmmfm_ven_master() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		String iv_fdate = request.getParameter("IV_FDATE");
		String iv_tdate = request.getParameter("IV_TDATE");
		String funcName = request.getParameter("func_name");
		String iv_if  = request.getParameter("IV_IF");
		
		int result =0;
		try{
			resultData = sapMasterService.zmmfm_ven_master(funcName, iv_fdate, iv_tdate,iv_if);
 
			int return_status =  (int) resultData.get("return_status");
			int return_count =  (int)  resultData.get("return_count");
			
			if(return_status ==1 || return_status ==2 ){
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", return_count+ "건 SAP와 동기화를 성공했습니다.");
			 
			}else if (return_status ==0  ){
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "동기화 건수 0 건");
			}
		} catch(Exception ex){
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", ex.toString());
			ex.printStackTrace();
		}
//		resultData.put("rows", listDataJArray);
		return resultData.toJSONString();
	}*/
	
	//Bom data 생성 요청 rfc
	@ResponseBody
	@RequestMapping(value = "/zmmfm_vw_mat", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String zmmfm_vw_mat(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.zmmfm_vw_mat() is called.");
		
		JSONObject resultData = null;
		
		String params = request.getParameter("params");
		String funcName = request.getParameter("funcName");
		String sessId = SessionUtil.getMemberId(request);
		resultData = sapMasterService.zmmfm_vw_mat(funcName, params, sessId);
		
		return resultData.toJSONString();
	}
	/*
	//Bom data 조회 rfc
	@ResponseBody
	@RequestMapping(value = "/zmmfm_mat_master", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String zmmfm_mat_master(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.zmmfm_mat_master() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		String fdate = request.getParameter("fdate");
		String tdate = request.getParameter("tdate");
		String funcName = request.getParameter("funcName");
		
		try{
			logger.debug("flow log : jco.ashost : " + environment.getProperty("jco.ashost"));
			
			resultData = sapMasterService.zmmfm_mat_master(fdate, tdate, funcName);
			

		} catch(Exception ex){
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", ex.toString());
			ex.printStackTrace();
		}
//		resultData.put("rows", listDataJArray);
		return resultData.toJSONString();
	}*/

	/* sample
	@ResponseBody
	@RequestMapping(value = "/sap_master/sample_rfc_call", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String sampleRFCCall(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.sampleRFCCall() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		String IV_FDATE = request.getParameter("IV_FDATE");
		String IV_TDATE = request.getParameter("IV_TDATE");
		logger.debug(IV_FDATE);
		
		try{
			logger.debug("flow log : jco.ashost : " + environment.getProperty("jco.ashost"));
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			logger.debug("@@@@@@");
			
			VmesJcoConnection connect = new VmesJcoConnection(connectVo); 
			
			logger.debug("@@@@@@");   
			JCoFunction function = connect.getFunction("ZIFFM_POP_PP001");
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			
			//== Setting RFC Parameter ===================================
			function.getImportParameterList().setValue("IV_FDATE", IV_FDATE);
			function.getImportParameterList().setValue("IV_TDATE", IV_TDATE);
			
			//== Return Value Mapping ===================================
			try {
				connect.executeFunction(function);
					
				JSONObject resultObj = new JSONObject();
				JCoTable t_tab = function.getTableParameterList().getTable("ET_OUTPUT");
				
				resultObj.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
				resultObj.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));
				listDataJArray.add(resultObj);
				
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");
				
			} catch(Exception ex){
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				ex.printStackTrace();
			} 
			resultData.put("rows", listDataJArray);
			
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData.toJSONString();
	}
	*/
	@ResponseBody
	@RequestMapping(value = "/sap_master/metrial_req_detail_select", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked") 
	public String mesMatrReqDetailSelectCall(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.mesMatrReqDetailSelectCall() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		String pordno = request.getParameter("pordno");
		String functionName = request.getParameter("functionName");
		logger.debug("Key = " + pordno + " / functionName = " + functionName);
		
		try{
			resultData = sapMasterService.mesMatrReqDetailSelectCall(pordno, functionName);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/ziffm_mes_pp015", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked") 
	public String ziffm_mes_pp015(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.ziffm_mes_pp015() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		 
		String func_name = request.getParameter("func_name"); 
		String iv_werks = request.getParameter("iv_werks");
		String iv_matnr = request.getParameter("iv_matnr");
		String iv_sernr = request.getParameter("iv_sernr");
		
		try{
			resultData = sapMasterService.ziffm_mes_pp015(func_name, iv_werks, iv_matnr, iv_sernr);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/eis_test", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String sampleRFCCall(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.sampleRFCCall() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		String param_1 = request.getParameter("param_1");
		String param_2 = request.getParameter("param_2");

		try{
			logger.debug("flow log : jco.ashost : " + environment.getProperty("jco.ashost"));
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			logger.debug("@@@@@@");
			
			VmesJcoConnection connect = new VmesJcoConnection(connectVo); 
			
			logger.debug("@@@@@@");   
			JCoFunction function = connect.getFunction("ZIFFM_MES_PP003");
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			
			//== Setting RFC Parameter ===================================
			function.getImportParameterList().setValue("IV_FDATE", param_1);
			function.getImportParameterList().setValue("IV_TDATE", param_2);
			function.getImportParameterList().setValue("IV_IF", "X");
			
			//== Return Value Mapping ===================================
			try {
				connect.executeFunction(function);
					
				JSONObject resultObj = new JSONObject();
				
				JCoTable t_proc = function.getTableParameterList().getTable("ET_OUTPUT_2");

				List<SYEisVo> hVoList = new ArrayList<SYEisVo>();
				for (int i = 0; i < t_proc.getNumRows(); i++) {
					t_proc.setRow(i);
					SYEisVo hVo = new SYEisVo();
					hVo.setAufnr(t_proc.getString("AUFNR"));
					hVo.setAplzl(t_proc.getString("APLZL"));
					hVo.setVornr(t_proc.getString("VORNR"));
					hVo.setArbpl(t_proc.getString("ARBPL"));
					hVo.setWerks(t_proc.getString("WERKS"));
					hVo.setSteus(t_proc.getString("STEUS"));
					hVo.setFrdlb(t_proc.getString("FRDLB"));
					hVoList.add(hVo);
		        }
				
				String listDataJsonString = ResponseUtils.getJsonResponse(response, hVoList);
				listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
				
				resultData.put("rows", listDataJArray);
				resultData.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
				resultData.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));
			
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");
				
			} catch(Exception ex){
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				ex.printStackTrace();
			} 
			resultData.put("rows", listDataJArray);
			
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData.toJSONString();
	}
	
	/*@ResponseBody
	@RequestMapping(value = "/addLabst", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String addLabst(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.addLabst() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		String reqm_matnr_key = request.getParameter("reqm_matnr_key");
		String werks = request.getParameter("werks");
		String gridString = request.getParameter("gridData");
	
		SYReqmMatnrTblVo sVo_1 = new SYReqmMatnrTblVo();
		sVo_1.setReqm_matnr_key(reqm_matnr_key);
		List<SYReqmMatnrTblVo> listCode = sYhubService.material_req_det_select(sVo_1);
		try{
			JSONArray jarr = new JSONArray();
			List<SYStockVo> stock_list = new ArrayList<SYStockVo>();
			for(int i=0 ; i< listCode.size(); i++) {
				JSONObject job = new JSONObject();
	
				String p_lgort = listCode.get(i).getLgort();
				String p_matnr = listCode.get(i).getMatnr();
				job.put("lgort", p_lgort);
				job.put("matnr", p_matnr);
				job.put("werks", werks);
				
				jarr.add(job);
			}
			JSONObject result_stock_data = sapMasterService.zmmfm_sloc_stock_1("ZMMFM_SLOC_STOCK", jarr, werks);
			String mard_json = (String) result_stock_data.get("mard_json");
				
			listDataJArray = (JSONArray) jsonParser.parse(mard_json);
	
			if(listDataJArray.size() != 0) {
				JSONObject jOb = (JSONObject)listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();
	
				for(int k=0; k<listDataJArray.size(); k++){
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject)listDataJArray.get(k);
					SYStockVo tmp_sVo = new SYStockVo();
				
					for(Object key : keyArr){
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						
						if( "werks".equals(nKey) ) tmp_sVo.setWerks(nValue);
						else if( "lgort".equals(nKey) ) tmp_sVo.setLgort(nValue);
						else if( "lifnr".equals(nKey) ) tmp_sVo.setLifnr(nValue);
						else if( "kunnr".equals(nKey) ) tmp_sVo.setKunnr(nValue);
						else if( "matnr".equals(nKey) ) tmp_sVo.setMatnr(nValue);
						else if( "labst".equals(nKey) ) tmp_sVo.setLabst(nValue);			
					}
					stock_list.add(tmp_sVo);
				}
			}	
			String listDataJsonString = ResponseUtils.getJsonResponse(response, stock_list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
					
			resultData.put("rows", listDataJArray);
	//		resultData.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
	//		resultData.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));
				
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");
				
		} catch(Exception ex){
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
			ex.printStackTrace();
		} 
		resultData.put("rows", listDataJArray);
			
		return resultData.toJSONString();
	}*/
	/*
	@ResponseBody
	@RequestMapping(value = "/stock_inquiry", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String stock_inquiry(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.stock_inquiry() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
			
		String werks = request.getParameter("werks");
		String p_lgort = request.getParameter("lgort");
		String p_matnr = request.getParameter("matnr");
		String p_name1 = request.getParameter("name1");
		String p_lifnr = request.getParameter("lifnr");
		
		String gubun = request.getParameter("gubun");
		
		try{

		JSONArray jarr = new JSONArray();
		List<SYStockVo> stock_list = new ArrayList<SYStockVo>();
		
		JSONObject job = new JSONObject();
		
		job.put("lgort", p_lgort);
		job.put("werks", werks);
		job.put("lifnr", p_lifnr);
		
		jarr.add(job);
		
		JSONObject result_stock_data = sapMasterService.zmmfm_sloc_stock_1("ZMMFM_SLOC_STOCK", jarr, werks);
				
			
		String mard_json = (String) result_stock_data.get("mard_json");
		String equi_json = (String) result_stock_data.get("equi_json");
		
		if(gubun.equals("M")) {
			listDataJArray = (JSONArray) jsonParser.parse(mard_json);
			ArrayList<String> matnrList = new ArrayList<String>();
			
			if(listDataJArray.size() != 0) {
				JSONObject jOb = (JSONObject)listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();

				for(int k=0; k<listDataJArray.size(); k++){
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject)listDataJArray.get(k);
					SYStockVo tmp_sVo = new SYStockVo();
				
					for(Object key : keyArr){
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						
						if( "werks".equals(nKey) ) tmp_sVo.setWerks(nValue);
						else if( "lgort".equals(nKey) ) tmp_sVo.setLgort(nValue);
						else if( "matnr".equals(nKey) ) { 
							tmp_sVo.setMatnr(nValue);
							matnrList.add(nValue.toString());
						}
						else if( "labst".equals(nKey) ) tmp_sVo.setLabst(nValue);			
					}
					if(p_lgort.equals(tmp_sVo.getLgort())){
						stock_list.add(tmp_sVo);	
					}
				}
			}	
			
			SYZmmfmMatMasterVo pVo = new SYZmmfmMatMasterVo();
			pVo.setMatnrList(matnrList);
			pVo.setWerks(werks);
			List<SYZmmfmMatMasterVo> matnr_list = sYhubService.material_recv_master_select_vendor_nopage(pVo);
			
			for(int i = 0 ; i<stock_list.size(); i++) {
				for(int j = 0 ; j<matnr_list.size(); j++) {
					if(stock_list.get(i).getMatnr().equals((matnr_list.get(j).getMatnr()))) {
						if(stock_list.get(i).getWerks().equals((matnr_list.get(j).getWerks()))) {
							stock_list.get(i).setWrkst(matnr_list.get(j).getWrkst());
							stock_list.get(i).setMaktx(matnr_list.get(j).getMaktx());
							stock_list.get(i).setWerks_nm(matnr_list.get(j).getWerks_nm());
							stock_list.get(i).setMeins(matnr_list.get(j).getMeins());
							stock_list.get(i).setSernp(matnr_list.get(j).getSernp());
						}
					}
				}
			}

		} else if(gubun.equals("D")){
			listDataJArray = (JSONArray) jsonParser.parse(equi_json);
			
			if(listDataJArray.size() != 0) {
				JSONObject jOb = (JSONObject)listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();

				for(int k=0; k<listDataJArray.size(); k++){
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject)listDataJArray.get(k);
					SYStockVo tmp_sVo = new SYStockVo();
				
					for(Object key : keyArr){
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						
						if( "b_werk".equals(nKey) ) tmp_sVo.setB_werks(nValue);
						else if( "b_lager".equals(nKey) ) tmp_sVo.setB_lager(nValue);
						else if( "matnr".equals(nKey) ) tmp_sVo.setMatnr(nValue);
						else if( "sernr".equals(nKey) ) tmp_sVo.setSernr(nValue);	
					}
					
					if(p_matnr.equals(tmp_sVo.getMatnr())){
						if(p_lgort.equals(tmp_sVo.getB_lager())){
							stock_list.add(tmp_sVo);	
						}	
					}
				}
			}	
		}
				
		String listDataJsonString = ResponseUtils.getJsonResponse(response, stock_list);
		listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
				
		resultData.put("rows", listDataJArray);
		resultData.put("e_return", (String) result_stock_data.get("e_return"));
		resultData.put("e_message", (String) result_stock_data.get("e_message"));
			
		resultData.put("status", HttpStatus.OK.value());
		resultData.put("message", "RFC FUNC. is success.");
			
		} catch(Exception ex){
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
			ex.printStackTrace();
		} 
//		resultData.put("rows", listDataJArray);
		return resultData.toJSONString();
	}*/
	/*
	@ResponseBody
	@RequestMapping(value = "/vendor_stock_inquiry", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String vendor_stock_inquiry(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("SapMasterController.vendor_stock_inquiry() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray_0 = new JSONArray();
		JSONArray listDataJArray_1 = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		String p_name1 = request.getParameter("name1");
		String p_lifnr = request.getParameter("lifnr");

		try{

		JSONArray jarr = new JSONArray();
		List<SYStockVo> stock_list_0 = new ArrayList<SYStockVo>();
		List<SYStockVo> stock_list_1 = new ArrayList<SYStockVo>();
		
		JSONObject job = new JSONObject();
		jarr.add(job);
		
		JSONObject result_stock_data_0 = sapMasterService.zmmfm_sloc_stock_1("ZMMFM_SLOC_STOCK", jarr, "1110");
		JSONObject result_stock_data_1 = sapMasterService.zmmfm_sloc_stock_1("ZMMFM_SLOC_STOCK", jarr, "1210");
				
			
		String mard_json_0 = (String) result_stock_data_0.get("mard_json");
		String mard_json_1 = (String) result_stock_data_1.get("mard_json");
		
		listDataJArray_0 = (JSONArray) jsonParser.parse(mard_json_0);
		listDataJArray_1 = (JSONArray) jsonParser.parse(mard_json_1);
		
		ArrayList<String> matnrList_0 = new ArrayList<String>();
		ArrayList<String> matnrList_1 = new ArrayList<String>();
			
		if(listDataJArray_0.size() != 0) {
			JSONObject jOb = (JSONObject)listDataJArray_0.get(0);
			Object[] keyArr = jOb.keySet().toArray();

			for(int k=0; k<listDataJArray_0.size(); k++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray_0.get(k);
				SYStockVo tmp_sVo = new SYStockVo();
				
				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					
					if( "werks".equals(nKey) ) tmp_sVo.setWerks(nValue);
					else if( "lgort".equals(nKey) ) tmp_sVo.setLgort(nValue);
					else if( "matnr".equals(nKey) ) { 
						tmp_sVo.setMatnr(nValue);
						matnrList_0.add(nValue.toString());
					}
					else if( "labst".equals(nKey) ) tmp_sVo.setLabst(nValue);			
					else if( "lifnr".equals(nKey) ) tmp_sVo.setLifnr(nValue);
				}
				if(p_lifnr.equals(tmp_sVo.getLifnr()) && !tmp_sVo.getLifnr().equals("")){
					stock_list_0.add(tmp_sVo);	
				}
			}
		}	
			
		SYZmmfmMatMasterVo pVo_0 = new SYZmmfmMatMasterVo();
		pVo_0.setMatnrList(matnrList_0);
		pVo_0.setWerks("1110");
		List<SYZmmfmMatMasterVo> matnr_list_0 = sYhubService.material_recv_master_select_vendor_nopage(pVo_0);
		
		for(int i = 0 ; i<stock_list_0.size(); i++) {
			for(int j = 0 ; j<matnr_list_0.size(); j++) {
				if(stock_list_0.get(i).getMatnr().equals((matnr_list_0.get(j).getMatnr()))) {
					if("1110".equals((matnr_list_0.get(j).getWerks()))) {
						stock_list_0.get(i).setWrkst(matnr_list_0.get(j).getWrkst());
						stock_list_0.get(i).setMaktx(matnr_list_0.get(j).getMaktx());
						stock_list_0.get(i).setWerks_nm(matnr_list_0.get(j).getWerks_nm());
						stock_list_0.get(i).setMeins(matnr_list_0.get(j).getMeins());
						stock_list_0.get(i).setSernp(matnr_list_0.get(j).getSernp());
					}
				}
			}
		}

		////////////////////////////////////////////////////////////
		if(listDataJArray_1.size() != 0) {
			JSONObject jOb = (JSONObject)listDataJArray_1.get(0);
			Object[] keyArr = jOb.keySet().toArray();

			for(int k=0; k<listDataJArray_1.size(); k++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray_1.get(k);
				SYStockVo tmp_sVo = new SYStockVo();
				
				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					
					if( "werks".equals(nKey) ) tmp_sVo.setWerks(nValue);
					else if( "lgort".equals(nKey) ) tmp_sVo.setLgort(nValue);
					else if( "matnr".equals(nKey) ) { 
						tmp_sVo.setMatnr(nValue);
						matnrList_1.add(nValue.toString());
					}
					else if( "labst".equals(nKey) ) tmp_sVo.setLabst(nValue);
					else if( "lifnr".equals(nKey) ) tmp_sVo.setLifnr(nValue);
				}
				if(!p_lifnr.equals("")) {
					if(p_lifnr.equals(tmp_sVo.getLifnr())){
						stock_list_1.add(tmp_sVo);	
					}	
				} else {
					if(tmp_sVo.getLifnr().length() != 0)
					stock_list_1.add(tmp_sVo);
				}
			}
		}	
			
		SYZmmfmMatMasterVo pVo_1 = new SYZmmfmMatMasterVo();
		pVo_1.setMatnrList(matnrList_1);
		pVo_1.setWerks("1210");
		List<SYZmmfmMatMasterVo> matnr_list_1 = sYhubService.material_recv_master_select_vendor_nopage(pVo_1);
		
		for(int i = 0 ; i<stock_list_1.size(); i++) {
			for(int j = 0 ; j<matnr_list_1.size(); j++) {
				if(stock_list_1.get(i).getMatnr().equals((matnr_list_1.get(j).getMatnr()))) {
					if(("1210").equals((matnr_list_1.get(j).getWerks()))) {
						stock_list_1.get(i).setWrkst(matnr_list_1.get(j).getWrkst());
						stock_list_1.get(i).setMaktx(matnr_list_1.get(j).getMaktx());
						stock_list_1.get(i).setWerks_nm(matnr_list_1.get(j).getWerks_nm());
						stock_list_1.get(i).setMeins(matnr_list_1.get(j).getMeins());
						stock_list_1.get(i).setSernp(matnr_list_1.get(j).getSernp());
					}
				}
			}
		}
		////////////////////////////////////////////////////////////
				
		String listDataJsonString_0 = ResponseUtils.getJsonResponse(response, stock_list_0);
		String listDataJsonString_1 = ResponseUtils.getJsonResponse(response, stock_list_1);

		listDataJArray_0 = (JSONArray) jsonParser.parse(listDataJsonString_0);
		listDataJArray_1 = (JSONArray) jsonParser.parse(listDataJsonString_1);
		
		resultData.put("rows_0", listDataJArray_0);
		resultData.put("rows_1", listDataJArray_1);
			
		resultData.put("status", HttpStatus.OK.value());
		resultData.put("message", "RFC FUNC. is success.");
			
		} catch(Exception ex){
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
			ex.printStackTrace();
		} 
//		resultData.put("rows", listDataJArray);
		return resultData.toJSONString();
	}*/
}
