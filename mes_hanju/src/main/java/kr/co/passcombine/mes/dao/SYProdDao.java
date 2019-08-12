package kr.co.passcombine.mes.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.passcombine.mes.vo.SYProdTblVo;

import kr.co.passcombine.mes.vo.SYTransReceiptVo;
import kr.co.passcombine.mes.vo.SYVprodVo;

import org.springframework.stereotype.Repository;

@Repository(value = "vmesProdDAO")
public interface SYProdDao {
	public List<SYProdTblVo> prod_tbl_select(SYProdTblVo vo);
}
