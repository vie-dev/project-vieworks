package kr.co.passcombine.mes.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import kr.co.passcombine.mes.vo.SYCostTypeVo;
import kr.co.passcombine.mes.vo.SYInInspVo;
import kr.co.passcombine.mes.vo.SYIoTypeVo;
import kr.co.passcombine.mes.vo.SYMesCodeVo;
import kr.co.passcombine.mes.vo.SYMesVo;
import kr.co.passcombine.mes.vo.SYMoveTypeVo;
import kr.co.passcombine.mes.vo.SYProdVo;
import kr.co.passcombine.mes.vo.SYReqmMatnrTblVo;
import kr.co.passcombine.mes.vo.SYScmRawProcVo;
import kr.co.passcombine.mes.vo.SYSelfInspDetailVo;
import kr.co.passcombine.mes.vo.SYSelfInspHeaderVo;
import kr.co.passcombine.mes.vo.SYSelfInspMasterVo;
import kr.co.passcombine.mes.vo.SYSlocMasterVo;

import org.springframework.stereotype.Repository;

@Repository(value = "vmesMesDAO")
public interface SYMesDAO {
	
	public List<SYMesVo> selectList(SYMesVo menuVo);
	public int selectListCount(SYMesVo menuVo);
	public List<SYMesVo> selectDetailList(SYMesVo menuVo);
//	public List<SYProdVo> selectProdOrderGroup(SYProdVo prodVo);
	public List<SYProdVo> selectProdOrdUserIng(SYProdVo prodVo);
	public List<SYProdVo> selectProdOrdUserIng_opt(SYProdVo prodVo);
	
	public int reqm_matnr_tbl_insert(SYReqmMatnrTblVo sVo);
	public int reqd_matnr_tbl_insert(SYReqmMatnrTblVo sVo);
	public String reqm_matnr_tbl_key_select();
	public List<SYReqmMatnrTblVo> grade_master_select();
	public List<SYReqmMatnrTblVo> grade_exist_chk(SYReqmMatnrTblVo sVo);
	public List<SYReqmMatnrTblVo> reqd_matnr_key_select(String key);
	public List<SYInInspVo> inInsp_select(SYInInspVo vo);
	public List<SYInInspVo> inInsp_selectKey(SYInInspVo vo);
	public int ininsp_update(SYInInspVo vo);
	public int ininsp_delete(SYScmRawProcVo vo);
	public int ininsp_detail_delete(SYInInspVo vo);
	public int ininsp_header_delete(SYInInspVo vo);
	
	public int insert_sloc_master(SYSlocMasterVo sVo);
	public int insert_cost_type_tbl(SYCostTypeVo sVo);
	public int insert_io_type_tbl(SYIoTypeVo sVo);
	public int insert_move_type_tbl(SYMoveTypeVo sVo);
	
//	public List<SYProdVo> select_medi_item(SYProdVo pVo);
//	public List<SYProdVo> select_beforeJob_pdsts(SYProdVo pVo);
	
	public List<SYSelfInspMasterVo> select_selfinsp_master(SYSelfInspMasterVo vo);
//	public List<SYSelfInspHeaderVo> select_selfinsp_header(SYSelfInspHeaderVo vo);
//	public SYProdVo select_dmrRnInfo(String pordno);
//	public List<SYSelfInspHeaderVo> select_selfinsp_header_exist(SYSelfInspHeaderVo vo);
//	public List<SYSelfInspDetailVo> select_selfinsp_detail(SYSelfInspDetailVo vo);
//	public List<SYSelfInspDetailVo> select_selfinsp_detail_exist(SYSelfInspDetailVo vo);
	public List<SYMesCodeVo> select_selfInspCode_1210(SYMesCodeVo vo);
//	public List<SYMesCodeVo> select_selfInspCode_1110(SYMesCodeVo vo);
//	public int checkExistSelfInsp(SYSelfInspHeaderVo vo);
//	public int insert_selfInspHeader(SYSelfInspHeaderVo vo);
//	public int update_selfInspHeader(SYSelfInspHeaderVo vo);
//	public int insert_selfInspDetail(SYSelfInspDetailVo vo);
//	public int update_selfInspDetail(SYSelfInspDetailVo vo);
	public int insert_selfInspMaster(SYSelfInspMasterVo vo);
	public int update_selfInspMaster(SYSelfInspMasterVo vo);
	public List<SYProdVo> grade_matnr_chk(ArrayList<String> list);
	public int grade_loc_update(SYProdVo masVo);
	public String maktx_select(String _matnr);
	public int selfInspMaster_update(SYSelfInspMasterVo vo);
	public int selfInspMaster_new_insert(SYSelfInspMasterVo vo);
	public int selfInspMaster_matnr_insert(SYSelfInspMasterVo vo);
	public int selfInspHeader_update(SYSelfInspHeaderVo vo);
	public int selfInspHeader_insert(SYSelfInspHeaderVo vo);
	public int selfInspDetail_update(SYSelfInspDetailVo vo);
	public int selfInspDetail_insert(SYSelfInspDetailVo vo);
	public List<SYSelfInspMasterVo> checkDuplicateMatnr(SYSelfInspMasterVo vo);
	public List<SYSelfInspMasterVo> select_v_selfinsp_master(	SYSelfInspMasterVo vo);
	public int v_selfInspMaster_new_insert(SYSelfInspMasterVo vo);
	public int v_selfInspMaster_matnr_insert(SYSelfInspMasterVo vo);
	public int v_selfInspHeader_insert(SYSelfInspHeaderVo tmpVo);
	public int v_selfInspHeader_update(SYSelfInspHeaderVo tmpVo);
	public List<SYSelfInspHeaderVo> select_v_selfinsp_header(
			SYSelfInspHeaderVo vo);
	public List<SYSelfInspDetailVo> select_v_selfinsp_detail(
			SYSelfInspDetailVo vo);
	public List<SYSelfInspMasterVo> v_checkDuplicateMatnr(SYSelfInspMasterVo vo);
	public int v_selfInspMaster_update(SYSelfInspMasterVo vo);
	public int v_selfInspDetail_insert(SYSelfInspDetailVo vo);
	public int v_selfInspDetail_update(SYSelfInspDetailVo vo);
}
