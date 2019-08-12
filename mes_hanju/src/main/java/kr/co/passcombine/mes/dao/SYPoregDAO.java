package kr.co.passcombine.mes.dao;

import java.util.List;

import kr.co.passcombine.mes.vo.SYPoRegVo;

import org.springframework.stereotype.Repository;

@Repository(value = "vmesPoregDAO")
public interface SYPoregDAO {

	public int poreg_select_count(SYPoRegVo vo);
	public List<SYPoRegVo> poreg_select(SYPoRegVo vo);
	public String get_posalesno_key();
	public int poreg_chk_menge(SYPoRegVo vo);
	public int poreg_insert(SYPoRegVo vo);
	public int poreg_update(SYPoRegVo vo);
	public int poreg_delete(SYPoRegVo vo);
	/*
	public int project_dup_chk(SYProjectMngVo vo);
	public String get_project_key();
	public int project_delete(SYProjectMngVo vo);
	*/
}
