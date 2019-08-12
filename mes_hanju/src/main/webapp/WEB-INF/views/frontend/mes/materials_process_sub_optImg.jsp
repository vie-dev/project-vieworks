<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String routing_no = (String)request.getAttribute("routing_no");
String routing_gno = (String)request.getAttribute("routing_gno");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Vieworks MES | VMES</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
	<jsp:include page="/common/header_inc" flush="true">
		 <jsp:param name="page_title" value="0" />
	</jsp:include>
</head>

<body class="hold-transition skin-green-light sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1010" />
		<jsp:param name="selected_menu_cd" value="1067" />
	</jsp:include>

	<div class="content-wrapper">
		<section class="content-header">
			<h1>
				MES <small>공정진행처리(의료)</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> MES</a></li>
				<li class="active">공정진행처리(의료)</li>
			</ol>
			<div class="row">
				<div class="pull-right" style="padding-right: 15px;">
					<button type="button" class="btn btn-default btn-sm" aria-label="Left Align" onclick="location.href = '/frontend/location/mes/materials_process_medi';">
					  <i class="fa fa-reply" aria-hidden="true"></i> 이전화면
					</button>
				</div>
			</div>
		</section>
		<section class="content" style="padding-bottom: 0px;">
			<div class="row">
				<div class="col-md-3">
					<div class="box" style="margin-bottom: 0px;">
						<div class="box-header with-border">
							<h3 class="box-title">작업 목록</h3>
							<div class="box-tools pull-right" style="padding-top: 3px;">
								<button type="button" class="btn btn-xs" style="background-color:hotpink;" aria-label="Left Align" onclick="searchGridReady();">
									<i class="fa fa-refresh" aria-hidden="true"></i>
								</button>
							</div>
						</div>
						<div id="dv_grid_ready" class="box-body">
							<table id="grid_ready"></table>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="row">
						<div class="box box-primary">
							<div class="box-header">
								<h3 class="box-title">선택 공정 정보</h3>
							</div>
							<div class="box-body">
								<form id="info" name="info" class="form-horizontal">
								<div class="form-group">
									<label for="itnbr_nm" class="col-sm-3 control-label">제품명</label>
									<div class="col-sm-9">
										<div id="itnbr_nm" name="itnbr_nm" style="margin-top:7px;">-</div>
									</div>
								</div>
								<div class="form-group">
									<label for="itnbr" class="col-sm-3 control-label">제품코드</label>
									<div class="col-sm-9">
										<div id="itnbr" name="itnbr" style="margin-top:7px;">-</div>
									</div>
		  						</div>
								<div class="form-group">
									<label for="routing" class="col-sm-3 control-label">공정 </label>
									<div class="col-sm-9">
										<div id="routing" name="routing" style="margin-top:7px;">-</div>
									</div>
		  						</div>
								<div class="form-group">
									<label for="routing" class="col-sm-3 control-label">대표시리얼 </label>
									<div class="col-sm-9">
										<div id="project_no" name="project_no" style="margin-top:7px;">-</div>
									</div>
		  						</div>
		  						</form>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="box box-success">
							<div class="box-header">
								<h3 class="box-title">작업 선택 및 이력 확인</h3>
								<div class="box-tools pull-right" style="padding-top: 3px;">
								<button type="button" class="btn btn-success btn-xs" aria-label="Left Align" onclick="searchGridHis();">
									<i class="fa fa-refresh" aria-hidden="true"></i>
								</button>
							</div>
							</div>
							<div class="box-body">
								<div class="row" style="margin-bottom: 10px;">
	  								<div class="col-sm-6"><button type="button" class="btn btn-block bg-black" onclick="bigSerialInsert();">
	  									대표시리얼 등록</button></div>
<!-- 	  								<div class="col-sm-6"><button type="button" class="btn btn-block bg-navy" onclick="smallSerialInsert();"> -->
<!-- 	  									시리얼등록</button></div> -->
	  								<div class="col-sm-6"><button type="button" class="btn btn-block bg-navy" onclick="popUpDetailSerial();">
	  									공정운영처리</button></div>
								</div>
								<div class="row" style="margin-bottom: 10px;">
<!-- 									<div class="col-sm-6"><button type="button" class="btn btn-block btn-primary" onclick="chnStatus('p3');"> -->
									<div class="col-sm-6">
										<button type="button" class="btn btn-block btn-primary" id="btn_p3" onclick="fnClickWorkStart();">
										작업시작</button></div>
									<div class="col-sm-6">
										<button type="button" class="btn btn-block btn-danger"  id="btn_p6" onclick="chnStatus('p6');">
										작업종료</button></div>
								</div>
								<div class="row" style="margin-bottom: 10px;">
									<div class="col-sm-6">
										<button type="button" class="btn btn-block bg-teal"  id="btn_p4" onclick="chnStatus('p4');">
										비가동시작</button></div>
									<div class="col-sm-6">
										<button type="button" class="btn btn-block bg-maroon"  id="btn_p5" onclick="chnStatus('p5');">
										비가동종료</button></div>
								</div>
								<div id="dv_grid_his" class="box-body" style="padding: 10px 0px 10px 0px;">
									<table id="grid_his"></table>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="box" style="margin-bottom: 0px;">
						<div class="box-header with-border">
							<h3 class="box-title">작업 완료 목록</h3>
							<div class="box-tools pull-right" style="padding-top: 3px;">
								<button type="button" class="btn btn-success btn-xs" aria-label="Left Align" onclick="searchGridComp();">
									<i class="fa fa-refresh" aria-hidden="true"></i>
								</button>
							</div>
						</div>
						<div id="dv_grid_comp" class="box-body">
							<table id="grid_comp"></table>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	
	<jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
	
	<jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>

<!-- modal area start -->
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
						<div class="form-group">
							<label for="mes_po" class="col-sm-3 control-label">라인</label>
<!-- 								<div class="col-sm-9" id="dv_grid_worker" > -->
								<div>
									<label><input type="radio" name="rdo_work_line" class="flat-red" value="A" checked> A라인</label>
									<label><input type="radio" name="rdo_work_line" class="flat-red" value="B" > B라인</label>							
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
<!-- main serial insert -->
<div class="modal fade" id="modal_main_serial_add" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">메인시리얼등록관리</h4>
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
									<input type="input" id="m_sap_po" name="pordno" class="form-control"  maxlength="20" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label for="jidat" class="col-sm-3 control-label">지시일</label>
								<div class="col-sm-9">
									<input type="input" id="m_jidat" name="jidat" class="form-control"  maxlength="20" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label for="serial_no" class="col-sm-3 control-label">시리얼넘버</label>
								<div class="col-sm-9">
									<input type="input" id="m_serial_no" name="project_no" class="form-control" maxlength="100">
								</div>
							</div>           
						</div>
					</form>
				</div><!-- end box -->
			</div><!-- end modal body -->
		</div><!-- end modal content -->
	</div><!-- end modal dialog -->
</div><!-- end modal area2 -->

<!-- detail serial insert -->  
<!-- <div class="modal fade" id="modal_detail_serial_add" data-backdrop="static"> -->
<!-- 	<div class="modal-dialog modal-lg"> -->
<!-- 		<div class="modal-content"> -->
<!-- 			<div class="modal-header"> -->
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
<!-- 				<h4 class="modal-title" id="modal_code_title">공정별시리얼등록관리</h4> -->
<!-- 			</div> -->
<!-- 			<div class="modal-body" id="modal_code_body"> -->
<!-- 				<div class="box box-warning box-solid"> -->
<!-- 					<div class="box-header with-border"> -->
<!-- 						<h3 class="box-title">시리얼등록</h3> -->
<!-- 						<div class="box-tools pull-right"> -->
<!-- 							<button type="button" id="btn_detail_serial_save" class="btn btn-success btn-sm" onclick="fnSaveDetailSerial();"> -->
<!-- 							등록</button> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<form id="frm_detail_serial" name="frm_detail_serial" class="form-horizontal"> -->
<!-- 					<div class="box-body"> -->
<!-- 						<div class="form-group"> -->
<!-- 							<label for="mes_po" class="col-sm-3 control-label">MES지시번호</label> -->
<!-- 							<div class="col-sm-9"> -->
<!-- 								<input type="input" id="m_dsa_mes_po" name="pordno_pop" class="form-control"  maxlength="20" readonly="readonly"> -->
<!-- 								<input type="hidden" id="m_dept_cd" name="m_dept_cd" class="form-control"> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="form-group"> -->
<!-- 							<label for="mes_po" class="col-sm-3 control-label">라우팅번호</label> -->
<!-- 							<div class="col-sm-9"> -->
<!-- 								<input type="input" id="m_dsa_routing_no" name="m_dsa_routing_no" class="form-control"  maxlength="20" readonly="readonly"> -->
<!-- 								<input type="hidden" id="m_dsa_routing_gno" name="m_dsa_routing_gno" class="form-control"  maxlength="20" readonly="readonly"> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="form-group"> -->
<!-- 							<label for="mes_po" class="col-sm-3 control-label">메인 시리얼</label> -->
<!-- 							<div class="col-sm-9"> -->
<!-- 								<input type="input" id="m_dsa_project_no" name="project_no" class="form-control"  maxlength="20" readonly="readonly"> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="form-group"> -->
<!-- 							<label for="mes_po" class="col-sm-3 control-label"></label> -->
<!-- 						</div> -->
<!-- 						<div class="row"> -->
<!-- 							<div class=" col-md-6"> -->
<!-- 								<div class="box" style="margin-bottom: 0px;"> -->
<!-- 									<div class="box-header with-border"> -->
<!-- 										<h3 class="box-title">자재 목록</h3> -->
<!-- 										<div class="box-tools pull-right"> -->
<!-- 											<select id="gubun" class="input-sm" onChange="changeMatGubun();"> -->
<!-- 												<option value="basic">소요자재목록</option> -->
<!-- 												<option value="mat">자재마스터목록</option> -->
<!-- 											</select> -->
<!-- 											<button type="button" id="matSearch" class="btn bg-teal btn-sm" onclick="$('#modal_mat_search').modal('show');" style="display:none;"> -->
<!-- 												<i class="fa fa-search" aria-hidden="true"></i> -->
<!-- 											</button>&nbsp; -->
<!-- 											<button type="button" id="" class="btn btn-warning btn-sm" onclick="addItnbrDetail();"> -->
<!-- 								               <i class="fa fa-forward" aria-hidden="true"></i></button> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div id="dv_grid_itnbrlist" class="box-body"> -->
<!-- 										<table id="grid_itnbrlist"></table> -->
<!-- <!-- 										<div id="grid_itnbrlist_pager"></div> --> -->
<!-- 									</div> -->
<!-- 									<div id="dv_grid_materiallist" class="box-body"> -->
<!-- 										<table id="grid_materiallist"></table> -->
<!-- 										<div id="grid_materiallist_pager"></div> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 							<div class=" col-md-6"> -->
<!-- 								<div class="box" style="margin-bottom: 0px;"> -->
<!-- 									<div class="box-header with-border"> -->
<!-- 										<h3 class="box-title">공정 투입자재</h3> -->
<!-- 										<div class="box-tools pull-right"> -->
<!-- 											<button type="button" id="" class="btn btn-warning btn-sm" onclick="deleteItnbrDetail();"> -->
<!-- 												<i class="fa fa-backward" aria-hidden="true"></i></button> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div id="dv_grid_addItnbr_list" class="box-body"> -->
<!-- 										<table id="grid_addItnbr_list"></table> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div>end box body -->
<!-- 					</form> -->
<!-- 				</div>end box -->
<!--         	</div>end modal body -->
<!-- 		</div>end modal content -->
<!-- 	</div>end modal -->
<!-- </div> -->
<!-- ************************자재출고 등록관리 : Start ************************-->
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
							<div class="box-tools pull-center">
							<button type="button" id="btn_pord_fault" class="btn btn-danger btn-sm" onClick="pordFaultProc();">공정불량처리</button>							
						 	</div>
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

<!-- ************************자재출고 등록관리 : End ************************-->

<!-- ************************자재 시리얼 등록 : Start ************************-->
<!-- end modal fault mng-->
<div class="modal fade" id="scanner_serial_add" data-backdrop="static">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">시리얼입력관리</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
	            <form id="frm_serial_add" name="frm_serial_add" class="form-horizontal">
					<div class="form-group">
						<label for="" class="col-sm-3 control-label">시리얼</label>
						<div class="col-sm-9">
							<input type="input"  id="fsa_project_no" name="fsa_project_no" class="form-control"  maxlength="20" onkeyup="checkBarcode(this);" 
								onkeypress="if(event.keyCode==13) {sernr_enter(this); return false;}">
						</div>
	                </div>
	                <div class="form-group">
	                	<ul>
	                		<li>9자리 이상 입력하면 저장버튼이 보입니다.</li>
	                		<li>(Barcode Reading...)</li>
	                	</ul>
	                </div>
	            </form>
	        </div>
	        <div class="modal-footer center-block" id="btnArea" style="display:none;">
		        <button type="button" class="btn btn-sm btn-primary" onclick="sernrInputMng();">확인</button>
		        <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- ************************자재 시리얼 등록 : End ************************-->

<!-- ************************불량처리 : Start ************************-->
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
					<div class="col-sm-12 text-right" style="font-weight:bold; color:red;">
							<i class="fa fa-check" aria-hidden="true"></i> <span id="warningTxt">1. 자재불량내역을 선택 2.불량항목 level선택 3. 입력 버튼 클릭  :::::::  순서로 불량내역을 등록해주세요.</span>
						</div>
			<div class="modal-body" id="modal_code_body">
						<div class="box-body">				
			            <form id="frm_serial_add" name="frm_serial_add" class="form-horizontal">
						
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
							<div class="col-sm-3">
								<label for="m_lv1" class="col-sm-2 control-label">Lv.01</label>
								<select id="sel_step2" class="form-control select2" onChange="changeStep($(this).val(),'step2');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-3">
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
							<div class="col-sm-1">
								<label for="lv_c" class="col-sm-1 control-label"></label>
								<button type="button" id="" onclick="input_code();" class="btn btn-primary btn-sm" style="height: 55px;width: 55px;"">입력</button>
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
<!-- ************************불량처리 : End ************************-->

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
<!-- modal area end -->

<!-- ************************공정불량처리 : Start ************************-->
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
<!-- ************************공정불량처리 : End ************************-->
<script type="text/javascript">
var addItnbrArr = [];
var itnbrArr = [];
var matArr = [];

var routing_gno = '<%=routing_gno%>';
var routing_no = '<%=routing_no%>';
var selected_pordno_pop;
var selected_routing_no;
// var selected_routing_no;
var gridReadySelect_idx = '';
var dept_cd = '1210';
var searchMatCode = '';
var readyKey = '';
var addMatObj = {};
$(function($) {
	initComponent();
})

function initComponent() {
// 	console.info('initComponent()');
	
	$(window).bind('resize', function() {
		resizeJqGrid("grid_ready", false);
		resizeJqGrid("grid_comp", false);
		resizeJqGrid("grid_his", false);
	}).trigger('resize');
	
	$('input[type="radio"].flat-red').iCheck({
		checkboxClass : 'icheckbox_flat-green',
		radioClass : 'iradio_flat-green',
		handle : 'radio'
	});
	
	gridReadyGen();
	gridCompGen();
	gridHisGen();
	fnLoadWorkerAddGrid();
	initItnbrGrid();
	initNewItnbrGrid();
	fnLoadFaultListGrid();
	initMaterialGrid();
	fnLoadProdFaultListGrid();

}

function getFormatDate(d) {
	var month = d.getMonth();
	if( month==12 ) month = 0;
	else month += 1; 
	var date = d.getDate();
	month = (month < 10) ? "0" + month : month;
	date = (date < 10) ? "0" + date : date;
	return d.getFullYear() + '-' + month + '-' + date;
}

// 작업 대기열 목록 조회
function gridReadyGen() {
	console.info('gridReadyGen()');
// 	var tmpDay = new Date();
// 	var toDay = getFormatDate(tmpDay);
// 	console.log('today --> ' + toDay);
	var page_url = "/frontend/mes/selectProdOrdUserIng"
		 		 + "?dept_cd=" + encodeURIComponent(dept_cd)
// 		 		 + "&cmdat=" + encodeURIComponent(toDay)
		 		 + "&routing_gno=" + encodeURIComponent(routing_gno);
// 	console.log(page_url);
	
	$("#grid_ready").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['UNIQKEY', 'PORDNO', 'PORDNO_POP', 'PORDNO_SEQ', 'CUSTOMER_NM', 'ITNBR', '제품명', '공정그룹명', 
		          '공정코드', 'routing_code', '공정명', 'PDSTS', '진행상태', 'JIDAT', 'project_no', 'auart', 'lgort', 'pdqty', 'wkctr'],
		colModel:[
			{name : 'uniqkey', index : 'uniqkey', sorttype:'text', sortable:true, hidden:false, key:true},
			{name : 'pordno', index : 'pordno', sorttype:'text', sortable:true, hidden:true},
			{name : 'pordno_pop', index : 'pordno_pop', sorttype:'text', sortable:true, hidden:true},
			{name : 'pordno_seq', index : 'pordno_seq', sorttype:'text', sortable:true, hidden:true},
			{name : 'customer_nm', index : 'customer_nm', sorttype:'text', sortable:true, hidden:true},
			{name : 'itnbr', index : 'itnbr', sorttype:'text', sortable:true, hidden:true},
			{name : 'itnbr_nm', index : 'itnbr_nm', sorttype:'text', sortable:true, hidden:true},
			{name : 'routing_nm', index : 'routing_nm', sorttype:'text', sortable:true},
			{name : 'routing_no', index : 'routing_no', sorttype:'text', sortable:true},
			{name : 'routing_code', index : 'routing_code', sorttype:'text', sortable:true, hidden:false},
			{name : 'routing_dscr', index : 'routing_dscr', sorttype:'text', sortable:true},
			{name : 'pdsts', index : 'pdsts', sorttype:'text', sortable:true, hidden:true},
			{name : 'pdsts_nm', index : 'pdsts_nm', sorttype:'text', sortable:true},
			{name : 'jidat', index : 'jidat', sorttype:'text', hidden:true},
			{name : 'project_no', index : 'project_no', sorttype:'text', hidden:true},
			{name : 'auart', index : 'auart', sorttype:'text', hidden:true},
			{name : 'lgort', index : 'lgort', sorttype:'text', hidden:true}, 
			{name : 'pdqty', index : 'pdqty', sorttype:'text', hidden:true},
			{name : 'wkctr', index : 'wkctr', sorttype:'text', hidden:true}
			],
		rowNum:1000,
	    height: 640,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: false,
	    sortable: true,
	    sortname: 'pordno',
	   	grouping:true,
	   	groupingView : {
	   		groupField : ['pordno'],
	   		groupColumnShow : [false],
	   		groupText : ['<b>{0} - ( {1} 단계 )</b>'],
	   		groupCollapse : false,
	   		groupOrder: ['asc']
	   	},
	    loadComplete : function(data){
	    	console.log(data);
	    	var rowsHtml = $(this).children().children();
	    	if( rowsHtml.length>0 ){
	    		$.each( rowsHtml, function(idx, row){
	    			if( $(row).children().length > 1 ){
	    				if($(($(row).children())[8]).text() == routing_no ) {
	    					$(row).css('color', 'red');
	    				} 
	    			}
	    		});
	    	}
	    },
		onSelectRow: function(key) {
			if(key != null) {
				var rowData = $("#grid_ready").jqGrid('getRowData', key);
				selected_pordno_pop = rowData.pordno_pop;
				selected_routing_no = rowData.routing_no;
				gridReadySelect_idx = $("#grid_ready").jqGrid('getInd', key);
				var selData = $("#grid_ready").getRowData(key);
				
				var beforeIdx = (gridReadySelect_idx>1)?(gridReadySelect_idx-1):gridReadySelect_idx;
				var chidrenLength = $('#grid_ready tr:eq('+beforeIdx+')').children().length;
				var beforeStat = "종료";
				if(	chidrenLength==1 ){	// 해당 PO의 첫번째 공정. 해더가 (td) 1개
				} else {
					beforeStat = $($('#grid_ready tr:eq('+beforeIdx+')').children()[12])[0].innerText;
				}
				if ( beforeStat=="종료" && chidrenLength==1 ) {	//진행
					searchGridHis();
				} else {	// blocked
					$("#btn_p3").attr('disabled', 'disabled');
					$("#btn_p4").attr('disabled', 'disabled');
					$("#btn_p5").attr('disabled', 'disabled');
					$("#btn_p6").attr('disabled', 'disabled');
					fnMessageModalAlert("확인하세요.", "이전 단계가 작업종료 상태가 아니므로 어떠한 작업도 시작 할 수 없습니다.");
				}
				
				if(selData.routing_code == 'T1') {
					$("#btn_p3").attr('disabled', 'disabled');
					$("#btn_p4").attr('disabled', 'disabled');
					$("#btn_p5").attr('disabled', 'disabled');
					$("#btn_p6").attr('disabled', 'disabled');
					fnMessageModalAlert("확인하세요.", "T1 공정은 최종검사화면에서 처리해야합니다.");
				}
				
// 				searchGridHis();
				var selData = $("#grid_ready").getRowData(key);
				$("#itnbr_nm").html(selData.itnbr_nm);
				$("#itnbr").html(selData.itnbr);
				// routing info
				var infoStr = selData.routing_nm + '(' + routing_gno + ')'
							+ ' / ' + selData.routing_code + '(' + selData.routing_no + ')';
				$("#routing").html(infoStr);
				$("#project_no").html(selData.project_no);
				// 시작버튼 정보  popup 
				$('#m_worker_mes_po').val(selData.pordno_pop);
				$('#m_routing_no').val(routing_no);
				
				if( selData.auart=='ZP01' || selData.auart=='ZP05' )
					searchMatCode = 'basic';
				else	// ZP02, ZP03, ZP04
					searchMatCode = 'mat';
				
				readyKey = key;
			}					
		}
	});
	// hide header
// 	$('.ui-jqgrid-hdiv').hide();
}

//공정 그룹 목록 조회
function searchGridReady() {
	console.log('searchGridReady()');
	
	var page_url = "/frontend/mes/selectProdOrdUserIng"
		 		 + "?dept_cd=" + encodeURIComponent(dept_cd)
		 		 + "&routing_gno=" + encodeURIComponent(routing_gno);
	
	$("#grid_ready").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_ready").trigger("reloadGrid");
	   
	var idsArr = $("#grid_ready").jqGrid("getDataIDs");
	var gCnt = 1;
	$.each(idsArr, function(i, ids){
		var chidrenLength = $('#grid_ready tr:eq(' + i +')').children().length;
		if( chidrenLength==1 ) {
			gCnt++;
		} else {
			if( ids==readyKey ){
				$("#grid_ready").jqGrid("setSelection",ids[gridReadySelect_idx - gCnt]);
			} else {
				return false;
			}
		}
	});
	
	$("#grid_popord").jqGrid('clearGridData');
	$("#grid_hisord").jqGrid('clearGridData');
}

//공정 상세 목록 생성
function gridCompGen() {
	console.log('gridCompGen()');
	
// 	var tmpDay = new Date();
// 	var toDay = getFormatDate(tmpDay);
	var page_url = "/frontend/mes/selectProdOrdUserIng"
				 + "?dept_cd=" + encodeURIComponent(dept_cd)
// 				 + "&cmdat=" + encodeURIComponent(toDay)
				 + "&routing_gno=" + encodeURIComponent(routing_gno)
				 + "&routing_no=" + encodeURIComponent(routing_no)
				 + "&pdsts=p6";
// 	console.log(page_url);
	$("#grid_comp").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['UNIQKEY', 'PORDNO', 'PORDNO_POP', 'PORDNO_SEQ', 'CUSTOMER_NM', 'ITNBR', '제품명', '공정그룹명', 
		          '공정코드', 'routing_code', '공정명', 'PDSTS', '진행상태', 'JIDAT', 'project_no', 'auart', 'lgort'],
		colModel:[
			{name : 'uniqkey', index : 'uniqkey', sorttype:'text', sortable:true, hidden:true, key:true},
			{name : 'pordno', index : 'pordno', sorttype:'text', sortable:true, hidden:true},
			{name : 'pordno_pop', index : 'pordno_pop', sorttype:'text', sortable:true, hidden:true},
			{name : 'pordno_seq', index : 'pordno_seq', sorttype:'text', sortable:true, hidden:true},
			{name : 'customer_nm', index : 'customer_nm', sorttype:'text', sortable:true, hidden:true},
			{name : 'itnbr', index : 'itnbr', sorttype:'text', sortable:true, hidden:true},
			{name : 'itnbr_nm', index : 'itnbr_nm', sorttype:'text', sortable:true, hidden:true},
			{name : 'routing_nm', index : 'routing_nm', sorttype:'text', sortable:true},
			{name : 'routing_no', index : 'routing_no', sorttype:'text', sortable:true},
			{name : 'routing_code', index : 'routing_code', sorttype:'text', sortable:true, hidden:false},
			{name : 'routing_dscr', index : 'routing_dscr', sorttype:'text', sortable:true},
			{name : 'pdsts', index : 'pdsts', sorttype:'text', sortable:true, hidden:true},
			{name : 'pdsts_nm', index : 'pdsts_nm', sorttype:'text', sortable:true},
			{name : 'jidat', index : 'jidat', sorttype:'text', hidden:true},
			{name : 'project_no', index : 'project_no', sorttype:'text', hidden:true},
			{name : 'auart', index : 'auart', sorttype:'text', hidden:true},
			{name : 'lgort', index : 'lgort', sorttype:'text', hidden:true} ],
// 		colNames:['PORDNO_POP', 'PORDNO_SEQ', 'CUSTOMER_NM', '제품코드', '제품명', '공정명','', 'PDSTS', '진행상태'],
// 		colModel:[
// 			{name : 'pordno_pop', index : 'pordno_pop', sorttype:'text', sortable:true, hidden:true},
// 			{name : 'pordno_seq', index : 'pordno_seq', sorttype:'text', sortable:true, hidden:true},
// 			{name : 'customer_nm', index : 'customer_nm', sorttype:'text', sortable:true, hidden:true},
// 			{name : 'itnbr', index : 'itnbr', sorttype:'text', sortable:true, hidden:false},
// 			{name : 'itnbr_nm', index : 'itnbr_nm', sorttype:'text', sortable:true, hidden:false},
// 			{name : 'routing_dscr', index : 'routing_dscr', sorttype:'text', sortable:true, hidden:true},
// 			{name : 'routing_no', index : 'routing_no', sorttype:'text', sortable:true, hidden:true, key:true},
// 			{name : 'pdsts', index : 'pdsts', sorttype:'text', sortable:true, hidden:true},
// 			{name : 'pdsts_nm', index : 'pdsts_nm', sorttype:'text', sortable:true, hidden:true}
// 		],
		rowNum:1000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    height: 640,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: false,
	    sortable: true,
	    sortname: "routing_no, itnbr",
	    grouping:true,
	   	groupingView : {
	   		groupField : ['pordno'],
	   		groupColumnShow : [false],
	   		groupText : [''],
	   		groupCollapse : false,
	   		groupOrder: ['asc']
	   	},
		loadComplete : function(data) { 
// 			console.log(data);
		},
		onSelectRow: function(ids){
		    if (ids != null) {
// 		    	console.log(ids);
		    }
		}
	});
	// hide header
// 	$('.ui-jqgrid-hdiv').hide();
}

// 공정 완료 목록 조회
function searchGridComp() {
	console.log('searchGridComp()');
	
	var tmpDay = new Date();
// 	var toDay = getFormatDate(new Date(tmpDay.setDate(tmpDay.getDate() + 30)));
	var toDay = getFormatDate(tmpDay);
	var page_url = "/frontend/mes/selectProdOrdUserIng"
				 + "?dept_cd=" + encodeURIComponent(dept_cd)
// 				 + "&cmdat=" + encodeURIComponent(toDay)
				 + "&routing_gno=" + encodeURIComponent(routing_gno)
				 + "&routing_no=" + encodeURIComponent(routing_no)
				 + "&pdsts=p6";
// 	console.log(page_url);
	$("#grid_comp").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_comp").trigger("reloadGrid");
}

//공정 이력목록
function gridHisGen() {
// 	console.log('gridHisGen()');
	
// 	var pordno_pop;
// 	var page_url = "/frontend/prod/pop_prod_his_select"
// 				 + "?pordno_pop=" + encodeURIComponent(pordno_pop);

	$("#grid_his").jqGrid({
// 		url : page_url,
		datatype : "json",
		colNames : [ '공정순서', 'MES지시번호', '공정코드', '공정명', '작업시작',
					'비가동시작', '비가동종료', '작업종료', 'pordno_seq' ],
		colModel : [
			{name : 'routing_no', index : 'routing_no', width : 30, sorttype : "text", sortable : true}, 
			{name : 'pordno_pop', index : 'pordno_pop', width : 40, sorttype : "text", sortable : true}, 
			{name : 'routing_code', index : 'routing_code', width : 30, sorttype : "text", sortable : true}, 
			{name : 'routing_nm', index : 'routing_nm', width : 50, sorttype : "text", sortable : true}, 
			{name : 'start_dt_tm', index : 'start_dt_tm', width : 50, sorttype : "text", sortable : true}, 
			{name : 'pause_start_dt_tm', index : 'pause_start_dt_tm', width : 50, sorttype : "text", sortable : true}, 
			{name : 'pause_end_dt_tm', index : 'pause_end_dt_tm', width : 50, sorttype : "text", sortable : true}, 
			{name : 'end_dt_tm', index : 'end_dt_tm', width : 50, sorttype : "text", sortable : true}, 
			{name : 'pordno_seq', index : 'pordno_seq', width : 50, sorttype : "text", sortable : true, hidden : true, key : true} ],
		rowNum : 1000,
		viewrecords : true,
		autowidth : true,
		shrinkToFit : true,
		multiselect : true,
		height : 235,
		altRows : true,
		rownumbers : true,
		rownumWidth : 25,
		autoencode : true,
		loadonce : true,
		sortable : true,
		onSelectRow : function(rowid, selected) {
			if (rowid != null) {}
		},
		loadComplete : function() {
			workStatusChk();
		}
	});
}

// 공정 완료 목록 조회
function searchGridHis() {
// 	console.log('searchGridHis()');
	
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selectedData = $("#grid_ready").getRowData(selKey);
	
	var page_url = "/frontend/prod/pop_prod_his_select"
		 + "?pordno_pop=" + encodeURIComponent(selectedData.pordno_pop)
		 + "&routing_no=" + encodeURIComponent(selectedData.routing_no);

	$("#grid_his").jqGrid('setGridParam', { url : page_url, datatype : 'json' });
	$("#grid_his").trigger("reloadGrid");
}

// 대표 시리얼 등록
function bigSerialInsert() {
	console.info('bigSerialInsert()');
	
	var rowData = $("#grid_ready").getRowData(readyKey);
	if ( readyKey == '' ) {
		fnMessageModalAlert("확인하세요.", "선택된 생산지시오더 없습니다.");
		return;
	}
	
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selectedData = $("#grid_ready").getRowData(selKey);
// 	console.log(selectedData);
	if (selectedData == {}) {
		fnMessageModalAlert("Notification(ProdConfirm)", "등록하고자 하는 선택된 작업이 없습니다.");
		return;
	}
	$("#m_sap_po").val(selectedData.pordno);
	$("#m_jidat").val(selectedData.jidat);
	$("#m_serial_no").val('');
	if( selectedData.project_no!='' ){
		$("#m_serial_no").val(selectedData.project_no);
	}
	$("#modal_main_serial_add").modal('show');
}

function fnSaveMainSerial() {
	console.info('fnSaveMainSerial()');
	var postData = $("#frm_main_serial").serializeArray();
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selData = $("#grid_ready").jqGrid('getRowData', selKey);
	var selDataArr = [];
	selDataArr.push(selData);
	selData.project_no = $("#m_serial_no").val();
	var page_url = "/frontend/prod/main_serial_add";
	
	var postData = "pordno=" +  encodeURIComponent(selData.pordno)
				 + "&project_no=" +  encodeURIComponent($("#m_serial_no").val())
				 + "&fedat=" +  encodeURIComponent(selData.fedat)
				 + "&sedat=" +  encodeURIComponent(selData.sedat)
				 + "&params=" +  encodeURIComponent(JSON.stringify(selDataArr));
	
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200" && data.result=="S") {
				fnMessageModalAlert("Notification(SerialAdd)", "선택된 생산지시오더 시리얼등록을 성공했습니다.");
			} else {
				fnMessageModalAlert("Notification(SerialAdd)", "선택된 생산지시오더 시리얼등록을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(SerialAdd)", "선택된 생산지시오더 시리얼등록 중 오류가 발생하였습니다.");
		},
		complete : function() {

			searchGridReady();
			
			setTimeout(function() {
				$("#grid_ready").jqGrid("setSelection", selKey);
			}, 100);
			
			
			$("#modal_main_serial_add").modal('hide');
		}
	});
	
}

//공정투입자재 grid generate
 function reloadNewItnbrGrid() {
 	console.info('reloadNewItnbrGrid()');
	
 	$("#grid_addItnbr_list").jqGrid('clearGridData');

 	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
 	var selectedData = $("#grid_ready").getRowData(selKey);
	
 	var page_url = "/frontend/prod/selectSernrManageTbl"
 				 + "?pordno_pop=" + encodeURIComponent(selectedData.pordno_pop)
 				 + "&routing_no=" + encodeURIComponent(selectedData.routing_no);
 	$("#grid_addItnbr_list").jqGrid('setGridParam', { url : page_url, datatype : 'json' });
 	$("#grid_addItnbr_list").trigger("reloadGrid");
 }

//공정투입자재 grid generate
function initNewItnbrGrid() {
  	console.log('initNewItnbrGrid()');
	$("#grid_addItnbr_list").jqGrid('clearGridData');
	$("#grid_addItnbr_list").trigger("reloadGrid");
	var selGridRowData = $("#grid_ready").getRowData($('#grid_ready').jqGrid('getGridParam','selrow'));
// 	var page_url = "/frontend/prod/selectSernrManageTbl"
// 			 	 + "?pordno_pop=" + encodeURIComponent(selGridRowData.pordno_pop)
// 				 + "&routing_no=" + encodeURIComponent(selGridRowData.routing_no);
	$("#grid_addItnbr_list").jqGrid({
// 		url:page_url,
		datatype: 'json',
		colNames:['','자재','소요량','단위','일련번호', '예약품목번호', '생산오더번호','sernp','pordno_pop', 'lgort' ],
		colModel:[
// 			{name:'chk',index:'chk', width:20, formatter: gridCheckBox},
			{name:'chk',index:'chk', width:20, formatter: function() { 
				return "<input type='checkbox' name='chk' class='add_itnbr' onclick='makeFaultMatnrArr(this);'/>";}},
			{name:'matnr',index:'matnr', width:120, sorttype:'text', sortable:true, key: true},
			{name:'bdmng', index:'bdmng', width:60, sorttype:'text', sortable:true},
			{name:'meins',index:'meins', width:60, sorttype:'text', sortable:true, sortable:true},
			{name:'sernr',index:'sernp', width:125, sorttype:'text', sortable:true, hidden:false},
			{name:'rspos',index:'rspos', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'aufnr',index:'aufnr', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'sernp',index:'sernp', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'pordno_pop',index:'pordno_pop', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'lgort',index:'lgort', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true}
		],
		rowNum: 1000,
		viewrecords : true,
// 	    autowidth : true,
	    shrinkToFit: false, 
	    multiselect : false,
	    height: 410,
	    width : 420,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: false,
	    sortable: true,
	    sortname: 'matnr',
	    cellEdit : true,
	    cellsubmit : 'clientArray',
	    onCellSelect: function(rowId, idx, content, event) {
// 	    	console.log(rowId, idx, content, event);
	    	var rowData = $("#grid_addItnbr_list").getRowData(rowId);
	    	$("#grid_addItnbr_list").setColProp('bdmng',{editable:false});
	    	if( rowData.sernp=='V001' ){
	    		console.log("세부 시리얼 등록!!!!");
	    		$("#fsa_project_no").val('');
		    	$('#scanner_serial_add').modal('show');
		    	$("#grid_addItnbr_list").setColProp('bdmng',{editable:false});
	    	} else {
	    		if( idx==2 ) {
		    		$("#grid_addItnbr_list").setColProp('bdmng',{editable:true});
	    		}else{
	    			$("#grid_addItnbr_list").setColProp('bdmng',{editable:false});
	    		}
	    	}
	    },
		afterEditCell: function (rowid, cellname, value, iRow, iCol) {
// 	    	console.log(rowid, cellname, value, iRow, iCol);
	    	 if( cellname=='bdmng' ){
	           	e = jQuery.Event("keydown");
				e.keyCode = $.ui.keyCode.ENTER;
				//get the edited thing
				edit = $(".edit-cell > *");
				edit.blur(function() {
				    edit.trigger(e);
				});
	    	 }
    	},
		loadComplete : function(data) {
			addItnbrData = data.rows;			
		}
	});
// 	$("#grid_addItnbr_list").trigger("reloadGrid");	
}


function initItnbrGrid() {
	console.info('initItnbrGrid()');
	
	$('#grid_itnbrlist').jqGrid({
		datatype: 'json',
		colNames:['','자재','소요량','단위','일련번호 프로파일', '예약품목번호', '생산오더번호', 'lgort'],
		colModel:[
			{name:'chk',index:'chk', width:20, formatter: function(){
				return "<input type='checkbox' name='chk' class='itnbr' onclick='makeFaultMatnrArr(this);'/>";}},
			{name:'matnr',index:'matnr', width:100, sorttype:'text', sortable:true, key: true},
			{name:'bdmng', index:'bdmng', width:100, sorttype:'text', sortable:true},
			{name:'meins',index:'meins', width:100, sorttype:'text', sortable:true, sortable:true},
			{name:'sernp',index:'sernp', width:100, sorttype:'text', sortable:true, hidden:false},
			{name:'rspos',index:'rspos', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'aufnr',index:'aufnr', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'lgort',index:'lgort', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true}
		],
// 		pager : '#grid_itnbrlist_pager',
		rowNum:10000,
// 		rowList : [ 20, 50, 100 ],
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 360,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
// 	    sortable: true,
// 	    sortname: 'matnr',
	    onSelectRow : function(rowid, selected) {
			if ( rowid != null && selected ) { 
				var rowInfo = $("#grid_itnbrlist").getRowData(rowid);
				addMatObj = rowInfo;
			}
		},
		loadComplete : function(data) {
		}
	});
	
	$("#grid_itnbrlist").trigger("reloadGrid", [{current:true}]); 
}

function materialSearch() {
	console.log('materialSearch()');
	
	var page_url = '/frontend/hub/material_recv_master_select'
		 		 + '?matnr=' + encodeURIComponent($("#m_matnr").val())
		 		 + '&werks=' + encodeURIComponent(dept_cd)
		 		 + '&wrkst=' + encodeURIComponent($("#m_wrkst").val())
		 		 + '&maktx=' + encodeURIComponent($("#m_maktx").val());
	$("#grid_materiallist").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_materiallist").trigger("reloadGrid");
	
	$("#modal_mat_search").modal('hide');
}

function initMaterialGrid() {
	var page_url = '/frontend/hub/material_recv_master_select'
		+"?werks=" + encodeURIComponent(dept_cd);
	$('#grid_materiallist').jqGrid({
		url:page_url,
		datatype: 'json',
		colNames:['','자재코드','자재내역',' Spec.','제품군명', '자재그룹명', '생성일자', '수정일자', '단위', 'lgpro'],
		colModel:[
// 			{name:'chk',index:'chk', width:20, editable: true, align:'center', edittype: 'checkbox', editoptions: { value: "Y:N", defaultValue: "false" },formatter: "checkbox", formatoptions: { disabled: false }},
			{name:'chk',index:'chk', width:20, formatter: function(){
						return "<input type='checkbox' name='chk' class='mat' onclick='makeFaultMatnrArr(this);'/>"; }},
			{name:'matnr',index:'matnr', width:100, sorttype:'text', sortable:true, key:true},
			{name:'maktx',index:'maktx', width:130, sorttype:'text', sortable:true},
			{name:'wrkst',index:'wrkst', width:130, sorttype:'text', sortable:true, sortable:true},
			{name:'vtext',index:'vtext', sorttype:'text', sortable:true, hidden:true},
			{name:'wgbez',index:'wgbez', sorttype:'text', sortable:true, hidden:true},
			{name:'date_created',index:'date_created', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'date_updated',index:'date_updated', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'meins',index:'meins', width:30, hidden:false},
			{name:'lgpro',index:'lgpro', hidden:true}
		],
		pager : '#grid_materiallist_pager',
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 360,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: false,
	    sortable: true,
	    sortname: 'matnr',
	    jsonReader : {
		    root : "list_data",
		    records : "records",
		    repeatitems : false,
		    id : "matnr"
	    },
	    onSelectRow : function(rowid, selected) {
			if ( rowid != null && selected ) { 
				var matRowInfo = $("#grid_materiallist").getRowData(rowid);
				addMatObj.matnr = matRowInfo.matnr;
				addMatObj.bdmng = 1;
				addMatObj.meins = matRowInfo.meins;
				addMatObj.sernp = '';
				addMatObj.rspos = '';
				addMatObj.aufnr = '';
				addMatObj.lgort = matRowInfo.lgpro;
			}
		},
		loadComplete : function(data) {
			
			console.log(data);
			
			$('input:checkbox[class="mat"]').each(function() {
				var mat_nm = ((($(this)).parent()).parent())[0].id;
				
				for(var i=0 ; i<matArr.length; i++)
				{
					if(matArr[i].matnr == mat_nm){ 
				    	this.checked = true;
			 	    }		
				}
				
			 });
		}
	});
}

//시리얼 등록
// function smallSerialInsert() {
// 	console.log('smallSerialInsert()');
	
// 	var rowData = $("#grid_ready").getRowData(readyKey);
// 	if ( readyKey == '' ) {
// 		fnMessageModalAlert("확인하세요.", "선택된 생산지시오더 없습니다.");
// 		return;
// 	}

// 	$('#grid_itnbrlist').jqGrid('clearGridData');
// 	$("#grid_addItnbr_list").jqGrid('clearGridData');
	
// 	reloadNewItnbrGrid();
	
// // 	console.log(rowData);
// 	$("#gubun").val(searchMatCode);		

// 	if( searchMatCode=='basic' ){
// 		var page_url = "/sap_master/ziffm_mes_pp004"
// 			 + "?func_name=" + encodeURIComponent("ZIFFM_MES_PP004")
// 			 + "&IV_AUFNR=" + encodeURIComponent(rowData.pordno)
// 			 + "&IV_IF=X";
		
// 		$("#grid_itnbrlist").jqGrid('setGridParam', { url : page_url, datatype : 'json' });
// 		$("#grid_itnbrlist").trigger("reloadGrid");
// 		$("#dv_grid_itnbrlist").show();
// 		$("#dv_grid_materiallist").hide();
// 		$("#matSearch").hide();		
// 	}else{	// mat
// 		var page_url = '/frontend/hub/material_recv_master_select';
// 		$("#grid_materiallist").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
// 		$("#grid_materiallist").trigger("reloadGrid");
// 		$("#dv_grid_itnbrlist").hide();
// 		$("#dv_grid_materiallist").show();
// 		$("#matSearch").show();
// 	}

// 	$("#m_dsa_mes_po").val(rowData.pordno_pop);
// 	$("#m_dsa_routing_no").val(rowData.routing_no);
// // 	var masGridRowData = $("#grid_sapord").getRowData($("#grid_sapord").getGridParam('selrow'));
// 	$("#m_dsa_project_no").val(rowData.project_no);
// 	$("#m_dept_cd").val(dept_cd);
// 	$("#m_dsa_routing_gno").val(rowData.routing_gno);
// 	$("#modal_detail_serial_add").modal('show');
// }

function changeMatGubun() {
	console.log('changeMatGubun()');
	
	var rowData = $("#grid_ready").getRowData(readyKey);
	
	if( $("#gubun").val()=='basic' ){
		var page_url = "/sap_master/ziffm_mes_pp004"
			 + "?func_name=" + encodeURIComponent("ZIFFM_MES_PP004")
			 + "&IV_AUFNR=" + encodeURIComponent(rowData.pordno)
			 + "&IV_IF=X";
		
		$("#grid_itnbrlist").jqGrid('setGridParam', { url : page_url, datatype : 'json' });
		$("#grid_itnbrlist").trigger("reloadGrid");
		$("#dv_grid_itnbrlist").show();
		$("#dv_grid_materiallist").hide();
		$("#matSearch").hide();		
	}else{	// mat
		var page_url = '/frontend/hub/material_recv_master_select'
			 + '?werks=' + encodeURIComponent(dept_cd);
		$("#grid_materiallist").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
		$("#grid_materiallist").trigger("reloadGrid");
		$("#dv_grid_itnbrlist").hide();
		$("#dv_grid_materiallist").show();
		$("#matSearch").show();
	}
}

var dataArr = [];
//itnbr move to newlist
function addItnbrDetail() {
	console.log('addItnbrDetail()');
	
	var gridDataArr = $('#grid_addItnbr_list').jqGrid('getRowData');
	
	// 추가하려는 목록이 선택 되었는가?
	if( addMatObj.matnr == '' || addMatObj.matnr == undefined){
		fnMessageModalAlert("확인하세요", "추가하려는 항목을 선택해야 합니다.");
	} else {
		// 기존에 추가된 항목인지 확인
		if( gridDataArr.length>0 ){
			
			var chkCnt = 0;
			for(var idx=0; idx<gridDataArr.length; idx++){
// 				console.log(gridDataArr[idx]);
				if( gridDataArr[idx].matnr == addMatObj.matnr ){
					chkCnt++;
				}
			}
			// chkCnt가 0보다 크면, 같은 항목이 한개 이상 있다는...
			if( chkCnt==0 ){
				dataArr.push(addMatObj);
				$("#grid_addItnbr_list").jqGrid('addRow',{position  :"last", initdata : addMatObj, cellEdit:false});
			}else{
				fnMessageModalAlert("Notification(Duplicate)", "이미 추가되어 있는 항목입니다.");	
			}
		}else{
			dataArr.push(addMatObj);
			$("#grid_addItnbr_list").jqGrid('addRow',{position  :"last", initdata  : addMatObj, cellEdit:false});	
		}
	}
	addMatObj = {};
}

//remove new itnbr list
function deleteItnbrDetail() {
	$("#grid_addItnbr_list").jqGrid('delRowData', $("#grid_addItnbr_list").getGridParam('selrow'));
}

function fnSaveDetailSerial() {
	console.log('fnSaveDetailSerial()');
// 	console.log($("#m_dept_cd").val());
	var rfcData = $("#grid_addItnbr_list").jqGrid('getRowData');
	var frmData = $("#frm_detail_serial").serializeArray();
	var selectedData = $("#grid_ready").getRowData(readyKey);
	
	var page_url = "/frontend/prod/detail_serial_add";
	var postData = "pordno_pop=" + encodeURIComponent(selectedData.pordno_pop)
				 + "&routing_no=" + encodeURIComponent(selectedData.routing_no)
				 + "&routing_gno=" + encodeURIComponent($("#m_dsa_routing_gno").val())
				 + "&project_no=" + encodeURIComponent($("#m_dsa_project_no").val()) //메인 시리얼번호
				 + "&dept_cd=" + encodeURIComponent($("#m_dept_cd").val())
				 + "&lgort=" + encodeURIComponent(selectedData.lgort)
				 + "&pordno=" + encodeURIComponent((selectedData.pordno_pop).substr(0,7))
				 + "&params=" + encodeURIComponent(JSON.stringify(rfcData));
// 	console.log($("#m_dept_cd").val());
	//m_dsa_mes_po
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnMessageModalAlert("Notification(SerialAdd)","선택된 생산지시오더 시리얼등록을 성공했습니다.");
			} else {
				fnMessageModalAlert("Notification(SerialAdd)", "선택된 생산지시오더 시리얼등록을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(SerialAdd)", "선택된 생산지시오더 시리얼등록을 실패했습니다.");
		},
		loadComplete : function(data) {
// 			console.log(data);
		},
		complete : function() {
			$("#modal_detail_serial_add").modal('hide');
		}
	});
}

function chnStatus(pdsts) {
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selectedData = $("#grid_ready").getRowData(selKey);
	
	if ( selKey == '' || selKey == null ) {
		fnMessageModalAlert("Notification(MES)", "선택된 생산지시오더 없습니다.");
		return;
	}
	
	var page_url = '/frontend/prod/workChangeStatus';
	var postData = 'pordno_pop=' + encodeURIComponent(selectedData.pordno_pop)
				 + '&routing_no=' + encodeURIComponent(selectedData.routing_no)
				 + '&pdsts=' + pdsts;
	var success_msg = '';
	var fail_msg = '';
	if( pdsts == 'p6' ) {	// 작업종료
		success_msg = '선택된 지시가 생산완료 성공했습니다.';
		fail_msg = '선택된 지시가 생산완료 실패했습니다.';
	} else if( pdsts == 'p4' ){	// 비가동 시작
		success_msg = '선택된 지시가 비가동 시작에 성공했습니다.';
		fail_msg = '선택된 지시가 비가동 시작에 실패했습니다.';
	} else if( pdsts == 'p5' ){	// 비가동 종료
		success_msg = '선택된 지시가 비가동 종료에 성공했습니다.';
		fail_msg = '선택된 지시가 비가동 종료에 실패했습니다.';
	} else if( pdsts == 'p3' ){
		// 작업자 정보가 이미 등록되어 있다면 modal을 띄우지 말아야 한다.
		// 좌측의 작업 목록에서 선택한 공정의 상태를 확인 후 작업을 시작해야 한다.
		success_msg = '선택된 지시가 생산시작 성공했습니다.';
		fail_msg = '선택된 지시가 생산시작 실패했습니다.';
	}
	
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnMessageModalAlert("Notification(MES)", data.rtn_msg);				
				if(data.status_change_yn == 'N') {
					console.log("데이터 변동 없음..")
					return;
				}
				/********************생산 완료 시 sap로 실적 전송 : Start*******************/
				if(pdsts == 'p6') {
					console.log("prodEndChk() ::: "  + prodEndChk());
					if(prodEndChk()) {					//routing_header_master의 routng_plast_gubun 값... 현재 라우팅이 생산종료 단계인지 체크
						console.log("생산실적처리");
						var rowData = $("#grid_sapord").getRowData(selectedData.pordno);
						toSapProdIn();					//생산입고 rfc (ZIFFM_MES_PP008) 실행
						toSapProdData();		
					}
					
					if(t1Chk())	{	// 다음 공정이 T1 인지 체크..T1이면 최종검사테이블 insert
						console.log("toMesLastInspec();    // 최종검사!!!!");
						toMesLastInspec();	
					}	
				}
				/********************생산 완료 시 sap로 실적 전송 : End  *******************/
			} else {
				fnMessageModalAlert("Notification(MES)", fail_msg);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", fail_msg);
		},
		complete : function() {
			searchGridReady();
			$("#grid_ready").jqGrid("setSelection", selKey).focus();
			searchGridComp();
			searchGridHis();
		}
	});
}

// 작업시작버튼 눌렀을 때...
function fnClickWorkStart(){
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selectedData = $("#grid_ready").getRowData(selKey);
	
	if ( selKey == '' || selKey == null ) {
		fnMessageModalAlert("Notification(MES)", "시작할 작업을 목록에서 선택해야 합니다.");
		return;
	}
	
	$('#modal_worker_add').modal('show');
}

//btn action 작업시작 버튼
function fnWorkerAdd() {
// 	console.log('fnWorkerAdd()');
	var fwa_member_emp_no = '';
	var fwa_member_nm= '';
	
	//SELECT ROW ->> $('#grid_worker').jqGrid('getGridParam',"selrow")
	var gridData = $('#grid_worker').jqGrid('getRowData');

	for (var i = 0; i < gridData.length; i++) {
		if (gridData[i].chk == 'Y') {
			fwa_member_emp_no = gridData[i].member_emp_no
			fwa_member_nm= gridData[i].member_nm
		}
	}
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selectedData = $("#grid_ready").getRowData(selKey);
	
	var postData = $("#frm_worker_add").serializeArray();
	var page_url = "/frontend/prod/worker_update";
	var postData = "pordno_pop=" + encodeURIComponent(selectedData.pordno_pop)
				 + "&routing_no=" + encodeURIComponent(selectedData.routing_no)
				 + "&member_emp_no=" + encodeURIComponent(fwa_member_emp_no)
				 + "&member_nm=" + encodeURIComponent(fwa_member_nm)
				 + "&jocod=" + encodeURIComponent($(':radio[name="rdo_work_line"]:checked').val());
		
	// 이미 작업자가 등록되어 있는 경우 update, 없는 경우 insert service단에서 처리해야 하는가??
	if(fwa_member_emp_no =='' || fwa_member_nm =='') {
		fnMessageModalAlert("Notification(fnWorkerAdd)", "작업자를 선택해주세요.");
	} else {
		// 작업자 등록
		$.ajax({
			url : page_url,
			data : postData,
			type : "POST",
			success : function(data, textStatus, jqXHR) {
				if (data.status == "200") {
					if ( data.returnMsg=='Already registered' ){
						fnMessageModalAlert("Notification(fnWorkerAdd)", "이미 등록된 작업자가 존재합니다.");
						chnStatus('p3');
					} else {
// 						fnWorkStart(selected_pordno_pop,selected_routing_no);
						chnStatus('p3');
					}
				} else {
					fnMessageModalAlert("Notification(fnWorkerAdd)", "작업자 등록에 실패했습니다.");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("Notification(fnWorkerAdd)", "작업자 등록에 실패했습니다.");
			},
			complete : function() {
				selected_pordno_pop = "";
				selected_routing_no = "";
				
				fwa_member_emp_no = '';
				fwa_member_nm= '';
								
				$("#modal_worker_add").modal('hide');
			}
		});
	}
}

//modal : employee list generate
function fnLoadWorkerAddGrid() {
// 	console.log('fnLoadWorkerAddGrid()');
	var pordno_pop;
	var page_url = "/frontend/prod/worker_select_1110";
	
	$("#grid_worker").jqGrid({
		url : page_url,
		datatype : "json",
		colNames : [ '','사원번호', 'ID','사원명','구분' ],
		colModel : [ 
			{name : 'chk', index : 'chk', width : 10, editable : true, align : 'center', edittype : 'checkbox',
				multiselect : false,
				editoptions : { value : "Y:N", defaultValue : "false"},
				formatter : "checkbox",
				formatoptions : { disabled : false}}, 
			{name : 'member_emp_no', index : 'member_emp_no', width : 90, sorttype : "text", sortable : true}, 
			{name : 'member_id', index : 'member_id', width : 90, sorttype : "text", sortable : true}, 
			{name : 'member_nm', index : 'member_nm', width : 100, sorttype : "text", sortable : true}, 
			{name : 'dept_cd', index : 'dept_cd', width : 100, sorttype : "text", sortable : true} ],
		rowNum : 1000,
		viewrecords : true,
		autowidth : true,
		shrinkToFit : true,
		multiselect : false,
		height : 270,
		altRows : true,
		rownumbers : true,
		rownumWidth : 25,
		autoencode : true,
		loadonce : true,
		sortable : true,
		onSelectRow : function(rowid, selected) {
			if (rowid != null) { }
		},
		loadComplete : function() {}
		});
}

function workStatusChk() {
// 	console.log('workStatusChk()');
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selectedData = $("#grid_ready").getRowData(selKey);
	if(selectedData.routing_code == 'T1')
		return;
	
	
	var gridData = $('#grid_his').jqGrid('getRowData');

	$("#btn_p3").attr('disabled', 'disabled');
	$("#btn_p4").attr('disabled', 'disabled');
	$("#btn_p5").attr('disabled', 'disabled');
	$("#btn_p6").attr('disabled', 'disabled');
// 	$("#btn_p4").removeAttr('disabled');
	
	if ($('#grid_popord').jqGrid('getRowData').length == 0) {
	} else if (gridData.length == 0) {
		//작업시작
		$("#btn_p3").removeAttr('disabled');
	} else if (gridData[gridData.length - 1].start_dt_tm != "") {
		//비가동시작, 작업종료
// 		$("#btn_p3").removeAttr('disabled');
		$("#btn_p4").removeAttr('disabled');
// 		$("#btn_p5").removeAttr('disabled');
		$("#btn_p6").removeAttr('disabled');
		
// 		$("#btn_work_start").css("visibility","hidden");
// 		$("#btn_work_pause_end").css("visibility","hidden");
	} else if (gridData[gridData.length - 1].pause_start_dt_tm != "") {
		//비가동종료			
// 		$("#btn_p3").removeAttr('disabled');
// 		$("#btn_p4").removeAttr('disabled');
		$("#btn_p5").removeAttr('disabled');
// 		$("#btn_p6").removeAttr('disabled');
		
// 		$("#btn_work_start").css("visibility","hidden");
// 		$("#btn_work_pause_start").css("visibility","hidden");
// 		$("#btn_work_end").css("visibility","hidden");
	} else if (gridData[gridData.length - 1].pause_end_dt_tm != "") {
		//비가동시작, 작업종료
// 		$("#btn_p3").removeAttr('disabled');
		$("#btn_p4").removeAttr('disabled');
// 		$("#btn_p5").removeAttr('disabled');
		$("#btn_p6").removeAttr('disabled');
		
// 		$("#btn_work_start").css("visibility","hidden");
// 		$("#btn_work_pause_end").css("visibility","hidden");
	} else if (gridData[gridData.length - 1].end_dt_tm != "") {
		//작업끝!!!! 다 가림
// 		$("#btn_p3").removeAttr('disabled');
// 		$("#btn_p4").removeAttr('disabled');
// 		$("#btn_p5").removeAttr('disabled');
// 		$("#btn_p6").removeAttr('disabled');
		
// 		$("#btn_work_start").css("visibility","hidden");
// 		$("#btn_work_pause_start").css("visibility","hidden");
// 		$("#btn_work_pause_end").css("visibility","hidden");
// 		$("#btn_work_end").css("visibility","hidden");
	}
}

function popUpDetailSerial() {
	console.log('popUpDetailSerial()');
	
// 	faultMatrArr.splice(0,faultMatrArr.length);
	faultMatrArr = [];
	
	addItnbrArr	 = [];
	itnbrArr  = [];
	matArr = [];
	
	
// 	var rowData = $("#grid_sapord").getRowData(selected_pordno);
	
// 	if (selected_routing_no == '') {
// 		fnMessageModalAlert("Notification(MES)", "선택된 생산지시오더 없습니다.");
// 		return;
// 	}

	var rowData = $("#grid_ready").getRowData(readyKey);
	if ( readyKey == '' ) {
		fnMessageModalAlert("확인하세요.", "선택된 생산지시오더 없습니다.");
		return;
	}
	
	$('#grid_itnbrlist').jqGrid('clearGridData');
	$("#grid_addItnbr_list").jqGrid('clearGridData');
	
	//	initItnbrGrid();
// 	materialSearch();
 	reloadNewItnbrGrid();
	
	$("#gubun").val(searchMatCode);		

	if( searchMatCode=='basic' ){
		var page_url = "/sap_master/ziffm_mes_pp004"
			 + "?func_name=" + encodeURIComponent("ZIFFM_MES_PP004")
			 + "&IV_AUFNR=" + encodeURIComponent(rowData.pordno)
			 + "&IV_IF=X";
		
		$("#grid_itnbrlist").jqGrid('setGridParam', { url : page_url, datatype : 'json', loadComplete : function(data) 
			{
				ItnbrData = data.rows;
				
				/////////////////////////////////////////////////////////////////////
				$('input:checkbox[class="itnbr"]').each(function() {
										
					var mat_nm = ((($(this)).parent()).parent())[0].id;
					
					for(var i=0 ; i<itnbrArr.length; i++)
					{
						if(itnbrArr[i].matnr == mat_nm){ 
					    	this.checked = true;
				 	    }		
					}
					
				 });
				/////////////////////////////////////////////////////////////////////
			} 
		});

		$("#grid_itnbrlist").trigger("reloadGrid");
		$("#dv_grid_itnbrlist").show();
		$("#dv_grid_materiallist").hide();
		$("#matSearch").hide();		
	}else{	// mat
		var page_url = '/frontend/hub/material_recv_master_select'
			+"?werks=" + encodeURIComponent(dept_cd);
		$("#grid_materiallist").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
		$("#grid_materiallist").trigger("reloadGrid");
		$("#dv_grid_itnbrlist").hide();
		$("#dv_grid_materiallist").show();
		$("#matSearch").show();
	}

	$("#m_dsa_mes_po").val(rowData.pordno_pop);
	$("#m_dsa_routing_no").val(rowData.routing_no);
	$("#m_dsa_project_no").val(rowData.project_no);
	$("#m_dept_cd").val(dept_cd);
	$("#m_dsa_routing_gno").val(rowData.routing_gno);

	$("#modal_detail_serial_add").modal('show');
}

var addItnbrArr = [];
var itnbrArr = [];
var matArr = [];
function makeFaultMatnrArr(obj) {
// 	console.log($(obj)[0].checked);
	
	console.log($(obj));
	var jObj = {};
	jObj.matnr = $($($(obj).parent()).siblings()[1]).text();
	jObj.meins = $($($(obj).parent()).siblings()[3]).text();
		
	jObj.gubun = $(obj)[0].className;	
	
	if(jObj.gubun == "itnbr") {
		jObj.lgort = $('#grid_itnbrlist').getRowData(jObj.matnr).lgort;	
	} else if(jObj.gubun == "mat")  {
		jObj.lgort = $('#grid_materiallist').getRowData(jObj.matnr).lgpro;
	}
	
// 	console.log(jObj.lgort);
	
	var flag = true;
	if( jObj.gubun=='add_itnbr' ) {
		for(var i=0 ; i<addItnbrArr.length; i++) {
			if(addItnbrArr[i].matnr == jObj.matnr) {
				addItnbrArr.splice(i,1);
				flag = false;		
			} 
		}
		if(flag == true)		
			addItnbrArr.push(jObj);	
	} else if( jObj.gubun=='itnbr' ) {
		for(var i=0 ; i<itnbrArr.length; i++) {
			if(itnbrArr[i].matnr == jObj.matnr) {
				itnbrArr.splice(i,1);
				flag = false;		
			} 
		}
		if(flag == true)		
			itnbrArr.push(jObj);
	} else if( jObj.gubun=='mat' ) {
		for(var i=0 ; i<matArr.length; i++) {
			if(matArr[i].matnr == jObj.matnr) {
				matArr.splice(i,1);
				flag = false;		
			} 
		}
		if(flag == true)		
			matArr.push(jObj);
	}	
	

// 	if( gubun=='add_itnbr' ) {
// 		addItnbr.push(jObj);	
// 	} else if( gubun=='itnbr' ) {
// 		itnbrArr.push(jObj);
// 	} else if( gubun=='mat' ) {
// 		matArr.push(jObj);
// 	}
}

var addItnbrData;
var ItnbrData;
function fnFaultMatnrConf() {
	console.log('fnFaultMatnrConf()');

	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selectedData = $("#grid_ready").getRowData(selKey);
	
	$("#grid_fault_list").jqGrid('clearGridData');
	
	var totalArr = [];
// 	$.each(faultMatrArr, function(idx, obj){
// 		totalArr.push(obj.matnr);
// 	});
	
	$.each(addItnbrArr, function(idx, obj){
		totalArr.push(obj.matnr);
	});
	$.each(itnbrArr, function(idx, obj){
		totalArr.push(obj.matnr);
	});
	$.each(matArr, function(idx, obj){
		totalArr.push(obj.matnr);
	});
	var uniqArr = $.unique(totalArr);
	
	
	console.log(uniqArr);
	
	if(uniqArr.length==0) {
		fnMessageModalAlert("Notification(MES)", "체크 된 데이터가 없습니다.");
		return;
	}
	
// 	console.log(uniqArr)
	console.log(addItnbrData);
	console.log(ItnbrData);


 	var itnbr_data;
	var page_url = '/frontend/hub/material_recv_master_select_nopage'	
				 + "?matnrs=" + encodeURIComponent(String(uniqArr))
				 +"&werks=" + encodeURIComponent(dept_cd);
	
	$.ajax({
		url : page_url,
		type : "POST",
		async:false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				itnbr_data = data.rows;
			} else {
				fnMessageModalAlert("Fail", "데이터를 불러오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Fail", "데이터를 불러오지 못했습니다.");
		}
	});
	
	var arrObj = [];


	$.each(itnbr_data, function(idx, obj){
		
		var tmpObj = {};
		tmpObj.aufnr = selectedData.pordno;
		tmpObj.werks = dept_cd;
		tmpObj.sernp = obj.sernp;
			
		tmpObj.matnr = obj.matnr;
		tmpObj.maktx = obj.maktx;	
		tmpObj.wrkst = obj.wrkst;
		tmpObj.meins = obj.meins;
		
		var menge = '1.000';	//수량
		var sernr = '';	//시리얼
		var rfc_chk = 'N';	//리버스여부(취소 RFC)
		var lgort = obj.lgpro;
		console.log("obj.lgpro ::: " + obj.lgpro); 
		//소요자재 내역으로 덮어쓰기
		$.each(ItnbrData, function(i, row){
			if( obj.matnr==row.matnr){
				menge = row.bdmng;
				sernr = "";
				rfc_chk = "N";
				lgort = row.lgort;
			}
		});
		
		//공정투입된 자재 내역으로 덮어쓰기
		$.each(addItnbrData, function(i, row){
			if( obj.matnr==row.matnr){
				menge = row.bdmng;
				sernr = row.sernr;
				rfc_chk = "Y";
				//lgort = "";
			}
		});
		
		tmpObj.lgort = lgort;
		tmpObj.menge = menge;
		tmpObj.sernr = sernr;
		tmpObj.rfc_chk = rfc_chk;
		
		arrObj.push(tmpObj);
		$('#grid_fault_list').addRowData( idx, tmpObj, 'last');
	});
	console.log(arrObj);

	initOptions($('#sel_step1'));
	initOptions($('#sel_step2'));
	initOptions($('#sel_step3'));
	initOptions($('#sel_step4'));
	makeSelStep1();
	$("#fault_mng").modal('show');
}

function checkBarcode(text){
	if(text.value.length > 8) {
		$("#btnArea").show();
	} else {
		$("#btnArea").hide();
    } 
}

function sernrInputMng() {
	console.log('sernrInputMng()');
	
	var gridRowData = $("#grid_addItnbr_list").getRowData($("#grid_addItnbr_list").getGridParam('selrow'));
	var sernr = $('#fsa_project_no').val();
	
	// duplicate check
	var duCnt = chkSerialNoDuplicate(sernr);
	if( duCnt>0 ) {
		fnMessageModalAlert("Notification(fnSaveMainSerial)", "시리얼번호가 중복된 값이 입력되었습니다.");
		return false;
	}

	gridRowData.sernr = sernr;
	$("#grid_addItnbr_list").setRowData($("#grid_addItnbr_list").getGridParam('selrow'), gridRowData, {});
	$("#scanner_serial_add").modal('hide');
}

function chkSerialNoDuplicate(sernrNo) {
	console.log('chkSerialNoDuplicate(',sernrNo,')');
	var page_url = "/frontend/prod/chkSerialNoDuplicate";
	var postData = "project_no=" + encodeURIComponent(sernrNo);
	var returnVal = 0;
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async : false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				if( Number(data.cnt)>0 ) {
					returnVal = Number(data.cnt);
				}
			} else {
				fnMessageModalAlert("Notification(chkSerialNoDuplicate)", "시리얼 번호 중복 확인 실패하였습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(chkSerialNoDuplicate)", "시리얼 번호 중복 확인 중 오류 발생하였습니다.");
		},
		loadComplete : function(data) { },
		complete : function(data) {
		}
	});
	return returnVal;
}

function initOptions(obj) {
    $(obj)
        .find('option')
        .remove()
        .end()
//         .append('<option value="">선택</option>')
        .val();
}

var step1Val = '';
var step2Val = '';
var step3Val = '';
var step4Val = '';
function changeStep(selVal, step) {
	console.log('changeStep(',selVal,',',step,')');
	var compName = '';
	if( step=='step1' ) {
		initOptions($('#sel_step2'));
		initOptions($('#sel_step3'));
		initOptions($('#sel_step4'));
		step1Val = selVal;
		compName = 'sel_step2';
	} else if( step=='step2' ) {
		initOptions($('#sel_step3'));
		initOptions($('#sel_step4'));
		step2Val = selVal;
		compName = 'sel_step3';
	} else if( step=='step3' ) {
		initOptions($('#sel_step4'));
		step3Val = selVal;
		compName = 'sel_step4';
	} 
// 	else if( step=='step4' ) {
// 		step4Val = selVal;
	
	var page_url = "/frontend/scm/issue_getSteps";
	var params = "";
	if( step=='step1' ) {
		params += "gr_code=" + encodeURIComponent(step1Val);
	} 
	if( step=='step2' ) {
		params += "gr_code=" + encodeURIComponent(step1Val);
		params += "&level1_code=" + encodeURIComponent(step2Val);
	}
	if( step=='step3' ) {
		params += "gr_code=" + encodeURIComponent(step1Val);
		params += "&level1_code=" + encodeURIComponent(step2Val);
		params += "&level2_code=" + encodeURIComponent(step3Val);
	}
// 	else if( step=='step4' )
// 		params += "?level3_code=" + encodeURIComponent(step4Val);
	
	$.ajax({
	    url: page_url,
	    data: params,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$('#'+compName).append($('<option>', { 
				        text : '-'
				    }));
					$.each(data.rows, function (i, item) {
						if( step=='step1' ) {
							$('#'+compName).append($('<option>', { 
						        value: item.level1_code,
						        text : item.level1_name 
						    }));
						} else if( step=='step2' ) {
							$('#'+compName).append($('<option>', { 
								value: item.level2_code,
						        text : item.level2_name 
						    }));
						} else if( step=='step3' ) {
							$('#'+compName).append($('<option>', { 
								value: item.level3_code,
						        text : item.level3_name 
						    }));
						} 
					});
				}
	    	} else {
	    		fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}

function p_changeStep(selVal, step) {
	console.log('changeStep(',selVal,',',step,')');
	var compName = '';
	if( step=='step1' ) {
		initOptions($('#p_sel_step2'));
		initOptions($('#p_sel_step3'));
		initOptions($('#p_sel_step4'));
		step1Val = selVal;
		compName = 'p_sel_step2';
	} else if( step=='step2' ) {
		initOptions($('#p_sel_step3'));
		initOptions($('#p_sel_step4'));
		step2Val = selVal;
		compName = 'p_sel_step3';
	} else if( step=='step3' ) {
		initOptions($('#p_sel_step4'));
		step3Val = selVal;
		compName = 'p_sel_step4';
	} 
// 	else if( step=='step4' ) {
// 		step4Val = selVal;
	
	var page_url = "/frontend/scm/issue_getSteps";
	var params = "";
	if( step=='step1' ) {
		params += "gr_code=" + encodeURIComponent(step1Val);
	} 
	if( step=='step2' ) {
		params += "gr_code=" + encodeURIComponent(step1Val);
		params += "&level1_code=" + encodeURIComponent(step2Val);
	}
	if( step=='step3' ) {
		params += "gr_code=" + encodeURIComponent(step1Val);
		params += "&level1_code=" + encodeURIComponent(step2Val);
		params += "&level2_code=" + encodeURIComponent(step3Val);
	}
// 	else if( step=='step4' )
// 		params += "?level3_code=" + encodeURIComponent(step4Val);
	
	$.ajax({
	    url: page_url,
	    data: params,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$('#'+compName).append($('<option>', { 
				        text : '-'
				    }));
					$.each(data.rows, function (i, item) {
						if( step=='step1' ) {
							$('#'+compName).append($('<option>', { 
						        value: item.level1_code,
						        text : item.level1_name 
						    }));
						} else if( step=='step2' ) {
							$('#'+compName).append($('<option>', { 
								value: item.level2_code,
						        text : item.level2_name 
						    }));
						} else if( step=='step3' ) {
							$('#'+compName).append($('<option>', { 
								value: item.level3_code,
						        text : item.level3_name 
						    }));
						} 
					});
				}
	    	} else {
	    		fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}
	
function makeSelStep1() {
	console.log('makeSelStep1()');
	
	var page_url = "/frontend/scm/issue_getStep1";
	$.ajax({
	    url: page_url,
	    data: '',
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    		console.log(data);
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$('#sel_step1').append($('<option>', { 
				        text : '-'
				    }));
					$.each(data.rows, function (i, item) {
						$('#sel_step1').append($('<option>', { 
					        value: item.gr_code,
					        text : item.gr_nm 
					    }));
					});
				}
	    	} else {
	    		fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}

function p_makeSelStep1() {
	console.log('makeSelStep1()');
	
	var page_url = "/frontend/scm/issue_getStep1";
	$.ajax({
	    url: page_url,
	    data: '',
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    		console.log(data);
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){				
					$('#p_sel_step1').append($('<option>', { 
				        text : '-'
				    }));
					$.each(data.rows, function (i, item) {
						$('#p_sel_step1').append($('<option>', { 
					        value: item.gr_code,
					        text : item.gr_nm 
					    }));
					});
				}
	    	} else {
	    		fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}

function input_code() {
	
	var s_id = $('#grid_fault_list').jqGrid('getGridParam', 'selrow');
	
	var sel_step1 = $("#sel_step1").val();
	var sel_step2 = $("#sel_step2").val();
	var sel_step3 = $("#sel_step3").val();
	var sel_step4 = $("#sel_step4").val();
	
	var sel_step1_t = $("#sel_step1 option:selected").text();
	var sel_step2_t = $("#sel_step2 option:selected").text();
	var sel_step3_t = $("#sel_step3 option:selected").text();
	var sel_step4_t = $("#sel_step4 option:selected").text();
	
	if(s_id == null) {
		fnMessageModalAlert("Notification(MES)", "불량코드가 입력 될 자재불량내역을 선택해 주세요.");
		return;
	}
	
	if(sel_step4_t == '' || sel_step4_t == '-') {
		fnMessageModalAlert("Notification(MES)", "lv.03 까지 불량내역을 지정해주세요.");
		return;
	}
	
	$('#grid_fault_list').jqGrid('setCell', s_id, 'org_issue_memo', sel_step4_t);
	
	$('#grid_fault_list').jqGrid('setCell', s_id, 'org_issue_code', sel_step4);
}

function jqgridHighlightFormattersernpYn(cellvalue, options, rowObject) {
// 	if (cellvalue != null && cellvalue != "" && cellvalue == "V001") {
	if (rowObject.sernp != null && rowObject.sernp != "" && rowObject.sernp == "V001") {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">시리얼대상</span>';
	} else {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">시리얼미대상</span>';
	}
}

function fnLoadFaultListGrid() {
	
// 	var matnr;	//자재번호
// 	var maktx;	//자재내역
// 	var wrkst;	//자재스펙
// 	var menge;	//수량
// 	var sernr;	//시리얼
// 	var rfc_chk;	//리버스여부(취소 RFC)
	
	$('#grid_fault_list').jqGrid({
		datatype: 'json',
		colNames:['자재','자재내역','자재스펙', '단위', '수량', 'sernp','시리얼대상여부', '시리얼', '리버스여부', '메모', '불량내역', 'org_issue_code', 'aufnr', 'werks', 'lgort'],
		colModel:[
			{name:'matnr',index:'matnr', width:100, sorttype:'text', key: true},
			{name:'maktx', index:'maktx', width:120, sorttype:'text'},
			{name:'wrkst',index:'wrkst', width:120, sorttype:'text', sortable:true},
			{name:'meins',index:'meins', width:40, sorttype:'text'},
			{name:'menge',index:'menge', width:50, sorttype:'text', hidden:false, editable:true},
			{name:'sernp',index:'sernp', width:80, sorttype:'text', hidden:true},
			{name:'f_sernp',index:'f_sernp', width:100, sorttype:'text', hidden:false, formatter : jqgridHighlightFormattersernpYn},
			{name:'sernr',index:'sernr', width:110, sorttype:'text', hidden:false, editable:true},
			{name:'rfc_chk',index:'rfc_chk', width:50, sorttype:'text', hidden:true},
			{name:'org_remark',index:'org_remark', width:120, sorttype:'text', hidden:false, editable:true},
			{name:'org_issue_memo',index:'org_issue_memo', width:120, sorttype:'text', hidden:false},
			
			{name:'org_issue_code',index:'org_remark', width:120, sorttype:'text', hidden:true},
			
			{name:'aufnr',index:'aufnr', width:150, sorttype:'text', hidden:true},
			{name:'werks',index:'werks', width:150, sorttype:'text', hidden:true},
			{name:'lgort',index:'lgort', width:150, sorttype:'text', hidden:true},
		],
		rowNum:10000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 360,
		altRows: true,
		rownumbers: true,
		cellEdit:true,
	    cellsubmit : 'clientArray',
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
// 	    sortable: true,
// 	    sortname: 'matnr',
	    onCellSelect : function(rowid, selected) {
			if ( rowid != null && selected ) { 
				var selGridData = $("#grid_fault_list").getRowData(rowid);	

			}
		},
		beforeEditCell: function (rowid, cellname, value, iRow, iCol){
	    	var selGridData = $("#grid_fault_list").getRowData($('#grid_fault_list').jqGrid('getGridParam','selrow'));

	    	if(cellname == 'sernr' && selGridData.sernp.length == 0) {
				console.log("시리얼비대상!!");
				$('#grid_item').jqGrid('setCell', rowid, 'sernr', ' ');
				fnMessageModalAlert("오류", "시리얼대상이 아닙니다.");
				
	    	} else {
				console.log("시리얼대상!!");
	    	}
	   	},
	    afterEditCell: function (rowid, cellname, value, iRow, iCol) {
// 	    	console.log(rowid, cellname, value, iRow, iCol);
			//This code saves the state of the box when focus is lost in a pretty horrible
            //way, may be they will add support for this in the future
            //set up horrible hack for pressing enter when leaving cell
         
            if(cellname=='sernr' || cellname=='org_remark' || cellname=='menge') {
	            e = jQuery.Event("keydown");
	            e.keyCode = $.ui.keyCode.ENTER;
	            //get the edited thing
	            edit = $(".edit-cell > *");
	            edit.blur(function() {	
	                edit.trigger(e);
	            });
            }	    	
    	},
		loadComplete : function(data) {
			console.log("grid_fault_list grid data!!!!!!");
			console.log(data);
		}
	});
}

//자재불량처리
function fnFaultConf() {
	var data = $('#grid_fault_list').getRowData();
	
	console.log(data);

	$('#grid_fault_list').jqGrid('setGridParam', {cellEdit: false});
	
	var gridDataArr = $('#grid_fault_list').jqGrid('getRowData');

	$('#grid_fault_list').jqGrid('setGridParam', {cellEdit: true});
	
	/*********************데이터 유무 확인 : Start*********************/
	if(gridDataArr.length == 0)
	{
		fnMessageModalAlert("Notification(MES)", "데이터가 없습니다.");
 		return;
	}
	/*********************데이터 유무 확인 : End*********************/
	
	var jsonStr = JSON.stringify(gridDataArr);


	/********************* 데이터 insert 및 rfc 전송 : Start*********************/
	
		var page_url = "/frontend/prod/fnFaultConf";
		var postData = 'jsonStr=' + encodeURIComponent(jsonStr);
		postData += '&pordno_pop=' + encodeURIComponent($('#m_dsa_mes_po').val());
		postData += '&routing_no=' + encodeURIComponent($('#m_dsa_routing_no').val());
		postData += '&dept_cd=' + encodeURIComponent(dept_cd);
		postData += '&t_gubun=' + encodeURIComponent("tp");

		console.log(jsonStr);

		$.ajax({
		    url: page_url,
		    data: postData,
		    async : false,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	console.log(data);
		    	if(data.status == "200") {
			    	if(data.inFzifsta == 'S') {
			    		fnMessageModalAlert("Notification(MES)", "***투입 자재 불량처리 sap 전송 결과*** <br/>e_return : : " 
		    					+ data.inFzifsta	+ "<br/>e_message : "+ data.inFzifmsg + "<br/><br/>***미투입 자재 불량처리 sap 전송 결과*** <br/>e_return : : " 
		    					+ data.e_return	+ "<br/>e_message : "+ data.e_message);
			    		} else {
			    			fnMessageModalAlert("Notification(MES)", "***투입 자재 불량처리 sap 전송 결과*** <br/>e_return : : " 
			    					+ data.inFzifsta	+ "<br/>e_message : "+ data.inFzifmsg+ "<br/><br/>***미투입 자재 불량처리 sap 전송 결과*** <br/>e_return : : " 
			    					+ data.e_return	+ "<br/>e_message : "+ data.e_message);
			    		}

		    	} else {
		    		fnMessageModalAlert("Notification(MES)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(MES)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
			
		    }
		});
		
		
		$("#modal_detail_serial_add").modal('hide');
		$("#grid_req_sernr").modal('hide');
		$("#fault_mng").modal('hide');
		
		
		/********************* 데이터 insert 및 rfc 전송 : End*********************/
}

//공정불량처리
function fnProdFaultConf() {
	var data = $('#grid_prod_fault_list').getRowData();
	
	console.log(data);

	$('#grid_prod_fault_list').jqGrid('setGridParam', {cellEdit: false});
	
	var gridDataArr = $('#grid_prod_fault_list').jqGrid('getRowData');

	$('#grid_prod_fault_list').jqGrid('setGridParam', {cellEdit: true});
	
	/*********************데이터 유무 확인 : Start*********************/
	if(gridDataArr.length == 0)
	{
		fnMessageModalAlert("Notification(MES)", "데이터가 없습니다.");
 		return;
	}
	/*********************데이터 유무 확인 : End*********************/
	
	var jsonStr = JSON.stringify(gridDataArr);


	/********************* 데이터 insert 및 rfc 전송 : Start*********************/
		var page_url = "/frontend/prod/fnProdFaultConf";
		var postData = 'jsonStr=' + encodeURIComponent(jsonStr);
		postData += '&pordno_pop=' + encodeURIComponent(selected_pordno_pop);
		postData += '&routing_no=' + encodeURIComponent(selected_routing_no);
		postData += '&t_gubun=' + encodeURIComponent("tw");

		console.log(jsonStr);

		$.ajax({
		    url: page_url,
		    data: postData,
		    async : false,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	console.log(data);
		    	if(data.status == "200") {
		    		fnMessageModalAlert("Notification(MES)", "정보를 저장했습니다.");	
		    	} else {
		    		fnMessageModalAlert("Notification(MES)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(MES)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    	
		    	
		    	console.log('여기 타냐 앟마닫.다.ㄹㄷ.닫ㄹ.ㄹ다.ㄷ라');
		    	
		    	selected_pordno='';
// 				fnSearchMasterCodeGrid();
		    
		    }
		});
		
		
		$("#modal_detail_serial_add").modal('hide');
		$("#grid_req_sernr").modal('hide');
		$("#fault_mng").modal('hide');
		
		
		/********************* 데이터 insert 및 rfc 전송 : End*********************/
}

function pordFaultProc() {
	console.log('pordFaultProc()');

	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selectedData = $("#grid_ready").getRowData(selKey);
	
	console.log(selectedData);
	
	$("#grid_prod_fault_list").jqGrid('clearGridData');

	var itnbr_rows;
	var arrObj = [];
// 	var rowData = $("#grid_sapord").getRowData(selected_pordno);
// 	var itnbr = rowData.itnbr;
// 	var pdqty = rowData.pdqty;
// 	var lgort = rowData.lgort;
// 	var project_no = rowData.project_no;
	
	var pordno = selectedData.pordno;
	var itnbr = selectedData.itnbr;
	var pdqty = selectedData.pdqty;
	var lgort = selectedData.lgort;
	var project_no = selectedData.project_no;
	
	var page_url = '/frontend/hub/material_recv_master_select_nopage'	
		 + "?matnr=" + encodeURIComponent(itnbr)
		 +"&werks=" + encodeURIComponent(dept_cd);

			$.ajax({
			url : page_url,
			type : "POST",
			async:false,
			success : function(data, textStatus, jqXHR) {
				if (data.status == "200") {
					itnbr_rows = data.rows;
				} else {
					fnMessageModalAlert("Fail", "데이터를 불러오지 못했습니다.");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("Fail", "데이터를 불러오지 못했습니다.");
			}
			});

		var tmpObj = {};
		tmpObj.aufnr = pordno;
		tmpObj.werks = dept_cd;

		tmpObj.matnr = itnbr;
		tmpObj.maktx = itnbr_rows[0].maktx;	
		tmpObj.wrkst = itnbr_rows[0].wrkst;
		tmpObj.meins = itnbr_rows[0].meins;
		
		tmpObj.lgort = lgort;
		tmpObj.menge = pdqty;
		tmpObj.sernr = project_no;
		
		arrObj.push(tmpObj);
		$('#grid_prod_fault_list').addRowData( 0, tmpObj, 'last');

	console.log(arrObj);
	
	initOptions($('#p_sel_step1'));
	initOptions($('#p_sel_step2'));
	initOptions($('#p_sel_step3'));
	initOptions($('#p_sel_step4'));
	p_makeSelStep1();
	$("#Pord_fault_mng").modal('show');
}

function input_prod_fault_code() {
	var s_id = $('#grid_prod_fault_list').jqGrid('getGridParam', 'selrow');
		
		var sel_step1 = $("#p_sel_step1").val();
		var sel_step2 = $("#p_sel_step2").val();
		var sel_step3 = $("#p_sel_step3").val();
		var sel_step4 = $("#p_sel_step4").val();
		
		var sel_step1_t = $("#p_sel_step1 option:selected").text();
		var sel_step2_t = $("#p_sel_step2 option:selected").text();
		var sel_step3_t = $("#p_sel_step3 option:selected").text();
		var sel_step4_t = $("#p_sel_step4 option:selected").text();
		
		if(s_id == null) {
			fnMessageModalAlert("Notification(MES)", "불량코드가 입력 될 자재불량내역을 선택해 주세요.");
			return;
		}
		
		if(sel_step4_t == '' || sel_step4_t == '-') {
			fnMessageModalAlert("Notification(MES)", "lv.03 까지 불량내역을 지정해주세요.");
			return;
		}
		
		$('#grid_prod_fault_list').jqGrid('setCell', s_id, 'org_issue_memo', sel_step4_t);
		
		$('#grid_prod_fault_list').jqGrid('setCell', s_id, 'org_issue_code', sel_step4);
	}
	
	
function fnLoadProdFaultListGrid() {
	

	$('#grid_prod_fault_list').jqGrid({
		datatype: 'json',
		colNames:['지시번호', '플랜트', '창고', '자재', '자재내역','자재스펙', '수량', '단위', '시리얼', '메모', '불량내역', 'org_issue_code'],
		colModel:[
			
			{name:'aufnr',index:'aufnr', width:80, sorttype:'text'},
			{name:'werks',index:'werks', width:50, sorttype:'text'},
			{name:'lgort',index:'lgort', width:50, sorttype:'text'},

			{name:'matnr',index:'matnr', width:100, sorttype:'text', key: true},
			{name:'maktx', index:'maktx', width:100, sorttype:'text'},
			{name:'wrkst',index:'wrkst', width:100, sorttype:'text'},
			
			{name:'menge',index:'menge', width:50, sorttype:'text'},
			{name:'meins',index:'meins', width:40, sorttype:'text'},
			
			{name:'sernr',index:'sernr', width:90, sorttype:'text', hidden:false, editable:true},
			{name:'org_remark',index:'org_remark', width:120, sorttype:'text', hidden:false, editable:true},
			{name:'org_issue_memo',index:'org_issue_memo', width:100, sorttype:'text', hidden:false},
			
			{name:'org_issue_code',index:'org_issue_code', width:120, sorttype:'text', hidden:true}			
			
		],
		rowNum:10000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 360,
		altRows: true,
		rownumbers: true,
		cellEdit:true,
	    cellsubmit : 'clientArray',
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
// 	    sortable: true,
// 	    sortname: 'matnr',
	    onCellSelect : function(rowid, selected) {
			if ( rowid != null && selected ) { 
			}
		},
	    afterEditCell: function (rowid, cellname, value, iRow, iCol) {
// 	    	console.log(rowid, cellname, value, iRow, iCol);
			//This code saves the state of the box when focus is lost in a pretty horrible
            //way, may be they will add support for this in the future
            //set up horrible hack for pressing enter when leaving cell
         
            if(cellname=='org_remark') {
	            e = jQuery.Event("keydown");
	            e.keyCode = $.ui.keyCode.ENTER;
	            //get the edited thing
	            edit = $(".edit-cell > *");
	            edit.blur(function() {	
	                edit.trigger(e);
	            });
            }	    	
    	},
		loadComplete : function(data) {
		}
	});
}

function sernr_enter(text){
	if(text.value.length > 8) {
		sernrInputMng();
		$("#btnArea").show();
	} else {
		fnMessageModalAlert("Notification(MES)", "바코드 길이는 8자리 이상이어야 합니다.<br/>입력값 : " + $('#fsa_project_no').val());
		$('#fsa_project_no').val("");
    } 
}

function prodEndChk() {
	console.log('prodEndChk()');
	var page_url = "/frontend/prod/prod_end_chk";			
	var postData =	'routing_no=' + encodeURIComponent(selected_routing_no);

	var chk_result;
	
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200")
			{
				chk_result = data.result;
			} else
			{
				fnMessageModalAlert("Notification(MES)",	"현재 실적의 라우팅 정보에서 생산종료확인 데이터를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "현재 실적의 라우팅 정보에서 생산종료확인 데이터를 가져오지 못했습니다.");
		},
		complete : function() {
		}
	});
	
	 if(chk_result == 'Y') {
		 return true;
	 } else {
		 return false;
	 } 
}

function toSapProdIn() {
	console.log('toSapProdIn()');
	
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selData = $("#grid_ready").jqGrid('getRowData', selKey);
	
	var page_url = "/sap_master/ziffm_mes_pp008";			
	var postData = "funcName=" + encodeURIComponent("ZIFFM_MES_PP008");	
	postData +=	'&pordno=' + encodeURIComponent(selData.pordno);
	postData +=	'&pordno_pop=' + encodeURIComponent(selData.pordno_pop);
	postData +=	'&routing_no=' + encodeURIComponent(routing_no);

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200"){
				
			} else {
				fnMessageModalAlert("Notification(MES)",	"SAP 생산실적 전송을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "SAP 생산실적 전송을 실패했습니다.");
		},
		complete : function() {}
	});
}

function toSapProdData() {
	console.log('toSapProdData()');	
	
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selData = $("#grid_ready").jqGrid('getRowData', selKey);
	
	var page_url = "/sap_master/ziffm_mes_pp006";			
	var postData = "funcName=" + encodeURIComponent("ZIFFM_MES_PP006");	
	postData +=	'&pordno=' + encodeURIComponent(selData.pordno);
	postData +=	'&pordno_pop=' + encodeURIComponent(selData.pordno_pop);
	postData +=	'&routing_no=' + encodeURIComponent(selData.routing_no);
	postData +=	'&dept_cd=' + encodeURIComponent(dept_cd);
	postData +=	'&wkctr=' + encodeURIComponent(selData.wkctr);
	
	console.log(selData.pordno, selData.pordno_pop, selData.routing_no, dept_cd, selData.wkctr);
	
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200")
			{	
			} else
			{
				fnMessageModalAlert("Notification(MES)",	"SAP 생산실적 전송을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "SAP 생산실적 전송을 실패했습니다.");
		},
		complete : function() {
		}
	});
}

function t1Chk() {
	var res_data;
	var rtn_data = false;

	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selData = $("#grid_ready").jqGrid('getRowData', selKey);
	
	//T1이 공정 중간에 있을때..
	var page_url = "/frontend/prod/pop_prod_select"
	var postData = "pordno=" + encodeURIComponent(selData.pordno);
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200")
			{
				res_data = data.rows;
			} else
			{
				fnMessageModalAlert("Notification(MES)",	"현재 실적의 공정관리테이블의 데이터를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)",	"현재 실적의 공정관리테이블의 데이터를 가져오지 못했습니다.");
		},
		complete : function() {
		}
	});
	
	console.log(res_data);
	for(var i=0 ;i<res_data.length; i++) {
		if(res_data[i].routing_code == 'T1' && i!=0) {
			if(res_data[i-1].pdsts == "p6" && res_data[i].pdsts != "p6") {
				rtn_data = true;
			} 
		}
	}
	console.log("rtn_data :: " + rtn_data);
	return rtn_data;
	
}

function toMesLastInspec() {
	
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selData = $("#grid_ready").jqGrid('getRowData', selKey);
	
	var page_url = "/frontend/prod/lastInspec_insert";			
	var postData = 'pordno=' + encodeURIComponent(selData.pordno);	

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
// 				console.log(data);
			} else {
				fnMessageModalAlert("Notification(MES)",	"SAP 생산실적 전송을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "SAP 생산실적 전송을 실패했습니다.");
		},
		complete : function() {
		}
	});
}
</script>

</body>
</html>
