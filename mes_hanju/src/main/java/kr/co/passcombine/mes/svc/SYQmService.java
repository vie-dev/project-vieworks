package kr.co.passcombine.mes.svc;

import java.util.ArrayList;
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

import kr.co.passcombine.mes.dao.SYQmDAO;
import kr.co.passcombine.mes.sap.VmesJcoConnectVo;
import kr.co.passcombine.mes.sap.VmesJcoConnection;
import kr.co.passcombine.mes.vo.SYDmrMasterVo;
import kr.co.passcombine.mes.vo.SYInInspDetailVo;
import kr.co.passcombine.mes.vo.SYInInspHeaderVo;
import kr.co.passcombine.mes.vo.SYInInspVo;
import kr.co.passcombine.mes.vo.SYProdVo;
import kr.co.passcombine.mes.vo.SYQmFaultHisVo;
import kr.co.passcombine.mes.vo.SYQmFaultStatsVo;
import kr.co.passcombine.mes.vo.SYQmInspectionVo;
import kr.co.passcombine.mes.vo.SYQmVo;
import kr.co.passcombine.mes.vo.SYReqmMatnrTblVo;
import kr.co.passcombine.mes.vo.SYScmIssueDetailVo;
import kr.co.passcombine.mes.vo.SYStockVo;
import kr.co.passcombine.mes.vo.SYVprodVo;

@Service(value = "vmesQmService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYQmService {

	// private static final Logger logger = LoggerFactory.getLogger(SYCodeService.class);
	@Resource
	private Environment environment;
	
	@Resource(name = "vmesQmDAO")
	private SYQmDAO qmDAO;

	public int last_inspection_select_count(SYQmVo sVo) {
		return qmDAO.last_inspection_select_count(sVo);
	}
	
	public String reqm_matnr_tbl_key_select_2() {
		return qmDAO.reqm_matnr_tbl_key_select_2();
	}
	
	public List<SYQmVo> last_inspection_select(SYQmVo sVo) {
		return qmDAO.last_inspection_select(sVo);
	}

	/*public int inspection_process(SYQmVo sVo) {

		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		*//******** gridData 데이터 가져오기 : start *********//*
		String gridData = sVo.getGridData();
		List<SYQmVo> data_list = new ArrayList<SYQmVo>();
		try {
			listDataJArray = (JSONArray) jsonParser.parse(gridData);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(listDataJArray.size() != 0) {
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();

			
			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray.get(idx);
				SYQmVo tmp_sVo = new SYQmVo();
		
				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					
					if( "pordno".equals(nKey) ) tmp_sVo.setPordno(nValue);
					else if( "pordno_seq".equals(nKey) ) tmp_sVo.setPordno_seq(nValue);
					else if( "issue_memo".equals(nKey) ) tmp_sVo.setIssue_memo(nValue);
					else if( "issue_code".equals(nKey) ) tmp_sVo.setIssue_code(nValue);
					
					tmp_sVo.setPdsts(sVo.getPdsts());
					tmp_sVo.setSudat(sVo.getSudat());
					tmp_sVo.setUpdater(sVo.getUpdater());
					
					tmp_sVo.setRef_doc_no(sVo.getRef_doc_no());				
					tmp_sVo.setMblnr(sVo.getMblnr());     
					tmp_sVo.setMjahr(sVo.getMjahr());     
					
					tmp_sVo.setPlant(sVo.getPlant());
					tmp_sVo.setStge_loc(sVo.getStge_loc());
					tmp_sVo.setMove_plant(sVo.getMove_plant());
					tmp_sVo.setMove_stloc(sVo.getMove_stloc());
					tmp_sVo.setConf_date(sVo.getConf_date());
				 

				}
				data_list.add(tmp_sVo);
			}
		}
		System.out.println("@@@@@@@@@ ::: " +  data_list.size());
		for(int i=0 ; i<data_list.size(); i++) {
			qmDAO.inspection_process(data_list.get(i));
			qmDAO.prodTbl_pdsts_update(data_list.get(i));
		}
		return 0; 
		*//******** gridData 데이터 가져오기 : end *********//*
	}*/

	/*public int prodTbl_pdsts_update(SYQmVo sVo) {
		return qmDAO.prodTbl_pdsts_update(sVo);		
	}*/
	
	public int ship_inspection_select_count(SYQmVo sVo) {
		return qmDAO.ship_inspection_select_count(sVo);
	}

	public List<SYQmVo> ship_inspection_select(SYQmVo sVo) {
		return qmDAO.ship_inspection_select(sVo);
	}

	public int ship_insp_insert(SYQmVo sVo) {
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		/******** gridData 데이터 가져오기 : start *********/
		String gridData = sVo.getGridData();
		List<SYQmVo> data_list = new ArrayList<SYQmVo>();
		try {
			listDataJArray = (JSONArray) jsonParser.parse(gridData);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(listDataJArray.size() != 0) {
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();

			
			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray.get(idx);
				SYQmVo tmp_sVo = new SYQmVo();
		
				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					
					if( "pordno".equals(nKey) ) tmp_sVo.setPordno(nValue);

				}
				data_list.add(tmp_sVo);
			}
		}

		for(int i=0 ; i<data_list.size(); i++) {
			List<SYQmVo> list = qmDAO.last_inspection_select_nopaging(data_list.get(i));

			qmDAO.ship_insp_insert(list.get(0));
		}
		
		return 0; 

		/******** gridData 데이터 가져오기 : end *********/
		
	}

	/*public int ship_inspection_process(SYQmVo sVo) {
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		//******** gridData 데이터 가져오기 : start *********//*
		String gridData = sVo.getGridData();
		List<SYQmVo> data_list = new ArrayList<SYQmVo>();
		try {
			listDataJArray = (JSONArray) jsonParser.parse(gridData);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(listDataJArray.size() != 0) {
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();

			
			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray.get(idx);
				SYQmVo tmp_sVo = new SYQmVo();
		
				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue = (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					
					if( "pordno".equals(nKey) ) tmp_sVo.setPordno(nValue);
					else if( "issue_memo".equals(nKey) ) tmp_sVo.setIssue_memo(nValue);
					
					tmp_sVo.setPdsts(sVo.getPdsts());
					tmp_sVo.setSudat(sVo.getSudat());
					tmp_sVo.setUpdater(sVo.getUpdater());
					
					tmp_sVo.setRef_doc_no(sVo.getRef_doc_no());				
					tmp_sVo.setMblnr(sVo.getMblnr());     
					tmp_sVo.setMjahr(sVo.getMjahr());     
					
				}
				data_list.add(tmp_sVo);
			}
		}
		System.out.println("@@@@@@@@@ ::: " +  data_list.size());
		for(int i=0 ; i<data_list.size(); i++) {
			qmDAO.ship_inspection_process(data_list.get(i));
			qmDAO.prodTbl_pdsts_update(data_list.get(i));
		}
		return 0; 
		*//******** gridData 데이터 가져오기 : end *********//*
	}*/

	/*public int last_insp_cancel_update(SYQmVo sVo) {
		return qmDAO.last_insp_cancel_update(sVo);		
	}*/

	public int ship_insp_cancel_update(SYQmVo sVo) {
		return qmDAO.ship_insp_cancel_update(sVo);		
		
	}

	public int ship_insp_delete(SYQmVo pVo) {
		return qmDAO.ship_insp_delete(pVo);		
	}
	
	public List<SYInInspDetailVo> inInspDetail_select(SYInInspDetailVo vo) {
		return qmDAO.inInspDetail_select(vo);
	}
	
	public int inInspHeader_insert(List<SYInInspHeaderVo> voList) {
		int result = 0;
		for( SYInInspHeaderVo vo : voList ){
			result += qmDAO.inInspHeader_insert(vo);
		}
		return result;
	}
	
	public int inInspDetail_insert(List<SYInInspDetailVo> voList) {
		int result = 0;
		for( SYInInspDetailVo vo : voList ){
			result += qmDAO.inInspDetail_insert(vo);
		}
		return result;
	}

	public int inInsp_update(List<SYInInspHeaderVo> voList) {
		int result = 0;
		for( SYInInspHeaderVo vo : voList ){
			SYInInspVo iVo = new SYInInspVo();
			iVo.setEbeln(vo.getEbeln());
			iVo.setEbelp(vo.getEbelp());
			iVo.setPartial_seq(vo.getPartial_seq());
			iVo.setInsp_status(vo.getInsp_status());
			if( "i2".equals(vo.getInsp_status()) ) {
				iVo.setSuccess_yn("Y");
				iVo.setIn_confirm_date(vo.getIn_cofirm_date());
			} else if( "i3".equals(vo.getInsp_status()) ) {
				iVo.setFail_yn("Y");
				iVo.setIn_fail_date(vo.getIn_fail_date());
			}
			result += qmDAO.inInsp_update(iVo);
		}
		return result;
	}
	
	public List<SYInInspHeaderVo> inInspHeader_select(SYInInspHeaderVo vo) {
		return qmDAO.inInspHeader_select(vo);
	}
	
	public int inInspResultSta_update(SYInInspVo Vo) {
		return qmDAO.inInspResultSta_update(Vo);
	}
	
	public List<SYInInspDetailVo> inInspResult_select(SYInInspDetailVo vo) {
		return qmDAO.inInspResult_select(vo);
	}
	
	public int standby_inspection_select_count(SYQmInspectionVo sVo) {
		return qmDAO.standby_inspection_select_count(sVo);
	}
 
	public List<SYQmInspectionVo> standby_inspection_select(SYQmInspectionVo sVo) {
		return qmDAO.standby_inspection_select(sVo);
	}

	public List<SYStockVo> insp_select(SYStockVo sVo) {
		return qmDAO.insp_select(sVo);
	}

	public int insp_select_count(SYStockVo sVo) {
		return qmDAO.insp_select_count(sVo);
	}

	public int fnSaveInspLot(SYStockVo sVo) {
		return qmDAO.fnSaveInspLot(sVo);
		
	}
	
	public String lot_gen() {
		return qmDAO.lot_gen();
		
	}

	public int fnLastInspWorkerAdd(SYQmVo pVo) {
		return qmDAO.fnLastInspWorkerAdd(pVo);
	}

	public int lastStsUpdate(SYQmVo pVo) {
		return qmDAO.lastStsUpdate(pVo);
	}

	public String maxPordnoSeq(SYQmVo pVo) {
		return qmDAO.maxPordnoSeq(pVo);
	}

	public List<SYQmVo> inspection_state_select(SYQmVo sVo) {
		return qmDAO.inspection_state_select(sVo);
	}

	public List<SYQmVo> inspection_state_monthly_select(SYQmVo sVo) {
		return qmDAO.inspection_state_monthly_select(sVo);
	}

	public List<SYQmVo> import_inspection_state_select(SYQmVo sVo) {
		return qmDAO.import_inspection_state_select(sVo);
	}

	public List<SYQmVo> import_inspection_monthly_state_select(SYQmVo sVo) {
		return qmDAO.import_inspection_monthly_state_select(sVo);
	}

	public List<SYQmVo> import_inspection_m_state_select(SYQmVo sVo) {
		return qmDAO.import_inspection_m_state_select(sVo);
	}

	public List<SYQmVo> import_inspection_m_monthly_state_select(SYQmVo sVo) {
		return qmDAO.import_inspection_m_monthly_state_select(sVo);
	}

	public int inspSave(List<SYInInspDetailVo> detail_list) {
		int rtn_value = 1;
		for(int i=0 ; i<detail_list.size() ; i++) {
			int result = qmDAO.inspSave(detail_list.get(i));
			if(result == 0) {
				rtn_value = result;
			}
		}
		return rtn_value;
	}

	public int inspHeaderSave(SYInInspHeaderVo sVo) {
		int result = qmDAO.inspHeaderSave(sVo);
		return result;
	}

	public int vendor_prod_insert(SYVprodVo sVo) {
		return qmDAO.vendor_prod_insert(sVo);		
	}

	/*public List<SYVprodVo> vprod_select(SYVprodVo sVo) {
		return qmDAO.vprod_select(sVo);
	}*/

	/*public List<SYZmmfmMatMasterVo> v_prod_matnr_select(SYZmmfmMatMasterVo sVo) {
		return qmDAO.v_prod_matnr_select(sVo);
	}*/

	/*public int selfInspSernrSave(SYVprodVo sVo) {
		return qmDAO.selfInspSernrSave(sVo);
	}*/

	/*public int vOrdStatusChange(SYVprodVo tmp_sVo) {
		return qmDAO.vOrdStatusChange(tmp_sVo);
	}*/

	public List<SYVprodVo> chkVpdsts(SYVprodVo sVo) {
		return qmDAO.chkVpdsts(sVo);
	}

	/*public int vorder_del(SYVprodVo tmp_sVo) {
		return qmDAO.vorder_del(tmp_sVo);
	}*/

	/*public List<SYDmrMasterVo> showDmrInfo(SYDmrMasterVo sVo) {
		return qmDAO.showDmrInfo(sVo);
	}*/

	/*public List<SYVprodVo> vph_chkDupSernr(SYVprodVo sVo) {
		return qmDAO.vph_chkDupSernr(sVo);
	}*/

	public int updateDmr(SYVprodVo sVo) {
		return qmDAO.updateDmr(sVo);
	}

	public List<SYQmFaultHisVo> select_fault_his_data(SYQmFaultHisVo sVo) {
		return qmDAO.select_fault_his_data(sVo);
	}

	public List<SYScmIssueDetailVo> issueDataSelc(SYScmIssueDetailVo sVo) {
		return qmDAO.issueDataSelc(sVo);
	}

	public int issueDataProc(SYScmIssueDetailVo sVo) {
		System.out.println("********************************change status ::: " + sVo.getStatus());
		int result = 0;
		JSONParser parser = new JSONParser();
		JSONArray hJsonArr = new JSONArray();
		try {
			hJsonArr = (JSONArray) parser.parse(sVo.getJsonStr().toString());
			JSONObject tmpObj = (JSONObject)hJsonArr.get(0);
			Object[] keyArr = tmpObj.keySet().toArray();
			List<SYScmIssueDetailVo> headerList = new ArrayList<SYScmIssueDetailVo>();
			for(int idx=0; idx<hJsonArr.size(); idx++) {
				JSONObject rowObj = (JSONObject)hJsonArr.get(idx);
				SYScmIssueDetailVo tmpVo = new SYScmIssueDetailVo();
				tmpVo.setStatus(sVo.getStatus());
				tmpVo.setUpdater(sVo.getUpdater());
				for(Object key : keyArr) {
					String nKey = key.toString();
					String nValue = (rowObj.get(nKey)==null)?"":rowObj.get(nKey).toString();
					
					if ( "fault_no".equals(nKey) ) tmpVo.setFault_no(nValue);
					else if ( "fault_no_seq".equals(nKey) )  tmpVo.setFault_no_seq(nValue);
					else if ( "level3_code".equals(nKey) )  tmpVo.setLevel3_code(nValue);
				}
				headerList.add(tmpVo);
			}
			for(SYScmIssueDetailVo vo : headerList) {
				result += qmDAO.issueDataProc(vo);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result; 
	}

	public int issueValidChk(SYQmFaultHisVo sVo) {
		int rtn_result = 0;
		JSONParser parser = new JSONParser();
		JSONArray hJsonArr = new JSONArray();
		try {
			hJsonArr = (JSONArray) parser.parse(sVo.getJsonStr().toString());
			JSONObject tmpObj = (JSONObject)hJsonArr.get(0);
			Object[] keyArr = tmpObj.keySet().toArray();
			List<SYQmFaultHisVo> headerList = new ArrayList<SYQmFaultHisVo>();
			for(int idx=0; idx<hJsonArr.size(); idx++) {
				JSONObject rowObj = (JSONObject)hJsonArr.get(idx);
				SYQmFaultHisVo tmpVo = new SYQmFaultHisVo();
				for(Object key : keyArr) {
					String nKey = key.toString();
					String nValue = (rowObj.get(nKey)==null)?"":rowObj.get(nKey).toString();
					
					if ( "werks".equals(nKey) ) tmpVo.setWerks(nValue);
					else if ( "level1_code".equals(nKey) )  tmpVo.setLevel1_code(nValue);
					else if ( "level2_code".equals(nKey) )  tmpVo.setLevel2_code(nValue);
					else if ( "level3_code".equals(nKey) )  tmpVo.setLevel3_code(nValue);
				}
				headerList.add(tmpVo);
			}
			for(SYQmFaultHisVo vo : headerList) {
				List<SYQmFaultHisVo> result =  qmDAO.issueValidChk(vo);
				if(result.size() == 0)
					rtn_result++;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return rtn_result; 
	}

	public List<SYQmFaultStatsVo> fault_stats_data(SYQmFaultStatsVo sVo) {
		return qmDAO.fault_stats_data(sVo);
	}

	public List<SYQmFaultStatsVo> input_stats_data(SYQmFaultStatsVo sVo) {
		return qmDAO.input_stats_data(sVo);
	}

	public List<SYQmFaultStatsVo> fault_stats_dtl_data(SYQmFaultStatsVo sVo) {
		return qmDAO.fault_stats_dtl_data(sVo);
	}
}
