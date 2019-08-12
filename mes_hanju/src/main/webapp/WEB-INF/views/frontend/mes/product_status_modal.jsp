<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--  modal area1 -->
<div class="modal fade" id="modal_itnbr_add" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">추가자재불출관리</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="box box-warning box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">추가자재불출요청</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_mcode_save"  class="btn btn-success btn-sm">요청</button>
						</div>
					</div>
					<form id="frm_mcode" name="frm_mcode" class="form-horizontal">
						<input type="hidden" id="m_cmd" name="cmd">
						<input type="hidden" id="m_code_use_yn" name="code_use_yn" />
						<div class="box-body">
							<div class="form-group">
								<label for="master_code" class="col-sm-3 control-label">MES지시번호</label>
								<div class="col-sm-9">
									<input type="input" id="m_master_code" name="master_code" class="form-control" placeholder="Code ID" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label for="code_nm" class="col-sm-3 control-label">코드명</label>
								<div class="col-sm-9">
									<input type="input" id="m_code_nm" name="code_nm" class="form-control" placeholder="Code Name" maxlength="20">
								</div>
	  						</div>
							<div class="form-group">
								<label for="code_nm_en" class="col-sm-3 control-label">코드명(영문)</label>
								<div class="col-sm-9">
									<input type="input" id="m_code_nm_en" name="code_nm_en" class="form-control" placeholder="Code Name(Eng)" maxlength="20">
								</div>
							</div>
							<div class="form-group">
								<label for="code_dscr" class="col-sm-3 control-label">코드설명</label>
								<div class="col-sm-9">
									<input type="input" id="m_code_dscr" name="code_dscr" class="form-control" placeholder="Code Description" maxlength="100">
								</div>
							</div>
							<div class="form-group">
								<label for="code_order" class="col-sm-3 control-label">코드출력순서</label>
								<div class="col-sm-9">
									<input type="number" id="m_code_order" name="code_order" class="form-control" placeholder="출력순서" maxlength="4" oninput="maxLengthCheck(this);" />
								</div>
							</div>
							<div class="form-group">
								<label for="rdo_mcode_use_yn" class="col-sm-3 control-label">코드사용여부</label>
								<div class="col-sm-9">
									<label><input type="radio" name="rdo_mcode_use_yn" class="flat-red" value="Y" checked> 사용</label>
									<label><input type="radio" name="rdo_mcode_use_yn" class="flat-red" value="N" > 미사용</label>
								</div>
							</div>
							<div class="form-group">
								<label for="filter1_val" class="col-sm-3 control-label">확장필드01</label>
								<div class="col-sm-9">
									<input type="input" id="m_filter1_val" name="filter1_val" class="form-control" placeholder="Expand Filed01" maxlength="20">
								</div>
							</div>
							<div class="form-group">
								<label for="filter2_val" class="col-sm-3 control-label">확장필드02</label>
								<div class="col-sm-9">
									<input type="input" id="m_filter2_val" name="filter2_val" class="form-control" placeholder="Expand Filed02" maxlength="20">
								</div>
							</div>
							<div class="form-group">
								<label for="filter3_val" class="col-sm-3 control-label">확장필드03</label>
								<div class="col-sm-9">
									<input type="input" id="m_filter3_val" name="filter3_val" class="form-control" placeholder="Expand Filed03" maxlength="20">
								</div>
							</div>
						</div>
					</form>
				</div><!-- end box -->
			</div><!-- end modal body -->
		</div><!-- end modal content -->
	</div><!-- end modal dialog -->
</div><!-- end modal area1 -->

<!-- modal area2 -->
<div class="modal fade" id="modal_main_serial_add" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">메인시리얼등록</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="box box-warning box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">시리얼등록</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_main_serial_save" class="btn btn-success btn-sm" onclick="fnSaveMainSerial();">
							등록</button>
						</div>
					</div>
					<form id="frm_main_serial" name="frm_main_serial" class="form-horizontal">
						<input type="hidden" id="m_cmd" name="cmd">
						<input type="hidden" id="m_code_use_yn" name="code_use_yn" />
						<div class="box-body">
							<div class="form-group">
								<label for="sap_po" class="col-sm-3 control-label">SAP지시번호</label>
								<div class="col-sm-9">
									<input type="input" id="m_sap_po" name="pordno" class="form-control input-sm"  maxlength="20" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label for="jidat" class="col-sm-3 control-label">지시일</label>
								<div class="col-sm-9">
									<input type="input" id="m_jidat" name="jidat" class="form-control input-sm"  maxlength="20" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label for="serial_no" class="col-sm-3 control-label">시리얼넘버</label>
								<div class="col-sm-9">
								<!-- 	<input type="input" id="m_serial_no" name="project_no" class="form-control input-sm" maxlength="100"> -->
									<input type="input"  id="m_serial_no" name="project_no" class="form-control input-sm"  maxlength="100"  
								onkeypress="if(event.keyCode==13) {Mainsernr_enter(this); return false;}">
								
								</div>
							</div>           
						</div>
					</form>
				</div><!-- end box -->
			</div><!-- end modal body -->
		</div><!-- end modal content -->
	</div><!-- end modal dialog -->
</div><!-- end modal area2 -->

<!-- modal area3 -->  
<div class="modal fade" id="modal_detail_serial_add" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">공정운영처리</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="box box-warning box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">시리얼등록</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_pord_fault" class="btn btn-danger btn-sm" onClick="pordFaultProc();">공정불량처리</button>							
							<button type="button" id="btn_fault_matnr_save" class="btn btn-success btn-sm" onclick="fnFaultMatnrConf();">불량처리</button>
							<button type="button" id="btn_detail_serial_save" class="btn btn-success btn-sm" onclick="fnSaveDetailSerial();">등록</button>
						</div>
					</div>
					<form id="frm_detail_serial" name="frm_detail_serial" class="form-horizontal">
					<div class="box-body">
						<div class="form-group">
							<label for="mes_po" class="col-sm-3 control-label">MES지시번호</label>
							<div class="col-sm-9">
								<input type="input" id="m_dsa_mes_po" name="pordno_pop" class="form-control"  maxlength="20" readonly="readonly">
								<input type="hidden" id="m_dept_cd" name="m_dept_cd" class="form-control">
							</div>
						</div>
						<div class="form-group">
							<label for="mes_po" class="col-sm-3 control-label">라우팅번호</label>
							<div class="col-sm-9">
								<input type="input" id="m_dsa_routing_no" name="m_dsa_routing_no" class="form-control"  maxlength="20" readonly="readonly">
								<input type="hidden" id="m_dsa_routing_gno" name="m_dsa_routing_gno" class="form-control"  maxlength="20" readonly="readonly">
							</div>
						</div>
						<div class="form-group">
							<label for="mes_po" class="col-sm-3 control-label">메인 시리얼</label>
							<div class="col-sm-9">
								<input type="input" id="m_dsa_project_no" name="project_no" class="form-control"  maxlength="20" readonly="readonly">
							</div>
						</div>
						<div class="form-group">
							<label for="mes_po" class="col-sm-3 control-label"></label>
						</div>
						<div class="row">
							<div class=" col-md-6">
								<div class="box" style="margin-bottom: 0px;">
									<div class="box-header with-border">
										<h3 class="box-title">자재 목록</h3>
										<div class="box-tools pull-right">
											<select id="gubun" class="input-sm" onChange="changeMatGubun();">
												<option value="basic">소요자재목록</option>
												<option value="mat">자재마스터목록</option>
											</select>
											<button type="button" id="matSearch" class="btn bg-teal btn-sm" onclick="$('#modal_mat_search').modal('show');" style="display:none;">
												<i class="fa fa-search" aria-hidden="true"></i>
											</button>&nbsp;
<!-- 											<div class="input-group input-group-sm mat" style="width: 150px;float: left;"> -->
<!-- 							                  <input type="text" id="itnbr_search_popup" name="itnbr_search" class="form-control pull-right" placeholder="자재내역"> -->
<!-- 												<div class="input-group-btn"> -->
<!-- 							                    <button type="button" id="btn_itnbr_search_popup" class="btn btn-default btn-sm" onclick="searchItnbrGrid();"><i class="fa fa-search"></i></button> -->
<!-- 							                  </div> -->
<!-- 							                </div> -->
<!-- 							                &nbsp;| -->
											<button type="button" id="btn_batch_proc" class="btn btn-danger btn-sm" onClick="addItnbrBatch();">일괄투입</button>
											<button type="button" id="" class="btn btn-warning btn-sm" onclick="addItnbrDetail();">
								               <i class="fa fa-forward" aria-hidden="true"></i></button>
										</div>
									</div>
									<div id="dv_grid_itnbrlist" class="box-body">
										<table id="grid_itnbrlist"></table>
<!-- 										<div id="grid_itnbrlist_pager"></div> -->
									</div>
									<div id="dv_grid_materiallist" class="box-body">
										<table id="grid_materiallist"></table>
										<div id="grid_materiallist_pager"></div>
									</div>
								</div>
							</div>
							<div class=" col-md-6">
								<div class="box" style="margin-bottom: 0px;">
									<div class="box-header with-border">
										<h3 class="box-title">공정 투입자재</h3>
										<div class="box-tools pull-right">
											<button type="button" id="" class="btn btn-warning btn-sm" onclick="deleteItnbrDetail();">
												<i class="fa fa-backward" aria-hidden="true"></i></button>
										</div>
									</div>
									<div id="dv_grid_addItnbr_list" class="box-body">
										<table id="grid_addItnbr_list"></table>
									</div>
								</div>
							</div>
						</div>
					</div><!-- end box body-->
					</form>
				</div><!-- end box -->
        	</div><!-- end modal body -->
		</div><!-- end modal content -->
	</div><!-- end modal -->
</div>
  
<div class="modal fade" id="modal_worker_add" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">작업시작</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="box box-warning box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">작업자정보</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_worker_add" class="btn btn-success btn-sm" onclick="fnWorkerAdd();">작업시작</button>
						</div>
					</div>
					<form id="frm_worker_add" name="frm_worker_add" class="form-horizontal">
					<div class="box-body">
						<div class="form-group">
							<label for="mes_po" class="col-sm-3 control-label">MES지시번호</label>
							<div class="col-sm-9">
								<input type="input" id="m_worker_mes_po" name="pordno_pop" class="form-control"  maxlength="20" readonly="readonly">
							</div>
						</div>
						<div class="form-group">
							<label for="mes_po" class="col-sm-3 control-label">라우팅번호</label>
							<div class="col-sm-9">
								<input type="input" id="m_routing_no" name="routing_no" class="form-control"  maxlength="20" readonly="readonly">
							</div>
						</div>
<!-- 						<div class="form-group"> -->
<!-- 							<label for="mes_po" class="col-sm-3 control-label">라인</label> -->
<!-- 								<div class="col-sm-9" id="dv_grid_worker" > -->
<!-- 									<label><input type="radio" name="rdo_work_line" class="flat-red" value="A" checked> A라인</label> -->
<!-- 									<label><input type="radio" name="rdo_work_line" class="flat-red" value="B" > B라인</label>							 -->
<!-- 								</div> -->
<!-- 						</div> -->
						<div class="form-group">
							<label for="login_user" class="col-sm-3 control-label">기본 작업자</label>
								<div class="col-sm-9" id="dv_login_user" >
									<input type="input" id="login_user" name="login_user" class="form-control"  maxlength="20" readonly="readonly">
								</div>
						</div>
						<div class="form-group">
							<label for="mes_po" class="col-sm-3 control-label">사원정보</label>
							<div class="col-sm-9 box-body" id="dv_grid_worker" >
								<table id="grid_worker"></table>							
							</div>
						</div>         
					</div>
					</form>
				</div><!-- end box -->
			</div><!-- end modal body -->
		</div><!-- end modal-content -->
	</div><!-- end modal dialog -->
</div><!-- end modal div -->
  
<!-- start modal fault mng-->
  <div class="modal fade" id="fault_mng" data-backdrop="static">
    <div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">자재불량관리</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
			<div class="box box-warning box-solid">
			<div class="box-header with-border">
						<h3 class="box-title">자재불량내역</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_fault_conf" class="btn btn-success btn-sm" onclick="fnFaultConf();">불량확정</button>
						</div>
					</div>
			<div class="modal-body" id="modal_code_body">
						<div class="box-body">				
			            <form id="frm_serial_add" name="frm_serial_add" class="form-horizontal">

						<i class="fa fa-check h_flag" aria-hidden="true"></i> <span class="h_flag">공정불량내역</span>
						<div class="row h_flag">
							<table id="grid_fault_routing_list"></table>
						</div>
						<br>
						<i class="fa fa-check" aria-hidden="true"></i> <span>자재불량내역</span>
						<div class="row">
							<table id="grid_fault_list"></table>
						</div>
						<div class="row">
							<div class="col-sm-2">
								<label for="m_type" class="col-sm-4 control-label">Type</label>
								<select id="sel_step1" class="form-control select2" onChange="changeStep($(this).val(),'step1');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-2">
								<label for="m_lv1" class="col-sm-2 control-label">Lv.01</label>
								<select id="sel_step2" class="form-control select2" onChange="changeStep($(this).val(),'step2');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-2">
								<label for="m_lv2" class="col-sm-2 control-label">Lv.02</label>
								<select id="sel_step3" class="form-control select2" onChange="changeStep($(this).val(),'step3');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-3">
								<label for="m_lv3" class="col-sm-2 control-label">Lv.03</label>
								<select id="sel_step4" class="form-control select2">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-3 text-center">
								<div class="row" style="padding-top: 28px;">
									<button type="button" id="" onclick="input_code_1();" class="btn btn-primary btn-sm h_flag">공정불량입력</button>
									<button type="button" id="" onclick="input_code_2();" class="btn btn-primary btn-sm">자재불량입력</button>
								</div>
							</div>
						</div>
						</form>
						</div>
	        </div>
	        </div>
	        </div>
		</div>
	</div>
</div>
<!-- end modal fault mng-->
<div class="modal fade" id="scanner_serial_add" data-backdrop="static">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">시리얼입력</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
	            <form id="frm_serial_add" name="frm_serial_add" class="form-horizontal">
					<div class="form-group input_1">
						<label for="" class="col-sm-3 control-label">시리얼</label>
						<div class="col-sm-9">
							<input type="input"  id="fsa_project_no" name="fsa_project_no" class="form-control"  maxlength="60" onkeyup="checkBarcode(this);" 
								onkeypress="if(event.keyCode==13) {sernr_enter(this); return false;}">
						</div>
	                </div>
	                <div class="form-group input_2" style="display:none;">
						<label for="" class="col-sm-3 control-label">창고</label>
						<div class="col-sm-9">
<!-- 							<input type="input"  id="fsa_loc" name="fsa_loc" class="form-control"  maxlength="20" > -->
							<select id="fsa_loc" class="form-control select2 fsa_loc">
							</select> 
						</div>
	                </div>
	                <div class="form-group input_3">
						<label for="" class="col-sm-3 control-label">수량</label>
						<div class="col-sm-9">
							 <input type="input"  id="fsa_bdmng" name="fsa_bdmng" class="form-control"  maxlength="20" >
						</div>
	                </div>
	                <div class="form-group">
	                	<ul>
	                		<li>시리얼 번호는 최소 7자리 이상 입력해야합니다.</li>
	                		<li>(Barcode Reading...)</li>
	                	</ul>
	                </div>
	            </form>
	        </div>
<!-- 	        <div class="modal-footer center-block" id="btnArea" style="display:none;"> -->
			<div class="modal-footer center-block" id="btnArea">
		        <button type="button" class="btn btn-sm btn-primary" onclick="sernrInputMng();">확인</button>
		        <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- material Search Condition -->
<div class="modal fade" id="modal_mat_search" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">자재목록 검색 조건</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="text-center" style="font-weight:bold; color:blue;">
					 모든 조건 검색은 Like 검색을  사용합니다. (검색 입력정보를 포함한 데이터 검색)
				</div>
				<form id="frm_search_condition" name="frm_search_condition" class="form-horizontal">
					<div class="form-group">
						<label for="m_matnr" class="col-sm-3 control-label">자재코드</label>
						<div class="col-sm-9">
							<input type="input" id="m_matnr" name="m_matnr" class="form-control input-sm"  maxlength="20">
						</div>
					</div>
					<div class="form-group">
						<label for="m_wrkst" class="col-sm-3 control-label">자재명</label>
						<div class="col-sm-9">
							<input type="input" id="m_wrkst" name="m_wrkst" class="form-control input-sm"  maxlength="20">
						</div>
					</div>
					<div class="form-group">
						<label for="m_maktx" class="col-sm-3 control-label">자재내역</label>
						<div class="col-sm-9">
							<input type="input" id="m_maktx" name="m_maktx" class="form-control input-sm"  maxlength="20">
						</div>
					</div>
				</form>
			</div><!-- end modal body -->
			<div class="modal-footer">
				<div class="text-center">
		        <button type="button" class="btn btn-sm btn-primary" onclick="materialSearch();">검색</button>
		        <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">닫기</button>
		        </div>
			</div>
		</div><!-- end modal-content -->
	</div><!-- end modal dialog -->
</div><!-- end modal div -->

<div class="modal fade" id="Pord_fault_mng" data-backdrop="static">
    <div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">공정불량관리</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
			<div class="box box-warning box-solid">
			<div class="box-header with-border">
						<h3 class="box-title">공정불량내역</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_prod_fault_conf" class="btn btn-success btn-sm" onclick="fnProdFaultConf();">불량확정</button>
						</div>
			</div>
			<div class="col-sm-12 text-right" style="font-weight:bold; color:red;">
							<i class="fa fa-check" aria-hidden="true"></i> <span id="warningTxt">1. 공정불량내역을 선택 2.불량항목 level선택 3. 입력 버튼 클릭  :::::::  순서로 불량내역을 등록해주세요.</span>
						</div>
			<div class="modal-body" id="modal_code_body">
						 
						<div class="box-body">				
			            <form id="frm_prod_fault" name="frm_prod_fault" class="form-horizontal">
						
						<div class="row">
						<table id="grid_prod_fault_list"></table>
						</div>
						<div class="row">
							<div class="col-sm-2">
								<label for="p_m_type" class="col-sm-4 control-label">Type</label>
								<select id="p_sel_step1" class="form-control select2" onChange="p_changeStep($(this).val(),'step1');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-3">
								<label for="p_m_lv1" class="col-sm-2 control-label">Lv.01</label>
								<select id="p_sel_step2" class="form-control select2" onChange="p_changeStep($(this).val(),'step2');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-3">
								<label for="p_m_lv2" class="col-sm-2 control-label">Lv.02</label>
								<select id="p_sel_step3" class="form-control select2" onChange="p_changeStep($(this).val(),'step3');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-3">
								<label for="p_m_lv3" class="col-sm-2 control-label">Lv.03</label>
								<select id="p_sel_step4" class="form-control select2">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-1">
								<label for="p_lv_c" class="col-sm-1 control-label"></label>
								<button type="button" id="" onclick="input_prod_fault_code();" class="btn btn-primary btn-sm" style="height: 55px;width: 55px;"">입력</button>
							</div>
						</div>
						</form>
						</div>
	        </div>
	        </div>
	        </div>
		</div>
	</div>
</div>

<!-- ************************등급창고 지정 : Start ************************-->
<div class="modal fade" id="grade_loc_add" data-backdrop="static">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">등급창고지정</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
	            <form id="frm_serial_add_1" name="frm_serial_add_1" class="form-horizontal">
					<div class="form-group">
						<label for="" class="col-sm-3 control-label">자재번호</label>
						<div class="col-sm-9">
							<input type="input" id="grade_loc_matnr" name="grade_loc_matnr" class="form-control"  readonly="readonly">
						</div>
					</div>
	                <div class="form-group input_2">
						<label for="" class="col-sm-3 control-label">창고</label>
						<div class="col-sm-9">
<!-- 							<input type="input"  id="fsa_loc" name="fsa_loc" class="form-control"  maxlength="20" > -->
							<select id="grade_loc" class="form-control select2">
							</select> 
						</div>
	                </div>
	            </form>
	        </div>
			<div class="modal-footer center-block">
		        <button type="button" class="btn btn-sm btn-primary" onclick="locInputMng();">확인</button>
		        <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- ************************등급창고 지정 : End ************************-->
<!-- ************************등급대상실적들 창고 입력 : Start ************************-->
  <div class="modal fade" id="grade_mng" data-backdrop="static">
    <div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">등급창고입력내역</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
			<div class="box box-warning box-solid">
			<div class="box-header with-border">
						<h3 class="box-title">등급창고입력</h3>
						<div class="box-tools pull-right" style="padding-top: 3px;">
									<button type="button" id="" onclick="work_end_proc();" class="btn btn-primary btn-sm">진행</button>
								</div>
					</div>
			<div class="modal-body" id="modal_code_body">
						<div class="box-body">				
			            <form id="frm_grid_grade_mng" name="frm_grid_grade_mng" class="form-horizontal">
						
						<div class="row">
						<table id=grid_grade_mng></table>
						</div>

						</form>
						</div>
	        </div>
	        </div>
	        </div>
		</div>
	</div>
</div>
<!-- ************************등급대상실적들 창고 입력 : End ************************-->

<!-- ************************등급창고 지정 : Start ************************-->
<div class="modal fade" id="grade_loc_add_1" data-backdrop="static">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">등급창고지정</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
	            <form id="frm_serial_add_1" name="frm_serial_add_1" class="form-horizontal">
					<div class="form-group">
						<label for="" class="col-sm-3 control-label">자재번호</label>
						<div class="col-sm-9">
							<input type="input" id="grade_loc_matnr_1" name="grade_loc_matnr_1" class="form-control"  readonly="readonly">
						</div>
					</div>
	                <div class="form-group input_2">
						<label for="" class="col-sm-3 control-label">창고</label>
						<div class="col-sm-9">
<!-- 							<input type="input"  id="fsa_loc" name="fsa_loc" class="form-control"  maxlength="20" > -->
							<select id="grade_loc_1" class="form-control select2">
							</select> 
						</div>
	                </div>
	            </form>
	        </div>
			<div class="modal-footer center-block">
		        <button type="button" class="btn btn-sm btn-primary" onclick="locInputMng_1();">확인</button>
		        <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- ************************등급창고 지정 : End ************************-->

<!-- modal area : general fault proc -->  
<div class="modal fade" id="modal_g_fault_proc" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">자재불량처리</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="box box-warning box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">자재내역</h3>
						<div class="box-tools pull-right">
							<button type="button" id="" class="btn btn-primary btn-sm" onclick="g_materialSearch();">조회</button>
						</div>
					</div>
					<form id="" name="" class="form-horizontal">
					<div class="box-body">		
						<div class="form-group">
							<label for="" class="col-sm-2 control-label">플랜트</label>
							<div class="col-sm-7">
								<select id="s_plant" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
									<option value="1110">의료</option>
									<option value="1210">광영상</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-sm-2 control-label">자재번호</label>
							<div class="col-sm-7">
								<input type="input" id="s_matnr" name="s_matnr" class="form-control input-sm" placeholder="">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-sm-2 control-label">자재내역</label>
							<div class="col-sm-7">
								<input type="input" id="s_maktx" name="s_maktx" class="form-control input-sm" placeholder="">
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-sm-2 control-label">Spec</label>
							<div class="col-sm-7">
								<input type="input" id="s_wrkst" name="s_wrkst" class="form-control input-sm" placeholder="">
							</div>
						</div>		
						<div class="row">
							<div class="col-md-12">
								<div class="box" style="margin-bottom: 0px;">
									<div class="box-header with-border">
										<h3 class="box-title">자재 목록</h3>
										<div class="box-tools pull-right">
	                                        <span style='float:left; margin: 5px;'>From창고 : </span>
											<div style='float:left;width:150px; margin-right:10px;'>
		                                        <select id="v_lgort" name="v_lgort" class="form-control select2 input-sm col-md-6">
		                                        </select>
	                                        </div>
											<button type="button" id="" class="btn btn-success btn-sm" onclick="fnFaultGnrMatnrConf();">불량처리</button>
										</div>
									</div>
									<div id="dv_grid_g_materiallist" class="box-body">
										<table id="grid_g_materiallist"></table>
										<div id="grid_g_materiallist_pager"></div>
									</div>
								</div>
							</div>
						</div>
					</div><!-- end box body-->
					</form>
				</div><!-- end box -->
        	</div><!-- end modal body -->
		</div><!-- end modal content -->
	</div><!-- end modal -->
</div>
