package kr.co.passcombine.mes.svc;

import java.util.List;

import javax.annotation.Resource;

import kr.co.passcombine.mes.dao.SYFileDAO;
//import kr.co.passcombine.mes.vo.SYFileVo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service(value = "vmesFileService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYFileService {

	private static final Logger logger = LoggerFactory.getLogger(SYFileService.class);
	
	@Resource(name = "vmesFileDAO")
	private SYFileDAO fileDAO;
	
	public String selectFileKey(){
		return fileDAO.selectFileKey();
	}
/*
	public List<SYFileVo> selectFile(SYFileVo fileVo){
		return fileDAO.selectFile(fileVo);
	}
	public SYFileVo selectFileDetail(SYFileVo fileVo){
		return fileDAO.selectFileDetail(fileVo);
	}
	
	public int insertFile(SYFileVo fileVo){
		return fileDAO.insertFile(fileVo);
	}
	public int deleteFile(SYFileVo fileVo){
		return fileDAO.deleteFile(fileVo);
	}

//	public int delFlagFile(SYFileVo sVo) {
//		return fileDAO.delFlagFile(sVo);
//	}

	public int selectFile_count(SYFileVo sVo) {
		return fileDAO.selectFile_count(sVo);
	}

	public List<SYFileVo> selectFile_nopage(SYFileVo sVo) {
		return fileDAO.selectFile_nopage(sVo);
	}*/
}