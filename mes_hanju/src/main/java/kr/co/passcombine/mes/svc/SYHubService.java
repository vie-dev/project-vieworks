package kr.co.passcombine.mes.svc;

//import java.lang.reflect.Field;
//import java.util.ArrayList;
//import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
//import org.json.simple.parser.ParseException;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;

import kr.co.passcombine.mes.vo.SYMemberVo;
import kr.co.passcombine.mes.dao.LogStatusDAO;
import kr.co.passcombine.mes.dao.SYHubDAO;
import kr.co.passcombine.mes.sap.VmesJcoConnectVo;
import kr.co.passcombine.mes.sap.VmesJcoConnection;
//import kr.co.passcombine.mes.util.SessionUtil;
//import kr.co.passcombine.mes.util.ResponseUtils;
//import kr.co.passcombine.mes.util.SessionUtil;
import kr.co.passcombine.mes.util.StringUtil;
import kr.co.passcombine.mes.vo.LogStatusVo;
import kr.co.passcombine.mes.vo.SYDmrFwVo;
import kr.co.passcombine.mes.vo.SYDmrMasterVo;
import kr.co.passcombine.mes.vo.SYDmrPbaVo;
//import kr.co.passcombine.mes.vo.SYFileVo;
import kr.co.passcombine.mes.vo.SYHubBomVo; 
import kr.co.passcombine.mes.vo.SYHubRevInsMasVo;
import kr.co.passcombine.mes.vo.SYHubRevInsCliVo;
import kr.co.passcombine.mes.vo.SYHubRoutingDetailVo;
import kr.co.passcombine.mes.vo.SYHubRoutingHeaderVo;
//import kr.co.passcombine.mes.vo.SYLineVo;
//import kr.co.passcombine.mes.vo.SYProdVo;
import kr.co.passcombine.mes.vo.SYReqmMatnrTblVo;
//import kr.co.passcombine.mes.vo.SYScmRawSernrVo;
//import kr.co.passcombine.mes.vo.SYSernrManageVo;
//import kr.co.passcombine.mes.vo.SYHubItnbrVo;
//import kr.co.passcombine.mes.vo.SYMenuVo;
//import kr.co.passcombine.mes.vo.SYMesVo;
//import kr.co.passcombine.mes.vo.SYPoRequirementVo;
//import kr.co.passcombine.mes.vo.SYProdVo;
//import kr.co.passcombine.mes.vo.SYScmRawDeliveryVo;
import kr.co.passcombine.mes.vo.SYVendorVo;
import kr.co.passcombine.mes.vo.SYHubRecvinspeVo;


@Service(value = "vmesHubService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYHubService {

	// private static final Logger logger = LoggerFactory.getLogger(SYCodeService.class);
	@Resource
	private Environment environment;
	
	@Resource(name = "vmesHubDAO")
	private SYHubDAO hubDAO;
	
	@Resource(name = "vmesLogStatusDAO")
	private LogStatusDAO logStatusDAO;
	
	@Transactional
	public List<SYHubRevInsMasVo> qualityMaster_select(SYHubRevInsMasVo hubVo){
		return hubDAO.qualityMaster_select(hubVo);
	}

	@Transactional
	public List<SYHubRevInsCliVo> qualityDetail_select(SYHubRevInsCliVo hubVo){
		return hubDAO.qualityDetail_select(hubVo);
	}
	
	/*@Transactional
	public List<SYHubRevInsCliVo> qualityDetailTest_select(SYHubRevInsCliVo hubVo){
		return hubDAO.qualityDetailTest_select(hubVo);
	}*/
	
	/*@Transactional
	public List<SYHubRoutingHeaderVo> routingHeader_select(SYHubRoutingHeaderVo hubRVo){
		return hubDAO.routingHeader_select(hubRVo);
	}*/

	/*@Transactional
	public List<SYHubRoutingHeaderVo> routingHeaderItem_select(SYHubRoutingHeaderVo hubRVo){
		return hubDAO.routingHeaderItem_select(hubRVo);
	}*/
	
	//material_recv_master_select_count
	/*@Transactional
	public int routingDetail_select_count(SYZmmfmMatMasterVo hubDVo){
		return hubDAO.routingDetail_select_count(hubDVo);
	}*/
	
	/*@Transactional
	public List<SYZmmfmMatMasterVo> routingDetail_select(SYZmmfmMatMasterVo hubDVo){
		return hubDAO.routingDetail_select(hubDVo);
	}*/
	/*
	@Transactional
	public List<SYZmmfmMatMasterVo> material_recv_master_select(SYZmmfmMatMasterVo sVo){
		return hubDAO.material_recv_master_select(sVo);
	}
	
	@Transactional
	public int material_recv_master_select_count(SYZmmfmMatMasterVo sVo){
		return hubDAO.material_recv_master_select_count(sVo);
	}
	*/
	/*@Transactional
	public List<SYZmmfmMatMasterVo> routing_material_recv_master_select(SYZmmfmMatMasterVo sVo){
		return hubDAO.routing_material_recv_master_select(sVo);
	}*/
	/*
	@Transactional
	public int routing_material_recv_master_select_count(SYZmmfmMatMasterVo sVo){
		return hubDAO.routing_material_recv_master_select_count(sVo);
	}*/
	
	public int selectCustomerMemberCount(SYMemberVo custMemberVo){
		return hubDAO.selectCustomerMemberCount(custMemberVo);
	}
	public List<SYMemberVo> selectCustomerMember(SYMemberVo custMemberVo){
		return hubDAO.selectCustomerMember(custMemberVo);
	}
	public SYMemberVo selectCustomerMemberInfo(SYMemberVo custMemberVo){
		return hubDAO.selectCustomerMemberInfo(custMemberVo);
	}
	
	@Transactional
	public List<SYHubRecvinspeVo> rinspectionheader_select(SYHubRecvinspeVo hubRVo){
		return hubDAO.rinspectionheader_select(hubRVo);
	}
	
	@Transactional
	public List<SYHubRecvinspeVo> rinspectionItem_select(SYHubRecvinspeVo hubRVo){
		return hubDAO.rinspectionItem_select(hubRVo);
	}
	
	public int searchInspectionMatnr_count(SYHubRecvinspeVo hubDVo){
		return hubDAO.searchInspectionMatnr_count(hubDVo);
	}
	
	
	@Transactional
	public List<SYHubRecvinspeVo> searchInspectionMatnr(SYHubRecvinspeVo hubRVo){
		return hubDAO.searchInspectionMatnr(hubRVo);
	}
	
	@Transactional
	public int routingHeader_insert(SYHubRoutingHeaderVo hubHVo){
//		int result = hubDAO.deleteMenuRole(menuVo);
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();
		int result = 0;
		try{
			listDataJArray = (JSONArray) jsonParser.parse(hubHVo.getGridData());
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();
			// by group insert
			hubHVo.setRouting_gno(hubDAO.getRoutingGroupNo());
			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray.get(idx);
				hubHVo.setRouting_no(hubDAO.getRoutingNo());
				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue =  (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					if( "routing_gubun".equals(nKey) )
						hubHVo.setRouting_gubun(nValue);
					else if( "routing_code".equals(nKey) )
						hubHVo.setRouting_code(nValue);
					else if( "routing_dscr".equals(nKey) )
						hubHVo.setRouting_dscr(nValue);
				}
				result = hubDAO.routingHeader_insert(hubHVo);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}

//	@Transactional					//수정중
//	public int material_send_master_insert(ArrayList<E> sVolist){
//			
//	}
	@Transactional
	public int routingHeaderItem_insert(SYHubRoutingHeaderVo hubHVo){
//		int result = hubDAO.deleteMenuRole(menuVo);
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();
		int result = 0;
		try{
			listDataJArray = (JSONArray) jsonParser.parse(hubHVo.getGridData());
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();
			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray.get(idx);
				hubHVo.setRouting_no(hubDAO.getRoutingNo());
				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue =  (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					if( "routing_gubun".equals(nKey) )
						hubHVo.setRouting_gubun(nValue);
					else if( "routing_code".equals(nKey) )
						hubHVo.setRouting_code(nValue);
					else if( "routing_dscr".equals(nKey) )
						hubHVo.setRouting_dscr(nValue);
				}
				result = hubDAO.routingHeaderItem_insert(hubHVo);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}
	
	@Transactional
	public int routingHeaderItem_update(SYHubRoutingHeaderVo hubHVo){
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();
		int result = 0;
		try{
			listDataJArray = (JSONArray) jsonParser.parse(hubHVo.getGridData());
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();
 
			for(int idx=0; idx<listDataJArray.size(); idx++){
				SYHubRoutingHeaderVo tmpVo = new SYHubRoutingHeaderVo();
				tmpVo.setRouting_gno(hubHVo.getRouting_gno());
				tmpVo.setUpdater(hubHVo.getUpdater());
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray.get(idx);
//				hubHVo.setRouting_no(hubDAO.getRoutingNo());
				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					if( "routing_gubun".equals(nKey) )
						tmpVo.setRouting_gubun(nValue);
					else if( "routing_code".equals(nKey) )
						tmpVo.setRouting_code(nValue);
					else if( "routing_dscr".equals(nKey) )
						tmpVo.setRouting_dscr(nValue);
					else if( "routing_no".equals(nKey) )
						tmpVo.setRouting_no(nValue);
				}
//				System.out.println(tmpVo.getRouting_code());
//				System.out.println(tmpVo.getRouting_gubun());
//				System.out.println(tmpVo.getRouting_dscr());
				result = hubDAO.routingHeaderItem_update(tmpVo);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}
	
	@Transactional
	public int routingDetail_insert(SYHubRoutingDetailVo hubDVo){
//		int result = hubDAO.deleteMenuRole(menuVo);
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();
		int result = 0;
		try{
			listDataJArray = (JSONArray) jsonParser.parse(hubDVo.getGridData());
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();
			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray.get(idx); 
				for(Object key : keyArr){
					String nKey = key.toString();
				//	String nValue =  jObj.get(nKey).toString();
					
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					
					if( "matnr".equals(nKey) )
						hubDVo.setMatnr(nValue);
					else if( "maktx".equals(nKey) )
						hubDVo.setMaktx(nValue);
				}
				result = hubDAO.routingDetail_insert(hubDVo);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}

	@Transactional
	public int routingHeaderItem_count(SYHubRoutingHeaderVo hubDVo){
		return hubDAO.routingHeaderItem_count(hubDVo);
	}

	@Transactional
	public int routingDetailItem_count(SYHubRoutingDetailVo hubDVo){
		return hubDAO.routingDetailItem_count(hubDVo);
	}

	@Transactional
	public int routingHeaderGroup_delete(SYHubRoutingHeaderVo hubDVo){
		return hubDAO.routingHeaderGroup_delete(hubDVo);
	}
	
	@Transactional
	public int routingHeaderItem_delete(SYHubRoutingHeaderVo hubDVo){
		return hubDAO.routingHeaderItem_delete(hubDVo);
	}
	
	@Transactional
	public int routingHeaderItem_delete_1(SYHubRoutingHeaderVo hubDVo){
		return hubDAO.routingHeaderItem_delete_1(hubDVo);
	}
	
	/*@Transactional
	public int routingDetail_delete(SYHubRoutingDetailVo hubDVo){
		return hubDAO.routingDetail_delete(hubDVo);
	}*/
	
	@SuppressWarnings("unchecked")
	public JSONObject fn_ZIFFM_MES_PP002(String func_name, String iv_matnr, String iv_date, String iv_werks, String iv_if) {
	 
//		List<SYHubBomVo> listCode = null;
//		SYHubBomVo pVo = new SYHubBomVo();
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		try{
	       	VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
		    VmesJcoConnection connect = new VmesJcoConnection(connectVo); 
 	
			JCoFunction function = connect.getFunction(func_name);
	//		function.getImportParameterList().getStructure("Structure_Name").setValue("Field_Value", "Field_Name");
			 
	//		function.getImportParameterList().getStructure("Structure_Name").setValue("Field_Value", "Field_Name");
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			
			System.out.println("iv_date" +iv_date );
			System.out.println("iv_werks" +iv_werks );
			System.out.println("IV_IF" +iv_if );
		 
			/*== Setting RFC Parameter ===================================*/
			function.getImportParameterList().setValue("IV_MATNR", "HV2002");
			function.getImportParameterList().setValue("IV_DATE", "20170921");
			function.getImportParameterList().setValue("IV_WERKS", iv_werks);
			function.getImportParameterList().setValue("IV_IF", iv_if);
 
			/*== Return Value Mapping ===================================*/
			LogStatusVo logVo = new LogStatusVo();
			
			try {
				logVo.setCreator("system");
				logVo.setUpdater("system");
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:"+func_name);
				logVo.setBatch_target_ds("hub_tbl");
				logVo.setBatch_type("M");
				logVo.setBatch_action("U");
				
				connect.executeFunction(function);
 
				JCoTable t_tab = function.getTableParameterList().getTable("ET_OUTPUT");
 
			//	resultObj.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
			//	resultObj.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));
 			
				 for (int i = 0; i < t_tab.getNumRows(); i++) {
					 JSONObject resultObj = new JSONObject();
					 t_tab.setRow(i);
			      //  	pVo.setMatnr(t_tab.getString("MATNR"));
			     ///   	pVo.setOjtxp(t_tab.getString("OJTXP"));
					resultObj.put("matnr",t_tab.getString("MATNR"));
					resultObj.put("werks",t_tab.getString("WERKS"));
					resultObj.put("stlan",t_tab.getString("STLAN"));
					resultObj.put("stlal",t_tab.getString("STLAL"));
					resultObj.put("stufe",t_tab.getString("STUFE"));
					resultObj.put("maktx",t_tab.getString("MAKTX")); 
					resultObj.put("idnrk",t_tab.getString("IDNRK")); 
					resultObj.put("ojtxp",t_tab.getString("OJTXP")); 
					resultObj.put("menge",t_tab.getString("MENGE")); 
					resultObj.put("meins",t_tab.getString("MEINS")); 
					resultObj.put("sortf",t_tab.getString("SORTF")); 
					resultObj.put("potx1",t_tab.getString("POTX1")); 
					resultObj.put("schgt",t_tab.getString("SCHGT")); 
					resultObj.put("mschg",t_tab.getString("MSCHG")); 
					resultObj.put("sobsl",t_tab.getString("SOBSL")); 
					resultObj.put("sobsk",t_tab.getString("SOBSK")); 
					resultObj.put("sernp",t_tab.getString("SERNP")); 
					resultObj.put("datuv",t_tab.getString("DATUV")); 
					resultObj.put("aennr",t_tab.getString("AENNR")); 
					resultObj.put("datub",t_tab.getString("DATUB")); 
					resultObj.put("aenra",t_tab.getString("AENRA")); 
			          	
			     //   	resultObj.put("datuv",t_tab.getString("DATUV")); 
			     //   	resultObj.put("datuv",t_tab.getString("DATUV")); 
					listDataJArray.add(resultObj);
				 }
				 System.out.println("listDataJArray" +listDataJArray.toString());
			 
				logVo.setBatch_result("S");
				logVo.setBatch_description("");
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");
			} catch(Exception ex){
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
			
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}
	
	public List<SYVendorVo> selectVendortbl(SYVendorVo vo) {
		List<SYVendorVo> list = hubDAO.selectVendortbl(vo);
		return list;
	}
/*	
	public List<SYVendorVo> selectVendortbl(String funcName, String iv_fdate, String iv_tdate, String lifnr, String name1) {
		SYVendorVo vo = new SYVendorVo();
		vo.setIv_fdate(iv_fdate);
		vo.setIv_tdate(iv_tdate); 
		vo.setLifnr(lifnr); 
		vo.setName1(name1); 
		
		List<SYVendorVo> list = hubDAO.selectVendortbl(vo);
		return list;
	}
*/	
	public List<SYReqmMatnrTblVo> material_req_mas_select(SYReqmMatnrTblVo sVo){
		return hubDAO.material_req_mas_select(sVo);
	}
	
	/*public List<SYReqmMatnrTblVo> material_req_det_select(SYReqmMatnrTblVo sVo){
		return hubDAO.material_req_det_select(sVo);
	}*/
	
//	public List<SYReqmMatnrTblVo> material_req_det_select_1(SYReqmMatnrTblVo sVo){
//		return hubDAO.material_req_det_select_1(sVo);
//	}
	
	/*public List<SYReqmMatnrTblVo> material_req_done_select(SYReqmMatnrTblVo sVo){
		return hubDAO.material_req_done_select(sVo);
	}*/
	
	public int selectBomtbl_count(SYHubBomVo vo) {
		return hubDAO.selectBomtbl_count(vo);
	}
	
	public List<SYHubBomVo> selectBomtbl(SYHubBomVo vo) {
		return hubDAO.selectBomtbl(vo);
	}
	

	/*public List<SYReqmMatnrTblVo> req_status_chk(SYReqmMatnrTblVo sVo){
		return hubDAO.req_status_chk(sVo);
	}*/
	/*
	@Transactional
	public int reqd_sernr_insert(SYReqmMatnrTblVo sVo){
//		int result = hubDAO.deleteMenuRole(menuVo);
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();
		
		JSONParser jsonParser_1 = new JSONParser();
		JSONArray listDataJArray_1 = new JSONArray();

		int result = 0;
		try{
			/ *******************시리얼 사용실적 처리 : Start****************************//*
			listDataJArray = (JSONArray) jsonParser.parse(sVo.getGridData());
			
			if(listDataJArray.size() != 0) {
				JSONObject jOb = (JSONObject)listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();
	
				sVo.setGrantor(sVo.getCreator());
				sVo.setGrantor_date(sVo.getGrantor_date());
				
				for(int idx=0; idx<listDataJArray.size(); idx++){
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject)listDataJArray.get(idx);
					SYReqmMatnrTblVo tmp_sVo = new SYReqmMatnrTblVo();
	
					for(Object key : keyArr){
						String nKey = key.toString();
						String nValue =  (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						if( "reqm_matnr_key".equals(nKey) ) {
							tmp_sVo.setReqm_matnr_key(nValue);
							sVo.setReqm_matnr_key(nValue);
						}
						else if( "reqm_sub_key".equals(nKey) ) {
							tmp_sVo.setReqm_sub_key(nValue);
							sVo.setReqm_sub_key(nValue);
						}
						else if( "matnr".equals(nKey) ) tmp_sVo.setMatnr(nValue);
						else if( "reqd_matnr_key".equals(nKey) ) tmp_sVo.setReqd_matnr_key(nValue);
						else if( "serial".equals(nKey) ) tmp_sVo.setSernr(nValue);
					}
					
					
					tmp_sVo.setCreator(sVo.getCreator());
					tmp_sVo.setUpdater(sVo.getCreator());
					
					result = hubDAO.reqd_sernr_insert(tmp_sVo);			//reqd_matnr_sernr_tbl 테이블에 serial 실적 insert
					result = hubDAO.reqm_status_update(sVo);			//reqm_matnr_tbl에 승인으로 상태 업데이트
				}
				
				List<SYReqmMatnrTblVo> conf_bdmng_list = hubDAO.conf_bdmng_chk(sVo);
				
				for(int k=0 ; k<conf_bdmng_list.size() ; k++) {
					SYReqmMatnrTblVo pVo = new SYReqmMatnrTblVo();
					
					pVo.setReqm_matnr_key(conf_bdmng_list.get(k).getReqm_matnr_key());
					pVo.setReqm_sub_key(conf_bdmng_list.get(k).getReqm_sub_key());
					pVo.setReqd_matnr_key(conf_bdmng_list.get(k).getReqd_matnr_key());
					pVo.setMatnr(conf_bdmng_list.get(k).getMatnr());
					pVo.setConfirm_bdmng(conf_bdmng_list.get(k).getSernr_seq());
					pVo.setGrade(conf_bdmng_list.get(k).getGrade_nm());
					
					hubDAO.conf_bdmng_update(pVo);			//reqd_matnr_tbl.. 승인수량 업데이트.. serial 순번 최대값을 수량으로 넣어준다
				}
			}
			//*******************시리얼 사용실적 처리 : End****************************//*
			
			//*******************시리얼 미사용실적 처리(수량만 관리) : Start****************************//*
			listDataJArray_1 = (JSONArray) jsonParser_1.parse(sVo.getGridData_1());
			
			if(listDataJArray_1.size() != 0) {
				JSONObject jOb_1 = (JSONObject)listDataJArray_1.get(0);
				Object[] keyArr_1 = jOb_1.keySet().toArray();
	
				
				for(int idx=0; idx<listDataJArray_1.size(); idx++){
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject)listDataJArray_1.get(idx);
					SYReqmMatnrTblVo tmp_sVo = new SYReqmMatnrTblVo();
			
					for(Object key : keyArr_1){
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						if( "reqm_matnr_key".equals(nKey) ) {
							tmp_sVo.setReqm_matnr_key(nValue);
							sVo.setReqm_matnr_key(nValue);
						}
						else if( "reqm_sub_key".equals(nKey) ) {
							tmp_sVo.setReqm_sub_key(nValue);
							sVo.setReqm_sub_key(nValue);
						}
						else if( "matnr".equals(nKey) ) tmp_sVo.setMatnr(nValue);
						else if( "reqd_matnr_key".equals(nKey) ) tmp_sVo.setReqd_matnr_key(nValue);
						else if( "serial".equals(nKey) ) tmp_sVo.setConfirm_bdmng(nValue);			//serial 이라고 이름 잘못지음..
					}
					
					
					tmp_sVo.setCreator(sVo.getCreator());
					tmp_sVo.setUpdater(sVo.getCreator());
					result = hubDAO.conf_bdmng_update(tmp_sVo);			//reqd_matnr_tbl.. 승인수량 업데이트..화면에서 입력한 수량을 넣어줌..
					sVo.setGrantor(sVo.getCreator());
					result = hubDAO.reqm_status_update(sVo);			//reqm_matnr_tbl.. 상태 승인으로 업데이트
				}
				//*******************시리얼 미사용실적 처리(수량만 관리) : End****************************//*
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}*/
	/*
	@Transactional
	public int conf_bdmng_update(SYReqmMatnrTblVo sVo){
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();
		int result = 0;
		try{
			listDataJArray = (JSONArray) jsonParser.parse(sVo.getGridData());
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();

			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray.get(idx);
				SYReqmMatnrTblVo tmp_sVo = new SYReqmMatnrTblVo();

				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					if( "reqm_matnr_key".equals(nKey) ) {
						tmp_sVo.setReqm_matnr_key(nValue);
						sVo.setReqm_matnr_key(nValue);
					}
					else if( "reqm_sub_key".equals(nKey) ) {
						tmp_sVo.setReqm_sub_key(nValue);
						sVo.setReqm_sub_key(nValue);
					}
					else if( "matnr".equals(nKey) ) tmp_sVo.setMatnr(nValue);
					else if( "reqd_matnr_key".equals(nKey) ) tmp_sVo.setReqd_matnr_key(nValue);
					else if( "serial".equals(nKey) ) tmp_sVo.setConfirm_bdmng(nValue);
				}
				tmp_sVo.setCreator(sVo.getCreator());
				tmp_sVo.setUpdater(sVo.getCreator());
				result = hubDAO.conf_bdmng_update(tmp_sVo);			//승인 자재들 시리얼 매핑
			}
			sVo.setGrantor(sVo.getCreator());

			result = hubDAO.reqm_status_update(sVo);			//reqm_matnr_tbl.. 상태 승인으로 업데이트
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}*/

	public List<SYReqmMatnrTblVo> grade_master_selc(String grade_nm) {
		return hubDAO.grade_master_selc(grade_nm);		
	}

	public List<SYReqmMatnrTblVo> material_req_mas_select_1(SYReqmMatnrTblVo sVo) {
		return hubDAO.material_req_mas_select_1(sVo);
	}
	
	public List<SYReqmMatnrTblVo> tmp_matdoc_itm_select(SYReqmMatnrTblVo sVo) {
		return hubDAO.tmp_matdoc_itm_select(sVo);
	}

	public int matdoc_itm_update(SYReqmMatnrTblVo pVo) {
		return  hubDAO.matdoc_itm_update(pVo);
	}
	
	@Transactional
	public int rinspectionHeader_insert(SYHubRecvinspeVo hubHVo){
 
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();	
		int result = 0;
		
		try{
 	
			listDataJArray = (JSONArray) jsonParser.parse(hubHVo.getGridData());
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();
 
			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray.get(idx);
				hubHVo.setInspection_gcode(hubDAO.getInspectionGroupNo());
				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					if( "inspection_gnm".equals(nKey) )
						hubHVo.setInspection_gnm(nValue);
				}
				result = hubDAO.rinspectionHeader_insert(hubHVo);
			}
			 
		 
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}
	
	@Transactional
	public int rinpsectionDetailItem_insert(SYHubRecvinspeVo hubHVo){
//		int result = hubDAO.deleteMenuRole(menuVo);
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();
		int result = 0;
		try{
			listDataJArray = (JSONArray) jsonParser.parse(hubHVo.getGridData());
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();
			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray.get(idx);
				hubHVo.setInspection_code(hubDAO.getInspectionNo());
				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					if( "dept_cd".equals(nKey) )
						hubHVo.setDept_cd(nValue);
					else if( "inspection_list".equals(nKey) )
						hubHVo.setInspection_list(nValue);
					else if( "inspection_standard".equals(nKey) )
						hubHVo.setInspection_standard(nValue);
					else if( "inspection_value_max".equals(nKey) )
						hubHVo.setInspection_value_max(nValue);
					else if( "inspection_value_low".equals(nKey) )
						hubHVo.setInspection_value_low(nValue);
					else if( "inspection_remark_code".equals(nKey) ){
						 hubHVo.setInspection_remark_code(nValue);
     
					     String rm =  hubDAO.getInspectionRemarkNm(hubHVo);
		   
					     hubHVo.setInspection_remark(rm);
	 
					}else if( "creator".equals(nKey) )
						hubHVo.setCreator(nValue);
					else if( "updater".equals(nKey) )
						hubHVo.setUpdater(nValue);
					
				}
				result = hubDAO.rinpsectionDetailItem_insert(hubHVo);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}
	
	@Transactional
	public int rinspection_DetailItem_delete(SYHubRecvinspeVo hubDVo){
		return hubDAO.rinspection_DetailItem_delete(hubDVo);
	}
	
	
	@Transactional
	public int rinspection_matnr_insert(SYHubRecvinspeVo hubDVo){
//		int result = hubDAO.deleteMenuRole(menuVo);
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();
		int result = 0;
		try{
			listDataJArray = (JSONArray) jsonParser.parse(hubDVo.getGridData());
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();
			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray.get(idx);
				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					if( "matnr".equals(nKey) )
						hubDVo.setMatnr(nValue);
					else if( "maktx".equals(nKey) )
						hubDVo.setMaktx(nValue);		
				}
				result = hubDAO.rinspection_matnr_insert(hubDVo);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}
	
	@Transactional
	public int rinspection_matnr_delete(SYHubRecvinspeVo hubDVo){
		return hubDAO.rinspection_matnr_delete(hubDVo);
	}
	
	/*public int updateRouting_Plast(List<SYHubRoutingHeaderVo> sendList ) {
		int result = 0;
		if( sendList.size()>0 ) {
			result = hubDAO.updateRoutingPlastN(sendList.get(0));
			if( result>0 ) {
				for(SYHubRoutingHeaderVo tmpVo : sendList){
					result = hubDAO.updateRoutingPlastY(tmpVo);
				}
			}
		}
		return result;
	}*/

	public List<SYDmrMasterVo> dmrMaster_select(SYDmrMasterVo dmrVo) {
		return hubDAO.dmrMaster_select(dmrVo);
	}
	
	public List<SYDmrMasterVo> dmrMasterAllByKey_select(SYDmrMasterVo dmrVo) {
		return hubDAO.dmrMasterAllByKey_select(dmrVo);
	}
	
	public int dmrMaster_insert(SYDmrMasterVo dmrVo) {
		return hubDAO.dmrMaster_insert(dmrVo);
	}

	public int dmrMaster_applyInit_update(SYDmrMasterVo dmrVo) {
		return hubDAO.dmrMaster_applyInit_update(dmrVo);
	}

	public int dmrMaster_update(SYDmrMasterVo dmrVo) {
		return hubDAO.dmrMaster_update(dmrVo);
	}
	
	public int dmrMaster_delete(SYDmrMasterVo dmrVo) {
		return hubDAO.dmrMaster_delete(dmrVo);
	}
	
	public List<SYDmrPbaVo> dmrPba_select(SYDmrPbaVo pbaVo) {
		return hubDAO.dmrPba_select(pbaVo);
	}
	
	public int dmrPba_insert(List<SYDmrPbaVo> pbaList) {
		int resultCnt = 0;
		SYDmrPbaVo tmpVo = new SYDmrPbaVo();
		tmpVo.setGr_no(pbaList.get(0).getGr_no());
		tmpVo.setGr_seq(pbaList.get(0).getGr_seq());
		hubDAO.dmrPba_delete(tmpVo);
		
		for( SYDmrPbaVo vo : pbaList ){
//			if( "".equals(vo.getPba_seq()) ){
				resultCnt += hubDAO.dmrPba_insert(vo);
//			} else {
//				resultCnt += hubDAO.dmrPba_update(vo);
//			}
		}
		return resultCnt;
	}

	public int dmrPbaVerUp_insert(List<SYDmrPbaVo> pbaList) {
		int resultCnt = 0;
		for( SYDmrPbaVo vo : pbaList ){
			resultCnt += hubDAO.dmrPba_insert(vo);
		}
		return resultCnt;
	}
	
//	public int dmrPba_update(SYDmrPbaVo pbaVo) {
//		return hubDAO.dmrPba_update(pbaVo);
//	}
	
	public int dmrPba_delete(SYDmrPbaVo pbaVo) {
		return hubDAO.dmrPba_delete(pbaVo);
	}
	
	public List<SYDmrFwVo> dmrFw_select(SYDmrFwVo fwVo) {
		return hubDAO.dmrFw_select(fwVo);
	}
	
	public int dmrFw_insert(List<SYDmrFwVo> fwList) {
//		return hubDAO.dmrFw_insert(fwVo);
		int resultCnt = 0;
		
		SYDmrFwVo tmpVo = new SYDmrFwVo();
		tmpVo.setGr_no(fwList.get(0).getGr_no());
		tmpVo.setGr_seq(fwList.get(0).getGr_seq());
		hubDAO.dmrFw_delete(tmpVo);
		
		for( SYDmrFwVo vo : fwList ){
//			if( "".equals(vo.getFw_seq()) ){
				resultCnt += hubDAO.dmrFw_insert(vo);
//			} else {
//				resultCnt += hubDAO.dmrFw_update(vo);
//			}
		}
		return resultCnt;
	}

	public int dmrFwVerUp_insert(List<SYDmrFwVo> fwList) {
//		return hubDAO.dmrFw_insert(fwVo);
		int resultCnt = 0;
		for( SYDmrFwVo vo : fwList ){
			resultCnt += hubDAO.dmrFw_insert(vo);
		}
		return resultCnt;
	}
	
	public int dmrFw_update(SYDmrFwVo fwVo) {
		return hubDAO.dmrFw_update(fwVo);
	}
	
	public int dmrFw_delete(SYDmrFwVo fwVo) {
		return hubDAO.dmrFw_delete(fwVo);
	}
	
	public String getGrSeq() {
		return hubDAO.getGrSeq();
	}

	public String getGrNo() {
		return hubDAO.getGrNo();
	}
	
	public int ecrMaster_insert(SYDmrMasterVo dmrVo) {
		return hubDAO.ecrMaster_insert(dmrVo);
	}
	
	@SuppressWarnings({ "unused", "unchecked" })
	public JSONObject ZIFFM_MES_PP009(SYDmrMasterVo ecrVo,String funcName ) {
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();

		try {
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo);
			JCoFunction function = connect.getFunction(funcName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}

			 
			/* == Return Value Mapping =================================== */
			LogStatusVo logVo = new LogStatusVo();
			try {
				logVo.setCreator("system");
				logVo.setUpdater("system");
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:ZIFFM_MES_PP009");
				logVo.setBatch_target_ds("ecr_manager_tbl");
				logVo.setBatch_type("M");
				logVo.setBatch_action("U");

			 

				JSONObject resultObj = new JSONObject();
				JCoTable itemTable = function.getTableParameterList().getTable("IT_PP009");
 	 
		  
				itemTable.appendRows(1);
			 	itemTable.setValue("WERKS",ecrVo.getDept_cd()  );
				itemTable.setValue("AENNR",ecrVo.getEcr_no()  );    //설계변경 번호
				itemTable.setValue("AETXT",ecrVo.getChange_remark() );  //제품모델
				itemTable.setValue("DATUV",ecrVo.getConfirm_date()  );  //효력시작일
				itemTable.setValue("AEGRU",ecrVo.getChange_memo() );    //세부항목
				itemTable.setValue("LTEXT",ecrVo.getSpecial_note() );   //Information
 	
				function.getImportParameterList().setValue("IV_IF", "X");
				function.getTableParameterList().setValue("IT_PP009", itemTable);
				// == Return Value Mapping ===================================
				connect.executeFunction(function);
 	
				System.out.println(itemTable);

				logVo.setBatch_result("S");
				logVo.setBatch_description("");
				
				resultData.put("status", "S");
				resultData.put("message", "RFC FUNC. is success.");
 	 

			} catch (Exception ex) {
				logVo.setBatch_result("F");
				logVo.setBatch_description(ex.toString());
				
				resultData.put("status", "F");
				resultData.put("message", "SAP RFC 전송실패 ");
			 
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
    
	public List<SYDmrMasterVo> ecrMaster_select(SYDmrMasterVo dmrVo) {
		return hubDAO.ecrMaster_select(dmrVo);
	}
	/*
	@Transactional
	public List<SYZmmfmMatMasterVo> dmr_matnr_select(SYZmmfmMatMasterVo sVo){
		return hubDAO.dmr_matnr_select(sVo);
	}
	
	@Transactional
	public int dmr_matnr_select_count(SYZmmfmMatMasterVo sVo){
		return hubDAO.dmr_matnr_select_count(sVo);
	}
	
	public List<SYZmmfmMatMasterVo> dmrmatnrManageTbl(SYZmmfmMatMasterVo vo) {
		return hubDAO.dmrmatnrManageTbl(vo);
	}
	
	public int dmrMatnr_insert(SYZmmfmMatMasterVo dmrVo) {
		return hubDAO.dmrMatnr_insert(dmrVo);
	}*/

	/*public List<SYZmmfmMatMasterVo> material_recv_master_select_nopage(SYZmmfmMatMasterVo sVo) {
		return hubDAO.material_recv_master_select_nopage(sVo);
	}*/

	/*public List<SYZmmfmMatMasterVo> material_recv_master_select_vendor_nopage(SYZmmfmMatMasterVo sVo) {
		return hubDAO.material_recv_master_select_nopage(sVo);
	}*/
//	public int reqm_cancel_update(SYReqmMatnrTblVo pVo) {
//		return hubDAO.reqm_cancel_update(pVo);
//	}

	/*public int reqd_cancel_update(SYReqmMatnrTblVo pVo) {
		return hubDAO.reqd_cancel_update(pVo);
	}*/

	/*public int reqd_sernr_cancel_delete(SYReqmMatnrTblVo pVo) {
		return hubDAO.reqd_sernr_cancel_delete(pVo);
	}*/
/*
	public int updateMasterMaterial01(List<SYZmmfmMatMasterVo> list) {
		int result = 0;
//		int result1 = 0;
//		int result2 = 0;
		for(SYZmmfmMatMasterVo vo : list){
 			 
			result += hubDAO.updateMasterMaterial01(vo);
			if(vo.getWerks().equals("1110")){
				if (vo.getMess_medical_yn().equals("Y")){
//					result1 += hubDAO.updateMasterMaterial03(vo);
					hubDAO.updateMasterMaterial03(vo);
				}else if (vo.getMess_medical_yn().equals("N")){ 
//					result2 += hubDAO.updateMasterMaterial04(vo);
					hubDAO.updateMasterMaterial04(vo);
				}
			}else{
				if (vo.getMess_optical_yn().equals("Y")){
//					result1 += hubDAO.updateMasterMaterial03(vo);
					hubDAO.updateMasterMaterial03(vo);
				}else if (vo.getMess_optical_yn().equals("N")){ 
//					result2 += hubDAO.updateMasterMaterial04(vo);		
					hubDAO.updateMasterMaterial04(vo);		
				}
			}
		}
		return result;
	}*/
	
	public int create_vmember(List<SYVendorVo> lineList) {
		int resultCnt = 0;
 
		for( SYVendorVo vo : lineList ){
			
			resultCnt += hubDAO.create_vmember(vo);
		}
		return resultCnt;
	}
	public int create_vmember_map(List<SYVendorVo> lineList) {
		int resultCnt = 0;
 
		for( SYVendorVo vo : lineList ){
			
			resultCnt += hubDAO.create_vmember_map(vo);
		}
		return resultCnt;
	}    
	public int create_vmember_role (List<SYVendorVo> lineList) {
		int resultCnt = 0;
 
		for( SYVendorVo vo : lineList ){
			
			resultCnt += hubDAO.create_vmember_role(vo);
		}
		return resultCnt;
	}
	public int update_vendor_id_yn (List<SYVendorVo> lineList) {
		int resultCnt = 0;
 
		for( SYVendorVo vo : lineList ){
			
			resultCnt += hubDAO.update_vendor_id_yn(vo);
		}
		return resultCnt;
	}
	
	/*public List<SYHubRoutingHeaderVo> routing_group_byItnbr_select(SYHubRoutingHeaderVo vo) {
		return hubDAO.routing_group_byItnbr_select(vo);
	}*/
	
	/*public int update_routinggnm(SYHubRoutingHeaderVo vo) {
		return hubDAO.update_routinggnm(vo);
	}*/

	/*public int matnr_workstd_mapping(SYFileVo vo) {
		
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();
		int result = 0;
		try{
			listDataJArray = (JSONArray) jsonParser.parse(vo.getParams());
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();
			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray.get(idx);
				SYFileVo pVo = new SYFileVo();
				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue =  (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					
					if( "matnr".equals(nKey) )
						pVo.setMatnr(nValue);
					else if( "werks".equals(nKey) )
						pVo.setDept_cd(nValue);
				}
				pVo.setFile_name(vo.getFile_name());
				pVo.setCreator(vo.getCreator());
				pVo.setUpdater(vo.getUpdater());
				result = hubDAO.matnr_workstd_mapping(pVo);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}*/
/*
	public List<SYFileVo> mapping_list_selc(SYFileVo sVo) {
		return hubDAO.mapping_list_selc(sVo);
	}*/
	
	/*
	public int fnDelMatnr(SYFileVo vo) {
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();
		int result = 0;
		try{
			listDataJArray = (JSONArray) jsonParser.parse(vo.getParams());
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();
			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray.get(idx);
				SYFileVo pVo = new SYFileVo();
				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue =  (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					
					if( "matnr".equals(nKey) )
						pVo.setMatnr(nValue);
					else if( "dept_cd".equals(nKey) )
						pVo.setDept_cd(nValue);
				}
				pVo.setFile_name(vo.getFile_name());
				pVo.setUpdater(vo.getUpdater());
				result = hubDAO.fnDelMatnr(pVo);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}*/

	public List<SYHubRecvinspeVo> insp_group_byItnbr_select(SYHubRecvinspeVo vo) {
		return hubDAO.insp_group_byItnbr_select(vo);
	}
	
	public int insertVendor(SYVendorVo pVo) {
		return hubDAO.insertVendor(pVo);
	}
	
	public int updateVendor(SYVendorVo pVo) {
		return hubDAO.updateVendor(pVo);
	}
	
	public int deleteVendor(SYVendorVo pVo) {
		return hubDAO.deleteVendor(pVo);
	}
}
