<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
	String memberId = SessionUtil.getMemberId(request);
	String rolenm = SessionUtil.getRoleNm(request);
	String positionnm = SessionUtil.getPositionNm(request);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Vieworks MES | VMES</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">

<jsp:include page="/common/header_inc" flush="true">
	<jsp:param name="page_title" value="0" />
</jsp:include>
</head>

<style>
#caseByCase .nav-pills>li>a {
	border-radius: 4px 4px 0 0;
}

#caseByCase .tab-content {
	border: 1px solid #cccccc;
	padding: 5px 15px;
	border-radius: 0 0 4px 4px;
}

.nav-pills>li.active>a, .nav-pills>li.active>a:hover, .nav-pills>li.active>a:focus
	{
	color: #000000;
	background-color: #cccccc;
}
}
</style>

<body class="hold-transition skin-green-light sidebar-mini">
	<div class="wrapper">
		<jsp:include page="/common/top_menu_inc" flush="true">
			<jsp:param name="fb_div" value="F" />
			<jsp:param name="page_title" value="0" />
		</jsp:include>

		<jsp:include page="/common/sidebar_menu_inc" flush="true">
			<jsp:param name="menu_div" value="F" />
			<jsp:param name="selected_menu_p_cd" value="1013" />
			<jsp:param name="selected_menu_cd" value="1066" />
		</jsp:include>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					SCM 관리 <small>이동.타출요청</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> SCM 관리</a></li>
					<li class="active">이동.타출요청</li>
				</ol>
			</section>
			<section class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="box box-success box-solid">
							<div class="box-header with-border">
								<h3 class="box-title">조회조건</h3>
								<div class="box-tools pull-right">
									<button type="button" id="btn_req"
										class="btn btn-primary btn-sm" onclick="fnRequest();">요청</button>
									|
									<button type="button" id="btn_search"
										class="btn btn-primary btn-sm"
										onclick="fnSearchRegListGrid();">조회</button>
									<button type="button" id="btn_search_init"
										class="btn btn-primary btn-sm" onclick="fnIinitPrams();">조건초기화</button>
								</div>
							</div>
							<div id="" class="box-body">
								<div class="row">
									<div class="col-sm-3">
										<div class="form-group">
											<label>| 요청내역일자</label>
											<div class="input-group">
												<div class="input-group-addon">
													<i class="fa fa-calendar"></i>
												</div>
												<input type="text" class="form-control pull-right input-sm" id="register_date_range">
											</div>
										</div>
									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<label>| 진행상태</label><br /> <label> <input
												type="radio" name="rdo_req_type" class="flat-red" value=""
												checked> 전체
											</label> <label> <input type="radio" name="rdo_req_type"
												class="flat-red" value="f1"> 요청
											</label> <label> <input type="radio" name="rdo_req_type"
												class="flat-red" value="f2"> 승인
											</label> <label> <input type="radio" name="rdo_req_type"
												class="flat-red" value="f3"> 처리
											</label> <label> <input type="radio" name="rdo_req_type"
												class="flat-red" value="f4"> 취소
											</label>
										</div>
									</div>

									<div class="col-sm-3">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>| 플랜트</label>
											<div class="form-group" style="margin-bottom: 0px;">
												<select id="s_werks" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
													<option value="">전체</option>
													<option value="1110">의료</option>
													<option value="1210">광</option>
												</select>
											</div>
										</div>
									</div>

									<div class="col-sm-3">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>| 저장위치</label>
											<div class="form-group" style="margin-bottom: 0px;">
												<select id="s_sloc" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
													<option value="">전체</option>
												</select>
											</div>
										</div>
									</div>

								</div>
							</div>
						</div>
					</div>
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-12">
								<div class="box" style="margin-bottom: 0px;">
									<div class="box-header with-border">
										<h3 class="box-title">요청 내용 목록</h3>
										<div class="box-tools pull-right">
											<button type="button" id="" class="btn btn-primary btn-sm"
												onclick="directConfRef();">처리</button>
											<button type="button" id="" class="btn btn-primary btn-sm"
												onclick="cancel_req_ord();">요청취소</button>
										</div>
									</div>
									<div id="dv_grid_reg" class="box-body">
										<table id="grid_reg"></table>
										<div id="grid_reg_pager"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
	<%@include file="./scm_transfer_request_modal.jsp"%>
	<%@include file="./scm_transfer_request_modal_1.jsp"%>
  	<jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
	<jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>

<script type="text/javascript">

var rolenm = "<%=rolenm%>";

$(function($) {
	fnLoadCommonOption();
	fnLoadRegListGrid();//fnSearchMainGrid

	getStrotageList();

	$('#s_werks').change(function() {
		getStrotageList();
	});
})

// search component setting
function fnLoadCommonOption() {
	$(window).bind('resize', function() {
		resizeJqGrid("grid_reg", false);
	}).trigger('resize');

	$('input[type="radio"].flat-red').iCheck({
		checkboxClass : 'icheckbox_flat-green',
		radioClass : 'iradio_flat-green',
		handle : 'radio'
	});
	$("#register_date_range").pressEnter(function(e) {
		e.preventDefault();
		if (e.target.id == "register_date_range") {
			// 			fnSearchMasterCodeGrid();
		}
	});
	$('#register_date_range').daterangepicker({
		locale : {
			format : 'YYYY-MM-DD', // inputbox 에 '2011/04/29' 로표시
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
			showMonthAfterYear : true,
			yearSuffix : '년',
			orientation : "top left"
		}
	});
	$("#btn_search").on('click', function(e) {
		e.preventDefault();
	});
}

// serch parameter setting
function fnSearchRegListGrid() {
	var date1 = $("#register_date_range").val().substring(0, 10);
	var date2 = $("#register_date_range").val().substring(13, 23);

	date1 = date1.replace("-", "").replace("-", "");
	date2 = date2.replace("-", "").replace("-", "");

	var page_url = "/frontend/scm/fwother_select"
			+ "?from=" + encodeURIComponent(date1)
			+ "&to=" + encodeURIComponent(date2)
			+ "&plant=" + encodeURIComponent($("#s_werks").val())
			+ "&stge_loc=" + encodeURIComponent($("#s_sloc").val())
			+ "&status=" + encodeURIComponent($(':radio[name="rdo_req_type"]:checked').val());

	$("#grid_reg").jqGrid('setGridParam', {
		url : page_url,
		datatype : 'json'
	});
	$("#grid_reg").setGridParam({
		page : 1
	}).trigger("reloadGrid");
}

// serch result grid
function fnLoadRegListGrid() {

	$("#grid_reg").jqGrid({
		datatype : "json",
		colNames : [ 'status', '상태', 'proc_gubun', '즉시처리대상', '요청번호', 'plant', '플랜트', '저장위치', '저장위치', '자재번호', '자재내역', '자재문서번호',
				'costcenter', '코스트센터', 'I/O', 'I/O', '요청일자', '수량', '단위', "자재수령인", "header_txt" ],
		colModel : [ 
		    { name : 'status', index : 'status', width : 20, sorttype : "text", hidden : true }, 
		    { name : 'status_nm', index : 'status', width : 10, sorttype : "text" },
		    { name : 'proc_gubun', index : 'status', width : 10, sorttype : "text", hidden : true },
		    { name : 'f_proc_gubun', index : 'status', width : 10, sorttype : "text", formatter:jqgridHighlightFormatterProcGubunYn},
		    { name : 'ref_doc_no', index : 'ref_doc_no', width : 20, sorttype : "text" }, 
			{ name : 'plant', index : 'plant', width : 20, sorttype : "text", hidden : true}, 
			{ name : 'plant_nm', index : 'plant', width : 20, sorttype : "text" }, 
			{ name : 'stge_loc', index : 'stge_loc', width : 20, sorttype : "text", hidden : true}, 
			{ name : 'stge_loc_nm', index : 'stge_loc', width : 20, sorttype : "text" }, 
			{ name : 'material', index : 'material', width : 20, sorttype : "text" }, 
			{ name : 'maktx', index : 'maktx', width : 20, sorttype : "text" }, 
			{ name : 'matdoc_itm', index : 'matdoc_itm', width : 20, sorttype : "text", hidden : true}, 
			{ name : 'costcenter', index : 'costcenter', width : 20, sorttype : "text", hidden : true}, 
			{ name : 'costcenter_nm', index : 'costcenter', width : 20, sorttype : "text"}, 
			{ name : 'orderid', index : 'orderid', width : 20, sorttype : "text", hidden : true}, 
			{ name : 'orderid_nm', index : 'orderid_nm', width : 20, sorttype : "text"}, 
			{ name : 'req_dt', index : 'req_dt', width : 20, sorttype : "text"}, 
			{ name : 'entry_qnt', index : 'entry_qnt', width : 10, sorttype : "text", align : "right"}, 
			{ name : 'entry_uom', index : 'entry_uom', width : 20, sorttype : "text", hidden : true}, 
			{ name : 'gr_rcpt', index : 'gr_rcpt', width : 20, sorttype : "text", hidden : true}, 
			{ name : 'header_txt', index : 'header_txt', width : 20, sorttype : "text", hidden : true} ],
		pager : "#grid_reg_pager",
		rowNum : 20,
		rowList : [ 20, 50, 100 ],
		height : 455,
		width : 270,
		rownumWidth : 25,
		viewrecords : true,
		autowidth : true,
		shrinkToFit : true,
		multiselect : false,
		altRows : true,
		rownumbers : true,
		autoencode : true,
		loadonce : false,
		sortable : true,
		emptyrecords : "0 records found",
		jsonReader : {
			root : "list_data",
			records : "records",
			repeatitems : false
		},
		loadComplete : function(data) {
			console.log(data);
		},
		onSelectRow : function(rowid, selected) {
			if (rowid != null) {
			}
		}
	});
}

function fnRequest() {

	$("#s_cc").val("");
	$("#s_io").val("");
	$("#s_move_type").val("");
	$("#s_header_txt").val("");
	$("#r_spec_stock").val("");

	$("#t_gubun_1").prop("checked", true);
	
	$('#grid_addItnbr_list').jqGrid('clearGridData');
	$("#modal_detail").modal('show');
}

function getStrotageList() {

	initOptions($('#s_sloc'));

	var page_url = "/frontend/scm/scm_sloc_code_select"
	var postData = 'werks=' + encodeURIComponent($('#s_werks').val());

	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					
					$('#s_sloc').append($('<option>', { 
				        value: '',
				        text : "전체"
				    }));
					
					$.each(data.rows, function (i, item) {
						$('#s_sloc').append($('<option>', { 
					        value: item.lgort,
					        text : item.lgobe + '('+ item.lgort + ')' 
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

function jqgridHighlightFormatterConfYn(cellvalue, options, rowObject) {
	if (cellvalue != null && cellvalue != "" && cellvalue == "Y") {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">승인</span>';
	} else {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">미승인</span>';
	}
}

function directConfRef() {

	var id = $("#grid_reg").jqGrid('getGridParam', 'selrow');
	var mas_key = $("#grid_reg").getRowData(id).ref_doc_no;

	var page_url = "/frontend/scm/fwother_select_nopage";
	var postData = '&ref_doc_no=' + encodeURIComponent(mas_key);
	var r_data;

	$.ajax({
	    url: page_url,
	    data: postData,
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		r_data = data;
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "정보를 조회하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 조회하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	if(r_data.rows.length > 0) {
	    		if(r_data.rows[0].proc_gubun != 'Y') {
    				fnMessageModalAlert("Notification(SCM)", "요청 시 즉시처리 미대상으로 지정된 항목입니다.<br>타출승인&출고 메뉴에서 처리해주세요.");
    				return;
    	    	}
	    		
	    		if(r_data.rows[0].status == "f3" || r_data.rows[0].status == "f4") {
	    				fnMessageModalAlert("Notification(SCM)", "이미 처리가 완료된 항목입니다.");
	    				return;
	    	    }
	    	}
	    	
	    	if(id == null || id == "undfined") {
	    		fnMessageModalAlert("Notification(SCM)", "선택 된 오더가 없습니다.");
	    		return;
	    	}
	    	
	    	fnSearchReqDetGrid_f2(mas_key, id);
	    	$('#modal_conf').modal('show');
	    	fnSearchRegListGrid();
	    	fnSearchConditionInit();
	    }
	});
}

function cancel_req_ord() {
	var id = $("#grid_reg").jqGrid('getGridParam', 'selrow');
	var mas_key = $("#grid_reg").getRowData(id).ref_doc_no;
	
	fnMessageModalConfirm("Notification(SCM)", "선택된 내역("+ mas_key +")을 삭제하시겠습니까?", function(result){
		if(result) {
			fn_cancel_req_ord();
		}
	});
}
function fn_cancel_req_ord() {
	var id = $("#grid_reg").jqGrid('getGridParam', 'selrow');
	var mas_key = $("#grid_reg").getRowData(id).ref_doc_no;
	
	if($("#grid_reg").getRowData(id).status != 'f1') {
		fnMessageModalAlert("Fail", "이미 진행된 항목입니다.");
		return;
	}
	
	if(id == null || id == "undfined") {
		fnMessageModalAlert("Fail", "선택 된 오더가 없습니다.");
		return;
	}
	
	var page_url = "/frontend/scm/cancel_req_ord";
	var postData = '&ref_doc_no=' + encodeURIComponent(mas_key);


	$.ajax({
	    url: page_url,
	    data: postData,
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalAlert("Notification(SCM)", "해당 실적을 삭제 완료했습니다.");	
		    	fnSearchRegListGrid();
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "정보를 삭제하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 삭제하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
		
	    }
	});
}

function jqgridHighlightFormatterProcGubunYn(cellvalue, options, rowObject) {
	if (rowObject.proc_gubun != null && rowObject.proc_gubun != "" && rowObject.proc_gubun =='Y') {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">Y</span>';
	} else {
// 		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">N</span>';
		return '';
	}
}

function fnIinitPrams() {
	alert("준비중...");
}
</script>
</body>
</html>