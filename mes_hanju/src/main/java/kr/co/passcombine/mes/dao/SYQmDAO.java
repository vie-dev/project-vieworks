package kr.co.passcombine.mes.dao;

import java.util.HashMap;
import java.util.List;

import kr.co.passcombine.mes.vo.SYDmrMasterVo;
import kr.co.passcombine.mes.vo.SYInInspDetailVo;
import kr.co.passcombine.mes.vo.SYInInspHeaderVo;
import kr.co.passcombine.mes.vo.SYInInspVo;
import kr.co.passcombine.mes.vo.SYQmFaultHisVo;
import kr.co.passcombine.mes.vo.SYQmFaultStatsVo;
import kr.co.passcombine.mes.vo.SYQmInspectionVo;
import kr.co.passcombine.mes.vo.SYQmVo;

import kr.co.passcombine.mes.vo.SYScmIssueDetailVo;
import kr.co.passcombine.mes.vo.SYStockVo;
import kr.co.passcombine.mes.vo.SYVprodVo;

import org.springframework.stereotype.Repository;

@Repository(value = "vmesQmDAO")
public interface SYQmDAO {

	public int last_inspection_select_count(SYQmVo sVo);
	public List<SYQmVo> last_inspection_select(SYQmVo sVo);

	public String reqm_matnr_tbl_key_select_2();
//	public int inspection_process(SYQmVo sVo);
	public int ship_inspection_select_count(SYQmVo sVo);
	public List<SYQmVo> ship_inspection_select(SYQmVo sVo);
	public int ship_insp_insert(SYQmVo syQmVo);
	public List<SYQmVo> last_inspection_select_nopaging(SYQmVo sVo);
//	public int ship_inspection_process(SYQmVo syQmVo);
//	public int prodTbl_pdsts_update(SYQmVo syQmVo);
//	public int last_insp_cancel_update(SYQmVo sVo);
	public int ship_insp_cancel_update(SYQmVo sVo);
	public int ship_insp_delete(SYQmVo pVo);
	public List<SYInInspDetailVo> inInspDetail_select(SYInInspDetailVo vo);
	public int inInspHeader_insert(SYInInspHeaderVo vo);
	public int inInspDetail_insert(SYInInspDetailVo vo);
	public int inInsp_update(SYInInspVo vo);
	public List<SYInInspHeaderVo> inInspHeader_select(SYInInspHeaderVo vo); 
	public int inInspResultSta_update(SYInInspVo vo);
	public List<SYInInspDetailVo> inInspResult_select(SYInInspDetailVo vo);
	
	public int standby_inspection_select_count(SYQmInspectionVo sVo);
	public List<SYQmInspectionVo> standby_inspection_select(SYQmInspectionVo sVo);
	public List<SYStockVo> insp_select(SYStockVo sVo);
	public int insp_select_count(SYStockVo sVo);
	public int fnSaveInspLot(SYStockVo sVo);
	public String lot_gen();
	public int fnLastInspWorkerAdd(SYQmVo pVo);
	public int lastStsUpdate(SYQmVo pVo);
	public String maxPordnoSeq(SYQmVo pVo);
	
	public List<SYQmVo> batch_lastInsp_select();
	public int batch_lastInsp_update(SYQmVo vo);
	public List<SYQmVo> inspection_state_select(SYQmVo sVo);
	public List<SYQmVo> inspection_state_monthly_select(SYQmVo sVo);
	public List<SYQmVo> import_inspection_state_select(SYQmVo sVo);
	public List<SYQmVo> import_inspection_monthly_state_select(SYQmVo sVo);
	public List<SYQmVo> import_inspection_m_state_select(SYQmVo sVo);
	public List<SYQmVo> import_inspection_m_monthly_state_select(SYQmVo sVo);
	public int inspSave(SYInInspDetailVo sVo);
	public int inspHeaderSave(SYInInspHeaderVo sVo);
	public int vendor_prod_insert(SYVprodVo sVo);
//	public List<SYVprodVo> vprod_select(SYVprodVo sVo);
//	public int selfInspSernrSave(SYVprodVo sVo);
//	public int vOrdStatusChange(SYVprodVo tmp_sVo);
	public List<SYVprodVo> chkVpdsts(SYVprodVo sVo);
//	public int vorder_del(SYVprodVo tmp_sVo);
//	public List<SYDmrMasterVo> showDmrInfo(SYDmrMasterVo sVo);
//	public List<SYVprodVo> vph_chkDupSernr(SYVprodVo sVo);
	public int updateDmr(SYVprodVo sVo);
	public List<SYQmFaultHisVo> select_fault_his_data(SYQmFaultHisVo sVo);
	public List<SYScmIssueDetailVo> issueDataSelc(SYScmIssueDetailVo sVo);
	public int issueDataProc(SYScmIssueDetailVo vo);
	public List<SYQmFaultHisVo> issueValidChk(SYQmFaultHisVo sVo);
	public List<SYQmFaultStatsVo> fault_stats_data(SYQmFaultStatsVo sVo);
	public List<SYQmFaultStatsVo> input_stats_data(SYQmFaultStatsVo sVo);
	public List<SYQmFaultStatsVo> fault_stats_dtl_data(SYQmFaultStatsVo sVo);
}
