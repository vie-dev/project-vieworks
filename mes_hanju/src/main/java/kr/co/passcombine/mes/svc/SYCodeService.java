package kr.co.passcombine.mes.svc;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.passcombine.mes.dao.SYCodeDAO;
import kr.co.passcombine.mes.vo.SYCodeVo;

@Service(value = "vmesCodeService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYCodeService {

	// private static final Logger logger = LoggerFactory.getLogger(SYCodeService.class);

	@Resource(name = "vmesCodeDAO")
	private SYCodeDAO codeDAO;

	public List<SYCodeVo> selectMasterCode(SYCodeVo code){
		return codeDAO.selectMasterCode(code);
	}
	public int insertMasterCode(SYCodeVo code){
		return codeDAO.insertMasterCode(code);
	}
	public int updateMasterCode(SYCodeVo code){
		return codeDAO.updateMasterCode(code);
	}

	@Transactional
	public int deleteMasterCode(SYCodeVo code){
		int result = codeDAO.deleteDetailCode(code);
		return codeDAO.deleteMasterCode(code);
	}
	public List<SYCodeVo> selectDetailCode(SYCodeVo code){
		return codeDAO.selectDetailCode(code);
	}
	public int insertDetailCode(SYCodeVo code){
		return codeDAO.insertDetailCode(code);
	}
	public int updateDetailCode(SYCodeVo code){
		return codeDAO.updateDetailCode(code);
	}
	public int deleteDetailCode(SYCodeVo code){
		return codeDAO.deleteDetailCode(code);
	}
	
	public List<SYCodeVo> comm_code_select(SYCodeVo vo) {
		return codeDAO.comm_code_select(vo);
	}
}
