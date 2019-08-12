<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
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
		<jsp:param name="selected_menu_p_cd" value="1013" />
		<jsp:param name="selected_menu_cd" value="1071" />
	</jsp:include>

 	<div class="content-wrapper">
		<section class="content-header">
			<h1>
				SCM관리 <small>이동요청</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> MES</a></li>
				<li class="active">자재 요청</li>
			</ol>
		</section>

		<section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="box box-success box-solid">
						<div class="box-header with-border">
							<h3 class="box-title">조회조건</h3>
							<div class="box-tools pull-right">
								<button type="button" id="btn_req" class="btn btn-primary btn-sm" onclick="fnRequest();">요청</button> |
								<button type="button" id="btn_search" class="btn btn-primary btn-sm" onclick="fnSearchRegListGrid();">조회</button>
								<button type="button" id="btn_search_init" class="btn btn-primary btn-sm" onclick="initParams();">조건초기화</button>
							</div>
						</div>
						<div id="" class="box-body">
							<div class="row">
								<div class="col-sm-2">
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
								<div class="col-sm-2">
									<div class="form-group">
										<label>| 진행상태</label><br /> <label> 
										<input type="radio" name="rdo_req_type" class="flat-red" value="" checked>
											전체 
										</label> 
										<label> <input type="radio" name="rdo_req_type" class="flat-red" value="N"> 미승인 </label> 
										<label> <input type="radio" name="rdo_req_type" class="flat-red" value="Y"> 승인 </label>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>| Plant</label>
										<div class="form-group" style="margin-bottom: 0px;">
											<select id="i_werks" class="form-control select2 input-sm" data-placeholder="플랜트 선택" style="width: 100%;">
												<option value="1110">의료</option>
												<option value="1210">광</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>| From</label>
										<div class="form-group" style="margin-bottom: 0px;">
											<select id="from_storage" class="form-control select2 input-sm" data-placeholder="출고 창고 선택" style="width: 100%;">
												<option value="">전체</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>| To</label>
										<div class="form-group" style="margin-bottom: 0px;">
											<select id="to_storage" class="form-control select2 input-sm" data-placeholder="입고 창고 선택" style="width: 100%;">
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
										<button type="button" id="" class="btn btn-primary btn-sm" onclick="directConfRef();">처리</button>
										<button type="button" id="btn_req_cancel" class="btn btn-primary btn-sm" onclick="fnReqCancel();">요청취소</button> 
										<button type="button" id="btn_chk_confirm" class="btn btn-primary btn-sm" onclick="fnChkConfirm();">수령확인</button>
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
  <%@include file="./scm_stk_request_modal.jsp"%>
  <%@include file="./scm_stk_request_modal_1.jsp"%>
  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>
<!-- ./wrapper -->
<script type="text/javascript">

var s_member_emp_no = '<%=s_member_emp_no%>';

$(function($) {
	fnLoadCommonOption();
	fnLoadRegListGrid();//fnSearchMainGrid
	
//////////////////////////
	initOptions($('#i_lgort'));
	
	getStrotageList();
	$('#i_werks').change(function(){
		getStrotageList();
	});
	//////////////////////////

})

// search component setting
function fnLoadCommonOption() {
	$(window).bind('resize', function() {
		resizeJqGrid("grid_reg", false);
	}).trigger('resize');
	
	$('input[type="radio"].flat-red').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green',
		handle: 'radio'
	});
	$("#register_date_range").pressEnter(function(e) {
		e.preventDefault();
		if(e.target.id == "register_date_range"){
// 			fnSearchMasterCodeGrid();
		}
	});
	fnDateInit();
	$( "#btn_search" ).on('click', function(e) {
		e.preventDefault();
// 		fnSearchMasterCodeGrid();
	});
}

function fnDateInit() {
	$('#register_date_range').daterangepicker({
		 locale: {
			format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
			,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			,dayNamesShort : ['일', '월', '화', '수', '목', '금', '토']
			,showMonthAfterYear: true
			,yearSuffix: '년'
			,orientation: "top left"
	    },

	    startDate: getTodayDate(),
	    endDate: getTodayDate()
	});
}
// serch parameter setting
function fnSearchRegListGrid(){
	var date1 = $("#register_date_range").val().substring(0,10);
	var date2 = $("#register_date_range").val().substring(13,23);
	
	date1 = date1.replace("-","").replace("-","");
	date2 = date2.replace("-","").replace("-","");
	
	var page_url = "/frontend/scm/req_matnr_ord_select"
				 + "?from=" + encodeURIComponent(date1)
				 + "&to=" + encodeURIComponent(date2)
				 + "&pgm_nm=" + encodeURIComponent("SCM")
				 + "&plant=" + encodeURIComponent($('#i_werks').val())
				 + "&stge_loc=" + encodeURIComponent($("#from_storage").val())
				 + "&move_stloc=" + encodeURIComponent($("#to_storage").val())
				 + "&grantor_status=" + encodeURIComponent($(':radio[name="rdo_req_type"]:checked').val());
	
// 	console.log(page_url);
	
	$("#grid_reg").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_reg").trigger("reloadGrid");
}

// serch result grid
function fnLoadRegListGrid(){

	$("#grid_reg").jqGrid({
		datatype: "json",
		colNames : ['요청번호', '요청순번', '즉시처리대상', 'proc_gubun', '품번', '품명', '승인상태', '저장위치', '요청일자', '단위', 'From플랜트','From창고', 'To플랜트','To창고', "s1", "s2", "s3", "s4", '요청수량', '수령인'],
		colModel:[
			{name : 'reqm_matnr_key',index : 'reqm_matnr_key',width : 20,sorttype : "text"},
			{name : 'reqm_sub_key',index : 'reqm_sub_key',width : 10,sorttype : "text"},
			{ name : 'f_proc_gubun', index : 'status', width : 10, sorttype : "text", formatter:jqgridHighlightFormatterProcGubunYn},
			{name : 'proc_gubun',index : 'proc_gubun',width : 13,sorttype : "text", hidden:true},
			{name : 'matnr',index : 'matnr',width : 18,sorttype : "text"}, 
			{name : 'maktx',index : 'maktx',width : 18,sorttype : "text"}, 
			{name : 'grantor_status',index : 'grantor_status',width : 10,sorttype : "text", formatter:jqgridHighlightFormatterConfYn}, 
			{name : 'lgort',index : 'lgort',width : 20,sorttype : "text", hidden:true},					            
			{name : 'creator_date',index : 'creator_date',width : 20, sorttype : "text"},
			{name : 'meins',index : 'meins',	width : 8,sorttype : "text", hidden:true},		
			{name : 'plant_nm',index : 'plant',width : 15, sorttype : "text"},
			{name : 'stge_loc_nm',index : 'stge_loc',width : 22, sorttype : "text"},
			{name : 'move_plant_nm',index : 'move_plant',width : 15, sorttype : "text"},
			{name : 'move_stloc_nm',index : 'move_stloc',width : 22, sorttype : "text"},
			{name : 'plant',index : 'plant',width : 20, sorttype : "text", hidden:true},
			{name : 'stge_loc',index : 'stge_loc',width : 25, sorttype : "text", hidden:true},
			{name : 'move_plant',index : 'move_plant',width : 20, sorttype : "text", hidden:true},
			{name : 'move_stloc',index : 'move_stloc',width : 20, sorttype : "text", hidden:true},
			{name : 'request_bdmng',index : 'request_bdmng',	width : 30,sorttype : "text"},
			{name : 'member_nm',index : 'member_nm',	width : 30,sorttype : "text"},
			],
		pager : "#grid_reg_pager",
		rowNum:20,
		rowList : [ 20, 50, 100 ],
	    height: 455,
	    width:270,
	    rownumWidth: 25,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
		altRows: true,
		rownumbers: true, 
	    autoencode: true,
	    loadonce: false,
	    sortable: true,
	    emptyrecords: "0 records found",
	    jsonReader : {
	    	root : "list_data",
	      records : "records",
	      repeatitems : false
	    },
	    loadComplete : function(data){
	    	console.log(data);
	    },
		onSelectRow: function(rowid, selected) {
			if(rowid != null) {
			}					
		}
	}); 
}

function fnRequest(){
	
	$("#s_matnr").val("");
	$("#s_maktx").val("");
	$("#s_from_str").val("");
	$("#s_to_str").val("");
	
	$('#grid_addItnbr_list').jqGrid('clearGridData');
	
	$("#t_gubun_1").prop("checked", true);
	
	$("#modal_detail").modal('show');
}

function getStrotageList() {
// 	console.log("getStrotageList()");
	initOptions($('#from_storage'));
	initOptions($('#to_storage'));

	var page_url = "/frontend/scm/scm_sloc_code_select"
	var postData = 'werks=' + encodeURIComponent($('#i_werks').val()); 
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    async:false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					
					$('#from_storage').append($('<option>', { 
				        value: '',
				        text : '전체' 
				    }));
					
					$('#to_storage').append($('<option>', { 
				        value: '',
				        text : '전체' 
				    }));
					
					
					$.each(data.rows, function (i, item) {
						$('#from_storage').append($('<option>', { 
					        value: item.lgort,
					        text : item.lgobe + '('+ item.lgort + ')' 
					    }));
						
						$('#to_storage').append($('<option>', { 
					        value: item.lgort,
					        text : item.lgobe 
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

function fnReqCancel() {
		
	var gridRowData = $("#grid_reg").getRowData($("#grid_reg").getGridParam('selrow'));
	var reqm_matnr_key = gridRowData.reqm_matnr_key;
	
	fnMessageModalConfirm("Notification(SCM)", "요청번호 : " + reqm_matnr_key + " 에 해당하는 요청내역이 모두 삭제됩니다. <br/>계속 진행 하시겠습니까?", function(result){
		if(result) {
			ReqCancel();
		}
	});
}


function ReqCancel() {
	var gridRowData = $("#grid_reg").getRowData($("#grid_reg").getGridParam('selrow'));
	var reqm_matnr_key = gridRowData.reqm_matnr_key;
	
	var page_url = "/frontend/scm/scm_trans_req_cancel";
	var postData = 'reqm_matnr_key=' + encodeURIComponent(reqm_matnr_key)
		 		+ '&requester_status=' + encodeURIComponent('N');		 
	$.ajax({
	    url: page_url,
 	    data: postData,
	    type: "POST",
	    async:false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		if(data.g_flag == "Y") {
	    			fnMessageModalAlert("Notification(SCM)", "승인처리가 완료된 데이터는 요청취소 할 수 없습니다.");
	    		} else {
	    			fnMessageModalAlert("Notification(SCM)", "해당 데이터의 요청 취소를 완료했습니다.");	
	    		}
				
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "해당 데이터의 요청 취소를 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "해당 데이터의 요청 취소를 실패하였습니다.");	
	    },
	    complete: function() {}
	});

	fnSearchRegListGrid()
}


function fnChkConfirm() {
	var gridRowData = $("#grid_reg").getRowData($("#grid_reg").getGridParam('selrow'));
	var reqm_matnr_key = gridRowData.reqm_matnr_key;
	
	var page_url = "/frontend/scm/scm_trans_req_user_confirml"
	var postData = 'reqm_matnr_key=' + encodeURIComponent(reqm_matnr_key);
	postData += '&confirm_user=' + encodeURIComponent(s_member_emp_no);
	$.ajax({
	    url: page_url,
 	    data: postData,
	    type: "POST",
	    async:false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		if(data.g_flag == "N") {
	    			fnMessageModalAlert("Notification(SCM)", "아직 승인처리되지 않은 데이터입니다.");
	    		} else if(data.c_flag == "Y") {
	    			fnMessageModalAlert("Notification(SCM)", "이미 등록된 수령인이 있습니다.");
	    		} else {
	    			fnMessageModalAlert("Notification(SCM)", "수령인 정보등록에 성공했습니다.");	
	    		}
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "수령인 정보등록에 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "수령인 정보등록에 실패하였습니다.");	
	    },
	    complete: function() {}
	});

	fnSearchRegListGrid()
}

function directConfRef() {

	var id = $("#grid_reg").jqGrid('getGridParam', 'selrow');
	var mas_key = $("#grid_reg").getRowData(id).reqm_matnr_key;

	var page_url = "/frontend/scm/req_matnr_ord_select_nopage";
	var postData = 'reqm_matnr_key=' + encodeURIComponent(mas_key);
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
    				fnMessageModalAlert("Notification(SCM)", "요청 시 즉시처리 미대상으로 지정된 항목입니다.<br>이동승인&출고 메뉴에서 처리해주세요.");
    				return;
    	    	}
	    		
	    		if(r_data.rows[0].grantor_status == "Y") {
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
// 	    	fnSearchRegListGrid();
	    	fnSearchConditionInit();
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

function initParams() {
	fnDateInit();
}
</script>
</body>
</html>