package kr.co.passcombine.mes.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

//import kr.co.passcombine.mes.vo.SYFileVo;

@Repository(value = "vmesFileDAO")
public interface SYFileDAO {
	
	public String selectFileKey();
	/*
	public List<SYFileVo> selectFile(SYFileVo fVo);
	public SYFileVo selectFileDetail(SYFileVo fVo);
	
	public int insertFile(SYFileVo fVo);
	public int deleteFile(SYFileVo fVo);
//	public int delFlagFile(SYFileVo sVo);
	public int selectFile_count(SYFileVo sVo);
	public List<SYFileVo> selectFile_nopage(SYFileVo sVo);*/
}
