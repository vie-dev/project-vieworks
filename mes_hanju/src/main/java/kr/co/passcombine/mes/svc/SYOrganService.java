package kr.co.passcombine.mes.svc;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.core.env.Environment;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kr.co.passcombine.mes.dao.SYOrganDAO;
import kr.co.passcombine.mes.sap.VmesJcoConnectVo;
import kr.co.passcombine.mes.sap.VmesJcoConnection;
import kr.co.passcombine.mes.util.StringUtil;
import kr.co.passcombine.mes.vo.LogStatusVo;
import kr.co.passcombine.mes.vo.SYMemberVo;
import kr.co.passcombine.mes.vo.SYOrganVo;

import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;

@Service(value = "vmesOrganService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYOrganService {

	private static final Logger logger = LoggerFactory.getLogger(SYOrganService.class);
	
	@Resource
	private Environment environment;
	
	@Resource(name = "vmesOrganDAO")
	private SYOrganDAO organDAO;
	
	public List<SYOrganVo> selectOrgan(SYOrganVo deptVo){
		return organDAO.selectOrgan(deptVo);
	}
	public SYOrganVo selectOrganInfo(SYOrganVo deptVo){
		return organDAO.selectOrganInfo(deptVo);
	}
	public int insertDept(SYOrganVo deptVo){
		return organDAO.insertDept(deptVo);
	}
	public int updateDept(SYOrganVo deptVo){
		return organDAO.updateDept(deptVo);
	}
	public int deleteDept(SYOrganVo deptVo){
		return organDAO.deleteDept(deptVo);
	}
	public List<SYMemberVo> selectMemberList(SYMemberVo memberVo){
		return organDAO.selectMemberList(memberVo);
	}
	public SYMemberVo selectMemberInfo(SYMemberVo memberVo){
		return organDAO.selectMemberInfo(memberVo);
	}
	
	public SYMemberVo selectMemberLoginInfoAuto(SYMemberVo memberVo){
		return organDAO.selectMemberLoginInfoAuto(memberVo);
	}
	
	public List<SYMemberVo> selectMemberCheck(SYMemberVo memberVo){
		return organDAO.selectMemberCheck(memberVo);
	}
	public int selectRoleMemberCount(SYMemberVo memberVo){
		return organDAO.selectRoleMemberCount(memberVo);
	}
	public List<SYMemberVo> selectRoleMemberList(SYMemberVo memberVo){
		return organDAO.selectRoleMemberList(memberVo);
	}
	public int insertRoleMember(SYMemberVo memberVo){
		int result = organDAO.deleteRoleMember(memberVo);
		result = organDAO.insertRoleMember(memberVo); 
		return result;
	}
	public int deleteRoleMember(SYMemberVo memberVo){
		return organDAO.deleteRoleMember(memberVo);
	}
	public SYMemberVo selectMemberLoginInfo(SYMemberVo memberVo){
		return organDAO.selectMemberLoginInfo(memberVo);
	}
	public int selectMemberIdCheck(SYMemberVo memberVo){
		return organDAO.selectMemberIdCheck(memberVo);
	}
	public int insertMember(SYMemberVo memberVo){
		int result = organDAO.insertMember(memberVo);
		result = organDAO.insertOrganMember(memberVo);
		return result;
	}
	public int updateMember(SYMemberVo memberVo){
		int result = organDAO.updateMember(memberVo);
		result = organDAO.updateOrganMember(memberVo);
		return result;
	}
	public int updateMemberPwd(SYMemberVo memberVo) {
		return organDAO.updateMemberPwd(memberVo);
	}
	public int deleteMember(SYMemberVo memberVo){
		int result = organDAO.deleteMember(memberVo);
		result = organDAO.deleteOrganMember(memberVo);
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public JSONObject synchronizeHRInfo(String member_id){
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		try{
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			VmesJcoConnection connect = new VmesJcoConnection(connectVo); 
			JCoFunction function = connect.getFunction("ZFMHR_FI0010");
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			
			/*== Setting RFC Parameter ===================================*/
			
			/*== Return Value Mapping ===================================*/
			LogStatusVo logVo = new LogStatusVo();
			try {
				logVo.setCreator(member_id);
				logVo.setUpdater(member_id);
				logVo.setBatch_start_dt(StringUtil.getDateTime());
				logVo.setBatch_source_ds("SAP:ZFMHR_FI0010");
				logVo.setBatch_target_ds("sa_master_organ");
				logVo.setBatch_type("HR");
				logVo.setBatch_action("U");
				
				connect.executeFunction(function);
					
				JSONObject resultObj = new JSONObject();
				JCoTable et_output = function.getTableParameterList().getTable("ET_OUTPUT");
				if(et_output != null && et_output.getNumRows() > 0){
					for (int i = 0; i < et_output.getNumRows(); i++) {
						et_output.setRow(i);
						logger.debug("-------------------------------------------------> et_output ROWS : " + (i+1));
						logger.debug("flow log : C_CD  : " +  et_output.getString("C_CD"));
						logger.debug("flow log : ORG_ID  : " +  et_output.getString("ORG_ID"));
						logger.debug("flow log : ORG_NM  : " +  et_output.getString("ORG_NM"));
						logger.debug("flow log : UP_ORG_ID  : " +  et_output.getString("UP_ORG_ID"));
						logger.debug("flow log : UP_ORG_NM  : " +  et_output.getString("UP_ORG_NM"));
						logger.debug("flow log : TLEVEL  : " +  et_output.getString("TLEVEL"));
						logger.debug("flow log : DP_ORDER  : " +  et_output.getString("DP_ORDER"));
						logger.debug("flow log : STA_YMD  : " +  et_output.getString("STA_YMD"));
						logger.debug("flow log : END_YMD  : " +  et_output.getString("END_YMD"));
						logger.debug("flow log : ORG_CLASS  : " +  et_output.getString("ORG_CLASS"));
						logger.debug("flow log : INOUT_CD  : " +  et_output.getString("INOUT_CD"));
						logger.debug("flow log : PAY_AREA_CD  : " +  et_output.getString("PAY_AREA_CD"));
						logger.debug("flow log : BIZPL_CD  : " +  et_output.getString("BIZPL_CD"));
						logger.debug("flow log : WORK_LOC_CD  : " +  et_output.getString("WORK_LOC_CD"));
						logger.debug("flow log : EMP_ID  : " +  et_output.getString("EMP_ID"));
						logger.debug("flow log : MGR_CLASS  : " +  et_output.getString("MGR_CLASS"));
						
						HashMap<String, String> htObj = new HashMap<String, String>();

						htObj.put("c_cd", et_output.getString("C_CD"));
						htObj.put("org_id", et_output.getString("ORG_ID"));
						htObj.put("org_nm", et_output.getString("ORG_NM"));
						htObj.put("up_org_id", et_output.getString("UP_ORG_ID"));
						htObj.put("up_org_nm", et_output.getString("UP_ORG_NM"));
						htObj.put("tlevel", et_output.getString("TLEVEL"));
						htObj.put("dp_order", et_output.getString("DP_ORDER"));
						htObj.put("sta_ymd", et_output.getString("STA_YMD"));
						htObj.put("end_ymd", et_output.getString("END_YMD"));
						htObj.put("org_class", et_output.getString("ORG_CLASS"));
						htObj.put("inout_cd", et_output.getString("INOUT_CD"));
						htObj.put("pay_area_cd", et_output.getString("PAY_AREA_CD"));
						htObj.put("bizpl_cd", et_output.getString("BIZPL_CD"));
						htObj.put("work_loc_cd", et_output.getString("WORK_LOC_CD"));
						htObj.put("emp_id", et_output.getString("EMP_ID"));
						htObj.put("mgr_class", et_output.getString("MGR_CLASS"));
						htObj.put("creator", member_id);
						htObj.put("updater", member_id);
						
						organDAO.insertMasterOrgan(htObj);
					}
					
					organDAO.updateDisableOrganMes();
					organDAO.insertSyncOrganMes();
					
				   
				}
				
				listDataJArray.add(resultObj);
				
				logVo.setBatch_result("S");
				logVo.setBatch_description("");
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");
				
			} catch(Exception ex){
				logVo.setBatch_result("F");
				logVo.setBatch_description(ex.toString());
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				ex.printStackTrace();
			} finally {
				logVo.setBatch_end_dt(StringUtil.getDateTime());
		 
			}
			
			VmesJcoConnection connect2 = new VmesJcoConnection(connectVo); 
			JCoFunction function2 = connect.getFunction("ZFMHR_FI0020");
			if (function2 == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			
			/*== Setting RFC Parameter ===================================*/
			
			/*== Return Value Mapping ===================================*/
			LogStatusVo logVo2 = new LogStatusVo();
			try {
				logVo2.setCreator(member_id);
				logVo2.setUpdater(member_id);
				logVo2.setBatch_start_dt(StringUtil.getDateTime());
				logVo2.setBatch_source_ds("SAP:ZFMHR_FI0020");
				logVo2.setBatch_target_ds("sa_master_member");
				logVo2.setBatch_type("HR");
				logVo2.setBatch_action("U");
				
				connect2.executeFunction(function2);
					
				JSONObject resultObj = new JSONObject();
				JCoTable et_output = function2.getTableParameterList().getTable("ET_OUTPUT");
				if(et_output != null && et_output.getNumRows() > 0){
					for (int i = 0; i < et_output.getNumRows(); i++) {
						et_output.setRow(i);
						logger.debug("-------------------------------------------------> et_output ROWS : " + (i+1));
						
						logger.debug("flow log : C_CD  : " +  et_output.getString("C_CD"));
						logger.debug("flow log : CP_CD  : " +  et_output.getString("CP_CD"));
						logger.debug("flow log : EMP_ID  : " +  et_output.getString("EMP_ID"));
						logger.debug("flow log : EMP_NM  : " +  et_output.getString("EMP_NM"));
						logger.debug("flow log : LNS_TYPE  : " +  et_output.getString("LNS_TYPE"));
						logger.debug("flow log : BIRTH_YMD  : " +  et_output.getString("BIRTH_YMD"));
						logger.debug("flow log : ENTER_YMD  : " +  et_output.getString("ENTER_YMD"));
						logger.debug("flow log : GRP_YMD  : " +  et_output.getString("GRP_YMD"));
						logger.debug("flow log : RETIRE_YMD  : " +  et_output.getString("RETIRE_YMD"));
						logger.debug("flow log : ATTEND_STA_YMD  : " +  et_output.getString("ATTEND_STA_YMD"));
						logger.debug("flow log : RET_STA_YMD  : " +  et_output.getString("RET_STA_YMD"));
						logger.debug("flow log : LAST_MOVE_YMD  : " +  et_output.getString("LAST_MOVE_YMD"));
						logger.debug("flow log : LAST_PROM_YMD  : " +  et_output.getString("LAST_PROM_YMD"));
						logger.debug("flow log : SAL_STEP_YMD  : " +  et_output.getString("SAL_STEP_YMD"));
						logger.debug("flow log : GENDER_TYPE  : " +  et_output.getString("GENDER_TYPE"));
						logger.debug("flow log : MAIL_ADDR  : " +  et_output.getString("MAIL_ADDR"));
						logger.debug("flow log : PER_NO  : " +  et_output.getString("PER_NO"));
						logger.debug("flow log : OFFICE_TEL_NO  : " +  et_output.getString("OFFICE_TEL_NO"));
						logger.debug("flow log : TEL_NO  : " +  et_output.getString("TEL_NO"));
						logger.debug("flow log : MOBILE_NO  : " +  et_output.getString("MOBILE_NO"));
						logger.debug("flow log : ORG_ID  : " +  et_output.getString("ORG_ID"));
						logger.debug("flow log : EMP_TYPE  : " +  et_output.getString("EMP_TYPE"));
						logger.debug("flow log : EMP_GRADE_CD  : " +  et_output.getString("EMP_GRADE_CD"));
						logger.debug("flow log : SAL_STEP_CD  : " +  et_output.getString("SAL_STEP_CD"));
						logger.debug("flow log : DUTY_CD  : " +  et_output.getString("DUTY_CD"));
						logger.debug("flow log : POST_CD  : " +  et_output.getString("POST_CD"));
						logger.debug("flow log : EMP_TITLE_CD  : " +  et_output.getString("EMP_TITLE_CD"));
						logger.debug("flow log : DUP_ORG_ID  : " +  et_output.getString("DUP_ORG_ID"));
						logger.debug("flow log : DUP_DUTY_CD  : " +  et_output.getString("DUP_DUTY_CD"));
						logger.debug("flow log : DISP_ORG_ID  : " +  et_output.getString("DISP_ORG_ID"));
						logger.debug("flow log : DISP_DUTY_CD  : " +  et_output.getString("DISP_DUTY_CD"));
						logger.debug("flow log : STAT_CD  : " +  et_output.getString("STAT_CD"));
						logger.debug("flow log : PAY_AREA_CD  : " +  et_output.getString("PAY_AREA_CD"));
						logger.debug("flow log : ATTEND_AREA_CD  : " +  et_output.getString("ATTEND_AREA_CD"));
						logger.debug("flow log : BIZPL_CD  : " +  et_output.getString("BIZPL_CD"));
						logger.debug("flow log : WORK_LOC_CD  : " +  et_output.getString("WORK_LOC_CD"));
						logger.debug("flow log : STA_YMD  : " +  et_output.getString("STA_YMD"));
						logger.debug("flow log : END_YMD  : " +  et_output.getString("END_YMD"));
						logger.debug("flow log : NOTE  : " +  et_output.getString("NOTE"));
						logger.debug("flow log : APPNT_CD  : " +  et_output.getString("APPNT_CD"));
						logger.debug("flow log : STAT_NM  : " +  et_output.getString("STAT_NM"));
						logger.debug("flow log : ORG_NM  : " +  et_output.getString("ORG_NM"));
						logger.debug("flow log : EMP_TYPE_NM  : " +  et_output.getString("EMP_TYPE_NM"));
						logger.debug("flow log : EMP_GRADE_NM  : " +  et_output.getString("EMP_GRADE_NM"));
						logger.debug("flow log : DUTY_NM  : " +  et_output.getString("DUTY_NM"));
						logger.debug("flow log : EMP_TITLE_NM  : " +  et_output.getString("EMP_TITLE_NM"));
						logger.debug("flow log : POST_NM  : " +  et_output.getString("POST_NM"));
						logger.debug("flow log : SAL_TYPE_NM  : " +  et_output.getString("SAL_TYPE_NM"));
						logger.debug("flow log : SAL_STEP_NM  : " +  et_output.getString("SAL_STEP_NM"));
						logger.debug("flow log : PAY_AREA_NM  : " +  et_output.getString("PAY_AREA_NM"));
						logger.debug("flow log : ATTEND_AREA_NM  : " +  et_output.getString("ATTEND_AREA_NM"));
						logger.debug("flow log : BIZPL_NM  : " +  et_output.getString("BIZPL_NM"));
						logger.debug("flow log : WORK_LOC_NM  : " +  et_output.getString("WORK_LOC_NM"));
						                                                       
						HashMap<String, String> htObj = new HashMap<String, String>();
						htObj.put("c_cd", et_output.getString("C_CD"));
						htObj.put("cp_cd", et_output.getString("CP_CD"));
						htObj.put("emp_id", et_output.getString("EMP_ID"));
						htObj.put("emp_nm", et_output.getString("EMP_NM"));
						htObj.put("lns_type", et_output.getString("LNS_TYPE"));
						htObj.put("birth_ymd", et_output.getString("BIRTH_YMD"));
						htObj.put("enter_ymd", et_output.getString("ENTER_YMD"));
						htObj.put("grp_ymd", et_output.getString("GRP_YMD"));
						htObj.put("retire_ymd", et_output.getString("RETIRE_YMD"));
						htObj.put("attend_sta_ymd", et_output.getString("ATTEND_STA_YMD"));
						htObj.put("ret_sta_ymd", et_output.getString("RET_STA_YMD"));
						htObj.put("last_move_ymd", et_output.getString("LAST_MOVE_YMD"));
						htObj.put("last_prom_ymd", et_output.getString("LAST_PROM_YMD"));
						htObj.put("sal_step_ymd", et_output.getString("SAL_STEP_YMD"));
						htObj.put("gender_type", et_output.getString("GENDER_TYPE"));
						htObj.put("mail_addr", et_output.getString("MAIL_ADDR"));
						htObj.put("per_no", et_output.getString("PER_NO"));
						htObj.put("office_tel_no", et_output.getString("OFFICE_TEL_NO"));
						htObj.put("tel_no", et_output.getString("TEL_NO"));
						htObj.put("mobile_no", et_output.getString("MOBILE_NO"));
						htObj.put("org_id", et_output.getString("ORG_ID"));
						htObj.put("emp_type", et_output.getString("EMP_TYPE"));
						htObj.put("emp_grade_cd", et_output.getString("EMP_GRADE_CD"));
						htObj.put("sal_step_cd", et_output.getString("SAL_STEP_CD"));
						htObj.put("duty_cd", et_output.getString("DUTY_CD"));
						htObj.put("post_cd", et_output.getString("POST_CD"));
						htObj.put("emp_title_cd", et_output.getString("EMP_TITLE_CD"));
						htObj.put("dup_org_id", et_output.getString("DUP_ORG_ID"));
						htObj.put("dup_duty_cd", et_output.getString("DUP_DUTY_CD"));
						htObj.put("disp_org_id", et_output.getString("DISP_ORG_ID"));
						htObj.put("disp_duty_cd", et_output.getString("DISP_DUTY_CD"));
						htObj.put("stat_cd", et_output.getString("STAT_CD"));
						htObj.put("pay_area_cd", et_output.getString("PAY_AREA_CD"));
						htObj.put("attend_area_cd", et_output.getString("ATTEND_AREA_CD"));
						htObj.put("bizpl_cd", et_output.getString("BIZPL_CD"));
						htObj.put("work_loc_cd", et_output.getString("WORK_LOC_CD"));
						htObj.put("sta_ymd", et_output.getString("STA_YMD"));
						htObj.put("end_ymd", et_output.getString("END_YMD"));
						htObj.put("note", et_output.getString("NOTE"));
						htObj.put("appnt_cd", et_output.getString("APPNT_CD"));
						htObj.put("stat_nm", et_output.getString("STAT_NM"));
						htObj.put("org_nm", et_output.getString("ORG_NM"));
						htObj.put("emp_type_nm", et_output.getString("EMP_TYPE_NM"));
						htObj.put("emp_grade_nm", et_output.getString("EMP_GRADE_NM"));
						htObj.put("duty_nm", et_output.getString("DUTY_NM"));
						htObj.put("emp_title_nm", et_output.getString("EMP_TITLE_NM"));
						htObj.put("post_nm", et_output.getString("POST_NM"));
						htObj.put("sal_type_nm", et_output.getString("SAL_TYPE_NM"));
						htObj.put("sal_step_nm", et_output.getString("SAL_STEP_NM"));
						htObj.put("pay_area_nm", et_output.getString("PAY_AREA_NM"));
						htObj.put("attend_area_nm", et_output.getString("ATTEND_AREA_NM"));
						htObj.put("bizpl_nm", et_output.getString("BIZPL_NM"));
						htObj.put("work_loc_nm", et_output.getString("WORK_LOC_NM"));
						htObj.put("creator", member_id);       
						htObj.put("updater", member_id);       
						                                      
						organDAO.insertMasterMember(htObj);            
					}
					
					organDAO.updateDisableMemberMes();
					organDAO.insertSyncMemberMes();
					organDAO.insertSyncMemberOrgMes();
					organDAO.insertSyncMemberOrgMes();
					
				}
				
				listDataJArray.add(resultObj);
				
				
			
				
				logVo2.setBatch_result("S");
				logVo2.setBatch_description("");
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");
				
			} catch(Exception ex){
				logVo2.setBatch_result("F");
				logVo2.setBatch_description(ex.toString());
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				ex.printStackTrace();
			} finally {
				logVo2.setBatch_end_dt(StringUtil.getDateTime());
 
			}
			
			resultData.put("rows", listDataJArray);
			
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		return resultData;
	}
	
}