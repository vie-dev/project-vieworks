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

import kr.co.passcombine.mes.vo.SYMaterialMngVo;
import kr.co.passcombine.mes.vo.SYMemberVo;
import kr.co.passcombine.mes.vo.SYMaterialMasVo;
import kr.co.passcombine.mes.dao.LogStatusDAO;
import kr.co.passcombine.mes.dao.SYMaterialDAO;
import kr.co.passcombine.mes.util.StringUtil;
import kr.co.passcombine.mes.vo.LogStatusVo;


@Service(value = "vmesMaterialService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYMaterialService {

	// private static final Logger logger = LoggerFactory.getLogger(SYCodeService.class);
	@Resource
	private Environment environment;
	
	@Resource(name = "vmesLogStatusDAO")
	private LogStatusDAO logStatusDAO;

	@Resource(name = "vmesMaterialDAO")
	private SYMaterialDAO materialDAO;
	
	
	/*
	@Transactional
	public int routingHeader_insert(SYHubRoutingHeaderVo hubHVo){
//		int result = hubDAO.deleteMenuRole(menuVo);
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();
		int result = 0;
		try{
			listDataJArray = (JSONArray) jsonParser.parse(hubHVo.getGridData());
			JSONObject jOb = (JSONObject)listDataJArray.get(0);
			Object[] keyArr = jOb.keySet().toArray();
			// by group insert
			hubHVo.setRouting_gno(hubDAO.getRoutingGroupNo());
			for(int idx=0; idx<listDataJArray.size(); idx++){
				JSONObject jObj = new JSONObject();
				jObj = (JSONObject)listDataJArray.get(idx);
				hubHVo.setRouting_no(hubDAO.getRoutingNo());
				for(Object key : keyArr){
					String nKey = key.toString();
					String nValue =  (jObj.get(nKey)==null)?"":jObj.get(nKey).toString();
					if( "routing_gubun".equals(nKey) )
						hubHVo.setRouting_gubun(nValue);
					else if( "routing_code".equals(nKey) )
						hubHVo.setRouting_code(nValue);
					else if( "routing_dscr".equals(nKey) )
						hubHVo.setRouting_dscr(nValue);
				}
				result = hubDAO.routingHeader_insert(hubHVo);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return result; 
	}*/
	
	public int material_master_select_count(SYMaterialMasVo sVo){
		return materialDAO.material_master_select_count(sVo);
	}
	
	public List<SYMaterialMasVo> material_master_select(SYMaterialMasVo sVo){
		return materialDAO.material_master_select(sVo);
	}
	
	public List<SYMaterialMasVo> material_master_select_pop(SYMaterialMasVo sVo){
		return materialDAO.material_master_select_pop(sVo);
	}
	
	public List<SYMaterialMasVo> material_master_select_one(SYMaterialMasVo sVo){
		return materialDAO.material_master_select_one(sVo);
	}
	
	public int material_master_dup_check(SYMaterialMasVo vo) {
		return materialDAO.material_master_dup_check(vo);
	}
	
	@Transactional
	public int material_master_insert(SYMaterialMasVo vo) {
		return materialDAO.material_master_insert(vo);
	}
	
	@Transactional
	public int material_master_update(SYMaterialMasVo vo) {
		return materialDAO.material_master_update(vo);
	}
	
	@Transactional
	public int material_master_delete(SYMaterialMasVo vo) {
		return materialDAO.material_master_delete(vo);
	}
	
	public int material_mng_select_count(SYMaterialMngVo sVo){
		return materialDAO.material_mng_select_count(sVo);
	}
	
	public List<SYMaterialMngVo> material_mng_select(SYMaterialMngVo sVo){
		return materialDAO.material_mng_select(sVo);
	}
	
	public int material_mng_dup_check(SYMaterialMngVo vo) {
		return materialDAO.material_mng_dup_check(vo);
	}
	
	@Transactional
	public int material_mng_insert(SYMaterialMngVo vo) {
		return materialDAO.material_mng_insert(vo);
	}
	
	@Transactional
	public int material_mng_update(SYMaterialMngVo vo) {
		return materialDAO.material_mng_update(vo);
	}
	
	@Transactional
	public int material_mng_delete(SYMaterialMngVo vo) {
		return materialDAO.material_mng_delete(vo);
	}
}
