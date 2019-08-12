package kr.co.passcombine.mes.svc;

import java.util.List;

import javax.annotation.Resource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.passcombine.mes.dao.LogStatusDAO;
import kr.co.passcombine.mes.dao.SYPoregDAO;
import kr.co.passcombine.mes.util.StringUtil;
import kr.co.passcombine.mes.vo.LogStatusVo;
import kr.co.passcombine.mes.vo.SYPoRegVo;


@Service(value = "vmesPoregService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYPoregService {

	// private static final Logger logger = LoggerFactory.getLogger(SYCodeService.class);
	@Resource
	private Environment environment;
	
	@Resource(name = "vmesLogStatusDAO")
	private LogStatusDAO logStatusDAO;

	@Resource(name = "vmesPoregDAO")
	private SYPoregDAO poregDAO;
	
	
	public int poreg_select_count(SYPoRegVo vo) {
		return poregDAO.poreg_select_count(vo);
	}
	
	public List<SYPoRegVo> poreg_select(SYPoRegVo vo) {
		return poregDAO.poreg_select(vo);
	}

	public String get_posalesno_key() {
		return poregDAO.get_posalesno_key();
	}
	
	public int poreg_chk_menge(SYPoRegVo vo) {
		return poregDAO.poreg_chk_menge(vo);
	}
	
	public int poreg_insert(SYPoRegVo vo) {
		return poregDAO.poreg_insert(vo);
	}
	
	public int poreg_update(SYPoRegVo vo) {
		return poregDAO.poreg_update(vo);
	}
	
	public int poreg_delete(SYPoRegVo vo) {
		return poregDAO.poreg_delete(vo);
	}
	/*
	
	public int project_dup_chk(SYProjectMngVo vo) {
		return projectDAO.project_dup_chk(vo);
	}
	
	public String get_project_key() {
		return projectDAO.get_project_key();
	}
	
	@Transactional
	public int project_insert(SYProjectMngVo vo) {
		return projectDAO.project_insert(vo);
	}
	
	@Transactional
	public int project_update(SYProjectMngVo vo) {
		return projectDAO.project_update(vo);
	}
	
	@Transactional
	public int project_delete(SYProjectMngVo vo) {
		return projectDAO.project_delete(vo);
	}
	*/
}
