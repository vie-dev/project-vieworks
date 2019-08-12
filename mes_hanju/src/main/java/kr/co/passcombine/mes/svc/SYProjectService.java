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
import kr.co.passcombine.mes.dao.SYProjectDAO;
import kr.co.passcombine.mes.util.StringUtil;
import kr.co.passcombine.mes.vo.LogStatusVo;
import kr.co.passcombine.mes.vo.SYMemberVo;
import kr.co.passcombine.mes.vo.SYProjectMngVo;


@Service(value = "vmesProjectService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYProjectService {

	// private static final Logger logger = LoggerFactory.getLogger(SYCodeService.class);
	@Resource
	private Environment environment;
	
	@Resource(name = "vmesLogStatusDAO")
	private LogStatusDAO logStatusDAO;

	@Resource(name = "vmesProjectDAO")
	private SYProjectDAO projectDAO;
	
	public int project_select_count(SYProjectMngVo vo) {
		return projectDAO.project_select_count(vo);
	}
	
	public List<SYProjectMngVo> project_select(SYProjectMngVo vo) {
		return projectDAO.project_select(vo);
	}
	
	// ★★★★★★★★/ soobin_vendor
	
	public int soobin_vendor_count(SYProjectMngVo vo) {
		return projectDAO.soobin_vendor_count(vo);
	}
	
	public List<SYProjectMngVo> soobin_vendor(SYProjectMngVo vo) {
		return projectDAO.soobin_vendor(vo);
	}
	
	// test
	public int test_count(SYMemberVo vo) {
		return projectDAO.test_count(vo);
	}
	
	public List<SYMemberVo> test(SYMemberVo vo) {
		return projectDAO.test(vo);
	}
	
	public List<SYMemberVo> searchText(SYMemberVo vo) {
		return projectDAO.searchText(vo);
	}
	
	// insert
	public int test_insert(SYMemberVo vo) {
		return projectDAO.test_insert(vo);
	}
	
	// tTab_select
	public List<SYProjectMngVo> tTab_select(SYProjectMngVo vo) {
		return projectDAO.tTab_select(vo);
	}
	// tTab_count
	public int tTab_count(SYProjectMngVo vo) {
		return projectDAO.tTab_count(vo);
	}
	
	// tTab_insert
	@Transactional
	public int tTab_insert(SYProjectMngVo vo) {
		return projectDAO.tTab_insert(vo);
	}
	
	// tTab_update
	@Transactional
	public int tTab_update(SYProjectMngVo vo) {
		return projectDAO.tTab_update(vo);
	}
	// tTab_delete
	@Transactional
	public int tTab_delete(SYProjectMngVo vo) {
		return projectDAO.tTab_delete(vo);
	}
	//★★★★★★★★/ end
	
	public List<SYProjectMngVo> project_select_popup(SYProjectMngVo vo) {
		return projectDAO.project_select_popup(vo);
	}
	
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
}
