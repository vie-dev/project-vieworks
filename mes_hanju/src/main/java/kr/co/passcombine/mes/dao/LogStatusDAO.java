package kr.co.passcombine.mes.dao;

import java.util.List;

import kr.co.passcombine.mes.vo.*;

import org.springframework.stereotype.Repository;

@Repository(value = "vmesLogStatusDAO")
public interface LogStatusDAO {
	public List<LogStatusVo> selectLogStatus(LogStatusVo logVo);
	public int insertLogStatus(LogStatusVo logVo);
	public int deleteLogStatus(LogStatusVo logVo);
}