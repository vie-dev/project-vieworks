package kr.co.passcombine.mes.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.passcombine.mes.svc.SYCodeService;
import kr.co.passcombine.mes.svc.SYHubService;
import kr.co.passcombine.mes.svc.SYMaterialService;
import kr.co.passcombine.mes.svc.SYMesService;
import kr.co.passcombine.mes.svc.SYOrganService;
import kr.co.passcombine.mes.svc.SYProdService;
import kr.co.passcombine.mes.svc.SYProjectService;
import kr.co.passcombine.mes.svc.SYQmService;
import kr.co.passcombine.mes.svc.SYPoregService;
import kr.co.passcombine.mes.svc.SYScmService;
import kr.co.passcombine.mes.svc.SYShipmentService;
import kr.co.passcombine.mes.svc.SapMasterService;
import kr.co.passcombine.mes.util.ResponseUtils;
import kr.co.passcombine.mes.util.SessionUtil;
import kr.co.passcombine.mes.util.StringUtil;
import kr.co.passcombine.mes.dao.SYMesDAO;
import kr.co.passcombine.mes.vo.SYCodeVo;
import kr.co.passcombine.mes.vo.SYDmrFwVo;
import kr.co.passcombine.mes.vo.SYDmrMasterVo;
import kr.co.passcombine.mes.vo.SYDmrPbaVo;
import kr.co.passcombine.mes.vo.SYInInspDetailVo;
import kr.co.passcombine.mes.vo.SYInInspHeaderVo;
import kr.co.passcombine.mes.vo.SYInInspVo;
import kr.co.passcombine.mes.vo.SYMaterialMasVo;
import kr.co.passcombine.mes.vo.SYMaterialMngVo;
import kr.co.passcombine.mes.vo.SYMemberVo;
import kr.co.passcombine.mes.vo.SYMenuVo;
import kr.co.passcombine.mes.vo.SYMesWkctrVo;
import kr.co.passcombine.mes.vo.SYMoveTypeVo;
import kr.co.passcombine.mes.vo.SYPissueInspectionVo;
import kr.co.passcombine.mes.vo.SYPoRegVo;
import kr.co.passcombine.mes.vo.SYPoRequirementVo;
import kr.co.passcombine.mes.vo.SYProdTblVo;
import kr.co.passcombine.mes.vo.SYProjectMngVo;
import kr.co.passcombine.mes.vo.SYQmFaultHisVo;
import kr.co.passcombine.mes.vo.SYQmFaultStatsVo;
import kr.co.passcombine.mes.vo.SYSelfInspDetailVo;
import kr.co.passcombine.mes.vo.SYSelfInspHeaderVo;
import kr.co.passcombine.mes.vo.SYSelfInspMasterVo;
import kr.co.passcombine.mes.vo.SYShipmentHordTblVo;
import kr.co.passcombine.mes.vo.SYTransReceiptVo;
import kr.co.passcombine.mes.vo.SYProdVo;
import kr.co.passcombine.mes.vo.SYMesVo;
import kr.co.passcombine.mes.vo.SYHubRevInsMasVo;
import kr.co.passcombine.mes.vo.SYHubRevInsCliVo;
import kr.co.passcombine.mes.vo.SYQmInspectionVo;
import kr.co.passcombine.mes.vo.SYQmVo;
import kr.co.passcombine.mes.vo.SYReqmMatnrTblVo;
import kr.co.passcombine.mes.vo.SYHubRoutingDetailVo;
import kr.co.passcombine.mes.vo.SYHubRoutingHeaderVo;
import kr.co.passcombine.mes.vo.SYHubItnbrVo;
import kr.co.passcombine.mes.vo.SYScmIssueDetailVo;
import kr.co.passcombine.mes.vo.SYScmRawCommentVo;
import kr.co.passcombine.mes.vo.SYScmRawDeliveryVo;
import kr.co.passcombine.mes.vo.SYScmRawProcSernrVo;
import kr.co.passcombine.mes.vo.SYScmRawProcSubVo;
import kr.co.passcombine.mes.vo.SYScmRawProcVo;
import kr.co.passcombine.mes.vo.SYScmRawSernrVo;
import kr.co.passcombine.mes.vo.SYMesCodeVo;
import kr.co.passcombine.mes.vo.SYScmRawVendorResultVo;
import kr.co.passcombine.mes.vo.SYSernrManageVo;
import kr.co.passcombine.mes.vo.SYSlocMasterVo;
import kr.co.passcombine.mes.vo.SYStockVo;
import kr.co.passcombine.mes.vo.SYVprodVo;
import kr.co.passcombine.mes.vo.SYWfwotherVo;
import kr.co.passcombine.mes.vo.SYVendorVo;
import kr.co.passcombine.mes.vo.SYHubBomVo;
import kr.co.passcombine.mes.vo.SYHubRecvinspeVo;
import kr.co.passcombine.mes.vo.SYLineVo;
import kr.co.passcombine.mes.vo.SYScmBomVo;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/frontend")
public class FrontendController {
	private static final Logger logger = LoggerFactory
			.getLogger(FrontendController.class);

	@Resource(name = "vmesProdService")
	SYProdService sYprodService;

	@Resource(name = "vmesMesService")
	SYMesService sYmesService;

	@Resource(name = "vmesHubService")
	SYHubService sYhubService;

	@Resource(name = "vmesScmService")
	SYScmService sYscmService;

	@Resource(name = "vmesQmService")
	SYQmService sYqmService;
	
	@Resource(name = "vmesShipmentService")
	SYShipmentService sYshipService;
	
	@Resource(name = "vmesSapMasterService")
	SapMasterService sapMasterService;
	
	/************************** New *****************************/
	@Resource(name = "vmesMaterialService")
	SYMaterialService sYmaterialService;
	
	@Resource(name = "vmesCodeService")
	SYCodeService sYcodeService;
	
	@Resource(name = "vmesProjectService")
	SYProjectService sYprojectService;
	
	@Resource(name = "vmesPoregService")
	SYPoregService sYporegService;
	/************************** New *****************************/
	
	@RequestMapping(value = "/location/{menu_div}/{menu_page}", method = {
			RequestMethod.GET, RequestMethod.POST })
	public ModelAndView frontendMenuNavigation(@PathVariable String menu_div,
			@PathVariable String menu_page, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.frontendMenuNavigation() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("frontend/" + menu_div + "/" + menu_page);

		if ("materials_process_sub_medi".equals(menu_page)) {
			modelAndView.addObject("routing_no", request.getParameter("routing_no"));
			modelAndView.addObject("routing_gno", request.getParameter("routing_gno"));
		} else if ("materials_process_sub_optImg".equals(menu_page)) {
			modelAndView.addObject("routing_no", request.getParameter("routing_no"));
			modelAndView.addObject("routing_gno", request.getParameter("routing_gno"));
		}
		return modelAndView;
	}

	/**
	 * #05. System Management : Prod Management : Start
	 * ===================================================================
	 */

	/*@ResponseBody
	@RequestMapping(value = "/prod/sap_prod_select", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectCode(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectCode() is called.");
		
		 * //////////////////////////////////////////////////////////////////////
		 * ////////////// JSONObject resultData = new JSONObject(); try { int
		 * currentPage = Integer.parseInt(request.getParameter("page")); int
		 * pageRows = Integer.parseInt(request.getParameter("rows")); int
		 * startIndex = currentPage * pageRows - pageRows;
		 * 
		 * memberVo.setPage(startIndex); memberVo.setRows(pageRows);
		 * 
		 * int totalRows = syOrganService.selectRoleMemberCount(memberVo);
		 * List<SYMemberVo> listMember =
		 * syOrganService.selectRoleMemberList(memberVo); resultData =
		 * ResponseUtils.getJQGridJsonResponse(response, listMember,
		 * currentPage, pageRows, totalRows); } catch(Exception e) {
		 * e.printStackTrace(); resultData.put("status",
		 * HttpStatus.INTERNAL_SERVER_ERROR.value()); resultData.put("rows",
		 * null); }
		 // //////////////////////////////////////////////////////////////////////////////////
			// ///////////////////////////원본
		List<SYProdVo> listCode = null;
		// sYprodService.insertSapProdOrd();
		listCode = sYprodService.sapProdCode(prodVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
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
	@RequestMapping(value = "/prod/sap_prod_select_confirm", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectCode_confirm(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectCode_confirm() is called.");
		
		 * //////////////////////////////////////////////////////////////////////
		 * ////////////// JSONObject resultData = new JSONObject(); try { int
		 * currentPage = Integer.parseInt(request.getParameter("page")); int
		 * pageRows = Integer.parseInt(request.getParameter("rows")); int
		 * startIndex = currentPage * pageRows - pageRows;
		 * 
		 * memberVo.setPage(startIndex); memberVo.setRows(pageRows);
		 * 
		 * int totalRows = syOrganService.selectRoleMemberCount(memberVo);
		 * List<SYMemberVo> listMember =
		 * syOrganService.selectRoleMemberList(memberVo); resultData =
		 * ResponseUtils.getJQGridJsonResponse(response, listMember,
		 * currentPage, pageRows, totalRows); } catch(Exception e) {
		 * e.printStackTrace(); resultData.put("status",
		 * HttpStatus.INTERNAL_SERVER_ERROR.value()); resultData.put("rows",
		 * null); }
		 // //////////////////////////////////////////////////////////////////////////////////
		// ///////////////////////////원본
		List<SYProdVo> listCode = null;
		// sYprodService.insertSapProdOrd();
		listCode = sYprodService.sapProdCode_confirm(prodVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		
		return resultData.toJSONString();
	}
	*/
	/*
	@ResponseBody
	@RequestMapping(value = "/prod/fault_grid_select", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String fault_grid_select(@ModelAttribute SYSernrManageVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.fault_grid_select() is called.");

		List<SYSernrManageVo> listCode = null;
		SYSernrManageVo sVo = new SYSernrManageVo();
		listCode = sYprodService.fault_grid_select(sVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
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
	
	/*@ResponseBody
	@RequestMapping(value = "/prod/pop_prod_his_select", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String pop_prod_his_select(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.pop_prod_his_select() is called.");

		List<SYProdVo> listCode = null;

		listCode = sYprodService.popProdHisSelect(prodVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
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
	@RequestMapping(value = "/prod/pop_prod_his_select_confirm", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String pop_prod_his_select_confrim(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.pop_prod_his_select_confrim() is called.");
		
		List<SYProdVo> listCode = null;
		
		listCode = sYprodService.popProdHisSelect_confrim(prodVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		
		return resultData.toJSONString();
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/prod/cofirm_ord_chk", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String confirmOrdChk(@ModelAttribute SYProdVo pordVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.confirmOrdChk() is called.");

		List<SYProdVo> listCode = null;
		String pordnos = request.getParameter("pordnos");
		listCode = sYprodService.confirmOrdChk(pordnos);

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/prod/pop_prod_his_chk", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String popProdHisChk(@ModelAttribute SYProdVo pordVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.popProdHisChk() is called.");

		List<SYProdVo> listCode = null;
		String pordnos = request.getParameter("pordnos");
		listCode = sYprodService.popProdHisChk(pordnos);

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		try {

			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
*/
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/prod/rawDelivery_selectByKey", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String rawDelivery_selectByKey(
			@ModelAttribute SYScmRawDeliveryVo sVo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.raw_status_chk() is called.");

		List<SYScmRawDeliveryVo> listCode = null;
		String ebeln = request.getParameter("ebeln");
		String ebelp = request.getParameter("ebelp");
		sVo.setEbeln(ebeln);
		sVo.setEbelp(ebelp);
		listCode = sYscmService.rawDelivery_selectByKey(sVo);

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/prod/rawVendor_selectAll", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String rawDelivery_selectByKey(
			@ModelAttribute SYScmRawVendorResultVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.raw_status_chk() is called.");

		List<SYScmRawVendorResultVo> listCode = null;
		String ebeln = request.getParameter("ebeln");
		String ebelp = request.getParameter("ebelp");
		String partial_seq = request.getParameter("partial_seq");
		sVo.setEbeln(ebeln);
		sVo.setEbelp(ebelp);
		listCode = sYscmService.rawVendor_selectAll(sVo);

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/scm/rawProc_selectByKey", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String rawProc_selectByKey(@ModelAttribute SYScmRawProcVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.rawProc_selectByKey() is called.");
		
		List<SYScmRawProcVo> listCode = null;
		listCode = sYscmService.rawProc_selectByKey(sVo);
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}

	/*@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/hub/req_status_chk", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String req_status_chk(@ModelAttribute SYReqmMatnrTblVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.req_status_chk() is called.");

		List<SYReqmMatnrTblVo> listCode = null;
		String reqm_matnr_key = request.getParameter("reqm_matnr_key");
		String reqm_sub_key = request.getParameter("reqm_sub_key");
		sVo.setReqm_matnr_key(reqm_matnr_key);
		sVo.setReqm_sub_key(reqm_sub_key);
		listCode = sYhubService.req_status_chk(sVo);

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		try {

			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/

	/*@ResponseBody
	@RequestMapping(value = "/hub/req_confirm", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String req_confirm(@ModelAttribute SYReqmMatnrTblVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.req_confirm() is called.");

		List<SYReqmMatnrTblVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONObject resultData_1 = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		String gridData = request.getParameter("gridData"); // 시리얼 관리 대상 실적들(화면 왼쪽 그리드 데이터)
		String gridData_1 = request.getParameter("gridData_1"); // 시리얼 비관리 대상 실적들(화면 오른쪽 그리드 데이터)
		String conf_date = request.getParameter("conf_date");

		String reqm_matnr_key = request.getParameter("reqm_matnr_key");
				
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));

			sVo.setGridData(gridData);
			sVo.setGridData_1(gridData_1);
			sVo.setGrantor_date(conf_date);
			sYhubService.reqd_sernr_insert(sVo);
			resultData.put("status", HttpStatus.OK.value());

			//******************* rfc 로 요청승인 된 내역 전송 : Start *******************//*
			resultData_1 = sapMasterService.zmmfm_goodsmvt_st("ZMMFM_GOODSMVT_ST", reqm_matnr_key, conf_date);
			Object e_return = resultData_1.get("e_return");
			Object e_message = resultData_1.get("e_message");
			resultData.put("e_return", e_return);
			resultData.put("e_message", e_message);
			//******************* rfc 로 요청승인 된 내역 전송 : End *******************//*

			System.out.println("#####################################################");
			System.out.println("RFC 전송 결과 :: " + e_return);
			System.out.println("reqm_matnr_key :: " + reqm_matnr_key);
			
			if(e_return.equals("E")) {
				SYReqmMatnrTblVo pVo = new SYReqmMatnrTblVo();
				pVo.setReqm_matnr_key(reqm_matnr_key);
				
				int tt = sYhubService.reqm_cancel_update(pVo);
				int dd = sYhubService.reqd_cancel_update(pVo);
				int ee = sYhubService.reqd_sernr_cancel_delete(pVo);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	/*
	@ResponseBody
	@RequestMapping(value = "/hub/conf_bdmng_update", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String conf_bdmng_update(@ModelAttribute SYReqmMatnrTblVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.conf_bdmng_update() is called.");

		List<SYReqmMatnrTblVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONObject resultData_1 = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		String gridData = request.getParameter("gridData");
		String conf_date = request.getParameter("conf_date");
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));
			sVo.setGridData(gridData);
			sVo.setGrantor_date(conf_date);
			sYhubService.conf_bdmng_update(sVo);
			resultData.put("status", HttpStatus.OK.value());

			*//******************* rfc 로 요청승인 된 내역 전송 : Start *******************//*
			resultData_1 = sapMasterService.zmmfm_goodsmvt_st("ZMMFM_GOODSMVT_ST", gridData, conf_date);
			Object e_return = resultData_1.get("e_return");
			Object e_message = resultData_1.get("e_message");
			resultData.put("e_return", e_return);
			resultData.put("e_message", e_message);
			*//******************* rfc 로 요청승인 된 내역 전송 : End *******************//*

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/scm/rawProc_sernr_duplication_chk", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String rawProc_sernr_duplication_chk(
			@ModelAttribute SYScmRawProcSernrVo sVo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.rawProc_sernr_duplication_chk() is called.");
		
		List<SYScmRawProcSernrVo> listCode = null;
		String sernrs = request.getParameter("sernrs");
		listCode = sYscmService.rawProc_sernr_duplication_chk(sernrs);
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
/*
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/prod/pop_prod_routing_chk", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public boolean popProdRoutingChk(@ModelAttribute SYProdVo pordVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.popProdRoutingChk() is called.");

		// List<SYProdVo> listCode = null;
		boolean result;
		String pordnos = request.getParameter("pordnos");
		result = sYprodService.popProdRoutingChk(pordnos);

		return result;
	}
*/
	/*@ResponseBody
	@RequestMapping(value = "/prod/pop_prod_select", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String popProdSelect(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.popProdSelect() is called.");

		List<SYProdVo> listCode = null;
		// sYprodService.insertSapProdOrd();
		listCode = sYprodService.popProdSelect(prodVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
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
	@RequestMapping(value = "/prod/mngProcessDtl_select_1", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String mngProcessDtl_select_1(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.mngProcessDtl_select_1() is called.");

		List<SYProdVo> listCode = null;

		listCode = sYprodService.select1(prodVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/prod/mngProcessDtl_select_2", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String mngProcessDtl_select_2(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.mngProcessDtl_select_2() is called.");

		List<SYProdVo> listCode = null;

		listCode = sYprodService.select2(prodVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/prod/mngProcessDtl_select_3", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String mngProcessDtl_select_3(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.mngProcessDtl_select_3() is called.");

		List<SYProdVo> listCode = null;

		listCode = sYprodService.select3(prodVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/prod/mngProcessDtl_select_4", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String mngProcessDtl_select_4(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.mngProcessDtl_select_4() is called.");

		List<SYProdVo> listCode = null;

		listCode = sYprodService.select4(prodVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/prod/faultMemo_update", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String faultMemo_update(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.faultMemo_update() is called.");
		prodVo.setCreator(SessionUtil.getMemberId(request));
		prodVo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			sYprodService.faultMemo_update(prodVo);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
*/
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/prod/workStart_update", method =
	 * {RequestMethod.GET, RequestMethod.POST},
	 * produces="application/json;charset=UTF-8")
	 * 
	 * @SuppressWarnings("unchecked") public String
	 * workStart_update(@ModelAttribute SYProdVo prodVo, HttpServletRequest
	 * request, HttpServletResponse response, HttpSession session) {
	 * logger.debug("FrontendController.workStart_update() is called.");
	 * JSONObject resultData = new JSONObject(); try{
	 * prodVo.setCreator(SessionUtil.getMemberId(request));
	 * prodVo.setUpdater(SessionUtil.getMemberId(request));
	 * 
	 * // String pordno_pop = request.getParameter("pordno_pop"); // String
	 * routing_no = request.getParameter("routing_no");
	 * 
	 * sYprodService.workStart_update(prodVo);
	 * 
	 * resultData.put("status", HttpStatus.OK.value()); } catch(Exception e) {
	 * e.printStackTrace(); resultData.put("status",
	 * HttpStatus.INTERNAL_SERVER_ERROR.value()); } return
	 * resultData.toJSONString(); }
	 */

	/*@ResponseBody
	@RequestMapping(value = "/prod/workStart_update", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String workStart_update(@ModelAttribute SYProdVo prodVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.workStart_update() is called.");
		JSONObject resultData = new JSONObject();
		try{
			prodVo.setCreator(SessionUtil.getMemberId(request));
			prodVo.setUpdater(SessionUtil.getMemberId(request));
			
//			String pordno_pop = request.getParameter("pordno_pop");
//			String routing_no = request.getParameter("routing_no");
			
			sYprodService.workStart_update(prodVo);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	
	/*@ResponseBody
	@RequestMapping(value = "/prod/worker_update", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String worker_update(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.worker_update() is called.");
		JSONObject resultData = new JSONObject();
		try {
			prodVo.setCreator(SessionUtil.getMemberId(request));
			prodVo.setUpdater(SessionUtil.getMemberId(request));

			if(prodVo.getMember_emp_no() == null) {
				
				prodVo.setMember_emp_no(SessionUtil.getMemberEmpNo(request));
				prodVo.setMember_nm(SessionUtil.getMemberNm(request));
				prodVo.setMember_cnt("1");
				
			}

//			int result = sYprodService.worker_update(prodVo); // UPDATE
			
			int result = 0;
			// 작업자 추가전에 이미 등록 되어 있는지 확인
			int chkCnt = sYprodService.chk_worker_update(prodVo);
			if (chkCnt > 0) {
				resultData.put("returnMsg", "Already registered");
			} else {
				result = sYprodService.worker_update(prodVo); // UPDATE PROD_ORD_TBL
				resultData.put("returnMsg", result);
			}
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	
	/*@ResponseBody
	@RequestMapping(value = "/prod/worker_update_new", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String worker_update_new(@ModelAttribute SYProdVo prodVo,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.worker_update_new() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		try {
			prodVo.setCreator(SessionUtil.getMemberId(request));
			prodVo.setUpdater(SessionUtil.getMemberId(request));
			
			if(prodVo.getMember_emp_no() == null) {
				prodVo.setMember_emp_no(SessionUtil.getMemberEmpNo(request));
				prodVo.setMember_nm(SessionUtil.getMemberNm(request));
				prodVo.setMember_cnt("1");
			}
			String params = request.getParameter("params");
			jsonArray = (JSONArray) parser.parse(params);
			Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray();
			List<SYProdVo> list = new ArrayList<SYProdVo>(); 
			for(int i=0; i<jsonArray.size(); i++) {
				JSONObject jObj = (JSONObject)jsonArray.get(i);
				SYProdVo vo = new SYProdVo();
				vo.setMember_emp_no(prodVo.getMember_emp_no());
				vo.setMember_nm(prodVo.getMember_nm());
				vo.setMember_cnt(prodVo.getMember_cnt());
				//vo.setJocod(prodVo.getJocod());
				for(Object key : keyArr) {
					String nKey = key.toString();
					String nValue = "";
					if( jObj.get(nKey)==null ) continue;
					else nValue = jObj.get(nKey).toString();
					
					if( "pordno_pop".equals(nKey) ) vo.setPordno_pop(nValue);
					else if( "routing_no".equals(nKey) ) vo.setRouting_no(nValue);
				}
				list.add(vo);
			}
			int listCnt = list.size();
			int result = 0;
			for(SYProdVo tmpVo : list){
				// 작업자 추가전에 이미 등록 되어 있는지 확인
				int chkCnt = sYprodService.chk_worker_update(tmpVo);
				if (chkCnt > 0) {
					resultData.put("returnMsg", "Already registered");
				} else {
					result += sYprodService.worker_update(tmpVo); // UPDATE
					resultData.put("returnMsg", result);
				}
			}
//			if( listCnt==result ){
				resultData.put("status", HttpStatus.OK.value());
//			} else {
//				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/

	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/prod/workEnd_update", method =
	 * {RequestMethod.GET, RequestMethod.POST},
	 * produces="application/json;charset=UTF-8")
	 * 
	 * @SuppressWarnings("unchecked") public String
	 * workEnd_update(@ModelAttribute SYProdVo prodVo, HttpServletRequest
	 * request, HttpServletResponse response, HttpSession session) {
	 * logger.debug("FrontendController.workEnd_update() is called.");
	 * JSONObject resultData = new JSONObject(); try{
	 * prodVo.setCreator(SessionUtil.getMemberId(request));
	 * prodVo.setUpdater(SessionUtil.getMemberId(request));
	 * 
	 * // String pordno_pop = request.getParameter("pordno_pop"); // String
	 * routing_no = request.getParameter("routing_no");
	 * 
	 * 
	 * sYprodService.workEnd_update(prodVo); resultData.put("status",
	 * HttpStatus.OK.value()); } catch(Exception e) { e.printStackTrace();
	 * resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value()); }
	 * return resultData.toJSONString(); }
	 *//*
	@ResponseBody
	@RequestMapping(value = "/prod/matr_insert", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String matr_insert(@ModelAttribute SYPoRequirementVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.matr_insert() is called.");
		JSONObject resultData = new JSONObject();
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));

			String pordnos = request.getParameter("pordnos");
			sYprodService.matr_insert(pordnos);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
/*
	@ResponseBody
	@RequestMapping(value = "/prod/matr_delete", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String matr_delete(@ModelAttribute SYPoRequirementVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.matr_delete() is called.");
		JSONObject resultData = new JSONObject();
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));
			String pordnos = request.getParameter("pordnos");
			sYprodService.matr_delete(pordnos);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
*/
	/*@ResponseBody
	@RequestMapping(value = "/prod/getProdStatus", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String getProdStatus(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.getProdStatus() is called.");
		
		SYProdVo rVo = sYprodService.getProdStatus(prodVo);

		String r_pdsts = rVo.getPdsts();
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("result", r_pdsts);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}*/
	
	/*@ResponseBody
	@RequestMapping(value = "/prod/getProdStatus_new", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String getProdStatus_new(@ModelAttribute SYProdVo prodVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.getProdStatus_new() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser parser = new JSONParser();
		try {
			String params = request.getParameter("params");
			listDataJArray = (JSONArray)parser.parse(params);
			Object[] keyArr = ((JSONObject)listDataJArray.get(0)).keySet().toArray();
			List<SYProdVo> list = new ArrayList<SYProdVo>();
			for( int i=0; i<listDataJArray.size(); i++) {
				JSONObject jObj = (JSONObject)listDataJArray.get(i);
				SYProdVo tmpVo = new SYProdVo();
				for(Object key : keyArr) {
					String nKey = key.toString();
					String nValue = "";
					if( jObj.get(nKey)==null ) continue;
					else nValue = jObj.get(nKey).toString();
					
					if( "pordno_pop".equals(nKey) ) tmpVo.setPordno_pop(nValue);
					else if( "routing_no".equals(nKey) )tmpVo.setRouting_no(nValue);
				}
				list.add(sYprodService.getProdStatus(tmpVo));
			}
			String listDataJsonString = ResponseUtils.getJsonResponse(response,list);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("result", listDataJsonString);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	
	/*
	@ResponseBody
	@RequestMapping(value = "/prod/workChangeStatus", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String workChangeStatus(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.workChangeStatus() is called.");
		JSONObject resultData = new JSONObject();
		try {
			prodVo.setCreator(SessionUtil.getMemberId(request));
			prodVo.setUpdater(SessionUtil.getMemberId(request));
			
			String rtn_msg = "";
			
			String pdsts = request.getParameter("pdsts");
			
			SYProdVo tmpVo = sYprodService.getProdStatus(prodVo);
			
			String now_status = tmpVo.getPdsts();
			
			String status_change_yn = "Y";		//상태 변경 성공 여부
			
			System.out.println("##################################################");
			System.out.println("요청 pdsts ::: " + pdsts + "     //     현재 pdsts ::: " + now_status);
			
			if (pdsts.equals("p3") && now_status.equals("p2")) { // 시작
				sYprodService.workStart_update(prodVo);
				rtn_msg = "선택된 지시가 생산시작 성공했습니다.";
			} else if (pdsts.equals("p4") && (now_status.equals("p3") || now_status.equals("p5"))) { // 비가동
				sYprodService.workPauseHisStart_insert(prodVo);
				rtn_msg = "선택된 지시가 비가동 시작에 성공했습니다.";
			} else if (pdsts.equals("p5") && now_status.equals("p4")) { // 재가동
				sYprodService.workPauseHisEnd_insert(prodVo);
				rtn_msg = "선택된 지시가 비가동 종료에 성공했습니다.";
			} else if (pdsts.equals("p6") && (now_status.equals("p3") || now_status.equals("p5"))) { // 종료
				sYprodService.workEnd_update(prodVo);
				rtn_msg = "선택된 지시가 생산완료 성공했습니다";
			} else {	
				status_change_yn = "N";	// status 변경 없음.. 이미 다른PC의 같은 화면에서 상태 변경..되거나 현재상태와 맞지 않는 처리요청이 들어왔을때...
				//rtn_msg = "선택된 지시는 이미 처리됐습니다.";
				rtn_msg = "요청한 작업선택이 올바르지 않습니다. 다시 확인하고 처리해주세요.";
			}
			
			if(status_change_yn.equals("Y")) {
				prodVo.setPordno((prodVo.getPordno_pop()).substring(0, 10));
				sYprodService.prod_stat_update(prodVo);// UPDATE PROD_TBL
			} else {}
			
			resultData.put("status_change_yn", status_change_yn);
			resultData.put("rtn_msg", rtn_msg);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
/*
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/prod/prod_ord_non_confirm", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String prodOrdNonConfirm(@ModelAttribute SYProdVo pordVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.prodOrdNonConfirm() is called.");
		JSONObject resultData = new JSONObject();
		try {
			pordVo.setCreator(SessionUtil.getMemberId(request));
			pordVo.setUpdater(SessionUtil.getMemberId(request));

			String pordnos = request.getParameter("pordnos");
			
			//////////////////////
			
			String funcName = "ZIFFM_MES_PP011";
			String params = request.getParameter("params");	// json list : object String
			String pdsts = request.getParameter("p1");
			String sessId = SessionUtil.getMemberId(request);
			JSONObject result = sapMasterService.ziffm_mes_pp011(funcName, params, pdsts, sessId);
			
			//////////////////////
			
			if(result.get("zifsta").toString().equals("S")) {
				sYprodService.prodOrdNonConfirm(pordnos);
			}
			
			resultData.put("zifsta", result.get("zifsta").toString());
			resultData.put("zifmsg", result.get("zifmsg").toString());
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
*/
	/*@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/prod/main_serial_add", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String main_serial_add(@ModelAttribute SYProdVo pordVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.main_serial_add() is called.");
		JSONObject resultData = new JSONObject();
		try {
			pordVo.setCreator(SessionUtil.getMemberId(request));
			pordVo.setUpdater(SessionUtil.getMemberId(request));

			int mResult = sYprodService.updateMainSerial(pordVo);
			String resultStr = "";
			if (mResult > 0) {
				int cResult = sYprodService.updateDetailSerial(pordVo);
				if (mResult > 0) {
					// resultStr += "PROD_ORD_TBL update success.";
					resultStr = "S";
				} else {
					// resultStr += "PROD_ORD_TBL update fail.";
					resultStr = "F";
				}
				// resultStr += "PROD_TBL update success.";
				resultStr = "S";
			} else {
				// resultStr += "PROD_TBL update Fail.";
				resultStr = "F";
			}
			JSONObject result = sapMasterService.ziffm_mes_pp011("ZIFFM_MES_PP011", pordVo.getParams(), pordVo.getPdsts(),	SessionUtil.getMemberId(request));
			
			if(result.get("zifsta").toString().equals("S")) {
				int result_1 = sYprodService.updateLastInspSerial(pordVo);
			}
			
			if( "200".equals(result.get("status").toString()) ) {
				resultData.put("result", resultStr);
				resultData.put("status", HttpStatus.OK.value());
			} else {
				resultData.put("result", "F");
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/

	
	/*@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/prod/projectNoDupChk", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String projectNoDupChk(@ModelAttribute SYProdVo pordVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.projectNoDupChk() is called.");
		JSONObject resultData = new JSONObject();
		try {
			pordVo.setCreator(SessionUtil.getMemberId(request));
			pordVo.setUpdater(SessionUtil.getMemberId(request));
			
			int result = sYprodService.projectNoDupChk(pordVo);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt",  Integer.toString(result));
			
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	/*
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/prod/chkSerialNoDuplicate", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String chkSerialNoDuplicate(@ModelAttribute SYSernrManageVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.chkSerialNoDuplicate() is called.");
		JSONObject resultData = new JSONObject();
		try {
			resultData.put("cnt", sYprodService.chkSerialNoDuplicate(sVo));
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
*/
	/*@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/prod/detail_serial_add", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String detail_serial_add(@ModelAttribute SYSernrManageVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.detail_serial_add() is called.");
		JSONObject resultData = new JSONObject();
		JSONObject resultObj = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		String user_id = SessionUtil.getMemberId(request);
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));
			String dept_cd = request.getParameter("dept_cd");
			String lgort = request.getParameter("lgort"); // ??

			
			 * 1. 받아온 그리드 데이터를 vo로 만든다. 2. 기존 저장되어 있는 데이터와 같은 데이터가 있으면, reverse
			 * 항목에 "X" 를 세팅한다. 3. 007 에 전달한다.
			 
			// 1.
			String params = sVo.getParams();
			// string to json list
			listDataJArray = (JSONArray) jsonParser.parse(params);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar c1 = Calendar.getInstance();
			String strToday = sdf.format(c1.getTime());

			List<SYSernrManageVo> iVoList = new ArrayList<SYSernrManageVo>();
			if (listDataJArray.size() > 0) {
				JSONObject jOb = (JSONObject) listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();
				for (int idx = 0; idx < listDataJArray.size(); idx++) {
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject) listDataJArray.get(idx);
					SYSernrManageVo tmpVo = new SYSernrManageVo();
					tmpVo.setPordno_pop(sVo.getPordno_pop());
					tmpVo.setPordno(sVo.getPordno());
					tmpVo.setBudat(strToday);
					tmpVo.setRouting_gno(sVo.getRouting_gno());
					tmpVo.setRouting_no(sVo.getRouting_no());
					for (Object key : keyArr) {
						String nKey = key.toString();
//						String nValue = "";
//						if(jObj.get(nKey)!=null) nValue = jObj.get(nKey).toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						if ("matnr".equals(nKey))
							tmpVo.setMatnr(nValue);
						else if ("meins".equals(nKey))
							tmpVo.setMeins(nValue);
						else if ("sernr".equals(nKey))
							tmpVo.setSernr(nValue);
						else if ("sernp".equals(nKey))
							tmpVo.setSernp(nValue);
						else if ("lgort".equals(nKey))
							tmpVo.setLgort(nValue);
						else if ("sernr_seq".equals(nKey))
							tmpVo.setSernr_seq(nValue);						
						else if ("bdmng".equals(nKey)) {
							tmpVo.setBdmng(nValue);
							tmpVo.setMenge(nValue);
						}
					}
					iVoList.add(idx, tmpVo);
				}
			}
			// 2. 삭제 대상 조회 "X" 플래그 넣어 저장
			List<SYSernrManageVo> loadVoList = new ArrayList<SYSernrManageVo>();
			List<SYSernrManageVo> delVoList = new ArrayList<SYSernrManageVo>();
			loadVoList = sYprodService.selectSernrManageTbl(sVo);
			if (iVoList.size() == 0) {
				for (SYSernrManageVo lVo : loadVoList) {
					lVo.setReverse("X");
					iVoList.add(iVoList.size(), lVo);
					delVoList.add(lVo);
					lVo.setReverse("X");
					iVoList.add(iVoList.size(), lVo);
					
					if(	Float.parseFloat(lVo.getBdmng())< 0 ){
						
						lVo.setReversecheck("A");  // reverse 痍⑥냼�떆 湲곗〈怨� 諛섎�濡� 異쒓퀬泥섎━�빐�빞�븯湲곕븣臾몄뿉 援щ텇�옄 "A"異붽�
						lVo.setReverse("");
						lVo.setMenge(String.valueOf(Math.abs(Float.parseFloat(lVo.getBdmng()))));
						lVo.setBdmng(String.valueOf(Math.abs(Float.parseFloat(lVo.getBdmng()))));
						
						//영향 미치는지 확인...
//						lVo.setMenge(lVo.getBdmng());
//						lVo.setBdmng(lVo.getBdmng());
					
					}			
					delVoList.add(lVo);		
				}
			} else {
				for (SYSernrManageVo lVo : loadVoList) {
					String lSernr_seq = lVo.getSernr_seq();
					String flag = "X";
					for (SYSernrManageVo iVo : iVoList) {
						String iSernr_seq = iVo.getSernr_seq();
						if (lSernr_seq.equals(iSernr_seq)) {
							flag = "O";
							break;
						}
					}
					// 기존 목록에 대하여 새로운 목록을 비교, 삭재된 항목에 대하여 reverse "X"를 set 하여
					// rfc에 보낼 데이터에 합하여 준다.
					if ("X".equals(flag)) {
						lVo.setReverse("X");
						iVoList.add(iVoList.size(), lVo);
						
						if(	Float.parseFloat(lVo.getBdmng())< 0 ){
							
							lVo.setReversecheck("A");   // reverse 취소시 기존과 반대로 출고처리해야하기때문에 구분자 "A"추가
							lVo.setReverse("");
//							lVo.setMenge(String.valueOf(Math.abs(Float.parseFloat(lVo.getBdmng()))));
//							lVo.setBdmng(String.valueOf(Math.abs(Float.parseFloat(lVo.getBdmng()))));
							lVo.setMenge(String.valueOf(Math.abs(Integer.parseInt(lVo.getBdmng()))));
							lVo.setBdmng(String.valueOf(Math.abs(Integer.parseInt(lVo.getBdmng()))));		
						
						}
						delVoList.add(lVo);
					}
				}
			}
			
			// 2. 추가 대상만 추린다.
			// List<SYSernrManageVo> newArr = new ArrayList<SYSernrManageVo>();
			List<SYSernrManageVo> intArr = new ArrayList<SYSernrManageVo>();
			if (iVoList.size() > 0) {
				for (SYSernrManageVo vo : iVoList) {
					if (!("X".equals(vo.getReverse())))
						intArr.add(vo);
					//해체 때문에 수정 해체일경우 (-) 수량이 온다. (-) 수량이 오면 즉 'X'=> rfc 는 reverse 처럼 처리하여 rfc 전송한다.
					if (!("X".equals(vo.getReverse()))  && !("A".equals(vo.getReversecheck())) ){  // reverse 취소시 기존과 반대로 출고처리해야하기때문에 구분자 "A"추가
						if(	Float.parseFloat(vo.getBdmng())< 0 ){
							vo.setReversecheck("X");
							vo.setReverse("X");
//							vo.setMenge(String.valueOf(Math.abs(Float.parseFloat(vo.getBdmng()))));
//							vo.setBdmng(String.valueOf(Math.abs(Float.parseFloat(vo.getBdmng()))));
							
							vo.setMenge(String.valueOf(Math.abs(Integer.parseInt(vo.getBdmng()))));
							vo.setBdmng(String.valueOf(Math.abs(Integer.parseInt(vo.getBdmng()))));							
						}
						intArr.add(vo);
					}
				}
				
				for (int idx = 0; idx < iVoList.size(); idx++) {
					SYSernrManageVo vo = iVoList.get(idx);
					String iSernr_seq = vo.getSernr_seq();
					if (loadVoList.size() > 0) {
						for (SYSernrManageVo lVo : loadVoList) {
							String lSernr_seq = lVo.getSernr_seq();
							if (lSernr_seq.equals(iSernr_seq)) {
								intArr.remove(vo);
							}else{
							}
						}
					}else{
					}
				}
			}
			
			// 3.
			List<SYSernrManageVo> rfcVoList = new ArrayList<SYSernrManageVo>();
			if( intArr.size()>0 ){
				for( SYSernrManageVo vo : intArr) {
					rfcVoList.add(vo);
				}
			}
			System.out.println("##################intArr#######################");
			System.out.println(intArr.toString());
			
			if( delVoList.size()>0 ){
				for( SYSernrManageVo vo : delVoList) {
					rfcVoList.add(vo);
				}
			}
			System.out.println("##################delVoList#######################");
			System.out.println(delVoList.toString());
			
			System.out.println(rfcVoList);
			String target_ds = "Material input processing";
			resultObj = sapMasterService.ziffm_mes_pp007("ZIFFM_MES_PP007", rfcVoList, dept_cd, user_id, target_ds);
			
			if ( "200".equals(resultObj.get("status").toString()) ) {
				String zifsta = "-";
				String zifmsg = "-";
				if(resultObj.get("zifsta") != null) {
					zifsta = resultObj.get("zifsta").toString();
					zifmsg = resultObj.get("zifmsg").toString(); 
				}
				
				resultData.put("zifsta", zifsta);
				resultData.put("zifmsg", zifmsg);
				
				if(zifsta.equals("S")) {
						
					sVo.setIf_status("S");
					sVo.setIf_msg(resultObj.get("message").toString());
					
					if( iVoList.size()>0 ){
						for ( SYSernrManageVo vo : iVoList) {
							SYSernrManageVo tmpVo = new SYSernrManageVo();
							tmpVo.setPordno_pop(vo.getPordno_pop());
							tmpVo.setRouting_no(vo.getRouting_no());
							tmpVo.setMatnr(vo.getMatnr());
							sYprodService.deleteSernrManageTbl(tmpVo);
						}
					}
					if( iVoList.size()>0 ){
						for( SYSernrManageVo vo : iVoList ){
							// ivolist 가 변경되었기 때문에 insertSernrManageTbl에 insert 처리하기 위해서 다시 원상태로 돌려준다. insertSernrManageTbl 에 -수량으로 이력을 쌓는다.
							if(("X".equals(vo.getReversecheck()))){
								vo.setReverse("");
								vo.setMenge("-"+vo.getBdmng());
								vo.setBdmng("-"+vo.getBdmng());
							}
							if( !("X".equals(vo.getReverse())) && !("A".equals(vo.getReversecheck())) ) // reverse 취소시 기존과 반대로 출고처리해야하기때문에 구분자 "A"추가
								sYprodService.insertSernrManageTbl(vo);
						}
					}
				}
			}
			
			// UPDATE sub_Sernr
			String sub_sernr = request.getParameter("sub_sernr");

			if( !"".equals(sub_sernr) && sub_sernr!=null) {
				SYProdVo pVo = new SYProdVo();
				pVo.setPordno(sVo.getPordno());
				pVo.setSub_sernr(sub_sernr);
				int mResult = sYprodService.updateMainSerial(pVo);
				int cResult = sYprodService.updateDetailSerial(pVo);
			}
			
			resultData.put("result", resultObj.toJSONString());
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	
	/*@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/mes/select_beforeJob_pdsts", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String select_beforeJob_pdsts(@ModelAttribute SYProdVo pVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.select_beforeJob_pdsts() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		List<SYProdVo> list = new ArrayList<SYProdVo>();
		try{
			list = sYmesService.select_beforeJob_pdsts(pVo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	
	/*@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/prod/selectSernrManageTbl", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String selectSernrManageTbl(@ModelAttribute SYSernrManageVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectSernrManageTbl() is called.");
		JSONObject resultData = new JSONObject();
		JSONObject resultObj = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		List<SYSernrManageVo> list = new ArrayList<SYSernrManageVo>();
		try{
			list = sYprodService.selectSernrManageTbl(sVo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	
	/*@ResponseBody
	@RequestMapping(value = "/prod/worker_select_1110", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String worker_select_1110(@ModelAttribute SYMemberVo memberVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.worker_select_1110() is called.");

		List<SYProdVo> listCode = null;
	//	System.out.println("dept_cd"+dept_cd );
		//memberVo.setDept_cd(dept_cd);
		listCode = sYprodService.worker_select_1110(memberVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
//		JSONParser jsonParser = new JSONParser();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,listCode);
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
	@RequestMapping(value = "/mes/metrial_req_detail_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String mesMetrialReq_detail_select(@ModelAttribute SYMesVo mesVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.mesMetrialReq_detail_select() is called.");
		
		List<SYMesVo> listCode = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// pagination--
//			int currentPage = Integer.parseInt(request.getParameter("page")); 
//		    int pageRows = Integer.parseInt(request.getParameter("rows")); 
//		    int startIndex = currentPage * pageRows - pageRows; 
		    
//		    mesVo.setPage(startIndex);
//		    mesVo.setRows(pageRows);
		    
//		    int totalRows = sYmesService.selectDetailListCount(mesVo);
		    // -- pagination
		    
			resultData = sYmesService.selectDetailList(mesVo);
//			String listDataJsonString = ResponseUtils.getJsonResponse(response,listCode);
//			listDataJArray = (JSONArray)jsonParser.parse(jsonObjStr);
//			resultData.put("status", HttpStatus.OK.value());
//			resultData.put("rows", listDataJArray);
//			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	

	// Hub > Materials_approve(done) 승인완료된 실적 조회
	/*@ResponseBody
	@RequestMapping(value = "/hub/material_req_done_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_req_done_select(@ModelAttribute SYReqmMatnrTblVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.material_req_done_select() is called.");
		
		List<SYReqmMatnrTblVo> listCode = null;

		String reqm_matnr_key = request.getParameter("reqm_matnr_key");
		String reqm_sub_key = request.getParameter("reqm_sub_key");

		sVo.setReqm_matnr_key(reqm_matnr_key);
		sVo.setReqm_sub_key(reqm_sub_key);

		listCode = sYhubService.material_req_done_select(sVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
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
	@RequestMapping(value = "/hub/material_req_det_select_1", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_req_det_select_1(@ModelAttribute SYReqmMatnrTblVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.material_req_det_select_1() is called.");
		
		List<SYReqmMatnrTblVo> listCode = null;
		
		String reqm_matnr_key = request.getParameter("reqm_matnr_key");
//		String reqm_sub_key = request.getParameter("reqm_sub_key");
		
		sVo.setReqm_matnr_key(reqm_matnr_key);
		// sVo.setReqm_sub_key(reqm_sub_key);

		listCode = sYhubService.material_req_det_select_1(sVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
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
	
	// Hub > Materials_approve(detail)
	/*@ResponseBody
	@RequestMapping(value = "/hub/material_req_det_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_req_det_select(@ModelAttribute SYReqmMatnrTblVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.material_req_det_select() is called.");

		List<SYReqmMatnrTblVo> listCode = null;

		String reqm_matnr_key = request.getParameter("reqm_matnr_key");
		String reqm_sub_key = request.getParameter("reqm_sub_key");

		sVo.setReqm_matnr_key(reqm_matnr_key);
		sVo.setReqm_sub_key(reqm_sub_key);

		listCode = sYhubService.material_req_det_select(sVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
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

	@ResponseBody
	@RequestMapping(value = "/hub/material_req_mas_select_1", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_req_mas_select_1(@ModelAttribute SYReqmMatnrTblVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.material_req_mas_select_1() is called.");

		List<SYReqmMatnrTblVo> listCode = null;

		String from_req_date = request.getParameter("from_req_date");
		String to_req_date = request.getParameter("to_req_date");

		String grantor_status = request.getParameter("grantor_status");
		String werks = request.getParameter("werks");

		sVo.setFrom_req_date(from_req_date);
		sVo.setTo_req_date(to_req_date);
		sVo.setGrantor_status(grantor_status);
		sVo.setWerks(werks);
		
		listCode = sYhubService.material_req_mas_select_1(sVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		
		return resultData.toJSONString();
	}
	
	// Hub > Materials_approve(master)

	@ResponseBody
	@RequestMapping(value = "/hub/material_req_mas_select", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_req_mas_select(@ModelAttribute SYReqmMatnrTblVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.material_req_mas_select() is called.");

		List<SYReqmMatnrTblVo> listCode = null;

		String from_req_date = request.getParameter("from_req_date");
		String to_req_date = request.getParameter("to_req_date");

		String grantor_status = request.getParameter("grantor_status");
		String werks = request.getParameter("werks");

		sVo.setFrom_req_date(from_req_date);
		sVo.setTo_req_date(to_req_date);
		sVo.setGrantor_status(grantor_status);
		sVo.setWerks(werks);

		listCode = sYhubService.material_req_mas_select(sVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}

	// Hub > Quality manage
	@ResponseBody
	@RequestMapping(value = "/hub/quality_master_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String qualityMaster_select(@ModelAttribute SYHubRevInsMasVo hubVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.qualityMaster_select() is called.");

		List<SYHubRevInsMasVo> listCode = null;

		listCode = sYhubService.qualityMaster_select(hubVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/hub/quality_detail_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String qualityDetail_select(@ModelAttribute SYHubRevInsCliVo hubVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.qualityDetail_select() is called.");

		List<SYHubRevInsCliVo> listCode = null;

		listCode = sYhubService.qualityDetail_select(hubVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}

	/*@ResponseBody
	@RequestMapping(value = "/hub/quality_detailTest_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String qualityDetailTest_select(@ModelAttribute SYHubRevInsCliVo hubVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.qualityDetailTest_select() is called.");

		List<SYHubRevInsCliVo> listCode = null;

		listCode = sYhubService.qualityDetailTest_select(hubVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
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

	/*@ResponseBody
	@RequestMapping(value = "/hub/routing_header_select", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routingHeader_select(@ModelAttribute SYHubRoutingHeaderVo hubRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routingheader_select() is called.");

		List<SYHubRoutingHeaderVo> listCode = null;

		listCode = sYhubService.routingHeader_select(hubRVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
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
	@RequestMapping(value = "/hub/routing_headerItem_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routingHeaderItem_select(@ModelAttribute SYHubRoutingHeaderVo hubRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routingHeaderItem_select() is called.");

		List<SYHubRoutingHeaderVo> listCode = null;

		listCode = sYhubService.routingHeaderItem_select(hubRVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
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
	
	/*@ResponseBody
	@RequestMapping(value = "/mes/select_medi_item", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String select_medi_item(@ModelAttribute SYProdVo pVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.select_medi_item() is called.");
		
		List<SYProdVo> list = new ArrayList<SYProdVo>();
		
		list = sYmesService.select_medi_item(pVo);
		System.out.println(list.toString());
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			System.out.println(listDataJArray.toJSONString());
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/

	/*@ResponseBody
	@RequestMapping(value = "/hub/routing_detail_select_w2ui", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routingDetail_select_w2ui(@ModelAttribute SYZmmfmMatMasterVo hubDVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routingDetail_select_w2ui() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser(); 
		List<SYZmmfmMatMasterVo> listCode = null;
		try {
			int curreCntPage = hubDVo.getPage(); 
			int rowCount = hubDVo.getRows(); 
			int rowTotal = sYhubService.routingDetail_select_count(hubDVo);
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
			if( curreCntPage > rowTotal ){
				hubDVo.setRows(rowCount-(curreCntPage-rowTotal));
			}
		    List<SYZmmfmMatMasterVo> list = sYhubService.routingDetail_select(hubDVo);
		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
		    listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
		    resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/

	/*@ResponseBody
	@RequestMapping(value = "/hub/routing_group_byItnbr_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routing_group_byItnbr_select(@ModelAttribute SYHubRoutingHeaderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routing_group_byItnbr_select() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser(); 
		try {
			List<SYHubRoutingHeaderVo> list = sYhubService.routing_group_byItnbr_select(vo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
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
	
	/*@ResponseBody
	@RequestMapping(value = "/hub/routing_detail_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routingDetail_select(@ModelAttribute SYZmmfmMatMasterVo hubDVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routingDetail_select() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		List<SYZmmfmMatMasterVo> listCode = null;
		try {
			int currentPage = Integer.parseInt(request.getParameter("page")); 
		    int pageRows = Integer.parseInt(request.getParameter("rows")); 
		    int startIndex = currentPage * pageRows - pageRows;
		    
		    hubDVo.setPage(startIndex);
		    hubDVo.setRows(pageRows);
		    
		    int totalRows = sYhubService.routingDetail_select_count(hubDVo);
		    
			listCode = sYhubService.routingDetail_select(hubDVo);
			resultData = ResponseUtils.getJQGridJsonResponse(response, listCode, currentPage, pageRows, totalRows);
//			JSONParser jsonParser = new JSONParser();
//			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
//			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
//			resultData.put("status", HttpStatus.OK.value());
//			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		
		return resultData.toJSONString();
	}*/
	
	@ResponseBody
	@RequestMapping(value = "/hub/routing_header_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routingHeader_insert(@ModelAttribute SYHubRoutingHeaderVo hubHVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routingHeader_insert() is called.");
		
		List<SYHubRoutingHeaderVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			hubHVo.setCreator(SessionUtil.getMemberId(request));
			hubHVo.setUpdater(SessionUtil.getMemberId(request));
			hubHVo.setRouting_gnm(request.getParameter("routing_gnm"));
			hubHVo.setDept_cd(request.getParameter("dept_cd"));
			hubHVo.setGridData(request.getParameter("gridData"));
			
			hubHVo.setRouting_gno_gubun(request.getParameter("routing_gno_gubun"));  //포장화면 추가에 따른 routing 양산 포장 구분자 추가 
			
			sYhubService.routingHeader_insert(hubHVo);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/hub/routing_headerItem_edit", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routing_headerItem_edit(@ModelAttribute SYHubRoutingHeaderVo hubHVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routing_headerItem_edit() is called.");
		
		List<SYHubRoutingHeaderVo> list = null;
		JSONObject resultData = new JSONObject();
		try {
//			String param = request.getParameter("gridData");
			
			String delData = request.getParameter("delData");
			String insData = request.getParameter("insData");
			String uptData = request.getParameter("uptData");
			hubHVo.setCreator(SessionUtil.getMemberId(request));
			hubHVo.setUpdater(SessionUtil.getMemberId(request));
//			hubHVo.setGridData(request.getParameter("gridData"));
			
			// delete
			if( !"[]".equals(delData) ) {
//				hubHVo.setGridData(delData);
				routingHeaderItem_delete(hubHVo, request, response, session);
			}
			// update
			if( !"[]".equals(uptData) ) {
				hubHVo.setGridData(uptData);
				sYhubService.routingHeaderItem_update(hubHVo);
			}
			// insert
			if( !"[]".equals(insData) ) {
				hubHVo.setGridData(insData);
				sYhubService.routingHeaderItem_insert(hubHVo);
			}
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/routing_headerItem_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routingHeaderItem_insert(@ModelAttribute SYHubRoutingHeaderVo hubHVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routingHeaderItem_insert() is called.");
		
		List<SYHubRoutingHeaderVo> list = null;
		JSONObject resultData = new JSONObject();
		try {
			String param = request.getParameter("gridData");
			
			hubHVo.setCreator(SessionUtil.getMemberId(request));
			hubHVo.setUpdater(SessionUtil.getMemberId(request));
			hubHVo.setGridData(request.getParameter("gridData"));
			
			sYhubService.routingHeaderItem_insert(hubHVo);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/routing_detail_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routingDetail_insert(@ModelAttribute SYHubRoutingDetailVo hubDVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routingDetail_insert() is called.");
		
		List<SYHubRoutingDetailVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			hubDVo.setCreator(SessionUtil.getMemberId(request));
			hubDVo.setUpdater(SessionUtil.getMemberId(request));
			hubDVo.setRouting_gno(request.getParameter("routing_gno"));
			hubDVo.setRouting_gno_gubun(request.getParameter("routing_gno_gubun"));
			hubDVo.setGridData(request.getParameter("gridData"));
			
			sYhubService.routingDetail_insert(hubDVo);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/routing_headerItem_count", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routingHeaderItem_count(@ModelAttribute SYHubRoutingHeaderVo hubHVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routingHeaderItem_count() is called.");
		
		List<SYHubRoutingHeaderVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			resultData.put("cnt", sYhubService.routingHeaderItem_count(hubHVo));
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/hub/routing_detailItem_count", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routingDetailItem_count(@ModelAttribute SYHubRoutingDetailVo hubDVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routingDetailItem_count() is called.");
		
		List<SYHubRoutingDetailVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			resultData.put("cnt", sYhubService.routingDetailItem_count(hubDVo));
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/hub/routing_headerGroup_delete", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routingHeaderGroup_delete(@ModelAttribute SYHubRoutingHeaderVo hubHVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routingHeaderGroup_delete() is called.");
		
		List<SYHubRoutingHeaderVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			resultData.put("result", sYhubService.routingHeaderGroup_delete(hubHVo)); 
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/routing_headerItem_delete", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routingHeaderItem_delete(@ModelAttribute SYHubRoutingHeaderVo hubHVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routingHeaderItem_delete() is called.");
		
		List<SYHubRoutingHeaderVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		String deletecheck = (request.getParameter("deletecheck")  == null)?"N":request.getParameter("deletecheck") ;
		try {
			int result = 0;
			String params = request.getParameter("params");
			listDataJArray = (JSONArray)jsonParser.parse(params);
			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				SYHubRoutingHeaderVo tmpVo = new SYHubRoutingHeaderVo();
				jObj = (JSONObject)listDataJArray.get(idx);
				tmpVo.setRouting_no(jObj.get("routing_no").toString());
				tmpVo.setRouting_gno(hubHVo.getRouting_gno());
				result += sYhubService.routingHeaderItem_delete(tmpVo);  // routing_header_master 삭제 처리
				
				System.out.println("deletecheck     "+deletecheck);
				
				if (deletecheck.trim().equals("Y")) {
					System.out.println("routingHeaderItem_delete_1 ################################    " );
					result += sYhubService.routingHeaderItem_delete_1(tmpVo); // routing_header_master 삭제 처리 RD57
				}
			}
			resultData.put("result", result); 
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}

	/*@ResponseBody
	@RequestMapping(value = "/hub/routing_detail_delete", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routingDetail_delete(@ModelAttribute SYHubRoutingDetailVo hubDVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routingDetail_delete() is called.");
		
		List<SYHubRoutingDetailVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			String[] itnbrArr = hubDVo.getItnbr().split(",");
			int resultCnt = 0;
			for(String itnbr : itnbrArr ) {
				SYHubRoutingDetailVo vo = new SYHubRoutingDetailVo();
				vo.setRouting_gno(hubDVo.getRouting_gno());
				vo.setItnbr(itnbr);
				resultCnt += sYhubService.routingDetail_delete(vo);
			}
			resultData.put("result", resultCnt); 
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	
	@ResponseBody
	@RequestMapping(value = "/scm/loadProc_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String loadProc_select(@ModelAttribute SYScmRawProcVo scmPVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.loadProc_select() is called.");
		
		List<SYScmRawProcVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONObject paramData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
//		String sap_return;
		try {
			String funcName = request.getParameter("funcName");
			paramData.put("datFrom", request.getParameter("jidat_from"));
			paramData.put("datTo", request.getParameter("jidat_to"));
			
			JSONObject rfcObj = sapMasterService.zmmfm_purch_ord_forProc(funcName,paramData);
			JSONObject rfcTbls = (JSONObject) rfcObj.get("rows");
			
			if( "S".equals( rfcTbls.get("EV_STATUS") ) ) {
//				JCoTable ekpo = (JCoTable) rfcTbls.get("ET_EKPO");
				list = sYscmService.rawProc_select(scmPVo);
				String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
				listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);

				resultData.put("status", HttpStatus.OK.value());
				resultData.put("rows", listDataJArray);
			} else {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("rows", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/scm/rawProcSub_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String loadProcSub_select(@ModelAttribute SYScmRawProcSubVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.loadProcSub_select() is called.");
		
		List<SYScmRawProcSubVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONObject paramData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		String sap_return;
		try {
			list = sYscmService.rawProcSub_select(sVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/vendor_result_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String vendor_result_select(@ModelAttribute SYScmRawVendorResultVo vVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.vendor_result_select() is called.");
		
		List<SYScmRawVendorResultVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONObject paramData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			list = sYscmService.rawVendor_select(vVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/scm/rawProc_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String rawProc_select(@ModelAttribute SYScmRawProcVo vVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.rawProc_select() is called.");
		
		List<SYScmRawProcVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONObject paramData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			list = sYscmService.rawProc_select(vVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/rawDelivery_partial_update", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String rawDelivery_partial_update(@ModelAttribute SYScmRawDeliveryVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.rawDelivery_partial_update() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		int result = 0;
		try {
			String partial_yn = request.getParameter("partial_yn");
			String ebeln = request.getParameter("ebeln");
			String ebelp = request.getParameter("ebelp");
			
			result = sYscmService.rawDelivery_partial_update(scmRVo);
			if( result>0 ){
				
			}
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/delivery_vendor_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deliveryVendor_select(@ModelAttribute SYScmRawDeliveryVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.deliveryVendor_select() is called.");
			    
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try {
			int currentPage = Integer.parseInt(request.getParameter("page")); 
		    int pageRows = Integer.parseInt(request.getParameter("rows")); 
		    int startIndex = currentPage * pageRows - pageRows;
		    
		    scmRVo.setPage(startIndex);
		    scmRVo.setRows(pageRows);

		    int totalRows = sYscmService.selectDeliveryVendorCount(scmRVo);
		    List<SYScmRawDeliveryVo> list = sYscmService.deliveryVendor_select(scmRVo);

			resultData = ResponseUtils.getJQGridJsonResponse(response, list, currentPage, pageRows, totalRows);
			System.out.println("resultData :::::::::::::::::::::: " + resultData);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/rawProc_sernr_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String rawProcSernr_select(@ModelAttribute SYScmRawProcSernrVo scmSVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.rawProcSernr_select() is called.");
		
		List<SYScmRawProcSernrVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			list = sYscmService.rawProcSernr_select(scmSVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/scm_sta_code_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String getStaCodeList_select(@ModelAttribute SYMesCodeVo codeVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.getStaCodeList_select() is called.");
		
		List<SYMesCodeVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			list = sYscmService.getStaCodeList_select(codeVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/scmProc_sernr_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String scmProcSernr_insert(@ModelAttribute SYScmRawProcSernrVo scmSVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.scmProcSernr_insert() is called.");
		
		List<SYScmRawProcSernrVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			scmSVo.setCreator(SessionUtil.getMemberId(request));
			scmSVo.setUpdater(SessionUtil.getMemberId(request));
//			scmSVo.setGridData(request.getParameter("gridData"));
			String gridData = request.getParameter("gridData");
			scmSVo.setB_werks(request.getParameter("werks"));
			scmSVo.setB_lager(request.getParameter("lgort"));

			listDataJArray = (JSONArray) jsonParser.parse(gridData);
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();

			int resultCnt = 0;
			List<SYScmRawProcSernrVo> vList = new ArrayList<SYScmRawProcSernrVo>();
			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				SYScmRawProcSernrVo sVo = new SYScmRawProcSernrVo();
				jObj = (JSONObject)listDataJArray.get(idx);
				sVo.setUse_yn("Y");
				sVo.setIf_status("-");
				sVo.setIf_msg("-");
				sVo.setUpdater(SessionUtil.getMemberId(request));
				sVo.setCreator(SessionUtil.getMemberId(request));
				sVo.setB_werks(request.getParameter("werks"));
				sVo.setB_lager(request.getParameter("lgort"));
//				sVo.setEbelp(scmSVo.getEbelp());
//				sVo.setPartial_seq(scmSVo.getPartial_seq());
				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue = ( jObj.get(nKey)==null )?"":jObj.get(nKey).toString();
					if( "ebeln".equals(nKey) ) sVo.setEbeln(nValue);
					if( "ebelp".equals(nKey) ) {
						if(sVo.getEbelp()==null || "".equals(sVo.getEbelp()) )
							sVo.setEbelp(nValue);
					}
					if( "matnr".equals(nKey) ) sVo.setMatnr(nValue);
					if( "txz01".equals(nKey) ) sVo.setTxz01(nValue);
					if( "partial_seq".equals(nKey) ) {
						if(sVo.getPartial_seq()==null || "".equals(sVo.getPartial_seq()) )
							sVo.setPartial_seq(nValue);
					}
					if( "zdeli_menge".equals(nKey) ) sVo.setZdeli_menge(nValue);
					if( "equnr".equals(nKey) ) sVo.setEqunr(nValue);
				}
				vList.add(sVo);
				SYScmRawProcSernrVo tmpVo = new SYScmRawProcSernrVo();
				tmpVo.setEbeln(sVo.getEbeln());
				tmpVo.setEbelp(sVo.getEbelp());
				tmpVo.setMatnr(sVo.getMatnr());
				tmpVo.setTxz01(sVo.getTxz01());
				tmpVo.setPartial_seq(sVo.getPartial_seq());
				sYscmService.rawProcSernr_delete(tmpVo);
			}
			for( SYScmRawProcSernrVo vo : vList ) {
				resultCnt = sYscmService.scmProcSernr_insert(vo);
			}
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/scm/scm_raw_delivery_update", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String scmRawDelivery_update(@ModelAttribute SYScmRawDeliveryVo scmSVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.scmRawDelivery_update() is called.");
		
		List<SYScmRawSernrVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			scmSVo.setUpdater(SessionUtil.getMemberId(request));
			sYscmService.scmRawDelivery_update(scmSVo);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/scm_delivery_diff_update", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String scmRawDeliveryDiff_update(@ModelAttribute SYScmRawDeliveryVo scmSVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.scmRawDeliveryDiff_update() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			scmSVo.setUpdater(SessionUtil.getMemberId(request));
			sYscmService.scmRawDeliveryDiff_update(scmSVo);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/delivery_status_update", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deliverySta_update(@ModelAttribute SYScmRawDeliveryVo scmDVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.deliverySta_update() is called.");
		
		List<SYScmRawSernrVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			scmDVo.setUpdater(SessionUtil.getMemberId(request));
			
			sYscmService.deliverySta_update(scmDVo);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	

	@ResponseBody
	@RequestMapping(value = "/scm/vendor_status_update", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String vendorSta_update(@ModelAttribute SYScmRawVendorResultVo scmDVo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.vendorSta_update() is called.");
		
		List<SYScmRawSernrVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			sYscmService.rawVendorResultSta_update(scmDVo);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	/*@ResponseBody
	@RequestMapping(value = "/mes/selectProdOrderGroup", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProdOrderGroup(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProdOrderGroup() is called.");
		
		List<SYProdVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			list = sYmesService.selectProdOrderGroup(prodVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
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

	@ResponseBody
	@RequestMapping(value = "/mes/selectProdOrdUserIng_opt", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProdOrdUserIng_opt(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProdOrdUserIng_opt() is called.");
		
		List<SYProdVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			list = sYmesService.selectProdOrdUserIng_opt(prodVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/mes/selectProdOrdUserIng", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProdOrdUserIng(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProdOrdUserIng() is called.");
		
		List<SYProdVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			list = sYmesService.selectProdOrdUserIng(prodVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}

	/*@ResponseBody
	@RequestMapping(value = "/hub/material_recv_master_select_w2ui", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_recv_master_select_w2ui(@ModelAttribute SYZmmfmMatMasterVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.material_recv_master_select_w2ui() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			int curreCntPage = sVo.getPage(); 
			int rowCount = sVo.getRows();
			int rowTotal = sYhubService.material_recv_master_select_count(sVo);
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
			if( curreCntPage > rowTotal ){
				sVo.setRows(rowCount-(curreCntPage-rowTotal));
			}

			List<SYZmmfmMatMasterVo> list = sYhubService.material_recv_master_select(sVo);
		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	
	/*@ResponseBody
	@RequestMapping(value = "/hub/material_recv_master_select_nopage", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_recv_master_select_nopage(@ModelAttribute SYZmmfmMatMasterVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.material_recv_master_select_nopage() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			String matnrs = request.getParameter("matnrs");
			System.out.println("@@@@@@@@@@@@@@@@@@@@@");
			System.out.println(matnrs);
			if(matnrs != null && StringUtil.trim(matnrs).length() > 0){
				String[] arr_matnr = matnrs.split(",");
				if(arr_matnr.length > 0){
					ArrayList<String> list = new ArrayList<>();
					list.clear();
					for (String p_matnr : arr_matnr) {
						list.add(p_matnr);
					}
					sVo.setMatnrList(list);
				}
			}
			List<SYZmmfmMatMasterVo> dataList = sYhubService.material_recv_master_select_nopage(sVo);
				 
			String listDataJsonString = ResponseUtils.getJsonResponse(response, dataList);
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

	@ResponseBody
	@RequestMapping(value = "/hub/selectVendortbl", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectVendortbl(@ModelAttribute SYVendorVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectVendortbl() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
//			String lifnr = URLDecoder.decode(request.getParameter("LIFNR"), "UTF-8" );
			
			List<SYVendorVo> dataList = sYhubService.selectVendortbl(sVo);
			 
			String listDataJsonString = ResponseUtils.getJsonResponse(response, dataList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
/*	@ResponseBody
	@RequestMapping(value = "/hub/selectVendortbl", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectVendortbl(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectVendortbl() is called.");
		String func_name = request.getParameter("func_name");
		String iv_fdate = request.getParameter("I_FDATE");	 
		String iv_tdate = request.getParameter("I_TDATE");	 
		String name1 = request.getParameter("NAME1");	
		String lifnr = URLDecoder.decode(request.getParameter("LIFNR"), "UTF-8" );
		
//		System.out.println("iv_fdate = " + iv_fdate + " / iv_tdate = " + iv_tdate);
		
		//sYprodService.insertSapProdOrd();
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			String func_name = request.getParameter("func_name");
			String iv_fdate = request.getParameter("I_FDATE");	 
			String iv_tdate = request.getParameter("I_TDATE");	 
			String name1 = request.getParameter("NAME1");	
			String lifnr = URLDecoder.decode(request.getParameter("LIFNR"), "UTF-8" );
			System.out.println("iv_fdate = " + iv_fdate + " / iv_tdate = " + iv_tdate);
			
			List<SYVendorVo> dataList = sYhubService.selectVendortbl(func_name,iv_fdate,iv_tdate,lifnr,name1);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, dataList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
*/	
	@ResponseBody
	@RequestMapping(value = "/hub/saveVendor", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveVendortbl(@ModelAttribute SYVendorVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.saveVendor() is called.");

		JSONObject resultData = new JSONObject();
//		JSONArray listDataJArray = new JSONArray();
//		JSONParser jsonParser = new JSONParser();
		try {
//			String lifnr = URLDecoder.decode(request.getParameter("LIFNR"), "UTF-8" );
			// insert or update
			String flag = request.getParameter("flag");
			int result = 0;
			
			sVo.setCreater(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));
			System.out.println(flag);
			System.out.println(sVo.toString());
			
			if( "I".equals(flag) ) {
				// insert
				result = sYhubService.insertVendor(sVo);
			} else if( "U".equals(flag) ) {
				// update
				result = sYhubService.updateVendor(sVo);
			}
			
//			List<SYVendorVo> dataList = sYhubService.selectVendortbl(sVo);
			 
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/deleteVendor", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteVendortbl(@ModelAttribute SYVendorVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deleteVendor() is called.");
		
		JSONObject resultData = new JSONObject();
		try {
			int result = 0;
			
			System.out.println(sVo.getCodeList());
			
			result = sYhubService.deleteVendor(sVo);
			
//			List<SYVendorVo> dataList = sYhubService.selectVendortbl(sVo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/selectBomtbl", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectBomtbl(@ModelAttribute SYHubBomVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectBomtbl() is called.");

		String matnr = request.getParameter("IV_MATNR");	 
		String iv_date = request.getParameter("IV_DATE");	 
		String werks = request.getParameter("IV_WERKS");	 
	 
		System.out.println("iv_date = " + iv_date);

		// sYprodService.insertSapProdOrd();
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			String func_name = "";
			int rowTotal = sYhubService.selectBomtbl_count(sVo);
			int curreCntPage = sVo.getPage(); 
			int rowCount = sVo.getRows();
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
//			if( rowCount*(curreCntPage+1) > rowTotal ){
//				sVo.setRows((rowCount*(curreCntPage+1))-rowTotal);
//			}
			if( curreCntPage > rowTotal ){
				sVo.setRows(rowCount-(curreCntPage-rowTotal));
			}
			List<SYHubBomVo> dataList = sYhubService.selectBomtbl(sVo);
			 
			String listDataJsonString = ResponseUtils.getJsonResponse(response, dataList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/mes/reqm_matnr_tbl_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String reqm_matnr_tbl_insert(@ModelAttribute SYReqmMatnrTblVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.reqm_matnr_tbl_insert() is called.");
		
		List<SYReqmMatnrTblVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));

			sVo.setReqm_matnr_tbl_data(request.getParameter("reqm_matnr_tbl_data"));
			sVo.setReqd_matnr_tbl_data(request.getParameter("reqd_matnr_tbl_data"));
			sVo.setPgm_nm(request.getParameter("pgm_nm"));
			
			sYmesService.reqm_matnr_tbl_insert(sVo);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/stk_request_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String stk_request_insert(@ModelAttribute SYReqmMatnrTblVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.stk_request_insert() is called.");
		
		List<SYReqmMatnrTblVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));

			sVo.setJsonStr(request.getParameter("jsonStr"));
			
			sYscmService.stk_request_insert(sVo);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/departOrder", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String departOrder(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.departOrder() is called.");
		
//		JSONArray clistDataArray = new JSONArray();
		JSONObject cDataObj = new JSONObject();
		JSONParser jsonParser = new JSONParser();
		SYScmRawDeliveryVo dVo = new SYScmRawDeliveryVo();
		JSONObject resultData = new JSONObject();
		
		List<SYScmRawVendorResultVo> vVoList = new ArrayList<SYScmRawVendorResultVo>();
		try {
			String momGridData = request.getParameter("momGridData");
			String chiData = request.getParameter("chiData");
			JSONObject momData = new JSONObject();
			momData = (JSONObject) jsonParser.parse(momGridData);
			
			SYScmRawDeliveryVo tmpVo = new SYScmRawDeliveryVo();
			tmpVo.setEbeln(momData.get("ebeln").toString());
			tmpVo.setEbelp(momData.get("ebelp").toString());
			tmpVo.setItem_seq(momData.get("item_seq").toString());
			List<SYScmRawDeliveryVo> momList = sYscmService.rawDelivery_selectByKey(tmpVo);
			dVo = momList.get(0);
			
//			dVo.setEindt(momData.get("eindt").toString());
//			dVo.setEbeln(momData.get("ebeln").toString());
//			dVo.setWerks(momData.get("werks").toString()); 
//			dVo.setZdeli_menge(momData.get("zdeli_menge").toString());
//			dVo.setRvendor_status(momData.get("rvendor_status").toString());
//			dVo.setBukrs(momData.get("bukrs").toString());
//			dVo.setTxz01(momData.get("txz01").toString());
//			dVo.setDiff_date(momData.get("diff_date").toString());
//			dVo.setMatnr(momData.get("matnr").toString());
//			dVo.setEbelp(momData.get("ebelp").toString());
//			dVo.setRorder_status(momData.get("rorder_status").toString());
			dVo.setOrder_delivery_date(momData.get("order_delivery_date").toString());
//			dVo.setVendor_delivery_date(momData.get("vendor_delivery_date").toString());
//			dVo.setMenge(momData.get("menge").toString());
//			dVo.setLgort(momData.get("lgort").toString());
			
			dVo.setUpdater(SessionUtil.getMemberId(request));
			
			cDataObj = (JSONObject)jsonParser.parse(chiData);
			if( !cDataObj.isEmpty() )
				dVo.setPartial_yn("Y");
			
			// update raw_delivery_tbl update diff_date='Y', partial_yn='Y'
			sYscmService.rawDeliverySta_update(dVo);
			
//			String eindt = momData.get("eindt").toString();
			String eindt = dVo.getEindt();
//			System.out.println(clistDataArray.size());
//			for(int idx=0; idx<clistDataArray.size() ; idx++){
				SYScmRawVendorResultVo vVo = new SYScmRawVendorResultVo(); 
//				JSONObject tmpObj = (JSONObject)clistDataArray.get(idx);
				//(ebeln, ebelp, matnr, rorder_status, rvendor_status, menge, zdeli_menge, werks, bukrs, diff_date)
				vVo.setEbeln(dVo.getEbeln());
				vVo.setEbelp(dVo.getEbelp());
				vVo.setMatnr(dVo.getMatnr());
				vVo.setRorder_status(dVo.getRorder_status());
				vVo.setRvendor_status(dVo.getRvendor_status());
				vVo.setMenge(dVo.getMenge());
				vVo.setZdeli_menge(cDataObj.get("qty").toString());
				vVo.setWerks(dVo.getWerks());
				vVo.setBukrs(dVo.getBukrs());
				vVo.setVendor_delivery_date(cDataObj.get("date").toString());
				vVo.setOrder_delivery_date(dVo.getOrder_delivery_date());
				vVo.setConfirm_date(dVo.getOrder_delivery_date());
				vVo.setLgort(dVo.getLgort());
				vVo.setLifnr(dVo.getLifnr());
				String diff_date = "Y";
				if( eindt.equals(cDataObj.get("date").toString()) ) {
					diff_date = "N";
				} else {
					
				}
				vVo.setDiff_date(diff_date);
				vVoList.add(vVo);
//			}
			if ( "".equals(cDataObj.get("level").toString()) ) {	// new
				sYscmService.rawVendorResult_insert(vVo);
			} else {	// update
				vVo.setPartial_seq(cDataObj.get("partial_seq").toString());
				sYscmService.rawVendorResultSta_update(vVo);
			}
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", null);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
			
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/hub/data_customer_member_grid", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String customerMemberGridData(@ModelAttribute SYMemberVo syMemberVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CustomerController.customerMemberGridData() is called.");
		JSONObject resultData = new JSONObject();
		try {
			int currentPage = Integer.parseInt(request.getParameter("page")); 
	    int pageRows = Integer.parseInt(request.getParameter("rows")); 
	    int startIndex = currentPage * pageRows - pageRows; 
	    
	    syMemberVo.setPage(startIndex);
	    syMemberVo.setRows(pageRows);
	  //  syMemberVo.setLang(SessionUtil.getMemberLang(request));
	    
	    int totalRows = sYhubService.selectCustomerMemberCount(syMemberVo);
	    List<SYMemberVo> listCustomerMember = sYhubService.selectCustomerMember(syMemberVo);
	    resultData = ResponseUtils.getJQGridJsonResponse(response, listCustomerMember, currentPage, pageRows, totalRows);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
	    resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/data_customer_member_detail", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public JSONObject customerMemberDetailData(@ModelAttribute SYMemberVo custMemberVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CustomerController.customerMemberDetailData() is called.");
		JSONObject resultData = new JSONObject();
		try {
			custMemberVo.setLang(SessionUtil.getMemberLang(request));
			SYMemberVo resultCustMemberVo = sYhubService.selectCustomerMemberInfo(custMemberVo);
			resultData.put("result", "success");
			resultData.put("data", resultCustMemberVo);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return resultData;
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/confirmSchedule_proc", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String confirmSchedule_proc(@ModelAttribute SYScmRawProcVo pVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.confirmSchedule_proc() is called.");
		
		List<SYScmRawProcVo> uniqueKeylist = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		SYScmRawProcVo dVo = new SYScmRawProcVo();
		SYScmRawCommentVo cVo = new SYScmRawCommentVo(); 
		
		try {
			String jidat_from = request.getParameter("jidat_from");
			String jidat_to = request.getParameter("jidat_to");
			
			String rOrderStatus = pVo.getRorder_status();
			String rVendorStatus = pVo.getRvendor_status();
			
			String gridString = request.getParameter("gridData");
			listDataJArray = (JSONArray)jsonParser.parse(gridString);
			JSONObject tmpJsonObj = new JSONObject();
			// update confirmDate
			Object[] keyArr = ((JSONObject)listDataJArray.get(0)).keySet().toArray();
			List<SYScmRawProcVo> sapList = new ArrayList<SYScmRawProcVo>();
			for(int idx=0; idx<listDataJArray.size(); idx++ ) {
				JSONObject jObj = new JSONObject();
				SYScmRawProcVo tmpVo = new SYScmRawProcVo();
				jObj = (JSONObject) listDataJArray.get(idx);
				tmpVo.setConfirm_yn("Y");
				for (Object key : keyArr) {
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					if ("ebeln".equals(nKey)) {
						tmpVo.setEbeln(nValue);
					} else if ("partial_seq".equals(nKey))
						tmpVo.setPartial_seq(nValue);
					else if ("ebelp".equals(nKey))
						tmpVo.setEbelp(nValue);
					else if ("eindt".equals(nKey))
						tmpVo.setEindt(nValue);
					else if ("order_delivery_date".equals(nKey))
						tmpVo.setOrder_delivery_date(nValue);
					else if ("vendor_delivery_date".equals(nKey)) {
//						System.out.println(nKey);
//						System.out.println(nValue);
						if( !"".equals(nValue) ) {
							tmpVo.setVendor_delivery_date(nValue);
							tmpVo.setOrder_delivery_date(nValue);
							tmpVo.setConfirm_date(nValue);
						}
					}
				}
				if( !("".equals(rVendorStatus)) )
					tmpVo.setRvendor_status(rVendorStatus);
				tmpVo.setDiff_date("N");
				tmpVo.setRorder_status(rOrderStatus);
				sapList.add(tmpVo);
			}
			
			System.out.println(sapList.toString());
			
			for( SYScmRawProcVo vo : sapList ) {
				sYscmService.rawProcSta_update(vo);
			}
//			System.out.println(" uniqueKeylist -->");
//			System.out.println(uniqueKeylist.toString());
			// 해당 po데이터 가져온다. r4제외
			String ebeln = sapList.get(0).getEbeln();
			List<SYScmRawProcVo> allList = sYscmService.rawProcConfirm_select(ebeln);

			// make labnr list
			JSONArray ebelnArr = new JSONArray();
			ebelnArr.add(sapList.get(0).getEbeln());
			uniqueKeylist = sYscmService.getProcUniqueKeyList(ebelnArr);	//labnr
//			List<SYScmRawProcVo> rfcSendList = new ArrayList<SYScmRawProcVo>();
			for(int idx=0; idx<allList.size(); idx++ ) {
				SYScmRawProcVo tmpVo = (SYScmRawProcVo)allList.get(idx); 
				for( SYScmRawProcVo itemVo : uniqueKeylist ) {
					String header = (itemVo.getUnikey()).substring(0, 16);
					String tail = (itemVo.getUnikey()).substring(18, 20);
					String seq = String.format("%02d", Integer.parseInt(tmpVo.getKey_cnt()));
					String uniKey = header + seq + tail;
					
					String partial_check = itemVo.getPartial_seq();
					
					if( (itemVo.getEbeln()).equals(tmpVo.getEbeln()) && 
							(itemVo.getEbelp()).equals(tmpVo.getEbelp()) && 
							(itemVo.getPartial_seq()).equals(tmpVo.getPartial_seq()) ) {
						tmpVo.setLabnr(uniKey);
						tmpVo.setKey_cnt( (Integer.parseInt(tmpVo.getKey_cnt())+1)+"" );
						
						if ("0001".equals(partial_check)) {
							tmpVo.setZflag("C");
						} else {
							tmpVo.setZflag("I");   
						}
						itemVo.setLabnr(uniKey);
					}
				}
			}
			
			List<SYScmRawProcVo> sendRFC = new ArrayList<SYScmRawProcVo>();
			for(SYScmRawProcVo vo : allList ) {
				if( "r1".equals(vo.getRorder_status()) || "r3".equals(vo.getRorder_status()) )  {
//				if( "r1".equals(vo.getRorder_status()) || ( "r3".equals(vo.getRorder_status()) && "Y".equals(vo.getPartial_yn()) ) )  {
					vo.setLabnr_1(vo.getLabnr());
					if( "".equals(vo.getVendor_delivery_date()) || vo.getVendor_delivery_date()==null ) {
						vo.setVendor_delivery_date(vo.getEindt());
						vo.setOrder_delivery_date(vo.getEindt());
						vo.setConfirm_date(vo.getEindt());
					}
					sendRFC.add(vo);
				}
			}
			
			System.out.println(sendRFC.toString());
			// execute RFC
			String funcName = "ZMMFM_PO_SCHEDULE";
			JSONObject sapResult = sapMasterService.zmmfm_po_schedule_proc(funcName, sendRFC);
			String result = ((JSONObject)sapResult.get("rows")).get("EV_STATUS").toString();
			if( "S".equals(result) ){
				for(SYScmRawProcVo itemVo : allList){
					// r3 : 정상
					if( "r3".equals(rOrderStatus) ){
						itemVo.setDiff_date("N");
						itemVo.setRorder_status(rOrderStatus);
						itemVo.setRvendor_status("v2");
						if( "V001".equals(itemVo.getSernp()) ) {
							sYscmService.rawProcSernr_update(itemVo);	// update serial
						}
						//간헐적 confirm_Date가 없어서 분할 seq update가 안되는부분수정 3/19일 시작
						if( "".equals(itemVo.getVendor_delivery_date()) || itemVo.getVendor_delivery_date()==null ) {
							itemVo.setVendor_delivery_date(itemVo.getEindt());
							itemVo.setOrder_delivery_date(itemVo.getEindt());
							itemVo.setConfirm_date(itemVo.getEindt());
						}
						
						
						if( "".equals(itemVo.getConfirm_date()) || itemVo.getConfirm_date()==null ) {
							itemVo.setOrder_delivery_date(itemVo.getVendor_delivery_date());
							itemVo.setConfirm_date(itemVo.getVendor_delivery_date());
						}
						//간헐적 confirm_Date가 없어서 분할 seq update가 안되는부분수정 3/19일  끝
						
						itemVo.setUpdater(SessionUtil.getMemberId(request));
//						System.out.println(itemVo.getLabnr_1());
						sYscmService.rawProcSta_update(itemVo);
					} else if ("r2".equals(rOrderStatus)) {
						// 보류
						cVo.setEbeln(itemVo.getEbeln());
						cVo.setEbelp(itemVo.getEbelp());
						cVo.setPartial_seq(itemVo.getPartial_seq());
						cVo.setOrder_delivery_date(itemVo.getOrder_delivery_date());
						cVo.setVendor_delivery_date(itemVo.getVendor_delivery_date());
						cVo.setComment(request.getParameter("comment"));
						sYscmService.raw_comment_insert(cVo);
						itemVo.setRorder_status(rOrderStatus);
						itemVo.setRvendor_status(rVendorStatus);
						sYscmService.rawProcSta_update(itemVo);
	//						System.out.println(dVo.toString());
	//						sYscmService.deliverySta_update(dVo);
					}
				}
				SYScmRawProcVo tVo = new SYScmRawProcVo();
				tVo.setEbeln(allList.get(0).getEbeln());
				tVo.setKey_cnt(sYscmService.getMaxKeYCnt(allList.get(0).getEbeln()));
				sYscmService.rawProcKeyCnt_update(tVo);
				
				JSONObject paramObj = new JSONObject();
				paramObj.put("datFrom", jidat_from);
				paramObj.put("datTo", jidat_to);
				JSONObject rfcObj = sapMasterService.zmmfm_purch_ord_forProc("ZMMFM_PURCH_ORD", paramObj);
			}
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	/*@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/prod/prod_end_chk", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String prod_end_chk(@ModelAttribute SYProdVo pordVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.prod_end_chk() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		String result = null;
		String routing_no = request.getParameter("routing_no");
		result =sYprodService.prod_end_chk(routing_no);
		

		try{
//			JSONParser jsonParser = new JSONParser();
//			String listDataJsonString = ResponseUtils.getJsonResponse(response,
//					listCode);
//			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("result", result);
			resultData.put("status", HttpStatus.OK.value());
//			resultData.put("rows", listDataJArray);

		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
 
	@ResponseBody
	@RequestMapping(value = "/scm/matnr_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String matnr_select(@ModelAttribute SYReqmMatnrTblVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.matnr_select() is called.");
		
		List<SYReqmMatnrTblVo> listCode = null;
		
		JSONObject resultData = new JSONObject();
		
		int currentPage = Integer.parseInt(request.getParameter("page")); 
	    int pageRows = Integer.parseInt(request.getParameter("rows")); 
	    int startIndex = currentPage * pageRows - pageRows; 

	    String matnr = request.getParameter("matnr");
		String werks = request.getParameter("werks");
		String maktx = request.getParameter("maktx");
		String wrkst = request.getParameter("wrkst");
		
		sVo.setPage(startIndex);
		sVo.setRows(pageRows);
		
		sVo.setMatnr(matnr);
		sVo.setWerks(werks);
		sVo.setMaktx(maktx);
		sVo.setWrkst(wrkst);
		
		int totalRows = sYscmService.matnr_select_count(sVo);
		listCode = sYscmService.matnr_select(sVo);

		try {
			resultData = ResponseUtils.getJQGridJsonResponse(response, listCode, currentPage, pageRows, totalRows);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/scm/str_stock_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String str_stock_select(@ModelAttribute SYStockVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.str_stock_select() is called.");
		
		List<SYProdVo> listCode = null;

		//SAP와 재고 sync
		SYStockVo pVo = new SYStockVo();
		pVo.setMatnr(sVo.getMatnr());
		pVo.setLgort(sVo.getLgort());
		pVo.setWerks(sVo.getWerks());

		sYscmService.str_stock_header_delete(pVo);
		sYscmService.str_stock_detail_delete(pVo);
		
		sYshipService.zmmfm_sloc_stock(pVo,  "ZMMFM_SLOC_STOCK");
		
		listCode = sYscmService.str_stock_select(sVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/req_matnr_ord_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String req_matnr_ord_select(@ModelAttribute SYReqmMatnrTblVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.req_matnr_ord_select() is called.");
		
		List<SYReqmMatnrTblVo> listCode = null;
		
		JSONObject resultData = new JSONObject();
		
		int currentPage = Integer.parseInt(request.getParameter("page")); 
	    int pageRows = Integer.parseInt(request.getParameter("rows")); 
	    int startIndex = currentPage * pageRows - pageRows; 

	    String fromDate = request.getParameter("from");
		String toDate = request.getParameter("to");
		String plant = request.getParameter("plant");
		sVo.setPage(startIndex);
		sVo.setRows(pageRows);
		sVo.setPlant(plant);
		sVo.setFrom_req_date(fromDate);
		sVo.setTo_req_date(toDate);
		
		int totalRows = sYscmService.req_matnr_ord_select_count(sVo);
		listCode = sYscmService.req_matnr_ord_select(sVo);

		try {
			resultData = ResponseUtils.getJQGridJsonResponse(response, listCode, currentPage, pageRows, totalRows);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/req_matnr_ord_select_nopage", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String req_matnr_ord_select_nopage(@ModelAttribute SYReqmMatnrTblVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.req_matnr_ord_select_nopage() is called.");
	
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		List<SYReqmMatnrTblVo> listCode = null;

		try {
			listCode = sYscmService.req_matnr_ord_select_nopage(sVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response,listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/scm_sloc_code_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String scm_sloc_code_select(@ModelAttribute SYSlocMasterVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.scm_sloc_code_select() is called.");
		
		List<SYSlocMasterVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		String werks = request.getParameter("werks");
		
		sVo.setWerks(werks);
		
		try {
			list = sYscmService.scm_sloc_code_select(sVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/mes_stock_tbl_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String mes_stock_tbl_select(@ModelAttribute SYSlocMasterVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.mes_stock_tbl_select() is called.");
		
		List<SYSlocMasterVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		String werks = request.getParameter("werks");
		
		sVo.setWerks(werks);
		
		try {
			list = sYscmService.mes_stock_tbl_select(sVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/rinspection_header_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String inspection_header_select(@ModelAttribute SYHubRecvinspeVo hubRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.rinspection_header_select() is called.");
		
		List<SYHubRecvinspeVo> listCode = null;
		
		listCode = sYhubService.rinspectionheader_select(hubRVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		
		return resultData.toJSONString();
	}


	@ResponseBody
	@RequestMapping(value = "/hub/rinspection_header_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String rinspection_header_insert(@ModelAttribute SYHubRecvinspeVo hubHVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.inspection_header_insert() is called.");
		
		List<SYHubRoutingHeaderVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
	 
	 
		try {
			hubHVo.setCreator(SessionUtil.getMemberId(request));
			hubHVo.setUpdater(SessionUtil.getMemberId(request));
			hubHVo.setDept_cd(request.getParameter("dept_cd"));
			hubHVo.setGridData(request.getParameter("gridData"));

			sYhubService.rinspectionHeader_insert(hubHVo);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/hub/rinspection_detailItem_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String InspectionHeaderItem_select(@ModelAttribute SYHubRecvinspeVo hubRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.Inspection_headerItem_select() is called.");
		
		List<SYHubRecvinspeVo> listCode = null;
		
//		listCode = sYhubService.routingHeaderItem_select(hubRVo);
		
		listCode = sYhubService.rinspectionItem_select(hubRVo);
		
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/hub/rinpsection_detailItem_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String rinpsectionHeaderItem_insert(@ModelAttribute SYHubRecvinspeVo hubHVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.rinpsection_detailItem_insert() is called.");
		
		List<SYHubRecvinspeVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			
			hubHVo.setCreator(SessionUtil.getMemberId(request));
			hubHVo.setUpdater(SessionUtil.getMemberId(request));
			hubHVo.setInspection_gcode(request.getParameter("inspection_gcode"));
			hubHVo.setDept_cd(request.getParameter("dept_cd"));
			hubHVo.setDate_created(request.getParameter("date_created"));
			hubHVo.setGridData(request.getParameter("gridData"));
			
//			sYhubService.routingHeaderItem_insert(hubHVo);
			sYhubService.rinpsectionDetailItem_insert(hubHVo);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/hub/inspection_matnr_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String inspection_matnr_insert(@ModelAttribute SYHubRecvinspeVo hubDVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.inspection_matnr_insert() is called.");
		
		List<SYHubRecvinspeVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			hubDVo.setCreator(SessionUtil.getMemberId(request));
			hubDVo.setUpdater(SessionUtil.getMemberId(request));
			hubDVo.setInspection_gcode(request.getParameter("inspection_gcode"));
			hubDVo.setGridData(request.getParameter("gridData"));
			hubDVo.setDept_cd(request.getParameter("dept_cd"));
			
		//	sYhubService.routingDetail_insert(hubDVo);
			
			sYhubService.rinspection_matnr_insert(hubDVo);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	 
	@ResponseBody
	@RequestMapping(value = "/hub/rinspection_matnr_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String rinspection_matnr_select(@ModelAttribute SYHubRecvinspeVo hubDVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.rinspection_matnr_select() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		List<SYHubRecvinspeVo> listCode = null;
		try {
			int currentPage = Integer.parseInt(request.getParameter("page")); 
		    int pageRows = Integer.parseInt(request.getParameter("rows")); 
		    int startIndex = currentPage * pageRows - pageRows;
		    
		    hubDVo.setPage(startIndex);
		    hubDVo.setRows(pageRows);
		    
		    int totalRows = sYhubService.searchInspectionMatnr_count(hubDVo);
		    
			listCode = sYhubService.searchInspectionMatnr(hubDVo);
			resultData = ResponseUtils.getJQGridJsonResponse(response, listCode, currentPage, pageRows, totalRows);
//			JSONParser jsonParser = new JSONParser();
//			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
//			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
//			resultData.put("status", HttpStatus.OK.value());
//			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/rinspection_detailItem_delete", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String rinspection_detailItem_delete(@ModelAttribute SYHubRecvinspeVo hubHVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routingHeaderItem_delete() is called.");
		
		List<SYHubRecvinspeVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			resultData.put("result", sYhubService.rinspection_DetailItem_delete(hubHVo)); 
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}


	@ResponseBody
	@RequestMapping(value = "/hub/rinspection_matnr_delete", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String rinspection_matnr_delete(@ModelAttribute SYHubRecvinspeVo hubDVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.rinspection_matnr_delete() is called.");
		
		List<SYHubRecvinspeVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			resultData.put("result", sYhubService.rinspection_matnr_delete(hubDVo)); 
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
/*
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/prod/wkctr_code_select", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String wkctr_code_select(@ModelAttribute SYProdVo pordVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.wkctr_code_select() is called.");
		
		List<SYProdVo> listCode = null;
		String werks = request.getParameter("werks");
		listCode =sYprodService.wkctr_code_select(werks);
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		try{
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);

		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	*/
	
	@ResponseBody
	@RequestMapping(value = "/qm/inspection_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String inspection_select(@ModelAttribute SYQmVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.inspection_select() is called.");
		
		List<SYQmVo> listCode = null;
		
		JSONObject resultData = new JSONObject();
		
		String gubun = request.getParameter("gubun");

		int currentPage = Integer.parseInt(request.getParameter("page")); 
	    int pageRows = Integer.parseInt(request.getParameter("rows")); 
	    int startIndex = currentPage * pageRows - pageRows; 
	    int totalRows = 0;
	    
		sVo.setPage(startIndex);
		sVo.setRows(pageRows);
		
		if(gubun.equals("L")) {
			totalRows = sYqmService.last_inspection_select_count(sVo);
			listCode = sYqmService.last_inspection_select(sVo);
		} else {
			totalRows = sYqmService.ship_inspection_select_count(sVo);
			listCode = sYqmService.ship_inspection_select(sVo);
		}
		
		try {
			resultData = ResponseUtils.getJQGridJsonResponse(response, listCode, currentPage, pageRows, totalRows);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		
		return resultData.toJSONString();
	}
	
	/*@ResponseBody
	@RequestMapping(value = "/prod/lastInspec_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String lastInspec_insert(@ModelAttribute SYProdVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.lastInspec_insert() is called.");
		
		List<SYProdVo> list = null;
		int result =0;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));


			sVo.setPdsts("p8");
			result = sYprodService.prodTbl_pdsts_update(sVo);
			
			result = sYprodService.lastInspec_insert(sVo);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	
	/*@ResponseBody
	@RequestMapping(value = "/qm/inspection_process", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String inspection_process(@ModelAttribute SYQmVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.inspection_process() is called.");
		
		List<SYReqmMatnrTblVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		String gridData = request.getParameter("gridData");					
		String conf_date = request.getParameter("conf_date");
		String plant = request.getParameter("plant");	
		String stge_loc = request.getParameter("stge_loc");	
		String move_plant = request.getParameter("move_plant");	
		String move_stloc = request.getParameter("move_stloc");	
		
		String pdsts = request.getParameter("pdsts");
		String gubun	= request.getParameter("gubun");
		
		sVo.setGridData(gridData);
		sVo.setConf_date(conf_date);
		sVo.setPlant(plant);
		sVo.setStge_loc(stge_loc);
		sVo.setMove_plant(move_plant);
		sVo.setMove_stloc(move_stloc);
		sVo.setPdsts(pdsts);
		
		if(gubun.equals("Y")) {
			try {
				sVo.setCreator(SessionUtil.getMemberId(request));
				sVo.setUpdater(SessionUtil.getMemberId(request));
				
				*//*******************rfc 로 요청승인 된 내역 전송 : Start*******************//*
				resultData = sapMasterService.zmmfm_goodsmvt_st("ZMMFM_GOODSMVT_ST", sVo);
	
				Object ev_ref_doc_no = resultData.get("ev_ref_doc_no");
				Object ev_mblnr = resultData.get("ev_mblnr");
				Object ev_mjahr = resultData.get("ev_mjahr");
				
				Object e_return = resultData.get("e_return");
				Object e_message = resultData.get("e_message");
				
				resultData.put("e_return", e_return);
				resultData.put("e_message", e_message);
				*//*******************rfc 로 요청승인 된 내역 전송 : End*******************//*			
				
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@");
				System.out.println("gubun : " + gubun);
				System.out.println("e_return : " + e_return);
				
				System.out.println("ev_ref_doc_no : " + ev_ref_doc_no.toString());
				System.out.println("ev_mblnr : " + ev_mblnr.toString());
				System.out.println("ev_mjahr : " + ev_mjahr.toString());
				
				if(e_return.toString().equals("S")) {				
					sVo.setSudat(conf_date);
					sVo.setRef_doc_no(ev_ref_doc_no.toString());				
					sVo.setMblnr(ev_mblnr.toString());
					sVo.setMjahr(ev_mjahr.toString());
		
					sYqmService.inspection_process(sVo);	//최종검사 테이블 업데이트 
				}
				
				resultData.put("status", HttpStatus.OK.value());
				
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("rows", null);
			}
		} else {
			try {
				sVo.setCreator(SessionUtil.getMemberId(request));
				sVo.setUpdater(SessionUtil.getMemberId(request));
				sVo.setSudat(conf_date);
				
				sYqmService.inspection_process(sVo);	//최종검사 테이블 업데이트 

				resultData.put("status", HttpStatus.OK.value());
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("rows", null);
			}
			
		}
		return resultData.toJSONString();
	}*/
	
	/*@ResponseBody
	@RequestMapping(value = "/hub/routing_material_recv_master_select_w2ui", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routing_material_recv_master_select_w2ui(@ModelAttribute SYZmmfmMatMasterVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routing_material_recv_master_select_w2ui() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			int curreCntPage = sVo.getPage(); 
			int rowCount = sVo.getRows(); 
			int rowTotal = sYhubService.routing_material_recv_master_select_count(sVo);
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
			if( curreCntPage > rowTotal ){
//				sVo.setRows((rowCount*(curreCntPage+1))-rowTotal);
				sVo.setRows(rowCount-(curreCntPage-rowTotal));
			}
			
			List<SYZmmfmMatMasterVo> list = sYhubService.routing_material_recv_master_select(sVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/routing_material_recv_master_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String routing_material_recv_master_select(@ModelAttribute SYZmmfmMatMasterVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routing_material_recv_master_select() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			int currentPage = Integer.parseInt(request.getParameter("page")); 
		    int pageRows = Integer.parseInt(request.getParameter("rows")); 
		    int startIndex = currentPage * pageRows - pageRows;
		    
		    sVo.setPage(startIndex);
		    sVo.setRows(pageRows);

		    int totalRows = sYhubService.routing_material_recv_master_select_count(sVo);
//		    System.out.println(totalRows);
		    List<SYZmmfmMatMasterVo>list = sYhubService.routing_material_recv_master_select(sVo);

			resultData = ResponseUtils.getJQGridJsonResponse(response, list, currentPage, pageRows, totalRows);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	
	/*@ResponseBody
	@RequestMapping(value = "/qm/inspection_delete", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String inspection_delete(@ModelAttribute SYQmVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.inspection_delete() is called.");
		JSONObject resultData = new JSONObject();

		String gubun = request.getParameter("gubun");
		String pordno_seq = request.getParameter("pordno_seq");
		
		
		if(gubun.equals("Y")) {
			try {
				
				String func_name = request.getParameter("func_name");
				String pordno = request.getParameter("pordno");
				System.out.println("pordno :::::::::::::::::::: " + pordno);
				resultData= sapMasterService.zmmfm_goodsmvt_cancel(sVo, func_name);
	
				JSONArray rows_arr = (JSONArray)resultData.get("rows");
				JSONObject rows_obj = (JSONObject)rows_arr.get(0);
				String ev_status = rows_obj.get("ev_status").toString();
				
				System.out.println("#######################");
				System.out.println("ev_status :: " + ev_status);
				System.out.println("ev_mblnr :: " + rows_obj.get("ev_mblnr").toString());
				System.out.println("ev_mjahr :: " + rows_obj.get("ev_mjahr").toString());
				
				if(ev_status.equals("S")) {
					
					SYQmVo pVo = new SYQmVo();
									
					String ev_mblnr = rows_obj.get("ev_mblnr").toString();
					String ev_mjahr = rows_obj.get("ev_mjahr").toString();
					
					pVo.setPordno(pordno);
					pVo.setPordno_seq(pordno_seq);
					
					pVo.setMblnr_cancel(ev_mblnr);
					pVo.setMjahr_cancel(ev_mjahr);				
					
					//최종검사 내역 업데이트
					sYqmService.last_insp_cancel_update(pVo);
					//출하검사 내역 삭제

					//prodtbl 상태 업데이트
					pVo.setPdsts("p8");
					sYqmService.prodTbl_pdsts_update(pVo);
				}
				
				resultData.put("status", HttpStatus.OK.value());
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			}
		} else {
			try {
				String pordno = request.getParameter("pordno");
				SYQmVo pVo = new SYQmVo();
														
				pVo.setPordno(pordno);
				pVo.setPordno_seq(pordno_seq);
				//최종검사 내역 업데이트
				sYqmService.last_insp_cancel_update(pVo);

				//prodtbl 상태 업데이트
				pVo.setPdsts("p8");
				sYqmService.prodTbl_pdsts_update(pVo);
				
				resultData.put("status", HttpStatus.OK.value());
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			}
		}
		System.out.println(resultData.toJSONString());
		return resultData.toJSONString();
	}*/
	
	/*
	@ResponseBody
	@RequestMapping(value = "/scm/vendorUpdateFromDelivery", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String vendorUpdateFromDelivery(@ModelAttribute SYScmRawDeliveryVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.vendorUpdateFromDelivery() is called.");
		
		List<SYScmRawDeliveryVo> dList = null;
		JSONObject resultData = new JSONObject();
		JSONObject paramData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		String sap_return;
		try {
			String funcName = request.getParameter("funcName");
			paramData.put("datFrom", request.getParameter("jidat_from"));
			paramData.put("datTo", request.getParameter("jidat_to"));

			JSONObject rfcObj = sapMasterService.zmmfm_purch_ord(funcName, paramData);

			dList = sYscmService.rawDelivery_select(scmRVo);
			for( SYScmRawDeliveryVo vo : dList ) {
				List<SYScmRawVendorResultVo> vList = new ArrayList<SYScmRawVendorResultVo>();
				SYScmRawVendorResultVo vVo = new SYScmRawVendorResultVo();
				vVo.setLabnr(vo.getLabnr());
				vList = sYscmService.rawVendor_selectAll(vVo);
//				vList.get(0)
			}
//			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
//			System.out.println(listDataJsonString);
//			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			// resultData.put("sap_retrun", sap_return);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	*/
	
	@ResponseBody
	@RequestMapping(value = "/mes/inInsp_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String inInsp_select(@ModelAttribute SYInInspVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.inInsp_select() is called.");
		
		List<SYInInspVo> iList = null;
		JSONObject resultData = new JSONObject();
		JSONObject paramData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		String sap_return;
		try {
			iList = sYmesService.inInsp_select(vo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, iList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/mes/inInsp_selectKey", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String inInsp_selectKey(@ModelAttribute SYInInspVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.inInsp_selectKey() is called.");
		
		List<SYInInspVo> iList = new ArrayList<SYInInspVo>();
		JSONObject resultData = new JSONObject();
		JSONObject paramData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		String sap_return;
		try {
//			String params = request.getParameter("params");
//			JSONArray objList = (JSONArray)jsonParser.parse(params);
//			for( int i=0; i<objList.size(); i++ ){
//				SYInInspVo tmpVo = new SYInInspVo();
//				JSONObject obj = (JSONObject)objList.get(i);
//				tmpVo.setEbeln((String)obj.get("ebeln"));
//				tmpVo.setMblnr((String)obj.get("mblnr"));
//				tmpVo.setMjahr((String)obj.get("mjahr"));
//				iList.add(sYmesService.inInsp_selectKey(tmpVo));
//			}
			iList = sYmesService.inInsp_selectKey(vo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, iList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
 /*
	@ResponseBody
	@RequestMapping(value = "/hub/saveRouting_Plast", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveRouting_Plast(@ModelAttribute SYHubRoutingHeaderVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.saveRouting_Plast() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try{
			String detData = request.getParameter("detData");
			listDataJArray = (JSONArray)jsonParser.parse(detData);
			Object[] keyArr = ((JSONObject)listDataJArray.get(0)).keySet().toArray();
			List<SYHubRoutingHeaderVo> sendList = new ArrayList<SYHubRoutingHeaderVo>();
			for(int idx=0; idx<listDataJArray.size(); idx++){
				SYHubRoutingHeaderVo tmpVo = new SYHubRoutingHeaderVo();
				JSONObject jObj = (JSONObject)listDataJArray.get(idx);
				tmpVo.setRouting_gno(vo.getRouting_gno());
				for(Object key : keyArr){
					String nkey = key.toString();
					String nValue = "";
					if( jObj.get(nkey)==null ) continue;
					else 
						nValue = jObj.get(nkey).toString();
					if( "routing_no".equals(nkey) ) tmpVo.setRouting_no(nValue);
				}
				sendList.add(tmpVo);
			}
			sYhubService.updateRouting_Plast(sendList);
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	
	@ResponseBody
	@RequestMapping(value = "/qm/inInspDetail_select", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String inInspDetail_select(@ModelAttribute SYInInspDetailVo Vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.inInspDetail_select() is called.");
		JSONObject resultData = new JSONObject();
		List<SYInInspDetailVo> iList = null;
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try{
			iList = sYqmService.inInspDetail_select(Vo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, iList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/qm/inspResultProcess", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String inspResultProcess(@ModelAttribute SYInInspHeaderVo Vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.inspResultProcess() is called.");
		
		JSONObject resultData = new JSONObject();
		List<SYInInspDetailVo> iList = null;
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		JSONArray sernrObj = new JSONArray();
		String  ebeln = null;
		String  ebelp = null;
		String  partial_seq = null;
		
		try{
			String funcName = request.getParameter("funcName");
			String params = request.getParameter("params");
			String gubun = request.getParameter("gubun"); // success / fail
			String headerJson = request.getParameter("headerJson"); // JSONOBJ -> VOlist header
			JSONArray dataArr = (JSONArray) jsonParser.parse(params);
			JSONObject headerObj = (JSONObject) jsonParser.parse(headerJson);
			
			String insp_model = request.getParameter("insp_model");
			String insp_ecr = request.getParameter("insp_ecr");
			String insp_maql = request.getParameter("insp_maql");
			String insp_vaql = request.getParameter("insp_vaql");
			String insp_doc = request.getParameter("insp_doc");
			String insp_remark = request.getParameter("insp_remark");
			
			
			insp_model = (insp_model=="")?null:insp_model;
			insp_ecr = (insp_ecr=="")?null:insp_ecr;
			insp_maql = (insp_maql=="")?null:insp_maql;
			insp_vaql = (insp_vaql=="")?null:insp_vaql;
			insp_doc = (insp_doc=="")?null:insp_doc;
			insp_remark = (insp_remark=="")?null:insp_remark;
			
			List<SYInInspHeaderVo> hList = new ArrayList<SYInInspHeaderVo>();
			Object[] hkeyArr = headerObj.keySet().toArray();
			SYInInspHeaderVo hVo = new SYInInspHeaderVo();
			hVo.setUpdater(SessionUtil.getMemberId(request));
			hVo.setCreator(SessionUtil.getMemberId(request));
			for (Object key : hkeyArr) {
				String nKey = key.toString();
				String nValue = (headerObj.get(nKey)==null)?"":headerObj.get(nKey).toString();
				if ( "ebeln".equals(key) ) {
					hVo.setEbeln(nValue);
					ebeln = nValue;
				} else if( "ebelp".equals(key) ) {
					hVo.setEbelp(nValue);
					ebelp=nValue;
				} else if( "partial_seq".equals(key) ) {
					hVo.setPartial_seq(nValue);
					partial_seq=nValue;
				} else if( "insp_status".equals(key) ) {
					hVo.setInsp_status(nValue);
				} else if( "matnr".equals(key) ) {
					hVo.setMatnr(nValue);
				} else if( "in_cofirm_date".equals(key) ) {
					hVo.setIn_cofirm_date(nValue);
				} else if( "in_fail_date".equals(key) ) {
					hVo.setIn_fail_date(nValue);
				} else if( "insp_gubun".equals(key) ) {
					hVo.setInsp_gubun(nValue);
				} else if( "insp_check_gubun".equals(key) ) {
					hVo.setInsp_check_gubun(nValue);
				} else if( "maktx".equals(key) ) {
					hVo.setMaktx(nValue);
				} else if( "wrkst".equals(key) ) {
					hVo.setWrkst(nValue);
				} else if( "mblnr".equals(key) ) {
					hVo.setMblnr(nValue);
				} else if( "mjahr".equals(key) ) {
					hVo.setMjahr(nValue);
				} else if( "in_labnr".equals(key) ) {
					hVo.setIn_labnr(nValue);
				} else if( "labnr".equals(key) ) {
					hVo.setLabnr(nValue);
				} else if( "lgort".equals(key) ) {
					hVo.setLgort(nValue);
				} else if( "zdeli_menge".equals(key) ) {
					hVo.setZdeli_menge(nValue);
				} else if( "menge".equals(key) ) {
					hVo.setMenge(nValue);
				} else if( "meins".equals(key) ) {
					hVo.setMeins(nValue);
				} else if( "werks".equals(key) ) {
					hVo.setWerks(nValue);
				} else if( "bukrs".equals(key) ) {
					hVo.setBukrs(nValue);
				}
			}
			
			hVo.setInsp_model(insp_ecr);
			hVo.setInsp_model(insp_model);
			hVo.setInsp_maql(insp_maql);
			hVo.setInsp_vaql(insp_vaql);
			hVo.setInsp_doc(insp_doc);
			hVo.setInsp_remark(insp_remark);
			
			hList.add(hVo);
//			int hInt = sYqmService.inInspHeader_insert(hList);
		
//			int dInt = sYqmService.inInspDetail_insert(dList);
//			int iInt = sYqmService.inInsp_update(hList);
			
			// make sernr
			for(SYInInspHeaderVo vo : hList){
				SYScmRawProcSernrVo sVo = new SYScmRawProcSernrVo();
				sVo.setEbeln(vo.getEbeln());
				sVo.setEbelp(vo.getEbelp());
			/*	sVo.setPartial_seq(vo.getPartial_seq());   취소때문에....*/
				sVo.setPartial_seq("0001");
				sVo.setMatnr(vo.getMatnr());
				for( SYScmRawProcSernrVo vvo : sYscmService.rawProcSernr_select(sVo)){
					JSONObject tmpObj = new JSONObject(); 
					tmpObj.put("ebeln", vo.getEbeln());
					tmpObj.put("ebelp", vo.getEbelp());
					tmpObj.put("partial_seq", vo.getPartial_seq());
					tmpObj.put("matnr", vo.getMatnr());
					tmpObj.put("equnr", vvo.getEqunr());
					vo.setSernp("V001");
					sernrObj.add(tmpObj);
				}
			}
//			System.out.println("*************************");
//			System.out.println(sernrObj);
			if( "success".equals(gubun) ) {	//합격
				for( SYInInspHeaderVo vo : hList) {
					List<SYScmRawProcVo> vList = new ArrayList<SYScmRawProcVo>();
					if( "IB".equals(vo.getInsp_gubun()) ){  //입하검사
						// rfc
						String ref_doc_no = sYscmService.makeRefDocNo();
						SYScmRawProcVo rVo = new SYScmRawProcVo();
						rVo.setLabnr(vo.getLabnr());
						rVo.setMatnr(vo.getMatnr());
						rVo.setWerks(vo.getWerks());
						rVo.setLgort(vo.getLgort());
						rVo.setZdeli_menge(vo.getZdeli_menge());
						rVo.setMeins(vo.getMeins());
						rVo.setEbeln(vo.getEbeln());
						rVo.setEbelp(vo.getEbelp());
						rVo.setTxz01(vo.getMaktx());
						rVo.setOrder_delivery_date(vo.getIn_cofirm_date());
						rVo.setMblnr(vo.getMblnr());//mblnr
						rVo.setMjahr(vo.getMjahr()); //mjahr			
						rVo.setSernp(vo.getSernp()); //sernp			
						rVo.setMesr("N");  // 입고처리시 입고후검사일경우 zmmfm_goodsmvt_po function에서 특정 창고로 보내야 하는 부분인데 공통으로 사용하기위해 강제로 넣음
										
						rVo.setMove_type("105");
						vList.add(rVo);
						resultData = sapMasterService.zmmfm_goodsmvt_po_proc(funcName, vList, sernrObj, ref_doc_no, null);
					}else{    //입고검사
						JSONObject job = new JSONObject();
						job.put("ebeln", vo.getEbeln());
						job.put("ebelp", vo.getEbelp());
						job.put("partial_seq", vo.getPartial_seq());
						job.put("matnr", vo.getMatnr());
						job.put("plant", vo.getWerks());
						job.put("bukrs", vo.getBukrs());
						job.put("mblnr", vo.getMblnr());
						job.put("maktx", vo.getMaktx());
						job.put("meins", vo.getMeins());
						job.put("menge", vo.getMenge());
						job.put("patial_seq", vo.getPartial_seq());
						job.put("zdeli_menge", vo.getZdeli_menge());
						job.put("stge_loc", "1050");
						job.put("move_stloc", "1010");
						resultData = sapMasterService.zmmfm_goodsmvt_st("ZMMFM_GOODSMVT_ST", job);
					}
				}
			} else {	//불합격
				for( SYInInspHeaderVo vo : hList) {
					List<SYScmRawVendorResultVo> vList = new ArrayList<SYScmRawVendorResultVo>();
					String ref_doc_no = sYscmService.makeRefDocNo();
					SYScmRawVendorResultVo rVo = new SYScmRawVendorResultVo();
					// Fail process : update raw_proc_tbl update
//					SYScmRawProcVo uVo = new SYScmRawProcVo(); 
//					uVo.setEbeln(vo.getEbeln());
//					uVo.setEbelp(vo.getEbelp());
//					uVo.setRorder_status("r3");
//					uVo.setRvendor_status("v2");
//					uVo.setLabnr("");
//					sYscmService.rawProcSta_update(uVo);
					
					//rawProcSta_update
					rVo.setLabnr(vo.getLabnr());
					rVo.setMatnr(vo.getMatnr());
					rVo.setWerks(vo.getWerks());
					rVo.setLgort(vo.getLgort());
					rVo.setZdeli_menge(vo.getZdeli_menge());
					rVo.setMeins(vo.getMeins());
					rVo.setEbeln(vo.getEbeln());
					rVo.setEbelp(vo.getEbelp());
					rVo.setTxz01(vo.getMaktx());
					rVo.setOrder_delivery_date(vo.getIn_fail_date());
					rVo.setMblnr(vo.getMblnr());//mblnr
					rVo.setMjahr(vo.getMjahr()); //mjahr
					rVo.setSernp(vo.getSernp());
					rVo.setMesr("N");  // 입고처리시 입고후검사일경우 zmmfm_goodsmvt_po function에서 특정 창고로 보내야 하는 부분인데 공통으로 사용하기위해 강제로 넣음
					if( "IB".equals(vo.getInsp_gubun()) ){
						rVo.setMove_type("124");
					} else if( "IF".equals(vo.getInsp_gubun()) ){
						rVo.setMove_type("122");
					}
					vList.add(rVo);
					resultData = sapMasterService.zmmfm_goodsmvt_po(funcName, vList, sernrObj, ref_doc_no);
				}
			}
 
			JSONObject rows = (JSONObject) resultData.get("rows");
			String return_status =  (String) rows.get("EV_STATUS");
			String return_msg =  (String)  rows.get("EV_MESSAGE");
			String return_mblnr =  (String) rows.get("EV_MBLNR");
			String return_mjahr =  (String)  rows.get("EV_MJAHR");
 	
		    resultData.put("status", return_status);
			resultData.put("message", return_msg );
			
			SYInInspVo inspVo = new SYInInspVo();
			inspVo.setEbeln(ebeln);
			inspVo.setEbelp(ebelp);
			inspVo.setPartial_seq(partial_seq);
			
			
			
			if( "S".equals(return_status) ){
				int hInt = sYqmService.inInspHeader_insert(hList);
	
				SYInInspHeaderVo shVo = sYqmService.inInspHeader_select(hList.get(0)).get(0);
				String insp_header_seq = shVo.getInsp_header_seq();
				List<SYInInspDetailVo> dList = new ArrayList<SYInInspDetailVo>();
				Object[] keyArr = ((JSONObject) dataArr.get(0)).keySet().toArray();
				for (int idx = 0; idx < dataArr.size(); idx++) {
					JSONObject jObj = new JSONObject();
					SYInInspDetailVo dVo = new SYInInspDetailVo();
					jObj = (JSONObject) dataArr.get(idx);
					
					dVo.setUpdater(SessionUtil.getMemberId(request));
					dVo.setCreator(SessionUtil.getMemberId(request));
					dVo.setInsp_header_seq(insp_header_seq);
					for (Object key : keyArr) {
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						if ( "ebeln".equals(key) ) {
							dVo.setEbeln(nValue);
						} else if( "ebelp".equals(key) ) {
							dVo.setEbelp(nValue);
						} else if( "partial_seq".equals(key) ) {
							dVo.setPartial_seq(nValue);
						} else if( "inspection_code".equals(key) ) {
							dVo.setInspection_code(nValue);
						} else if( "inspection_gcode".equals(key) ) {
							dVo.setInspection_gcode(nValue);
						} else if( "inspection_gnm".equals(key) ) {
							dVo.setInspection_gnm(nValue);
						} else if( "inspection_list".equals(key) ) {
							dVo.setInspection_list(nValue);
						} else if( "inspection_standard".equals(key) ) {
							dVo.setInspection_standard(nValue);
						} else if( "inspection_remark_code".equals(key) ) {
							dVo.setInspection_remark_code(nValue);
						} else if( "inspection_remark".equals(key) ) {
							dVo.setInspection_remark(nValue);
							
						} else if( "inspection_value1".equals(key) ) {
							dVo.setInspection_value1(nValue);
						} else if( "inspection_value2".equals(key) ) {
							dVo.setInspection_value2(nValue);
						} else if( "inspection_value3".equals(key) ) {
							dVo.setInspection_value3(nValue);
						} else if( "inspection_value4".equals(key) ) {
							dVo.setInspection_value4(nValue);
						} else if( "inspection_value5".equals(key) ) {
							dVo.setInspection_value5(nValue);
						} else if( "inspection_value6".equals(key) ) {
							dVo.setInspection_value6(nValue);
						} else if( "inspection_value7".equals(key) ) {
							dVo.setInspection_value7(nValue);
						} else if( "inspection_value8".equals(key) ) {
							dVo.setInspection_value8(nValue);
						} else if( "inspection_value9".equals(key) ) {
							dVo.setInspection_value9(nValue);
						} else if( "inspection_value10".equals(key) ) {
							dVo.setInspection_value10(nValue);
						
						} else if( "inspection_value11".equals(key) ) {
							dVo.setInspection_value11(nValue);
						} else if( "inspection_value12".equals(key) ) {
							dVo.setInspection_value12(nValue);
						} else if( "inspection_value13".equals(key) ) {
							dVo.setInspection_value13(nValue);
						} else if( "inspection_value14".equals(key) ) {
							dVo.setInspection_value14(nValue);
						} else if( "inspection_value15".equals(key) ) {
							dVo.setInspection_value15(nValue);
						} else if( "inspection_value16".equals(key) ) {
							dVo.setInspection_value16(nValue);
						} else if( "inspection_value17".equals(key) ) {
							dVo.setInspection_value17(nValue);
						} else if( "inspection_value18".equals(key) ) {
							dVo.setInspection_value18(nValue);
						} else if( "inspection_value19".equals(key) ) {
							dVo.setInspection_value19(nValue);
						} else if( "inspection_value20".equals(key) ) {
							dVo.setInspection_value20(nValue);
							
						} else if( "inspection_value21".equals(key) ) {
							dVo.setInspection_value21(nValue);
						} else if( "inspection_value22".equals(key) ) {
							dVo.setInspection_value22(nValue);
						} else if( "inspection_value23".equals(key) ) {
							dVo.setInspection_value23(nValue);
						} else if( "inspection_value24".equals(key) ) {
							dVo.setInspection_value24(nValue);
						} else if( "inspection_value25".equals(key) ) {
							dVo.setInspection_value25(nValue);
						} else if( "inspection_value26".equals(key) ) {
							dVo.setInspection_value26(nValue);
						} else if( "inspection_value27".equals(key) ) {
							dVo.setInspection_value27(nValue);
						} else if( "inspection_value28".equals(key) ) {
							dVo.setInspection_value28(nValue);
						} else if( "inspection_value29".equals(key) ) {
							dVo.setInspection_value29(nValue);
						} else if( "inspection_value30".equals(key) ) {
							dVo.setInspection_value30(nValue);
							
						} else if( "inspection_value31".equals(key) ) {
							dVo.setInspection_value31(nValue);
						} else if( "inspection_value32".equals(key) ) {
							dVo.setInspection_value32(nValue);
						
						} else if( "inspection_type".equals(key) ) {
							dVo.setInspection_type(nValue);	
						} else if( "inspection_decision".equals(key) ) {
							dVo.setInspection_decision(nValue);
						}  else if( "inspection_cn".equals(key) ) {
							dVo.setInspection_cn(nValue);
						} 
					}
					dList.add(dVo);
				}
				
				int dInt = sYqmService.inInspDetail_insert(dList);
				int iInt = sYqmService.inInsp_update(hList);
			 
				if( "success".equals(gubun) ) {	//합격	
					inspVo.setS_mblnr(return_mblnr);
					inspVo.setS_mjahr(return_mjahr);
				}else{ //불합격
					// Fail process : update raw_proc_tbl update
					SYScmRawProcVo uVo = new SYScmRawProcVo(); 
					uVo.setEbeln(ebeln);
					uVo.setEbelp(ebelp);
					uVo.setRorder_status("r3");
					uVo.setRvendor_status("v2");
					uVo.setLabnr("");
					sYscmService.rawProcSta_update(uVo);
					
					inspVo.setMblnr_cancel(return_mblnr);
					inspVo.setMjahr_cancel(return_mjahr);
				}	
				
				inspVo.setRemark(return_msg);
				
			} else {	// means rfc process "FAIL"
				inspVo.setRemark(return_msg);
			}
			sYqmService.inInspResultSta_update(inspVo);
			
			resultData.put("rows", rows);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/rawProcNextStep_update", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String rawProcNextStep_update(@ModelAttribute SYScmRawProcVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.rawProcNextStep_update() is called.");
		JSONObject resultData = new JSONObject();
		List<SYScmRawProcVo> iList = null;
		try{
			int result = sYscmService.rawProcNextStep_update(vo);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/scm/rawProcConfirmYn_update", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String rawProcConfirmYn_update(@ModelAttribute SYScmRawProcVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.rawProcConfirmYn_update() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONArray listUKeyArray = new JSONArray();
		JSONParser jsonParser = new JSONParser(); 
		try{
			int result = 0;
			String params =  request.getParameter("params");
			String uKeyArr = request.getParameter("uKeyArr");
			
			listDataJArray = (JSONArray)jsonParser.parse(params);
			List<SYScmRawProcVo> iList = new ArrayList<SYScmRawProcVo>();
			Object[] keyArr = ((JSONObject) listDataJArray.get(0)).keySet().toArray();
			for(int idx=0; idx<listDataJArray.size(); idx++) {
				JSONObject obj = (JSONObject)listDataJArray.get(idx);
				SYScmRawProcVo tmpVo = new SYScmRawProcVo();
				tmpVo.setUpdater(SessionUtil.getMemberId(request));
				for(Object key : keyArr) {
					String nKey = key.toString();
					String nValue = (obj.get(nKey)==null)?"":obj.get(nKey).toString();
					if( "ebeln".equals(nKey) ) tmpVo.setEbeln(nValue);
					else if( "ebelp".equals(nKey) ) tmpVo.setEbelp(nValue);
					else if( "partial_seq".equals(nKey) ) tmpVo.setPartial_seq(nValue);
					else if( "partial_yn".equals(nKey) ) tmpVo.setPartial_yn(nValue);
					else if( "vendor_delivery_date".equals(nKey) ) tmpVo.setVendor_delivery_date(nValue);
					else if( "order_delivery_date".equals(nKey) ) tmpVo.setOrder_delivery_date(nValue);
					else if( "confirm_date".equals(nKey) ) tmpVo.setConfirm_date(nValue);
					else if( "zdeli_menge".equals(nKey) ) tmpVo.setZdeli_menge(nValue);
					else if( "confirm_yn".equals(nKey) ) tmpVo.setConfirm_yn(nValue);
					else if( "diff_date".equals(nKey) ) tmpVo.setDiff_date(nValue);
					else if( "key_cnt".equals(nKey) ) tmpVo.setKey_cnt(nValue);
				}
				iList.add(tmpVo);
			}
			// set labnr
			listUKeyArray = (JSONArray)jsonParser.parse(uKeyArr);	// ebeln list
			List<SYScmRawProcVo> uniqueKeylist = sYscmService.getProcUniqueKeyList(listUKeyArray);	//labnr
			for(int idx=0; idx<iList.size(); idx++ ) {
				for( SYScmRawProcVo itemVo : uniqueKeylist ) {
					if( (itemVo.getEbeln()).equals((iList.get(idx)).getEbeln()) && 
						(itemVo.getEbelp()).equals((iList.get(idx)).getEbelp()) && 
						(itemVo.getPartial_seq()).equals((iList.get(idx)).getPartial_seq()) ) {
//						(iList.get(idx)).setLabnr(itemVo.getUnikey());
						String header = (itemVo.getUnikey()).substring(0, 16);
						String tail = (itemVo.getUnikey()).substring(18, 20);
						String seq = String.format("%02d", Integer.parseInt((iList.get(idx)).getKey_cnt())); 
						(iList.get(idx)).setLabnr(header + seq + tail);
						(iList.get(idx)).setKey_cnt( (Integer.parseInt((iList.get(idx)).getKey_cnt())+1)+"" );
					}
				}
			}
			
			for(SYScmRawProcVo pVo : iList){
//				System.out.println(pVo);
				result += sYscmService.rawProcConfirmYn_update(pVo);
			}
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/qm/inInspResult_select", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String inInspResult_select(@ModelAttribute SYInInspDetailVo Vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.inInspDetail_select() is called.");
		JSONObject resultData = new JSONObject();
		List<SYInInspDetailVo> iList = null;
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try{
			iList = sYqmService.inInspResult_select(Vo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, iList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/scm/fwother_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String fwother_select(@ModelAttribute SYWfwotherVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.fwother_select() is called.");
			    
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try {
			int currentPage = Integer.parseInt(request.getParameter("page")); 
		    int pageRows = Integer.parseInt(request.getParameter("rows")); 
		    int startIndex = currentPage * pageRows - pageRows;
		    
		    scmRVo.setPage(startIndex);
		    scmRVo.setRows(pageRows);

		    int totalRows = sYscmService.fwother_select_count(scmRVo);
		    List<SYWfwotherVo> list = sYscmService.fwother_select(scmRVo);

			resultData = ResponseUtils.getJQGridJsonResponse(response, list, currentPage, pageRows, totalRows);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/fwother_serial_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String fwother_serial_select(@ModelAttribute SYWfwotherVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.fwother_serial_select() is called.");
			    		
		List<SYWfwotherVo> listCode = null;
		listCode = sYscmService.fwother_serial_select(scmRVo);
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/fwother_select_nopage", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String fwother_select_nopage(@ModelAttribute SYWfwotherVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.fwother_select_nopage() is called.");
			    		
		List<SYWfwotherVo> listCode = null;
		listCode = sYscmService.fwother_select_nopage(scmRVo);
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/scm/approval_req_matr", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String approval_req_matr(@ModelAttribute SYWfwotherVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.approval_req_matr() is called.");
		JSONObject resultData = new JSONObject();
		try {
			String userId = SessionUtil.getMemberId(request);
			scmRVo.setUpdater(userId);
			scmRVo.setStatus("f2");
			int result = sYscmService.req_matr_status_update(scmRVo);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/fwother_mst_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String fwother_mst_insert(@ModelAttribute SYWfwotherVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.fwother_mst_insert() is called.");
		JSONObject resultData = new JSONObject();
		try {
			String userId = SessionUtil.getMemberId(request);
			
			scmRVo.setCreator(userId);
			scmRVo.setUpdater(userId);
			scmRVo.setStatus("f1");
			scmRVo.setGr_rcpt(userId);
			
			int result = sYscmService.fwother_mst_insert(scmRVo);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	/*
	@ResponseBody
	@RequestMapping(value = "/scm/cancel_req_ord", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String cancel_req_ord(@ModelAttribute SYWfwotherVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.cancel_req_ord() is called.");
		JSONObject resultData = new JSONObject();
		try {
			String userId = SessionUtil.getMemberId(request);

			scmRVo.setUpdater(userId);
			scmRVo.setUse_yn("N");

			int result = sYscmService.cancel_req_ord(scmRVo);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	
	
	@ResponseBody
	@RequestMapping(value = "/scm/conf_req_matr", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String conf_req_matr(@ModelAttribute SYWfwotherVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.conf_req_matr() is called.");
		JSONObject resultData = new JSONObject();
		try {
			String userId = SessionUtil.getMemberId(request);

			String pre_status = request.getParameter("pre_status");
		
			System.out.println("*****************************************");
			System.out.println(pre_status);
		
			scmRVo.setCreator(userId);
			scmRVo.setUpdater(userId);
			scmRVo.setStatus("f3");
			
			
//			serial insert 
			int result = sYscmService.fwother_serial_insert(scmRVo);
			//status 변경(f3)
			result = sYscmService.req_matr_status_update(scmRVo);
			
			/*****************ZMMFM_GOODSMVT_GI 로 전송 : Start**************************/
			
			/*****************header data***************/
			String ref_doc_no = scmRVo.getRef_doc_no();
			String pstng_date = scmRVo.getConf_date();
			String doc_date= scmRVo.getConf_date();
			String header_txt = scmRVo.getHeader_txt();
			 
			
			JSONObject header_jobj = new JSONObject();
			header_jobj.put("ref_doc_no", ref_doc_no);
			header_jobj.put("pstng_date", pstng_date);
			header_jobj.put("doc_date", doc_date);
			header_jobj.put("header_txt", header_txt);
			 
			
			/*****************header data***************/
			
			/*****************item data***************/
			SYWfwotherVo pVo = new SYWfwotherVo();
			pVo.setRef_doc_no(ref_doc_no);
			List<SYWfwotherVo> item_selc_result = sYscmService.fwother_select_nopage(pVo);
			
			JSONArray item_jarr = new JSONArray();
			
			for(int i=0 ; i<item_selc_result.size(); i++) {
				
				JSONObject jobj = new JSONObject();
				
				jobj.put("matdoc_itm", item_selc_result.get(i).getMatdoc_itm());
				jobj.put("material", item_selc_result.get(i).getMaterial());
				jobj.put("move_type", item_selc_result.get(i).getMove_type());
				jobj.put("plant", item_selc_result.get(i).getPlant());
				jobj.put("stge_loc", item_selc_result.get(i).getStge_loc());
				jobj.put("reserv_no", item_selc_result.get(i).getReserv_no());
				jobj.put("res_item", item_selc_result.get(i).getRes_item());
				jobj.put("costcenter", item_selc_result.get(i).getCostcenter());
				jobj.put("orderid", item_selc_result.get(i).getOrderid());
				jobj.put("entry_qnt", item_selc_result.get(i).getEntry_qnt());
				jobj.put("entry_uom", item_selc_result.get(i).getEntry_uom());
				jobj.put("gr_rcpt", item_selc_result.get(i).getGr_rcpt());
				jobj.put("item_text", item_selc_result.get(i).getItem_text());
				jobj.put("spec_stock", item_selc_result.get(i).getSpec_stock());
				
				item_jarr.add(jobj);
				
			}

			/*****************item data***************/
			
			/*****************sernr data***************/
			pVo = new SYWfwotherVo();
			pVo.setRef_doc_no(ref_doc_no);
			pVo.setUpdater(userId);
			List<SYWfwotherVo> sernr_selc_result = sYscmService.fwother_serial_select(pVo);
			
			JSONArray sernr_jarr = new JSONArray();
			
			for(int i=0 ; i<sernr_selc_result.size(); i++) {
				
				JSONObject jobj = new JSONObject();
				
				jobj.put("matdoc_itm", sernr_selc_result.get(i).getMatdoc_itm());
				jobj.put("serialno", sernr_selc_result.get(i).getSerialno());

				sernr_jarr.add(jobj);
			}

			/*****************sernr data***************/
			resultData = sapMasterService.zmmfm_goodsmvt_gi("ZMMFM_GOODSMVT_GI", header_jobj, item_jarr, sernr_jarr);
			/*****************ZMMFM_GOODSMVT_GI 로 전송 : End**************************/
			
			
			
			resultData.put("status", HttpStatus.OK.value());
			String e_return = resultData.get("e_return").toString();
			String ev_mblnr = resultData.get("ev_mblnr").toString();			//자재문서번호
			String ev_mjahr = resultData.get("ev_mjahr").toString();			//자재문서연도
			System.out.println("################################");
			System.out.println("ev_mblnr :: " + ev_mblnr + "    //    ev_mjahr :: "+ ev_mjahr);
			
			SYWfwotherVo ppVo = new SYWfwotherVo();
			
			ppVo.setRef_doc_no(scmRVo.getRef_doc_no());
			ppVo.setEv_mblnr(ev_mblnr);
			ppVo.setEv_mjahr(ev_mjahr);
			
			
			if(e_return.equals("E") ) {
				pVo.setStatus(pre_status);
				sYscmService.fwother_restore_update(pVo);
				sYscmService.fwother_restore_delete(pVo);
			} else {
				sYscmService.sap_return_update(ppVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/fwother_conf_header_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String fwother_conf_header_select(@ModelAttribute SYWfwotherVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.fwother_conf_header_select() is called.");
	
		List<SYWfwotherVo> listCode = null;
		
		listCode = sYscmService.fwother_conf_header_select(scmRVo);

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/move_type_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String move_type_select(@ModelAttribute SYMoveTypeVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.move_type_select() is called.");
			    		
		List<SYMoveTypeVo> listCode = null;
		listCode = sYscmService.move_type_select(scmRVo);
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/cost_type_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String cost_type_select(@ModelAttribute SYMoveTypeVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.cost_type_select() is called.");
			    		
		List<SYMoveTypeVo> listCode = null;
		listCode = sYscmService.cost_type_select(scmRVo);
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/io_type_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String io_type_select(@ModelAttribute SYMoveTypeVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.move_type_select() is called.");
			    		
		List<SYMoveTypeVo> listCode = null;
		listCode = sYscmService.io_type_select(scmRVo);
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/cancel_req_matr", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String cancel_req_matr(@ModelAttribute SYWfwotherVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.cancel_req_matr() is called.");
		JSONObject resultData = new JSONObject();
		try {
			String userId = SessionUtil.getMemberId(request);
			scmRVo.setUpdater(userId);

			List<SYWfwotherVo> fwother_list = sYscmService.fwother_select_nopage(scmRVo);
			
			String s_mblnr = null;
			String s_mjahr = null;
			String sudat = null;
			
			for(int i=0 ; i<fwother_list.size(); i++) {
				s_mblnr = fwother_list.get(i).getS_mblnr();	//자재문서번호
				s_mjahr = fwother_list.get(i).getS_mjahr(); 	//자재문서년도
				sudat = fwother_list.get(i).getSudat(); 	//자재문서년도
			}
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			System.out.println("s_mblnr :::" + s_mblnr + "    //   s_mjahr ::: " + s_mjahr + "    //   sudat ::: "+ sudat);
			
			SYQmVo sVo = new SYQmVo();
			
			JSONArray jarr = new JSONArray();
			
			JSONObject job = new JSONObject();
			
			job.put("iv_materialdocument", s_mblnr);
			job.put("iv_matdocumentyear", s_mjahr);
			job.put("iv_goodsmvt_pstng_date", sudat);

			jarr.add(job);
			
			String jstr = jarr.toJSONString();
			
			sVo.setJstr(jstr);
			 
			resultData= sapMasterService.zmmfm_goodsmvt_cancel(sVo, "ZMMFM_GOODSMVT_CANCEL");

			JSONArray rows_arr = (JSONArray)resultData.get("rows");
			JSONObject rows_obj = (JSONObject)rows_arr.get(0);
			String ev_status = rows_obj.get("ev_status").toString();
			
			System.out.println("#######################");
			System.out.println("ev_status :: " + ev_status);
			System.out.println("ev_mblnr :: " + rows_obj.get("ev_mblnr").toString());
			System.out.println("ev_mjahr :: " + rows_obj.get("ev_mjahr").toString());
			
			if(ev_status.equals("S")) {
				SYWfwotherVo pVo = new SYWfwotherVo();
				pVo.setStatus("f4");
				pVo.setUpdater(userId);
				pVo.setRef_doc_no(scmRVo.getRef_doc_no());
				pVo.setC_mblnr(rows_obj.get("ev_mblnr").toString());
				pVo.setC_mjahr(rows_obj.get("ev_mjahr").toString());
				
				int result = sYscmService.req_matr_status_update(pVo);
			}
				
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/dmrMaster_select", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String dmrMaster_select(@ModelAttribute SYDmrMasterVo dVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.dmrMaster_select() is called.");
		JSONObject resultData = new JSONObject();
		List<SYDmrMasterVo> iList = null;
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try{
			System.out.println( "dVo" +dVo.toString());
			iList = sYhubService.dmrMaster_select(dVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, iList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/dmrVersion_select", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String dmrMasterAllByKey_select(@ModelAttribute SYDmrMasterVo dVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.dmrMasterAllByKey_select() is called.");
		JSONObject resultData = new JSONObject();
		List<SYDmrMasterVo> iList = null;
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try{
			System.out.println(dVo.getGr_no());
			iList = sYhubService.dmrMasterAllByKey_select(dVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, iList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/hub/dmrMaster_insert", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String dmrMaster_insert(@ModelAttribute SYDmrMasterVo dVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.dmrMaster_insert() is called.");
		JSONObject resultData = new JSONObject();
		int resultCnt = 0;
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try{
			String creater = SessionUtil.getMemberId(request);
			String updater = SessionUtil.getMemberId(request);
			String masterData = request.getParameter("masterData");
			String pbaData = request.getParameter("pbaData");
			String fwData = request.getParameter("fwData");
			String gubun = request.getParameter("gubun");
			System.out.println(gubun);
			// master data
			SYDmrMasterVo mVo = new SYDmrMasterVo();
			mVo.setCreator(creater);
			mVo.setUpdater(updater);
			JSONObject mObj = (JSONObject)jsonParser.parse(masterData);
			Object[] mKeyArr = mObj.keySet().toArray();
			for(Object key : mKeyArr) {
				String nKey = key.toString();
				String nValue = (mObj.get(nKey)==null)?"":mObj.get(nKey).toString();
				if ( "p_gr_no".equals(nKey) ) {
					if ( "".equals(nValue) ) 
						nValue = sYhubService.getGrNo(); 
					mVo.setGr_no(nValue);
				} else if ( "p_gr_seq".equals(nKey) ) {
					if ( "".equals(nValue) ) 
						nValue = sYhubService.getGrSeq();
					mVo.setGr_seq(nValue);
				} else if ( "p_gr_nm".equals(nKey) ) mVo.setGr_nm(nValue);
				else if ( "p_dept_cd".equals(nKey) ) mVo.setDept_cd(nValue);
				else if ( "p_change_date".equals(nKey) ) mVo.setChange_date(nValue);
				else if ( "p_confirm_date".equals(nKey) ) mVo.setConfirm_date(nValue);
				else if ( "p_change_remark".equals(nKey) ) mVo.setChange_remark(nValue);
				else if ( "p_change_memo".equals(nKey) ) mVo.setChange_memo(nValue);
				else if ( "p_special_note".equals(nKey) ) mVo.setSpecial_note(nValue);
				else if ( "p_ecr_no".equals(nKey) ) mVo.setEcr_no(nValue);
				else if ( "p_rn_no".equals(nKey) ) mVo.setRn_no(nValue);
				else if ( "p_dmr_no".equals(nKey) ) mVo.setDmr_no(nValue);
				else if ( "p_apply_yn".equals(nKey) ) mVo.setApply_yn(nValue);
			}
			System.out.println(mVo.toString());
			// master tbl insert/update
			if( "Y".equals(mVo.getApply_yn()) ){
				SYDmrMasterVo tmpVo = new SYDmrMasterVo();
				tmpVo.setGr_no(mVo.getGr_no());
				tmpVo.setUpdater(SessionUtil.getMemberId(request));
				sYhubService.dmrMaster_applyInit_update(tmpVo);
			}
			
			if( "addGroup".equals(gubun) ) {
				mVo.setGr_no(sYhubService.getGrNo());
				mVo.setGr_seq(sYhubService.getGrSeq());
				mVo.setApply_yn("Y");
			}
			
			resultCnt = sYhubService.dmrMaster_insert(mVo);
			// pba data : master key 는 필수로 들어온다.(jsp control)
			if( !("".equals(pbaData)) ) {
				JSONArray pbaObjArr = (JSONArray)jsonParser.parse(pbaData);
				List<SYDmrPbaVo> pbaList = new ArrayList<SYDmrPbaVo>();
//				System.out.println(pbaList);
				if( pbaObjArr!=null || pbaObjArr.size()>0 ) {
					Object[] pbaKeyArr = ((JSONObject)pbaObjArr.get(0)).keySet().toArray();
					for(int idx=0; idx<pbaObjArr.size(); idx++){
						SYDmrPbaVo tmpVo = new SYDmrPbaVo();
						JSONObject tmpObj = (JSONObject)pbaObjArr.get(idx);
						tmpVo.setGr_no(mVo.getGr_no());
						tmpVo.setGr_seq(mVo.getGr_seq());
						tmpVo.setGr_nm(mVo.getGr_nm());
						tmpVo.setUpdater(updater);
						tmpVo.setCreator(creater);
						for(Object key : pbaKeyArr) {
							String nKey = key.toString();
							String nValue = (tmpObj.get(nKey) == null)?"":tmpObj.get(nKey).toString();
//							System.out.println( nKey);	
//							System.out.println( nValue);
							if ( "pba_gubun".equals(nKey) ) tmpVo.setPba_gubun(nValue);
							else if ( "pba_matnr".equals(nKey) ) tmpVo.setPba_matnr(nValue);
							else if ( "pba_maktx".equals(nKey) ) tmpVo.setPba_maktx(nValue);
							else if ( "pba_wrkst".equals(nKey) ) tmpVo.setPba_wrkst(nValue);
							else if ( "pba_matnr".equals(nKey) ) tmpVo.setPba_matnr(nValue);
							else if ( "pba_seq".equals(nKey) ) tmpVo.setPba_seq(nValue);
						}
						pbaList.add(tmpVo);
					}
					// pba tbl insert/update
					resultCnt += sYhubService.dmrPba_insert(pbaList);
				}
			}
			// fw data : master key 는 필수로 들어온다.(jsp control)
			if( !("".equals(fwData)) ) {
				JSONArray fwObjArr = (JSONArray)jsonParser.parse(fwData);
				List<SYDmrFwVo> fwList = new ArrayList<SYDmrFwVo>();
//				System.out.println(fwList.toString());
				if( fwObjArr!=null || fwObjArr.size()>0 ) {
					Object[] fwKeyArr = ((JSONObject)fwObjArr.get(0)).keySet().toArray();
					for(int idx=0; idx<fwObjArr.size(); idx++){
						SYDmrFwVo tmpVo = new SYDmrFwVo();
						JSONObject tmpObj = (JSONObject)fwObjArr.get(idx);
						tmpVo.setGr_no(mVo.getGr_no());
						tmpVo.setGr_seq(mVo.getGr_seq());
						tmpVo.setGr_nm(mVo.getGr_nm());
						tmpVo.setUpdater(updater);
						tmpVo.setCreator(creater);
						for(Object key : fwKeyArr) {
							String nKey = key.toString();
							String nValue = (tmpObj.get(nKey) == null)?"":tmpObj.get(nKey).toString();
//							System.out.println( nKey);	
//							System.out.println( nValue);	
							
						//	String nValue = tmpObj.get(nKey).toString();
							if ( "fw_gubun".equals(nKey) ) tmpVo.setFw_gubun(nValue);
							else if ( "fw_type".equals(nKey) ) tmpVo.setFw_type(nValue);
							else if ( "fw_info".equals(nKey) ) tmpVo.setFw_info(nValue);
							else if ( "fw_seq".equals(nKey) ) tmpVo.setFw_seq(nValue);
						}
						fwList.add(tmpVo);
					}
					// fw tbl insert/update
					resultCnt += sYhubService.dmrFw_insert(fwList);
				}
			}
			if( resultCnt>0 ) {
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("result", resultCnt);
			} else {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("result", "0");
			}
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/hub/dmrMaster_newVersion", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String dmrMaster_newVersion(@ModelAttribute SYDmrMasterVo dVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.dmrMaster_newVersion() is called.");
		JSONObject resultData = new JSONObject();
		int resultCnt = 0;
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try{
			String creater = SessionUtil.getMemberId(request);
			String updater = SessionUtil.getMemberId(request);
			String masterData = request.getParameter("masterData");
			String pbaData = request.getParameter("pbaData");
			String fwData = request.getParameter("fwData");
			
			// master data
			SYDmrMasterVo mVo = new SYDmrMasterVo();
			mVo.setCreator(creater);
			mVo.setUpdater(updater);
			// 새로운 순번 만들어 가져온다.
			String newSeq = sYhubService.getGrSeq();
			JSONObject mObj = (JSONObject)jsonParser.parse(masterData);
			Object[] mKeyArr = mObj.keySet().toArray();
			for(Object key : mKeyArr) {
				String nKey = key.toString();
				String nValue = (mObj.get(nKey)==null)?"":mObj.get(nKey).toString();
				if ( "p_gr_no".equals(nKey) ) mVo.setGr_no(nValue);
				else if ( "p_gr_seq".equals(nKey) ) mVo.setGr_seq(newSeq);	// 강제로 순번(버전)을 삭제하여 새로 순번을 만들어 추가하도록 한다. 
				else if ( "p_gr_nm".equals(nKey) ) mVo.setGr_nm(nValue);
				else if ( "p_dept_cd".equals(nKey) ) mVo.setDept_cd(nValue);
				else if ( "p_change_date".equals(nKey) ) mVo.setChange_date(nValue);
				else if ( "p_confirm_date".equals(nKey) ) mVo.setConfirm_date(nValue);
				else if ( "p_change_remark".equals(nKey) ) mVo.setChange_remark(nValue);
				else if ( "p_change_memo".equals(nKey) ) mVo.setChange_memo(nValue);
				else if ( "p_special_note".equals(nKey) ) mVo.setSpecial_note(nValue);
				else if ( "p_ecr_no".equals(nKey) ) mVo.setEcr_no(nValue);
				else if ( "p_rn_no".equals(nKey) ) mVo.setRn_no(nValue);
				else if ( "p_dmr_no".equals(nKey) ) mVo.setDmr_no(nValue);
				else if ( "p_apply_yn".equals(nKey) ) mVo.setApply_yn(nValue);
//				else if ( "p_apply_yn".equals(nKey) ) mVo.setApply_yn("N");
			}
			if( "Y".equals(mVo.getApply_yn()) ) {
				SYDmrMasterVo uVo = new SYDmrMasterVo();
				uVo.setGr_no(mVo.getGr_no());
				uVo.setUpdater(updater);
				uVo.setApply_yn("N");
				sYhubService.dmrMaster_update(uVo);
			}
			// master tbl insert/update
			resultCnt = sYhubService.dmrMaster_insert(mVo);
			
			// pba data : master key 는 필수로 들어온다.(jsp control)
			if( pbaData!=null && resultCnt>0 ) {
				JSONArray pbaObjArr = (JSONArray)jsonParser.parse(pbaData);
				List<SYDmrPbaVo> pbaList = new ArrayList<SYDmrPbaVo>();
				if( pbaObjArr!=null || pbaObjArr.size()>0 ) {
					Object[] pbaKeyArr = ((JSONObject)pbaObjArr.get(0)).keySet().toArray();
					for(int idx=0; idx<pbaObjArr.size(); idx++){
						SYDmrPbaVo tmpVo = new SYDmrPbaVo();
						JSONObject tmpObj = (JSONObject)pbaObjArr.get(idx);
						tmpVo.setGr_no(mVo.getGr_no());
						tmpVo.setGr_seq(mVo.getGr_seq());
						tmpVo.setGr_nm(mVo.getGr_nm());
						tmpVo.setUpdater(updater);
						for(Object key : pbaKeyArr) {
							String nKey = key.toString();
							String nValue = "";
							if( tmpObj.get(nKey)==null ) continue;
							else
								nValue = tmpObj.get(nKey).toString();
							if ( "pba_gubun".equals(nKey) ) tmpVo.setPba_gubun(nValue);
							else if ( "pba_matnr".equals(nKey) ) tmpVo.setPba_matnr(nValue);
							else if ( "pba_maktx".equals(nKey) ) tmpVo.setPba_maktx(nValue);
							else if ( "pba_wrkst".equals(nKey) ) tmpVo.setPba_wrkst(nValue);
							else if ( "pba_matnr".equals(nKey) ) tmpVo.setPba_matnr(nValue);
							else if ( "pba_seq".equals(nKey) ) tmpVo.setPba_seq(nValue);
						}
						pbaList.add(tmpVo);
					}
					// pba tbl insert/update
					resultCnt += sYhubService.dmrPbaVerUp_insert(pbaList);
				}
			}
			
			// fw data : master key 는 필수로 들어온다.(jsp control)
			if( fwData!=null && resultCnt>0 ) {
				JSONArray fwObjArr = (JSONArray)jsonParser.parse(fwData);
				List<SYDmrFwVo> fwList = new ArrayList<SYDmrFwVo>();
				if( fwObjArr!=null || fwObjArr.size()>0 ) {
					Object[] fwKeyArr = ((JSONObject)fwObjArr.get(0)).keySet().toArray();
					for(int idx=0; idx<fwObjArr.size(); idx++){
						SYDmrFwVo tmpVo = new SYDmrFwVo();
						JSONObject tmpObj = (JSONObject)fwObjArr.get(idx);
						tmpVo.setGr_no(mVo.getGr_no());
						tmpVo.setGr_seq(mVo.getGr_seq());
						tmpVo.setGr_nm(mVo.getGr_nm());
						tmpVo.setUpdater(updater);
						for(Object key : fwKeyArr) {
							String nKey = key.toString();
							String nValue = (tmpObj.get(nKey) == null)?"":tmpObj.get(nKey).toString();
							
						 
							if ( "fw_gubun".equals(nKey) ) tmpVo.setFw_gubun(nValue);
							else if ( "fw_type".equals(nKey) ) tmpVo.setFw_type(nValue);
							else if ( "fw_info".equals(nKey) ) tmpVo.setFw_info(nValue);
							else if ( "fw_seq".equals(nKey) ) tmpVo.setFw_seq(nValue);
						}
						fwList.add(tmpVo);
					}
					// fw tbl insert/update
					resultCnt += sYhubService.dmrFwVerUp_insert(fwList);
				}
			}
			
			if( resultCnt>0 ) {
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("result", resultCnt);
			} else {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("result", "0");
			}
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/dmrMaster_delete", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String dmrMaster_delete(@ModelAttribute SYDmrMasterVo dVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.dmrMaster_delete() is called.");
		JSONObject resultData = new JSONObject();
		int resultCnt = 0;
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try{
			resultCnt = sYhubService.dmrMaster_delete(dVo);
			if( resultCnt>0 ) {
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("result", resultCnt);
			} else {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("result", "0");
			}
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/dmrPba_select", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String dmrPba_select(@ModelAttribute SYDmrPbaVo dVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.dmrPba_select() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try{
			List<SYDmrPbaVo> list = sYhubService.dmrPba_select(dVo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/dmrFw_select", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String dmrFw_select(@ModelAttribute SYDmrFwVo dVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.dmrFw_select() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try{
			List<SYDmrFwVo> list = sYhubService.dmrFw_select(dVo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/applyVersion", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String applyVersion(@ModelAttribute SYDmrMasterVo dVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.applyVersion() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		int resultCnt = 0;
		try{
			/*
			SYDmrMasterVo tryVo = new SYDmrMasterVo();
			tryVo.setApply_yn("N");
			tryVo.setGr_no(dVo.getGr_no());
			tryVo.setUpdater(SessionUtil.getMemberId(request));
			resultCnt = sYhubService.dmrMaster_update(tryVo);
			*/
			SYDmrMasterVo tmpVo = new SYDmrMasterVo();
			tmpVo.setUpdater(SessionUtil.getMemberId(request));
			tmpVo.setGr_no(dVo.getGr_no());
			sYhubService.dmrMaster_applyInit_update(tmpVo);
			
			SYDmrMasterVo tryVo = new SYDmrMasterVo();
			tryVo.setGr_no(dVo.getGr_no());
			tryVo.setGr_seq(dVo.getGr_seq());
			tryVo.setApply_yn("Y");
			// appy_yn = "Y" update
			resultCnt = sYhubService.dmrMaster_update(tryVo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", resultCnt);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
/*
	@ResponseBody
	@RequestMapping(value = "/prod/deletetProdOrdTbl", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deletetProdOrdTbl(@ModelAttribute SYProdVo pVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deletetProdOrdTbl() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		int resultCnt = 0;
		try{
			String delData = request.getParameter("params");
			listDataJArray = (JSONArray)jsonParser.parse(delData);
			List<SYProdVo> list = new ArrayList<SYProdVo>();
			if (listDataJArray.size() > 0) {
				Object[] keyArr = ((JSONObject) listDataJArray.get(0)).keySet().toArray();
				for (int idx = 0; idx < listDataJArray.size(); idx++) {
					JSONObject jOb = (JSONObject)listDataJArray.get(idx);
					SYProdVo tmpVo = new SYProdVo();
					for( Object key : keyArr ){
						String nKey = key.toString();
						String nValue = jOb.get(nKey).toString();
						if( "pordno_pop".equals(nKey) )
							tmpVo.setPordno_pop(nValue);
						else if( "pordno_seq".equals(nKey) )
							tmpVo.setPordno_seq(nValue);
						else if( "routing_gno".equals(nKey) )
							tmpVo.setRouting_gno(nValue);
						else if( "routing_no".equals(nKey) )
							tmpVo.setRouting_no(nValue);
							
					}
					list.add(tmpVo);
				}
			}
			resultCnt = sYprodService.deletetProdOrdTbl(list);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", resultCnt);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	*/
	@ResponseBody
	@RequestMapping(value = "/scm/cancel_approval_matr", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String cancel_approval_matr(@ModelAttribute SYWfwotherVo scmRVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.cancel_approval_matr() is called.");
		JSONObject resultData = new JSONObject();
		try {
			String userId = SessionUtil.getMemberId(request);
		
			scmRVo.setUpdater(userId);
			scmRVo.setStatus("f1");
			
			int result = sYscmService.cancel_approval_matr(scmRVo);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
//	@ResponseBody
//	@RequestMapping(value = "/hub/dmrPba_insert", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
//	@SuppressWarnings("unchecked")
//	public String dmrPba_insert(@ModelAttribute SYDmrPbaVo dVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		logger.debug("FrontendController.dmrPba_insert() is called.");
//		JSONObject resultData = new JSONObject();
//		int resultCnt = 0;
////		JSONArray listDataJArray = new JSONArray();
////		JSONParser jsonParser = new JSONParser();
//		
//		try{
////			listDataJArray = (JSONArray)jsonParser.parse(params);
//			dVo.setParams(request.getParameter("params"));
//			dVo.setCreator(SessionUtil.getMemberId(request));
//			dVo.setUpdater(SessionUtil.getMemberId(request));
//			resultCnt = sYhubService.dmrPba_insert(dVo);
//			if( resultCnt>0 ) {
//				resultData.put("status", HttpStatus.OK.value());
//				resultData.put("result", resultCnt);
//			} else {
//				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
//				resultData.put("result", "0");
//			}
//		} catch(Exception e) {
//			e.printStackTrace();
//			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
//		}
//		return resultData.toJSONString();
//	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/ecrMaster_insert", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String ecrMaster_insert(@ModelAttribute SYDmrMasterVo dVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.ecrMaster_insert is called.");
		JSONObject resultData = new JSONObject();
		int resultCnt = 0;
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try{
			String creater = SessionUtil.getMemberId(request);
			String updater = SessionUtil.getMemberId(request);
			String masterData = request.getParameter("masterData");
			 
			// master data
			SYDmrMasterVo mVo = new SYDmrMasterVo();
			mVo.setCreator(creater);
			mVo.setUpdater(updater);
			JSONObject mObj = (JSONObject)jsonParser.parse(masterData);
			Object[] mKeyArr = mObj.keySet().toArray();
			for(Object key : mKeyArr) {
				String nKey = key.toString();
				String nValue = (mObj.get(nKey)==null)?"":mObj.get(nKey).toString();
				if ( "p_dept_cd".equals(nKey) ) mVo.setDept_cd(nValue);                  //ECR 관리 사업부 코드
				else if ( "p_confirm_date".equals(nKey) ) mVo.setConfirm_date(nValue);   //ECR 관리 적용일자
				else if ( "p_change_remark".equals(nKey) ) mVo.setChange_remark(nValue); //ECR 관리 제품 모델
				else if ( "p_change_memo".equals(nKey) ) mVo.setChange_memo(nValue);     //ECR 세부항목
				else if ( "p_special_note".equals(nKey) ) mVo.setSpecial_note(nValue);   //ECR INFORMATION
				else if ( "p_ecr_no".equals(nKey) ) mVo.setEcr_no(nValue);               //ECR 설계변경 번호
		
			}

			resultCnt = sYhubService.ecrMaster_insert(mVo);

			if( resultCnt>0 ) {
				
			/*	resultData= sapMasterService.zmmfm_goodsmvt_cancel(sVo, "ZMMFM_GOODSMVT_CANCEL");

				JSONArray rows_arr = (JSONArray)resultData.get("rows");
				JSONObject rows_obj = (JSONObject)rows_arr.get(0);
				String ev_status = rows_obj.get("ev_status").toString();*/
				
				
				resultData= sYhubService.ZIFFM_MES_PP009(mVo, "ZIFFM_MES_PP009");
				
				 
				String ev_status = resultData.get("status").toString(); 
				String message = resultData.get("message").toString(); 
				
				System.out.println("ev_status     " +ev_status);
				System.out.println("message     " +message);
				
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("result", resultCnt);
			} else {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("result", "0");
			}
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/ecrMaster_select", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String ecrMaster_select(@ModelAttribute SYDmrMasterVo dVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.ecrMaster_select is called.");
		JSONObject resultData = new JSONObject();
		List<SYDmrMasterVo> iList = null;
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try{
			iList = sYhubService.ecrMaster_select(dVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, iList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	/*@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/scm/issue_getStep1", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String issue_getStep1(@ModelAttribute SYScmIssueDetailVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.issue_getStep1() is called.");
		JSONObject resultData = new JSONObject();
		JSONObject resultObj = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		List<SYScmIssueDetailVo> list = new ArrayList<SYScmIssueDetailVo>();
		try{
			list = sYscmService.issue_getStep1(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	
	/*@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/scm/issue_getSteps", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String issue_getSteps(@ModelAttribute SYScmIssueDetailVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.issue_getSteps() is called.");
		JSONObject resultData = new JSONObject();
		JSONObject resultObj = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		List<SYScmIssueDetailVo> list = new ArrayList<SYScmIssueDetailVo>();
		try{
			list = sYscmService.issue_getSteps(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	
	/*@ResponseBody
	@RequestMapping(value = "/prod/fnFaultConf", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String fnFaultConf(@ModelAttribute SYSernrManageVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.fnFaultConf() is called.");
		JSONObject resultData = new JSONObject();
		JSONObject resultObj = new JSONObject();
		JSONObject resultObj_move = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		String user_id = SessionUtil.getMemberId(request);
		System.out.println("########################################");
		String fault_no = sYprodService.faultKeySelect();
		System.out.println("fault_no :::::::::::::::::::::::: " + fault_no);
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));
			String jsonStr = request.getParameter("jsonStr");

			String lgort = "2710";
			String dept_cd = request.getParameter("dept_cd");
			String sapord_lgort = request.getParameter("sapord_lgort");
			String pordno_pop = request.getParameter("pordno_pop");
			String routing_no = request.getParameter("routing_no");
			String t_gubun = request.getParameter("t_gubun");
			
			JSONObject lgortObj = new JSONObject();
			JSONObject lgortObj_1110 = new JSONObject();
			JSONObject lgortObj_1210 = new JSONObject();
			
//			lgortObj_1110.put("21", "2160");	
//			lgortObj_1110.put("22", "2260");
//			lgortObj_1110.put("23", "2370");
//			lgortObj_1110.put("31", "3160");
//			lgortObj_1210.put("21", "2160");
//			lgortObj_1210.put("31", "3160");
//			lgortObj.put("1110", lgortObj_1110);
//			lgortObj.put("1210", lgortObj_1210);
			
			lgortObj_1110.put("21", "2170");	
			lgortObj_1110.put("22", "2270");
			lgortObj_1110.put("23", "2370");
			lgortObj_1110.put("31", "3170");
			lgortObj_1110.put("51", "5170");
			lgortObj_1210.put("21", "2170");
			lgortObj_1210.put("31", "3170");
			lgortObj_1210.put("51", "5170");
			lgortObj.put("1110", lgortObj_1110);
			lgortObj.put("1210", lgortObj_1210);
			
			
			
			 * 1. 받아온 그리드 데이터를 vo로 만든다. 2. 기존 저장되어 있는 데이터와 같은 데이터가 있으면, reverse
			 * 항목에 "X" 를 세팅한다. 3. 007 에 전달한다.
			 
			// string to json list
			listDataJArray = (JSONArray) jsonParser.parse(jsonStr);

			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar c1 = Calendar.getInstance();
			String strToday = sdf.format(c1.getTime());

			List<SYSernrManageVo> iVoList = new ArrayList<SYSernrManageVo>();
			List<SYSernrManageVo> commonVoList = new ArrayList<SYSernrManageVo>();
			if (listDataJArray.size() > 0) {
				JSONObject jOb = (JSONObject) listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();
				for (int idx = 0; idx < listDataJArray.size(); idx++) {
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject) listDataJArray.get(idx);
					SYSernrManageVo tmpVo = new SYSernrManageVo();
					tmpVo.setPordno_pop(sVo.getPordno_pop());
					tmpVo.setPordno(sVo.getPordno());
					tmpVo.setBudat(strToday);
					tmpVo.setRouting_gno(sVo.getRouting_gno());
					tmpVo.setRouting_no(sVo.getRouting_no());
					tmpVo.setDept_cd(dept_cd);
					for (Object key : keyArr) {
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						if ("matnr".equals(nKey))
							tmpVo.setMatnr(nValue);
						else if ("meins".equals(nKey))
							tmpVo.setMeins(nValue);
						else if ("sernr".equals(nKey)) 
							tmpVo.setSernr(nValue);
						else if ("sernr_seq".equals(nKey)) 
							tmpVo.setSernr_seq(nValue);
						else if ("lgort".equals(nKey))
							tmpVo.setLgort(nValue);
						else if ("menge".equals(nKey)) {
							tmpVo.setBdmng(nValue);
							tmpVo.setMenge(nValue);
						}
						else if ("org_menge".equals(nKey)) {
							tmpVo.setOrg_menge(nValue);
						}		
						else if ("rfc_chk".equals(nKey))
							tmpVo.setRfc_chk(nValue);
//						else if ("aufnr".equals(nKey))
//							tmpVo.setAufnr(nValue);
						else if ("aufnr".equals(nKey))
							tmpVo.setPordno(nValue);
						else if ("werks".equals(nKey))
							tmpVo.setWerks(nValue);
						else if ("maktx".equals(nKey))
							tmpVo.setMaktx(nValue);
						
						else if ("org_issue_code".equals(nKey))
							tmpVo.setOrg_issue_code(nValue);
						else if ("org_issue_memo".equals(nKey))
							tmpVo.setOrg_issue_memo(nValue);
						else if ("org_remark".equals(nKey))
							tmpVo.setOrg_remark(nValue);
					}
					iVoList.add(idx, tmpVo);
					commonVoList.add(idx, tmpVo);
				}
			}
			// 2. 리버스대상 "Q" 플래그 넣어 저장
			List<SYSernrManageVo> delVoList = new ArrayList<SYSernrManageVo>();
			List<SYSernrManageVo> moveVoList = new ArrayList<SYSernrManageVo>();
			for (SYSernrManageVo lVo : commonVoList) {
				float menge = Float.parseFloat(lVo.getMenge());
				String rfc_chk = lVo.getRfc_chk();
				if( menge>=0 && rfc_chk.equals("Y")) {
					lVo.setReverse("Q");
					String f_lgort = lVo.getLgort().substring(0, 2);
					lVo.setF_lgort(lVo.getLgort());	//fault_his_tbl() 에 들어갈 F창고
					String t_lgort = ((JSONObject)lgortObj.get(dept_cd)).get(f_lgort).toString();	
					lVo.setLgort(t_lgort);	//리버스 대상 자재들 lgort from창고가 아니라 to창고로 들어가야함..
					lVo.setT_lgort(t_lgort);//fault_his_tbl() 에 들어갈 T창고
					
					delVoList.add(lVo);
				} else {
					moveVoList.add(lVo);
				}
			}

			System.out.println("delVoList : " + delVoList.toString());
			if(delVoList.size() != 0) {
				String target_ds = "Material fault processing";
				resultObj = sapMasterService.ziffm_mes_pp007("ZIFFM_MES_PP007", delVoList, dept_cd, user_id, target_ds);
			}
			
			String inFzifsta = null;
			String inFzifmsg = null;
			
			if(resultObj.get("zifsta")!=null){
				inFzifsta = resultObj.get("zifsta").toString();
				inFzifmsg = resultObj.get("zifmsg").toString();
				
				
				if(resultObj.get("zifsta").equals("S")) {
					if( delVoList.size()>0 ){
						for ( SYSernrManageVo vo : delVoList) {
							SYSernrManageVo tmpVo = new SYSernrManageVo();
							tmpVo.setPordno_pop(vo.getPordno_pop());
							tmpVo.setRouting_no(vo.getRouting_no());
							tmpVo.setMatnr(vo.getMatnr());
							tmpVo.setSernr(vo.getSernr());
							tmpVo.setSernr_seq(vo.getSernr_seq());
							tmpVo.setOrg_menge(vo.getOrg_menge());
							
							int org_menge = (int)Math.floor(Float.parseFloat(vo.getOrg_menge()));
							int menge = (int)Math.floor(Float.parseFloat(vo.getMenge()));

							if(org_menge == menge) {
								sYprodService.deleteSernrManageTbl(tmpVo);	
							} else {
								SYSernrManageVo pVo = new SYSernrManageVo();
								pVo.setPordno_pop(vo.getPordno_pop());
								pVo.setSernr_seq(vo.getSernr_seq());
								List<SYSernrManageVo> result_smt = sYprodService.selectSernrManageTbl(pVo);
								
								sYprodService.deleteSernrManageTbl(vo);
													
								result_smt.get(0).setMenge(Integer.toString(org_menge - menge));
								
								sYprodService.insertSernrManageTbl(result_smt.get(0));
							}
								
								
						}
					}

					sYprodService.faultHisInsert(delVoList, user_id, routing_no, fault_no);
				}
			}
			////////////////////////////////////////////////////////////////////////////////////////////////////
			String funcName = null; 
			String item_tbl = null;
			String sernr_tbl = null;
			
			JSONArray m_jobj_arr = new JSONArray();
			JSONArray d_jobj_arr = new JSONArray();
			
			for(int i =0 ; i<moveVoList.size() ; i++) {
				
				JSONObject m_jobj = new JSONObject();
				JSONObject d_jobj = new JSONObject();

				m_jobj.put("material", moveVoList.get(i).getMatnr());
				m_jobj.put("move_type", "311");
				m_jobj.put("plant", moveVoList.get(i).getWerks());
				m_jobj.put("stge_loc", moveVoList.get(i).getLgort());//f
				moveVoList.get(i).setF_lgort(moveVoList.get(i).getLgort());//fault_his_tbl() 에 들어갈 F창고
				m_jobj.put("move_mat", moveVoList.get(i).getMatnr());
				m_jobj.put("move_plant", moveVoList.get(i).getWerks());
//				m_jobj.put("move_stloc", lgort);
				String fromLgort = moveVoList.get(i).getLgort();
				String fromLgort_std = fromLgort.substring(0, 2); 
				System.out.println(fromLgort);
				System.out.println(fromLgort_std);
				System.out.println(lgortObj.toJSONString());
				System.out.println(lgortObj.get(dept_cd));
				System.out.println(((JSONObject)lgortObj.get(dept_cd)));
				System.out.println(((JSONObject)lgortObj.get(dept_cd)).get(fromLgort_std));
				if( lgortObj.get(dept_cd)!=null && ((JSONObject)lgortObj.get(dept_cd)).get(fromLgort_std)!=null ) {
//					String toLgort = ((JSONObject)lgortObj.get(dept_cd)).get(fromLgort).toString();
					String toLgort = ((JSONObject)lgortObj.get(dept_cd)).get(fromLgort_std).toString();
					m_jobj.put("move_stloc", toLgort);
					moveVoList.get(i).setT_lgort(toLgort); //fault_his_tbl() 에 들어갈 T창고
				} else {
					m_jobj.put("move_stloc", lgort);
				}
				m_jobj.put("entry_qnt", moveVoList.get(i).getMenge());
				m_jobj.put("entry_uom", moveVoList.get(i).getMeins());
				m_jobj.put("gr_rcpt", SessionUtil.getMemberId(request));
				
				////////////////////////////////////
				m_jobj.put("serialno", moveVoList.get(i).getSernr());
				////////////////////////////////////
				
				if(moveVoList.get(i).getSernr().trim().length() != 0) {
					d_jobj.put("material", moveVoList.get(i).getMatnr());
					d_jobj.put("serialno",  moveVoList.get(i).getSernr());
					
					d_jobj_arr.add(d_jobj);
				}
				m_jobj_arr.add(m_jobj);

			}
			
			item_tbl = m_jobj_arr.toJSONString();
			sernr_tbl = d_jobj_arr.toJSONString();
			String func_name = "ZMMFM_GOODSMVT_ST";
			
			if(moveVoList.size() != 0) {
				resultObj_move = sapMasterService.zmmfm_goodsmvt_st_1(func_name, item_tbl, sernr_tbl, strToday);
			}
			
			///////////////////////////
			String e_return = null;
			String e_message = null;
			
			if(resultObj_move.get("e_return")!=null){
				e_return = resultObj_move.get("e_return").toString();
				e_message = resultObj_move.get("e_message").toString();
				
				System.out.println("e_return :: " + e_return);
				System.out.println("e_message :: " + e_message);
				
				if(resultObj_move.get("e_return").equals("S")) {
					if( moveVoList.size()>0 ){
						sYprodService.faultHisInsert(moveVoList, user_id, routing_no, fault_no);
					}
				}
//				if(resultObj_move.get("e_return").equals("S")) {
//					if( moveVoList.size()>0 ){
//						for ( SYSernrManageVo vo : moveVoList) {
//							SYPissueInspectionVo tmpVo = new SYPissueInspectionVo();
//							
//							tmpVo.setInsts("ST");
//							tmpVo.setLgort(vo.getLgort());
//							tmpVo.setBudat(strToday);
//							tmpVo.setRouting_no(routing_no);
//							tmpVo.setOrg_no(vo.getAufnr());
//							tmpVo.setT_gubun(t_gubun);        
//							tmpVo.setOrg_issue_code(vo.getOrg_issue_code()); 
//							tmpVo.setOrg_issue_memo(vo.getOrg_issue_memo());
//							tmpVo.setOrg_remark(vo.getOrg_remark());
//							tmpVo.setMatnr(vo.getMatnr());      
//							tmpVo.setMaktx(vo.getMaktx());          
//							tmpVo.setMeins(vo.getMeins());          
//							tmpVo.setBdmng(vo.getMenge());          
//							tmpVo.setSernp_no(vo.getSernr());  
//							tmpVo.setWerks(vo.getWerks());
//							tmpVo.setMblnr(resultObj_move.get("ev_mblnr").toString());          
//							tmpVo.setMjahr(resultObj_move.get("ev_mjahr").toString());          
//							tmpVo.setCreator(SessionUtil.getMemberId(request));
//							tmpVo.setUpdater(SessionUtil.getMemberId(request));
//							
//							sYprodService.insertPissueInspectionTbl(tmpVo);
//						}
//					}
//				}
			}
			
			///////////////////////////
			
			//ZIFFM_MES_PP007 rfc 처리결과 
			resultData.put("inFzifsta", inFzifsta);
			resultData.put("inFzifmsg", inFzifmsg);
			
			//zmmfm_goodsmvt_st rfc 처리결과
			resultData.put("e_return", e_return);
			resultData.put("e_message", e_message);
			
			resultData.put("result", resultObj.toJSONString());
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		
		System.out.println("##############################################resultObj.toJSONString()");
		System.out.println(resultObj.toJSONString());
		return resultData.toJSONString();
	}*/
	
	/*
	@ResponseBody
	@RequestMapping(value = "/prod/fnProdFaultConf", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String fnProdFaultConf(@ModelAttribute SYSernrManageVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.fnProdFaultConf() is called.");
		JSONObject resultData = new JSONObject();
		JSONObject resultObj = new JSONObject();
		JSONObject resultObj_move = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));
			String jsonStr = request.getParameter("jsonStr");


			String deptcd = request.getParameter("deptcd");
		
			String pordno_pop = request.getParameter("pordno_pop");
			String routing_no = request.getParameter("routing_no");
			String t_gubun = request.getParameter("t_gubun");
			
			listDataJArray = (JSONArray) jsonParser.parse(jsonStr);

			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar c1 = Calendar.getInstance();
			String strToday = sdf.format(c1.getTime());

			List<SYSernrManageVo> iVoList = new ArrayList<SYSernrManageVo>();
			List<SYSernrManageVo> commonVoList = new ArrayList<SYSernrManageVo>();
			if (listDataJArray.size() > 0) {
				JSONObject jOb = (JSONObject) listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();
				for (int idx = 0; idx < listDataJArray.size(); idx++) {
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject) listDataJArray.get(idx);
					SYSernrManageVo tmpVo = new SYSernrManageVo();
					tmpVo.setPordno_pop(sVo.getPordno_pop());
					tmpVo.setPordno(sVo.getPordno());
					tmpVo.setBudat(strToday);
					tmpVo.setRouting_gno(sVo.getRouting_gno());
					tmpVo.setRouting_no(sVo.getRouting_no());
					tmpVo.setDept_cd(deptcd);
					for (Object key : keyArr) {
						String nKey = key.toString();
						String nValue = ( jObj.get(nKey) == null)?"":jObj.get(nKey).toString();

					//	String nValue = jObj.get(nKey).toString();
						if ("matnr".equals(nKey))
							tmpVo.setMatnr(nValue);
						else if ("meins".equals(nKey))
							tmpVo.setMeins(nValue);
						else if ("sernr".equals(nKey)) 
							tmpVo.setSernr(nValue);
						else if ("lgort".equals(nKey))
							tmpVo.setLgort(nValue);
						// else if ("menge".equals(nKey))
						// tmpVo.setBdmng(nValue);
						else if ("menge".equals(nKey)) {
							tmpVo.setBdmng(nValue);
							tmpVo.setMenge(nValue);
						}		
						else if ("aufnr".equals(nKey))
							tmpVo.setAufnr(nValue);
						else if ("werks".equals(nKey))
							tmpVo.setWerks(nValue);
						else if ("maktx".equals(nKey))
							tmpVo.setMaktx(nValue);
						
						else if ("org_issue_code".equals(nKey))
							tmpVo.setOrg_issue_code(nValue);
						else if ("org_issue_memo".equals(nKey))
							tmpVo.setOrg_issue_memo(nValue);
						else if ("org_remark".equals(nKey))
							tmpVo.setOrg_remark(nValue);
					}
					commonVoList.add(idx, tmpVo);
				}
			}
		if( commonVoList.size()>0 ){
		
			for ( SYSernrManageVo vo : commonVoList) {
				SYPissueInspectionVo tmpVo = new SYPissueInspectionVo();
				SYQmVo  pVo = new SYQmVo();
				tmpVo.setInsts("ST");
				tmpVo.setBudat(strToday);
				tmpVo.setRouting_no(routing_no);
				tmpVo.setOrg_no(vo.getAufnr());
				tmpVo.setT_gubun(t_gubun);
				tmpVo.setLgort(vo.getLgort()); 
				tmpVo.setOrg_issue_code(vo.getOrg_issue_code()); 
				tmpVo.setOrg_issue_memo(vo.getOrg_issue_memo());
				tmpVo.setOrg_remark(vo.getOrg_remark());
				tmpVo.setMatnr(vo.getMatnr());      
				tmpVo.setMaktx(vo.getMaktx());          
				tmpVo.setMeins(vo.getMeins());          
				tmpVo.setBdmng(vo.getMenge());          
				tmpVo.setSernp_no(vo.getSernr());   
				tmpVo.setWerks(vo.getWerks());
				tmpVo.setCreator(SessionUtil.getMemberId(request));
				tmpVo.setUpdater(SessionUtil.getMemberId(request));
				
				pVo.setPdsts("p13");
				pVo.setPordno(vo.getAufnr());
				
				sYprodService.insertPissueInspectionTbl(tmpVo);
				sYqmService.prodTbl_pdsts_update(pVo);
			}
		}
		// 공정 불량 시 status 비가동 처리 : start
		
		SYProdVo pVo = new SYProdVo();
		pVo.setPordno(pordno_pop.substring(0, 10));
		pVo.setPordno_pop(pordno_pop);
		pVo.setRouting_no(routing_no);
		
		String pdsts = sYprodService.getProdStatus(pVo).getPdsts();
		
		if (pdsts.equals("p3") ||  pdsts.equals("p5")) { 
			pVo.setPdsts("p4");	//작업시작, 재가동 상태일때 비가동처리
			sYprodService.workPauseHisStart_insert(pVo);
			sYprodService.prod_stat_update(pVo);
		} else if (pdsts.equals("p4")) {
			pVo.setPdsts("p5"); //비가동 상태일때 비가동종료(재가동)처리
			sYprodService.workPauseHisEnd_insert(pVo);
			pVo.setPdsts("p4");	//비가동 처리
			sYprodService.workPauseHisStart_insert(pVo);
			sYprodService.prod_stat_update(pVo);
		} 
		
		pVo.setPdsts("p13");
		sYprodService.prodTbl_pdsts_update(pVo);
		// 공정 불량 시 status 비가동 처리 : end
			
			resultData.put("result", resultObj.toJSONString());
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	
	@ResponseBody
	@RequestMapping(value = "/qm/standby_inspection_select", method = { RequestMethod.GET,RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String standby_inspection_select(@ModelAttribute SYQmInspectionVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.standby_inspection() is called.");
		
		List<SYQmInspectionVo> listCode = null;
		
		JSONObject resultData = new JSONObject();
		
		String gubun = request.getParameter("gubun");


		int currentPage = Integer.parseInt(request.getParameter("page")); 
	    int pageRows = Integer.parseInt(request.getParameter("rows")); 
	    int startIndex = currentPage * pageRows - pageRows; 
	    int totalRows = 0;
	    
		sVo.setPage(startIndex);
		sVo.setRows(pageRows);
		
		  /*t_gubun  value="tp"    제품不
	        t_gubun  value="tw"    공정不
	        t_gubun  value="tl"    최종검사不
	        t_gubun  value="td"    포장검사不 
	        insts            value="ST"    대기
	        insts            value="SS"    처리완료
	        */
		 
			totalRows = sYqmService.standby_inspection_select_count(sVo);
			listCode = sYqmService.standby_inspection_select(sVo);
		//	listCode = sYqmService.last_inspection_select(sVo);
		 
		try {
			resultData = ResponseUtils.getJQGridJsonResponse(response, listCode, currentPage, pageRows, totalRows);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		
		return resultData.toJSONString();
	}
	/*
	@ResponseBody
	@RequestMapping(value = "/qm/standby_inspection_process", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String standby_inspection_process(@ModelAttribute SYSernrManageVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.standby_inspection_process() is called.");
		JSONObject resultData = new JSONObject();
		JSONObject resultObj = new JSONObject();
		JSONObject resultObj_move = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));
			
			String jsonStr = request.getParameter("jsonStr");

			String cmdat = request.getParameter("cmdat");
			String move_stloc = request.getParameter("move_stloc");
			String insp_yn = request.getParameter("insp_yn");
			String move_plant = request.getParameter("move_plant");
			
			String sernpNos = request.getParameter("sernpNos");
			sernpNos = (sernpNos==null)?"":sernpNos;	
			
			String insts = request.getParameter("insts");
	

			// string to json list
			listDataJArray = (JSONArray) jsonParser.parse(jsonStr);

			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar c1 = Calendar.getInstance();
			String strToday = sdf.format(c1.getTime());

			List<SYPissueInspectionVo> commonVoList = new ArrayList<SYPissueInspectionVo>();
			if (listDataJArray.size() > 0) {
				JSONObject jOb = (JSONObject) listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();
				String[] sernrArr = null;
				for (int idx = 0; idx < listDataJArray.size(); idx++) {
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject) listDataJArray.get(idx);
					SYPissueInspectionVo tmpVo = new SYPissueInspectionVo();
					tmpVo.setCmdat(cmdat);
					tmpVo.setMove_stloc(move_stloc);
					
					
					int num =0;
					
					for (Object key : keyArr) {
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();						
						if ("budat".equals(nKey))
							tmpVo.setBudat(nValue);
						else if ("cmdat".equals(nKey))
							tmpVo.setCmdat(nValue);
						else if ("inspec_lot".equals(nKey))
							tmpVo.setInspec_lot(nValue);
						else if ("insts_nm".equals(nKey))
							tmpVo.setInsts_nm(nValue);
						else if ("werks_nm".equals(nKey))
							tmpVo.setWerks_nm(nValue);
						else if ("org_no".equals(nKey))
							tmpVo.setOrg_no(nValue);
						else if ("matnr".equals(nKey))
							tmpVo.setMatnr(nValue);
						else if ("maktx".equals(nKey))
							tmpVo.setMaktx(nValue);
						else if ("sernp_no".equals(nKey)) {
							sernrArr = nValue.split(",");
							tmpVo.setSernp_no(sernrArr[idx]);
						}
						else if ("org_issue_memo".equals(nKey))
							tmpVo.setOrg_issue_memo(nValue);
						else if ("issue_memo".equals(nKey))
							tmpVo.setIssue_memo(nValue);
						else if ("issue_code".equals(nKey))
							tmpVo.setIssue_code(nValue);
						else if ("insts".equals(nKey))
							tmpVo.setInsts(nValue);
						else if ("werks".equals(nKey))
							tmpVo.setWerks(nValue);
						else if ("mblnr".equals(nKey))
							tmpVo.setMblnr(nValue);
						else if ("mjahr".equals(nKey))
							tmpVo.setMjahr(nValue);
						else if ("ref_doc_no".equals(nKey))
							tmpVo.setRef_doc_no(nValue);
						else if ("sernp_no".equals(nKey))
							tmpVo.setSernp_no(nValue);
						else if ("meins".equals(nKey))
							tmpVo.setMeins(nValue);
						else if ("bdmng".equals(nKey))
							tmpVo.setBdmng(nValue);
						else if ("lgort".equals(nKey))
							tmpVo.setLgort(nValue);
					}
					num++;
					commonVoList.add(idx, tmpVo);
				}
			}
			*//********************************자재불량처리 : start******************************************//*
			if(insts.equals("tp")) {
				
				String func_name = "ZMMFM_GOODSMVT_ST";
				String item_tbl = null;
				String sernr_tbl = null;
				
				JSONArray m_jobj_arr = new JSONArray();
				JSONArray d_jobj_arr = new JSONArray();
				
				for(int i =0 ; i<commonVoList.size() ; i++) {
					
					JSONObject m_jobj = new JSONObject();
					JSONObject d_jobj = new JSONObject();
	
					m_jobj.put("material", commonVoList.get(i).getMatnr());
					m_jobj.put("move_type", "311");
					m_jobj.put("plant", commonVoList.get(i).getWerks());
					m_jobj.put("stge_loc", commonVoList.get(i).getLgort());
					m_jobj.put("move_mat", commonVoList.get(i).getMatnr());
					m_jobj.put("move_plant", move_plant);
					m_jobj.put("move_stloc", move_stloc);
					m_jobj.put("entry_qnt", commonVoList.get(i).getBdmng());
					m_jobj.put("entry_uom", commonVoList.get(i).getMeins());
					m_jobj.put("gr_rcpt", SessionUtil.getMemberId(request));
					m_jobj.put("serialno",  commonVoList.get(i).getSernp_no());
					if(commonVoList.get(i).getSernp_no().trim().length() != 0) {
						d_jobj.put("material", commonVoList.get(i).getMatnr());
						d_jobj.put("serialno",  commonVoList.get(i).getSernp_no());
						
						d_jobj_arr.add(d_jobj);
					}
					m_jobj_arr.add(m_jobj);
	
				}
				
				item_tbl = m_jobj_arr.toJSONString();
				sernr_tbl = d_jobj_arr.toJSONString();
				
				System.out.println("***********************pram list******************************");
			
				System.out.println(item_tbl);
				System.out.println(sernr_tbl);
				System.out.println("***********************pram list******************************");
	
				if(commonVoList.size() != 0) {
					resultObj_move = sapMasterService.zmmfm_goodsmvt_st_1(func_name, item_tbl, sernr_tbl, strToday);
				}
				
	
				String e_return = null;
				String e_message = null;
				String ev_ref_doc_no = null;
				String ev_mblnr = null;
				String ev_mjahr = null;
				
				if(resultObj_move.get("e_return")!=null){
					e_return = resultObj_move.get("e_return").toString();
					e_message = resultObj_move.get("e_message").toString();
					ev_ref_doc_no = resultObj_move.get("ev_ref_doc_no").toString();
					ev_mblnr = resultObj_move.get("ev_mblnr").toString();
					ev_mjahr = resultObj_move.get("ev_mjahr").toString();
					
	
					
					
					if(e_return.equals("S")) {
						if( commonVoList.size()>0 ){
							for ( SYPissueInspectionVo vo : commonVoList) {
								SYPissueInspectionVo tmpVo = new SYPissueInspectionVo();
								
								if(insp_yn.equals("Y")) {
									tmpVo.setInsts("SS");
									tmpVo.setCmdat(cmdat);
									tmpVo.setIssue_code(vo.getIssue_code());
									tmpVo.setIssue_memo(vo.getIssue_memo());
									tmpVo.setInsp_yn(insp_yn);
									tmpVo.setS_mblnr(ev_mblnr);
									tmpVo.setS_mjahr(ev_mjahr);
									tmpVo.setSernp_no(sernpNos);
									tmpVo.setUpdater(SessionUtil.getMemberId(request));
									
									tmpVo.setInspec_lot(vo.getInspec_lot());
								} else {
									tmpVo.setInsts("SS");
									tmpVo.setCmdat(cmdat);
									tmpVo.setIssue_code(vo.getIssue_code());
									tmpVo.setIssue_memo(vo.getIssue_memo());
									tmpVo.setInsp_yn(insp_yn);
									tmpVo.setN_mblnr(ev_mblnr);
									tmpVo.setN_mjahr(ev_mjahr);
									tmpVo.setSernp_no(sernpNos);
									tmpVo.setUpdater(SessionUtil.getMemberId(request));
									
									tmpVo.setInspec_lot(vo.getInspec_lot());
								}
								int result = sYprodService.updatePissueInspectionTbl(tmpVo);
							}
						}
					}
				}
								
				//zmmfm_goodsmvt_st rfc 처리결과
				resultData.put("e_return", e_return);
				resultData.put("e_message", e_message);
				
				System.out.println("***********************zmmfm_goodsmvt_st rfc 처리결과******************************");
				System.out.println("e_return :: " + e_return);
				System.out.println("e_message :: " + e_message);
				System.out.println("ev_mblnr :: " + ev_mblnr);
				System.out.println("ev_mjahr :: " + ev_mjahr);
				System.out.println("***********************zmmfm_goodsmvt_st rfc 처리결과******************************");
			
			*//********************************자재불량처리 : end******************************************//*
				
			*//********************************공정불량처리 : start******************************************//*
			} else if(insts.equals("tw")) {
				
				if( commonVoList.size()>0 ){
					for ( SYPissueInspectionVo vo : commonVoList) {
						SYPissueInspectionVo tmpVo = new SYPissueInspectionVo();
						
						if(insp_yn.equals("Y")) {
							tmpVo.setInsts("SS");
							tmpVo.setCmdat(cmdat);
							tmpVo.setIssue_code(vo.getIssue_code());
							tmpVo.setIssue_memo(vo.getIssue_memo());
							tmpVo.setInsp_yn(insp_yn);
							tmpVo.setUpdater(SessionUtil.getMemberId(request));
							
							tmpVo.setInspec_lot(vo.getInspec_lot());
						} else {
							tmpVo.setInsts("SS");
							tmpVo.setCmdat(cmdat);
							tmpVo.setIssue_code(vo.getIssue_code());
							tmpVo.setIssue_memo(vo.getIssue_memo());
							tmpVo.setInsp_yn(insp_yn);
							tmpVo.setUpdater(SessionUtil.getMemberId(request));
							
							tmpVo.setInspec_lot(vo.getInspec_lot());
						}
						int result = sYprodService.updatePissueInspectionTbl(tmpVo);
					}
				}
			}
			*//********************************공정불량처리 : end******************************************//*	
			
			resultData.put("result", resultObj.toJSONString());
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	*/
	/*@ResponseBody
	@RequestMapping(value = "/prod/reWorkProc", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String reWorkProc(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.reWorkProc() is called.");
		JSONObject resultData = new JSONObject();
		try {
			prodVo.setCreator(SessionUtil.getMemberId(request));
			prodVo.setUpdater(SessionUtil.getMemberId(request));
			
			String pordno = prodVo.getPordno_pop().substring(0, 10);
			String pordno_pop = prodVo.getPordno_pop();              
			String routing_no = prodVo.getRouting_no();              
			
			List<SYProdVo> list = sYprodService.getReworkSubjectData(prodVo);
			
			SYProdVo pVo = new SYProdVo();
			for(int i=0 ; i<list.size(); i++) {
				pVo = new SYProdVo();
				pVo.setPordno(pordno);
				pVo.setPordno_pop(pordno_pop);
				pVo.setRouting_no(list.get(i).getRouting_no());
			
				String pdsts = sYprodService.getProdStatus(pVo).getPdsts();
				
				if (pdsts.equals("p3") ||  pdsts.equals("p5")) { 
					pVo.setPdsts("p6");
					sYprodService.workEnd_update(pVo);
					sYprodService.prodOrd_stat_update(pVo);
					pVo.setPdsts("p2");
					sYprodService.prod_stat_update(pVo);
					sYprodService.prodOrd_stat_update(pVo);
				} else if (pdsts.equals("p4")) {
					pVo.setPdsts("p5");
					sYprodService.workPauseHisEnd_insert(pVo);
					pVo.setPdsts("p6");
					sYprodService.workEnd_update(pVo);
					sYprodService.prodOrd_stat_update(pVo);
					pVo.setPdsts("p2");
					sYprodService.prod_stat_update(pVo);
					sYprodService.prodOrd_stat_update(pVo);
				} else if (pdsts.equals("p6")) {
//					sYprodService.prodOrd_stat_update(pVo);
					pVo.setPdsts("p2");
					sYprodService.prod_stat_update(pVo);
					sYprodService.prodOrd_stat_update(pVo);
				}
				sYprodService.prod_stat_update(pVo);
			}
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	/*
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/prod/prodRfcConf_yn", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String prodRfcConf_yn(@ModelAttribute SYProdVo pordVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.prodRfcConf_yn() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		List<SYProdVo> listCode = null;
		String pordno = request.getParameter("pordno");
		listCode =sYprodService.prodRfcConf_yn(pordno);
		

		try{
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);

		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/qm/insp_select", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String insp_select(@ModelAttribute SYStockVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.insp_select() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		List<SYStockVo> list_data = null;
		String lgort = request.getParameter("lgort");
		String werks = request.getParameter("werks");

		
		SYStockVo pVo = new SYStockVo();
		pVo.setWerks(werks);
		pVo.setLgort(lgort);
		sYscmService.str_stock_header_delete(pVo);
		sYscmService.str_stock_detail_delete(pVo);
		
		
		
		pVo.setWerks(werks);
		sVo.setLgort(lgort);
		sYshipService.zmmfm_sloc_stock(sVo,  "ZMMFM_SLOC_STOCK");
		

		//////////////////////////////
		int currentPage = Integer.parseInt(request.getParameter("page")); 
	    int pageRows = Integer.parseInt(request.getParameter("rows")); 
	    int startIndex = currentPage * pageRows - pageRows; 
	    int totalRows = 0;
	    
		sVo.setPage(startIndex);
		sVo.setRows(pageRows);
		
		totalRows = sYqmService.insp_select_count(sVo);
		list_data = sYqmService.insp_select(sVo);

		////////////////////////
		try{

			resultData = ResponseUtils.getJQGridJsonResponse(response, list_data, currentPage, pageRows, totalRows);
			resultData.put("status", HttpStatus.OK.value());

		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/qm/fnSaveInspLot", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String fnSaveInspLot(@ModelAttribute SYStockVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.fnSaveInspLot() is called.");
		JSONObject resultData = new JSONObject();
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));
			
			String inspec_lot = sYqmService.lot_gen();
			sVo.setInspec_lot(inspec_lot);
			sYqmService.fnSaveInspLot(sVo);
						
			resultData.put("inspec_lot", inspec_lot);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	/*@ResponseBody
	@RequestMapping(value = "/prod/confirm_ord_dmr_update", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String confirm_ord_dmr_update(@ModelAttribute SYProdVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.confirm_ord_dmr_update() is called.");
//		List<SYProdVo> listCode = null;
		int result = 0;
		String pordnos = request.getParameter("pordnos");

		JSONObject resultData = new JSONObject();

		try {
			result = sYprodService.confirm_ord_dmr_update(pordnos);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
}*/
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/scm/req_stock_select", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String req_stock_select(@ModelAttribute SYStockVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.req_stock_select() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		List<SYStockVo> list_data = null;
		String lgort = request.getParameter("lgort");
		String werks = request.getParameter("werks");
		String matnrs = request.getParameter("matnrs");

		//sap - mes 자재 동기화 : Start
		SYStockVo pVo = new SYStockVo();
		
		if(matnrs != null && StringUtil.trim(matnrs).length() > 0){
			String[] arr_matnr = matnrs.split(",");
			if(arr_matnr.length > 0){
				ArrayList<String> list = new ArrayList<>();
				list.clear();
				for (String p_matnr : arr_matnr) {
					list.add(p_matnr);
				}
				pVo.setMatnrList(list);
			}
		}
				
		pVo.setWerks(werks);
		pVo.setLgort(lgort);
		
		
		sYscmService.str_stock_header_delete(pVo);
		sYscmService.str_stock_detail_delete(pVo);

		sYshipService.zmmfm_sloc_stock(pVo,  "ZMMFM_SLOC_STOCK");
		//sap - mes 자재 동기화 : End		

		//sap - mes 자재 재고 조회 : Start	
		list_data = sYshipService.stock_header_tbl_select(pVo);
		//sap - mes 자재 재고 조회 : End
		
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list_data);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}
	
	/*@ResponseBody
	@RequestMapping(value = "/prod/prodUserInfo", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String prodUserInfo(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.prodUserInfo() is called.");
		
		List<SYProdVo> listCode = null;

		listCode = sYprodService.prodUserInfo(prodVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
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
	@RequestMapping(value = "/prod/jo_select", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String jo_select(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.jo_select() is called.");

		List<SYProdVo> listCode = null;
		listCode = sYprodService.jo_select(prodVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/prod/jocod_update", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String jocod_update(@ModelAttribute SYProdVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.jocod_update() is called.");

		int result = 0;

		JSONObject resultData = new JSONObject();

		try {
			result = sYprodService.jocod_update(sVo);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
}
	
	@ResponseBody
	@RequestMapping(value = "/prod/line_header_select", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String line_header_select(@ModelAttribute SYLineVo lineVo,HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.line_header_select() is called.");

		List<SYLineVo> listCode = null;

		//listCode = sYhubService.routingHeader_select(mesVo);
		listCode = sYprodService.line_header_select(lineVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/prod/line_header_save", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String line_header_save(@ModelAttribute SYLineVo dVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.line_header_save() is called.");
		JSONObject resultData = new JSONObject();
		int resultCnt = 0;
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try{
			String creater = SessionUtil.getMemberId(request);
			String updater = SessionUtil.getMemberId(request);
			String lineData = request.getParameter("lineData");
			String dept_cd = request.getParameter("dept_cd");
	
		 
			// lineData data : master key 는 필수로 들어온다.(jsp control)
			if( !("".equals(lineData)) ) {
				JSONArray lineObjArr = (JSONArray)jsonParser.parse(lineData);
				List<SYLineVo> lineList = new ArrayList<SYLineVo>();
//				System.out.println(pbaList);
				if( lineObjArr!=null || lineObjArr.size()>0 ) {
					Object[] lineKeyArr = ((JSONObject)lineObjArr.get(0)).keySet().toArray();
					for(int idx=0; idx<lineObjArr.size(); idx++){
						SYLineVo tmpVo = new SYLineVo();
						JSONObject tmpObj = (JSONObject)lineObjArr.get(idx);
						tmpVo.setDept_cd(dept_cd);
						tmpVo.setCreator(creater);
						tmpVo.setUpdater(updater);
						
						for(Object key : lineKeyArr) {
							
							String nKey = key.toString();
							System.out.println( nKey);	
							String nValue = (tmpObj.get(nKey) == null)?"":tmpObj.get(nKey).toString();

							System.out.println( nValue);
							
							if ( "jocod".equals(nKey) ) tmpVo.setJocod(nValue);
							else if ( "line_nm".equals(nKey) ) tmpVo.setLine_nm(nValue);
							else if ( "jo_nm".equals(nKey) ) tmpVo.setJo_nm(nValue);
							 
						}
						lineList.add(tmpVo);
					}
					// line tbl insert/update
					resultCnt += sYprodService.line_header_save(lineList);
				}
			}
		 
			if( resultCnt>0 ) {
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("result", resultCnt);
			} else {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("result", "0");
			}
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/prod/line_member_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String line_member_select(@ModelAttribute SYLineVo lineVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.routingDetail_select_w2ui() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser(); 
		List<SYLineVo> listCode = null;
		try {
			int curreCntPage = lineVo.getPage(); 
			int rowCount = lineVo.getRows(); 
	//		int rowTotal = sYhubService.routingDetail_select_count(lineVo);
			int rowTotal = sYprodService.line_member_select_count(lineVo);
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
			if( rowCount*(curreCntPage+1) > rowTotal ){
				lineVo.setRows(rowTotal-(rowCount*curreCntPage));
			}
		    System.out.println(lineVo.getPage());
		    System.out.println(lineVo.getRows());
		    List<SYLineVo> list = sYprodService.line_member_select(lineVo);
		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
		    listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
		    resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	/*
	@ResponseBody
	@RequestMapping(value = "/prod/line_member_delete", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String line_member_delete(@ModelAttribute SYLineVo hubDVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.line_member_delete() is called.");
		List<SYLineVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			resultData.put("result", sYprodService.line_member_delete(hubDVo)); 
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	/*
	@ResponseBody
	@RequestMapping(value = "/prod/loadmemberinfo", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String loadmemberinfo(@ModelAttribute SYLineVo lineVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.loadmemberinfo() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser(); 
		List<SYLineVo> listCode = null;
		try {
			int curreCntPage = lineVo.getPage(); 
			int rowCount = lineVo.getRows(); 
	//		int rowTotal = sYhubService.routingDetail_select_count(lineVo);
			int rowTotal = sYprodService.loadmemberinfo_count(lineVo);
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
			if( rowCount*(curreCntPage+1) > rowTotal ){
				lineVo.setRows(rowTotal-(rowCount*curreCntPage));
			}
		    System.out.println(lineVo.getPage());
		    System.out.println(lineVo.getRows());
		    List<SYLineVo> list = sYprodService.loadmemberinfo(lineVo);
		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
		    listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
		    resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	
	/*
	@ResponseBody
	@RequestMapping(value = "/prod/fnWorkerAdd", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String fnWorkerAdd(@ModelAttribute SYLineVo dVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.line_header_save() is called.");
		JSONObject resultData = new JSONObject();
		int resultCnt = 0;
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try{
  
			String creater = SessionUtil.getMemberId(request);
			String updater = SessionUtil.getMemberId(request);
			String jocod = request.getParameter("jocod");
			String dept_cd = request.getParameter("dept_cd");
			String params = request.getParameter("params");
	
		 
			// lineData data : master key 는 필수로 들어온다.(jsp control)
			if( !("".equals(params)) ) {
				JSONArray lineObjArr = (JSONArray)jsonParser.parse(params);
				List<SYLineVo> lineList = new ArrayList<SYLineVo>();
//				System.out.println(pbaList);
				if( lineObjArr!=null || lineObjArr.size()>0 ) {
					Object[] lineKeyArr = ((JSONObject)lineObjArr.get(0)).keySet().toArray();
					for(int idx=0; idx<lineObjArr.size(); idx++){
						SYLineVo tmpVo = new SYLineVo();
						JSONObject tmpObj = (JSONObject)lineObjArr.get(idx);
						tmpVo.setJocod(jocod);
						tmpVo.setDept_cd(dept_cd);
 	
						for(Object key : lineKeyArr) {
							
							String nKey = key.toString();
							System.out.println( nKey);	
							String nValue = (tmpObj.get(nKey) == null)?"":tmpObj.get(nKey).toString();

							System.out.println( nValue);
							
							if ( "member_id".equals(nKey) ) tmpVo.setMember_id(nValue);
							else if ( "member_nm".equals(nKey) ) tmpVo.setMember_nm(nValue);
						 
							 
						}
						lineList.add(tmpVo);
					}
					// line tbl insert/update
				//	resultCnt += sYprodService.line_header_save(lineList);
					resultCnt += sYprodService.fnWorkerAdd(lineList);
				}
			}
		 
			if( resultCnt>0 ) {
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("result", resultCnt);
			} else {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("result", "0");
			}
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/
	@ResponseBody
	@RequestMapping(value = "/hub/create_veid", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String create_veid(@ModelAttribute SYVendorVo dVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.line_header_save() is called.");
		JSONObject resultData = new JSONObject();
		int resultCnt = 0;
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try{
  
			String creater = SessionUtil.getMemberId(request);
			String updater = SessionUtil.getMemberId(request);
			String dept_cd = request.getParameter("dept_cd");
			String params = request.getParameter("params");
			String id_yn = "Y";

			// lineData data : master key 는 필수로 들어온다.(jsp control)
			if( !("".equals(params)) ) {
				JSONArray lineObjArr = (JSONArray)jsonParser.parse(params);
				List<SYVendorVo> lineList = new ArrayList<SYVendorVo>();
//				System.out.println(pbaList);
				if( lineObjArr!=null || lineObjArr.size()>0 ) {
					Object[] lineKeyArr = ((JSONObject)lineObjArr.get(0)).keySet().toArray();
					for(int idx=0; idx<lineObjArr.size(); idx++){
						SYVendorVo tmpVo = new SYVendorVo();
						JSONObject tmpObj = (JSONObject)lineObjArr.get(idx);
//						tmpVo.setCreator(creater);
						tmpVo.setUpdater(updater);
//						tmpVo.setDept_cd(dept_cd);
						tmpVo.setId_yn(id_yn);
						
 	
						for(Object key : lineKeyArr) {
							
							String nKey = key.toString();
							System.out.println( nKey);	
							String nValue = (tmpObj.get(nKey) == null)?"":tmpObj.get(nKey).toString();

							System.out.println( nValue);
							/*
							if ( "member_emp_no".equals(nKey) )  tmpVo.setMember_emp_no(nValue);
							else if ( "member_id".equals(nKey) ) tmpVo.setMember_id(nValue);
							else if ( "member_email".equals(nKey) ) tmpVo.setMember_email(nValue);
							else if ( "member_pwd".equals(nKey) ) tmpVo.setMember_pwd(nValue);
							else if ( "member_nm".equals(nKey) ) tmpVo.setMember_nm(nValue);
							else if ( "member_nm_en".equals(nKey) ) tmpVo.setMember_nm_en(nValue);
							else if ( "company_cd".equals(nKey) ) tmpVo.setCompany_cd(nValue);
							else if ( "init_yn".equals(nKey) ) tmpVo.setInit_yn(nValue);
							else if ( "pwd_chg_date".equals(nKey) ) tmpVo.setPwd_chg_date(nValue);
							else if ( "member_lang".equals(nKey) ) tmpVo.setMember_lang(nValue);
							*/ 				 
						}
						lineList.add(tmpVo);
					}
					// line tbl insert/update   
				//	resultCnt += sYprodService.line_header_save(lineList);
					resultCnt += sYhubService.create_vmember(lineList);
					resultCnt += sYhubService.create_vmember_map(lineList);
					resultCnt += sYhubService.create_vmember_role(lineList);
					resultCnt += sYhubService.update_vendor_id_yn(lineList);
				}
			}
		 
			if( resultCnt>0 ) {
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("result", resultCnt);
			} else {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("result", "0");
			}
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/trans_receipt_select", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectCode(@ModelAttribute SYTransReceiptVo pVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.trans_receipt_select() is called.");
		
		List<SYTransReceiptVo> listCode = null;
		listCode = sYscmService.trans_receipt_select(pVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/prod/fnLastInspWorkerAdd", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String fnLastInspWorkerAdd(@ModelAttribute SYQmVo pVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.fnLastInspWorkerAdd() is called.");

		pVo.setWorker_emp_no(SessionUtil.getMemberEmpNo(request));
		
		int result = sYqmService.fnLastInspWorkerAdd(pVo);
		JSONObject resultData = new JSONObject();
		try {
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/prod/lastStsUpdate", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String lastStsUpdate(@ModelAttribute SYQmVo pVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.lastStsUpdate() is called.");

		int result = sYqmService.lastStsUpdate(pVo);
		JSONObject resultData = new JSONObject();
		try {
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
	
	
	/*@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/prod/detail_serial_add_opt", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String detail_serial_add_opt(@ModelAttribute SYSernrManageVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.detail_serial_add_opt() is called.");
		JSONObject resultData = new JSONObject();
		JSONObject resultObj = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		String user_id = SessionUtil.getMemberId(request);
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));
			String dept_cd = request.getParameter("dept_cd");
			String lgort = request.getParameter("lgort"); // ??

			
			 * 1. 받아온 그리드 데이터를 vo로 만든다. 2. 기존 저장되어 있는 데이터와 같은 데이터가 있으면, reverse
			 * 항목에 "X" 를 세팅한다. 3. 007 에 전달한다.
			 
			// 1.
			String params = sVo.getParams();
			// string to json list
			listDataJArray = (JSONArray) jsonParser.parse(params);

			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar c1 = Calendar.getInstance();
			String strToday = sdf.format(c1.getTime());

			List<SYSernrManageVo> iVoList = new ArrayList<SYSernrManageVo>();
			if (listDataJArray.size() > 0) {
				JSONObject jOb = (JSONObject) listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();
				for (int idx = 0; idx < listDataJArray.size(); idx++) {
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject) listDataJArray.get(idx);
					SYSernrManageVo tmpVo = new SYSernrManageVo();
					tmpVo.setPordno_pop(sVo.getPordno_pop());
					tmpVo.setPordno(sVo.getPordno());
					tmpVo.setBudat(strToday);
					tmpVo.setRouting_gno(sVo.getRouting_gno());
					tmpVo.setRouting_no(sVo.getRouting_no());
					for (Object key : keyArr) {
						String nKey = key.toString();
						String nValue = "";
						if(jObj.get(nKey)==null) continue;
						else nValue = jObj.get(nKey).toString();
						if ("matnr".equals(nKey))
							tmpVo.setMatnr(nValue);
						else if ("meins".equals(nKey))
							tmpVo.setMeins(nValue);
						else if ("sernr".equals(nKey))
							tmpVo.setSernr(nValue);
						else if ("sernp".equals(nKey))
							tmpVo.setSernp(nValue);
//						else if ("pordno_pop".equals(nKey))
							//tmpVo.setPordno_pop(nValue);
//							tmpVo.setPordno_pop(sVo.getPordno_pop());
						else if ("lgort".equals(nKey))
							tmpVo.setLgort(nValue);
//						 else if ("menge".equals(nKey))
//						 tmpVo.setBdmng(nValue);
						else if ("bdmng".equals(nKey)) {
							tmpVo.setBdmng(nValue);
							tmpVo.setMenge(nValue);
						}
						else if ("sernr_seq".equals(nKey)) {
							tmpVo.setSernr_seq(nValue);
						}
					}
//					System.out.println(tmpVo.toString());
					iVoList.add(idx, tmpVo);
				}
			}
			// 2. 삭제 대상 조회 "X" 플래그 넣어 저장
			List<SYSernrManageVo> loadVoList = new ArrayList<SYSernrManageVo>();
			List<SYSernrManageVo> delVoList = new ArrayList<SYSernrManageVo>();
			loadVoList = sYprodService.selectSernrManageTbl(sVo);
			  System.out.println("loadVoList : " + loadVoList.toString());
			  System.out.println("iVoList1 : " + iVoList.toString());
			if (iVoList.size() == 0) {
				for (SYSernrManageVo lVo : loadVoList) {
					lVo.setReverse("X");
					iVoList.add(iVoList.size(), lVo);
					delVoList.add(lVo);
					lVo.setReverse("X");
					iVoList.add(iVoList.size(), lVo);
					
					if(	Float.parseFloat(lVo.getBdmng())< 0 ){
						
						lVo.setReversecheck("A");  // reverse 취소시 기존과 반대로 출고처리해야하기때문에 구분자 "A"추가
						lVo.setReverse("");
//						lVo.setMenge(lVo.getBdmng());
//						lVo.setBdmng(lVo.getBdmng());
						lVo.setMenge(String.valueOf(Math.abs(Integer.parseInt(lVo.getBdmng()))));
						lVo.setBdmng(String.valueOf(Math.abs(Integer.parseInt(lVo.getBdmng()))));		
					
					}			
					delVoList.add(lVo);			 
				}
			} else {
				for (SYSernrManageVo lVo : loadVoList) {
					String flag = "X";
					String lsernr_seq = lVo.getSernr_seq();
					for (SYSernrManageVo iVo : iVoList) {
						String isernr_seq = iVo.getSernr_seq();
						
						if (lsernr_seq.equals(isernr_seq)) {
							flag = "O";
							break;
						}
					}
					
//					String lRoutingNo = lVo.getRouting_no();
//					String lMatnr = lVo.getMatnr();
//					String flag = "X";
//					for (SYSernrManageVo iVo : iVoList) {
//						System.out.println("1-1");
//						String iRoutingNo = iVo.getRouting_no();
//						String iMatnr = iVo.getMatnr();
//						if (iRoutingNo.equals(lRoutingNo) && iMatnr.equals(lMatnr)) {
//							flag = "O";
//							break;
//						}
//					}
					// 기존 목록에 대하여 새로운 목록을 비교, 삭재된 항목에 대하여 reverse "X"를 set 하여
					// rfc에 보낼 데이터에 합하여 준다.
					if ("X".equals(flag)) {
						lVo.setReverse("X");
						iVoList.add(iVoList.size(), lVo);
						
						if(	Float.parseFloat(lVo.getBdmng())< 0 ){
							
							lVo.setReversecheck("A");   // reverse 취소시 기존과 반대로 출고처리해야하기때문에 구분자 "A"추가
							lVo.setReverse("");
							lVo.setMenge(String.valueOf(Math.abs(Integer.parseInt(lVo.getBdmng()))));
							lVo.setBdmng(String.valueOf(Math.abs(Integer.parseInt(lVo.getBdmng()))));		
						
						}
						delVoList.add(lVo);
					}
				}
			}

			// 2. 추가 대상만 추린다.
			// List<SYSernrManageVo> newArr = new ArrayList<SYSernrManageVo>();
			List<SYSernrManageVo> intArr = new ArrayList<SYSernrManageVo>();
			if (iVoList.size() > 0) {
				for (SYSernrManageVo vo : iVoList) {
					if (!("X".equals(vo.getReverse())))
						intArr.add(vo);
					//해체 때문에 수정 해체일경우 (-) 수량이 온다. (-) 수량이 오면 즉 'X'=> rfc 는 reverse 처럼 처리하여 rfc 전송한다.
					if (!("X".equals(vo.getReverse()))  && !("A".equals(vo.getReversecheck())) ){  // reverse 취소시 기존과 반대로 출고처리해야하기때문에 구분자 "A"추가
						
						System.out.println("vo.getBdmng()"+vo.getBdmng() );
						
						if(	Float.parseFloat(vo.getBdmng())< 0 ){
							vo.setReversecheck("X");
							vo.setReverse("X");
							vo.setMenge(String.valueOf(Math.abs(Integer.parseInt(vo.getBdmng()))));
							vo.setBdmng(String.valueOf(Math.abs(Integer.parseInt(vo.getBdmng()))));		
						}
						
						if(vo.getSernr_seq().length() == 0) {
							intArr.add(vo);
						}
					}
				}
				
				for (int idx = 0; idx < iVoList.size(); idx++) {
					SYSernrManageVo vo = iVoList.get(idx);
					String iRoutingNo = vo.getRouting_no();
					String iMatnr = vo.getMatnr();
					if (loadVoList.size() > 0) {
						for (SYSernrManageVo lVo : loadVoList) {
							String lRoutingNo = lVo.getRouting_no();
							String lMatnr = lVo.getMatnr();
							if ((lRoutingNo.equals(iRoutingNo) && lMatnr.equals(iMatnr))) {
								intArr.remove(vo);
							}else{
//								newArr.add(vo);
//								break;
							}
						}
					}else{
//						newArr.add(vo);
					}
				}
	
			}
			System.out.println("******");
			System.out.println(iVoList);
			System.out.println("******");
//			System.out.println("newArr : " + newArr.toString());
			System.out.println("intArr : " + intArr.toString());
			System.out.println("delVoList : " + delVoList.toString());
			// 3.
			List<SYSernrManageVo> rfcVoList = new ArrayList<SYSernrManageVo>();
			if( intArr.size()>0 ){
				for( SYSernrManageVo vo : intArr) {
					rfcVoList.add(vo);
				}
			}
			if( delVoList.size()>0 ){
				for( SYSernrManageVo vo : delVoList) {
					rfcVoList.add(vo);
				}
			}
			System.out.println(rfcVoList);
			String target_ds = "Material input processing";
			resultObj = sapMasterService.ziffm_mes_pp007("ZIFFM_MES_PP007", rfcVoList, dept_cd, user_id, target_ds);
			
			if ( "200".equals(resultObj.get("status").toString()) ) {
				sVo.setIf_status("S");
				sVo.setIf_msg(resultObj.get("message").toString());
				
				String zifsta = resultObj.get("zifsta").toString();
				String zifmsg = resultObj.get("zifmsg").toString();
				
				resultData.put("zifsta", zifsta);
				resultData.put("zifmsg", zifmsg);
				
				if(zifsta.equals("S")) {
					if( iVoList.size()>0 ){
						for ( SYSernrManageVo vo : iVoList) {
							SYSernrManageVo tmpVo = new SYSernrManageVo();
							tmpVo.setPordno_pop(vo.getPordno_pop());
							tmpVo.setRouting_no(vo.getRouting_no());
							tmpVo.setMatnr(vo.getMatnr());
							tmpVo.setSernr_seq(vo.getSernr_seq());
							sYprodService.deleteSernrManageTbl(tmpVo);
						}
					}
					if( iVoList.size()>0 ){
						for( SYSernrManageVo vo : iVoList ){
							System.out.println("==============");
							System.out.println(vo);
							
							// ivolist 가 변경되었기 때문에 insertSernrManageTbl에 insert 처리하기 위해서 다시 원상태로 돌려준다. insertSernrManageTbl 에 -수량으로 이력을 쌓는다.
							if(("X".equals(vo.getReversecheck()))){
								vo.setReverse("");
								vo.setMenge("-"+vo.getBdmng());
								vo.setBdmng("-"+vo.getBdmng());
							}
							if( !("X".equals(vo.getReverse())) && !("A".equals(vo.getReversecheck())) ) // reverse 취소시 기존과 반대로 출고처리해야하기때문에 구분자 "A"추가
								sYprodService.insertSernrManageTbl(vo);
						}
					}
				}
			
			}
			resultData.put("result", resultObj.toJSONString());
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}*/

	/*
	@ResponseBody
	@RequestMapping(value = "/prod/sernrCntChk", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String sernrCntChk(@ModelAttribute SYSernrManageVo pVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.sernrCntChk() is called.");
		
		List<SYSernrManageVo> listCode = null;
		listCode = sYprodService.sernrCntChk(pVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}
	*/
	@ResponseBody
	@RequestMapping(value = "/mes/select_selfinsp_master", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String select_selfinsp_master(@ModelAttribute SYSelfInspMasterVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.select_selfinsp_master() is called.");
		
		List<SYSelfInspMasterVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			list = sYmesService.select_selfinsp_master(vo);
			// 기존 데이터를 불러와야 한다. 
			
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/mes/selfInspMaster_update", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selfInspMaster_update(@ModelAttribute SYSelfInspMasterVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selfInspMaster_update() is called.");
		
		List<SYSelfInspMasterVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			int resultCnt = sYmesService.selfInspMaster_update(vo);
			// 기존 데이터를 불러와야 한다. 
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", resultCnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/mes/selfInspMaster_insert", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selfInspMaster_insert(@ModelAttribute SYSelfInspMasterVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selfInspMaster_insert() is called.");
		
		List<SYSelfInspMasterVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			vo.setCreator(SessionUtil.getMemberId(request));
			int resultCnt = 0;
			if( "group".equals(vo.getGubun()) ) {
				resultCnt = sYmesService.selfInspMaster_new_insert(vo); 
			} else {
				resultCnt = sYmesService.selfInspMaster_matnr_insert(vo);
			}
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", resultCnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	/*@ResponseBody
	@RequestMapping(value = "/mes/select_selfinsp_header_list", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String select_selfinsp_header_list(@ModelAttribute SYSelfInspHeaderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.select_selfinsp_header_list() is called.");
		
		List<SYSelfInspHeaderVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			list = sYmesService.select_selfinsp_header(vo);
				
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
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
	
	/*@ResponseBody
	@RequestMapping(value = "/mes/select_selfinsp_header", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String select_selfinsp_header(@ModelAttribute SYSelfInspHeaderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.select_selfinsp_header() is called.");
		
		List<SYSelfInspHeaderVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			int chkCount = sYmesService.checkExistSelfInsp(vo);
			if( chkCount==0 ) {
				list = sYmesService.select_selfinsp_header(vo);
				SYProdVo prodVo = sYmesService.select_dmrRnInfo(vo.getPordno());
				for( SYSelfInspHeaderVo sVo : list ) {
					if( "DMR".equals(sVo.getSub_name().trim()) ) {
						sVo.setItem_value(prodVo.getDmr_no());
					}
					if( "RN".equals(sVo.getSub_name().trim()) ) {
						sVo.setItem_value(prodVo.getRn_no());
					}
				}
			} else {
				list = sYmesService.select_selfinsp_header_exist(vo);
				// 기존 데이터를 불러와야 한다. 
			}
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
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

	@ResponseBody
	@RequestMapping(value = "/mes/update_selfinsp_header", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String update_selfinsp_header(@ModelAttribute SYSelfInspHeaderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.update_selfinsp_header() is called.");
		
		List<SYSelfInspHeaderVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray intDataJArray = new JSONArray();
		JSONArray uptDataJArray = new JSONArray();
		JSONParser parser = new JSONParser();
		try {
			String insertData = request.getParameter("insertData");
			String updateData = "";
			if ( request.getParameter("updateData")!=null ) {
				updateData = request.getParameter("updateData");
				uptDataJArray = (JSONArray)parser.parse(updateData);
			}
			intDataJArray = (JSONArray)parser.parse(insertData);
			// make insert vo array
			int intResult = 0;
			if( intDataJArray.size()>0 ) {
				Object[] keyarr = ((JSONObject)intDataJArray.get(0)).keySet().toArray();
				for( int idx=0; idx<intDataJArray.size(); idx++ ){
					JSONObject jObj = (JSONObject)intDataJArray.get(idx); 
					SYSelfInspHeaderVo tmpVo = new SYSelfInspHeaderVo();
					tmpVo.setCreator(SessionUtil.getMemberId(request));
					for(Object key : keyarr) {
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						if( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
						else if ( "dept_cd".equals(nKey) ) tmpVo.setDept_cd(nValue);
						else if ( "display_seq".equals(nKey) ) tmpVo.setDisplay_seq(nValue);
						else if ( "main_name".equals(nKey) ) tmpVo.setMain_name(nValue);
						else if ( "sub_name".equals(nKey) ) tmpVo.setSub_name(nValue);
						else if ( "item_value".equals(nKey) ) tmpVo.setItem_value(nValue);
						else if ( "use_yn".equals(nKey) ) tmpVo.setUse_yn(nValue);
					}
					intResult += sYmesService.selfInspHeader_insert(tmpVo);
				}
			}
			// make update vo array
			int uptResult = 0;
			if( uptDataJArray.size()>0 ) {
				Object[] keyarr = ((JSONObject)uptDataJArray.get(0)).keySet().toArray();
				for( int idx=0; idx<uptDataJArray.size(); idx++ ){
					JSONObject jObj = (JSONObject)uptDataJArray.get(idx); 
					SYSelfInspHeaderVo tmpVo = new SYSelfInspHeaderVo();
					tmpVo.setUpdater(SessionUtil.getMemberId(request));
					for(Object key : keyarr) {
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						if( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
						else if ( "siheader_seq".equals(nKey) ) tmpVo.setSiheader_seq(nValue);
						else if ( "siheader_code".equals(nKey) ) tmpVo.setSiheader_code(nValue);
						else if ( "main_name".equals(nKey) ) tmpVo.setMain_name(nValue);
						else if ( "sub_name".equals(nKey) ) tmpVo.setSub_name(nValue);
						else if ( "item_value".equals(nKey) ) tmpVo.setItem_value(nValue);
						else if ( "use_yn".equals(nKey) ) tmpVo.setUse_yn(nValue);
					}
					uptResult += sYmesService.selfInspHeader_update(tmpVo);
				}
			}
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("intResult", intResult);
			resultData.put("uptResult", uptResult);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/mes/update_selfinsp_detail", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String update_selfinsp_detail(@ModelAttribute SYSelfInspDetailVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.update_selfinsp_detail() is called.");
		
		List<SYSelfInspDetailVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray intDataJArray = new JSONArray();
		JSONArray uptDataJArray = new JSONArray();
		JSONParser parser = new JSONParser();
		try {
			String insertData = request.getParameter("insertData");
			String updateData = "";
			if ( request.getParameter("updateData")!=null ) {
				updateData = request.getParameter("updateData");
				uptDataJArray = (JSONArray)parser.parse(updateData);
			}
			intDataJArray = (JSONArray)parser.parse(insertData);
			// make insert vo array
			int intResult = 0;
			if( intDataJArray.size()>0 ) {
				Object[] keyarr = ((JSONObject)intDataJArray.get(0)).keySet().toArray();
				for( int idx=0; idx<intDataJArray.size(); idx++ ){
					JSONObject jObj = (JSONObject)intDataJArray.get(idx); 
					SYSelfInspDetailVo tmpVo = new SYSelfInspDetailVo();
					tmpVo.setCreator(SessionUtil.getMemberId(request));
					for(Object key : keyarr) {
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						if( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
						else if ( "dept_cd".equals(nKey) ) tmpVo.setDept_cd(nValue);
						else if ( "display_seq".equals(nKey) ) tmpVo.setDisplay_seq(nValue);
						else if ( "sidetail_seq".equals(nKey) ) tmpVo.setSidetail_seq(nValue);
						else if ( "sidetail_code".equals(nKey) ) tmpVo.setSidetail_code(nValue);
						else if ( "routing_code".equals(nKey) ) tmpVo.setRouting_code(nValue);
						else if ( "routing_code_sub".equals(nKey) ) tmpVo.setRouting_code_sub(nValue);
						else if ( "minsp_name".equals(nKey) ) tmpVo.setMinsp_name(nValue);
						else if ( "sinsp_name".equals(nKey) ) tmpVo.setSinsp_name(nValue);
						else if ( "insp_standard".equals(nKey) ) tmpVo.setInsp_standard(nValue);
						else if ( "insp_value".equals(nKey) ) tmpVo.setInsp_value(nValue);
						else if ( "member_emp_no".equals(nKey) ) tmpVo.setMember_emp_no(nValue);
						else if ( "member_nm".equals(nKey) ) tmpVo.setMember_nm(nValue);
						else if ( "remark".equals(nKey) ) tmpVo.setRemark(nValue);
						else if ( "use_yn".equals(nKey) ) tmpVo.setUse_yn(nValue);
					}
					intResult += sYmesService.selfInspDetail_insert(tmpVo);
				}
			}
			// make update vo array
			int uptResult = 0;
			if( uptDataJArray.size()>0 ) {
				Object[] keyarr = ((JSONObject)uptDataJArray.get(0)).keySet().toArray();
				for( int idx=0; idx<uptDataJArray.size(); idx++ ){
					JSONObject jObj = (JSONObject)uptDataJArray.get(idx); 
					SYSelfInspDetailVo tmpVo = new SYSelfInspDetailVo();
					tmpVo.setUpdater(SessionUtil.getMemberId(request));
					for(Object key : keyarr) {
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						if( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
						else if ( "dept_cd".equals(nKey) ) tmpVo.setDept_cd(nValue);
						else if ( "display_seq".equals(nKey) ) tmpVo.setDisplay_seq(nValue);
						else if ( "sidetail_seq".equals(nKey) ) tmpVo.setSidetail_seq(nValue);
						else if ( "sidetail_code".equals(nKey) ) tmpVo.setSidetail_code(nValue);
						else if ( "routing_code".equals(nKey) ) tmpVo.setRouting_code(nValue);
						else if ( "routing_code_sub".equals(nKey) ) tmpVo.setRouting_code_sub(nValue);
						else if ( "minsp_name".equals(nKey) ) tmpVo.setMinsp_name(nValue);
						else if ( "sinsp_name".equals(nKey) ) tmpVo.setSinsp_name(nValue);
						else if ( "insp_standard".equals(nKey) ) tmpVo.setInsp_standard(nValue);
						else if ( "insp_value".equals(nKey) ) tmpVo.setInsp_value(nValue);
						else if ( "member_emp_no".equals(nKey) ) tmpVo.setMember_emp_no(nValue);
						else if ( "member_nm".equals(nKey) ) tmpVo.setMember_nm(nValue);
						else if ( "remark".equals(nKey) ) tmpVo.setRemark(nValue);
						else if ( "use_yn".equals(nKey) ) tmpVo.setUse_yn(nValue);
					}
					uptResult += sYmesService.selfInspDetail_update(tmpVo);
				}
			}
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("intResult", intResult);
			resultData.put("uptResult", uptResult);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
//	@ResponseBody
//	@RequestMapping(value = "/mes/ㅑㅜㄴㄷ_selfinsp_header", method = {
//			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
//	@SuppressWarnings("unchecked")
//	public String update_selfinsp_header(@ModelAttribute SYSelfInspHeaderVo vo,
//			HttpServletRequest request, HttpServletResponse response,
//			HttpSession session) {
//		logger.debug("FrontendController.update_selfinsp_header() is called.");
//		
//		List<SYSelfInspHeaderVo> list = null;
//		JSONObject resultData = new JSONObject();
//		JSONArray intDataJArray = new JSONArray();
//		JSONArray uptDataJArray = new JSONArray();
//		JSONParser parser = new JSONParser();
//		try {
//			String insertData = request.getParameter("insertData");
//			String updateData = request.getParameter("updateData");
//			intDataJArray = (JSONArray)parser.parse(insertData);
//			uptDataJArray = (JSONArray)parser.parse(updateData);
//			// make insert vo array
//			int intResult = 0;
//			if( intDataJArray.size()>0 ) {
//				Object[] keyarr = ((JSONObject)intDataJArray.get(0)).keySet().toArray();
//				for( int idx=0; idx<intDataJArray.size(); idx++ ){
//					JSONObject jObj = (JSONObject)intDataJArray.get(idx); 
//					SYSelfInspHeaderVo tmpVo = new SYSelfInspHeaderVo();
//					tmpVo.setCreator(SessionUtil.getMemberId(request));
//					for(Object key : keyarr) {
//						String nKey = key.toString();
//						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
//						if( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
//						else if ( "dept_cd".equals(nKey) ) tmpVo.setDept_cd(nValue);
//						else if ( "display_seq".equals(nKey) ) tmpVo.setDisplay_seq(nValue);
//						else if ( "main_name".equals(nKey) ) tmpVo.setMain_name(nValue);
//						else if ( "sub_name".equals(nKey) ) tmpVo.setSub_name(nValue);
//						else if ( "item_value".equals(nKey) ) tmpVo.setItem_value(nValue);
//						else if ( "use_yn".equals(nKey) ) tmpVo.setUse_yn(nValue);
//					}
//					intResult += sYmesService.selfInspHeader_insert(tmpVo);
//				}
//			}
//			// make update vo array
//			int uptResult = 0;
//			if( uptDataJArray.size()>0 ) {
//				Object[] keyarr = ((JSONObject)uptDataJArray.get(0)).keySet().toArray();
//				for( int idx=0; idx<uptDataJArray.size(); idx++ ){
//					JSONObject jObj = (JSONObject)uptDataJArray.get(idx); 
//					SYSelfInspHeaderVo tmpVo = new SYSelfInspHeaderVo();
//					tmpVo.setUpdater(SessionUtil.getMemberId(request));
//					for(Object key : keyarr) {
//						String nKey = key.toString();
//						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
//						if( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
//						else if ( "siheader_seq".equals(nKey) ) tmpVo.setSiheader_seq(nValue);
//						else if ( "siheader_code".equals(nKey) ) tmpVo.setSiheader_code(nValue);
//						else if ( "main_name".equals(nKey) ) tmpVo.setMain_name(nValue);
//						else if ( "sub_name".equals(nKey) ) tmpVo.setSub_name(nValue);
//						else if ( "item_value".equals(nKey) ) tmpVo.setItem_value(nValue);
//						else if ( "use_yn".equals(nKey) ) tmpVo.setUse_yn(nValue);
//					}
//					uptResult += sYmesService.selfInspHeader_update(tmpVo);
//				}
//			}
//			resultData.put("status", HttpStatus.OK.value());
//			resultData.put("intResult", intResult);
//			resultData.put("uptResult", uptResult);
//		} catch (Exception e) {
//			e.printStackTrace();
//			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			resultData.put("rows", null);
//		}
//		return resultData.toJSONString();
//	}
	/*
	@ResponseBody
	@RequestMapping(value = "/mes/select_selfinsp_detail_list", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String select_selfinsp_detail_list(@ModelAttribute SYSelfInspDetailVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.select_selfinsp_detail_list() is called.");
		
		List<SYSelfInspDetailVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			SYSelfInspHeaderVo hVo = new SYSelfInspHeaderVo();
			hVo.setPordno(vo.getPordno());
			list = sYmesService.select_selfinsp_detail(vo);
			
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
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
	
	/*@ResponseBody
	@RequestMapping(value = "/mes/select_selfinsp_detail", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String select_selfinsp_detail(@ModelAttribute SYSelfInspDetailVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.select_selfinsp_detail() is called.");
		
		List<SYSelfInspDetailVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			SYSelfInspHeaderVo hVo = new SYSelfInspHeaderVo();
			hVo.setPordno(vo.getPordno());
			int chkCount = sYmesService.checkExistSelfInsp(hVo);
			if( chkCount==0 )
				list = sYmesService.select_selfinsp_detail(vo);
			else
				list = sYmesService.select_selfinsp_detail_exist(vo);
			// 기존 데이터를 불러와야 한다.
			
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
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
	
	@ResponseBody
	@RequestMapping(value = "/mes/select_selfInspCode_1210", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String select_selfInspCode_1210(@ModelAttribute SYMesCodeVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.select_selfInspCode_1210() is called.");
		
		List<SYMesCodeVo> list = null;
		list = sYmesService.select_selfInspCode_1210(vo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	/*@ResponseBody
	@RequestMapping(value = "/mes/select_selfInspCode_1110", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String select_selfInspCode_1110(@ModelAttribute SYMesCodeVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.select_selfInspCode_1110() is called.");
		
		List<SYMesCodeVo> list = null;
		list = sYmesService.select_selfInspCode_1110(vo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
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

	/*@ResponseBody
	@RequestMapping(value = "/mes/checkExistSelfInsp", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String checkExistSelfInsp(@ModelAttribute SYSelfInspHeaderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.checkExistSelfInsp() is called.");
		
		int chkCount = sYmesService.checkExistSelfInsp(vo);
		JSONObject resultData = new JSONObject();
		try {
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", chkCount);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/

	/*@ResponseBody
	@RequestMapping(value = "/mes/saveSelfInsp_1210", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveSelfInsp_1210(@ModelAttribute SYSelfInspHeaderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveSelfInsp_1210() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONParser parser = new JSONParser();
		JSONArray hJsonArr = new JSONArray(); 
		try {
			String flag = "true";
			String pordno = request.getParameter("pordno");

			SYVprodVo sVo = new SYVprodVo();
			sVo.setVpordno(pordno);
			sVo.setDel_yn("N");
						
			List<SYVprodVo> listCode = sYqmService.vprod_select(sVo);
			
			for(int i=0 ; i<listCode.size(); i++) {
				if(listCode.get(i).getVpdsts().equals("v3")) {
					flag = "false";
				}  
			} 
			
			if(flag.equals("true")) {
				String headerData = request.getParameter("headerData");
				String confirm_id = "";
				if( (request.getParameter("confirm_id"))!=null ) {
					confirm_id = request.getParameter("confirm_id");
				}
				JSONObject jObj_header = new JSONObject();
				jObj_header.put("headerData", headerData);
				jObj_header.put("dept_cd", vo.getDept_cd());
				jObj_header.put("pordno", vo.getPordno());
				
				String grid_p1_data = "";
				String grid_p2_data = "";
				String grid_p5_data = "";
				String grid_t1_data = "";
				String detailData = "";
				if( (request.getParameter("detailData"))!=null ) {
					detailData = request.getParameter("detailData");
				} else {
					if( (request.getParameter("grid_p1_data"))!=null ) {
						grid_p1_data = request.getParameter("grid_p1_data");
					}
					if( (request.getParameter("grid_p2_data"))!=null ) {
						grid_p2_data = request.getParameter("grid_p2_data");
					}
					if( (request.getParameter("grid_p5_data"))!=null ) {
						grid_p5_data = request.getParameter("grid_p5_data");
					}
					if( (request.getParameter("grid_t1_data"))!=null ) {
						grid_t1_data = request.getParameter("grid_t1_data");
					}
				}
				JSONObject jObj_detail = new JSONObject();
				if( "".equals(detailData) ) {
					jObj_detail.put("grid_p1_data", grid_p1_data);
					jObj_detail.put("grid_p2_data", grid_p2_data);
					jObj_detail.put("grid_p5_data", grid_p5_data);
					jObj_detail.put("grid_t1_data", grid_t1_data);
				} else {
					jObj_detail.put("detailData", detailData);
				}
				jObj_detail.put("dept_cd", vo.getDept_cd());
				jObj_detail.put("pordno", vo.getPordno());
				
				int chkCount = sYmesService.checkExistSelfInsp(vo);
				if( chkCount>0 ) {	
					// update
					jObj_header.put("updater", SessionUtil.getMemberId(request));
					if( !"".equals(confirm_id) )
						jObj_header.put("confirm_id", confirm_id);
					jObj_detail.put("updater", SessionUtil.getMemberId(request));
					sYmesService.update_selfInspHeader(jObj_header);
					sYmesService.update_selfInspDetail_1210(jObj_detail);
				} else { 
					// insert
					jObj_header.put("creator", SessionUtil.getMemberId(request));
					if( !"".equals(confirm_id) )
						jObj_header.put("confirm_id", confirm_id);
					jObj_detail.put("creator", SessionUtil.getMemberId(request));
					sYmesService.insert_selfInspHeader(jObj_header);
					sYmesService.insert_selfInspDetail_1210(jObj_detail);
				}
			}
			
			resultData.put("flag", flag);
			resultData.put("status", HttpStatus.OK.value());
//			resultData.put("rows", chkCount);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	
	/*@ResponseBody
	@RequestMapping(value = "/mes/saveSelfInsp_1110", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveSelfInsp_1110(@ModelAttribute SYSelfInspHeaderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveSelfInsp_1110() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONParser parser = new JSONParser();
		JSONArray hJsonArr = new JSONArray(); 
		try {
			
			String flag = "true";
			String pordno = request.getParameter("pordno");

			SYVprodVo sVo = new SYVprodVo();
			sVo.setVpordno(pordno);
			sVo.setDel_yn("N");			
			List<SYVprodVo> listCode = sYqmService.vprod_select(sVo);
			
			for(int i=0 ; i<listCode.size(); i++) {
				if(listCode.get(i).getVpdsts().equals("v3")) {
					flag = "false";
				}  
			} 
			
			if(flag.equals("true")) {
				String headerData = request.getParameter("headerData");
				String detailData = request.getParameter("detailData");
				String confirm_id = "";
				if( request.getParameter("confirm_id")!=null )
					confirm_id = request.getParameter("confirm_id");
				JSONObject jObj_header = new JSONObject();
				jObj_header.put("headerData", headerData);
				jObj_header.put("dept_cd", vo.getDept_cd());
				jObj_header.put("pordno", vo.getPordno());
				
				JSONObject jObj_detail = new JSONObject();
				jObj_detail.put("detailData", detailData);
				jObj_detail.put("dept_cd", vo.getDept_cd());
				jObj_detail.put("pordno", vo.getPordno());
				
				int chkCount = sYmesService.checkExistSelfInsp(vo);
				if( chkCount>0 ) {	
					// update
					jObj_header.put("updater", SessionUtil.getMemberId(request));
					if( !"".equals(confirm_id) )
						jObj_header.put("confirm_id", confirm_id);
					jObj_detail.put("updater", SessionUtil.getMemberId(request));
					sYmesService.update_selfInspHeader(jObj_header);
					sYmesService.update_selfInspDetail_1110(jObj_detail);
				} else { 
					// insert
					jObj_header.put("creator", SessionUtil.getMemberId(request));
					if( !"".equals(confirm_id) )
						jObj_header.put("confirm_id", confirm_id);
					jObj_detail.put("creator", SessionUtil.getMemberId(request));
					sYmesService.insert_selfInspHeader(jObj_header);
					sYmesService.insert_selfInspDetail_1110(jObj_detail);
				}
			}
			
			
			resultData.put("flag", flag);
			resultData.put("status", HttpStatus.OK.value());
//			resultData.put("rows", chkCount);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	
	//public String checkVenderMember(String member_emp_no) {
	@ResponseBody
	@RequestMapping(value = "/scm/checkVenderMember", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String checkVenderMember(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.checkVenderMember() is called.");
		
		JSONObject resultData = new JSONObject();
		try {
			String member_emp_no = request.getParameter("member_emp_no");
			String chkDeptCd = sYscmService.checkVenderMember(member_emp_no);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("result", chkDeptCd);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("result", null);
		}
		return resultData.toJSONString();
	}
	
	/*@ResponseBody
	@RequestMapping(value = "/prod/mes_wkctr_tbl_select", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String mes_wkctr_tbl_select(@ModelAttribute SYMesWkctrVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.mes_wkctr_tbl_select() is called.");
		
		List<SYMesWkctrVo> list = null;
		list = sYprodService.mes_wkctr_tbl_select(vo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
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
	@RequestMapping(value = "/prod/jo_worker_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String jo_worker_select(@ModelAttribute SYMemberVo memberVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.worker_select_1110() is called.");

		List<SYMemberVo> listCode = null;

		listCode = sYprodService.jo_worker_select(memberVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,listCode);
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
	
	@ResponseBody
	@RequestMapping(value = "/mes/grade_matnr_chk", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String grade_matnr_chk(@ModelAttribute SYProdVo pVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.grade_matnr_chk() is called.");

		List<SYProdVo> listCode = null;
		
		String pordnos = request.getParameter("pordnos");
		
		listCode = sYmesService.grade_matnr_chk(pordnos);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/mes/grade_loc_update", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String grade_loc_update(@ModelAttribute SYProdVo pVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.grade_loc_update() is called.");

	
		String params = request.getParameter("params");
		
		int result = sYmesService.grade_loc_update(params);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		try {
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/scm_trans_req_cancel", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String scm_trans_req_cancel(@ModelAttribute SYReqmMatnrTblVo pVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.scm_trans_req_cancel() is called.");
		
		List<SYReqmMatnrTblVo> chkList = null;
		chkList = sYscmService.trans_req_select(pVo);
		
		String g_flag = "";		//승인 여부 flag
		
		if(chkList.size() > 0) {
			if(chkList.get(0).getGrantor_status().equals("Y")) {
				g_flag = "Y";
			} else {
				g_flag = "N";
			}
		}
		
		if(g_flag.equals("N")) {
			int result = sYscmService.scm_trans_req_cancel(pVo);
		}
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		try {
			resultData.put("g_flag", g_flag);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/scm_trans_req_user_confirml", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String scm_trans_req_user_confirml(@ModelAttribute SYReqmMatnrTblVo pVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.scm_trans_req_user_confirml() is called.");
		
		List<SYReqmMatnrTblVo> chkList = null;
		chkList = sYscmService.trans_req_select(pVo);
		
		String g_flag = "";		//승인 여부 flag
		String c_flag = "";		//자재 수령 여부 flag
		
		if(chkList.size() > 0) {
			if(chkList.get(0).getGrantor_status().equals("Y")) {
				g_flag = "Y";
			} else {
				g_flag = "N";
			}
			
			if(chkList.get(0).getConfirm_user() == null) {
				c_flag = "N";
			} else {
				c_flag = "Y";
			}
		}
		
		if(g_flag.equals("Y")  && c_flag.equals("N")) {
			int result = sYscmService.scm_trans_req_user_confirml(pVo);
		}
		
		JSONObject resultData = new JSONObject();

		try {
			resultData.put("g_flag", g_flag);
			resultData.put("c_flag", c_flag);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/scm_cancel", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String scm_cancel(@ModelAttribute SYQmVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.scm_cancel() is called.");
		JSONObject resultData = new JSONObject(); 
		JSONParser paser = new JSONParser(); 
		JSONArray objArr = new JSONArray();
		try{
			String gubun = request.getParameter("gubun");
			String updateKeyObj = request.getParameter("updateObj");
			// set list for raw_proc_tbl update
			objArr = (JSONArray)paser.parse(updateKeyObj);
			Object[] keyarr = ((JSONObject)objArr.get(0)).keySet().toArray();
			List<SYScmRawProcVo> sList = new ArrayList<SYScmRawProcVo>();
			for( int idx=0; idx<objArr.size(); idx++ ){
				JSONObject jObj = (JSONObject)objArr.get(idx); 
				SYScmRawProcVo tmpVo = new SYScmRawProcVo();
				for(Object key : keyarr) {
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					if( "ebeln".equals(nKey) ) tmpVo.setEbeln(nValue);
					else if( "ebelp".equals(nKey) ) tmpVo.setEbelp(nValue);
					else if( "partial_seq".equals(nKey) ) tmpVo.setPartial_seq(nValue);
				}
				sList.add(tmpVo);
			}
			// case by cancel process
			if( "case1".equals(gubun) ) {	// 입하/입고 취소
				resultData = sapMasterService.zmmfm_goodsmvt_cancel(vo, "ZMMFM_GOODSMVT_CANCEL");
				JSONArray rows_arr = (JSONArray)resultData.get("rows");
				JSONObject rows_obj = (JSONObject)rows_arr.get(0);
				String ev_status = rows_obj.get("ev_status").toString();
				if( "S".equals(ev_status) ) {
					String updater = SessionUtil.getMemberId(request);
					int updateCnt = 0;
					for( SYScmRawProcVo sVo : sList ) {
						sVo.setUpdater(updater);
						sVo.setC_mblnr(rows_obj.get("ev_mblnr").toString());
						sVo.setC_mjahr(rows_obj.get("ev_mjahr").toString());
						sVo.setMblnr("-");
						sVo.setMjahr("-");
						sVo.setRorder_status("r3");
						sVo.setRvendor_status("v2");
						updateCnt += sYscmService.rawProcSta_update(sVo);
						sYmesService.ininsp_delete(sVo);
					}
					if( updateCnt>0 ){
						resultData.put("status", HttpStatus.OK.value());
						resultData.put("reason", "update success");
					} else {
						resultData.put("status", HttpStatus.OK.value());
						resultData.put("reason", "update fail(none)");
					}
				} else {
					resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
					resultData.put("reason", "cancel rfc process fail");
				}
			} else {	// 수입검사 취소
				resultData = sapMasterService.zmmfm_goodsmvt_cancel(vo, "ZMMFM_GOODSMVT_CANCEL");
				
				JSONArray rows_arr = (JSONArray)resultData.get("rows");
				JSONObject rows_obj = (JSONObject)rows_arr.get(0);
				String ev_status = rows_obj.get("ev_status").toString();
				if( "S".equals(ev_status.trim()) ) {
					int updateCnt = 0;
					for( SYScmRawProcVo sVo : sList ) {
						SYInInspVo iVo = new SYInInspVo();
						iVo.setMblnr_cancel(rows_obj.get("ev_mblnr").toString());
						iVo.setMjahr_cancel(rows_obj.get("ev_mjahr").toString());
						iVo.setEbeln(sVo.getEbeln());
						iVo.setEbelp(sVo.getEbelp());
						iVo.setPartial_seq(sVo.getPartial_seq());
						updateCnt += sYmesService.ininsp_update(iVo);
						sYmesService.ininsp_detail_delete(iVo);
						sYmesService.ininsp_header_delete(iVo);
					}
					if( updateCnt>0 ){
						resultData.put("status", HttpStatus.OK.value());
						resultData.put("reason", "update success");
					} else {
						resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
						resultData.put("reason", "update fail(none)");
					}
				} else {
					resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
					resultData.put("reason", "cancel rfc process fail");
					resultData.put("ev_message", rows_obj.get("EV_MESSAGE").toString());
				}
			}
		} catch( Exception e ) {
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("reason", "Exception");
		}
		return resultData.toJSONString();
	}
	
	/*@ResponseBody
	@RequestMapping(value = "/hub/update_routinggnm", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String update_routinggnm(@ModelAttribute SYHubRoutingHeaderVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.update_routinggnm() is called.");
		JSONObject resultData = new JSONObject(); 
//		JSONParser paser = new JSONParser(); 
//		JSONArray objArr = new JSONArray();
		try{
			int result = sYhubService.update_routinggnm(vo);
			if( result>0 ){
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("result", result);
			} else {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("reason", "0");
			}
		} catch( Exception e ) {
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("reason", "Exception");
		}
		return resultData.toJSONString();
	}*/

	@ResponseBody
	@RequestMapping(value = "/mes/checkDuplicateMatnr", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String checkDuplicateMatnr(@ModelAttribute SYSelfInspMasterVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.checkDuplicateMatnr() is called.");
		JSONObject resultData = new JSONObject();
		List<SYSelfInspMasterVo> list = new ArrayList<SYSelfInspMasterVo>();
//		JSONParser paser = new JSONParser(); 
		JSONArray listDataJArray = new JSONArray();
		try{
			list = sYmesService.checkDuplicateMatnr(vo);
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch( Exception e ) {
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("reason", "Exception");
		}
		return resultData.toJSONString();
	}
	/*
	@ResponseBody
	@RequestMapping(value = "/hub/matnr_workstd_mapping", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String matnr_workstd_mapping(@ModelAttribute SYFileVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.matnr_workstd_mapping() is called.");
		JSONObject resultData = new JSONObject(); 

		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));
		
		try{
			int result = sYhubService.matnr_workstd_mapping(vo);
			if( result>0 ){
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("result", result);
			} else {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("reason", "0");
			}
		} catch( Exception e ) {
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("reason", "Exception");
		}
		return resultData.toJSONString();
	}*/
	
	/*
	@ResponseBody
	@RequestMapping(value = "/hub/fnDelMatnr", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String fnDelMatnr(@ModelAttribute SYFileVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.fnDelMatnr() is called.");
		JSONObject resultData = new JSONObject(); 

		vo.setUpdater(SessionUtil.getMemberId(request));
		
		try{
			int result = sYhubService.fnDelMatnr(vo);
			if( result>0 ){
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("result", result);
			} else {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("reason", "0");
			}
		} catch( Exception e ) {
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("reason", "Exception");
		}
		return resultData.toJSONString();
	}*/
	
	@ResponseBody
	@RequestMapping(value = "/scm/vendorselectBomtbl", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String vendorselectBomtbl(@ModelAttribute SYScmBomVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectBomtbl() is called.");

		 
		// sYprodService.insertSapProdOrd();
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			String func_name = "";
			int rowTotal = sYscmService.selectBomtbl_count(sVo);
			int curreCntPage = sVo.getPage(); 
			int rowCount = sVo.getRows();
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
 
			if( curreCntPage > rowTotal ){
				sVo.setRows(rowCount-(curreCntPage-rowTotal));
			}
			List<SYScmBomVo> dataList = sYscmService.selectBomtbl(sVo);
			 
			String listDataJsonString = ResponseUtils.getJsonResponse(response, dataList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	/*
	@ResponseBody
	@RequestMapping(value = "/scm/vender_nm_grid_add", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String vender_nm_grid_add(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.vender_nm_grid_add() is called.");
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		JSONObject resultData = new JSONObject();
		
		try {
			String lifnrs = request.getParameter("lifnrs");
			List<SYVendorVo> dataList = sYscmService.vender_nm_grid_add(lifnrs);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, dataList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	
	@ResponseBody
	@RequestMapping(value = "/qm/inspection_state_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String inspection_state_select(@ModelAttribute SYQmVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.inspection_state_select() is called.");
		
		List<SYQmVo> listCode = null;
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		listCode = sYqmService.inspection_state_select(sVo);
	
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();

	}
	
	@ResponseBody
	@RequestMapping(value = "/qm/inspection_state_monthly_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String inspection_state_monthly_select(@ModelAttribute SYQmVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.inspection_state_monthly_select() is called.");
		
		List<SYQmVo> listCode = null;
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		listCode = sYqmService.inspection_state_monthly_select(sVo);
	
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();

	}
	
	@ResponseBody
	@RequestMapping(value = "/qm/import_inspection_state_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String import_inspection_state_select(@ModelAttribute SYQmVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.import_inspection_state_select() is called.");
		
		List<SYQmVo> listCode = null;
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		listCode = sYqmService.import_inspection_state_select(sVo);
	
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();

	}
	
	@ResponseBody
	@RequestMapping(value = "/qm/import_inspection_monthly_state_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String import_inspection_monthly_state_select(@ModelAttribute SYQmVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.import_inspection_monthly_state_select() is called.");
		
		List<SYQmVo> listCode = null;
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		listCode = sYqmService.import_inspection_monthly_state_select(sVo);
	
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();

	}
	
	@ResponseBody
	@RequestMapping(value = "/qm/import_inspection_m_state_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String import_inspection_m_state_select(@ModelAttribute SYQmVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.import_inspection_m_state_select() is called.");
		
		List<SYQmVo> listCode = null;
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		listCode = sYqmService.import_inspection_m_state_select(sVo);
	
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();

	}
	
	@ResponseBody
	@RequestMapping(value = "/qm/import_inspection_m_monthly_state_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String import_inspection_m_monthly_state_select(@ModelAttribute SYQmVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.import_inspection_m_monthly_state_select() is called.");
		
		List<SYQmVo> listCode = null;
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		listCode = sYqmService.import_inspection_m_monthly_state_select(sVo);
	
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();

	}
	
	@ResponseBody
	@RequestMapping(value = "/qm/inspSave", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String inspSave(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.inspSave() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		String headerJson = request.getParameter("headerJson");
		String detailJson = request.getParameter("detailJson");
		
		String insp_model = request.getParameter("insp_model");
		String insp_ecr = request.getParameter("insp_ecr");
		String insp_maql = request.getParameter("insp_maql");
		String insp_vaql = request.getParameter("insp_vaql");
		String insp_doc = request.getParameter("insp_doc");
		String insp_remark = request.getParameter("insp_remark");
		
		
		insp_model = (insp_model=="")?null:insp_model;
		insp_ecr = (insp_ecr=="")?null:insp_ecr;
		insp_maql = (insp_maql=="")?null:insp_maql;
		insp_vaql = (insp_vaql=="")?null:insp_vaql;
		insp_doc = (insp_doc=="")?null:insp_doc;
		insp_remark = (insp_remark=="")?null:insp_remark;
 	
		
		String ebeln = "";
		String ebelp = "";
		String partial_seq = ""; 
		
		List<SYInInspDetailVo> detail_list = new ArrayList<SYInInspDetailVo>();
		try{
							
			//header 리스트
			listDataJArray = (JSONArray) jsonParser.parse(headerJson);
	
			if(listDataJArray.size() != 0) {
				JSONObject jOb = (JSONObject)listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();
	
				for(int k=0; k<listDataJArray.size(); k++){
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject)listDataJArray.get(k);
					SYQmVo tmp_sVo = new SYQmVo();
				
					for(Object key : keyArr){
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();						
						if( "ebeln".equals(nKey) ) {
							ebeln = nValue;
						}
						else if( "ebelp".equals(nKey) ) {
							ebelp = nValue;
						}
						else if( "partial_seq".equals(nKey) ) {
							partial_seq = nValue;
						}
					}
				}
			}	
			
			//detail 리스트
			listDataJArray = (JSONArray) jsonParser.parse(detailJson);
			
			if(listDataJArray.size() != 0) {
				JSONObject jOb = (JSONObject)listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();
	
				for(int k=0; k<listDataJArray.size(); k++){
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject)listDataJArray.get(k);
					SYInInspDetailVo dVo = new SYInInspDetailVo();
				
					for(Object key : keyArr){
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						
						if( "inspection_value1".equals(key) ) {
							dVo.setInspection_value1(nValue);
						} else if( "inspection_value2".equals(key) ) {
							dVo.setInspection_value2(nValue);
						} else if( "inspection_value3".equals(key) ) {
							dVo.setInspection_value3(nValue);
						} else if( "inspection_value4".equals(key) ) {
							dVo.setInspection_value4(nValue);
						} else if( "inspection_value5".equals(key) ) {
							dVo.setInspection_value5(nValue);
						} else if( "inspection_value6".equals(key) ) {
							dVo.setInspection_value6(nValue);
						} else if( "inspection_value7".equals(key) ) {
							dVo.setInspection_value7(nValue);
						} else if( "inspection_value8".equals(key) ) {
							dVo.setInspection_value8(nValue);
						} else if( "inspection_value9".equals(key) ) {
							dVo.setInspection_value9(nValue);
						} else if( "inspection_value10".equals(key) ) {
							dVo.setInspection_value10(nValue);
						} else if( "inspection_value11".equals(key) ) {
							dVo.setInspection_value11(nValue);
						} else if( "inspection_value12".equals(key) ) {
							dVo.setInspection_value12(nValue);
						} else if( "inspection_value13".equals(key) ) {
							dVo.setInspection_value13(nValue);
						} else if( "inspection_value14".equals(key) ) {
							dVo.setInspection_value14(nValue);
						} else if( "inspection_value15".equals(key) ) {
							dVo.setInspection_value15(nValue);
						} else if( "inspection_value16".equals(key) ) {
							dVo.setInspection_value16(nValue);
						} else if( "inspection_value17".equals(key) ) {
							dVo.setInspection_value17(nValue);
						} else if( "inspection_value18".equals(key) ) {
							dVo.setInspection_value18(nValue);
						} else if( "inspection_value19".equals(key) ) {
							dVo.setInspection_value19(nValue);
						} else if( "inspection_value20".equals(key) ) {
							dVo.setInspection_value20(nValue);
						} else if( "inspection_value21".equals(key) ) {
							dVo.setInspection_value21(nValue);
						} else if( "inspection_value22".equals(key) ) {
							dVo.setInspection_value22(nValue);
						} else if( "inspection_value23".equals(key) ) {
							dVo.setInspection_value23(nValue);
						} else if( "inspection_value24".equals(key) ) {
							dVo.setInspection_value24(nValue);
						} else if( "inspection_value25".equals(key) ) {
							dVo.setInspection_value25(nValue);
						} else if( "inspection_value26".equals(key) ) {
							dVo.setInspection_value26(nValue);
						} else if( "inspection_value27".equals(key) ) {
							dVo.setInspection_value27(nValue);
						} else if( "inspection_value28".equals(key) ) {
							dVo.setInspection_value28(nValue);
						} else if( "inspection_value29".equals(key) ) {
							dVo.setInspection_value29(nValue);
						} else if( "inspection_value30".equals(key) ) {
							dVo.setInspection_value30(nValue);
						} else if( "inspection_value31".equals(key) ) {
							dVo.setInspection_value31(nValue);
						} else if( "inspection_value32".equals(key) ) {
							dVo.setInspection_value32(nValue);
						} else if( "inspection_decision".equals(key) ) {
							dVo.setInspection_decision(nValue);
						}  else if( "inspection_cn".equals(key) ) {
							dVo.setInspection_cn(nValue);
						} else if( "inspection_code".equals(key) ) {
							dVo.setInspection_code(nValue);
						} else if( "insp_header_seq".equals(key) ) {
							dVo.setInsp_header_seq(nValue);
						} 
					}
					
					dVo.setEbeln(ebeln);
					dVo.setEbelp(ebelp);
					dVo.setPartial_seq(partial_seq);
					
					detail_list.add(dVo);
				}
			}	
			
			SYInInspHeaderVo sVo = new SYInInspHeaderVo();
			
			sVo.setEbeln(ebeln);
			sVo.setEbelp(ebelp);
			sVo.setPartial_seq(partial_seq);
			sVo.setInsp_model(insp_model);
			sVo.setInsp_ecr(insp_ecr);
			sVo.setInsp_maql(insp_maql);
			sVo.setInsp_vaql(insp_vaql);
			sVo.setInsp_doc(insp_doc);
			sVo.setInsp_remark(insp_remark);
			
			int rtn_header_value = sYqmService.inspHeaderSave(sVo);
			int rtn_value = sYqmService.inspSave(detail_list);
			
			////////////////////////////////////////////////

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");
				
		} catch(Exception ex){
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
			ex.printStackTrace();
		} 
			
		return resultData.toJSONString();
	}
	
	//////////////////////////////외주업체 자주검사 마스터 관리
	
	@ResponseBody
	@RequestMapping(value = "/mes/select_v_selfinsp_master", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String select_v_selfinsp_master(@ModelAttribute SYSelfInspMasterVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.select_v_selfinsp_master() is called.");
		
		List<SYSelfInspMasterVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			list = sYmesService.select_v_selfinsp_master(vo);
			// 기존 데이터를 불러와야 한다. 
			
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/mes/v_selfInspMaster_insert", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String v_selfInspMaster_insert(@ModelAttribute SYSelfInspMasterVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.v_selfInspMaster_insert() is called.");
		
		List<SYSelfInspMasterVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			vo.setCreator(SessionUtil.getMemberId(request));
			int resultCnt = 0;
			if( "group".equals(vo.getGubun()) ) {
				resultCnt = sYmesService.v_selfInspMaster_new_insert(vo); 
			} else {
				resultCnt = sYmesService.v_selfInspMaster_matnr_insert(vo);
			}
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", resultCnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/mes/v_update_selfinsp_header", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String v_update_selfinsp_header(@ModelAttribute SYSelfInspHeaderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.v_update_selfinsp_header() is called.");
		
		List<SYSelfInspHeaderVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray intDataJArray = new JSONArray();
		JSONArray uptDataJArray = new JSONArray();
		JSONParser parser = new JSONParser();
		try {
			String insertData = request.getParameter("insertData");
			String updateData = "";
			if ( request.getParameter("updateData")!=null ) {
				updateData = request.getParameter("updateData");
				uptDataJArray = (JSONArray)parser.parse(updateData);
			}
			intDataJArray = (JSONArray)parser.parse(insertData);
			// make insert vo array
			int intResult = 0;
			if( intDataJArray.size()>0 ) {
				Object[] keyarr = ((JSONObject)intDataJArray.get(0)).keySet().toArray();
				for( int idx=0; idx<intDataJArray.size(); idx++ ){
					JSONObject jObj = (JSONObject)intDataJArray.get(idx); 
					SYSelfInspHeaderVo tmpVo = new SYSelfInspHeaderVo();
					tmpVo.setCreator(SessionUtil.getMemberId(request));
					for(Object key : keyarr) {
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						if( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
						else if ( "dept_cd".equals(nKey) ) tmpVo.setDept_cd(nValue);
						else if ( "display_seq".equals(nKey) ) tmpVo.setDisplay_seq(nValue);
						else if ( "main_name".equals(nKey) ) tmpVo.setMain_name(nValue);
						else if ( "sub_name".equals(nKey) ) tmpVo.setSub_name(nValue);
						else if ( "item_value".equals(nKey) ) tmpVo.setItem_value(nValue);
						else if ( "use_yn".equals(nKey) ) tmpVo.setUse_yn(nValue);
					}
					intResult += sYmesService.v_selfInspHeader_insert(tmpVo);
				}
			}
			// make update vo array
			int uptResult = 0;
			if( uptDataJArray.size()>0 ) {
				Object[] keyarr = ((JSONObject)uptDataJArray.get(0)).keySet().toArray();
				for( int idx=0; idx<uptDataJArray.size(); idx++ ){
					JSONObject jObj = (JSONObject)uptDataJArray.get(idx); 
					SYSelfInspHeaderVo tmpVo = new SYSelfInspHeaderVo();
					tmpVo.setUpdater(SessionUtil.getMemberId(request));
					for(Object key : keyarr) {
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						if( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
						else if ( "siheader_seq".equals(nKey) ) tmpVo.setSiheader_seq(nValue);
						else if ( "siheader_code".equals(nKey) ) tmpVo.setSiheader_code(nValue);
						else if ( "main_name".equals(nKey) ) tmpVo.setMain_name(nValue);
						else if ( "sub_name".equals(nKey) ) tmpVo.setSub_name(nValue);
						else if ( "item_value".equals(nKey) ) tmpVo.setItem_value(nValue);
						else if ( "use_yn".equals(nKey) ) tmpVo.setUse_yn(nValue);
					}
					uptResult += sYmesService.v_selfInspHeader_update(tmpVo);
				}
			}
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("intResult", intResult);
			resultData.put("uptResult", uptResult);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/mes/select_v_selfinsp_header_list", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String select_v_selfinsp_header_list(@ModelAttribute SYSelfInspHeaderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.select_v_selfinsp_header_list() is called.");
		
		List<SYSelfInspHeaderVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			list = sYmesService.select_v_selfinsp_header(vo);
				
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/mes/select_v_selfinsp_detail_list", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String select_v_selfinsp_detail_list(@ModelAttribute SYSelfInspDetailVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.select_v_selfinsp_detail_list() is called.");
		
		List<SYSelfInspDetailVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			SYSelfInspHeaderVo hVo = new SYSelfInspHeaderVo();
			hVo.setPordno(vo.getPordno());
			list = sYmesService.select_v_selfinsp_detail(vo);
			
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/mes/v_checkDuplicateMatnr", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String v_checkDuplicateMatnr(@ModelAttribute SYSelfInspMasterVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.v_checkDuplicateMatnr() is called.");
		JSONObject resultData = new JSONObject();
		List<SYSelfInspMasterVo> list = new ArrayList<SYSelfInspMasterVo>();
//		JSONParser paser = new JSONParser(); 
		JSONArray listDataJArray = new JSONArray();
		try{
			list = sYmesService.v_checkDuplicateMatnr(vo);
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch( Exception e ) {
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("reason", "Exception");
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/mes/v_selfInspMaster_update", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String v_selfInspMaster_update(@ModelAttribute SYSelfInspMasterVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.v_selfInspMaster_update() is called.");
		
		List<SYSelfInspMasterVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			int resultCnt = sYmesService.v_selfInspMaster_update(vo);
			// 기존 데이터를 불러와야 한다. 
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", resultCnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/mes/v_update_selfinsp_detail", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String v_update_selfinsp_detail(@ModelAttribute SYSelfInspDetailVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.v_update_selfinsp_detail() is called.");
		
		List<SYSelfInspDetailVo> list = null;
		JSONObject resultData = new JSONObject();
		JSONArray intDataJArray = new JSONArray();
		JSONArray uptDataJArray = new JSONArray();
		JSONParser parser = new JSONParser();
		try {
			String insertData = request.getParameter("insertData");
			String updateData = "";
			if ( request.getParameter("updateData")!=null ) {
				updateData = request.getParameter("updateData");
				uptDataJArray = (JSONArray)parser.parse(updateData);
			}
			intDataJArray = (JSONArray)parser.parse(insertData);
			// make insert vo array
			int intResult = 0;
			if( intDataJArray.size()>0 ) {
				Object[] keyarr = ((JSONObject)intDataJArray.get(0)).keySet().toArray();
				for( int idx=0; idx<intDataJArray.size(); idx++ ){
					JSONObject jObj = (JSONObject)intDataJArray.get(idx); 
					SYSelfInspDetailVo tmpVo = new SYSelfInspDetailVo();
					tmpVo.setCreator(SessionUtil.getMemberId(request));
					for(Object key : keyarr) {
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						if( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
						else if ( "dept_cd".equals(nKey) ) tmpVo.setDept_cd(nValue);
						else if ( "display_seq".equals(nKey) ) tmpVo.setDisplay_seq(nValue);
						else if ( "sidetail_seq".equals(nKey) ) tmpVo.setSidetail_seq(nValue);
						else if ( "sidetail_code".equals(nKey) ) tmpVo.setSidetail_code(nValue);
						else if ( "routing_code".equals(nKey) ) tmpVo.setRouting_code(nValue);
						else if ( "routing_code_sub".equals(nKey) ) tmpVo.setRouting_code_sub(nValue);
						else if ( "minsp_name".equals(nKey) ) tmpVo.setMinsp_name(nValue);
						else if ( "sinsp_name".equals(nKey) ) tmpVo.setSinsp_name(nValue);
						else if ( "insp_standard".equals(nKey) ) tmpVo.setInsp_standard(nValue);
						else if ( "insp_value".equals(nKey) ) tmpVo.setInsp_value(nValue);
						else if ( "member_emp_no".equals(nKey) ) tmpVo.setMember_emp_no(nValue);
						else if ( "member_nm".equals(nKey) ) tmpVo.setMember_nm(nValue);
						else if ( "remark".equals(nKey) ) tmpVo.setRemark(nValue);
						else if ( "use_yn".equals(nKey) ) tmpVo.setUse_yn(nValue);
					}
					intResult += sYmesService.v_selfInspDetail_insert(tmpVo);
				}
			}
			// make update vo array
			int uptResult = 0;
			if( uptDataJArray.size()>0 ) {
				Object[] keyarr = ((JSONObject)uptDataJArray.get(0)).keySet().toArray();
				for( int idx=0; idx<uptDataJArray.size(); idx++ ){
					JSONObject jObj = (JSONObject)uptDataJArray.get(idx); 
					SYSelfInspDetailVo tmpVo = new SYSelfInspDetailVo();
					tmpVo.setUpdater(SessionUtil.getMemberId(request));
					for(Object key : keyarr) {
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						if( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
						else if ( "dept_cd".equals(nKey) ) tmpVo.setDept_cd(nValue);
						else if ( "display_seq".equals(nKey) ) tmpVo.setDisplay_seq(nValue);
						else if ( "sidetail_seq".equals(nKey) ) tmpVo.setSidetail_seq(nValue);
						else if ( "sidetail_code".equals(nKey) ) tmpVo.setSidetail_code(nValue);
						else if ( "routing_code".equals(nKey) ) tmpVo.setRouting_code(nValue);
						else if ( "routing_code_sub".equals(nKey) ) tmpVo.setRouting_code_sub(nValue);
						else if ( "minsp_name".equals(nKey) ) tmpVo.setMinsp_name(nValue);
						else if ( "sinsp_name".equals(nKey) ) tmpVo.setSinsp_name(nValue);
						else if ( "insp_standard".equals(nKey) ) tmpVo.setInsp_standard(nValue);
						else if ( "insp_value".equals(nKey) ) tmpVo.setInsp_value(nValue);
						else if ( "member_emp_no".equals(nKey) ) tmpVo.setMember_emp_no(nValue);
						else if ( "member_nm".equals(nKey) ) tmpVo.setMember_nm(nValue);
						else if ( "remark".equals(nKey) ) tmpVo.setRemark(nValue);
						else if ( "use_yn".equals(nKey) ) tmpVo.setUse_yn(nValue);
					}
					uptResult += sYmesService.v_selfInspDetail_update(tmpVo);
				}
			}
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("intResult", intResult);
			resultData.put("uptResult", uptResult);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/qm/vendor_prod_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String vendor_prod_insert(@ModelAttribute SYVprodVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.vendor_prod_insert() is called.");
		
//		List<SYQmVo> list = null;
		int result =0;
		JSONParser jsonParser = new JSONParser();
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
//		List<SYVprodVo> param_list = new ArrayList<SYVprodVo>(); 
		
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));
			
			String record = request.getParameter("record");
			
			
			listDataJArray = (JSONArray) jsonParser.parse(record);
			
			if(listDataJArray.size() != 0) {
				JSONObject jOb = (JSONObject)listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();
	
				for(int k=0; k<listDataJArray.size(); k++){
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject)listDataJArray.get(k);
					SYVprodVo tmp_sVo = new SYVprodVo();
				
					for(Object key : keyArr){
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();						
						
						if( "matnr".equals(nKey) ) tmp_sVo.setMatnr(nValue);
						else if( "maktx".equals(nKey) ) tmp_sVo.setMaktx(nValue);
						else if( "pdqty".equals(nKey) ) tmp_sVo.setPdqty(nValue);
						else if( "dept_cd".equals(nKey) ) tmp_sVo.setDept_cd(nValue);
						else if( "menge".equals(nKey) ) tmp_sVo.setMenge("1");
						else if( "sernr".equals(nKey) ) tmp_sVo.setSernr(nValue);
					}
					
					tmp_sVo.setLifnr(SessionUtil.getMemberId(request));
					if(tmp_sVo.getPdqty().length() == 0) {
					} else {
						int roop_cnt= Integer.parseInt(tmp_sVo.getPdqty());
						
						for(int i=0 ; i<roop_cnt; i++) {
							result = sYqmService.vendor_prod_insert(tmp_sVo);
						}	
					}
				}
			}	
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	/*@ResponseBody
	@RequestMapping(value = "/qm/vprod_select", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String vprod_select(@ModelAttribute SYVprodVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.vprod_select() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		sVo.setDel_yn("N");
		List<SYVprodVo> listCode = sYqmService.vprod_select(sVo);
		
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
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

	/*@ResponseBody
	@RequestMapping(value = "/qm/selfInspSernrSave", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selfInspSernrSave(@ModelAttribute SYVprodVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selfInspSernrSave() is called.");
		
		int result =0;
		
		JSONParser jsonParser = new JSONParser();
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));
			
			String record = request.getParameter("record");
			
			///////////////////////////////////////////////////////////////
			String flag = "true";
			String vpordnos = request.getParameter("vpordnos");
			
			ArrayList<String> vpordno_list = new ArrayList<String>();
			String[] arrVpordno = vpordnos.split(","); 
			for(int i=0;i<arrVpordno.length;i++) {
				vpordno_list.add(arrVpordno[i]);
			}
			sVo.setList(vpordno_list);
			sVo.setDel_yn("N");
			List<SYVprodVo> listCode = sYqmService.vprod_select(sVo);
			
			for(int i=0 ; i<listCode.size(); i++) {
				if(listCode.get(i).getVpdsts().equals("v1")) {
				} else {
					flag = "false";
				} 
			} 
			
			if(flag.equals("true")) {
				listDataJArray = (JSONArray) jsonParser.parse(record);
				
				if(listDataJArray.size() != 0) {
					JSONObject jOb = (JSONObject)listDataJArray.get(0);
					Object[] keyArr = jOb.keySet().toArray();
		
					for(int k=0; k<listDataJArray.size(); k++){
						JSONObject jObj = new JSONObject();
						jObj = (JSONObject)listDataJArray.get(k);
						SYVprodVo tmp_sVo = new SYVprodVo();
					
						for(Object key : keyArr){
							String nKey = key.toString();
							String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();						
							
							if( "vpordno".equals(nKey) ) tmp_sVo.setVpordno(nValue);
							else if( "sernr".equals(nKey) ) tmp_sVo.setSernr(nValue);
						}
						result = sYqmService.selfInspSernrSave(tmp_sVo);
					}
				}	
			}
			
			resultData.put("flag", flag);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	
	/*@ResponseBody
	@RequestMapping(value = "/qm/vOrdStatusChange", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String vOrdStatusChange(@ModelAttribute SYVprodVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.vOrdStatusChange() is called.");
		
		int result =0;
		JSONParser jsonParser = new JSONParser();
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		try {
			String flag = "true";
			String vpordnos = request.getParameter("vpordnos");
			String vpdsts = request.getParameter("vpdsts");
			
			ArrayList<String> vpordno_list = new ArrayList<String>();
			String[] arrVpordno = vpordnos.split(","); 
			for(int i=0;i<arrVpordno.length;i++) {
				vpordno_list.add(arrVpordno[i]);
			}
			sVo.setList(vpordno_list);
			sVo.setDel_yn("N");
			List<SYVprodVo> listCode = sYqmService.vprod_select(sVo);
			
			if(vpdsts.equals("v3")) {											//완료 시 조건
				for(int i=0 ; i<listCode.size(); i++) {
					if(listCode.get(i).getVpdsts().equals("v2")) {
					} else {
						flag = "false";
					} 
				} 
			} else {																	//삭제 시 조건
				for(int i=0 ; i<listCode.size(); i++) {
					if(listCode.get(i).getVpdsts().equals("v1")) {
					} else {
						flag = "false";
					} 
				}
			}
			
			if(flag.equals("true")) {
				sVo.setCreator(SessionUtil.getMemberId(request));
				sVo.setUpdater(SessionUtil.getMemberId(request));
				
				String record = request.getParameter("record");
				listDataJArray = (JSONArray) jsonParser.parse(record);
				
				if(listDataJArray.size() != 0) {
					JSONObject jOb = (JSONObject)listDataJArray.get(0);
					Object[] keyArr = jOb.keySet().toArray();
		
					for(int k=0; k<listDataJArray.size(); k++){
						JSONObject jObj = new JSONObject();
						jObj = (JSONObject)listDataJArray.get(k);
						SYVprodVo tmp_sVo = new SYVprodVo();
					
						for(Object key : keyArr){
							String nKey = key.toString();
							String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();						
							
							if( "vpordno".equals(nKey) ) tmp_sVo.setVpordno(nValue);
						}
						tmp_sVo.setVpdsts(sVo.getVpdsts());
						
						result = sYqmService.vOrdStatusChange(tmp_sVo);
					
					}
				}	
			}
				
			resultData.put("flag", flag);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	
	
	@ResponseBody
	@RequestMapping(value = "/qm/chkVpdsts", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String chkVpdsts(@ModelAttribute SYVprodVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.chkVpdsts() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		List<SYVprodVo> listCode = sYqmService.chkVpdsts(sVo);
		
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}
	
	/*@ResponseBody
	@RequestMapping(value = "/qm/vorder_del", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String vorder_del(@ModelAttribute SYVprodVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.vorder_del() is called.");
		
//		List<SYQmVo> list = null;
		int result =0;
		JSONParser jsonParser = new JSONParser();
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
//		List<SYVprodVo> param_list = new ArrayList<SYVprodVo>(); 
		
		try {
			
			String flag = "true";
			String vpordnos = request.getParameter("vpordnos");
			
			ArrayList<String> vpordno_list = new ArrayList<String>();
			String[] arrVpordno = vpordnos.split(","); 
			for(int i=0;i<arrVpordno.length;i++) {
				vpordno_list.add(arrVpordno[i]);
			}
			sVo.setList(vpordno_list);
			
			List<SYVprodVo> listCode = sYqmService.vprod_select(sVo);
			
			for(int i=0 ; i<listCode.size(); i++) {
				if(listCode.get(i).getVpdsts().equals("v1") && listCode.get(i).getDel_yn().equals("N")) {
				} else {
					flag = "false";
				} 
			} 
			
			if(flag.equals("true")) {
				sVo.setUpdater(SessionUtil.getMemberId(request));
				
				String record = request.getParameter("record");
				
				listDataJArray = (JSONArray) jsonParser.parse(record);
				
				if(listDataJArray.size() != 0) {
					JSONObject jOb = (JSONObject)listDataJArray.get(0);
					Object[] keyArr = jOb.keySet().toArray();
		
					for(int k=0; k<listDataJArray.size(); k++){
						JSONObject jObj = new JSONObject();
						jObj = (JSONObject)listDataJArray.get(k);
						SYVprodVo tmp_sVo = new SYVprodVo();
					
						for(Object key : keyArr){
							String nKey = key.toString();
							String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();						
							
							if( "vpordno".equals(nKey) ) tmp_sVo.setVpordno(nValue);
						}
						result = sYqmService.vorder_del(tmp_sVo);
					}
				}	
			}
			resultData.put("flag", flag);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}*/
	
/*
	@ResponseBody
	@RequestMapping(value = "/qm/showDmrInfo", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String showDmrInfo(@ModelAttribute SYDmrMasterVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.showDmrInfo() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		String gr_no = request.getParameter("gr_no");
		String gr_seq = request.getParameter("gr_seq");
		String matnr = request.getParameter("matnr");
		String apply_yn = request.getParameter("apply_yn");
		String use_yn = request.getParameter("use_yn");
		String vpordno = request.getParameter("vpordno");
		String vpdsts = "";
		
		SYDmrMasterVo pVo = new SYDmrMasterVo();
		SYVprodVo _vpordVo = new SYVprodVo();
		_vpordVo.setVpordno(vpordno);
		
		List<SYVprodVo> vpordVoList = sYqmService.vprod_select(_vpordVo);
		vpdsts = vpordVoList.get(0).getVpdsts();
		
		List<SYDmrMasterVo> listCode = null; 
		
		if(vpdsts.equals("v1")) {
			pVo.setMatnr(matnr);
			pVo.setApply_yn(apply_yn);
			pVo.setUse_yn(use_yn);
			listCode = sYqmService.showDmrInfo(pVo);
		} else if(vpdsts.equals("v2") || vpdsts.equals("v3")) {
			if(gr_no.length() == 0) {
				listCode = new ArrayList<SYDmrMasterVo>();
			} else {
				pVo.setGr_no(gr_no);
				pVo.setGr_seq(gr_seq);
				listCode = sYqmService.showDmrInfo(pVo);
			}
		}
		
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
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
	
	/*@ResponseBody
	@RequestMapping(value = "/qm/vph_chkDupSernr", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String vph_chkDupSernr(@ModelAttribute SYVprodVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.vph_chkDupSernr() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
				
		String params = request.getParameter("params");
		String rtn_msg = "N";
		try {
						
			JSONParser jsonParser = new JSONParser();
			
			listDataJArray = (JSONArray) jsonParser.parse(params);
			
			if(listDataJArray.size() != 0) {
				JSONObject jOb = (JSONObject)listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();
	
				for(int k=0; k<listDataJArray.size(); k++){
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject)listDataJArray.get(k);
					SYVprodVo tmp_sVo = new SYVprodVo();
				
					for(Object key : keyArr){
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();						
						
						if( "matnr".equals(nKey) ) {
							tmp_sVo.setMatnr(nValue);	
						}
						else if( "sernr".equals(nKey) ) {
							tmp_sVo.setSernr(nValue);
						} 
					}
					List<SYVprodVo> listCode = sYqmService.vph_chkDupSernr(tmp_sVo);	
					
					tmp_sVo.setDel_yn("N");
					List<SYVprodVo> vprod_data = sYqmService.vprod_select(tmp_sVo);
					
					if(listCode.size()>0 || vprod_data.size()>0) {
						rtn_msg = "Y";
					}
				}
			}	
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rtn_msg", rtn_msg);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rtn_msg", rtn_msg);
		}

		return resultData.toJSONString();
	}*/
	
	@ResponseBody
	@RequestMapping(value = "/qm/updateDmr", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateDmr(@ModelAttribute SYVprodVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.updateDmr() is called.");
		
		int result =0;
		JSONParser jsonParser = new JSONParser();
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		try {
			sVo.setCreator(SessionUtil.getMemberId(request));
			sVo.setUpdater(SessionUtil.getMemberId(request));
			
			result = sYqmService.updateDmr(sVo);
	
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/hub/insp_group_byItnbr_select", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String insp_group_byItnbr_select(@ModelAttribute SYHubRecvinspeVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.insp_group_byItnbr_select() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser(); 
		try {
			List<SYHubRecvinspeVo> list = sYhubService.insp_group_byItnbr_select(vo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	/*
	@ResponseBody
	@RequestMapping(value = "/prod/selectfault_his_tbl", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectfault_his_tbl(@ModelAttribute SYProdVo prodVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectfault_his_tbl() is called.");
		
		List<SYProdVo> listCode = null;
		
		 
		listCode = sYprodService.selectfault_his_tbl(prodVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					listCode);
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
	
	@ResponseBody
	@RequestMapping(value = "/qm/select_fault_his_data", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String select_fault_his_data(@ModelAttribute SYQmFaultHisVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.select_fault_his_data() is called.");
	 
		// sYprodService.insertSapProdOrd();
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
		
			List<SYQmFaultHisVo> dataList = sYqmService.select_fault_his_data(sVo);
			 
			String listDataJsonString = ResponseUtils.getJsonResponse(response, dataList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/qm/issueDataSelc", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String issueDataSelc(@ModelAttribute SYScmIssueDetailVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.issueDataSelc() is called.");
	 
		// sYprodService.insertSapProdOrd();
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
		
			List<SYScmIssueDetailVo> dataList = sYqmService.issueDataSelc(sVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, dataList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/qm/issueDataProc", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String issueDataProc(@ModelAttribute SYScmIssueDetailVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.issueDataProc() is called.");
	 
		// sYprodService.insertSapProdOrd();
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		String updater = request.getParameter("member_id");
		sVo.setUpdater(updater);
		
		try {
			int result = sYqmService.issueDataProc(sVo);

			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/qm/issueValidChk", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String issueValidChk(@ModelAttribute SYQmFaultHisVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.issueDataSelc() is called.");
	 
		// sYprodService.insertSapProdOrd();
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
		
			int result = sYqmService.issueValidChk(sVo);
			resultData.put("result", result);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/qm/fault_stats_mst_data", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String select_fault_stats_data(@ModelAttribute SYQmFaultStatsVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.select_fault_stats_data() is called.");
	 
		// sYprodService.insertSapProdOrd();
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
		
			List<SYQmFaultStatsVo> f_list = sYqmService.fault_stats_data(sVo);
			List<SYQmFaultStatsVo> i_list = sYqmService.input_stats_data(sVo);
			
			for(int i=0 ; i<f_list.size(); i++) {
				for(int j=0 ; j<i_list.size(); j++) {
					if(f_list.get(i).getMatnr().equals(i_list.get(j).getMatnr())) {
						f_list.get(i).setI_bdmng(i_list.get(j).getI_bdmng());
						if(Double.parseDouble(f_list.get(i).getI_bdmng()) != 0) {
							Double f_bdmng = Double.parseDouble(f_list.get(i).getF_bdmng());
							Double i_bdmng = Double.parseDouble(f_list.get(i).getI_bdmng());
							Double f_rate = f_bdmng/i_bdmng;
							f_list.get(i).setFault_rate(String.format("%.2f", f_rate*100) + "%");
						}
					}
				}
			}

			if(sVo.getWerks().equals("1110")) {
				sVo.setGubun("원자재");
				List<SYQmFaultStatsVo> f_r_list = sYqmService.fault_stats_data(sVo);
				sVo.setGubun("작업");
				List<SYQmFaultStatsVo> f_o_list = sYqmService.fault_stats_data(sVo);
				
				for(int i=0 ; i<f_list.size(); i++) {
					
					for(int j=0 ; j<f_r_list.size(); j++) {
						if(f_list.get(i).getMatnr().equals(f_r_list.get(j).getMatnr())) {
							f_list.get(i).setF_r_bdmng(f_r_list.get(j).getF_bdmng());
							if(f_list.get(i).getI_bdmng() != null) {
								if(Double.parseDouble(f_list.get(i).getI_bdmng()) != 0) {
									Double f_r_bdmng = Double.parseDouble(f_list.get(i).getF_r_bdmng());
									Double i_bdmng = Double.parseDouble(f_list.get(i).getI_bdmng());
									Double f_rate = f_r_bdmng/i_bdmng;
									f_list.get(i).setF_r_rate(String.format("%.2f", f_rate*100) + "%");
								}
							}
						}
					}
					
					for(int j=0 ; j<f_o_list.size(); j++) {
						if(f_list.get(i).getMatnr().equals(f_o_list.get(j).getMatnr())) {
							f_list.get(i).setF_o_bdmng(f_o_list.get(j).getF_bdmng());
							if(f_list.get(i).getI_bdmng() != null) {
								if(Double.parseDouble(f_list.get(i).getI_bdmng()) != 0) {
									Double f_o_bdmng = Double.parseDouble(f_list.get(i).getF_o_bdmng());
									Double i_bdmng = Double.parseDouble(f_list.get(i).getI_bdmng());
									Double f_rate = f_o_bdmng/i_bdmng;
									f_list.get(i).setF_o_rate(String.format("%.2f", f_rate*100) + "%");
								}
							}
						}
					}
				}
			}
			String listDataJsonString = ResponseUtils.getJsonResponse(response, f_list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/qm/fault_stats_dtl_data", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String fault_stats_dtl_data(@ModelAttribute SYQmFaultStatsVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.fault_stats_dtl_data() is called.");
	 
		// sYprodService.insertSapProdOrd();
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYQmFaultStatsVo> result_list = sYqmService.fault_stats_dtl_data(sVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, result_list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/scm/partialSave", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String partialSave(@ModelAttribute SYScmRawProcVo sVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.partialSave() is called.");
		JSONObject resultData = new JSONObject();
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();
		JSONArray listUKeyArray = new JSONArray();
		
		String ebeln = ""; 
		String ebelp = "";
		try {
			String gridData = request.getParameter("gridData");
			System.out.println(gridData);
			listDataJArray = (JSONArray) jsonParser.parse(gridData);
			List<SYScmRawProcVo> list = new ArrayList<SYScmRawProcVo>();
			
			for(int i=0; i<listDataJArray.size(); i++){
				JSONObject rowObj = (JSONObject) listDataJArray.get(i);
				SYScmRawProcVo procVo = new SYScmRawProcVo();
				
				if(rowObj.get("org_data_chk").toString().equals("Y")) {
					
					ebeln = rowObj.get("ebeln") == null ? "" : rowObj.get("ebeln").toString();
					ebelp	= rowObj.get("ebelp") == null ? "" : rowObj.get("ebelp").toString();
									
					procVo.setEbeln(rowObj.get("ebeln") == null ? "" : rowObj.get("ebeln").toString());
					procVo.setEbelp(rowObj.get("ebelp") == null ? "" : rowObj.get("ebelp").toString());
					procVo.setPartial_seq(rowObj.get("partial_seq") == null ? "" : rowObj.get("partial_seq").toString());
					procVo.setMenge(rowObj.get("menge") == null ? "" : rowObj.get("menge").toString());
					procVo.setZdeli_menge(rowObj.get("zdeli_menge") == null ? "" : rowObj.get("zdeli_menge").toString());
					procVo.setVendor_delivery_date(rowObj.get("vendor_delivery_date") == null ? "" : rowObj.get("vendor_delivery_date").toString());
					if(procVo.getVendor_delivery_date().equals(procVo.getEindt())) {
						procVo.setDiff_date("N");
					} else {
						procVo.setDiff_date("Y");
					}
					procVo.setRorder_status(rowObj.get("rorder_status") == null ? "" : rowObj.get("rorder_status").toString());
					procVo.setRvendor_status(rowObj.get("rvendor_status") == null ? "" : rowObj.get("rvendor_status").toString());
					procVo.setPartial_yn("Y");
					
					int result = sYscmService.rawProcUpload_update(procVo);
				} else {
					procVo.setEbeln(rowObj.get("ebeln") == null ? "" : rowObj.get("ebeln").toString());
					procVo.setEbelp(rowObj.get("ebelp") == null ? "" : rowObj.get("ebelp").toString());
					List<SYScmRawProcVo> rawProc_list = sYscmService.rawProc_selectByKey(procVo);
										
					if(rawProc_list.size() > 0) {
						rawProc_list.get(0).setVendor_delivery_date(rowObj.get("vendor_delivery_date") == null ? "" : rowObj.get("vendor_delivery_date").toString());
						rawProc_list.get(0).setZdeli_menge(rowObj.get("zdeli_menge") == null ? "" : rowObj.get("zdeli_menge").toString());
						int result = sYscmService.rawProcUpload_insert(rawProc_list.get(0));
					}
				}
			}
			
			//rawProcConfirmYn_update : Start
			
			
			int result = 0;
			
			SYScmRawProcVo tVo = new SYScmRawProcVo();
			tVo.setEbeln(ebeln);
			tVo.setEbelp(ebelp);
			List<SYScmRawProcVo> rawProc_list = sYscmService.rawProc_selectByKey(tVo);
			
			
			for(int i=0 ; i<rawProc_list.size(); i++) {
				//listUKeyArray setting
				listUKeyArray.add(ebeln);
				
				//rawProc_list setting
				rawProc_list.get(i).setPartial_yn("Y");
				String vendor_delivery_date = rawProc_list.get(i).getVendor_delivery_date() == null ? "": rawProc_list.get(i).getVendor_delivery_date();
				if( rawProc_list.get(i).getVendor_delivery_date().equals("")) {
					rawProc_list.get(i).setVendor_delivery_date(rawProc_list.get(i).getEindt());
				}
				
				rawProc_list.get(i).setOrder_delivery_date(vendor_delivery_date);
				rawProc_list.get(i).setConfirm_yn("Y");
				if(vendor_delivery_date.equals(rawProc_list.get(i).getEindt())) {
					rawProc_list.get(i).setDiff_date("N");	
				} else {
					rawProc_list.get(i).setDiff_date("Y");
				}
			}
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, rawProc_list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			
			List<SYScmRawProcVo> iList = new ArrayList<SYScmRawProcVo>();
			Object[] keyArr = ((JSONObject) listDataJArray.get(0)).keySet().toArray();
			for(int idx=0; idx<listDataJArray.size(); idx++) {
				JSONObject obj = (JSONObject)listDataJArray.get(idx);
				SYScmRawProcVo tmpVo = new SYScmRawProcVo();
				tmpVo.setUpdater(SessionUtil.getMemberId(request));
				for(Object key : keyArr) {
					String nKey = key.toString();
					String nValue = (obj.get(nKey)==null)?"":obj.get(nKey).toString();
					if( "ebeln".equals(nKey) ) tmpVo.setEbeln(nValue);
					else if( "ebelp".equals(nKey) ) tmpVo.setEbelp(nValue);
					else if( "partial_seq".equals(nKey) ) tmpVo.setPartial_seq(nValue);
					else if( "partial_yn".equals(nKey) ) tmpVo.setPartial_yn(nValue);
					else if( "vendor_delivery_date".equals(nKey) ) tmpVo.setVendor_delivery_date(nValue);
					else if( "order_delivery_date".equals(nKey) ) tmpVo.setOrder_delivery_date(nValue);
					else if( "confirm_date".equals(nKey) ) tmpVo.setConfirm_date(nValue);
					else if( "zdeli_menge".equals(nKey) ) tmpVo.setZdeli_menge(nValue);
					else if( "confirm_yn".equals(nKey) ) tmpVo.setConfirm_yn(nValue);
					else if( "diff_date".equals(nKey) ) tmpVo.setDiff_date(nValue);
					else if( "key_cnt".equals(nKey) ) tmpVo.setKey_cnt(nValue);
				}
				iList.add(tmpVo);
			}

			// set labnr
			List<SYScmRawProcVo> uniqueKeylist = sYscmService.getProcUniqueKeyList(listUKeyArray);	//labnr
			for(int idx=0; idx<iList.size(); idx++ ) {
				for( SYScmRawProcVo itemVo : uniqueKeylist ) {
					if( (itemVo.getEbeln()).equals((iList.get(idx)).getEbeln()) && 
						(itemVo.getEbelp()).equals((iList.get(idx)).getEbelp()) && 
						(itemVo.getPartial_seq()).equals((iList.get(idx)).getPartial_seq()) ) {
						String header = (itemVo.getUnikey()).substring(0, 16);
						String tail = (itemVo.getUnikey()).substring(18, 20);
						String seq = String.format("%02d", Integer.parseInt((iList.get(idx)).getKey_cnt())); 
						(iList.get(idx)).setLabnr(header + seq + tail);
						(iList.get(idx)).setKey_cnt( (Integer.parseInt((iList.get(idx)).getKey_cnt())+1)+"" );
					}
				}
			}
			
			for(SYScmRawProcVo pVo : iList){
				result += sYscmService.rawProcConfirmYn_update(pVo);
			}
			
			//rawProcConfirmYn_update : End
		
			
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("result", null);
		}
		return resultData.toJSONString();
	}
	
	/*************************** New *********************************/
	
	@ResponseBody
	@RequestMapping(value = "/material_master_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_master_select(@ModelAttribute SYMaterialMasVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.material_master_select() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			String matnrs = request.getParameter("matnr");
			/*
			if(matnrs != null && StringUtil.trim(matnrs).length() > 0){
				String[] arr_matnr = matnrs.split(",");
				if(arr_matnr.length > 0){
					ArrayList<String> list = new ArrayList<>();
					list.clear();
					for (String p_matnr : arr_matnr) {
						list.add(p_matnr);
					}
					sVo.setMatnrList(list);
				}
			}*/
			
			int rowTotal = sYmaterialService.material_master_select_count(vo);
			int curreCntPage = vo.getPage(); 
			int rowCount = vo.getRows();
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
			if( curreCntPage > rowTotal ){
				vo.setRows(rowCount-(curreCntPage-rowTotal));
			}

		    List<SYMaterialMasVo> list = sYmaterialService.material_master_select(vo);

//			resultData = ResponseUtils.getJQGridJsonResponse(response, list, currentPage, pageRows, totalRows);
		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/material_master_select_pop", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_master_select_pop(@ModelAttribute SYMaterialMasVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.material_master_select_pop() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			String matnrs = request.getParameter("matnr");
		    List<SYMaterialMasVo> list = sYmaterialService.material_master_select_pop(vo);

		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/material_master_dup_check", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_master_dup_check(@ModelAttribute SYMaterialMasVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.material_master_dup_check() is called.");
		
		JSONObject resultData = new JSONObject();
		try {
		    int cnt = sYmaterialService.material_master_dup_check(vo);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/material_master_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_master_insert(@ModelAttribute SYMaterialMasVo vo,
										HttpServletRequest request, HttpServletResponse response,
										HttpSession session) {
		logger.debug("FrontendController.material_master_insert() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			int cnt = sYmaterialService.material_master_insert(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/material_master_update", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_master_update(@ModelAttribute SYMaterialMasVo vo,
									HttpServletRequest request, HttpServletResponse response,
									HttpSession session) {
		logger.debug("FrontendController.material_master_update() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			int cnt = sYmaterialService.material_master_update(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/material_master_delete", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_master_delete(@ModelAttribute SYMaterialMasVo vo,
										HttpServletRequest request, HttpServletResponse response,
										HttpSession session) {
		logger.debug("FrontendController.material_master_delete() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			int cnt = sYmaterialService.material_master_delete(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/material_mng_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_mng_select(@ModelAttribute SYMaterialMngVo vo,
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session) {
		logger.debug("FrontendController.material_mng_select() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			String matnrs = request.getParameter("matnr");
			/*
			if(matnrs != null && StringUtil.trim(matnrs).length() > 0){
				String[] arr_matnr = matnrs.split(",");
				if(arr_matnr.length > 0){
					ArrayList<String> list = new ArrayList<>();
					list.clear();
					for (String p_matnr : arr_matnr) {
						list.add(p_matnr);
					}
					sVo.setMatnrList(list);
				}
			}*/
			
			int rowTotal = sYmaterialService.material_mng_select_count(vo);
			int curreCntPage = vo.getPage(); 
			int rowCount = vo.getRows();
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
			if( curreCntPage > rowTotal ){
				vo.setRows(rowCount-(curreCntPage-rowTotal));
			}

		    List<SYMaterialMngVo> list = sYmaterialService.material_mng_select(vo);

//			resultData = ResponseUtils.getJQGridJsonResponse(response, list, currentPage, pageRows, totalRows);
		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/material_mng_select_count", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_mng_select_count(@ModelAttribute SYMaterialMngVo vo,
										HttpServletRequest request, HttpServletResponse response,
										HttpSession session) {
		logger.debug("FrontendController.material_mng_select_count() is called.");
		
		JSONObject resultData = new JSONObject();
		try {
			String matnrs = request.getParameter("matnr");
			
			int cnt = sYmaterialService.material_mng_select_count(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", 0);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/material_mng_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_mng_insert(@ModelAttribute SYMaterialMngVo vo,
										HttpServletRequest request, HttpServletResponse response,
										HttpSession session) {
		logger.debug("FrontendController.material_mng_insert() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			SYMaterialMasVo masVo = new SYMaterialMasVo();
			masVo.setMatnr(vo.getMatnr());
			
			List<SYMaterialMasVo> list = sYmaterialService.material_master_select_one(masVo);
			masVo = list.get(0);
			vo.setMatnr(masVo.getMatnr());
			vo.setMtart(masVo.getMtart());
			vo.setMeins(masVo.getMeins());
			vo.setMaktx(masVo.getMaktx());
			vo.setWrkst(masVo.getWrkst());
			vo.setLvorm(masVo.getLvorm());
			vo.setKzumw(masVo.getKzumw());
			vo.setIloos(masVo.getIloos());
			vo.setIhivi(masVo.getIhivi());
			vo.setPrice(masVo.getPrice());
			vo.setBrgew(masVo.getBrgew());
			vo.setNtgew(masVo.getNtgew());
			vo.setGewei(masVo.getGewei());
			vo.setWgbez(masVo.getWgbez());
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			int cnt = sYmaterialService.material_mng_insert(vo);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/material_mng_update", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_mng_update(@ModelAttribute SYMaterialMngVo vo,
									HttpServletRequest request, HttpServletResponse response,
									HttpSession session) {
		logger.debug("FrontendController.material_mng_update() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			int cnt = sYmaterialService.material_mng_update(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/material_mng_delete", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String material_mng_delete(@ModelAttribute SYMaterialMngVo vo,
										HttpServletRequest request, HttpServletResponse response,
										HttpSession session) {
		logger.debug("FrontendController.material_mng_delete() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			int cnt = sYmaterialService.material_mng_delete(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value = "/commCode/comm_code_select", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String comm_code_select(@ModelAttribute SYCodeVo gVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.comm_code_select() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
//			System.out.println(gVo.getGrp_code());
			
			String grpCodeArrStr = request.getParameter("grpCodeArr");
			if(grpCodeArrStr != null && StringUtil.trim(grpCodeArrStr).length() > 0){
				String[] arr_gcode = grpCodeArrStr.split(",");
				if(arr_gcode.length > 0){
					ArrayList<String> list = new ArrayList<>();
					list.clear();
					for (String str : arr_gcode) {
						list.add(str);
					}
					gVo.setGrpCodeList(list);
				}
			}
			
			List<SYCodeVo> gList = sYcodeService.comm_code_select(gVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, gList);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/project_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String project_select(@ModelAttribute SYProjectMngVo vo,
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session) {
		logger.debug("FrontendController.project_select() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			/*
			if(matnrs != null && StringUtil.trim(matnrs).length() > 0){
				String[] arr_matnr = matnrs.split(",");
				if(arr_matnr.length > 0){
					ArrayList<String> list = new ArrayList<>();
					list.clear();
					for (String p_matnr : arr_matnr) {
						list.add(p_matnr);
					}
					sVo.setMatnrList(list);
				}
			}*/
			
			int rowTotal = sYprojectService.project_select_count(vo);
			int curreCntPage = vo.getPage(); 
			int rowCount = vo.getRows();
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
			if( curreCntPage > rowTotal ){
				vo.setRows(rowCount-(curreCntPage-rowTotal));
			}

		    List<SYProjectMngVo> list = sYprojectService.project_select(vo);

//			resultData = ResponseUtils.getJQGridJsonResponse(response, list, currentPage, pageRows, totalRows);
		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/project_select_popup", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String project_select_popup(@ModelAttribute SYProjectMngVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.project_select_popup() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYProjectMngVo> list = sYprojectService.project_select_popup(vo);
			
//			resultData = ResponseUtils.getJQGridJsonResponse(response, list, currentPage, pageRows, totalRows);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/project_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String project_insert(@ModelAttribute SYProjectMngVo vo,
										HttpServletRequest request, HttpServletResponse response,
										HttpSession session) {
		logger.debug("FrontendController.project_insert() is called.");
		
		JSONObject resultData = new JSONObject();
		try {
			String lifnr_nm = URLDecoder.decode(request.getParameter("lifnr_nm"), "UTF-8" );
			String project_nm = URLDecoder.decode(request.getParameter("project_nm"), "UTF-8" );
			String remark = URLDecoder.decode(request.getParameter("remark"), "UTF-8" );
			vo.setLifnr_nm(lifnr_nm);
			vo.setProject_nm(project_nm);
			vo.setRemark(remark);
			String project_no = sYprojectService.get_project_key();
			vo.setProject_no(project_no);
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			int cnt = sYprojectService.project_insert(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/project_update", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String project_update(@ModelAttribute SYProjectMngVo vo,
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session) {
		logger.debug("FrontendController.project_update() is called.");
		
		JSONObject resultData = new JSONObject();
		try {
			String project_nm = URLDecoder.decode(request.getParameter("project_nm"), "UTF-8" );
			String remark = URLDecoder.decode(request.getParameter("remark"), "UTF-8" );
			vo.setProject_nm(project_nm);
			vo.setRemark(remark);
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			int cnt = sYprojectService.project_update(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/projectDeleteBefore", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String projectDeleteBefore(@ModelAttribute SYPoRegVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.projectDeleteBefore() is called.");
		
		JSONObject resultData = new JSONObject();
		try {
			int cnt = sYporegService.poreg_select_count(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/project_delete", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String project_delete(@ModelAttribute SYProjectMngVo vo,
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session) {
		logger.debug("FrontendController.project_delete() is called.");
		
		JSONObject resultData = new JSONObject();
		try {
			int cnt = sYprojectService.project_delete(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/prod_tbl_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String prod_tbl_select(@ModelAttribute SYProdTblVo vo,
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session) {
		logger.debug("FrontendController.prod_tbl_select() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
		    List<SYProdTblVo> list = sYprodService.prod_tbl_select(vo);

		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/sales_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String sales_select(@ModelAttribute SYPoRegVo vo,
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session) {
		logger.debug("FrontendController.sales_select() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			int rowTotal = sYporegService.poreg_select_count(vo);
			int curreCntPage = vo.getPage(); 
			int rowCount = vo.getRows();
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
			if( curreCntPage > rowTotal ){
				vo.setRows(rowCount-(curreCntPage-rowTotal));
			}

		    List<SYPoRegVo> list = sYporegService.poreg_select(vo);

//			resultData = ResponseUtils.getJQGridJsonResponse(response, list, currentPage, pageRows, totalRows);
		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/poreg_chk_menge", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String poreg_chk_menge(@ModelAttribute SYPoRegVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.poreg_chk_menge() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			int sum = sYporegService.poreg_chk_menge(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", sum);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/poreg_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String poreg_insert(@ModelAttribute SYPoRegVo vo,
										HttpServletRequest request, HttpServletResponse response,
										HttpSession session) {
		logger.debug("FrontendController.poreg_insert() is called.");
		
		JSONObject resultData = new JSONObject();
		try {
//			System.out.println(vo.toString());
			vo.setPosale_no(sYporegService.get_posalesno_key());
//			posale_seq, 
			
			SYProjectMngVo pvo = new SYProjectMngVo();
			pvo.setProject_no(vo.getProject_no());
			pvo.setPage(0);
			pvo.setRows(1);
			List<SYProjectMngVo> projList = sYprojectService.project_select(pvo);
			vo.setLifnr(projList.get(0).getLifnr());
			vo.setLifnr_nm(projList.get(0).getLifnr_nm()); 
			vo.setProject_nm(projList.get(0).getProject_nm()); 
			vo.setNetwr(projList.get(0).getNetwr()); 
			vo.setMenge(projList.get(0).getMenge()); 
			vo.setMeins(projList.get(0).getMeins()); 
			vo.setRemark(projList.get(0).getRemark()); 
			vo.setPlan_dt(projList.get(0).getPlan_dt()); 
			vo.setEindt(projList.get(0).getEindt()); 
			vo.setPurdt(projList.get(0).getPurdt()); 
			vo.setFile_group(projList.get(0).getFile_group());
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			int cnt = sYporegService.poreg_insert(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/poreg_update", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String poreg_update(@ModelAttribute SYPoRegVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.poreg_update() is called.");
		
		JSONObject resultData = new JSONObject();
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			vo.setMaktx(URLDecoder.decode(request.getParameter("maktx"), "UTF-8" ));
			int cnt = sYporegService.poreg_update(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/poreg_delete", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String poreg_delete(@ModelAttribute SYPoRegVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.poreg_delete() is called.");
		
		JSONObject resultData = new JSONObject();
		try {
			int cnt = sYporegService.poreg_delete(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/select_shipment", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String sales_shipment(@ModelAttribute SYShipmentHordTblVo vo,
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session) {
		logger.debug("FrontendController.sales_shipment() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			int rowTotal = sYshipService.select_shipment_count(vo);
			int curreCntPage = vo.getPage(); 
			int rowCount = vo.getRows();
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
			if( curreCntPage > rowTotal ){
				vo.setRows(rowCount-(curreCntPage-rowTotal));
			}

		    List<SYShipmentHordTblVo> list = sYshipService.select_shipment(vo);

//			resultData = ResponseUtils.getJQGridJsonResponse(response, list, currentPage, pageRows, totalRows);
		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	/*************************** New *********************************/
		
	/**
	 * @author josoobin
	 * */
	@ResponseBody
	@RequestMapping(value = "/soobin_vendor", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String soobin_vendor(@ModelAttribute SYProjectMngVo vo,
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session) {
		logger.debug("FrontendController.project_select() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			/*
			if(matnrs != null && StringUtil.trim(matnrs).length() > 0){
				String[] arr_matnr = matnrs.split(",");
				if(arr_matnr.length > 0){
					ArrayList<String> list = new ArrayList<>();
					list.clear();
					for (String p_matnr : arr_matnr) {
						list.add(p_matnr);
					}
					sVo.setMatnrList(list);
				}
			}*/
			
			// Service
			int rowTotal = sYprojectService.soobin_vendor_count(vo);
			int curreCntPage = vo.getPage(); 
			int rowCount = vo.getRows();
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
			if( curreCntPage > rowTotal ){
				vo.setRows(rowCount-(curreCntPage-rowTotal));
			}

		    List<SYProjectMngVo> list = sYprojectService.soobin_vendor(vo);

//			resultData = ResponseUtils.getJQGridJsonResponse(response, list, currentPage, pageRows, totalRows);
		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	/**
	 * @author josoobin
	 * test
	 */
	@ResponseBody
	@RequestMapping(value = "/test", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String test(@ModelAttribute SYMemberVo vo,
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session) {
		logger.debug("FrontendController.test() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			/*
			if(matnrs != null && StringUtil.trim(matnrs).length() > 0){
				String[] arr_matnr = matnrs.split(",");
				if(arr_matnr.length > 0){
					ArrayList<String> list = new ArrayList<>();
					list.clear();
					for (String p_matnr : arr_matnr) {
						list.add(p_matnr);
					}
					sVo.setMatnrList(list);
				}
			}*/
			
			// Service
			int rowTotal = sYprojectService.test_count(vo);
			int curreCntPage = vo.getPage(); 
			int rowCount = vo.getRows();
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
			if( curreCntPage > rowTotal ){
				vo.setRows(rowCount-(curreCntPage-rowTotal));
			}

		    List<SYMemberVo> list = sYprojectService.test(vo);

//			resultData = ResponseUtils.getJQGridJsonResponse(response, list, currentPage, pageRows, totalRows);
		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	
	/**
	 * searchText
	 * 검색조건에 맞은 값만 보여주기
	 * String test = request.getParameter("jsp 에서 설정한 이름"); >> 이렇게 값을 받아 오고
	 *	vo.setMember_nm(test);	// 값을 vo에 설정을 하고 DB로 보낸다.
	 */
	
	@ResponseBody
	@RequestMapping(value = "/searchText", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String searchText(@ModelAttribute SYMemberVo vo,
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session) {
		logger.debug("FrontendController.test() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		System.out.println("vo :: " + request.getParameter("member_nm"));
		
		
		try {
			
//			String name = request.getParameter("search"); // 첨 방법
			
			// 한글 깨짐 방지 && getParameter로  jsp파일로 ajax 보낸 값 가져오기
			String name = request.getParameter("member_nm");
					   // URLDecoder.decode(request.getParameter("search"), "UTF-8" );
									
						//			String name = URLDecoder.decode((URLDecoder.decode("search", "8859_1")), "UTF-8");  // 방법 2		
									// 한번 시도
						//			String name =  encodeURIComponent( encodeURIComponent(request.getParameter("search")) );  // 방법3
									
			// 숫자 처리
			//String member_emp_no = request.getParameter("search");
			
//			System.out.println("test1 : " + request.getParameter("search"));
//			System.out.println("test2 : " + URLDecoder.decode(request.getParameter("search"), "UTF-8" ));
//			System.out.println("test3 : " + URLDecoder.decode((URLDecoder.decode("search", "8859_1")), "UTF-8"));
//			
			
			vo.setMember_nm(name);
			
//			vo.setMember_emp_no(member_emp_no);
			System.out.println("NAME = " + name);
			
			// Service
			int rowTotal = sYprojectService.test_count(vo);
			int curreCntPage = vo.getPage(); 
			int rowCount = vo.getRows();
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
			if( curreCntPage > rowTotal ){
				vo.setRows(rowCount-(curreCntPage-rowTotal));
			}

		    List<SYMemberVo> list = sYprojectService.searchText(vo);
		    System.out.println("############################");
		    System.out.println(list.size());
		    
//			resultData = ResponseUtils.getJQGridJsonResponse(response, list, currentPage, pageRows, totalRows);
		    
		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
//	test_insert
	@ResponseBody
	@RequestMapping(value = "/test_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String test_insert(@ModelAttribute SYMemberVo vo,
										HttpServletRequest request, HttpServletResponse response,
										HttpSession session) {
		logger.debug("FrontendController.test_insert() is called.");
		
		JSONObject resultData = new JSONObject();
		try {			
				System.out.println("aaaa");
				System.out.println("@@@@@@@@ :: " + request.getParameter("member_nm"));
				String member_emp_no = request.getParameter("member_emp_no");
				String member_id	 = request.getParameter("member_id");
				String member_pwd	 = request.getParameter("member_pwd");
				String date_created	 = request.getParameter("date_created");
				String date_updated	 = request.getParameter("date_updated");
				String member_nm 		 = URLDecoder.decode(request.getParameter("member_nm"), "UTF-8" );
				System.out.println("0000");
				vo.setMember_emp_no(member_emp_no);
				vo.setMember_id(member_id);
				vo.setMember_nm(member_nm);
				vo.setMember_pwd(member_pwd);
			
				//String project_no = sYprojectService.get_project_key();
				//vo.setProject_no(project_no);
				
				vo.setCreator(SessionUtil.getMemberId(request));
				vo.setUpdater(SessionUtil.getMemberId(request));
				
				System.out.println("1111");
				int cnt = sYprojectService.test_insert(vo);
				System.out.println("2222");
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.toString());
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/json_test", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String json_test(@ModelAttribute SYMemberVo vo,
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session) {
		logger.debug("FrontendController.json_test() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		//String params;
		String grid;
	
		
		try {
			System.out.println("11");
			grid = URLDecoder.decode(request.getParameter("gridData"), "UTF-8"); // 받아온 값을 String에 담기
			//System.out.println("grid = " + grid);	// 출력해보깅
	
			listDataJArray = (JSONArray)jsonParser.parse(grid);	// parse를 통해 String으로 받아온 값을 JSONArray로 변환 후 담기	
			Object[] keyArr2 = ((JSONObject) listDataJArray.get(0)).keySet().toArray(); // 키추출
			
			for(int idx = 0; idx < listDataJArray.size(); idx++) {
				JSONObject obj = (JSONObject)listDataJArray.get(idx);	// 키[인덱스]
				System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
				for(Object key : keyArr2) {	//첫번째 배열에 담긴 데이터 추출
					String nKey = key.toString();
					String nValue = (obj.get(nKey)==null)?"":obj.get(nKey).toString();
						
					if("member_emp_no".equals(nKey)) {
						System.out.println("Key(member_emp_no) = "+ nKey + ", Value = "+nValue);
					} else if("member_nm".equals(nKey)) {
						System.out.println("Key(member_nm) = "+ nKey + ", Value = "+nValue);
					} else if("recid".equals(nKey)){
						System.out.println("Key(recid) = "+ nKey + ", Value = "+nValue);
					}
				}
				System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			}
			
			
			/*params = URLDecoder.decode(request.getParameter("params"), "UTF-8" );
			System.out.println(params);
			listDataJArray = (JSONArray)jsonParser.parse(params);
			//json key값 추출
			Object[] keyArr = ((JSONObject) listDataJArray.get(0)).keySet().toArray();
			
			//json value값 추출
			for(int idx=0; idx<listDataJArray.size(); idx++) {	//객체 단위로 접근
				JSONObject obj = (JSONObject)listDataJArray.get(idx);	//0번째 순번에선 첫번째 배열값이 나옴
				System.out.println("###################################");
				for(Object key : keyArr) {		//첫번째 배열에 담긴 데이터 추출
					String nKey = key.toString(); 	//첫번째 키값 test1 > test2 > test3..
					String nValue = (obj.get(nKey)==null)?"":obj.get(nKey).toString();	
					if( "test1".equals(nKey) ) 
					{
						System.out.println("nKey :: "+ nKey + " /// nValue ::"+nValue);
					} 
					else if( "test2".equals(nKey) ) 
					{
						System.out.println("nKey :: "+ nKey + " /// nValue ::"+nValue);
					}
					else if( "test3".equals(nKey) ) 
					{
						System.out.println("nKey :: "+ nKey + " /// nValue ::"+nValue);
					}
				}
				System.out.println("###################################");
			}
*/
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", null);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/tTab_select", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String tTab_select(@ModelAttribute SYProjectMngVo vo,
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session) {
		logger.debug("FrontendController.tTab() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		//String params;
		String grid;
	
		
		try {
			System.out.println("11");
			
			int rowTotal = sYprojectService.tTab_count(vo);
			int curreCntPage = vo.getPage(); 
			int rowCount = vo.getRows();
			int pageTotal =  (rowTotal / rowCount);
			if((rowTotal % rowCount) > 0 ) pageTotal++;
			
			if( curreCntPage > rowTotal ){
				vo.setRows(rowCount-(curreCntPage-rowTotal));
			}

		    List<SYProjectMngVo> list = sYprojectService.tTab_select(vo);

//			resultData = ResponseUtils.getJQGridJsonResponse(response, list, currentPage, pageRows, totalRows);
		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
			resultData.put("pageTotal", pageTotal);
			resultData.put("rowTotal", rowTotal);	
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	// tTab_insert
	@ResponseBody
	@RequestMapping(value = "/tTab_insert", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String tTab_insert(@ModelAttribute SYProjectMngVo vo,
										HttpServletRequest request, HttpServletResponse response,
										HttpSession session) {
		logger.debug("FrontendController.tTab_insert() is called.");
		
		JSONObject resultData = new JSONObject();
		try {
			
			String lifnr_nm = URLDecoder.decode(request.getParameter("lifnr_nm"), "UTF-8" );
			String project_nm = URLDecoder.decode(request.getParameter("project_nm"), "UTF-8" );
			String date_created	 = request.getParameter("date_created");
			String date_updated	 = request.getParameter("date_updated");
			
			
			vo.setLifnr_nm(lifnr_nm);
			vo.setProject_nm(project_nm);
			vo.setDate_created(date_created);
			vo.setDate_updated(date_updated);
			
			System.out.println(vo.getSuccess_yn());
			
			// no + 생성+수정자
			String project_no = sYprojectService.get_project_key();	
			vo.setProject_no(project_no);
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			int cnt = sYprojectService.tTab_insert(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	// tTab_update
	@ResponseBody
	@RequestMapping(value = "/tTab_update", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String tTab_update(@ModelAttribute SYProjectMngVo vo,
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session) {
		logger.debug("FrontendController.tTab_update() is called.");
		
		JSONObject resultData = new JSONObject();
		try {
			String project_nm = URLDecoder.decode(request.getParameter("project_nm"), "UTF-8" );
			System.out.println(project_nm);
			
			vo.setProject_nm(project_nm);
			
			System.out.println("vo = " + vo);
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			System.out.println("vo.getSuccess_yn() = " + vo.getSuccess_yn());
			
			int cnt = sYprojectService.tTab_update(vo);
			
			System.out.println("cnt = " + cnt); // 출력 안되짐 쿼리문제인듯.
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	// tTab_delete
	@ResponseBody
	@RequestMapping(value = "/tTab_delete", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String tTab_delete(@ModelAttribute SYProjectMngVo vo,
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session) {
		logger.debug("FrontendController.tTab_delete() is called.");
		
		JSONObject resultData = new JSONObject();
		try {
			int cnt = sYprojectService.tTab_delete(vo);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/production_journal", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String production_journal(@ModelAttribute SYProdTblVo vo,
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session) {
		logger.debug("FrontendController.production_journal() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
		    List<SYProdTblVo> list = sYprodService.prod_tbl_select(vo);

		    String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
}