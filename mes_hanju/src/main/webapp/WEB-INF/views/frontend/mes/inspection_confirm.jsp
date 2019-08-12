<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
String member_id = SessionUtil.getMemberId(request);
String s_member_nm = SessionUtil.getMemberNm(request);
String s_member_emp_no = SessionUtil.getMemberEmpNo(request);
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
		<jsp:param name="selected_menu_cd" value="1112" />
	</jsp:include>

	<div class="content-wrapper">
		<section class="content-header">
			<h1>
				MES <small>자주검사 확정관리</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> MES</a></li>
				<li class="active">자주검사 확정관리</li>
			</ol>
		</section>
		<section class="content" style="padding-bottom: 0px;">
			<div class="row">
     		<div class="col-md-12">
     			<div class="box" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">공정 목록</h3>
						<div class="box-tools pull-right">
<!-- 							<div class="form-group"> -->
								<button type="button" id="btn_search_csr"  class="btn btn-primary btn-sm">조회</button>   
<!-- 								<button type="button" id="" onclick="editGroupPopup();" class="btn btn-primary btn-sm">수정/삭제</button>    -->
<!-- 								<button type="button" id="" onclick="openModalIntGroup()" class="btn btn-primary btn-sm">추가</button>    -->
<!-- 							</div> -->
						</div>
					</div>
					<div class="box-body" style="padding-bottom: 0px;">
						<div class="row">
							<div class="col-sm-4">
								<div class="form-group">
									<label>| 작업시작일</label>
									<div class="input-group">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input type="text" class="form-control pull-right input-sm" id="work_date_range">
									</div>
								</div>
							</div>
							<div class="col-sm-4" style="padding-left: 0px;">
								<div class="form-group">
									<label>| 지시번호</label> 
									<input type="input" id="s_pordno" name="s_pordno" class="form-control input-sm" placeholder="ex) 10010010010" maxlength="30">
								</div>
							</div>
							<div class="col-sm-4" style="padding-left: 0px;">
								<div class="form-group">
									<label>| 분야</label> 
									<select id="s_dept_cd" name="s_dept_cd" class="form-control select2 input-sm">
										<option value="">전체</option>
										<option value="1110">의료</option>
										<option value="1210">광영상</option>
									</select>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-4">
								<div class="form-group">
									<label>| 자재코드</label> <input type="input" id="s_itnbr" name="s_itnbr" class="form-control input-sm" placeholder="ex) 1800-100A" maxlength="50">
								</div>
							</div>
							<div class="col-sm-4" style="padding-left: 0px;">
								<div class="form-group">
									<label>| 자재내역</label> 
									<input type="input" id="s_pordno_status" name="s_pordno_status" class="form-control input-sm" placeholder="ex) REL  PCNF DLV  PRC  GMCO MANC SETC" maxlength="50">
								</div>
							</div>
							<div class="col-sm-4" style="padding-left: 0px;">
								<div class="form-group">
									<label>| 시리얼번호</label>
                        	    	<input type="input"  id="s_project_no" name="s_project_no" class="form-control input-sm"  maxlength="100" onkeypress="if(event.keyCode==13) {LMainsernr_enter(this); return false;}">
								</div>
							</div>
						</div>
					</div><!-- end boxbody search condition -->
					<div class="box-body" style="padding-top: 0px;">
						<div class="text-right" style="padding-bottom: 10px;">
							<button type="button" id="" onclick="fnSelfInsp();" class="btn btn-success btn-sm">이력카드</button>
							<button type="button" id="" onclick="fnShowOperateHisModal();" class="btn btn-primary btn-sm">공정관리</button>
							<button type="button" id="" onclick="fnUsingMatnrList();" class="btn btn-warning btn-sm">자재사용현황</button>
							<button type="button" id="" onclick="fnFaultyMatnrList();" class="btn btn-danger btn-sm">불량자재현황</button>
							<button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_sapord');" data-selfilepath="/upload" data-selfilename="test.xlsx">
							 	<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
							</button>
						</div>
						<div id="grid_sapord" style="width: 100%; height: 590px;"></div>
					</div><!-- end boxbody grid -->
				</div>
     		</div>		
		</section><!-- end section content -->
	</div>
	
	<!-- 자주검사  -->
	<div class="modal fade" id="modal_selfInsp" data-backdrop="static">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="modal_code_title">이력카드 <span id="pono"></span></h4>
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
							<select id="self_insp_routing"
								class="form-control select2 input-sm" style="margin-top: 10px;"	onChange="showSelfInspGrid();"></select>
						</div>
					</div>
					<div class="row" id="selfinsp_1110" style="height: 400px; overflow-y: auto; overflow-x: hidden; display: none;"">
						<div class="col-md-12">
							<div class="row">
								<!-- darkimage검사 -->
								<div class="col-md-12" id="grid_v12_area" style="margin-top: 10px; display: none;">
									<div id="grid_v12" style="width: 100%; height: 400px;"></div>
								</div>
							</div>
							<div class="row">
								<!-- calibration -->
								<div class="col-md-12" id="grid_v13_area" style="margin-top: 10px; display: none;">
									<div id="grid_v13" style="width: 100%; height: 400px;"></div>
								</div>
							</div>
							<div class="row">
								<!-- osf -->
								<div class="col-md-12" id="grid_v14_area" style="margin-top: 10px; display: none;">
									<div id="grid_v14" style="width: 100%; height: 200px;"></div>
								</div>
							</div>
							<div class="row">
								<!-- 최종 검사 -->
								<div class="col-md-12" id="grid_v17_area" style="margin-top: 10px; display: none;">
									<div id="grid_v17" style="width: 100%; height: 200px;"></div>
								</div>
							</div>
							<div class="row">
								<!-- 1차조립 -->
								<div class="col-md-12" id="grid_r10_area" style="margin-top: 10px; display: none;">
									<div id="grid_r10" style="width: 100%; height: 200px;"></div>
								</div>
							</div>
							<div class="row">
								<!-- 공정 검사 -->
								<div class="col-md-12" id="grid_r11_area" style="margin-top: 10px; display: none;">
									<div id="grid_r11" style="width: 100%; height: 200px;"></div>
								</div>
							</div>
							<div class="row">
								<!-- 최종 조립 -->
								<div class="col-md-12" id="grid_r12_area" style="margin-top: 10px; display: none;">
									<div id="grid_r12" style="width: 100%; height: 200px;"></div>
								</div>
							</div>
							<div class="row">
								<!-- 공정 검사 -->
								<div class="col-md-12" id="grid_r21_area" style="margin-top: 10px; display: none;">
									<div id="grid_r21" style="width: 100%; height: 200px;"></div>
								</div>
							</div>
							<div class="row">
								<!-- on/off test -->
								<div class="col-md-12" id="grid_r22_area" style="margin-top: 10px; display: none;">
									<div id="grid_r22" style="width: 100%; height: 200px;"></div>
								</div>
							</div>
							<div class="row">
								<!-- 최종 조립 -->
								<div class="col-md-12" id="grid_r23_area" style="margin-top: 10px; display: none;">
									<div id="grid_r23" style="width: 100%; height: 200px;"></div>
								</div>
							</div>
							<div class="row">
								<!-- ghost 작업 -->
								<div class="col-md-12" id="grid_r31_area" style="margin-top: 10px; display: none;">
									<div id="grid_r31" style="width: 100%; height: 200px;"></div>
								</div>
							</div>
							<div class="row">
								<!-- Backup -->
								<div class="col-md-12" id="grid_r32_area" style="margin-top: 10px; display: none;">
									<div id="grid_r32" style="width: 100%; height: 200px;"></div>
								</div>
							</div>
							<div class="row">
								<!-- 공정검사 -->
								<div class="col-md-12" id="grid_r52_area" style="margin-top: 10px; display: none;">
									<div id="grid_r52" style="width: 100%; height: 200px;"></div>
								</div>
							</div>
							<div class="row">
								<!-- 품질 최종 검사 -->
								<div class="col-md-12" id="grid_qt_area" style="margin-top: 10px; display: none;">
									<div id="grid_qt" style="width: 100%; height: 200px;"></div>
								</div>
							</div>
							<div class="row">
								<!-- 품질 1차 검사  -->
								<div class="col-md-12" id="grid_qo_area" style="margin-top: 10px; display: none;">
									<div id="grid_qo" style="width: 100%; height: 200px;"></div>
								</div>
							</div>
							<div class="row">
								<!-- 품질 Aging -->
								<div class="col-md-12" id="grid_qa_area" style="margin-top: 10px; display: none;">
									<div id="grid_qa" style="width: 100%; height: 200px;"></div>
								</div>
							</div>
						</div>
					</div><!-- end 1110 -->
					<div class="row" id="selfinsp_1210" style="height:400px;overflow-y: auto;overflow-x: hidden; display: none;">
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
					</div><!-- end 1210 -->
				</div>
		<!-- end modal body -->
				<div class="modal-footer">
					<div class="text-center">
<!-- 							<button type="button" class="btn btn-sm btn-primary" onclick="saveSelfInsp();">저장</button> -->
						<button type="button" class="btn btn-sm btn-primary" onclick="saveSelfInsp();">관리자 확인</button>
						<button type="button" class="btn btn-sm btn-secondary"
							data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div><!-- end modal-content -->
	</div>
	<!-- end modal dialog -->
	
	<!-- history -->
	<div class="modal fade" id="operate_his" data-backdrop="static">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="modal_code_title">공정이력</h4>
				</div>
				<div class="modal-body" id="modal_code_body">
					<div class="row">
						<div class="col-md-12" id="grid_operate_his_area" style="margin-top: 10px;">
							<div id="grid_operate_his" style="width: 100%; height: 500px;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- MATNR LIST -->
	<div class="modal fade" id="matnr_list" data-backdrop="static">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="modal_code_title">자재현황</h4>
				</div>
				<div class="modal-body" id="modal_code_body">
					<div class="row">
						<div class="col-md-12" id="grid_addItnbr_list_area" style="margin-top: 10px;">
							<div id="grid_addItnbr_list" style="width: 100%; height: 500px;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- faulty matnr list -->
	<div class="modal fade" id="faulty_matnr_list" data-backdrop="static">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="modal_code_title">불량자재현황</h4>
				</div>
				<div class="modal-body" id="modal_code_body">
					<div class="row">
						<div class="col-md-12" id="grid_faulty_matnr_area" style="margin-top: 10px;">
							<div id="grid_faulty_matnr" style="width: 100%; height: 500px;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
	
	<jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div><!-- end div wrapper -->

<script type="text/javascript">

// var jocod = "";
// var login_user_dept_cd = "";

// var addItnbrArr = [];
// var itnbrArr = [];
// var matArr = [];
var member_id = '<%=member_id%>';
var s_member_nm = '<%=s_member_nm%>';
var s_member_emp_no = '<%=s_member_emp_no%>';

// var gridReadySelect_idx = '';
var searchMatCode = '';
var selected_pordno = '';
var selfDetail = [];
var dept_cd =  '';
// // var readyKey = '';
// var addMatObj = {};

// var member_nm = '';
// var member_emp_no = '';
// var member_cnt = '';



$(function($) {
	initComponent();
})

function initComponent() {
// 	console.info('initComponent()');

	$(window).bind('resize', function() {
		resizeJqGrid("grid_sapord", false);
	}).trigger('resize');
	
	$('#work_date_range').daterangepicker({
		opens: 'right',
		locale: {
			format : 'YYYY.MM.DD'	,
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
					'7월', '8월', '9월', '10월', '11월', '12월' ],
			daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
			showMonthAfterYear : true,
			yearSuffix : '년'
	    },
 	     startDate: '2018.03.01',
 	     endDate: '2018.03.31'
//  	     startDate: getTodayDate(),
//  	     endDate: getTodayDate()
	});
	
	$("#btn_search_csr").on('click',
		function(e) {
			e.preventDefault();
			 
			if (e.target.id == "btn_search_csr") {
				selected_pordno='';
				fnLoadGridData();
			}
		});
	
	$("#s_dept_cd").change(function() {
		  dept_cd = this.value;
		  if( dept_cd=='1110' ) {
			  $("#selfinsp_1110").show();
			  $("#selfinsp_1210").hide();
		  } else if( dept_cd=='1210' ) {
			  $("#selfinsp_1110").hide();
			  $("#selfinsp_1210").show();
		  } else {
			  $("#selfinsp_1110").hide();
			  $("#selfinsp_1210").hide();
		  }
	});
	
	initScreenSizeModal();
	gridSapOrdGen();
	
	// selfInsp
	initGridSelgInspHeader();
	// 1110
	init_grid_v12();
	init_grid_v13();
	init_grid_v14();
	init_grid_v17();
	init_grid_r10();
	init_grid_r11();
	init_grid_r12();
	init_grid_r21();
	init_grid_r22();
	init_grid_r23();
	init_grid_r31();
	init_grid_r32();
	init_grid_r52();
	init_grid_qt();
	init_grid_qo();
	init_grid_qa();
	// 1210
	init_grid_p1();
	init_grid_p2();
	init_grid_p5();
	init_grid_t1();
	
	fnLoadGridData();
	fnInitOperateHisGrid();
	fnInitNewItnbrGrid();
	fnInitfaultyMatnrGrid();
}

function gridSapOrdGen() {
// 	console.log('gridSapOrdGen()');
	/*
	var date1 = replaceAll($("#csr_register_date_range").val().substring(0, 10),'-','');
	var date2 = replaceAll($("#csr_register_date_range").val().substring(13, 23),'-','');

	var page_url = "/frontend/prod/sap_prod_select";
	page_url += "?jidat_from=" + encodeURIComponent(date1);
	page_url += "&jidat_to=" + encodeURIComponent(date2);
	page_url += "&cmdat=" + encodeURIComponent("cmdat");	//cmdat is not null 실행 조건으로 걸어놓았음...
	page_url += "&dept_cd=" + encodeURIComponent($("#s_dept_cd").val());
	page_url += "&routing_gno_gubun=" + encodeURIComponent($("#s_order").val());
	page_url += "&auart=" + encodeURIComponent($("#auart").val());

	*/
	$("#grid_sapord").w2grid({
		name : 'grid_sapord',
		reorderColumns: true,
		show : {
			lineNumbers : true,
			selectColumn: true,
            footer: true
        },
        columns :[
            { caption:'플랜트', field:'dept_cd', size:'70px', sortable : true, render:function(record, index, col_index){
				if(this.getCellValue(index, col_index)=='1110')	return '의료';
				else if(this.getCellValue(index, col_index)=='1210')	return '광영상';}, style:'text-align:center'},
            { caption:'오더유형', field:'auart_nm', size:'80px', style:'text-align:center'},
			{ caption:'오더상태', field:'pdsts_nm', size:'120px',	sortable : true, style:'text-align:center'}, 
            { caption:'생산오더번호', field:'pordno', size:'120px', sortable : true, key : true, style:'text-align:center'}, 
            { caption:'pordno_child', field:'pordno_child', hidden:true}, 
            { caption:'품목', field:'itnbr', size:'120px',  sortable : true},
            { caption:'품목명', field:'pordno_status', size:'310px', sortable : true}, 
            { caption:'Spec.', field:'spec', size:'310px', sortable : true, hidden:true}, 	// * 
            { caption:'수량', field:'pdqty', size:'30px', sortable : true}, 	// * 
            { caption:'SN', field:'project_no', size:'120px', sortable : true},
            { caption:'작업시작일', field:'jidat', size:'100px', sortable : true, style:'text-align:center'}, 	// *
            { caption:'작업종료일', field:'ed_date', size:'100px', sortable : true}, 	// *
            { caption:'DMR', field:'dmr', size:'100px', sortable : true}, 	// *
            { caption:'RN', field:'rn', size:'100px', sortable : true}, 	// *
            { caption:'이력카드', field:'confirm_id', size:'80px', sortable : true, render:function(record, index, col_index){
				if(this.getCellValue(index, col_index)=='')	return 'X';
				else if(this.getCellValue(index, col_index)!='')	return 'O';}}, 	// *
            { caption:'pdsts', field:'pdsts', size:'200px', sortable : true, hidden:true}, 
//             { caption:'지시일', field:'jidat', size:'200px', sortable : true},
            { caption:'lgort', field:'lgort', size:'200px', sortable : true, hidden:true}, 
            { caption:'routing_gno', field:'routing_gno', size:'200px', sortable : true, hidden:true},
            { caption:'routing_no', field:'routing_no', size:'200px', sortable : true, hidden:true},
            { caption:'fedat', field:'fedat', hidden:true},
            { caption:'sedat', field:'sedat', hidden:true},
            { caption:'auart', field:'auart', hidden:true},
            { caption:'wkctr', field:'wkctr', hidden:true},
            { caption:'pdqty', field:'pdqty', hidden:true},
            { caption:'routing_gno_gubun', field:'routing_gno_gubun', hidden:true},
            { caption:'sernp', field:'sernp', hidden:true}
		],
		sortData: [{field: 'pordno', direction: 'ASC'}],
		records: [],
		recordHeight : 30
	});
}

function fnInitOperateHisGrid() {
// 	console.log('fnInitOperateHisGrid()');
	$("#grid_operate_his").w2grid({
		name : 'grid_operate_his',
		reorderColumns: true,
		show : {
			lineNumbers : true,
            footer: true
        },
        columns :[
//                   { caption:'플랜트', field:'dept_cd', size:'70px', sortable : true, render:function(record, index, col_index){
			{ field:'pordno', caption:'지시번호', size:'100px', sortable:true, hidden:false },
			{ field:'routing_nm', caption:'라우팅이름', size:'100px', sortable:true, hidden:false },
			{ field:'routing_code', caption:'라우팅code', size:'100px', sortable:true, hidden:false },
			{ field:'routing_dscr', caption:'라우팅dscr', size:'100px', sortable:true, hidden:false },
			{ field:'start_dt_tm', caption:'작업시작', size:'100px', sortable:true, hidden:false },
			{ field:'pause_start_dt_tm', caption:'비가동시작', size:'100px', sortable:true, hidden:false },
			{ field:'pause_end_dt_tm', caption:'비가동종료', size:'100px', sortable:true, hidden:false },
			{ field:'end_dt_tm', caption:'작업종료', size:'100px', sortable:true, hidden:false },
			{ field:'pordno_seq', caption:'pordno_seq', size:'100px', sortable:true, hidden:false }
		],
		sortData: [{field: 'pordno_seq', direction: 'ASC'}],
		records: [],
		recordHeight : 30
	});
}

function fnInitNewItnbrGrid() {
//	console.log('fnInitNewItnbrGrid()');
	$("#grid_addItnbr_list").w2grid({
		name : 'grid_addItnbr_list',
		show : {
			lineNumbers : true,
// 			selectColumn: true,
	        footer: true
	    },
		columns : [
			{ field:'matnr', caption:'품목코드', size:'110px', sortable:true},	//key: true
			{ field:'maktx', caption:'품목명', size:'100px', sortable:true},
			{ field:'spec', caption:'spec.', size:'100px', sortable:true},	//*
			{ field:'bdmng', caption:'투입량', size:'50px', sortable:true, editable:function(record, index, col_index){
				if( record.pordno==undefined ) {
					return { type: 'text'};
				} else { return false;}
			}},
			{ field:'SN', caption:'일련번호', size:'110px', sortable:true, editable: function(record, index, col_index){
				if (record.sernp=='V001')	return { type: 'text'};
				else	return false;	}, render:function(record, index, col_index){
				if (record.sernp!='V001') {
					return '시리얼 입력 비대상';
				} else return this.getCellValue(index, col_index);
			} },
			{ field:'meins', caption:'단위', size:'60px', sortable:true, hidden:true},
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
		onChange: function(event) {	
			 var selection = w2ui.grid_addItnbr_list.getSelection();
			 var selectData = w2ui.grid_addItnbr_list.get(selection);
	    	  event.onComplete = function() {
	    
	    		  $.each(selectData, function(idx, row) {
	    			  var change = row.w2ui.changes;
						if( change.fw_gubun!=undefined )
							row.sernr = change.sernr;
	
	    				  if(change.sernr.length > 30 && Left(change.sernr,2) == 01  ){
	    					  console.log(" Right(change.sernr,9)" ,  Right(change.sernr,9));
	    					  change.sernr = Right(change.sernr,9);  
	    				    	}
			      				 
	  			});
	    		 
	    	 };
	    	
		}
	
	});
}

function fnInitfaultyMatnrGrid() {
//	console.log('fnInitfaultyMatnrGrid()');
	$("#grid_faulty_matnr").w2grid({
		name : 'grid_faulty_matnr',
		show : {
			lineNumbers : true,
// 			selectColumn: true,
	        footer: true
	    },
		columns : [
			// 품목코드	품목명	Spec		SN	발생공정	등록자	발생수량	Level1	Level2	Level3	Level4
			{ field:'matnr', caption:'품목코드', size:'120px', sortable:true},	//key: true
			{ field:'maktx', caption:'품목명', size:'150px', sortable:true},
			{ field:'sernr', caption:'SN', size:'100px', sortable:true},
			{ field:'routing_no', caption:'발생공정코드', size:'110px', sortable:true, hidden:true},
			{ field:'routing_nm' , caption:'발생공정명', size:'110px', sortable:true},
			{ field:'creator', caption:'등록자', size:'60px'},
			{ field:'issue_code', caption:'발생사유코드', size:'100px', hidden:true },
			{ field:'issue_code_nm', caption:'발생사유명', size:'150px' },
			{ field:'issue_remark', caption:'코멘트', size:'200px' }
			],
		recordHeight : 30,
		sortData : [{field: 'matnr', direction: 'ASC'}],
		records : [],
		total : 0
	});
}

function fnSelfInsp() {
// 	console.log('fnSelfInsp()');
	
	var selectRow = w2ui.grid_sapord.getSelection();
	if( selectRow.length!=1 ) {
		fnMessageModalAlert("Warning", "목록에서 한건의 데이터를 선택하여야 합니다.");
	} else {
		var row = w2ui.grid_sapord.get(selectRow[0]);
		
		if( row.auart=='ZP01' || row.auart=='ZP05' )
			searchMatCode = 'basic';
		else	// ZP02, ZP03, ZP04
			searchMatCode = 'mat';
		
		if( dept_cd == '' )
			dept_cd = row.dept_cd;
		
		if( dept_cd=='1110' ) {
			$("#selfinsp_1110").show();
			$("#selfinsp_1210").hide();
		} else if( dept_cd=='1210' ) {
			$("#selfinsp_1110").hide();
			$("#selfinsp_1210").show();
		} else {
			$("#selfinsp_1110").hide();
			$("#selfinsp_1210").hide();
		}
		selfInspModal();
	}
}

//생산지시 grid search
function fnLoadGridData() {
// 	console.log('fnLoadGridData()');
	var date1 = replaceAll($("#work_date_range").val().substring(0, 10),'.','');
	var date2 = replaceAll($("#work_date_range").val().substring(13, 23),'.','');

	w2ui.grid_sapord.clear();
	
	var page_url = "/frontend/prod/sap_prod_select_confirm";
	page_url += "?jidat_from=" + encodeURIComponent(date1);
	page_url += "&jidat_to=" + encodeURIComponent(date2);
	page_url += "&cmdat=" + encodeURIComponent("cmdat");	//cmdat is not null 실행 조건으로 걸어놓았음...
	page_url += "&dept_cd=" + encodeURIComponent(dept_cd);
	page_url += "&itnbr=" + encodeURIComponent($("#s_itnbr").val());
	page_url += "&project_no=" + encodeURIComponent($("#s_project_no").val());
	page_url += "&pordno=" + encodeURIComponent($("#s_pordno").val());
	
	 
	var rowArr = [];
	w2ui.grid_sapord.lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		async:false,
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				w2ui.grid_sapord.records = rowArr;
				w2ui.grid_sapord.total = rowArr.length;
			}
			w2ui.grid_sapord.refresh();
			w2ui.grid_sapord.unlock();
			
// 			if(selectItemKey!=undefined && selectItemKey!='') {
// 				w2ui.grid_item.select(Number(selectItemKey));
// 				selectItemKey = '';
// 			}
		},complete: function () {}
	});
	
// 	$("#grid_sapord").jqGrid('setGridParam', { url : page_url, datatype : 'json' });
// 	$("#grid_sapord").trigger("reloadGrid");
// 	if (gridSapordSelect_idx != '') {
// 		setTimeout(function() {
// 			var ids = $("#grid_sapord").jqGrid("getDataIDs");
// 			if (ids && ids.length > 0) {
// 				$("#grid_sapord").jqGrid("setSelection", ids[gridSapordSelect_idx - 1]);
// 			}
// 		}, 100);
// 	}
}

function selfInspModal() {
// 	console.log('selfInspModal()');
	var selKey = w2ui.grid_sapord.getSelection();
	selfDetail = [];
	if ( selKey.length==0 ) {
		fnMessageModalAlert("Warning", "목록에서 한건의 데이터를 선택하여야 합니다.");
		return;
	} else if ( selKey.length>1 ) {
		fnMessageModalAlert("Warning", "목록에서 한건의 데이터만 선택하여야 합니다.");
		return;
	}
	
	var selectData = w2ui.grid_sapord.get(selKey[0]);	// auart : ZP02, ZP04
	if( selectData.itnbr=='' ) {
		fnMessageModalAlert("Warning", "해당 공정은 자재내역이 조회되지 않아 자주검사가 불가능 합니다.");
		return;
	} else {
		var headerCheck = loadSelfInspHeader();
		if( headerCheck ) {
		 	loadSelfInspDetail();
			makeSelectBox();
			$("#pono").text("( 지시번호 : " + selectData.pordno + " )");	// 2018-01-24 : iris add
			$("#modal_selfInsp").modal('show');
		 	showSelfInspGrid();
			setTimeout(function(){
				w2ui.grid_selfInsp_header.resize();
				w2ui.grid_selfInsp_header.refresh();
				$.each(selfDetail, function(idx, opt){
					w2ui['grid_' + opt].resize();
					w2ui['grid_' + opt].refresh();
				});
			}, 200);		
		} else {
			return;
		}
	}
}

function loadSelfInspHeader() {
// 	console.log('loadSelfInspHeader()');
	var selData = w2ui.grid_sapord.get(w2ui.grid_sapord.getSelection()[0]);
	var page_url = "/frontend/mes/select_selfinsp_header"
				+ "?dept_cd=" + encodeURIComponent(dept_cd)
				+ "&pordno=" + encodeURIComponent(selData.pordno)
				+ "&matnr=" + encodeURIComponent(selData.itnbr);
	var returnVal = false;
	var rowArr = [];
	w2ui.grid_selfInsp_header.lock('loading...', true);
	$.ajax({
		url : page_url,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200" ) {
				if( (data.rows).length>0 ) {
					rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
						if( row.siheader_seq=='1' )
							row.item_value = row.simaster_gr_nm;
					});
					w2ui.grid_selfInsp_header.records = rowArr;
					w2ui.grid_selfInsp_header.total = rowArr.length;
					returnVal = true;
				} else {
					fnMessageModalAlert("Warning", "해당 공정(" + selData.pordno + ") 에 해당하는 이력카드 정보가 없습니다.");
				}
			} else if(data.status == "200" && (data.rows).length==0 ) {
				fnMessageModalAlert("Check", "해당 데이터는 자주검사 대상이 아닙니다.");
			}else {
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

//########################### selfInsp grid init start ###########################
//grid_selfInsp_header
function initGridSelgInspHeader() {
//	console.log('initGridSelgInspHeader()');
	$("#grid_selfInsp_header").w2grid({
		name : 'grid_selfInsp_header',
		header : '제품 이력카드',
		show : { header : true },
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

//--------------------------- start 1110 detail ----------------------------------
function init_grid_v12() {
// 	console.log('init_grid_v12()');
	$("#grid_v12").w2grid({
		name : 'grid_v12',
		header : 'DarkImage검사',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
				render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
						return replaceAll(getTodayDate(),'.','-');
					else
						return this.getCellValue(index, col_index);
				}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_v12.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_v12.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_v12.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_v12.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}

function init_grid_v13() {
// 	console.log('init_grid_v13()');
	$("#grid_v13").w2grid({
		name : 'grid_v13',
		header : 'Calibration',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_v13.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_v13.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_v13.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_v13.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}

function init_grid_v14() {
// 	console.log('init_grid_v14()');
	$("#grid_v14").w2grid({
		name : 'grid_v14',
		header : 'OSF',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_v14.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_v14.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_v14.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_v14.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}

function init_grid_v17() {
// 	console.log('init_grid_v17()');
	$("#grid_v17").w2grid({
		name : 'grid_v17',
		header : '최종 검사',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_v17.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_v17.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_v17.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_v17.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}

function init_grid_r10() {
// 	console.log('init_grid_r10()');
	$("#grid_r10").w2grid({
		name : 'grid_r10',
		header : '1차조립',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r10.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r10.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r10.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r10.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}

function init_grid_r11() {
// 	console.log('init_grid_r11()');
	$("#grid_r11").w2grid({
		name : 'grid_r11',
		header : '공정 검사',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r11.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r11.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r11.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r11.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}

function init_grid_r12() {
// 	console.log('init_grid_r12()');
	$("#grid_r12").w2grid({
		name : 'grid_r12',
		header : '최종 조립',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r12.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r12.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r12.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r12.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}

function init_grid_r21() {
// 	console.log('init_grid_r21()');
	$("#grid_r21").w2grid({
		name : 'grid_r21',
		header : '공정 검사',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r21.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r21.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r21.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r21.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}

function init_grid_r22() {
// 	console.log('init_grid_r22()');
	$("#grid_r22").w2grid({
		name : 'grid_r22',
		header : 'ON/OFF Test',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r22.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r22.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r22.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r22.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}

function init_grid_r23() {
// 	console.log('init_grid_r23()');
	$("#grid_r23").w2grid({
		name : 'grid_r23',
		header : '최종 조립',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r23.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r23.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r23.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r23.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}

function init_grid_r31() {
// 	console.log('init_grid_r31()');
	$("#grid_r31").w2grid({
		name : 'grid_r31',
		header : 'Ghost 작업',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r31.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r31.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r31.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r31.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}

function init_grid_r32() {
// 	console.log('init_grid_r32()');
	$("#grid_r32").w2grid({
		name : 'grid_r32',
		header : 'Backup',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r32.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r32.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r32.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r32.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}

function init_grid_r52() {
// 	console.log('init_grid_r52()');
	$("#grid_r52").w2grid({
		name : 'grid_r52',
		header : '공정검사',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r52.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r52.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r52.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r52.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}

function init_grid_qt() {
// 	console.log('init_grid_qt()');
	$("#grid_qt").w2grid({
		name : 'grid_qt',
		header : '품질 최종 검사',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_qt.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_qt.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_qt.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_qt.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}

function init_grid_qo() {
// 	console.log('init_grid_qo()');
	$("#grid_qo").w2grid({
		name : 'grid_qo',
		header : '품질 1차 검사',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_qo.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_qo.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_qo.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_qo.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}

function init_grid_qa() {
// 	console.log('init_grid_qa()');
	$("#grid_qa").w2grid({
		name : 'grid_qa',
		header : '품질 Aging',
		show : { header : true },
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
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},//member_id
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_qa.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_qa.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_qa.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_qa.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }        
	});
}
//--------------------------- end 1110 detail ----------------------------------
//--------------------------- start 1210 detail --------------------------------

function init_grid_p1() {
// 	console.log('init_grid_p1()');
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

function init_grid_p2() {
// 	console.log('init_grid_p2()');
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

function init_grid_p5() {
// 	console.log('init_grid_p5()');
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

function init_grid_t1() {
// 	console.log('init_grid_t1()');
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
//--------------------------- end 1210 detail ----------------------------------
//########################### selfInsp grid init end ###########################

//########################### load selfInsp data start ###########################
//selfinsp_1110 / selfinsp_1210
//--------------------------- start 1110 ----------------------------------
function showSelfInspGrid() {
// 	console.log('showSelfInspGrid()');
	$.each(selfDetail, function(idx, opt){
		$("#grid_" + opt + "_area").hide();
	});
	var code = $("#self_insp_routing").val().toLowerCase();
	if( code==null || code=='-' ) {	//전체
		$.each(selfDetail, function(idx, opt){
			$("#grid_" + opt + "_area").show();
			w2ui['grid_' + opt].resize();
			w2ui['grid_' + opt].refresh();
		});
	} else {
		$("#grid_" + code + "_area").show();
		w2ui['grid_' + code].resize();
		w2ui['grid_' + code].refresh();
	}
}

var selfDetail = [];
function makeSelectBox() {
// 	console.log('makeSelectBox()');
	$("#self_insp_routing").empty();
	var selectHeader = w2ui.grid_selfInsp_header.records[0];
	var page_url = "/frontend/mes/select_selfInspCode_1110"
				 + "?ref1=" + encodeURIComponent(selectHeader.simaster_gr_no);
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
						selfDetail.push((item.code).toLowerCase());
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
	var pordno = (w2ui.grid_sapord.get(w2ui.grid_sapord.getSelection()[0])).pordno;
	var headerData = w2ui.grid_selfInsp_header.records;
	$.each(headerData, function(idx, row){
		if( row.w2ui!=undefined ){
			row.item_value = row.w2ui.changes.item_value;
		}
	});
// 	console.log(headerData);
	var detailObj = {};
	$.each(selfDetail, function(idx, opt){
		detailObj[opt] = dataSetselfinspDetail(w2ui['grid_' + opt].records);
	});
	var page_url = "";
	if( dept_cd=="1110" ) {
		page_url = "/frontend/mes/saveSelfInsp_1110"
	} else {	// 1210
		page_url = "/frontend/mes/saveSelfInsp_1210"
	}
	page_url += "?pordno=" + encodeURIComponent(pordno)
			 + "&dept_cd=" + encodeURIComponent(dept_cd)
			 + "&confirm_id=" + encodeURIComponent(member_id);
	var params = "&headerData=" + encodeURIComponent(JSON.stringify(headerData))
			   + "&detailData=" + encodeURIComponent(JSON.stringify(detailObj))
	$.ajax({
		url: page_url,
		data : params,
		type: "POST",
		success:function(data, textStatus, jqXHR){
			if(data.status == "200") {
				fnMessageModalAlert("Success", "저장을 완료 하였습니다.");
				$("#modal_selfInsp").modal('hide');
				$("#pono").text("");	// 2018-01-24 : iris add, 지시번호 표시
				fnLoadGridData();
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
// 		if( row.member_nm=='' ) {
// 			row.member_nm = member_nm; 
// 			row.member_emp_no = member_emp_no; 
// 		}
		if( row.work_date=='' ) {
			row.work_date = replaceAll(getTodayDate(),'.','-'); 
		}
	});
	return dataArr;
}

//--------------------------- end 1110 ----------------------------------
//--------------------------- start 1210 ----------------------------------
function loadSelfInspDetail() {
// 	console.log('loadSelfInspDetail()');
	var selData = w2ui.grid_sapord.get(w2ui.grid_sapord.getSelection()[0]);
	var page_url = "/frontend/mes/select_selfinsp_detail"
				+ "?dept_cd=" + encodeURIComponent(dept_cd)
				+ "&pordno=" + encodeURIComponent(selData.pordno)
				+ "&use_yn=" + encodeURIComponent("Y")
				+ "&simaster_gr_no=" + encodeURIComponent((w2ui.grid_selfInsp_header.records)[0].simaster_gr_no);

	var detailObj = {};
	$.each(selfDetail, function(idx, code){
		w2ui['grid_' + code].lock('loading...', true);
	});
	
	$.ajax({
		url : page_url,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200" && (data.rows).length>0 ) {
				$.each(data.rows, function(idx, row){
					if( row.insp_state=='' || row.insp_state==undefined )
						row.insp_state = 'i2';
					var subCode = (row.routing_code_sub).toLowerCase();
					if ( detailObj[subCode]==undefined ) {
						var tmpArr = [];
						tmpArr.push(row);
						detailObj[subCode] = tmpArr;
					} else {
						detailObj[subCode].push(row);				
					}
				});
				$.each(detailObj, function(key, arr){
					$.each(arr, function(i, row){
						row.recid = i+1;
					});
					w2ui['grid_' + key].records = arr; 
					w2ui['grid_' + key].total = arr.length;
				});
			} else {
				fnMessageModalAlert("Fail",	"정보를 가져오는 중 오류가 발생하였습니다.");
			}
			$.each(selfDetail, function(idx, code){
				w2ui['grid_' + code].refresh();
				w2ui['grid_' + code].unlock();
			});
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "정보를 가져오는 중 오류가 발생하였습니다.");
		},
		complete : function() {}
	});
}
//--------------------------- end 1210 ----------------------------------
//########################### load selfInsp data end ###########################

function excelFileDownload(gridName) {
// 	console.log('excelFileDownload('+gridName+')');
	var gridCols = w2ui[gridName].columns;
	var gridData = w2ui[gridName].records;

	var fileName = '자주검사_확정관리.xlsx';
	var sheetTitle = '자주검사_확정관리';
	var sheetName = '자주검사_확정관리';
	
	var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
	var is_rownum = true;
	
	if(gridCols != null && gridCols.length > 0){
		// w2grid 는 linenumber column info not exist
		param_col_name = "No"
		param_col_id = "rownum";
		param_col_align = "center";
		param_col_width = "80";
		//--------------------------------------------
		for(var i=0; i<gridCols.length; i++){
			if(!gridCols[i].hidden){
				var caption = gridCols[i].caption;
					param_col_name += "," + caption;
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
	/*
	var getColModels = $("#grid_sapord").jqGrid('getGridParam','colModel');
	$.each(getColModels, function(idx, mrow){
		if( mrow.hidden==false && getColNames[idx]!='' ) {
			mrow.caption = getColNames[idx]; 
			tmpArr.push(mrow);  
		}
	});
	
	var gridCols = tmpArr;
	var gridData = $("#grid_sapord").getRowData();

	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	if( gridName=='grid_sapord' ) {
		fileName = '생산진행관리.xlsx';
		sheetTitle = '생산진행관리';
		sheetName = '생산진행관리';
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
	*/
}

function fnShowOperateHisModal() {
	var selKey = w2ui.grid_sapord.getSelection();
	if (selKey.length > 1) {
		fnMessageModalAlert("Notification", "한개의 작업만 선택해주세요.");
		return;
	} else if(selKey.length == 0) {
		fnMessageModalAlert("Notification", "선택된 작업이 없습니다.");
		return;
	}
	
	var selectedData = w2ui.grid_sapord.get(w2ui.grid_sapord.getSelection()[0]);
	var page_url = "/frontend/prod/pop_prod_his_select_confirm"
				 + "?pordno_pop=" + encodeURIComponent(selectedData.pordno+selectedData.pordno_child);
	var rowArr = [];
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		async:false,
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				w2ui.grid_operate_his.records = rowArr;
				w2ui.grid_operate_his.total = rowArr.length;
			}
			w2ui.grid_operate_his.refresh();
			w2ui.grid_operate_his.unlock();
			
		},complete: function () {}
	});
	
	$('#operate_his').modal('show');
	
	setTimeout(function(){
		w2ui.grid_operate_his.resize();
		w2ui.grid_operate_his.refresh();
	}, 200);	
}

function fnUsingMatnrList() {
	console.log('fnUsingMatnrList()');
 	w2ui.grid_addItnbr_list.clear();

 	// selection validate???
 	if( w2ui.grid_sapord.getSelection().length>0 ){
	 	var selGroupRow = w2ui.grid_sapord.get(w2ui.grid_sapord.getSelection()[0]);
	 	var page_url = "/frontend/prod/selectSernrManageTbl"
	 				 + "?pordno_pop=" + encodeURIComponent(selGroupRow.pordno+selGroupRow.pordno_child);
	 	w2ui['grid_addItnbr_list'].lock('loading...', true);
	 	$.ajax({
			url : page_url,
			type : "POST",
			success : function(data, textStatus, jqXHR) {
				if(data.status == 200 && (data.rows).length>0 ) {
					rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
						row.bdmng = Math.floor(row.bdmng);
					});
					w2ui['grid_addItnbr_list'].records = rowArr;
					w2ui['grid_addItnbr_list'].total = rowArr.length;
				}
				w2ui['grid_addItnbr_list'].refresh();
				w2ui['grid_addItnbr_list'].unlock();
			},
			error : function(jqXHR, textStatus, errorThrown) {
			},
			complete : function() {}
		});
	 	
	 	$('#matnr_list').modal('show');
		
		setTimeout(function(){
			w2ui.grid_addItnbr_list.resize();
			w2ui.grid_addItnbr_list.refresh();
		}, 200);	
 	}
}

function fnFaultyMatnrList() {
	console.log('fnFaultyMatnrList()');
 	w2ui.grid_faulty_matnr.clear();

 	if( w2ui.grid_sapord.getSelection().length>0 ){
 	 	var selGroupRow = w2ui.grid_sapord.get(w2ui.grid_sapord.getSelection()[0]);
  	 	var page_url = "/frontend/prod/selectfault_his_tbl"
  	 				 + "?pordno=" + encodeURIComponent(selGroupRow.pordno);
  	 	w2ui['grid_faulty_matnr'].lock('loading...', true);
  	 	$.ajax({
 			url : page_url,
  			type : "POST",
  			success : function(data, textStatus, jqXHR) {
  				if(data.status == 200 && (data.rows).length>0 ) {
 					rowArr = data.rows;
  					$.each(rowArr, function(idx, row){
  						row.recid = idx+1;
 						 
  					});
 					w2ui['grid_faulty_matnr'].records = rowArr;
  					w2ui['grid_faulty_matnr'].total = rowArr.length;
  				}
  				w2ui['grid_faulty_matnr'].refresh();
  				w2ui['grid_faulty_matnr'].unlock();
 			},
 			error : function(jqXHR, textStatus, errorThrown) {
 			},
 			complete : function() {}
 		});
	 	
	 	$('#faulty_matnr_list').modal('show');
		
		setTimeout(function(){
			w2ui.grid_faulty_matnr.resize();
			w2ui.grid_faulty_matnr.refresh();
		}, 200);	
 	}
}
</script>

</body>
</html>

