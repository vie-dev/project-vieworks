<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.bitts.vmes.util.*"%>
<%
String memberId = SessionUtil.getMemberId(request);
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
		<jsp:param name="selected_menu_p_cd" value="1013" />
		<jsp:param name="selected_menu_cd" value="1074" />
	</jsp:include>

	<style type="text/css">
	.popupText {
		margin-top:7px;
		font-weight: bold;
		font-size:15px;
		color: #566573;
	}
	</style>
	
  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        SCM관리
        <small>구매오더확인(Vendor)</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> SCM관리</a></li><li class="active">구매오더확인(Vendor)</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
    	<div class="row">
			<div class="col-md-8">
				<div class="box" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">구매오더 목록</h3>
						<div class="box-tools pull-right">
							<button type="button" id="" onclick="partialSelcProc();" class="btn btn-sm bg-teal">분할</button>
							<button type="button" id="" onclick="printTransacion();" class="btn btn-primary btn-sm">거래명세표 출력</button>
							<button type="button" id="btn_pstyp" onclick="pstypSernr();" class="btn btn-info btn-sm" style="display:none;">사급자재 시리얼</button>
							<span class="btn btn-warning btn-sm fileinput-button c_code_flag"> 
								<span>오더변경 업로드</span>
								<input id="reqfileupload" type="file" name="files[]" multiple>
							</span>
							<button type="button" id="" onclick="excelFileDownload('gridProc');" class="btn btn-success btn-sm grid_attach_down c_code_flag">오더 다운로드</button>
							<button type="button" id="" onclick="reloadGridProc();" class="btn btn-primary btn-sm">조회</button>
							<button type="button" id="" onclick="checkOrder();" class="btn btn-primary btn-sm">저장</button><!-- 일정확인 -->
						</div>
					</div>
					<div class="box-body" style="padding-bottom: 0px;">
						<div class="row">
							<div class="col-sm-3">
								<div id="area_decide_date_range" class="form-group">
									<label>| 납품일자</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right input-sm" id="decide_date_range">
									</div>
								</div>
								<div id="area_possible_date_range" class="form-group" style="display:none;">
									<label>| 납품가능일자</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right input-sm" id="possible_date_range">
									</div>
								</div>
							</div>
							<div class="col-sm-2" style="padding-left: 0px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 처리상태</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="rvendor_status" class="form-control select2 input-sm" data-placeholder="Vendor 선택" style="width: 100%;">
											<option value=''>전체</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-2" style="padding-left: 0px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 품목</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="matnr">
									</div>
								</div>
							</div>
							<div class="col-sm-3" style="padding-left: 0px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 문서번호</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="ebeln">
									</div>
								</div>
							</div>
							<div class="col-sm-2" style="padding-left: 0px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 사급자재 대상</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="pstyp" class="form-control select2 input-sm" data-placeholder="사급자재 구분" style="width: 100%;">
											<option value="">전체</option>
											<option value="3">대상</option>
										</select>
									</div>
								</div>
							</div>
						</div>
<!-- 						<div class="box-tools pull-right" style="display:none;"> -->
<!-- 							<button type="button" id="area_transation" onclick="makeTranDetails();" class="btn btn-success btn-sm" style="display:none;">거래명세서</button> -->
<!-- 						</div> -->
					</div>
						<div id="gridProc" style="width: 100%; height: 653px;"></div>
<!-- 					<div id="dv_grid_goods" class="box-body" style="padding-top: 0px;"> -->
<!-- 						<table id="grid_goods"></table> -->
<!-- 						<div id="grid_goods_pager"></div> -->
<!-- 					</div> -->
				</div>
			</div>
			<div class="col-md-4">
				<div id="caseByCase">	
					<div class="box" style="margin-bottom: 0px;">
						<div class="box-header with-border">
							<h3 class="box-title">시리얼 관리</h3>
							<div class="box-tools pull-right" style="min-width:400px;">
								<div id="progress" class="col-sm-1 progress" style="float:left;">
									<div class="progress-bar progress-bar-warning"></div>
								</div>
<!-- 								<div id="serialBtns" style="float:right; text-align: right; display:none;"> -->
								<div id="serialBtns" style="float:right; text-align: right;">
									<button type="button" class="btn btn-info btn-sm grid_attach_down" onclick="excelFileDownload('gridSernr');" data-selfilepath="/upload" data-selfilename="test.xlsx">
										<i class="fa fa-check"></i> 다운로드 
									</button>
									<span class="btn btn-warning btn-sm fileinput-button"> 
										<span>시리얼 일괄 처리</span> 
										<input id="sernrfileupload" type="file" name="files[]" multiple>
									</span>
									<button type="button" id="btn_saveSerial" class="btn btn-success btn-sm" onclick="saveSerials();">저장</button>
								</div>
							</div>
						
						</div>
						<div class="box-body" style="padding: 10px 0px 0px 0px;">
<!-- 							<div id="msg" style="height:723px; color:red; display:none;"> -->
<!-- 								<b>해당 데이터는 현재 메뉴에서의 시리얼 입력 대상 내용이 아닙니다.</b> -->
<!-- 							</div> -->
							<div id="gridSernr" style="width: 100%; height: 723px;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
   	</section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
  <div class="modal fade" id="modal_detail" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">품목조회조건</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class=" col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">제품 목록</h3>
									<div class="box-tools pull-right">
										<div class="input-group input-group-sm" style="width: 150px;float: left;">
						                  <input type="text" id="itnbr_search_popup" name="itnbr_search" class="form-control pull-right" placeholder="name Search">
											<div class="input-group-btn">
						                    <button type="button" id="btn_itnbr_search_popup" class="btn btn-default btn-sm" onclick="searchItnbrpopup();"><i class="fa fa-search"></i></button>
						                  </div>
						                </div>
						                &nbsp;|
						                <button type="button" id="" class="btn btn-warning btn-sm" onclick="addItnbrDetail();">
						                <i class="fa fa-forward" aria-hidden="true"></i></button>
									</div>
								</div>
								<div id="dv_grid_itnbrlist" class="box-body">
									<table id="grid_itnbrlist"></table>
									<div id="grid_itnbrlist_pager"></div>
								</div>
							</div>
						</div>
						<div class=" col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">조회 대상 제품 목록</h3>
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
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-success btn-sm" onclick="inputMntrs();">조회조건입력</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!--  modal area1 -->
<div class="modal fade" id="modal_procSub" data-backdrop="static">
	<div class="modal-dialog modal-bg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">사급자재 시리얼 등록</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-8">
						<div class="box" style="margin-bottom: 0px;">
							<div class="box-header with-border">
								사급자재 대상
							</div>
							<div id="" class="box-body">
								<div id="gridProcSub" style="width: 100%; height: 500px;"></div>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="box" style="margin-bottom: 0px;">
							<div class="box-header with-border">
								<h3 class="box-title">시리얼 관리</h3>
								<div class="box-tools pull-right" style="min-width:400px;">
									<div id="progress" class="col-sm-1 progress" style="float:left;">
										<div class="progress-bar progress-bar-warning"></div>
									</div>
									<div id="subSerialBtns" style="float:right; text-align: right;">
										<button type="button" class="btn btn-info btn-sm grid_attach_down" onclick="excelFileDownload('gridProcSubSernr');" data-selfilepath="/upload" data-selfilename="test.xlsx">
											<i class="fa fa-check"></i> 다운로드 
										</button>
										<span class="btn btn-warning btn-sm fileinput-button"> 
											<span>시리얼 일괄 처리</span> 
											<input id="subsernrfileupload" type="file" name="files[]" multiple>
										</span>
										<button type="button" id="btn_saveSubSerial" class="btn btn-success btn-sm" onclick="saveSubSerials();">저장</button>
									</div>
								</div>
							
							</div>
							<div class="box-body" style="padding-bottom: 0px;">
	<!-- 							<div id="msg" style="height:723px; color:red; display:none;"> -->
	<!-- 								<b>해당 데이터는 현재 메뉴에서의 시리얼 입력 대상 내용이 아닙니다.</b> -->
	<!-- 							</div> -->
								<div id="gridProcSubSernr" style="width: 100%; height: 500px;"></div>
							</div>
						</div>
					</div>
				</div>
			</div><!-- end modal body -->
		</div><!-- end modal content -->
	</div><!-- end modal dialog -->
</div><!-- end modal area1 --> 	

<!-- 거래명세서 출력 대상 선택 modal : start-->
<div class="modal fade" id="modal_tansaction" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="">거래명세서 조건 선택</h4>
			</div>
			<div class="modal-body" id="">
				<div class="row">
					<div class="col-md-12">
						<form id="frm_arrival" name="frm_arrival" class="form-horizontal">
						<div class="form-group" style="margin-bottom: 0px;padding-bottom: 10px; display:none;">
							<label for="" class="col-sm-4 control-label">체크오더상태</label> 
							<div class="input-group col-sm-6">
								<input type="text" class="form-control pull-right input-sm" id="s_status">
							</div>
						</div>
						<div class="form-group" style="margin-bottom: 0px;padding-bottom: 10px;">
							<label for="trs_ebeln" class="col-sm-4 control-label">문서번호</label> 
							<div class="input-group col-sm-6">
								<select id="trs_ebeln" class="form-control select2 input-sm" style="width: 100%;" onChange="getTransactionList('b');">
									<option>선택</option>
								</select>
							</div>
						</div>
						<div class="form-group" id="trs_labnr_area" style="margin-bottom: 0px;padding-bottom: 10px;">
							<label for="trs_labnr" class="col-sm-4 control-label">납품일정번호</label> 
							<div class="input-group col-sm-6">
								<select id="trs_labnr" class="form-control select2 input-sm" style="width: 100%;"></select>
							</div>
						</div>
					</form>
					<div class="box-body" style="padding: 0px;">
						<div id="grid_doc_list" style="width: 100%; height: 350px;"></div>
					</div>
					</div>
				</div>
	        </div>
	        <div class="modal-footer">
				<div class="col-md-12 text-center">
					<div class="form-group">
						<label> <input type="radio" id="d_print" name="rdo_req_type" class="flat-red rdo_req_type" value="Y" checked> 출력용</label> 
						<label> <input type="radio" id="d_selc" name="rdo_req_type" class="flat-red rdo_req_type" value="N"> 조회용</label> 
					</div>
					<label for="r_conf_date" class="for_print">납품일자</label>
					<input type="input" id="r_conf_date" name="r_conf_date" class="for_print" placeholder="" maxlength="10">
					<button type="button" id="" class="btn btn-sm btn-success" onclick="printDoc();">출력실행</button>
<!-- 				<button type="button" id="" class="btn btn-sm btn-success" onclick="test();">TEST</button> -->
					<button type="button" id="" class="btn btn-sm btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 거래명세서 출력 대상 선택 modal : end-->

<!-- 분할 처리 대상 선택 modal : start-->
<div class="modal fade" id="modal_partial_selc" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="">분할 대상 선택</h4>
			</div>
			<div class="modal-body" id="">
				<div class="box-body pull-right">
					<button type="button" id="button_partialProc" onclick="partialProc();" class="btn btn-sm btn-primary">분할</button>
				</div>
				<div class="box-body" style="padding: 0px;">
					<div id="grid_partial_selc" style="width: 100%; height: 350px;"></div>
				</div>
	        </div>
		</div>
	</div>
</div>
<!-- 분할 처리 대상 선택 선택 modal : end-->

<!-- 분할 modal : start-->
<div class="modal fade" id="modal_partial" data-backdrop="static">
	<div class="modal-dialog modal-bg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">분할</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="box box-warning box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">선택항목 기본정보</h3>
						<div class="box-tools pull-right">
							<button type="button" id="button1" onclick="partialRowAdd();" class="btn btn-sm btn-primary">추가</button>
							<button type="button" id="button2" onclick="partialRowDel();" class="btn btn-sm btn-danger">삭제</button>
							<button type="button" id="button3" onclick="partialSave();" class="btn btn-sm btn-success">저장</button>
						</div>
					</div>
					<div id="" class="box-body">
						<table class="table table-condensed">
							<tr>
							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 문서번호</th>
							  <td class="col-md-2"> <div id="p_ebeln" name="p_ebeln" class="popupText" style="margin-top: 3px;">-</div> </td>
							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 문서품목</th>
							  <td class="col-md-2"> <div id="p_ebelp" name="p_ebelp" class="popupText" style="margin-top: 3px;">-</div> </td>
							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 분기순번</th>
							  <td class="col-md-2"> <div id="p_partial_seq" name="p_zmenge" class="popupText" style="margin-top: 3px;">-</div> </td>
							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 진행상태</th>
							  <td class="col-md-2"> <div id="p_rvendor_status_nm" name="p_maktx" class="popupText" style="margin-top: 3px;">-</div> </td>
							</tr>
							<tr>
							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 품목</th>
							  <td class="col-md-2"> <div id="p_matnr" name="p_inspCheckGubun" class="popupText" style="margin-top: 3px;"></div> </td>
							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 내역</th>
							  <td class="col-md-2"> <div id="p_txz01" name="p_insp_status_nm" class="popupText" style="margin-top: 3px;"></div> </td>
							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 납품수량</th>
							  <td class="col-md-2"> <div id="p_menge" name="p_wrkst" class="popupText" style="margin-top: 3px;">-</div> </td>
						      <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 납품일자</th>
							  <td class="col-md-2"> <div id="p_eindt" name="p_name1" class="popupText" style="margin-top: 3px;">-</div> </td>
							</tr>
						</table>
					</div>
				</div><!-- end box -->
<!-- 				<div id="dv_grid_partial"> -->
<!-- 					<table id="grid_partial"></table> -->
<!-- 				</div> -->
				<div class="box-body" style="padding: 0px;">
					<div id="grid_partial" style="width: 100%; height: 350px;"></div>
				</div>
					
					
			</div><!-- end modal body -->
		</div><!-- end modal content -->
	</div><!-- end modal dialog -->
</div><!-- end modal area1 --> 	
<!-- 분할 modal : end-->
<%@include file="./bringin_materials_confirm_doc.jsp"%>
  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>
<!-- ./wrapper -->

<!-- <script src="/res/plugins/jquery-latest.min.js"></script> -->
<script type="text/javascript" src="/res/plugins/jquery-barcode.js"></script>

<script src="/res/plugins/jquery-printme.js"></script>
<script type="text/javascript">
// session info
var memberId = "<%=memberId%>";
var lifnr = '';
var c_code = '';

var mainKey;
var selectGridId;
var newDate;
var dataArr = [];
$(".progress").hide();

$(function($) {
	fnChkUser();
	fnLoadCommonOption();
	fnLoadProcListGrid();
	fnLoadSernrListGrid();
	
	initConfDate();
	
	fnLoadProcSubListGrid();
	fnLoadSernrSubListGrid();
	
	initItnbrGrid();
	initNewItnbrGrid(); 
	initNewDocGrid(); 
	
	fnLoadPartialSelcGrid();
	fnLoadPartialGrid();
	
	initScreenSizeModal();
})


function initConfDate() {
	$("#r_conf_date").datepicker({
		language: "kr",
		todayHighlight: true,
		format: "yyyymmdd",
		autoclose: true
  	});

	$('.rdo_req_type').change(function() {
		var rdo_req_type =  $(':radio[name="rdo_req_type"]:checked').val();
		if(rdo_req_type == 'Y') {
			$('.for_print').show();
		} else {
			$('.for_print').hide();
		}
	});
	
}
function fnChkUser() {
	//console.log('fnChkUser()');
	
	var page_url = "/frontend/scm/checkVenderMember";
	var params = "member_emp_no="+encodeURIComponent(memberId);
	
	$.ajax({
		url : page_url,
		data : params,
		type : 'POST',
		async : false,
		dataType : 'json',
		success: function( data ) {
			if(data.status == 200) {
				var dept_cd = data.result;
				c_code = dept_cd;
				if( data.result=='1063') {
					lifnr = memberId;
				}
				else {
					lifnr = '';
				}
			}
		},
		complete: function () {}
	});
}

// search component setting
function fnLoadCommonOption() {
// 	console.info('fnLoadCommonOption()');
	
	resizeJqGrid("grid_jocod_add", true);

	$("#decide_date_range").pressEnter(function(e) {
		e.preventDefault();
		if(e.target.id == "decide_date_range"){
			reloadGridProc();
		}
	});
	
	var datePickOpt = {
				format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
				,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
				,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
				,showMonthAfterYear: true
				,yearSuffix: '년'
				,orientation: "top left" };
	
	$("#decide_date_range").daterangepicker({
		startDate :  getTodayDate(),
		endDate :  getTodayDate(),
		opens : 'right',
		locale : datePickOpt
	});
	
	$('#possible_date_range').daterangepicker({
		opens : 'right',
		locale : datePickOpt
	});
	
	$("#delivery_date, #vandor_delivery_date").datepicker({
		language: "kr",
		todayHighlight: true,
		format: "yyyy.mm.dd",
		autoclose: true
	}).on('changeDate',function(selected){
		 newDate = new Date(selected.date);
		// Extract the current date from Date object
		newDate.setDate(newDate.getDate());
		
		chDateStr = $.datepicker.formatDate('yymmdd',selected.date);
		$('#vendor_delivery_date').datepicker("setDate",  selected.date);
	});
	// ignoreReadonly: true
	
	getStatusCodeList('rvendor_status');
	
	$('#rvendor_status').change(function(){
//			area_decide_date_range
//			area_possible_date_range / possible_date_range			
		if ( $(this).val()=='v1' || $(this).val()=='' || $(this).val()==null ){	//요청 혹은 그 이전
			$('#area_decide_date_range').show();
			$('#area_possible_date_range').hide();
	//			$('#area_transation').hide();
		} else {	// 요청 이후의 상태
			$('#area_decide_date_range').hide();
			$('#area_possible_date_range').show();
	//			$('#area_transation').show();
		}
		reloadGridProc();
	});

	fnSernrLoadFileHandler();
	fnReqLoadFileHandler();
	fnSubLoadFileHandler();
	
	$("#grid_itnbrlist").jqGrid('clearGridData');
	$("#grid_addItnbr_list").jqGrid('clearGridData');
	
    $('#table').on('check.bs.table', function (e, row, $el) {
    	alert('check index: ' + $el.closest('tr').data('index'));
    });
    $('#table').on('uncheck.bs.table', function (e, row, $el) {
    	alert('uncheck index: ' + $el.closest('tr').data('index'));
    });
    
    $(".fileinput-button").hide();
	$(".grid_attach_down").hide();
}

function excelFileDownload(gridName) {
// 	console.log('excelFileDownload('+gridName+')');
	
	var gridCols = w2ui[gridName].columns;
	var gridData = w2ui[gridName].records;

	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	if( gridName=='gridProc' ) {
		fileName = '입고요청목록.xlsx';
		sheetTitle = '입고요청목록';
		sheetName = '입고요청목록';
	} else if( gridName=='gridSernr' ) {
		fileName = '시리얼_대상목록.xlsx';
		sheetTitle = '시리얼 대상목록';
		sheetName = '시리얼 대상목록';
	} else if( gridName=='gridProcSubSernr' ) {
		fileName = '사급자재_시리얼_대상목록.xlsx';
		sheetTitle = '사급자재 시리얼 대상목록';
		sheetName = '사급자재 시리얼 대상목록';
	}
	
	var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
	var is_rownum = true;
	
	if(gridCols != null && gridCols.length > 0){
		// w2grid 는 linenumber column info not exist
		param_col_name = "No"
		param_col_id = "rownum";
		param_col_align = "center";
		param_col_width = "80";
		param_col_name += ",선택";
		param_col_id += ",rn";
		param_col_align += ",left";
		param_col_width += ",80";
		//--------------------------------------------
		for(var i=0; i<gridCols.length; i++){
			if(!gridCols[i].hidden){
				var caption = gridCols[i].caption;
				if( gridName=='gridProc' && (caption=='요청수량' || caption=='요청일자' || caption=='분기 미승인' )){
					param_col_name += "," + caption + '(*)';
				}else if( gridName=='gridSernr' && caption=='순차관리번호' ){
					param_col_name += "," + caption + '(*)';
				}else if( gridName=='gridProcSubSernr' && caption=='순차관리번호' ){
					param_col_name += "," + caption + '(*)';
				}else{
					param_col_name += "," + caption;
				}
				param_col_id += "," + gridCols[i].field;
				param_col_align += ",left";
				param_col_width += "," + (gridCols[i].width==undefined?"80":(gridCols[i].width).replace('px',''));
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
// 		console.log(export_data);
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

// status code select
function getStatusCodeList(gubun) {
	var page_url = "/frontend/scm/scm_sta_code_select"
	var postData = 'code_cat=' + encodeURIComponent(gubun);
				 
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$.each(data.rows, function (i, item) {
						$('#'+gubun).append($('<option>', { 
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

// serch parameter setting
function reloadGridProc(){
// 	console.log('reloadGridProc()');

	w2ui['gridProc'].clear();
	w2ui['gridSernr'].clear();
// 	w2ui['gridProc'].refresh();
	
	var vendor_status = $('#rvendor_status').val();
	var fDate = tDate = '';
	if( vendor_status=='v1' || vendor_status=='' ){
		fDate = $("#decide_date_range").val().substring(0,10);
		tDate = $("#decide_date_range").val().substring(13,23);	
	} else {
		fDate = $("#possible_date_range").val().substring(0,10);
		tDate = $("#possible_date_range").val().substring(13,23);
	}
	
	var pstyp = $("#pstyp").val();
	var subgridData = [];
	var page_url = "/frontend/scm/loadProc_select"
				 + "?jidat_from=" + encodeURIComponent(fDate)
				 + "&jidat_to=" + encodeURIComponent(tDate)
				 + "&pstyp=" + encodeURIComponent(pstyp)
				 + "&rvendor_status=" + encodeURIComponent(vendor_status)
				 + "&ebeln=" + encodeURIComponent($("#ebeln").val())
				 + "&matnr=" + encodeURIComponent($("#matnr").val())
				 + "&funcName=" + encodeURIComponent("ZMMFM_PURCH_ORD");
	if( lifnr!='' )
		page_url += "&lifnr=" + encodeURIComponent(lifnr);
	
	w2ui['gridProc'].lock('loading...', true);
	var rowArr = [];
	$.ajax({
	  url : page_url,
	  type : 'POST',
// 	  async : false,
	  dataType : 'json',
	  success : function( data ) {
	  	if(data.status == 200 ) {
	  		rowArr = data.rows;
	  		if( rowArr.length>0 ) {
		  		$.each(rowArr, function(idx, row){
		  			row.recid = idx+1;
		  			if( row.partial_yn=='Y' )
		  				row.w2ui = { style : 'background-color: #FBFEC0' };
		  		});
				w2ui['gridProc'].records = rowArr;
				w2ui['gridProc'].total = rowArr.length;
	  		} else {
	  			fnMessageModalAlert("...", "조회된 데이터가 없습니다.");
	  		}
	  	}
	  	w2ui['gridProc'].refresh();
  		w2ui['gridProc'].unlock();

  		if( vendor_status!='' || vendor_status!='v4' ) {
	  		$(".fileinput-button").show();
	  		$(".grid_attach_down").show();
  		} else {
  			$(".fileinput-button").hide();
	  		$(".grid_attach_down").hide();
  		}
  		
  		if(c_code ==  '1063') {
	  		$(".c_code_flag").hide();
	  	}

	  },complete: function () {
		  
	  }
	});
}

var chkArr = [];
// serch result grid
function fnLoadProcListGrid() {
// 	console.log('fnLoadProcListGrid()');
	
	$("#gridProc").w2grid({ 
        name: "gridProc",
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
			{ field : 'ebeln', caption:'문서번호 ', size: '100px', frozen: true}, 
			{ field : 'ebelp', caption:'문서품목', size: '65px', frozen: true, style:'text-align:center'},
			{ field : 'partial_seq', caption:'분기순번', size: '65px', frozen: true, style:'text-align:center'},
            { field : 'rvendor_status_nm', caption:'진행상태', size: '70px', frozen: true, style:'text-align:center'}, 
			{ field : 'matnr', caption:'품목', size: '150px'}, 
			{ field : 'txz01', caption:'내역', size: '150px'}, 
			{ field : 'menge', caption:'납품수량', size: '65px', render:'int'}, 
			{ field : 'eindt', caption:'납품일자', size: '100px', style:'text-align:center'},
			{ field : 'zdeli_menge', caption:'요청수량', size: '65px', render:'int'},
			{ field : 'vendor_delivery_date', caption:'요청일자', size: '100px', style:'text-align:center', editable: { type: 'date', format: 'yyyy-mm-dd'}},  
			{ field : 'rvendor_status', caption:'rvendor_status', size: '30%', hidden:true}, 
			{ field : 'rorder_status', caption:'rorder_status', size: '30%', hidden:true}, 
			{ field : 'diff_date', caption:'diff_date', size: '30%', hidden:true},
			{ field : 'werks', caption:'werks', size: '30%', hidden:true},
			{ field : 'bukrs', caption:'bukrs', size: '30%', hidden:true},
			{ field : 'lgort', caption:'lgort', size: '30%', hidden:true},
			{ field : 'ukey', caption:'ukey', size: '30%', hidden:true},
			{ field : 'partial_seq',caption:'partial_seq', size: '30%', hidden:true},
			{ field : 'zdue_menge',caption:'zdeli_menge', size: '30%', hidden:true},
			{ field : 'sernp',caption:'시리얼 대상', size: '75px', style:'text-align:center'},
			{ field : 'confirm_yn', caption:'일정확인', size: '65px', style:'text-align:center'},
			{ field : 'aedat', caption:'생성일자', size: '100px', style:'text-align:center'}, 
			{ field : 'partial_yn', caption:'분기 미승인', size: '95px', style:'text-align:center'},
			{ field : 'item_seq',caption:'item_seq', hidden:true},
			{ field : 'lifnr',caption:'lifnr', hidden:true},
			{ field : 'pstyp',caption:'pstyp', hidden:true},
			{ field : 'key_cnt', caption:'key_cnt', hidden:true},
			{ field : 'labnr',caption:'labnr', hidden:true}
        ],
      	sortData: [{field: 'recid', direction: 'ASC'}],
      	recordHeight : 30,
      	records : [],
      	total : 0,
		onReload: function(event) {
			reloadGridProc();
		},
		onClick: function (event) {
			event.onComplete = function () {
		        var selectArr = w2ui.gridProc.getSelection();
		        var sel = Number(event.recid);
				var selectedData = this.get(sel);

				var pstypCnt = 0;
	        	$("#btn_pstyp").hide();
	        	$.each(selectArr, function(idx, recid){
	        		if( (w2ui.gridProc.get(recid)).pstyp=='3' ) pstypCnt++;
	        	});
	        	if( pstypCnt>0 ) $("#btn_pstyp").show();

		        if( $.inArray(sel, chkArr) < 0 ){	// checkbox on
		        	// serial grid add by key
		        	$.each(w2ui.gridProc.records, function(idx, row){
						if( selectedData.ebeln==row.ebeln ){
				        	w2ui.gridProc.select(row.recid);
				        	chkArr.push(row.recid);
						}
		        	});
		        	gridProcEvent();
		        } else if( $.inArray(sel, chkArr) > -1 ){	// checkbox off
		        	// serial grid remove by key
		        	var sernrData = w2ui.gridSernr.records;
		        	$.each(w2ui.gridProc.records, function(idx, row){
						if( selectedData.ebeln==row.ebeln ){
				        	w2ui.gridProc.unselect(row.recid);
				        	chkArr.splice(chkArr.indexOf(row.recid), 1);
				        	$.each(sernrData, function(sdx, srow){
				        		if( row.sernp=='V001' ) {
				        			if( srow.ebeln==row.ebeln && srow.ebelp==row.ebelp ){    			
				        				w2ui.gridSernr.select(srow.recid);
				        			}
				        		} else { console.log('no serial Data'); }
				        	});
				        	if( row.sernp=='V001' ){
				        		w2ui.gridSernr.delete(true);
				        	}
						}
		        	});
		        }
		    }
		}
	});
	var fDate = $("#decide_date_range").val().substring(0,10);
	var tDate = $("#decide_date_range").val().substring(13,23);
	
	var page_url = "/frontend/scm/loadProc_select"
				 + "?jidat_from=" + encodeURIComponent(fDate)
				 + "&jidat_to=" + encodeURIComponent(tDate)
				 + "&funcName=" + encodeURIComponent("ZMMFM_PURCH_ORD")
				 + "&rvendor_status=v1";
	if( lifnr!='' )
		page_url += "&lifnr=" + encodeURIComponent(lifnr);
	
	w2ui['gridProc'].lock('loading...', true);
	var rowArr = [];
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 ) {
		  		rowArr = data.rows;
		  		if( rowArr.length>0 ) {
		  			$.each(rowArr, function(idx, row){
			  			row.recid = idx+1;
			  			if( row.partial_yn=='Y' )
			  				row.w2ui = { style : 'background-color: #FBFEC0' };
			  		});
			  		w2ui['gridProc'].records = rowArr;	  			
		  		} else {
		  			fnMessageModalAlert("...", "조회된 데이터가 없습니다.");
		  		}
		  	}
	  		w2ui['gridProc'].refresh();
	  		w2ui['gridProc'].unlock();
	  		
	  		$(".fileinput-button").show();
	  		$(".grid_attach_down").show();
	  		
	  		
			if(c_code ==  '1063') {
				$(".c_code_flag").hide();
		  	}
		},complete: function () {}
	});
}

function gridProcEvent() {
// 	console.log('gridProcEvent()');
	
	var selectArr = w2ui.gridProc.getSelection();
	w2ui.gridSernr.clear();
	w2ui.gridSernr.refresh();
	
	$.each(selectArr, function(idx, recid){
		var selectedData = w2ui.gridProc.get(recid);
		if( selectedData.sernp=='V001' ) {
			fnSearchSernrList(recid);
		} else { 
// 			console.log("no serial Data"); 
		}
	});
}

//detail grid setting
function fnLoadSernrListGrid() {
//	console.log('fnLoadSernrListGrid()');	
	$('#gridSernr').w2grid({ 
        name: 'gridSernr',
        show: { 
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
			{ field : 'ebeln', caption:'문서번호 ', size: '100px'}, 
			{ field : 'matnr', caption:'품목', size: '150px'}, 
			{ field : 'txz01', caption:'내역', size: '150px'}, 
			{ field : 'menge', caption:'요청수량', size: '100px'}, 
			{ field : 'zdeli_menge', caption:'납품수량', size: '100px'},
			{ field : 'equnr', caption:'순차관리번호', size: '100px', editable: function(record, index, col_index){
				if (record.sernp=='V001') return { type: 'text'};
				else return false;	}},
// 			, render: function(record, index, col_index){
// 						if (record.sernp=='V001') return this.getCellValue(index, col_index);
// 						else	return '시리얼 비대상';} },
			{ field : 'ebelp', caption:'문서품목', size:'0px'}, 
			{ field : 'partial_seq', caption:'분기순번', size: '0px'},
			{ field : 'sernp', caption:'sernp', hidden:true}],
      	sortData: [{field: 'ebeln', direction: 'ASC'}],
      	recordHeight : 30,
		onReload: function(event) {}
	});
}

// search detail list
function fnSearchSernrList(sel) {
// 	console.log('fnSearchSernrList(',sel,')');
	
	var selRowData = w2ui['gridProc'].get(sel);
// 	console.log(selRowData);
	var serialData = w2ui.gridSernr.records;
	if( selRowData!={} && Number(selRowData.menge)>0 && selRowData.sernp=='V001' ){
		// prevent duplaicate serial data
		if( w2ui.gridProc.getSelection().length==1)
			w2ui.gridSernr.clear();
		
		if( chkSernrExist(selRowData.ebeln, selRowData.ebelp) ){
// 			console.log(111);
			// already exist data
			var page_url = "/frontend/scm/rawProc_sernr_select"
						 + "?ebeln=" + encodeURIComponent(selRowData.ebeln)
						 + "&ebelp=" + encodeURIComponent(selRowData.ebelp)
						 + "&partial_seq=" + encodeURIComponent(selRowData.partial_seq);
			w2ui['gridSernr'].lock('Loading...', true);
			$.ajax({
			    url: page_url,
			    type: "POST",
			    success:function(data, textStatus, jqXHR){
			    	if(data.status == "200") {
			    		var objArr = data.rows;
			    		if ( objArr.length>0 ){
			    			var gridRecords = (w2ui['gridSernr'].records);
			    			var alreadyCnt = gridRecords.length;
							$.each(objArr, function(idx, row){
								row.recid = alreadyCnt + (idx+1);
								row.menge = 1;
								row.zdeli_menge = 1;
								row.werks = row.b_werks;
								row.lgort = row.b_lager;
								row.sernp = 'V001';
							});
							w2ui['gridSernr'].add(objArr);
			    		}
			    		w2ui['gridSernr'].total = (w2ui['gridSernr'].records).length; 
			    	}else{
			    		fnMessageModalAlert("Error", "정보를 가져오는데 에러가 발생하였습니다.");
			    	}
			    	w2ui['gridSernr'].unlock();
			    },
			    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("Error", "정보를 가져오는데 에러가 발생하였습니다.");	
			    },
			    complete: function() {}
			});
		} else {
// 			console.log(2322);
			w2ui['gridSernr'].lock('Loading...', true);
			var gridRecords = (w2ui['gridSernr'].records);
			var alreadyCnt = gridRecords.length;
// 			var arrTmpObj = [];
			for(var idx=0; idx<selRowData.zdeli_menge; idx++ ){
				var tmpObj = {};
				tmpObj.recid = alreadyCnt + (idx+1); 
				tmpObj.ebeln = selRowData.ebeln;
				tmpObj.ebelp = selRowData.ebelp;
				tmpObj.partial_seq = selRowData.partial_seq;
				tmpObj.matnr = selRowData.matnr;
				tmpObj.txz01 = selRowData.txz01;
				tmpObj.menge = 1; 
				tmpObj.zdeli_menge = 1; 
				tmpObj.sernp = 'V001';
// 				console.log(tmpObj);
				gridRecords.push(tmpObj);
			}
// 			console.log(gridRecords);
			
			w2ui['gridSernr'].records = gridRecords;	
			w2ui['gridSernr'].total = gridRecords.length;
			w2ui['gridSernr'].refresh();
    		w2ui['gridSernr'].unlock();
		}
	}
}

function chkSernrExist(ebeln, ebelp) {
// 	console.log('chkSernrExist()');

	var page_url = "/frontend/scm/rawProc_sernr_select";
	var postData = "ebeln=" + encodeURIComponent(ebeln)
				 + "&ebelp=" + encodeURIComponent(ebelp);
	var returnVal = false;	// not exist serial
	$.ajax({
	    url: page_url,
	    data: postData,
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					returnVal = true;
				}
	    	} else {
	    		fnMessageModalAlert("Error", "정보를 가져오는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Error", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
	return returnVal;
}

function fnLoadProcSubListGrid() {
// 	console.log('fnLoadProcSubListGrid()');
	$('#gridProcSub').w2grid({ 
        name: 'gridProcSub',
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
			{ field : 'ebeln', caption:'문서번호 ', size: '100px', style:'text-align:center'}, 
			{ field : 'ebelp', caption:'문서품목', size: '60px', style:'text-align:center'},
			{ field : 'matnr', caption:'자재번호', size: '150px'}, 
			{ field : 'maktx', caption:'자재명', size: '200px'},
            { field : 'werks', caption:'werks', size: '70px',hidden:true}, 
            { field : 'werks_nm', caption:'플랜트', size: '70px', style:'text-align:center'}, 
            { field : 'lgort', caption:'저장위치', size: '70px', hidden:true}, 
            { field : 'bdmng', caption:'소요량', size:'50px', render:'int'},
            { field : 'meins', caption:'단위', size:'70px'},
            { field : 'z1110_labst', caption:'의료 재고', size:'75px', render:'int'},
            { field : 'z1210_labst', caption:'광영상 재고', size:'75px', render:'int'},
            { field : 'zvendor_sllab', caption:'vendor 재고', size:'75px', render:'int'},
            { field : 'rsnum', caption: '예약/종속 소요량의 번호', size:'75px', hidden:true},
            { field : 'rspos', caption:'예약/종속 소요량에 대한 품목 번호', size:'75px', hidden:true},
            { field : 'xloek', caption:'삭제여부', size:'75px', hidden:true},
            { field : 'sernp', caption:'시리얼대상', size:'50px'},
            { field : 'date_created', caption:'date_created', hidden:true},
            { field : 'date_updated', caption:'date_updated', hidden:true} ],
      	sortData: [{field: 'recid', direction: 'ASC'}],
      	onReload : function(event){
      		reloadProcSubGrid();
      	}, 
		onClick: function (event) {
			event.onComplete = function () {
		        var selectArr = w2ui.gridProcSub.getSelection();
		        var sel = Number(event.recid);
				var selectedData = this.get(sel);
// 		    	console.log(selectedData.matnr);
		        if( $.inArray(sel, selectArr) > -1 ){	// checkbox on
// 		        	console.log("checked");
		        	fnSearchSubSernrList(sel);
		        } else {	// checkbox off
// 		        	console.log("not checked");
		        	// serial grid remove by key
		        	var sernrData = w2ui.gridProcSubSernr.records;
// 		        	console.log(sernrData)
		        	$.each(w2ui.gridProcSub.records, function(idx, row){
						if( selectedData.matnr==row.matnr ){
				        	w2ui.gridProcSub.unselect(row.recid);
						}
		        	});
// 		        	var arr = [];
		        	$.each(sernrData, function(sdx, srow){
		        		if( srow.matnr==selectedData.matnr ){
// 		        			arr.push(srow.recid);
// 							console.log(srow.recid);
		        			w2ui.gridProcSubSernr.select(srow.recid);
		        		}
		        	});
// 		        	console.log(w2ui.gridProcSubSernr.getSelection());
        			w2ui.gridProcSubSernr.delete(true);
//         			w2ui.gridProcSubSernr.refresh();
// 		        	w2ui.gridProcSubSernr.delete(true);
		        }
		    }
		}
	});
}

function fnSearchSubSernrList(sel) {
// 	console.log('fnSearchSubSernrList(',sel,')');
	
	var selRowData = w2ui['gridProcSub'].get(sel);
	var serialData = w2ui.gridProcSubSernr.records;
	if( selRowData!={} && Number(selRowData.bdmng)>0 && selRowData.sernp=='V001' ){
		// prevent duplaicate serial data
		if( w2ui.gridProcSub.getSelection().length==1)
			w2ui.gridProcSubSernr.clear();
		if( chkSernrExist(selRowData.ebeln, selRowData.ebelp) ){
			// already exist data
			var page_url = "/frontend/scm/rawProc_sernr_select"
						 + "?ebeln=" + encodeURIComponent(selRowData.ebeln)
						 + "&ebelp=" + encodeURIComponent(selRowData.ebelp);
			w2ui['gridProcSubSernr'].lock('Loading...', true);
			$.ajax({
			    url: page_url,
			    type: "POST",
			    success:function(data, textStatus, jqXHR){
			    	if(data.status == "200") {
			    		var objArr = data.rows;
			    		if ( objArr.length>0 ){
							$.each(objArr, function(idx, row){
								row.recid = idx+1;
								row.menge = 1;
								row.zdeli_menge = 1;
								row.werks = row.b_werks;
								row.lgort = row.b_lager;
							});
							w2ui['gridProcSubSernr'].add(objArr);
			    		}
			    		w2ui['gridProcSubSernr'].unlock();
			    	}else{
			    		fnMessageModalAlert("Error", "정보를 가져오는데 에러가 발생하였습니다.");
			    	}
			    },
			    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("Error", "정보를 가져오는데 에러가 발생하였습니다.");	
			    },
			    complete: function() {}
			});
		} else {
			var arrTmpObj = [];
			for(var idx=0; idx<selRowData.menge; idx++ ){
				var tmpObj = {};
				tmpObj.recid = idx+1; 
				tmpObj.ebeln = selRowData.ebeln;
				tmpObj.ebelp = selRowData.ebelp;
				tmpObj.matnr = selRowData.matnr;
				tmpObj.txz01 = selRowData.maktx;
				tmpObj.menge = 1; 
				tmpObj.zdeli_menge = 1; 
	
				arrTmpObj.push(tmpObj);
			}
			w2ui['gridProcSubSernr'].add(arrTmpObj);
		}
	}
}

function reloadProcSubGrid(){
// 	console.log('reloadProcSubGrid()');
	var selectedData = w2ui.gridProc.get(w2ui.gridProc.getSelection())[0];
	var page_url = "/frontend/scm/rawProcSub_select"
				 + "?ebeln=" + encodeURIComponent(selectedData.ebeln)
				 + "&ebelp=" + encodeURIComponent(selectedData.ebelp);

	w2ui['gridProcSub'].lock('loading...', true);
	var rowArr = [];
	$.ajax({
	  url : page_url,
	  type : 'POST',
	  dataType : 'json',
	  success : function( data ) {
	  	if(data.status == 200 && (data.rows).length>0 ) {
	  		rowArr = data.rows;
	  		$.each(rowArr, function(idx, row){
	  			row.recid = idx+1;
	  		});
	  		w2ui['gridProcSub'].records = rowArr;
	  	}
  		w2ui['gridProcSub'].refresh();
  		w2ui['gridProcSub'].unlock();
	  },complete: function () {}
	});
}

function fnLoadSernrSubListGrid() {
// 	console.log('fnLoadSernrSubListGrid()');
	$('#gridProcSubSernr').w2grid({ 
        name: 'gridProcSubSernr',
        show: { 
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
			{ field : 'ebeln', caption:'문서번호 ', size: '100px'}, 
			{ field : 'matnr', caption:'품목', size: '150px'}, 
			{ field : 'txz01', caption:'내역', size: '150px'}, 
			{ field : 'menge', caption:'요청수량', size: '70px'}, 
			{ field : 'zdeli_menge', caption:'납품수량', size: '70px'},
			{ field : 'equnr',caption:'순차관리번호', size: '100px', editable: { type: 'text', inTag:'maxlength=13' }}
        ],
        onReload : function(event){},
      	sortData: [{field: 'ebeln', direction: 'ASC'}]
	});
}

function saveSerials() {
// 	console.log('saveSerials()');	
 
	var rawValidationChk_result = rawValidationChk();		
	if(rawValidationChk_result == false) {
		return;
	}
	var gridDataArr = w2ui['gridSernr'].records;
	$.each(gridDataArr, function(idx, row){
		if( row.w2ui!=null || row.w2ui!=undefined )
			row.equnr = row.w2ui.changes.equnr; 
	});
// 	console.log(gridDataArr);
	
	var selection = w2ui['gridProc'].getSelection()[0];
	var selGridRowData = w2ui['gridProc'].get(w2ui['gridProc'].getSelection())[0];
	
	var page_url = "/frontend/scm/scmProc_sernr_insert"
	var postData = 'gridData=' + encodeURIComponent(JSON.stringify(gridDataArr))
				 + '&partial_seq=' + encodeURIComponent(selGridRowData.partial_seq)
				 + '&ebelp=' + encodeURIComponent(selGridRowData.ebelp)
				 + '&werks=' + encodeURIComponent(selGridRowData.werks)
				 + '&lgort=' + encodeURIComponent(selGridRowData.lgort);
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalConfirm("Success", "정보를 저장하였습니다.", function(chk){
		    		if(chk){
						updateStatus();
	    				w2ui['gridSernr'].clear();
	    				reloadGridProc();
	    				w2ui['gridProc'].select(selection);
	    			}
	    		});
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}

function saveSubSerials() {
// 	console.log('saveSubSerials()');	
	var gridDataArr = w2ui['gridProcSubSernr'].records;
	$.each(gridDataArr, function(idx, row){
		if(row.w2ui!=undefined)
			row.equnr = row.w2ui.changes.equnr;
	});	
	var selection = w2ui['gridProcSub'].getSelection()[0];
	var selGridRowData = w2ui['gridProcSub'].get(w2ui['gridProcSub'].getSelection())[0];
	var page_url = "/frontend/scm/scmProc_sernr_insert"
	var postData = 'gridData=' + encodeURIComponent(JSON.stringify(gridDataArr))
				 + '&partial_seq=' + encodeURIComponent('-')
				 + '&ebelp=' + encodeURIComponent(selGridRowData.ebelp)
				 + '&werks=' + encodeURIComponent(selGridRowData.werks)
				 + '&lgort=' + encodeURIComponent(selGridRowData.lgort);
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalConfirm("Notification(SCM)", "정보를 저장하였습니다.", function(chk){
		    		if(chk){
// 						updateStatus();
// 	    				w2ui['gridProcSubSernr'].clear();
// 	    				reloadGridProc();
// 	    				w2ui['gridProc'].select(selection);
	    			}
	    		});
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}

function chkSubGridData(subObj) {
// 	console.log('chkSubGridData()');
	
	var returnVal = 0;
	var page_url = "/frontend/scm/rawProc_sernr_select"
	var postData = 'ebelp=' + encodeURIComponent(subObj.ebelp)
				 + '&ebeln=' + encodeURIComponent(subObj.ebeln);
	$.ajax({
	    url: page_url,
	    data: postData,
	    async:false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		returnVal = (data.rows).length;
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 실행하는데 에러가 발생하였습니다.(chkSubGridData)");	
	    },
	    complete: function() {
	    }
	});
	return returnVal;
}

function updateStatus() {
	console.info('updateStatus()');
	var selRowData = w2ui['gridProc'].get(w2ui['gridProc'].getSelection())[0]; 
	var delivery_date = selRowData.enidt;
	var vendor_delivery_date = selRowData.vendor_delivery_date;
	var diff_date = (delivery_date==vendor_delivery_date)?'N':'Y';
	
	var page_url = "/frontend/scm/rawProcNextStep_update"
	var postData = 'ebelp=' + encodeURIComponent(selRowData.ebelp)
				 + '&ebeln=' + encodeURIComponent(selRowData.ebeln)
				 + '&rvendor_status=v2'
				 + '&partial_seq=' + encodeURIComponent(selRowData.partial_seq)
				 + '&vendor_delivery_date=' + encodeURIComponent(vendor_delivery_date)
// 				 + '&zdeli_menge=' + encodeURIComponent(zdeli_menge)
				 + '&diff_date=' + encodeURIComponent(diff_date);
	
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    }
	});
}

/*
function updateDeliveryStatus(staus, zdeli_menge) {
	console.info('updateDeliveryStatus(',staus,zdeli_menge,')');
	
	var selRowData = $("#gridProc").getRowData($("#gridProc").getGridParam('selrow'));
	
// 	var delivery_date = $.datepicker.formatDate('yy-mm-dd', $("#delivery_date").datepicker("getDate"));  // ?
// 	var vendor_delivery_date = $.datepicker.formatDate('yy-mm-dd', newDate);	// ?
	var delivery_date = selRowData.enidt;
	var vendor_delivery_date = selRowData.vendor_delivery_date;
	
	if( selRowData.partial_seq!='' ){
		// 분할 케이스인 경우
		vendor_delivery_date = selRowData.vendor_delivery_date;
	}
	
	var diff_date = (delivery_date==vendor_delivery_date)?'N':'Y';
	
	var page_url = "/frontend/scm/delivery_status_update"
	var postData = 'ebelp=' + encodeURIComponent(selRowData.ebelp)
				 + '&ebeln=' + encodeURIComponent(selRowData.ebeln)
				 + '&rvendor_status=' + encodeURIComponent(staus)
				 + '&delivery_date=' + encodeURIComponent(delivery_date)
	 			 + '&vendor_delivery_date=' + encodeURIComponent(vendor_delivery_date)
	 			 + '&zdeli_menge=' + encodeURIComponent(zdeli_menge)
	 			 + '&diff_date=' + encodeURIComponent(diff_date);
	
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    }
	});
}
*/

//거래명세서 발행-barcode
function makeTranDetails() {
	fnMessageModalAlert("Sorry!", "해당 기능은 준비중입니다.");
}

function fnSernrLoadFileHandler(){
// 	console.log('fnSernrLoadFileHandler()');
	var page_url = "/file/sernrlist_import_upload";
	
	$('#sernrfileupload').fileupload({
		url : page_url,
		dataType : 'json',
		async:false,
		autoUpload : true,
		acceptFileTypes : /(\.|\/)(xlsx)$/i,
		maxFileSize : 106800000, 
	}).on('fileuploadadd', function(e, data) {
	}).on('fileuploadprocessalways', function(e, data) {
		var index = data.index;
		var file = data.files[index];
		if (file.error) {
			fnMessageModalAlert("Notification", file.error);
		}
	}).on('fileuploadprogressall', function(e, data) {
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#progress .progress-bar').css('width', progress + '%');
	}).on('fileuploaddone', function(e, data) {
		var selRowData = w2ui['gridProc'].get(w2ui['gridProc'].getSelection())
// 		var selRowData = $("#"+selectGridId).getRowData(mainKey);
		var arrData = data.result.rows;
		var priData = [];
		$.each(arrData, function(idx, row){
			var tmpObj = {};
			tmpObj.recid = idx+1;
			tmpObj.ebeln = row.ebeln;
			tmpObj.ebelp = row.ebelp;
			tmpObj.matnr = row.matnr;
			tmpObj.txz01 = row.txz01;
			tmpObj.menge = 1;
// 			tmpObj.menge = selRowData.menge;
			tmpObj.zdeli_menge = 1;
			tmpObj.partial_seq = row.partial_seq;
			tmpObj.equnr = row.equnr;
			priData.push(tmpObj);
		});
		/*
		for(var i=0; i<data.result.rows.length; i++ ){
			var tmpObj = {};
			tmpObj.recid = i;
			tmpObj.ebeln = selRowData[0].ebeln;
			tmpObj.matnr = selRowData[0].matnr;
			tmpObj.txz01 = selRowData[0].txz01;
			tmpObj.menge = 1;
// 			tmpObj.menge = selRowData.menge;
			tmpObj.zdeli_menge = 1;
			tmpObj.partial_seq = selRowData[0].partial_seq;
			tmpObj.equnr = arrData[i].equnr;
			priData.push(tmpObj);
		}
		*/
		w2ui['gridSernr'].records = priData;
		w2ui['gridSernr'].refresh();
	}).on('fileuploadfail', function(e, data) {
		$.each(data.files, function(index) {
			fnMessageModalAlert("Notification", "File upload failed.");
		});
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}

function fnReqLoadFileHandler(){
// 	console.log('fnReqLoadFileHandler()');

	$('#reqfileupload').fileupload({
		url : "/file/reqlist_import_upload",
		dataType : 'json',
		async:false,
		autoUpload : true,
		acceptFileTypes : /(\.|\/)(xlsx)$/i,
		maxFileSize : 106800000, 
	}).on('fileuploadadd', function(e, data) {
		
	}).on('fileuploadprocessalways', function(e, data) {
		var index = data.index;
		var file = data.files[index];
		if (file.error) {
			fnMessageModalAlert("Notification", file.error);
		}
	}).on('fileuploadprogressall', function(e, data) {
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#progress .progress-bar').css('width', progress + '%');
	}).on('fileuploaddone', function(e, data) {
		if(data.result.status==200) {
			var msg = "업로드가 정상적으로 실행되었습니다.<br> "
					+ "<span style='color:red;font-weight: bold;'>반드시 변경된 데이터에 대하여 [저장]을 실행하여야 합니다.</span><br>";
			fnMessageModalAlert("Success", msg);
		} else {	// 500
			if( data.result.msg!=null && data.result.msg!=undefined ) {
				if(data.result.msg=='menge'){
					fnMessageModalAlert("Error", "업로드에 실패하였습니다.<br>문서번호의 요청수량의 합과 납품수량이 다릅니다.");
				} else if(data.result.msg=='vendor_delivery_date') {
					fnMessageModalAlert("Error", "업로드에 실패하였습니다.<br>요청일자가 입력되지 않은 항목이 존재합니다.");
				} else if(data.result.msg=='zdeli_menge') {
					fnMessageModalAlert("Error", "업로드에 실패하였습니다.<br>요청수량이 입력되지 않은 항목이 존재합니다.");
				}
			}
		}
 		reloadGridProc();
	}).on('fileuploadfail', function(e, data) {
		$.each(data.files, function(index) {
			fnMessageModalAlert("Notification", "File upload failed.");
		});
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}

function fnSubLoadFileHandler(){
// 	console.log('fnSubLoadFileHandler()');
	var page_url = "/file/sernrlist_import_upload";
	
	$('#subsernrfileupload').fileupload({
		url : page_url,
		dataType : 'json',
		async:false,
		autoUpload : true,
		acceptFileTypes : /(\.|\/)(xlsx)$/i,
		maxFileSize : 106800000, 
	}).on('fileuploadadd', function(e, data) {
	}).on('fileuploadprocessalways', function(e, data) {
		var index = data.index;
		var file = data.files[index];
		if (file.error) {
			fnMessageModalAlert("Notification", file.error);
		}
	}).on('fileuploadprogressall', function(e, data) {
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#progress .progress-bar').css('width', progress + '%');
	}).on('fileuploaddone', function(e, data) {
		var selRowData = w2ui['gridProcSub'].get(w2ui['gridProcSub'].getSelection())
// 		var selRowData = $("#"+selectGridId).getRowData(mainKey);
		var arrData = data.result.rows;
		var priData = [];
		for(var i=0; i<data.result.rows.length; i++ ){
			var tmpObj = {};
			tmpObj.recid = i;
			tmpObj.ebeln = selRowData[0].ebeln;
			tmpObj.matnr = selRowData[0].matnr;
			tmpObj.txz01 = selRowData[0].maktx;
			tmpObj.menge = 1;
// 			tmpObj.menge = selRowData.menge;
			tmpObj.zdeli_menge = 1;
// 			tmpObj.partial_seq = selRowData[0].partial_seq;
			tmpObj.equnr = arrData[i].equnr;
			priData.push(tmpObj);
		}
		w2ui['gridProcSubSernr'].records = priData;
		w2ui['gridProcSubSernr'].refresh();
	}).on('fileuploadfail', function(e, data) {
		$.each(data.files, function(index) {
			fnMessageModalAlert("Notification", "File upload failed.");
		});
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}

function rawValidationChk() {
// 	console.log('rawValidationChk()');
	
	var rawValidationChk_result = null;
	var gridDataArr = w2ui['gridSernr'].records;
	var selection = w2ui['gridProc'].getSelection();
	var selRowData = w2ui['gridProc'].get(selection[0]);
	var arrSernr = [];

	$.each(gridDataArr, function(idx, row){
		var equnr;
		if(row.w2ui==undefined)
			equnr = row.equnr;
		else
			equnr = row.w2ui.changes.equnr;
		arrSernr.push(equnr);
	});
	// 순차관리  체크 박스
	if( gridDataArr.length != (w2ui['gridSernr'].getSelection().length) ){
		fnMessageModalAlert("Warning", "체크되지 않은 항목이 았습니다.<br>모든 항목을 체크해 주시기 바랍니다.");
		rawValidationChk_result = false;
 		return false;
	}
// 	if( gridDataArr.length != selection.length ){
// 		fnMessageModalAlert("Notification(SCM)", "체크되지 않은 항목이 았습니다.<br>모든 항목을 체크해 주시기 바랍니다.");
// 		rawValidationChk_result = false;
//  		return false;
// 	}
	
	// 순차관리 null 입력 여부 체크
	var nullCnt = 0;
	$.each(arrSernr, function(idx, row){
		if( row==null || row==undefined || $.trim(row)=='' ) { 
			nullCnt++;
		}
	});
	if( nullCnt>0 ) {
		fnMessageModalAlert("Warning", "입력되지않은 번호가 있습니다.<br> 순차관리번호를 모두 입력해주십시오.");
		rawValidationChk_result = false;
		return false;
	}
// 	$.each(gridDataArr, function(idx, row){
// 		var equnr;
// 		if(row.w2ui==undefined)
// 			equnr = row.equnr;
// 		else
// 			equnr = row.w2ui.changes.equnr;
// 		if( equnr == null || equnr == '') {
// 			fnMessageModalAlert("Warning", "순차관리번호를 입력해주십시오.");
// 			rawValidationChk_result = false;
// 			return false;
// 		}
// 	});	
	
	// 순차관리 중복 입력 여부 체크 
	$.unique(arrSernr);
	if( gridDataArr.length!=arrSernr.length ){
		fnMessageModalAlert("Notification(StatusChk)", "순차관리 번호를 중복 입력하였습니다.");
		rawValidationChk_result = false;
	}
			
	// 상태 체크
	var page_url = "/frontend/scm/rawProc_selectByKey";
	var postData = "ebeln=" + encodeURIComponent(selRowData.ebeln)
				 + "&ebelp=" + encodeURIComponent(selRowData.ebelp)
				 + "&partial_seq=" + encodeURIComponent(selRowData.partial_seq);
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				var result = (data.rows)[0].rvendor_status;
				if(result != 'v1') {
					rawValidationChk_result = false;
					fnMessageModalAlert("Notification(StatusChk)", "이미 요청처리가 완료된 데이터 입니다.");
				}
			} else {
				rawValidationChk_result = false;	
				fnMessageModalAlert("Notification(StatusChk)", "요청처리를 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(StatusChk)", "요청처리를 실패했습니다.");
		},
		complete : function() { }			
	});
	if(rawValidationChk_result == false) {
		return rawValidationChk_result;
	}
	
	// 순차관리번호 중복 DB 체크
	var page_url = "/frontend/scm/rawProc_sernr_duplication_chk";
	var postData = "sernrs=" + encodeURIComponent(arrSernr.toString());
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				var resultJson = JSON.parse(JSON.stringify(data));
				var result_len = resultJson.rows.length;
				if(result_len > 0) {
					rawValidationChk_result = false;
					fnMessageModalAlert("Notification(StatusChk)", "순차관리번호가 기존 등록된 내역과 중복됩니다.");
				}		
			} else {
				rawValidationChk_result = false;	
				fnMessageModalAlert("Notification(StatusChk)", "요청처리를 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(StatusChk)", "요청처리를 실패했습니다.");
		},
		complete : function() {}			
	});
	if(rawValidationChk_result == false) {
		return rawValidationChk_result;
	}
}

function fnSearchMntrNm(){
	$('#modal_detail').modal('show');
}

//search itnbr list
function searchItnbrpopup(){
	var page_url = '/frontend/hub/material_recv_master_select'
				 + '?wrkst=' + encodeURIComponent($('#itnbr_search_popup').val());
	$("#grid_itnbrlist").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_itnbrlist").trigger("reloadGrid");
}

function initItnbrGrid() {
	var page_url = '/frontend/hub/material_recv_master_select';
	$('#grid_itnbrlist').jqGrid({
		url:page_url,
		datatype: 'json',
		colNames:['자재코드','자재내역',' Spec.','제품군명', '자재그룹명', '생성일자', '수정일자'],
		colModel:[
			{name:'matnr',index:'matnr', width:100, sorttype:'text', sortable:true, key: true},
			{name:'maktx',index:'maktx', width:150, sorttype:'text', sortable:true},
			{name:'wrkst',index:'wrkst', width:150, sorttype:'text', sortable:true, sortable:true},
			{name:'vtext',index:'vtext', sorttype:'text', sortable:true, hidden:true},
			{name:'wgbez',index:'wgbez', sorttype:'text', sortable:true, hidden:true},
			{name:'date_created',index:'date_created', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'date_updated',index:'date_updated', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true}
		],
		pager : '#grid_itnbrlist_pager',
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
		loadComplete : function() {
		}
	});
}
function initNewItnbrGrid() {
	$('#grid_addItnbr_list').jqGrid({
		url:'',
		datatype: 'json',
		colNames:['자재코드','자재내역',' Spec.','제품군명', '자재그룹명', '생성일자', '수정일자'],
		colModel:[
			{name:'matnr',index:'matnr', width:100, sorttype:'text', sortable:true, key: true},
			{name:'maktx',index:'maktx', width:150, sorttype:'text', sortable:true},
			{name:'wrkst',index:'wrkst', width:150, sorttype:'text', sortable:true, sortable:true},
			{name:'vtext',index:'vtext', sorttype:'text', sortable:true, hidden:true},
			{name:'wgbez',index:'wgbez', sorttype:'text', sortable:true, hidden:true},
			{name:'date_created',index:'date_created', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'date_updated',index:'date_updated', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true}
		],
// 		pager : '#grid_addItnbr_list_pager',
		rowNum: 20,
// 		rowList : [ 20, 50, 100 ],
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 410,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    sortable: true,
	    sortname: 'matnr',
		loadComplete : function() {
		}
	});
}


function initNewDocGrid() {
	$("#grid_doc_list").w2grid({
		name : 'grid_doc_list',
		show : {
			lineNumbers : true,
			selectColumn: true,
            footer: true
        },
		columns : [
				{ field : 'ebeln', caption:'문서번호 ', size: '100px', frozen: true}, 
				{ field : 'ebelp', caption:'문서품목', size: '65px', frozen: true, style:'text-align:center'},
				{ field : 'matnr', caption:'품목', size: '120px'}, 
				{ field : 'txz01', caption:'내역', size: '120px'},
				{ field : 'eindt', caption:'납품일자', size: '100px'}
			],
		recordHeight : 30,
		sortData : [{field: 'matnr', direction: 'ASC'}],
		records : [],
		total : 0,
	    onSelect : function(event) {}
	});
}

var dataArr = [];
function addItnbrDetail() {
	var groupInfo = $("#grid_itnbrlist").getRowData($("#grid_itnbrlist").getGridParam('selrow'));
	var gridDataArr = $('#grid_addItnbr_list').jqGrid('getRowData');
	// 추가하려는 목록이 선택 되었는가?
	if( groupInfo.matnr == undefined || groupInfo.matnr == undefined){
		fnMessageModalAlert("확인하세요", "추가하려는 항목을 선택해야 합니다.");
	} else {
		// 기존에 추가된 항목인지 확인
		if( gridDataArr.length>0 ){
			var chkCnt = 0;
			for(var idx=0; idx<gridDataArr.length; idx++){
				if( gridDataArr[idx].matnr == groupInfo.matnr ){
					chkCnt++;
				}
			}
			// chkCnt가 0보다 크면, 같은 항목이 한개 이상 있다는...
			if( chkCnt==0 ){
				dataArr.push(groupInfo);
				$("#grid_addItnbr_list").jqGrid('addRow',{position  :"last",
						initdata  : groupInfo});
			}
		}else{
			dataArr.push(groupInfo);
			$("#grid_addItnbr_list").jqGrid('addRow',{position  :"last",
					initdata  : groupInfo});	
		}
	}
}

// remove new itnbr list
function deleteItnbrDetail() {
	$("#grid_addItnbr_list").jqGrid('delRowData', $("#grid_addItnbr_list").getGridParam('selrow'));
}

function inputMntrs(){
	var gridDataArr = $('#grid_addItnbr_list').jqGrid('getRowData');
	var matnr = '';
	
	for(var i=0 ; i<gridDataArr.length; i++){
		matnr = matnr + gridDataArr[i].matnr + ',';
	} 
	
	if(matnr.length != 0)
		matnr = matnr.substring(0, matnr.length-1);
	
	$('#mntr_nm').val(matnr);
	$('#grid_addItnbr_list').jqGrid('clearGridData');
	$("#modal_detail").modal('hide');
}

function checkOrder() {
// 	console.log('checkOrder()');
	var selectKeyArr = w2ui.gridProc.getSelection();
	if( selectKeyArr.length==0 ){
		fnMessageModalAlert("Warning...", "일정확인 대상이 선택되지 않았습니다.");
		return;		
	}
	
	var paramObjArr = [];
	var uKeyArr = [];
	$.each(selectKeyArr, function(idx, key){
		var rowData = w2ui.gridProc.get(key)
		var paramObj = {};
		paramObj.ebeln = rowData.ebeln;
		paramObj.ebelp = rowData.ebelp;
		paramObj.partial_seq = rowData.partial_seq;
		paramObj.partial_yn = 'Y';
		if( rowData.w2ui==undefined ) {
			if( rowData.vendor_delivery_date==''||rowData.vendor_delivery_date==null) {
				paramObj.vendor_delivery_date = rowData.eindt;
			} else {
				paramObj.vendor_delivery_date = rowData.vendor_delivery_date;
			}
		} else {
			var chn = rowData.w2ui.changes;
			if( chn.vendor_delivery_date!=undefined ) {
				paramObj.vendor_delivery_date = chn.vendor_delivery_date;
			} else {
				paramObj.vendor_delivery_date = rowData.vendor_delivery_date;
			}
		}
		paramObj.zdeli_menge = rowData.zdeli_menge;
// 		paramObj.confirm_date = paramObj.vendor_delivery_date;
// 		paramObj.confirm_date = paramObj.confirm_date; ???
		paramObj.order_delivery_date = paramObj.vendor_delivery_date;
		paramObj.confirm_yn = 'Y';
		
		paramObj.diff_date = 'N';
		if( paramObj.vendor_delivery_date!=rowData.eindt )
			paramObj.diff_date = 'Y';
	
		paramObj.key_cnt = rowData.key_cnt;
		uKeyArr.push(rowData.ebeln);
		paramObjArr.push(paramObj);
	});
	
	var page_url = "/frontend/scm/rawProcConfirmYn_update";
	var params = "params=" + encodeURIComponent(JSON.stringify(paramObjArr))
			   + "&uKeyArr=" + encodeURIComponent(JSON.stringify(uKeyArr));
	$.ajax({
		url:page_url,
		data:params,
		type:'POST',
		dataType: 'json',
		success: function( data ) {
			if(data.status == 200) {
				fnMessageModalAlert("Success...", "일정변경확인이 정상적으로 처리되었습니다.");
				reloadGridProc();
			} else {
				fnMessageModalAlert("Warning...", "일정변경확인 중 오류가 발생하였습니다.");
			}
		},complete: function () {}
	});
}

function pstypSernr() {
// 	console.log('pstypSernr()');
	/*
	1. 선택된 목록을 가져온다.
	2. 목록 중 po가 여러개인것은 처리 할 수 없다는 오류 메세지 표시하여 한개의 po만 가져올 수 있도록 한다.
	3. 한개의 po만 있다면, 사급상세 오더의 시리얼 번호를 입력하기 위한 팝업 창을 띄운다.
	*/
	var selectdGridData = w2ui.gridProc.get(w2ui.gridProc.getSelection());
	var ebelnArr = [];
	$.each(selectdGridData, function(idx, row){
		ebelnArr.push(row.ebeln);
	});
	var ebelnCnt = ($.unique(ebelnArr)).length;
	if ( ebelnCnt>1 ){
		fnMessageModalAlert("Warning...", "한개의 문서번호를 선택하여야 합니다.");
		return;
	}
	w2ui.gridProcSubSernr.clear();
	$("#modal_procSub").modal('show');
	
	setTimeout(function(){
		w2ui.gridProcSub.resize();
		reloadProcSubGrid();
		w2ui.gridProcSubSernr.resize();
		w2ui.gridProcSubSernr.refresh();
		w2ui.gridProcSubSernr.reload();
	}, 300);
	
}

function chkNumber(obj){
	if( !cf_isNumber($(obj).val()) ){
		fnMessageModalAlert("Warning...", "수량은 숫자형식으로 입력해야 합니다.");
		$(obj).val('0');
		$(obj).focus();
		return;
	}
}

function getTransactionList(flag) {
// 	console.log('getTransactionList('+flag+')');

	var poData = [];
	poData =w2ui.gridProc.get(w2ui.gridProc.getSelection());
	
	var rvendor_status = $("#s_status").val();
	
	var s_rowdata = [];
	w2ui['grid_doc_list'].clear();

	for(var i=0 ; i<poData.length; i++) {
		if(poData[i].ebeln ==  $("#trs_ebeln").val()) {
			s_rowdata.push(poData[i]);
		}
	}
	
	w2ui.grid_doc_list.clear();
	w2ui.grid_doc_list.refresh();
	w2ui.grid_doc_list.records = s_rowdata;
	w2ui.grid_doc_list.refresh();
	
	var ebelnArr = [];
	$.each(poData, function(idx, row){
		ebelnArr.push(row.ebeln);
	});
	$.unique(ebelnArr);
	
   if(rvendor_status == 'v1') {
	   $("#trs_labnr_area").hide();
   } else if(rvendor_status == 'v2' || rvendor_status == 'v4') {
	   $("#trs_labnr_area").show();
   }
	if( flag=='a' ){
		$.each(ebelnArr, function(idx, item){
			if( idx==0 ) {
				$("#trs_ebeln").append($('<option>', { 
			        value: '', text : '선택'
			    }));
			}
			$("#trs_ebeln").append($('<option>', { 
		        value: item, text : item 
		    }));
		});
	} 
	if( flag=='b' && (rvendor_status == 'v2'  || rvendor_status == 'v4')) {
		initOptions($("#trs_labnr"));
		var labnrArr = [];
		$.each(poData, function(idx, row){
			if( row.ebeln==$("#trs_ebeln").val() ){
				//labnrArr.push(row.labnr.substring(0,15));
				labnrArr.push(row.labnr);
			}
		});
		
		if( labnrArr.length>0 ){
			$("#trs_labnr_area").show();
			$.unique(labnrArr);
			$.each(labnrArr, function(idx, item){
				if( idx==0 ) {
					$("#trs_labnr").append($('<option>', { 
				        value: '', text : '선택'
				    }));
				}
				
				if(item != null){
					$("#trs_labnr").append($('<option>', { 
				        value: item, text : item 
				    }));	
				}
				
			});	
		} 
	}
} 

function printTransacion() {
// 	console.log('printTransacion()');
	
	$("#d_print").prop("checked", true);
	$('.for_print').show();
	
	var gridPoData = w2ui.gridProc.get(w2ui.gridProc.getSelection());
	if( gridPoData.length==0 ) {
		fnMessageModalAlert("Warning", "출력하고자 하는 문서번호를 선택후 다시 시도하시기 바랍니다.");
		return;
	}
	
	var statusArr = [];
	var uniqueStatusArr = [];
	
	for(var i=0 ; i<gridPoData.length; i++) {
		statusArr.push(gridPoData[i].rvendor_status);
	}

	$.each(statusArr, function(i, el){
		if($.inArray(el, uniqueStatusArr) === -1) uniqueStatusArr.push(el);
	});

	if(uniqueStatusArr.length != 1) {
		fnMessageModalAlert("Warning", "선택 된 내역의 처리 상태가 동일해야합니다.<br>오더를 다시 선택한 후에 시도하시기 바랍니다.");
		return;
	}	
	
	$('#r_conf_date').val($.datepicker.formatDate('yymmdd', new Date()));
	
	var rvendor_status = uniqueStatusArr[0];
	
	$("#s_status").val(rvendor_status);
	
	if(rvendor_status == 'v1') {
		$("#grid_doc_list").show();
	} else if(rvendor_status == 'v2' ||rvendor_status == 'v4') {
		$("#grid_doc_list").hide();
	} 
	
	
	if( rvendor_status!='v1' && rvendor_status!='v2' && rvendor_status!='v4' ) {
		fnMessageModalAlert("Warning", "검색조건의 처리 상태가  [ 협력사 확인대상, 협력사확인완료, 변경요청승인 ] 이 아닙니다.<br> 다시 선택 후 조회하여 시도하시기 바랍니다. ");
		return;
	}
	if( rvendor_status!='v1' && rvendor_status!='v2' && rvendor_status!='v4' ) {
		fnMessageModalAlert("Warning", "구매오더 목록이 [ 협력사 확인대상, 협력사확인완료, 변경요청승인 ] 이 아닙니다.<br> 조회하여 시도하시기 바랍니다. ");
		return;
	}
	
	var next = true;
	$.each(gridPoData, function(idx, row){
		if( row.rvendor_status!='v1' && row.rvendor_status!='v2' && row.rvendor_status!='v4' ) {
			var msg = "선택한 문서번호(" + row.ebeln + ")는 거래명세표를 출력할 수 있는 처리상태가 아닙니다.<br>"
					+ "처리상태가 [ 협력사 확인대상, 협력사확인완료, 변경요청승인 ] 인 경우에만 가능합니다."
			fnMessageModalAlert("Warning", msg);
			next = false;
		}
	});
	
	initOptions($("#trs_ebeln"));
	initOptions($("#trs_labnr"));
	
	if( next ) {
		// po
		getTransactionList('a');
		if( rvendor_status=='v1') $("#trs_labnr_area").hide();
		else $("#trs_labnr_area").show();
		
		setTimeout(function(){
			w2ui.grid_doc_list.resize();
			w2ui.grid_doc_list.refresh();
			w2ui.grid_doc_list.reload();
		}, 200);
		
		$("#modal_tansaction").modal('show');
	}
}

function printDoc() {
	
	var rdo_req_type =  $(':radio[name="rdo_req_type"]:checked').val();
	
	if(rdo_req_type == 'Y' && $("#r_conf_date").val().length == 0) {
		fnMessageModalAlert("Notification(SCM)", "납품일자를 선택해주세요." );
		return;		 
	}
	
	
	var rvendor_status = $("#s_status").val();
	var selectEbeln = $("#trs_ebeln").val();
	var selectLabnr = $("#trs_labnr").val();
	console.log("selectEbeln :: " + selectEbeln);
	console.log("selectLabnr :: " + selectLabnr);

	var labnr = '';
	if( selectLabnr!=null )
		//labnr = selectLabnr.substring(0,15);
		labnr = selectLabnr; 
	
	var page_url = "/frontend/scm/trans_receipt_select";
	var post_data = "";
	if( selectLabnr!=null )
		post_data += "labnr="+encodeURIComponent(labnr);
	else
		post_data += "ebeln="+encodeURIComponent(selectEbeln);
	
	if(rvendor_status == 'v2' || rvendor_status == 'v4') {
		if(selectEbeln.length == 0) {
			fnMessageModalAlert("Notification(SCM)", "문서번호를 선택해주세요." );
			return;
		} else if(selectLabnr == null || selectLabnr.length == 0) {
			fnMessageModalAlert("Notification(SCM)", "납품일정번호가 존재하지 않아 거래명세서를 발행할 수 없습니다." );
			return;
		} 
	}
	
	if(rvendor_status == 'v1') {
		if(selectEbeln.length ==0) {
			fnMessageModalAlert("Notification(SCM)", "문서번호를 선택해주세요." );
			return;
		}
	}
	var r_data;
	$.ajax({
	  url:page_url,
	  data:post_data,
	  type:'POST',
	  async:false,
	  dataType: 'json',
	  success: function( data ) {
	  	if(data.status == 200) {
	  		if(rvendor_status == 'v1') {
		  		var tmp_data = [];
		  		var selectArr = w2ui.grid_doc_list.get(w2ui.grid_doc_list.getSelection());
				for(var i=0 ; i<data.rows.length ;  i++) {
					for(var k=0 ; k<selectArr.length ;  k++) {
						if(selectArr[k].ebeln == data.rows[i].ebeln) {
							if( (selectArr[k].ebelp == data.rows[i].ebelp) &&  (selectArr[k].partial_seq == data.rows[i].partial_seq)) {
								tmp_data.push(data.rows[i]);	
							}
						}
			  		}
				}
				r_data = tmp_data;
	  		} else if(rvendor_status == 'v2' || rvendor_status == 'v4') {
	  			r_data = data.rows;
	  		}
	  	}
	  },
	  complete: function () {}
	});		
	if(r_data.length == 0) {
		fnMessageModalAlert("Notification(SCM)", "출력대상 데이터가 없습니다." );
		return;
	}
	
	$('#row_0_2').html("120-81-93796");
	$('#row_0_7').html("");
	$('#row_1_2').html("뷰웍스(부가세)");
	$('#row_1_4').html("김후식");
	$('#row_1_7').html(r_data[0].name1);
	$('#row_1_9').html(r_data[0].j_1kfrepre);
	$('#row_2_2').html('경기도 안양시 동안구 관양동 1736-3');
	$('#row_2_7').html(r_data[0].ort01);	
		
	var my_tbody = document.getElementById('my0-tbody_1');
	var netpr = 0; 
	var supply_total = 0;
	var netpr_total = 0;
	var cnt = 0;
	
	for(var i=0 ; i<r_data.length; i++) {
		var oRow = my_tbody.insertRow();	
		var oCell1 = oRow.insertCell();
		oCell1.id = "rCell1";
		var oCell2 = oRow.insertCell();
		oCell2.id = "rCell2";
		var oCell3 = oRow.insertCell();
		oCell3.id = "rCell3";
		var oCell4 = oRow.insertCell();
		oCell4.id = "rCell4";
		var oCell5 = oRow.insertCell();
		oCell5.id = "rCell5";
		var oCell6 = oRow.insertCell();
		oCell6.id = "rCell6";
		var oCell7 = oRow.insertCell();
		oCell7.id = "rCell7";
		var oCell8 = oRow.insertCell();
		oCell8.id = "rCell8";
		var oCell9 = oRow.insertCell();
		oCell9.id = "rCell9";

		oCell1.innerHTML=  "<a style='font-size: 10px;'><small>" + (i+1) +"</small></a>";
		oCell2.innerHTML=  "<a style='font-size: 10px;'><small>" + r_data[i].matnr +"</small></a>";
		oCell3.innerHTML=  "<a style='font-size: 10px;'><small>" + r_data[i].txz01 + "<br>" + r_data[i].wrkst + "</small></a>";
		oCell4.innerHTML=  "<a style='font-size: 10px;'><small>" + r_data[i].werks +"</small></a>";
		oCell5.innerHTML=  "<a style='font-size: 10px;'><small>" + r_data[i].lgort +"</small></a>";		
		oCell6.innerHTML=  "<a style='font-size: 10px; text-align: right;'><small>" + addCommas(Number(r_data[i].zdeli_menge).toFixed(0)) +"</small></a>";
		oCell7.innerHTML=  "<a style='font-size: 10px;'><small>" + r_data[i].meins +"</small></a>";		
		oCell8.innerHTML=  "<a style='font-size: 10px; text-align: right;'><small>" + addCommas(Number(r_data[i].netpr).toFixed(0)) +"</small></a>";	
// 		oCell9.innerHTML=  "<a style='font-size: 10px; text-align: right;'><small>" + addCommas(Number(r_data[i].supply).toFixed(0))  +"</small></a>";
		oCell9.innerHTML=  "<a style='font-size: 10px; text-align: right;'><small>" + addCommas(Number(r_data[i].supply).toFixed(2))  +"</small></a>";
			
		cnt = Number(cnt) + Number(r_data[i].zdeli_menge);
		netpr_total = Number(netpr_total) + Number(r_data[i].netpr);
		supply_total = Number(supply_total) + Number(r_data[i].supply);
	}

	cnt = cnt.toFixed(0);
	netpr_total = netpr_total.toFixed(0);
	supply_total = supply_total.toFixed(2);
	// 합계란 라인 : start
	var oRow = my_tbody.insertRow();
	
	var oCell1 = oRow.insertCell();
	oCell1.id = "mCell1";
	var oCell6 = oRow.insertCell();
	oCell6.id = "mCell6";
	var oCell7 = oRow.insertCell();
	oCell7.id = "mCell7";
	var oCell8 = oRow.insertCell();
	oCell8.id = "mCell8";
	var oCell9 = oRow.insertCell();
	oCell9.id = "mCell9";
	
	oCell1.innerHTML=  "<a style='font-size: 10px;'>" + "합 계" +"</a>";
	oCell6.innerHTML=  "<a style='font-size: 10px; text-align: right;'>" + addCommas(cnt); +"</a>";                     
	oCell7.innerHTML=  "<a style='font-size: 10px; text-align: right;'></a>";
	oCell8.innerHTML=  "<a style='font-size: 10px; text-align: right;'>" + addCommas(netpr_total); +"</a>";                   
	oCell9.innerHTML=  "<a style='font-size: 10px; text-align: right;'>" + addCommas(supply_total); +"</a>";                                  
		
	oCell1.colSpan=5;	
	// 합계란 라인 : end
	
	//사인란 라인 : start
	var my_tbody_1 = document.getElementById('my0-tbody_2');
	var eRow = my_tbody_1.insertRow();
	var eCell1 = eRow.insertCell();
	eCell1.id = "eCell1";
	var eCell2 = eRow.insertCell();
	eCell2.id = "eCell2";
	var eCell3 = eRow.insertCell();
	eCell3.id = "eCell3";
	var eCell4 = eRow.insertCell();
	eCell4.id = "eCell4";

	eCell1.innerHTML=  "<a style='font-size: 5px;'>" + "작 &nbsp; &nbsp;성 &nbsp; &nbsp;자" +"</a>";
	eCell2.innerHTML=  "<a style='font-size: 5px; text-align: right;'>" + "(인)" +"</a>";                     
	eCell3.innerHTML=  "<a style='font-size: 5px; text-align: right;'>" + "인 &nbsp; &nbsp;수 &nbsp; &nbsp;자" +"</a>";
	eCell4.innerHTML=  "<a style='font-size: 5px; text-align: right;'>" + "(인)" +"</a>";                   
	//사인란 라인 : end

	$("#barcode").barcode(
		r_data[0].ebeln, // Value barcode (dependent on the type of barcode)
		"code128" // type (string)
	);
	
 	
 	$('#row_3').html(r_data[0].ebeln);
 	
 	if($(':radio[name="rdo_req_type"]:checked').val() == 'Y') {
 		$('#row_1').html($('#r_conf_date').val());
 	} else {
 		$('#row_1').html("");
 	}
 	if(selectLabnr == null) {
 		$('#row_2').html('');
 	} else {	
 		$('#row_2').html(r_data[0].labnr);	
 	}
 	$('#row_4').html(r_data[0].waers);
 	$('#row_5').html(addCommas(r_data[0].wkurs));
	
	$("#transDoc").printMe(
		{	"path": ["/res/bootstrap/css/printme.css"]}
	);	
	
	document.getElementById("my0-tbody_1").deleteRow(r_data.length+1);		//합계란 라인 삭제
// 	console.log(r_data);
	for(var i=0 ; i<r_data.length+1; i++) {
		if(i == r_data.length) {
			break;
		}
		document.getElementById("my0-tbody_1").deleteRow(1);	
	}	
	document.getElementById("my0-tbody_2").deleteRow(0);	
}


function test() {
	//////////////////////////////////////////////////////////////////////////////
	var rvendor_status = $("#s_status").val();
	var selectEbeln = $("#trs_ebeln").val();
	var selectLabnr = $("#trs_labnr").val();
	console.log("selectEbeln :: " + selectEbeln);
	console.log("selectLabnr :: " + selectLabnr);

	var labnr = '';
	if( selectLabnr!=null )
		labnr = selectLabnr.substring(0,15); 
	
	var page_url = "/frontend/scm/trans_receipt_select";
	var post_data = "";
	if( selectLabnr!=null )
		post_data += "labnr="+encodeURIComponent(labnr);
	else
		post_data += "ebeln="+encodeURIComponent(selectEbeln);
	
	if(rvendor_status == 'v2' || rvendor_status == 'v4') {
		if(selectEbeln.length == 0) {
			fnMessageModalAlert("Notification(SCM)", "문서번호를 선택해주세요." );
			return;
		} else if(selectLabnr == null || selectLabnr.length == 0) {
			fnMessageModalAlert("Notification(SCM)", "납품일정번호가 존재하지 않아 거래명세서를 발행할 수 없습니다." );
			return;
		} 
	}
	
	if(rvendor_status == 'v1') {
		if(selectEbeln.length ==0) {
			fnMessageModalAlert("Notification(SCM)", "문서번호를 선택해주세요." );
			return;
		}
	}
	var r_data;
	$.ajax({
	  url:page_url,
	  data:post_data,
	  type:'POST',
	  async:false,
	  dataType: 'json',
	  success: function( data ) {
	  	if(data.status == 200) {
	  		if(rvendor_status == 'v1') {
		  		var tmp_data = [];
		  		var selectArr = w2ui.grid_doc_list.get(w2ui.grid_doc_list.getSelection());
				for(var i=0 ; i<data.rows.length ;  i++) {
					for(var k=0 ; k<selectArr.length ;  k++) {
						if(selectArr[k].ebeln == data.rows[i].ebeln) {
							if( (selectArr[k].ebelp == data.rows[i].ebelp) &&  (selectArr[k].partial_seq == data.rows[i].partial_seq)) {
								tmp_data.push(data.rows[i]);	
							}
						}
			  		}
				}
				r_data = tmp_data;
	  		} else if(rvendor_status == 'v2' || rvendor_status == 'v4') {
	  			r_data = data.rows;
	  		}
	  	}
	  },
	  complete: function () {}
	});		
	if(r_data.length == 0) {
		fnMessageModalAlert("Notification(SCM)", "출력대상 데이터가 없습니다." );
		return;
	}
	//////////////////////////////////////////////////////////////////////////////
	var aa = document.getElementById("doctest");
	
	var i = 0;
	
	var text = "<p style='text-align: center;'><span style='font-size: 20px;'><strong>거 &nbsp; &nbsp;래 &nbsp; &nbsp;명 &nbsp; &nbsp;세 &nbsp; &nbsp;표</strong></span></p>"
	+"<table style='width: 100%;border: 0px;' >"
	+"<tbody style='border: 0px;'>"
	+"<tr style='border: 0px;'>"
	+"<td style='width: 39%;border: 0px;'>"
	+"<div>"
	+"<br><span style='font-size: 8px;'><strong>납품일자 :&nbsp;</strong><a class='zrow_0' style='font-size: 8px;'></a></span>"
	+"<br><span style='font-size: 8px;'><strong>납품번호 :&nbsp;</strong><a class='zrow_1' style='font-size: 8px;'></a></span>"
	+"<br><span style='font-size: 8px;'><strong>발주번호 :&nbsp;</strong><a class='zrow_2' style='font-size: 8px;'></a></span>"
	+"<br>"
	+"</div>"
	+"</td>"
	+"<td style='width: 41%; text-align: left;border: 0px;'>"
	+"<div id='barcodea'></div>"
	+"</td>"
	+"<td style='width: 20%;border: 0px;'>"
	+"<p style='text-align: right;font-size: 8px;'><strong>VAT 별도</strong></p>"
	+"<table style='width: 100%;'>"
	+"<tbody>"
	+"<tr>"
	+"<td style='text-align: center;font-size: 8px;'>통화</td>"
	+"<td style='text-align: center;font-size: 8px;'>환율</td>"
	+"</tr>"
	+"<tr>"	
	+"<td style='text-align: center;font-size: 8px;'><a class='row_4a' style='font-size: 8px;'></a></td>"
	+"<td style='text-align: center;font-size: 8px;'><a class='row_5a' style='font-size: 8px;'></a></td>"
	+"</tr>"
	+"</tbody>"
	+"</table>"
	+"</td>"
	+"</tr>"
	+"</tbody>"
	+"</table>"
	
	
	+"<table style='width: 100%;'>"
	+"<tbody>"
	+"<tr>"
	+"<td rowspan='3' style='width: 5%; text-align: center;'><span style='font-size: 8px;'><strong>공급받는자</strong></span>"
	+"</td>"
	+"<td style='height:25px; width: 10%; text-align: center;'><span style='font-size: 8px;'><strong>등록번호</strong></span></td>"
	+"<td colspan='3' style='width: 35%; text-align: center;'>"
	+"<a id='row_0_2' style='font-size: 8px;'></a>"
	+"</td>"
	+"<td rowspan='3' style='width: 5%; text-align: center;'><span style='font-size: 8px;'><strong>공<br/>급<br/>자</strong></span>"
	+"</td>"
	+"<td style='width: 10%; text-align: center;'><span style='font-size: 8px;'><strong>등록번호</strong></span>"
	+"</td>"
	+"<td colspan='3' style='width: 35%; text-align: center;'>"
	+"<a id='row_0_7' style='font-size: 8px;'></a>"
	+"</td>"
	+"</tr>"
	+"<tr>"
	+"<td style='height:25px; width: 10%; text-align: center;'><span style='font-size: 8px;'><strong>상호</strong></span></td>"
	+"<td style='width: 15%; text-align: center;'>"
	+"<a id='row_1_2' style='font-size: 8px;'></a>"
	+"</td>"
	+"<td style='width: 10%; text-align: center;'><span style='font-size: 8px;'><strong>대표자성명</strong></span>"
	+"</td>"
	+"<td style='width: 10%; text-align: center;'>"
	+"<a id='row_1_4' style='font-size: 8px;'></a>"
	+"</td>"
	+"<td style='width: 10%; text-align: center;'><strong><span style='font-size: 8px;'>상호</span></strong></td>"
	+"<td style='width: 15%; text-align: center;'>"
	+"<a id='row_1_7' style='font-size: 8px;'></a>"
	+"</td>"
	+"<td style='width: 10%; text-align: center;'><span style='font-size: 8px;'><strong>대표자성명</strong></span>"
	+"</td>"
	+"<td style='width: 10%; text-align: center;'>"
	+"<a id='row_1_9' style='font-size: 8px;'></a>"
	+"</td>"
	+"</tr>"
	+"<tr>"
	+"<td style='height:25px; width: 10%; text-align: center;'><span style='font-size: 8px;'><strong>주소</strong></span></td>"
	+"<td colspan='3' style='width: 35%; text-align: center;'>"
	+"<a id='row_2_2' style='font-size: 8px;'></a>"
	+"</td>"
	+"<td style='width: 10%; text-align: center;'><span style='font-size: 8px;'><strong>주소</strong></span>"
	+"</td>"
	+"<td colspan='3' style='width: 35%; text-align: center;'>"
	+"<a id='row_2_7' style='font-size: 8px;'></a>"
	+"</td>"
	+"</tr>"
	+"</tbody>"
	+"</table>"
	
	+"<table style='width: 100%;'>"
	+"<tbody id='my0-tbody_1'>"
	+"<tr>"
	+"<td style='height:20px; width: 5%; text-align: center;'><span style='font-size: 8px;'><strong>순번</strong></span>"
	+"</td>"
	+"<td style='width: 15%; text-align: center;'><span style='font-size: 8px;'><strong>품목코드</strong></span>"
	+"</td>"
	+"<td style='width: 32%; text-align: center;'><span style='font-size: 8px;'><strong>품목/규격</strong></span>"
	+"</td>"
	+"<td style='width: 8%; text-align: center;'><span style='font-size: 8px;'><strong>플랜트</strong></span>"
	+"</td>"
	+"<td style='width: 8%; text-align: center;'><span style='font-size: 8px;'><strong>입고창고</strong></span>"
	+"</td>"
	+"<td style='width: 8%; text-align: center;'><span style='font-size: 8px;'><strong>수량</strong></span>"
	+"</td>"
	+"<td style='width: 8%; text-align: center;'><span style='font-size: 8px;'><strong>단위</strong></span>"
	+"</td>"
	+"<td style='width: 8%; text-align: center;'><span style='font-size: 8px;'><strong>단가</strong></span>"
	+"</td>"
	+"<td style='width: 8%; text-align: center;'><span style='font-size: 8px;'><strong>공급가액</strong></span>"
	+"</td>"
	+"</tr>"
	+"</tbody>"
	+"</table>";
	
	aa.innerHTML = text;
		
	//////////////////////////////////////////////////////
	var my_tbody = document.getElementById('my0-tbody_1');
	
	$('#row_0_2').html("120-81-93796");
	$('#row_0_7').html("");
	$('#row_1_2').html("뷰웍스(부가세)");
	$('#row_1_4').html("김후식");
	$('#row_1_7').html(r_data[0].name1);
	$('#row_1_9').html(r_data[0].j_1kfrepre);
	$('#row_2_2').html('경기도 안양시 동안구 관양동 1736-3');
	$('#row_2_7').html(r_data[0].ort01);	
	
	var netpr = 0; 
	var supply_total = 0;
	var netpr_total = 0;
	var cnt = 0;
	
	for(var i=0 ; i<3; i++) {
		var oRow = my_tbody.insertRow();	
		var oCell1 = oRow.insertCell();
		oCell1.id = "rCell1";
		var oCell2 = oRow.insertCell();
		oCell2.id = "rCell2";
		var oCell3 = oRow.insertCell();
		oCell3.id = "rCell3";
		var oCell4 = oRow.insertCell();
		oCell4.id = "rCell4";
		var oCell5 = oRow.insertCell();
		oCell5.id = "rCell5";
		var oCell6 = oRow.insertCell();
		oCell6.id = "rCell6";
		var oCell7 = oRow.insertCell();
		oCell7.id = "rCell7";
		var oCell8 = oRow.insertCell();
		oCell8.id = "rCell8";
		var oCell9 = oRow.insertCell();
		oCell9.id = "rCell9";
		
		oCell1.innerHTML=  "<a style='font-size: 10px;'><small>" + (i+1) +"</small></a>";
		oCell2.innerHTML=  "<a style='font-size: 10px;'><small>" + r_data[i].matnr +"</small></a>";
		oCell3.innerHTML=  "<a style='font-size: 10px;'><small>" + r_data[i].txz01 + "<br>" + r_data[i].wrkst + "</small></a>";
		oCell4.innerHTML=  "<a style='font-size: 10px;'><small>" + r_data[i].werks +"</small></a>";
		oCell5.innerHTML=  "<a style='font-size: 10px;'><small>" + r_data[i].lgort +"</small></a>";		
		oCell6.innerHTML=  "<a style='font-size: 10px; text-align: right;'><small>" + addCommas(Number(r_data[i].zdeli_menge).toFixed(0)) +"</small></a>";
		oCell7.innerHTML=  "<a style='font-size: 10px;'><small>" + r_data[i].meins +"</small></a>";		
		oCell8.innerHTML=  "<a style='font-size: 10px; text-align: right;'><small>" + addCommas(Number(r_data[i].netpr).toFixed(0)) +"</small></a>";	
		oCell9.innerHTML=  "<a style='font-size: 10px; text-align: right;'><small>" + addCommas(Number(r_data[i].supply).toFixed(2))  +"</small></a>";
		
		
		console.log(r_data[i].supply);
		console.log(addCommas(Number(r_data[i].supply).toFixed(2)));
		
		cnt = Number(cnt) + Number(r_data[i].zdeli_menge);
		netpr_total = Number(netpr_total) + Number(r_data[i].netpr);
		supply_total = Number(supply_total) + Number(r_data[i].supply);
	}
	
	//////////////////////////////////////////////////////
 	$('.zrow_0').html("test!!!!!");	
 	$('.zrow_1').html("1234567");
 	$('.zrow_2').html("@@@@@");
 	
 	i = i+3;
 	
 	$('#zrow_3').html("test!!!!!");	
 	$('#zrow_4').html("1234567");
 	$('#zrow_5').html("@@@@@");
 	
 	
 	$('.row_4a').html("1234567");
 	$('.row_5a').html("@@@@@");
 	
	$("#doctest").printMe(
		{	"path": ["/res/bootstrap/css/printme.css"] }
	);	
}

function getTodayDate(){
	 var _date  = new Date();
	 var _year  = _date.getFullYear(); // YYYY 4자리
	 var _month = "" + (_date.getMonth() + 1);
	 var _day   = "" + _date.getDate();

	 if( _month.length == 1 ) _month = "0" + _month;
	 if( ( _day.length ) == 1 ) _day = "0" + _day;

	 var tmp = "" + _year + "-" + _month +"-" + _day;
	 return tmp;
}
	
function initOptions(obj) {
    $(obj)
        .find('option')
        .remove()
        .end()
        .val();
}



var y_cSty = 'text-align:center;background-color:rgba(246, 255, 82, 0.4);';	// yellow

function partialSelcProc() {
	
	w2ui.grid_partial_selc.clear();

	var selcObj = w2ui.gridProc.get(w2ui.gridProc.getSelection());
		
	if(selcObj.length == 0) {
		fnMessageModalAlert("Warning", "분할항 항목을 선택해주세요.");
		return;		
	}
	
	var tmpArr = [];
	
	for(var i=0 ; i<selcObj.length; i++) {
		tmpArr.push(clone(selcObj[i]));
	}
	 
	w2ui.grid_partial_selc.records = tmpArr;
	
	setTimeout(function(){
		w2ui.grid_partial_selc.resize();
		w2ui.grid_partial_selc.refresh();
		w2ui.grid_partial_selc.reload();
	}, 200);
	
	$('#modal_partial_selc').modal('show');
}

function partialProc() {
	$('#modal_partial_selc').modal('hide');
	w2ui.grid_partial.clear();
	var partialProcData = {};

	if(w2ui.grid_partial_selc.getSelection().length != 1) {
		fnMessageModalAlert("Warning", "분할항 항목을 1개만 선택해주세요.");
		return;		
	}
	
	if(patialChk() == false) {
		return;
	}
	
	var selcObj = w2ui.grid_partial_selc.get(w2ui.grid_partial_selc.getSelection());
	partialProcData = clone(selcObj[0]); 
	partialProcData.org_data_chk = 'Y';
	w2ui.grid_partial.records.push(partialProcData);
	
	$('#p_ebeln').text(selcObj[0].ebeln);
	$('#p_ebelp').text(selcObj[0].ebelp);
	$('#p_partial_seq').text(selcObj[0].partial_seq);
	$('#p_rvendor_status_nm').text(selcObj[0].rvendor_status_nm);
	$('#p_matnr').text(selcObj[0].matnr);
	$('#p_txz01').text(selcObj[0].txz01);
	$('#p_menge').text(selcObj[0].menge);
	$('#p_eindt').text(selcObj[0].eindt);
	
	setTimeout(function(){
		w2ui.grid_partial.resize();
		w2ui.grid_partial.refresh();
		w2ui.grid_partial.reload();
	}, 200);
	
	$('#modal_partial').modal('show');
}

function fnLoadPartialSelcGrid() {
	
	$("#grid_partial_selc").w2grid({ 
        name: "grid_partial_selc",
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
			{ field : 'ebeln', caption:'문서번호 ', size: '100px' }, 
			{ field : 'ebelp', caption:'문서품목', size: '65px' , style:'text-align:center'},
			{ field : 'partial_seq', caption:'분기순번', size: '65px' , style:'text-align:center'},
            { field : 'rvendor_status_nm', caption:'진행상태', size: '70px' , style:'text-align:center', hidden:true}, 
			{ field : 'matnr', caption:'품목', size: '150px'}, 
			{ field : 'txz01', caption:'내역', size: '150px', hidden:true}, 
			{ field : 'menge', caption:'납품수량', size: '65px', render:'int'}, 
			{ field : 'eindt', caption:'납품일자', size: '100px', style:'text-align:center'},
			{ field : 'zdeli_menge', caption:'요청수량', size: '65px', render:'int', editable: { type: 'text', inTag:'maxlength=10' }, style:y_cSty, hidden:true},
			{ field : 'vendor_delivery_date', caption:'요청일자', size: '100px', style:'text-align:center', editable: { type: 'date', format: 'yyyy-mm-dd'}, style:y_cSty, hidden:true},  
			{ field : 'rvendor_status', caption:'rvendor_status', size: '30%', hidden:true}, 
			{ field : 'rorder_status', caption:'rorder_status', size: '30%', hidden:true}, 
			{ field : 'diff_date', caption:'diff_date', size: '30%', hidden:true},
			{ field : 'werks', caption:'werks', size: '30%', hidden:true},
			{ field : 'bukrs', caption:'bukrs', size: '30%', hidden:true},
			{ field : 'lgort', caption:'lgort', size: '30%', hidden:true},
			{ field : 'ukey', caption:'ukey', size: '30%', hidden:true},
			{ field : 'partial_seq',caption:'partial_seq', size: '30%', hidden:true},
			{ field : 'zdue_menge',caption:'zdeli_menge', size: '30%', hidden:true},
			{ field : 'sernp',caption:'시리얼 대상', size: '75px', style:'text-align:center', hidden:true},
			{ field : 'confirm_yn', caption:'일정확인', size: '65px', style:'text-align:center', hidden:true},
			{ field : 'aedat', caption:'생성일자', size: '100px', style:'text-align:center', hidden:true}, 
			{ field : 'partial_yn', caption:'분기 미승인', size: '95px', style:'text-align:center', hidden:true},
			{ field : 'item_seq',caption:'item_seq', hidden:true},
			{ field : 'lifnr',caption:'lifnr', hidden:true},
			{ field : 'pstyp',caption:'pstyp', hidden:true},
			{ field : 'key_cnt', caption:'key_cnt', hidden:true},
			{ field : 'labnr',caption:'labnr', hidden:true},
			{ field : 'org_data_chk',caption:'org_data_chk', hidden:true}
        ],
      	sortData: [{field: 'recid', direction: 'ASC'}],
      	recordHeight : 30,
      	records : [],
      	total : 0,
		onReload: function(event) {
		},
		onClick: function (event) {
			event.onComplete = function () {
		    }
		}
	});
}

function fnLoadPartialGrid() {
	console.log('fnLoadPartialGrid()');
	
	$("#grid_partial").w2grid({ 
        name: "grid_partial",
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
			{ field : 'ebeln', caption:'문서번호 ', size: '100px' }, 
			{ field : 'ebelp', caption:'문서품목', size: '65px' , style:'text-align:center'},
			{ field : 'partial_seq', caption:'분기순번', size: '65px' , style:'text-align:center'},
            { field : 'rvendor_status_nm', caption:'진행상태', size: '70px' , style:'text-align:center'}, 
			{ field : 'matnr', caption:'품목', size: '150px'}, 
			{ field : 'txz01', caption:'내역', size: '150px'}, 
			{ field : 'menge', caption:'납품수량', size: '65px', render:'int'}, 
			{ field : 'eindt', caption:'납품일자', size: '100px', style:'text-align:center'},
			{ field : 'zdeli_menge', caption:'요청수량', size: '65px', render:'int', editable: { type: 'text', inTag:'maxlength=10' }, style:y_cSty},
			{ field : 'vendor_delivery_date', caption:'요청일자', size: '100px', style:'text-align:center', editable: { type: 'date', format: 'yyyy-mm-dd'}, style:y_cSty},  
			{ field : 'rvendor_status', caption:'rvendor_status', size: '30%', hidden:true}, 
			{ field : 'rorder_status', caption:'rorder_status', size: '30%', hidden:true}, 
			{ field : 'diff_date', caption:'diff_date', size: '30%', hidden:true},
			{ field : 'werks', caption:'werks', size: '30%', hidden:true},
			{ field : 'bukrs', caption:'bukrs', size: '30%', hidden:true},
			{ field : 'lgort', caption:'lgort', size: '30%', hidden:true},
			{ field : 'ukey', caption:'ukey', size: '30%', hidden:true},
			{ field : 'partial_seq',caption:'partial_seq', size: '30%', hidden:true},
			{ field : 'zdue_menge',caption:'zdeli_menge', size: '30%', hidden:true},
			{ field : 'sernp',caption:'시리얼 대상', size: '75px', style:'text-align:center'},
			{ field : 'confirm_yn', caption:'일정확인', size: '65px', style:'text-align:center'},
			{ field : 'aedat', caption:'생성일자', size: '100px', style:'text-align:center'}, 
			{ field : 'partial_yn', caption:'분기 미승인', size: '95px', style:'text-align:center'},
			{ field : 'item_seq',caption:'item_seq', hidden:true},
			{ field : 'lifnr',caption:'lifnr', hidden:true},
			{ field : 'pstyp',caption:'pstyp', hidden:true},
			{ field : 'key_cnt', caption:'key_cnt', hidden:true},
			{ field : 'labnr',caption:'labnr', hidden:true},
			{ field : 'org_data_chk',caption:'org_data_chk', hidden:true}
        ],
      	sortData: [{field: 'recid', direction: 'ASC'}],
      	recordHeight : 30,
      	records : [],
      	total : 0,
		onReload: function(event) {
		},
		onClick: function (event) {
			event.onComplete = function () {
		    }
		}
	});
}


function partialRowAdd() {
	var obj = w2ui.grid_partial_selc.get(w2ui.grid_partial_selc.getSelection());
	var cloneObj = clone(obj[0]);
	cloneObj.org_data_chk = 'N';
	console.log(cloneObj);
	w2ui.grid_partial.add(cloneObj);
	$.each(w2ui.grid_partial.records, function(idx, row){
		row.recid = idx+1;
	});
	
	w2ui.grid_partial.refresh();
	w2ui.grid_partial.reload();
}

function partialRowDel() {
	var selection = w2ui.grid_partial.getSelection();
	var selcObj = w2ui.grid_partial.get(selection);
	var org_data_chk_cnt = 0;
	for(var i=0 ;i<selcObj.length; i++) {
		if(selcObj[i].org_data_chk == 'Y') {
			org_data_chk_cnt++;
		}
	}
	
	if(org_data_chk_cnt>0) {
		fnMessageModalAlert("Notification", "분할 대상 데이터는 삭제할 수 없습니다.");
		return;
	}
	
	$.each(selection, function(idx, sel){
		w2ui.grid_partial.select(sel);
	});
	w2ui.grid_partial.delete(true);
}

function partialSave() {
	var rowData = w2ui.grid_partial.records;
	
	if(rowData.length < 2) {
		fnMessageModalAlert("Notification", "분할할 대상이 없습니다.");
		return;
	}
	
	var menge = Number(w2ui.grid_partial.records[0].menge);
	var zdeli_menge_sum = 0;
	var numChk = 0;
	var changeData = w2ui['grid_partial'].getChanges();
	
	for(var i=0 ;i<changeData.length; i++) {
		if(changeData[i].zdeli_menge != undefined) {
			w2ui.grid_partial.get(changeData[i].recid).zdeli_menge = changeData[i].zdeli_menge;	
		}
		if(changeData[i].vendor_delivery_date != undefined) {
			w2ui.grid_partial.get(changeData[i].recid).vendor_delivery_date = changeData[i].vendor_delivery_date;	
		}
	}
	
	for(var i=0 ;i<rowData.length ;i++) {
		
		if(!(/^[0-9]*$/).test(rowData[i].zdeli_menge)) {
			numChk++;
		}
		
		zdeli_menge_sum += Number(rowData[i].zdeli_menge);
	}
	
	if(numChk > 0) {
		fnMessageModalAlert("Notification", "요청수량은 양수만 입력가능합니다.");
		return;
	}
	if(zdeli_menge_sum != menge) {
		fnMessageModalAlert("Warning", "납품수량과 요청수량의 합이 다릅니다.");
		return;
	}

	var page_url = "/frontend/scm/partialSave";
	var params = "gridData="+encodeURIComponent(JSON.stringify(rowData));
	
	$.ajax({
		url : page_url,
		data : params,
		type : 'POST',
		async : false,
		dataType : 'json',
		success: function( data ) {
			if(data.status == 200) {
				fnMessageModalAlert("Notification", "분할이 완료되었습니다.");
			} else {
				fnMessageModalAlert("Notification", "분할이 실패했습니다.");
			}
		},
		complete: function () {
			reloadGridProc();
			$("#modal_partial").modal('hide');
		}
	});
}

function clone(obj) {
  if (obj === null || typeof(obj) !== 'object')
  return obj;

  var copy = obj.constructor();

  for (var attr in obj) {
    if (obj.hasOwnProperty(attr)) {
      copy[attr] = clone(obj[attr]);
    }
  }

  return copy;
}

function PartialCheckOrder() {
// 	console.log('checkOrder()');
	var selectKeyArr = w2ui.gridProc.getSelection();
	if( selectKeyArr.length==0 ){
		fnMessageModalAlert("Warning...", "일정확인 대상이 선택되지 않았습니다.");
		return;		
	}
	
	var paramObjArr = [];
	var uKeyArr = [];
	$.each(selectKeyArr, function(idx, key){
		var rowData = w2ui.gridProc.get(key)
		var paramObj = {};
		paramObj.ebeln = rowData.ebeln;
		paramObj.ebelp = rowData.ebelp;
		paramObj.partial_seq = rowData.partial_seq;
		paramObj.partial_yn = 'Y';
		if( rowData.w2ui==undefined ) {
			if( rowData.vendor_delivery_date==''||rowData.vendor_delivery_date==null) {
				paramObj.vendor_delivery_date = rowData.eindt;
			} else {
				paramObj.vendor_delivery_date = rowData.vendor_delivery_date;
			}
		} else {
			var chn = rowData.w2ui.changes;
			if( chn.vendor_delivery_date!=undefined ) {
				paramObj.vendor_delivery_date = chn.vendor_delivery_date;
			} else {
				paramObj.vendor_delivery_date = rowData.vendor_delivery_date;
			}
		}
		paramObj.zdeli_menge = rowData.zdeli_menge;
		paramObj.order_delivery_date = paramObj.vendor_delivery_date;
		paramObj.confirm_yn = 'Y';
		
		paramObj.diff_date = 'N';
		if( paramObj.vendor_delivery_date!=rowData.eindt )
			paramObj.diff_date = 'Y';
	
		paramObj.key_cnt = rowData.key_cnt;
		uKeyArr.push(rowData.ebeln);
		paramObjArr.push(paramObj);
	});
	
	var page_url = "/frontend/scm/rawProcConfirmYn_update";
	var params = "params=" + encodeURIComponent(JSON.stringify(paramObjArr))
			   + "&uKeyArr=" + encodeURIComponent(JSON.stringify(uKeyArr));
	$.ajax({
		url:page_url,
		data:params,
		type:'POST',
		dataType: 'json',
		success: function( data ) {
			if(data.status == 200) {
				fnMessageModalAlert("Success...", "일정변경확인이 정상적으로 처리되었습니다.");
				reloadGridProc();
			} else {
				fnMessageModalAlert("Warning...", "일정변경확인 중 오류가 발생하였습니다.");
			}
		},complete: function () {}
	});
}

function patialChk() {
	var selRowData = w2ui.gridProc.get(w2ui.gridProc.getSelection())[0];
	var result = true;
	var chk =0 ;
	var page_url = "/frontend/scm/rawProc_selectByKey";
	var postData = "ebeln=" + encodeURIComponent(selRowData.ebeln)
				 + "&ebelp=" + encodeURIComponent(selRowData.ebelp);
				 
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				var rowData = data.rows;
				
				if(rowData.length > 1) {
					fnMessageModalAlert("Notification(StatusChk)", "분할처리 진행 중인 오더입니다.");
					result = false;
				}
				
				for(var i=0 ; i<rowData.length; i++) {
					if(rowData[i].rorder_status== 'r4' || rowData[i].rvendor_status=='v4' ) {
						chk++;	
						result = false;
					} 
				}
					
				if(result == false) {
					if(chk > 0) {
						result = false;
						fnMessageModalAlert("Notification(StatusChk)", "해당오더의 현재 Status에서는 분할이 불가능합니다");
					}	
				}	
				
			} else {
				result = false;	
				fnMessageModalAlert("Notification(StatusChk)", "요청처리를 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			result = false;	
			fnMessageModalAlert("Notification(StatusChk)", "요청처리를 실패했습니다.");
		},
		complete : function() { }			
	});
	return result;
}
</script>
</body>
</html>