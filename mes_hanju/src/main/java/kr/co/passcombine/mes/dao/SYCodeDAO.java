package kr.co.passcombine.mes.dao;

import java.util.List;

import kr.co.passcombine.mes.vo.SYCodeVo;

import org.springframework.stereotype.Repository;

@Repository(value = "vmesCodeDAO")
public interface SYCodeDAO {

	public List<SYCodeVo> selectMasterCode(SYCodeVo code);
	public int insertMasterCode(SYCodeVo code);
	public int updateMasterCode(SYCodeVo code);
	public int deleteMasterCode(SYCodeVo code);

	public List<SYCodeVo> selectDetailCode(SYCodeVo code);
	public int insertDetailCode(SYCodeVo code);
	public int updateDetailCode(SYCodeVo code);
	public int deleteDetailCode(SYCodeVo code);
	
	public List<SYCodeVo> comm_code_select(SYCodeVo vo);
}
