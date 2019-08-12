package kr.co.passcombine.mes.svc;

import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.HashSet;
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
//import com.sap.conn.jco.JCoTable;

import kr.co.passcombine.mes.dao.SYMesDAO;
import kr.co.passcombine.mes.sap.VmesJcoConnectVo;
import kr.co.passcombine.mes.sap.VmesJcoConnection;
import kr.co.passcombine.mes.vo.SYInInspVo;
import kr.co.passcombine.mes.vo.SYMesCodeVo;
import kr.co.passcombine.mes.vo.SYMesVo;
//import kr.co.passcombine.mes.vo.SYPoRequirementVo;
import kr.co.passcombine.mes.vo.SYProdVo;
import kr.co.passcombine.mes.vo.SYReqmMatnrTblVo;
import kr.co.passcombine.mes.vo.SYScmRawProcVo;
import kr.co.passcombine.mes.vo.SYSelfInspDetailVo;
import kr.co.passcombine.mes.vo.SYSelfInspHeaderVo;
import kr.co.passcombine.mes.vo.SYSelfInspMasterVo;
import kr.co.passcombine.mes.svc.SYProdService;



@Service(value = "vmesMesService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYMesService {

	@Resource(name = "vmesProdService")
	SYProdService sYprodService;
	
	// private static final Logger logger = LoggerFactory.getLogger(SYCodeService.class);
	@Resource
	private Environment environment;
	
	@Resource(name = "vmesMesDAO")
	private SYMesDAO mesDAO;
	
	@Transactional
	public List<SYMesVo> selectList(SYMesVo code){
		return mesDAO.selectList(code);
	}

	public int selectListCount(SYMesVo code){
		return mesDAO.selectListCount(code);
	}
	/*
	@SuppressWarnings("unchecked")
	public JSONObject selectDetailList(SYMesVo mesVo){
		
//		SYMesVo resultVo = new SYMesVo();
//		List<SYMesVo> listVo = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		String pordNo = mesVo.getPordno();
		String functionName = mesVo.getFunctionName();
		
//		JCoTable t_tab1 = null;
		
		try{
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo);
			
			JCoFunction function = connect.getFunction(functionName);
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			== Setting RFC Parameter ===================================
			function.getImportParameterList().setValue("IV_AUFNR", pordNo);
			
			== Return Value Mapping ===================================
			try {
				connect.executeFunction(function);
					
				JSONObject resultObj = new JSONObject();
//				JCoTable t_tab1 = function.getTableParameterList().getTable("ET_OUTPUT");
				resultObj.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
				resultObj.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));
//				resultObj.put("e_output", t_tab1.toString());
//				listDataJArray.add(resultObj);
				//rfc t_tab1 결과 prod_tbl에 insert, t_tab2 결과 prod_tbl에 update
//				SYMesVo tmpVo = new SYMesVo();
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");
				
			} catch(Exception ex){
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				ex.printStackTrace();
			} 
			resultData.put("rows", listDataJArray);
			//resultData.put("AUFNR", function.getExportParameterList().getTable("ET_OUTPUT_1").getValue("AUFNR"));
			
		}catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
//		System.out.println(resultData.toJSONString());
		return resultData;
	}*/
	
	/*@Transactional
	public List<SYProdVo> selectProdOrderGroup(SYProdVo pordVo){
		return mesDAO.selectProdOrderGroup(pordVo);
	}*/
	
	@Transactional
	public List<SYProdVo> selectProdOrdUserIng(SYProdVo pordVo){
		return mesDAO.selectProdOrdUserIng(pordVo);
	}
	
	@Transactional
	public List<SYProdVo> selectProdOrdUserIng_opt(SYProdVo pordVo){
//		List<SYProdVo> list = sYprodService.sapProdCode(pordVo);
//		
//		List<SYProdVo> r_list = new ArrayList<SYProdVo>();
//		
//		for(int i=0;i<list.size();i++) {
//			List<SYProdVo> result = mesDAO.selectProdOrdUserIng_opt(list.get(i));
//			r_list.add(result.get(0));
//		}
//		
//		System.out.println("################# r_list");
//		System.out.println(r_list);
//		return r_list;
		return mesDAO.selectProdOrdUserIng_opt(pordVo);
	}
	
	public int reqm_matnr_tbl_insert(SYReqmMatnrTblVo sVo) {
		JSONParser jsonParser = new JSONParser();
	
		JSONArray masArr = new JSONArray();
		JSONArray detArr = new JSONArray();
		
		int result = 0;
		 
		String newKey = reqm_matnr_tbl_key_select();
		sVo.setReqm_matnr_key(newKey);
		
 		try{
 			masArr = (JSONArray) jsonParser.parse(sVo.getReqm_matnr_tbl_data());
			JSONObject masObj = (JSONObject)masArr.get(0);	// for get key
			Object[] masObj_keyArr = masObj.keySet().toArray();
			
 			detArr = (JSONArray) jsonParser.parse(sVo.getReqd_matnr_tbl_data());
			JSONObject detObj = (JSONObject)detArr.get(0);
			Object[] detObj_keyArr = detObj.keySet().toArray();
			
			// insert master Data
			for(int idx=0; idx<masArr.size(); idx++){
				JSONObject jObj = (JSONObject)masArr.get(idx);
				SYReqmMatnrTblVo masVo = new SYReqmMatnrTblVo();
				masVo.setReqm_matnr_key(newKey);	// id
				for(Object key : masObj_keyArr){	// json keys
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();

					if( "matnr".equals(nKey) ) masVo.setMatnr(nValue);
					else if( "werks".equals(nKey)) masVo.setWerks(nValue);
					else if( "bdter".equals(nKey)) masVo.setBdter(nValue);
					else if( "lgort".equals(nKey)) masVo.setLgort(nValue);
					else if( "bdmng".equals(nKey)) masVo.setBdmng(nValue);
					else if( "meins".equals(nKey)) masVo.setMeins(nValue);
					else if( "request_bdmng".equals(nKey)) masVo.setRequest_bdmng(nValue);
					else if( "grade".equals(nKey)) {
						if(nValue.equals( "등급없음")) 	
							masVo.setGrade_yn("N");
						else 
							masVo.setGrade_yn("Y");
					}
//					else if( "requester_status".equals(nKey)) masVo.setRequester_status("Y");
//					else if( "grantor_status".equals(nKey)) masVo.setGrantor_status("N");
					
				}
				masVo.setRequester_status("Y");
				masVo.setGrantor_status("N");
				masVo.setCreator(sVo.getCreator());
				masVo.setPgm_nm(sVo.getPgm_nm());
				result = mesDAO.reqm_matnr_tbl_insert(masVo);
			}
			
			
			List<SYReqmMatnrTblVo> keyList = reqd_matnr_key_select(newKey);
			// insert detail Data
			for(int idx=0; idx<detArr.size(); idx++){
				JSONObject jObj = (JSONObject)detArr.get(idx);
				SYReqmMatnrTblVo detVo = new SYReqmMatnrTblVo();
//				detVo.setReqm_matnr_key(newKey);	// id
				
				for(Object key : detObj_keyArr){	// json keys
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();

					if( "matnr".equals(nKey) ) {	
						detVo.setMatnr(nValue);
						
						for( SYReqmMatnrTblVo vo : keyList ) {	//마스터 내용 조회해 온 내용
							if(nValue.equals(vo.getMatnr())){	
								detVo.setMatnr(vo.getMatnr());
								detVo.setReqm_matnr_key(vo.getReqm_matnr_key());
								detVo.setReqm_sub_key(vo.getReqm_sub_key());
							}else{
							}
						}
					}
					else if( "grade_nm".equals(nKey)) detVo.setGrade_nm(nValue);
					else if( "request_bdmng".equals(nKey)) detVo.setRequest_bdmng(nValue);
					else if( "werks".equals(nKey)) {
						detVo.setPlant(nValue);
						detVo.setMove_plant(nValue);
					}
					else if( "lgfsb".equals(nKey)) detVo.setStge_loc(nValue);
					else if( "lgpro".equals(nKey)) detVo.setMove_stloc(nValue);
				}
//				if(detVo.getGrade_nm() != "등급없음") 
					result = mesDAO.reqd_matnr_tbl_insert(detVo);					
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}
	public String reqm_matnr_tbl_key_select(){
		return mesDAO.reqm_matnr_tbl_key_select();
	}
	
	public List<SYReqmMatnrTblVo> grade_master_select(){
		return mesDAO.grade_master_select();
	}

	public List<SYReqmMatnrTblVo> grade_exist_chk(SYReqmMatnrTblVo sVo) {
		return mesDAO.grade_exist_chk(sVo);		
	}
	
	public List<SYReqmMatnrTblVo> reqd_matnr_key_select(String key){
		return mesDAO.reqd_matnr_key_select(key);
	}

	public List<SYInInspVo> inInsp_select(SYInInspVo vo) {
		return mesDAO.inInsp_select(vo);
	}

	public List<SYInInspVo> inInsp_selectKey(SYInInspVo vo) {
		return mesDAO.inInsp_selectKey(vo);
	}
	
	public int ininsp_update(SYInInspVo vo) {
		return mesDAO.ininsp_update(vo);
	}
	
	public int ininsp_delete(SYScmRawProcVo vo) {
		return mesDAO.ininsp_delete(vo);
	}
	
	public int ininsp_detail_delete(SYInInspVo vo) {
		return mesDAO.ininsp_detail_delete(vo);
	}
	
	public int ininsp_header_delete(SYInInspVo vo) {
		return mesDAO.ininsp_header_delete(vo);
	}
	
	/*public List<SYProdVo> select_medi_item(SYProdVo pVo) {
		return mesDAO.select_medi_item(pVo);
	}*/

	/*public List<SYProdVo> select_beforeJob_pdsts(SYProdVo pVo) {
		return mesDAO.select_beforeJob_pdsts(pVo);
	}*/
	
	public List<SYSelfInspMasterVo> select_selfinsp_master(SYSelfInspMasterVo vo) {
		return mesDAO.select_selfinsp_master(vo);
	}
	
	/*public List<SYSelfInspHeaderVo> select_selfinsp_header(SYSelfInspHeaderVo vo) {
		return mesDAO.select_selfinsp_header(vo);
	}*/
	
	/*public SYProdVo select_dmrRnInfo(String pordno) {
		return mesDAO.select_dmrRnInfo(pordno);
	}*/

	/*public List<SYSelfInspHeaderVo> select_selfinsp_header_exist(SYSelfInspHeaderVo vo) {
		return mesDAO.select_selfinsp_header_exist(vo);
	}*/

	/*public List<SYSelfInspDetailVo> select_selfinsp_detail(SYSelfInspDetailVo vo) {
		return mesDAO.select_selfinsp_detail(vo);
	}*/

	/*public List<SYSelfInspDetailVo> select_selfinsp_detail_exist(SYSelfInspDetailVo vo) {
		return mesDAO.select_selfinsp_detail_exist(vo);
	}*/

	public List<SYMesCodeVo> select_selfInspCode_1210(SYMesCodeVo vo) {
		return mesDAO.select_selfInspCode_1210(vo);
	}
	
	/*public List<SYMesCodeVo> select_selfInspCode_1110(SYMesCodeVo vo) {
		return mesDAO.select_selfInspCode_1110(vo);
	}*/
	
	/*public int checkExistSelfInsp(SYSelfInspHeaderVo vo) {
		return mesDAO.checkExistSelfInsp(vo);
	}*/
	
	public int insert_selfInspMaster(JSONObject jObj) {
		return 0;
	}
	public int update_selfInspMaster(JSONObject jObj) {
		return 0;
	}
	
	/*public int insert_selfInspHeader(JSONObject jObj) {
		int result = 0;
		JSONParser parser = new JSONParser();
		JSONArray hJsonArr = new JSONArray();
		try {
			hJsonArr = (JSONArray) parser.parse(jObj.get("headerData").toString());
			String pordno = jObj.get("pordno").toString();
			String dept_cd = jObj.get("dept_cd").toString();
			String creator = jObj.get("creator").toString();
			JSONObject tmpObj = (JSONObject)hJsonArr.get(0);
			Object[] keyArr = tmpObj.keySet().toArray();
			List<SYSelfInspHeaderVo> headerList = new ArrayList<SYSelfInspHeaderVo>();
			for(int idx=0; idx<hJsonArr.size(); idx++) {
				JSONObject rowObj = (JSONObject)hJsonArr.get(idx);
				SYSelfInspHeaderVo tmpVo = new SYSelfInspHeaderVo();
				tmpVo.setDept_cd(dept_cd);
				tmpVo.setPordno(pordno);
				tmpVo.setCreator(creator);
				for(Object key : keyArr) {
					String nKey = key.toString();
					String nValue = (rowObj.get(nKey)==null)?"":rowObj.get(nKey).toString();
					if ( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
					else if ( "simaster_gr_nm".equals(nKey) )  tmpVo.setSimaster_gr_nm(nValue);
					else if ( "siheader_code".equals(nKey) )  tmpVo.setSiheader_code(nValue);
					else if ( "siheader_seq".equals(nKey) )  tmpVo.setSiheader_seq(nValue);
					else if ( "main_name".equals(nKey) )  tmpVo.setMain_name(nValue);
					else if ( "sub_name".equals(nKey) )  tmpVo.setSub_name(nValue);
					else if ( "display_seq".equals(nKey) )  tmpVo.setDisplay_seq(nValue);
					else if ( "item_value".equals(nKey) )  tmpVo.setItem_value(nValue);
				}
				headerList.add(tmpVo);
			}
			for(SYSelfInspHeaderVo vo : headerList) {
				result += mesDAO.insert_selfInspHeader(vo);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result; 
	}*/
	
	/*public int update_selfInspHeader(JSONObject jObj) {
		int result = 0;
		JSONParser parser = new JSONParser();
		JSONArray hJsonArr = new JSONArray();
		try {
			hJsonArr = (JSONArray) parser.parse(jObj.get("headerData").toString());
			String pordno = jObj.get("pordno").toString();
			String dept_cd = jObj.get("dept_cd").toString();
			String updater = jObj.get("updater").toString();
			String confirm_id = "";
			if( jObj.get("confirm_id")!=null && !"".equals(jObj.get("confirm_id").toString()) )
				confirm_id = jObj.get("confirm_id").toString();
			JSONObject tmpObj = (JSONObject)hJsonArr.get(0);
			Object[] keyArr = tmpObj.keySet().toArray();
			List<SYSelfInspHeaderVo> headerList = new ArrayList<SYSelfInspHeaderVo>();
			for(int idx=0; idx<hJsonArr.size(); idx++) {
				JSONObject rowObj = (JSONObject)hJsonArr.get(idx);
				SYSelfInspHeaderVo tmpVo = new SYSelfInspHeaderVo();
				tmpVo.setDept_cd(dept_cd);
				tmpVo.setPordno(pordno);
				tmpVo.setUpdater(updater);
				if( !"".equals(confirm_id) )	tmpVo.setConfirm_id(confirm_id);
				for(Object key : keyArr) {
					String nKey = key.toString();
					String nValue = (rowObj.get(nKey)==null)?"":rowObj.get(nKey).toString();
					if ( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
					else if ( "simaster_gr_nm".equals(nKey) )  tmpVo.setSimaster_gr_nm(nValue);
					else if ( "siheader_code".equals(nKey) )  tmpVo.setSiheader_code(nValue);
					else if ( "siheader_seq".equals(nKey) )  tmpVo.setSiheader_seq(nValue);
					else if ( "main_name".equals(nKey) )  tmpVo.setMain_name(nValue);
					else if ( "sub_name".equals(nKey) )  tmpVo.setSub_name(nValue);
					else if ( "display_seq".equals(nKey) )  tmpVo.setDisplay_seq(nValue);
					else if ( "item_value".equals(nKey) )  tmpVo.setItem_value(nValue);
				}
				headerList.add(tmpVo);
			}
			for(SYSelfInspHeaderVo vo : headerList) {
				result += mesDAO.update_selfInspHeader(vo);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result; 
	}*/
	
	/*public int insert_selfInspDetail_1210(JSONObject jObj) {
		int result = 0;
		//List<SYSelfInspDetailVo> voList
//		result = mesDAO.insert_selfInspDetail(voList);
		JSONParser parser = new JSONParser();
		JSONArray dJsonArr_p1 = new JSONArray();
		JSONArray dJsonArr_p2 = new JSONArray();
		JSONArray dJsonArr_p5 = new JSONArray();
		JSONArray dJsonArr_t1 = new JSONArray();
		try {
			String pordno = jObj.get("pordno").toString();
			String dept_cd = jObj.get("dept_cd").toString();
			String creator = jObj.get("creator").toString();
			dJsonArr_p1 = (JSONArray) parser.parse(jObj.get("grid_p1_data").toString());
			dJsonArr_p2 = (JSONArray) parser.parse(jObj.get("grid_p2_data").toString());
			dJsonArr_p5 = (JSONArray) parser.parse(jObj.get("grid_p5_data").toString());
			dJsonArr_t1 = (JSONArray) parser.parse(jObj.get("grid_t1_data").toString());

			JSONObject jObj_p1 = (JSONObject)dJsonArr_p1.get(0);
			Object[] keyArr = jObj_p1.keySet().toArray();
			List<SYSelfInspDetailVo> detail_p1_List = new ArrayList<SYSelfInspDetailVo>();
			for(int idx=0; idx<dJsonArr_p1.size(); idx++) {
				JSONObject rowObj = (JSONObject)dJsonArr_p1.get(idx);
				SYSelfInspDetailVo tmpVo = new SYSelfInspDetailVo();
				tmpVo.setDept_cd(dept_cd);
				tmpVo.setPordno(pordno);
				tmpVo.setCreator(creator);
				for(Object key : keyArr) {
					String nKey = key.toString();
					String nValue = (rowObj.get(nKey)==null)?"":rowObj.get(nKey).toString();
					if ( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
					else if ( "sidetail_code".equals(nKey) )  tmpVo.setSidetail_code(nValue);
					else if ( "sidetail_seq".equals(nKey) )  tmpVo.setSidetail_seq(nValue);
					else if ( "routing_code".equals(nKey) )  tmpVo.setRouting_code(nValue);
					else if ( "display_seq".equals(nKey) )  tmpVo.setDisplay_seq(nValue);
					else if ( "minsp_name".equals(nKey) )  tmpVo.setMinsp_name(nValue);
					else if ( "sinsp_name".equals(nKey) )  tmpVo.setSinsp_name(nValue);
					else if ( "insp_standard".equals(nKey) )  tmpVo.setInsp_standard(nValue);
					else if ( "insp_state".equals(nKey) )  tmpVo.setInsp_state(nValue);
					else if ( "insp_value".equals(nKey) )  tmpVo.setInsp_value(nValue);
					else if ( "member_emp_no".equals(nKey) )  tmpVo.setMember_emp_no(nValue);
					else if ( "member_nm".equals(nKey) )  tmpVo.setMember_nm(nValue);
					else if ( "work_date".equals(nKey) )  tmpVo.setWork_date(nValue);
					else if ( "remark".equals(nKey) )  tmpVo.setRemark(nValue);
				}
				detail_p1_List.add(tmpVo);
			}
			
//			JSONObject jObj_p2 = (JSONObject)dJsonArr_p1.get(0);
			List<SYSelfInspDetailVo> detail_p2_List = new ArrayList<SYSelfInspDetailVo>();
			for(int idx=0; idx<dJsonArr_p2.size(); idx++) {
				JSONObject rowObj = (JSONObject)dJsonArr_p2.get(idx);
				SYSelfInspDetailVo tmpVo = new SYSelfInspDetailVo();
				tmpVo.setDept_cd(dept_cd);
				tmpVo.setPordno(pordno);
				tmpVo.setCreator(creator);
				for(Object key : keyArr) {
					String nKey = key.toString();
					String nValue = (rowObj.get(nKey)==null)?"":rowObj.get(nKey).toString();
					if ( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
					else if ( "sidetail_code".equals(nKey) )  tmpVo.setSidetail_code(nValue);
					else if ( "sidetail_seq".equals(nKey) )  tmpVo.setSidetail_seq(nValue);
					else if ( "routing_code".equals(nKey) )  tmpVo.setRouting_code(nValue);
					else if ( "display_seq".equals(nKey) )  tmpVo.setDisplay_seq(nValue);
					else if ( "minsp_name".equals(nKey) )  tmpVo.setMinsp_name(nValue);
					else if ( "sinsp_name".equals(nKey) )  tmpVo.setSinsp_name(nValue);
					else if ( "insp_standard".equals(nKey) )  tmpVo.setInsp_standard(nValue);
					else if ( "insp_state".equals(nKey) )  tmpVo.setInsp_state(nValue);
					else if ( "insp_value".equals(nKey) )  tmpVo.setInsp_value(nValue);
					else if ( "member_emp_no".equals(nKey) )  tmpVo.setMember_emp_no(nValue);
					else if ( "member_nm".equals(nKey) )  tmpVo.setMember_nm(nValue);
					else if ( "work_date".equals(nKey) )  tmpVo.setWork_date(nValue);
					else if ( "remark".equals(nKey) )  tmpVo.setRemark(nValue);
				}
				detail_p2_List.add(tmpVo);
			}
//			JSONObject jObj_p5 = (JSONObject)dJsonArr_p1.get(0);
			List<SYSelfInspDetailVo> detail_p5_List = new ArrayList<SYSelfInspDetailVo>();
			for(int idx=0; idx<dJsonArr_p5.size(); idx++) {
				JSONObject rowObj = (JSONObject)dJsonArr_p5.get(idx);
				SYSelfInspDetailVo tmpVo = new SYSelfInspDetailVo();
				tmpVo.setDept_cd(dept_cd);
				tmpVo.setPordno(pordno);
				tmpVo.setCreator(creator);
				for(Object key : keyArr) {
					String nKey = key.toString();
					String nValue = (rowObj.get(nKey)==null)?"":rowObj.get(nKey).toString();
					if ( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
					else if ( "sidetail_code".equals(nKey) )  tmpVo.setSidetail_code(nValue);
					else if ( "sidetail_seq".equals(nKey) )  tmpVo.setSidetail_seq(nValue);
					else if ( "routing_code".equals(nKey) )  tmpVo.setRouting_code(nValue);
					else if ( "display_seq".equals(nKey) )  tmpVo.setDisplay_seq(nValue);
					else if ( "minsp_name".equals(nKey) )  tmpVo.setMinsp_name(nValue);
					else if ( "sinsp_name".equals(nKey) )  tmpVo.setSinsp_name(nValue);
					else if ( "insp_standard".equals(nKey) )  tmpVo.setInsp_standard(nValue);
					else if ( "insp_state".equals(nKey) )  tmpVo.setInsp_state(nValue);
					else if ( "insp_value".equals(nKey) )  tmpVo.setInsp_value(nValue);
					else if ( "member_emp_no".equals(nKey) )  tmpVo.setMember_emp_no(nValue);
					else if ( "member_nm".equals(nKey) )  tmpVo.setMember_nm(nValue);
					else if ( "work_date".equals(nKey) )  tmpVo.setWork_date(nValue);
					else if ( "remark".equals(nKey) )  tmpVo.setRemark(nValue);
				}
				detail_p5_List.add(tmpVo);
			}
//			JSONObject jObj_t1 = (JSONObject)dJsonArr_p1.get(0);
			List<SYSelfInspDetailVo> detail_t1_List = new ArrayList<SYSelfInspDetailVo>();
			for(int idx=0; idx<dJsonArr_t1.size(); idx++) {
				JSONObject rowObj = (JSONObject)dJsonArr_t1.get(idx);
				SYSelfInspDetailVo tmpVo = new SYSelfInspDetailVo();
				tmpVo.setDept_cd(dept_cd);
				tmpVo.setPordno(pordno);
				tmpVo.setCreator(creator);
				for(Object key : keyArr) {
					String nKey = key.toString();
					String nValue = (rowObj.get(nKey)==null)?"":rowObj.get(nKey).toString();
					if ( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
					else if ( "sidetail_code".equals(nKey) )  tmpVo.setSidetail_code(nValue);
					else if ( "sidetail_seq".equals(nKey) )  tmpVo.setSidetail_seq(nValue);
					else if ( "routing_code".equals(nKey) )  tmpVo.setRouting_code(nValue);
					else if ( "display_seq".equals(nKey) )  tmpVo.setDisplay_seq(nValue);
					else if ( "minsp_name".equals(nKey) )  tmpVo.setMinsp_name(nValue);
					else if ( "sinsp_name".equals(nKey) )  tmpVo.setSinsp_name(nValue);
					else if ( "insp_standard".equals(nKey) )  tmpVo.setInsp_standard(nValue);
					else if ( "insp_state".equals(nKey) )  tmpVo.setInsp_state(nValue);
					else if ( "insp_value".equals(nKey) )  tmpVo.setInsp_value(nValue);
					else if ( "member_emp_no".equals(nKey) )  tmpVo.setMember_emp_no(nValue);
					else if ( "member_nm".equals(nKey) )  tmpVo.setMember_nm(nValue);
					else if ( "work_date".equals(nKey) )  tmpVo.setWork_date(nValue);
					else if ( "remark".equals(nKey) )  tmpVo.setRemark(nValue);
				}
				detail_t1_List.add(tmpVo);
			}
			for(SYSelfInspDetailVo vo_p1 : detail_p1_List) {
				result += mesDAO.insert_selfInspDetail(vo_p1);
			}
			if( dJsonArr_p1.size()==result ) {
				result = 0;
				for(SYSelfInspDetailVo vo_p2 : detail_p2_List) {
					result += mesDAO.insert_selfInspDetail(vo_p2);
				}
				if( dJsonArr_p2.size()==result ) {
					result = 0;
					for(SYSelfInspDetailVo vo_p5 : detail_p5_List) {
						result += mesDAO.insert_selfInspDetail(vo_p5);
					}
					if( dJsonArr_p5.size()==result ) {
						result = 0;
						for(SYSelfInspDetailVo vo_t1 : detail_t1_List) {
							result += mesDAO.insert_selfInspDetail(vo_t1);
						}
					}
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result; 
	}*/
	
	/*public int insert_selfInspDetail_1110(JSONObject jObj) {
		int result = 0;
		JSONParser parser = new JSONParser();
		JSONObject dJsonObj = new JSONObject();
		try {
			String pordno = jObj.get("pordno").toString();
			String dept_cd = jObj.get("dept_cd").toString();
			String creator = jObj.get("creator").toString();
			dJsonObj = (JSONObject) parser.parse(jObj.get("detailData").toString());
			
			Object[] keyArr = dJsonObj.keySet().toArray();
			for(Object key : keyArr) {
				System.out.println("Key : " + key.toString());
				JSONArray subDetailObjArr = new JSONArray();
				subDetailObjArr = (JSONArray)dJsonObj.get(key);
				Object[] dKeyArr = ((JSONObject)subDetailObjArr.get(0)).keySet().toArray();
				List<SYSelfInspDetailVo> detail_list = new ArrayList<SYSelfInspDetailVo>();
				// reverse vo ans put to list
				for(int idx=0; idx<subDetailObjArr.size(); idx++) {
					JSONObject rowObj = (JSONObject)subDetailObjArr.get(idx);
					SYSelfInspDetailVo tmpVo = new SYSelfInspDetailVo();
					tmpVo.setDept_cd(dept_cd);
					tmpVo.setPordno(pordno);
					tmpVo.setUpdater(creator);
					for(Object skey : dKeyArr) {
						String nKey = skey.toString();
						String nValue = (rowObj.get(nKey)==null)?"":rowObj.get(nKey).toString();
						if ( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
						else if ( "sidetail_code".equals(nKey) )  tmpVo.setSidetail_code(nValue);
						else if ( "sidetail_seq".equals(nKey) )  tmpVo.setSidetail_seq(nValue);
						else if ( "routing_code".equals(nKey) )  tmpVo.setRouting_code(nValue);
						else if ( "display_seq".equals(nKey) )  tmpVo.setDisplay_seq(nValue);
						else if ( "minsp_name".equals(nKey) )  tmpVo.setMinsp_name(nValue);
						else if ( "sinsp_name".equals(nKey) )  tmpVo.setSinsp_name(nValue);
						else if ( "insp_standard".equals(nKey) )  tmpVo.setInsp_standard(nValue);
						else if ( "insp_state".equals(nKey) )  tmpVo.setInsp_state(nValue);
						else if ( "insp_value".equals(nKey) )  tmpVo.setInsp_value(nValue);
						else if ( "member_emp_no".equals(nKey) )  tmpVo.setMember_emp_no(nValue);
						else if ( "member_nm".equals(nKey) )  tmpVo.setMember_nm(nValue);
						else if ( "work_date".equals(nKey) )  tmpVo.setWork_date(nValue);
						else if ( "remark".equals(nKey) )  tmpVo.setRemark(nValue);
					}
					detail_list.add(tmpVo);
				}
				for(SYSelfInspDetailVo dVo : detail_list) {
					result += mesDAO.insert_selfInspDetail(dVo);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result; 
	}*/
	
	/*public int update_selfInspDetail_1210(JSONObject jObj) {
		int result = 0;
		//List<SYSelfInspDetailVo> voList
//		result = mesDAO.insert_selfInspDetail(voList);
		JSONParser parser = new JSONParser();
		JSONArray dJsonArr_p1 = new JSONArray();
		JSONArray dJsonArr_p2 = new JSONArray();
		JSONArray dJsonArr_p5 = new JSONArray();
		JSONArray dJsonArr_t1 = new JSONArray();
		JSONObject dJsonObj = new JSONObject();
		try {
			String pordno = jObj.get("pordno").toString();
			String dept_cd = jObj.get("dept_cd").toString();
			String updater = jObj.get("updater").toString();
			if(jObj.get("detailData")!=null) {
				dJsonObj = (JSONObject) parser.parse(jObj.get("detailData").toString());
				
				Object[] keyArr = dJsonObj.keySet().toArray();
				// by routing_code jsonObject array
				for(Object key : keyArr) {
					System.out.println("Key : " + key.toString());
					JSONArray subDetailObjArr = new JSONArray();
					subDetailObjArr = (JSONArray)dJsonObj.get(key);
					Object[] dKeyArr = ((JSONObject)subDetailObjArr.get(0)).keySet().toArray();
					List<SYSelfInspDetailVo> detail_list = new ArrayList<SYSelfInspDetailVo>();
					// reverse vo ans put to list
					for(int idx=0; idx<subDetailObjArr.size(); idx++) {
						JSONObject rowObj = (JSONObject)subDetailObjArr.get(idx);
						SYSelfInspDetailVo tmpVo = new SYSelfInspDetailVo();
						tmpVo.setDept_cd(dept_cd);
						tmpVo.setPordno(pordno);
						tmpVo.setUpdater(updater);
						for(Object skey : dKeyArr) {
							String nKey = skey.toString();
							String nValue = (rowObj.get(nKey)==null)?"":rowObj.get(nKey).toString();
							if ( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
							else if ( "sidetail_code".equals(nKey) )  tmpVo.setSidetail_code(nValue);
							else if ( "sidetail_seq".equals(nKey) )  tmpVo.setSidetail_seq(nValue);
							else if ( "routing_code".equals(nKey) )  tmpVo.setRouting_code(nValue);
							else if ( "display_seq".equals(nKey) )  tmpVo.setDisplay_seq(nValue);
							else if ( "minsp_name".equals(nKey) )  tmpVo.setMinsp_name(nValue);
							else if ( "sinsp_name".equals(nKey) )  tmpVo.setSinsp_name(nValue);
							else if ( "insp_standard".equals(nKey) )  tmpVo.setInsp_standard(nValue);
							else if ( "insp_state".equals(nKey) )  tmpVo.setInsp_state(nValue);
							else if ( "insp_value".equals(nKey) )  tmpVo.setInsp_value(nValue);
							else if ( "member_emp_no".equals(nKey) )  tmpVo.setMember_emp_no(nValue);
							else if ( "member_nm".equals(nKey) )  tmpVo.setMember_nm(nValue);
							else if ( "work_date".equals(nKey) )  tmpVo.setWork_date(nValue);
							else if ( "remark".equals(nKey) )  tmpVo.setRemark(nValue);
						}
						detail_list.add(tmpVo);
					}
					for(SYSelfInspDetailVo dVo : detail_list) {
						result += mesDAO.update_selfInspDetail(dVo);
					}
				}
			} else {
				dJsonArr_p1 = (JSONArray) parser.parse(jObj.get("grid_p1_data").toString());
				dJsonArr_p2 = (JSONArray) parser.parse(jObj.get("grid_p2_data").toString());
				dJsonArr_p5 = (JSONArray) parser.parse(jObj.get("grid_p5_data").toString());
				dJsonArr_t1 = (JSONArray) parser.parse(jObj.get("grid_t1_data").toString());
				
				JSONObject jObj_p1 = (JSONObject)dJsonArr_p1.get(0);
				Object[] keyArr = jObj_p1.keySet().toArray();
				List<SYSelfInspDetailVo> detail_p1_List = new ArrayList<SYSelfInspDetailVo>();
				for(int idx=0; idx<dJsonArr_p1.size(); idx++) {
					JSONObject rowObj = (JSONObject)dJsonArr_p1.get(idx);
					SYSelfInspDetailVo tmpVo = new SYSelfInspDetailVo();
					tmpVo.setDept_cd(dept_cd);
					tmpVo.setPordno(pordno);
					tmpVo.setUpdater(updater);
					for(Object key : keyArr) {
						String nKey = key.toString();
						String nValue = (rowObj.get(nKey)==null)?"":rowObj.get(nKey).toString();
						if ( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
						else if ( "sidetail_code".equals(nKey) )  tmpVo.setSidetail_code(nValue);
						else if ( "sidetail_seq".equals(nKey) )  tmpVo.setSidetail_seq(nValue);
						else if ( "routing_code".equals(nKey) )  tmpVo.setRouting_code(nValue);
						else if ( "display_seq".equals(nKey) )  tmpVo.setDisplay_seq(nValue);
						else if ( "minsp_name".equals(nKey) )  tmpVo.setMinsp_name(nValue);
						else if ( "sinsp_name".equals(nKey) )  tmpVo.setSinsp_name(nValue);
						else if ( "insp_standard".equals(nKey) )  tmpVo.setInsp_standard(nValue);
						else if ( "insp_state".equals(nKey) )  tmpVo.setInsp_state(nValue);
						else if ( "insp_value".equals(nKey) )  tmpVo.setInsp_value(nValue);
						else if ( "member_emp_no".equals(nKey) )  tmpVo.setMember_emp_no(nValue);
						else if ( "member_nm".equals(nKey) )  tmpVo.setMember_nm(nValue);
						else if ( "work_date".equals(nKey) )  tmpVo.setWork_date(nValue);
						else if ( "remark".equals(nKey) )  tmpVo.setRemark(nValue);
					}
					detail_p1_List.add(tmpVo);
				}
				
				List<SYSelfInspDetailVo> detail_p2_List = new ArrayList<SYSelfInspDetailVo>();
				for(int idx=0; idx<dJsonArr_p2.size(); idx++) {
					JSONObject rowObj = (JSONObject)dJsonArr_p2.get(idx);
					SYSelfInspDetailVo tmpVo = new SYSelfInspDetailVo();
					tmpVo.setDept_cd(dept_cd);
					tmpVo.setPordno(pordno);
					tmpVo.setUpdater(updater);
					for(Object key : keyArr) {
						String nKey = key.toString();
						String nValue = (rowObj.get(nKey)==null)?"":rowObj.get(nKey).toString();
						if ( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
						else if ( "sidetail_code".equals(nKey) )  tmpVo.setSidetail_code(nValue);
						else if ( "sidetail_seq".equals(nKey) )  tmpVo.setSidetail_seq(nValue);
						else if ( "routing_code".equals(nKey) )  tmpVo.setRouting_code(nValue);
						else if ( "display_seq".equals(nKey) )  tmpVo.setDisplay_seq(nValue);
						else if ( "minsp_name".equals(nKey) )  tmpVo.setMinsp_name(nValue);
						else if ( "sinsp_name".equals(nKey) )  tmpVo.setSinsp_name(nValue);
						else if ( "insp_standard".equals(nKey) )  tmpVo.setInsp_standard(nValue);
						else if ( "insp_state".equals(nKey) )  tmpVo.setInsp_state(nValue);
						else if ( "insp_value".equals(nKey) )  tmpVo.setInsp_value(nValue);
						else if ( "member_emp_no".equals(nKey) )  tmpVo.setMember_emp_no(nValue);
						else if ( "member_nm".equals(nKey) )  tmpVo.setMember_nm(nValue);
						else if ( "work_date".equals(nKey) )  tmpVo.setWork_date(nValue);
						else if ( "remark".equals(nKey) )  tmpVo.setRemark(nValue);
					}
					detail_p2_List.add(tmpVo);
				}
				List<SYSelfInspDetailVo> detail_p5_List = new ArrayList<SYSelfInspDetailVo>();
				for(int idx=0; idx<dJsonArr_p5.size(); idx++) {
					JSONObject rowObj = (JSONObject)dJsonArr_p5.get(idx);
					SYSelfInspDetailVo tmpVo = new SYSelfInspDetailVo();
					tmpVo.setDept_cd(dept_cd);
					tmpVo.setPordno(pordno);
					tmpVo.setUpdater(updater);
					for(Object key : keyArr) {
						String nKey = key.toString();
						String nValue = (rowObj.get(nKey)==null)?"":rowObj.get(nKey).toString();
						if ( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
						else if ( "sidetail_code".equals(nKey) )  tmpVo.setSidetail_code(nValue);
						else if ( "sidetail_seq".equals(nKey) )  tmpVo.setSidetail_seq(nValue);
						else if ( "routing_code".equals(nKey) )  tmpVo.setRouting_code(nValue);
						else if ( "display_seq".equals(nKey) )  tmpVo.setDisplay_seq(nValue);
						else if ( "minsp_name".equals(nKey) )  tmpVo.setMinsp_name(nValue);
						else if ( "sinsp_name".equals(nKey) )  tmpVo.setSinsp_name(nValue);
						else if ( "insp_standard".equals(nKey) )  tmpVo.setInsp_standard(nValue);
						else if ( "insp_state".equals(nKey) )  tmpVo.setInsp_state(nValue);
						else if ( "insp_value".equals(nKey) )  tmpVo.setInsp_value(nValue);
						else if ( "member_emp_no".equals(nKey) )  tmpVo.setMember_emp_no(nValue);
						else if ( "member_nm".equals(nKey) )  tmpVo.setMember_nm(nValue);
						else if ( "work_date".equals(nKey) )  tmpVo.setWork_date(nValue);
						else if ( "remark".equals(nKey) )  tmpVo.setRemark(nValue);
					}
					detail_p5_List.add(tmpVo);
				}
				List<SYSelfInspDetailVo> detail_t1_List = new ArrayList<SYSelfInspDetailVo>();
				for(int idx=0; idx<dJsonArr_t1.size(); idx++) {
					JSONObject rowObj = (JSONObject)dJsonArr_t1.get(idx);
					SYSelfInspDetailVo tmpVo = new SYSelfInspDetailVo();
					tmpVo.setDept_cd(dept_cd);
					tmpVo.setPordno(pordno);
					tmpVo.setUpdater(updater);
					for(Object key : keyArr) {
						String nKey = key.toString();
						String nValue = (rowObj.get(nKey)==null)?"":rowObj.get(nKey).toString();
						if ( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
						else if ( "sidetail_code".equals(nKey) )  tmpVo.setSidetail_code(nValue);
						else if ( "sidetail_seq".equals(nKey) )  tmpVo.setSidetail_seq(nValue);
						else if ( "routing_code".equals(nKey) )  tmpVo.setRouting_code(nValue);
						else if ( "display_seq".equals(nKey) )  tmpVo.setDisplay_seq(nValue);
						else if ( "minsp_name".equals(nKey) )  tmpVo.setMinsp_name(nValue);
						else if ( "sinsp_name".equals(nKey) )  tmpVo.setSinsp_name(nValue);
						else if ( "insp_standard".equals(nKey) )  tmpVo.setInsp_standard(nValue);
						else if ( "insp_state".equals(nKey) )  tmpVo.setInsp_state(nValue);
						else if ( "insp_value".equals(nKey) )  tmpVo.setInsp_value(nValue);
						else if ( "member_emp_no".equals(nKey) )  tmpVo.setMember_emp_no(nValue);
						else if ( "member_nm".equals(nKey) )  tmpVo.setMember_nm(nValue);
						else if ( "work_date".equals(nKey) )  tmpVo.setWork_date(nValue);
						else if ( "remark".equals(nKey) )  tmpVo.setRemark(nValue);
					}
					detail_t1_List.add(tmpVo);
				}
				for(SYSelfInspDetailVo vo_p1 : detail_p1_List) {
					result += mesDAO.update_selfInspDetail(vo_p1);
				}
				if( dJsonArr_p1.size()==result ) {
					result = 0;
					for(SYSelfInspDetailVo vo_p2 : detail_p2_List) {
						result += mesDAO.update_selfInspDetail(vo_p2);
					}
					if( dJsonArr_p2.size()==result ) {
						result = 0;
						for(SYSelfInspDetailVo vo_p5 : detail_p5_List) {
							result += mesDAO.update_selfInspDetail(vo_p5);
						}
						if( dJsonArr_p5.size()==result ) {
							result = 0;
							for(SYSelfInspDetailVo vo_t1 : detail_t1_List) {
								result += mesDAO.update_selfInspDetail(vo_t1);
							}
						}
					}
				}
				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result; 
	}*/
	
	/*public int update_selfInspDetail_1110(JSONObject jObj) {
		int result = 0;
		//List<SYSelfInspDetailVo> voList
//		result = mesDAO.insert_selfInspDetail(voList);
		JSONParser parser = new JSONParser();
		JSONObject dJsonObj = new JSONObject();
		try {
			String pordno = jObj.get("pordno").toString();
			String dept_cd = jObj.get("dept_cd").toString();
			String updater = jObj.get("updater").toString();
			dJsonObj = (JSONObject) parser.parse(jObj.get("detailData").toString());
			
			Object[] keyArr = dJsonObj.keySet().toArray();
			// by routing_code jsonObject array
			for(Object key : keyArr) {
				System.out.println("Key : " + key.toString());
				JSONArray subDetailObjArr = new JSONArray();
				subDetailObjArr = (JSONArray)dJsonObj.get(key);
				Object[] dKeyArr = ((JSONObject)subDetailObjArr.get(0)).keySet().toArray();
				List<SYSelfInspDetailVo> detail_list = new ArrayList<SYSelfInspDetailVo>();
				// reverse vo ans put to list
				for(int idx=0; idx<subDetailObjArr.size(); idx++) {
					JSONObject rowObj = (JSONObject)subDetailObjArr.get(idx);
					SYSelfInspDetailVo tmpVo = new SYSelfInspDetailVo();
					tmpVo.setDept_cd(dept_cd);
					tmpVo.setPordno(pordno);
					tmpVo.setUpdater(updater);
					for(Object skey : dKeyArr) {
						String nKey = skey.toString();
						String nValue = (rowObj.get(nKey)==null)?"":rowObj.get(nKey).toString();
						if ( "simaster_gr_no".equals(nKey) ) tmpVo.setSimaster_gr_no(nValue);
						else if ( "sidetail_code".equals(nKey) )  tmpVo.setSidetail_code(nValue);
						else if ( "sidetail_seq".equals(nKey) )  tmpVo.setSidetail_seq(nValue);
						else if ( "routing_code".equals(nKey) )  tmpVo.setRouting_code(nValue);
						else if ( "display_seq".equals(nKey) )  tmpVo.setDisplay_seq(nValue);
						else if ( "minsp_name".equals(nKey) )  tmpVo.setMinsp_name(nValue);
						else if ( "sinsp_name".equals(nKey) )  tmpVo.setSinsp_name(nValue);
						else if ( "insp_standard".equals(nKey) )  tmpVo.setInsp_standard(nValue);
						else if ( "insp_state".equals(nKey) )  tmpVo.setInsp_state(nValue);
						else if ( "insp_value".equals(nKey) )  tmpVo.setInsp_value(nValue);
						else if ( "member_emp_no".equals(nKey) )  tmpVo.setMember_emp_no(nValue);
						else if ( "member_nm".equals(nKey) )  tmpVo.setMember_nm(nValue);
						else if ( "work_date".equals(nKey) )  tmpVo.setWork_date(nValue);
						else if ( "remark".equals(nKey) )  tmpVo.setRemark(nValue);
					}
					detail_list.add(tmpVo);
				}
				for(SYSelfInspDetailVo dVo : detail_list) {
					result += mesDAO.update_selfInspDetail(dVo);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result; 
	}*/

	public List<SYProdVo> grade_matnr_chk(String pordnos) {
		
		ArrayList<String> list=  new ArrayList<String>();
        
		String[] arrPordno = pordnos.split(","); 
		for(int i=0;i<arrPordno.length;i++) {
			list.add(arrPordno[i]);
		}
		return mesDAO.grade_matnr_chk(list);
	}

	public int grade_loc_update(String params) {
		JSONParser jsonParser = new JSONParser();
		
		JSONArray masArr = new JSONArray();

		int result = 0;
		
 		try{
 			masArr = (JSONArray) jsonParser.parse(params);
			JSONObject masObj = (JSONObject)masArr.get(0);	// for get key
			Object[] masObj_keyArr = masObj.keySet().toArray();
			
			// insert master Data
			for(int idx=0; idx<masArr.size(); idx++){
				JSONObject jObj = (JSONObject)masArr.get(idx);
				SYProdVo masVo = new SYProdVo();

				for(Object key : masObj_keyArr){	// json keys
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();

					if( "pordno".equals(nKey) ) masVo.setPordno(nValue);
					else if( "lgort".equals(nKey)) masVo.setLgort(nValue);
					
				}

				result = mesDAO.grade_loc_update(masVo);
			}
 		} catch(Exception ex){
 			
 		} 
 		return result;
	}

	public String maktx_select(String _matnr) {
		return mesDAO.maktx_select(_matnr);
	}
	
	public int selfInspMaster_update(SYSelfInspMasterVo vo) {
		return mesDAO.selfInspMaster_update(vo);
	}
	
	public int selfInspMaster_new_insert(SYSelfInspMasterVo vo) {
		return mesDAO.selfInspMaster_new_insert(vo);
	}
	
	public int selfInspMaster_matnr_insert(SYSelfInspMasterVo vo) {
		return mesDAO.selfInspMaster_matnr_insert(vo);
	}
	
	public int selfInspHeader_update(SYSelfInspHeaderVo vo) {
		return mesDAO.selfInspHeader_update(vo);
	}
	
	public int selfInspHeader_insert(SYSelfInspHeaderVo vo) {
		return mesDAO.selfInspHeader_insert(vo);
	}
	
	public int selfInspDetail_update(SYSelfInspDetailVo vo) {
		return mesDAO.selfInspDetail_update(vo);
	}
	
	public int selfInspDetail_insert(SYSelfInspDetailVo vo) {
		return mesDAO.selfInspDetail_insert(vo);
	}
	
	public List<SYSelfInspMasterVo> checkDuplicateMatnr(SYSelfInspMasterVo vo) {
		return mesDAO.checkDuplicateMatnr(vo);
	}
	
	public List<SYSelfInspMasterVo> select_v_selfinsp_master(SYSelfInspMasterVo vo) {
		return mesDAO.select_v_selfinsp_master(vo);
	}

	public int v_selfInspMaster_new_insert(SYSelfInspMasterVo vo) {
		return mesDAO.v_selfInspMaster_new_insert(vo);
	}

	public int v_selfInspMaster_matnr_insert(SYSelfInspMasterVo vo) {
		return mesDAO.v_selfInspMaster_matnr_insert(vo);
	}

	public int v_selfInspHeader_insert(SYSelfInspHeaderVo tmpVo) {
		return mesDAO.v_selfInspHeader_insert(tmpVo);
	}

	public int v_selfInspHeader_update(SYSelfInspHeaderVo tmpVo) {
		return mesDAO.v_selfInspHeader_update(tmpVo);
	}

	public List<SYSelfInspHeaderVo> select_v_selfinsp_header(	SYSelfInspHeaderVo vo) {
		return mesDAO.select_v_selfinsp_header(vo);
	}
	public List<SYSelfInspDetailVo> select_v_selfinsp_detail(SYSelfInspDetailVo vo) {
		return mesDAO.select_v_selfinsp_detail(vo);	
	}
	public List<SYSelfInspMasterVo> v_checkDuplicateMatnr(SYSelfInspMasterVo vo) {
		return mesDAO.v_checkDuplicateMatnr(vo);
	}
	public int v_selfInspMaster_update(SYSelfInspMasterVo vo) {
		return mesDAO.v_selfInspMaster_update(vo);
	}
	public int v_selfInspDetail_insert(SYSelfInspDetailVo vo) {
		return mesDAO.v_selfInspDetail_insert(vo);
	}
	public int v_selfInspDetail_update(SYSelfInspDetailVo vo) {
		return mesDAO.v_selfInspDetail_update(vo);
	}
	
}
