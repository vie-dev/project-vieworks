package kr.co.passcombine.mes.svc;
 
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.passcombine.mes.dao.SYProdDao;
import kr.co.passcombine.mes.vo.SYProdTblVo;

@SuppressWarnings("unchecked")
@Service(value = "vmesProdService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYProdService {

	// private static final Logger logger = LoggerFactory.getLogger(SYCodeService.class);
	@Resource
	private Environment environment;
	
	@Resource(name = "vmesProdDAO")
	private SYProdDao prodDAO;
 
	public List<SYProdTblVo> prod_tbl_select(SYProdTblVo vo) {
		return prodDAO.prod_tbl_select(vo);
	}
}
