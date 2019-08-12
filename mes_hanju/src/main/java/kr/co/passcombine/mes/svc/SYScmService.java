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
import kr.co.passcombine.mes.sap.VmesJcoConnectVo;
import kr.co.passcombine.mes.sap.VmesJcoConnection;
import kr.co.passcombine.mes.vo.SYHubBomVo;
import kr.co.passcombine.mes.vo.SYInInspVo;
import kr.co.passcombine.mes.vo.SYMoveTypeVo;
import kr.co.passcombine.mes.vo.SYProdVo;
import kr.co.passcombine.mes.vo.SYReqmMatnrTblVo;
import kr.co.passcombine.mes.vo.SYScmIssueDetailVo;
import kr.co.passcombine.mes.vo.SYScmRawCommentVo;
import kr.co.passcombine.mes.vo.SYScmRawDeliveryVo;
import kr.co.passcombine.mes.vo.SYScmRawProcSernrVo;
import kr.co.passcombine.mes.vo.SYScmRawProcSubVo;
import kr.co.passcombine.mes.vo.SYScmRawProcVo;
import kr.co.passcombine.mes.vo.SYScmRawSernrVo;
import kr.co.passcombine.mes.vo.SYMesCodeVo;
import kr.co.passcombine.mes.vo.SYScmRawVendorResultVo;
import kr.co.passcombine.mes.vo.SYSlocMasterVo;
import kr.co.passcombine.mes.vo.SYStockVo;
import kr.co.passcombine.mes.vo.SYTransReceiptVo;
import kr.co.passcombine.mes.vo.SYVendorVo;
import kr.co.passcombine.mes.vo.SYWfwotherVo;
import kr.co.passcombine.mes.vo.SYScmBomVo;

import kr.co.passcombine.mes.util.ExportExcelUtil;
import kr.co.passcombine.mes.util.SessionUtil;

@Service(value = "vmesScmService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYScmService {

	// private static final Logger logger = LoggerFactory.getLogger(SYCodeService.class);
	@Resource
	private Environment environment;
	
	@Resource(name = "vmesScmDAO")
	private SYScmDAO scmDAO;
	
	@Transactional
	public List<SYScmRawDeliveryVo> deliveryReq_select(SYScmRawDeliveryVo scmRVo){
		return scmDAO.deliveryReq_select(scmRVo);
	}
	
	@Transactional
	public List<SYScmRawDeliveryVo> deliveryVendor_select(SYScmRawDeliveryVo scmRVo){
		return scmDAO.deliveryVendor_select(scmRVo);
	}
	
	@Transactional
	public List<SYMesCodeVo> getStaCodeList_select(SYMesCodeVo codeVo){
		return scmDAO.getStaCodeList_select(codeVo);
	}
	
	public List<SYScmRawDeliveryVo> rawDelivery_selectByKey(SYScmRawDeliveryVo sVo){
		return scmDAO.rawDelivery_selectByKey(sVo);
	}
	
	@Transactional
	public int scmRawDelivery_update(SYScmRawDeliveryVo scmRVo){
		return scmDAO.scmRawDelivery_update(scmRVo);
	}
	
	@Transactional
	public int deliverySta_update(SYScmRawDeliveryVo scmRVo){
		return scmDAO.deliverySta_update(scmRVo);
	}
	
	@Transactional
	public int scmRawDeliveryDiff_update(SYScmRawDeliveryVo scmRVo){
		return scmDAO.scmRawDeliveryDiff_update(scmRVo);
	}
	
	@Transactional
	public int selectDeliveryVendorCount(SYScmRawDeliveryVo scmRVo){
		return scmDAO.selectDeliveryVendorCount(scmRVo);
	}
	/*
	@Transactional
	public int material_recv_master_insert(SYZmmfmMatMasterVo sVo){
		return scmDAO.material_recv_master_insert(sVo);
	}

	@Transactional
	public int material_recv_detail_insert(SYZmmfmMatMasterVo sVo){
		return scmDAO.material_recv_detail_insert(sVo);
	}
	
	@Transactional
	public List<SYZmmfmMatMasterVo> material_recv_master_exist_chk(SYZmmfmMatMasterVo sVo){
		return scmDAO.material_recv_master_exist_chk(sVo);
	}*/

	@Transactional
	public int rawDelivery_insert(SYScmRawDeliveryVo sVo){
		return scmDAO.rawDelivery_insert(sVo);
	}

	@Transactional
	public int rawDelivery_update(SYScmRawDeliveryVo sVo){
		return scmDAO.rawDelivery_update(sVo);
	}
	
	@Transactional
	public int rawDelivery_partial_update(SYScmRawDeliveryVo sVo){
		return scmDAO.rawDelivery_partial_update(sVo);
	}
	
	@Transactional
	public List<SYScmRawDeliveryVo> rawDelivery_select(SYScmRawDeliveryVo sVo) {
		return scmDAO.rawDelivery_select(sVo);
	}
	
	@Transactional
	public int rawVendorResult_insert(SYScmRawVendorResultVo sVo){
		return scmDAO.rawVendorResult_insert(sVo);
	}

	@Transactional
	public int rawVendorResultSta_update(SYScmRawVendorResultVo sVo){
		return scmDAO.rawVendorResultSta_update(sVo);
	}
	/*
	@Transactional
	public int inInsp_insert(List<SYScmRawVendorResultVo> vList) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c1 = Calendar.getInstance();
		String strToday = sdf.format(c1.getTime());
		
		ArrayList<String> matnrList =  new ArrayList<String>();
//		SYScmRawVendorResultVo -> SYInInspVo change 
		List<SYInInspVo> iList = new ArrayList<SYInInspVo>();
		for( SYScmRawVendorResultVo vo : vList ) {
			SYInInspVo tmpVo = new SYInInspVo();
			tmpVo.setEbeln(vo.getEbeln());
			tmpVo.setEbelp(vo.getEbelp());
			tmpVo.setPartial_seq(vo.getPartial_seq());
			tmpVo.setMatnr(vo.getMatnr());
			matnrList.add(vo.getMatnr());
			tmpVo.setRorder_status(vo.getRorder_status());
			tmpVo.setRvendor_status(vo.getRvendor_status());
			tmpVo.setConfirm_date(vo.getConfirm_date());
			tmpVo.setOrder_delivery_date(vo.getOrder_delivery_date());
			tmpVo.setVendor_delivery_date(vo.getVendor_delivery_date());
			tmpVo.setMenge(vo.getMenge());
			tmpVo.setZdeli_menge(vo.getZdeli_menge());
			tmpVo.setWerks(vo.getWerks());
			tmpVo.setBukrs(vo.getBukrs());
			tmpVo.setLgort(vo.getLgort());
			tmpVo.setDiff_date(vo.getDiff_date());
			tmpVo.setMblnr(vo.getMblnr());
			tmpVo.setMjahr(vo.getMjahr());
			tmpVo.setSap_doc_no(vo.getSap_doc_no());
			tmpVo.setLabnr(vo.getLabnr());
			tmpVo.setIn_labnr((vo.getLabnr()).substring(0, 11) + "1" + (vo.getLabnr()).substring(12, 19));	//4500000065-0004-0001
			tmpVo.setLifnr(vo.getLifnr());
			tmpVo.setRef_doc_no(vo.getRef_doc_no());
			if( "Y".equals(vo.getMesr()) )
				tmpVo.setInsp_gubun("IF");
			else
				tmpVo.setInsp_gubun("IB");
			tmpVo.setInsp_check_gubun(vo.getMesg());
			tmpVo.setConfirm_date(vo.getConfirm_date());
			tmpVo.setIn_delivery_date(strToday);
			tmpVo.setInsp_status("i1");
			iList.add(tmpVo);
		}
		// update volist, material info
		List<SYZmmfmMatMasterVo> matList = scmDAO.matMasterGetMesi_selectAll(matnrList);
		int result = 0;
		for( SYInInspVo vo : iList ) {
			String matnr = vo.getMatnr();
			for( SYZmmfmMatMasterVo mVo : matList ) {
				if( matnr.equals(mVo.getMatnr()) ){
					vo.setMaktx(mVo.getMaktx());
					vo.setWrkst(mVo.getWrkst());
					vo.setMeins(mVo.getMeins());
				}
			}
			result += scmDAO.inInsp_insert(vo);
		}
		return result;
	}*/
	/*
	@Transactional
	public int inInsp_insert_proc(List<SYScmRawProcVo> vList) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c1 = Calendar.getInstance();
		String strToday = sdf.format(c1.getTime());
		
		ArrayList<String> matnrList =  new ArrayList<String>();
//		SYScmRawVendorResultVo -> SYInInspVo change 
		List<SYInInspVo> iList = new ArrayList<SYInInspVo>();
		for( SYScmRawProcVo vo : vList ) {
//			System.out.println(vo.getLabnr());
			SYInInspVo tmpVo = new SYInInspVo();
			tmpVo.setEbeln(vo.getEbeln());
			tmpVo.setEbelp(vo.getEbelp());
//			tmpVo.setPartial_seq(vo.getPartial_seq());
			tmpVo.setMatnr(vo.getMatnr());
			matnrList.add(vo.getMatnr());
			tmpVo.setRorder_status(vo.getRorder_status());
			tmpVo.setRvendor_status(vo.getRvendor_status());
			tmpVo.setConfirm_date(vo.getConfirm_date());
			tmpVo.setOrder_delivery_date(vo.getOrder_delivery_date());
			tmpVo.setVendor_delivery_date(vo.getVendor_delivery_date());
			tmpVo.setMenge(vo.getMenge());
			tmpVo.setZdeli_menge(vo.getZdeli_menge());
			tmpVo.setWerks(vo.getWerks());
			tmpVo.setBukrs(vo.getBukrs());
			tmpVo.setLgort(vo.getLgort());
			tmpVo.setDiff_date(vo.getDiff_date());
			tmpVo.setMblnr(vo.getMblnr());
			tmpVo.setMjahr(vo.getMjahr());
			tmpVo.setSap_doc_no(vo.getSap_doc_no());
			if( vo.getLabnr()!=null && !"".equals(vo.getLabnr()) ) {
				tmpVo.setLabnr(vo.getLabnr());
				tmpVo.setIn_labnr((vo.getLabnr()).substring(0, 11) + "1" + (vo.getLabnr()).substring(12, 19));	//4500000065-0004-0001
			}
			tmpVo.setLifnr(vo.getLifnr());
			tmpVo.setRef_doc_no(vo.getRef_doc_no());
			if( "Y".equals(vo.getMesr()) )
				tmpVo.setInsp_gubun("IF");
			else
				tmpVo.setInsp_gubun("IB");
			tmpVo.setInsp_check_gubun(vo.getMesg());
			tmpVo.setConfirm_date(vo.getConfirm_date());
//			tmpVo.setIn_delivery_date(strToday);
			tmpVo.setIn_delivery_date(vo.getOrder_delivery_date());
			tmpVo.setInsp_status("i1");
//			System.out.println("tmpVo.getLabnr() : " + tmpVo.getLabnr());
			iList.add(tmpVo);
		}
		// update volist, material info
		List<SYZmmfmMatMasterVo> matList = scmDAO.matMasterGetMesi_selectAll(matnrList);
		int result = 0;
		for( SYInInspVo vo : iList ) {
			String matnr = vo.getMatnr();
			for( SYZmmfmMatMasterVo mVo : matList ) {
				if( matnr.equals(mVo.getMatnr()) ){
					vo.setMaktx(mVo.getMaktx());
					vo.setWrkst(mVo.getWrkst());
					vo.setMeins(mVo.getMeins());
				}
			}
//			System.out.println("vo.getLabnr() : " + vo.getLabnr());
//			if( exist_insp_select(vo) ) { //exist data -> increse partial_seq -> remove vo.setPartial_seq(); AUTOSEQ관련 나중에반영해야하는데 쿼리로 나눠야함
//				vo.setPartial_seq(null);
//			}
			result += scmDAO.inInsp_insert(vo);
		}
		return result;
	}*/

	@Transactional
	public boolean exist_insp_select(SYInInspVo vo){
		List<SYInInspVo> list = scmDAO.exist_insp_select(vo);
		boolean returnVal = false;
		if( list.size()>0 ) {
			returnVal = true;
		}
		return returnVal;
	}

	@Transactional
	public int rawDeliverySta_update(SYScmRawDeliveryVo dVo){
		return scmDAO.rawDeliverySta_update(dVo);
	}
	
	@Transactional
	public int raw_comment_insert(SYScmRawCommentVo sVo){
		return scmDAO.raw_comment_insert(sVo);
	}
	/*
	@Transactional
	public SYZmmfmMatMasterVo matMasterGetMesi_select(String matnr) {
		return scmDAO.matMasterGetMesi_select(matnr);
	}
	
	@Transactional
	public List<SYZmmfmMatMasterVo> matMasterGetMesi_selectAll(JSONArray listData) {
		ArrayList<String> list =  new ArrayList<String>();
		for(int idx=0; idx<listData.size(); idx++ ) {
			JSONObject jObj = (JSONObject)listData.get(idx);
			list.add(jObj.get("matnr").toString());
		}
		return scmDAO.matMasterGetMesi_selectAll(list);
	}*/

	@Transactional
	public List<SYScmRawVendorResultVo> rawVendor_select(SYScmRawVendorResultVo vVo) {
		return scmDAO.rawVendor_select(vVo);
	}
	
	@Transactional
	public List<SYScmRawVendorResultVo> rawVendor_selectAll(SYScmRawVendorResultVo vVo) {	// del
		return scmDAO.rawVendor_selectAll(vVo);
	}
	
	@Transactional
	public List<SYScmRawProcVo> rawProc_select(SYScmRawProcVo vVo) {
		return scmDAO.rawProc_select(vVo);
	}
	
	@Transactional
	public List<SYScmRawProcSubVo> rawProcSub_select(SYScmRawProcSubVo vVo) {
		return scmDAO.rawProcSub_select(vVo);
	}
	
	@Transactional
	public List<SYScmRawVendorResultVo> getUniqueKeyList(JSONArray listData) {
		ArrayList<String> list =  new ArrayList<String>();
		for(int idx=0; idx<listData.size(); idx++ ) {
			JSONObject jObj = (JSONObject)listData.get(idx);
			list.add(jObj.get("ebeln").toString());
		}
		return scmDAO.getUniqueKeyList(list);
	}

	@Transactional
	public List<SYScmRawProcVo> getProcUniqueKeyList(JSONArray listData) {
		ArrayList<String> list =  new ArrayList<String>();
		for(int idx=0; idx<listData.size(); idx++ ) {
			list.add(listData.get(idx).toString());
		}
		return scmDAO.getProcUniqueKeyList(list);
	}

	public List<SYReqmMatnrTblVo> matnr_select(SYReqmMatnrTblVo sVo) {
		return scmDAO.matnr_select(sVo);
	}

	public int matnr_select_count(SYReqmMatnrTblVo sVo) {
		return scmDAO.matnr_select_count(sVo);
	}
	
	public String reqm_matnr_tbl_key_select_1() {
		return scmDAO.reqm_matnr_tbl_key_select_1();
	}
	
	
	public int stk_request_insert(SYReqmMatnrTblVo sVo) {
		
		JSONParser jsonParser = new JSONParser();
		
		JSONArray masArr = new JSONArray();
		JSONArray detArr = new JSONArray();
		
		int result = 0;
		
		String newKey = reqm_matnr_tbl_key_select_1();

		sVo.setReqm_matnr_key(newKey);
		System.out.println(sVo.getJsonStr());
		try{
			masArr = (JSONArray) jsonParser.parse(sVo.getJsonStr());
			JSONObject masObj = (JSONObject)masArr.get(0);	// for get key
			Object[] masObj_keyArr = masObj.keySet().toArray();
			
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
					else if( "meins".equals(nKey)) masVo.setMeins(nValue);
					else if( "request_bdmng".equals(nKey)) masVo.setRequest_bdmng(nValue);
					else if( "grade".equals(nKey)) masVo.setGrade_yn(nValue);
					else if( "proc_gubun".equals(nKey) ) {
						if(nValue.equals("Y")) {
							masVo.setProc_gubun(nValue);
						} else {
							masVo.setProc_gubun(null);
						}
					}
					masVo.setRequester_status("Y");
					masVo.setGrantor_status("N");
					masVo.setPgm_nm("SCM");
				}
				masVo.setCreator(sVo.getCreator());
//				masVoList.add(masVo);
				result = scmDAO.mstk_request_insert(masVo);
			}
			
			// insert detail Data
			
			List<SYReqmMatnrTblVo> keyList = reqd_matnr_key_select_1(newKey);
			

			for(int idx=0; idx<masArr.size(); idx++){
				JSONObject jObj = (JSONObject)masArr.get(idx);
				SYReqmMatnrTblVo detVo = new SYReqmMatnrTblVo();
				detVo.setReqm_matnr_key(newKey);	// id
				
				for(Object key : masObj_keyArr){	// json keys
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					
					if( "matnr".equals(nKey) ) {
						detVo.setMatnr(nValue);
						
						for( SYReqmMatnrTblVo vo : keyList ) {
							if(nValue.equals(vo.getMatnr())){	
								detVo.setMatnr(vo.getMatnr());
								detVo.setReqm_sub_key(vo.getReqm_sub_key());
							}
						}
					}
					else if( "werks".equals(nKey)) detVo.setWerks(nValue);
					else if( "request_bdmng".equals(nKey)) detVo.setRequest_bdmng(nValue);
					else if( "stge_loc".equals(nKey)) detVo.setStge_loc(nValue);
					else if( "plant".equals(nKey)) detVo.setPlant(nValue);
					else if( "move_stloc".equals(nKey)) detVo.setMove_stloc(nValue);
					else if( "move_plant".equals(nKey)) detVo.setMove_plant(nValue);
					
				}
					result = scmDAO.dstk_request_insert(detVo);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}

	public List<SYReqmMatnrTblVo> reqd_matnr_key_select_1(String newKey) {
		return scmDAO.reqd_matnr_key_select_1(newKey);
	}
	
	public List<SYReqmMatnrTblVo> req_matnr_ord_select(SYReqmMatnrTblVo sVo) {
		return scmDAO.req_matnr_ord_select(sVo);
	}

	public int req_matnr_ord_select_count(SYReqmMatnrTblVo sVo) {
		return scmDAO.req_matnr_ord_select_count(sVo);
	}

	public List<SYSlocMasterVo> scm_sloc_code_select(SYSlocMasterVo sVo) {
		return scmDAO.scm_sloc_code_select(sVo);
	}

	public String makeRefDocNo() {
		return scmDAO.makeRefDocNo();
	}
	
	public int rawVendorResultEbelp_update(SYScmRawVendorResultVo vo) {
		return scmDAO.rawVendorResultEbelp_update(vo);
	}
	
//	public int rawSernrEbelp_update(SYScmRawVendorResultVo vo) {
//		return scmDAO.rawSernrEbelp_update(vo);
//	}
	
	public List<SYWfwotherVo> fwother_select(SYWfwotherVo sVo) {
		return scmDAO.fwother_select(sVo);
	}
	
	public int fwother_select_count(SYWfwotherVo sVo) {
		return scmDAO.fwother_select_count(sVo);
	}

	public int fwother_mst_insert(SYWfwotherVo sVo) {
		
		int result =0;
		
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();

		String newkey = reqm_matnr_tbl_key_select_1();
		try{
			listDataJArray = (JSONArray) jsonParser.parse(sVo.getJsonStr());
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();
			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray.get(idx);
				SYWfwotherVo scmDVo = new SYWfwotherVo();  
				for(Object key : keyArr){
					String nKey = key.toString();
					
					String nValue = (jObj.get(nKey) == null)?"":jObj.get(nKey).toString();
					
					if( "plant".equals(nKey) ) scmDVo.setPlant(nValue);
					else if( "stge_loc".equals(nKey) ) scmDVo.setStge_loc(nValue);
					else if( "costcenter".equals(nKey) ) scmDVo.setCostcenter(nValue);
					else if( "orderid".equals(nKey) ) scmDVo.setOrderid(nValue);
					else if( "move_type".equals(nKey) ) scmDVo.setMove_type(nValue);
					else if( "material".equals(nKey) ) scmDVo.setMaterial(nValue);
					else if( "entry_qnt".equals(nKey) ) scmDVo.setEntry_qnt(nValue);
					else if( "entry_uom".equals(nKey) ) scmDVo.setEntry_uom(nValue);
					else if( "serial_yn".equals(nKey) ) {
						if(nValue.length() > 0)
							scmDVo.setSerial_yn("Y");
						else
							scmDVo.setSerial_yn("N");
					}
					else if( "header_txt".equals(nKey) ) scmDVo.setHeader_txt(nValue);
					else if( "item_text".equals(nKey) ) scmDVo.setItem_text(nValue);
					else if( "req_dt".equals(nKey) ) scmDVo.setReq_dt(nValue);
					else if( "spec_stock".equals(nKey) ) scmDVo.setSpec_stock(nValue);
					else if( "proc_gubun".equals(nKey) ) {
						if(nValue.equals("Y")) {
							scmDVo.setProc_gubun(nValue);
						} else {
							scmDVo.setProc_gubun(null);
						}
					}
				}
				scmDVo.setMatdoc_itm(("00000"+(idx+1)).substring(("00000"+(idx+1)).length()-4, ("00000"+(idx+1)).length()));
				scmDVo.setStatus(sVo.getStatus());
				scmDVo.setGr_rcpt(sVo.getGr_rcpt());
				scmDVo.setUpdater(sVo.getUpdater());
				scmDVo.setCreator(sVo.getCreator());
				scmDVo.setRef_doc_no(newkey);

				result = scmDAO.fwother_mst_insert(scmDVo);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}

	public List<SYWfwotherVo> fwother_conf_header_select(SYWfwotherVo scmRVo) {
		return scmDAO.fwother_conf_header_select(scmRVo);
	}

	public List<SYWfwotherVo> fwother_select_nopage(SYWfwotherVo scmRVo) {
		return scmDAO.fwother_select_nopage(scmRVo);
	}

	public int req_matr_status_update(SYWfwotherVo scmRVo) {
		return scmDAO.req_matr_status_update(scmRVo);
	}

	public int fwother_serial_insert(SYWfwotherVo sVo) {
		
		int result =0;
		
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();

		try{
			
			listDataJArray = (JSONArray) jsonParser.parse(sVo.getJsonStr());
			if(listDataJArray.size() != 0) {
				JSONObject jOb = (JSONObject)listDataJArray.get(0);
				Object[] keyArr = jOb.keySet().toArray();
				for(int idx=0; idx<listDataJArray.size(); idx++){
					JSONObject jObj = new JSONObject();
					jObj = (JSONObject)listDataJArray.get(idx);
					SYWfwotherVo scmDVo = new SYWfwotherVo();  
					for(Object key : keyArr){
						String nKey = key.toString();
						String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
						if( "ref_doc_no".equals(nKey) ) scmDVo.setRef_doc_no(nValue);
						else if( "matdoc_itm".equals(nKey) ) scmDVo.setMatdoc_itm(nValue);
						else if( "serial".equals(nKey) ) scmDVo.setSerialno(nValue);
					}
					result = scmDAO.fwother_serial_insert(scmDVo);
				}
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return result;

	}

	public List<SYWfwotherVo> fwother_serial_select(SYWfwotherVo scmRVo) {
		return scmDAO.fwother_serial_select(scmRVo);
	}

	public int fwother_restore_update(SYWfwotherVo pVo) {
		return scmDAO.fwother_restore_update(pVo);
	}

	public int fwother_restore_delete(SYWfwotherVo pVo) {
		return scmDAO.fwother_restore_delete(pVo);
	}

	public List<SYMoveTypeVo> move_type_select(SYMoveTypeVo scmRVo) {
		return scmDAO.move_type_select(scmRVo);
	}

	public List<SYMoveTypeVo> cost_type_select(SYMoveTypeVo scmRVo) {
		return scmDAO.cost_type_select(scmRVo);
	}

	public List<SYMoveTypeVo> io_type_select(SYMoveTypeVo scmRVo) {
		return scmDAO.io_type_select(scmRVo);
	}

	public int sap_return_update(SYWfwotherVo ppVo) {
		return scmDAO.sap_return_update(ppVo);
		
	}

	public List<SYProdVo> str_stock_select(SYStockVo sVo) {
		return scmDAO.str_stock_select(sVo);
	}

	public int cancel_approval_matr(SYWfwotherVo scmRVo) {
		return scmDAO.cancel_approval_matr(scmRVo);
	}

//	public int cancel_req_ord(SYWfwotherVo scmRVo) {
//		return scmDAO.cancel_req_ord(scmRVo);
//	}
	
	@Transactional 
	public int rawProc_insert(SYScmRawProcVo sVo){
		return scmDAO.rawProc_insert(sVo);
	}
	
	@Transactional
	public int rawProc_update(SYScmRawProcVo scmRVo){
		return scmDAO.rawProc_update(scmRVo);
	}
	
	@Transactional
	public int rawProcLoekzi_update(SYScmRawProcVo vo) {
		return scmDAO.rawProcLoekzi_update(vo);
	}
	
	@Transactional
	public int rawProcEbelp_update(SYScmRawProcVo vo) {
		return scmDAO.rawProcEbelp_update(vo);
	}
	
	@Transactional
	public int rawProcSta_update(SYScmRawProcVo dVo){
		return scmDAO.rawProcSta_update(dVo);
	}

	@Transactional
	public int rawProcKeyCnt_update(SYScmRawProcVo dVo){
		return scmDAO.rawProcKeyCnt_update(dVo);
	}

	@Transactional
	public int rawProcSta_upload(List<SYScmRawProcVo> pList){
		System.out.println("scmService rawProcSta_upload() ");
		int result = 0;
		List<SYScmRawProcVo> updateList = new ArrayList<SYScmRawProcVo>();
		List<SYScmRawProcVo> insertList = new ArrayList<SYScmRawProcVo>();
		for( SYScmRawProcVo vo : pList) {
//			vo.setPartial_seq("0001");
			if( vo.getNo()==null || "".equals(vo.getNo().trim()) ){
				insertList.add(vo);
			} else {
				vo.setRorder_status("r1");
				vo.setRvendor_status("v1");
				updateList.add(vo);
			}
		}
		
		// update
		for( SYScmRawProcVo vo : updateList) {
			result += scmDAO.rawProcUpload_update(vo);
		}
		// insert
		for( SYScmRawProcVo vo : insertList) {
			// file controller에서 한번 체크
			// 기존의 ebeln, ebelp 의 키값에 해당하는 zdeli_menge sum값이 이미 menge와 같다면, 추가 불가하다.
			int zdeli_menge_sum = scmDAO.rawProc_parsingChk(vo);
			if( Integer.parseInt(vo.getMenge())<=zdeli_menge_sum ) {
				// insert deny
			} else {
				SYScmRawProcVo getVo = scmDAO.rawProc_selectByKey(vo).get(0);
				System.out.println("=== insert key_cnt : " + getVo.getKey_cnt());
				// insert
				getVo.setRorder_status("r1");
				getVo.setRvendor_status("v1");
				getVo.setVendor_delivery_date(vo.getVendor_delivery_date());
				getVo.setZdeli_menge(vo.getZdeli_menge());
				getVo.setPartial_seq(null);
				getVo.setPartial_yn("Y");
				getVo.setDiff_date(vo.getDiff_date());
				getVo.setUpdater(vo.getUpdater());
//				System.out.println(getVo);
				result += scmDAO.rawProcUpload_insert(getVo);
			}
		}
		return result;
	}
	
	@Transactional
	public List<SYScmRawProcVo> rawProc_selectByKey(SYScmRawProcVo rVo) {
		return scmDAO.rawProc_selectByKey(rVo);
	}

	@Transactional
	public int rawProcNextStep_update(SYScmRawProcVo rVo) {
		return scmDAO.rawProcNextStep_update(rVo);
	}
	
	@Transactional
	public int rawProcConfirmYn_update(SYScmRawProcVo rVo) {
		return scmDAO.rawProcConfirmYn_update(rVo);
	}

	@Transactional
	public int rawProc_update_partial(SYScmRawProcVo rVo) {
		return scmDAO.rawProc_update_partial(rVo);
	}

	@Transactional
	public int rawProcSernr_update_partial(SYScmRawProcVo rVo) {
		return scmDAO.rawProcSernr_update_partial(rVo);
	}

	@Transactional
	public List<SYScmRawProcSernrVo> rawProcSernr_select(SYScmRawProcSernrVo sVo) {
		return scmDAO.rawProcSernr_select(sVo);
	}
	
	@Transactional
	public int rawProcSernr_delete(SYScmRawProcSernrVo sVo) {
		return scmDAO.rawProcSernr_delete(sVo);
	}

	@Transactional
	public List<SYScmRawProcVo> scmProcMat_select(String ebeln) {
		return scmDAO.scmProcMat_select(ebeln);
	}
	
	@Transactional	
	public int scmProcSernr_update(SYScmRawProcSernrVo sVo) {
		System.out.println("scmService scmProcSernr_update()");
		System.out.println(sVo.toString());
		int result = 0;
		try{
			result = scmDAO.scmProcSernr_update(sVo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}
	
	@Transactional	
	public int scmProcSernr_insert(SYScmRawProcSernrVo sVo) {
		System.out.println("scmService scmProcSernr_insert()");
		System.out.println(sVo.toString());
		
		int result = 0;
		try{
				result = scmDAO.scmProcSernr_insert(sVo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}

	public int scmProcSernr_insertItem(SYScmRawProcSernrVo sVo){
		return scmDAO.scmProcSernr_insert(sVo);
	}
	
	@Transactional	
	public List<SYScmRawProcSernrVo> rawProc_sernr_duplication_chk(String sernrs) {
		ArrayList<String> list=  new ArrayList<String>();
		String[] arrSernrs = sernrs.split(",");
		for(String sernr : arrSernrs ) {
			list.add(sernr);
		}
		return scmDAO.rawProc_sernr_duplication_chk(list);
	}
	
	@Transactional	
	public int rawProcSernr_update(SYScmRawProcVo vo) {
		return scmDAO.rawProcSernr_update(vo);
	}

	@Transactional	
	public int rawProcSernrEbelp_update(SYScmRawProcVo vo) {
		return scmDAO.rawProcSernrEbelp_update(vo);
	}
	
	/*public List<SYScmIssueDetailVo> issue_getStep1(SYScmIssueDetailVo vo) {
		return scmDAO.issue_getStep1(vo);
	}*/
	
	/*public List<SYScmIssueDetailVo> issue_getSteps(SYScmIssueDetailVo vo) {
		return scmDAO.issue_getSteps(vo);
	}*/
	
	@Transactional
	public int rawProc_SubInsert(SYScmRawProcSubVo scmRVo){
		return scmDAO.rawProc_SubInsert(scmRVo);
	}

	
	@Transactional
	public int rawProc_SubDelete(SYScmRawProcSubVo scmRVo){
		return scmDAO.rawProc_SubDelete(scmRVo);
	}

	
	public int str_stock_header_delete(SYStockVo pVo) {
		return scmDAO.str_stock_header_delete(pVo);
		
	}

	public int str_stock_detail_delete(SYStockVo pVo) {
		return scmDAO.str_stock_detail_delete(pVo);
		
	}

	public List<SYTransReceiptVo> trans_receipt_select(SYTransReceiptVo pVo) {
		return scmDAO.trans_receipt_select(pVo);
	}

	public List<SYSlocMasterVo> mes_stock_tbl_select(SYSlocMasterVo sVo) {
		return scmDAO.mes_stock_tbl_select(sVo);
	}
	
	public String checkVenderMember(String member_emp_no) {
		return scmDAO.checkVenderMember(member_emp_no);
	}

	public String getMaxKeYCnt(String ebeln) {
		return scmDAO.getMaxKeYCnt(ebeln);
	}
	
	public int checkPartialYN(SYScmRawProcVo vo) {
		return scmDAO.checkPartialYN(vo);
	}
	/*
	public int after_zmmfm_goodsmvt_po_proc(List<SYScmRawProcVo> vList, String ev_mjahr, String ev_mblnr, String updater) {
//		List<SYScmRawProcVo> vList = new ArrayList<SYScmRawProcVo>();
		int result = 0;
		for( SYScmRawProcVo vo : vList ) {
			SYScmRawProcVo tVo = new SYScmRawProcVo();
			tVo.setEbeln(vo.getEbeln());
			tVo.setEbelp(vo.getEbelp());
			tVo.setMjahr(ev_mjahr);
			tVo.setMblnr(ev_mblnr);
			tVo.setRorder_status("r4");
			tVo.setRvendor_status("v4");
			if( vo.getConfirm_date()==null || "".equals(vo.getConfirm_date()) )
				tVo.setConfirm_date(vo.getVendor_delivery_date());
			if( vo.getOrder_delivery_date()==null || "".equals(vo.getOrder_delivery_date()) )
				tVo.setOrder_delivery_date(vo.getVendor_delivery_date());
			tVo.setUpdater(updater);
			System.out.println("@@@@@@@@@@@@@@@@@@@@");
			System.out.println(tVo.toString());
			rawProcSta_update(tVo);
			vo.setMjahr(ev_mjahr);
			vo.setMblnr(ev_mblnr);
			vo.setRorder_status("r4");
			vo.setRvendor_status("v4");
		}
		SYScmRawProcVo tmpVo = vList.get(0);
		
		vo.setMesi("Y"); // 무검사 대상
			vo.setMove_type("101");
		 * 
		System.out.println("입하 처리 결과 후 작업 조건 : " + tmpVo.getMesi() + " / " + tmpVo.getMove_type());
		if( "Y".equals(tmpVo.getMesi()) && "101".equals(tmpVo.getMove_type()) ) {
			// nothing
		}else{
			result = inInsp_insert_proc(vList);
		}
		return result;
	}*/

	public int scm_trans_req_cancel(SYReqmMatnrTblVo pVo) {
		return scmDAO.scm_trans_req_cancel(pVo);
	}

	public int scm_trans_req_user_confirml(SYReqmMatnrTblVo pVo) {
		return scmDAO.scm_trans_req_user_confirml(pVo);
	}
	
	public List<SYReqmMatnrTblVo> trans_req_select(SYReqmMatnrTblVo pVo) {
		return scmDAO.trans_req_select(pVo);
	}
	
	public List<SYScmRawProcVo> rawProcConfirm_select(String ebeln) {
		return scmDAO.rawProcConfirm_select(ebeln);
	}

	public List<SYReqmMatnrTblVo> req_matnr_ord_select_nopage(SYReqmMatnrTblVo sVo) {
		return scmDAO.req_matnr_ord_select_nopage(sVo);
	}
	public int selectBomtbl_count(SYScmBomVo vo) {
		return scmDAO.selectBomtbl_count(vo);
	}
	
	public List<SYScmBomVo> selectBomtbl(SYScmBomVo vo) {
		return scmDAO.selectBomtbl(vo);
	}
	/*
	public List<SYVendorVo> vender_nm_grid_add(String lifnrs) {
		List<SYVendorVo> result = null;

		ArrayList<String> list=  new ArrayList<String>();
		String[] arrLifnr = lifnrs.split(","); 
		for(int i=0; i<arrLifnr.length; i++) {
			list.add(arrLifnr[i]);
		}

		SYVendorVo pVo = new SYVendorVo();
		pVo.setList(list);
		result = scmDAO.vender_nm_grid_add(pVo);

		return result;
	}*/

	public int rawProcUpload_update(SYScmRawProcVo procVo) {
		return scmDAO.rawProcUpload_update(procVo);
	}

	public int rawProcUpload_insert(SYScmRawProcVo pVo) {
		return scmDAO.rawProcUpload_insert(pVo);
	}
}


