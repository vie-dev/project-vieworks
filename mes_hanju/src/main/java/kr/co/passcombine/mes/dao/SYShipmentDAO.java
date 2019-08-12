package kr.co.passcombine.mes.dao;

import java.util.HashMap;
import java.util.List;

import kr.co.passcombine.mes.vo.SYHubBomVo;
import kr.co.passcombine.mes.vo.SYInInspVo;
import kr.co.passcombine.mes.vo.SYMesVo;
import kr.co.passcombine.mes.vo.SYProdVo;
import kr.co.passcombine.mes.vo.SYReqmMatnrTblVo;
import kr.co.passcombine.mes.vo.SYScmRawVendorResultVo;
import kr.co.passcombine.mes.vo.SYShipmentHordTblVo;
import kr.co.passcombine.mes.vo.SYShipmentSernrVo;
import kr.co.passcombine.mes.vo.SYShipmentVo;
import kr.co.passcombine.mes.vo.SYStockVo;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

@Repository(value = "vmesShipmentDAO")
public interface SYShipmentDAO {
	// new 
	public int select_shipment_count(SYShipmentHordTblVo vo);  
	public List<SYShipmentHordTblVo> select_shipment(SYShipmentHordTblVo vo);  
	
	
	
	public int insert_zsdfm_deliv_dat(SYShipmentVo shipVo);
	public int update_zsdfm_deliv_dat(SYShipmentVo shipVo);
	public int update_zsdfm_deliv_datall(SYShipmentVo shipVo);
	public List<SYShipmentVo> select_shipment_tbl(SYShipmentVo vVo);
	public List<SYShipmentSernrVo> shipmentSernr_select(SYShipmentSernrVo vVo);
	public int shipmentSernr_insert(SYShipmentSernrVo vo);
	public int shipmentSernr_delete(SYShipmentSernrVo vo);
	public int shipment_update(SYShipmentVo vo);
	public int insert_stock_header_tbl(SYStockVo pVo);
	public int insert_stock_item_tbl(SYStockVo pVo);
	public List<SYShipmentVo> sapStockChk(SYShipmentVo sVo);
	public List<SYStockVo> stock_item_tbl_select(SYStockVo pVo);
	public List<SYStockVo> stock_header_tbl_select(SYStockVo pVo);
	public List<SYShipmentVo> shipment_do_group_select(SYShipmentVo shipVo);
	public List<SYProdVo> packing_joblist_select(SYProdVo pVo);
	public List<SYProdVo> packing_jobDetailList_select(SYProdVo pVo);
	public List<SYShipmentVo> shipment_select(SYShipmentVo vo); 
	public List<SYShipmentVo> shipment_select_o(SYShipmentVo vo);
	public List<SYProdVo> getSerialInfo(SYShipmentVo vo); 
}
