package kr.co.passcombine.mes.dao;

import java.util.ArrayList;
import java.util.List;

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
import kr.co.passcombine.mes.vo.SYSernrManageVo;
import kr.co.passcombine.mes.vo.SYStockVo;
import kr.co.passcombine.mes.vo.SYTransReceiptVo;
import kr.co.passcombine.mes.vo.SYVendorVo;
import kr.co.passcombine.mes.vo.SYWfwotherVo;
import kr.co.passcombine.mes.vo.SYScmBomVo;

import org.springframework.stereotype.Repository;

@Repository(value = "vmesScmDAO")
public interface SYScmDAO {
	public List<SYScmRawDeliveryVo> deliveryReq_select(SYScmRawDeliveryVo hubVo);
	public List<SYScmRawDeliveryVo> deliveryVendor_select(SYScmRawDeliveryVo hubVo);
	public List<SYMesCodeVo> getStaCodeList_select(SYMesCodeVo codeVo);
	public int scmRawDelivery_update(SYScmRawDeliveryVo scmSVo);
	public int deliverySta_update(SYScmRawDeliveryVo scmSVo);
	public int scmRawDeliveryDiff_update(SYScmRawDeliveryVo scmSVo);
	
	public int selectDeliveryVendorCount(SYScmRawDeliveryVo sVo);
	
	public int rawDelivery_insert(SYScmRawDeliveryVo rVo);
	public int rawDelivery_update(SYScmRawDeliveryVo rVo);
	public int rawDelivery_partial_update(SYScmRawDeliveryVo rVo);
	public List<SYScmRawDeliveryVo> rawDelivery_select(SYScmRawDeliveryVo rVo);
	
	public int rawVendorResult_insert(SYScmRawVendorResultVo vo);
	public int rawVendorResultSta_update(SYScmRawVendorResultVo vo);
	public int inInsp_insert(SYInInspVo vo);
	public int rawDeliverySta_update(SYScmRawDeliveryVo dVo);
	public List<SYScmRawVendorResultVo> rawVendor_select(SYScmRawVendorResultVo vVo);// del
	public List<SYScmRawProcVo> rawProc_select(SYScmRawProcVo vVo);//
	public List<SYScmRawProcSubVo> rawProcSub_select(SYScmRawProcSubVo vVo);//
	public List<SYScmRawVendorResultVo> rawVendor_selectAll(SYScmRawVendorResultVo vVo);
	
	public List<SYScmRawDeliveryVo> rawDelivery_selectByKey(SYScmRawDeliveryVo sVo);
	public List<SYScmRawSernrVo> raw_vendor_result_select(SYScmRawSernrVo sVo);
	
	public int raw_comment_insert(SYScmRawCommentVo vo);
	
	public List<SYScmRawVendorResultVo> getUniqueKeyList(ArrayList<String> list);
	public List<SYScmRawProcVo> getProcUniqueKeyList(ArrayList<String> list);
	public List<SYReqmMatnrTblVo> matnr_select(SYReqmMatnrTblVo sVo);
	public int matnr_select_count(SYReqmMatnrTblVo sVo);
	public int mstk_request_insert(SYReqmMatnrTblVo masVo);
	
	public String reqm_matnr_tbl_key_select_1();
	public int dstk_request_insert(SYReqmMatnrTblVo detVo);
	public List<SYReqmMatnrTblVo> reqd_matnr_key_select_1(String newKey);
	
	public List<SYReqmMatnrTblVo> req_matnr_ord_select(SYReqmMatnrTblVo sVo);
	public int req_matnr_ord_select_count(SYReqmMatnrTblVo sVo);
	public int req_matnr_select_count(SYReqmMatnrTblVo sVo);
	public List<SYSlocMasterVo> scm_sloc_code_select(SYSlocMasterVo sVo);
	
	public String makeRefDocNo();
	public int rawVendorResultEbelp_update(SYScmRawVendorResultVo vo);
	
//	public int rawSernrEbelp_update(SYScmRawVendorResultVo vo);
	public List<SYWfwotherVo> fwother_select(SYWfwotherVo sVo);
	public int fwother_select_count(SYWfwotherVo sVo);
	public int fwother_mst_insert(SYWfwotherVo scmDVo);
	public List<SYWfwotherVo> fwother_conf_header_select(SYWfwotherVo scmRVo);
	public List<SYWfwotherVo> fwother_select_nopage(SYWfwotherVo scmRVo);
	public int req_matr_status_update(SYWfwotherVo scmRVo);
	public int fwother_serial_insert(SYWfwotherVo scmDVo);
	public List<SYWfwotherVo> fwother_serial_select(SYWfwotherVo scmRVo);
	public int fwother_restore_update(SYWfwotherVo pVo);
	public int fwother_restore_delete(SYWfwotherVo pVo);
	public List<SYMoveTypeVo> move_type_select(SYMoveTypeVo scmRVo);
	public List<SYMoveTypeVo> cost_type_select(SYMoveTypeVo scmRVo);
	public List<SYMoveTypeVo> io_type_select(SYMoveTypeVo scmRVo);
	public int sap_return_update(SYWfwotherVo ppVo);
	public List<SYProdVo> str_stock_select(SYStockVo sVo);
	public int cancel_approval_matr(SYWfwotherVo scmRVo);
//	public int cancel_req_ord(SYWfwotherVo scmRVo);
	public int rawProcUpload_insert(SYScmRawProcVo rVo);
	public int rawProcUpload_update(SYScmRawProcVo rVo);
	public int rawProc_update_partial(SYScmRawProcVo rVo);
	public int rawProcSernr_update_partial(SYScmRawProcVo rVo);
	public int rawProc_insert(SYScmRawProcVo rVo);
	public int rawProc_update(SYScmRawProcVo rVo);
	public int rawProcLoekzi_update(SYScmRawProcVo vo);
	public int rawProcEbelp_update(SYScmRawProcVo vo);
	public int rawProcSta_update(SYScmRawProcVo dVo);
	public int rawProcKeyCnt_update(SYScmRawProcVo dVo);
	public List<SYScmRawProcVo> rawProc_selectByKey(SYScmRawProcVo rVo);
	public int rawProc_parsingChk(SYScmRawProcVo rVo);
	public int rawProcNextStep_update(SYScmRawProcVo rVo);
	public int rawProcConfirmYn_update(SYScmRawProcVo rVo);
	
	public List<SYScmRawProcSernrVo> rawProcSernr_select(SYScmRawProcSernrVo sVo);
	public int rawProcSernr_delete(SYScmRawProcSernrVo sVo);
	public List<SYScmRawProcVo> scmProcMat_select(String ebeln);
	public int scmProcSernr_update(SYScmRawProcSernrVo sVo);
	public int scmProcSernr_insert(SYScmRawProcSernrVo sVo);
	public List<SYScmRawProcSernrVo> rawProc_sernr_duplication_chk(ArrayList<String> list);
	public int rawProcSernr_update(SYScmRawProcVo vo);
	public int rawProcSernrEbelp_update(SYScmRawProcVo vo);
	
//	public List<SYScmIssueDetailVo> issue_getStep1(SYScmIssueDetailVo vo);
//	public List<SYScmIssueDetailVo> issue_getSteps(SYScmIssueDetailVo vo);
	
	public int rawProc_SubInsert(SYScmRawProcSubVo rVo);
	public int rawProc_SubDelete(SYScmRawProcSubVo rVo);  //사급자재 sub 내역 sap와 sync를 맞추기 위해 추가 
	
	public int str_stock_header_delete(SYStockVo pVo);
	public int str_stock_detail_delete(SYStockVo pVo);
	public List<SYTransReceiptVo> trans_receipt_select(SYTransReceiptVo pVo);
	public List<SYSlocMasterVo> mes_stock_tbl_select(SYSlocMasterVo sVo);
	public String checkVenderMember(String member_emp_no);
	public String getMaxKeYCnt(String ebeln);
	
	public int checkPartialYN(SYScmRawProcVo vo);
	public int scm_trans_req_cancel(SYReqmMatnrTblVo pVo);
	public int scm_trans_req_user_confirml(SYReqmMatnrTblVo pVo);
	public List<SYReqmMatnrTblVo> trans_req_select(SYReqmMatnrTblVo pVo);
	
	public List<SYScmRawProcVo> rawProcConfirm_select(String ebeln);
	public List<SYReqmMatnrTblVo> req_matnr_ord_select_nopage(SYReqmMatnrTblVo sVo);
	
	public List<SYInInspVo> exist_insp_select(SYInInspVo vo);
	public int selectBomtbl_count(SYScmBomVo pVo);
	public List<SYScmBomVo> selectBomtbl(SYScmBomVo pVo);
	public List<SYVendorVo> vender_nm_grid_add(SYVendorVo pVo);
	
}
