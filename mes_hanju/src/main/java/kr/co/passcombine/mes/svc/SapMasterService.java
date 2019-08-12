package kr.co.passcombine.mes.svc;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;

import kr.co.passcombine.mes.dao.LogStatusDAO;
import kr.co.passcombine.mes.dao.SYHubDAO;
import kr.co.passcombine.mes.dao.SYMesDAO;
import kr.co.passcombine.mes.dao.SYQmDAO;
import kr.co.passcombine.mes.sap.VmesJcoConnectVo;
import kr.co.passcombine.mes.sap.VmesJcoConnection;
import kr.co.passcombine.mes.util.StringUtil;
import kr.co.passcombine.mes.vo.LogStatusVo;
import kr.co.passcombine.mes.vo.SYCostTypeVo;
import kr.co.passcombine.mes.vo.SYHubBomVo;
import kr.co.passcombine.mes.vo.SYInInspVo;
import kr.co.passcombine.mes.vo.SYIoTypeVo;
import kr.co.passcombine.mes.vo.SYMaterialSendMasterVo;
import kr.co.passcombine.mes.vo.SYMoveTypeVo;
import kr.co.passcombine.mes.vo.SYProdVo;
import kr.co.passcombine.mes.vo.SYPoRequirementVo;
import kr.co.passcombine.mes.vo.SYQmVo;
import kr.co.passcombine.mes.vo.SYReqmMatnrTblVo;
//import kr.co.passcombine.mes.vo.SYScmRawDeliveryVo;
import kr.co.passcombine.mes.vo.SYScmRawProcSernrVo;
import kr.co.passcombine.mes.vo.SYScmRawProcSubVo;
import kr.co.passcombine.mes.vo.SYScmRawProcVo;
//import kr.co.passcombine.mes.vo.SYScmRawSernrVo;
import kr.co.passcombine.mes.vo.SYScmRawVendorResultVo;
import kr.co.passcombine.mes.vo.SYSernrManageVo;
import kr.co.passcombine.mes.vo.SYShipmentSernrVo;
import kr.co.passcombine.mes.vo.SYShipmentVo;
import kr.co.passcombine.mes.vo.SYSlocMasterVo;
//import kr.co.passcombine.mes.vo.SYStockVo;
import kr.co.passcombine.mes.vo.SYVendorVo;
//import kr.co.passcombine.mes.vo.SYWfwotherVo;
import kr.co.passcombine.mes.svc.SYProdService;

@Component("vmesSapMasterService")
@PropertySource("classpath:/app.properties")
public class SapMasterService {

	@Resource
	private Environment environment;

	@Resource(name = "vmesLogStatusDAO")
	private LogStatusDAO logStatusDAO;

	@Resource(name = "vmesProdService")
	SYProdService sYprodService;

	@Resource(name = "vmesScmService")
	SYScmService sYScmService;

	@Resource(name = "vmesMesService")
	SYMesService sYMesService;

	@Resource(name = "vmesHubService")
	SYHubService sYHubService;

	@Resource(name = "vmesQmDAO")
	private SYQmDAO sYQmDAO;

	@Resource(name = "vmesHubDAO")
	private SYHubDAO hubDAO;
	
	@Resource(name = "vmesMesDAO")
	private SYMesDAO mesDAO;
	

	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject execProdMaster(SYProdVo prodVo) {
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		try {
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo);
			JCoFunction function = connect.getFunction("ZSD_MASTER_PROD");
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}

			/* == Setting RFC Parameter =================================== */
			function.getImportParameterList().setValue("I_TDATE", prodVo.getCell());

			/* == Return Value Mapping =================================== */
			LogStatusVo logVo = new LogStatusVo();
			try {
				logVo.setCreator("system");
				logVo.setUpdater("system");
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:ZSD_MASTER_PROD");
				logVo.setBatch_target_ds("prod_tbl");
				logVo.setBatch_type("M");
				logVo.setBatch_action("U");

				connect.executeFunction(function);

				JSONObject resultObj = new JSONObject();
				JCoTable t_tab = function.getTableParameterList().getTable("T_TAB1");

				resultObj.put("e_return", function.getExportParameterList().getString("E_RETURN"));
				resultObj.put("e_message", function.getExportParameterList().getString("E_MESSAGE"));
				listDataJArray.add(resultObj);

				logVo.setBatch_result("S");
				logVo.setBatch_description("");
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");

			} catch (Exception ex) {
				logVo.setBatch_result("F");
				logVo.setBatch_description(ex.toString());
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				ex.printStackTrace();
			} finally {
				logVo.setBatch_end_dt(StringUtil.getDateTime());
				logStatusDAO.insertLogStatus(logVo);
			}
			resultData.put("rows", listDataJArray);

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}

	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject mesMatrReqDetailSelectCall(String pordno, String funcName) {
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		try {
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo);
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			LogStatusVo logVo = new LogStatusVo();

			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:" + funcName);
			logVo.setBatch_target_ds("생산");
			logVo.setBatch_type("M");
			logVo.setBatch_action("U");
			/* == Setting RFC Parameter =================================== */
			function.getImportParameterList().setValue("CAUFV-AUFNR", pordno);

			/* == Return Value Mapping =================================== */
			try {
				connect.executeFunction(function);

				JSONObject resultObj = new JSONObject();
				JCoTable t_tab = function.getTableParameterList().getTable("ET_OUTPUT");

				resultObj.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
				resultObj.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));
				listDataJArray.add(resultObj);

				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");

			} catch (Exception ex) {
				resultData.put("status",HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				ex.printStackTrace();
			}
			resultData.put("rows", listDataJArray);

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}
/*
	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject zmmfm_purch_ord(String funcName, JSONObject paramObj) {
		JSONObject resultData = new JSONObject();
		JSONObject resultObj = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		LogStatusVo logVo = new LogStatusVo();
		try {
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo);
			JCoFunction function = connect.getFunction(funcName);

			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			// == Setting RFC Parameter =================================== 
			function.getImportParameterList().getStructure("IS_AEDAT").setValue("LOW", paramObj.get("datFrom"));
			function.getImportParameterList().getStructure("IS_AEDAT").setValue("HIGH", paramObj.get("datTo"));
			// == Return Value Mapping =================================== 

			try {
				logVo.setCreator("system");
				logVo.setUpdater("system");
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:ZMMFM_PURCH_ORD");
				logVo.setBatch_target_ds("RAW_DELIVERY_TBL");
				logVo.setBatch_type("M");
				logVo.setBatch_action("U");
				
				connect.executeFunction(function);

				JCoTable ekpo = (JCoTable)function.getTableParameterList().getTable("ET_EKPO");
				for (int i = 0; i < ekpo.getNumRows(); i++, ekpo.nextRow()) {
					SYScmRawDeliveryVo iVo = new SYScmRawDeliveryVo();
					iVo.setEbeln(ekpo.getString("EBELN")); //구매문서번호
					iVo.setEbelp(ekpo.getString("EBELP")); //구매문서품목번호
					iVo.setLoekz(ekpo.getString("LOEKZ")); //구매문서의삭제지시자
					iVo.setTxz01(ekpo.getString("TXZ01")); //납품내역
					iVo.setMatnr(ekpo.getString("MATNR")); //자재번호
					iVo.setBukrs(ekpo.getString("BUKRS")); //회사코드
					iVo.setWerks(ekpo.getString("WERKS")); //플랜트
					iVo.setLgort(ekpo.getString("LGORT")); //저장위치
					iVo.setLgobe(ekpo.getString("LGOBE")); //저장위치명
					iVo.setMatkl(ekpo.getString("MATKL")); //자재그릅
					iVo.setWgbez(ekpo.getString("WGBEZ")); //자재그룹명
					iVo.setIdnlf(ekpo.getString("IDNLF")); //공급업체가사용하는 자재번호
					iVo.setEindt(ekpo.getString("EINDT")); //납품일자
					iVo.setVendor_delivery_date(ekpo.getString("EINDT")); //납품일자
					iVo.setMenge(ekpo.getString("MENGE")); //구매오더수량
//					iVo.setZdeli_menge(ekpo.getString("ZDELI_MENGE")); //납품수량
					iVo.setZdeli_menge(ekpo.getString("MENGE")); //납품수량
					iVo.setZdue_menge(ekpo.getString("ZDUE_MENGE")); //잔량
					iVo.setMeins(ekpo.getString("MEINS")); //구매오더단위
					iVo.setNetpr(ekpo.getString("NETPR")); //구매문서의단가(전표통화)
					iVo.setPeinh(ekpo.getString("PEINH")); //가격단위
					iVo.setNetwr(ekpo.getString("NETWR")); //순오더금액(po통화)
					iVo.setElikz(ekpo.getString("ELIKZ")); //납품완료지시자
					iVo.setErekz(ekpo.getString("EREKZ")); //최종송장지시자
					iVo.setPstyp(ekpo.getString("PSTYP")); //구매문서의품목범주
					iVo.setKnttp(ekpo.getString("KNTTP")); //계정지정범주
					iVo.setSernp(ekpo.getString("SERNP")); //시리얼관리대상여부 관리 Y ELSE N
					iVo.setLabnr(ekpo.getString("LABNR")); //납품일정번호
					sYScmService.rawDelivery_insert(iVo);
					
					SYScmRawVendorResultVo tmpVo = new SYScmRawVendorResultVo();
					tmpVo.setEbeln(iVo.getEbeln());
					tmpVo.setEbelp(iVo.getEbelp());
					tmpVo.setLabnr(iVo.getLabnr());
					
					int cnt = sYScmService.rawVendorResultEbelp_update(tmpVo);
					if( cnt > 0 ){
						sYScmService.rawSernrEbelp_update(tmpVo);	// update serial
//						sYScmService.rawProcSernrEbelp_update(tmpVo);	// update serial
						SYScmRawDeliveryVo dVo = new SYScmRawDeliveryVo();
						dVo.setEbeln(iVo.getEbeln());
						dVo.setEbelp(iVo.getEbelp());
						dVo.setRorder_status("r3");
						dVo.setRvendor_status("v2");
						sYScmService.rawDeliverySta_update(dVo);
					}
					//사급오더 개발관련 syc 
				}
				
				JCoTable ekko = (JCoTable)function.getTableParameterList().getTable("ET_EKKO");
				List<SYScmRawDeliveryVo> rdVoList = new ArrayList<SYScmRawDeliveryVo>();
				for (int i = 0; i < ekko.getNumRows(); i++, ekko.nextRow()) {
					SYScmRawDeliveryVo rdVo = new SYScmRawDeliveryVo();
					rdVo.setEbeln(ekko.getString("EBELN"));
					rdVo.setBstyp(ekko.getString("BSTYP"));	//구매문서범주
					rdVo.setBsart(ekko.getString("BSART")); //구매문서유형
					rdVo.setAedat(ekko.getString("AEDAT")); //레코드생성일
					rdVo.setErnam(ekko.getString("ERNAM")); //오브젝트생성자이름
					rdVo.setLifnr(ekko.getString("LIFNR")); //공급업체계정번호
					rdVo.setName1(ekko.getString("NAME1")); //공급업체명
					rdVo.setEkgrp(ekko.getString("EKGRP")); //구매구룹
					rdVo.setEknam(ekko.getString("EKNAM")); //구매그룹명
					rdVo.setZcsreq(ekko.getString("IHREZ")); //csr 번호
					rdVoList.add(rdVo);
					sYScmService.rawDelivery_update(rdVo);
				}
				
				JCoTable et_resb  = (JCoTable)function.getTableParameterList().getTable("ET_RESB");
				List<SYScmRawVendorResultVo> reVoList = new ArrayList<SYScmRawVendorResultVo>();
				for (int i = 0; i < et_resb.getNumRows(); i++, et_resb.nextRow()) {
					SYScmRawVendorResultVo reVo = new SYScmRawVendorResultVo();
 	
					reVo.setEbeln(et_resb.getString("EBELN"));  //구매문서번호
					reVo.setEbelp(et_resb.getString("EBELP"));	//구매품목번호
					reVo.setMatnr(et_resb.getString("MATNR")); //구매문서유형
					reVo.setMaktx(et_resb.getString("MAKTX")); //자재명
					reVo.setWerks(et_resb.getString("WERKS")); //플랜트
					reVo.setLgort(et_resb.getString("LGORT")); //저장위치
					reVo.setBdmng(et_resb.getString("BDMNG")); //소요량
					reVo.setMeins(et_resb.getString("MEINS")); //기본단위
					reVo.setZ1110_labst(et_resb.getString("Z1110_LABST")); //stock_의료
					reVo.setZ1210_labst(et_resb.getString("Z1210_LABST")); //stock_영상
					reVo.setZvendor_sllab(et_resb.getString("ZVENDOR_SLLAB")); //vendor_stock
					reVo.setRsnum(et_resb.getString("RSNUM")); //예약/종속 소요량의 번호
					reVo.setRspos(et_resb.getString("RSPOS")); //예약/종속 소요량에 대한 품목 번호
					reVo.setXloek(et_resb.getString("XLOEK")); //삭제여부
					reVoList.add(reVo);
				}
				resultObj.put("ET_EKKO", function.getTableParameterList().getTable("ET_EKKO"));
				resultObj.put("ET_EKPO", function.getTableParameterList().getTable("ET_EKPO"));
				resultObj.put("ET_RESB", function.getTableParameterList().getTable("ET_RESB"));
				resultObj.put("EV_STATUS", function.getExportParameterList().getString("EV_STATUS"));
				resultObj.put("EV_MESSAGE", function.getExportParameterList().getString("EV_MESSAGE"));
				
				System.out.println(resultObj);

				logVo.setBatch_result("S");
				logVo.setBatch_description("");
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");

			} catch (Exception ex) {
				logVo.setBatch_result("F");
				logVo.setBatch_description(ex.toString());
				resultData.put("status",HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				ex.printStackTrace();
			} finally {
				logVo.setBatch_end_dt(StringUtil.getDateTime());
				logStatusDAO.insertLogStatus(logVo);
			}
			resultData.put("rows", resultObj);

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}
	*/
	
	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject zmmfm_purch_ord_forProc(String funcName, JSONObject paramObj) {
		JSONObject resultData = new JSONObject();
		JSONObject resultObj = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		LogStatusVo logVo = new LogStatusVo();
		try {
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo);
			JCoFunction function = connect.getFunction(funcName);
			
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			final Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -1);
			Date yesterday = cal.getTime();
			Date today = new Date();
//			System.out.println(dateFormat.format(today)); // 2018-01-24
//		    System.out.println(dateFormat.format(yesterday)); // 2018-01-23
			/* == Setting RFC Parameter =================================== */
			/*function.getImportParameterList().getStructure("IS_EINDT").setValue("LOW", paramObj.get("datFrom"));
			function.getImportParameterList().getStructure("IS_EINDT").setValue("HIGH", paramObj.get("datTo"));*/
//			function.getImportParameterList().getStructure("IS_AEDAT").setValue("LOW", paramObj.get("datFrom"));
//			function.getImportParameterList().getStructure("IS_AEDAT").setValue("HIGH", paramObj.get("datTo"));
		    // 2018-01-24 iris edit
			function.getImportParameterList().getStructure("IS_AEDAT").setValue("LOW", dateFormat.format(yesterday));
			function.getImportParameterList().getStructure("IS_AEDAT").setValue("HIGH", dateFormat.format(today));
			/* == Return Value Mapping =================================== */
			
			try {
				logVo.setCreator("system");
				logVo.setUpdater("system");
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:ZMMFM_PURCH_ORD");
				logVo.setBatch_target_ds("RAW_PROC_TBL");
				logVo.setBatch_type("M");
				logVo.setBatch_action("U");
				
				connect.executeFunction(function);
				
				// item table
				JCoTable ekpo = (JCoTable)function.getTableParameterList().getTable("ET_EKPO");
				for (int i = 0; i < ekpo.getNumRows(); i++, ekpo.nextRow()) {
					SYScmRawProcVo iVo = new SYScmRawProcVo();
					iVo.setEbeln(ekpo.getString("EBELN")); //구매문서번호
					iVo.setEbelp(ekpo.getString("EBELP")); //구매문서품목번호
//					iVo.setLoekz(ekpo.getString("LOEKZ")); //구매문서의삭제지시자
					iVo.setLoekz_i(ekpo.getString("LOEKZ")); //구매문서의삭제지시자
					iVo.setTxz01(ekpo.getString("TXZ01")); //납품내역
					iVo.setMatnr(ekpo.getString("MATNR")); //자재번호
					iVo.setBukrs(ekpo.getString("BUKRS")); //회사코드
					iVo.setWerks(ekpo.getString("WERKS")); //플랜트
					iVo.setLgort(ekpo.getString("LGORT")); //저장위치
					iVo.setLgobe(ekpo.getString("LGOBE")); //저장위치명
					iVo.setMatkl(ekpo.getString("MATKL")); //자재그릅
					iVo.setWgbez(ekpo.getString("WGBEZ")); //자재그룹명
					iVo.setIdnlf(ekpo.getString("IDNLF")); //공급업체가사용하는 자재번호
					iVo.setEindt(ekpo.getString("EINDT")); //납품일자
					iVo.setMenge(ekpo.getString("MENGE")); //구매오더수량
					iVo.setZdeli_menge(ekpo.getString("MENGE")); //납품수량
					iVo.setZdue_menge(ekpo.getString("ZDUE_MENGE")); //잔량
					iVo.setMeins(ekpo.getString("MEINS")); //구매오더단위
					iVo.setNetpr(ekpo.getString("NETPR")); //구매문서의단가(전표통화)
					iVo.setPeinh(ekpo.getString("PEINH")); //가격단위
					iVo.setNetwr(ekpo.getString("NETWR")); //순오더금액(po통화)
					iVo.setElikz(ekpo.getString("ELIKZ")); //납품완료지시자
					iVo.setErekz(ekpo.getString("EREKZ")); //최종송장지시자
					iVo.setPstyp(ekpo.getString("PSTYP")); //구매문서의품목범주
					iVo.setKnttp(ekpo.getString("KNTTP")); //계정지정범주
					iVo.setSernp(ekpo.getString("SERNP")); //시리얼관리대상여부 관리 Y ELSE N
					iVo.setLabnr(ekpo.getString("LABNR")); //납품일정번호
//					System.out.println("$$$$$$$$$$$$$$$$$");
//					System.out.println(iVo);
					
					// LOEKZ_i update : po의 건당 삭제 처리
					// condition : ebeln, ebelp
					if( "L".equals(iVo.getLoekz_i()) ) {
						SYScmRawProcVo uVo = new SYScmRawProcVo();
						uVo.setEbeln(iVo.getEbeln());
						uVo.setEbelp(iVo.getEbelp());
						uVo.setLoekz_i(iVo.getLoekz_i());
						sYScmService.rawProcLoekzi_update(uVo);
						//iris
					}
					
					int cnt = 0; 
					if( !"".equals(iVo.getLabnr()) ) {
//						System.out.println("iVo.getLabnr() : " + iVo.getLabnr());
//						System.out.println("iVo.getEbelp() : " + iVo.getEbelp());
						SYScmRawProcVo tmpVo1 = new SYScmRawProcVo();
						tmpVo1.setEbeln(iVo.getEbeln());
						tmpVo1.setEbelp(iVo.getEbelp());
						tmpVo1.setLabnr(iVo.getLabnr());
//						tmpVo1.setEindt(iVo.getEindt());
						cnt = sYScmService.rawProcEbelp_update(tmpVo1);
						if( cnt > 0 ){
							sYScmService.rawProcSernrEbelp_update(iVo);	// update serial
						}
					}
					
					// old
					SYScmRawProcVo tmpVo = new SYScmRawProcVo();
					tmpVo.setEbeln(iVo.getEbeln());
					tmpVo.setEbelp(iVo.getEbelp());
					int chkString = sYScmService.checkPartialYN(tmpVo);
					if(chkString == 0 )
						cnt = sYScmService.rawProc_insert(iVo);
					/*
					// NEW
					SYScmRawProcVo tmpVo = new SYScmRawProcVo();
					tmpVo.setEbeln(iVo.getEbeln());
					tmpVo.setEbelp(iVo.getEbelp());
					tmpVo.setPartial_seq("0001");
					int ccc = (sYScmService.rawProc_selectByKey(tmpVo)).size();
					
					if( ccc==0 ) {
						cnt = sYScmService.rawProc_insert(iVo);
					}
					*/
					
					// EBELN, EBELP 대상, r3, v2 status, CONFIRM_DATE IS NOT NULL
					// PARITIAL_YN = 'N' / PARTIAL_SEQ = '0001'
					int tmpCnt = 0;
					if( !"".equals(iVo.getLabnr()) ) {
						tmpCnt = sYScmService.rawProc_update_partial(iVo);
					}
					if( tmpCnt>0 ) {
						tmpCnt = sYScmService.rawProcSernr_update_partial(iVo);
					}
				}
				
				// header table
				JCoTable ekko = (JCoTable)function.getTableParameterList().getTable("ET_EKKO");
				List<SYScmRawProcVo> rdVoList = new ArrayList<SYScmRawProcVo>();
				for (int i = 0; i < ekko.getNumRows(); i++, ekko.nextRow()) {
					SYScmRawProcVo rdVo = new SYScmRawProcVo();
					rdVo.setEbeln(ekko.getString("EBELN"));
					rdVo.setBstyp(ekko.getString("BSTYP"));	//구매문서범주
					rdVo.setBsart(ekko.getString("BSART")); //구매문서유형
					rdVo.setAedat(ekko.getString("AEDAT")); //레코드생성일
					rdVo.setErnam(ekko.getString("ERNAM")); //오브젝트생성자이름
					rdVo.setLifnr(ekko.getString("LIFNR")); //공급업체계정번호
					rdVo.setName1(ekko.getString("NAME1")); //공급업체명
					rdVo.setEkgrp(ekko.getString("EKGRP")); //구매구룹
					rdVo.setEknam(ekko.getString("EKNAM")); //구매그룹명
					rdVo.setZcsreq(ekko.getString("IHREZ")); //csr 번호
					rdVo.setWaers(ekko.getString("WAERS")); // 통화키
					rdVo.setWkurs(ekko.getString("WKURS")); //환율
					rdVo.setLoekz(ekko.getString("LOEKZ")); //구매문서의삭제지시자
					
					rdVoList.add(rdVo);
					sYScmService.rawProc_update(rdVo);
				}
				
				JCoTable et_resb  = (JCoTable)function.getTableParameterList().getTable("ET_RESB");
				List<SYScmRawProcSubVo> reVoList = new ArrayList<SYScmRawProcSubVo>();
				for (int i = 0; i < et_resb.getNumRows(); i++, et_resb.nextRow()) {
					SYScmRawProcSubVo reVo = new SYScmRawProcSubVo();
					 
					reVo.setEbeln(et_resb.getString("EBELN"));  //구매문서번호
					reVo.setEbelp(et_resb.getString("EBELP"));	//구매품목번호
					reVo.setMatnr(et_resb.getString("MATNR")); //구매문서유형
					reVo.setMaktx(et_resb.getString("MAKTX")); //자재명
					reVo.setWerks(et_resb.getString("WERKS")); //플랜트
					reVo.setLgort(et_resb.getString("LGORT")); //저장위치
					reVo.setBdmng(et_resb.getString("BDMNG")); //소요량
					reVo.setMeins(et_resb.getString("MEINS")); //기본단위
					reVo.setZ1110_labst(et_resb.getString("Z1110_LABST")); //stock_의료
					reVo.setZ1210_labst(et_resb.getString("Z1210_LABST")); //stock_영상
					reVo.setZvendor_sllab(et_resb.getString("ZVENDOR_SLLAB")); //vendor_stock
					reVo.setRsnum(et_resb.getString("RSNUM")); //예약/종속 소요량의 번호
					reVo.setRspos(et_resb.getString("RSPOS")); //예약/종속 소요량에 대한 품목 번호
					reVo.setXloek(et_resb.getString("XLOEK")); //삭제여부
					reVo.setSernp(et_resb.getString("SERNP")); //시리얼 여부
					reVoList.add(reVo);
					
					
					
					if("0001".equals(et_resb.getString("RSPOS"))){
						// 사급 subContract SAP와 Sync를 처리하기 위해서 Delete 함.
						sYScmService.rawProc_SubDelete(reVo);   // 저녁때 할까????사급관련 Subcontract 삭제 Sap 와 Sync 관련 추가 
					} 
					sYScmService.rawProc_SubInsert(reVo);   // 사급관련 Subcontract 추가
					 
				}
				
				resultObj.put("ET_EKKO", function.getTableParameterList().getTable("ET_EKKO"));
				resultObj.put("ET_EKPO", function.getTableParameterList().getTable("ET_EKPO"));
				resultObj.put("ET_RESB", function.getTableParameterList().getTable("ET_RESB"));
				resultObj.put("EV_STATUS", function.getExportParameterList().getString("EV_STATUS"));
				resultObj.put("EV_MESSAGE", function.getExportParameterList().getString("EV_MESSAGE"));
				
				System.out.println(resultObj);
				
				logVo.setBatch_result("S");
				logVo.setBatch_description("");
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");
				
			} catch (Exception ex) {
				logVo.setBatch_result("F");
				logVo.setBatch_description(ex.toString());
				resultData.put("status",HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				ex.printStackTrace();
			} finally {
				logVo.setBatch_end_dt(StringUtil.getDateTime());
				logStatusDAO.insertLogStatus(logVo);
			}
			resultData.put("rows", resultObj);
			
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}
	
	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject zmmfm_purch_ord_forProcBatch(String funcName, JSONObject paramObj) {
		JSONObject resultData = new JSONObject();
		JSONObject resultObj = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		LogStatusVo logVo = new LogStatusVo();
		try {
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo);
			JCoFunction function = connect.getFunction(funcName);
			
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			/* == Setting RFC Parameter =================================== */
			function.getImportParameterList().getStructure("IS_AEDAT").setValue("LOW", paramObj.get("datFrom"));
			function.getImportParameterList().getStructure("IS_AEDAT").setValue("HIGH", paramObj.get("datTo"));
			/* == Return Value Mapping =================================== */
			
			try {
				logVo.setCreator("system");
				logVo.setUpdater("system");
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:ZMMFM_PURCH_ORD");
				logVo.setBatch_target_ds("RAW_PROC_TBL");
				logVo.setBatch_type("M");
				logVo.setBatch_action("U");
				
				connect.executeFunction(function);
				
				JCoTable ekpo = (JCoTable)function.getTableParameterList().getTable("ET_EKPO");
				for (int i = 0; i < ekpo.getNumRows(); i++, ekpo.nextRow()) {
					SYScmRawProcVo iVo = new SYScmRawProcVo();
					iVo.setEbeln(ekpo.getString("EBELN")); //구매문서번호
					iVo.setEbelp(ekpo.getString("EBELP")); //구매문서품목번호
					iVo.setLoekz(ekpo.getString("LOEKZ")); //구매문서의삭제지시자
					iVo.setTxz01(ekpo.getString("TXZ01")); //납품내역
					iVo.setMatnr(ekpo.getString("MATNR")); //자재번호
					iVo.setBukrs(ekpo.getString("BUKRS")); //회사코드
					iVo.setWerks(ekpo.getString("WERKS")); //플랜트
					iVo.setLgort(ekpo.getString("LGORT")); //저장위치
					iVo.setLgobe(ekpo.getString("LGOBE")); //저장위치명
					iVo.setMatkl(ekpo.getString("MATKL")); //자재그릅
					iVo.setWgbez(ekpo.getString("WGBEZ")); //자재그룹명
					iVo.setIdnlf(ekpo.getString("IDNLF")); //공급업체가사용하는 자재번호
					iVo.setEindt(ekpo.getString("EINDT")); //납품일자
					iVo.setMenge(ekpo.getString("MENGE")); //구매오더수량
					iVo.setZdeli_menge(ekpo.getString("MENGE")); //납품수량
					iVo.setZdue_menge(ekpo.getString("ZDUE_MENGE")); //잔량
					iVo.setMeins(ekpo.getString("MEINS")); //구매오더단위
					iVo.setNetpr(ekpo.getString("NETPR")); //구매문서의단가(전표통화)
					iVo.setPeinh(ekpo.getString("PEINH")); //가격단위
					iVo.setNetwr(ekpo.getString("NETWR")); //순오더금액(po통화)
					iVo.setElikz(ekpo.getString("ELIKZ")); //납품완료지시자
					iVo.setErekz(ekpo.getString("EREKZ")); //최종송장지시자
					iVo.setPstyp(ekpo.getString("PSTYP")); //구매문서의품목범주
					iVo.setKnttp(ekpo.getString("KNTTP")); //계정지정범주
					iVo.setSernp(ekpo.getString("SERNP")); //시리얼관리대상여부 관리 Y ELSE N
					iVo.setLabnr(ekpo.getString("LABNR")); //납품일정번호
//					System.out.println("$$$$$$$$$$$$$$$$$");
//					System.out.println(iVo);
					
					int cnt = 0;
					if( !"".equals(iVo.getLabnr()) ) {
//						System.out.println("iVo.getLabnr() : " + iVo.getLabnr());
//						System.out.println("iVo.getEbelp() : " + iVo.getEbelp());
						SYScmRawProcVo tmpVo1 = new SYScmRawProcVo();
						tmpVo1.setEbeln(iVo.getEbeln());
						tmpVo1.setEbelp(iVo.getEbelp());
						tmpVo1.setLabnr(iVo.getLabnr());
						cnt = sYScmService.rawProcEbelp_update(tmpVo1);
						if( cnt > 0 ){
							sYScmService.rawProcSernrEbelp_update(iVo);	// update serial
						}
					}
					
					// old
					SYScmRawProcVo tmpVo = new SYScmRawProcVo();
					tmpVo.setEbeln(iVo.getEbeln());
					tmpVo.setEbelp(iVo.getEbelp());
					int chkString = sYScmService.checkPartialYN(tmpVo);
					if(chkString == 0 )
						cnt = sYScmService.rawProc_insert(iVo);
					/*
					// NEW
					SYScmRawProcVo tmpVo = new SYScmRawProcVo();
					tmpVo.setEbeln(iVo.getEbeln());
					tmpVo.setEbelp(iVo.getEbelp());
					tmpVo.setPartial_seq("0001");
					int ccc = (sYScmService.rawProc_selectByKey(tmpVo)).size();
					
					if( ccc==0 ) {
						cnt = sYScmService.rawProc_insert(iVo);
					}
					*/
					
					// EBELN, EBELP 대상, r3, v2 status, CONFIRM_DATE IS NOT NULL
					// PARITIAL_YN = 'N' / PARTIAL_SEQ = '0001'
					int tmpCnt = 0;
					if( !"".equals(iVo.getLabnr()) ) {
						tmpCnt = sYScmService.rawProc_update_partial(iVo);
					}
					if( tmpCnt>0 ) {
						tmpCnt = sYScmService.rawProcSernr_update_partial(iVo);
					}
				}
				
				JCoTable ekko = (JCoTable)function.getTableParameterList().getTable("ET_EKKO");
				List<SYScmRawProcVo> rdVoList = new ArrayList<SYScmRawProcVo>();
				for (int i = 0; i < ekko.getNumRows(); i++, ekko.nextRow()) {
					SYScmRawProcVo rdVo = new SYScmRawProcVo();
					rdVo.setEbeln(ekko.getString("EBELN"));
					rdVo.setBstyp(ekko.getString("BSTYP"));	//구매문서범주
					rdVo.setBsart(ekko.getString("BSART")); //구매문서유형
					rdVo.setAedat(ekko.getString("AEDAT")); //레코드생성일
					rdVo.setErnam(ekko.getString("ERNAM")); //오브젝트생성자이름
					rdVo.setLifnr(ekko.getString("LIFNR")); //공급업체계정번호
					rdVo.setName1(ekko.getString("NAME1")); //공급업체명
					rdVo.setEkgrp(ekko.getString("EKGRP")); //구매구룹
					rdVo.setEknam(ekko.getString("EKNAM")); //구매그룹명
					rdVo.setZcsreq(ekko.getString("IHREZ")); //csr 번호
					rdVo.setWaers(ekko.getString("WAERS")); // 통화키
					rdVo.setWkurs(ekko.getString("WKURS")); //환율
					
					rdVoList.add(rdVo);
//					System.out.println("%%%%%%%%%%%%%%%%");
//					System.out.println(rdVo);
					sYScmService.rawProc_update(rdVo);
				}
				
				JCoTable et_resb  = (JCoTable)function.getTableParameterList().getTable("ET_RESB");
				List<SYScmRawProcSubVo> reVoList = new ArrayList<SYScmRawProcSubVo>();
				for (int i = 0; i < et_resb.getNumRows(); i++, et_resb.nextRow()) {
					SYScmRawProcSubVo reVo = new SYScmRawProcSubVo();
					
					
					
					
					reVo.setEbeln(et_resb.getString("EBELN"));  //구매문서번호
					reVo.setEbelp(et_resb.getString("EBELP"));	//구매품목번호
					reVo.setMatnr(et_resb.getString("MATNR")); //구매문서유형
					reVo.setMaktx(et_resb.getString("MAKTX")); //자재명
					reVo.setWerks(et_resb.getString("WERKS")); //플랜트
					reVo.setLgort(et_resb.getString("LGORT")); //저장위치
					reVo.setBdmng(et_resb.getString("BDMNG")); //소요량
					reVo.setMeins(et_resb.getString("MEINS")); //기본단위
					reVo.setZ1110_labst(et_resb.getString("Z1110_LABST")); //stock_의료
					reVo.setZ1210_labst(et_resb.getString("Z1210_LABST")); //stock_영상
					reVo.setZvendor_sllab(et_resb.getString("ZVENDOR_SLLAB")); //vendor_stock
					reVo.setRsnum(et_resb.getString("RSNUM")); //예약/종속 소요량의 번호
					reVo.setRspos(et_resb.getString("RSPOS")); //예약/종속 소요량에 대한 품목 번호
					reVo.setXloek(et_resb.getString("XLOEK")); //삭제여부
					reVo.setSernp(et_resb.getString("SERNP")); //시리얼 여부
					reVoList.add(reVo);
					
					if("0001".equals(et_resb.getString("RSPOS"))){
						// 사급 subContract SAP와 Sync를 처리하기 위해서 Delete 함.
						sYScmService.rawProc_SubDelete(reVo);   // 저녁때 할까????사급관련 Subcontract 삭제 Sap 와 Sync 관련 추가 
					} 
					sYScmService.rawProc_SubInsert(reVo);   // 사급관련 Subcontract 추가
				}
				
				resultObj.put("ET_EKKO", function.getTableParameterList().getTable("ET_EKKO"));
				resultObj.put("ET_EKPO", function.getTableParameterList().getTable("ET_EKPO"));
				resultObj.put("ET_RESB", function.getTableParameterList().getTable("ET_RESB"));
				resultObj.put("EV_STATUS", function.getExportParameterList().getString("EV_STATUS"));
				resultObj.put("EV_MESSAGE", function.getExportParameterList().getString("EV_MESSAGE"));
				
				System.out.println(resultObj);
				
				logVo.setBatch_result("S");
				logVo.setBatch_description("");
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");
				
			} catch (Exception ex) {
				logVo.setBatch_result("F");
				logVo.setBatch_description(ex.toString());
				resultData.put("status",HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				ex.printStackTrace();
			} finally {
				logVo.setBatch_end_dt(StringUtil.getDateTime());
				logStatusDAO.insertLogStatus(logVo);
			}
			resultData.put("rows", resultObj);
			
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}
	

	// Bom data 생성 요청 rfc
	@SuppressWarnings("unchecked")
	public JSONObject zmmfm_vw_mat(String funcName, String params, String sessId) {

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);

		List<SYMaterialSendMasterVo> mVoList = new ArrayList<SYMaterialSendMasterVo>();
		LogStatusVo logVo = new LogStatusVo();

		JCoFunction function = null;

		try {
			function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}

			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:ZMMFM_VW_MAT");
			logVo.setBatch_target_ds("-");
			logVo.setBatch_type("M");
			logVo.setBatch_action("U");

			// get table from RFC
			JCoTable impTable = function.getTableParameterList().getTable("IT_MATNR");

			// string to json list
			listDataJArray = (JSONArray) jsonParser.parse(params);

			JSONObject jOb = (JSONObject) listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();
			impTable.appendRows(listDataJArray.size());
			for (int idx = 0; idx < listDataJArray.size(); idx++) {
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject) listDataJArray.get(idx);
				SYMaterialSendMasterVo mVo = new SYMaterialSendMasterVo();

				// set Table : import data
				for (Object key : keyArr) {
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();

					if ("zrequest_no".equals(nKey)) {
						impTable.setValue("ZREQUEST_NO", nValue);
						mVo.setZrequest_no(nValue);
					} else if ("zseq".equals(nKey)) {
						impTable.setValue("ZSEQ", nValue);
						mVo.setZseq(nValue);
					} else if ("matnr".equals(nKey)) {
						impTable.setValue("MATNR", nValue);
						mVo.setMatnr(nValue);
					} else if ("maktx".equals(nKey)) {
						impTable.setValue("MAKTX", nValue);
						mVo.setMaktx(nValue);
					} else if ("wrkst".equals(nKey)) {
						impTable.setValue("WRKST", nValue);
						mVo.setWrkst(nValue);
					} else if ("meins".equals(nKey)) {
						impTable.setValue("MEINS", nValue);
						mVo.setMeins(nValue);
					}
				}
				impTable.nextRow();
				mVoList.add(mVo);
			}
			// == Setting RFC Parameter ===================================
			function.getTableParameterList().setValue("IT_MATNR", impTable);
			// == Return Value Mapping ===================================
			connect.executeFunction(function);
			logVo.setBatch_result("S");
			logVo.setBatch_description("");

		} catch (Exception e) {
			logVo.setBatch_result("F");
			logVo.setBatch_description(e.toString());
			e.printStackTrace();
		} finally {
			resultData.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
			resultData.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));
			logVo.setBatch_end_dt(StringUtil.getDateTime());
			logStatusDAO.insertLogStatus(logVo);
		}

		return resultData;
	}
	/*
	// zmmfm_ven_master
	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject zmmfm_ven_master(String funcName, String iv_fdate,
			String iv_tdate, String iv_if) {
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		List<SYVendorVo> pVoList = new ArrayList<SYVendorVo>();
		List<SYVendorVo> listSYVendorVo = new ArrayList<SYVendorVo>();
		int result1 = 0;

		try {
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}

			LogStatusVo logVo = new LogStatusVo();

			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:ZMMFM_VEN_MASTER");
			logVo.setBatch_target_ds("vendor_tbl");
			logVo.setBatch_type("M");
			logVo.setBatch_action("U");

			// == Setting RFC Parameter ===================================
			function.getImportParameterList().setValue("IV_FDATE", iv_fdate);
			function.getImportParameterList().setValue("IV_TDATE", iv_tdate);
			// == Return Value Mapping ===================================
			connect.executeFunction(function);
			JCoTable t_tab = function.getTableParameterList().getTable("ET_LFA1");

			System.out.println("t_tab.getNumRows()" + t_tab.getNumRows());

			for (int i = 0; i < t_tab.getNumRows(); i++) {
				t_tab.setRow(i);
				SYVendorVo pVo = new SYVendorVo();
				pVo.setLifnr(t_tab.getString("LIFNR"));
				pVo.setKtokk(t_tab.getString("KTOKK"));
				pVo.setTxt30(t_tab.getString("TXT30"));
				pVo.setLoevm(t_tab.getString("LOEVM"));
				pVo.setName1(t_tab.getString("NAME1"));
				pVo.setName2(t_tab.getString("NAME2"));
				pVo.setMcod1(t_tab.getString("MCOD1"));
				pVo.setPstlz(t_tab.getString("PSTLZ"));
				pVo.setOrt01(t_tab.getString("ORT01"));
				pVo.setRegio(t_tab.getString("REGIO"));
				pVo.setLand1(t_tab.getString("LAND1"));
				pVo.setTelf1(t_tab.getString("TELF1"));
				pVo.setTelf2(t_tab.getString("TELF2"));
				pVo.setTelfx(t_tab.getString("TELFX"));
				pVo.setSmtp_addr(t_tab.getString("SMTP_ADDR"));
				pVo.setStenr(t_tab.getString("STENR"));
				pVo.setJ_1kfrepre(t_tab.getString("J_1KFREPRE"));
				pVo.setJ_1kftbus(t_tab.getString("J_1KFTBUS"));
				pVo.setJ_1kftind(t_tab.getString("J_1KFTIND"));
				pVo.setAltkn(t_tab.getString("ALTKN"));
				pVo.setErdat(t_tab.getString("ERDAT"));
				pVo.setAedat(t_tab.getString("AEDAT"));

				pVoList.add(pVo);
				result1 = hubDAO.insertSapVendor(pVo);

			}

			resultData.put("return_status", result1);
			resultData.put("return_count", t_tab.getNumRows());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultData;
	}*/
	/*
	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject zmmfm_mat_master(String fDate, String tDate,
			String funcName) {
		JSONObject resultData = new JSONObject();
		JSONParser jsonParser = new JSONParser();
		List<SYProdVo> listCode = null;
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		try {

			LogStatusVo logVo = new LogStatusVo();
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}

			 == Setting RFC Parameter =================================== 
			function.getImportParameterList().setValue("IV_FDATE", fDate);
			function.getImportParameterList().setValue("IV_TDATE", tDate);
			 == Return Value Mapping =================================== 
			try {
				logVo.setCreator("system");
				logVo.setUpdater("system");
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:ZMMFM_MAT_MASTER");
				logVo.setBatch_target_ds("material_recv");
				logVo.setBatch_type("M");
				logVo.setBatch_action("U");

				connect.executeFunction(function);

				JSONObject resultObj = new JSONObject();

				JCoTable tb_et_mara = function.getTableParameterList().getTable("ET_MARA");
				JCoTable tb_et_marc_mbew = function.getTableParameterList().getTable("ET_MARC_MBEW");

				SYZmmfmMatMasterVo sVo = new SYZmmfmMatMasterVo();
				sVo.setFdate(fDate);
				sVo.setTdate(tDate);

				*//************************************************************************************//*
				for (int i = 0; i < tb_et_mara.getNumRows(); i++) {
					tb_et_mara.setRow(i);

					sVo = new SYZmmfmMatMasterVo();

					sVo.setMatnr(tb_et_mara.getString("MATNR"));
					sVo.setMtart(tb_et_mara.getString("MTART"));
					sVo.setMeins(tb_et_mara.getString("MEINS"));
					sVo.setMaktx(tb_et_mara.getString("MAKTX"));
					sVo.setWrkst(tb_et_mara.getString("WRKST"));
					sVo.setLvorm(tb_et_mara.getString("LVORM"));
					sVo.setMstae(tb_et_mara.getString("MSTAE"));
					sVo.setMtstb(tb_et_mara.getString("MTSTB"));
					sVo.setBrgew(tb_et_mara.getString("BRGEW"));
					sVo.setNtgew(tb_et_mara.getString("NTGEW"));
					sVo.setGewei(tb_et_mara.getString("GEWEI"));
					sVo.setSpart(tb_et_mara.getString("SPART"));
					sVo.setVtext(tb_et_mara.getString("VTEXT"));
					sVo.setMatkl(tb_et_mara.getString("MATKL"));
					sVo.setWgbez(tb_et_mara.getString("WGBEZ"));
					sVo.setEkwsl(tb_et_mara.getString("EKWSL"));
					sVo.setErsda(tb_et_mara.getString("ERSDA"));
					sVo.setErnam(tb_et_mara.getString("ERNAM"));
					sVo.setLaeda(tb_et_mara.getString("LAEDA"));
					sVo.setAenam(tb_et_mara.getString("AENAM"));
					
					
					if (tb_et_mara.getString("KZUMW").length() > 0) {
							sVo.setKzumw("Y");		
				    }else{
				        	sVo.setKzumw(tb_et_mara.getString("KZUMW"));	
				    }

				    if(tb_et_mara.getString("ILOOS").length() > 0) {
				    	    sVo.setIloos("Y");
				    }else{
				        	sVo.setIloos(tb_et_mara.getString("ILOOS"));	
				    }
				   
				    if(tb_et_mara.getString("IHIVI").length() > 0) {
				    	   sVo.setIhivi("Y");
				    }else{
				    	sVo.setIhivi(tb_et_mara.getString("IHIVI"));
				    }

					sYScmService.material_recv_master_insert(sVo);
				}

				*//*************************************************************************************//*

				*//************************************************************************************//*
				for (int i = 0; i < tb_et_marc_mbew.getNumRows(); i++) {
					tb_et_marc_mbew.setRow(i);

					sVo = new SYZmmfmMatMasterVo();

					sVo.setWerks(tb_et_marc_mbew.getString("WERKS"));
					sVo.setMatnr(tb_et_marc_mbew.getString("MATNR"));
					sVo.setMmsta(tb_et_marc_mbew.getString("MMSTA"));
					sVo.setMtstb(tb_et_marc_mbew.getString("MTSTB"));
					sVo.setEkgrp(tb_et_marc_mbew.getString("EKGRP"));
					sVo.setEknam(tb_et_marc_mbew.getString("EKNAM"));
					sVo.setKautb(tb_et_marc_mbew.getString("KAUTB"));
					sVo.setDisgr(tb_et_marc_mbew.getString("DISGR"));
					sVo.setMaabc(tb_et_marc_mbew.getString("MAABC"));
					sVo.setDismm(tb_et_marc_mbew.getString("DISMM"));
					sVo.setDisls(tb_et_marc_mbew.getString("DISLS"));
					sVo.setBstfe(tb_et_marc_mbew.getString("BSTFE"));
					sVo.setBstmi(tb_et_marc_mbew.getString("BSTMI"));
					sVo.setBstma(tb_et_marc_mbew.getString("BSTMA"));
					sVo.setBstrf(tb_et_marc_mbew.getString("BSTRF"));
					sVo.setEisbe(tb_et_marc_mbew.getString("EISBE"));
					sVo.setShflg(tb_et_marc_mbew.getString("SHFLG"));
					sVo.setShzet(tb_et_marc_mbew.getString("SHZET"));
					sVo.setDispo(tb_et_marc_mbew.getString("DISPO"));
					sVo.setDsnam(tb_et_marc_mbew.getString("DSNAM"));
					sVo.setBeskz(tb_et_marc_mbew.getString("BESKZ"));
					sVo.setSobsl(tb_et_marc_mbew.getString("SOBSL"));
					sVo.setLgpro(tb_et_marc_mbew.getString("LGPRO"));
					sVo.setLgobe_lgpro(tb_et_marc_mbew.getString("LGOBE_LGPRO"));
					sVo.setLgfsb(tb_et_marc_mbew.getString("LGFSB"));
					sVo.setLgobe_lgfsb(tb_et_marc_mbew.getString("LGOBE_LGFSB"));
					sVo.setDzeit(tb_et_marc_mbew.getString("DZEIT"));
					sVo.setPlifz(tb_et_marc_mbew.getString("PLIFZ"));
					sVo.setWebaz(tb_et_marc_mbew.getString("WEBAZ"));
					sVo.setFhori(tb_et_marc_mbew.getString("FHORI"));
					sVo.setRgekz(tb_et_marc_mbew.getString("RGEKZ"));
					sVo.setSchgt(tb_et_marc_mbew.getString("SCHGT"));
					sVo.setSbdkz(tb_et_marc_mbew.getString("SBDKZ"));
					sVo.setMtvfp(tb_et_marc_mbew.getString("MTVFP"));
					sVo.setStrgr(tb_et_marc_mbew.getString("STRGR"));
					sVo.setVrmod(tb_et_marc_mbew.getString("VRMOD"));
					sVo.setVint1(tb_et_marc_mbew.getString("VINT1"));
					sVo.setVint2(tb_et_marc_mbew.getString("VINT2"));
					sVo.setFevor(tb_et_marc_mbew.getString("FEVOR"));
					sVo.setSfcpf(tb_et_marc_mbew.getString("SFCPF"));
					sVo.setSernp(tb_et_marc_mbew.getString("SERNP"));
					sVo.setBklas(tb_et_marc_mbew.getString("BKLAS"));
					sVo.setVerpr(tb_et_marc_mbew.getString("VERPR"));
					sVo.setStprs(tb_et_marc_mbew.getString("STPRS"));
					sVo.setVprsv(tb_et_marc_mbew.getString("VPRSV"));
					sVo.setLosgr(tb_et_marc_mbew.getString("LOSGR"));
					sVo.setHkmat(tb_et_marc_mbew.getString("HKMAT"));
					sVo.setHrkft(tb_et_marc_mbew.getString("HRKFT"));
					sVo.setPrctr(tb_et_marc_mbew.getString("PRCTR"));
					sVo.setZplp1(tb_et_marc_mbew.getString("ZPLP1"));
					sVo.setZpld1(tb_et_marc_mbew.getString("ZPLD1"));
					sVo.setAtwtb_l(tb_et_marc_mbew.getString("ATWTB_L"));
					sVo.setAtwtb_m(tb_et_marc_mbew.getString("ATWTB_M"));
					sVo.setAtwtb_s(tb_et_marc_mbew.getString("ATWTB_S"));

					sYScmService.material_recv_detail_insert(sVo);

					if (tb_et_marc_mbew.getString("SERNP").equals("V001")) {
						
						if (tb_et_marc_mbew.getString("WERKS").equals("1110")) {
							sVo.setMess_medical_yn("Y");
							sVo.setSap_manage_yn("Y");
						} else if (tb_et_marc_mbew.getString("WERKS").equals("1210")) {
							sVo.setMess_optical_yn("Y");
							sVo.setSap_manage_yn("Y");
						}

						hubDAO.updateMasterMaterial01(sVo);
					} else {
				
						if (tb_et_marc_mbew.getString("WERKS").equals("1110")) {
							sVo.setMess_medical_yn("N");
							sVo.setSap_manage_yn("N");
						} else if (tb_et_marc_mbew.getString("WERKS").equals("1210")) {
							sVo.setMess_optical_yn("N");
							sVo.setSap_manage_yn("N");
						}
						hubDAO.updateMasterMaterial02(sVo);
						
						
						String chkmediString = hubDAO.checkmediSerYN(sVo.getMatnr());
						String chkoptiString = hubDAO.checkoptiSerYN(sVo.getMatnr());
	 
						if (tb_et_marc_mbew.getString("WERKS").equals("1110") && chkmediString.equals("Y")) {
						  
							hubDAO.updateMasterMaterial03(sVo);
							
						} else if (tb_et_marc_mbew.getString("WERKS").equals("1210") && chkoptiString.equals("Y")) {
					 
							hubDAO.updateMasterMaterial03(sVo);
						}
 		 
					}
				}

				*//*************************************************************************************//*
				resultObj.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
				resultObj.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));

				resultData.put("rows", resultObj);
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");

			} catch (Exception ex) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				logVo.setBatch_result("F");
				logVo.setBatch_description(ex.toString());
				ex.printStackTrace();
			} finally {
				logVo.setBatch_end_dt(StringUtil.getDateTime());
				logStatusDAO.insertLogStatus(logVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}*/
	
	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject zmmfm_goodsmvt_po(String funcName, List<SYScmRawVendorResultVo> vList, JSONArray sernrArr, String ref_doc_no) {
		JSONObject resultData = new JSONObject();
		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		try {
			LogStatusVo logVo = new LogStatusVo();
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			// get table from RFC
			JCoTable itemTbl = function.getTableParameterList().getTable("IT_ITEM");
			itemTbl.appendRows(vList.size());
			JCoTable sernrTbl = function.getTableParameterList().getTable("IT_SERIAL");
			
			NumberFormat nf = new DecimalFormat("0000");
			int mainCnt = 0;
			for (SYScmRawVendorResultVo vo : vList) {
				System.out.println(vo.toString());
				mainCnt++;
				itemTbl.setValue("LABNR", vo.getLabnr());
				itemTbl.setValue("MATERIAL", vo.getMatnr());
				itemTbl.setValue("PLANT", vo.getWerks());
				 
//				vo.getMesr(); // 입고검사 101
				
				if(vo.getMesr().equals("Y")){ 	
					//입고검사일겨우 저장위치를 검사대기창고(1050) 으로 변경해서 rfc 전송
					itemTbl.setValue("STGE_LOC", "1050");							
				}else{
					
					if ( vo.getMove_type().equals("122") )  {
					 	itemTbl.setValue("STGE_LOC","1050");
					}else{
						
						itemTbl.setValue("STGE_LOC", vo.getLgort());	
					}
				}	
				
				System.out.println("################################");
				System.out.println("vo.getMesr()"+vo.getMesr()+ "     stge_loc   "+itemTbl.getValue("STGE_LOC"));
				System.out.println("################################");
 	
				itemTbl.setValue("MOVE_TYPE", vo.getMove_type()); // 입하 : "103" 입고 : 105  입고후반품 : "122" 입하검사 불합격 "124"
				itemTbl.setValue("ENTRY_QNT", vo.getZdeli_menge());
				itemTbl.setValue("ENTRY_UOM", vo.getMeins());
				itemTbl.setValue("PO_NUMBER", vo.getEbeln());
				itemTbl.setValue("PO_ITEM", vo.getEbelp());
				itemTbl.setValue("ITEM_TEXT", vo.getTxz01());
				itemTbl.setValue("MVT_IND", "B");
				
				if (vo.getMove_type().equals("105") || vo.getMove_type().equals("124") || vo.getMove_type().equals("122") )  {
//					REF_DOC_YR		참조문서의 회계연도	NUMC	4	* 105 일때 103 mm doc 을 입력하세요						
//					REF_DOC		참조 문서의 문서 번호	CHAR	10	* 105 일때 103 mm year 을 입력하세요						
				itemTbl.setValue("REF_DOC",vo.getMblnr());
				itemTbl.setValue("REF_DOC_YR",vo.getMjahr());	//Mjahr
					
				}
				if ( "V001".equals(vo.getSernp()) ){
					sernrTbl.appendRows(sernrArr.size());
					for (int idx = 0; idx < sernrArr.size(); idx++) {
						JSONObject jObj = new JSONObject();
						jObj = (JSONObject) sernrArr.get(idx);
						if ((vo.getEbeln()).equals(jObj.get("ebeln")) && (vo.getEbelp()).equals(jObj.get("ebelp"))) {
							sernrTbl.setValue("LABNR", vo.getLabnr());
							sernrTbl.setValue("ZLINE", nf.format(mainCnt));
							sernrTbl.setValue("SERIALNO", jObj.get("equnr").toString());
							sernrTbl.nextRow();
						}
					}
				}
				itemTbl.nextRow();
			}
			System.out.println(itemTbl.toString());
			System.out.println(sernrTbl.toString());

			String odate = (vList.get(0).getOrder_delivery_date()).replaceAll("-", "").trim();
			// System.out.println(odate);
			/* == Setting RFC Parameter =================================== */
//			function.getImportParameterList().setValue("IV_REF_DOC_NO", vList.get(0).getRef_doc_no());
			function.getImportParameterList().setValue("IV_REF_DOC_NO", ref_doc_no);
			function.getImportParameterList().setValue("IV_PSTNG_DATE", odate);
			function.getImportParameterList().setValue("IV_DOC_DATE", odate);
			function.getTableParameterList().setValue("IT_ITEM", itemTbl);
			function.getTableParameterList().setValue("IT_SERIAL", sernrTbl);
			/* == Return Value Mapping =================================== */
			try {
				logVo.setCreator("system");
				logVo.setUpdater("system");
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:ZMMFM_GOODSMVT_PO");
				logVo.setBatch_target_ds("rawVendorResult");
				logVo.setBatch_type("M");
				logVo.setBatch_action("U");

				connect.executeFunction(function);

				JSONObject resultObj = new JSONObject();
				resultObj.put("EV_STATUS", function.getExportParameterList().getString("EV_STATUS"));
				resultObj.put("EV_MESSAGE", function.getExportParameterList().getString("EV_MESSAGE"));
				resultObj.put("EV_MBLNR", function.getExportParameterList().getString("EV_MBLNR"));
				resultObj.put("EV_MJAHR", function.getExportParameterList().getString("EV_MJAHR"));
//				if( "S".equals(result) ){
//					for (SYScmRawVendorResultVo vo : vList) {
//						vo.setRef_doc_no(ref_doc_no);
//						sYScmService.rawVendorResultSta_update(vo);
//					}
//				}

				logVo.setBatch_result("S");
				logVo.setBatch_description("");
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");
				resultData.put("rows", resultObj);
			} catch (Exception ex) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				logVo.setBatch_result("F");
				logVo.setBatch_description(ex.toString());
				ex.printStackTrace();
			} finally {
				logVo.setBatch_end_dt(StringUtil.getDateTime());
				// logStatusDAO.insertLogStatus(logVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}
	
	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject zmmfm_goodsmvt_po_proc(String funcName, List<SYScmRawProcVo> vList, JSONArray sernrArr, String ref_doc_no, 
						List<SYScmRawProcSernrVo> subSernr) {
		JSONObject resultData = new JSONObject();
		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		try {
			LogStatusVo logVo = new LogStatusVo();
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			// get table from RFC
			JCoTable itemTbl = function.getTableParameterList().getTable("IT_ITEM");
//			itemTbl.appendRows(vList.size());
			JCoTable sernrTbl = function.getTableParameterList().getTable("IT_SERIAL");
			
			// 사급자재인가?
			// 사급자재 중 serial 대상자가 한개라도 있으면, 구조가 달라진다.
			List<SYScmRawProcVo> sList = new ArrayList<SYScmRawProcVo>();
			String ebeln = "";
			if( subSernr!=null && subSernr.size()>0 ) {
				System.out.println("case1");
				System.out.println(subSernr);
				ebeln = subSernr.get(0).getEbeln();
			} else {
				System.out.println("case2");
				System.out.println(vList.toString());
				ebeln = vList.get(0).getEbeln();
			}
			sList = sYScmService.scmProcMat_select(ebeln);
			
//			System.out.println(" vo "+vList.toString() );
			//ebeln, ebelp, matnr, gubun, sernp, rownum(seq), rnum(seq by mom&child)
			int seq = 0;
			for (SYScmRawProcVo vo : vList) {							
				itemTbl.appendRows(1);
				seq++;
				String seqNumber = String.format("%06d", seq);
				for( SYScmRawProcVo sVo : sList ){
					if( (sVo.getEbeln()).equals(vo.getEbeln()) && (sVo.getEbelp()).equals(vo.getEbelp()) && (sVo.getMatnr()).equals(vo.getMatnr()) ){
						// itemTbl @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
						
						itemTbl.setValue("LABNR", vo.getLabnr());
						itemTbl.setValue("MATERIAL", vo.getMatnr());
						itemTbl.setValue("PLANT", vo.getWerks());
						
						if(vo.getMesr()!=null && vo.getMesr().equals("Y")){ 	
							//입고검사일겨우 저장위치를 검사대기창고(1050) 으로 변경해서 rfc 전송
							itemTbl.setValue("STGE_LOC", "1050");							
						}else{
							if ( vo.getMove_type().equals("122") )  {
								itemTbl.setValue("STGE_LOC","1050");
							}else{
								
								itemTbl.setValue("STGE_LOC", vo.getLgort());	
							}
						}	
						System.out.println("################################");
						System.out.println("vo.getMesr() : "+vo.getMesr()+ " / stge_loc : "+itemTbl.getValue("STGE_LOC"));
						System.out.println("################################");
						// MOVE_TYPE : 입하("103"), 입고(105), 입고후반품(122), 입하검사 불합격 (124), 사급자재구분(543) 
						itemTbl.setValue("MOVE_TYPE", vo.getMove_type()); 
						itemTbl.setValue("ENTRY_QNT", vo.getZdeli_menge());
						itemTbl.setValue("ENTRY_UOM", vo.getMeins());
						itemTbl.setValue("PO_NUMBER", vo.getEbeln());
						itemTbl.setValue("PO_ITEM", vo.getEbelp());
						itemTbl.setValue("ITEM_TEXT", vo.getTxz01());

						if( "543".equals(vo.getMove_type()) ) {
							itemTbl.setValue("MVT_IND", "O");
						} else { 
							itemTbl.setValue("MVT_IND", "B");
						}
						if (vo.getMove_type().equals("105") || vo.getMove_type().equals("124") || vo.getMove_type().equals("122") )  {
							//					REF_DOC_YR		참조문서의 회계연도	NUMC	4	* 105 일때 103 mm doc 을 입력하세요						
							//					REF_DOC		참조 문서의 문서 번호	CHAR	10	* 105 일때 103 mm year 을 입력하세요						
							itemTbl.setValue("REF_DOC",vo.getMblnr());
							itemTbl.setValue("REF_DOC_YR",vo.getMjahr());	//Mjahr
						}
						
						// sequence number sVo.getRownum()
						
						if( "543".equals(vo.getMove_type()) && "S".equals(sVo.getGubun()) ) {
//							itemTbl.setValue("LINE_ID", sVo.getRownum());
//							System.out.println("===>" + sVo.getRownum());
							itemTbl.setValue("LINE_ID", seqNumber);
							itemTbl.setValue("PARENT_ID", sVo.getRnum());
						} else if ( "M".equals(sVo.getGubun()) ) {
							if( "105".equals(vo.getMove_type()) ) {
								itemTbl.setValue("LINE_ID", seqNumber);
							} else {
								itemTbl.setValue("LINE_ID", sVo.getRownum());
							}
							itemTbl.setValue("PARENT_ID", sVo.getRnum());
						}
						
						itemTbl.nextRow();
						// itemTbl @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
						// sernrTbl @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
						System.out.println("Sernp = " + vo.getSernp());
						System.out.println("Move Type = " + vo.getMove_type());
						if ( "V001".equals(vo.getSernp()) ){
							if ( "543".equals(vo.getMove_type()) ) { // subSernr type :  List<SYScmRawProcSernrVo>
//								System.out.println("543 : " + subSernr);
								for(SYScmRawProcSernrVo subVo : subSernr) {
									if (subVo.getEqunr()!=null && (vo.getEbeln()).equals(subVo.getEbeln()) && (vo.getEbelp()).equals(subVo.getEbelp()) ) {
										sernrTbl.appendRows(1);
										sernrTbl.setValue("LABNR", "");
										sernrTbl.setValue("ZLINE", seqNumber);
										sernrTbl.setValue("SERIALNO", subVo.getEqunr());
										sernrTbl.nextRow();
									}
								}
							} else {  // sernrArr type : JSONArray
								for (int idx = 0; idx < sernrArr.size(); idx++) {
									JSONObject jObj = new JSONObject();
									jObj = (JSONObject) sernrArr.get(idx);
									if ((vo.getEbeln()).equals(jObj.get("ebeln")) && (vo.getEbelp()).equals(jObj.get("ebelp"))) {
										sernrTbl.appendRows(1);
										sernrTbl.setValue("LABNR", vo.getLabnr());
										sernrTbl.setValue("ZLINE", seqNumber);
										sernrTbl.setValue("SERIALNO", jObj.get("equnr").toString());
										sernrTbl.nextRow();
									}
								}
							}
						}
						// sernrTbl @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
					}
				}
			}
			
			System.out.println(itemTbl.toString());
			System.out.println(sernrTbl.toString());
			
			String odate = (vList.get(0).getOrder_delivery_date()).replaceAll("-", "").trim();
			// System.out.println(odate);
			/* == Setting RFC Parameter =================================== */
//			function.getImportParameterList().setValue("IV_REF_DOC_NO", vList.get(0).getRef_doc_no());
			function.getImportParameterList().setValue("IV_REF_DOC_NO", ref_doc_no);
			function.getImportParameterList().setValue("IV_PSTNG_DATE", odate);
			function.getImportParameterList().setValue("IV_DOC_DATE", odate);
			function.getTableParameterList().setValue("IT_ITEM", itemTbl);
			function.getTableParameterList().setValue("IT_SERIAL", sernrTbl);
			System.out.println("IV_REF_DOC_NO" + ref_doc_no);
			System.out.println("IV_PSTNG_DATE" + odate);
			System.out.println("IV_DOC_DATE" + odate);
//			System.out.println("IT_ITEM" + itemTbl);
//			System.out.println("IT_SERIAL" + sernrTbl);
			/* == Return Value Mapping =================================== */
			try {
				logVo.setCreator("system");
				logVo.setUpdater("system");
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:ZMMFM_GOODSMVT_PO");
				logVo.setBatch_target_ds("rawProcTbl");
				logVo.setBatch_type("M");
				logVo.setBatch_action("U");
				
				connect.executeFunction(function);
				
				JSONObject resultObj = new JSONObject();
				resultObj.put("EV_STATUS", function.getExportParameterList().getString("EV_STATUS"));
				resultObj.put("EV_MESSAGE", function.getExportParameterList().getString("EV_MESSAGE"));
				resultObj.put("EV_MBLNR", function.getExportParameterList().getString("EV_MBLNR"));
				resultObj.put("EV_MJAHR", function.getExportParameterList().getString("EV_MJAHR"));
//				if( "S".equals(result) ){
//					for (SYScmRawVendorResultVo vo : vList) {
//						vo.setRef_doc_no(ref_doc_no);
//						sYScmService.rawVendorResultSta_update(vo);
//					}
//				}
				
				logVo.setBatch_result("S");
				logVo.setBatch_description("");
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");
				resultData.put("rows", resultObj);
			} catch (Exception ex) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				logVo.setBatch_result("F");
				logVo.setBatch_description(ex.toString());
				ex.printStackTrace();
			} finally {
				logVo.setBatch_end_dt(StringUtil.getDateTime());
				// logStatusDAO.insertLogStatus(logVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}
	
	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject zmmfm_po_schedule(String funcName, List<SYScmRawVendorResultVo> sapList) {
		JSONObject resultData = new JSONObject();
		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		try {
			LogStatusVo logVo = new LogStatusVo();
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			// get table from RFC
			JCoTable itemTbl = function.getTableParameterList().getTable("IT_EKET");
			// JSONObject selObj = (JSONObject)selArr.get(0);
			itemTbl.appendRows(sapList.size());
			for (SYScmRawVendorResultVo vo : sapList) {
				itemTbl.setValue("LABNR", vo.getLabnr());
				itemTbl.setValue("EBELN", vo.getEbeln());
				itemTbl.setValue("ZSEQ", vo.getPartial_seq());
				itemTbl.setValue("EBELP", vo.getEbelp());
				itemTbl.setValue("LIFNR", vo.getBukrs());
				itemTbl.setValue("WERKS", vo.getWerks());
				itemTbl.setValue("ZFLAG", vo.getZflag());
				itemTbl.setValue("EINDT", vo.getVendor_delivery_date());
				itemTbl.setValue("MENGE", vo.getZdeli_menge());
				itemTbl.nextRow();
			}
			/* == Setting RFC Parameter =================================== */
			function.getTableParameterList().setValue("IT_EKET", itemTbl);
			/* == Return Value Mapping =================================== */
			try {
				logVo.setCreator("system");
				logVo.setUpdater("system");
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:ZMMFM_MAT_MASTER");
				logVo.setBatch_target_ds("material_recv");
				logVo.setBatch_type("M");
				logVo.setBatch_action("U");

				System.out.println(itemTbl.toString());
				connect.executeFunction(function);

				JSONObject resultObj = new JSONObject();
				resultObj.put("EV_STATUS", function.getExportParameterList().getString("EV_STATUS"));
				resultObj.put("EV_MESSAGE", function.getExportParameterList().getString("EV_MESSAGE"));
				
				System.out.println(resultObj);
				
				logVo.setBatch_result("S");
				logVo.setBatch_description("");
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");
				resultData.put("rows", resultObj);
			} catch (Exception ex) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				logVo.setBatch_result("F");
				logVo.setBatch_description(ex.toString());
				ex.printStackTrace();
			} finally {
				logVo.setBatch_end_dt(StringUtil.getDateTime());
				// logStatusDAO.insertLogStatus(logVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}

	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject zmmfm_po_schedule_proc(String funcName, List<SYScmRawProcVo> sapList) {
		JSONObject resultData = new JSONObject();
		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		try {
			LogStatusVo logVo = new LogStatusVo();
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			// get table from RFC
			JCoTable itemTbl = function.getTableParameterList().getTable("IT_EKET");
			// JSONObject selObj = (JSONObject)selArr.get(0);
			itemTbl.appendRows(sapList.size());
			for (SYScmRawProcVo vo : sapList) {
//				System.out.println(vo.toString());
//				System.out.println(vo.getVendor_delivery_date());
//				System.out.println(vo.getVendor_delivery_date().replaceAll("-", ""));
				itemTbl.setValue("LABNR", vo.getLabnr());
				itemTbl.setValue("EBELN", vo.getEbeln());
				itemTbl.setValue("ZSEQ", vo.getPartial_seq());
				itemTbl.setValue("EBELP", vo.getEbelp());
				itemTbl.setValue("LIFNR", vo.getBukrs());
				itemTbl.setValue("WERKS", vo.getWerks());
				itemTbl.setValue("ZFLAG", vo.getZflag());
				itemTbl.setValue("EINDT", vo.getVendor_delivery_date().replaceAll("-", ""));
				itemTbl.setValue("MENGE", vo.getZdeli_menge());
				itemTbl.nextRow();
			}
			/* == Setting RFC Parameter =================================== */
			function.getTableParameterList().setValue("IT_EKET", itemTbl);
			/* == Return Value Mapping =================================== */
			try {
				logVo.setCreator("system");
				logVo.setUpdater("system");
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:"+funcName);
				logVo.setBatch_target_ds("RAW_PROC_TBL");
				logVo.setBatch_type("M");
				logVo.setBatch_action("U");
				
				System.out.println(itemTbl.toString());
				connect.executeFunction(function);
				
				JSONObject resultObj = new JSONObject();
				resultObj.put("EV_STATUS", function.getExportParameterList().getString("EV_STATUS"));
				resultObj.put("EV_MESSAGE", function.getExportParameterList().getString("EV_MESSAGE"));
				
				System.out.println(resultObj);
				
				logVo.setBatch_result("S");
				logVo.setBatch_description("");
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");
				resultData.put("rows", resultObj);
			} catch (Exception ex) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				logVo.setBatch_result("F");
				logVo.setBatch_description(ex.toString());
				ex.printStackTrace();
			} finally {
				logVo.setBatch_end_dt(StringUtil.getDateTime());
				logStatusDAO.insertLogStatus(logVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}

	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject ziffm_mes_pp002(String func_name, String iv_date, String iv_werks, String iv_if) {

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		List<SYHubBomVo> pVoList = new ArrayList<SYHubBomVo>();
		int result1 = 0;

		try {
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo);
			JCoFunction function = connect.getFunction(func_name);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}

			/* == Setting RFC Parameter =================================== */
			function.getImportParameterList().setValue("IV_DATE", iv_date);
//			function.getImportParameterList().setValue("IV_WERKS", iv_werks);
			function.getImportParameterList().setValue("IV_IF", iv_if);

			/* == Return Value Mapping =================================== */
			LogStatusVo logVo = new LogStatusVo();

			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:" + func_name);
			logVo.setBatch_target_ds("hub_tbl");
			logVo.setBatch_type("M");
			logVo.setBatch_action("U");

			connect.executeFunction(function);

			JCoTable t_tab = function.getTableParameterList().getTable("ET_OUTPUT");

			System.out.println("t_tab.getNumRows()" + t_tab.getNumRows());

			for (int i = 0; i < t_tab.getNumRows(); i++) {
				t_tab.setRow(i);
				SYHubBomVo pVo = new SYHubBomVo();
				pVo.setMatnr(t_tab.getString("MATNR"));
				pVo.setWerks(t_tab.getString("WERKS"));
				pVo.setStlan(t_tab.getString("STLAN"));
				pVo.setStlal(t_tab.getString("STLAL"));
				pVo.setStufe(t_tab.getString("STUFE"));
				pVo.setZmatnr(t_tab.getString("ZMATNR"));
				pVo.setZmaktx(t_tab.getString("ZMAKTX"));
				pVo.setMaktx(t_tab.getString("MAKTX"));
				pVo.setIdnrk(t_tab.getString("IDNRK"));
				pVo.setOjtxp(t_tab.getString("OJTXP"));
				pVo.setMenge(t_tab.getString("MENGE"));
				pVo.setMeins(t_tab.getString("MEINS"));
				pVo.setSortf(t_tab.getString("SORTF"));
				pVo.setPotx1(t_tab.getString("POTX1"));
				pVo.setSchgt(t_tab.getString("SCHGT"));
				pVo.setMschg(t_tab.getString("MSCHG"));
				pVo.setSobsl(t_tab.getString("SOBSL"));
				pVo.setSobsk(t_tab.getString("SOBSK"));
				pVo.setSernp(t_tab.getString("SERNP"));
				pVo.setDatuv(t_tab.getString("DATUV"));
				pVo.setAennr(t_tab.getString("AENNR"));
				pVo.setDatub(t_tab.getString("DATUB"));
				pVo.setAenra(t_tab.getString("AENRA"));

				pVoList.add(pVo);
				result1 = hubDAO.insert_ZIFFM_MES_PP002(pVo);

			}

			resultData.put("return_status", result1);
			resultData.put("return_count", t_tab.getNumRows());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}

	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject ziffm_mes_pp003(SYProdVo prodVo, String fDate,
			String tDate, String funcName) {
		JSONObject resultData = new JSONObject();
		JSONParser jsonParser = new JSONParser();
		List<SYProdVo> listCode = null;
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		try {
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}

			/* == Setting RFC Parameter =================================== */
			function.getImportParameterList().setValue("IV_FDATE", fDate);
			function.getImportParameterList().setValue("IV_TDATE", tDate);
			function.getImportParameterList().setValue("IV_IF", "X");
			/* == Return Value Mapping =================================== */
			try {
				LogStatusVo logVo = new LogStatusVo();

				logVo.setCreator("system");
				logVo.setUpdater("system");
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:ZIFFM_MES_PP003");
				logVo.setBatch_target_ds("prod_tbl");
				logVo.setBatch_type("M");
				logVo.setBatch_action("U");

				connect.executeFunction(function);

				JSONObject resultObj = new JSONObject();

				JCoTable t_order = function.getTableParameterList().getTable("ET_OUTPUT_1"); // 오더 정보 TABLE
				JCoTable t_process = function.getTableParameterList().getTable("ET_OUTPUT_2"); // 공정 정보 TABLE
				resultObj.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
				resultObj.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));
//				sYprodService.fn_ZIFFM_MES_PP003(t_order, t_process);

				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");

			} catch (Exception ex) {
				resultData.put("status",
						HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				ex.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}

	@SuppressWarnings("unchecked")
	public HashMap<String, Object> ziffm_pop_pp004(String funcName, String aufnr, String iv_if) {

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		HashMap<String, Object> hashObj = new HashMap<String, Object>();

		List<SYPoRequirementVo> pVoList = new ArrayList<SYPoRequirementVo>();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		try {
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}

			/* == Setting RFC Parameter =================================== */
			function.getImportParameterList().setValue("IV_AUFNR", aufnr);
			function.getImportParameterList().setValue("IV_IF", iv_if);
			/* == Return Value Mapping =================================== */
			try {
				connect.executeFunction(function);

				JSONObject resultObj = new JSONObject();
				JCoTable t_tab = function.getTableParameterList().getTable("ET_OUTPUT");

				for (int i = 0; i < t_tab.getNumRows(); i++) {
					t_tab.setRow(i);
					SYPoRequirementVo pVo = new SYPoRequirementVo();
					pVo.setAufnr(t_tab.getString("AUFNR"));
					pVo.setRspos(t_tab.getString("RSPOS"));
					pVo.setMatnr(t_tab.getString("MATNR"));
					pVo.setBdmng(t_tab.getString("BDMNG"));
					pVo.setMeins(t_tab.getString("MEINS"));
					pVo.setSernp(t_tab.getString("SERNP"));
					pVo.setXloek(t_tab.getString("XLOEK"));
					pVo.setLgort(t_tab.getString("LGORT"));
					pVo.setSchgt(t_tab.getString("SCHGT"));
					pVo.setSortf(t_tab.getString("SORTF"));
					pVo.setPotx1(t_tab.getString("POTX1"));
					pVo.setDumps(t_tab.getString("DUMPS"));
					// RESB-WERKS 플랜트
					// MARC-DISPO MRP 관리자
					pVo.setWerks(t_tab.getString("WERKS"));
					pVo.setDispo(t_tab.getString("DISPO"));
					pVo.setZdispo(t_tab.getString("ZDISPO"));
					pVo.setAennr(t_tab.getString("AENNR"));
 	
					pVoList.add(pVo);
				}

				hashObj.put("voList", pVoList);

				resultObj.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
				resultObj.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));

				listDataJArray.add(resultObj);

				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");

			} catch (Exception ex) {
				resultData.put("status",
						HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				ex.printStackTrace();
			}
			resultData.put("rows", listDataJArray);
			hashObj.put("resultData", resultData);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}

		return hashObj;
	}

	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject ziffm_mes_pp013(String funcName, String fdate,
			String tdate, String iv_if) {

		JSONObject resultData = new JSONObject();
		JSONParser jsonParser = new JSONParser();
		List<SYReqmMatnrTblVo> listCode = null;
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		try {

			LogStatusVo logVo = new LogStatusVo();
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}

			/* == Setting RFC Parameter =================================== */
			function.getImportParameterList().setValue("IV_FDATE", fdate);
			function.getImportParameterList().setValue("IV_TDATE", tdate);
			function.getImportParameterList().setValue("IV_IF", iv_if);
			/* == Return Value Mapping =================================== */
			try {
				logVo.setCreator("system");
				logVo.setUpdater("system");
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:ZMMFM_MAT_MASTER");
				logVo.setBatch_target_ds("material_recv");
				logVo.setBatch_type("M");
				logVo.setBatch_action("U");

				connect.executeFunction(function);

				JSONObject resultObj = new JSONObject();

				JCoTable et_output = function.getTableParameterList().getTable("ET_OUTPUT");

				resultObj.put("et_output", et_output);
				resultObj.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
				resultObj.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));

				resultData.put("rows", resultObj);
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");

			} catch (Exception ex) {
				resultData.put("status",
						HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				logVo.setBatch_result("F");
				logVo.setBatch_description(ex.toString());
				ex.printStackTrace();
			} finally {
				logVo.setBatch_end_dt(StringUtil.getDateTime());
				logStatusDAO.insertLogStatus(logVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}

	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject ziffm_mes_pp007(String funcName, List<SYSernrManageVo> voList, String dept_cd, String user_id, String target_ds) {
		// public List<SYProdVo> ziffm_mes_pp007(String funcName, String params,
		// String lgort, String dept_cd) {
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		String pordno = "";
		LogStatusVo logVo = new LogStatusVo();

		try {
//			String params = sVo.getParams(); 
//			String lgort = sVo.getLgort(); 
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
	
			logVo.setCreator(user_id);
			logVo.setUpdater(user_id);
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:ZIFFM_MES_PP007");
			logVo.setBatch_target_ds(target_ds);
			logVo.setBatch_type("PR");
			logVo.setBatch_action("U");

			// get table from RFC
			JCoTable impTable = function.getTableParameterList().getTable("IT_PP007");

			impTable.appendRows(voList.size());
			for ( SYSernrManageVo vo : voList) {
				// set Table : import data
				
//				if(vo.getWerks() != "" || vo.getWerks() != null) {
//					dept_cd = vo.getWerks();
//				}
					
				pordno = vo.getPordno();
				
				impTable.setValue("WERKS", dept_cd);
				impTable.setValue("BUDAT", vo.getBudat());
//				impTable.setValue("AUFNR", vo.getAufnr());
				impTable.setValue("AUFNR", vo.getPordno());
				impTable.setValue("MATNR", vo.getMatnr());
				impTable.setValue("SERNR", vo.getSernr());
				impTable.setValue("MENGE", vo.getBdmng());
				impTable.setValue("MEINS", vo.getMeins());
				impTable.setValue("LGORT", vo.getLgort());
				impTable.setValue("REVERSE", vo.getReverse());
				impTable.nextRow();
			}
			System.out.println(impTable.toString());
			// == Setting RFC Parameter ===================================
			function.getTableParameterList().setValue("IT_PP007", impTable);
			function.getImportParameterList().setValue("IV_IF", "X");
			// == Return Value Mapping ===================================
			connect.executeFunction(function);

			JSONObject resultObj = new JSONObject();
			resultObj.put("ET_OUTPUT", function.getTableParameterList().getTable("ET_OUTPUT"));
			
			String zifsta = "-";
			String zifmsg = "-";
			
			JCoTable ettbl = function.getTableParameterList().getTable("ET_OUTPUT");
			for (int i = 0; i < ettbl.getNumRows(); i++, ettbl.nextRow()) {
				zifsta = ettbl.getString("ZIFSTA");
				zifmsg = ettbl.getString("ZIFMSG");
			}
			
			System.out.println("rfc result :return msg**************************************");
			System.out.println(zifsta);
			System.out.println(zifmsg);
			
			resultData.put("zifsta", zifsta);
			resultData.put("zifmsg", zifmsg);
			
//			listDataJArray.add(resultObj);
			logVo.setBatch_result("S");
			logVo.setBatch_description(zifmsg + "(" + pordno + ")");
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");
//			resultData.put("rows", listDataJArray);
			resultData.put("rows", resultObj);

			System.out.println(resultData.toJSONString());
		} catch (Exception e) {
			logVo.setBatch_result("F");
			logVo.setBatch_description(e.toString());
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
			e.printStackTrace();
		} finally {
			logVo.setBatch_end_dt(StringUtil.getDateTime());
			logStatusDAO.insertLogStatus(logVo);
		}
		return resultData;
		// return pVoList;
	}

	@SuppressWarnings("unchecked")
	public JSONObject ziffm_mes_pp011(String funcName, String params, String pdsts, String sessId) {
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);

		List<SYProdVo> pVoList = new ArrayList<SYProdVo>();
		
		LogStatusVo logVo = new LogStatusVo();
		String aufnr = "";
		String sernr = "";
		
		try {
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			
			logVo.setCreator(sessId);
			logVo.setUpdater(sessId);
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:ZIFFM_MES_PP011");
			logVo.setBatch_target_ds("Production Main sernr Add");
			logVo.setBatch_type("PR");
			logVo.setBatch_action("U");

			// get table from RFC
			JCoTable impTable = function.getTableParameterList().getTable("IT_PP011");
			// string to json list
			listDataJArray = (JSONArray) jsonParser.parse(params);
			// get keys : prodNo, c_date, dateBySeq, project_no
			JSONObject jOb = (JSONObject) listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();
			
			impTable.appendRows(listDataJArray.size());
			for (int idx = 0; idx < listDataJArray.size(); idx++) {
				JSONObject jObj = new JSONObject();
				SYProdVo pVo = new SYProdVo();
				jObj = (JSONObject) listDataJArray.get(idx);
				pVo.setCreator(sessId);
				pVo.setUpdater(sessId);
				pVo.setPdsts(pdsts);
				// set Table : import data
				for (Object key : keyArr) {
					String nKey = key.toString();
					String nValue = "";
					if( jObj.get(nKey)==null ) continue;
					else nValue = jObj.get(nKey).toString();
					System.out.println("------ nKey : " + nKey + " / nValue = " + nValue);
					if ("prodNo".equals(nKey)) {
						impTable.setValue("AUFNR", nValue);
						pVo.setPordno(nValue);
						aufnr = nValue;
					} else if ("pordno".equals(nKey)) {
						impTable.setValue("AUFNR", nValue);
						pVo.setPordno(nValue);
						aufnr = nValue;
					} else if ("c_date".equals(nKey)) {
						impTable.setValue("GSTRP", nValue);
						impTable.setValue("GLTRP", nValue);
						pVo.setCmdat(nValue);
					} else if ("dateBySeq".equals(nKey)) {
						pVo.setCmdat_seq(nValue);
					} else if ("project_no".equals(nKey)) {
						impTable.setValue("SERNR", nValue);
						pVo.setProject_no(nValue);
						sernr = nValue;
					} else if ("fedat".equals(nKey)) {
						impTable.setValue("GLTRP", nValue);
					} else if ("sedat".equals(nKey)) {
						impTable.setValue("GSTRP", nValue);
					} else if ("zmesfirm".equals(nKey)) {
						impTable.setValue("ZMESFIRM", nValue);
					}
				}
				impTable.nextRow();
				pVoList.add(pVo);
			}
			System.out.println(impTable.toString());
			// == Setting RFC Parameter ===================================
			function.getTableParameterList().setValue("IT_PP011", impTable);
			function.getImportParameterList().setValue("IV_IF", "X");
			// == Return Value Mapping ===================================
			connect.executeFunction(function);
			
			JSONObject resultObj = new JSONObject();
			resultObj.put("ET_OUTPUT", function.getTableParameterList().getTable("ET_OUTPUT"));
			System.out.println(function.getTableParameterList().getTable("ET_OUTPUT"));
			String zifsta ="-";
			String zifmsg ="-";
			
			JCoTable ettbl = function.getTableParameterList().getTable("ET_OUTPUT");
			for (int i = 0; i < ettbl.getNumRows(); i++, ettbl.nextRow()) {
				zifsta = ettbl.getString("ZIFSTA");
				zifmsg = ettbl.getString("ZIFMSG");
			}
			
			System.out.println("#############zifsta :: " + zifsta);
			System.out.println("#############zifmsg :: " + zifmsg);
			
			resultData.put("zifsta", zifsta);
			resultData.put("zifmsg", zifmsg);
			
			
			logVo.setBatch_result("S");
			logVo.setBatch_description(zifmsg + "("+aufnr + " // "+ sernr +")");
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");
			resultData.put("list", pVoList);
			
			
			System.out.println(resultData.toJSONString());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
			
			logVo.setBatch_result("F");
			logVo.setBatch_description(e.toString() + "("+aufnr + " // "+ sernr +")");
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
			e.printStackTrace();
		} finally {
			logVo.setBatch_end_dt(StringUtil.getDateTime());
			logStatusDAO.insertLogStatus(logVo);
		}
		return resultData;
	}

	/*
	 * //zmmfm_ven_master
	 * 
	 * @SuppressWarnings({ "unused", "unchecked" }) public List<SYVendorVo>
	 * zmmfm_ven_master(String funcName, String iv_fdate, String iv_tdate,
	 * String iv_if) { JSONObject resultData = new JSONObject(); JSONArray
	 * listDataJArray = new JSONArray(); JSONParser jsonParser = new
	 * JSONParser(); VmesJcoConnectVo connectVo = new
	 * VmesJcoConnectVo(environment); VmesJcoConnection connect = new
	 * VmesJcoConnection(connectVo); List<SYVendorVo> pVoList = new
	 * ArrayList<SYVendorVo>(); int result1 =0;
	 * 
	 * 
	 * try { JCoFunction function = connect.getFunction(funcName); if (function
	 * == null) { throw new RuntimeException("function not found in SAP."); }
	 * 
	 * LogStatusVo logVo = new LogStatusVo();
	 * 
	 * logVo.setCreator("system"); logVo.setUpdater("system");
	 * logVo.setBatch_start_dt(StringUtil.getDateTime());
	 * logVo.setBatch_source_ds("SAP:ZMMFM_VEN_MASTER");
	 * logVo.setBatch_target_ds("vendor_tbl"); logVo.setBatch_type("M");
	 * logVo.setBatch_action("U");
	 * 
	 * //== Setting RFC Parameter ===================================
	 * function.getImportParameterList().setValue("IV_FDATE", iv_fdate);
	 * function.getImportParameterList().setValue("IV_TDATE", iv_tdate); //==
	 * Return Value Mapping ===================================
	 * connect.executeFunction(function); JCoTable t_tab =
	 * function.getTableParameterList().getTable("ET_LFA1"); for(int i=0;
	 * i<t_tab.getNumRows(); i++) { t_tab.setRow(i); SYVendorVo pVo = new
	 * SYVendorVo(); pVo.setLifnr(t_tab.getString("LIFNR"));
	 * pVo.setKtokk(t_tab.getString("KTOKK"));
	 * pVo.setTxt30(t_tab.getString("TXT30"));
	 * pVo.setLoevm(t_tab.getString("LOEVM"));
	 * pVo.setName1(t_tab.getString("NAME1"));
	 * pVo.setName2(t_tab.getString("NAME2"));
	 * pVo.setMcod1(t_tab.getString("MCOD1"));
	 * pVo.setPstlz(t_tab.getString("PSTLZ"));
	 * pVo.setOrt01(t_tab.getString("ORT01"));
	 * pVo.setRegio(t_tab.getString("REGIO"));
	 * pVo.setLand1(t_tab.getString("LAND1"));
	 * pVo.setTelf1(t_tab.getString("TELF1"));
	 * pVo.setTelf2(t_tab.getString("TELF2"));
	 * pVo.setTelfx(t_tab.getString("TELFX"));
	 * pVo.setSmpt_addr(t_tab.getString("SMPT_ADDR"));
	 * pVo.setStenr(t_tab.getString("STENR"));
	 * pVo.setJ_1kfrepre(t_tab.getString("J_1KFREPRE"));
	 * pVo.setJ_1kfrbus(t_tab.getString("J_1KFTBUS"));
	 * pVo.setJ_1kftind(t_tab.getString("J_1KFTIND"));
	 * pVo.setAltkn(t_tab.getString("ALTKN"));
	 * pVo.setErdat(t_tab.getString("ERDAT"));
	 * pVo.setAedat(t_tab.getString("AEDAT"));
	 * 
	 * result1 = hubDAO.insertSapVendor(pVo);
	 * 
	 * pVoList.add(pVo); }
	 * 
	 * } catch(Exception e){ e.printStackTrace(); } return pVoList; }
	 */
	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject zmmfm_goodsmvt_st(String funcName, JSONObject jObj) {
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		LogStatusVo logVo = new LogStatusVo();
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar c1 = Calendar.getInstance();
			String strToday = sdf.format(c1.getTime());
			
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:ZMMFM_GOODSMVT_ST");
			logVo.setBatch_target_ds("-");
			logVo.setBatch_type("M");
			logVo.setBatch_action("U");

			// get table from RFC
			JCoTable itemTable = function.getTableParameterList().getTable("IT_ITEM");
			JCoTable senrTable = function.getTableParameterList().getTable("IT_SERIAL");
			// string to json list
			
			// header
//			NumberFormat nf = new DecimalFormat("0000");
//			String matdoc_itm = nf.format(1);
			itemTable.appendRows(1);
			itemTable.setValue("MATDOC_ITM", "0001");
			itemTable.setValue("MATERIAL", jObj.get("matnr").toString());
			itemTable.setValue("MOVE_TYPE", "311");
			itemTable.setValue("PLANT", jObj.get("plant".toString()));
			itemTable.setValue("STGE_LOC", jObj.get("stge_loc").toString());
			itemTable.setValue("VENDOR", jObj.get("bukrs").toString());
			itemTable.setValue("RESERV_NO", jObj.get(""));
			itemTable.setValue("RES_ITEM", jObj.get(""));
			itemTable.setValue("MOVE_MAT", jObj.get("matnr").toString());
			itemTable.setValue("MOVE_PLANT", jObj.get("plant".toString()));
			itemTable.setValue("MOVE_STLOC", jObj.get("move_stloc".toString()));
			itemTable.setValue("MOVE_REAS", "");
			itemTable.setValue("ENTRY_QNT", jObj.get("menge").toString());		
			itemTable.setValue("ENTRY_UOM", jObj.get("meins").toString());
			itemTable.setValue("GR_RCPT", "");
			itemTable.setValue("ITEM_TEXT", "");
			
			// serial
//			SYScmRawSernrVo sVo = new SYScmRawSernrVo();
//			sVo.setEbeln(jObj.get("ebeln").toString());
//			sVo.setEbelp(jObj.get("ebelp").toString());
//			List<SYScmRawSernrVo> serList = new ArrayList<SYScmRawSernrVo>();
//			serList = sYScmService.rawSernr_select(sVo);
			SYScmRawProcSernrVo sVo = new SYScmRawProcSernrVo();
			sVo.setEbeln(jObj.get("ebeln").toString());
			sVo.setEbelp(jObj.get("ebelp").toString());
			List<SYScmRawProcSernrVo> serList = new ArrayList<SYScmRawProcSernrVo>();
			serList = sYScmService.rawProcSernr_select(sVo);
			
			if( serList.size()>0 ) {
				senrTable.appendRows(serList.size());
				for(int idx=0; idx<serList.size(); idx++){
					SYScmRawProcSernrVo vo = serList.get(idx); 
					senrTable.setValue("MATDOC_ITM", "0001");
					senrTable.setValue("SERIALNO", vo.getEqunr());
					senrTable.nextRow();
				}
			}

			// == Setting RFC Parameter ===================================
			String newKey = sYScmService.makeRefDocNo();
			function.getImportParameterList().setValue("IV_REF_DOC_NO", newKey);	// ??
			function.getImportParameterList().setValue("IV_PSTNG_DATE",	strToday);
			function.getImportParameterList().setValue("IV_DOC_DATE", strToday);
			function.getTableParameterList().setValue("IT_ITEM", itemTable);
			function.getTableParameterList().setValue("IT_SERIAL", senrTable);

			// == Return Value Mapping ===================================
			System.out.println("#####################################");
			System.out.println(newKey);
			System.out.println(itemTable);
			System.out.println(senrTable);

			connect.executeFunction(function);

			String rStatus = function.getExportParameterList().getString("EV_STATUS");
			resultData.put("EV_REF_DOC_NO", function.getExportParameterList().getString("EV_REF_DOC_NO"));
			resultData.put("EV_MBLNR", function.getExportParameterList().getString("EV_MBLNR"));
			resultData.put("EV_MJAHR", function.getExportParameterList().getString("EV_MJAHR"));
			
			resultData.put("EV_STATUS", rStatus);
			resultData.put("EV_MESSAGE", function.getExportParameterList().getString("EV_MESSAGE"));
			
			if( "S".equals(rStatus) ) {
				logVo.setBatch_result("S");
				logVo.setBatch_description("");
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");
				// ref_doc_no update
				SYInInspVo iVo = new SYInInspVo();
				iVo.setEbeln(jObj.get("ebeln").toString());
				iVo.setEbelp(jObj.get("ebelp").toString());
				iVo.setPartial_seq(jObj.get("partial_seq").toString());
				iVo.setRef_doc_no(newKey);
				sYQmDAO.inInsp_update(iVo);
			} else {
				logVo.setBatch_result("F");
				logVo.setBatch_description("RFC FUNC is fail.");
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
			}
			
			System.out.println(resultData.toJSONString());
		} catch (Exception e) {
			logVo.setBatch_result("F");
			logVo.setBatch_description(e.toString());
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
			e.printStackTrace();
		}
		return resultData;
	}
	
	@SuppressWarnings("unchecked")
	public JSONObject zmmfm_goodsmvt_st(String funcName, SYQmVo sVo) {
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		LogStatusVo logVo = new LogStatusVo();
		try {
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:ZMMFM_GOODSMVT_ST");
			logVo.setBatch_target_ds("-");
			logVo.setBatch_type("M");
			logVo.setBatch_action("U");

			// get table from RFC
			JCoTable itemTable = function.getTableParameterList().getTable("IT_ITEM");
			JCoTable senrTable = function.getTableParameterList().getTable("IT_SERIAL");
			// string to json list
			
			/******** gridData 데이터 가져오기 : start *********/
			String gridData = sVo.getGridData();
			List<SYQmVo> data_list = new ArrayList<SYQmVo>();
			listDataJArray = (JSONArray) jsonParser.parse(gridData);
			
			if(listDataJArray.size() != 0) {
				JSONObject jOb = (JSONObject)listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();
	
				
				for(int idx=0; idx<listDataJArray.size(); idx++){
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject)listDataJArray.get(idx);
					SYQmVo tmp_sVo = new SYQmVo();
			
					for(Object key : keyArr){
						String nKey = key.toString();
						String nValue =  (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						
						if( "pordno".equals(nKey) ) tmp_sVo.setPordno(nValue);
						else if( "itnbr".equals(nKey) ) tmp_sVo.setItnbr(nValue);
						else if( "project_no".equals(nKey) ) tmp_sVo.setProject_no(nValue);
						
						tmp_sVo.setPlant(sVo.getPlant());
						tmp_sVo.setStge_loc(sVo.getStge_loc());
						tmp_sVo.setMove_plant(sVo.getMove_plant());
						tmp_sVo.setMove_stloc(sVo.getMove_stloc());
					}
					data_list.add(tmp_sVo);
				}
			}
			/******** gridData 데이터 가져오기 : end *********/

			/******** itemTable 작성 : start *********/
			// data size 만큼 itemTable, senrTable row생성
			itemTable.appendRows(data_list.size());
			senrTable.appendRows(data_list.size());
			
			for (int j = 0; j < data_list.size(); j++) {
				itemTable.setValue("MATDOC_ITM", ("00000"+(j+1)).substring(("00000"+(j+1)).length()-4, ("00000"+(j+1)).length()));
				System.out.println("MATDOC_ITM"+("00000"+(j+1)).substring(("00000"+(j+1)).length()-4, ("00000"+(j+1)).length()) );
				itemTable.setValue("MATERIAL", data_list.get(j).getItnbr());
				itemTable.setValue("MOVE_TYPE", "311");
				itemTable.setValue("PLANT", sVo.getPlant());
				itemTable.setValue("STGE_LOC", sVo.getStge_loc());
				itemTable.setValue("MOVE_PLANT", sVo.getMove_plant());
				itemTable.setValue("MOVE_STLOC", sVo.getMove_stloc());
				itemTable.setValue("ENTRY_QNT", "1.000");
				itemTable.setValue("ENTRY_UOM", "EA");
				
				senrTable.setValue("MATDOC_ITM", ("00000"+(j+1)).substring(("00000"+(j+1)).length()-4, ("00000"+(j+1)).length()));
				senrTable.setValue("SERIALNO", data_list.get(j).getProject_no());
				
				itemTable.nextRow();
				senrTable.nextRow();
			}
			/******** itemTable 작성 : end *********/

			// == Setting RFC Parameter ===================================
			String newKey = sYScmService.reqm_matnr_tbl_key_select_1();
			function.getImportParameterList().setValue("IV_REF_DOC_NO", newKey);
			function.getImportParameterList().setValue("IV_PSTNG_DATE",	sVo.getConf_date());
			function.getImportParameterList().setValue("IV_DOC_DATE", sVo.getConf_date());
			function.getTableParameterList().setValue("IT_ITEM", itemTable);
			function.getTableParameterList().setValue("IT_SERIAL", senrTable);

			// == Return Value Mapping ===================================
			System.out.println("#####################################");
			System.out.println(newKey);
			System.out.println(sVo.getConf_date());
			System.out.println(itemTable);
			System.out.println(senrTable);

			connect.executeFunction(function);

			logVo.setBatch_result("S");
			logVo.setBatch_description("");
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");
 
			
			resultData.put("ev_ref_doc_no", function.getExportParameterList().getString("EV_REF_DOC_NO"));
			resultData.put("ev_mblnr", function.getExportParameterList().getString("EV_MBLNR"));
			resultData.put("ev_mjahr", function.getExportParameterList().getString("EV_MJAHR"));
			
			resultData.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
			resultData.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));
			System.out.println(resultData.toJSONString());
		} catch (Exception e) {
			logVo.setBatch_result("F");
			logVo.setBatch_description(e.toString());
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
			e.printStackTrace();
		}
		return resultData;
	}
	

	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject zmmfm_goodsmvt_st_forBatch() {
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		LogStatusVo logVo = new LogStatusVo();
		try {
			JCoFunction function = connect.getFunction("ZMMFM_GOODSMVT_ST");
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:ZMMFM_GOODSMVT_ST");
			logVo.setBatch_target_ds("-");
			logVo.setBatch_type("M");
			logVo.setBatch_action("U");

			// get table from RFC
			JCoTable itemTable = function.getTableParameterList().getTable("IT_ITEM");
			JCoTable senrTable = function.getTableParameterList().getTable("IT_SERIAL");

			List<SYQmVo> voList = sYQmDAO.batch_lastInsp_select();
			if( voList.size()>0 ) {
				int voSize = voList.size();
				/******** itemTable 작성 : start *********/
				// data size 만큼 itemTable, senrTable row생성
				for (int j = 0; j < voSize; j++) {
					itemTable.appendRows(1);
					senrTable.appendRows(1);
					
					SYQmVo vo = voList.get(j);
					itemTable.setValue("MATDOC_ITM", "0001");
					System.out.println("MATDOC_ITM"+ "0001" );
					itemTable.setValue("MATERIAL", vo.getItnbr());
					itemTable.setValue("MOVE_TYPE", "311");
					itemTable.setValue("PLANT", vo.getPlant());
					itemTable.setValue("STGE_LOC", vo.getStge_loc());
					itemTable.setValue("MOVE_PLANT", vo.getMove_plant());
					itemTable.setValue("MOVE_STLOC", vo.getMove_stloc());
					itemTable.setValue("ENTRY_QNT", vo.getPdqty());
				//	itemTable.setValue("ENTRY_QNT", "1.000");
					itemTable.setValue("ENTRY_UOM", "EA");
					
					senrTable.setValue("MATDOC_ITM", "0001");
					senrTable.setValue("SERIALNO", vo.getProject_no());
					
					// == Setting RFC Parameter ===================================
					String newKey = sYScmService.reqm_matnr_tbl_key_select_1();
					function.getImportParameterList().setValue("IV_REF_DOC_NO", newKey);
					function.getImportParameterList().setValue("IV_PSTNG_DATE",	vo.getConf_date());
					function.getImportParameterList().setValue("IV_DOC_DATE", vo.getConf_date());
					function.getTableParameterList().setValue("IT_ITEM", itemTable);
					function.getTableParameterList().setValue("IT_SERIAL", senrTable);

					// == Return Value Mapping ===================================
					System.out.println("#####################################");
					System.out.println(newKey);
					System.out.println(vo.getConf_date());
					System.out.println(itemTable);
					System.out.println(senrTable);

					connect.executeFunction(function);

					itemTable.clear();
					senrTable.clear();
					
					// UPDATE 'N'->'Y'
					if( "S".equals(function.getExportParameterList().getString("EV_STATUS")) ) {
						
						vo.setMblnr( function.getExportParameterList().getString("EV_MBLNR"));
						vo.setMjahr(function.getExportParameterList().getString("EV_MJAHR"));
						sYQmDAO.batch_lastInsp_update(vo);
					} else {
						System.out.println("EV_STATUS ==> E");
					}
					logVo.setBatch_result("S");
					logVo.setBatch_description("");
					resultData.put("status", HttpStatus.OK.value());
					resultData.put("message", "RFC FUNC. is success.");
					resultData.put("ev_ref_doc_no", function.getExportParameterList().getString("EV_REF_DOC_NO"));
					resultData.put("ev_mblnr", function.getExportParameterList().getString("EV_MBLNR"));
					resultData.put("ev_mjahr", function.getExportParameterList().getString("EV_MJAHR"));
					resultData.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
					resultData.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));
					System.out.println(resultData.toJSONString());
				}
			}
		} catch (Exception e) {
			logVo.setBatch_result("F");
			logVo.setBatch_description(e.toString());
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
			e.printStackTrace();
		}
		return resultData;
	}
	/*
	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject zmmfm_goodsmvt_st(String funcName, String reqm_matnr_key, String conf_date) {
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		LogStatusVo logVo = new LogStatusVo();
		try {
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			logVo.setCreator("-");
			logVo.setUpdater("-");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:ZMMFM_GOODSMVT_ST");
			logVo.setBatch_target_ds("Material transfer processing");
			logVo.setBatch_type("SC");
			logVo.setBatch_action("U");

			// get table from RFC
			JCoTable itemTable = function.getTableParameterList().getTable("IT_ITEM");
			JCoTable senrTable = function.getTableParameterList().getTable("IT_SERIAL");
			// string to json list

			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar c1 = Calendar.getInstance();
			String strToday = sdf.format(c1.getTime());

			*//******** db에서 master 데이터 가져오기 : start *********//*
			SYReqmMatnrTblVo pVo = new SYReqmMatnrTblVo();
			pVo.setReqm_matnr_key(reqm_matnr_key);

			List<SYReqmMatnrTblVo> mas_data_list = sYHubService.material_req_mas_select(pVo);

			*//******** db에서 master 데이터 가져오기 : end *********//*

			String mas_key = mas_data_list.get(0).getReqm_matnr_key();
			String sub_key = "";

			*//******** reqd_matnr_tbl 에 matdoc_itm 업데이트 : start *********//*
			List<SYReqmMatnrTblVo> tmp_matdoc_itm_list = sYHubService.tmp_matdoc_itm_select(pVo);

			for (int i = 0; i < tmp_matdoc_itm_list.size(); i++) {

				pVo = new SYReqmMatnrTblVo();

				String t_reqm_matnr_key = tmp_matdoc_itm_list.get(i).getReqm_matnr_key();
				String t_reqm_sub_key = tmp_matdoc_itm_list.get(i).getReqm_sub_key();
				String t_reqd_matnr_key = tmp_matdoc_itm_list.get(i).getReqd_matnr_key();
				String t_matdoc_itm = tmp_matdoc_itm_list.get(i).getTmp_matdoc_itm(); // sap rfc 던져줄때 쓸 키값때문에 만듬...

				pVo.setReqm_matnr_key(t_reqm_matnr_key);
				pVo.setReqm_sub_key(t_reqm_sub_key);
				pVo.setReqd_matnr_key(t_reqd_matnr_key);
				pVo.setMatdoc_itm(t_matdoc_itm);

				int result = sYHubService.matdoc_itm_update(pVo);
			}
			*//******** reqd_matnr_tbl 에 matdoc_itm 업데이트 : end *********//*

			for (int i = 0; i < mas_data_list.size(); i++) {
				*//******** db에서 detail 데이터 가져오기 : start *********//*

				sub_key = mas_data_list.get(i).getReqm_sub_key();

				pVo = new SYReqmMatnrTblVo();
				pVo.setReqm_matnr_key(mas_key);
				pVo.setReqm_sub_key(sub_key);
				List<SYReqmMatnrTblVo> det_data_list = sYHubService.material_req_det_select(pVo);

				List<SYReqmMatnrTblVo> tmp_det_data_list = new ArrayList<SYReqmMatnrTblVo>();

				// 승인수량이 0인건 승인하지 않은 실적임...해당 실적 제외한 detail list 작성
				for (int k = 0; k < det_data_list.size(); k++) {
					if (det_data_list.get(k).getConfirm_bdmng().equals("0.000") == false) {
						tmp_det_data_list.add(det_data_list.get(k));
					}
				}
				*//******** db에서 detail 데이터 가져오기 : end *********//*

				*//******** detail 데이터로 itemTable 작성 : start *********//*
				// detail size 만큼 itemTable row생성
				itemTable.appendRows(tmp_det_data_list.size());

				for (int j = 0; j < tmp_det_data_list.size(); j++) {

					itemTable.setValue("MATDOC_ITM", tmp_det_data_list.get(j)	.getMatdoc_itm());
					itemTable.setValue("MATERIAL", tmp_det_data_list.get(j).getMatnr());
					
					itemTable.setValue("ENTRY_QNT", tmp_det_data_list.get(j).getConfirm_bdmng());
					itemTable.setValue("ENTRY_UOM", tmp_det_data_list.get(j).getMeins());
					itemTable.setValue("GR_RCPT", tmp_det_data_list.get(j).getCreator());
					
					if(tmp_det_data_list.get(j).getPgm_nm().equals("SCM")) {
						// SCM에서 요청한 내역일때 
						if(tmp_det_data_list.get(j).getPlant().equals(tmp_det_data_list.get(j).getMove_plant())) {
							itemTable.setValue("MOVE_TYPE", "311");
						} else {
							itemTable.setValue("MOVE_TYPE", "301");
						}
						itemTable.setValue("PLANT", tmp_det_data_list.get(j).getPlant());
						itemTable.setValue("MOVE_PLANT", tmp_det_data_list.get(j).getMove_plant());
						itemTable.setValue("STGE_LOC", tmp_det_data_list.get(j).getStge_loc());
						itemTable.setValue("MOVE_STLOC", tmp_det_data_list.get(j).getMove_stloc());
					} else {
						// MES에서 요청한 내역일때
						itemTable.setValue("MOVE_TYPE", "311");
						itemTable.setValue("PLANT", tmp_det_data_list.get(j).getWerks());
						itemTable.setValue("MOVE_PLANT", tmp_det_data_list.get(j).getWerks());
						
						*//********자재이동 일때 창고코드 설정 : start *********//*
						// 창고코드는 등급구분이 있으면 grade_master 테이블에서 없으면 자재마스터에서 가져온다
						if (tmp_det_data_list.get(j).getGrade_nm().equals("등급없음")) {
							SYReqmMatnrTblVo sVo = new SYReqmMatnrTblVo();

							sVo.setMatnr(tmp_det_data_list.get(j).getMatnr());
							sVo.setWerks(tmp_det_data_list.get(j).getWerks());

//							List<SYReqmMatnrTblVo> matnr_list = sYMesService.grade_exist_chk(sVo);
//							String lgpro = matnr_list.get(0).getLgpro();
//							String lgfsb = matnr_list.get(0).getLgfsb();
							String lgfsb = tmp_det_data_list.get(j).getStge_loc();
							String lgpro = tmp_det_data_list.get(j).getMove_stloc();
							itemTable.setValue("STGE_LOC", lgfsb.trim()); // from창고코드
							itemTable.setValue("MOVE_STLOC", lgpro.trim()); // to창고코드
						} else {
							String grade_nm = tmp_det_data_list.get(j).getGrade_nm();
							List<SYReqmMatnrTblVo> grade_info_list = sYHubService.grade_master_selc(grade_nm);
							itemTable.setValue("STGE_LOC", grade_info_list.get(0).getFrom_loc()); // from창고 코드
							itemTable.setValue("MOVE_STLOC", grade_info_list.get(0).getTo_loc()); // to창고 코드
						}
						*//********자재이동 일때 창고코드 설정 : end *********//*
					}
					
					itemTable.nextRow();

				}
				*//******** detail 데이터로 itemTable 작성 : end *********//*
			}

			*//******** db에서 serial 데이터 가져오기 : start *********//*
			pVo = new SYReqmMatnrTblVo();
			pVo.setReqm_matnr_key(mas_key);
			List<SYReqmMatnrTblVo> senr_data_list = sYHubService
					.material_req_done_select(pVo);
			*//******** db에서 serial 데이터 가져오기 : end *********//*

			*//******** serial 데이터로 senrTable 작성 : start *********//*
			senrTable.appendRows(senr_data_list.size());

			for (int i = 0; i < senr_data_list.size(); i++) {
				senrTable.setValue("MATDOC_ITM", senr_data_list.get(i).getMatdoc_itm());
				senrTable.setValue("SERIALNO", senr_data_list.get(i).getSernr()	.trim());
				senrTable.nextRow();
			}
			*//******** serial 데이터로 senrTable 작성 : end *********//*

			// == Setting RFC Parameter ===================================
			function.getImportParameterList().setValue("IV_REF_DOC_NO", reqm_matnr_key.trim());
			function.getImportParameterList().setValue("IV_PSTNG_DATE",	conf_date);
			function.getImportParameterList().setValue("IV_DOC_DATE", conf_date);
			function.getTableParameterList().setValue("IT_ITEM", itemTable);
			function.getTableParameterList().setValue("IT_SERIAL", senrTable);

			// == Return Value Mapping ===================================
			System.out.println("#####################################");
			System.out.println(reqm_matnr_key.trim());
			System.out.println(conf_date);
			System.out.println(itemTable);
			System.out.println(senrTable);

			connect.executeFunction(function);

			logVo.setBatch_result("S");
			logVo.setBatch_description("");
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");
			resultData.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
			resultData.put("e_message", function.getExportParameterList()	.getString("EV_MESSAGE"));
			System.out.println(resultData.toJSONString());
		} catch (Exception e) {
			logVo.setBatch_result("F");
			logVo.setBatch_description(e.toString());
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
			e.printStackTrace();
		}
		return resultData;
	}*/
	/*
	@SuppressWarnings("unchecked")
	public JSONObject ziffm_mes_pp008(String funcName, String pordno, String pordno_pop, String routing_no, String user_id) {
		JSONObject resultData = new JSONObject();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		LogStatusVo logVo = new LogStatusVo();
		try {
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			logVo.setCreator(user_id);
			logVo.setUpdater(user_id);
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:ZIFFM_MES_PP008");
			logVo.setBatch_target_ds("Production warehousing processing");
			logVo.setBatch_type("PR");
			logVo.setBatch_action("U");

			// get table from RFC
			JCoTable it_pp008 = function.getTableParameterList().getTable("IT_PP008");

			*//******** db에서 생산 데이터 가져오기 : start *********//*
			SYProdVo pVo = new SYProdVo();
			pVo.setPordno(pordno);
			pVo.setPordno_pop(pordno_pop);
			pVo.setRouting_no(routing_no);

			List<SYProdVo> prodTbl_list = sYprodService.sapProdCode(pVo);
			List<SYProdVo> prodOrdTbl_list = sYprodService.popProdSelect(pVo);

			*//******** db에서 생산 데이터 가져오기 : end *********//*

			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@");
			System.out.println("20"
					+ prodOrdTbl_list.get(0).getProd_end_date()
							.replace("-", ""));
			*//******** detail 데이터로 it_pp008 작성 : start *********//*

			it_pp008.appendRows(1);

			it_pp008.setValue("AUFNR", prodTbl_list.get(0).getPordno());
			it_pp008.setValue("MATNR", prodTbl_list.get(0).getItnbr());
			it_pp008.setValue("WERKS", prodTbl_list.get(0).getDept_cd());
			it_pp008.setValue("LMNGA", prodTbl_list.get(0).getPdqty());
			it_pp008.setValue("MEINS", "EA");
			it_pp008.setValue("FTRMI", "20"+ prodOrdTbl_list.get(0).getProd_end_date().replace("-", ""));
			it_pp008.setValue("SERNR", prodTbl_list.get(0).getProject_no());
			it_pp008.setValue("LGORT", prodTbl_list.get(0).getInsp_lgort());

			*//******** detail 데이터로 it_pp008 작성 : end *********//*

			// == Setting RFC Parameter ===================================
			System.out.println(it_pp008);
			function.getImportParameterList().setValue("IV_IF", "X");
			function.getTableParameterList().setValue("IT_PP008", it_pp008);
			// == Return Value Mapping ===================================
			connect.executeFunction(function);

			String zifsta ="-";
			String zifmsg ="-";
			
			JCoTable ettbl = function.getTableParameterList().getTable("ET_OUTPUT");
			for (int i = 0; i < ettbl.getNumRows(); i++, ettbl.nextRow()) {
				zifsta = ettbl.getString("ZIFSTA");
				zifmsg = ettbl.getString("ZIFMSG");
			}
			
			logVo.setBatch_result("S");
			logVo.setBatch_description(zifmsg + "("+prodTbl_list.get(0).getPordno()+")");
			

			resultData.put("zifsta", zifsta);
			resultData.put("zifmsg", zifmsg);
			resultData.put("message", "RFC FUNC. is success.");

			// JCoTable et_output =
			// function.getExportParameterList().getTable("ET_OUTPUT");
			// et_output.setRow(0);
			// String zifsta = et_output.getString("ZIFSTA");
			// String zifmsg = et_output.getString("ZIFMSG");

			// System.out.println("zifsta :: " + zifsta + "   //    zifmsg :: "
			// + zifmsg);
			//
			// resultData.put("rfc_status", zifsta);
			// resultData.put("rfc_message", zifmsg);

			System.out.println(resultData.toJSONString());
		} catch (Exception e) {
			logVo.setBatch_result("F");
			logVo.setBatch_description(e.toString());
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
			e.printStackTrace();
		} finally {
			logVo.setBatch_end_dt(StringUtil.getDateTime());
			logStatusDAO.insertLogStatus(logVo);
		}
		return resultData;

	}*/
	/*
	@SuppressWarnings("unchecked")
	public JSONObject ziffm_mes_pp006(String funcName, String pordno, String pordno_pop, String routing_no, String dept_cd, String wkctr, String user_id) {
		JSONObject resultData = new JSONObject();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		LogStatusVo logVo = new LogStatusVo();
		try {
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			logVo.setCreator(user_id);
			logVo.setUpdater(user_id);
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:ZIFFM_MES_PP006");
			logVo.setBatch_target_ds("Production performance processing");
			logVo.setBatch_type("PR");
			logVo.setBatch_action("U");

			// get table from RFC
			JCoTable it_pp006 = function.getTableParameterList().getTable(
					"IT_PP006");
			 //string to json list

		      SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			  Calendar c1 = Calendar.getInstance();
			  String strToday = sdf.format(c1.getTime());

			//String strToday = "20171020";

			String isdd = "";
			String isdz = "";
			String iedd = "";
			String iedz = "";
				
			*//******** 비가동 시간 합 : Start *********//*
			SYProdVo pVo = new SYProdVo();

			pVo.setPordno_pop(pordno_pop);
			List<SYProdVo> prod_his_list = sYprodService.popProdHisSelect(pVo);

			String start_dt = null;
			String end_dt = null;
			String pause_start_dt = null;
			String pause_end_dt = null;

			String pdqty = null;
			String pordno_child = null;
			
			long total_minute = 0;
			long p_total_minute = 0;

			for (int i = 0; i < prod_his_list.size(); i++) {
				////////////////////////////시작, 종료시간 구하는 부분////////////////////////////
				if(i == 0) {
					System.out.println("@@@@@@@@@@@ :::" + prod_his_list.get(i).getStart_dt_tm());
					String s_dttm = "20" + (prod_his_list.get(i).getStart_dt_tm().replace(":", "-").replace(" ","-").replace("-",""));
					isdd = s_dttm.substring(0, 8); // 작업시작일자
					isdz = s_dttm.substring(8, 14); // 작업시작시간
					
					pdqty = prod_his_list.get(i).getPdqty();
					pordno_child = prod_his_list.get(i).getPordno_child();
				}
				if(i == (prod_his_list.size()-1)) {
					String e_dttm = "20" + (prod_his_list.get(i).getEnd_dt_tm().replace(":", "-").replace(" ","-").replace("-",""));
					iedd = e_dttm.substring(0, 8); // 작업시작일자
					iedz = e_dttm.substring(8, 14); // 작업시작시간
				}
				
				////////////////////////////가동시간 구하는 부분////////////////////////////
				if (prod_his_list.get(i).getStart_dt_tm().trim().length() != 0) {
					start_dt = prod_his_list.get(i).getStart_dt_tm();
				}
				if (prod_his_list.get(i).getEnd_dt_tm().trim().length() != 0) {
					end_dt = prod_his_list.get(i).getEnd_dt_tm();
					// 비가동 시간 합 연산...
					String m_start_dt = "20" + (start_dt.replace(":", "-").replace(" ","-"));
					String m_end_dt = "20" + (end_dt.replace(":", "-").replace(" ", "-"));
					String[] s_date_arr = m_start_dt.split("-");
					String[] e_date_arr = m_end_dt.split("-");

					Calendar date1 = Calendar.getInstance();
					Calendar date2 = Calendar.getInstance();

					date1.set(Integer.parseInt(s_date_arr[0]),
							Integer.parseInt(s_date_arr[1]),
							Integer.parseInt(s_date_arr[2]),
							Integer.parseInt(s_date_arr[3]),
							Integer.parseInt(s_date_arr[4]),
							Integer.parseInt(s_date_arr[5]));

					date2.set(Integer.parseInt(e_date_arr[0]),
							Integer.parseInt(e_date_arr[1]),
							Integer.parseInt(e_date_arr[2]),
							Integer.parseInt(e_date_arr[3]),
							Integer.parseInt(e_date_arr[4]),
							Integer.parseInt(e_date_arr[5]));

					long minute = (date2.getTimeInMillis() - date1.getTimeInMillis()) / 60000;
					
					String m_cnt = prod_his_list.get(i).getMember_cnt();			
					if(m_cnt == null ) {
						m_cnt = "1";
					}
					minute = minute * Long.parseLong(m_cnt);
					total_minute = total_minute + minute;
				}
				////////////////////////////비가동 구하는 부분//////////////////////////// 
				if (prod_his_list.get(i).getPause_start_dt_tm().trim().length() != 0) {
					pause_start_dt = prod_his_list.get(i).getPause_start_dt_tm();
				}
				if (prod_his_list.get(i).getPause_end_dt_tm().trim().length() != 0) {
					pause_end_dt = prod_his_list.get(i).getPause_end_dt_tm();
					// 비가동 시간 합 연산...
					String ntcod_start_dt = "20" + (pause_start_dt.replace(":", "-").replace(" ","-"));
					String ntcod_end_dt = "20" + (pause_end_dt.replace(":", "-").replace(" ", "-"));
					String[] s_date_arr = ntcod_start_dt.split("-");
					String[] e_date_arr = ntcod_end_dt.split("-");

					Calendar date1 = Calendar.getInstance();
					Calendar date2 = Calendar.getInstance();

					date1.set(Integer.parseInt(s_date_arr[0]),
							Integer.parseInt(s_date_arr[1]),
							Integer.parseInt(s_date_arr[2]),
							Integer.parseInt(s_date_arr[3]),
							Integer.parseInt(s_date_arr[4]),
							Integer.parseInt(s_date_arr[5]));

					date2.set(Integer.parseInt(e_date_arr[0]),
							Integer.parseInt(e_date_arr[1]),
							Integer.parseInt(e_date_arr[2]),
							Integer.parseInt(e_date_arr[3]),
							Integer.parseInt(e_date_arr[4]),
							Integer.parseInt(e_date_arr[5]));

					long minute = (date2.getTimeInMillis() - date1.getTimeInMillis()) / 60000;

					String m_cnt = prod_his_list.get(i).getMember_cnt();
					if(m_cnt == null ) {
						m_cnt = "1";
					}
					minute = minute * Long.parseLong(m_cnt);
					
					p_total_minute = p_total_minute + minute;
				}
			}

			long real_total_time = total_minute - p_total_minute;

			
			System.out.println("작업시작일자 ::: " + isdd);
			System.out.println("작업시작시간 ::: " + isdz);
			System.out.println("작업완료일자 ::: " + iedd);
			System.out.println("작업완료시간 ::: " + iedz);
			System.out.println("투입공수 ::: " + total_minute);
			System.out.println("비가동시간 합 ::: " + p_total_minute);
			System.out.println("실제 가동시간 ::: " + real_total_time);
			*//******** 비가동 시간 합 : End *********//*
					
			*//******** detail 데이터로 it_pp006 작성 : start *********//*
			it_pp006.appendRows(1);

			
			it_pp006.setValue("AUFNR", prodOrdTbl_list.get(0).getPordno());
			it_pp006.setValue("VORNR", prodOrdTbl_list.get(0).getPordno_child());
			it_pp006.setValue("WERKS", prodOrdTbl_list.get(0).getDept_cd());
			
			it_pp006.setValue("AUFNR", pordno);
			it_pp006.setValue("VORNR", pordno_child);
			it_pp006.setValue("WERKS", dept_cd);
			it_pp006.setValue("LMNGA", pdqty);
			it_pp006.setValue("MEINS", "EA");
			it_pp006.setValue("BUDAT", strToday);
			it_pp006.setValue("ISDD", isdd); // 작업시작일자
			it_pp006.setValue("ISDZ", isdz); // 작업시작시간
			it_pp006.setValue("IEDD", iedd); // 작업완료일자
			it_pp006.setValue("IEDZ", iedz); // 작업완료시간
			it_pp006.setValue("ARBID", wkctr); // 작업장
			it_pp006.setValue("ISM01", real_total_time); // 투입공수
			it_pp006.setValue("ILE01", "MIN"); // 단위
			it_pp006.setValue("ISM02", real_total_time);
			it_pp006.setValue("ILE02", "MIN");
			it_pp006.setValue("ISM03", real_total_time);
			it_pp006.setValue("ILE03", "MIN");
			it_pp006.setValue("ISM04", real_total_time);
			it_pp006.setValue("ILE04", "MIN");
			it_pp006.setValue("ISM05", real_total_time);
			it_pp006.setValue("ILE05", "MIN");
			it_pp006.setValue("ISM06", real_total_time);
			it_pp006.setValue("ILE06", "MIN");

			*//******** detail 데이터로 it_pp006 작성 : end *********//*

			// == Setting RFC Parameter ===================================
			System.out.println(it_pp006);
			function.getImportParameterList().setValue("IV_IF", "X");
			function.getTableParameterList().setValue("IT_PP006", it_pp006);
			// == Return Value Mapping ===================================
			connect.executeFunction(function);

			String zifsta ="-";
			String zifmsg ="-";
			
			JCoTable ettbl = function.getTableParameterList().getTable("ET_OUTPUT");
			for (int i = 0; i < ettbl.getNumRows(); i++, ettbl.nextRow()) {
				zifsta = ettbl.getString("ZIFSTA");
				zifmsg = ettbl.getString("ZIFMSG");
			}
			
			logVo.setBatch_result("S");
			logVo.setBatch_description(zifmsg + "(" + pordno + ")");
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");

			System.out.println(resultData.toJSONString());
		} catch (Exception e) {
			logVo.setBatch_result("F");
			logVo.setBatch_description(e.toString());
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
			e.printStackTrace();
		} finally {
			logVo.setBatch_end_dt(StringUtil.getDateTime());
			logStatusDAO.insertLogStatus(logVo);
		}
		return resultData;

	}*/
	
	@SuppressWarnings("unchecked")
	public JSONObject ziffm_mes_pp009(String funcName, String pordno,
		String pordno_pop, String routing_no) {
		JSONObject resultData = new JSONObject();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		LogStatusVo logVo = new LogStatusVo();
		try {
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:ZIFFM_MES_PP009");
			logVo.setBatch_target_ds("-");
			logVo.setBatch_type("M");
			logVo.setBatch_action("U");
			
			// get table from RFC
			JCoTable it_pp006 = function.getTableParameterList().getTable("IT_PP006");
			//string to json list
			
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
//			Calendar c1 = Calendar.getInstance();
//			String strToday = sdf.format(c1.getTime());
			
			//String strToday = "20171020";
			
//			SimpleDateFormat dateFormat = new SimpleDateFormat("YYYYMMddHHmm");
			// //////////////////////////////////////////////////////////////////////////
			// Calendar date1 = Calendar.getInstance();
			// Calendar date2 = Calendar.getInstance();
			//
			// date1.set(2017, 9, 10, 12, 0, 0);
			// date2.set(2017, 9, 11, 12, 0, 0);
			//
			// long difference = (date2.getTimeInMillis() -
			// date1.getTimeInMillis())/60000;
			//
			// System.out.println("그 날(date2)부터 이 날(date1)까지 " + difference
			// +" 분이 지났습니다");
			// //////////////////////////////////////////////////////////////////////////
			logVo.setBatch_result("S");
			logVo.setBatch_description("");
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");
			
			System.out.println(resultData.toJSONString());
		} catch (Exception e) {
			logVo.setBatch_result("F");
			logVo.setBatch_description(e.toString());
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
			e.printStackTrace();
		}
		return resultData;
		
	}

	@SuppressWarnings("unchecked")
	public JSONObject zmmfm_goodsmvt_cancel(SYQmVo sVo, String func_name) {
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		try {
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo);
			JCoFunction function = connect.getFunction(func_name);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			/* == Setting RFC Parameter =================================== */
			sVo.getJstr();
			JSONParser paser = new JSONParser();
			JSONArray jarr;
			try {
				jarr = (JSONArray) paser.parse(sVo.getJstr());
				
				JSONObject jobj = (JSONObject)jarr.get(0);
				Object[] keyarr = jobj.keySet().toArray();
				
				//한건 단위로 처리함...
	        	 for(int j = 0 ; j < keyarr.length; j ++) {
	        		 String nKey = keyarr[j].toString();
					 String nValue = (jobj.get(nKey) == null)?"":jobj.get(nKey).toString();
						
	        		 if(("iv_materialdocument").equals(nKey)) {
	        			 function.getImportParameterList().setValue("IV_MATERIALDOCUMENT", nValue);
	        		 } else if(("iv_matdocumentyear").equals(nKey)) {
	        			 function.getImportParameterList().setValue("IV_MATDOCUMENTYEAR", nValue);
	        		 } else if(("iv_goodsmvt_pstng_date").equals(nKey)) {
	        			 function.getImportParameterList().setValue("IV_GOODSMVT_PSTNG_DATE", nValue);
	        		 } else if(("iv_documentheader_text").equals(nKey)) {
	        			 function.getImportParameterList().setValue("IV_DOCUMENTHEADER_TEXT", nValue);
	        		 }   			  
	        	 }
			} catch (ParseException e) {
				e.printStackTrace();
			}

			/* == Return Value Mapping =================================== */
			LogStatusVo logVo = new LogStatusVo();
			try {
				logVo.setCreator("system");
				logVo.setUpdater("system");
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:" + func_name);
				logVo.setBatch_target_ds("-");
				logVo.setBatch_type("M");
				logVo.setBatch_action("U");

				connect.executeFunction(function);

				JSONObject resultObj = new JSONObject();
				
				System.out.println("@@@@@@@@@@@@@@파라미터값@@@@@@@@@@@@@@");
				System.out.println("자재문서번호 :: "+ function.getImportParameterList().getValue("IV_MATERIALDOCUMENT"));
				System.out.println("자재문서연도 :: "+ function.getImportParameterList().getValue("IV_MATDOCUMENTYEAR"));
				System.out.println("전표의 전기일 :: "+ function.getImportParameterList().getValue("IV_GOODSMVT_PSTNG_DATE"));
				System.out.println("@@@@@@@@@@@@@@파라미터값@@@@@@@@@@@@@@");
				System.out.println("@@@@@@@@@@@@@@리턴값@@@@@@@@@@@@@@");
				System.out.println("EV_MBLNR :: " + function.getExportParameterList().getString("EV_MBLNR"));
				System.out.println("EV_MJAHR :: " + function.getExportParameterList().getString("EV_MJAHR"));
				System.out.println("EV_STATUS :: " + function.getExportParameterList().getString("EV_STATUS"));
				System.out.println("EV_MESSAGE :: " + function.getExportParameterList().getString("EV_MESSAGE"));
				System.out.println("@@@@@@@@@@@@@@리턴값@@@@@@@@@@@@@@");
				
				resultObj.put("ev_mblnr", function.getExportParameterList().getString("EV_MBLNR"));				//자재 문서 번호
				resultObj.put("ev_mjahr", function.getExportParameterList().getString("EV_MJAHR"));					//자재 문서 연도
				resultObj.put("ev_status", function.getExportParameterList().getString("EV_STATUS"));				//단일 문자 표시
				resultObj.put("ev_message", function.getExportParameterList().getString("EV_MESSAGE"));		//메시지 텍스트
				
				listDataJArray.add(resultObj);

				logVo.setBatch_result("S");
				logVo.setBatch_description("");
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");

			} catch (Exception ex) {
				logVo.setBatch_result("F");
				logVo.setBatch_description(ex.toString());
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				ex.printStackTrace();
			} finally {
				logVo.setBatch_end_dt(StringUtil.getDateTime());
				logStatusDAO.insertLogStatus(logVo);
			}
			resultData.put("rows", listDataJArray);

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}
	
	@SuppressWarnings("unchecked")
	public JSONObject zsdfm_deliv_change(List<SYShipmentVo> hList, List<SYShipmentSernrVo> voList, String func_name, String if_flag) {
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		try {
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo);
			JCoFunction function = connect.getFunction(func_name);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			
			JCoTable it_lips = function.getTableParameterList().getTable("IT_LIPS");

			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar c1 = Calendar.getInstance();
			String strToday = sdf.format(c1.getTime());
			
			it_lips.appendRows(voList.size());
			
			// set Table : import data
			for( SYShipmentVo hVo : hList ){
				String vbeln = hVo.getVbeln();
				String posnr = hVo.getPosnr();
				for ( SYShipmentSernrVo vo : voList) {
					if( vbeln.equals(vo.getVbeln()) && posnr.equals(vo.getPosnr()) ){
						it_lips.setValue("VBELN", vbeln);
						it_lips.setValue("POSNR", posnr);
						if( "V001".equals(hVo.getSernp()) ) {
							it_lips.setValue("SERNR", vo.getSernr());
						}else {
							it_lips.setValue("SERNR", "");	
						}
						it_lips.setValue("IF_FLAG", if_flag);
						it_lips.setValue("WADAT_IST", strToday);
						it_lips.setValue("LFART", hVo.getLfart());
						it_lips.setValue("VTEXT_LFART", hVo.getVtext_lfart());
						it_lips.setValue("VSTEL", hVo.getVstel());
						it_lips.setValue("VTEXT_VSTEL", hVo.getVtext_vstel());
						it_lips.setValue("WERKS", hVo.getWerks());
						it_lips.setValue("NAME1_WERKS", hVo.getName1_werks());
						it_lips.setValue("LGORT", hVo.getLgort());
						it_lips.setValue("LGOBE", hVo.getLgobe());
						it_lips.setValue("MATNR", hVo.getMatnr());
						it_lips.setValue("ARKTX", hVo.getArktx());
						if( "V001".equals(hVo.getSernp()) ) {
							it_lips.setValue("LFIMG", "1");
						}else {
							it_lips.setValue("LFIMG", hVo.getLfimg());
						}
						it_lips.setValue("VRKME_DO", hVo.getVrkme_do());
						it_lips.setValue("VKORG", hVo.getVkorg());
						it_lips.setValue("VTEXT_VKORG", hVo.getVtext_vkorg());
						it_lips.setValue("VTWEG", hVo.getVtweg());
						it_lips.setValue("VTEXT_VTWEG", hVo.getVtext_vtweg());
						it_lips.setValue("SPART", hVo.getSpart());
						it_lips.setValue("VTEXT_SPART", hVo.getVtext_spart());
						it_lips.setValue("VKBUR", hVo.getVkbur());
						it_lips.setValue("BEZEI_VKBUR", hVo.getBezei_vkbur());
						it_lips.setValue("VKGRP", hVo.getVkgrp());
						it_lips.setValue("BEZEI_VKGRP", hVo.getBezei_vkgrp());
						it_lips.setValue("VGBEL", hVo.getVgbel());
						it_lips.setValue("VGPOS", hVo.getVgpos());
						it_lips.setValue("SERNP", hVo.getSernp());
						it_lips.setValue("STRGR", hVo.getStrgr());

						it_lips.nextRow();
					}
				}
			}
			
			LogStatusVo logVo = new LogStatusVo();
			try {
				logVo.setCreator("system");
				logVo.setUpdater("system");
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:" + func_name);
				logVo.setBatch_target_ds("-");
				logVo.setBatch_type("M");
				logVo.setBatch_action("U");

				System.out.println(it_lips.toString());
				// == Setting RFC Parameter ===================================
				function.getImportParameterList().setValue("IV_ACTION", "2");	
				function.getTableParameterList().setValue("IT_LIPS", it_lips);
				// == Return Value Mapping ===================================
				connect.executeFunction(function);

				JSONObject resultObj = new JSONObject();

				resultObj.put("ev_status", function.getExportParameterList().getString("EV_STATUS"));		//단일 문자 표시
				resultObj.put("ev_message", function.getExportParameterList().getString("EV_MESSAGE"));		//메시지 텍스트
				
				System.out.println("################################");
				System.out.println("ev_status ::: " + function.getExportParameterList().getString("EV_STATUS"));
				System.out.println("ev_message ::: " + function.getExportParameterList().getString("EV_MESSAGE"));

				listDataJArray.add(resultObj);

				logVo.setBatch_result("S");
				logVo.setBatch_description("");
				
				resultData.put("ev_status", function.getExportParameterList().getString("EV_STATUS"));
				resultData.put("ev_message", function.getExportParameterList().getString("EV_MESSAGE"));
				
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");

			} catch (Exception ex) {
				logVo.setBatch_result("F");
				logVo.setBatch_description(ex.toString());
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				ex.printStackTrace();
			} finally {
				logVo.setBatch_end_dt(StringUtil.getDateTime());
				logStatusDAO.insertLogStatus(logVo);
			}
			resultData.put("rows", listDataJArray);

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}

	@SuppressWarnings("unchecked")
	public JSONObject zmmfm_goodsmvt_gi(String funcName, JSONObject header_jobj, JSONArray item_jarr, JSONArray sernr_jarr) {
		JSONObject resultData = new JSONObject();
//		JSONArray listDataJArray = new JSONArray();
//		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);

		LogStatusVo logVo = new LogStatusVo();

		JCoFunction function = null;

		try {
			function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}

			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("zmmfm_goodsmvt_gi");
			logVo.setBatch_target_ds("-");
			logVo.setBatch_type("M");
			logVo.setBatch_action("U");

			// get table from RFC
			JCoTable it_item = function.getTableParameterList().getTable("IT_ITEM");
			JCoTable it_serial = function.getTableParameterList().getTable("IT_SERIAL");

			// string to json list
			
			
			JSONObject jOb_h = (JSONObject) header_jobj;
			
			String ref_doc_no = (String) jOb_h.get("ref_doc_no");
			String pstng_date = (String) jOb_h.get("pstng_date");
			String doc_date = (String) jOb_h.get("doc_date");
			String header_txt = (String) jOb_h.get("header_txt");
			
			
			JSONObject jOb = (JSONObject) item_jarr.get(0);
			Object[] keyArr = jOb.keySet().toArray();
			it_item.appendRows(item_jarr.size());
			for (int idx = 0; idx < item_jarr.size(); idx++) {
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject) item_jarr.get(idx);

				// set Table : import data
				for (Object key : keyArr) {
					String nKey = key.toString();
					System.out.println("@@@nKey@@@@@ :: " + nKey);
					
					String nValue = "";
					if(jObj.get(nKey) == null) {
						nValue = "";
					} else {
						nValue = jObj.get(nKey).toString();
					}
//					String nValue = jObj.get(nKey).toString();

					System.out.println("@@@nValue@@@@@ :: " + nValue);

					if ("matdoc_itm".equals(nKey)) {
						it_item.setValue("MATDOC_ITM", nValue);
					} else if ("material".equals(nKey)) {
						it_item.setValue("MATERIAL", nValue);
					} else if ("move_type".equals(nKey)) {
						it_item.setValue("MOVE_TYPE", nValue);
					} else if ("plant".equals(nKey)) {
						it_item.setValue("PLANT", nValue);
					} else if ("stge_loc".equals(nKey)) {
						it_item.setValue("STGE_LOC", nValue);
					} else if ("reserv_no".equals(nKey)) {
						it_item.setValue("RESERV_NO", nValue);
					} else if ("res_item".equals(nKey)) {
						it_item.setValue("RES_ITEM", nValue);
					} else if ("costcenter".equals(nKey)) {
						it_item.setValue("COSTCENTER", nValue);
					} else if ("orderid".equals(nKey)) {
						it_item.setValue("ORDERID", nValue);
					} else if ("entry_qnt".equals(nKey)) {
						it_item.setValue("ENTRY_QNT", nValue);
					} else if ("entry_uom".equals(nKey)) {
						it_item.setValue("ENTRY_UOM", nValue);
					} else if ("gr_rcpt".equals(nKey)) {
						it_item.setValue("GR_RCPT", nValue);
					} else if ("item_text".equals(nKey)) {
						it_item.setValue("ITEM_TEXT", nValue);
					}
					
				}
				it_item.nextRow();

			}

			if(sernr_jarr.size() > 0 ) {
				JSONObject jOb_1 = (JSONObject) sernr_jarr.get(0);
				Object[] keyArr_1 = jOb_1.keySet().toArray();
				it_serial.appendRows(sernr_jarr.size());
				for (int idx = 0; idx < sernr_jarr.size(); idx++) {
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject) sernr_jarr.get(idx);
	
					// set Table : import data
					for (Object key : keyArr_1) {
						String nKey = key.toString();
						
						String nValue = "";
						if(jObj.get(nKey) == null) {
							nValue = "";
						} else {
							nValue = jObj.get(nKey).toString();
						}
	
						if ("matdoc_itm".equals(nKey)) {
							it_serial.setValue("MATDOC_ITM", nValue);
						} else if ("serialno".equals(nKey)) {
							it_serial.setValue("SERIALNO", nValue);
						}
					}
					it_serial.nextRow();
				}
			}
			// == Setting RFC Parameter ===================================
						
			function.getImportParameterList().setValue("IV_REF_DOC_NO", ref_doc_no);
			function.getImportParameterList().setValue("IV_PSTNG_DATE", pstng_date);
			function.getImportParameterList().setValue("IV_DOC_DATE", doc_date);
			function.getImportParameterList().setValue("IV_HEADER_TXT", header_txt);
			
			function.getTableParameterList().setValue("IT_ITEM", it_item);
			function.getTableParameterList().setValue("IT_SERIAL", it_serial);
			// == Return Value Mapping ===================================

			System.out.println("##################################################################");
			System.out.println("ref_doc_no :: " + ref_doc_no);
			System.out.println("pstng_date :: " + pstng_date);
			System.out.println("doc_date :: " + doc_date);
			System.out.println("header_txt :: " + header_txt);
			System.out.println(it_item);
			System.out.println(it_serial);
			System.out.println("##################################################################");
			
			connect.executeFunction(function);
			logVo.setBatch_result("S");
			logVo.setBatch_description("");

			
			
		} catch (Exception e) {
			logVo.setBatch_result("F");
			logVo.setBatch_description(e.toString());
			e.printStackTrace();
		} finally {
			resultData.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
			resultData.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));
			resultData.put("ev_ref_doc_no", function.getExportParameterList().getString("EV_REF_DOC_NO"));
			resultData.put("ev_mblnr", function.getExportParameterList().getString("EV_MBLNR"));
			resultData.put("ev_mjahr", function.getExportParameterList().getString("EV_MJAHR"));
			logVo.setBatch_end_dt(StringUtil.getDateTime());
			logStatusDAO.insertLogStatus(logVo);
		}

		return resultData;
	}
	
	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject ZMMFM_ETC_MASTER() {

		System.out.println( "cost & movetype & io 정보 rfc service 시작 ");

	 
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
 
		int result1 = 0;
		int result2 = 0;
		int result3 = 0;
		int result4 = 0;

		try {
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo);
			JCoFunction function = connect.getFunction("ZMMFM_ETC_MASTER");
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
 
			LogStatusVo logVo = new LogStatusVo();

			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:" + "ZMMFM_ETC_MASTER");
			logVo.setBatch_target_ds("sloc_master");
			logVo.setBatch_type("M");
			logVo.setBatch_action("U");
 
			connect.executeFunction(function);
 
			JCoTable et_t001l = function.getTableParameterList().getTable("ET_T001L");
			System.out.println(et_t001l);    //sloc_master   (저장위치 마스터)   SYSlocMasterVo
			
			JCoTable et_cskt = function.getTableParameterList().getTable("ET_CSKT");
			System.out.println(et_cskt);    //cost_type_tbl  (코스트센터 마스터)  SYCostTypeVo
 
			JCoTable et_aufk = function.getTableParameterList().getTable("ET_AUFK");
			System.out.println(et_aufk);    //io_type_tbl    (오더 마스터)      SYIoTypeVo
 
			JCoTable et_t156t = function.getTableParameterList().getTable("ET_T156T");
			System.out.println(et_t156t);    //move_type_tbl (이동유형 마스터 )   SYMoveTypeVo
 

			for (int i = 0; i < et_t001l.getNumRows(); i++) {
				et_t001l.setRow(i);
				
				//sloc_master  저장위치 마스터 
 
			    SYSlocMasterVo pVo = new SYSlocMasterVo();

				pVo.setWerks(et_t001l.getString("WERKS"));
				pVo.setLgort(et_t001l.getString("LGORT"));
				pVo.setLgobe(et_t001l.getString("LGOBE"));
		 
				
				result1 = mesDAO.insert_sloc_master(pVo);
			}

			for (int i = 0; i < et_cskt.getNumRows(); i++) {
				et_cskt.setRow(i);
				
				//cost_type_tbl  (코스트센터 마스터)  SYCostTypeVo
 
				SYCostTypeVo pVo = new SYCostTypeVo();

				pVo.setKokrs(et_cskt.getString("KOKRS"));
				
				int num = Integer.parseInt(et_cskt.getString("KOSTL"));
				 
				 
				pVo.setKostl( String.valueOf(num));
				pVo.setDatbi(et_cskt.getString("DATBI"));
				pVo.setKtext(et_cskt.getString("KTEXT"));
				 
				
				result2 = mesDAO.insert_cost_type_tbl(pVo);
			}
			
			for (int i = 0; i < et_aufk.getNumRows(); i++) {
				et_aufk.setRow(i);
				
				 //io_type_tbl    (오더 마스터)      SYIoTypeVo
 
				SYIoTypeVo pVo = new SYIoTypeVo();
				
//				int num = Integer.parseInt(et_aufk.getString("AUFNR"));

//				pVo.setAufnr(String.valueOf(num));
				pVo.setAufnr(et_aufk.getString("AUFNR"));
				pVo.setAuart(et_aufk.getString("AUART"));
				pVo.setKtext(et_aufk.getString("KTEXT"));
				pVo.setBukrs(et_aufk.getString("BUKRS"));
				pVo.setWerks(et_aufk.getString("WERKS"));
				pVo.setLoekz(et_aufk.getString("LOEKZ"));
				 
				
				result3 = mesDAO.insert_io_type_tbl(pVo);
			}
			
			for (int i = 0; i < et_t156t.getNumRows(); i++) {
				et_t156t.setRow(i);
				
				 //move_type_tbl (이동유형 마스터 )   SYMoveTypeVo
 
				SYMoveTypeVo pVo = new SYMoveTypeVo();

				pVo.setBwart(et_t156t.getString("BWART"));
				pVo.setBtext(et_t156t.getString("BTEXT"));
				pVo.setKostl(et_t156t.getString("KOSTL"));
				pVo.setAufnr(et_t156t.getString("AUFNR"));
 	
				result4 = mesDAO.insert_move_type_tbl(pVo);
			}
			
			
			JSONObject resultObj = new JSONObject();
			 
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");
			 

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}

		return resultData;
	}

	@SuppressWarnings("unchecked")
	public JSONObject zmmfm_goodsmvt_st_1(String funcName, String item_tbl, String sernr_tbl, String conf_date) {
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);
		LogStatusVo logVo = new LogStatusVo();
		try {
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:ZMMFM_GOODSMVT_ST");
			logVo.setBatch_target_ds("-");
			logVo.setBatch_type("M");
			logVo.setBatch_action("U");

			// get table from RFC
			JCoTable itemTable = function.getTableParameterList().getTable("IT_ITEM");
			JCoTable senrTable = function.getTableParameterList().getTable("IT_SERIAL");
			// string to json list
			
			/******** itemTable 데이터 list 만들기 : start *********/
			List<SYSernrManageVo> item_tbl_list = new ArrayList<SYSernrManageVo>();
			listDataJArray = (JSONArray) jsonParser.parse(item_tbl);
			
			if(listDataJArray.size() != 0) {
				JSONObject jOb = (JSONObject)listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();
	
				
				for(int idx=0; idx<listDataJArray.size(); idx++){
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject)listDataJArray.get(idx);
					SYSernrManageVo tmp_sVo = new SYSernrManageVo();
			
					for(Object key : keyArr){
						String nKey = key.toString();
						String nValue =  (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						
						if( "material".equals(nKey) ) tmp_sVo.setMaterial(nValue);
						else if( "move_type".equals(nKey) ) tmp_sVo.setMove_type(nValue);
						else if( "plant".equals(nKey) ) tmp_sVo.setPlant(nValue);
						else if( "stge_loc".equals(nKey) ) tmp_sVo.setStge_loc(nValue);
						else if( "move_mat".equals(nKey) ) tmp_sVo.setMove_mat(nValue);
						else if( "move_plant".equals(nKey) ) tmp_sVo.setMove_plant(nValue);
						else if( "move_stloc".equals(nKey) ) tmp_sVo.setMove_stloc(nValue);
						else if( "entry_qnt".equals(nKey) ) tmp_sVo.setEntry_qnt(nValue);
						else if( "entry_uom".equals(nKey) ) tmp_sVo.setEntry_uom(nValue);
						else if( "gr_rcpt".equals(nKey) ) tmp_sVo.setGr_rcpt(nValue);
						
						////////////////////////////////////////
						else if( "serialno".equals(nKey) ) tmp_sVo.setSerialno(nValue);
					}
					item_tbl_list.add(tmp_sVo);
				}
			}
			/******** itemTable 데이터 list 만들기 : end *********/

			/******** sernrTable 데이터 list 만들기 : start *********/
			List<SYSernrManageVo> sernr_tbl_list = new ArrayList<SYSernrManageVo>();
			listDataJArray = (JSONArray) jsonParser.parse(sernr_tbl);
			
			if(listDataJArray.size() != 0) {
				JSONObject jOb = (JSONObject)listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();

				for(int idx=0; idx<listDataJArray.size(); idx++){
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject)listDataJArray.get(idx);
					SYSernrManageVo tmp_sVo = new SYSernrManageVo();
			
					for(Object key : keyArr){
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						
						if( "material".equals(nKey) ) tmp_sVo.setMaterial(nValue);
						else if( "serialno".equals(nKey) ) tmp_sVo.setSerialno(nValue);
					}
					sernr_tbl_list.add(tmp_sVo);
				}
			}
			/******** sernrTable 데이터 list 만들기 : end *********/
			
			/******** itemTable 작성 : start *********/
			// data size 만큼 itemTable, senrTable row생성
			itemTable.appendRows(item_tbl_list.size());
			senrTable.appendRows(sernr_tbl_list.size());
			
			for (int j = 0; j < item_tbl_list.size(); j++) {
				String matdoc_itm = ("00000"+(j+1)).substring(("00000"+(j+1)).length()-4, ("00000"+(j+1)).length());
				item_tbl_list.get(j).setMatdoc_itm(matdoc_itm);
				
				itemTable.setValue("MATDOC_ITM", item_tbl_list.get(j).getMatdoc_itm());
				itemTable.setValue("MATERIAL", item_tbl_list.get(j).getMaterial());
				itemTable.setValue("MOVE_TYPE", item_tbl_list.get(j).getMove_type());
				itemTable.setValue("PLANT", item_tbl_list.get(j).getPlant());
				itemTable.setValue("STGE_LOC", item_tbl_list.get(j).getStge_loc());
				itemTable.setValue("MOVE_MAT", item_tbl_list.get(j).getMove_mat());
				itemTable.setValue("MOVE_PLANT", item_tbl_list.get(j).getMove_plant());
				itemTable.setValue("MOVE_STLOC", item_tbl_list.get(j).getMove_stloc());
				itemTable.setValue("ENTRY_QNT", item_tbl_list.get(j).getEntry_qnt());
				itemTable.setValue("ENTRY_UOM", item_tbl_list.get(j).getEntry_uom());
				itemTable.setValue("GR_RCPT", item_tbl_list.get(j).getGr_rcpt());
				
				itemTable.nextRow();
				
				if(item_tbl_list.get(j).getSerialno() == null) {
					item_tbl_list.get(j).setSerialno("");
				} 
				if(item_tbl_list.get(j).getSerialno().length() != 0 ) {
					senrTable.setValue("MATDOC_ITM", item_tbl_list.get(j).getMatdoc_itm());
					senrTable.setValue("SERIALNO", item_tbl_list.get(j).getSerialno());
					senrTable.nextRow();
				}
				
			}
			
//			for (int j = 0; j < sernr_tbl_list.size(); j++) {
//				for(int k =0 ; k<item_tbl_list.size(); k++) {
//					if(item_tbl_list.get(k).getMaterial().equals(sernr_tbl_list.get(j).getMaterial())) {
//						senrTable.setValue("MATDOC_ITM", item_tbl_list.get(k).getMatdoc_itm());
//						senrTable.setValue("SERIALNO", sernr_tbl_list.get(j).getSerialno());
//					}
//				}
//				
//				senrTable.nextRow();
//			}
			/******** itemTable 작성 : end *********/

			// == Setting RFC Parameter ===================================
			String newKey = sYScmService.reqm_matnr_tbl_key_select_1();
			function.getImportParameterList().setValue("IV_REF_DOC_NO", newKey);
			function.getImportParameterList().setValue("IV_PSTNG_DATE",conf_date);
			function.getImportParameterList().setValue("IV_DOC_DATE", conf_date);
			function.getTableParameterList().setValue("IT_ITEM", itemTable);
			function.getTableParameterList().setValue("IT_SERIAL", senrTable);

			// == Return Value Mapping ===================================
			System.out.println("#####################################");
			System.out.println(newKey);
			System.out.println(conf_date);
			System.out.println(itemTable);
			System.out.println(senrTable);

			connect.executeFunction(function);

			logVo.setBatch_result("S");
			logVo.setBatch_description("");
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");
 
			
			resultData.put("ev_ref_doc_no", function.getExportParameterList().getString("EV_REF_DOC_NO"));
			resultData.put("ev_mblnr", function.getExportParameterList().getString("EV_MBLNR"));
			resultData.put("ev_mjahr", function.getExportParameterList().getString("EV_MJAHR"));
			
			resultData.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
			resultData.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));
			System.out.println(resultData.toJSONString());
		} catch (Exception e) {
			logVo.setBatch_result("F");
			logVo.setBatch_description(e.toString());
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "RFC FUNC is fail.");
			e.printStackTrace();
		}
		return resultData;
	}
	
	@SuppressWarnings("unchecked")
	public JSONObject zmmfm_sloc_stock_1(String funcName, JSONArray jarr, String werks) {
		System.out.println( " service 시작 "+funcName);
		JSONObject resultData = new JSONObject();
//		JSONArray listDataJArray = new JSONArray();
		
//		int result1 = 0;
//		int result2 = 0;

		ArrayList<String> matnr_list = new ArrayList<String>();
		ArrayList<String> lgort_list = new ArrayList<String>();
		ArrayList<String> werks_list = new ArrayList<String>();
		ArrayList<String> lifnr_list = new ArrayList<String>();
		
		try {
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo);
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}

			/* == Setting RFC Parameter =================================== */
			
			
			if(jarr.size() != 0) {
				JSONObject jOb = (JSONObject)jarr.get(0);
				Object[] keyArr = jOb.keySet().toArray();
	
				
				for(int idx=0; idx<jarr.size(); idx++){
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject)jarr.get(idx);
//					SYStockVo tmp_sVo = new SYStockVo();
			
					for(Object key : keyArr){
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						
						if( "lgort".equals(nKey) ) lgort_list.add(nValue);
						else if( "matnr".equals(nKey) ) matnr_list.add(nValue);
						else if( "werks".equals(nKey) ) werks_list.add(nValue);
						else if( "lifnr".equals(nKey) ) {
							if(nValue.length() != 0) {
								lifnr_list.add(nValue);	
							}
						}
					}
				}
			}
			JCoTable it_matnr = null;
			JCoTable it_lifnr = null;
			JCoTable it_werks = null;

			if(matnr_list.size() != 0) {
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
			
			if(werks != null) {
				it_werks = function.getTableParameterList().getTable("IT_WERKS");
				it_werks.appendRows(1);
				
				it_werks.setRow(0);
				it_werks.setValue("LOW", werks);
				it_werks.setValue("HIGH", werks);
				
				function.getTableParameterList().setValue("IT_WERKS", it_werks);
			}
			
			if(lifnr_list.size() != 0) {
				it_lifnr = function.getTableParameterList().getTable("IT_LIFNR");
				it_lifnr.appendRows(lifnr_list.size());
				for (int i = 0; i < lifnr_list.size(); i++) {
			
					it_lifnr.setRow(i);
					
					it_lifnr.setValue("LOW", (lifnr_list.get(i)).trim());
					it_lifnr.setValue("HIGH", (lifnr_list.get(i)).trim());
					
					it_lifnr.nextRow();
				}
				function.getTableParameterList().setValue("IT_LIFNR", it_lifnr);
			}
						
			/* == Return Value Mapping =================================== */
			System.out.println("*************** sap params********************");
			System.out.println(it_matnr);
			System.out.println(it_werks);
			System.out.println(it_lifnr);
				
			LogStatusVo logVo = new LogStatusVo();

			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("SAP:" + funcName);
			logVo.setBatch_target_ds("shipment_tbl");
			logVo.setBatch_type("M");
			logVo.setBatch_action("U");
 
			connect.executeFunction(function);
 
			JCoTable et_mard = function.getTableParameterList().getTable("ET_MARD");
			JCoTable et_equi = function.getTableParameterList().getTable("ET_EQUI");
			System.out.println(et_mard);
//			System.out.println(et_equi);
			
			JSONArray mard_jarr = new JSONArray();
			JSONArray equi_jarr = new JSONArray();
			
			for (int i = 0; i < et_mard.getNumRows(); i++) {
				et_mard.setRow(i);
				
				JSONObject job = new JSONObject();
				
				job.put("werks", et_mard.getString("WERKS"));
				job.put("lgort", et_mard.getString("LGORT"));
				job.put("lifnr", et_mard.getString("LIFNR"));
				job.put("kunnr", et_mard.getString("KUNNR"));
				job.put("matnr", et_mard.getString("MATNR"));
				job.put("labst", et_mard.getString("LABST"));

				
				mard_jarr.add(job);
			}

			for (int i = 0; i < et_equi.getNumRows(); i++) {
				et_equi.setRow(i);
				
				JSONObject job = new JSONObject();
				
				job.put("b_werk", et_equi.getString("B_WERK"));
				job.put("b_lager", et_equi.getString("B_LAGER"));
				job.put("matnr", et_equi.getString("MATNR"));
				job.put("sernr", et_equi.getString("SERNR"));

				equi_jarr.add(job);
			}
			
			String mard_json = mard_jarr.toJSONString();
			String equi_json = equi_jarr.toJSONString();
			
//			JSONObject resultObj = new JSONObject();
			resultData.put("mard_json", mard_json);
			resultData.put("equi_json", equi_json);
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

	@SuppressWarnings("unchecked")
	public JSONObject ziffm_mes_pp015(String func_name, String iv_werks, String iv_matnr, String iv_sernr) {
		JSONObject resultData = new JSONObject();
//		JSONArray listDataJArray = new JSONArray();
//		JSONParser jsonParser = new JSONParser();
		VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		VmesJcoConnection connect = new VmesJcoConnection(connectVo);

		LogStatusVo logVo = new LogStatusVo();

		JCoFunction function = null;


		try {
			function = connect.getFunction(func_name);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}

			logVo.setCreator("system");
			logVo.setUpdater("system");
			logVo.setBatch_start_dt(StringUtil.getDateTime());
			logVo.setBatch_source_ds("ZIFFM_MES_PP015");
			logVo.setBatch_target_ds("matnr stock location chk");
			logVo.setBatch_type("PR");
			logVo.setBatch_action("U");

			// == Setting RFC Parameter ===================================
						
			function.getImportParameterList().setValue("IV_WERKS", iv_werks);
			function.getImportParameterList().setValue("IV_MATNR", iv_matnr);
			function.getImportParameterList().setValue("IV_SERNR", iv_sernr);
			function.getImportParameterList().setValue("IV_IF", "X");
			
			// == Return Value Mapping ===================================

			
			
			connect.executeFunction(function);
			logVo.setBatch_result("S");
			logVo.setBatch_description("");
			
			String ev_b_lager = "";
			String ev_status = "";
			String ev_message = "";
			
			ev_b_lager = function.getExportParameterList().getString("EV_B_LAGER"); 
			ev_status = function.getExportParameterList().getString("EV_STATUS");
			ev_message = function.getExportParameterList().getString("EV_MESSAGE");
			
			resultData.put("ev_b_lager", ev_b_lager);
			resultData.put("ev_status", ev_status);
			resultData.put("ev_message", ev_message);

			System.out.println("##################################################################");
			System.out.println("IV_WERKS :: " + iv_werks);
			System.out.println("IV_MATNR :: " + iv_matnr);
			System.out.println("IV_SERNR :: " + iv_sernr);
			System.out.println("------------------------------------------");
			System.out.println("EV_B_LAGER :: " + ev_b_lager);
			System.out.println("EV_STATUS :: " + ev_status);
			System.out.println("EV_MESSAGE :: " + ev_message);
			System.out.println("##################################################################");
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("message", "RFC FUNC. is success.");
			
		} catch (Exception e) {
			logVo.setBatch_result("F");
			logVo.setBatch_description(e.toString());
			e.printStackTrace();
		} finally {
			logVo.setBatch_end_dt(StringUtil.getDateTime());
			logStatusDAO.insertLogStatus(logVo);
		}

		return resultData;
	}
}