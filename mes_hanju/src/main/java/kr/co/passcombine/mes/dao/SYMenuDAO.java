package kr.co.passcombine.mes.dao;

import java.util.HashMap;
import java.util.List;

import kr.co.passcombine.mes.vo.SYMenuVo;

import org.springframework.stereotype.Repository;

@Repository(value = "vmesMenuDAO")
public interface SYMenuDAO {
	
	public List<SYMenuVo> selectMenu(SYMenuVo menuVo);
	public SYMenuVo selectMenuInfo(SYMenuVo menuVo);
	public int insertMenu(SYMenuVo menuVo);
	public int updateMenu(SYMenuVo menuVo);
	public int deleteMenu(SYMenuVo menuVo);
	
	public List<SYMenuVo> selectMenuAll(SYMenuVo menuVo);
	public List<SYMenuVo> selectMenuAcl(SYMenuVo menuVo);
	public List<SYMenuVo> selectMenuRole(SYMenuVo menuVo);
	
	public int insertMenuRole(SYMenuVo menuVo);
	public int deleteMenuRole(SYMenuVo menuVo);
}
