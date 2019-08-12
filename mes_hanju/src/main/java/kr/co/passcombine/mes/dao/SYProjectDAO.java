package kr.co.passcombine.mes.dao;

import java.util.List;

import kr.co.passcombine.mes.vo.SYMemberVo;
import kr.co.passcombine.mes.vo.SYProjectMngVo;

import org.springframework.stereotype.Repository;

@Repository(value = "vmesProjectDAO")
public interface SYProjectDAO {
	public int project_select_count(SYProjectMngVo vo);
	public List<SYProjectMngVo> project_select(SYProjectMngVo vo);
	public List<SYProjectMngVo> project_select_popup(SYProjectMngVo vo);
	public int project_dup_chk(SYProjectMngVo vo);
	public String get_project_key();
	public int project_insert(SYProjectMngVo vo);
	public int project_update(SYProjectMngVo vo);
	public int project_delete(SYProjectMngVo vo);
	
	// soobin_vendor
	
	public int soobin_vendor_count(SYProjectMngVo vo);
	public List<SYProjectMngVo> soobin_vendor(SYProjectMngVo vo);
	
	public int test_count(SYMemberVo vo);
	public List<SYMemberVo> test(SYMemberVo vo);
	
	public List<SYMemberVo> searchText(SYMemberVo vo);
	public int test_insert(SYMemberVo vo);
	
	// SYProjectMngVo
	public List<SYProjectMngVo> tTab_select(SYProjectMngVo vo);
	// SYProjectMngVo
	public int tTab_count(SYProjectMngVo vo);
	
	public int tTab_insert(SYProjectMngVo vo);
	
	// tTab_update
	public int tTab_update(SYProjectMngVo vo);
	
	// tTab_delete
	public int tTab_delete(SYProjectMngVo vo);
	
	// soobin_vendor end
	
	/*
	public int material_master_select_count(SYMaterialMasVo vo);
	public List<SYMaterialMasVo> material_master_select(SYMaterialMasVo vo);
	public int material_master_dup_check(SYMaterialMasVo vo);
	public int material_master_insert(SYMaterialMasVo vo);
	public int material_master_update(SYMaterialMasVo vo);
	public int material_master_delete(SYMaterialMasVo vo);*/
}
