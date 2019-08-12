package kr.co.passcombine.mes.svc;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import kr.co.passcombine.mes.dao.LogStatusDAO;
import kr.co.passcombine.mes.vo.LogStatusVo;

@Component("vmesLogStatusService")
public class LogStatusService {
	@Resource(name="vmesLogStatusDAO")
	private LogStatusDAO logStatusDAO;
	
	public List<LogStatusVo> selectLogStatus(LogStatusVo logVo){
		return logStatusDAO.selectLogStatus(logVo);
	}
	
	public int insertLogStatus(LogStatusVo logVo){
		return logStatusDAO.insertLogStatus(logVo);
	}
	
	public int deleteLogStatus(LogStatusVo logVo){
		return logStatusDAO.deleteLogStatus(logVo);
	}
}
