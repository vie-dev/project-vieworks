package kr.co.passcombine.mes.dao;

import java.util.List;

import kr.co.passcombine.mes.vo.SYMaterialMasVo;
import kr.co.passcombine.mes.vo.SYMaterialMngVo;

import org.springframework.stereotype.Repository;

@Repository(value = "vmesMaterialDAO")
public interface SYMaterialDAO {
	
	public int material_master_select_count(SYMaterialMasVo vo);
	public List<SYMaterialMasVo> material_master_select(SYMaterialMasVo vo);
	public List<SYMaterialMasVo> material_master_select_pop(SYMaterialMasVo vo);
	public List<SYMaterialMasVo> material_master_select_one(SYMaterialMasVo vo);
	public int material_master_dup_check(SYMaterialMasVo vo);
	public int material_master_insert(SYMaterialMasVo vo);
	public int material_master_update(SYMaterialMasVo vo);
	public int material_master_delete(SYMaterialMasVo vo);
	
	public int material_mng_select_count(SYMaterialMngVo vo);
	public List<SYMaterialMngVo> material_mng_select(SYMaterialMngVo vo);
	public int material_mng_dup_check(SYMaterialMngVo vo);
	public int material_mng_insert(SYMaterialMngVo vo);
	public int material_mng_update(SYMaterialMngVo vo);
	public int material_mng_delete(SYMaterialMngVo vo);
}
