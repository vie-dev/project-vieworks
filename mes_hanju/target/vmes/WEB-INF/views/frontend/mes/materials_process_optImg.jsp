<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
String member_id = SessionUtil.getMemberId(request);
String s_member_nm = SessionUtil.getMemberNm(request);
String s_member_emp_no = SessionUtil.getMemberEmpNo(request);

//jsp properties
String thema = SessionUtil.getProperties("mes.thema");
String pageTitle = SessionUtil.getProperties("mes.company");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title> <%=pageTitle %> </title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
	<jsp:include page="/common/header_inc" flush="true"> 
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</head>

<body class="hold-transition skin-<%=thema%> sidebar-mini">
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
				MES <small>공정진행처리(광영상)</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> MES</a></li>
				<li class="active">공정진행처리(광영상)</li>
			</ol>
		</section>
		<section class="content" style="padding-bottom: 0px;">
			<div class="row">
				<div class="box-body">
				<!-- 	<form id="info" name="info" class="form-horizontal"> -->
						<div class="form-group">
							<label for="jo_nm" class="col-lg-2 control-label" style="font-size: 20px;">Log In 작업자 Line 정보</label>
								<div class="col-lg-4">
									<div id="jo_nm" name="jo_nm" style="margin-top:7px;font-size: 20px;">-</div>
								</div>
							<label for="member_nm" class="col-lg-2 control-label" style="font-size: 20px;">세팅된 작업자</label>
								<div class="col-lg-4">
									<div id="member_nm" name="member_nm" style="margin-top:7px;font-size: 20px;">-</div>
								</div>
						</div>
					</form>
			<!-- 	</div> -->
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="box" style="margin-bottom: 0px;">
						<div class="box-header with-border">
							<h3 class="box-title">작업 목록</h3>
							<div class="box-tools pull-right">
								<div class="box-tools pull-right">
									<button type="button" id="btn_g_fault_proc" class="btn bg-maroon btn-sm" onClick="g_fault_proc();">
										자재불량처리
									</button>
									<button type="button" class="btn btn-info btn-sm" onclick="drwDownload('drw');">
										도면 다운로드
									</button>
									<button type="button" class="btn btn-info btn-sm" onclick="drwDownload('ord');">
										작업표준서 다운로드
									</button>
									<button type="button" class="btn btn-primary btn-sm" onclick="selfInspModal();">
										자주검사
									</button>
									<button type="button" class="btn btn-success btn-sm" aria-label="Left Align" onclick="searchGridReady();">
										새로고침
									</button>
									<button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_ready');" data-selfilepath="/upload" data-selfilename="test.xlsx">
								    	<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
									</button>
								</div>
							</div>
						</div>
						<div id="dv_grid_ready" class="box-body">
							<table id="grid_ready"></table>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="box box-success" style="margin-bottom: 0px;">
						<div class="box-header with-border">
							<h3 class="box-title">작업 선택 및 이력 확인</h3>
							<div class="box-tools pull-right">
							<!-- 	<button type="button" class="btn btn-block btn-success" onclick="prodOperateHisSelec();">공정이력확인</button>
							 --></div>
						</div>
						<div class="box-body">
							<div class="row" style="margin-bottom: 10px;">
	  							<!-- <div class="col-sm-6"><button type="button" class="btn btn-block bg-black" onclick="bigSerialInsert();" style="height:70px;font-size: 20px;">대표시리얼 등록</button></div> -->
	  							<div class="col-sm-6"><button type="button" class="btn btn-block bg-navy" onclick="popUpDetailSerial();" style="height:50px;font-size: 20px;">공정운영처리</button></div>
	  							<div class="col-sm-6"><button type="button" class="btn btn-block bg-black" onclick="prodOperateHisSelec();" style="height:50px;font-size: 20px;">공정이력확인 </button></div>
							</div>
							<div class="row" style="margin-bottom: 10px;">
								<div class="col-sm-6"><button type="button" class="btn btn-block btn-primary" id="btn_p3" onclick="fnClickWorkStart();" style="height:50px;font-size: 20px;">작업시작</button></div>
								<div class="col-sm-6"><button type="button" class="btn btn-block btn-danger"  id="btn_p6" onclick="grade_chk();" style="height:50px;font-size: 20px;">작업종료</button></div>
							</div>
							<div class="row" style="margin-bottom: 10px;">
								<div class="col-sm-6"><button type="button" class="btn btn-block bg-teal"  id="btn_p4" onclick="chnStatus('p4');" style="height:50px;font-size: 20px;">비가동시작</button></div>
								<div class="col-sm-6"><button type="button" class="btn btn-block bg-maroon"  id="btn_p5" onclick="chnStatus('p5');" style="height:50px;font-size: 20px;">비가동종료</button></div>
							</div>
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
							<button type="button" id="btn_worker_add" class="btn btn-success btn-sm" onclick="chnStatus('p3');">작업시작</button>
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
<!-- 								<div> -->
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
							<label for="mes_po" class="col-sm-3 control-label">추가 작업자</label>
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


<!-- ************************자재출고 등록관리 : Start ************************-->
<div class="modal fade" id="modal_detail_serial_add" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" id="mainclose" class="close" data-dismiss="modal" onclick="mainclose();"  aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">공정운영처리</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="box box-warning box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">시리얼등록</h3>
					 	
						<div class="box-tools pull-right">
				 	        <button type="button" id="btn_bigSerialInsert"  class="btn bg-black btn-sm" onclick="bigSerialInsert();">대표시리얼 등록</button>
					    	<button type="button" id="btn_pord_fault" class="btn btn-danger btn-sm" onClick="pordFaultProc();">공정불량처리</button>							
							<button type="button" id="btn_fault_matnr_save" class="btn btn-primary btn-sm" onclick="fnFaultMatnrConf();">불량처리</button>
							<button type="button" id="btn_detail_serial_save" class="btn btn-success btn-sm" onclick="fnSaveDetailSerial();">등록</button>
						</div>
					</div>
					<form id="frm_detail_serial" name="frm_detail_serial" class="form-horizontal">
					<div class="box-body">
						<div class="form-group">
							<label for="mes_po" class="col-sm-3 control-label">MES지시번호</label>
							<div class="col-sm-9">
								<input type="input" id="m_dsa_mes_po" name="pordno_pop" class="form-control input-sm"  maxlength="20" readonly="readonly">
								<input type="hidden" id="m_dept_cd" name="m_dept_cd" class="form-control">
							</div>
						</div>
						<div class="form-group">
							<label for="mes_po" class="col-sm-3 control-label">라우팅번호</label>
							<div class="col-sm-9">
								<input type="input" id="m_dsa_routing_no" name="m_dsa_routing_no" class="form-control input-sm"  maxlength="20" readonly="readonly">
								<input type="hidden" id="m_dsa_routing_gno" name="m_dsa_routing_gno" class="form-control"  maxlength="20" readonly="readonly">
							</div>
						</div>
						<div class="form-group">
							<label for="mes_po" class="col-sm-3 control-label">메인 시리얼</label>
							<div class="col-sm-9">
								<input type="input" id="m_dsa_project_no" name="project_no" class="form-control input-sm"  maxlength="20" readonly="readonly">
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
											<button type="button" id="btn_batch_proc" class="btn btn-danger btn-sm" onClick="addItnbrBatch();">일괄투입</button>
											<button type="button" id="" class="btn btn-warning btn-sm" onclick="addItnbrDetail();">
								               <i class="fa fa-forward" aria-hidden="true"></i></button>
										</div>
									</div>
									<div id="dv_grid_itnbrlist" class="box-body">
										<table id="grid_itnbrlist"></table>
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
				<h4 class="modal-title" id="modal_code_title">시리얼입력</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
	            <form id="frm_serial_add" name="frm_serial_add" class="form-horizontal">
					
	                <div class="form-group input_2">
						<label for="" class="col-sm-3 control-label">창고</label>
						<div class="col-sm-9">
<!-- 							<input type="input"  id="fsa_loc" name="fsa_loc" class="form-control"  maxlength="20" > -->
							<select id="fsa_loc" class="form-control select2 fsa_loc">
							</select> 
						</div>
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
								<select id="sel_step1" class="form-control select2 input-sm" onChange="changeStep($(this).val(),'step1');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-2">
								<label for="m_lv1" class="col-sm-2 control-label">Lv.01</label>
								<select id="sel_step2" class="form-control select2 input-sm" onChange="changeStep($(this).val(),'step2');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-2">
								<label for="m_lv2" class="col-sm-2 control-label">Lv.02</label>
								<select id="sel_step3" class="form-control select2 input-sm" onChange="changeStep($(this).val(),'step3');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-3">
								<label for="m_lv3" class="col-sm-2 control-label">Lv.03</label>
								<select id="sel_step4" class="form-control select2 input-sm">
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

<!-- ************************공정이력확인 : Start ************************-->
  <div class="modal fade" id="operate_his" data-backdrop="static">
    <div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">공정이력확인</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
			<div class="box box-warning box-solid">
			<div class="box-header with-border">
						<h3 class="box-title">공정이력조회</h3>
						<div class="box-tools pull-right" style="padding-top: 3px;">
									<button type="button" class="btn btn-success btn-xs" aria-label="Left Align" onclick="fnSearchOperateHisGrid();">
										<i class="fa fa-refresh" aria-hidden="true"></i>
									</button>
								</div>
					</div>
<!-- 					<div class="col-sm-12 text-right" style="font-weight:bold; color:red;"> -->
<!-- 							<i class="fa fa-check" aria-hidden="true"></i> <span id="warningTxt">광영상 오더는 작업자 정보를 등록해야 합니다.</span> -->
<!-- 					</div> -->
			<div class="modal-body" id="modal_code_body">
						<div class="box-body">				
			            <form id="frm_operate_his" name="frm_operate_his" class="form-horizontal">
						
						<div class="row">
						<table id="grid_operate_his"></table>
						</div>

						</form>
						</div>
	        </div>
	        </div>
	        </div>
		</div>
	</div>
</div>
<!-- ************************공정이력확인 : End ************************-->

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
							<button type="button" id="btn_main_serial_save" class="btn btn-success btn-sm" onclick="fnSaveMainSerial();" >
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
									<input type="input" id="m_serial_no" name="project_no" class="form-control" maxlength="100"  >
								</div>
							</div>           
						</div>
					</form>
				</div><!-- end box -->
			</div><!-- end modal body -->
		</div><!-- end modal content -->
	</div><!-- end modal dialog -->
</div><!-- end modal area2 -->
<!-- 자주검사  -->
<div class="modal fade" id="modal_selfInsp" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">자주검사</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12">
						<div id="grid_selfInsp_header" style="width: 100%; height: 300px;"></div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-10"></div>
					<div class="col-md-2">
						<select id="self_insp_routing" class="form-control select2 input-sm" style="margin-top: 10px;" onChange="showSelfInspGrid();"></select>
					</div>
				</div>
				<div class="row" style="height:400px;overflow-y: auto;overflow-x: hidden;">
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-12" id="grid_p1_area" style="margin-top: 10px;">
								<div id="grid_p1" style="width: 100%; height: 400px;"></div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12" id="grid_p2_area" style="margin-top: 10px;">
								<div id="grid_p2" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12" id="grid_p5_area" style="margin-top: 10px;">
								<div id="grid_p5" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12" id="grid_t1_area" style="margin-top: 10px;">
								<div id="grid_t1" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
					</div>
				</div>
			</div><!-- end modal body -->
			<div class="modal-footer">
				<div class="text-center">
			        <button type="button" class="btn btn-sm btn-primary" onclick="saveSelfInsp();">저장</button>
			        <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">닫기</button>
		        </div>
			</div>
		</div><!-- end modal-content -->
	</div><!-- end modal dialog -->
</div><!-- end modal div -->

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
<script type="text/javascript">

var jocod = "";
var login_user_dept_cd = "";

var addItnbrArr = [];
var itnbrArr = [];
var matArr = [];
var member_id = '<%=member_id%>';
var s_member_nm = '<%=s_member_nm%>';
var s_member_emp_no = '<%=s_member_emp_no%>';

var gnrFaultMantrFlag='';
var gridReadySelect_idx = '';
var dept_cd = '1210';
var searchMatCode = '';
// var readyKey = '';
// var addMatObj = {};

var member_nm = '';
var member_emp_no = '';
var member_cnt = '';


$(function($) {
	initComponent();
	init_g_MaterialGrid();
})

function initComponent() {
// 	console.info('initComponent()');

	$(window).bind('resize', function() {
		resizeJqGrid("grid_ready", false);
	}).trigger('resize');
	
	$('input[type="radio"].flat-red').iCheck({
		checkboxClass : 'icheckbox_flat-green',
		radioClass : 'iradio_flat-green',
		handle : 'radio'
	});
	

	initScreenSizeModal();
    
	fnLoadUserInfo();
	gridReadyGen();
	fnLoadWorkerAddGrid();
	initItnbrGrid();
	initNewItnbrGrid();
	fnLoadFaultListGrid();
	initMaterialGrid();
	fnLoadProdFaultListGrid();
	fnLoadOperateHisGrid();
	// selfInsp
	initGridSelgInspHeader();
	initGridP1();
	initGridP2();
	initGridP5();
	initGridT1();
	
	fnLoadGradeMngGrid();
	fnLoadFaultRoutingListGrid();
}

function fnLoadUserInfo() {
	var page_url = "/frontend/prod/prodUserInfo"
		 + "?member_id=" + encodeURIComponent(member_id);

	$.ajax({
		url : page_url,
		async: false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				if( Number(data.rows.length)>0 ) {
					var names = "";
					var member_ids = "";
					login_user_dept_cd = data.rows[0].dept_cd;
					jocod = data.rows[0].jocod;
					$("#jo_nm").html(data.rows[0].line_nm + " - " + data.rows[0].jo_nm);
					for(var i=0 ;i<data.rows.length; i++) {
						names = names + data.rows[i].member_nm + ",";
						member_ids = member_ids + data.rows[i].member_id + ",";
						
					}
					names = names.substring(0, names.length-1);
					member_ids = member_ids.substring(0, member_ids.length-1);
					
					$("#member_nm").html(names);
					
					member_nm = names;
					member_emp_no = member_ids;
					member_cnt = data.rows.length;
// 					console.log("member_nm ::  " + member_nm + " //  member_emp_no ::  " + member_emp_no + " //  member_cnt ::  " + member_cnt + " //  jocod ::  "  + jocod);
				} else {
					$("#jo_nm").html("-");
					$("#member_nm").html("-");
					login_user_dept_cd = dept_cd;
				}
				$("#jo_nm").css('color', 'blue');
				$("#member_nm").css('color', 'blue');
			} else {
				fnMessageModalAlert("Notification(MES)", "사용자 정보를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "사용자 정보를 가져오지 못했습니다.");
		},
		complete : function() {}
	});
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
// 	console.info('gridReadyGen()');
	var page_url = "/frontend/mes/selectProdOrdUserIng_opt"
		 		 + "?jocod=" + encodeURIComponent(jocod)
				+ "&dept_cd=" + encodeURIComponent(login_user_dept_cd);
	$("#grid_ready").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['P/O', '확정일', '확정순번', '요구등급', '라인정보', '작업자', 'PORDNO_POP', 'PORDNO_SEQ', 'CUSTOMER_NM', '제품명', '제품내역', '공정그룹명', 'S/N',
		           'JIDAT', 'auart', 'lgort', '수량', 'wkctr', '현재공정', 'routng_code','pdsts','진행상태', '다음공정', 'first_routing_no', 'sernp', 'next_routing'],
		colModel:[
			{name : 'pordno', index : 'pordno', sorttype:'text', sortable:true, key:true, width:50},
			{name : 'cmdat', index : 'cmdat', sorttype:'text', sortable:true, width:50},
			{name : 'cmdat_seq', index : 'cmdat_seq', sorttype:'text', sortable:true, align : 'center', width:50},
			{name : 'zgrade', index : 'zgrade', sorttype:'text', sortable:true, align : 'center', width:50},
			{name : 'jocod', index : 'jocod', sorttype:'text', sortable:true, align : 'center', width:50},
			{name : 'member_nm', index : 'member_nm', sorttype:'text', sortable:true, align : 'center', width:50},
			{name : 'pordno_pop', index : 'pordno_pop', sorttype:'text', sortable:true, hidden:true},
			{name : 'pordno_seq', index : 'pordno_seq', sorttype:'text', sortable:true, hidden:true},
			{name : 'customer_nm', index : 'customer_nm', sorttype:'text', sortable:true, hidden:true},
			{name : 'itnbr', index : 'itnbr', sorttype:'text', sortable:true, width:100},
			{name : 'pordno_status', index : 'pordno_status', sorttype:'text', sortable:true, width:150},
			{name : 'routing_nm', index : 'routing_nm', sorttype:'text', sortable:true, hidden:true},
			{name : 'project_no', index : 'project_no', sorttype:'text', width:100},
			{name : 'jidat', index : 'jidat', sorttype:'text', hidden:true},
			{name : 'auart', index : 'auart', sorttype:'text', hidden:true},
			{name : 'lgort', index : 'lgort', sorttype:'text', hidden:true}, 
			{name : 'pdqty', index : 'pdqty', sorttype:'text', align : 'center', width:50},
			{name : 'wkctr', index : 'wkctr', sorttype:'text', hidden:true},
			{name : 'routing_code', index : 'routing_code', sorttype:'text', sortable:true, width:100},
			{name : 'routing_no', index : 'routing_no', sorttype:'text', sortable:true, hidden:true},
			{name : 'pdsts', index : 'pdsts', sorttype:'text', hidden:true},
			{name : 'pdsts_nm', index : 'pdsts_nm', sorttype:'text', width:100},
			{name : 'next_routing_code', index : 'next_routing_code', sorttype:'text', sortable:true, width:100},
			{name : 'first_routing_no', index : 'first_routing_no', sorttype:'text', sortable:true, hidden:true},
			{name : 'sernp', index : 'sernp', sorttype:'text', sortable:true, hidden:true},
			{name : 'next_routing', index : 'next_routing', sorttype:'text', sortable:true, hidden:true},
			],
		rowNum:1000,
	    height: 400,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 20,
	    autoencode: true,
	    loadonce: true,
	    sortable: true,
	    sortname: 'pordno',
	    multiselect : true,
	    loadComplete : function(data){},
		onSelectRow: function(key) {
			if(key != null) {
				var rowData = $("#grid_ready").jqGrid('getRowData', key);
				gridReadySelect_idx = $("#grid_ready").jqGrid('getInd', key);
				var selData = $("#grid_ready").getRowData(key);
				if(selData.routing_code == 'T1') {
					$("#btn_p3").attr('disabled', 'disabled');
					$("#btn_p4").attr('disabled', 'disabled');
					$("#btn_p5").attr('disabled', 'disabled');
					$("#btn_p6").attr('disabled', 'disabled');
					fnMessageModalAlert("확인하세요.", "T1 공정은 최종검사화면에서 처리해야합니다.");
				}
				var selData = $("#grid_ready").getRowData(key);
				if( selData.auart=='ZP01' || selData.auart=='ZP05' )
					searchMatCode = 'basic';
				else	// ZP02, ZP03, ZP04
					searchMatCode = 'mat';
			}					
		},
		afterInsertRow:function(rowid, rowdata, rowelem){
// 			console.log(rowdata);
// 			if( rowdata.pdsts=='p8' ) { // 대기  green
// 				$("tr.jqgrow#"+rowid).css("color","#0FA60F");
// 			} else if( rowdata.pdsts=='p9' ) {	// 합격 blue
// 				$("tr.jqgrow#"+rowid).css("color","#0F18A6");
// 			} else if( rowdata.pdsts=='p10' ) { // 불합격 red
// 				$("tr.jqgrow#"+rowid).css("color","#A6190F");
// 			}
		}
	});
}

//공정 그룹 목록 조회
function searchGridReady() {
// 	console.log('searchGridReady()');
	var page_url = "/frontend/mes/selectProdOrdUserIng_opt"
				 + "?jocod=" + encodeURIComponent(jocod)
				 + "&dept_cd=" + encodeURIComponent(login_user_dept_cd);
	
	$("#grid_ready").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_ready").trigger("reloadGrid");
}

// 공정 완료 목록 조회 :: 사용 X ... 컨트롤러에서 판단하게 뺐음..
function searchGridHis() {
// 	console.log('searchGridHis()');
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selectedData = $("#grid_ready").getRowData(selKey);
	var r_data;
	var page_url = "/frontend/prod/pop_prod_his_select"
		 + "?pordno_pop=" + encodeURIComponent(selectedData.pordno_pop)
		 + "&routing_no=" + encodeURIComponent(selectedData.routing_no);
	$.ajax({
		url : page_url,
		async: false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				r_data = data.rows;
			} else {
				fnMessageModalAlert("Notification(MES)", "선택된 생산지시내역을 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "선택된 생산지시내역을 가져오지 못했습니다.");
		},
		complete : function() {}
	});
	return r_data;
}

// 대표 시리얼 등록
function bigSerialInsert() {
// 	console.info('bigSerialInsert()');
	var selKey = $("#grid_ready").jqGrid('getGridParam', 'selarrrow');
	if (selKey.length > 1) {
		fnMessageModalAlert("Notification(MES)", "한개의 오더만 선택해주세요.");
		return;
	} else if(selKey.length == 0) {
		fnMessageModalAlert("Notification(MES)", "선택된 생산지시오더가 없습니다.");
		return;
	}
	var selectedData = $("#grid_ready").getRowData(selKey[0]);
	if (selectedData == {}) {
		fnMessageModalAlert("Notification(MES)", "등록하고자 하는 선택된 작업이 없습니다.");
		return;
	}
	$("#m_sap_po").val(selectedData.pordno);
	$("#m_jidat").val(selectedData.jidat);
	$("#m_serial_no").val($("#m_dsa_project_no").val());
	$("#modal_main_serial_add").modal('show');
	$('#modal_main_serial_add').on('shown.bs.modal', function () {
		setTimeout(function (){
	        $('#m_serial_no').focus();
	    }, 500);
	})
}

// 공정운영처리 닫기 이벤트
function mainclose() {
	console.info('mainclose()');
// 	searchGridReady();
}

function projectNoDupChk() {
	var ser_no = $("#m_serial_no").val();
	var page_url = "/frontend/prod/projectNoDupChk";
	var postData = "project_no=" +  encodeURIComponent(ser_no);
	var rtn = 0;
	$.ajax({
		url : page_url,
		data : postData,
		async:false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				rtn = data.cnt;
			} else {
				fnMessageModalAlert("Notification(SerialAdd)", "생산지시오더의 시리얼 등록 내역 조회에 실패했습니다.");
				return;
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(SerialAdd)", "생산지시오더의 시리얼 등록 내역 조회에 실패했습니다.");
			return;
		},
		complete : function() {}
	});
	return rtn;
}

function fnSaveMainSerial() {
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selData = $("#grid_ready").jqGrid('getRowData', selKey);
// 	console.log("시리얼 :: " + $("#m_serial_no").val().length);
	if($("#m_serial_no").val().length == '0') {
		fnMessageModalAlert("Notification(MES)", "시리얼 번호를 입력해주세요.");
		return;
	}	
	var ser_no = $("#m_serial_no").val();
	if(projectNoDupChk() == 0) {
		fnMessageModalConfirm("Notification", "선택된 지시번호( " + selData.pordno + " )에 등록요청하신 시리얼번호( " + ser_no +  " )를 등록합니다.<br/>"
				+ "계속 진행하시겠습니까?", function(chk){
				if(chk){
					saveMainSerial();
				}
			});
	} else {
		fnMessageModalConfirm("Notification", "선택된 지시번호( " + selData.pordno + " )에 등록요청하신 시리얼번호( " + ser_no +  " )는 <font color='red'>이미 등록되어있습니다.</font><br/>"
				+ "계속 진행하시겠습니까?", function(chk){
				if(chk){
					saveMainSerial();
				}
			});
	}
	
	
}
function saveMainSerial() {
// 	console.info('fnSaveMainSerial()');
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
		async:false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200" && data.result=="S") {
				fnMessageModalAlert("Notification(SerialAdd)", "선택된 생산지시오더 시리얼등록을 성공했습니다.");
				$("#m_dsa_project_no").val($("#m_serial_no").val());
			} else {
				fnMessageModalAlert("Notification(SerialAdd)", "선택된 생산지시오더 시리얼등록을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(SerialAdd)", "선택된 생산지시오더 시리얼등록 중 오류가 발생하였습니다.");
		},
		complete : function() {
			$("#modal_main_serial_add").modal('hide');
		}
	});
	
	searchGridReady();
}

//공정투입자재 grid data select
function loadNewItnbrGridData() {
//  	console.info('loadNewItnbrGridData()');
	var rtn_data = [];
 	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
 	var selectedData = $("#grid_ready").getRowData(selKey);
 	var page_url = "/frontend/prod/selectSernrManageTbl"
 				 + "?pordno_pop=" + encodeURIComponent(selectedData.pordno_pop)
 				 + "&routing_no=" + encodeURIComponent(selectedData.routing_no);

 	$.ajax({
		url : page_url,
		async:false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				rtn_data = data.rows;
			} else {
				fnMessageModalAlert("Notification(MES)", "투입자재내역을 가져오는데 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "투입자재내역을 가져오는데 실패했습니다.");
		},
		loadComplete : function(data) {},
		complete : function() {}
	});
	return rtn_data;
}

//공정투입자재 grid generate
function reloadNewItnbrGrid() {
//  	console.info('reloadNewItnbrGrid()');
	var rtn_data = [];
 	$("#grid_addItnbr_list").jqGrid('clearGridData');
 	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
 	var selectedData = $("#grid_ready").getRowData(selKey);
 	var page_url = "/frontend/prod/selectSernrManageTbl"
 				 + "?pordno_pop=" + encodeURIComponent(selectedData.pordno_pop)
 				 + "&routing_no=" + encodeURIComponent(selectedData.routing_no);
 	$("#grid_addItnbr_list").jqGrid('setGridParam', { 
 		url : page_url, 
 		datatype : 'json',
 		ajaxGridOptions : { async:false },
 		loadComplete : function(data) {
 			rtn_data = data.rows;
 			addItnbrData = rtn_data;
 		} 		
 	});
 	$("#grid_addItnbr_list").trigger("reloadGrid");

 	return rtn_data;
}

//공정투입자재 grid generate
function initNewItnbrGrid() {
//   	console.log('initNewItnbrGrid()');
	$("#grid_addItnbr_list").jqGrid('clearGridData');
	$("#grid_addItnbr_list").trigger("reloadGrid");
	var selGridRowData = $("#grid_ready").getRowData($('#grid_ready').jqGrid('getGridParam','selrow'));
	$("#grid_addItnbr_list").jqGrid({
// 		url:page_url,
		datatype: 'json',
		colNames:['자재', '자재내역', '저장위치','소요량','단위', '일련번호', '예약품목번호', '생산오더번호','sernp','pordno_pop', 'uni_key', 'sernr_seq', 'kzumw'],
		colModel:[
			{name:'matnr',index:'matnr', width:80, sorttype:'text', sortable:true},
			{name:'maktx',index:'maktx', width:80, sorttype:'text', sortable:true, hidden:false},
			{name:'lgort',index:'lgort', width:40, sorttype:'text', sortable:true, sortable:true, hidden:false},
			{name:'bdmng', index:'bdmng', width:50, sorttype:'text', sortable:true, editable:true},
			{name:'meins',index:'meins', width:30, sorttype:'text', sortable:true, sortable:true},
			{name:'sernr',index:'sernr', width:90, sorttype:'text', sortable:true, hidden:false, editable:true},
			{name:'rspos',index:'rspos', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'aufnr',index:'aufnr', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'sernp',index:'sernp', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'pordno_pop',index:'pordno_pop', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'uni_key',index:'uni_key', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true, key: true},
			{name:'sernr_seq',index:'sernr_seq', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'kzumw',index:'kzumw', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
		],
		rowNum: 1000,
		viewrecords : true,
// 	    autowidth : true,
	    shrinkToFit: false, 
	    multiselect : true,
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
			
			$("#grid_addItnbr_list").setColProp('bdmng',{editable:true});
			$("#grid_addItnbr_list").setColProp('sernr',{editable:true});
			if(idx ==5 || idx ==7) {
				if(rowId.substring(0,3) != 'jqg') {
					$("#grid_addItnbr_list").setColProp('bdmng',{editable:false});
					if(rowData.sernp == 'V001') {
						$("#grid_addItnbr_list").setColProp('sernr',{editable:false});
					}
					else {
						$("#grid_addItnbr_list").setColProp('sernr',{editable:false});
					}
				}
				//$("#grid_addItnbr_list").setColProp('bdmng',{editable:true});
			}
			if(idx ==4) {
		    	if( rowData.uni_key.length == 0){
		    		    		
		    		if(rowData.kzumw == 'Y') {
		    			getStrList('mst03');
		    		} else {
		    			initOptions($('#fsa_loc'));
		    			
		    			$('#fsa_loc').append($('<option>', { 
					        value: rowData.lgort,
					        text : rowData.lgort 
					    }));
		    		}
// 			    	$('#scanner_serial_add').modal('show');
		    	}
			}
	    },
		afterEditCell: function (rowid, cellname, value, iRow, iCol) {
// 	    	console.log(rowid, cellname, value, iRow, iCol);
	    	 if( cellname=='bdmng' || cellname=='sernr'){
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
			console.log("@@@");
			console.log(addItnbrData);
		}
	});
// 	$("#grid_addItnbr_list").trigger("reloadGrid");	
}

function initItnbrGrid() {
// 	console.info('initItnbrGrid()');
	$('#grid_itnbrlist').jqGrid({
		datatype: 'json',
		colNames:['자재','자재내역', '소요량','단위','등급관리','일련번호 프로파일', '예약품목번호', '생산오더번호', 'lgort', '투입필요수량'],
		colModel:[
			{name:'matnr',index:'matnr', width:100, sorttype:'text', sortable:true, key: true},
			{name:'maktx',index:'maktx', width:100, sorttype:'text', sortable:true},
			{name:'bdmng', index:'bdmng', width:50, sorttype:'text', sortable:true},
			{name:'meins',index:'meins', width:50, sorttype:'text', sortable:true, sortable:true},
			{name:'kzumw',index:'kzumw', width:30, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'sernp',index:'sernp', width:40, sorttype:'text', sortable:true, hidden:false},
			{name:'rspos',index:'rspos', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'aufnr',index:'aufnr', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'lgort',index:'lgort', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'remain_bdmng',index:'remain_bdmng', width:30, sorttype:'text', sortable:true, sortable:true}
		],
		rowNum:10000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : true,
	    height: 400,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    onSelectRow : function(rowid, selected) {
// 			if ( rowid != null && selected ) { 
// 				var rowInfo = $("#grid_itnbrlist").getRowData(rowid);
// 				addMatObj = rowInfo;
// 			}
		},
		loadComplete : function(data) {}
	});
	$("#grid_itnbrlist").trigger("reloadGrid", [{current:true}]); 
}

function materialSearch() {
// 	console.log('materialSearch()');
	var page_url = '/frontend/hub/material_recv_master_select'
		 		 + '?matnr=' + encodeURIComponent($("#m_matnr").val())
		 		 + '&werks=' + encodeURIComponent(dept_cd)
		 		 + '&wrkst=' + encodeURIComponent($("#m_wrkst").val())
		 		 + '&maktx=' + encodeURIComponent($("#m_maktx").val());
	$("#grid_materiallist").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_materiallist").setGridParam({ page: 1 }).trigger("reloadGrid");
// 	$("#grid_materiallist").trigger("reloadGrid");
	
	$("#modal_mat_search").modal('hide');
}

function initMaterialGrid() {
	var page_url = '/frontend/hub/material_recv_master_select'
		+"?werks=" + encodeURIComponent(dept_cd);
	$('#grid_materiallist').jqGrid({
		url:page_url,
		datatype: 'json',
		colNames:['자재코드','자재내역',' Spec.','등급구분', '제품군명', '자재그룹명', '생성일자', '수정일자', '단위', 'lgpro', 'sernp'],
		colModel:[
			{name:'matnr',index:'matnr', width:110, sorttype:'text', sortable:true, key:true},
			{name:'maktx',index:'maktx', width:110, sorttype:'text', sortable:true},
			{name:'wrkst',index:'wrkst', width:110, sorttype:'text', sortable:true},
			{name:'kzumw',index:'kzumw', width:40, sorttype:'text', sortable:true, hidden:true},
			{name:'vtext',index:'vtext', sorttype:'text', sortable:true, hidden:true},
			{name:'wgbez',index:'wgbez', sorttype:'text', sortable:true, hidden:true},
			{name:'date_created',index:'date_created', width:40, sorttype:'text', sortable:true, hidden:true},
			{name:'date_updated',index:'date_updated', width:40, sorttype:'text', sortable:true, hidden:true},
			{name:'meins',index:'meins', width:40, hidden:false},
			{name:'lgpro',index:'lgpro', hidden:true},
			{name:'sernp',index:'sernp', hidden:true},
		],
		pager : '#grid_materiallist_pager',
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : true,
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
// 			if ( rowid != null && selected ) { 
// 				var matRowInfo = $("#grid_materiallist").getRowData(rowid);
// 				addMatObj.matnr = matRowInfo.matnr;
// 				addMatObj.bdmng = 1;
// 				addMatObj.meins = matRowInfo.meins;
// 				addMatObj.sernp = matRowInfo.sernp;
// 				addMatObj.rspos = '';
// 				addMatObj.aufnr = '';
// 				addMatObj.lgort = getFromLgort();
// 				addMatObj.kzumw = matRowInfo.kzumw;
				
// 			}
		},
		loadComplete : function(data) {
		}
	});
}

function changeMatGubun() {
// 	console.log('changeMatGubun()')
	$("#grid_materiallist").jqGrid('clearGridData');
	$("#grid_itnbrlist").jqGrid('clearGridData');;
	var s_Key = $("#grid_ready").jqGrid('getGridParam', 'selarrrow');
	var rowData = $("#grid_ready").getRowData(s_Key);
	var s_ItnbrData;
	if( $("#gubun").val()=='basic' ){
		var page_url = "/sap_master/ziffm_mes_pp004"
			 + "?func_name=" + encodeURIComponent("ZIFFM_MES_PP004")
			 + "&IV_AUFNR=" + encodeURIComponent(rowData.pordno)
			 + "&IV_IF=X";
		
		$("#grid_itnbrlist").jqGrid('setGridParam', { 
			url : page_url, 
			datatype : 'json',
			ajaxGridOptions : { async:false },
			loadComplete : function(data) 
			{
				s_ItnbrData = data.rows;
			}
		});
		$("#grid_itnbrlist").trigger("reloadGrid");
		
		in_remain_cnt(s_ItnbrData, loadNewItnbrGridData());
		
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

//itnbr move to newlist
function addItnbrDetail() {
// 	console.log('addItnbrDetail()');
	// 추가하려는 목록이 선택 되었는가?
	var fromLgort = getFromLgort();
	var gridDatas = [];
	var flag = 0;
	if($("#gubun").val() == 'basic') {
		var grid_itnbrlist_keys = $("#grid_itnbrlist").jqGrid('getGridParam', 'selarrrow');
		for(var i=0 ; i<grid_itnbrlist_keys.length; i++) {
			gridDatas.push($("#grid_itnbrlist").getRowData(grid_itnbrlist_keys[i]));
		}	
	} else {
		var grid_materiallist_keys = $("#grid_materiallist").jqGrid('getGridParam', 'selarrrow');
		for(var i=0 ; i<grid_materiallist_keys.length; i++) {
			var tmpObj = $("#grid_materiallist").getRowData(grid_materiallist_keys[i]);
			tmpObj.lgort = fromLgort;
			gridDatas.push(tmpObj);
		}	
	}
	
	var grid_addItnbr_list_Datas = $('#grid_addItnbr_list').jqGrid('getRowData');
	var gridDataArr = [];
	
	for(var i=0 ; i<grid_addItnbr_list_Datas.length; i++) {
		gridDataArr.push(grid_addItnbr_list_Datas[i]);
	}
	
	///////////////시리얼 자재 투입 수량 validation : start///////////////
	for(var p=0 ; p<gridDatas.length; p++) {
		var addMatObj = gridDatas[p];
		if(addMatObj.sernp == 'V001') {
			var s_cnt = Number(sernrCntChk(addMatObj.matnr));
			var n_cnt = Number(addMatObj.bdmng);
			var cnt = 0;
			for(var i=0 ; i<gridDataArr.length ; i++) {
				if(gridDataArr[i].matnr == addMatObj.matnr && gridDataArr[i].sernr_seq.length == 0) {
					cnt++;
				}		
			}
			//cnt		: 투입 대기 자재 수량(아직 투입은 안됐고 오른쪽 그리드로 당겨놓은 상태) + 투입 된 자재 수량
			//s_cnt	: 투입 된 자재 수량
			//n_cnt	: 소요자재 수량
// 			console.log("cnt ::" + cnt);
			
			if($("#gubun").val() == 'basic') {
				if((s_cnt + cnt) == n_cnt) {
					flag++;
				} 
			} 
		}
	}
		
	if(flag > 0) {
		fnMessageModalAlert("Notification(MES)", "해당 자재는 이미 소요량에 맞게 투입됐습니다. <br/>더 이상 해당 자재 투입이 불가합니다.");
		return;
	}
	///////////////시리얼 자재 투입 수량 validation :   end///////////////
	
	for(var p=0 ; p<gridDatas.length; p++) {
		var addMatObj = gridDatas[p];

		if(addMatObj.sernp == 'V001') {				
			addMatObj.bdmng = '1';
		} else {
			if($("#gubun").val() == 'mat') {
				addMatObj.bdmng = "1";
			} else {
				addMatObj.bdmng = addMatObj.remain_bdmng;	
			}
		}
		
		if(addMatObj.kzumw == 'Y') {
			addMatObj.lgort = '';
		}
			
// 			dataArr.push(addMatObj);
			
		if(addMatObj.sernp == 'V001') {
			$("#grid_addItnbr_list").setColProp('sernr',{editable:true});	
		} else {
			$("#grid_addItnbr_list").setColProp('sernr',{editable:false});
		}
		
		$("#grid_addItnbr_list").setColProp('bdmng',{editable:true});
		
		if(addMatObj.sernp == 'V001') {
			if($("#gubun").val() == 'basic') {
				for(var i=0 ; i<Number(addMatObj.remain_bdmng); i++) {
					$("#grid_addItnbr_list").jqGrid('addRow',{position  :"last", initdata  : addMatObj, cellEdit:false});
				}
			} else {
				$("#grid_addItnbr_list").jqGrid('addRow',{position  :"last", initdata  : addMatObj, cellEdit:false});
			}
		} else {
			$("#grid_addItnbr_list").jqGrid('addRow',{position  :"last", initdata  : addMatObj, cellEdit:false});
		}

	}
	$("#grid_itnbrlist").jqGrid("resetSelection");
	$("#grid_materiallist").jqGrid("resetSelection");
}

function selectPoLgort() {
	var rst_lgort ="";
	var pordno = $("#grid_ready").getRowData($("#grid_ready").getGridParam('selrow')).pordno;
	var page_url = "/frontend/prod/sap_prod_select";
	var postData = "pordno=" + encodeURIComponent(pordno);
	
	$.ajax({
		url : page_url,
		data : postData,
		async:false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				rst_lgort = data.rows[0].lgort;
			} else {
				fnMessageModalAlert("Notification(SerialAdd)", "선택된 내역의 창고위치를 가져오는데 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(SerialAdd)", "선택된 내역의 창고위치를 가져오는데 실패했습니다.");
		},
		loadComplete : function(data) {},
		complete : function() {}
	});
	return rst_lgort;
}

function sernrCntChk(matnr) {
	var data_length =0; 
	var page_url = "/frontend/prod/sernrCntChk";
	var postData = "pordno_pop=" + encodeURIComponent($("#m_dsa_mes_po").val())
				 + "&matnr=" + encodeURIComponent(matnr);
	$.ajax({
		url : page_url,
		data : postData,
		async:false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				data_length = data.rows.length
			} else {
				fnMessageModalAlert("Notification(SerialAdd)", "선택된 내역의 등록 수량을 가져오는데 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(SerialAdd)", "선택된 내역의 등록 수량을 가져오는데 실패했습니다.");
		},
		loadComplete : function(data) {},
		complete : function() {}
	});
	return data_length;
}

//remove new itnbr list
function deleteItnbrDetail() {
	var grid_addItnbr_list_keys = $("#grid_addItnbr_list").jqGrid('getGridParam', 'selarrrow');
	var keys = [];
	for(var i=0 ; i<grid_addItnbr_list_keys.length; i++) {
		keys.push(grid_addItnbr_list_keys[i]);
	}
	
	for(var i=0 ; i<keys.length; i++) {
		$("#grid_addItnbr_list").jqGrid('delRowData', keys[i]);
	}	
}

function fnSaveDetailSerial() {
// 	console.log('fnSaveDetailSerial()');
// 	console.log($("#m_dept_cd").val());
	
	$("#grid_addItnbr_list").jqGrid('setGridParam', {cellEdit: false});
	
		
	var rfcData = $("#grid_addItnbr_list").jqGrid('getRowData');
	var keyArr = $('#grid_addItnbr_list').jqGrid('getDataIDs');
	
// 	for(var i=0 ; i<rfcData.length; i++) {
// 		if(rfcData[i].lgort.length == 0) {
// 			fnMessageModalAlert("Notification(MES)", "투입 요청 자재의 저장위치를 설정해주세요.");
// 			$("#grid_addItnbr_list").jqGrid('setGridParam', {cellEdit: true});
// 			return;
// 		} 
// 	}		

	for(var idx=0; idx<rfcData.length; idx++){
		if(keyArr[idx].substring(0,3) == 'jqg') {
			var sernr =  $('#'+keyArr[idx]+'_sernr').val();
			var bdmng =  $('#'+keyArr[idx]+'_bdmng').val();
			if(sernr == undefined) {
				rfcData[idx].sernr = '';
			} else {
				
				if(sernr.length == 0) {
					fnMessageModalAlert("Notification(MES)", "시리얼 대상 자재에 시리얼이 입력되지 않았습니다.<br>시리얼을 입력해주세요.");
					return;
				} else {
					var loc = sernr_stock_chk('1210', rfcData[idx].matnr, sernr);
					
					if(rfcData[idx].lgort.length == 0) {
						if(Number(bdmng) < 0) {
							rfcData[idx].lgort = selectPoLgort();
						}else if(loc.length == 0) {
							fnMessageModalAlert("Notification(MES)",	"입력하신 시리얼은 등급창고에 재고가 없어 투입이 불가합니다.<br>확인해주세요.");
							return;
						} else {
							rfcData[idx].lgort = loc;	
						}
					}
				}
				rfcData[idx].sernr = sernr;	
			}
			
			rfcData[idx].bdmng = bdmng;
		} 
	}

	
	$("#grid_addItnbr_list").jqGrid('setGridParam', {cellEdit: true});
	
	var frmData = $("#frm_detail_serial").serializeArray();
	var s_Key = $("#grid_ready").jqGrid('getGridParam', 'selarrrow');
	var selectedData = $("#grid_ready").getRowData(s_Key);
	var page_url = "/frontend/prod/detail_serial_add_opt";
	var postData = "pordno_pop=" + encodeURIComponent(selectedData.pordno_pop)
				 + "&routing_no=" + encodeURIComponent(selectedData.first_routing_no)
				 + "&routing_gno=" + encodeURIComponent($("#m_dsa_routing_gno").val())
				 + "&project_no=" + encodeURIComponent($("#m_dsa_project_no").val()) //메인 시리얼번호
				 + "&dept_cd=" + encodeURIComponent($("#m_dept_cd").val())
				 + "&lgort=" + encodeURIComponent(selectedData.lgort)
				 + "&pordno=" + encodeURIComponent((selectedData.pordno_pop).substr(0,10))
				 + "&params=" + encodeURIComponent(JSON.stringify(rfcData));
	console.log(JSON.stringify(rfcData));
	$.ajax({
		url : page_url,
		data : postData,
		async:false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.zifsta == "S") {
				fnMessageModalAlert("Notification(SerialAdd)","선택된 생산지시오더의 자재투입처리를 성공했습니다.<br>"+"SAP return : " + data.zifsta	+"<br>SAP msg : " + data.zifmsg);
			} else {
				fnMessageModalAlert("Notification(SerialAdd)", "선택된 생산지시오더의 자재투입처리를 실패했습니다.<br>"+"SAP return : " + data.zifsta	+"<br>SAP msg : " + data.zifmsg);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(SerialAdd)", "선택된 생산지시오더의 자재투입처리를 실패했습니다.");
		},
		loadComplete : function(data) {},
		complete : function() {
			$("#modal_detail_serial_add").modal('hide');
		}
	});
	searchGridReady();
}

function ordStatusChk() {
	var selKey = $("#grid_ready").jqGrid('getGridParam', 'selarrrow');
	var rtn = false;
	
	if(selKey.length == 0) {
		fnMessageModalAlert("Notification(MES)", "선택된 생산지시오더가 없습니다.");
		return;
	}
	
	var page_url = "/frontend/mes/selectProdOrdUserIng_opt"
		 + "?jocod=" + encodeURIComponent(jocod)
		+ "&dept_cd=" + encodeURIComponent(login_user_dept_cd);
	
	$.ajax({
		url : page_url,
		async:false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				for(var i=0 ; i<selKey.length; i++) {
					var selectedData = $("#grid_ready").getRowData(selKey[i]);
					for(var k=0 ;k<data.rows.length; k++) {
						if(selectedData.pordno == data.rows[k].pordno) {
							if((selectedData.routing_no != data.rows[k].routing_no) ||(selectedData.pdsts != data.rows[k].pdsts)) {
								rtn = true;
							}
						} 
					}
				}
			} else {
				fnMessageModalAlert("Notification(MES)", "생산지시오더 조회에 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "생산지시오더 조회에 실패했습니다.");
		},
		complete : function() {}
	});
	return rtn;
}

function chnStatus(pdsts) {
	var rtn = ordStatusChk();
	if(rtn) {
		fnMessageModalAlert("Notification(MES)", "선택된 오더의 현재 상태가 조회시점과 달라졌습니다. <br/>확인 후 다시 처리해주세요.");
		searchGridReady();
		return;
	}
	/////////////////////////////////////////
	
	
	if ($('#grid_ready').jqGrid('getGridParam','selrow') == '') {
		fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더 없습니다.");
		return;
	}
	
// 	var popOrdData = $("#grid_ready").getRowData($('#grid_ready').jqGrid('getGridParam','selrow'));
	
	var rowData = $("#grid_ready").getRowData();
	
	
	var project_no_yn = "Y";
	var add_itnbr_yn = "Y";

	var selKey = $("#grid_ready").jqGrid('getGridParam', 'selarrrow');

 	for(var i=0 ; i<selKey.length; i++) {
 		
 		var popOrdData  = $("#grid_ready").getRowData(selKey[i]);
 		
		var pEndChk = prodEndChk(popOrdData.routing_no);	//생산실적전송라우팅인지 확인..
			
		if( pdsts == 'p6' ) {	
			if( pEndChk ) {			
				if(popOrdData.project_no==null || popOrdData.project_no==undefined || popOrdData.project_no=='') {
					project_no_yn = "N";
					if(popOrdData.sernp == "V001") {
						fnMessageModalAlert("Notification(MES)", "해당 오더는 대표시리얼 등록이 반드시 필요한 오더입니다.<br>대표시리얼 등록 후 다시 진행해주세요.");
						return;
					}
				} 
				if ( !chkAddItnbrExist(popOrdData.pordno_pop) ) {
					add_itnbr_yn = "N";
				} 
			}
		}
 	}
	var text = '';
	if(project_no_yn == "N") {
		text += " * 대표시리얼이 입력되지 않은 오더가 있습니다.<br>";
	}
	
	if(add_itnbr_yn == "N") {
		text += " * 자재투입이 되지 않은 오더가 있습니다.<br>";
	}
	/////////////////////////////////////////
		fnMessageModalConfirm("Notification", text + "선택 작업을 처리하시겠습니까?", function(chk){
		if(chk){
			fnChnStatus(pdsts);
		}
	});
}

function fnChnStatus(pdsts) {
	var rtn_result;
	var selKey = $("#grid_ready").jqGrid('getGridParam', 'selarrrow');
	if(ordRoutingChk() == false) {
		fnMessageModalAlert("Notification(MES)", "선택된 생산지시오더에 T1 - 최종검사 공정이 포함되어 있습니다." + 
				"<br/>최종검사 공정은 최종검사 화면에서 처리해야합니다.");
		return;
	}
	if(ordPdstsChk() == false )	return;

	
	
// 	for(var i=0 ; i<selKey.length; i++) {
// 		var selectedData = $("#grid_ready").getRowData(selKey[i]);
// 		if(prodEndChk(selectedData.routing_no)) {

// 			if(selectedData.project_no.length == 0) {
// 				fnMessageModalAlert("Notification(MES)", "대표시리얼 번호를 등록하셔야 합니다.<br>해당 작업진행은 취소됩니다." );
// 				return;
// 			}
// 			if(!chkAddItnbrExist(selectedData.pordno + '0010')) {
// 				fnMessageModalAlert("Notification(MES)", "공정 투입자재 등록이 되지 않았습니다.<br>우측 상단의 공정운영처리에서 공정투입자재를 등록하기 바랍니다.<br>해당 작업진행은 취소됩니다." );
// 				return;
// 			}
// 		}
		
// 	}
	
	
	
	
	for(var i=0 ; i<selKey.length; i++) {
		
		var selectedData = $("#grid_ready").getRowData(selKey[i]);
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
			async: false,
			success : function(data, textStatus, jqXHR) {
				if (data.status == "200") {
					rtn_result = data.rtn_msg;
 					fnMessageModalAlert("Notification(MES)", data.rtn_msg);
 					console.log("data.status_change_yn :: " + data.status_change_yn);
					if(data.status_change_yn == 'N') {
// 						console.log("데이터 변동 없음..")
						return;
					} else {
						if(pdsts == 'p3') {
							fnWorkerAdd();
						}
					}
					/********************생산 완료 시 sap로 실적 전송 : Start*******************/
					if(pdsts == 'p6') {
// 						console.log("prodEndChk() ::: "  + prodEndChk());
						if(prodEndChk(selectedData.routing_no)) {//routing_header_master의 routng_plast_gubun 값... 현재 라우팅이 생산종료 단계인지 체크
// 							console.log("생산실적처리");
							toSapProdIn(selectedData.pordno, selectedData.pordno_pop, selectedData.routing_no);					//생산입고 rfc (ZIFFM_MES_PP008) 실행
							toSapProdData(selectedData.pordno, selectedData.pordno_pop, selectedData.routing_no, selectedData.wkctr);		
						}
						if(t1Chk(selectedData.pordno))	{	// 다음 공정이 T1 인지 체크..T1이면 최종검사테이블 insert
// 							console.log("toMesLastInspec();    // 최종검사!!!!");
							toMesLastInspec(selectedData.pordno);	
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
			complete : function() {}
		});

	}

	$("#modal_worker_add").modal('hide');
	$("#grade_mng").modal('hide');	
	searchGridReady();
	fnMessageModalAlert("Notification(MES)", rtn_result);
}

// 작업시작버튼 눌렀을 때...
function fnClickWorkStart(){

	var selKey = $("#grid_ready").jqGrid('getGridParam', 'selarrrow');
	if(selKey.length == 0) {
		fnMessageModalAlert("Notification(MES)", "선택된 생산지시오더가 없습니다.");
		return;
	}
	
	if(ordPdstsChk() == false)	return;
	if(ordRoutingChk() == false) {
		fnMessageModalAlert("Notification(MES)", "선택된 생산지시오더에 T1 - 최종검사 공정이 포함되어 있습니다." + 
				"<br/>최종검사 공정은 최종검사 화면에서 처리해야합니다.");
		return;
	}
	var pordno_pops = "";
	var routing_nos = "";
	var gridRowData;
	
	// 시작버튼 정보  popup 
	for(var i=0 ;i<selKey.length; i++) {
		gridRowData = $("#grid_ready").getRowData(selKey[i]);

		pordno_pops = pordno_pops + gridRowData.pordno_pop + ", ";
		routing_nos = routing_nos + gridRowData.routing_no + ", ";
	}
	pordno_pops = pordno_pops.substring(0, pordno_pops.length-2); 
	routing_nos = routing_nos.substring(0, routing_nos.length-2);

	$('#m_worker_mes_po').val(pordno_pops);
	$('#m_routing_no').val(routing_nos);
	
	
	
	
	$("#login_user").val(s_member_nm);
	fnSearchWorkerAddGrid();
	$("#modal_worker_add").modal('show');
}

//btn action 작업시작 버튼
function fnWorkerAdd() {
// 	console.log('fnWorkerAdd()');
// 	if(ordPdstsChk() == false)	return;

	var gridData = $('#grid_worker').jqGrid('getRowData');
	
	var fwa_member_emp_no = s_member_emp_no + ',';
	var fwa_member_nm= s_member_nm + ',';
	
	var member_cnt = 1; 
	
	for (var i = 0; i < gridData.length; i++) {
		if (gridData[i].chk == 'Y') {
			fwa_member_emp_no = fwa_member_emp_no + gridData[i].member_emp_no + ',';
			fwa_member_nm= fwa_member_nm + gridData[i].member_nm + ',';
			member_cnt++;
		}
	}
	
	fwa_member_emp_no = fwa_member_emp_no.substring(0, fwa_member_emp_no.length-1);
	fwa_member_nm = fwa_member_nm.substring(0, fwa_member_nm.length-1);
	
	var selKey = $("#grid_ready").jqGrid('getGridParam', 'selarrrow');
	if(selKey.length == 0) {
		fnMessageModalAlert("Notification(MES)", "선택된 생산지시오더가 없습니다.");
		return;
	}
	for(var i=0 ; i<selKey.length; i++) {
		var selectedData = $("#grid_ready").getRowData(selKey[i]);
		var postData = $("#frm_worker_add").serializeArray();
		var page_url = "/frontend/prod/worker_update";
		var postData = "pordno_pop=" + encodeURIComponent(selectedData.pordno_pop)
					 + "&routing_no=" + encodeURIComponent(selectedData.routing_no)
					 + "&member_emp_no=" + encodeURIComponent(fwa_member_emp_no)
					 + "&member_nm=" + encodeURIComponent(fwa_member_nm)
					 + "&member_cnt=" + encodeURIComponent(member_cnt)
					 + "&jocod=" + encodeURIComponent(jocod);
		// 작업자 등록
		$.ajax({
			url : page_url,
			data : postData,
			async:false,
			type : "POST",
			success : function(data, textStatus, jqXHR) {
				if (data.status == "200") {
					//if ( data.returnMsg=='Already registered' ){
					//	fnMessageModalAlert("Notification(fnWorkerAdd)", "이미 등록된 작업자가 존재합니다.");
					//}
				} else {
					fnMessageModalAlert("Notification(fnWorkerAdd)", "작업자 등록에 실패했습니다.");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("Notification(fnWorkerAdd)", "작업자 등록에 실패했습니다.");
			},
			complete : function() {
// 				$("#modal_worker_add").modal('hide');
			}
		});
	}
	
}

function fnSearchWorkerAddGrid() {
	var page_url = "/frontend/prod/jo_worker_select";
	page_url += "?jocod="+ jocod;
	page_url += "&member_id="+ member_id;
	
	$("#grid_worker").jqGrid('setGridParam', { url : page_url, datatype : 'json' });
	$("#grid_worker").trigger("reloadGrid");
}

//modal : employee list generate
function fnLoadWorkerAddGrid() {
// 	console.log('fnLoadWorkerAddGrid()');
	var pordno_pop;
	
	var page_url = "/frontend/prod/jo_worker_select";
	page_url += "?jocod="+ jocod;
	page_url += "&member_id="+ member_id;
	$("#grid_worker").jqGrid({
		url : page_url,
		datatype : "json",
		colNames : [ '','사원번호', 'ID','사원명','구분' ],
		colModel : [ 
			{name : 'chk', index : 'chk', width : 20, editable : true, align : 'center', edittype : 'checkbox',
				multiselect : false,
				editoptions : { value : "Y:N", defaultValue : "false"},
				formatter : "checkbox",
				formatoptions : { disabled : false}}, 
			{name : 'member_emp_no', index : 'member_emp_no', width : 80, sorttype : "text", sortable : true}, 
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

// 컨트롤러 단에서 처리해주는걸로 바꿔서 사용하지 않고 있음...
function workStatusChk() {
// 	console.log('workStatusChk()');
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selectedData = $("#grid_ready").getRowData(selKey);
	if(selectedData.routing_code == 'T1')	return;
	var r_data = searchGridHis();
	
	$("#btn_p3").attr('disabled', 'disabled');
	$("#btn_p4").attr('disabled', 'disabled');
	$("#btn_p5").attr('disabled', 'disabled');
	$("#btn_p6").attr('disabled', 'disabled');
	
	if (r_data.length == 0) {
		//작업시작
		$("#btn_p3").removeAttr('disabled');
	} else if (r_data[r_data.length - 1].start_dt_tm != "") {
		//비가동시작, 작업종료
		$("#btn_p4").removeAttr('disabled');
		$("#btn_p6").removeAttr('disabled');
	} else if (r_data[r_data.length - 1].pause_start_dt_tm != "") {
		//비가동종료			
		$("#btn_p5").removeAttr('disabled');
	} else if (r_data[r_data.length - 1].pause_end_dt_tm != "") {
		//비가동시작, 작업종료
		$("#btn_p4").removeAttr('disabled');
		$("#btn_p6").removeAttr('disabled');
	} else if (r_data[r_data.length - 1].end_dt_tm != "") {
		//작업끝!!!! 다 가림
	}
}

function popUpDetailSerial() {
// 	console.log('popUpDetailSerial()');
	faultMatrArr = [];
	addItnbrArr	 = [];
	itnbrArr  = [];
	matArr = [];
	
	var selKey = $("#grid_ready").jqGrid('getGridParam', 'selarrrow');
	if (selKey.length > 1) {
		fnMessageModalAlert("Notification(MES)", "한개의 오더만 선택해주세요.");
		return;
	} else if(selKey.length == 0) {
		fnMessageModalAlert("Notification(MES)", "선택된 생산지시오더가 없습니다.");
		return;
	}
	var rowData = $("#grid_ready").getRowData(selKey[0]);
	$('#grid_itnbrlist').jqGrid('clearGridData');
	$("#grid_addItnbr_list").jqGrid('clearGridData');
	
 	var addItnbr_data = reloadNewItnbrGrid();
 	
	$("#gubun").val(searchMatCode);		
	if( searchMatCode=='basic' ){
		var page_url = "/sap_master/ziffm_mes_pp004"
			 + "?func_name=" + encodeURIComponent("ZIFFM_MES_PP004")
			 + "&IV_AUFNR=" + encodeURIComponent(rowData.pordno)
			 + "&IV_IF=X";
		
		$("#grid_itnbrlist").jqGrid('setGridParam', { 
			url : page_url, 
			datatype : 'json',
			ajaxGridOptions : { async:false },
			loadComplete : function(data) 
			{
				ItnbrData = data.rows;
			}
		});
		$("#grid_itnbrlist").trigger("reloadGrid");

		in_remain_cnt(ItnbrData, addItnbr_data);
		
		$("#dv_grid_itnbrlist").show();
		$("#dv_grid_materiallist").hide();
		$("#matSearch").hide();		
	} else {	// mat
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

	getStrList('mst03');
	$("#modal_detail_serial_add").modal('show');
}

var addItnbrArr = [];
var itnbrArr = [];
var matArr = [];
function makeFaultMatnrArr(obj) {
// 	console.log($(obj)[0].checked);
// 	console.log($(obj));
	var jObj = {};
	jObj.matnr = $($($(obj).parent()).siblings()[1]).text();
	jObj.bdmng = $($($(obj).parent()).siblings()[2]).text();
	jObj.meins = $($($(obj).parent()).siblings()[3]).text();
	jObj.gubun = $(obj)[0].className;	

	
	if(jObj.gubun == 'itnbr') {
		jObj.bdmng =  $($($(obj).parent()).siblings()[3]).text();
	}
	
	
	console.log($($($(obj).parent()).siblings()[1]).text());
	console.log($($($(obj).parent()).siblings()[2]).text());
	console.log($($($(obj).parent()).siblings()[3]).text());
	console.log($($($(obj).parent()).siblings()[4]).text());
	console.log($($($(obj).parent()).siblings()[5]).text());
	
	if(jObj.gubun == "itnbr") {
		jObj.lgort = $('#grid_itnbrlist').getRowData(jObj.matnr).lgort;	
	} else if(jObj.gubun == "mat")  {
		jObj.lgort = $('#grid_materiallist').getRowData(jObj.matnr).lgpro;
	}
	var flag = true;
	if( jObj.gubun=='add_itnbr' ) {
		for(var i=0 ; i<addItnbrArr.length; i++) {
			if(addItnbrArr[i].matnr == jObj.matnr) {
				addItnbrArr.splice(i,1);
				flag = false;		
			} 
		}
		if(flag == true)	addItnbrArr.push(jObj);	
	} else if( jObj.gubun=='itnbr' ) {
		for(var i=0 ; i<itnbrArr.length; i++) {
			if(itnbrArr[i].matnr == jObj.matnr) {
				itnbrArr.splice(i,1);
				flag = false;		
			} 
		}
		if(flag == true)	itnbrArr.push(jObj);
	} else if( jObj.gubun=='mat' ) {
		for(var i=0 ; i<matArr.length; i++) {
			if(matArr[i].matnr == jObj.matnr) {
				matArr.splice(i,1);
				flag = false;		
			} 
		}
		if(flag == true)	matArr.push(jObj);
	}	
}

function getFromLgort() {
// 	console.log('getFromLgort()');
	
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selectedData = $("#grid_ready").getRowData(selKey);
	
	var page_url = "/frontend/prod/mes_wkctr_tbl_select"	
			 + "?dept_cd=" + encodeURIComponent(dept_cd)
			 + "&wkctr=" + encodeURIComponent(selectedData.wkctr);
	var returnWkctr = '';
	$.ajax({
		url : page_url,
		type : "POST",
		async : false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200" && (data.rows).length>0) {
				returnWkctr = (data.rows)[0].lgort;
			} else {
				fnMessageModalAlert("Fail", "데이터를 불러오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Fail", "데이터를 불러오지 못했습니다.");
		}
	});	
	return returnWkctr;
}

var addItnbrData;
var ItnbrData;
function fnFaultMatnrConf() {
// 	console.log('fnFaultMatnrConf()');
	$('.h_flag').show();
	gnrFaultMantrFlag = 's';
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selectedData = $("#grid_ready").getRowData(selKey);
	
	$("#grid_fault_list").jqGrid('clearGridData');

	var uniqMatnrArr = []; 
	var totalMatnrArr = []; 
	
	var grid_materiallist_keyArr = $("#grid_materiallist").getGridParam('selarrrow');  
	var grid_itnbrlist_keyArr = $("#grid_itnbrlist").getGridParam('selarrrow');    
	var grid_addItnbr_list_keyArr = $("#grid_addItnbr_list").getGridParam('selarrrow');
		
	var grid_materiallist_length = $("#grid_materiallist").getGridParam('selarrrow').length;  
	var grid_itnbrlist_length = $("#grid_itnbrlist").getGridParam('selarrrow').length;    
	var grid_addItnbr_list_length = $("#grid_addItnbr_list").getGridParam('selarrrow').length;  
	
	var grid_materiallist_selcData = [];  
	var grid_itnbrlist_selcData = [];    
	var grid_addItnbr_list_selcData = [];
	
	if(Number(grid_materiallist_length) + Number(grid_itnbrlist_length) + Number(grid_addItnbr_list_length) == 0) {
		fnMessageModalAlert("Notification(MES)", "체크 된 데이터가 없습니다.");
		return;
	}

	for(var i=0 ; i<grid_materiallist_keyArr.length; i++) {
		var tmp_obj = $("#grid_materiallist").getRowData(grid_materiallist_keyArr[i])
		tmp_obj.gubun = "mat"
		grid_materiallist_selcData.push(tmp_obj);
		totalMatnrArr.push(tmp_obj.matnr);
	}
	for(var i=0 ; i<grid_itnbrlist_keyArr.length; i++) {
		var tmp_obj = $("#grid_itnbrlist").getRowData(grid_itnbrlist_keyArr[i])
		tmp_obj.gubun = "itnbr"
		grid_itnbrlist_selcData.push(tmp_obj);
		totalMatnrArr.push(tmp_obj.matnr);
	}
	for(var i=0 ; i<grid_addItnbr_list_keyArr.length; i++) {
		var tmp_obj = $("#grid_addItnbr_list").getRowData(grid_addItnbr_list_keyArr[i])
		
		 if(tmp_obj.sernr_seq == "") {
	    	fnMessageModalAlert("Warning", "공정투입자재 내역에 등록처리 되지 않은 자재가 있습니다.");
			return;
	    }
		
		tmp_obj.gubun = "addItnbr"
		grid_addItnbr_list_selcData.push(tmp_obj);
		totalMatnrArr.push(tmp_obj.matnr);
	}

	var uniqMatnrArr = $.unique(totalMatnrArr);
	
	$("#modal_g_fault_proc").modal('hide');	
	var fromLgort = getFromLgort();
	var itnbr_data;
	var page_url = '/frontend/hub/material_recv_master_select_nopage'	
				 + "?matnrs=" + encodeURIComponent(String(uniqMatnrArr))
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
	var grid_fault_list_data = [];
	
	$.each(grid_materiallist_selcData, function(idx, mat){
		var tmpObj = {};
		$.each(itnbr_data, function(i, obj){
			if( obj.matnr==mat.matnr ) {
				tmpObj.aufnr = selectedData.pordno;
				tmpObj.werks = dept_cd;
				tmpObj.sernp = obj.sernp;
				tmpObj.matnr = obj.matnr;
				tmpObj.maktx = obj.maktx;	
				tmpObj.wrkst = obj.wrkst;
				tmpObj.meins = obj.meins;
				tmpObj.kzumw = obj.kzumw;
				
				if(obj.kzumw == 'Y') {
					tmpObj.lgort = '';
				} else {
					if( mat.lgort=='' || mat.lgort==null ) {
						tmpObj.lgort = fromLgort;	
					} else {
						tmpObj.lgort = mat.lgort;	
					}	
				}
				
				tmpObj.menge = '1';
				tmpObj.sernr = '';
				tmpObj.sernr_seq = '';
				tmpObj.org_menge = '1';
				tmpObj.rfc_chk = 'N';
				tmpObj.gubun = mat.gubun;
				console.log(tmpObj);
				grid_fault_list_data.push(tmpObj);
			}
		});
	});
	
	$.each(grid_itnbrlist_selcData, function(idx, mat){
		var tmpObj = {};
		$.each(itnbr_data, function(i, obj){
			if( obj.matnr==mat.matnr ) {
				
				tmpObj.aufnr = selectedData.pordno;
				tmpObj.werks = dept_cd;
				tmpObj.sernp = obj.sernp;
				tmpObj.matnr = obj.matnr;
				tmpObj.maktx = obj.maktx;	
				tmpObj.wrkst = obj.wrkst;
				tmpObj.meins = obj.meins;
				tmpObj.kzumw = obj.kzumw;
				
				if(obj.kzumw == 'Y') {
					tmpObj.lgort = '';
				} else {
					if( mat.lgort=='' || mat.lgort==null ) {
						tmpObj.lgort = fromLgort;	
					} else {
						tmpObj.lgort = mat.lgort;	
					}	
				}
				
				tmpObj.menge = mat.bdmng;
				tmpObj.sernr = '';
				tmpObj.sernr_seq = '';
				tmpObj.org_menge = mat.bdmng;
				tmpObj.rfc_chk = 'N';
				tmpObj.gubun = mat.gubun;
				
				grid_fault_list_data.push(tmpObj);
			}
		});
	});
	
	$.each(grid_addItnbr_list_selcData, function(idx, mat){
		var tmpObj = {};
		$.each(itnbr_data, function(i, obj){
			if( obj.matnr==mat.matnr ) {
				
				tmpObj.aufnr = selectedData.pordno;
				tmpObj.werks = dept_cd;
				tmpObj.sernp = obj.sernp;
				tmpObj.matnr = obj.matnr;
				tmpObj.maktx = obj.maktx;	
				tmpObj.wrkst = obj.wrkst;
				tmpObj.meins = obj.meins;
				tmpObj.kzumw = obj.kzumw;
								
				if( mat.lgort=='' || mat.lgort==null ) {
					tmpObj.lgort = fromLgort;	
				} else {
					tmpObj.lgort = mat.lgort;	
				}

				tmpObj.menge = mat.bdmng;
				tmpObj.sernr = mat.sernr;
				tmpObj.sernr_seq = mat.sernr_seq
				tmpObj.org_menge = mat.bdmng;
				tmpObj.rfc_chk = "Y";
				tmpObj.gubun = mat.gubun;
				
				grid_fault_list_data.push(tmpObj);
			}
		});		
	});
	console.log(grid_fault_list_data);
	for(var i=0 ; i<grid_fault_list_data.length; i++) {
		grid_fault_list_data[i].org_menge = Math.abs(grid_fault_list_data[i].org_menge);
		grid_fault_list_data[i].menge = Math.abs(grid_fault_list_data[i].menge); 
	}
	
	$('#grid_fault_list').jqGrid('setGridParam', { datatype: 'local', data: grid_fault_list_data }).trigger('reloadGrid');

	initOptions($('#sel_step1'));
	initOptions($('#sel_step2'));
	initOptions($('#sel_step3'));
	initOptions($('#sel_step4'));
	makeSelStep1();
	
	faultRoutingProc();
	
	getStrList('mst03');	
	$("#fault_mng").modal('show');
}

function checkBarcode(text){
	if(text.value.length > 8) 	$("#btnArea").show();
// 	else 	$("#btnArea").hide();
}

function sernrInputMng() {
// 	console.log('sernrInputMng()');

	/*
	var gridRowData = $("#grid_addItnbr_list").getRowData($("#grid_addItnbr_list").getGridParam('selrow'));
	var sernr = $('#fsa_project_no').val();
	
	if( gridRowData.sernp.length > 0 && sernr.length < 8 ) {
		fnMessageModalAlert("Notification(fnSaveMainSerial)", "시리얼번호가 9자리 이하입니다.<br/>다시 입력해주세요.");
		return;
	}
	
	// duplicate check
	var duCnt = chkSerialNoDuplicate(sernr);
	if( duCnt>0 ) {
		fnMessageModalAlert("Notification(fnSaveMainSerial)", "시리얼번호가 중복된 값이 입력되었습니다.");
		return false;
	}
	
	if(sernr.length != 0)
		gridRowData.sernr = sernr;

	if($('#fsa_loc').val().length != 0)
		gridRowData.lgort = $('#fsa_loc').val();
	
	if($('#fsa_bdmng').val().length != 0)
		gridRowData.bdmng = $('#fsa_bdmng').val();

	$("#grid_addItnbr_list").setRowData($("#grid_addItnbr_list").getGridParam('selrow'), gridRowData, {});
	*/
	
	
// 	var gridRowData = $("#grid_addItnbr_list").getRowData($("#grid_addItnbr_list").getGridParam('selrow'));
	
// 	if($('#fsa_loc').val().length != 0)
// 		gridRowData.lgort = $('#fsa_loc').val();
	
// 	$("#grid_addItnbr_list").setRowData($("#grid_addItnbr_list").getGridParam('selrow'), gridRowData, {});

	$("#grid_addItnbr_list").jqGrid('setCell', $("#grid_addItnbr_list").getGridParam('selrow'), 'lgort', $('#fsa_loc').val());

	getStrList('mst03');
	$("#scanner_serial_add").modal('hide');
}

// 시리얼 중복 체크는 현재 사용하지 않음...
function chkSerialNoDuplicate(sernrNo) {
// 	console.log('chkSerialNoDuplicate(',sernrNo,')');
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
        .val();
}

var step1Val = '';
var step2Val = '';
var step3Val = '';
var step4Val = '';
function changeStep(selVal, step) {
// 	console.log('changeStep(',selVal,',',step,')');
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
	$.ajax({
	    url: page_url,
	    data: params,
	    type: "POST",
	    async : false,
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
	    		fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}

function p_changeStep(selVal, step) {
// 	console.log('changeStep(',selVal,',',step,')');
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
	$.ajax({
	    url: page_url,
	    data: params,
	    type: "POST",
	    async : false,
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
	    		fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}
	
function makeSelStep1() {
// 	console.log('makeSelStep1()');
	var page_url = "/frontend/scm/issue_getStep1";
	$.ajax({
	    url: page_url,
	    data: '',
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
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
	    		fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}

function p_makeSelStep1() {
// 	console.log('makeSelStep1()');
	var page_url = "/frontend/scm/issue_getStep1";
	$.ajax({
	    url: page_url,
	    data: '',
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
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
	    		fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}

function input_code_1() {
	var s_id = $('#grid_fault_routing_list').jqGrid('getGridParam', 'selrow');	
	
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
	$('#grid_fault_routing_list').jqGrid('setCell', s_id, 'org_issue_memo', sel_step4_t);
	$('#grid_fault_routing_list').jqGrid('setCell', s_id, 'org_issue_code', sel_step4);
}

function input_code_2() {
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

function gubunText(cellvalue, options, rowObject) {
	if (rowObject.gubun == 'addItnbr') {
		return '<span>투입자재</span>';
	} else {
		return '<span>일반자재</span>';
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
		colNames:['구분', 'gubun', '자재','자재내역','자재스펙', '저장위치', '단위', '수량', 'sernp','시리얼대상여부', '시리얼', '리버스여부', '메모', '불량내역', 'org_issue_code', 'aufnr', 'werks', 'kzumw', 'sernr_seq', 'org_menge'],
		colModel:[
			{name:'f_gubun',index:'f_gubun', width:40, sorttype:'text', formatter : gubunText},
			{name:'gubun',index:'gubun', width:40, sorttype:'text', hidden:true},
			{name:'matnr',index:'matnr', width:90, sorttype:'text'},				
			{name:'maktx', index:'maktx', width:110, sorttype:'text'},
			{name:'wrkst',index:'wrkst', width:100, sorttype:'text', sortable:true},
			{name:'lgort',index:'lgort', width:50, sorttype:'text', hidden:false},
			{name:'meins',index:'meins', width:40, sorttype:'text'},
			{name:'menge',index:'menge', width:50, sorttype:'text', hidden:false, editable:true,editype:'text', editoptions:{
				dataEvents:[
				//{type:'change', fn:function(e){alert("test1");}},   //onchange Event

				{type:'keydown', fn:function(e){                                    //keydown Event
					if(e.keyCode == 9 || e.keyCode == 13){      //Enter Key or Tab Key
						
						var selKey = $("#grid_fault_list").getGridParam('selrow')
	                	var data = $('#grid_fault_list').getRowData(selKey);
	                	var rowData = $('#grid_fault_list').getRowData();

	                	if(data.gubun == 'addItnbr' && data.sernp == 'V001') {
	                		fnMessageModalAlert("오류", "시리얼 대상 투입자재는 수량변경이 불가능합니다.");  
							var tmp = "#" + this.id;
							$(tmp).val("1.000");
							
	                		return;
	                	}
	                	
	                	if(data.sernp != 'V001') {
	                		return;
	                	}
	                	
	                	var flag =0;
	                	
	                	for(var i=0 ; i<rowData.length; i++) {
	                		if(rowData[i].gubun == 'itnbr' || rowData[i].gubun == 'mat') {
		                		if(data.matnr ==	rowData[i].matnr) {
		                			flag++;
		                		}
	                		}
	                	}
	   
	                	if(flag > 1) {
	                		fnMessageModalAlert("오류", "이미 수량 확정이 된 데이터입니다.");
							console.log(this);
							var tmp = "#" + this.id;
							$(tmp).val("1");
							
	                		return;
	                	}
		               	rowData.splice(Number(selKey)-1, 1);
		            
	                	var addMatObj = [];
	                	
	                	for(var i=0 ;i<rowData.length; i++) {
	                		var tmpObj = {};
	                		tmpObj.gubun = rowData[i].gubun;
	                		tmpObj.aufnr = rowData[i].aufnr;
		                	tmpObj.kzumw = rowData[i].kzumw; 
		                	tmpObj.lgort = rowData[i].lgort;
		                	tmpObj.maktx = rowData[i].maktx; 
		                	tmpObj.matnr = rowData[i].matnr; 
		                	tmpObj.meins = rowData[i].meins; 
		                	tmpObj.menge = rowData[i].menge; 
		                	tmpObj.rfc_chk = rowData[i].rfc_chk;
		                	tmpObj.sernp = rowData[i].sernp; 
		                	tmpObj.sernr = rowData[i].sernr; 
		                	tmpObj.werks = rowData[i].werks; 
		                	tmpObj.wrkst = rowData[i].wrkst;
		                	tmpObj.org_menge = rowData[i].org_menge;
		                	
		                	addMatObj.push(tmpObj);
	                	}
	             
		                	
		               	var tmp = "#" + this.id;
		               	
		               	for(var i=0 ;i<Number($(tmp).val()); i++) {
		               	
			               	var tmpObj = {};
			               	tmpObj.gubun = data.gubun;
			               	tmpObj.aufnr = data.aufnr;
			               	tmpObj.kzumw = data.kzumw; 
			               	tmpObj.lgort = data.lgort;
			               	tmpObj.maktx = data.maktx; 
			               	tmpObj.matnr = data.matnr; 
			               	tmpObj.meins = data.meins; 
			               	tmpObj.menge = '1'; 
			               	tmpObj.rfc_chk = data.rfc_chk;
			               	tmpObj.sernp = data.sernp; 
			               	tmpObj.sernr = data.sernr; 
			               	tmpObj.werks = data.werks; 
			               	tmpObj.wrkst = data.wrkst; 
			               	tmpObj.org_menge = '1'; 
			               	addMatObj.push(tmpObj);
		               	}
		     
		                	$("#grid_fault_list").jqGrid('clearGridData');

// 		                	$("#grid_fault_list").jqGrid('addRow',{position  :"last", initdata  : addMatObj, cellEdit:true});
		                	$('#grid_fault_list').jqGrid('setGridParam', { datatype: 'local', data: addMatObj, cellEdit:true}).trigger('reloadGrid');
	                	}
				}	
				}]

				 }},  //editoptions 종료, 칼럼정의 종료
			{name:'sernp',index:'sernp', width:80, sorttype:'text', hidden:true},
			{name:'f_sernp',index:'f_sernp', width:100, sorttype:'text', hidden:false, formatter : jqgridHighlightFormattersernpYn},
			{name:'sernr',index:'sernr', width:100, sorttype:'text', hidden:false, editable:true},
			{name:'rfc_chk',index:'rfc_chk', width:50, sorttype:'text', hidden:true},
			{name:'org_remark',index:'org_remark', width:100, sorttype:'text', hidden:false, editable:true},
			{name:'org_issue_memo',index:'org_issue_memo', width:100, sorttype:'text', hidden:false},
			{name:'org_issue_code',index:'org_remark', width:120, sorttype:'text', hidden:true},
			{name:'aufnr',index:'aufnr', width:150, sorttype:'text', hidden:true},
			{name:'werks',index:'werks', width:150, sorttype:'text', hidden:true},
			{name:'kzumw',index:'kzumw', width:150, sorttype:'text', hidden:true},
			{name:'sernr_seq',index:'sernr_seq', width:150, sorttype:'text', hidden:true},
			{name:'org_menge',index:'org_menge', width:150, sorttype:'text', hidden:true},
		],
		rowNum:10000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
// 	    height: 360,
	    height: 200,
		altRows: true,
		rownumbers: true,
		cellEdit:true,
	    cellsubmit : 'clientArray',
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    onCellSelect : function(rowid, selected) {
			if ( rowid != null && selected ) { 
				if(selected == '4') {
					var selGridData = $("#grid_fault_list").getRowData(rowid);
					if(selGridData.kzumw =='Y') {
						$("#grade_loc_matnr").val(selGridData.matnr);
						$("#grade_loc_add").modal('show');
					}
				}	
			}
		},
		beforeEditCell: function (rowid, cellname, value, iRow, iCol){
	    	var selGridData = $("#grid_fault_list").getRowData($('#grid_fault_list').jqGrid('getGridParam','selrow'));
	    			
	    	if(cellname == 'sernr' && selGridData.sernp != 'V001') {
// 				console.log("시리얼비대상!!");
				$('#grid_item').jqGrid('setCell', rowid, 'sernr', '');
				grid.editCell(0,0,false); 
				fnMessageModalAlert("오류", "시리얼대상이 아닙니다.");
				
	    	} else {
// 				console.log("시리얼대상!!");
	    	}
	   	},
	    afterEditCell: function (rowid, cellname, value, iRow, iCol) {
	    	if(cellname == 'sernr' && selGridData.sernp != 'V001') {
	    		grid.editCell(0,0,false); 
				$('#grid_fault_list').jqGrid('setCell', rowid, 'sernr', '');	
	    	}
	    	
	    	var p_val = value;
	    	var n_val = "";
	    	
	    	console.log(rowid);
	    	console.log(cellname);
	    	console.log(value);
	    	console.log(iRow);
	    	console.log(iCol);
	    	
            if(cellname=='sernr' || cellname=='org_remark' || cellname=='menge') {
            	var selKey = $("#grid_fault_list").getGridParam('selrow')
            	e = jQuery.Event("keydown");            	
            	e.keyCode = $.ui.keyCode.ENTER;
	            	            
	            //get the edited thing
	            edit = $(".edit-cell > *");
	            edit.blur(function() {	
	            	edit.trigger(e);
	            });
            }
    	},
		loadComplete : function() {
		}
	});
}

//자재불량처리
function fnFaultConf() {
	$('#grid_fault_list').editCell(0,0,false); 
	var data = $('#grid_fault_list').getRowData();
	$('#grid_fault_list').jqGrid('setGridParam', {cellEdit: false});
	var gridDataArr = $('#grid_fault_list').jqGrid('getRowData');
	$('#grid_fault_list').jqGrid('setGridParam', {cellEdit: true});
	
	/*********************데이터 유무 확인 : Start*********************/
	if(gridDataArr.length == 0) {
		fnMessageModalAlert("Notification(MES)", "데이터가 없습니다.");
 		return;
	}
	/*********************데이터 유무 확인 : End*********************/
	
	/*********************입력 데이터 누락 확인 : Start*********************/
	
	for(var i=0 ;i<gridDataArr.length; i++) {
		if(gridDataArr[i].lgort.length == 0) {
			fnMessageModalAlert("Notification(MES)", "자재불량내역의 저장위치 항목에 데이터가 없습니다.<br/>해당 셀을 클릭해 데이터를 입력해주세요.");
	 		return;
		}
		if(gridDataArr[i].sernp == 'V001' && gridDataArr[i].sernr.length == 0) {
			fnMessageModalAlert("Notification(MES)", "자재불량내역의 시리얼대상 항목에 시리얼 입력내역이 없습니다.<br/>해당 셀을 클릭해 시리얼을 입력해주세요.");
	 		return;
		}
		if(gridDataArr[i].org_issue_memo.length == 0) {
			fnMessageModalAlert("Notification(MES)", "자재불량내역이 입력되지 않았습니다.<br/>해당 셀을 선택한뒤 자재불량입력 버튼을 클릭해 불량내역을 입력해주세요.");
			$("#btn_fault_conf").removeAttr('disabled');
	 		return;
		}
		if(gridDataArr[i].gubun == 'addItnbr' && Number(gridDataArr[i].menge) > Number(gridDataArr[i].org_menge)) {
			fnMessageModalAlert("Notification(MES)", "불량처리할 수량이 투입수량보다 많은 항목이 있습니다 .<br/>수량을 확인하신 후 다시 진행해주세요.");
			$("#btn_fault_conf").removeAttr('disabled');
	 		return;
		}
	}
	
	if(gridDataArr.length == 0) {
		fnMessageModalAlert("Notification(MES)", "데이터가 없습니다.");
 		return;
	}
	/*********************입력 데이터 누락 확인 : End*********************/
	
	var jsonStr = JSON.stringify(gridDataArr);
	/********************* 데이터 insert 및 rfc 전송 : Start*********************/
	var page_url = "/frontend/prod/fnFaultConf";
	var postData = "";
	if(gnrFaultMantrFlag == 'g') {
		postData = 'jsonStr=' + encodeURIComponent(jsonStr);
		postData += '&pordno_pop=' + encodeURIComponent(null);
		postData += '&routing_no=' + encodeURIComponent(null);
		postData += '&dept_cd=' + encodeURIComponent(dept_cd);
		postData += '&t_gubun=' + encodeURIComponent("tp");
	} else {
		postData = 'jsonStr=' + encodeURIComponent(jsonStr);
		postData += '&pordno_pop=' + encodeURIComponent($('#m_dsa_mes_po').val());
		postData += '&routing_no=' + encodeURIComponent($('#m_dsa_routing_no').val());
		postData += '&dept_cd=' + encodeURIComponent(dept_cd);
		postData += '&t_gubun=' + encodeURIComponent("tp");
	}
	$.ajax({
	    url: page_url,
	    data: postData,
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		if(gnrFaultMantrFlag == 'g') {
	    			fnMessageModalAlert("Notification(MES)", "***자재 불량처리 sap 전송 결과*** <br/>e_return : : " 
	    					+ data.e_return	+ "<br/>e_message : "+ data.e_message);
	    			
	    			$("#modal_detail_serial_add").modal('hide');
					$("#grid_req_sernr").modal('hide');
					$("#fault_mng").modal('hide');
	    		} else {
	    			if(data.inFzifsta == 'S' || data.e_return == 'S') {		    		
			    		fnMessageModalConfirm("Notification(MES)", "***투입 자재 불량처리 sap 전송 결과*** <br/>e_return : : " 
		    					+ data.inFzifsta	+ "<br/>e_message : "+ data.inFzifmsg + "<br/><br/>***미투입 자재 불량처리 sap 전송 결과*** <br/>e_return : : " 
		    					+ data.e_return	+ "<br/>e_message : "+ data.e_message + "<br/><br/>공정불량처리를 계속해서 진행하시겠습니까?", function(chk) {
		    						
		    						if(chk){
		    							fnProdFaultConf_1();
		    						} else {
		    							$("#modal_detail_serial_add").modal('hide');
		    							$("#grid_req_sernr").modal('hide');
		    							$("#fault_mng").modal('hide');
		    						}
		    						
		    					});
			    		} else {
			    			fnMessageModalAlert("Notification(MES)", "***투입 자재 불량처리 sap 전송 결과*** <br/>e_return : : " 
			    					+ data.inFzifsta	+ "<br/>e_message : "+ data.inFzifmsg + "<br/><br/>***미투입 자재 불량처리 sap 전송 결과*** <br/>e_return : : " 
			    					+ data.e_return	+ "<br/>e_message : "+ data.e_message);
			    			
			    			$("#modal_detail_serial_add").modal('hide');
							$("#grid_req_sernr").modal('hide');
							$("#fault_mng").modal('hide');
			    		}
	    		}
	    	} else {
	    		fnMessageModalAlert("Notification(MES)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(MES)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
		
	/********************* 데이터 insert 및 rfc 전송 : End*********************/
}

function fnProdFaultConf_1() {
	var data = $('#grid_fault_routing_list').getRowData();
	$('#grid_fault_routing_list').jqGrid('setGridParam', {cellEdit: false});
	var gridDataArr = $('#grid_fault_routing_list').jqGrid('getRowData');
	$('#grid_fault_routing_list').jqGrid('setGridParam', {cellEdit: true});
	/*********************데이터 유무 확인 : Start*********************/
	if(gridDataArr.length == 0) {
		fnMessageModalAlert("Notification(MES)", "데이터가 없습니다.");
 		return;
	}
	/*********************데이터 유무 확인 : End*********************/
	var jsonStr = JSON.stringify(gridDataArr);
	/********************* 데이터 insert 및 rfc 전송 : Start*********************/
	var selGridRowData = $("#grid_ready").getRowData($('#grid_ready').jqGrid('getGridParam','selrow'));
	var page_url = "/frontend/prod/fnProdFaultConf";
	var postData = 'jsonStr=' + encodeURIComponent(jsonStr);
		postData += '&pordno_pop=' + encodeURIComponent(selGridRowData.pordno_pop);
		postData += '&routing_no=' + encodeURIComponent(selGridRowData.routing_no);
		postData += '&t_gubun=' + encodeURIComponent("tw");
	$.ajax({
	    url: page_url,
	    data: postData,
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		fnMessageModalAlert("Notification(MES)", "정보를 저장했습니다.");	
	    	} else {
	    		fnMessageModalAlert("Notification(MES)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(MES)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
	$("#modal_detail_serial_add").modal('hide');
	$("#grid_req_sernr").modal('hide');
	$("#fault_mng").modal('hide');
		
	searchGridReady();
	/********************* 데이터 insert 및 rfc 전송 : End*********************/
}

//공정불량처리
function fnProdFaultConf() {
	var data = $('#grid_prod_fault_list').getRowData();
	$('#grid_prod_fault_list').jqGrid('setGridParam', {cellEdit: false});
	var gridDataArr = $('#grid_prod_fault_list').jqGrid('getRowData');
	$('#grid_prod_fault_list').jqGrid('setGridParam', {cellEdit: true});
	/*********************데이터 유무 확인 : Start*********************/
	if(gridDataArr.length == 0) {
		fnMessageModalAlert("Notification(MES)", "데이터가 없습니다.");
 		return;
	}
	/*********************데이터 유무 확인 : End*********************/
	var jsonStr = JSON.stringify(gridDataArr);
	/********************* 데이터 insert 및 rfc 전송 : Start*********************/
	var selGridRowData = $("#grid_ready").getRowData($('#grid_ready').jqGrid('getGridParam','selrow'));
	var page_url = "/frontend/prod/fnProdFaultConf";
	var postData = 'jsonStr=' + encodeURIComponent(jsonStr);
		postData += '&pordno_pop=' + encodeURIComponent(selGridRowData.pordno_pop);
		postData += '&routing_no=' + encodeURIComponent(selGridRowData.routing_no);
		postData += '&t_gubun=' + encodeURIComponent("tw");
	$.ajax({
	    url: page_url,
	    data: postData,
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		fnMessageModalAlert("Notification(MES)", "정보를 저장했습니다.");	
	    	} else {
	    		fnMessageModalAlert("Notification(MES)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(MES)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
	$("#modal_detail_serial_add").modal('hide');
	$("#grid_req_sernr").modal('hide');
	$("#fault_mng").modal('hide');
		
	searchGridReady();
	/********************* 데이터 insert 및 rfc 전송 : End*********************/
}

function faultRoutingProc() {
// 	console.log('pordFaultProc()');
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selectedData = $("#grid_ready").getRowData(selKey);
	$("#grid_fault_routing_list").jqGrid('clearGridData');
	var itnbr_rows;
	var pordno = selectedData.pordno;
	var itnbr = selectedData.itnbr;
	var pdqty = selectedData.pdqty;
	var lgort = selectedData.lgort;
	var project_no = selectedData.project_no;
	
	if(itnbr.length !=0) {
		
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
		$('#grid_fault_routing_list').addRowData( 0, tmpObj, 'last');
	} else {
		var tmpObj = {};
		tmpObj.aufnr = pordno;
		tmpObj.werks = dept_cd;
		tmpObj.matnr = itnbr;
		tmpObj.maktx = '';	
		tmpObj.wrkst = '';
		tmpObj.meins = '';
		tmpObj.lgort = lgort;
		tmpObj.menge = pdqty;
		tmpObj.sernr = project_no;
		$('#grid_fault_routing_list').addRowData( 0, tmpObj, 'last');
	}

}

function pordFaultProc() {
// 	console.log('pordFaultProc()');
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selectedData = $("#grid_ready").getRowData(selKey);
	$("#grid_prod_fault_list").jqGrid('clearGridData');
	var itnbr_rows;
	var arrObj = [];
	var pordno = selectedData.pordno;
	var itnbr = selectedData.itnbr;
	var pdqty = selectedData.pdqty;
	var lgort = selectedData.lgort;
	var project_no = selectedData.project_no;
	
	if(itnbr.length !=0) {
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
	} else {
		var tmpObj = {};
		tmpObj.aufnr = pordno;
		tmpObj.werks = dept_cd;
		tmpObj.matnr = itnbr;
		tmpObj.maktx = '';
		tmpObj.wrkst =  '';
		tmpObj.meins =  '';
		tmpObj.lgort = lgort;
		tmpObj.menge = pdqty;
		tmpObj.sernr = project_no;
		arrObj.push(tmpObj);
		$('#grid_prod_fault_list').addRowData( 0, tmpObj, 'last');
	}
	
	
	
	initOptions($('#p_sel_step1'));
	initOptions($('#p_sel_step2'));
	initOptions($('#p_sel_step3'));
	initOptions($('#p_sel_step4'));
	p_makeSelStep1();
	$("#Pord_fault_mng").modal('show');
}

function input_prod_fault_code() {
// 	var s_id = $('#grid_prod_fault_list').jqGrid('getGridParam', 'selrow');
	var sel_step1 = $("#p_sel_step1").val();
	var sel_step2 = $("#p_sel_step2").val();
	var sel_step3 = $("#p_sel_step3").val();
	var sel_step4 = $("#p_sel_step4").val();
	var sel_step1_t = $("#p_sel_step1 option:selected").text();
	var sel_step2_t = $("#p_sel_step2 option:selected").text();
	var sel_step3_t = $("#p_sel_step3 option:selected").text();
	var sel_step4_t = $("#p_sel_step4 option:selected").text();
		
	if(sel_step4_t == '' || sel_step4_t == '-') {
		fnMessageModalAlert("Notification(MES)", "lv.03 까지 불량내역을 지정해주세요.");
		return;
	}
	$('#grid_prod_fault_list').jqGrid('setCell', 0, 'org_issue_memo', sel_step4_t);
	$('#grid_prod_fault_list').jqGrid('setCell', 0, 'org_issue_code', sel_step4);
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
	    onCellSelect : function(rowid, selected) {},
	    afterEditCell: function (rowid, cellname, value, iRow, iCol) {
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
		loadComplete : function(data) {}
	});
}

function fnLoadFaultRoutingListGrid() {
	$('#grid_fault_routing_list').jqGrid({
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
	    height: 200,
		altRows: true,
		rownumbers: true,
		cellEdit:true,
	    cellsubmit : 'clientArray',
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    onCellSelect : function(rowid, selected) {},
	    afterEditCell: function (rowid, cellname, value, iRow, iCol) {
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
		loadComplete : function(data) {}
	});
}


function fnSearchOperateHisGrid() {
	var selKey = $("#grid_ready").jqGrid('getGridParam', 'selarrrow');
	var selectedData = $("#grid_ready").getRowData(selKey[0]);
	var page_url = "/frontend/prod/pop_prod_his_select"
				 + "?pordno_pop=" + encodeURIComponent(selectedData.pordno_pop);
	$("#grid_operate_his").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_operate_his").trigger("reloadGrid");
}

function fnLoadOperateHisGrid() {
	$('#grid_operate_his').jqGrid({
		datatype: 'json',
		colNames:['지시번호', '라우팅이름', '라우팅code', '라우팅dscr', '작업시작','비가동시작', '비가동종료', '작업종료', 'pordno_seq'],
		colModel:[
			{name:'pordno',index:'pordno', width:80, sorttype:'text'},
			{name:'routing_nm',index:'routing_nm', width:150, sorttype:'text'},
			{name:'routing_code',index:'routing_code', width:80, sorttype:'text'},
			{name:'routing_dscr',index:'routing_dscr', width:80, sorttype:'text'},
			{name:'start_dt_tm', index:'start_dt_tm', width:120, sorttype:'text'},
			{name:'pause_start_dt_tm',index:'pause_start_dt_tm', width:120, sorttype:'text'},		
			{name:'pause_end_dt_tm',index:'pause_end_dt_tm', width:120, sorttype:'text'},
			{name:'end_dt_tm',index:'end_dt_tm', width:120, sorttype:'text'},
			{name:'pordno_seq',index:'pordno_seq', width:100, sorttype:'text', key: true, hidden:true},
		],
		rowNum:10000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 360,
		altRows: true,
		rownumbers: true,
		cellEdit:false,
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true
	});
}

function sernr_enter(text){
	if(text.value.length > 8) {
		sernrInputMng();
		$("#btnArea").show();
	} else {
		fnMessageModalAlert("Notification(MES)", "바코드 길이는 8자리 이상이어야 합니다.<br/>입력값 : " + $('#fsa_project_no').val());
    }
	$('#fsa_project_no').val("");
}

function prodEndChk(routing_no) {
// 	console.log('prodEndChk()');
	var page_url = "/frontend/prod/prod_end_chk";			
	var postData =	'routing_no=' + encodeURIComponent(routing_no);
	var chk_result;
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				chk_result = data.result;
			} else {
				fnMessageModalAlert("Notification(MES)",	"현재 실적의 라우팅 정보에서 생산종료확인 데이터를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "현재 실적의 라우팅 정보에서 생산종료확인 데이터를 가져오지 못했습니다.");
		},
		complete : function() {}
	});
	 if(chk_result == 'Y') 
		 return true;
	 else
		 return false;
}

function toSapProdIn(pordno, pordno_pop, routing_no) {
// 	console.log('toSapProdIn()');
	var page_url = "/sap_master/ziffm_mes_pp008";			
	var postData = "funcName=" + encodeURIComponent("ZIFFM_MES_PP008");	
		postData +=	'&pordno=' + encodeURIComponent(pordno);
		postData +=	'&pordno_pop=' + encodeURIComponent(pordno_pop);
		postData +=	'&routing_no=' + encodeURIComponent(routing_no);
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status != "200"){
				fnMessageModalAlert("Notification(MES)",	"SAP 생산실적 전송을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "SAP 생산실적 전송을 실패했습니다.");
		},
		complete : function() {}
	});
}

function toSapProdData(pordno, pordno_pop, routing_no, wkctr) {
// 	console.log('toSapProdData()');	
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selData = $("#grid_ready").jqGrid('getRowData', selKey);
	var page_url = "/sap_master/ziffm_mes_pp006";			
	var postData = "funcName=" + encodeURIComponent("ZIFFM_MES_PP006");	
		postData +=	'&pordno=' + encodeURIComponent(pordno);
		postData +=	'&pordno_pop=' + encodeURIComponent(pordno_pop);
		postData +=	'&routing_no=' + encodeURIComponent(routing_no);
		postData +=	'&dept_cd=' + encodeURIComponent(dept_cd);
		postData +=	'&wkctr=' + encodeURIComponent(wkctr);
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status != "200") {
				fnMessageModalAlert("Notification(MES)",	"SAP 생산실적 전송을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "SAP 생산실적 전송을 실패했습니다.");
		},
		complete : function() {}
	});
}

function t1Chk(pordno) {
	var res_data;
	var rtn_data = false;
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selrow");
	var selData = $("#grid_ready").jqGrid('getRowData', selKey);
	//T1이 공정 중간에 있을때..
	var page_url = "/frontend/prod/pop_prod_select"
	var postData = "pordno=" + encodeURIComponent(pordno);
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				res_data = data.rows;
			} else {
				fnMessageModalAlert("Notification(MES)",	"현재 실적의 공정관리테이블의 데이터를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)",	"현재 실적의 공정관리테이블의 데이터를 가져오지 못했습니다.");
		},
		complete : function() {}
	});
	for(var i=0 ;i<res_data.length; i++) {
		if(res_data[i].routing_code == 'T1' && i!=0) {
			if(res_data[i-1].pdsts == "p6" && res_data[i].pdsts != "p6") {
				rtn_data = true;
				break;
			} 
		}
	}
	return rtn_data;
}

function toMesLastInspec(pordno) {
	var page_url = "/frontend/prod/lastInspec_insert";			
	var postData = 'pordno=' + encodeURIComponent(pordno);	
	postData += '&routing_no=' + encodeURIComponent($("#grid_ready").getRowData(pordno).next_routing);
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status != "200") {
				fnMessageModalAlert("Notification(MES)",	"SAP 생산실적 전송을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "SAP 생산실적 전송을 실패했습니다.");
		},
		complete : function() {}
	});
}

function ordPdstsChk() {
	var rtn;
	var arr =  [];
	var uniqueArr = [];
	var selKey = $("#grid_ready").jqGrid('getGridParam', 'selarrrow');
	for(var i=0 ; i<selKey.length; i++) {
		var selectedData = $("#grid_ready").getRowData(selKey[i]);
		var page_url = '/frontend/prod/getProdStatus';
		var postData = 'pordno_pop=' + encodeURIComponent(selectedData.pordno_pop)
					 + '&routing_no=' + encodeURIComponent(selectedData.routing_no)
		$.ajax({
			url : page_url,
			data : postData,
			async : false,
			type : "POST",
			success : function(data, textStatus, jqXHR) {
				if(data.status == "200") {
					arr.push(data.result);
				} else {
					fnMessageModalAlert("Notification(MES)",	"선택오더의 상태값을 읽는데 실패했습니다.");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("Notification(MES)",	"선택오더의 상태값을 읽는데 실패했습니다.");
			},
			complete : function() {}
		});
	}
	
	$.each(arr, function(i, el){
		if($.inArray(el, uniqueArr) === -1) uniqueArr.push(el);
	});
	
	if(uniqueArr.length == 1) {
		rtn = true;
	} else {
		fnMessageModalAlert("Notification(MES)",	"선택오더들의 진행상태가 일치하지 않습니다."
				+ "<br/>일괄처리 시 대상오더들의 작업진행상태는 모두 동일해야합니다.");
		rtn = false;
		searchGridReady();
	}
	return rtn;
}

function ordRoutingChk() {
	var rtn = true;
	var r_data; 
	var selKey = $("#grid_ready").jqGrid('getGridParam', 'selarrrow');
	var page_url = "/frontend/mes/selectProdOrdUserIng_opt"
				+ "?jocod=" + encodeURIComponent(jocod)
				+ "&dept_cd=" + encodeURIComponent(login_user_dept_cd);
	$.ajax({
		url : page_url,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				r_data = data.rows;
			} else {
				fnMessageModalAlert("Notification(MES)",	"선택오더의 상태값을 읽는데 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)",	"선택오더의 상태값을 읽는데 실패했습니다.");
		},
		complete : function() {}
	});
	
	for(var i=0 ; i<r_data.length; i++) {
		for(var k=0 ; k<selKey.length; k++) {
			if(r_data[i].pordno == selKey[k]) {
				if(r_data[i].routing_code.substring(0,2) == 'T1') {
					rtn = false;
				}
			}
		}
	}
	return rtn;
}

function prodOperateHisSelec() {
	var selKey = $("#grid_ready").jqGrid('getGridParam', 'selarrrow');
	if (selKey.length > 1) {
		fnMessageModalAlert("Notification(MES)", "한개의 오더만 선택해주세요.");
		return;
	} else if(selKey.length == 0) {
		fnMessageModalAlert("Notification(MES)", "선택된 생산지시오더가 없습니다.");
		return;
	}
	fnSearchOperateHisGrid();
	$('#operate_his').modal('show');
}
function addItnbrBatch() {
	var batchDataArr = [];
	var gridDataArr = $('#grid_itnbrlist').jqGrid('getRowData');
	var gridAddItnbrArr = $('#grid_addItnbr_list').jqGrid('getRowData');
	
	var flag = true;
	
	for(var i=0 ; i<gridDataArr.length ; i++) {
		flag = true;
		if(gridDataArr[i].sernp != 'V001'){
			for(var k=0 ; k<gridAddItnbrArr.length ; k++) {
				if(gridAddItnbrArr[k].matnr == gridDataArr[i].matnr) {
					flag = false;
				}
			}
			if(flag) {
				if(gridDataArr[i].kzumw == 'Y') {
					gridDataArr[i].lgort = '';
				}
				batchDataArr.push(gridDataArr[i]);	
				$("#grid_addItnbr_list").setColProp('sernr',{editable:false});
				$("#grid_addItnbr_list").jqGrid('addRow',{position  :"last", initdata  : gridDataArr[i], cellEdit:true});	
			}
		}
	}
}

function selfInspModal() {
// 	console.log('selfInspModal()');
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selarrrow");
	if ( selKey.length==0 ) {
		fnMessageModalAlert("Warning", "작업목록에서 한건의 데이터를 선택하여야 합니다.");
		return;
	} else if ( selKey.length>1 ) {
		fnMessageModalAlert("Warning", "작업목록에서 한건의 데이터만 선택하여야 합니다.");
		return;
	}
	var headerCheck = loadSelfInspHeader();
	if( headerCheck ) {
// 	if( (w2ui.grid_selfInsp_header.records).length>0 ) {
		loadSelfInspDetail();
		makeSelectBox();
		$("#modal_selfInsp").modal('show');
		showSelfInspGrid();
		setTimeout(function(){
			w2ui.grid_selfInsp_header.resize();
			w2ui.grid_selfInsp_header.refresh();
			w2ui.grid_p1.resize();
			w2ui.grid_p1.refresh();
			w2ui.grid_p2.resize();
			w2ui.grid_p2.refresh();
			w2ui.grid_p5.resize();
			w2ui.grid_p5.refresh();
			w2ui.grid_t1.resize();
			w2ui.grid_t1.refresh();
		}, 200);	
	}
}


//grid_selfInsp_header
function initGridSelgInspHeader() {
// 	console.log('initGridSelgInspHeader()');
	$("#grid_selfInsp_header").w2grid({
		name : 'grid_selfInsp_header',
		header : '제품 이력카드',
		show : {
			header : true
        },
		columns :[
	        { field:'simaster_gr_no', caption:'simaster_gr_no', hidden:true},
	        { field:'siheader_seq', caption:'', hidden:true},
	        { field:'siheader_code', caption:'모델명', hidden:true},
	        { field:'display_seq', caption:'seq', hidden:true},
	        { field:'main_name', caption:'대분류', size:'20%', style:'text-align:center'},
	        { field:'sub_name', caption:'소분류', size:'40%', style:'text-align:center'},
	        { field:'item_value', caption:'입력란', size:'40%', sortable:true, editable: { type: 'text'}}
	        ],
		records: [],
		recordHeight : 30,
		total : 0
	});
}

function initGridP1() {
// 	console.log('initGridP1()');
	$("#grid_p1").w2grid({
		name : 'grid_p1',
		header : 'Master 검사 공정',
		show : {
			header : true
        },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
   			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
   			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
        		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
            	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
				render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
						return replaceAll(getTodayDate(),'.','-');
					else
						return this.getCellValue(index, col_index);
				}},
			{ field:'remark', caption:'비고', editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_p1.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_p1.set(event.recid, {'member_nm' :s_member_nm, 'member_emp_no' : s_member_emp_no});
				}
			}
		}
	});
}

function initGridP2() {
// 	console.log('initGridP2()');
	$("#grid_p2").w2grid({
		name : 'grid_p2',
		header : '조립 공정',
		show : {
			header : true
        },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
   			{ field:'minsp_name', caption:'항목', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
        		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
            	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', editable:{type:'text'}, style:'text-align:center'},
			{ field:'work_date', caption:'작업일', editable: { type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
				render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
						return replaceAll(getTodayDate(),'.','-');
					else
						return this.getCellValue(index, col_index);
				}},
			{ field:'remark', caption:'비고', editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==8 || event.column==9 || event.column==13 ) {
					w2ui.grid_p2.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_p2.set(event.recid, {'member_nm' : s_member_nm, 'member_emp_no' : s_member_emp_no});
				}
			}
		}
	});
}

function initGridP5() {
// 	console.log('initGridP5()');
	$("#grid_p5").w2grid({
		name : 'grid_p5',
		header : '조정 공정',
		show : {
			header : true
        },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
   			{ field:'minsp_name', caption:'항목', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
        		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
            	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', editable:{type:'text'}, style:'text-align:center'},
			{ field:'work_date', caption:'작업일', editable: { type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
				render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
						return replaceAll(getTodayDate(),'.','-');
					else
						return this.getCellValue(index, col_index);
				}},
			{ field:'remark', caption:'비고', editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==7 || event.column==8 || event.column==12 ) {
					w2ui.grid_p5.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_p5.set(event.recid, {'member_nm' : s_member_nm, 'member_emp_no' : s_member_emp_no});
				}
			}
		}
	});
}

function initGridT1() {
// 	console.log('initGridT5()');
	$("#grid_t1").w2grid({
		name : 'grid_t1',
		header : '최종검사 공정',
		show : {
			header : true
        },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
   			{ field:'minsp_name', caption:'항목', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
        		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
            	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', editable:{type:'text'}, style:'text-align:center'},
			{ field:'work_date', caption:'작업일', editable: { type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
				render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
						return replaceAll(getTodayDate(),'.','-');
					else
						return this.getCellValue(index, col_index);
				}},
			{ field:'remark', caption:'비고', editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==7 || event.column==8 || event.column==12 ) {
					w2ui.grid_t1.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_t1.set(event.recid, {'member_nm' : s_member_nm, 'member_emp_no' : s_member_emp_no});
				}
			}
		}
	});
}

function loadSelfInspHeader() {
// 	console.log('loadSelfInspHeader()');
	
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selarrrow");
	var selData = $("#grid_ready").jqGrid('getRowData', selKey[0]);

	var page_url = "/frontend/mes/select_selfinsp_header"
				+ "?dept_cd=" + encodeURIComponent(dept_cd)
				+ "&pordno=" + encodeURIComponent(selData.pordno)
				+ "&matnr=" + encodeURIComponent(selData.itnbr);

	var rowArr = [];
	var returnVal = false;
	w2ui.grid_selfInsp_header.lock('loading...', true);
	$.ajax({
		url : page_url,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200" ) {
				if( (data.rows).length>0 ){
					rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
						if( row.siheader_seq=='1' )
							row.item_value = row.simaster_gr_nm;
					});
// 					console.log(rowArr);
					w2ui.grid_selfInsp_header.records = rowArr;
					w2ui.grid_selfInsp_header.total = rowArr.length;
					returnVal = true;
				} else {
					fnMessageModalAlert("Warning", "P/O(" + selData.pordno + ") 에 해당하는 자주검사 정보가 없습니다.");
				}
			} else {
				fnMessageModalAlert("Fail",	"정보를 가져오는 중 오류가 발생하였습니다.");
			}
			w2ui.grid_selfInsp_header.refresh();
			w2ui.grid_selfInsp_header.unlock();
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "정보를 가져오는 중 오류가 발생하였습니다.");
		},
		complete : function() {}
	});
	return returnVal;
}

function loadSelfInspDetail() {
	console.log('loadSelfInspDetail()');
// 	console.log(w2ui.grid_selfInsp_header.records);
	var selKey = $("#grid_ready").jqGrid('getGridParam',"selarrrow");
	var selData = $("#grid_ready").jqGrid('getRowData', selKey[0]);
	
	var page_url = "/frontend/mes/select_selfinsp_detail"
				+ "?dept_cd=" + encodeURIComponent(dept_cd)
				+ "&pordno=" + encodeURIComponent(selData.pordno)
				+ "&use_yn=" + encodeURIComponent("Y")
				+ "&simaster_gr_no=" + encodeURIComponent((w2ui.grid_selfInsp_header.records)[0].simaster_gr_no);

	var rowArr_p1 = [];
	var rowArr_p2 = [];
	var rowArr_p5 = [];
	var rowArr_t1 = [];
	w2ui.grid_p1.lock('loading...', true);
	w2ui.grid_p2.lock('loading...', true);
	w2ui.grid_p5.lock('loading...', true);
	w2ui.grid_t1.lock('loading...', true);
	$.ajax({
		url : page_url,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200" && (data.rows).length>0 ) {
				var tmpArr = data.rows;
				$.each(tmpArr, function(idx, row){
// 					row.recid = idx+1;
					if( row.insp_state=='' || row.insp_state==undefined )	row.insp_state = 'i2';
					if( row.routing_code=='P1' )	rowArr_p1.push(row);
					else if( row.routing_code=='P2' )	rowArr_p2.push(row);
					else if( row.routing_code=='P5' )	rowArr_p5.push(row);
					else if( row.routing_code=='T1' )	rowArr_t1.push(row);
				});
				rowArr_p1 = setRecid(rowArr_p1);
				rowArr_p2 = setRecid(rowArr_p2);
				rowArr_p5 = setRecid(rowArr_p5); 
				rowArr_t1 = setRecid(rowArr_t1);
// 				console.log(rowArr_p1);
// 				console.log(rowArr_p2);
// 				console.log(rowArr_p5);
// 				console.log(rowArr_t1);
				w2ui.grid_p1.records = rowArr_p1;
				w2ui.grid_p1.total = rowArr_p1.length;
				w2ui.grid_p2.records = rowArr_p2;
				w2ui.grid_p2.total = rowArr_p2.length;
				w2ui.grid_p5.records = rowArr_p5;
				w2ui.grid_p5.total = rowArr_p5.length;
				w2ui.grid_t1.records = rowArr_t1;
				w2ui.grid_t1.total = rowArr_t1.length;
			} else {
				fnMessageModalAlert("Fail",	"정보를 가져오는 중 오류가 발생하였습니다.");
			}
			w2ui.grid_p1.refresh();
			w2ui.grid_p1.unlock();
			w2ui.grid_p2.refresh();
			w2ui.grid_p2.unlock();
			w2ui.grid_p5.refresh();
			w2ui.grid_p5.unlock();
			w2ui.grid_t1.refresh();
			w2ui.grid_t1.unlock();
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "정보를 가져오는 중 오류가 발생하였습니다.");
		},
		complete : function() {}
	});
}

function showSelfInspGrid() {
// 	console.log('showSelfInspGrid()');
	var code = $("#self_insp_routing").val();	// P1, P2, P5, T1
	if(code==null) code = '-';
	if ( code=='p1' ) {
		$("#grid_p1_area").show();
		$("#grid_p2_area").hide();
		$("#grid_p5_area").hide();
		$("#grid_t1_area").hide();
	} else if ( code=='p2' ) {
		$("#grid_p2_area").show();
		$("#grid_p1_area").hide();
		$("#grid_p5_area").hide();
		$("#grid_t1_area").hide();
	} else if ( code=='p5' ) {
		$("#grid_p5_area").show();
		$("#grid_p1_area").hide();
		$("#grid_p2_area").hide();
		$("#grid_t1_area").hide();
	} else if ( code=='t1' ) {
		$("#grid_t1_area").show();
		$("#grid_p1_area").hide();
		$("#grid_p2_area").hide();
		$("#grid_p5_area").hide();
	} else if ( code=='-' ) {
		$("#grid_p1_area").show();
		$("#grid_p2_area").show();
		$("#grid_p5_area").show();
		$("#grid_t1_area").show();
	}
	
	w2ui.grid_p1.resize();
	w2ui.grid_p1.refresh();
	w2ui.grid_p2.resize();
	w2ui.grid_p2.refresh();
	w2ui.grid_p5.resize();
	w2ui.grid_p5.refresh();
	w2ui.grid_t1.resize();
	w2ui.grid_t1.refresh();
}

function makeSelectBox() {
// 	console.log('makeSelectBox()');
	$("#self_insp_routing").empty();
	var page_url = "/frontend/mes/select_selfInspCode_1210"
				 + "?ref1=" +  + encodeURIComponent(dept_cd);
	$.ajax({
	    url: page_url,
	    type: "POST",
	    async : false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$("#self_insp_routing").append($('<option>', {
						value: '-', 
				        text : '전체'
				    }));
					$.each(data.rows, function (i, item) {
						$("#self_insp_routing").append($('<option>', { 
					        value: item.code,
					        text : item.code_nm
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

function saveSelfInsp() {
// 	console.log('saveSelfInsp()');
	var pordno = $("#grid_ready").jqGrid('getGridParam',"selarrrow")[0];
	var headerData = w2ui.grid_selfInsp_header.records;
	$.each(headerData, function(idx, row){
		if( row.w2ui!=undefined ){
			row.item_value = row.w2ui.changes.item_value;
		}
	});
// 	console.log(headerData);
	var grid_p1_data = dataSetselfinspDetail(w2ui.grid_p1.records);
	var grid_p2_data = dataSetselfinspDetail(w2ui.grid_p2.records);
	var grid_p5_data = dataSetselfinspDetail(w2ui.grid_p5.records);
	var grid_t1_data = dataSetselfinspDetail(w2ui.grid_t1.records);
//  	console.log(grid_p1_data);
//  	console.log(grid_p2_data);
//  	console.log(grid_p5_data);
//  	console.log(grid_t1_data);
 	var page_url = "/frontend/mes/saveSelfInsp_1210"
				 + "?pordno=" + encodeURIComponent(pordno)
				 + "&dept_cd=" + encodeURIComponent(dept_cd);
				 var params = "&headerData=" + encodeURIComponent(JSON.stringify(headerData))
				 + "&grid_p1_data=" + encodeURIComponent(JSON.stringify(grid_p1_data))
				 + "&grid_p2_data=" + encodeURIComponent(JSON.stringify(grid_p2_data))
				 + "&grid_p5_data=" + encodeURIComponent(JSON.stringify(grid_p5_data))
				 + "&grid_t1_data=" + encodeURIComponent(JSON.stringify(grid_t1_data));
//  	console.log(page_url);
//  	return;
	$.ajax({
		url: page_url,
		data : params,
		async : false,
		type: "POST",
		success:function(data, textStatus, jqXHR){
			if(data.status == "200") {
				fnMessageModalAlert("Success", "저장을 완료 하였습니다.");
				$("#modal_selfInsp").modal('hide');
			} else {
				fnMessageModalAlert("Fail", "데이터 저장을 실패하였습니다.");	
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("Fail", "데이터 저장하는데 에러가 발생하였습니다.");	
		},
		complete: function() {}
	});
}

function dataSetselfinspDetail(dataArr) {
// 	console.log('dataSetselfinspDetail()');
	$.each(dataArr, function(idx, row){
		if( row.w2ui!=undefined ){
			var chnObj = row.w2ui.changes;
			if( chnObj.insp_value!=undefined )
				row.insp_value = chnObj.insp_value;
			if( chnObj.insp_state!=undefined )
				row.insp_state = chnObj.insp_state;
			if( chnObj.member_nm!=undefined )
				row.member_nm = chnObj.member_nm;
			if( chnObj.work_date!=undefined )
				row.work_date = chnObj.work_date;
			if( chnObj.remark!=undefined )
				row.remark = chnObj.remark;
		}
	});
	return dataArr;
}

function setRecid(arr) {
	var resultArr = [];	
	$.each(arr, function(idx, row){
		row.recid = idx+1;
		resultArr.push(row);
	});
	return resultArr;
}

function locInputMng() {
// 	console.log('sernrInputMng()');
	var gridRowData = $("#grid_fault_list").getRowData($("#grid_fault_list").getGridParam('selrow'));
		
	gridRowData.lgort = $('#grade_loc').val();
	
	$("#grid_fault_list").setRowData($("#grid_fault_list").getGridParam('selrow'), gridRowData, {});
	$("#grade_loc_add").modal('hide');
}

function grade_chk() {
	
	$("#grid_grade_mng").jqGrid('clearGridData');
	
	var selKey = $("#grid_ready").jqGrid('getGridParam', 'selarrrow');
	var pordnos = "";
	var r_data = [];
	for(var i=0 ; i<selKey.length; i++) {
		
		var selectedData = $("#grid_ready").getRowData(selKey[i]);
		
		if(prodEndChk(selectedData.routing_no)) {//routing_header_master의 routng_plast_gubun 값... 현재 라우팅이 생산종료 단계인지 체크
			pordnos = pordnos + selectedData.pordno + ",";
		}
	}
	
	
	pordnos = pordnos.substring(0, pordnos.length-1);
	
	var page_url = "/frontend/mes/grade_matnr_chk";
	var postData = "&pordnos=" + encodeURIComponent(pordnos);
	
	$.ajax({
	url: page_url,
	data : postData,
	type: "POST",
	async : false,
	success:function(data, textStatus, jqXHR){
		if(data.status == "200") {
			r_data = data.rows;
		} else {
			fnMessageModalAlert("Fail", "데이터를 불러오는데 실패하였습니다.");	
		}
	},
	error: function(jqXHR, textStatus, errorThrown){
		fnMessageModalAlert("Fail", "데이터를 불러오는데 실패하였습니다.");	
	},
	complete: function() {}
	});
	
	var flag = false;
	for(var i=0 ; i<r_data.length; i++) {
		var tmpObj = {};
		
		tmpObj.pordno = r_data[i].pordno;
		tmpObj.project_no = r_data[i].project_no;
		tmpObj.matnr = r_data[i].matnr;
		tmpObj.maktx = r_data[i].maktx;
		tmpObj.wrkst = r_data[i].wrkst;
		tmpObj.kzumw = r_data[i].kzumw;
		tmpObj.lgort = r_data[i].lgort;
		$('#grid_grade_mng').addRowData( i, tmpObj, 'last');
		
		if(r_data[i].kzumw == 'Y')
			flag = true;
	}
	
	
// 	console.log("r_data.length :: " + r_data.length);
	if(flag) {
		$("#grade_mng").modal('show');	
	} else {
		//작업종료 진행
		chnStatus('p6');
	}
	
	
}

function fnLoadGradeMngGrid() {
// 	console.log('fnLoadWorkerAddGrid()');
	
	$("#grid_grade_mng").jqGrid({
		datatype : "json",
		colNames : ['P/O', '시리얼번호','제품명','제품내역', 'Spec.','등급창고여부', '저장창고'],
		colModel : [ 
		    {name : 'pordno', index : 'member_emp_no', width : 100, sorttype : "text", sortable : true}, 
			{name : 'project_no', index : 'member_id', width : 100, sorttype : "text", sortable : true}, 
			{name : 'matnr', index : 'member_nm', width : 100, sorttype : "text", sortable : true}, 
			{name : 'maktx', index : 'member_nm', width : 190, sorttype : "text", sortable : true}, 
			{name : 'wrkst', index : 'member_nm', width : 190, sorttype : "text", sortable : true}, 
			{name : 'kzumw', index : 'member_nm', width : 100, sorttype : "text", sortable : true}, 
			{name : 'lgort', index : 'dept_cd', width : 100, sorttype : "text", sortable : true} 
			],
			
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
		onCellSelect : function(rowid, selected) {
			if ( rowid != null && selected ) { 
				if(selected == '7') {
					var selGridData = $("#grid_grade_mng").getRowData(rowid);
					$("#grade_loc_matnr_1").val(selGridData.matnr);
					
					getStrList('mst05');
					$("#grade_loc_add_1").modal('show');
				}	
			}
		},
		loadComplete : function() {}
	});
}

function locInputMng_1() {
// 	console.log('sernrInputMng()');
	var gridRowData = $("#grid_grade_mng").getRowData($("#grid_grade_mng").getGridParam('selrow'));
		
	gridRowData.lgort = $('#grade_loc_1').val();
	
	$("#grid_grade_mng").setRowData($("#grid_grade_mng").getGridParam('selrow'), gridRowData, {});
	getStrList('mst03');
	$("#grade_loc_add_1").modal('hide');
}

function work_end_proc() {
	var selKey = $("#grid_grade_mng").jqGrid('getGridParam', 'selarrrow');
	var selGridData = $("#grid_grade_mng").getRowData();
	
	
	for(var i=0 ;i<selGridData.length; i++) {
		if(selGridData[i].lgort.length == 0) {
			fnMessageModalAlert("Notification(MES)", "조회내역의 저장위치 항목에 데이터가 없습니다.<br/>해당 셀을 클릭해 데이터를 입력해주세요.");
	 		return;
		}
	}
	
	//lgort업데이트
	grade_loc_update();
}

function grade_loc_update(){
	
	var selGridData = $("#grid_grade_mng").getRowData();
	
	
	var page_url = "/frontend/mes/grade_loc_update";
	var postData = "&params=" + encodeURIComponent(JSON.stringify(selGridData));

	$.ajax({
	url: page_url,
	data : postData,
	async : false,
	type: "POST",
	success:function(data, textStatus, jqXHR){
		if(data.status == "200") {
			chnStatus('p6');
		} else {
			fnMessageModalAlert("Fail", "데이터를 불러오는데 실패하였습니다.");	
		}
	},
	error: function(jqXHR, textStatus, errorThrown){
		fnMessageModalAlert("Fail", "데이터를 불러오는데 실패하였습니다.");	
	},
	complete: function() {}
	});
}

function getStrList(menu_code) {
	initOptions($('#fsa_loc'));
	initOptions($('#grade_loc'));
	initOptions($('#grade_loc_1'));

	var page_url = "/frontend/scm/mes_stock_tbl_select"
	var postData = 'menu_code=' + encodeURIComponent(menu_code);

	$.ajax({
	    url: page_url,
	    data: postData,
	    async:false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$.each(data.rows, function (i, item) {
						$('#fsa_loc').append($('<option>', { 
							value: item.stock_code,
					        text : "("+item.stock_code+") "+item.stock_name 
					    }));
						
						$('#grade_loc').append($('<option>', { 
							value: item.stock_code,
					        text : "("+item.stock_code+") "+item.stock_name 
					    }));
						
						$('#grade_loc_1').append($('<option>', { 
							value: item.stock_code,
					        text : "("+item.stock_code+") "+item.stock_name 
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
	    complete: function() {  	
	    }
	});
}

function chkAddItnbrExist(pordno_pop) {
	console.log('chkAddItnbrExist()');	
	var returnVal = false;
 	var page_url = "/frontend/prod/selectSernrManageTbl"
 				 + "?pordno_pop=" + encodeURIComponent(pordno_pop);
 	$.ajax({
		url : page_url,
		type : "POST",
		async : false,
		success : function(data, textStatus, jqXHR) {
			if( data.status == 200 ) {
				if( (data.rows).length>0 ) returnVal = true; 
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {},
		complete : function() {}
	});
 	return returnVal;
}

function sernr_stock_chk(werks, matnr, sernr) {
	
	var ev_b_lager = "";
	var ev_status = "";
	var ev_message = "";
	
	var page_url = "/sap_master/ziffm_mes_pp015"
		 + "?func_name=" + encodeURIComponent("ZIFFM_MES_PP015")
		 + "&iv_werks=" + encodeURIComponent(werks)
		 + "&iv_matnr=" + encodeURIComponent(matnr)
		 + "&iv_sernr=" + encodeURIComponent(sernr);

	$.ajax({
		url : page_url,
		type : "POST",
		async : false,
		success : function(data, textStatus, jqXHR) {
			if( data.status == 200 ) {
				ev_b_lager = data.ev_b_lager; 
				ev_status = data.ev_status;
				ev_message = data.ev_message;
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {},
		complete : function() {}
	});
	
	console.log(ev_b_lager);
	console.log(ev_status);
	console.log(ev_message);
	return ev_b_lager;
	
}

function drwDownload(file_cate) {
	
	var cate = '';
	if(file_cate == 'drw') {
		cate = '도면';
	} else if(file_cate == 'ord') {
		cate = '작업표준서';
	}
	
	var selKey = $("#grid_ready").jqGrid('getGridParam', 'selarrrow');
	
	if (selKey.length > 1) {
		fnMessageModalAlert("Notification(MES)", "한개의 오더만 선택해주세요.");
		return;
	} else if(selKey.length == 0) {
		fnMessageModalAlert("Notification(MES)", "선택된 생산지시오더가 없습니다.");
		return;
	}
	
	var rowData = $("#grid_ready").getRowData(selKey[0]);
	
	if(rowData.itnbr.lengh == 0 || rowData.itnbr == undefined || rowData.itnbr == '') {
		fnMessageModalAlert("Notification(MES)", "선택된 내역은 자재정보가 없는 지시입니다.");
		return;
	}
	
	fnMessageModalConfirm("Notification", "선택된 오더의 자재( " + rowData.itnbr + " )에 대한 " + cate + " 파일을 다운로드 받습니다.<br/>"
			+ "계속 진행하시겠습니까?", function(chk){
			if(chk){
				
				var r_data = ''	;
								
				if(file_cate == 'drw') {
					var page_url = "/file/file_select_nopage";
					page_url += "?file_cate=" + encodeURIComponent(file_cate)
					page_url += "&file_name=" + encodeURIComponent(rowData.itnbr)
					page_url += "&file_del_yn=" + encodeURIComponent("N");
				} else if(file_cate == 'ord'){
					var page_url = "/file/file_select_nopage";
					page_url += "?file_cate=" + encodeURIComponent(file_cate)
					page_url += "&matnr=" + encodeURIComponent(rowData.itnbr)
					page_url += "&file_del_yn=" + encodeURIComponent("N");
				}
				
				
				$.ajax({
					url : page_url,
					async: false,
					type : "POST",
					success : function(data, textStatus, jqXHR) {
						if (data.status == "200") {
							if(data.rows.length > 0) {
								r_data = data.rows;	
								var protocol = jQuery(location).attr('protocol');
							  	var host = jQuery(location).attr('host');
							    var link_url = "/file/attach_download";
							 	link_url += "?file_path="+encodeURIComponent(r_data[0].file_path);
							 	link_url += "&file_name="+encodeURIComponent(r_data[0].file_name);
							  
							 	$(location).attr('href', link_url);  		
								
							} else {
								fnMessageModalAlert("Notification(MES)", "선택된 지시에 대한 " + cate + " 파일정보가 존재하지 않습니다.");
								return;
							}
						} else {
							fnMessageModalAlert("Notification(MES)", "선택된 지시에 대한 " + cate + " 파일정보를 가져오지 못했습니다.");
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						fnMessageModalAlert("Notification(MES)", "선택된 지시에 대한 " + cate + " 파일정보를 가져오지 못했습니다.");
					},
					complete : function() {}
				});
			}
	});
}

function excelFileDownload(gridName) {
// 	console.log('excelFileDownload('+gridName+')');
	var tmpArr = [];
	var getColNames = $("#grid_ready").jqGrid('getGridParam','colNames');
	getColNames[1] = "";
	var getColModels = $("#grid_ready").jqGrid('getGridParam','colModel');
	$.each(getColModels, function(idx, mrow){
		if( mrow.hidden==false && getColNames[idx]!='' ) {
			mrow.caption = getColNames[idx]; 
			tmpArr.push(mrow);  
		}
	});
	
	var gridCols = tmpArr;
	var gridData = $("#grid_ready").getRowData();

	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	if( gridName=='grid_ready' ) {
		fileName = '공정진행처리_광영상.xlsx';
		sheetTitle = '공정진행처리_광영상';
		sheetName = '공정진행처리_광영상';
	}
	
	var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
	var is_rownum = true;
	
	if(gridCols != null && gridCols.length > 0){
		// w2grid 는 linenumber column info not exist
		param_col_name = "No"
		param_col_id = "rownum";
		param_col_align = "center";
		param_col_width = "80";
		//--------------------------------------------
		console.log(gridCols);
		for(var i=0; i<gridCols.length; i++){
			if(!gridCols[i].hidden){
				var caption = gridCols[i].caption;
				param_col_name += "," + caption;
				param_col_id += "," + gridCols[i].name;
				param_col_align += ",left";
				param_col_width += "," + (gridCols[i].width==undefined?"80":(gridCols[i].width));
			}
		}
	}
	
	var export_url = "/export/export_client_jqgrid";
	var export_data = "file_name="+encodeURIComponent(fileName);
		export_data += "&sheet_title="+encodeURIComponent(sheetTitle);
		export_data += "&sheet_name="+encodeURIComponent(sheetName);
		export_data += "&header_col_names="+encodeURIComponent(param_col_name);
		export_data += "&header_col_ids="+encodeURIComponent(param_col_id);
		export_data += "&header_col_aligns="+encodeURIComponent(param_col_align);
		export_data += "&header_col_widths="+encodeURIComponent(param_col_width);
		export_data += "&cmd="+encodeURIComponent("grid_goods_detail");
		export_data += "&body_data="+encodeURIComponent(JSON.stringify(gridData));

	$.ajax({
	  url:export_url,
	  data:export_data,
	  type:'POST',
	  dataType: 'json',
	  success: function( data ) {
	  	if(data.status == 200) {
	  		var file_path = data.file_path;
	  		var file_name = data.file_name;
	  		var protocol = jQuery(location).attr('protocol');
  			var host = jQuery(location).attr('host');
  			var link_url = "/file/attach_download";
  			link_url += "?file_path="+encodeURIComponent(file_path);
  			link_url += "&file_name="+encodeURIComponent(file_name);
  			$(location).attr('href', link_url);
	  	}
	  },
	  complete: function () {}
	});
}

function g_fault_proc() {
	
	matArr = [];
	$("#s_matnr").val('');
	$("#s_wrkst").val('');
	$("#s_maktx").val('');
	
	var page_url = '/frontend/hub/material_recv_master_select'
		 + '?werks=' + encodeURIComponent("1210");
	$("#grid_g_materiallist").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_g_materiallist").trigger("reloadGrid");
	$("#dv_grid_g_materiallist").show();
		
	initOptions($('#v_lgort'));
	
	$('#v_lgort').append($('<option>', { 
		value: '2100',
		text : '생산 창고'
	}));
	$('#v_lgort').append($('<option>', { 
		value: '210A',
		text : '생산 창고-S등급'
	}));
	$('#v_lgort').append($('<option>', { 
		value: '210B',
		text : '생산 창고-CS 등급' 
	}));
	$('#v_lgort').append($('<option>', { 
		value: '210C',
		text : '생산 창고-C등급'
	}));
	$('#v_lgort').append($('<option>', { 
		value: '210D',
		text : '생산 창고-D등급(2TAB)'
	}));
	
	
	$("#modal_g_fault_proc").modal('show');
}

function g_materialSearch() {
// 	console.log('materialSearch()');
	var page_url = '/frontend/hub/material_recv_master_select'
		 		 + '?matnr=' + encodeURIComponent($("#s_matnr").val())
		 		 + '&wrkst=' + encodeURIComponent($("#s_wrkst").val())
		 		 + '&maktx=' + encodeURIComponent($("#s_maktx").val())
				 + '&werks=' + encodeURIComponent("1210");
	$("#grid_g_materiallist").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_g_materiallist").setGridParam({ page: 1 }).trigger("reloadGrid");
}

function init_g_MaterialGrid() {
	$('#grid_g_materiallist').jqGrid({
		datatype: 'json',
		colNames:['자재코드','자재내역',' Spec.','제품군명', '자재그룹명', '생성일자', '수정일자', '단위', 'lgpro', 'sernp', 'kzumw'],
		colModel:[
			{name:'matnr',index:'matnr', width:205, sorttype:'text', sortable:true, key:true},
			{name:'maktx',index:'maktx', width:250, sorttype:'text', sortable:true},
			{name:'wrkst',index:'wrkst', width:250, sorttype:'text', sortable:true, sortable:true},
			{name:'vtext',index:'vtext', sorttype:'text', sortable:true, hidden:true},
			{name:'wgbez',index:'wgbez', sorttype:'text', sortable:true, hidden:true},
			{name:'date_created',index:'date_created', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'date_updated',index:'date_updated', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'meins',index:'meins', width:130, hidden:false},
			{name:'lgpro',index:'lgpro', hidden:true},
			{name:'sernp',index:'sernp', hidden:true},
			{name:'kzumw',index:'kzumw', hidden:true}
		],
		pager : '#grid_g_materiallist_pager',
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : true,
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
			}
		},
		loadComplete : function(data) {
		}
	});
}

function fnFaultGnrMatnrConf() {
	
	var fromLgort = $('#v_lgort').val();
	gnrFaultMantrFlag = 'g';
	$('.h_flag').hide();

	
	$("#btn_fault_conf").removeAttr('disabled');
	
	$("#grid_fault_list").jqGrid('clearGridData');
	
	var uniqMatnrArr = []; 
	var totalMatnrArr = []; 
	
	var grid_materiallist_keyArr = $("#grid_g_materiallist").getGridParam('selarrrow');  
		
	var grid_materiallist_length = $("#grid_g_materiallist").getGridParam('selarrrow').length;  

	
	var grid_materiallist_selcData = [];  
	
	if(Number(grid_materiallist_length) == 0) {
		fnMessageModalAlert("Notification(MES)", "체크 된 데이터가 없습니다.");
		return;
	}

	for(var i=0 ; i<grid_materiallist_keyArr.length; i++) {
		var tmp_obj = $("#grid_g_materiallist").getRowData(grid_materiallist_keyArr[i])
		tmp_obj.gubun = "mat"
		grid_materiallist_selcData.push(tmp_obj);
		totalMatnrArr.push(tmp_obj.matnr);
	}

	var uniqMatnrArr = $.unique(totalMatnrArr);
	
	$("#modal_g_fault_proc").modal('hide');	
		
	var itnbr_data;
	var page_url = '/frontend/hub/material_recv_master_select_nopage'	
				 + "?matnrs=" + encodeURIComponent(String(uniqMatnrArr))
				 +"&werks=" + encodeURIComponent("1210");
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
var grid_fault_list_data = [];
	
	$.each(grid_materiallist_selcData, function(idx, mat){
		var tmpObj = {};
		$.each(itnbr_data, function(i, obj){
			if( obj.matnr==mat.matnr ) {
				tmpObj.werks = dept_cd;
				tmpObj.sernp = obj.sernp;
				tmpObj.matnr = obj.matnr;
				tmpObj.maktx = obj.maktx;	
				tmpObj.wrkst = obj.wrkst;
				tmpObj.meins = obj.meins;
				tmpObj.kzumw = obj.kzumw;
				tmpObj.lgort = fromLgort;
				
				tmpObj.menge = '1';
				tmpObj.sernr = '';
				tmpObj.sernr_seq = '';
				tmpObj.org_menge = '1';
				tmpObj.rfc_chk = 'N';
				tmpObj.gubun = mat.gubun;
				console.log(tmpObj);
				grid_fault_list_data.push(tmpObj);
			}
		});
	});
	
	console.log(grid_fault_list_data);
	$('#grid_fault_list').jqGrid('setGridParam', { datatype: 'local', data: grid_fault_list_data }).trigger('reloadGrid');

	initOptions($('#sel_step1'));
	initOptions($('#sel_step2'));
	initOptions($('#sel_step3'));
	initOptions($('#sel_step4'));
	makeSelStep1();
	
	$("#fault_mng").modal('show');
}

function in_remain_cnt(itnbrlist_data, addItnbr_data) {
	
	for(var i=0 ;i<itnbrlist_data.length; i++) {
		
		var addItnbr_bdmng = 0;	//투입수량
		var itnbrlist_matnr = itnbrlist_data[i].matnr;		
		var itnbrlist_bdmng = itnbrlist_data[i].bdmng;	//지시수량
		
		for(var k=0 ;k<addItnbr_data.length; k++) {
			if(itnbrlist_data[i].matnr == addItnbr_data[k].matnr) {
				addItnbr_bdmng = addItnbr_bdmng + Number(addItnbr_data[k].bdmng);
			}
		}
		var remain_bdmng = Number(itnbrlist_bdmng) - Number(addItnbr_bdmng);	//잔량
				
		$("#grid_itnbrlist").jqGrid('setCell', itnbrlist_matnr, 'remain_bdmng', remain_bdmng);
		
		if(Number(remain_bdmng) == 0) {
			$("tr.jqgrow#"+itnbrlist_matnr).css("color","#0054FF");	
		} else {
			$("tr.jqgrow#"+itnbrlist_matnr).css("color","#FF0000");
		}
		
	}
}
</script>

</body>
</html>
