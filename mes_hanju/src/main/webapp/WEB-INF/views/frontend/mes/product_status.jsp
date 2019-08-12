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
        <jsp:param name="selected_menu_p_cd" value="1010" />
        <jsp:param name="selected_menu_cd" value="1032" />
    </jsp:include>

    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                MES <small>생산진행 관리</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> 시스템관리</a></li>
                <li class="active">생산진행 관리</li>
            </ol>
        </section>
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box" style="margin-bottom: 0px; min-height: 720px;">
                        <div class="box-header with-border">
                            <h3 class="box-title">생산지시</h3>
                            <div class="box-tools pull-right">
                                <div class="box-tools pull-right">
									<button type="button" class="btn btn-info btn-sm" onclick="drwDownload('drw');">
										도면 다운로드
									</button>
									<button type="button" class="btn btn-info btn-sm" onclick="drwDownload('ord');">
										작업표준서 다운로드
									</button>
                                    <button type="button" id="btn_main_serial_add" class="btn btn-primary btn-sm">시리얼등록</button>|
                                    <button type="button" id="btn_search_csr" class="btn btn-primary btn-sm">조회</button>
                                    <button type="button" id="btn_search_init" class="btn btn-primary btn-sm" onclick="fnSearchConditionInit();">조건초기화</button>
                                    <button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_sapord');" data-selfilepath="/upload" data-selfilename="test.xlsx">
									 	<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
									</button>
                                </div>
                            </div>
                        </div>
                        <!-- 조회조건 시작 -->
                        <div id="" class="box-body" style="padding-bottom: 0px;">
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>| 작업시작일</label>
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                            <input type="text" class="form-control pull-right input-sm" id="csr_register_date_range">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-2" style="padding-left: 0px;">
                                    <div class="form-group">
                                        <label>| 지시번호</label> <input type="input" id="s_pordno" name="s_pordno" class="form-control input-sm" placeholder="ex) 10010010010" maxlength="30">
                                    </div>
                                </div>
                                <div class="col-sm-2" style="padding-left: 0px;">
                                    <div class="form-group">
                                        <label>| 분야</label> 
                                         <select id="s_dept_cd" name="s_dept_cd" class="form-control select2 input-sm">
                                         	<option value="">전체</option>
                                         	<option value="1110">의료</option>
                                         	<option value="1210">광영상</option>
                                         </select>
                                    </div>
                                </div>
                                <div class="col-sm-2" style="padding-left: 0px;">
                                    <div class="form-group">
                                        <label>| 오더유형</label>
                                        <select id="s_order" name="s_order" class="form-control select2 input-sm">
                                         	<option value="">전체</option>
                                         	<option value="P">생산</option>
                                         	<option value="C">포장</option>
                                         </select>
                                    </div>
                                </div>
                                <div class="col-sm-2">
									<div class="form-group">
										<label>| 생산유형</label> 
										<select id="auart" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
											<option value="">전체</option>
											<option value="ZP01">생산</option>
											<option value="ZP02">재작업</option>
											<option value="ZP03">C/S 수리</option>
											<option value="ZP04">연구소</option>
											<option value="ZP05">S/W</option>
											<option value="ZP06">C/S 생산 수리</option>
											<option value="ZP07">Mount교체(광영상)</option>
											<option value="ZP09">C/S 로너 수리</option>
										</select>
									</div>
								</div>
								<div class="col-sm-4">
                                    <div class="form-group">
                                        <label>| 자재코드</label> <input type="input" id="s_itnbr" name="s_itnbr" class="form-control input-sm" placeholder="ex) 1800-100A" maxlength="50">
                                    </div>
                                </div>
								<div class="col-sm-4">
                                    <div class="form-group">
                                        <label>| 자재내역</label> <input type="input" id="s_pordno_status" name="s_pordno_status" class="form-control input-sm" placeholder="ex) REL  PCNF DLV  PRC  GMCO MANC SETC" maxlength="50">
                                    </div>
                                </div>
								<div class="col-sm-4" style="padding-left: 0px;">
                                   <div class="form-group">
                                	   <label>| 시리얼번호</label>
                                	   <!--  <input type="input" id="s_project_no" name="s_project_no" class="form-control input-sm" placeholder="ex) MPLAHA999" maxlength="50"> -->
                                	    <input type="input"  id="s_project_no" name="s_project_no" class="form-control input-sm"  maxlength="100"  
								onkeypress="if(event.keyCode==13) {LMainsernr_enter(this); return false;}">
                                   </div>
                                </div>
                            </div>
                        </div>
                        <div id="dv_grid_sapord" class="box-body" style="padding-top: 0px;">
                            <table id="grid_sapord"></table>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row">
                        <div class="box" style="min-height: 350px;">
                            <div class="box-header with-border">
                                <h3 class="box-title">공정관리</h3>
                                <div class="box-tools pull-right">
                                	<button type="button" id="btn_g_fault_proc" class="btn bg-maroon btn-sm" onClick="g_fault_proc();">자재불량처리</button>
                               		<button type="button" id="btn_pord_rework" class="btn btn-info btn-sm" onClick="confirm_reWork();">재작업</button>
                                    <button type="button" id="btn_pord_del" class="btn btn-info btn-sm" onClick="selrowEdit();" style="display:none;">공정삭제</button>
                                    <button type="button" id="btn_detail_serial_add" class="btn btn-sm" onClick="popUpDetailSerial();">공정운영처리</button>
                               <!--      <button type="button" id="btn_itnbr_add" class="btn  btn-sm">추가자재불출</button>| -->
                                    <button type="button" id="btn_work_start" class="btn btn-danger btn-sm">작업시작</button>
                                    <button type="button" id="btn_work_pause_start" class="btn btn-primary btn-sm">비가동시작</button>
                                    <button type="button" id="btn_work_pause_end" class="btn btn-primary btn-sm">비가동종료</button>
                                    <button type="button" id="btn_work_end" class="btn btn-warning btn-sm">작업종료</button>
                                </div>
                            </div>
                            <div id="dv_grid_popord" class="box-body">
                                <table id="grid_popord"></table>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="box" style="margin-bottom: 0px; min-height: 350px;">
                            <div class="box-header with-border">
                                <h3 class="box-title">작업이력 <span id="selrouting"></span> </h3>
                            </div>
                            <div id="dv_grid_hisord" class="box-body">
                                <table id="grid_hisord"></table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

<%@include file="./product_status_modal.jsp"%>
    <jsp:include page="/common/footer_inc" flush="true">
        <jsp:param name="page_title" value="0" />
    </jsp:include>

    <jsp:include page="/common/sidebar_rview_inc" flush="true">
        <jsp:param name="page_title" value="0" />
    </jsp:include>
    </div>
<script type="text/javascript">
var member_id = '<%=member_id%>';
var member_nm = '<%=member_nm%>';
var member_emp_no = '<%=member_emp_no%>';
var gnrFaultMantrFlag='';
var selected_pordno='';
var selected_pordno_pop='';
var selected_routing_no='';
var selected_lgort='';
var gridPopordSelect_idx ='';
var gridSapordSelect_idx = '';
var minDate='';
var maxDate='';
var grid_itnbr_selected='';
var searchMatCode = '';
var selected_sernr='';
var selected_wkctr = '';
// var faultMatrArr = [];
// var faultMatrArr = new Array() ;
var faultMatrArr = [];

// var chk_result;
$(function($) {

// 	$("#btn_work_start").css("visibility", "hidden");
// 	document.getElementById("btn_work_start").style.visibility = "hidden";

	
	fnLoadCommonOption();
	fnDateInit();
	fnLoadMasterCodeGrid();
	fnLoadDetailCodeGrid();
	fnLoadHisGrid();
	//fnLoadItnbrGrid()
	fnLoadWorkerAddGrid();
	fnLoadFaultListGrid();
	fnLoadProdFaultListGrid();
	fnLoadFaultRoutingListGrid();
	fnLoadGradeMngGrid();
	init_g_MaterialGrid();
	initScreenSizeModal();
	$('#m_lv3').blur(function() {
		$('#m_lv3').val();
	});
    
	$('#s_plant').change(function() {
		g_materialSearch();
	});
	
	$('input[name=chk]').each(function() {
	      $(this).on('change', function() {
// 				alert("test");
	       });
	});
    
})


function fnDateInit() {
	$('#csr_register_date_range').daterangepicker({
		opens : 'right',
		locale : {
			format : 'YYYY-MM-DD'	,
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
					'7월', '8월', '9월', '10월', '11월', '12월' ],
			daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
			showMonthAfterYear : true,
			yearSuffix : '년'
		},
	    startDate: getTodayDate(),
	    endDate: getTodayDate()
	});
	


/*      minDate = getFormatDate(new Date()), 
	mdTemp = new Date(), 
	maxDate = getFormatDate(new Date(mdTemp.setDate(mdTemp.getDate() + 30)));
	
	$('#csr_register_date_range').daterangepicker({
		opens : 'right',
		locale : {
			format : 'YYYY-MM-DD'	,
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
					'7월', '8월', '9월', '10월', '11월', '12월' ],
			daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
			showMonthAfterYear : true,
			yearSuffix : '년'
		},
//		startDate : '2017-10-01',
//		endDate :  '2017-10-30'
 		startDate : moment(maxDate),
 		endDate :  moment(maxDate)
 		
	});  
 		 */ 
}

function makeSelStep1() {
// 	console.log('makeSelStep1()');
	
	var page_url = "/frontend/scm/issue_getStep1";
	$.ajax({
	    url: page_url,
	    data: '',
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
// 	console.log('makeSelStep1()');
	
	var page_url = "/frontend/scm/issue_getStep1";
	$.ajax({
	    url: page_url,
	    data: '',
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
//         .append('<option value="">선택</option>')
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
function getFormatDate(d) {
	var month = d.getMonth();
	if( month==12 ) month = 0;
	else month += 1; 
	var date = d.getDate();
	month = (month < 10) ? "0" + month : month;
	date = (date < 10) ? "0" + date : date;
	return d.getFullYear() + '-' + month + '-' + date;
}

function fnLoadCommonOption() {
	$('input[type="radio"].flat-red').iCheck({
		checkboxClass : 'icheckbox_flat-green',
		radioClass : 'iradio_flat-green',
		handle : 'radio'
	});

	$(window).bind('resize', function() {
		resizeJqGrid("grid_sapord", false);
		resizeJqGrid("grid_popord", false);
		resizeJqGrid("grid_hisord", false);
	}).trigger('resize');

	$("#btn_work_start, #btn_work_end, #btn_search_csr, #btn_work_pause_start, #btn_work_pause_end, #btn_itnbr_add, #btn_main_serial_add, #modal_main_serial_add")
		.on('click',
				function(e) {
					e.preventDefault();
					 
					if (e.target.id == "btn_work_start") {
						//재작업시
						var gridRowData = $("#grid_popord").getRowData($("#grid_popord").getGridParam('selrow'));
						if(gridRowData.member_nm.length > 0) {
							fnWorkChnStat('start');
							return;
						}
						
						$("#grid_worker").jqGrid('clearGridData');	// modal : 사원정보 grid init
						fnSearchWorkerAddGrid();
						$("#m_worker_mes_po").val(selected_pordno_pop);
						$("#m_routing_no").val(selected_routing_no);	
						
						$("#login_user").val(member_nm);
						$("#modal_worker_add").modal('show');
					} else if (e.target.id == "btn_search_csr") {
						selected_pordno='';
						fnSearchMasterCodeGrid();
					} else if (e.target.id == "btn_work_end") {
// 						fnWorkChnStat('end');
						grade_chk();
// 						fnWorkEnd(selected_pordno_pop, selected_routing_no);
					} else if (e.target.id == "btn_work_pause_start") {
						fnWorkChnStat('pause_start');
// 						fnWorkPauseStart(selected_pordno_pop, selected_routing_no);
					} else if (e.target.id == "btn_work_pause_end") {
						fnWorkChnStat('pause_end');
// 						fnWorkPauseEnd(selected_pordno_pop, selected_routing_no);
					} else if (e.target.id == "btn_itnbr_add") {
						if (selected_pordno_pop != "") {
							$("#modal_itnbr_add").modal('show');
						} else {
							fnMessageModalAlert("Notification(ItnbrAdd)", "공정관리항목에 선택된 지시가 없습니다.");
						}
					} else if (e.target.id == "btn_main_serial_add") {
						if (selected_pordno == '') {
							fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더 없습니다.");
							return;
						}
						var selecData = $("#grid_sapord").jqGrid('getRowData', selected_pordno);
						$("#m_sap_po").val(selected_pordno);
						$("#m_jidat").val(selected_jidat);
						$("#m_serial_no").val('');
						var project_no = selecData.project_no;
						if( project_no!='' ){
							$("#m_serial_no").val(project_no);
						}
						
						$("#modal_main_serial_add").modal('show');
					}
				});
		initItnbrGrid();
		initMaterialGrid();
		initNewItnbrGrid();
// 		$('#csr_register_date_range').daterangepicker({
// 			opens : 'right',
// 			locale : {
// 				format : 'YYYY-MM-DD'	,
// 				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
// 						'7월', '8월', '9월', '10월', '11월', '12월' ],
// 				"daysOfWeek": [ "일","월", "화", "수", "목", "금", "토" ],
// 				showMonthAfterYear : true,
// 				yearSuffix : '년'
// 			}
// 		});
	}

// init search condition
function fnSearchConditionInit() {
	
	sernr_stock_chk('1210', '2282-B001', 'MBLAGZ003');
	
	fnDateInit();
	$("#s_pordno").val("");	
	$("#s_pordno_status").val("");
	$("#s_itnbr").val("");
}

// 생산지시 grid generate
function fnLoadMasterCodeGrid() {
// 	console.log('fnLoadMasterCodeGrid()');
	var date1 = replaceAll($("#csr_register_date_range").val().substring(0, 10),'-','');
	var date2 = replaceAll($("#csr_register_date_range").val().substring(13, 23),'-','');

	var page_url = "/frontend/prod/sap_prod_select";
		page_url += "?jidat_from=" + encodeURIComponent(date1);
		page_url += "&jidat_to=" + encodeURIComponent(date2);
		page_url += "&cmdat=" + encodeURIComponent("cmdat");	//cmdat is not null 실행 조건으로 걸어놓았음...
		page_url += "&dept_cd=" + encodeURIComponent($("#s_dept_cd").val());
		page_url += "&routing_gno_gubun=" + encodeURIComponent($("#s_order").val());
		page_url += "&auart=" + encodeURIComponent($("#auart").val());
// 		page_url += "&pdsts=" + encodeURIComponent("p2");

	$("#grid_sapord").jqGrid({
		url : page_url,
		datatype : "json",
		colNames : [ '상태', 'pdsts', '지시번호', '지시일', '품목', '작업내역', '시리얼', 'lgort', '플랜트','routing_gno', 'routing_no'
		             ,'fedat', 'sedat', 'auart', '오더유형', 'wkctr', 'pdqty', 'routing_gno_gubun', 'sernp'],
		colModel : [
		            {name : 'pdsts_nm',index : 'pdsts_nm', width : 20,sorttype : "text",	sortable : true}, 
		            {name : 'pdsts',index : 'pdsts',width : 10,sorttype : "text",	sortable : true, hidden:true}, 
		            {name : 'pordno',index : 'pordno',width : 20,sorttype : "text",sortable : true,key : true}, 
		            {name : 'jidat',index : 'jidat',width : 25,sorttype : "text",sortable : true},
		            {name : 'itnbr',index :'itnbr',width : 25, sorttype : "text",sortable : true},
		            {name : 'pordno_status',index : 'pordno_status',width : 50,sorttype : "text",sortable : true}, 
		            {name : 'project_no',index : 'project_no',	width : 35,sorttype : "text",	sortable : true},
		            {name : 'lgort',index :'lgort', width:10, sorttype : "text", sortable : true, hidden:true}, 
		            {name : 'dept_cd',index :'dept_cd', width:15, sorttype : "text", sortable : true, hidden:false},
		            {name : 'routing_gno',index :'routing_gno', width:10, sorttype : "text", sortable : true, hidden:true},
		            {name : 'routing_no',index :'routing_no', width:10, sorttype : "text", sortable : true, hidden:true},
		            {name : 'fedat',index :'fedat', hidden:true},
		            {name : 'sedat',index :'sedat', hidden:true},
		            {name : 'auart',index :'auart', hidden:true},
		            {name : 'auart_nm',index :'auart_nm', width:15, hidden:false},
		            {name : 'wkctr',index :'wkctr', hidden:true},
		            {name : 'pdqty',index :'pdqty', hidden:true},
		            {name : 'routing_gno_gubun',index :'routing_gno_gubun', hidden:true},
		            {name : 'sernp',index :'sernp', hidden:true}
		            ], 
		rowNum : 1000,
		viewrecords : true,
		autowidth : true,
		shrinkToFit : true,
		multiselect : false,
		height : 510,
		altRows : true,
		rownumbers : true,
		rownumWidth : 25,
		autoencode : true,
		loadonce : true,
		sortable : true,
		onSelectRow : function(rowid, selected) {
			if (rowid != null && selected) {
				var rowData = $("#grid_sapord").jqGrid('getRowData', rowid);
				gridSapordSelect_idx = $("#grid_sapord").jqGrid('getInd', rowid);
				selected_pordno = rowData.pordno;
				selected_jidat =  rowData.jidat;
				selected_lgort =  rowData.lgort;
				selected_sernr =  rowData.project_no;
				selected_wkctr = rowData.wkctr;
				selected_dept_cd =  rowData.dept_cd;
				selected_auart =  rowData.auart;
				
				if( rowData.auart=='ZP01' || rowData.auart=='ZP05' ) {
					searchMatCode = 'basic';
				} else {	// ZP02, ZP03, ZP04
					searchMatCode = 'mat';
				}
				
				if( rowData.auart!='ZP01' )
					$("#btn_pord_del").show();
				else
					$("#btn_pord_del").hide();
				fnSearchDetailCodeGrid(selected_pordno);
				
				selected_pordno_pop = "";
				selected_routing_no = "";
				$("#grid_hisord").jqGrid('clearGridData');
				
// 				if( $("#grid_sapord").jqGrid('getRowData', rowid).project_no != '' ) {
// 					$('#btn_main_serial_add').hide();
// 				} else {
// 					$('#btn_main_serial_add').show();
// 				}
			}
			
			if(prodRfcConf_yn()) {			
				$('#btn_pord_rework').hide();
			} else {
				$('#btn_pord_rework').show();
			}
		},
		loadComplete : function(data) {
		}
	});
}

//생산지시 grid search
function fnSearchMasterCodeGrid() {
// 	console.log('fnSearchMasterCodeGrid()');
	var date1 = replaceAll($("#csr_register_date_range").val().substring(0, 10),'-','');
	var date2 = replaceAll($("#csr_register_date_range").val().substring(13, 23),'-','');

	var page_url = "/frontend/prod/sap_prod_select";
	page_url += "?jidat_from=" + encodeURIComponent(date1);
	page_url += "&jidat_to=" + encodeURIComponent(date2);
	page_url += "&pordno_status=" + encodeURIComponent($("#s_pordno_status").val());
	page_url += "&cmdat=" + encodeURIComponent("cmdat");
	page_url += "&pordno=" + encodeURIComponent($("#s_pordno").val());
	page_url += "&project_no=" + encodeURIComponent($("#s_project_no").val());
	page_url += "&dept_cd=" + encodeURIComponent($("#s_dept_cd").val());
	page_url += "&routing_gno_gubun=" + encodeURIComponent($("#s_order").val());
	page_url += "&auart=" + encodeURIComponent($("#auart").val());
	page_url += "&itnbr=" + encodeURIComponent($("#s_itnbr").val());
	
	$("#grid_sapord").jqGrid('setGridParam', { url : page_url, datatype : 'json' });
	$("#grid_sapord").trigger("reloadGrid");
	if (gridSapordSelect_idx != '') {
		setTimeout(function() {
			var ids = $("#grid_sapord").jqGrid("getDataIDs");
			if (ids && ids.length > 0) {
				$("#grid_sapord").jqGrid("setSelection", ids[gridSapordSelect_idx - 1]);
			}
		}, 100);
	}
// 	$("#grid_sapord").jqGrid("setSelection", gridSapordSelect_idx);
	$("#grid_popord").jqGrid('clearGridData');
	$("#grid_hisord").jqGrid('clearGridData');
}

// 공정관리 grid generate
function fnLoadDetailCodeGrid() {
// 	console.log('fnLoadDetailCodeGrid()');
	var pordno;
	var page_url = "/frontend/prod/pop_prod_select"
				 + "?pordno=" + encodeURIComponent(pordno);

	$("#grid_popord").jqGrid({
			url : page_url,
			datatype : "json",
			colNames : [ '공정순서', 'MES지시번호', '시리얼', '공정코드', '공정명','상태', '작업자','시작', '종료','routing_gno','routing_plast_gubun', 'pdsts','소요시간 <br> (Min)'],
			colModel : [ 
					{ name : 'routing_no', index : 'routing_no', hidden:true, key : true },
					{ name : 'pordno_pop', index : 'pordno_pop', hidden:true},
					{ name : 'project_no', index : 'project_no', hidden:true},
					{ name : 'routing_code', index : 'routing_code', width : 20, sorttype : "text", sortable : true  },
					{ name : 'routing_dscr', index : 'routing_dscr', width : 30, sorttype : "text", sortable : true  },
					{ name : 'pdsts_nm', index : 'pdsts_nm', width : 15, sorttype : "text", sortable : true  },
					{ name : 'member_nm', index : 'member_nm', width : 25, sorttype : "text", sortable : true  },
					{ name : 'start_dt_tm', index : 'start_dt_tm', width : 30, sorttype : "text", sortable : true  },
					{ name : 'end_dt_tm', index : 'end_dt_tm', width : 30, sorttype : "text", sortable : true  },
					{ name : 'routing_gno', index : 'routing_gno', hidden:true  },
					{ name : 'routing_plast_gubun', index : 'routing_plast_gubun', hidden:true  },
					{ name : 'pdsts', index : 'pdsts', hidden:true  },
					{ name : 'diff_time', index : 'diff_time',width : 15  }
					],
			rowNum : 1000,
			viewrecords : true,
			autowidth : true,
			shrinkToFit : true,
			multiselect : true,
			height : 270,
			altRows : true,
			rownumbers : true,
			rownumWidth : 25,
			autoencode : true,
			loadonce : true,
			sortable : true,
			onSelectRow : function(rowid, selected) {
				var rowData = $("#grid_popord").getRowData(rowid);
				var rowAll = $("#grid_popord").getRowData();
				$("#selrouting").text("( " + rowData.routing_code + " - " + rowData.routing_dscr + " )");
				if (rowid != null && selected) {
					selected_pordno_pop = $("#grid_popord").jqGrid('getRowData', rowid).pordno_pop;
					selected_routing_no = $("#grid_popord").jqGrid('getRowData', rowid).routing_no;
					gridPopordSelect_idx = $("#grid_popord").jqGrid('getInd', rowid);
					$(this).jqGrid("setSelection", gridSapordSelect_idx, true);
					var beforeIdx = (gridPopordSelect_idx>1)?(gridPopordSelect_idx-1):gridPopordSelect_idx;
					var beforeStat = rowAll[beforeIdx-1].pdsts_nm;
					if ( rowData.routing_plast_gubun=="Y" ) {
						$("#btn_pord_del").hide();
					} else {
						$("#btn_pord_del").show();
					}
					
					
					if ( gridPopordSelect_idx==beforeIdx==1 || beforeStat=="종료" || rowData.pdsts_nm=="종료" ) {
						fnSearchHisGrid(selected_pordno_pop, selected_routing_no);
					} else { // if (beforeStat!="종료" ){
						$("#grid_hisord").jqGrid('clearGridData');
						$("#btn_work_start").css("visibility","hidden");
						$("#btn_work_pause_start").css("visibility","hidden");
						$("#btn_work_pause_end").css("visibility","hidden");
						$("#btn_work_end").css("visibility","hidden");
						fnSearchHisGrid(selected_pordno_pop, selected_routing_no);
// 						fnMessageModalAlert("확인하세요.", "이전 단계가 작업종료 상태가 아니므로 시작 할 수 없습니다.");
					}
				} else {	// selected = false
					$("#grid_hisord").jqGrid('clearGridData');
// 					$("#selrouting").text("");
					$("#btn_work_start").css("visibility","hidden");
					$("#btn_work_pause_start").css("visibility","hidden");
					$("#btn_work_pause_end").css("visibility","hidden");
					$("#btn_work_end").css("visibility","hidden");
				}
			},
			beforeSelectRow: function (rowId, e) {
				$(this).jqGrid("resetSelection");
			    return true;
			},
			loadComplete : function() {}
		});
}

//공정관리 grid search
function fnSearchDetailCodeGrid(pordno) {
// 	console.log('fnSearchDetailCodeGrid()');
	var page_url = "/frontend/prod/pop_prod_select"
				 + "?pordno=" + encodeURIComponent(pordno);

	$("#grid_popord").jqGrid('setGridParam', { url : page_url, datatype : 'json' });
	$("#grid_popord").trigger("reloadGrid");
// 	$("#grid_popord").jqGrid("setSelection", gridPopordSelect_idx);
	
	if (gridPopordSelect_idx != '') {
		setTimeout(function() {
			var grid = $("#grid_popord"), 
				ids = grid.jqGrid("getDataIDs");
			if (ids && ids.length > 0) {
				grid.jqGrid("setSelection", ids[gridPopordSelect_idx - 1]);
			}
		}, 200);
	}
}

function selrowEdit() {
// 	console.log('selrowEdit()');
	var keyArr = $("#grid_popord").jqGrid('getGridParam', 'selarrrow');
	if( keyArr.length==0 ){
		fnMessageModalAlert("Notification", "선택된 공정이 없습니다.");
		return;
	}
	
	var selGridRowData = $("#grid_popord").getRowData($('#grid_popord').jqGrid('getGridParam','selrow'));
	var getProdStatus_result;
	var page_url = "/frontend/prod/getProdStatus";
	var postData = "pordno_pop=" +  encodeURIComponent(selGridRowData.pordno_pop);
	postData += "&routing_no=" +  encodeURIComponent(selGridRowData.routing_no);
	 
	$.ajax({
		url : page_url,
		data : postData,
		async:false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				getProdStatus_result = data.result;
			} else {
				fnMessageModalAlert("Fail", "선택 오더의 현재 작업 상태를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Fail", "선택 오더의 현재 작업 상태를 가져오지 못했습니다.");
		}
	});	
	
	
	if(getProdStatus_result != 'p2') {
		fnMessageModalAlert("Notification(MES)", "이미 작업이 시작된 공정은 삭제할 수 없습니다.");
		return;
	}
	
	
	var params = new Array();  
	var idArry = $("#grid_popord").jqGrid('getDataIDs'); //grid의 id 값을 배열로 가져옴
	for (var i=0 ; i<idArry.length; i++) { //row id수만큼 실행           
	    if($("input:checkbox[id='jqg_grid_popord_"+idArry[i]+"']").is(":checked")){ //checkbox checked 여부 판단
		    var rowdata = $("#grid_popord").getRowData(idArry[i]); // 해당 id의 row 데이터를 가져옴
		    params.push(rowdata); //배열에 맵처럼 담김
	    }
	}
	
	fnMessageModalConfirm("Notification", "해당 데이터를 삭제 하시겠습니까?", function(chk){
		if(chk){
			var page_url = "/frontend/prod/deletetProdOrdTbl";
			var postData = "params=" +  encodeURIComponent(JSON.stringify(params));
			$.ajax({
				url : page_url,
				data : postData,
				type : "POST",
				async: false,
				success : function(data, textStatus, jqXHR) {
					if (data.status == "200") {
						fnMessageModalAlert("Success", "삭제되었습니다.");
						fnSearchDetailCodeGrid(selected_pordno);
					} else {
						fnMessageModalAlert("Fail", "삭제 작업이 완료되지 않았습니다.");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					fnMessageModalAlert("Fail", "삭제 작업 중 오류가 발생하였습니다.");
				}
			});			 
		}
	});		
}

// 작업이력 grid generate 
function fnLoadHisGrid() {
	var pordno_pop;
	var page_url = "/frontend/prod/pop_prod_his_select"
				 + "?pordno_pop=" + encodeURIComponent(pordno_pop);

	$("#grid_hisord").jqGrid({
		url : page_url,
		datatype : "json",
		colNames : [ '공정순서', 'MES지시번호', '공정코드', '공정명', '작업시작',
					'비가동시작', '비가동종료', '작업종료', 'pordno_seq' ],
		colModel : [
			{name : 'routing_no', index : 'routing_no', width : 30, sorttype : "text", sortable : true, hidden:true}, 
			{name : 'pordno_pop', index : 'pordno_pop', width : 40, sorttype : "text", sortable : true, hidden:true}, 
			{name : 'routing_code', index : 'routing_code', width : 30, sorttype : "text", sortable : true}, 
			{name : 'routing_dscr', index : 'routing_dscr', width : 50, sorttype : "text", sortable : true}, 
			{name : 'start_dt_tm', index : 'start_dt_tm', width : 50, sorttype : "text", sortable : true}, 
			{name : 'pause_start_dt_tm', index : 'pause_start_dt_tm', width : 50, sorttype : "text", sortable : true}, 
			{name : 'pause_end_dt_tm', index : 'pause_end_dt_tm', width : 50, sorttype : "text", sortable : true}, 
			{name : 'end_dt_tm', index : 'end_dt_tm', width : 50, sorttype : "text", sortable : true}, 
			{name : 'pordno_seq', index : 'pordno_seq', width : 50, sorttype : "text", sortable : true, hidden : true, key : true} ],
		rowNum : 1000,
		viewrecords : true,
		autowidth : true,
		shrinkToFit : true,
		multiselect : false,
		height : 250,
		altRows : true,
		rownumbers : true,
		rownumWidth : 25,
		autoencode : true,
		loadonce : true,
		sortable : true,
		onSelectRow : function(rowid, selected) {
			if (rowid != null) {}
		},
		loadComplete : function(data) {
			workStatusChk();
		}
	});
}

//작업이력 grid search
function fnSearchHisGrid(pordno_pop, routing_no) {
	console.info('fnSearchHisGrid(',pordno_pop,', ',routing_no,')');
	$("#grid_hisord").jqGrid('clearGridData');
	var page_url = "/frontend/prod/pop_prod_his_select"
				 + "?pordno_pop=" + encodeURIComponent(pordno_pop)
				 + "&routing_no=" + encodeURIComponent(routing_no);

	$("#grid_hisord").jqGrid('setGridParam', { url : page_url, datatype : 'json'});
	$("#grid_hisord").trigger("reloadGrid");
}

// 공정투입자재 grid generate
function initNewItnbrGrid() {
//   	console.log('initNewItnbrGrid()');
	$("#grid_addItnbr_list").jqGrid('clearGridData');
	$("#grid_addItnbr_list").trigger("reloadGrid");
	var selGridRowData = $("#grid_popord").getRowData($('#grid_popord').jqGrid('getGridParam','selrow'));
	var page_url = "/frontend/prod/selectSernrManageTbl"
				 + "?pordno_pop=" + encodeURIComponent(selected_pordno_pop);
// 				 + "&routing_no=" + encodeURIComponent(selGridRowData.routing_no);
	$("#grid_addItnbr_list").jqGrid({
		url:page_url,
		datatype: 'json',
		colNames:['자재','저장위치','소요량','단위','sernp','시리얼사용여부', '일련번호', '예약품목번호', '생산오더번호','pordno_pop', 'uni_key', 'sernr_seq', 'kzumw'],
		colModel:[
// 			{name:'chk',index:'chk', width:20, formatter: function() { 
// 				return "<input type='checkbox' name='chk' class='add_itnbr' onclick='makeFaultMatnrArr(this);'/>";}},
			{name:'matnr',index:'matnr', width:90, sorttype:'text', sortable:true},
			{name:'lgort',index:'lgort', width:50, sorttype:'text', sortable:true, sortable:true, hidden:false},
			{name:'bdmng', index:'bdmng', width:50, sorttype:'text', sortable:true},
			{name:'meins',index:'meins', width:40, sorttype:'text', sortable:true, sortable:true},
			{name:'sernp',index:'sernp', width:50, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'f_sernp',index:'f_sernp', width:50, sorttype:'text', sortable:true, sortable:true, hidden:false, formatter:jqgridHighlightFormattersernpYn},
			{name:'sernr',index:'sernr', width:90, sorttype:'text', sortable:true, hidden:false},
			{name:'rspos',index:'rspos', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'aufnr',index:'aufnr', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
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
	    	var rowData = $("#grid_addItnbr_list").getRowData(rowId);
	    	if( rowData.uni_key.length == 0){
	    		$(".input_1").hide();
	    		if(rowData.sernp=='V001') {
	    			$(".input_1").show();
	    		}
	    		if(rowData.kzumw == 'Y') {
	    			if($("#grid_sapord").getRowData($("#grid_sapord").getGridParam('selrow')).routing_gno_gubun == 'Y')
	    				getStrList('mst04');
	    			else
	    				getStrList('mst03');
	    		} else {
	    			initOptions($('#fsa_loc'));
	    			
	    			$('#fsa_loc').append($('<option>', { 
				        value: rowData.lgort,
				        text : rowData.lgort 
				    }));
	    		}
				$("#fsa_project_no").val('');
				$("#fsa_bdmng").val(rowData.bdmng);
				
		    	$('#scanner_serial_add').modal('show');
	    	} 
	    },
		afterEditCell: function (rowid, cellname, value, iRow, iCol) {
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
			//addItnbrData = data.rows;			
		}
	});
// 	$("#grid_addItnbr_list").trigger("reloadGrid");	
}

//공정투입자재 grid generate
 function reloadNewItnbrGrid() {
 	console.info('reloadNewItnbrGrid()');
	
 	var rtn_data = [];
 	$("#grid_addItnbr_list").jqGrid('clearGridData');
 	var selGridRowData = $("#grid_popord").getRowData($('#grid_popord').jqGrid('getGridParam','selrow'));
 	var page_url = "/frontend/prod/selectSernrManageTbl"
 				 + "?pordno_pop=" + encodeURIComponent(selected_pordno_pop)
 				 + "&routing_no=" + encodeURIComponent(selected_routing_no);
 	$("#grid_addItnbr_list").jqGrid('setGridParam', { 
 		url : page_url, 
 		datatype : 'json' ,
 		ajaxGridOptions : { async:false },
 		loadComplete : function(data) {
 			rtn_data = data.rows;
 			addItnbrData = rtn_data;
 		}
 	});
 	
 	$("#grid_addItnbr_list").trigger("reloadGrid");

 	return rtn_data;
 }

function materialSearch() {
// 	console.log('materialSearch()');
	var page_url = '/frontend/hub/material_recv_master_select'
		 		 + '?matnr=' + encodeURIComponent($("#m_matnr").val())
		 		 + '&wrkst=' + encodeURIComponent($("#m_wrkst").val())
		 		 + '&maktx=' + encodeURIComponent($("#m_maktx").val())
				 + '&werks=' + encodeURIComponent(selected_dept_cd);
	$("#grid_materiallist").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_materiallist").setGridParam({ page: 1 }).trigger("reloadGrid");
	
	$("#modal_mat_search").modal('hide');
}

function initMaterialGrid() {
	var page_url = '/frontend/hub/material_recv_master_select';
	$('#grid_materiallist').jqGrid({
		url:page_url,
		datatype: 'json',
		colNames:['자재코드','자재내역',' Spec.','제품군명', '자재그룹명', '생성일자', '수정일자', '단위', 'lgpro', 'sernp', 'kzumw'],
		colModel:[
// 			{name:'chk',index:'chk', width:20, formatter: function(){
// 						return "<input type='checkbox' name='chk' class='mat' onclick='makeFaultMatnrArr(this);'/>"; }},
			{name:'matnr',index:'matnr', width:100, sorttype:'text', sortable:true, key:true},
			{name:'maktx',index:'maktx', width:130, sorttype:'text', sortable:true},
			{name:'wrkst',index:'wrkst', width:130, sorttype:'text', sortable:true, sortable:true},
			{name:'vtext',index:'vtext', sorttype:'text', sortable:true, hidden:true},
			{name:'wgbez',index:'wgbez', sorttype:'text', sortable:true, hidden:true},
			{name:'date_created',index:'date_created', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'date_updated',index:'date_updated', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'meins',index:'meins', width:30, hidden:false},
			{name:'lgpro',index:'lgpro', hidden:true},
			{name:'sernp',index:'sernp', hidden:true},
			{name:'kzumw',index:'kzumw', hidden:true}
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
	    	$("#grid_addItnbr_list").setColProp('bdmng',{editable:false});
		},
		loadComplete : function(data) {
		}
	});
}

function initItnbrGrid() {
	console.info('initItnbrGrid()');
	
	$('#grid_itnbrlist').jqGrid({
		datatype: 'json',
		colNames:['자재','자재명','소요량','단위','등급관리','일련번호', '예약품목번호', '생산오더번호', 'lgort', '투입필요수량'],
		colModel:[
// 			{name:'chk',index:'chk', width:20, formatter: function(){
// 				return "<input type='checkbox' name='chk' class='itnbr' onclick='makeFaultMatnrArr(this);'/>";}},
			{name:'matnr',index:'matnr', width:88, sorttype:'text', sortable:true, key: true},
			{name:'maktx', index:'maktx', width:100, sorttype:'text', sortable:true},
			{name:'bdmng', index:'bdmng', width:44, sorttype:'text', sortable:true},
			{name:'meins',index:'meins', width:35, sorttype:'text', sortable:true, sortable:true},
			{name:'kzumw',index:'kzumw', width:60, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'sernp',index:'sernp', width:56, sorttype:'text', sortable:true, hidden:false},
			{name:'rspos',index:'rspos', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'aufnr',index:'aufnr', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'lgort',index:'lgort', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'remain_bdmng',index:'remain_bdmng', width:40, sorttype:'text', sortable:true, sortable:true}
		],
// 		pager : '#grid_itnbrlist_pager',
		rowNum:10000,
// 		rowList : [ 20, 50, 100 ],
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : true,
	    height: 360,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
// 	    sortable: true,
// 	    sortname: 'matnr',
	    onSelectRow : function(rowid, selected) {
	    	$("#grid_addItnbr_list").setColProp('bdmng',{editable:false});
		},
		loadComplete : function(data) {
		}
	});
	
	$("#grid_itnbrlist").trigger("reloadGrid", [{current:true}]); 
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
			{name:'wrkst',index:'wrkst', width:110, sorttype:'text', sortable:true},
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
	                		if(data.matnr ==	rowData[i].matnr) {
	                			flag++;
	                		}
	                	}
	                	
	                	if(flag > 1) {
	                		fnMessageModalAlert("오류", "이미 수량 확정이 된 데이터입니다.");
							var tmp = "#" + this.id;
							$(tmp).val("1");
							
	                		return;
	                	}
	                	rowData.splice(Number(selKey)-1, 1);
		            
	                	var d_addMatObj = [];
	                	
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
		                	d_addMatObj.push(tmpObj);
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
			               	d_addMatObj.push(tmpObj);
		               	}
		                	
		                	$("#grid_fault_list").jqGrid('clearGridData');
		                	$("#grid_fault_list").jqGrid('addRow',{position  :"last", initdata  : d_addMatObj, cellEdit:true});
	                	}
				}	
				}]

				 }},  //editoptions 종료, 칼럼정의 종료
			{name:'sernp',index:'sernp', width:80, sorttype:'text', hidden:true},
			{name:'f_sernp',index:'f_sernp', width:100, sorttype:'text', hidden:false, formatter : jqgridHighlightFormattersernpYn},
			{name:'sernr',index:'sernr', width:100, sorttype:'text', hidden:false, editable:true},
			{name:'rfc_chk',index:'rfc_chk', width:50, sorttype:'text', hidden:true},
			{name:'org_remark',index:'org_remark', width:90, sorttype:'text', hidden:false, editable:true},
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
	    height: 280,
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
				if(selected == '4') {
					var selGridData = $("#grid_fault_list").getRowData(rowid);
					if(selGridData.lgort.length != 0) {
						return;
					}
					if(selGridData.kzumw =='Y') {
						$("#grade_loc_matnr").val(selGridData.matnr);

		    			if($("#grid_sapord").getRowData($("#grid_sapord").getGridParam('selrow')).routing_gno_gubun == 'Y')
	    					getStrList('mst04');
	    				else
	    					getStrList('mst03');
						$("#grade_loc_add").modal('show');
					}
				}	
			}
		},
		beforeEditCell: function (rowid, cellname, value, iRow, iCol){
	    	var selGridData = $("#grid_fault_list").getRowData($('#grid_fault_list').jqGrid('getGridParam','selrow'));

	    	if(cellname == 'sernr' && selGridData.sernp != 'V001') {
				console.log("시리얼비대상!!");
				$('#grid_fault_list').jqGrid('setCell', rowid, 'sernr', '');
				fnMessageModalAlert("오류", "시리얼대상이 아닙니다.");
	    	} else {
				console.log("시리얼대상!!");
	    	}
	    	
// 	    	if(selGridData.gubun == 'addItnbr' && selGridData.sernp == 'V001' && cellname == 'menge' ) {
//         		fnMessageModalAlert("오류", "시리얼 대상 투입자재는 수량변경이 불가능합니다.");  
//         		$('#grid_fault_list').jqGrid('setCell', rowid, 'menge', '1.000');	      
//         	}
	   	},
	    afterEditCell: function (rowid, cellname, value, iRow, iCol) {
	    	var selGridData = $("#grid_fault_list").getRowData($('#grid_fault_list').jqGrid('getGridParam','selrow'));

	    	if(cellname == 'sernr' && selGridData.sernp != 'V001') {
				$('#grid_fault_list').jqGrid('setCell', rowid, 'sernr', ' ');	
	    	}
	    	
// 	    	if(selGridData.gubun == 'addItnbr' && selGridData.sernp == 'V001' && cellname == 'menge' ) {
//         		$('#grid_fault_list').jqGrid('setCell', rowid, 'menge', '1.000');	                		
//         	}
	    	
         	var p_val = value;
	    	var n_val = "";
	    	
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
// 			console.log("grid_fault_list grid data!!!!!!");
// 			console.log(data);
		}
	});
}

function popUpDetailSerial() {
// 	console.log('popUpDetailSerial()');
	
	$("#btn_detail_serial_save").removeAttr('disabled');
	
// 	faultMatrArr.splice(0,faultMatrArr.length);
	faultMatrArr = [];
	
	addItnbrArr	 = [];
	itnbrArr  = [];
	matArr = [];
	
	
	var rowData = $("#grid_sapord").getRowData(selected_pordno);
	
	if (selected_routing_no == '') {
		fnMessageModalAlert("Notification(MES)", "선택된 생산지시오더 없습니다.");
		return;
	}

	$('#grid_itnbrlist').jqGrid('clearGridData');
	$("#grid_addItnbr_list").jqGrid('clearGridData');
	
	//	initItnbrGrid();
// 	materialSearch();
	var addItnbr_data = reloadNewItnbrGrid();
	
	$("#gubun").val(searchMatCode);		

	if( searchMatCode=='basic' ){
		var page_url = "/sap_master/ziffm_mes_pp004"
			 + "?func_name=" + encodeURIComponent("ZIFFM_MES_PP004")
			 + "&IV_AUFNR=" + encodeURIComponent(selected_pordno)
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
	}else{	// mat
		var page_url = '/frontend/hub/material_recv_master_select';
		$("#grid_materiallist").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
		$("#grid_materiallist").trigger("reloadGrid");
		$("#dv_grid_itnbrlist").hide();
		$("#dv_grid_materiallist").show();
		$("#matSearch").show();
	}

	$("#m_dsa_mes_po").val(selected_pordno_pop);
	$("#m_dsa_routing_no").val(selected_routing_no);
	var masGridRowData = $("#grid_sapord").getRowData($("#grid_sapord").getGridParam('selrow'));
	$("#m_dsa_project_no").val(masGridRowData.project_no);
	$("#m_dept_cd").val(masGridRowData.dept_cd);
	$("#m_dsa_routing_gno").val(masGridRowData.routing_gno);
	
	
	
	$("#modal_detail_serial_add").modal('show');
}

function changeMatGubun() {

	$("#grid_materiallist").jqGrid('clearGridData');
	$("#grid_itnbrlist").jqGrid('clearGridData');
	if( $("#gubun").val()=='basic' ){
		var page_url = "/sap_master/ziffm_mes_pp004"
			 + "?func_name=" + encodeURIComponent("ZIFFM_MES_PP004")
			 + "&IV_AUFNR=" + encodeURIComponent(selected_pordno)
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
// 			 + '?wrkst=' + encodeURIComponent($('#itnbr_search_popup').val());
			 + '?werks=' + encodeURIComponent(selected_dept_cd);
		$("#grid_materiallist").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
		$("#grid_materiallist").trigger("reloadGrid");
		$("#dv_grid_itnbrlist").hide();
		$("#dv_grid_materiallist").show();
		$("#matSearch").show();
	}
}


function fnWorkChnStat_validation(flag) {
	
	var sapOrdData = $("#grid_sapord").getRowData($('#grid_sapord').jqGrid('getGridParam','selrow'));
	var popOrdData = $("#grid_popord").getRowData($('#grid_popord').jqGrid('getGridParam','selrow'));
	
	if (selected_routing_no == '') {
		fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더 없습니다.");
		return;
	}
	

	var project_no_yn = "Y";
	var add_itnbr_yn = "Y";
	
// 	if(ordPdstsChk() == false ) return;
	
	
	var pEndChk = prodEndChk(popOrdData.routing_no);	//생산실적전송라우팅인지 확인..
		
	if( flag == 'end' ) {	
		if( pEndChk ) {			
			if(popOrdData.project_no==null || popOrdData.project_no==undefined || popOrdData.project_no=='') {
				project_no_yn = "N";
			} 
			if ( !chkAddItnbrExist(popOrdData.pordno_pop) ) {
				add_itnbr_yn = "N";
			} 
		}
	}

	
	var text = '';
	
	if(sapOrdData.sernp == "V001" && project_no_yn == "N") {
		fnMessageModalAlert("Notification(MES)", "해당 오더는 대표시리얼 등록이 반드시 필요한 오더입니다.<br>대표시리얼 등록 후 다시 진행해주세요.");
		return;
	}
	
	if(project_no_yn == "N") {
		text += " * 대표시리얼이 입력되지 않은 오더가 있습니다.<br>";
	}
	
	if(add_itnbr_yn == "N") {
		text += " * 자재투입이 되지 않은 오더가 있습니다.<br>";
	}
	 			
		
	fnMessageModalConfirm("Notification(MES)", text + "계속 진행 하시겠습니까?", function(result){
		if(result) {
			fnWorkChnStat(flag);
		}
	});
}



// 시작, 비가동 시작 종료, 작업 종료 공통 상태 변경
function fnWorkChnStat(flag) {
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
		async : false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				
				fnMessageModalAlert("Notification(ProdConfirm)", data.rtn_msg);
				
				if(data.status_change_yn == 'N') {
					console.log("데이터 변동 없음..")
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
				
// 				fnMessageModalAlert("Notification(ProdConfirm)", data.rtn_msg);
				fnSearchDetailCodeGrid(selected_pordno);
			} else {
				fnMessageModalAlert("Notification(ProdConfirm)", fail_msg);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(ProdConfirm)", fail_msg);
		},
		complete : function() {
			$("#grade_mng").modal('hide');	
			fnSearchHisGrid(selected_pordno_pop, selected_routing_no);
			fnSearchMasterCodeGrid();
			selected_pordno_pop = "";
			selected_routing_no = "";
		}
	});
	
	
}

function workStatusChk() {
// 	console.log('workStatusChk()');
	var gridData = $("#grid_hisord").jqGrid('getRowData');
	var popordData = $("#grid_popord").jqGrid('getRowData');
	var beforeIdx = (gridPopordSelect_idx>1)?(gridPopordSelect_idx-1):gridPopordSelect_idx;
// 	var beforeStat = $($('#grid_popord tr:eq('+beforeIdx+')').children()[7])[0].innerText;
	if( popordData.length>0 ) {
		var beforeStat = popordData[beforeIdx-1].pdsts_nm;
		if( gridPopordSelect_idx==1 || beforeStat=="종료" ) {
			$("#btn_work_start").css("visibility","visible");
			$("#btn_work_pause_start").css("visibility","visible");
			$("#btn_work_pause_end").css("visibility","visible");
			$("#btn_work_end").css("visibility","visible");
			if ($('#grid_popord').jqGrid('getRowData').length == 0) {
			} else if (gridData.length == 0) {
				//작업시작
				$("#btn_work_pause_start").css("visibility","hidden");
				$("#btn_work_pause_end").css("visibility","hidden");
				$("#btn_work_end").css("visibility","hidden");
			} else if (gridData[gridData.length - 1].start_dt_tm != "") {
				//비가동시작, 작업종료
				$("#btn_work_start").css("visibility","hidden");
				$("#btn_work_pause_end").css("visibility","hidden");
			} else if (gridData[gridData.length - 1].pause_start_dt_tm != "") {
				//비가동종료			
				$("#btn_work_start").css("visibility","hidden");
				$("#btn_work_pause_start").css("visibility","hidden");
				$("#btn_work_end").css("visibility","hidden");
			} else if (gridData[gridData.length - 1].pause_end_dt_tm != "") {
				//비가동시작, 작업종료			
				$("#btn_work_start").css("visibility","hidden");
				$("#btn_work_pause_end").css("visibility","hidden");
			} else if (gridData[gridData.length - 1].end_dt_tm != "") {
				//작업끝!!!! 다 가림
				$("#btn_work_start").css("visibility","hidden");
				$("#btn_work_pause_start").css("visibility","hidden");
				$("#btn_work_pause_end").css("visibility","hidden");
				$("#btn_work_end").css("visibility","hidden");
			}
		} else {
			$("#btn_work_start").css("visibility","hidden");
			$("#btn_work_pause_start").css("visibility","hidden");
			$("#btn_work_pause_end").css("visibility","hidden");
			$("#btn_work_end").css("visibility","hidden");
		}
		
		/////////////////재작업 확정 상태일 때
// 		if($("#grid_hisord").getRowData().length != 0) {
// 			var sel_pop_pdsts = $("#grid_popord").getRowData($("#grid_popord").getGridParam('selrow')).pdsts;
// 			var popord_data = $("#grid_popord").getRowData($("#grid_popord").getGridParam('selrow'));
// 			if(gridData[gridData.length - 1].end_dt_tm != "" && sel_pop_pdsts == 'p2') {
// 				$("#btn_work_start").css("visibility","visible");
// 			}
// 		}

		if($("#grid_hisord").getRowData().length != 0) {
			var sel_pop_pdsts = $("#grid_popord").getRowData($("#grid_popord").getGridParam('selrow')).pdsts;
			var popord_data = $("#grid_popord").getRowData($("#grid_popord").getGridParam('selrow'));
			if(gridData[gridData.length - 1].end_dt_tm != "" && sel_pop_pdsts == 'p2' && popordData[beforeIdx-1].pdsts_nm == "종료") {
				$("#btn_work_start").css("visibility","visible");
			}
			if(gridPopordSelect_idx == 1 && sel_pop_pdsts == 'p2') {
				$("#btn_work_start").css("visibility","visible");	
			}
		}
		
		/////////////////CS 재작업 오더일 때, T1 공정 상태일때
		var sel_pop_r_code = $("#grid_popord").getRowData($("#grid_popord").getGridParam('selrow')).routing_code;
		
		if(sel_pop_r_code == 'T1') {
			$("#btn_work_start").css("visibility","hidden");
			$("#btn_work_pause_start").css("visibility","hidden");
			$("#btn_work_pause_end").css("visibility","hidden");
			$("#btn_work_end").css("visibility","hidden");
			
		}
	}
}


function fnSaveMainSerial() {
	var postData = $("#frm_main_serial").serializeArray();
	var selData = $("#grid_sapord").jqGrid('getRowData', selected_pordno);
	var selDataArr = [];
	selDataArr.push(selData);
	selData.project_no = $("#m_serial_no").val();
	var page_url = "/frontend/prod/main_serial_add";
	
	var postData = "pordno=" +  encodeURIComponent(selected_pordno)
				 + "&project_no=" +  encodeURIComponent($("#m_serial_no").val())
				 + "&fedat=" +  encodeURIComponent(selData.fedat)
				 + "&sedat=" +  encodeURIComponent(selData.sedat)
				 + "&params=" +  encodeURIComponent(JSON.stringify(selDataArr));
	
// 	var duCnt = chkSerialNoDuplicate($("#m_serial_no").val());
// 	if( duCnt>0 ) {
// 		fnMessageModalAlert("Notification(fnSaveMainSerial)", "시리얼번호가 중복된 값이 입력되었습니다.");
// 		return false;
// 	}
	
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async:false,
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
			fnSearchMasterCodeGrid();
			$("#modal_main_serial_add").modal('hide');
		}
	});
}

function chkSerialNoDuplicate(sernrNo) {
	var returnVal = 0;
	
	if(sernrNo.length != 0) {
		var page_url = "/frontend/prod/chkSerialNoDuplicate";
		var postData = "sernr=" + encodeURIComponent(sernrNo);
		
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
	}
	return returnVal;
}

function fnSaveDetailSerial() {
// 	console.log('fnSaveDetailSerial()');
	
	$("#btn_detail_serial_save").attr('disabled', 'disabled');
	var rfcData = $("#grid_addItnbr_list").jqGrid('getRowData');

	for(var i=0 ; i<rfcData.length; i++) {
		if(rfcData[i].lgort.length == 0) {
			fnMessageModalAlert("Notification(MES)", "투입 요청 자재의 저장위치를 설정해주세요.");
			$("#btn_detail_serial_save").attr("disabled",false);
			return;
		}
		
		if(rfcData[i].sernr.length == 0 && rfcData[i].sernp == 'V001') {
			fnMessageModalAlert("Notification(MES)", "시리얼 대상 투입 요청 자재의 시리얼을 입력해주세요.");
			$("#btn_detail_serial_save").attr("disabled",false);
			return;
		} 
	}	
	
	var first_routing_no = $("#grid_popord").getRowData()[0].routing_no;
	var frmData = $("#frm_detail_serial").serializeArray();
	var masGridRowData = $("#grid_sapord").getRowData($("#grid_sapord").getGridParam('selrow'));
	var page_url = "/frontend/prod/detail_serial_add_opt";
	var postData = "pordno_pop=" + encodeURIComponent(selected_pordno_pop)
// 				 + "&routing_no=" + encodeURIComponent(selected_routing_no)
				 + "&routing_no=" + encodeURIComponent(first_routing_no)
				 + "&routing_gno=" + encodeURIComponent($("#m_dsa_routing_gno").val())
				 + "&project_no=" + encodeURIComponent($("#m_dsa_project_no").val()) //메인 시리얼번호
				 + "&dept_cd=" + encodeURIComponent(masGridRowData.dept_cd)
				 + "&lgort=" + encodeURIComponent(selected_lgort)	// ?
				 //+ "&dept_cd=" + encodeURIComponent(selected_dept_cd)	// ?
				 + "&pordno=" + encodeURIComponent(selected_pordno_pop.substr(0,10))
				 + "&params=" + encodeURIComponent(JSON.stringify(rfcData));
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async:false,
		success : function(data, textStatus, jqXHR) {
			if (data.zifsta == "S") {
				fnMessageModalAlert("Notification(SerialAdd)", "선택된 생산지시오더의 자재투입처리를 성공했습니다.<br>"+"SAP return : " + data.zifsta	+"<br>SAP msg : " + data.zifmsg);
			} else {
				fnMessageModalAlert("Notification(SerialAdd)", "선택된 생산지시오더의 자재투입처리를 실패했습니다.<br>"+"SAP return : " + data.zifsta	+"<br>SAP msg : " + data.zifmsg);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(SerialAdd)", "선택된 생산지시오더의 자재투입처리를 실패했습니다.");
		},
		loadComplete : function(data) {},
		complete : function() {
			fnSearchDetailCodeGrid(masGridRowData.pordno);
			$("#modal_detail_serial_add").modal('hide');
		}
	});

}

//modal : employee list generate
function fnLoadWorkerAddGrid() {
	console.log('fnLoadWorkerAddGrid()');
// 	var pordno_pop;
	var masGridRowData = $("#grid_sapord").getRowData($("#grid_sapord").getGridParam('selrow'));
	var page_url = "/frontend/prod/worker_select_1110"  
	               +"?dept_cd=" + encodeURIComponent(masGridRowData.dept_cd);
	 
	$("#grid_worker").jqGrid({
		url : page_url,
		datatype: 'json',
		colNames : [ '','사원번호', 'ID','사원명','구분' ],
		colModel : [ 
			{name : 'chk', index : 'chk', width : 30, editable : true, align : 'center', edittype : 'checkbox',
				multiselect : false,
				editoptions : { value : "Y:N", defaultValue : "false"},
				formatter : "checkbox",
				formatoptions : { disabled : false}}, 
			{name : 'member_emp_no', index : 'member_emp_no', width : 90, sorttype : "text", sortable : true}, 
			{name : 'member_id', index : 'member_id', width : 90, sorttype : "text", sortable : true}, 
			{name : 'member_nm', index : 'member_nm', width : 100, sorttype : "text", sortable : true}, 
			{name : 'dept_cd', index : 'dept_cd', width : 50, sorttype : "text", sortable : true} ],
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

// modal : search employee list
function fnSearchWorkerAddGrid() {
// 	console.log('fnSearchWorkerAddGrid()');
	var masGridRowData = $("#grid_sapord").getRowData($("#grid_sapord").getGridParam('selrow'));
	var page_url = "/frontend/prod/worker_select_1110"  
		 		 +"?dept_cd=" + encodeURIComponent(masGridRowData.dept_cd);
	
  	$("#grid_worker").jqGrid('setGridParam', { url : page_url, datatype : 'json' });
	$("#grid_worker").trigger("reloadGrid");
}

// btn action 작업시작 버튼
function fnWorkerAdd() {

	var gridData = $('#grid_worker').jqGrid('getRowData');
	
	for (var i = 0; i < gridData.length; i++) {
		if (gridData[i].chk == 'Y') {
			if(member_emp_no == gridData[i].member_emp_no) {
				fnMessageModalAlert("Notification(작업시작)", "선택하신 작업자(" + gridData[i].member_nm + ")는 기본 작업자입니다.<br>사원정보에서 해당 작업자를 선택을 해제해주세요.");
				return;
			}
		}
	}
	var fwa_member_emp_no = member_emp_no + ',';
	var fwa_member_nm= member_nm + ',';
	
	var member_cnt = 1; 
	
	//SELECT ROW ->> $('#grid_worker').jqGrid('getGridParam',"selrow")
	

	for (var i = 0; i < gridData.length; i++) {
		if (gridData[i].chk == 'Y') {
			fwa_member_emp_no = fwa_member_emp_no + gridData[i].member_emp_no + ',';
			fwa_member_nm= fwa_member_nm + gridData[i].member_nm + ',';
			member_cnt++;
		}
	}
	
	fwa_member_emp_no = fwa_member_emp_no.substring(0, fwa_member_emp_no.length-1);
	fwa_member_nm = fwa_member_nm.substring(0, fwa_member_nm.length-1);

	var postData = $("#frm_worker_add").serializeArray();
	var page_url = "/frontend/prod/worker_update";
	var postData = "pordno_pop=" + encodeURIComponent($("#m_worker_mes_po").val());
		postData += "&routing_no=" + encodeURIComponent($("#m_routing_no").val());
		postData += "&member_emp_no=" + encodeURIComponent(fwa_member_emp_no);
		postData += "&member_nm=" + encodeURIComponent(fwa_member_nm);
		postData += "&member_cnt=" + encodeURIComponent(member_cnt);
// 		postData += "&jocod=" + encodeURIComponent($(':radio[name="rdo_work_line"]:checked').val());
	
	if(fwa_member_emp_no =='' || fwa_member_nm =='') {
		fnMessageModalAlert("Notification(작업시작)", "작업자를 선택해주세요.");
		return;
	} else {
		// 작업자 등록
		$.ajax({
			url : page_url,
			data : postData,
			type : "POST",
			async:false,
			success : function(data, textStatus, jqXHR) {
				if (data.status == "200") {
					if ( data.returnMsg=='Already registered' ){
// 						fnMessageModalAlert("Notification(fnWorkerAdd)", "이미 등록된 작업자가 존재합니다.");
// 						fnMessageModalAlert("Notification(fnWorkerAdd)", "재작업 공정입니다. 대상 작업은 이전 작업자명으로 계속해 진행됩니다.");
						fnWorkChnStat('start');
					} else {
// 						fnWorkStart(selected_pordno_pop,selected_routing_no);
						fnWorkChnStat('start');
					}
				} else {
					fnMessageModalAlert("Notification(fnWorkerAdd)", "작업자 등록에 실패했습니다.");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("Notification(fnWorkerAdd)", "작업자 등록에 실패했습니다.");
			},
			complete : function() {
// 				selected_pordno_pop = "";
// 				selected_routing_no = "";
				
				fwa_member_emp_no = '';
				fwa_member_nm= '';
								
				$("#modal_worker_add").modal('hide');
			}
		});
	}
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

function LMainsernr_enter(text){
	if(text.value.length > 6) {
		
	    if(text.value.length > 30 && Left(text.value,2) == 01  ){
	    	 
	    	$('#s_project_no').val(Right(text.value,9));
	    	}
	    
	    selected_pordno='';
		fnSearchMasterCodeGrid();
	   
	} else {
		fnMessageModalAlert("Notification(MES)", "바코드 길이는 7자리 이상이어야 합니다.<br/>입력값 : " + $('#s_project_no').val());
		$('#s_project_no').val("");
    } 
}

	 
function Mainsernr_enter(text){
	if(text.value.length > 6) {
		
	    if(text.value.length > 30 && Left(text.value,2) == 01  ){
	    	 
	    	$('#m_serial_no').val(Right(text.value,9));
	    	}
	   
	} else {
		fnMessageModalAlert("Notification(MES)", "바코드 길이는 7자리 이상이어야 합니다.<br/>입력값 : " + $('#m_serial_no').val());
		$('#m_serial_no').val("");
    } 
}

function sernr_enter(text){
	$('#fsa_project_no').val("");
	if(text.value.length > 6) {
		
	    if(text.value.length > 30 && Left(text.value,2) == 01  ){
	    	 
	    	$('#fsa_project_no').val(Right(text.value,9));
	    	}
	    
		sernrInputMng();
		$("#btnArea").show();
	} else {
		fnMessageModalAlert("Notification(MES)", "바코드 길이는 7자리 이상이어야 합니다.<br/>입력값 : " + $('#fsa_project_no').val());
		$('#fsa_project_no').val("");
    } 
}


function checkBarcode(text){
	 
 
	if(text.value.length > 6) {
		$("#btnArea").show();
	} else {
// 		$("#btnArea").hide();
    } 
}

//itnbr move to newlist
function addItnbrDetail() {
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

// remove new itnbr list
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

/*
// search itnbr list
function searchItnbrpopup(){
	var page_url = '/frontend/hub/routing_itnbr_select'
				 + '?itnbr_nm=' + encodeURIComponent($('#itnbr_search_popup').val());
	$("#grid_itnbrlist").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_itnbrlist").trigger("reloadGrid");
}
*/

function saveRoutingDetail() {
	var groupInfo = $("#grid_mas").getRowData($("#grid_mas").getGridParam('selrow'));
	var gridDataArr = $('#grid_addItnbr_list').jqGrid('getRowData');
	var keyArr = $('#grid_addItnbr_list').jqGrid('getDataIDs');
	if( gridDataArr.length==0 ) {
	} else {
		var jsonStr = JSON.stringify(gridDataArr);
		var page_url = "/frontend/hub/routing_detail_insert"
		var postData = 'routing_gno=' + encodeURIComponent(groupInfo.routing_gno)
					 + '&gridData=' + encodeURIComponent(jsonStr);
		$.ajax({
		    url: page_url,
		    data: postData,
		    type: "POST",
		    async:false,
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
		    		fnMessageModalConfirm("Notification(Hub)", "정보를 저장하였습니다.", function(chk){
		    			if(chk){
							searchRoutingDetail(groupInfo.routing_gno);
		    				$('.close').click();
		    			}
		    		});
		    	} else {
		    		fnMessageModalAlert("Notification(Hub)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(Hub)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    }
		});
	}
}

function sernrInputMng() {
	console.log('sernrInputMng()');
	
	var gridRowData = $("#grid_addItnbr_list").getRowData($("#grid_addItnbr_list").getGridParam('selrow'));
	var sernr = $('#fsa_project_no').val();
	
	if( gridRowData.sernp == 'V001' && sernr.length < 7 ) {
		fnMessageModalAlert("Notification(fnSaveMainSerial)", "시리얼번호가 7자리 이하입니다.<br/>다시 입력해주세요.");
		return;
	}
	
	
	// duplicate check
// 	console.log(gridRowData);
// 	var duCnt = chkSerialNoDuplicate(sernr);
// 	if( duCnt>0 ) {
// 		fnMessageModalAlert("Notification(fnSaveMainSerial)", "시리얼번호가 중복된 값이 입력되었습니다.");
// 		return false;
// 	}
	
	if(sernr.length != 0)
		gridRowData.sernr = sernr;
	
	var masGridRowData = $("#grid_sapord").getRowData($("#grid_sapord").getGridParam('selrow'));
	var addItnbrGridRowData = $("#grid_addItnbr_list").getRowData($("#grid_addItnbr_list").getGridParam('selrow'));
	
	var loc = sernr_stock_chk(masGridRowData.dept_cd, addItnbrGridRowData.matnr, sernr);
	
	
// 	console.log($('#fsa_loc').val());
// 	if($('#fsa_loc').val().length != 0) {
// 		gridRowData.lgort = $('#fsa_loc').val();
		
// 	} else {
		
// 	}
	
	console.log(loc);
	console.log(loc.length);
	if(addItnbrGridRowData.kzumw == 'Y') {
		if(loc.length == 0 && Number($('#fsa_bdmng').val()) > 0) {
			fnMessageModalAlert("Notification(MES)",	"입력하신 시리얼은 등급창고에 재고가 없어 투입이 불가합니다.<br>확인해주세요.");
			return;
		} 
		
		if(Number($('#fsa_bdmng').val()) < 0) {
			gridRowData.lgort = selectPoLgort();
		} else {
			gridRowData.lgort = loc;	
		}
		
	} else {
		gridRowData.lgort = addItnbrGridRowData.lgort;
	}
	
	
	if($('#fsa_bdmng').val().length != 0)
		gridRowData.bdmng = $('#fsa_bdmng').val();
	
	$("#grid_addItnbr_list").setRowData($("#grid_addItnbr_list").getGridParam('selrow'), gridRowData, {});
	$("#scanner_serial_add").modal('hide');
}

function toSapProdIn() {
	console.log('toSapProdIn()');
	
	var page_url = "/sap_master/ziffm_mes_pp008";			
	var postData = "funcName=" + encodeURIComponent("ZIFFM_MES_PP008");	
	postData +=	'&pordno=' + encodeURIComponent(selected_pordno);
	postData +=	'&pordno_pop=' + encodeURIComponent(selected_pordno_pop);
	postData +=	'&routing_no=' + encodeURIComponent(selected_routing_no);

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

function toSapProdData() {
	console.log('toSapProdData()');	
	var page_url = "/sap_master/ziffm_mes_pp006";			
	var postData = "funcName=" + encodeURIComponent("ZIFFM_MES_PP006");	
	postData +=	'&pordno=' + encodeURIComponent(selected_pordno);
	postData +=	'&pordno_pop=' + encodeURIComponent(selected_pordno_pop);
	postData +=	'&routing_no=' + encodeURIComponent(selected_routing_no);
	postData +=	'&dept_cd=' + encodeURIComponent(selected_dept_cd);
	postData +=	'&wkctr=' + encodeURIComponent(selected_wkctr);

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

function toMesLastInspec() {
	var t1_routing_no = '';
		
// 	var gridRowData = $("#grid_popord").getRowData($("#grid_popord").getGridParam('selrow'));
	var setKey = $("#grid_popord").getGridParam('selrow')
	var rowdata = $("#grid_popord").getRowData();
	
	for(var i=0 ; i<rowdata.length; i++) {
		if(rowdata[i].routing_no == setKey) {
			t1_routing_no = rowdata[i+1].routing_no;
			console.log(rowdata[i+1].routing_code);
		}		
	}

	console.log(t1_routing_no)
	
	
	var page_url = "/frontend/prod/lastInspec_insert";			
	var postData = 'pordno=' + encodeURIComponent(selected_pordno);
	postData += '&routing_no=' + encodeURIComponent(t1_routing_no);

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

var addItnbrArr = [];
var itnbrArr = [];
var matArr = [];

var addItnbrData;
var ItnbrData;
function fnFaultMatnrConf() {
	console.log('fnFaultMatnrConf()');

	$('.h_flag').show();
	gnrFaultMantrFlag = 's';
	$("#btn_fault_conf").removeAttr('disabled');
	
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
	
	// 1. po번호의 wkctr값에 해당하는 from창고 번호를 가져온다.
	var fromLgort = getFromLgort();
	var itnbr_data;
	var page_url = '/frontend/hub/material_recv_master_select_nopage'	
				 + "?matnrs=" + encodeURIComponent(String(uniqMatnrArr))
				 +"&werks=" + encodeURIComponent(selected_dept_cd);
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
				tmpObj.aufnr = selected_pordno;
				tmpObj.werks = selected_dept_cd;
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
				
				tmpObj.aufnr = selected_pordno;
				tmpObj.werks = selected_dept_cd;
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
				
				tmpObj.aufnr = selected_pordno;
				tmpObj.werks = selected_dept_cd;
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

	
	
	$("#fault_mng").modal('show');
}
/*
function gridCheckBox(cellvalue, options, rowObject) {
 	var chk = "<input type='checkbox' name='chk' onclick='makeFaultMatnrArr(this);'/>";
    return chk; 
}
*/

function faultRoutingProc() {
// 	console.log('pordFaultProc()');
	var rowData = $("#grid_sapord").getRowData(selected_pordno);
	$("#grid_fault_routing_list").jqGrid('clearGridData');
	var itnbr_rows;	
	var itnbr = rowData.itnbr;
	var pdqty = rowData.pdqty;
	var lgort = rowData.lgort;
	var project_no = rowData.project_no;
	
	
	if(itnbr.length !=0) {
		var page_url = '/frontend/hub/material_recv_master_select_nopage'	
					 + "?matnr=" + encodeURIComponent(itnbr)
					 +"&werks=" + encodeURIComponent(selected_dept_cd);
		
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
		tmpObj.aufnr = selected_pordno;
		tmpObj.werks = selected_dept_cd;
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
		tmpObj.aufnr = selected_pordno;
		tmpObj.werks = selected_dept_cd;
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


function fnFaultConf() {
	
	$("#btn_fault_conf").attr('disabled', 'disabled');
	
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
			$("#btn_fault_conf").removeAttr('disabled');
	 		return;
		}
		if(gridDataArr[i].sernp == 'V001' && gridDataArr[i].sernr.length == 0) {
			fnMessageModalAlert("Notification(MES)", "자재불량내역의 시리얼대상 항목에 시리얼 입력내역이 없습니다.<br/>해당 셀을 클릭해 시리얼을 입력해주세요.");
			$("#btn_fault_conf").removeAttr('disabled');
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
			postData += '&dept_cd=' + encodeURIComponent($("#s_plant").val());
			postData += '&t_gubun=' + encodeURIComponent("tp");
		} else {
			postData = 'jsonStr=' + encodeURIComponent(jsonStr);
			postData += '&pordno_pop=' + encodeURIComponent(selected_pordno_pop);
			postData += '&routing_no=' + encodeURIComponent(selected_routing_no);
			postData += '&dept_cd=' + encodeURIComponent(selected_dept_cd);
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
		    complete: function() {
			
		    }
		});
		
		
// 		$("#modal_detail_serial_add").modal('hide');
// 		$("#grid_req_sernr").modal('hide');
// 		$("#fault_mng").modal('hide');
		
		
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

	var page_url = "/frontend/prod/fnProdFaultConf";
	var postData = 'jsonStr=' + encodeURIComponent(jsonStr);
		postData += '&pordno_pop=' + encodeURIComponent($("#m_dsa_mes_po").val());
		postData += '&routing_no=' + encodeURIComponent($("#m_dsa_routing_no").val());
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
		
	selected_pordno='';
	fnSearchMasterCodeGrid();
	/********************* 데이터 insert 및 rfc 전송 : End*********************/
}


function fnProdFaultConf() {
	
	$("#btn_prod_fault_conf").attr('disabled', 'disabled');
	
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
				fnSearchMasterCodeGrid();
		    
		    }
		});
		
		
		$("#modal_detail_serial_add").modal('hide');
		$("#grid_req_sernr").modal('hide');
		$("#fault_mng").modal('hide');
		$("#Pord_fault_mng").modal('hide');
		
		
		/********************* 데이터 insert 및 rfc 전송 : End*********************/
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

function pordFaultProc() {
	console.log('pordFaultProc()');

	$("#btn_prod_fault_conf").removeAttr('disabled');
	
	$("#grid_prod_fault_list").jqGrid('clearGridData');

	var itnbr_rows;
	var arrObj = [];
	var rowData = $("#grid_sapord").getRowData(selected_pordno);
	var itnbr = rowData.itnbr;
	var pdqty = rowData.pdqty;
	var lgort = rowData.lgort;
	var project_no = rowData.project_no;
	
	if(itnbr.length !=0) {
		var page_url = '/frontend/hub/material_recv_master_select_nopage'	
			 + "?matnr=" + encodeURIComponent(itnbr)
			 +"&werks=" + encodeURIComponent(selected_dept_cd);
	
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
			tmpObj.aufnr = selected_pordno;
			tmpObj.werks = selected_dept_cd;
	
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
		tmpObj.aufnr = selected_pordno;
		tmpObj.werks = selected_dept_cd;
		tmpObj.matnr = itnbr;
		tmpObj.maktx = '';	
		tmpObj.wrkst = '';
		tmpObj.meins = '';
		tmpObj.lgort = lgort;
		tmpObj.menge = pdqty;
		tmpObj.sernr = project_no;
		$('#grid_prod_fault_list').addRowData( 0, tmpObj, 'last');
	}

	console.log(arrObj);
	
	initOptions($('#p_sel_step1'));
	initOptions($('#p_sel_step2'));
	initOptions($('#p_sel_step3'));
	initOptions($('#p_sel_step4'));
	p_makeSelStep1();
	$("#Pord_fault_mng").modal('show');
}

function input_prod_fault_code() {
// 	var s_id = $('#grid_prod_fault_list').jqGrid('getGridParam', 'selrow');
	
// 	console.log("s_id :: " + s_id);
	
	var sel_step1 = $("#p_sel_step1").val();
	var sel_step2 = $("#p_sel_step2").val();
	var sel_step3 = $("#p_sel_step3").val();
	var sel_step4 = $("#p_sel_step4").val();
	
	var sel_step1_t = $("#p_sel_step1 option:selected").text();
	var sel_step2_t = $("#p_sel_step2 option:selected").text();
	var sel_step3_t = $("#p_sel_step3 option:selected").text();
	var sel_step4_t = $("#p_sel_step4 option:selected").text();
	
// 	if(s_id == null) {
// 		fnMessageModalAlert("Notification(MES)", "불량코드가 입력 될 자재불량내역을 선택해 주세요.");
// 		return;
// 	}
	
	if(sel_step4_t == '' || sel_step4_t == '-') {
		fnMessageModalAlert("Notification(MES)", "lv.03 까지 불량내역을 지정해주세요.");
		return;
	}
	
	$('#grid_prod_fault_list').jqGrid('setCell', 0, 'org_issue_memo', sel_step4_t);
	
	$('#grid_prod_fault_list').jqGrid('setCell', 0, 'org_issue_code', sel_step4);
}

function confirm_reWork() {
	fnMessageModalConfirm("Notification(MES)", "재작업을 수행하시겠습니까?", function(chk){
		if(chk){
// 			reWork();
			workProc();
		}
	});	
}

// function reWork() {
// 	var rw_rowid = $("#grid_popord").jqGrid('getGridParam', 'selarrrow');
// 	var rw_rowData = $("#grid_popord").getRowData(rw_rowid);

// 	var getProdStatus_result;
	
// 	var page_url = "/frontend/prod/getProdStatus";
// 	var postData = "pordno_pop=" +  encodeURIComponent(rw_rowData.pordno_pop);
// 	postData += "&routing_no=" +  encodeURIComponent(rw_rowData.routing_no);
	 
// 	$.ajax({
// 		url : page_url,
// 		data : postData,
// 		async:false,
// 		type : "POST",
// 		success : function(data, textStatus, jqXHR) {
// 			if (data.status == "200") {
// 				getProdStatus_result = data.result;
// 			} else {
// 				fnMessageModalAlert("Fail", "선택 오더의 현재 작업 상태를 가져오지 못했습니다.");
// 			}
// 		},
// 		error : function(jqXHR, textStatus, errorThrown) {
// 			fnMessageModalAlert("Fail", "선택 오더의 현재 작업 상태를 가져오지 못했습니다.");
// 		}
// 	});	
	
// 	console.log("현재 작업 상태 :: " + getProdStatus_result);
	
// 	workProc(getProdStatus_result);
// }

function workProc() {
	/*
	p5 : 비가동 종료처리( = 재가동)
	p6 : 작업종료
	p7 : 재작업지시
	*/
		var sapOrdDataKey = '';
		var page_url = '/frontend/prod/reWorkProc';
		var postData = 'pordno_pop=' + encodeURIComponent(selected_pordno_pop)
					 + '&routing_no=' + encodeURIComponent(selected_routing_no);
		
		$.ajax({
			url : page_url,
			data : postData,
			async : false,
			type : "POST",
			success : function(data, textStatus, jqXHR) {
				if (data.status == "200") {
					fnSearchDetailCodeGrid(selected_pordno);
				} else {
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("Notification(ProdConfirm)", pdsts + " 처리 중에 오류가 발생했습니다.");
			},
			complete : function() {
				fnSearchHisGrid(selected_pordno_pop, selected_routing_no);
				
// 				sapOrdDataKey = $('#grid_sapord').jqGrid('getGridParam','selrow');
				
				fnSearchMasterCodeGrid();

				
// 				selected_pordno_pop = "";
// 				selected_routing_no = "";
			}
		});	
		
		console.log("selected_pordno :: " + selected_pordno);
		setTimeout(function(){
			$('#grid_sapord').setSelection(selected_pordno, true);
		}, 300);
		
}

function prodRfcConf_yn() {
	console.log('prodRfcConf_yn()');
	var page_url = "/frontend/prod/prodRfcConf_yn";			
	var postData = 'pordno=' + encodeURIComponent(selected_pordno);

	var chk_result;
	
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200")
			{
				chk_result = data.rows;
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
	console.log("prodRfcConf_yn() :: " + chk_result);
	 if(chk_result.length > 0) {
		 return true;
	 } else {
		 return false;
	 } 
}

function t1Chk() {
	var res_data;
	var rtn_data = false;

	//T1이 공정 중간에 있을때..
	var page_url = "/frontend/prod/pop_prod_select"
	var postData = "pordno=" + encodeURIComponent(selected_pordno);
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
		loadComplete : function(data) {

		},
		complete : function() {

		}
	});
	
	return data_length;
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
				batchDataArr.push(gridDataArr[i]);	
			}
		}
	}
	
	if(batchDataArr.length != 0) {
		$("#grid_addItnbr_list").jqGrid('addRow',{position  :"last", initdata  : batchDataArr, cellEdit:false});	
	}
		
	
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

function getFromLgort() {
	console.log('getFromLgort()');
	var wkctr = $("#grid_sapord").getRowData($("#grid_sapord").getGridParam('selrow')).wkctr;
	var dept_cd = $("#grid_sapord").getRowData($("#grid_sapord").getGridParam('selrow')).dept_cd;
	
	var page_url = "/frontend/prod/mes_wkctr_tbl_select"	
			 + "?dept_cd=" + encodeURIComponent(dept_cd)
			 + "&wkctr=" + encodeURIComponent(wkctr);
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

function locInputMng() {
// 	console.log('sernrInputMng()');
	var gridRowData = $("#grid_fault_list").getRowData($("#grid_fault_list").getGridParam('selrow'));
		
	gridRowData.lgort = $('#grade_loc').val();
	
	$("#grid_fault_list").setRowData($("#grid_fault_list").getGridParam('selrow'), gridRowData, {});
	$("#grade_loc_add").modal('hide');
}

function grade_chk() {

	$("#grid_grade_mng").jqGrid('clearGridData');
	
	var selKey = $("#grid_popord").jqGrid('getGridParam', 'selarrrow');
	var pordnos = "";
	var r_data = [];
	for(var i=0 ; i<selKey.length; i++) {
		
		var selectedData = $("#grid_popord").getRowData(selKey[i]);
		
		if(prodEndChk(selectedData.routing_no)) {//routing_header_master의 routng_plast_gubun 값... 현재 라우팅이 생산종료 단계인지 체크
			var pordno = selectedData.pordno_pop;
			pordno = pordno.substring(0,10);
			pordnos = pordnos + pordno + ",";
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
	
	
	console.log("r_data.length :: " + r_data.length);
	if(flag) {
		$("#grade_mng").modal('show');	
	} else {
		//작업종료 진행
		fnWorkChnStat_validation('end');
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
					
					if($("#grid_sapord").getRowData($("#grid_sapord").getGridParam('selrow')).routing_gno_gubun == 'Y')
	    				getStrList('mst04');
	    			else
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
			fnWorkChnStat_validation('end');
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

function jqgridHighlightFormattersernpYn(cellvalue, options, rowObject) {
	if (rowObject.sernp != null && rowObject.sernp != "" && rowObject.sernp == "V001") {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">Y</span>';
	} else {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">N</span>';
	}
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
	
	var selKey = $("#grid_sapord").jqGrid('getGridParam', 'selrow');
	
	if(selKey.length == 0) {
		fnMessageModalAlert("Notification(MES)", "선택된 생산지시오더가 없습니다.");
		return;
	}
	
	var rowData = $("#grid_sapord").getRowData(selKey);
	
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
	var getColNames = $("#grid_sapord").jqGrid('getGridParam','colNames');
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
}

function g_fault_proc() {
	
	matArr = [];
	$("#grid_g_materiallist").jqGrid('clearGridData');
	$("#s_matnr").val('');
	$("#s_wrkst").val('');
	$("#s_maktx").val('');
	$("#s_plant").val('');
	initOptions($('#v_lgort'));
	
	$("#dv_grid_g_materiallist").show();
	
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
	
	var grid_fault_list_data = [];
	
	$.each(grid_materiallist_selcData, function(idx, mat){
		var tmpObj = {};
		$.each(itnbr_data, function(i, obj){
			if( obj.matnr==mat.matnr ) {
				tmpObj.aufnr = selected_pordno;
				tmpObj.werks = $("#s_plant").val();
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

function getStrotageList() {

	initOptions($('#v_lgort'));

	if($("#s_plant").val() == '1110') {
		$('#v_lgort').append($('<option>', { 
			value: '2100',
			text : '생산자재 - FPD'
		}));
		$('#v_lgort').append($('<option>', { 
			value: '2200',
			text : '생산자재 - DR/RF'
		}));
		$('#v_lgort').append($('<option>', { 
			value: '2300',
			text : '생산자재 - Tab'
		}));
	} else {
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
		
		
		$("#grid_itnbrlist").jqGrid('setCell', itnbrlist_matnr, 'remain_bdmng', remain_bdmng);
		
		if(Number(remain_bdmng) == 0) {
			$("tr.jqgrow#"+itnbrlist_matnr).css("color","#0054FF");	
		} else {
			$("tr.jqgrow#"+itnbrlist_matnr).css("color","#FF0000");
		}
	}
}

function loadNewItnbrGridData() {

	var rtn_data = [];
	var selGridRowData = $("#grid_popord").getRowData($('#grid_popord').jqGrid('getGridParam','selrow'));
	var page_url = "/frontend/prod/selectSernrManageTbl"
				 + "?pordno_pop=" + encodeURIComponent(selGridRowData.pordno_pop);
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

function gubunText(cellvalue, options, rowObject) {
	if (rowObject.gubun == 'addItnbr') {
		return '<span>투입자재</span>';
	} else {
		return '<span>일반자재</span>';
	}
}

function selectPoLgort() {
	var rst_lgort ="";
	var pordno = $("#grid_sapord").getRowData($("#grid_sapord").getGridParam('selrow')).pordno;
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