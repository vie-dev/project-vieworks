package kr.co.passcombine.mes.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.passcombine.mes.vo.SYDmrPbaVo;
import kr.co.passcombine.mes.vo.SYHubRoutingDetailVo;
import kr.co.passcombine.mes.vo.SYHubRoutingHeaderVo;
import kr.co.passcombine.mes.vo.SYMemberVo;
import kr.co.passcombine.mes.vo.SYMesWkctrVo;
import kr.co.passcombine.mes.vo.SYPissueInspectionVo;
import kr.co.passcombine.mes.vo.SYPoRequirementVo;
import kr.co.passcombine.mes.vo.SYProdVo;
import kr.co.passcombine.mes.vo.SYReqmMatnrTblVo;
import kr.co.passcombine.mes.vo.SYSernrManageVo;
import kr.co.passcombine.mes.vo.SYStockVo;
import kr.co.passcombine.mes.vo.SYLineVo;

import kr.co.passcombine.mes.vo.SYTransReceiptVo;
import kr.co.passcombine.mes.vo.SYVprodVo;

import org.springframework.stereotype.Repository;

@Repository(value = "vmesProd201904DAO")
public interface SYProdDao_201904 {

//	public List<SYProdVo> sapProdCode(SYProdVo code);
	public List<SYProdVo> sapProdCode_confirm(SYProdVo code);
//	public List<SYProdVo> popProdSelect(SYProdVo code);
	public List<SYProdVo> select1(SYProdVo code);
	public List<SYProdVo> select2(SYProdVo code);
	public List<SYProdVo> select3(SYProdVo code);
	public List<SYProdVo> select4(SYProdVo code);
//	public List<SYProdVo> popProdHisSelect(SYProdVo code);
	public List<SYProdVo> popProdHisSelect_confrim(SYProdVo code);

//	public List<SYProdVo> worker_select_1110(SYMemberVo code);
	
//	public SYProdVo getProdStatus(SYProdVo code);
//	public int chk_worker_update(SYProdVo code);
//	public int worker_update(SYProdVo code);
	public int faultMemo_update(SYProdVo code);
	public int updateProdOrdConfirm(SYProdVo code);
	public int updateProdOrdNonConfirm(SYProdVo code);
	public int insertSapProdOrd(SYProdVo code);
	public int updateSapProdOrd(SYProdVo code);
	public List<SYProdVo> chkSapProdOrd(String pordNo);
	public int insertProdOrdTbl(SYProdVo code);
	public int deletetProdOrdTbl(SYProdVo prodVo);
	public List<SYProdVo> selectProdOrdtbl(String pordNo);
	
	public List<SYProdVo> popProdHisChk(ArrayList<String> list);
	public List<SYProdVo> popProdRoutingChk(ArrayList<String> list);
	public List<SYProdVo> confirmOrdChk(ArrayList<String> list);
	
	//public List<SYProdVo> popProdHisChk(String pordNo);
//	public int workStart_update(SYProdVo prodVo);
//	public int workEnd_update(SYProdVo prodVo);
//	public int prodOrd_stat_update(SYProdVo prodVo);
//	public int prod_stat_update(SYProdVo prodVo);
//	public int workPauseStart_update(SYProdVo prodVo);
//	public int workPauseEnd_update(SYProdVo prodVo);
//	public int workHisStart_insert(SYProdVo prodVo);
//	public int workHisEnd_insert(SYProdVo prodVo);
//	public int workPuaseHisStart_insert(SYProdVo prodVo);
//	public int workPuaseHisEnd_insert(SYProdVo prodVo);
//	public int updateMainSerial(SYProdVo prodVo);
	public int chkSerialNoDuplicate(SYSernrManageVo sVo);
//	public int updateDetailSerial(SYProdVo prodVo);
	
	public int po_requirement_tbl_insert(SYPoRequirementVo sVo);
	public int update_ZIFFM_MES_PP003(SYProdVo PVo);
	public int insert_ZIFFM_MES_PP003(SYProdVo PVo);
	
	public int matr_delete(ArrayList<String> list);
	public List<SYPoRequirementVo> matr_select(SYPoRequirementVo pVo);
	
	public int insertMasterCode(SYProdVo code);
	public int updateMasterCode(SYProdVo code);
	public int deleteMasterCode(SYProdVo code);
	
	public int insertDetailCode(SYProdVo code);
	public int updateDetailCode(SYProdVo code);
	public int deleteDetailCode(SYProdVo code);

	public List<SYProdVo> chkProdExist(SYProdVo pVo);
	public String prod_end_chk(String routing_no);
	
//	public int insertSernrManageTbl(SYSernrManageVo vo);
//	public int deleteSernrManageTbl(SYSernrManageVo vo);
//	public List<SYSernrManageVo> selectSernrManageTbl(SYSernrManageVo vo);
	public List<SYProdVo> wkctr_code_select(String werks);
//	public int lastInspec_insert(SYProdVo syProdVo);
//	public int prodTbl_pdsts_update(SYProdVo syProdVo);
	public List<SYSernrManageVo> fault_grid_select(SYSernrManageVo sVo);
//	public int insertPissueInspectionTbl(SYPissueInspectionVo tmpVo);
	public int updatePissueInspectionTbl(SYPissueInspectionVo tmpVo);
	public List<SYProdVo> prodRfcConf_yn(String pordno);
//	public int confirm_ord_dmr_update(SYProdVo pVo);
//	public List<SYProdVo> dmr_select(SYProdVo pVo);
//	public List<SYProdVo> prodUserInfo(SYProdVo prodVo);
	public List<SYProdVo> jo_select(SYProdVo prodVo);
	public int jocod_update(SYProdVo sVo);
	
	public List<SYLineVo> line_header_select(SYLineVo lineVo);
	public int line_header_insert(SYLineVo pbaVo);
	public int line_header_delete(SYLineVo pbaVo);
	public int line_member_select_count(SYLineVo lineVo);
	public List<SYLineVo> line_member_select(SYLineVo lineVo);
	public int line_member_delete(SYLineVo hubDVo);
	public int loadmemberinfo_count(SYLineVo lineVo);
	public List<SYLineVo> loadmemberinfo(SYLineVo lineVo);
	public int fnWorkerAdd(SYLineVo pbaVo);
//	public List<SYProdVo> getReworkSubjectData(SYProdVo prodVo);
//	public int projectNoDupChk(SYProdVo pordVo);
	public List<SYSernrManageVo> sernrCntChk(SYSernrManageVo pVo);	
	
//	public List<SYMesWkctrVo> mes_wkctr_tbl_select(SYMesWkctrVo pVo);
	public List<SYMemberVo> jo_worker_select(SYMemberVo memberVo);
	public int updateLastInspSerial(SYProdVo pordVo);
//	public int faultHisInsert(SYSernrManageVo pVo);
//	public String faultKeySelect();

	public List<SYProdVo> selectfault_his_tbl(SYProdVo code);
}
