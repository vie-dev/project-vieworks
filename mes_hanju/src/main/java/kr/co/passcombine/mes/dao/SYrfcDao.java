package kr.co.passcombine.mes.dao;


import java.util.List;


import kr.co.passcombine.mes.vo.SYProdVo;

import org.springframework.stereotype.Repository;

@Repository(value = "vmesrfcDAO")
public interface SYrfcDao {

	public List<SYProdVo> selectProdCode(SYProdVo code);
	public List<SYProdVo> select1(SYProdVo code);
	public List<SYProdVo> select2(SYProdVo code);
	public List<SYProdVo> select3(SYProdVo code);
	public List<SYProdVo> select4(SYProdVo code);
	
	public int faultMemo_update(SYProdVo code);
	
	public int insertMasterCode(SYProdVo code);
	public int updateMasterCode(SYProdVo code);
	public int deleteMasterCode(SYProdVo code);
	
	public int insertDetailCode(SYProdVo code);
	public int updateDetailCode(SYProdVo code);
	public int deleteDetailCode(SYProdVo code);
	
	public int insertrfcCode(SYProdVo code);
	 
 
}
