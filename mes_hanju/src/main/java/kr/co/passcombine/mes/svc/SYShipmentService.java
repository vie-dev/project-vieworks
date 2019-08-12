package kr.co.passcombine.mes.svc;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.List;

import javax.annotation.Resource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;

import kr.co.passcombine.mes.dao.SYScmDAO;
import kr.co.passcombine.mes.dao.SYShipmentDAO;
import kr.co.passcombine.mes.sap.VmesJcoConnectVo;
import kr.co.passcombine.mes.sap.VmesJcoConnection;
import kr.co.passcombine.mes.vo.LogStatusVo;
import kr.co.passcombine.mes.vo.SYHubBomVo;
import kr.co.passcombine.mes.vo.SYInInspVo;
import kr.co.passcombine.mes.vo.SYProdVo;
import kr.co.passcombine.mes.vo.SYReqmMatnrTblVo;
import kr.co.passcombine.mes.vo.SYScmRawCommentVo;
import kr.co.passcombine.mes.vo.SYScmRawDeliveryVo;
import kr.co.passcombine.mes.vo.SYScmRawSernrVo;
import kr.co.passcombine.mes.vo.SYMesCodeVo;
import kr.co.passcombine.mes.vo.SYScmRawVendorResultVo;
import kr.co.passcombine.mes.vo.SYShipmentHordTblVo;
import kr.co.passcombine.mes.vo.SYShipmentSernrVo;
import kr.co.passcombine.mes.vo.SYSlocMasterVo;
import kr.co.passcombine.mes.vo.SYStockVo;
import kr.co.passcombine.mes.util.ExportExcelUtil;
import kr.co.passcombine.mes.util.StringUtil;
import kr.co.passcombine.mes.vo.SYShipmentVo; 

@Service(value = "vmesShipmentService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYShipmentService {

	// private static final Logger logger = LoggerFactory.getLogger(SYCodeService.class);
	@Resource
	private Environment environment;
	
	@Resource(name = "vmesShipmentDAO")
	private SYShipmentDAO shipmentDAO;
	
	
	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject zsdfm_deliv_dat(SYShipmentVo shipVo,  String funcName,  String iv_fdate,  String iv_tdate) {

		System.out.println( " service 시작 "+funcName);

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		List<SYShipmentVo> shipList = new ArrayList<SYShipmentVo>();
		int result1 = 0;

		try {
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo);
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}

			/* == Setting RFC Parameter =================================== */
			function.getImportParameterList().setValue("IV_FDATE", iv_fdate);
			function.getImportParameterList().setValue("IV_TDATE", iv_tdate);
			//function.getImportParameterList().setValue("IV_VBELN", IV_VBELN);
		 

			/* == Return Value Mapping =================================== */
			LogStatusVo logVo = new LogStatusVo();

			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:" + funcName);
			logVo.setBatch_target_ds("shipment_tbl");
			logVo.setBatch_type("M");
			logVo.setBatch_action("U");
 
			connect.executeFunction(function);
 
			JCoTable t_tab = function.getTableParameterList().getTable("ET_LIPS");
 

			for (int i = 0; i < t_tab.getNumRows(); i++) {
				t_tab.setRow(i);
				
				SYShipmentVo sVo = new SYShipmentVo();
	 
				sVo.setVbeln(t_tab.getString("VBELN"));
				sVo.setPosnr(t_tab.getString("POSNR"));
				sVo.setIf_flag(t_tab.getString("IF_FLAG"));
				sVo.setLfart(t_tab.getString("LFART"));
				sVo.setVtext_lfart(t_tab.getString("VTEXT_LFART"));
				sVo.setVstel(t_tab.getString("VSTEL"));
				sVo.setVtext_vstel(t_tab.getString("VTEXT_VSTEL"));
				sVo.setWerks(t_tab.getString("WERKS"));
				sVo.setName1_werks(t_tab.getString("NAME1_WERKS"));
				sVo.setLgort(t_tab.getString("LGORT"));
				sVo.setLgobe(t_tab.getString("LGOBE"));
				sVo.setMatnr(t_tab.getString("MATNR"));
				sVo.setArktx(t_tab.getString("ARKTX"));
				sVo.setLfimg(t_tab.getString("LFIMG"));
				sVo.setVrkme_do(t_tab.getString("VRKME_DO"));
				sVo.setLgmng(t_tab.getString("LGMNG"));
				sVo.setMeins_do(t_tab.getString("MEINS_DO"));
				sVo.setUmvkz(t_tab.getString("UMVKZ"));
				sVo.setUmvkn(t_tab.getString("UMVKN"));
				sVo.setUebto(t_tab.getString("UEBTO"));
				sVo.setErdat_do(t_tab.getString("ERDAT_DO"));
				sVo.setErnam_do(t_tab.getString("ERNAM_DO"));
				sVo.setWadat(t_tab.getString("WADAT"));
				sVo.setText_z001(t_tab.getString("TEXT_Z001"));
				sVo.setVkorg(t_tab.getString("VKORG"));
				sVo.setVtext_vkorg(t_tab.getString("VTEXT_VKORG"));
				sVo.setVtweg(t_tab.getString("VTWEG"));
				sVo.setVtext_vtweg(t_tab.getString("VTEXT_VTWEG"));
				sVo.setSpart(t_tab.getString("SPART"));
				sVo.setVtext_spart(t_tab.getString("VTEXT_SPART"));
				sVo.setVkbur(t_tab.getString("VKBUR"));
				sVo.setBezei_vkbur(t_tab.getString("BEZEI_VKBUR"));
				sVo.setVkgrp(t_tab.getString("VKGRP"));
				sVo.setBezei_vkgrp(t_tab.getString("BEZEI_VKGRP"));
				sVo.setInco1(t_tab.getString("INCO1"));
				sVo.setInco2(t_tab.getString("INCO2"));
				sVo.setVgbel(t_tab.getString("VGBEL"));
				sVo.setVgpos(t_tab.getString("VGPOS"));
				sVo.setKunnr_ag(t_tab.getString("KUNNR_AG"));
				sVo.setName1_kunnr_ag(t_tab.getString("NAME1_KUNNR_AG"));
				sVo.setName2_kunnr_ag(t_tab.getString("NAME2_KUNNR_AG"));
				sVo.setLand1_kunnr_ag(t_tab.getString("LAND1_KUNNR_AG"));
				sVo.setCity1_kunnr_ag(t_tab.getString("CITY1_KUNNR_AG"));
				sVo.setStreet_kunnr_ag(t_tab.getString("STREET_KUNNR_AG"));
				sVo.setStr_suppl1_kunnr_ag(t_tab.getString("STR_SUPPL1_KUNNR_AG"));
				sVo.setStr_suppl2_kunnr_ag(t_tab.getString("STR_SUPPL2_KUNNR_AG"));
				sVo.setPstlz_kunnr_ag(t_tab.getString("PSTLZ_KUNNR_AG"));
				sVo.setJ_1kfrepre_kunnr_ag(t_tab.getString("J_1KFREPRE_KUNNR_AG"));
				sVo.setJ_1kftind_kunnr_ag(t_tab.getString("J_1KFTIND_KUNNR_AG"));
				sVo.setJ_1kftbus_kunnr_ag(t_tab.getString("J_1KFTBUS_KUNNR_AG"));
				sVo.setStcd1_kunnr_ag(t_tab.getString("STCD1_KUNNR_AG"));
				sVo.setStcd2_kunnr_ag(t_tab.getString("STCD2_KUNNR_AG"));
				sVo.setStcd3_kunnr_ag(t_tab.getString("STCD3_KUNNR_AG"));
				sVo.setTelf1_kunnr_ag(t_tab.getString("TELF1_KUNNR_AG"));
				sVo.setTelf2_kunnr_ag(t_tab.getString("TELF2_KUNNR_AG"));
				sVo.setTelfx_kunnr_ag(t_tab.getString("TELFX_KUNNR_AG"));
				sVo.setSmtp_addr_kunnr_ag(t_tab.getString("SMTP_ADDR_KUNNR_AG"));
				sVo.setKunnr_we(t_tab.getString("KUNNR_WE"));
				sVo.setName1_kunnr_we(t_tab.getString("NAME1_KUNNR_WE"));
				sVo.setName2_kunnr_we(t_tab.getString("NAME2_KUNNR_WE"));
				sVo.setLand1_kunnr_we(t_tab.getString("LAND1_KUNNR_WE"));
				sVo.setCity1_kunnr_we(t_tab.getString("CITY1_KUNNR_WE"));
				sVo.setStreet_kunnr_we(t_tab.getString("STREET_KUNNR_WE"));
				sVo.setStr_suppl1_kunnr_we(t_tab.getString("STR_SUPPL1_KUNNR_WE"));
				sVo.setStr_suppl2_kunnr_we(t_tab.getString("STR_SUPPL2_KUNNR_WE"));
				sVo.setPstlz_kunnr_we(t_tab.getString("PSTLZ_KUNNR_WE"));
				sVo.setJ_1kfrepre_kunnr_we(t_tab.getString("J_1KFREPRE_KUNNR_WE"));
				sVo.setJ_1kftind_kunnr_we(t_tab.getString("J_1KFTIND_KUNNR_WE"));
				sVo.setJ_1kftbus_kunnr_we(t_tab.getString("J_1KFTBUS_KUNNR_WE"));
				sVo.setStcd1_kunnr_we(t_tab.getString("STCD1_KUNNR_WE"));
				sVo.setStcd2_kunnr_we(t_tab.getString("STCD2_KUNNR_WE"));
				sVo.setStcd3_kunnr_we(t_tab.getString("STCD3_KUNNR_WE"));
				sVo.setTelf1_kunnr_we(t_tab.getString("TELF1_KUNNR_WE"));
				sVo.setTelf2_kunnr_we(t_tab.getString("TELF2_KUNNR_WE"));
				sVo.setTelfx_kunnr_we(t_tab.getString("TELFX_KUNNR_WE"));
				sVo.setSmtp_addr_kunnr_we(t_tab.getString("SMTP_ADDR_KUNNR_WE"));
				sVo.setKunnr_z1(t_tab.getString("KUNNR_Z1"));
				sVo.setName1_kunnr_z1(t_tab.getString("NAME1_KUNNR_Z1"));
				sVo.setName2_kunnr_z1(t_tab.getString("NAME2_KUNNR_Z1"));
				sVo.setKunnr_z2(t_tab.getString("KUNNR_Z2"));
				sVo.setName1_kunnr_z2(t_tab.getString("NAME1_KUNNR_Z2"));
				sVo.setTelf2_kunnr_z2(t_tab.getString("TELF2_KUNNR_Z2"));
				sVo.setErdat_so(t_tab.getString("ERDAT_SO"));
				sVo.setErnam_so(t_tab.getString("ERNAM_SO"));
				sVo.setAuart(t_tab.getString("AUART"));
				sVo.setBezei_auart(t_tab.getString("BEZEI_AUART"));
				sVo.setAugru(t_tab.getString("AUGRU"));
				sVo.setBezei_augru(t_tab.getString("BEZEI_AUGRU"));
				sVo.setEdatu(t_tab.getString("EDATU"));
				sVo.setKwmeng(t_tab.getString("KWMENG"));
				sVo.setVrkme_so(t_tab.getString("VRKME_SO"));
				sVo.setOrigin_vbeln(t_tab.getString("ORIGIN_VBELN"));
				sVo.setZzwarranty(t_tab.getString("ZZWARRANTY"));
				sVo.setBstkd(t_tab.getString("BSTKD"));
				sVo.setName_p4(t_tab.getString("NAME_P4"));
				sVo.setPst_p4(t_tab.getString("PST_P4"));
				sVo.setDpt_p4(t_tab.getString("DPT_P4"));
				sVo.setPhone_p4(t_tab.getString("PHONE_P4"));
				sVo.setEmail_p4(t_tab.getString("EMAIL_P4"));
				sVo.setSernp(t_tab.getString("SERNP"));
				sVo.setStrgr(t_tab.getString("STRGR"));

				shipList.add(sVo);
				
				if(t_tab.getString("IF_FLAG").equals("D")) {
					
					if(t_tab.getString("POSNR").equals("000000")){
						result1 = shipmentDAO.update_zsdfm_deliv_datall(sVo);
						
					}else{
						result1 = shipmentDAO.update_zsdfm_deliv_dat(sVo);
					}		
					
				} else{
					
					result1 = shipmentDAO.insert_zsdfm_deliv_dat(sVo);
					
				}
			

			}
			
			
			JSONObject resultObj = new JSONObject();
			resultObj.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
			resultObj.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));
			listDataJArray.add(resultObj);;
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");
			 

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		resultData.put("rows", listDataJArray);
		return resultData;
	}

	@Transactional
	public List<SYShipmentVo> select_shipment_tbl(SYShipmentVo vVo) {
		return shipmentDAO.select_shipment_tbl(vVo);
	}

	@Transactional
	public List<SYShipmentSernrVo> shipmentSernr_select(SYShipmentSernrVo vVo) {
		return shipmentDAO.shipmentSernr_select(vVo);
	}

	@Transactional
	public int shipmentSernr_insert(List<SYShipmentSernrVo> voList) {
		int result = 0;
		for( SYShipmentSernrVo vo : voList ){
			result += shipmentDAO.shipmentSernr_insert(vo);
		}
		return result;
	}
	
	@Transactional
	public int shipmentSernr_delete(List<SYShipmentSernrVo> voList) {
		int result = 0;
//		for( SYShipmentSernrVo vo : voList ){
//			result += shipmentDAO.shipmentSernr_delete(vo);
//		}
		result = shipmentDAO.shipmentSernr_delete(voList.get(0));
		return result;
	}	

	@Transactional
	public int shipment_update(List<SYShipmentVo> voList) {
		int result = 0;
		for( SYShipmentVo vo : voList ){
			result += shipmentDAO.shipment_update(vo);
		}
		return result;
	}

	public JSONObject sapStockSync(ArrayList<String> matnrs_list) {
		
		SYStockVo sVo = new SYStockVo();
		String funcName = "ZMMFM_SLOC_STOCK";
		sVo.setMatnrList(matnrs_list);
		JSONObject resultData = zmmfm_sloc_stock(sVo, funcName);
		
		return resultData;
	}
	
	public JSONObject sapStockChk(SYShipmentVo sVo) {
		
		JSONObject resultData = new JSONObject();
		
		List<SYShipmentVo> result_list = shipmentDAO.select_shipment_tbl(sVo);
		
		String sernr = sVo.getSernr();
		
		String lfart = "";
		String sernp = "";
		String strgr = "";
		String werks = "";
		String lgort = "";
		String vgbel = "";
		String vgpos = "";
		String matnr = "";
		
		for(int i=0 ; i<result_list.size(); i++) {
			lfart = result_list.get(i).getLfart();
			sernp = result_list.get(i).getSernp();
			strgr = result_list.get(i).getStrgr();
			
			werks = result_list.get(i).getWerks();
			lgort = result_list.get(i).getLgort();
			vgbel = result_list.get(i).getVgbel();
			vgpos = result_list.get(i).getVgpos();
			vgpos = result_list.get(i).getVgpos();
			matnr = result_list.get(i).getMatnr();
		}
			
		if(lfart.equals("LF")) {
			if(sernp.equals("V001")) {
				if(strgr.equals("20") || strgr.equals("50")) {
					//case1
					SYStockVo pVo = new SYStockVo();
					pVo.setB_werk(werks);
					pVo.setB_lager(lgort);
					pVo.setKdauf(vgbel);
					pVo.setKdpos(vgpos);
					pVo.setMatnr(matnr);
					pVo.setSernr(sernr);
					
					List<SYStockVo> result = shipmentDAO.stock_item_tbl_select(pVo);
					
					if(result.size() == 0)  {
						resultData.put("case", "1");
						resultData.put("flag", "N");
						resultData.put("result", "입력 된 시리얼번호는 플랜트-저장위치-판매오더 내 존재하지 않습니다");
					}
					else {
						resultData.put("case", "1");
						resultData.put("flag", "Y");
						resultData.put("result", "");
					}						
				} else {
					//case2
					SYStockVo pVo = new SYStockVo();
					pVo.setB_werk(werks);
					pVo.setB_lager(lgort);
					pVo.setMatnr(matnr);
					pVo.setSernr(sernr);
					
					List<SYStockVo> result = shipmentDAO.stock_item_tbl_select(pVo);
					
					if(result.size() == 0)  {
						resultData.put("case", "2");
						resultData.put("flag", "N");
						resultData.put("result", "입력 된 시리얼번호는 플랜트-저장위치 내 존재하지 않습니다");
					}
					else {
						resultData.put("case", "2");
						resultData.put("flag", "Y");
						resultData.put("result", "");
					}
				}
			}	else {
			//case3
			SYStockVo pVo = new SYStockVo();
			pVo.setWerks(werks);
			pVo.setLgort(lgort);
			pVo.setMatnr(matnr);
			
			List<SYStockVo> result = shipmentDAO.stock_header_tbl_select(pVo);
			
			if(result.size() == 0)  {
//				resultData.put("case", "3");
//				resultData.put("flag", "N");
//				resultData.put("result", "");
			}
			else {
//				resultData.put("case", "3");
//				resultData.put("flag", "Y");
//				resultData.put("result", "");
			}						
		}
	}
		return resultData;
	}
	
	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject zmmfm_sloc_stock(SYStockVo shipVo,  String funcName) {

		System.out.println( " service 시작 "+funcName);

		ArrayList<String> matnr_list = shipVo.getMatnrList();
//		ArrayList<String> lgort_list = shipVo.getLgortList();
		String matnr = shipVo.getMatnr();
		String lgort = shipVo.getLgort();
		String werks = shipVo.getWerks();

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		int result1 = 0;
		int result2 = 0;

		try {
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo);
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}

			/* == Setting RFC Parameter =================================== */
			
			
			JCoTable it_matnr = null;
			JCoTable it_lgort = null;
			JCoTable it_werks = null;
			
			if(matnr_list != null) {
				if(matnr_list.size() > 0) {
					 it_matnr = function.getTableParameterList().getTable("IT_MATNR");
					
					it_matnr.appendRows(matnr_list.size());
					for (int i = 0; i < matnr_list.size(); i++) {
						it_matnr.setRow(i);
						
						it_matnr.setValue("LOW", (matnr_list.get(i)).trim());
						it_matnr.setValue("HIGH", (matnr_list.get(i)).trim());
						
						it_matnr.nextRow();
					}
					
					function.getTableParameterList().setValue("IT_MATNR", it_matnr);
				}
			}
			
			if(matnr != null) {
				if(matnr.length() > 0 ) {
					it_matnr = function.getTableParameterList().getTable("IT_MATNR");
		
					it_matnr.appendRows(1);
					
					it_matnr.setRow(0);
						
					it_matnr.setValue("LOW", (matnr.trim()));
					it_matnr.setValue("HIGH", (matnr.trim()));
					
					function.getTableParameterList().setValue("IT_MATNR", it_matnr);
				}
			}
			
			if(lgort != null) {
				if(lgort.length() > 0 ) {
					
					System.out.println("#######################");
					System.out.println(lgort);
					System.out.println(lgort.length());
					
					it_lgort = function.getTableParameterList().getTable("IT_LGORT");
		
					it_lgort.appendRows(1);
					
					it_lgort.setRow(0);
						
					it_lgort.setValue("LOW", (lgort.trim()));
					it_lgort.setValue("HIGH", (lgort.trim()));
					
					function.getTableParameterList().setValue("IT_LGORT", it_lgort);
				}
			}
			
			if(werks != null) {
				if(werks.length() > 0 ) {
					it_werks = function.getTableParameterList().getTable("IT_WERKS");
		
					it_werks.appendRows(1);
					
					it_werks.setRow(0);
						
					
					it_werks.setValue("LOW", (werks.trim()));
					it_werks.setValue("HIGH", (werks.trim()));
					
					function.getTableParameterList().setValue("IT_WERKS", it_werks);
				}
			}			
			
			System.out.println("########################################3");
			System.out.println("it_matnr :: " + it_matnr);
			System.out.println("it_lgort :: " + it_lgort);
			System.out.println("it_werks :: " + it_werks);
			
			
			/* == Return Value Mapping =================================== */
			LogStatusVo logVo = new LogStatusVo();

			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:" + funcName);
			logVo.setBatch_target_ds("-");
			logVo.setBatch_type("M");
			logVo.setBatch_action("U");
 
			connect.executeFunction(function);
			
			JCoTable et_mard = function.getTableParameterList().getTable("ET_MARD");
			System.out.println(et_mard);
			JCoTable et_equi = function.getTableParameterList().getTable("ET_EQUI");
			System.out.println(et_equi);
 

			
			
			for (int i = 0; i < et_mard.getNumRows(); i++) {
				et_mard.setRow(i);
				
				SYStockVo pVo = new SYStockVo();

				pVo.setWerks(et_mard.getString("WERKS"));
				pVo.setLgort(et_mard.getString("LGORT"));
				pVo.setLifnr(et_mard.getString("LIFNR"));
				pVo.setKunnr(et_mard.getString("KUNNR"));
				pVo.setMatnr(et_mard.getString("MATNR"));
				pVo.setLabst(et_mard.getString("LABST"));
				
				result1 = shipmentDAO.insert_stock_header_tbl(pVo);
			}

			for (int i = 0; i < et_equi.getNumRows(); i++) {
				et_equi.setRow(i);
				
				SYStockVo pVo = new SYStockVo();

				pVo.setB_werk(et_equi.getString("B_WERK"));
				pVo.setB_lager(et_equi.getString("B_LAGER"));
				pVo.setKunnr(et_equi.getString("KUNNR"));
				pVo.setLifnr(et_equi.getString("LIFNR"));
				pVo.setKdauf(et_equi.getString("KDAUF"));
				pVo.setKdpos(et_equi.getString("KDPOS"));
				pVo.setPs_psp_pnr(et_equi.getString("PS_PSP_PNR"));
				pVo.setMatnr(et_equi.getString("MATNR"));
				pVo.setSernr(et_equi.getString("SERNR"));
				
				result2 = shipmentDAO.insert_stock_item_tbl(pVo);
			}
			
			JSONObject resultObj = new JSONObject();
			resultData.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
			resultData.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");
			 

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}

		return resultData;
	}

	public JSONObject zsdfm_deliv_change(String vbeln, String funcName, String iv_action) {
		System.out.println( " service 시작 "+funcName);

		SYShipmentVo sVo = new SYShipmentVo();
		SYShipmentSernrVo ssVo = new SYShipmentSernrVo();
		
		sVo.setVbeln(vbeln);
		ssVo.setVbeln(vbeln);
		
		List<SYShipmentVo> ship_list = select_shipment_tbl(sVo);
		List<SYShipmentSernrVo> ship_sernr_list = shipmentSernr_select(ssVo);
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		int result1 = 0;
		int result2 = 0;

		try {
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo);
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}

			/* == Setting RFC Parameter =================================== */
			
//			JCoTable lips_table = function.getTableParameterList().getTable("LIPS_TABLE");
//			lips_table.appendRows(ship_sernr_list.size());
//			for (int i = 0; i < ship_list.size(); i++) {
//				//lips_table.setRow(i);
//				for(int j=0 ; j<ship_sernr_list.size(); j++) {
//					
//				}	
//				lips_table.setValue("LOW", matnr_list.get(i));
//				lips_table.setValue("HIGH", matnr_list.get(i));
//
//				lips_table.nextRow();
//			}

			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar c1 = Calendar.getInstance();
			String strToday = sdf.format(c1.getTime());
			  
			JCoTable it_lips = function.getTableParameterList().getTable("IT_LIPS");
			it_lips.appendRows(ship_sernr_list.size());
			int idx =0;
			for (int i = 0; i < ship_list.size(); i++) {
				
				String posnr = ship_list.get(i).getPosnr();
				
				for(int j=0 ; j<ship_sernr_list.size(); j++) {
					
					if(!posnr.equals(ship_sernr_list.get(j).getPosnr())) {
						continue;
					}
						it_lips.setRow(idx);
						
						it_lips.setValue("VBELN", ship_list.get(i).getVbeln());
						it_lips.setValue("POSNR", ship_list.get(i).getPosnr());
						it_lips.setValue("SERNR", ship_sernr_list.get(j).getSernr());
						it_lips.setValue("IF_FLAG", ship_list.get(i).getIf_flag());
						it_lips.setValue("WADAT_IST", strToday);
						it_lips.setValue("LFART", ship_list.get(i).getLfart());
						it_lips.setValue("VTEXT_LFART", ship_list.get(i).getVtext_lfart());
						it_lips.setValue("VSTEL", ship_list.get(i).getVstel());
						it_lips.setValue("VTEXT_VSTEL", ship_list.get(i).getVtext_vstel());
						it_lips.setValue("WERKS", ship_list.get(i).getWerks());
						it_lips.setValue("NAME1_WERKS", ship_list.get(i).getName1_werks());
						it_lips.setValue("LGORT", ship_list.get(i).getLgort());
						it_lips.setValue("LGOBE", ship_list.get(i).getLgobe());
						it_lips.setValue("MATNR", ship_list.get(i).getMatnr());
						it_lips.setValue("ARKTX", ship_list.get(i).getArktx());						
						if( "V001".equals(ship_list.get(i).getSernp())) {
							it_lips.setValue("LFIMG", "1");	
						} else {
							it_lips.setValue("LFIMG", ship_list.get(i).getLfimg());
						}
						it_lips.setValue("VRKME_DO", ship_list.get(i).getVrkme_do());
						it_lips.setValue("VKORG", ship_list.get(i).getVkorg());
						it_lips.setValue("VTEXT_VKORG", ship_list.get(i).getVtext_vkorg());
						it_lips.setValue("VTWEG", ship_list.get(i).getVtweg());
						it_lips.setValue("VTEXT_VTWEG", ship_list.get(i).getVtext_vtweg());
						it_lips.setValue("SPART", ship_list.get(i).getSpart());
						it_lips.setValue("VTEXT_SPART", ship_list.get(i).getVtext_spart());
						it_lips.setValue("VKBUR", ship_list.get(i).getVkbur());
						it_lips.setValue("BEZEI_VKBUR", ship_list.get(i).getBezei_vkbur());
						it_lips.setValue("VKGRP", ship_list.get(i).getVkgrp());
						it_lips.setValue("BEZEI_VKGRP", ship_list.get(i).getBezei_vkgrp());
						it_lips.setValue("VGBEL", ship_list.get(i).getVgbel());
						it_lips.setValue("VGPOS", ship_list.get(i).getVgpos());
						it_lips.setValue("SERNP", ship_list.get(i).getSernp());
						it_lips.setValue("STRGR", ship_list.get(i).getStrgr());					
					
						idx++;
						it_lips.nextRow();
		
				}	
			}
			
			System.out.println("############################################################");
			System.out.println(iv_action);
			System.out.println(it_lips);
			System.out.println("############################################################");
			function.getImportParameterList().setValue("IV_ACTION", iv_action);	
			function.getTableParameterList().setValue("IT_LIPS", it_lips);
						
			/* == Return Value Mapping =================================== */
			LogStatusVo logVo = new LogStatusVo();

			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:" + funcName);
			logVo.setBatch_target_ds("shipment_tbl");
			logVo.setBatch_type("M");
			logVo.setBatch_action("U");
 
			connect.executeFunction(function);
			
			JSONObject resultObj = new JSONObject();
			resultData.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
			resultData.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));
			
			System.out.println(function.getExportParameterList().getString("EV_MESSAGE"));

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");
			 

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}

		return resultData;
	}

	public List<SYShipmentVo> shipment_do_group_select(SYShipmentVo shipVo) {
		return shipmentDAO.shipment_do_group_select(shipVo);
	}
	
	public List<SYStockVo> stock_header_tbl_select(SYStockVo pVo) {
		return shipmentDAO.stock_header_tbl_select(pVo);
	}
	
	public List<SYProdVo> packing_joblist_select(SYProdVo pVo) {
		return shipmentDAO.packing_joblist_select(pVo);
	}

	public List<SYProdVo> packing_jobDetailList_select(SYProdVo pVo) {
		return shipmentDAO.packing_jobDetailList_select(pVo);
	}
	
	public List<SYShipmentVo> shipment_select(SYShipmentVo vo) {
		return shipmentDAO.shipment_select(vo);
	}
	
	public List<SYShipmentVo> shipment_select_o(SYShipmentVo vo) {
		return shipmentDAO.shipment_select_o(vo);
	}
	
	public List<SYProdVo> getSerialInfo(SYShipmentVo vo) {
		return shipmentDAO.getSerialInfo(vo);
	}

	public int select_shipment_count(SYShipmentHordTblVo vo) {
		return shipmentDAO.select_shipment_count(vo);
	}
	
	public List<SYShipmentHordTblVo> select_shipment(SYShipmentHordTblVo vo) {
		return shipmentDAO.select_shipment(vo);
	}
}


