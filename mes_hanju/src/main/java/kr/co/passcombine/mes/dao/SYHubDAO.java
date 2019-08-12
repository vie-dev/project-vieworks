package kr.co.passcombine.mes.dao;

import java.util.List;

import kr.co.passcombine.mes.vo.SYDmrFwVo;
import kr.co.passcombine.mes.vo.SYDmrMasterVo;
import kr.co.passcombine.mes.vo.SYDmrPbaVo;
//import kr.co.passcombine.mes.vo.SYFileVo;
import kr.co.passcombine.mes.vo.SYLineVo;
import kr.co.passcombine.mes.vo.SYMemberVo;
import kr.co.passcombine.mes.vo.SYHubRevInsMasVo;
import kr.co.passcombine.mes.vo.SYHubRevInsCliVo;
import kr.co.passcombine.mes.vo.SYHubRoutingDetailVo;
import kr.co.passcombine.mes.vo.SYHubRoutingHeaderVo;
import kr.co.passcombine.mes.vo.SYReqmMatnrTblVo;
import kr.co.passcombine.mes.vo.SYHubBomVo;
import kr.co.passcombine.mes.vo.SYVendorVo;
import kr.co.passcombine.mes.vo.SYHubRecvinspeVo;

import org.springframework.stereotype.Repository;

@Repository(value = "vmesHubDAO")
public interface SYHubDAO {
	public List<SYHubRevInsMasVo> qualityMaster_select(SYHubRevInsMasVo hubVo);
	public List<SYHubRevInsCliVo> qualityDetail_select(SYHubRevInsCliVo hubVo);
//	public List<SYHubRevInsCliVo> qualityDetailTest_select(SYHubRevInsCliVo hubVo);
//	public List<SYHubRoutingHeaderVo> routingHeader_select(SYHubRoutingHeaderVo hubVo);
//	public List<SYHubRoutingHeaderVo> routingHeaderItem_select(SYHubRoutingHeaderVo hubVo);
//	public int routingDetail_select_count(SYZmmfmMatMasterVo hubDVo);
//	public List<SYZmmfmMatMasterVo> routingDetail_select(SYZmmfmMatMasterVo hubDVo);
	public String getRoutingGroupNo();
	public String getRoutingNo();
	public int routingHeader_insert(SYHubRoutingHeaderVo hubHVo);
	public int routingDetail_insert(SYHubRoutingDetailVo hubDVo);
	public int routingHeaderItem_insert(SYHubRoutingHeaderVo hubHVo);
	public int routingHeaderItem_update(SYHubRoutingHeaderVo hubHVo);
	public int routingHeaderItem_count(SYHubRoutingHeaderVo hubHVo);
	public int routingDetailItem_count(SYHubRoutingDetailVo hubDVo);
	public int routingHeaderGroup_delete(SYHubRoutingHeaderVo hubHVo);
	public int routingHeaderItem_delete(SYHubRoutingHeaderVo hubHVo);
	public int routingHeaderItem_delete_1(SYHubRoutingHeaderVo hubHVo);
//	public int routingDetail_delete(SYHubRoutingDetailVo hubDVo);
	public int insert_ZIFFM_MES_PP002(SYHubBomVo hubDVo);
//	public int insertSapVendor(SYVendorVo pVo);
	public int insertVendor(SYVendorVo pVo);
	public int updateVendor(SYVendorVo pVo);
	public int deleteVendor(SYVendorVo pVo);
	public List<SYVendorVo> selectVendortbl(SYVendorVo pVo);
	public int selectBomtbl_count(SYHubBomVo pVo);
	public List<SYHubBomVo> selectBomtbl(SYHubBomVo pVo);
	public List<SYReqmMatnrTblVo> material_req_mas_select(SYReqmMatnrTblVo sVo);
//	public List<SYReqmMatnrTblVo> material_req_det_select(SYReqmMatnrTblVo sVo);
	public int selectCustomerMemberCount(SYMemberVo custMemberVo);
	public List<SYMemberVo> selectCustomerMember(SYMemberVo custMemberVo);
	public SYMemberVo selectCustomerMemberInfo(SYMemberVo custMemberVo);
//	public List<SYReqmMatnrTblVo> material_req_done_select(SYReqmMatnrTblVo sVo);	
//	public List<SYReqmMatnrTblVo> req_status_chk(SYReqmMatnrTblVo sVo);
//	public int  reqd_sernr_insert(SYReqmMatnrTblVo sVo);
//	public int  reqm_status_update(SYReqmMatnrTblVo sVo);
//	public int  conf_bdmng_update(SYReqmMatnrTblVo sVo);
//	public List<SYReqmMatnrTblVo> conf_bdmng_chk(SYReqmMatnrTblVo sVo);
	public List<SYReqmMatnrTblVo> grade_master_selc(String grade_nm);
//	public List<SYReqmMatnrTblVo> material_req_det_select_1(SYReqmMatnrTblVo sVo);
	public List<SYReqmMatnrTblVo> material_req_mas_select_1(SYReqmMatnrTblVo sVo);
	public List<SYReqmMatnrTblVo> tmp_matdoc_itm_select(SYReqmMatnrTblVo sVo); 
	public int matdoc_itm_update(SYReqmMatnrTblVo pVo);
	
	public List<SYHubRecvinspeVo> rinspectionheader_select(SYHubRecvinspeVo hubVo);
	public List<SYHubRecvinspeVo> rinspectionItem_select(SYHubRecvinspeVo hubVo);
	public String getInspectionGroupNo();
	public String getInspectionNo();
	public int rinspectionHeader_insert(SYHubRecvinspeVo hubHVo);  //사용 
	public int rinspectionDetail_insert(SYHubRecvinspeVo hubDVo);
	public int rinpsectionDetailItem_insert(SYHubRecvinspeVo hubHVo); //사용 
	public int rinspectionHeaderItem_count(SYHubRecvinspeVo hubHVo);
	public int rinspectionDetailItem_count(SYHubRecvinspeVo hubDVo);
	public int rinspectionHeaderGroup_delete(SYHubRecvinspeVo hubHVo);
	
	public int rinspectionDetail_delete(SYHubRecvinspeVo hubDVo);
	public int rinspection_matnr_insert(SYHubRecvinspeVo hubDVo);
	public List<SYHubRecvinspeVo> searchInspectionMatnr(SYHubRecvinspeVo hubVo);
	public int searchInspectionMatnr_count(SYHubRecvinspeVo hubHVo);
	public int rinspection_DetailItem_delete(SYHubRecvinspeVo hubHVo);
	public int rinspection_matnr_delete(SYHubRecvinspeVo hubHVo);
	
//	public List<SYZmmfmMatMasterVo> routing_material_recv_master_select(SYZmmfmMatMasterVo sVo);
//	public int routing_material_recv_master_select_count(SYZmmfmMatMasterVo sVo);
	
//	public int updateRoutingPlastY(SYHubRoutingHeaderVo hubHVo);
//	public int updateRoutingPlastN(SYHubRoutingHeaderVo hubHVo);
	
	public String getInspectionRemarkNm(SYHubRecvinspeVo hubHVo);
 
	public List<SYDmrMasterVo> dmrMaster_select(SYDmrMasterVo dmrVo);
	public List<SYDmrMasterVo> dmrMasterAllByKey_select(SYDmrMasterVo dmrVo);
	public int dmrMaster_insert(SYDmrMasterVo dmrVo);
	public int dmrMaster_update(SYDmrMasterVo dmrVo);
	public int dmrMaster_applyInit_update(SYDmrMasterVo dmrVo);
	public int dmrMaster_delete(SYDmrMasterVo dmrVo);
	public List<SYDmrPbaVo> dmrPba_select(SYDmrPbaVo pbaVo);
	public int dmrPba_insert(SYDmrPbaVo pbaVo);
	public int dmrPba_update(SYDmrPbaVo pbaVo);
	public int dmrPba_delete(SYDmrPbaVo pbaVo);
	public List<SYDmrFwVo> dmrFw_select(SYDmrFwVo fwVo);
	public int dmrFw_insert(SYDmrFwVo fwVo);
	public int dmrFw_update(SYDmrFwVo fwVo);
	public int dmrFw_delete(SYDmrFwVo fwVo);
	public String getGrSeq();
	public String getGrNo();
	public int ecrMaster_insert(SYDmrMasterVo dmrVo);
	public List<SYDmrMasterVo> ecrMaster_select(SYDmrMasterVo dmrVo);
//	public int reqm_cancel_update(SYReqmMatnrTblVo pVo);
//	public int reqd_cancel_update(SYReqmMatnrTblVo pVo);
//	public int reqd_sernr_cancel_delete(SYReqmMatnrTblVo pVo);
	public int create_vmember(SYVendorVo pVo);
	public int create_vmember_map(SYVendorVo pVo);
	public int create_vmember_role(SYVendorVo pVo);
	public int update_vendor_id_yn(SYVendorVo pVo);
//	public List<SYHubRoutingHeaderVo> routing_group_byItnbr_select(SYHubRoutingHeaderVo vo);
	public String checkmediSerYN(String Matnr);
	public String checkoptiSerYN(String Matnr);
//	public int update_routinggnm(SYHubRoutingHeaderVo vo);
//	public int matnr_workstd_mapping(SYFileVo vo);
//	public List<SYFileVo> mapping_list_selc(SYFileVo sVo);
//	public int fnDelMatnr(SYFileVo pVo);
	public List<SYHubRecvinspeVo> insp_group_byItnbr_select(SYHubRecvinspeVo vo);
 
	
}
