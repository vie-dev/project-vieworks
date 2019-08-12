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

import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;

import kr.co.passcombine.mes.dao.SYProdDao_201904;
import kr.co.passcombine.mes.dao.SYHubDAO;
import kr.co.passcombine.mes.sap.VmesJcoConnectVo;
import kr.co.passcombine.mes.sap.VmesJcoConnection;
import kr.co.passcombine.mes.vo.SYDmrPbaVo;
import kr.co.passcombine.mes.vo.SYHubRoutingDetailVo;
import kr.co.passcombine.mes.vo.SYHubRoutingHeaderVo;
import kr.co.passcombine.mes.vo.SYMemberVo;
import kr.co.passcombine.mes.vo.SYMenuVo;
import kr.co.passcombine.mes.vo.SYMesWkctrVo;
import kr.co.passcombine.mes.vo.SYPissueInspectionVo;
import kr.co.passcombine.mes.vo.SYProdVo;
import kr.co.passcombine.mes.vo.SYReqmMatnrTblVo;
import kr.co.passcombine.mes.vo.SYScmRawSernrVo;
import kr.co.passcombine.mes.vo.SYPoRequirementVo;
import kr.co.passcombine.mes.vo.SYSernrManageVo;
import kr.co.passcombine.mes.vo.SYStockVo;
import kr.co.passcombine.mes.vo.SYTransReceiptVo;
import kr.co.passcombine.mes.vo.SYVprodVo;
import kr.co.passcombine.mes.vo.SYWfwotherVo;
import kr.co.passcombine.mes.vo.SYLineVo;


@SuppressWarnings("unchecked")
@Service(value = "vmesProd201904Service")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYProdService_201904 {

	// private static final Logger logger = LoggerFactory.getLogger(SYCodeService.class);
	@Resource
	private Environment environment;
	
	@Resource(name = "vmesSapMasterService")
	SapMasterService sapMasterService;
	
	@Resource(name = "vmesProd201904DAO")
	private SYProdDao_201904 prodDAO;
 
	@Transactional
	public void insertSapProdOrd(){
		
		//Sap 오더 RFC(ZIFFM_POP_PP003) Call		 
		int result1 =0;
		int result2 =0;
		SYProdVo pVo = new SYProdVo();
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		
		String IV_FDATE = "20170801";
		String IV_TDATE = "20170830";
		
		JCoTable t_tab1 = null;
		JCoTable t_tab2 = null;

		try{
			VmesJcoConnectVo connectVo = new VmesJcoConnectVo(environment);
			
			VmesJcoConnection connect = new VmesJcoConnection(connectVo); 
			
			JCoFunction function = connect.getFunction("ZIFFM_MES_PP003");
			if (function == null) {
				throw new RuntimeException("function not found in SAP.");
			}
			
			/*== Setting RFC Parameter ===================================*/
			function.getImportParameterList().setValue("IV_FDATE", IV_FDATE);
			function.getImportParameterList().setValue("IV_TDATE", IV_TDATE);
			
			/*== Return Value Mapping ===================================*/
			try {
				connect.executeFunction(function);
					
				JSONObject resultObj = new JSONObject();
				t_tab1 = function.getTableParameterList().getTable("ET_OUTPUT_2");
				t_tab2 = function.getTableParameterList().getTable("ET_OUTPUT_1");
				
				resultObj.put("e_return", function.getExportParameterList().getString("EV_STATUS"));
				resultObj.put("e_message", function.getExportParameterList().getString("EV_MESSAGE"));
				listDataJArray.add(resultObj);
				
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("message", "RFC FUNC. is success.");
				
			} catch(Exception ex){
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("message", "RFC FUNC is fail.");
				ex.printStackTrace();
			} 
			resultData.put("rows", listDataJArray);
			

		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", e.toString());
		}
		
		//rfc t_tab1 결과 prod_tbl에 insert, t_tab2 결과 prod_tbl에 update 
		 for (int i = 0; i < t_tab1.getNumRows(); i++) 
	        {
	        	t_tab1.setRow(i);
	           
	        	//prodDAO.chkSapProdOrd(t_tab1.getString("AUFNR"));	// 중복 오더 확인 개발 중...
	        	
	        	pVo.setPordno(t_tab1.getString("AUFNR"));
	        	pVo.setPordno_cnt(t_tab1.getString("APLZL"));
	        	pVo.setPordno_child(t_tab1.getString("VORNR"));
	        	pVo.setWkctr(t_tab1.getString("ARBPL"));
	        	pVo.setDept_cd(t_tab1.getString("WERKS"));
	        	pVo.setProd_memo(t_tab1.getString("LTXA1"));
	
	        	
	        	result1 = prodDAO.insertSapProdOrd(pVo);
	        	
	        }
		 
		 for (int i = 0; i < t_tab2.getNumRows(); i++) 
	        {
	        	t_tab2.setRow(i);

	        	pVo.setPordno(t_tab2.getString("AUFNR"));   			 
	            pVo.setPordno_status(t_tab2.getString("STTXT"));    	
	            pVo.setJidat(t_tab2.getString("FTRMI"));    			
	            pVo.setItnbr(t_tab2.getString("MATNR"));    			
	            pVo.setPdqty(t_tab2.getString("GAMNG"));    			
	            pVo.setSedat(t_tab2.getString("GSTRP"));    			
	            pVo.setFedat(t_tab2.getString("GLTRP"));     			
	            pVo.setProject_no(t_tab2.getString("SERNR"));     		
	            pVo.setKdauf(t_tab2.getString("KDAUF"));     			
	            pVo.setKdpos(t_tab2.getString("KDPOS"));     			
	            pVo.setEdatu(t_tab2.getString("EDATU"));     			
	            pVo.setAuart(t_tab2.getString("AUART"));     			
	            pVo.setCustomer_nm(t_tab2.getString("KUNNR_SE"));     	
	            pVo.setKunnr_se(t_tab2.getString("KUNNR_SP"));    		
	            pVo.setSapdel_yn(t_tab2.getString("LOEKZ"));     		
	            pVo.setCreate_date(t_tab2.getString("ERDAT"));     	
	            pVo.setChange_date(t_tab2.getString("AEDAT"));     	
	
	        	
	        	result2 = prodDAO.updateSapProdOrd(pVo);
	        	
	        }
	}

	//List<SYProdVo> chk_worker_update(
	/*public int chk_worker_update(SYProdVo prodVo){
		return prodDAO.chk_worker_update(prodVo);
	}*/
	
	/*public int worker_update(SYProdVo prodVo){
		return prodDAO.worker_update(prodVo);
	}*/
	
	/*public SYProdVo getProdStatus(SYProdVo code){
		return prodDAO.getProdStatus(code);
	}*/
	
	/*public int workStart_update(SYProdVo prodVo){
		int result =0;
		// check status = 'p2'
		SYProdVo tmpVo = getProdStatus(prodVo);
		if( "p2".equals(tmpVo.getPdsts()) ) {
			// possible update
			prodDAO.workStart_update(prodVo);
			List<SYProdVo> listPordno= prodDAO.popProdSelect(prodVo);
			prodDAO.workHisStart_insert(listPordno.get(0));
		} else {
			// impossible update
		}
		return result;
	}*/
	
	
	/*public int workEnd_update(SYProdVo prodVo){
		int result =0;
		prodDAO.workEnd_update(prodVo);
		List<SYProdVo> listPordno= prodDAO.popProdSelect(prodVo);
		prodDAO.workHisEnd_insert(listPordno.get(0));
		return result;
	}*/
	
	/*public int workPauseHisStart_insert(SYProdVo prodVo){
		int result =0;
		List<SYProdVo> listPordno= prodDAO.popProdSelect(prodVo);
		prodDAO.workPuaseHisStart_insert(listPordno.get(0));
		
		prodDAO.prodOrd_stat_update(prodVo);	//비가동시작 상태로 변경(pdsts : p3로 업데이트)
		return result;
	}*/
	
	/*public int workPauseHisEnd_insert(SYProdVo prodVo){
		int result =0;
		List<SYProdVo> listPordno= prodDAO.popProdSelect(prodVo);
		prodDAO.workPuaseHisEnd_insert(listPordno.get(0));
		
		prodDAO.prodOrd_stat_update(prodVo);	//비가동종료(재시작) 상태로 변경(pdsts : p4로 업데이트)
		return result;
	}*/
	
	/*public int prod_stat_update(SYProdVo prodVo) {
		return prodDAO.prod_stat_update(prodVo);
	}*/
	
	public List<SYProdVo> popProdHisChk(String pordnos){
		
		ArrayList<String> list=  new ArrayList<String>();
        
		String[] arrPordno = pordnos.split(","); 
		for(int i=0;i<arrPordno.length;i++) {
			list.add(arrPordno[i]);
		}
		return prodDAO.popProdHisChk(list);
	}
	
	public List<SYProdVo> confirmOrdChk(String pordnos){
		
		ArrayList<String> list=  new ArrayList<String>();
        
		String[] arrPordno = pordnos.split(","); 
		for(int i=0;i<arrPordno.length;i++)
		{
			list.add(arrPordno[i]);
		}
	    
		return prodDAO.confirmOrdChk(list);

	}

	public boolean popProdRoutingChk(String pordnos){
		List<SYProdVo> result = null;
		boolean popProdRoutingYN = true;

		ArrayList<String> list=  new ArrayList<String>();
		String[] arrPordno = pordnos.split(","); 
		for(int i=0; i<arrPordno.length; i++) {
			list.add(arrPordno[i]);
		}

		result = prodDAO.popProdRoutingChk(list);
		if( result.size()!=arrPordno.length )
			popProdRoutingYN = false;

		return popProdRoutingYN;
	}
	
	/*public List<SYProdVo> sapProdCode(SYProdVo code){
		return prodDAO.sapProdCode(code);
	}*/
	
	public List<SYProdVo> sapProdCode_confirm(SYProdVo code){
		return prodDAO.sapProdCode_confirm(code);
	}
	
	public int po_requirement_tbl_insert(List<SYPoRequirementVo> pVoList){
		int result=0;
		
		for (int i = 0; i < pVoList.size() ; i++){
			SYPoRequirementVo pVo = pVoList.get(i);
			
			if( i==0 )
				matr_delete(pVo.getAufnr());
			
			result = prodDAO.po_requirement_tbl_insert(pVo);
		}
		return result;
	}

	public int fn_ZIFFM_MES_PP003(JCoTable t_order, JCoTable t_proc) {
		System.out.println("******************* fn_ZIFFM_MES_PP003");
		int result=0;
		
		System.out.println(t_proc);
		System.out.println(t_order);
		/*
		|------------|--------|----|--------|----|----|----------------------------------------|-|--------|------|
		| TABLE 'ZIFYPOP_PP003_2'
		|------------|--------|----|--------|----|----|----------------------------------------|-|--------|------|
		|AUFNR       |APLZL   |VORN|ARBPL   |WERK|STEU|LTXA1                                   |F|UDATE   |UTIME |
		|------------|--------|----|--------|----|----|----------------------------------------|-|--------|------|
		|012345678901|23456789|0123|45678901|2345|6789|0123456789012345678901234567890123456789|0|12345678|901234|
		|------------|--------|----|--------|----|----|----------------------------------------|-|--------|------|
		|1000000     |00000001|0010|111040  |1110|PP01|VIVIX-1717S(B)                          | |20171018|113905|
		|1000001     |00000001|0010|111040  |1110|PP01|VIVIX-1717S(B)                          | |20171018|113905|
		|1000081     |00000001|0010|111040  |1110|PP01|SLIMPAC2 C-ARM (7M)                     | |20171018|113905|
		|1000402     |00000001|0010|111040  |1110|PP01|VIVIX-1717S(B)                          | |20171018|113905|
		|1000403     |00000001|0010|111040  |1110|PP01|VIVIX-1717S(B)                          | |20171018|113905|
		|1000448     |00000001|0010|111010  |1110|PP01|공정 .. 테스트 ..                            | |20171018|113905|
		|1000486     |00000001|0010|        |1110|PP01|공정 .. 테스트 ..                            | |20171018|113905|
		|------------|--------|----|--------|----|----|----------------------------------------|-|--------|------|
*/
		//t_proc
		List<SYProdVo> hVoList = new ArrayList<SYProdVo>();
		for (int i = 0; i < t_proc.getNumRows(); i++) {
			t_proc.setRow(i);
			SYProdVo hVo = new SYProdVo();
			hVo.setPordno(t_proc.getString("AUFNR"));
			hVo.setPordno_cnt(t_proc.getString("APLZL"));
			hVo.setPordno_child(t_proc.getString("VORNR"));
			hVo.setWkctr(t_proc.getString("ARBPL"));
			hVo.setDept_cd(t_proc.getString("WERKS"));
			hVo.setSteus(t_proc.getString("STEUS"));
			hVo.setFrdlb(t_proc.getString("FRDLB"));
			hVoList.add(hVo);
        }
		/*
		|------------|----|----------------------------------------|--------|----------------------------------------|----------------|--------|--------|------------------|----------|------|--------------------|--------|----------------------------------------|----------------------------------------|----|---|----|-|----------------------------------------|----------------------------------------|----------------------------------------|------------|--------|--------|--------|------|
		| TABLE 'ZIFYPOP_PP003_1'
		|------------|----|----------------------------------------|--------|----------------------------------------|----------------|--------|--------|------------------|----------|------|--------------------|--------|----------------------------------------|----------------------------------------|----|---|----|-|----------------------------------------|----------------------------------------|----------------------------------------|------------|--------|--------|--------|------|
		|AUFNR       |WERK|STTXT                                   |FTRMI   |MATNR                                   |GAMNG           |GSTRP   |GLTRP   |SERNR             |KDAUF     |KDPOS |BEZEI               |EDATU   |KUNNR_SE                                |KUNNR_SP                                |LGOR|DIS|AUAR|L|ZAUFNR                                  |KTEXT                                   |ZMATNR                                  |ZCSREQ      |ERDAT   |AEDAT   |UDATE   |UTIME |
		|------------|----|----------------------------------------|--------|----------------------------------------|----------------|--------|--------|------------------|----------|------|--------------------|--------|----------------------------------------|----------------------------------------|----|---|----|-|----------------------------------------|----------------------------------------|----------------------------------------|------------|--------|--------|--------|------|
		|012345678901|2345|6789012345678901234567890123456789012345|67890123|4567890123456789012345678901234567890123|   4   5   6   7|89012345|67890123|456789012345678901|2345678901|234567|89012345678901234567|89012345|6789012345678901234567890123456789012345|6789012345678901234567890123456789012345|6789|012|3456|7|8901234567890123456789012345678901234567|8901234567890123456789012345678901234567|8901234567890123456789012345678901234567|890123456789|01234567|89012345|67890123|456789|
		|------------|----|----------------------------------------|--------|----------------------------------------|----------------|--------|--------|------------------|----------|------|--------------------|--------|----------------------------------------|----------------------------------------|----|---|----|-|----------------------------------------|----------------------------------------|----------------------------------------|------------|--------|--------|--------|------|
		|1000000     |1110|VIVIX-1717S(B)                          |20170913|HV2002                                  |000000000001000C|20171013|20171013|                  |5000000000|000010|                    |00000000|                                        |                                        |2050|101|ZP01| |                                        |                                        |                                        |            |20170913|20171018|20171018|113905|
		|1000001     |1110|VIVIX-1717S(B)                          |20170913|HV2002                                  |000000000001000C|20170707|20170707|000000000030000147|5000000000|000010|                    |00000000|                                        |                                        |2050|101|ZP01| |                                        |                                        |                                        |            |20170913|20171018|20171018|113905|
		|1000081     |1110|SLIMPAC2 C-ARM (7M)                     |20170927|HF5030                                  |000000000001000C|20170902|20170902|000000000030000006|5000000006|000010|표준                  |20171011|EB Medical                              |                                        |2050|101|ZP01| |                                        |                                        |                                        |            |20170927|20171018|20171018|113905|
		|1000402     |1110|VIVIX-1717S(B)                          |20171011|HV2002                                  |000000000001000C|20171018|20171018|                  |          |000000|                    |00000000|                                        |                                        |2050|101|ZP01| |                                        |                                        |                                        |            |20171011|20171018|20171018|113905|
		|1000403     |1110|VIVIX-1717S(B)                          |20171011|HV2002                                  |000000000001000C|20171018|20171018|                  |          |000000|                    |00000000|                                        |                                        |2050|101|ZP01| |                                        |                                        |                                        |            |20171011|20171018|20171018|113905|
		|1000448     |1110|RCMF-1035H                              |20171016|1196-1006                               |000000000001000C|20171011|20171011|2345              |          |000000|                    |00000000|                                        |                                        |2030|201|ZP01| |                                        |                                        |                                        |            |20171016|20171018|20171018|113905|
		|1000486     |1110|재작업 -20171018                           |20171018|                                        |000000000001000C|20171018|20171018|                  |          |000000|                    |00000000|                                        |                                        |    |   |ZP02| |000001000448                            |                                        |1196-1006                               |            |20171017|20171018|20171018|113905|
		|------------|----|----------------------------------------|--------|----------------------------------------|----------------|--------|--------|------------------|----------|------|--------------------|--------|----------------------------------------|----------------------------------------|----|---|----|-|----------------------------------------|----------------------------------------|----------------------------------------|------------|--------|--------|--------|------|
*/
		// t_order
		List<SYProdVo> dVoList = new ArrayList<SYProdVo>();
		for (int i = 0; i < t_order.getNumRows(); i++) {
			SYProdVo dVo = new SYProdVo();
			t_order.setRow(i);
			dVo.setPordno(t_order.getString("AUFNR"));
			dVo.setWerks(t_order.getString("WERKS"));
			dVo.setPordno_status(t_order.getString("STTXT"));
			dVo.setJidat(t_order.getString("FTRMI").replaceAll("-", ""));
			dVo.setPdqty(t_order.getString("GAMNG"));
			dVo.setSedat(t_order.getString("GSTRP").replaceAll("-", ""));
			dVo.setFedat(t_order.getString("GLTRP").replaceAll("-", ""));
			dVo.setProject_no(t_order.getString("SERNR"));
			dVo.setKdauf(t_order.getString("KDAUF"));
			dVo.setKdpos(t_order.getString("KDPOS"));
			dVo.setBezei(t_order.getString("BEZEI"));
			dVo.setEdatu(t_order.getString("EDATU").replaceAll("-", ""));
			dVo.setKunnr_se(t_order.getString("KUNNR_SE"));
			dVo.setCustomer_nm(t_order.getString("KUNNR_SP"));
			dVo.setSernp(t_order.getString("SERNP"));
			dVo.setLgort(t_order.getString("LGORT"));
			dVo.setDispo(t_order.getString("DISPO"));
			dVo.setAuart(t_order.getString("AUART"));
			String auart = t_order.getString("AUART");
			// ZP03 ==> cs order
			if ( auart.equals("ZP02") || auart.equals("ZP03") || auart.equals("ZP04") || auart.equals("ZP09")) {
				dVo.setZaufnr(t_order.getString("ZAUFNR"));
				dVo.setKtext(t_order.getString("KTEXT"));
				if ( auart.equals("ZP02") || auart.equals("ZP04") ) {
					dVo.setItnbr(t_order.getString("ZMATNR"));
				}else{
					dVo.setItnbr(t_order.getString("MATNR"));
				}
			} else {
				dVo.setItnbr(t_order.getString("MATNR"));
				dVo.setZaufnr("");
				dVo.setKtext("");
			}
			dVo.setPdsts("p1");
			dVo.setSapdel_yn(t_order.getString("LOEKZ"));
//			dVo.setZcsreq("");
			dVo.setZcsreq(t_order.getString("ZCSREQ")); // data check
			
/*			AD_NAME1		END 고객명	Char	20	
			ZZAPPLICATION		Application	Char	50	
			ZZSWOPTION		SW Option	Char	5	
			ZTFTSERIAL		TFT 시리얼 번호	Char	18	
			ZLONGTEXT		작업 지시 주요 사항	Char	100	
*/
 	
			dVo.setAd_name1(t_order.getString("AD_NAME1")); // 포장관련 추가
			dVo.setZzapplication(t_order.getString("ZZAPPLICATION")); //  포장관련 추가
			dVo.setZzswoption(t_order.getString("ZZSWOPTION")); //  포장관련 추가
			dVo.setZzswoptiont(t_order.getString("ZZSWOPTIONT")); //  포장관련 추가
			  
			dVo.setZtftserial(t_order.getString("ZTFTSERIAL")); //  포장관련 추가
			dVo.setZlongtext(t_order.getString("ZLONGTEXT")); //  포장관련 추가
			dVo.setZgrade(t_order.getString("ZGRADE")); //  grade 관련  추가
			
			dVo.setCreate_date(t_order.getString("ERDAT").replaceAll("-", ""));
			dVo.setChange_date(t_order.getString("AEDAT").replaceAll("-", ""));
			
			dVo.setZauart(t_order.getString("ZAUART"));
			dVo.setZbezei(t_order.getString("ZBEZEI"));
			
			dVoList.add(dVo);
        }
		
		List<SYProdVo> sVoList = new ArrayList<SYProdVo>();
		for( SYProdVo hVo : hVoList ){
			for( SYProdVo dVo : dVoList ){
				if( (hVo.getPordno()).equals(dVo.getPordno()) ){
					SYProdVo sVo = new SYProdVo();
					sVo.setPordno(hVo.getPordno());
					sVo.setPordno_cnt(hVo.getPordno_cnt());
					sVo.setPordno_child(hVo.getPordno_child());
					sVo.setWkctr(hVo.getWkctr());
					sVo.setDept_cd(hVo.getDept_cd());
					sVo.setSteus(hVo.getSteus());
					sVo.setFrdlb(hVo.getFrdlb());
					sVo.setWerks(dVo.getWerks());
					sVo.setPordno_status(dVo.getPordno_status());
					sVo.setJidat(dVo.getJidat());
					sVo.setPdqty(dVo.getPdqty());
					sVo.setSedat(dVo.getSedat());
					sVo.setFedat(dVo.getFedat());
					sVo.setProject_no(dVo.getProject_no());
					sVo.setKdauf(dVo.getKdauf());
					sVo.setKdpos(dVo.getKdpos());
					sVo.setBezei(dVo.getBezei());
					sVo.setEdatu(dVo.getEdatu());
					sVo.setSernp(dVo.getSernp());
					sVo.setKunnr_se(dVo.getKunnr_se());
					sVo.setCustomer_nm(dVo.getCustomer_nm());
					sVo.setLgort(dVo.getLgort());
					sVo.setDispo(dVo.getDispo());
					sVo.setAuart(dVo.getAuart());
					sVo.setZaufnr(dVo.getZaufnr());
					sVo.setKtext(dVo.getKtext());
					sVo.setItnbr(dVo.getItnbr());
					sVo.setPdsts("p1");
					sVo.setSapdel_yn(dVo.getSapdel_yn());
					sVo.setZcsreq(dVo.getZcsreq());
					
				/*	dVo.setAd_name1(t_order.getString("AD_NAME1")); // 포장관련 추가
					dVo.setZzapplication(t_order.getString("ZZAPPLICATION")); //  포장관련 추가
					dVo.setZzswoption(t_order.getString("ZZSWOPTION")); //  포장관련 추가
					dVo.setZtftserial(t_order.getString("ZTFTSERIAL")); //  포장관련 추가
					dVo.setZlongtext(t_order.getString("ZLONGTEXT")); //  포장관련 추가*/
					
					sVo.setAd_name1(dVo.getAd_name1());
					sVo.setZzapplication(dVo.getZzapplication());
					sVo.setZzswoption(dVo.getZzswoption());
					sVo.setZzswoptiont(dVo.getZzswoptiont());
					 
					sVo.setZtftserial(dVo.getZtftserial());
					sVo.setZlongtext(dVo.getZlongtext());
					// zgrade 추가 
					
					sVo.setZgrade(dVo.getZgrade());
					sVo.setZauart(dVo.getZauart());
					sVo.setZbezei(dVo.getZbezei());
					
					sVo.setCreate_date(dVo.getCreate_date());
					sVo.setChange_date(dVo.getChange_date());
					sVoList.add(sVo);
				}
			}
		}
		
//		System.out.println(sVoList.toString());
		
		for( SYProdVo sVo : sVoList ){
			String upPordNo = chkProdExist(sVo);
			if ( upPordNo.equals("insert") ){
				result += prodDAO.insert_ZIFFM_MES_PP003(sVo);
			} else {
				result += prodDAO.update_ZIFFM_MES_PP003(sVo);
			}
		}
		
		return result;
	}
	
	public String chkProdExist(SYProdVo pVo) {
		String resultStr = "insert";
		List<SYProdVo> resultList = prodDAO.chkProdExist(pVo);
		if( resultList.size()>0 ){
			// pordNo 로 검색하여 1건이상이 나오면, 그 데이터의 change date, SAPDEL_YN 비교하여 변경이 있으면 업데이트
			String chDate = pVo.getChange_date();
			String sapDelYn = pVo.getSapdel_yn();
			for( SYProdVo prodVo : resultList ) {
				if ( !(prodVo.getChange_date()).equals(chDate) || !(prodVo.getSapdel_yn().equals(sapDelYn)) ) {
					resultStr = prodVo.getPordno();
				} else {
					// nothing.
					resultStr = "";
				}
			}
		} else {
			// 0건이면 insert
			//resultStr = "";
		}
		return resultStr;
	}
	
	/*public List<SYProdVo> popProdSelect(SYProdVo code){
		List<SYProdVo> result_list = prodDAO.popProdSelect(code);
		for(int i=0 ; i<result_list.size(); i++) {
			String end_time = (result_list.get(i).getProd_end_time() == null)?"":result_list.get(i).getProd_end_time();
			if(end_time.length() != 0) {
				String prod_time = pop_his_prod_time(result_list.get(i));	
				result_list.get(i).setDiff_time(prod_time);	
			} else {
				result_list.get(i).setDiff_time("");
			}
		}
				
		return result_list;
	}*/

	public List<SYProdVo> select1(SYProdVo code){
		return prodDAO.select1(code);
	}
	
	public List<SYProdVo> select2(SYProdVo code){
		return prodDAO.select2(code);
	}
	
	public List<SYProdVo> select3(SYProdVo code){
		return prodDAO.select3(code);
	}
	
	public List<SYProdVo> select4(SYProdVo code){
		return prodDAO.select4(code);
	}

	/*public List<SYProdVo> worker_select_1110(SYMemberVo code){
		return prodDAO.worker_select_1110(code);
	}*/
	
	/*public List<SYProdVo> popProdHisSelect(SYProdVo code){
		return prodDAO.popProdHisSelect(code);
	}*/
	
	public List<SYProdVo> popProdHisSelect_confrim(SYProdVo code){
		return prodDAO.popProdHisSelect_confrim(code);
	}

	public int faultMemo_update(SYProdVo code){
		return prodDAO.faultMemo_update(code);
	}
	
	public int prodOrdNonConfirm(String pordnos){
		String[] arrPordno = pordnos.split(",");
		
	  //미확정오더 flag처리(해당 오더 pdsts값 p1로 update)
	  int result = 0;
		if(arrPordno != null && arrPordno.length > 0){
			for(int i=0;i<arrPordno.length; i++){
				SYProdVo pVo = new SYProdVo();
				
				//String[] arrPordnoCmdat = arrPordno[i].split("/");
				
				pVo.setPordno(arrPordno[i]);
				pVo.setCreator(pVo.getCreator());
				pVo.setUpdater(pVo.getUpdater());
				result = prodDAO.updateProdOrdNonConfirm(pVo);
				
				pVo.setPordno_pop(arrPordno[i] + "0010");
				result = prodDAO.deletetProdOrdTbl(pVo);
			}
		}

		//공정별로 분기 된 mes확정오더 삭제 
//		if(arrPordno != null && arrPordno.length > 0){
//			for(int i=0;i<arrPordno.length; i++){
//				SYProdVo pVo = new SYProdVo();
//				
//				List<SYProdVo> listSYProdVo= prodDAO.selectProdOrdtbl(arrPordno[i]);
//
//				for(int k=0;k<listSYProdVo.size(); k++) {
//					listSYProdVo.get(k).setPordno_pop(listSYProdVo.get(k).getPordno() + listSYProdVo.get(k).getPordno_child());
//					result = prodDAO.deletetProdOrdTbl(listSYProdVo.get(k));
//				}
////				pVo.setUpdater(pVo.getUpdater());			<- 미확정잡은 사람, 변경일자 내용 추가해야함...update
//			}
//		}
		return result; 
	}
	/*
	public int updateProdOrdConfirm(String pordnos, String pdsts){
		String[] arrPordno = pordnos.split(",");
		
	  //확정오더 flag처리(해당 오더 pdsts값 p2로 update)
		int result = 0;
	  
		if(arrPordno != null && arrPordno.length > 0){
			
			ArrayList<String> routing_gno_arr = new ArrayList<String>();
			ArrayList<String> routing_no_arr = new ArrayList<String>();
			
			//확정오더 공정별로 분기
			for(int i=0;i<arrPordno.length; i++){
				SYProdVo pVo = new SYProdVo();
				String[] arrPordnoCmdat = arrPordno[i].split("/");
				String cmdat = arrPordnoCmdat[1];
				List<SYProdVo> listSYProdVo= prodDAO.selectProdOrdtbl(arrPordnoCmdat[0]);
				// for update prod_tbl
				routing_gno_arr.add( listSYProdVo.get(0).getRouting_gno() );
				routing_no_arr.add( (listSYProdVo.get(0)).getRouting_no() );
				
				for(int k=0;k<listSYProdVo.size(); k++){
					listSYProdVo.get(k).setPordno_pop(listSYProdVo.get(k).getPordno() + listSYProdVo.get(k).getPordno_child());
					listSYProdVo.get(k).setCmdat(cmdat);
					result = prodDAO.insertProdOrdTbl(listSYProdVo.get(k));
				}
//				pVo.setUpdater(pVo.getUpdater());			<- 확정잡은 사람, 변경일자 내용 추가해야함...update	
			}
			
			for(int gi=0; gi<arrPordno.length; gi++){
				SYProdVo pVo = new SYProdVo();
				String[] arrPordnoCmdat = arrPordno[gi].split("/");
				
				pVo.setPordno(arrPordnoCmdat[0]);
				pVo.setCmdat(arrPordnoCmdat[1]);
				pVo.setPdsts(pdsts);
				pVo.setRouting_gno(routing_gno_arr.get(gi));
				pVo.setRouting_no(routing_no_arr.get(gi));
				pVo.setCreator(pVo.getCreator());
				pVo.setUpdater(pVo.getUpdater());
				
				result = prodDAO.updateProdOrdConfirm(pVo);	// update prod_tbl : pdsts, cmdat
//				prodDAO.faultMemo_update(pVo);
			}
		}
		return result; 
	}
	*/
	
	public int updateProdOrdConfirm(List<SYProdVo> list){
		int result = 0;
		String routing_gno_gubun = null;

		if( list.size() > 0){
			ArrayList<String> routing_gno_arr = new ArrayList<String>();
			ArrayList<String> routing_no_arr = new ArrayList<String>();
			
			//확정오더 공정별로 분기
			for( int i=0; i<list.size(); i++) {
				SYProdVo pVo =list.get(i);
				String cmdat = pVo.getCmdat();
				String cmdat_seq = pVo.getCmdat_seq();
				String project_no = pVo.getProject_no();
				
				List<SYProdVo> listSYProdVo= prodDAO.selectProdOrdtbl(pVo.getPordno());
				// for update prod_tbl
				routing_gno_arr.add( listSYProdVo.get(0).getRouting_gno() );
				routing_no_arr.add( (listSYProdVo.get(0)).getRouting_no() );
				pVo.setRouting_gno(listSYProdVo.get(0).getRouting_gno());
				pVo.setRouting_no((listSYProdVo.get(0)).getRouting_no());
				
				if((listSYProdVo.get(0)).getRouting_gno_gubun().equals("Y")) {
					routing_gno_gubun = "C";
				} else {
					routing_gno_gubun = "P";
				}
					
				pVo.setRouting_gno_gubun(routing_gno_gubun);
				
				System.out.println("#################### :: getRouting_gno_gubun");
				System.out.println(pVo.getRouting_gno_gubun());
				
				
				for(int k=0;k<listSYProdVo.size(); k++){
					listSYProdVo.get(k).setPordno_pop(listSYProdVo.get(k).getPordno() + listSYProdVo.get(k).getPordno_child());
					listSYProdVo.get(k).setCmdat(cmdat.replaceAll("-", ""));
					listSYProdVo.get(k).setCmdat_seq(cmdat_seq);
					
					listSYProdVo.get(k).setProject_no(project_no);;
					
					String chDate = listSYProdVo.get(k).getChange_date().replaceAll("-", "");
					listSYProdVo.get(k).setChange_date(chDate);
					String crDate = listSYProdVo.get(k).getCreate_date().replaceAll("-", "");
					listSYProdVo.get(k).setCreate_date(crDate);
					listSYProdVo.get(k).setRouting_gno_gubun(routing_gno_gubun);
					result = prodDAO.insertProdOrdTbl(listSYProdVo.get(k));
				}

				result = prodDAO.updateProdOrdConfirm(pVo); // update prod_tbl : pdsts, cmdat
			}
		}
		return result; 
	}
	
	public List<SYPoRequirementVo> matr_select(String aufnr) {
		SYPoRequirementVo vo = new SYPoRequirementVo();
		vo.setAufnr(aufnr);
		List<SYPoRequirementVo> list = prodDAO.matr_select(vo);
		return list;
	}
	
	public void matr_insert(String pordnos){
		String[] arrPordno = pordnos.split(",");
		if(arrPordno != null && arrPordno.length > 0){
			for(int i=0;i<arrPordno.length; i++){
//				sapMasterService.rfc_ziffm_pop_pp004(arrPordno[i], "call_product_register");		// rfc 호출해서 소요자재 받아오고 테이블에 insert까지...
				HashMap<String, Object> hashData = sapMasterService.ziffm_pop_pp004("ZIFFM_MES_PP004", arrPordno[i], "X");
				List<SYPoRequirementVo> voList = (List<SYPoRequirementVo>)hashData.get("voList");
				int result = po_requirement_tbl_insert(voList);
			}
		}
	}
	
	public int matr_delete(String pordnos){
		ArrayList<String> list=  new ArrayList<String>();
		String[] arrPordno = pordnos.split(","); 
		for(int i=0; i<arrPordno.length; i++) {
			list.add(arrPordno[i]);
		}
		return prodDAO.matr_delete(list);
	}
	
	/*public int updateMainSerial(SYProdVo code){
		return prodDAO.updateMainSerial(code);
	}*/

	public int chkSerialNoDuplicate(SYSernrManageVo code){
		return prodDAO.chkSerialNoDuplicate(code);
	}
	
	/*public int updateDetailSerial(SYProdVo code){
		return prodDAO.updateDetailSerial(code);
	}*/
	
	public int insertMasterCode(SYProdVo code){
		return prodDAO.insertMasterCode(code);
	}
	public int updateMasterCode(SYProdVo code){
		return prodDAO.updateMasterCode(code);
	}

	public int deleteMasterCode(SYProdVo code){
		//int result = codeDAO.deleteDetailCode(code);
		return prodDAO.deleteMasterCode(code);
	}
	
	public int insertDetailCode(SYProdVo code){
		return prodDAO.insertDetailCode(code);
	}
	public int updateDetailCode(SYProdVo code){
		return prodDAO.updateDetailCode(code);
	}
	public int deleteDetailCode(SYProdVo code){
		return prodDAO.deleteDetailCode(code);
	}

	public String prod_end_chk(String routing_no) {
		return prodDAO.prod_end_chk(routing_no);
	}
	
	/*public int insertSernrManageTbl(SYSernrManageVo vo) {
		return prodDAO.insertSernrManageTbl(vo);
	}*/

	/*public int deleteSernrManageTbl(SYSernrManageVo vo) {
		return prodDAO.deleteSernrManageTbl(vo);
	}*/
	
	/*public List<SYSernrManageVo> selectSernrManageTbl(SYSernrManageVo vo) {
		return prodDAO.selectSernrManageTbl(vo);
	}*/

	public List<SYProdVo> wkctr_code_select(String werks) {
		return prodDAO.wkctr_code_select(werks);
	}

	/*public int lastInspec_insert(SYProdVo sVo) {
		int result =0;
		
		
		List<SYProdVo> list = prodDAO.sapProdCode(sVo);
		for(int i=0 ; i<list.size(); i++) {
			list.get(i).setRouting_no(sVo.getRouting_no());
			result = prodDAO.lastInspec_insert(list.get(i));
		}
		return result;
	}*/

	/*public int prodTbl_pdsts_update(SYProdVo sVo) {
		int result =0;
//
//		List<SYProdVo> list = prodDAO.sapProdCode(sVo);
//		for(int i=0 ; i<list.size(); i++) {
//			list.get(i).setPdsts("p8");
			result = prodDAO.prodTbl_pdsts_update(sVo);
//		}
		return result;
	}*/
	
	public int deletetProdOrdTbl(List<SYProdVo> list) {
		int cnt = 0;
		for(SYProdVo prodVo : list) {
			cnt += prodDAO.deletetProdOrdTbl(prodVo);
		}
		return cnt;
	}

	public List<SYSernrManageVo> fault_grid_select(SYSernrManageVo sVo) {
		return prodDAO.fault_grid_select(sVo);
	}

	/*public int insertPissueInspectionTbl(SYPissueInspectionVo tmpVo) {
		return prodDAO.insertPissueInspectionTbl(tmpVo);
		
	}*/

	public int updatePissueInspectionTbl(SYPissueInspectionVo tmpVo) {
		return prodDAO.updatePissueInspectionTbl(tmpVo);
	}
	
	/*public int prodOrd_stat_update(SYProdVo tmpVo) {
		return prodDAO.prodOrd_stat_update(tmpVo);
	}*/

	public List<SYProdVo> prodRfcConf_yn(String pordno) {
		return prodDAO.prodRfcConf_yn(pordno);
	}

	/*public int confirm_ord_dmr_update(String pordnos) {
		
		int result =0;
		ArrayList<String> list=  new ArrayList<String>();
        
		String[] arrPordno = pordnos.split(","); 
		for(int i=0;i<arrPordno.length;i++) {
			list.add(arrPordno[i]);
		}
		
		SYProdVo pVo = new SYProdVo();
		pVo.setList(list);
		
		List<SYProdVo> ord_list = prodDAO.sapProdCode(pVo);
		
		System.out.println("***********************파라미터****************************");
		System.out.println("ord_list :: " + ord_list.toString());
		System.out.println("ord_list :: " + ord_list.size());
		
		for(int i=0;i<ord_list.size();i++) {
			
			SYProdVo ppVo = new SYProdVo();
			
			String pordno = ord_list.get(i).getPordno();
			
			System.out.println("***********************파라미터****************************");
			System.out.println("pordno :: " + pordno);
			
			String itnbr = ord_list.get(i).getItnbr();
			String dept_cd = ord_list.get(i).getDept_cd();

			ppVo.setPordno(pordno);
			ppVo.setMatnr(itnbr);
			ppVo.setDept_cd(dept_cd);
			
			List<SYProdVo> dmr_list = prodDAO.dmr_select(ppVo);
			
			if(dmr_list.size() > 0) {				//데이터가 있을때 정상적인 경우 1개 로우만 검색된다...
				
				String gr_no = dmr_list.get(0).getGr_no();
				String gr_seq = dmr_list.get(0).getGr_seq();
				String ecr_no = dmr_list.get(0).getEcr_no();
				String rn_no = dmr_list.get(0).getRn_no(); 
				String dmr_no = dmr_list.get(0).getDmr_no();
															
				ppVo.setGr_no(gr_no);
				ppVo.setGr_seq(gr_seq);
				ppVo.setEcr_no(ecr_no);
				ppVo.setRn_no(rn_no);
				ppVo.setDmr_no(dmr_no);
				
				System.out.println("***********************파라미터****************************");
				System.out.println(ppVo.toString());
				
				result = prodDAO.confirm_ord_dmr_update(ppVo);
			}
		}
		
		return result;
	}*/

	/*public List<SYProdVo> prodUserInfo(SYProdVo prodVo) {
		return prodDAO.prodUserInfo(prodVo);
	}*/

	public List<SYProdVo> jo_select(SYProdVo prodVo) {
		return prodDAO.jo_select(prodVo);
	}

	public int jocod_update(SYProdVo sVo) {
		return prodDAO.jocod_update(sVo);
	}
	
	@Transactional
	public List<SYLineVo> line_header_select(SYLineVo lineVo){
		return prodDAO.line_header_select(lineVo);
	}
	
	public int line_header_save(List<SYLineVo> lineList) {
		int resultCnt = 0;
		SYLineVo tmpVo = new SYLineVo();
		tmpVo.setJocod(lineList.get(0).getJocod());
 
		prodDAO.line_header_delete(tmpVo);
		
		for( SYLineVo vo : lineList ){
			
			resultCnt += prodDAO.line_header_insert(vo);
		}
		return resultCnt;
	}
	
	// 
	@Transactional
	public int line_member_select_count(SYLineVo lineVo){
		return prodDAO.line_member_select_count(lineVo);
	}
	
	@Transactional
	public List<SYLineVo> line_member_select(SYLineVo lineVo){
		return prodDAO.line_member_select(lineVo);
	}
	
	@Transactional
	public int line_member_delete(SYLineVo hubDVo){
		return prodDAO.line_member_delete(hubDVo);
	}
	@Transactional
	public int loadmemberinfo_count(SYLineVo lineVo){
		return prodDAO.loadmemberinfo_count(lineVo);
	}
	
	@Transactional
	public List<SYLineVo> loadmemberinfo(SYLineVo lineVo){
		return prodDAO.loadmemberinfo(lineVo);
	}
	
	public int fnWorkerAdd(List<SYLineVo> lineList) {
		int resultCnt = 0;
 
		for( SYLineVo vo : lineList ){
			
			resultCnt += prodDAO.fnWorkerAdd(vo);
		}
		return resultCnt;
	}

	/*public List<SYProdVo> getReworkSubjectData(SYProdVo prodVo) {
		return prodDAO.getReworkSubjectData(prodVo);
	}*/

	/*public int projectNoDupChk(SYProdVo pordVo) {
		return prodDAO.projectNoDupChk(pordVo);
	}*/

	public List<SYSernrManageVo> sernrCntChk(SYSernrManageVo pVo) {
		return prodDAO.sernrCntChk(pVo);
	}
	
	/*public List<SYMesWkctrVo> mes_wkctr_tbl_select(SYMesWkctrVo pVo) {
		return prodDAO.mes_wkctr_tbl_select(pVo);
	}*/

	public List<SYMemberVo> jo_worker_select(SYMemberVo memberVo) {
		return prodDAO.jo_worker_select(memberVo);
	}

	public int updateLastInspSerial(SYProdVo pordVo) {
		   return prodDAO.updateLastInspSerial(pordVo);		
	}

	/*public void faultHisInsert(List<SYSernrManageVo> voList, String user_id, String routing_no, String fault_no) {
		
		for(int i=0 ; i<voList.size(); i++) {
			SYSernrManageVo pVo = voList.get(i);
			pVo.setFault_no(fault_no);
			pVo.setRouting_no((routing_no.equals("null"))?null:routing_no);
			
			if(pVo.getPordno() == null) {
				pVo.setRouting_no("");
			} else {
				pVo.setRouting_no((routing_no.equals("null"))?null:routing_no);
			}
			
			if(pVo.getReverse() == null) {
				pVo.setIn_gubun("N");
			} else {
				pVo.setIn_gubun("Y");
			}
			
			pVo.setCreator(user_id);
			prodDAO.faultHisInsert(pVo);		
		}
	}*/

	/*public String faultKeySelect() {
		return prodDAO.faultKeySelect();
	}*/	
	
	public List<SYProdVo> selectfault_his_tbl(SYProdVo code){
		return prodDAO.selectfault_his_tbl(code);
	}
	
	/*public String pop_his_prod_time(SYProdVo mVo){
		String isdd = "";
		String isdz = "";
		String iedd = "";
		String iedz = "";
		
		*//******** 비가동 시간 합 : Start *********//*
		SYProdVo pVo = new SYProdVo();

		pVo.setPordno_pop(mVo.getPordno_pop());
		pVo.setRouting_no(mVo.getRouting_no());
		List<SYProdVo> prod_his_list = popProdHisSelect(pVo);
	
		String start_dt = null;
		String end_dt = null;
		String pause_start_dt = null;
		String pause_end_dt = null;

		
		
		long total_minute = 0;
		long p_total_minute = 0;

		for (int i = 0; i < prod_his_list.size(); i++) {
			////////////////////////////시작, 종료시간 구하는 부분////////////////////////////
			if(i == 0) {
				String s_dttm = "20" + (prod_his_list.get(i).getStart_dt_tm().replace(":", "-").replace(" ","-").replace("-",""));
				isdd = s_dttm.substring(0, 8); // 작업시작일자
				isdz = s_dttm.substring(8, 14); // 작업시작시간
			}
			if(i == (prod_his_list.size()-1)) {
				String e_dttm = "20" + (prod_his_list.get(i).getEnd_dt_tm().replace(":", "-").replace(" ","-").replace("-",""));
				iedd = e_dttm.substring(0, 8); // 작업시작일자
				iedz = e_dttm.substring(8, 14); // 작업시작시간
			}
			
			////////////////////////////가동시간 구하는 부분////////////////////////////
			if (prod_his_list.get(i).getStart_dt_tm().trim().length() != 0) {
				start_dt = prod_his_list.get(i).getStart_dt_tm();
			}
			if (prod_his_list.get(i).getEnd_dt_tm().trim().length() != 0) {
				end_dt = prod_his_list.get(i).getEnd_dt_tm();
				// 비가동 시간 합 연산...
				String m_start_dt = "20" + (start_dt.replace(":", "-").replace(" ","-"));
				String m_end_dt = "20" + (end_dt.replace(":", "-").replace(" ", "-"));
				String[] s_date_arr = m_start_dt.split("-");
				String[] e_date_arr = m_end_dt.split("-");

				Calendar date1 = Calendar.getInstance();
				Calendar date2 = Calendar.getInstance();

				date1.set(Integer.parseInt(s_date_arr[0]),
						Integer.parseInt(s_date_arr[1]),
						Integer.parseInt(s_date_arr[2]),
						Integer.parseInt(s_date_arr[3]),
						Integer.parseInt(s_date_arr[4]),
						Integer.parseInt(s_date_arr[5]));

				date2.set(Integer.parseInt(e_date_arr[0]),
						Integer.parseInt(e_date_arr[1]),
						Integer.parseInt(e_date_arr[2]),
						Integer.parseInt(e_date_arr[3]),
						Integer.parseInt(e_date_arr[4]),
						Integer.parseInt(e_date_arr[5]));

				long minute = (date2.getTimeInMillis() - date1.getTimeInMillis()) / 60000;
				
				String m_cnt = prod_his_list.get(i).getMember_cnt();			
				if(m_cnt == null ) {
					m_cnt = "1";
				}
				minute = minute * Long.parseLong(m_cnt);
				total_minute = total_minute + minute;
			}
			
			////////////////////////////비가동 구하는 부분//////////////////////////// 
			if (prod_his_list.get(i).getPause_start_dt_tm().trim().length() != 0) {
				pause_start_dt = prod_his_list.get(i).getPause_start_dt_tm();
			}
			if (prod_his_list.get(i).getPause_end_dt_tm().trim().length() != 0) {
				pause_end_dt = prod_his_list.get(i).getPause_end_dt_tm();
				// 비가동 시간 합 연산...
				String ntcod_start_dt = "20" + (pause_start_dt.replace(":", "-").replace(" ","-"));
				String ntcod_end_dt = "20" + (pause_end_dt.replace(":", "-").replace(" ", "-"));
				String[] s_date_arr = ntcod_start_dt.split("-");
				String[] e_date_arr = ntcod_end_dt.split("-");

				Calendar date1 = Calendar.getInstance();
				Calendar date2 = Calendar.getInstance();

				date1.set(Integer.parseInt(s_date_arr[0]),
						Integer.parseInt(s_date_arr[1]),
						Integer.parseInt(s_date_arr[2]),
						Integer.parseInt(s_date_arr[3]),
						Integer.parseInt(s_date_arr[4]),
						Integer.parseInt(s_date_arr[5]));

				date2.set(Integer.parseInt(e_date_arr[0]),
						Integer.parseInt(e_date_arr[1]),
						Integer.parseInt(e_date_arr[2]),
						Integer.parseInt(e_date_arr[3]),
						Integer.parseInt(e_date_arr[4]),
						Integer.parseInt(e_date_arr[5]));
				
				long minute = (date2.getTimeInMillis() - date1.getTimeInMillis()) / 60000;

				String m_cnt = prod_his_list.get(i).getMember_cnt();
				if(m_cnt == null ) {
					m_cnt = "1";
				}
				minute = minute * Long.parseLong(m_cnt);
				
				p_total_minute = p_total_minute + minute;
			}
		}
		
		long real_total_time = total_minute - p_total_minute;
		
		return Long.toString(real_total_time);
	}*/
}
