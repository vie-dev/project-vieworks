<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
String member_id = SessionUtil.getMemberId(request);
String member_nm = SessionUtil.getMemberNm(request);
String member_emp_no = SessionUtil.getMemberEmpNo(request);
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
		<jsp:param name="selected_menu_p_cd" value="1043"  />
		<jsp:param name="selected_menu_cd" value="1084" />
	</jsp:include>
	<div class="content-wrapper">
		<section class="content-header">
			<h1>
				MES <small>포장처리</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> MES</a></li>
				<li class="active">포장처리</li>
			</ol>
		</section>
		<section class="content">
			<div class="row">
			<div class="col-md-5">
				<div class="box" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">작업목록</h3>
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
							<button type="button" onclick="reloadJobList();" class="btn btn-primary btn-sm">조회</button>
						</div>
					</div>
					<div class="box-body" style="padding-bottom: 0px;">
						<div class="row" id="exe_btn_area" style="margin-bottom:10px; display:none;">
							<div class="col-sm-12">
							<div class="box-tools pull-right">
<!--                                 <button type="button" id="btn_pord_del" class="btn btn-info btn-sm" onClick="selrowEdit();" style="display:none;">공정삭제</button> -->
								<button type="button" id="btn_work_start" class="btn btn-sm btn-primary">작업 시작</button>
<!-- 								<button type="button" id="btn_work_end" class="btn btn-sm btn-danger" onClick="chnStatus('p6');">작업 종료</button> -->
								<button type="button" id="btn_work_end" class="btn btn-sm btn-danger" onClick="chnStatus_validation('p6');">작업 종료</button>
								<button type="button" id="btn_work_pause_start" class="btn btn-sm bg-teal" onClick="chnStatus('p4');">비가동 시작</button>
								<button type="button" id="btn_work_pause_end" class="btn btn-sm bg-maroon" onClick="chnStatus('p5');">비가동 종료</button>
							</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 지시일자</label>
									<div class="input-group">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input type="text" class="form-control pull-right input-sm" id="cmdat"> 
                                    </div>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 분야</label>
									<select id="i_plant" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
										<option value="1110">의료</option>
										<option value="1210">광영상</option>
									</select>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 멀티체크</label>
									<select id="multiCheck" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
										<option value="Y">사용</option>
										<option value="N">미사용</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="box-body" style="padding-bottom: 0px;">
						<div id="grid_job" style="width: 100%; height: 650px;"></div>
					</div>
				</div>
			</div>
			<div class="col-md-7">
				<div class="row">
					<div class="col-md-12" style="padding-left: 0px;">
						<div class="box box-default" style="margin-bottom: 0px;">
							<div class="box-header with-border">
								<h3 class="box-title">상세작업목록</h3>
							</div>
							<div class="box-body" style="padding-bottom: 0px;height:320px;">
								<div id="grid_job_detail" style="width: 100%; height: 300px;"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="row" style="margin-top:10px;">
					<div class=" col-md-6" style="padding-left: 0px;">
						<div class="box box-primary" style="margin-bottom: 0px;">
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
							<div class="box-body" style="padding:0px;">
								<div id="grid_itnbrlist" style="width: 100%; height: 350px;"></div>
								<div id="grid_materiallist" style="width: 100%; height: 300px; display:none;"></div>
								<div id="pagination" class="text-center" style="display:none;"></div>
							</div>
						</div>
					</div>
					<div class=" col-md-6" style="padding-left: 0px;">
						<div class="box box-primary" style="margin-bottom: 0px;">
							<div class="box-header with-border">
								<h3 class="box-title">공정 투입자재</h3>
								<div class="box-tools pull-right">
									<button type="button" onclick="registSerial();" class="btn btn-primary btn-sm">시리얼 등록</button>
									<button type="button" id="btn_pord_fault" class="btn btn-danger btn-sm" onClick="pordFaultProc();">공정불량처리</button>							
									<button type="button" id="btn_fault_matnr_save" class="btn btn-success btn-sm" onclick="fnFaultMatnrConf();">불량처리</button>
									<button type="button" id="btn_detail_serial_save" class="btn btn-success btn-sm" onclick="fnSaveDetailSerial();">등록</button>
									<button type="button" id="" class="btn btn-warning btn-sm" onclick="deleteItnbrDetail();">
										<i class="fa fa-backward" aria-hidden="true"></i></button>
								</div>
							</div>
							<div class="box-body" style="padding:0px;">
								<div id="grid_addItnbr_list" style="width: 100%; height: 350px;"></div>
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
	
<!-- 공정불량처리 -->
<div class="modal fade" id="pord_fault_mng" data-backdrop="static">
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
							<div id="grid_prod_fault_list" style="width: 100%; height: 350px;"></div>
						</div>
						<div class="row">
							<div class="col-sm-2">
								<label for="p_m_type" class="col-sm-4 control-label">Type</label>
								<select id="p_sel_step1" class="form-control select2 input-sm" onChange="p_changeStep($(this).val(),'step1');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-3">
								<label for="p_m_lv1" class="col-sm-2 control-label">Lv.01</label>
								<select id="p_sel_step2" class="form-control select2 input-sm" onChange="p_changeStep($(this).val(),'step2');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-3">
								<label for="p_m_lv2" class="col-sm-2 control-label">Lv.02</label>
								<select id="p_sel_step3" class="form-control select2 input-sm" onChange="p_changeStep($(this).val(),'step3');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-3">
								<label for="p_m_lv3" class="col-sm-2 control-label">Lv.03</label>
								<select id="p_sel_step4" class="form-control select2 input-sm">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-1" style="padding: 20px 15px 0px 0px;">
								<label for="p_lv_c" class="col-sm-1 control-label"></label>
								<button type="button" id="" onclick="input_prod_fault_code();" class="btn btn-primary btn-sm" style="width:83px;">불량내역등록</button>
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
					<div class="col-sm-12 text-right" style="font-weight:bold; color:red;">
							<i class="fa fa-check" aria-hidden="true"></i> <span id="warningTxt">1. 자재불량내역을 선택 2.불량항목 level선택 3. 입력 버튼 클릭  :::::::  순서로 불량내역을 등록해주세요.</span>
						</div>
			<div class="modal-body" id="modal_code_body">
						<div class="box-body">				
			            <form id="frm_serial_add" name="frm_serial_add" class="form-horizontal">
						
						<i class="fa fa-check h_flag" aria-hidden="true"></i> <span class="h_flag">공정불량내역</span>
						<div class="row h_flag">
							<div id="grid_fault_routing_list" style="width: 100%; height: 200px;"></div>
						</div>
						<br>
						<i class="fa fa-check" aria-hidden="true"></i> <span>자재불량내역</span>
						<div class="row">
						<div id="grid_fault_list" style="width: 100%; height: 200px;"></div>
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
		        <button type="button" class="btn btn-sm btn-primary" onclick="loadList();">검색</button>
		        <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">닫기</button>
		        </div>
			</div>
		</div><!-- end modal-content -->
	</div><!-- end modal dialog -->
</div><!-- end modal div -->
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
							<label for="pordNoList" class="col-sm-2 control-label">제조오더</label>
							<div class="col-sm-10">
								<div id="pordNoList" style="padding-top: 7px;font-weight: bold;"></div>
							</div>
						</div>
						<div class="form-group">
							<label for="login_user" class="col-sm-2 control-label">기본작업자</label>
								<div class="col-sm-10">
									<input type="input" id="login_user" name="login_user" class="form-control"  maxlength="20" readonly="readonly">
								</div>
						</div>
						<div class="form-group">
							<label for="mes_po" class="col-sm-2 control-label">사원정보</label>
							<div class="col-sm-10 box-body" id="dv_grid_worker" >
								<div id="grid_worker" style="width: 100%; height: 500px;"></div>							
							</div>
						</div>         
					</div>
					</form>
				</div><!-- end box -->
			</div><!-- end modal body -->
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

<!-- ************************등급창고 지정 : Start ************************-->
<div class="modal fade" id="grade_loc_add_2" data-backdrop="static">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">등급창고지정</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
	            <form id="frm_serial_add_2" name="frm_serial_add_2" class="form-horizontal">
					<div class="form-group">
						<label for="" class="col-sm-3 control-label">자재번호</label>
						<div class="col-sm-9">
							<input type="input" id="grade_loc_matnr_2" name="grade_loc_matnr_2" class="form-control"  readonly="readonly">
						</div>
					</div>
	                <div class="form-group input_2">
						<label for="" class="col-sm-3 control-label">창고</label>
						<div class="col-sm-9">
<!-- 							<input type="input"  id="fsa_loc" name="fsa_loc" class="form-control"  maxlength="20" > -->
							<select id="grade_loc_2" class="form-control select2">
							</select> 
						</div>
	                </div>
	            </form>
	        </div>
			<div class="modal-footer center-block">
		        <button type="button" class="btn btn-sm btn-primary" onclick="locInputMng_2();">확인</button>
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
<script src="/res/plugins/pagination.js"></script>
<script type="text/javascript">
//for pagination
var page = 1; 		// 화면에서 사용할 page
var pageNum = 0; 	// 서버에 넘겨줄 page -> mysql 은 0 부터 시작
var rowPerPage = 20;
var rowLength = 0;
var totalPage = 0;
var cntRowPagination = 5;	// << 1 2 3 4 5 >>

<%-- var member_id = '<%=member_id%>'; --%>
var userInfo = { member_id : '<%=member_id%>' };

var member_nm = '<%=member_nm%>';
var member_emp_no = '<%=member_emp_no%>';
var gnrFaultMantrFlag='';

$(function($) {
	initComponent();
	init_g_MaterialGrid();
	getStrList();
	
	$('#s_plant').change(function() {
		g_materialSearch();
	});
	initScreenSizeModal();
})

function initComponent() {
// 	console.info('initComponent()');

	$('#cmdat').daterangepicker({
		opens: 'right',
		locale: {
			format : 'YYYY-MM-DD'	,
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
					'7월', '8월', '9월', '10월', '11월', '12월' ],
			daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
			showMonthAfterYear : true,
			yearSuffix : '년'
	    },
//  	     startDate: '2017-11-01',
//  	     endDate: '2017-11-30'
 	     startDate: getTodayDate(),
 	     endDate: getTodayDate()
	});
	
	$("#multiCheck").change(function(){
		if ( $(this).val()=='Y' ){
			w2ui.grid_job.multiSelect = true;
		} else {
			w2ui.grid_job.selectNone();
			w2ui.grid_job_detail.clear();
			w2ui.grid_job.multiSelect = false;
		}
	});
	
	$("#btn_work_start").on('click',function(e) {
		e.preventDefault();
		if (e.target.id == "btn_work_start") {
			var selectJob = w2ui.grid_job.get(w2ui.grid_job.getSelection());
			var selectPordnoArr = [];
			if(selectJob.length==0) {
				fnMessageModalAlert("Warning", "선택된 작업이 없습니다.");
				return;
			}
			/*
			else {
				var noSerialPordno = [];
				$.each(selectJob, function(idx, row){
					if(row.project_no==null || row.project_no==undefined || row.project_no=='')
						noSerialPordno.push(row.pordno);
					else
						selectPordnoArr.push(row.pordno);
				});
				if( noSerialPordno.length>0 ){
					fnMessageModalAlert("Warning", "작업시작전 대표시리얼 번호를 등록하셔야 합니다.<br>(미등록 제조오더 : " + noSerialPordno + ")");
					return;
				}
			}
			*/
			w2ui.grid_worker.clear();	// modal : 사원정보 grid init
			fnSearchWorkerAddGrid();
// 			$("#m_worker_mes_po").val(selected_pordno_pop);
// 			$("#m_routing_no").val(selected_routing_no);
			$("#pordNoList").text(String(selectPordnoArr));
			$("#login_user").val(member_nm);
			$("#modal_worker_add").modal('show');
			setTimeout(function(){
				w2ui.grid_worker.resize();
				w2ui.grid_worker.refresh();
			}, 200);			
		}
	});
	fnLoadUserInfo();
	gridJobGen();
	gridJobDetailGen();
	initItnbrGrid();
	initMaterialGrid();
	initNewItnbrGrid();
	fnLoadGradeMngGrid();
	fnLoadProdFaultListGrid();	// 공정불량처리
	fnLoadFaultListGrid();	//자재불량처리
	fnLoadWorkerAddGrid();	// 작업자 목록
	
	fnLoadFaultRoutingListGrid();
// 	reloadNewItnbrGrid();
}

function fnLoadUserInfo() {
// 	console.log('fnLoadUserInfo()');
	var page_url = "/frontend/prod/prodUserInfo"
		 		 + "?member_id=" + encodeURIComponent(userInfo.member_id);
	$.ajax({
		url : page_url,
		async: false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
// 				console.log(data.rows);
				if( Number(data.rows.length)>0 ) {
					var names = "";
					userInfo["user_dept_cd"] = data.rows[0].dept_cd;
					userInfo["jocod"] = data.rows[0].jocod;
					userInfo["line_nm"] = data.rows[0].line_nm;
					for(var i=0 ;i<data.rows.length; i++) {
						names = names + data.rows[i].member_nm + ", ";
					}
					names = names.substring(0, names.length-2);
					userInfo["member_nm"] = names;
				} else {
					userInfo["line_nm"] = "";
					userInfo["member_nm"] = "";
					userInfo["user_dept_cd"] = "";
				}
			} else {
				fnMessageModalAlert("Fail", "사용자 정보를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "사용자 정보를 가져오지 못했습니다.");
		}
	});
}

function gridJobGen() {
// 	console.info('gridJobGen()');

	$("#grid_job").w2grid({
		name : 'grid_job',
		show : {
			lineNumbers : true,
			selectColumn: true,
            footer: true
        },
		columns :[
	        { field:'pordno', caption:'제조오더', size:'100px', style:'text-align:center', sortable:true},
	        { field:'customer_nm', caption:'거래처', size:'150px', sortable:true},
	        { field:'itnbr', caption:'품목코드', size:'120px', hidden:true},
	        { field:'pordno_status', caption:'품목명', size:'150px', sortable:true},
	        { field:'pdsts_nm', caption:'진행상태', size:'100px', sortable:true, style:'text-align:center'},
	        { field:'ad_name1', caption:'END 고객명', size:'150px', sortable:true, style:'text-align:center'},
	        { field:'zgrade', caption:'요구등급', size:'100px', sortable:true},
	        { field:'pdsts', caption:'pdsts', hidden:true},
	        { field:'routing_no', caption:'현재공정', hidden:true},
	        { field:'routing_gno', caption:'routing_gno', hidden:true},
	        { field:'routing_nm', caption:'공정명', hidden:true},
// 	        { field:'auart', caption:'오더유형', size:'100px', hidden:true},
	        { field:'zauart', caption:'오더유형 code', size:'100px', hidden:true},
	        { field:'zbezei', caption:'오더유형', size:'100px', hidden:true},
	        { field:'bezei', caption:'판매오더유형', hidden:true},
	        { field:'cmdat', caption:'확정일', hidden:true},
	        { field:'dept_cd', caption:'분야', hidden:true},
	        { field:'dispo', caption:'MRP 관리자', hidden:true},
	        { field:'edatu', caption:'생산요청일', hidden:true}, 
	        { field:'fedat', caption:'생산완료예정일', hidden:true}, 
	        { field:'gr_no', caption:'변경점관리 GR번호', hidden:true}, 
	        { field:'jidat', caption:'지시일자', hidden:true},
	        { field:'lgort', caption:'입고저장위치', hidden:true},
	        { field:'pdqty', caption:'pdqty', hidden:true},
	        { field:'sedat', caption:'예정일자', hidden:true},
	        { field:'project_no', caption:'시리얼 번호', hidden:true},
	        { field:'wkctr', caption:'wkctr', hidden:true},
	        { field:'steus', caption:'제어키', hidden:true},
	        { field:'first_routing_no', caption:'first_routing_no', hidden:true},
	        { field:'next_routing', caption:'다음 작업', hidden:true},
	        { field:'sernp', caption:'sernp', hidden:true},
	        { field:'next_routing_code', caption:'다음 작업명', hidden:true} ],
		sortData: [{field: 'pordno', direction: 'ASC'}],
		multiSelect : true,
		records: [],
		recordHeight : 30,
		onLoad: function(event){},
		onClick: function(event){
			event.onComplete = function () {
		        var selectArr = w2ui.grid_job.getSelection();
		        var sel = Number(event.recid);
				var selectedData = this.get(sel);
		        if( $.inArray(sel, selectArr) > -1 ){	// checkbox on
		        	searchJobDetail();
		        } else {	// checkbox off
		        	var detailData = w2ui.grid_job_detail.records;
		        	$.each(detailData, function(idx, row){
						if( selectedData.pordno==row.pordno ){
							w2ui.grid_job_detail.select(row.recid);
						}
		        	});
        			w2ui.grid_job_detail.delete(true);
		        }
		        if( selectArr.length>0 )
		        	$("#exe_btn_area").show();
		        	$("#grid_job").css("height","610px");
		        if( $("#multiCheck").val()=='N' ) {
		        	if( selectedData.auart=='ZP01' || selectedData.auart=='ZP05' ) {
						$("#gubun").val('basic');
					} else {	// ZP02, ZP03, ZP04
						$("#gubun").val('mat');
					}
		        }
		        setMaterial();
		    }
		},
		onSelect: function(event){
			event.onComplete = function () {
				if(event.all) {
// 					console.log(w2ui.grid_job.getSelection());
					searchJobDetail();
				}
			}
		},
		onUnselect: function(event) {
			event.onComplete = function () {
				if(w2ui.grid_job.getSelection().length==0)
					w2ui.grid_job_detail.clear();
			}
	    }
	});
	reloadJobList();
}

function gridJobDetailGen() {
// 	console.info('gridJobDetailGen()');

	$("#grid_job_detail").w2grid({
		name : 'grid_job_detail',
		show : {
			lineNumbers : true,
            footer: true
        },
		columns :[
	        { field:'customer_nm', caption:'거래처', size:'100px', sortable:true},
	        { field:'itnbr', caption:'품목코드', size:'100px', sortable:true},
	        { field:'pordno_status', caption:'품목명', size:'150px', sortable:true},
	        { field:'wrkst', caption:'규격', size:'150px', sortable:true},
	        { field:'project_no', caption:'대표시리얼', size:'100px', sortable:true},
	        { field:'zzswoption', caption:'S/W', size:'100px', sortable:true},
	        { field:'zlongtext', caption:'비고', size:'100px', sortable:true}, 
	        { field:'routing_dscr', caption:'공정명', size:'80px', style:'text-align:center', sortable:true},
	        { field:'pordno', caption:'제조오더', size:'110px', style:'text-align:center', sortable:true},
	        { field:'cmdat', caption:'확정일', size:'100px', style:'text-align:center', sortable:true, hidden:true},
	        { field:'routing_no', caption:'공정코드', size:'100px', style:'text-align:center', hidden:true},
	        { field:'pordno_child', caption:'제조오더상세', hidden:true},
	        { field:'pordno_pop', caption:'pordno_pop', hidden:true},
	        { field:'pdsts', caption:'pdsts', hidden:true},
	        { field:'pdsts_nm', caption:'진행상태', size:'80px', hidden:true},
	        { field:'sub_sernr', caption:'자재시리얼', hidden:true} ],
		sortData: [{field: 'pordno', direction: 'ASC'}, {field: 'routing_no', direction: 'ASC'}],
		records: [],
		recordHeight : 30
	});
}

function clearList(){
	w2ui['grid_job_detail'].clear();
	w2ui['grid_itnbrlist'].clear();
	w2ui['grid_addItnbr_list'].clear();
}

function reloadJobList(key){
// 	console.log('reloadJobList()');
	w2ui['grid_job'].clear();
	
	var date1 = replaceAll($("#cmdat").val().substring(0, 10),'-','');
	var date2 = replaceAll($("#cmdat").val().substring(13, 23),'-','');
	
	var rowArr = [];
	var page_url = "/frontendShip/shipment/packingJoblist"
				 + "?cmdat_from="  + encodeURIComponent(date1)    
				 + "&cmdat_to=" + encodeURIComponent(date2)
				 + "&dept_cd=" + encodeURIComponent($("#i_plant").val());
	w2ui['grid_job'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		async:false,
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
// 				console.log(rowArr);
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				w2ui['grid_job'].records = rowArr;
				w2ui['grid_job'].total = rowArr.length;
			}
			w2ui['grid_job'].refresh();
			w2ui['grid_job'].unlock();
			
			if( key!=undefined )
				w2ui.grid_job.click(key);
// 				w2ui.grid_job.select(key);
		},complete: function () {}
	});
}

function searchJobDetail() {
// 	console.log('searchJobDetail()');
	var jobArr = w2ui.grid_job.get(w2ui.grid_job.getSelection());
	w2ui.grid_job_detail.clear();
	if( jobArr.length>0 ){
		w2ui['grid_job_detail'].lock('loading...', true);
		$.each(jobArr, function(idx, row){
			var rowArr = [];
			var page_url = "/frontendShip/shipment/packingJobDetaillist"
						 + "?pordno=" + encodeURIComponent(row.pordno);
			
			if( $("#multiCheck").val()=='N' )
				w2ui['grid_job_detail'].clear();
			
			$.ajax({
				url : page_url,
				type : 'POST',
				async:false,
				dataType : 'json',
				success : function( data ) {
					if(data.status == 200 && (data.rows).length>0 ) {
						rowArr = data.rows;
						var rowCnt = w2ui.grid_job_detail.records.length;
						$.each(rowArr, function(idx, row){
							row.recid = rowCnt + 1 + idx;
						});
						w2ui.grid_job_detail.add(rowArr);
						w2ui['grid_job_detail'].total = rowCnt + rowArr.length;
					}
		// 			w2ui['grid_job_detail'].refresh();
				},complete: function () {}
			});
			
		});
		w2ui['grid_job_detail'].unlock();
	}
}

function initItnbrGrid() {
// 	console.info('initItnbrGrid()');	
	$('#grid_itnbrlist').w2grid({
		name : 'grid_itnbrlist',
		show : {
			lineNumbers : true,
			selectColumn: true,
            footer: true
        },
		columns : [
			{ field:'matnr', caption:'자재', size:'25%', sortable:true},	//key: true
			{ field:'maktx', caption:'자재내역', size:'35%', sortable:true},
			{ field:'bdmng', caption:'소요량', size:'15%', sortable:true},
			{ field:'sernp', caption:'일련번호', size:'15%', sortable:true},
			{ field:'meins', caption:'단위', hidden:true},
			{ field:'kzumw', caption:'등급관리', hidden:true},
			{ field:'rspos', caption:'예약품목번호', hidden:true},
			{ field:'aufnr', caption:'생산오더번호', hidden:true},
			{ field:'lgort', caption:'lgort', hidden:true},
			{ field:'remain_bdmng', caption:'투입필요수량', size:'10%', sortable:true},
		],
		recordHeight : 30,
		sortData : [{field: 'matnr', direction: 'ASC'}],
		records : [],
		total : 0,
		onColumnClick : function(event) {
			itnbrlist_grid_color();			
		}
	});
}

var matSelectObj = {};//page:[matnr,matnr,matnr]
function initMaterialGrid() {
	$("#grid_materiallist").w2grid({
		name : 'grid_materiallist',
		show : {
			lineNumbers : true,
			selectColumn: true,
            footer: true
        },
		columns : [
			{ field:'matnr', caption:'자재코드', size:'100px', sortable:true},	//key:true
			{ field:'maktx', caption:'자재내역', size:'130px', sortable:true},
			{ field:'wrkst', caption:'Spec.', size:'130px', sortable:true},
			{ field:'vtext', caption:'제품군명', hidden:true},
			{ field:'wgbez', caption:'자재그룹명', hidden:true},
			{ field:'date_created', caption:'생성일자', hidden:true},
			{ field:'date_updated', caption:'수정일자', hidden:true},
			{ field:'meins', caption:'단위', size:'30px'},
			{ field:'lgpro', caption:'lgpro', hidden:true},
			{ field:'kzumw', caption:'kzumw', hidden:true},
			{ field:'sernp', caption:'sernp', hidden:true}
		],
		recordHeight : 30,
		sortData : [{field: 'matnr', direction: 'ASC'}],
		records : [],
		total : 0,
	    onSelect : function(event) {
	    	event.onComplete = function (a) {
				if( matSelectObj[page]==undefined){
					matSelectObj[page] = [];
				}
	    		matSelectObj[page].push(w2ui.grid_materiallist.get(event.recid).matnr);
	    	};
		},
		onUnselect: function(event) {
			event.onComplete = function () {
				if( event.recid!=undefined ){
					var marnr = w2ui.grid_materiallist.get(event.recid).matnr;
					if( matSelectObj[page].length>0 ){
						$.each(matSelectObj[page], function(idx, item){
							if(marnr==item) {
								matSelectObj[page].splice(idx, 1);
							}
						});
					}
				}
			}
	    }
	});
}

function initNewItnbrGrid() {
//   	console.log('initNewItnbrGrid()');
	$("#grid_addItnbr_list").w2grid({
		name : 'grid_addItnbr_list',
		show : {
			lineNumbers : true,
			selectColumn: true,
            footer: true
        },
		columns : [
			{ field:'matnr', caption:'자재', size:'25%', sortable:true},	//key: true
			{ field:'bdmng', caption:'투입량', size:'15%', sortable:true, editable:function(record, index, col_index){
				if( record.pordno==undefined ) {
					return { type: 'text'};
				} else { return false;}
			}},
			{ field:'sernr', caption:'일련번호', size:'40%', sortable:true, editable: function(record, index, col_index){
				if (record.sernp=='V001')	return { type: 'text'};
				else	return false;	}, render:function(record, index, col_index){
						if (record.sernp!='V001') {
							return '시리얼 입력 비대상';
						} else return this.getCellValue(index, col_index);}},
			{ field:'lgort', caption:'저장위치', size:'15%', sortable:true},
			{ field:'meins', caption:'단위', hidden:true},
			{ field:'sernp', caption:'', hidden:true},
			{ field:'rspos', caption:'예약품목번호', hidden:true},
			{ field:'aufnr', caption:'생산오더번호', hidden:true},
			{ field:'pordno_pop', caption:'pordno_pop', hidden:true},
			{ field:'lgort', caption:'lgort', hidden:true},
			{ field:'sernr_seq', caption:'sernr_seq', hidden:true}
			],
		recordHeight : 30,
		sortData : [{field: 'matnr', direction: 'ASC'}],
		records : [],
		total : 0,
	    onSelect : function(event) {
			event.onComplete = function () {
				if(event.column == '3') {
					var selectRow = w2ui.grid_addItnbr_list.get(w2ui.grid_addItnbr_list.getSelection());
					if(selectRow[0].lgort.length == 0) {
						$("#grade_loc_matnr_2").val(selectRow[0].matnr);
// 						$("#grade_loc_add_2").modal('show');
					}
				}
			}	    	
	    }  ,
	    onChange: function(event) {	
			 var selection = w2ui.grid_addItnbr_list.getSelection();
			 var selectData = w2ui.grid_addItnbr_list.get(selection);
	    	  event.onComplete = function() {
	    		  $.each(selectData, function(idx, row) {
		    			var change = row.w2ui.changes;
						if( change.fw_gubun!=undefined )
							row.sernr = change.sernr;
						
						if(change.sernr != undefined )
						{
			    			if(change.sernr.length > 30 && Left(change.sernr,2) == 01  ){
			    				console.log(" Right(change.sernr,9)" ,  Right(change.sernr,9));
			    				change.sernr = Right(change.sernr,9);  
			    			}
						}
		  			});  
	    	 	};
		}
	});
}

function Left(str,n){
    if (n <= 0){
       return "";
    }else if (n > String(str).length){
       return str;
    }else{
       return String(str).substring(0,n);
    }
}

function Right(str,n){
    if (n <= 0){
       return "";
    }else if (n > String(str).length){
       return str;
    }else{
       var iLen = String(str).length;
       return String(str).substring(iLen, iLen - n);
    }
}

function reloadNewItnbrGrid() {
//  	console.info('reloadNewItnbrGrid()');
	
 	w2ui.grid_addItnbr_list.clear();

 	// selection validate???
 	if( w2ui.grid_job.getSelection().length>0 ){
	 	var selGridRowData = w2ui.grid_job.get(w2ui.grid_job.getSelection()[0]);
	 	var page_url = "/frontend/prod/selectSernrManageTbl"
	 				 + "?pordno_pop=" + encodeURIComponent(selGridRowData.pordno_pop)
	 				 + "&routing_no=" + encodeURIComponent(selGridRowData.routing_no);
	 	
	 	w2ui['grid_addItnbr_list'].lock('loading...', true);
	 	$.ajax({
			url : page_url,
			type : "POST",
			async:false,
			success : function(data, textStatus, jqXHR) {
				if(data.status == 200 && (data.rows).length>0 ) {
					rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
					});
					w2ui['grid_addItnbr_list'].records = rowArr;
					w2ui['grid_addItnbr_list'].total = rowArr.length;
				}
				w2ui['grid_addItnbr_list'].refresh();
				w2ui['grid_addItnbr_list'].unlock();
			},
			error : function(jqXHR, textStatus, errorThrown) {},
			complete : function() {}
		});
 	}
}

// 공정불량처리 popup grid
function fnLoadProdFaultListGrid() {
// 	console.log('fnLoadProdFaultListGrid()');
	$("#grid_prod_fault_list").w2grid({
		name: 'grid_prod_fault_list',
		show : {
			lineNumbers : true,
            footer: true
        },
		columns : [
			{ field:'aufnr', caption:'지시번호', size:'80px', sortable:true, style:'text-align:center'},
			{ field:'werks', caption:'플랜트', size:'50px', sortable:true, render:function(record, index, col_index){
				if (this.getCellValue(index, col_index)=='1110')
					return '의료';
				else
					return '광영상';
			}, style:'text-align:center'},
			{ field:'lgort', caption:'창고', size:'70px', sortable:true},
			{ field:'matnr', caption:'자재', size:'100px', sortable:true},
			{ field:'maktx', caption:'자재내역', size:'150px', sortable:true},
			{ field:'wrkst', caption:'자재스펙', size:'150px', sortable:true},
			{ field:'menge', caption:'수량', size:'50px', sortable:true, render:'int'},
			{ field:'meins', caption:'단위', size:'50px', sortable:true, style:'text-align:center'},
			{ field:'sernr', caption:'시리얼', size:'120px', sortable:true},
			{ field:'org_remark', caption:'메모', size:'150px', sortable:true, editable: { type: 'text'}},
			{ field:'org_issue_memo', caption:'불량내역', size:'150px', sortable:true},
			{ field:'org_issue_code', caption:'org_issue_code', size:'120px', sortable:true, hidden:true}			
		],
		recordHeight : 30,
		sortData : [{field: 'aufnr', direction: 'ASC'}],
		records : [],
		total : 0,
	    onSelect : function(event) {}
	});
}

function fnLoadFaultListGrid() {
// 	console.log('fnLoadFaultListGrid()');
	$("#grid_fault_list").w2grid({
		name : 'grid_fault_list',
		columns : [
			{ field:'gubun', caption:'구분', size:'55px', sortable:true},
			{ field:'matnr', caption:'자재', size:'95px', sortable:true},
			{ field:'maktx', caption:'자재내역', size:'100px', sortable:true},
			{ field:'wrkst', caption:'자재스펙', size:'90px', sortable:true},
			{ field:'meins', caption:'단위', size:'40px', sortable:true},
			{ field:'menge', caption:'수량', size:'50px', sortable:true, editable: { type: 'text'}},
			{ field:'sernp', caption:'시리얼대상여부', size:'100px', sortable:true, style:'font-weight:bold;color:blue;background-color:rgba(255,255,0,0.3);text-align:center',
				render:function(record, index, col_index){
					if (this.getCellValue(index, col_index)=='V001')
						return '시리얼 대상';
					else
						return '시리얼 미대상'; } },
			{ field:'sernr', caption:'시리얼', size:'110px', sortable:true, 
				editable: function(record, index, col_index){
					if (this.getCellValue(index, col_index-1)=='V001') 
						return { type: 'text'};
					else
						return false;	} },
			{ field:'lgort', caption:'저장창고', size:'50px'},
			{ field:'rfc_chk', caption:'리버스여부', size:'50px', hidden:true},
			{ field:'org_remark', caption:'메모', size:'120px', sortable:true, editable: { type: 'text'}},
			{ field:'org_issue_memo', caption:'불량내역', size:'120px', sortable:true},
			{ field:'org_issue_code', caption:'org_issue_code', hidden:true},
			{ field:'aufnr', caption:'aufnr', hidden:true},
			{ field:'werks', caption:'werks', hidden:true},
			{ field:'sernr_seq', caption:'sernr_seq', hidden:true},
			{ field:'org_menge', caption:'org_menge', hidden:true},
		],
		recordHeight : 30,
		sortData : [{field: 'matnr', direction: 'ASC'}],
		records : [],
		total : 0,
		onSelect: function(event){
			event.onComplete = function () {
				if(event.column == '8') {
					var selectRow = w2ui.grid_fault_list.get(w2ui.grid_fault_list.getSelection());
// 					console.log(selectRow[0].kzumw);
					if(selectRow[0].kzumw == 'Y') {
						$("#grade_loc_matnr").val(selectRow[0].matnr);
						$("#grade_loc_add").modal('show');
					}
				}
			}
		},
		onChange : function(event) {
			event.onComplete = function () {
				if(event.column == '5' && w2ui.grid_fault_list.records[event.recid-1].sernp == 'V001') {

					var old_records = w2ui.grid_fault_list.records;
					var new_records = {};
					var old_recordsCnt = w2ui.grid_fault_list.records.length;
					
					new_records = old_records;			
					
					for(var i=0 ; i<event.value_new; i++) {
						
						var tmpObj = {};
						
						tmpObj.recid = (old_recordsCnt + 1) + i;
						tmpObj.gubun = old_records[event.recid-1].gubun;
						tmpObj.matnr = old_records[event.recid-1].matnr;
						tmpObj.maktx = old_records[event.recid-1].maktx;
						tmpObj.wrkst = old_records[event.recid-1].wrkst;
						tmpObj.meins = old_records[event.recid-1].meins;
						tmpObj.menge = old_records[event.recid-1].menge;
						tmpObj.sernp = old_records[event.recid-1].sernp;
						tmpObj.sernr = old_records[event.recid-1].sernr;
						tmpObj.rfc_chk = old_records[event.recid-1].rfc_chk;
						tmpObj.org_remark = old_records[event.recid-1].org_remark;
						tmpObj.org_issue_memo = old_records[event.recid-1].org_issue_memo;
						tmpObj.org_issue_code = old_records[event.recid-1].org_issue_code;
						tmpObj.aufnr = old_records[event.recid-1].aufnr;
						tmpObj.werks = old_records[event.recid-1].werks;
						tmpObj.lgort = old_records[event.recid-1].lgort;
						tmpObj.sernr_seq = old_records[event.recid-1].sernr_seq;
						tmpObj.org_menge = old_records[event.recid-1].org_menge;

						new_records.push(tmpObj);	
					}
					new_records.splice(event.recid-1,1);
					w2ui.grid_fault_list.clear();
					w2ui.grid_fault_list.records = new_records;
					$.each(new_records, function(idx, row){
						row.recid = idx+1;
					});
					w2ui.grid_fault_list.refresh();					
				}
			}
	    }      
	});
}

function fnLoadWorkerAddGrid() {
// 	console.log('fnLoadWorkerAddGrid()');
	$("#grid_worker").w2grid({
		name : 'grid_worker',
		show : {
			lineNumbers : true,
			selectColumn: true,
            footer: true
        },
        columns : [ 
			{field : 'member_emp_no', caption:'사원번호', size:'25%',sortable : true}, 
			{field : 'member_id', caption: 'ID', size:'25%', sortable : true}, 
			{field : 'member_nm', caption: '사원명', size:'25%', sortable : true}, 
			{field : 'dept_cd', caption: '구분', size:'25%', sortable : true} ],
		recordHeight : 30,
		sortData : [{field: 'member_emp_no', direction: 'ASC'}],
		records : [],
		total : 0
	});
}

function loadList(pageNum) {
// 	console.log('loadList()');
	w2ui['grid_materiallist'].selectNone();
	
	if( pageNum==undefined ){
		page=1;
		pageNum = 0;
	} else {
		page=pageNum;
		pageNum = (pageNum-1)*rowPerPage;
// 		pageNum = pageNum-1;
	}
	var selectJob = w2ui.grid_job.get(w2ui.grid_job.getSelection()[0]);
	var page_url = '/frontend/hub/material_recv_master_select_w2ui'
			  	 + '?werks=' + encodeURIComponent(selectJob.dept_cd)
			  	 + '&page=' + encodeURIComponent(pageNum)
			  	 + '&rows=' + encodeURIComponent(rowPerPage);
	
	if($("#m_matnr").val()!=undefined && $("#m_matnr").val()!='' ){
		page_url += '&matnr=' + encodeURIComponent($("#m_matnr").val()); 
	}
	if($("#m_wrkst").val()!=undefined && $("#m_wrkst").val()!='' ){
		page_url += '&wrkst=' + encodeURIComponent($("#m_wrkst").val()); 
	}
	if($("#m_maktx").val()!=undefined && $("#m_maktx").val()!='' ){
		page_url += '&maktx=' + encodeURIComponent($("#m_maktx").val()); 
	}
	w2ui['grid_materiallist'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : "POST",
		async:false,
		success : function(data, textStatus, jqXHR) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				if(data.pageTotal == 0){
					$("#pagination").empty();
				} else {
					totalPage = data.pageTotal;
					pagination();
				}
				w2ui['grid_materiallist'].records = rowArr;
				w2ui['grid_materiallist'].total = data.rowTotal;
			}
			w2ui['grid_materiallist'].refresh();
			w2ui['grid_materiallist'].unlock();
			if(matSelectObj[page]!=undefined){
				$.each(w2ui.grid_materiallist.records, function(i, row){
					$.each(matSelectObj[page], function(idx, itnbr){
						if( row.matnr==itnbr ){
							w2ui.grid_materiallist.select(row.recid);
						}
					});
				});
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
		},
		complete : function() {
		}
	});
}

function changeMatGubun() {
// 	console.log('changeMatGubun()');
	
	if ( w2ui.grid_job.getSelection().length==0 ) {
		$("#exe_btn_area").hide();
		$("#grid_job").css("height","650px");
	} else {
		var selectJob = w2ui.grid_job.get(w2ui.grid_job.getSelection()[0]);
		if( $("#gubun").val()=='basic' ){
			$("#grid_itnbrlist").show();
			$("#grid_materiallist").hide();
			$("#matSearch").hide();
			$("#pagination").hide();
			var page_url = "/sap_master/ziffm_mes_pp004"
				 + "?func_name=" + encodeURIComponent("ZIFFM_MES_PP004")
				 + "&IV_AUFNR=" + encodeURIComponent(selectJob.pordno)
				 + "&IV_IF=X";
			w2ui['grid_itnbrlist'].lock('loading...', true);
		 	$.ajax({
				url : page_url,
				type : "POST",
				async:false,
				success : function(data, textStatus, jqXHR) {
					if(data.status == 200 && (data.rows).length>0 ) {
						rowArr = data.rows;
						$.each(rowArr, function(idx, row){
							row.recid = idx+1;
						});
						w2ui['grid_itnbrlist'].records = rowArr;
						w2ui['grid_itnbrlist'].total = rowArr.length;
					}
					w2ui['grid_itnbrlist'].refresh();
					w2ui['grid_itnbrlist'].unlock();
				},
				error : function(jqXHR, textStatus, errorThrown) {					
				},
				complete : function() {
					in_remain_cnt(rowArr, loadNewItnbrGridData(selectJob.pordno_pop));
				}
			});
		}else{	// mat
			$("#grid_itnbrlist").hide();
			$("#grid_materiallist").show();
			$("#pagination").show();
			$("#matSearch").show();
			loadList();
		}
	}
}

function setMaterial() {
// 	console.log('setMaterial()');
	
	w2ui.grid_itnbrlist.clear();
	w2ui.grid_addItnbr_list.clear();
	
 	reloadNewItnbrGrid();
 	changeMatGubun();
}

function addItnbrDetail() {
// 	console.log('addItnbrDetail()');
	
	var gridDataArr = w2ui.grid_addItnbr_list.records;
	var addMatObj = [];
	// 추가하려는 목록이 선택 되었는가?
	if( $("#gubun").val()=='basic' ){
		if( (w2ui.grid_itnbrlist.getSelection()).length==0 ){
			fnMessageModalAlert("Warning", "추가하려는 항목을 선택해야 합니다.");
			return;
		} else {
			var imsiMatObj = w2ui.grid_itnbrlist.get(w2ui.grid_itnbrlist.getSelection());
			var tmpList = [];
			$.each(imsiMatObj, function(idx, row){
// 				console.log(row.bdmng);
				if( row.sernp=='V001' ){
					for(var i=0; i<Number(row.bdmng); i++) {
						var tmp = {};
						tmp.matnr = row.matnr;	//
						tmp.bdmng = 1;	//
						tmp.meins = row.meins;	//
						tmp.kzumw = row.kzumw;
						tmp.sernp = row.sernp;
						tmp.sernr = '';
						tmp.sernr_seq = '';
						tmp.rspos = row.respo;	//
						tmp.aufnr = row.aufnr;//
						tmp.lgort = row.lgort;//
						tmpList.push(tmp);
					}
				} else {
					var tmp = {};
					tmp.matnr = row.matnr;	//
					tmp.bdmng = row.remain_bdmng;	//
					tmp.meins = row.meins;	//
					tmp.kzumw = row.kzumw;
					tmp.sernp = row.sernp;
					tmp.sernr = '';
					tmp.sernr_seq = '';
					tmp.rspos = row.respo;	//
					tmp.aufnr = row.aufnr;//
					tmp.lgort = row.lgort;//
					tmpList.push(tmp);
				}
			});
			addMatObj = tmpList;
		}
	} else {
		if( (w2ui.grid_materiallist.getSelection()).length==0 ){
			fnMessageModalAlert("Warning", "추가하려는 항목을 선택해야 합니다.");
			return;
		} else {
			var matList = w2ui.grid_materiallist.get(w2ui.grid_materiallist.getSelection());
			var tmpList = [];
			$.each(matList, function(idx, row){
				var tmp = {};
				tmp.matnr = row.matnr;
				tmp.bdmng = 1;
				tmp.meins = row.meins;
				tmp.kzumw = row.kzumw;
				tmp.sernp = row.sernp;
				tmp.sernr = '';
				tmp.sernr_seq = '';
				tmp.rspos = '';
				tmp.aufnr = '';
				tmp.lgort = getFromLgort();
				tmpList.push(tmp);
			});
			addMatObj = tmpList;
		}
	}
	
	var initRecid = w2ui.grid_addItnbr_list.records.length + 1;
	$.each(addMatObj, function(idx, row){
		row.recid = initRecid + idx;
		if(row.kzumw == 'Y') {
			row.lgort = '';
		}
	});

// 	console.warn(addMatObj);
	// 기존에 추가된 항목인지 확인
	if( gridDataArr.length>0 ){
		w2ui.grid_addItnbr_list.add(addMatObj);
		w2ui.grid_addItnbr_list.refresh();
		$.each(w2ui.grid_addItnbr_list.records, function(idx, row){
			row.recid = idx+1;
		});
	}else{
// 		console.log("new");
		w2ui.grid_addItnbr_list.clear();
		w2ui.grid_addItnbr_list.refresh();
		$.each(addMatObj, function(idx, row){
			row.recid = idx+1;
		});
		w2ui.grid_addItnbr_list.records = addMatObj;
		w2ui.grid_addItnbr_list.refresh();
		$.each(w2ui.grid_itnbrlist.records, function(idx, row){
			row.recid = idx+1;
		});
		w2ui.grid_itnbrlist.refresh();
		in_remain_cnt(w2ui.grid_itnbrlist.records, loadNewItnbrGridData($("#m_dsa_mes_po").val()));
	}
	w2ui.grid_addItnbr_list.refresh();
}

// remove new itnbr list
function deleteItnbrDetail() {
// 	console.log(w2ui.grid_addItnbr_list.records);
	var selection = w2ui.grid_addItnbr_list.getSelection();
	$.each(selection, function(idx, sel){
		w2ui.grid_addItnbr_list.select(sel);
	});
	w2ui.grid_addItnbr_list.delete(true);
}

function registSerial() {
// 	console.log('registSerial()');
	
	var rfcData = w2ui.grid_addItnbr_list.records;
	var addList = w2ui.grid_addItnbr_list.getSelection();
	if ( addList>1 ) {
		var ckCnt = 0;
		$.each(w2ui.grid_addItnbr_list.get(addList), function(idx, row){
			if(row.sernp == 'V001') ckCnt++;
		});
		if( ckCnt>1 ) {
			fnMessageModalAlert("Warning", "대표시리얼 등록 시 한개의 공정투입 자재를 선택하여야 합니다.");
			return;
		}
	}
	
// 	for(var i=0 ; i<rfcData.length; i++) {
// 		if(rfcData[i].lgort.length == 0) {
// 			fnMessageModalAlert("Notification(SHIP)", "투입 요청 자재의 저장위치를 설정해주세요.");
// 			return;
// 		} 
// 	}
	var selectJobKey = w2ui.grid_job.getSelection()[0];
	
	if ( w2ui.grid_job.getSelection().length == 0 ) {
		fnMessageModalAlert("Warning", "선택된 작업이 없습니다.");
		return;
	}
	if ( w2ui.grid_addItnbr_list.getSelection().length == 0 ) {
		fnMessageModalAlert("Warning", "선택된 투입자재가 없습니다.");
		return;
	}
	if ( w2ui.grid_addItnbr_list.getSelection().length > 1 ) {
		fnMessageModalAlert("Warning", "대표시리얼 등록시 1개의 공정투입 자재를 선택해야 합니다.");
		return;
	}
	// 선택된 항목의 개수만큼 시리얼 번호가 있어야 한다.
	var selectRows = w2ui.grid_addItnbr_list.get(w2ui.grid_addItnbr_list.getSelection()[0]);
	if( selectRows.w2ui!=undefined ){
		selectRows.sernr = selectRows.w2ui.changes.sernr; 
	}
	if( selectRows.sernr==undefined || selectRows.sernr=='' ) {
		fnMessageModalAlert("Warning", "선택한 항목의 시리얼이 입력되지 않았습니다.");
		return;
	}
	
	var selectedAll = w2ui.grid_job.get(w2ui.grid_job.getSelection());
	var pordnoArr = [];
	$.each(selectedAll, function(idx, row){
		pordnoArr.push(row.pordno);
	});
	var uniqArr = $.unique(pordnoArr);
	if( uniqArr.length>1 ){
		fnMessageModalAlert("Warning", "한개의 작업번호에 대하여 작업을 실행할 수 있습니다.");
		return;
	}
	
	/////////////////////////////////////////////////////////////
	
	for(var i=0;i<rfcData.length;i++) {
		
		var row = rfcData[i];
		
		if(row.w2ui!=undefined) {
			row.sernr = row.w2ui.changes.sernr;
			if( row.w2ui.changes.bdmng!=undefined ) {
				row.bdmng = row.w2ui.changes.bdmng;
			}
			delete row['w2ui'];
		} 
		
		if(row.lgort.length == 0) {
			var loc = sernr_stock_chk('1210', row.matnr, row.sernr);
			console.log("loc!!!!!!!!!!!! :: " + loc);
			console.log("loc.length :: " + loc.length);
			if(loc.length == 0) {
				fnMessageModalAlert("Notification(MES)",	"입력하신 시리얼은 등급창고에 재고가 없어 투입이 불가합니다.<br>확인해주세요.");
				return;
			} else {
				row.lgort = loc;	
			}
		} 

	}
	
	//////////////////////////////////////////////////////////////
// 	var postData = $("#frm_main_serial").serializeArray();
	var selData = selectedAll[0];
	var selDataArr = [];
	selDataArr.push(selData);
 	selData.project_no = selectRows.sernr;
	var page_url = "/frontend/prod/main_serial_add";
	var postData = "pordno=" +  encodeURIComponent(selData.pordno)
				 + "&project_no=" +  encodeURIComponent(selData.project_no)
				 + "&fedat=" +  encodeURIComponent(selData.fedat)
				 + "&sedat=" +  encodeURIComponent(selData.sedat)
				 + "&params=" +  encodeURIComponent(JSON.stringify(selDataArr));
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async:false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200" && data.result=="S") {
				fnMessageModalAlert("Success", "선택된 작업의 시리얼등록을 성공했습니다.");
				fnSaveDetailSerial();
			} else {
				fnMessageModalAlert("Fail", "선택된 작업의 시리얼등록을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "선택된 작업의 시리얼등록 중 오류가 발생하였습니다.");
		},
		complete : function() {
			clearList();
			reloadJobList(selectJobKey);
// 			$("#modal_main_serial_add").modal('hide');
		}
	});
}

function fnProdFaultConf() {
// 	console.log('fnProdFaultConf()');

	var gridDataArr = w2ui.grid_prod_fault_list.records;
	// 데이터 유무 확인 
	if(gridDataArr.length == 0) {
		fnMessageModalAlert("Warning", "처리할 데이터가 존재하지 않습니다.");
 		return;
	}
	
	var issueChkCnt = 0;
	$.each(gridDataArr, function(idx, row){
		if(row.w2ui!=undefined){
			row.org_remark = row.w2ui.changes.org_remark;
		}
		if(row.org_remark==undefined || row.org_remark==null || row.org_remark=='')
			issueChkCnt++;
	});
	if(issueChkCnt>0){
		fnMessageModalAlert("Warning", "불량확정 대상목록 중 불량 내역이 입력되지 않은 항목이 있습니다.");
 		return;
	}
// 	console.log(gridDataArr);
	
	var jsonStr = JSON.stringify(gridDataArr);
	var jobData = w2ui.grid_job.get(w2ui.grid_job.getSelection()[0]);
	/********************* 데이터 insert 및 rfc 전송 : Start*********************/
	var page_url = "/frontend/prod/fnProdFaultConf";
	var postData = 'jsonStr=' + encodeURIComponent(jsonStr);
		postData += '&pordno_pop=' + encodeURIComponent(jobData.pordno_pop);
		postData += '&routing_no=' + encodeURIComponent(jobData.routing_no);
		postData += '&t_gubun=' + encodeURIComponent("tw");

	$.ajax({
	    url: page_url,
	    data: postData,
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
// 	    	console.log(data);
	    	if(data.status == "200") {
	    		fnMessageModalAlert("Success", "정보를 저장했습니다.");	
	    	} else {
	    		fnMessageModalAlert("Fail", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Error", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
// 	    	console.log('여기 타냐 앟마닫.다.ㄹㄷ.닫ㄹ.ㄹ다.ㄷ라');
			clearList();
	    	reloadJobList();
// 	    	w2ui.grid_job.select(selectJobKey);
	    }
	});
	/********************* 데이터 insert 및 rfc 전송 : End*********************/
}

function pordFaultProc() {
// 	console.log('pordFaultProc()');

	w2ui.grid_prod_fault_list.clear();

	var arrObj = [];
	if( w2ui.grid_job.getSelection().length==0 ){
		fnMessageModalAlert("Warning", "선택된 작업이 없습니다.");
		return;
	}
	if( w2ui.grid_job.getSelection().length>1 ){
		fnMessageModalAlert("Warning", "작업목록에서 한건의 작업을 선택하시기 바랍니다.");
		return;
	}
	var rowData = w2ui.grid_job.get(w2ui.grid_job.getSelection()[0]);
// 	console.log(rowData);
	var project_no = rowData.project_no;
	
	if(rowData.itnbr.length !=0) {
		var page_url = '/frontend/hub/material_recv_master_select_nopage'	
					 + '?matnr=' + encodeURIComponent(rowData.itnbr)
					 + '&werks=' + encodeURIComponent(rowData.dept_cd);
		var dataArr = [];
		$.ajax({
			url : page_url,
			type : "POST",
			async:false,
			success : function(data, textStatus, jqXHR) {
				var datarows = data.rows;
				var recordsCnt = w2ui.grid_prod_fault_list.records.length;
				if (data.status == "200") {
					if( datarows.length>0 ){
						$.each(datarows, function(idx, row){
							var tmpObj = {};
							tmpObj.recid = (recordsCnt + 1) + idx;
							tmpObj.aufnr = rowData.pordno;
							tmpObj.werks = rowData.dept_cd;
							tmpObj.matnr = rowData.itnbr;
							tmpObj.maktx = row.maktx;	
							tmpObj.wrkst = row.wrkst;
							tmpObj.meins = row.meins;
							tmpObj.lgort = rowData.lgort;
							tmpObj.menge = rowData.pdqty;
							tmpObj.sernr = rowData.project_no;
							dataArr.push(tmpObj);
						});
						w2ui.grid_prod_fault_list.add(dataArr);
						w2ui.grid_prod_fault_list.total = recordsCnt + dataArr.length;
					}
				} else {
					fnMessageModalAlert("Fail", "데이터를 불러오지 못했습니다.");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("Fail", "데이터를 불러오지 못했습니다.");
			}
		});
	}else {
		var dataArr = [];
		var tmpObj = {};
		tmpObj.recid = 1;
		tmpObj.aufnr = rowData.pordno;
		tmpObj.werks = dept_cd;
		tmpObj.matnr = '';
		tmpObj.maktx = '';	
		tmpObj.wrkst = '';
		tmpObj.meins = '';
		tmpObj.lgort = rowData.lgort;
		tmpObj.menge = rowData.pdqty;
		tmpObj.sernr = rowData.project_no;
		dataArr.push(tmpObj);
		w2ui.grid_fault_routing_list.add(dataArr);
		w2ui.grid_fault_routing_list.total = dataArr.length;
	}
	initOptions($('#p_sel_step1'));
	initOptions($('#p_sel_step2'));
	initOptions($('#p_sel_step3'));
	initOptions($('#p_sel_step4'));
	p_makeSelStep1();

	$("#pord_fault_mng").modal('show');
	setTimeout(function(){
		w2ui.grid_prod_fault_list.resize();
		w2ui.grid_prod_fault_list.refresh();
	}, 200);
}

function p_makeSelStep1() {
// 	console.log('makeSelStep1()');
	
	var page_url = "/frontend/scm/issue_getStep1";
	$.ajax({
	    url: page_url,
	    data: '',
	    type: "POST",
	    async:false,
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
	    		fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
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
	    async:false,
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
	    async:false,
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

function input_prod_fault_code() {
	var record = w2ui.grid_prod_fault_list.get(w2ui.grid_prod_fault_list.getSelection()[0]);
		
	var sel_step1 = $("#p_sel_step1").val();
	var sel_step2 = $("#p_sel_step2").val();
	var sel_step3 = $("#p_sel_step3").val();
	var sel_step4 = $("#p_sel_step4").val();
	
	var sel_step1_t = $("#p_sel_step1 option:selected").text();
	var sel_step2_t = $("#p_sel_step2 option:selected").text();
	var sel_step3_t = $("#p_sel_step3 option:selected").text();
	var sel_step4_t = $("#p_sel_step4 option:selected").text();
	
	if(w2ui.grid_prod_fault_list.getSelection().length == 0) {
		fnMessageModalAlert("Warning", "불량코드가 입력 될 자재불량내역을 선택해 주세요.");
		return;
	}
	
	if(sel_step4_t == '' || sel_step4_t == '-') {
		fnMessageModalAlert("Warning", "lv.03 까지 불량내역을 지정해주세요.");
		return;
	}
	
	record.org_issue_memo = sel_step4_t;
	record.org_issue_code = sel_step4;
	w2ui.grid_prod_fault_list.set(w2ui.grid_prod_fault_list.getSelection()[0], record);
}

function getFromLgort() {
	console.log('getFromLgort()');
	var selectJob = (w2ui.grid_job.get(w2ui.grid_job.getSelection()[0]));
	var page_url = "/frontend/prod/mes_wkctr_tbl_select"	
			 + "?dept_cd=" + encodeURIComponent(selectJob.dept_cd)
			 + "&wkctr=" + encodeURIComponent(selectJob.wkctr);
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

// var addItnbrData;
// var ItnbrData;
function fnFaultMatnrConf() {
// 	console.log('fnFaultMatnrConf()');
	$('.h_flag').show();
	gnrFaultMantrFlag = 's';
	
	w2ui.grid_fault_list.clear();
	
	if( w2ui.grid_job.getSelection().length==0 ){
		fnMessageModalAlert("Warning", "체크된 작업이 없습니다.");
		return;
	}

	var uniqMatnrArr = []; 
	var totalMatnrArr = []; 
	
	var fromLgort = getFromLgort();
	
	var grid_addItnbr_list_data = w2ui.grid_addItnbr_list.get(w2ui.grid_addItnbr_list.getSelection());
	var grid_itnbrlist_data = w2ui.grid_itnbrlist.get(w2ui.grid_itnbrlist.getSelection()); 
	var grid_materiallist_data = w2ui.grid_materiallist.get(w2ui.grid_materiallist.getSelection());

	var grid_materiallist_selcData = [];  
	var grid_itnbrlist_selcData = [];    
	var grid_addItnbr_list_selcData = [];

	for(var i=0 ; i<grid_materiallist_data.length; i++) {
		var tmp_obj = grid_materiallist_data[i];
		tmp_obj.gubun = "일반자재"
		grid_materiallist_selcData.push(tmp_obj);
		totalMatnrArr.push(tmp_obj.matnr);
	}
	for(var i=0 ; i<grid_itnbrlist_data.length; i++) {
		var tmp_obj = grid_itnbrlist_data[i];
		tmp_obj.gubun = "일반자재"
		grid_itnbrlist_selcData.push(tmp_obj);
		totalMatnrArr.push(tmp_obj.matnr);
	}
	for(var i=0 ; i<grid_addItnbr_list_data.length; i++) {
		var tmp_obj = grid_addItnbr_list_data[i];
		
	    if(tmp_obj.sernr_seq == false) {
	    	fnMessageModalAlert("Warning", "공정투입자재 내역에 등록처리 되지 않은 자재가 있습니다.");
			return;
	    }
		
		tmp_obj.gubun = "투입자재"
		grid_addItnbr_list_selcData.push(tmp_obj);
		totalMatnrArr.push(tmp_obj.matnr);
	}

	var uniqMatnrArr = $.unique(totalMatnrArr);

	if(uniqMatnrArr.length==0) {
		fnMessageModalAlert("Warning", "체크된 자재 목록이 없습니다.");
		return;
	}

 	var itnbr_data;
 	var grid_fault_list_data = [];
 	var selectedData = w2ui.grid_job.get(w2ui.grid_job.getSelection()[0]);
 	
	var page_url = '/frontend/hub/material_recv_master_select_nopage'	
				 + "?matnrs=" + encodeURIComponent(String(uniqMatnrArr))
				 + "&werks=" + encodeURIComponent(selectedData.dept_cd);
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
	
	
	var initRecid = w2ui.grid_fault_list.records.length + 1;
	var rowNo = 0;
	
	$.each(grid_materiallist_selcData, function(idx, mat){
		var tmpObj = {};
		$.each(itnbr_data, function(i, obj){
			if( obj.matnr==mat.matnr ) {
				tmpObj.recid = initRecid + rowNo; 
				tmpObj.aufnr = selectedData.pordno;
				tmpObj.werks = selectedData.dept_cd;
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
				rowNo++;
			}
		});
	});
	
	$.each(grid_itnbrlist_selcData, function(idx, mat){
		var tmpObj = {};
		$.each(itnbr_data, function(i, obj){
			if( obj.matnr==mat.matnr ) {
				tmpObj.recid = initRecid + rowNo; 
				tmpObj.aufnr = selectedData.pordno;
				tmpObj.werks = selectedData.dept_cd;
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
				rowNo++;
			}
		});
	});
	
	$.each(grid_addItnbr_list_selcData, function(idx, mat){
		var tmpObj = {};
		$.each(itnbr_data, function(i, obj){
			if( obj.matnr==mat.matnr ) {
				
				tmpObj.recid = initRecid + rowNo;
				tmpObj.aufnr = selectedData.pordno;
				tmpObj.werks = selectedData.dept_cd;
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
				rowNo++;
			}
		});		
	});
	
	for(var i=0 ; i<grid_fault_list_data.length; i++) {
		grid_fault_list_data[i].org_menge = Math.abs(grid_fault_list_data[i].org_menge);
		grid_fault_list_data[i].menge = Math.abs(grid_fault_list_data[i].menge); 
		w2ui.grid_fault_list.add(grid_fault_list_data[i]);	
	}

	initOptions($('#sel_step1'));
	initOptions($('#sel_step2'));
	initOptions($('#sel_step3'));
	initOptions($('#sel_step4'));
	makeSelStep1();
	
	faultRoutingProc();
	console.log(w2ui.grid_fault_list.records);
	$("#fault_mng").modal('show');
	setTimeout(function(){
		w2ui.grid_fault_routing_list.resize();
		w2ui.grid_fault_routing_list.refresh();
		
		w2ui.grid_fault_list.resize();
		w2ui.grid_fault_list.refresh();
	}, 200);
}

function makeSelStep1() {
// 	console.log('makeSelStep1()');
	
	var page_url = "/frontend/scm/issue_getStep1";
	$.ajax({
	    url: page_url,
	    data: '',
	    type: "POST",
	    async:false,
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
// 	console.log('input_code()');
	var record = w2ui.grid_fault_list.get(w2ui.grid_fault_list.getSelection()[0]);
	var sel_step1 = $("#sel_step1").val();
	var sel_step2 = $("#sel_step2").val();
	var sel_step3 = $("#sel_step3").val();
	var sel_step4 = $("#sel_step4").val();
	
	var sel_step1_t = $("#sel_step1 option:selected").text();
	var sel_step2_t = $("#sel_step2 option:selected").text();
	var sel_step3_t = $("#sel_step3 option:selected").text();
	var sel_step4_t = $("#sel_step4 option:selected").text();
	
	if(w2ui.grid_fault_list.getSelection().length == 0) {
		fnMessageModalAlert("Warning", "불량코드가 입력 될 자재불량내역을 선택해 주세요.");
		return;
	}
	
	if(sel_step4_t == '' || sel_step4_t == '-') {
		fnMessageModalAlert("Warning", "lv.03 까지 불량내역을 지정해주세요.");
		return;
	}
	
	if(sel_step4_t == '' || sel_step4_t == '-') {
		fnMessageModalAlert("Warning", "lv.03 까지 불량내역을 지정해주세요.");
		return;
	}
	record.org_issue_memo = sel_step4_t;
	record.org_issue_code = sel_step4;
	w2ui.grid_fault_list.set(w2ui.grid_fault_list.getSelection()[0], record);
}

function fnFaultConf() {
// 	console.log('fnFaultConf()');

	var jobSelect = w2ui.grid_job.get(w2ui.grid_job.getSelection()[0]);
	var gridDataArr = w2ui.grid_fault_list.records;
	// 데이터 유무 확인 
	if(gridDataArr.length == 0) {
		fnMessageModalAlert("Warning", "처리할 데이터가 존재하지 않습니다.");
 		return;
	}

	var sernrChkCnt = 0;
	var issueChkCnt = 0;
	var lgortChkCnt = 0;
	var mengeChkCnt = 0;
	
	$.each(gridDataArr, function(idx, row){
		if(row.w2ui!=undefined){
			if( row.w2ui.changes.org_remark!=undefined )
				row.org_remark = row.w2ui.changes.org_remark;
			if( row.w2ui.changes.sernr!=undefined )
				row.sernr = row.w2ui.changes.sernr;
			if( row.w2ui.changes.menge!=undefined )
				row.menge = row.w2ui.changes.menge;
		}
		if(row.sernp=='V001' && (row.sernr==''||row.sernr==undefined||row.sernr==null) )
			sernrChkCnt++;
		if( row.org_issue_code=='' || row.org_issue_code==undefined || row.org_issue_code==null )
			issueChkCnt++;
		if(row.lgort.length == 0) {
			lgortChkCnt++;
		}
		
		if(row.gubun == '투입자재' && (Number(row.menge) > Number(row.org_menge))) {
			mengeChkCnt++;
		}
	});
	
	if(mengeChkCnt>0) {
		fnMessageModalAlert("Notification(MES)", "불량처리할 수량이 투입수량보다 많은 항목이 있습니다 .<br/>수량을 확인하신 후 다시 진행해주세요.");
 		return;
	}
	if(lgortChkCnt>0) {
		fnMessageModalAlert("Warning", "저장위치가 누락된 실적이 있습니다.<br/>해당 위치를 클릭하신 뒤 창고를 입력해주세요.");
 		return;
	}
	if(sernrChkCnt>0) {
		fnMessageModalAlert("Warning", "시리얼 대상 데이터의 시리얼 입력이 되지 않았습니다.");
 		return;
	}
	if(issueChkCnt>0) {
		fnMessageModalAlert("Warning", "불량확정 데이터의 내역이 입력되지 않은 항목이 있습니다.");
 		return;
	}
	
	
	var jsonStr = JSON.stringify(gridDataArr);
	
	var v_pordno_pop = "";
	var v_routing_no = "";
	var v_dept_cd = "";
	
	if(jobSelect != undefined) {
		v_pordno_pop = jobSelect.pordno_pop;
		v_routing_no = jobSelect.routing_no;
		v_dept_cd = jobSelect.dept_cd;
	}
	
	/********************* 데이터 insert 및 rfc 전송 : Start*********************/
	var page_url = "/frontend/prod/fnFaultConf";
	var postData = "";
	if(gnrFaultMantrFlag == 'g') {
		postData = 'jsonStr=' + encodeURIComponent(jsonStr);
		postData += '&pordno_pop=' + encodeURIComponent(null);
		postData += '&routing_no=' + encodeURIComponent(null);
		postData += '&dept_cd=' + encodeURIComponent($("#s_plant").val());
		postData += '&t_gubun=' + encodeURIComponent("tp");
	} else {
		postData = 'jsonStr=' + encodeURIComponent(jsonStr);
		postData += '&pordno_pop=' + encodeURIComponent(jobSelect.pordno_pop);
		postData += '&routing_no=' + encodeURIComponent(jobSelect.routing_no);
		postData += '&dept_cd=' + encodeURIComponent(jobSelect.dept_cd);
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
	    	fnMessageModalAlert("Error", "정보를 저장하는데 에러가 발생하였습니다.");	
	    }
	});
	
	setTimeout(function(){
		w2ui.grid_materiallist.clear();
		w2ui.grid_itnbrlist.clear();
		w2ui.grid_addItnbr_list.clear();
		reloadNewItnbrGrid();		
		
		if(gnrFaultMantrFlag != 'g') {
			changeMatGubun();
		}
		
		w2ui.grid_addItnbr_list.refresh();
		w2ui.grid_materiallist.refresh();
		w2ui.grid_itnbrlist.refresh();
	}, 200);
	
	itnbrlist_grid_color();
	
	matSelectObj = {};
	/********************* 데이터 insert 및 rfc 전송 : End*********************/
}

function fnSaveDetailSerial() {
// 	console.log('fnSaveDetailSerial()');

	var rfcData = w2ui.grid_addItnbr_list.records;
// 	for(var i=0 ; i<rfcData.length; i++) {
// 		if(rfcData[i].lgort.length == 0) {
// 			var loc = sernr_stock_chk('1210', rfcData[idx].matnr, sernr);
// 			//fnMessageModalAlert("Warning", "투입 요청 자재의 저장위치를 설정해주세요.");
// 			//return;
// 		} 
// 	}
	
	var sub_sernrArr = []; 
	for(var i=0;i<rfcData.length;i++) {
		
		var row = rfcData[i];
		
		if(row.w2ui!=undefined) {
			row.sernr = row.w2ui.changes.sernr;
			if( row.w2ui.changes.bdmng!=undefined ) {
				row.bdmng = row.w2ui.changes.bdmng;
			}
			delete row['w2ui'];
		} 
		if( row.sernr!=undefined && row.sernr!='' )
			sub_sernrArr.push(row.sernr);
		
		if(row.lgort.length == 0) {
			var loc = sernr_stock_chk('1210', row.matnr, row.sernr);
			if(Number(row.bdmng) < 0) {
				row.lgort = selectPoLgort();
			} else if(loc.length == 0) {
				fnMessageModalAlert("Notification(MES)",	"입력하신 시리얼은 등급창고에 재고가 없어 투입이 불가합니다.<br>확인해주세요.");
				return;
			} else {
				row.lgort = loc;	
			}
		} 

	}
	
	var chkCnt = 0;
	$.each(rfcData, function(idx, row){
		if( row.sernp=='V001' && row.sernr=='' ) chkCnt++;
	});
	if( chkCnt>0 ){
		fnMessageModalAlert("Warning","시리얼 대상 자재가 있으나 시리얼 번호가 입력되지 않았습니다.<br>확인 후 다시 시도해 주세요");
		return;
	}
	
	console.log(rfcData);
	
	var selectJob = w2ui.grid_job.get(w2ui.grid_job.getSelection()[0]);
	var page_url = "/frontend/prod/detail_serial_add";
	var postData = "pordno_pop=" + encodeURIComponent(selectJob.pordno_pop)
				 + "&routing_no=" + encodeURIComponent(selectJob.first_routing_no)
				 + "&routing_gno=" + encodeURIComponent(selectJob.routing_gno)
				 + "&project_no=" + encodeURIComponent(selectJob.project_no)
				 + "&sub_sernr=" + encodeURIComponent(String(sub_sernrArr))
				 + "&dept_cd=" + encodeURIComponent(selectJob.dept_cd)
				 + "&lgort=" + encodeURIComponent(selectJob.lgort)	// ?
				 + "&pordno=" + encodeURIComponent(selectJob.pordno)
				 + "&params=" + encodeURIComponent(JSON.stringify(rfcData));
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async:false,
		success : function(data, textStatus, jqXHR) {
		
			if (data.zifsta == "S") {
				fnMessageModalAlert("Notification(SerialAdd)","선택된 생산지시오더의 자재투입처리를 성공했습니다.<br>"+"SAP return : " + data.zifsta	+"<br>SAP msg : " + data.zifmsg);
			} else {
				fnMessageModalAlert("Notification(SerialAdd)", "선택된 생산지시오더의 자재투입처리를 실패했습니다.<br>"+"SAP return : " + data.zifsta	+"<br>SAP msg : " + data.zifmsg);
			}
			
			searchJobDetail();
			//reloadNewItnbrGrid();
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(SerialAdd)", "선택된 생산지시오더의 자재투입처리를 실패했습니다.");
		},
		loadComplete : function(data) {
		},
		complete : function() {
// 			fnSearchDetailCodeGrid(masGridRowData.pordno);
		}
	});
	

	
	setTimeout(function(){
		w2ui.grid_materiallist.clear();
		w2ui.grid_itnbrlist.clear();
		w2ui.grid_addItnbr_list.clear();
		reloadNewItnbrGrid();		
		
		if(gnrFaultMantrFlag != 'g') {
			changeMatGubun();
		}
		
		w2ui.grid_addItnbr_list.refresh();
		w2ui.grid_materiallist.refresh();
		w2ui.grid_itnbrlist.refresh();
	}, 200);
	
	itnbrlist_grid_color();
	

}

//시작, 비가동 시작 종료, 작업 종료 공통 상태 변경
function fnWorkChnStat(flag) {
// 	console.log('fnWorkChnStat(', flag, ')');
	
	if(w2ui.grid_job.getSelection().length==0) {
		fnMessageModalAlert("Warning", "선택된 제조 오더가 없습니다.");
		return;
	}
	var selectJob = w2ui.grid_job.get(w2ui.grid_job.getSelection());
	
	var page_url = '/frontend/prod/workChangeStatus';
	var postData = 'pordno_pop=' + encodeURIComponent(selected_pordno_pop)
				 + '&routing_no=' + encodeURIComponent(selected_routing_no);
	var pdsts = 'p2';
	var success_msg = '';
	var fail_msg = '';
	if( flag=='end' ) {	// 작업종료
		pdsts = 'p6';
		success_msg = '선택된 지시가 생산완료 성공했습니다.';
		fail_msg = '선택된 지시가 생산완료 실패했습니다.';
	} else if( flag=='pause_start' ){	// 비가동 시작
		pdsts = 'p4';
		success_msg = '선택된 지시가 비가동 시작에 성공했습니다.';
		fail_msg = '선택된 지시가 비가동 시작에 실패했습니다.';
	} else if( flag=='pause_end' ){	// 비가동 종료
		pdsts = 'p5';
		success_msg = '선택된 지시가 비가동 종료에 성공했습니다.';
		fail_msg = '선택된 지시가 비가동 종료에 실패했습니다.';
	} else if( flag=='start'){	// 작업시작
		pdsts = 'p3';
		success_msg = '선택된 지시가 생산시작 성공했습니다.';
		fail_msg = '선택된 지시가 생산시작 실패했습니다.';
	}
	postData += '&pdsts=' + pdsts;
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async:false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				
				fnMessageModalAlert("Notification(ProdConfirm)", data.rtn_msg);
				
				if(data.status_change_yn == 'N') {
// 					console.log("데이터 변동 없음..")
					return;
				}
			
				/********************생산 완료 시 sap로 실적 전송 : Start*******************/
				if(pdsts == 'p6') {
					if(prodEndChk()) {					//routing_header_master의 routng_plast_gubun 값... 현재 라우팅이 생산종료 단계인지 체크
// 						console.log("생산실적처리");
						var rowData = $("#grid_sapord").getRowData(selected_pordno);
						toSapProdIn();					//생산입고 rfc (ZIFFM_MES_PP008) 실행
						toSapProdData();		
					}
					if(t1Chk())	{	// 다음 공정이 T1 인지 체크..T1이면 최종검사테이블 insert
// 						console.log("toMesLastInspec();    // 최종검사!!!!");
						toMesLastInspec();	
					}	
				}
				/********************생산 완료 시 sap로 실적 전송 : End  *******************/
				fnSearchDetailCodeGrid(selected_pordno);
			} else {
				fnMessageModalAlert("Notification(ProdConfirm)", fail_msg);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(ProdConfirm)", fail_msg);
		},
		complete : function() {
			
			fnSearchHisGrid(selected_pordno_pop, selected_routing_no);
			fnSearchMasterCodeGrid();
			selected_pordno_pop = "";
			selected_routing_no = "";
		}
	});
}

function ordPdstsChk() {
// 	console.log('ordPdstsChk()');
	var rtn;
	var arr =  [];
	var uniqueArr = [];
	
	var selectJob = w2ui.grid_job.get(w2ui.grid_job.getSelection());
	var page_url = '/frontend/prod/getProdStatus_new';
	var postData = 'params=' + encodeURIComponent(JSON.stringify(selectJob));
		
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				console.log(data);
				arr.push(data.result);
			} else {
				fnMessageModalAlert("Fail", "선택오더의 상태값을 읽는데 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "선택오더의 상태값을 읽는데 실패했습니다.");
		}
	});
	
	$.each(arr, function(i, el){
		if($.inArray(el, uniqueArr) === -1) uniqueArr.push(el);
	});
	
	if(uniqueArr.length == 1) {
		rtn = true;
	} else {
		fnMessageModalAlert("Warning", "선택오더들의 진행상태가 일치하지 않습니다.<br/>일괄처리 시 대상오더들의 작업진행상태는 모두 동일해야합니다.");
		rtn = false;
	}
	return rtn;
}

//modal : search employee list
function fnSearchWorkerAddGrid() {
// 	console.log('fnSearchWorkerAddGrid()');
	 
	var selectJob = w2ui.grid_job.get(w2ui.grid_job.getSelection());
	var page_url = "/frontend/prod/worker_select_1110"  
	               + "?dept_cd=" + encodeURIComponent(selectJob[0].dept_cd);
	
	w2ui['grid_worker'].lock('loading...', true);
	$.ajax({
		url : page_url,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				w2ui['grid_worker'].records = rowArr;
				w2ui['grid_worker'].total = rowArr.length;
			}
			w2ui['grid_worker'].refresh();
			w2ui['grid_worker'].unlock();
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "작업대상자 목록을 가져오는 중 오류가 발생하였습니다.");
		}
	});
}

//btn action 작업시작 버튼
function fnWorkerAdd() {
// 	console.log('fnWorkerAdd()');
	var rtn_flag = false;
	var fwa_member_emp_no = '';
	var fwa_member_nm= '';
	var member_cnt = 1; 
	var selectJob = w2ui.grid_job.get(w2ui.grid_job.getSelection());
	var gridData = w2ui.grid_worker.get(w2ui.grid_worker.getSelection());
	var fwa_member_nm = member_nm + ",";
	var fwa_member_emp_no = member_emp_no + ",";

	if( gridData.length>0 ){
		for (var i = 0; i < gridData.length; i++) {
			if(member_emp_no == gridData[i].member_emp_no) {
				fnMessageModalAlert("Notification(작업시작)", "선택하신 작업자(" + gridData[i].member_nm + ")는 기본 작업자입니다.<br>사원정보에서 해당 작업자를 선택을 해제해주세요.");
				return;
			}
		}
		for(var i=0 ; i<gridData.length; i++) {
			fwa_member_nm = fwa_member_nm + gridData[i].member_nm + ","
			fwa_member_emp_no = fwa_member_emp_no + gridData[i].member_emp_no + ","
			member_cnt++;
		}
	}
	fwa_member_nm = fwa_member_nm.substring(0, fwa_member_nm.length-1);
	fwa_member_emp_no = fwa_member_emp_no.substring(0, fwa_member_emp_no.length-1);
	
	var page_url = "/frontend/prod/worker_update_new";
	var postData = "params=" + encodeURIComponent(JSON.stringify(selectJob));
		postData += "&member_emp_no=" + encodeURIComponent(fwa_member_emp_no);
		postData += "&member_nm=" + encodeURIComponent(fwa_member_nm);
		postData += "&member_cnt=" + encodeURIComponent(member_cnt);
		//postData += "&jocod=" + encodeURIComponent($(':radio[name="rdo_work_line"]:checked').val());
	
	// 작업자 등록
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async:false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				if ( data.returnMsg=='Already registered' ){
					rtn_flag = true;
				} else {
					rtn_flag = true;
				}
			} else {
				fnMessageModalAlert("Fail", "작업자 등록에 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "작업자 등록 중 오류가 발생하였습니다.");
		}
	});
	if(rtn_flag) {	chnStatus('p3');	}
	$("#modal_worker_add").modal('hide');
}

function chnStatus_validation(pdsts) {
	
	var selectJob = w2ui.grid_job.get(w2ui.grid_job.getSelection());
	
	if(w2ui.grid_job.getSelection().length == 0) {
		fnMessageModalAlert("Warning", "선택된 작업이 없습니다.");
		return;
	}
	if(ordRoutingChk() == false) {
		fnMessageModalAlert("Warning", "선택된 생산지시오더에 T1 - 최종검사 공정이 포함되어 있습니다." + 
				"<br/>최종검사 공정은 최종검사 화면에서 처리해야 합니다.");
		return;
	}
	
	var project_no_yn = "Y";
	var add_itnbr_yn = "Y";
	
	if(ordPdstsChk() == false ) return;
	
	for(var i=0 ; i<selectJob.length; i++) {
		var row = selectJob[i]; 
		
		var pEndChk = prodEndChk(row.routing_no);	//생산실적전송라우팅인지 확인..
		
		if( pdsts == 'p6' ) {	// 작업종료
			if( pEndChk ) {			
				if(row.project_no==null || row.project_no==undefined || row.project_no=='') {
// 					fnMessageModalAlert("Warning", "대표시리얼 번호를 등록하셔야 합니다.<br>해당 작업진행은 취소됩니다.(미등록 제조오더 : " + row.pordno + ")");
					project_no_yn = "N";
					if(row.sernp == "V001") {
						fnMessageModalAlert("Notification(MES)", "해당 오더는 대표시리얼 등록이 반드시 필요한 오더입니다.<br>대표시리얼 등록 후 다시 진행해주세요.");
						return;
					}
				} 
				if ( !chkAddItnbrExist(row.pordno+"0010") ) {
// 					fnMessageModalAlert("Warning", "공정 투입자재 등록이 되지 않았습니다.<br>우측 상단의 공정운영처리에서 공정투입자재를 등록하기 바랍니다.<br>해당 작업진행은 취소됩니다.(제조오더 : " + row.pordno + ")");
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
	 			
		
	fnMessageModalConfirm("Notification(SHIP)", text + "계속 진행 하시겠습니까?", function(result){
		if(result) {
			chnStatus(pdsts);
		}
	});
}

function chnStatus(pdsts) {
// 	console.log('chnStatus(' + pdsts + ')');
	
	var rtn_result;
	var selectJob = w2ui.grid_job.get(w2ui.grid_job.getSelection());
	
// 	if(w2ui.grid_job.getSelection().length == 0) {
// 		fnMessageModalAlert("Warning", "선택된 작업이 없습니다.");
// 		return;
// 	}

// 	if(ordRoutingChk() == false) {
// 		fnMessageModalAlert("Warning", "선택된 생산지시오더에 T1 - 최종검사 공정이 포함되어 있습니다." + 
// 				"<br/>최종검사 공정은 최종검사 화면에서 처리해야 합니다.");
// 		return;
// 	}
	
// 	if(ordPdstsChk() == false ) return;
	
	$.each(selectJob, function(idx, row){
		var page_url = '/frontend/prod/workChangeStatus';
		var postData = 'pordno_pop=' + encodeURIComponent(row.pordno_pop)
					 + '&routing_no=' + encodeURIComponent(row.routing_no)
					 + '&pdsts=' + pdsts;
		var pEndChk = prodEndChk(row.routing_no);
		var success_msg = '';
		var fail_msg = '';
		if( pdsts == 'p6' ) {	// 작업종료
// 			if( pEndChk ) {			
// 				if(row.project_no==null || row.project_no==undefined || row.project_no=='') {
// 					fnMessageModalAlert("Warning", "대표시리얼 번호를 등록하셔야 합니다.<br>해당 작업진행은 취소됩니다.(미등록 제조오더 : " + row.pordno + ")");
// 					return;
// 				} else if ( !chkAddItnbrExist(row.pordno+"0010") ) {
// 					fnMessageModalAlert("Warning", "공정 투입자재 등록이 되지 않았습니다.<br>우측 상단의 공정운영처리에서 공정투입자재를 등록하기 바랍니다.<br>해당 작업진행은 취소됩니다.(제조오더 : " + row.pordno + ")");
// 					return;
// 				} 
// 				var rfcData = w2ui.grid_addItnbr_list.records;

// 			} 
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
 					//fnMessageModalAlert("Notification(MES)", data.rtn_msg);				
					if(data.status_change_yn == 'N') {
// 						console.log("데이터 변동 없음..")
						return;
					}
					/********************생산 완료 시 sap로 실적 전송 : Start*******************/
					if(pdsts == 'p6') {
						console.log("prodEndChk() ::: ");
						if( pEndChk ) {//routing_header_master의 routng_plast_gubun 값... 현재 라우팅이 생산종료 단계인지 체크
							toSapProdIn(row.pordno, row.pordno_pop, row.routing_no);					//생산입고 rfc (ZIFFM_MES_PP008) 실행
							toSapProdData(row);
						}
						
						if(t1Chk(row.pordno))	{	// 다음 공정이 T1 인지 체크..T1이면 최종검사테이블 insert
// 							console.log("toMesLastInspec();    // 최종검사!!!!");
							toMesLastInspec(selectedData.pordno);	
						}	
					}
					/********************생산 완료 시 sap로 실적 전송 : End  *******************/
				} else {
					fnMessageModalAlert("Fail", fail_msg);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("Error", fail_msg);
			},
			complete : function() {}
		});
	});
	clearList();
	reloadJobList();
	$("#grade_mng").modal('hide');	
	fnMessageModalAlert("Notification(MES)", rtn_result);
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

function ordRoutingChk() {
// 	console.log('ordRoutingChk()');

	var rtn = true;
	var r_data; 
	
	var page_url = "/frontend/mes/selectProdOrdUserIng_opt"
				 + "?jocod=" + encodeURIComponent(userInfo.jocod)
				 + "&dept_cd=" + encodeURIComponent(userInfo.user_dept_cd);
	$.ajax({
		url : page_url,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				r_data = data.rows;
			} else {
				fnMessageModalAlert("Fail", "선택오더의 상태값을 읽는데 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "선택오더의 상태값을 읽는데 실패했습니다.");
		}
	});
	
	var selKey = w2ui.grid_job.get(w2ui.grid_job.getSelection());
	
	if(r_data.length>0 ){
		for(var i=0 ; i<r_data.length; i++) {
			for(var k=0 ; k<selKey.length; k++) {
				if(r_data[i].pordno == selKey[k]) {
					if(r_data[i].routing_code.substring(0,2) == 'T1') {
						rtn = false;
					}
				}
			}
		}
	}
	return rtn;
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
				fnMessageModalAlert("Notification(MES)", "현재 실적의 라우팅 정보에서 생산종료확인 데이터를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "현재 실적의 라우팅 정보에서 생산종료확인 데이터를 가져오지 못했습니다.");
		}
	});
	
	if(chk_result == 'Y')	return true;
	else	return false;
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
			if(data.status == "200"){
			} else {
				fnMessageModalAlert("Fail",	"SAP 생산실적 전송을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "SAP 생산실적 전송을 실패했습니다.");
		}
	});
}

function toSapProdData(obj) {
// 	console.log('toSapProdData()');	
	
	var page_url = "/sap_master/ziffm_mes_pp006";			
	var postData = "funcName=" + encodeURIComponent("ZIFFM_MES_PP006");	
	postData +=	'&pordno=' + encodeURIComponent(obj.pordno);
	postData +=	'&pordno_pop=' + encodeURIComponent(obj.pordno_pop);
	postData +=	'&routing_no=' + encodeURIComponent(obj.routing_no);
	postData +=	'&dept_cd=' + encodeURIComponent(obj.dept_cd);
	postData +=	'&wkctr=' + encodeURIComponent(obj.wkctr);
		
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200"){	
			} else {
				fnMessageModalAlert("Fail",	"SAP 생산실적 전송을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "SAP 생산실적 전송을 실패했습니다.");
		}
	});
}

function t1Chk(pordno) {
// 	console.log('t1Chk('+pordno+')');

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
			if(data.status == "200"){
				res_data = data.rows;
			} else {
				fnMessageModalAlert("Fail",	"현재 실적의 공정관리테이블의 데이터를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "현재 실적의 공정관리테이블의 데이터를 가져오지 못했습니다.");
		}
	});
	if(res_data.length>0) {
		for(var i=0 ;i<res_data.length; i++) {
			if(res_data[i].routing_code == 'T1' && i!=0) {
				if(res_data[i-1].pdsts == "p6" && res_data[i].pdsts != "p6") {
					rtn_data = true;
				} 
			}
		}
	}
	return rtn_data;
}

function toMesLastInspec(pordno) {
// 	console.log('toMesLastInspec('+pordno+')');
	
	var page_url = "/frontend/prod/lastInspec_insert";			
	var postData = 'pordno=' + encodeURIComponent(pordno);	

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
			} else {
				fnMessageModalAlert("Fail", "SAP 생산실적 전송을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "SAP 생산실적 전송을 실패했습니다.");
		}
	});
}

 
function addItnbrBatch() {
	
	var batchDataArr = [];
	var gridDataArr = w2ui['grid_itnbrlist'].records
	var gridCheckArr = w2ui['grid_addItnbr_list'].records
    var msgcheck =0;
	
	var num = "1"; 
	
    for(var i=0 ; i<gridDataArr.length ; i++) {
    	var chkCnt = 0;
			for(var j=0 ; j<gridCheckArr.length ; j++) {
				if( gridDataArr[i].matnr == gridCheckArr[j].matnr ){
					chkCnt++;
				}	
			}
	
		// chkCnt가 0보다 크면, 같은 항목이 한개 이상 있다는...
		if( chkCnt==0 ){
			if(gridDataArr[i].sernp != 'V001'){
				gridDataArr[i].recid = num;
				batchDataArr.push(gridDataArr[i]);
				num++;
			}
		}else{		
			msgcheck =1;
		}
	} 

    $.each(batchDataArr, function(idx, row){
    	row.recid = (w2ui['grid_addItnbr_list'].records).length + 1;
    	row.sernp = '';
    	row.sernr = '';
    	row.sernr_seq = '';
    	w2ui['grid_addItnbr_list'].add(row);
    });
	w2ui['grid_addItnbr_list'].refresh();

	if(msgcheck==1){
		fnMessageModalAlert("Warning(Duplicate)", "이미 추가되어 있는 항목은 제외하였습니다.");
	}
 
}

////////////////////////////////////////////////////////////////////////////

function input_code_1() {
// 	var s_id = $('#grid_fault_routing_list').jqGrid('getGridParam', 'selrow');	
	
	var record = w2ui.grid_fault_routing_list.get(w2ui.grid_fault_routing_list.getSelection()[0]);
	
	var sel_step1 = $("#sel_step1").val();
	var sel_step2 = $("#sel_step2").val();
	var sel_step3 = $("#sel_step3").val();
	var sel_step4 = $("#sel_step4").val();
	var sel_step1_t = $("#sel_step1 option:selected").text();
	var sel_step2_t = $("#sel_step2 option:selected").text();
	var sel_step3_t = $("#sel_step3 option:selected").text();
	var sel_step4_t = $("#sel_step4 option:selected").text();
	
	if(w2ui.grid_fault_routing_list.getSelection().length == 0) {
		fnMessageModalAlert("Notification(MES)", "불량코드가 입력 될 자재불량내역을 선택해 주세요.");
		return;
	}
	
	if(sel_step4_t == '' || sel_step4_t == '-') {
		fnMessageModalAlert("Notification(MES)", "lv.03 까지 불량내역을 지정해주세요.");
		return;
	}
	
	record.org_issue_memo = sel_step4_t;
	record.org_issue_code = sel_step4;
	
	w2ui.grid_fault_routing_list.set(w2ui.grid_fault_routing_list.getSelection()[0], record);
	
}

function input_code_2() {
	var record = w2ui.grid_fault_list.get(w2ui.grid_fault_list.getSelection()[0]);
	var sel_step1 = $("#sel_step1").val();
	var sel_step2 = $("#sel_step2").val();
	var sel_step3 = $("#sel_step3").val();
	var sel_step4 = $("#sel_step4").val();
	
	var sel_step1_t = $("#sel_step1 option:selected").text();
	var sel_step2_t = $("#sel_step2 option:selected").text();
	var sel_step3_t = $("#sel_step3 option:selected").text();
	var sel_step4_t = $("#sel_step4 option:selected").text();
	
	if(w2ui.grid_fault_list.getSelection().length == 0) {
		fnMessageModalAlert("Warning", "불량코드가 입력 될 자재불량내역을 선택해 주세요.");
		return;
	}
	
	if(sel_step4_t == '' || sel_step4_t == '-') {
		fnMessageModalAlert("Warning", "lv.03 까지 불량내역을 지정해주세요.");
		return;
	}
	
	record.org_issue_memo = sel_step4_t;
	record.org_issue_code = sel_step4;
	w2ui.grid_fault_list.set(w2ui.grid_fault_list.getSelection()[0], record);
}

function fnProdFaultConf_1() {
// 	var data = $('#grid_fault_routing_list').getRowData();
// 	$('#grid_fault_routing_list').jqGrid('setGridParam', {cellEdit: false});
// 	var gridDataArr = $('#grid_fault_routing_list').jqGrid('getRowData');
// 	$('#grid_fault_routing_list').jqGrid('setGridParam', {cellEdit: true});
	var gridDataArr = w2ui.grid_fault_routing_list.records;
	/*********************데이터 유무 확인 : Start*********************/
	if(gridDataArr.length == 0) {
		fnMessageModalAlert("Notification(MES)", "데이터가 없습니다.");
 		return;
	}
	/*********************데이터 유무 확인 : End*********************/
	///////////////////////////
	var issueChkCnt = 0;
	$.each(gridDataArr, function(idx, row){
		if(row.w2ui!=undefined){
			row.org_issue_memo = row.w2ui.changes.org_issue_memo;
		}
		if(row.org_issue_memo==undefined || row.org_issue_memo==null || row.org_issue_memo=='')
			issueChkCnt++;
	});
	if(issueChkCnt>0){
		fnMessageModalAlert("Warning", "공정불량처리 내역이 입력되지 않아 자재불량처리까지만 진행되었습니다.<br>공정불량처리가 필요할 시 공정불량처리버튼으로 별도 처리해주세요.");
		$("#fault_mng").modal('hide');
		return;
	}
	///////////////////////////
	var jsonStr = JSON.stringify(gridDataArr);
	var jobData = w2ui.grid_job.get(w2ui.grid_job.getSelection()[0]);
	/********************* 데이터 insert 및 rfc 전송 : Start*********************/
	var page_url = "/frontend/prod/fnProdFaultConf";
	var postData = 'jsonStr=' + encodeURIComponent(jsonStr);
		postData += '&pordno_pop=' + encodeURIComponent(jobData.pordno_pop);
		postData += '&routing_no=' + encodeURIComponent(jobData.routing_no);
		postData += '&t_gubun=' + encodeURIComponent("tw");
	$.ajax({
	    url: page_url,
	    data: postData,
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
//	    	console.log(data);
	    	if(data.status == "200") {
	    		fnMessageModalAlert("Success", "정보를 저장했습니다.");	
	    	} else {
	    		fnMessageModalAlert("Fail", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Error", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
	
	$("#modal_detail_serial_add").modal('hide');
	$("#grid_req_sernr").modal('hide');
	$("#fault_mng").modal('hide');
		
	/********************* 데이터 insert 및 rfc 전송 : End*********************/
}

function faultRoutingProc() {
// 	console.log('pordFaultProc()');

	w2ui.grid_fault_routing_list.clear();
	
	var arrObj = [];
	if( w2ui.grid_job.getSelection().length==0 ){
		fnMessageModalAlert("Warning", "선택된 작업이 없습니다.");
		return;
	}
	
	var rowData = w2ui.grid_job.get(w2ui.grid_job.getSelection()[0]);

	var project_no = rowData.project_no;
	
	if(rowData.itnbr.length !=0) {
		var page_url = '/frontend/hub/material_recv_master_select_nopage'	
			 + '?matnr=' + encodeURIComponent(rowData.itnbr)
			 + '&werks=' + encodeURIComponent(rowData.dept_cd);
		
		var dataArr = [];
		
		$.ajax({
			url : page_url,
			type : "POST",
			async:false,
			success : function(data, textStatus, jqXHR) {
				var datarows = data.rows;
				var recordsCnt = w2ui.grid_fault_routing_list.records.length;
				if (data.status == "200") {
					if( datarows.length>0 ){
						$.each(datarows, function(idx, row){
							var tmpObj = {};
							tmpObj.recid = (recordsCnt + 1) + idx;
							tmpObj.aufnr = rowData.pordno;
							tmpObj.werks = rowData.dept_cd;
							tmpObj.matnr = rowData.itnbr;
							tmpObj.maktx = row.maktx;	
							tmpObj.wrkst = row.wrkst;
							tmpObj.meins = row.meins;
							tmpObj.lgort = rowData.lgort;
							tmpObj.menge = rowData.pdqty;
							tmpObj.sernr = rowData.project_no;
							dataArr.push(tmpObj);
						});
	
						w2ui.grid_fault_routing_list.add(dataArr);
						w2ui.grid_fault_routing_list.total = recordsCnt + dataArr.length;
					}
				} else {
					fnMessageModalAlert("Fail", "데이터를 불러오지 못했습니다.");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("Fail", "데이터를 불러오지 못했습니다.");
			}
		});
	}else {
		var dataArr = [];
		var tmpObj = {};
		tmpObj.recid = 1;
		tmpObj.aufnr = rowData.pordno;
		tmpObj.werks = dept_cd;
		tmpObj.matnr = '';
		tmpObj.maktx = '';	
		tmpObj.wrkst = '';
		tmpObj.meins = '';
		tmpObj.lgort = rowData.lgort;
		tmpObj.menge = rowData.pdqty;
		tmpObj.sernr = rowData.project_no;
		dataArr.push(tmpObj);
		w2ui.grid_fault_routing_list.add(dataArr);
		w2ui.grid_fault_routing_list.total = dataArr.length;
	}
	setTimeout(function(){
		w2ui.grid_fault_routing_list.resize();
		w2ui.grid_fault_routing_list.refresh();	
	}, 200);
}

function fnLoadFaultRoutingListGrid() {
	$("#grid_fault_routing_list").w2grid({
		name: 'grid_fault_routing_list',
		show : {
			lineNumbers : true,
            footer: true
        },
		columns : [
			{ field:'aufnr', caption:'지시번호', size:'80px', sortable:true, style:'text-align:center'},
			{ field:'werks', caption:'플랜트', size:'50px', sortable:true, render:function(record, index, col_index){
				if (this.getCellValue(index, col_index)=='1110')
					return '의료';
				else
					return '광영상';
			}, style:'text-align:center'},
			{ field:'lgort', caption:'창고', size:'70px', sortable:true},
			{ field:'matnr', caption:'자재', size:'100px', sortable:true},
			{ field:'maktx', caption:'자재내역', size:'150px', sortable:true},
			{ field:'wrkst', caption:'자재스펙', size:'150px', sortable:true},
			{ field:'menge', caption:'수량', size:'50px', sortable:true, render:'int'},
			{ field:'meins', caption:'단위', size:'50px', sortable:true, style:'text-align:center'},
			{ field:'sernr', caption:'시리얼', size:'120px', sortable:true},
			{ field:'org_remark', caption:'메모', size:'150px', sortable:true, editable: { type: 'text'}},
			{ field:'org_issue_memo', caption:'불량내역', size:'150px', sortable:true},
			{ field:'org_issue_code', caption:'org_issue_code', size:'120px', sortable:true, hidden:true}			
		],
		recordHeight : 30,
		sortData : [{field: 'aufnr', direction: 'ASC'}],
		records : [],
		total : 0,
	    onSelect : function(event) {}
	});
}

function locInputMng() {

	var record = w2ui.grid_fault_list.get(w2ui.grid_fault_list.getSelection()[0]);
	record.lgort = $('#grade_loc').val();
	w2ui.grid_fault_list.set(w2ui.grid_fault_list.getSelection()[0], record);
	
	$("#grade_loc_add").modal('hide');
}

function grade_chk() {

	var selectJob = w2ui.grid_job.get(w2ui.grid_job.getSelection());

	$("#grid_grade_mng").jqGrid('clearGridData');
	
	
	var pordnos = "";
	var r_data = [];
	for(var i=0 ; i<selectJob.length; i++) {
		
// 		var selectedData = $("#grid_ready").getRowData(selKey[i]);
		var selectedData = selectJob[i];
		
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
		chnStatus_validation('p6');
		//chnStatus('p6');
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
	$("#grade_loc_add_1").modal('hide');
}

function work_end_proc() {
	var selKey = $("#grid_grade_mng").jqGrid('getGridParam', 'selarrrow');
	var selGridData = $("#grid_grade_mng").getRowData();
	
	
	for(var i=0 ;i<selGridData.length; i++) {
		if(selGridData[i].lgort.length == 0) {
			fnMessageModalAlert("Notification(MES)", "조회내역의 저장창고 항목에 데이터가 없습니다.<br/>해당 셀을 클릭해 데이터를 입력해주세요.");
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
// 			chnStatus('p6');
			chnStatus_validation('p6');
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

function locInputMng_2() {
	
	var record = w2ui.grid_addItnbr_list.get(w2ui.grid_addItnbr_list.getSelection()[0]);
	
	record.lgort = $('#grade_loc_2').val();

	w2ui.grid_addItnbr_list.set(w2ui.grid_addItnbr_list.getSelection()[0], record);
		
	$("#grade_loc_add_2").modal('hide');
}

function getStrList() {
	initOptions($('#grade_loc'));
	initOptions($('#grade_loc_1'));
	initOptions($('#grade_loc_2'));

	var page_url = "/frontend/scm/mes_stock_tbl_select"
	var postData = 'menu_code=' + encodeURIComponent('mst04');

	$.ajax({
	    url: page_url,
	    data: postData,
	    async:false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$.each(data.rows, function (i, item) {
						$('#grade_loc').append($('<option>', { 
							value: item.stock_code,
					        text : "("+item.stock_code+") "+item.stock_name 
					    }));
						
						$('#grade_loc_1').append($('<option>', { 
							value: item.stock_code,
					        text : "("+item.stock_code+") "+item.stock_name 
					    }));
						
						$('#grade_loc_2').append($('<option>', { 
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
	
	var selection = w2ui.grid_job.getSelection();
	if ( selection.length==0 ) {
		fnMessageModalAlert("Warning", "선택된 메인공정이 없습니다.");
		return;
	}

	if (selection.length > 1) {
		fnMessageModalAlert("Notification(MES)", "한개의 오더만 선택해주세요.");
		return;
	}
	var rowData = w2ui.grid_job.get(selection)[0];

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

function g_fault_proc() {
	
	matArr = [];
	
	$("#s_matnr").val('');
	$("#s_wrkst").val('');
	$("#s_maktx").val('');
	$("#s_plant").val('');
	initOptions($('#v_lgort'));
	
	$("#grid_g_materiallist").jqGrid('clearGridData');
	
	$("#modal_g_fault_proc").modal('show');
}

function g_materialSearch() {
// 	console.log('materialSearch()');

	getStrotageList();

	var page_url = '/frontend/hub/material_recv_master_select'
		 		 + '?matnr=' + encodeURIComponent($("#s_matnr").val())
		 		 + '&wrkst=' + encodeURIComponent($("#s_wrkst").val())
		 		 + '&maktx=' + encodeURIComponent($("#s_maktx").val())
				 + '&werks=' + encodeURIComponent($("#s_plant").val());
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

	w2ui.grid_fault_list.clear();
	
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
		tmp_obj.gubun = "일반자재"
		grid_materiallist_selcData.push(tmp_obj);
		totalMatnrArr.push(tmp_obj.matnr);
	}

	var uniqMatnrArr = $.unique(totalMatnrArr);
	
	$("#modal_g_fault_proc").modal('hide');	
		
	var itnbr_data;
 	var grid_fault_list_data = [];
 	
	var page_url = '/frontend/hub/material_recv_master_select_nopage'	
				 + "?matnrs=" + encodeURIComponent(String(uniqMatnrArr))
				 +"&werks=" + encodeURIComponent($("#s_plant").val());
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
	var initRecid = w2ui.grid_fault_list.records.length + 1;
	var rowNo = 0;
	
	$.each(grid_materiallist_selcData, function(idx, mat){
		var tmpObj = {};
		$.each(itnbr_data, function(i, obj){
			if( obj.matnr==mat.matnr ) {
				tmpObj.recid = initRecid + rowNo; 
				tmpObj.werks = $("#s_plant").val();
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

				
				tmpObj.menge = '1';
				tmpObj.sernr = '';
				tmpObj.sernr_seq = '';
				tmpObj.org_menge = '1';
				tmpObj.rfc_chk = 'N';
				tmpObj.gubun = mat.gubun;
				console.log(tmpObj);
				grid_fault_list_data.push(tmpObj);
				rowNo++;
			}
		});
	});
		
	for(var i=0 ; i<grid_fault_list_data.length; i++) {
		w2ui.grid_fault_list.add(grid_fault_list_data[i]);	
	}

	initOptions($('#sel_step1'));
	initOptions($('#sel_step2'));
	initOptions($('#sel_step3'));
	initOptions($('#sel_step4'));
	makeSelStep1();
	console.log(w2ui.grid_fault_list.records);
	$("#fault_mng").modal('show');
	
	setTimeout(function(){
		
		w2ui.grid_fault_list.resize();
		w2ui.grid_fault_list.refresh();
	}, 200);
}

function getStrotageList() {

	initOptions($('#v_lgort'));

	if($("#s_plant").val() == '1110') {
		$('#v_lgort').append($('<option>', { 
			value: '3100',
			text : 'Packing'
		}));
	} else {
	 
		$('#v_lgort').append($('<option>', { 
			value: '3100',
			text : 'Packing'
		}));
		$('#v_lgort').append($('<option>', { 
			value: '310A',
			text : '포장 대기-S등급'
		}));
		$('#v_lgort').append($('<option>', { 
			value: '310B',
			text : '포장 대기-CS 등급' 
		}));
		$('#v_lgort').append($('<option>', { 
			value: '310C',
			text : '포장 대기-C등급'
		}));
		$('#v_lgort').append($('<option>', { 
			value: '310D',
			text : '포장 대기-D등급(2TAB)'
		}));
	}
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
		
		w2ui.grid_itnbrlist.set(i+1, { remain_bdmng: remain_bdmng});
		
		if(Number(remain_bdmng) == 0) {
	 		for(var k=0 ;k<10; k++) {
				$("#grid_grid_itnbrlist_data_"+i+"_" + k).css("color","#0054FF");
			}
		} else {
	 		for(var k=0 ;k<10; k++) {
				$("#grid_grid_itnbrlist_data_"+i+"_" + k).css("color","#FF0000");
			}
		}
	}
	
	
	
// 	for(var i=0 ;i<w2ui.grid_itnbrlist.records.length; i++) {
// 		for(var k=0 ;k<10; k++) {
// 			$("#grid_grid_itnbrlist_data_"+i+"_" + k).css("color","#ffcccc");
// 		}
// 	}
}

function loadNewItnbrGridData(pordno_pop) {

	var rtn_data = [];
	
 	var page_url = "/frontend/prod/selectSernrManageTbl"
 				 + "?pordno_pop=" + encodeURIComponent(pordno_pop);
 	$.ajax({
		url : page_url,
		type : "POST",
		async : false,
		success : function(data, textStatus, jqXHR) {
			if( data.status == 200 ) {
				rtn_data = data.rows;
			} else {
				fnMessageModalAlert("Notification(MES)", "투입자재내역을 가져오는데 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "투입자재내역을 가져오는데 실패했습니다.");
		},
		complete : function() {}
	});
 	return rtn_data;
}

function itnbrlist_grid_color() {
	setTimeout(function(){
		for(var i=0 ;i<w2ui.grid_itnbrlist.records.length; i++) {
			if(Number(w2ui.grid_itnbrlist.records[i].remain_bdmng) == 0) {
		 		for(var k=0 ;k<10; k++) {
					$("#grid_grid_itnbrlist_data_"+i+"_" + k).css("color","#0054FF");
				}
			} else {
		 		for(var k=0 ;k<10; k++) {
					$("#grid_grid_itnbrlist_data_"+i+"_" + k).css("color","#FF0000");
				}
			}
		}
	}, 200);
}

function selectPoLgort() {
	var rst_lgort ="";
	var pordno = w2ui.grid_job.get(w2ui.grid_job.getSelection()[0]).pordno;
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
</script>

</body>
</html>
  
 