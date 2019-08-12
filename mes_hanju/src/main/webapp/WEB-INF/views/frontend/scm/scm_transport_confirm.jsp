<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
String rolenm = SessionUtil.getRoleNm(request);
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
		<jsp:param name="selected_menu_cd" value="1065" />
	</jsp:include>

	<div class="content-wrapper">
			<section class="content-header">
				<h1>
					SCM 관리 <small>이동.타출승인</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> SCM 관리</a></li>
					<li class="active">이동.타출승인</li>
				</ol>
			</section>
	<section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="box box-success box-solid">
						<div class="box-header with-border">
							<h3 class="box-title">조회조건</h3>
							<div class="box-tools pull-right">
								<button type="button" id="btn_search"
									class="btn btn-primary btn-sm" onclick="fnSearchReqMastGrid();">조회</button>	
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
											<input type="text" class="form-control pull-right input-sm" id="req_date_range">
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="form-group">
										<label>| 승인여부</label><br /> <label> 
										<input type="radio" name="rdo_req_type" class="flat-red" value="" checked>
											전체 
										</label> <label> <input type="radio" name="rdo_req_type"
											class="flat-red" value="f1"> 요청
										</label> <label> <input type="radio" name="rdo_req_type"
											class="flat-red" value="f2"> 요청승인 
										</label> <label> <input type="radio" name="rdo_req_type"
											class="flat-red" value="f3"> 요청처리
										</label> <label> <input type="radio" name="rdo_req_type"
											class="flat-red" value="f4"> 취소 
										</label>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group">
										<label>| Plant 구분</label><br /> <label> <input type="radio"
											name="rdo_plant_type" class="flat-red" value="" checked>
											전체 
										</label> <label> <input type="radio" name="rdo_plant_type"
											class="flat-red" value="1110"> 의료
										</label> <label> <input type="radio" name="rdo_plant_type"
											class="flat-red" value="1210"> 광
										</label>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>| 요청번호</label>
										<div class="input-group">
											<input type="text" class="form-control pull-right input-sm"	id="s_ref_doc_no">
										</div>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>| 코스트센터</label>
										<div class="form-group" style="margin-bottom: 0px;">
											<select id="s_sloc" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
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
						<div class="col-md-4">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">요청 내역</h3>
								</div>
								<div id="dv_grid_req" class="box-body">
									<table id="grid_req"></table>
									<div id="grid_req_pager"></div>
								</div>
							</div>
						</div>
						<div class="col-md-8">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">요청 내역 상세 정보</h3>
									<div class="box-tools pull-right">
									<button type="button" id="btn_req_cancel" 	class="btn btn-primary btn-sm" onclick="fnCancelReqMatr();">요청처리취소</button>
									<button type="button" id="btn_approval_cancel" 	class="btn btn-primary btn-sm" onclick="fnCancelApprovalMatr();">요청승인취소</button>
									   <button type="button" id="btn_req_approval" 	class="btn btn-primary btn-sm" onclick="fnApprovalReqMatr();">요청승인</button>
	               					   <span id="req_conf">
	               					   <label for="r_conf_date">요청처리일자</label>
						               <input type="input" id="r_conf_date" name="r_conf_date"  placeholder="" maxlength="10">
										<button type="button" id="btn_req_conf" 	class="btn btn-primary btn-sm" onclick="fnConfReqMatr();">요청처리</button>
										</span>
									</div>
								</div>
								<div id="dv_grid_req" class="box-body">
									<div class="col-md-6" style="padding:0px;">
										<div id="dv_grid_req_sernr" class="box-body">
											<table id="grid_req_sernr"></table>
										</div>
									</div>
									<div class="col-md-6" style="padding:0px;">
										<div id="dv_grid_req_bdmng" class="box-body">
											<table id="grid_req_bdmng"></table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</div>
  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>
<script type="text/javascript">

var rolenm = "<%=rolenm%>";

var lastSel;

var selc_id;
var selected_sernp;
var selected_mas_key;
var selected_sub_key;

$(function($) {
	fnLoadCommonOption();
	fnLoadReqMastGrid();
	fnLoadReqDet1Grid();
	fnLoadReqDet2Grid();
	$("#cb_"+$("#grid_req")[0].id).hide();		// grid_req 그리드 전체 체크박스 invisible 처리..
	
	getStrotageList();

})

// search component setting
function fnLoadCommonOption() {
	$(window).bind('resize', function() {
		resizeJqGrid("grid_req", false);
		resizeJqGrid("grid_req_sernr", false);
		resizeJqGrid("grid_req_bdmng", false);
	}).trigger('resize');
	
	$('#req_date_range').daterangepicker({
		 locale: {
			format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
			,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			,dayNames: ['일', '월', '화', '수', '목', '금', '토']
			,dayNames : ['일', '월', '화', '수', '목', '금', '토']
			,dayNamesShort : ['일', '월', '화', '수', '목', '금', '토']
			,dayNamesMin : ['일', '월', '화', '수', '목', '금', '토']
			,showMonthAfterYear: true
			,yearSuffix: '년'
			,orientation: "top left"
	    }
	});
	
	
	$("#r_conf_date").datepicker({
		language: "kr",
		todayHighlight: true,
		format: "yyyymmdd",
		autoclose: true
  	});
	
	$('#r_conf_date').val($.datepicker.formatDate('yymmdd', new Date()));
	
	$("#btn_approval_cancel").hide();
	$("#btn_req_approval").hide();
	$("#req_conf").hide();
	$("#btn_req_cancel").hide();
}
function fnLoadReqMastGrid(){
	var date1 = $("#req_date_range").val().substring(0,10);
	var date2 = $("#req_date_range").val().substring(13,23);
	
	$("#grid_req").jqGrid({
		datatype: "json",
		colNames:['상태', '상태','요청번호', '플랜트', '플랜트', '저장위치', '저장위치', '코스트센터', '코스트센터', 'I/O', 'I/O', 'header_txt'],
		colModel:[
			{name:'status',index:'status', width:20, sorttype:"text", hidden:true},
			{name:'status_nm',index:'status_nm', width:20, sorttype:"text"},
	        {name:'ref_doc_no',index:'ref_doc_no', width:20, sorttype:"text", key:true},
	        {name:'plant',index:'plant', width:20, sorttype:"text", hidden:true},
	        {name:'plant_nm',index:'plant_nm', width:20, sorttype:"text"},
	        {name:'stge_loc',index:'stge_loc', width:20, sorttype:"text", hidden:true},
	        {name:'stge_loc_nm',index:'stge_loc', width:20, sorttype:"text"},
	        {name:'costcenter',index:'costcenter', width:20, sorttype:"text", hidden:true},
	        {name:'costcenter_nm',index:'costcenter_nm', width:20, sorttype:"text"},
	        {name:'orderid',index:'orderid', width:20, sorttype:"text", hidden:true},
	        {name:'orderid_nm',index:'orderid_nm', width:20, sorttype:"text"},
	        {name:'header_txt',index:'header_txt', width:20, sorttype:"text", hidden:true},
		],
		cmTemplate: {sortable: false},
		pager : "#grid_req_pager",
		rowNum:20,
		rowList : [ 20, 50, 100 ],
	    height: 455,
	    width:270,
	    rownumWidth: 25,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : true,
		altRows: true,
		rownumbers: true, 
	    autoencode: true,
	    loadonce: false,
	    sortable : true,
		sortname: 'ref_doc_no',
	    emptyrecords: "0 records found",
	    loadComplete : function(data){
	    	console.log(data);
	    },
		onSelectRow: function (rowId, status, e) {
	        
			selc_id = rowId;
			
			if (rowId == lastSel) {
	            $(this).jqGrid("resetSelection");
	            lastSel = undefined;
	            status = false;
	        } else {
	            lastSel = rowId;
	        }
	        
			if(rowId != null) {
				
				selected_mas_key =  $(this).getCell(rowId, getColumnIndexByName($(this),"ref_doc_no"));
				var selected_status =  $(this).getCell(rowId, getColumnIndexByName($(this),"status"));

				var flag = approval_btn_chk();
				console.log(flag);
				if(selected_status == "f1") {
					console.log("f1");
					if(flag) {
						$("#btn_req_approval").show();
					}
					$("#btn_approval_cancel").hide();
					$("#req_conf").hide();
					$("#btn_req_cancel").hide();
					fnSearchReqDetGrid_f1(selected_mas_key);	//요청상태일때
				} else if(selected_status == "f2") {
					console.log("f2");
					$("#btn_req_approval").hide();
					if(flag) {
						$("#btn_approval_cancel").show();
					}
					$("#req_conf").show();
					$("#btn_req_cancel").hide();
					fnSearchReqDetGrid_f2(selected_mas_key);	//승인상태일때
				} else if(selected_status == "f3") {
					console.log("f3");
					$("#btn_req_approval").hide();
					$("#req_conf").hide();
					if(flag) {
						$("#btn_req_cancel").show();
					}
					$("#btn_approval_cancel").hide();
					fnSearchReqDetGrid_f3(selected_mas_key);	//처리상태일때
				} else if(selected_status == "f4") {
					console.log("f4");
					$("#btn_approval_cancel").hide();
					$("#btn_req_approval").hide();
					$("#req_conf").hide();
					$("#btn_req_cancel").hide();
					fnSearchReqDetGrid_f3(selected_mas_key);	//취소상태일때
				}
			}					
	    },
		beforeSelectRow: function (rowId, e) {
				$(this).jqGrid("resetSelection");
			    return true;
		}
	}); 
}



function fnSearchReqMastGrid(){

	$("#btn_approval_cancel").hide();
	$("#btn_req_approval").hide();
	$("#req_conf").hide();
	$("#btn_req_cancel").hide();
	
	$("#grid_req_sernr").jqGrid('clearGridData');
	$("#grid_req_bdmng").jqGrid('clearGridData');
	
	var date1 = $("#req_date_range").val().substring(0,10).replace("-","").replace("-","");
	var date2 = $("#req_date_range").val().substring(13,23).replace("-","").replace("-","");
	
	var page_url = "/frontend/scm/fwother_conf_header_select"
		 + "?from=" + encodeURIComponent(date1)
		 + "&to=" + encodeURIComponent(date2)
		 + "&stge_loc=" + encodeURIComponent($("#s_sloc").val())
		 + "&plant=" + encodeURIComponent($(':radio[name="rdo_plant_type"]:checked').val())
		 + "&ref_doc_no=" + encodeURIComponent($("#s_ref_doc_no").val())
		 + "&costcenter=" + encodeURIComponent($("#s_sloc").val())
		 + "&status=" + encodeURIComponent($(':radio[name="rdo_req_type"]:checked').val());
	
	
	$("#grid_req").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_req").trigger("reloadGrid");
}

//detail grid setting
function fnLoadReqDet1Grid() {
	
	$("#grid_req_sernr").jqGrid({
		datatype: "json",
		colNames:['요청번호','문서번호','자재번호','요청수량', '시리얼번호', '단위', '요청자', '플랜트', '저장창고'],
		colModel:[
			{name:'ref_doc_no',index:'ref_doc_no'},
			{name:'matdoc_itm',index:'matdoc_itm', hidden:true},
			{name:'material',index:'material'},
			{name:'entry_qnt',index:'entry_qnt', align:"right"},
			{name:'serial',index:'serial', editable:true},			//시리얼 관리 대상 땐 승인수량 데이터 받음;;;...
			{name:'entry_uom',index:'entry_uom', hidden:true},
			{name:'gr_rcptr',index:'gr_rcpt', hidden:true},
			{name:'plant',index:'plant', hidden:true},
			{name:'stge_loc',index:'stge_loc', hidden:true}
		],
		cmTemplate: {sortable: false},
		rowNum:10000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
// 	    multiselect : true,
	    height: 505,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    cellEdit:true,
	    cellsubmit : 'clientArray',
	    emptyrecords: "0 records found",
	    loadComplete : function() {
		},
		afterEditCell: function(id,name,val,iRow,iCol){
			  $("#"+iRow+"_"+name).bind('blur',function(){
				$('#grid_req_sernr').saveCell(iRow,iCol);
			  });
		}
	});
}

function fnLoadReqDet2Grid() {
	
	$("#grid_req_bdmng").jqGrid({
		datatype: "json",
		colNames:['요청번호','문서번호','자재번호','요청수량', '승인수량', '단위', '요청자', '플랜트', '저장창고'],
		colModel:[
			{name:'ref_doc_no',index:'ref_doc_no'},
			{name:'matdoc_itm',index:'matdoc_itm', hidden:true},
			{name:'material',index:'material'},
			{name:'entry_qnt',index:'entry_qnt', align:"right"},
			{name:'serial',index:'serial', editable:true, hidden:true},			//시리얼 관리 대상 땐 승인수량 데이터 받음;;;...
			{name:'entry_uom',index:'entry_uom', hidden:true},
			{name:'gr_rcptr',index:'gr_rcptr', hidden:true},
			{name:'plant',index:'plant', hidden:true},
			{name:'stge_loc',index:'stge_loc', hidden:true}
		],
		cmTemplate: {sortable: false},
		rowNum:10000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
// 	    multiselect : true,
	    height: 505,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    cellEdit:true,
	    cellsubmit : 'clientArray',
	    emptyrecords: "0 records found",
	    loadComplete : function() {
		},
		afterEditCell: function(id,name,val,iRow,iCol){
			  $("#"+iRow+"_"+name).bind('blur',function(){
				$('#grid_req_bdmng').saveCell(iRow,iCol);
			  });
		}
	});
}

function fnSearchReqDetGrid_f1(mas_key) {

	$('#grid_req_sernr').jqGrid('clearGridData');
	$('#grid_req_bdmng').jqGrid('clearGridData');
	
	var page_url = "/frontend/scm/fwother_select_nopage"
	var postData = "ref_doc_no=" + encodeURIComponent(mas_key)

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			
			var arrTmpObj = [];
			var arrTmpObj_1 = [];
			
			if(data.status == "200")
			{				
				for(var i=0; i<data.rows.length; i++ ){
				
					var entry_qnt = Number(data.rows[i].entry_qnt);
					console.log(data);
					// 승인 대기, 시리얼 관리대상 데이터 생성
					if(data.rows[i].serial_yn == "Y"){
						$('#grid_req_sernr').setColProp('serial', {editable:false});
						
								var tmpObj = {};
								tmpObj.ref_doc_no = data.rows[i].ref_doc_no;
								tmpObj.matdoc_itm = data.rows[i].matdoc_itm;
								tmpObj.material = data.rows[i].material;
								tmpObj.entry_qnt = data.rows[i].entry_qnt; 
								tmpObj.serial = data.rows[i].serial;
								tmpObj.entry_uom =  data.rows[i].entry_uom;
								tmpObj.gr_rcptr = data.rows[i].gr_rcptr;
								tmpObj.plant = data.rows[i].plant;
								tmpObj.stge_loc = data.rows[i].stge_loc;

								arrTmpObj.push(tmpObj);
					} else {				
						// 승인 대기, 시리얼 비관리대상 데이터 생성
						$('#grid_req_bdmng').setColProp('serial', {editable:false});
						var tmpObj = {};
						
						tmpObj.ref_doc_no = data.rows[i].ref_doc_no;
						tmpObj.matdoc_itm = data.rows[i].matdoc_itm;
						tmpObj.material = data.rows[i].material;
						tmpObj.entry_qnt = data.rows[i].entry_qnt;
						tmpObj.serial = data.rows[i].serial;
						tmpObj.entry_uom =  data.rows[i].entry_uom;
						tmpObj.gr_rcptr = data.rows[i].gr_rcptr;
						tmpObj.plant = data.rows[i].plant;
						tmpObj.stge_loc = data.rows[i].stge_loc;						
						
						arrTmpObj_1.push(tmpObj);
					}
				}
				$('#grid_req_sernr').jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj }).trigger('reloadGrid');	
				$('#grid_req_bdmng').jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj_1 }).trigger('reloadGrid');	
			} else
			{
				fnMessageModalAlert("Notification(HUB)",
				"요청처리를 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(HUB)",
			"요청처리를 실패했습니다.");
		},
		complete : function() {
		}			
	});
}

function fnSearchReqDetGrid_f2(mas_key) {

	$('#grid_req_sernr').jqGrid('clearGridData');
	$('#grid_req_bdmng').jqGrid('clearGridData');
	
	var page_url = "/frontend/scm/fwother_select_nopage"
	var postData = "ref_doc_no=" + encodeURIComponent(mas_key)

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
		
			var arrTmpObj = [];
			var arrTmpObj_1 = [];
		
		
		
			if(data.status == "200")
			{				
				for(var i=0; i<data.rows.length; i++ ){
			
					var entry_qnt = Number(data.rows[i].entry_qnt);
					console.log(data);
					// 승인 대기, 시리얼 관리대상 데이터 생성
					if(data.rows[i].serial_yn == "Y"){
						$('#grid_req_sernr').setColProp('serial', {editable:true});
						for(var j=0; j<entry_qnt; j++ ){
								var tmpObj = {};
								tmpObj.ref_doc_no = data.rows[i].ref_doc_no;
								tmpObj.matdoc_itm = data.rows[i].matdoc_itm;
								tmpObj.material = data.rows[i].material;
								tmpObj.entry_qnt = "1.000"; 
								tmpObj.serial = data.rows[i].serial;
								tmpObj.entry_uom =  data.rows[i].entry_uom;
								tmpObj.gr_rcptr = data.rows[i].gr_rcptr;
								tmpObj.plant = data.rows[i].plant;
								tmpObj.stge_loc = data.rows[i].stge_loc;
							
								arrTmpObj.push(tmpObj);
						
						}
					} else {				
						// 승인 대기, 시리얼 비관리대상 데이터 생성
						$('#grid_req_bdmng').setColProp('serial', {editable:true});
						var tmpObj = {};
					
						tmpObj.ref_doc_no = data.rows[i].ref_doc_no;
						tmpObj.matdoc_itm = data.rows[i].matdoc_itm;
						tmpObj.material = data.rows[i].material;
						tmpObj.entry_qnt = data.rows[i].entry_qnt;
						tmpObj.serial = data.rows[i].serial;
						tmpObj.entry_uom =  data.rows[i].entry_uom;
						tmpObj.gr_rcptr = data.rows[i].gr_rcptr;
						tmpObj.plant = data.rows[i].plant;
						tmpObj.stge_loc = data.rows[i].stge_loc;						
					
						arrTmpObj_1.push(tmpObj);
					}
				}
				$('#grid_req_sernr').jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj }).trigger('reloadGrid');	
				$('#grid_req_bdmng').jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj_1 }).trigger('reloadGrid');	
			} else
			{
				fnMessageModalAlert("Notification(HUB)",
				"요청처리를 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(HUB)",
			"요청처리를 실패했습니다.");
		},
		complete : function() {
		}			
	});
}

function fnSearchReqDetGrid_f3(mas_key) {

	$('#grid_req_sernr').jqGrid('clearGridData');
	$('#grid_req_bdmng').jqGrid('clearGridData');
	/************************f3 상태 시리얼 그리드 구성 : Start ******************************/
	var page_url = "/frontend/scm/fwother_serial_select"
	var postData = "ref_doc_no=" + encodeURIComponent(mas_key)

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
		
			var arrTmpObj = [];
		
			if(data.status == "200")
			{				
				for(var i=0; i<data.rows.length; i++ ){
			
					var entry_qnt = Number(data.rows[i].entry_qnt);
					// 승인 대기, 시리얼 관리대상 데이터 생성
					if(data.rows[i].serial_yn == "Y"){
						$('#grid_req_sernr').setColProp('serial', {editable:false});
						for(var j=0; j<entry_qnt; j++ ){
								var tmpObj = {};
								tmpObj.ref_doc_no = data.rows[i].ref_doc_no;
								tmpObj.matdoc_itm = data.rows[i].matdoc_itm;
								tmpObj.material = data.rows[i].material;
								tmpObj.entry_qnt = "1.000"; 
								tmpObj.serial = data.rows[i].serialno;
								tmpObj.entry_uom =  data.rows[i].entry_uom;
								tmpObj.gr_rcptr = data.rows[i].gr_rcptr;
								tmpObj.plant = data.rows[i].plant;
								tmpObj.stge_loc = data.rows[i].stge_loc;
							
								arrTmpObj.push(tmpObj);						
						}
					} 
				}
				$('#grid_req_sernr').jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj }).trigger('reloadGrid');	
			} else
			{
				fnMessageModalAlert("Notification(HUB)",
				"요청처리를 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(HUB)",
			"요청처리를 실패했습니다.");
		},
		complete : function() {
		}			
	});
	/************************f3 상태 시리얼 그리드 구성 : End ******************************/
	/************************f3 상태 수량 그리드 구성 : Start ******************************/
	var page_url = "/frontend/scm/fwother_select_nopage"
		var postData = "ref_doc_no=" + encodeURIComponent(mas_key)

		$.ajax({
			url : page_url,
			data : postData,
			async : false,
			type : "POST",
			success : function(data, textStatus, jqXHR) {
			
				var arrTmpObj_1 = [];
						
				if(data.status == "200")
				{				
					for(var i=0; i<data.rows.length; i++ ){
				
						var entry_qnt = Number(data.rows[i].entry_qnt);
						// 승인 대기, 시리얼 관리대상 데이터 생성
						if(data.rows[i].serial_yn != "Y"){
				
							// 승인 대기, 시리얼 비관리대상 데이터 생성
							$('#grid_req_bdmng').setColProp('serial', {editable:false});
							var tmpObj = {};
						
							tmpObj.ref_doc_no = data.rows[i].ref_doc_no;
							tmpObj.matdoc_itm = data.rows[i].matdoc_itm;
							tmpObj.material = data.rows[i].material;
							tmpObj.entry_qnt = data.rows[i].entry_qnt;
							tmpObj.serial = data.rows[i].serial;
							tmpObj.entry_uom =  data.rows[i].entry_uom;
							tmpObj.gr_rcptr = data.rows[i].gr_rcptr;
							tmpObj.plant = data.rows[i].plant;
							tmpObj.stge_loc = data.rows[i].stge_loc;						
						
							arrTmpObj_1.push(tmpObj);
						}
					}
					
					console.log(arrTmpObj_1);
					$('#grid_req_bdmng').jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj_1 }).trigger('reloadGrid');	
				} else
				{
					fnMessageModalAlert("Notification(HUB)",
					"요청처리를 실패했습니다.");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("Notification(HUB)",
				"요청처리를 실패했습니다.");
			},
			complete : function() {
			}			
		});
	/************************f3 상태 수량 그리드 구성 : End ******************************/
}

var getColumnIndexByName = function(grid,columnName) {
    var cm = grid.jqGrid('getGridParam','colModel');
    for (var i=0,l=cm.length; i<l; i++) {
        if (cm[i].name===columnName) {
            return i; // return the index
        }
    }
    return -1;
}

function fnConfReqMatr(){

	var flag = true;
	
	var gridDataArr = $('#grid_req_sernr').jqGrid('getRowData');
	
	for(var i=0 ; i<gridDataArr.length; i++) {
		if(gridDataArr[i].serial.length == 0) {
			flag = false;
		}
	}
	
	if(flag == false) {
		fnMessageModalAlert("Notification(SCM)", "시리얼 대상 내역의 시리얼번호를 입력해주세요.");
		return;
	}
	
	fnMessageModalConfirm("Notification", "선택 요청을 처리하시겠습니까?", function(chk){
		if(chk){
			confReqMatr();
		}
	});
}

function confReqMatr(){
	$("#grid_req_sernr").jqGrid('setGridParam', {cellEdit: false});
	$("#grid_req_bdmng").jqGrid('setGridParam', {cellEdit: false});
	
	var gridDataArr = $('#grid_req_sernr').jqGrid('getRowData');
	var gridDataArr_1 = $('#grid_req_bdmng').jqGrid('getRowData');
	
	$("#grid_req_sernr").jqGrid('setGridParam', {cellEdit: true});
	$("#grid_req_bdmng").jqGrid('setGridParam', {cellEdit: true});
	
	/*********************그리드 체크여부 확인 : Start*********************/
	if(gridDataArr.length == 0 && gridDataArr_1.length == 0)
	{
		fnMessageModalAlert("Notification(HUB)", "체크 된 데이터가 없습니다.");
 		return;
	}
	/*********************그리드 체크여부 확인 : End*********************/
	
	var jsonStr = JSON.stringify(gridDataArr);
	var jsonStr_1 = JSON.stringify(gridDataArr_1);


	/********************* 데이터 insert 및 rfc 전송 : Start*********************/

		var selc_header_txt = $("#grid_req").getRowData(selc_id).header_txt;	
		var selc_status = $("#grid_req").getRowData(selc_id).status;
		
		var page_url = "/frontend/scm/conf_req_matr";
		var postData = 'jsonStr=' + encodeURIComponent(jsonStr)
		postData += '&jsonStr_1=' + encodeURIComponent(jsonStr_1)
		postData += '&conf_date=' + encodeURIComponent($("#r_conf_date").val())
		postData += '&ref_doc_no=' + encodeURIComponent(selc_id)
		postData += '&pre_status=' + encodeURIComponent(selc_status)
		postData += '&header_txt=' + encodeURIComponent(selc_header_txt);

		$.ajax({
		    url: page_url,
		    data: postData,
		    async : false,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
		    		console.log(data);
			    	if(data.e_return == 'S') {
			    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하였습니다. <br/> ***sap 전송 결과*** <br/>e_return : : " 
		    					+ data.e_return	+ "<br/>e_message : "+ data.e_message);
			    		} else {
			    			fnMessageModalAlert("Notification(SCM)", "정보를 저장하지 못했습니다. <br/> ***sap 전송 결과*** <br/>e_return : : " 
			    					+ data.e_return	+ "<br/>e_message : "+ data.e_message);
			    		}
			    	lastSel = null;
		    	} else {
		    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    	fnSearchReqMastGrid();
		    }
		});
		/********************* 데이터 insert 및 rfc 전송 : End*********************/
}

function rawValidationChk(jsonStr)
{		
	var rawValidationChk_result = null;
	var parsedJson = JSON.parse(jsonStr); 
	var raw_num_seqs = '';
	var Sernrs = '';

	var s_reqm_matnr_key = parsedJson[0].reqm_matnr_key;
	var s_reqm_sub_key =  parsedJson[0].reqm_sub_key;
	
	var arrSernr = [];
	var arrSernrTmp = [];
	
	for(var i=0;i<parsedJson.length;i++)
	{
		/*********************순차관리 입력 여부 체크 : Start*********************/
		if(parsedJson[i].serial == null || parsedJson[i].serial == '')
		{
			fnMessageModalAlert("Notification(StatusChk)",
			"시리얼을 입력해주십시오.");
			rawValidationChk_result = false;
			return rawValidationChk_result;
		}
		/*********************순차관리 입력 여부 체크 : End*********************/
		
		Sernrs += parsedJson[i].serial+ ',';
		arrSernr.push(parsedJson[i].serial);
	}
		
		
	/*********************순차관리 중복 입력 여부 체크 : Start*********************/
	$.each(arrSernr, function(i, el){
		if($.inArray(el, arrSernrTmp) === -1)
		{
			arrSernrTmp.push(el);
		} else {
			fnMessageModalAlert("Notification(StatusChk)",
			"시리얼 번호를 중복 입력했습니다.");
			rawValidationChk_result = false;
			return rawValidationChk_result;
		}
	});
	/*********************순차관리 중복 입력 여부 체크 : End*********************/		
	
		
	/*********************처리상태 체크 : Start*********************/

	var page_url = "/frontend/hub/req_status_chk";
		var postData = "reqm_matnr_key=" + encodeURIComponent(s_reqm_matnr_key);
		postData += "&reqm_sub_key=" + encodeURIComponent(s_reqm_sub_key);

		$.ajax({
			url : page_url,
			data : postData,
			async : false,
			type : "POST",
			success : function(data, textStatus, jqXHR) {
				if(data.status == "200")
				{
					var resultJson = JSON.parse(JSON.stringify(data));
					var result = resultJson.rows[0].grantor_status;
					if(result != 'N')
					{
						rawValidationChk_result = false;
						fnMessageModalAlert("Notification(HUB)",
						"이미 요청처리가 완료된 데이터 입니다.");
					}
				}else
				{
					rawValidationChk_result = false;	
					fnMessageModalAlert("Notification(HUB)",
					"요청처리를 실패했습니다.");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("Notification(HUB)",
				"요청처리를 실패했습니다.");
			},
			complete : function() {
			}			
		});
		if(rawValidationChk_result == false)
		{
			return rawValidationChk_result;
		}
	/*********************처리상태 체크 : End*********************/
	
	/*********************순차관리번호 중복 체크 : Start*********************/
	
// 	var page_url = "/frontend/scm/raw_sernr_duplication_chk";
// 		var postData = "Sernrs=" + encodeURIComponent(Sernrs);

// 		$.ajax({
// 			url : page_url,
// 			data : postData,
// 			async : false,
// 			type : "POST",
// 			success : function(data, textStatus, jqXHR) {
// 				if(data.status == "200")
// 				{
// 					var resultJson = JSON.parse(JSON.stringify(data));
// 					var result_len = resultJson.rows.length;
// 					if(result_len > 0)
// 					{
// 						rawValidationChk_result = false;
// 						fnMessageModalAlert("Notification(StatusChk)",
// 		 						"순차관리번호가 기존 등록된 내역과 중복됩니다.");
// 					}		
// 				}else
// 				{
// 					rawValidationChk_result = false;	
// 					fnMessageModalAlert("Notification(StatusChk)",
// 					"요청처리를 실패했습니다.");
// 				}
// 			},
// 			error : function(jqXHR, textStatus, errorThrown) {
// 				fnMessageModalAlert("Notification(StatusChk)",
// 				"요청처리를 실패했습니다.");
// 			},
// 			complete : function() {
// 			}			
// 		});
// 		if(rawValidationChk_result == false)
// 		{
// 			return rawValidationChk_result;
// 		}

	/*********************순차관리번호 중복 체크 : End*********************/
}

function jqgridChkFormatter(cellvalue, options, rowObject) {
	if (cellvalue != null && cellvalue != "" && cellvalue == "Y") {	
		return '<i class="fa fa-check" aria-hidden="true"></i>';
	} else {
		return "";
	}
}

function jqgridConfFormatter(cellvalue, options, rowObject) {
	if (cellvalue != null && cellvalue != "" && cellvalue == "Y") {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">승인</span>';
	} else if (cellvalue != null && cellvalue != "" && cellvalue == "N") {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#8C8C8C\">미승인</span>';
	} else {
		return "";
	}
}

function confChk(jsonStr_1){
	
	var rawValidationChk_result = null;
	var parsedJson = JSON.parse(jsonStr_1); 

	var s_reqm_matnr_key = parsedJson[0].reqm_matnr_key;
	var s_reqm_sub_key =  parsedJson[0].reqm_sub_key;
	
	var rawValidationChk_result;
	
	var page_url = "/frontend/hub/req_status_chk";
	var postData = "reqm_matnr_key=" + encodeURIComponent(s_reqm_matnr_key);
	postData += "&reqm_sub_key=" + encodeURIComponent(s_reqm_sub_key);

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200")
			{
				var resultJson = JSON.parse(JSON.stringify(data));
				var result = resultJson.rows[0].grantor_status;

				if(result != 'N')
				{
					rawValidationChk_result = false;
					fnMessageModalAlert("Notification(HUB)",
					"이미 요청처리가 완료된 데이터 입니다.");
				} else {
					rawValidationChk_result = true;
				}
				
			}else
			{
				rawValidationChk_result = false;	
				fnMessageModalAlert("Notification(HUB)",
				"요청처리를 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			rawValidationChk_result = false;	
			fnMessageModalAlert("Notification(HUB)",
			"요청처리를 실패했습니다.");
		},
		complete : function() {
		}			
	});
	
		return rawValidationChk_result;
}

function fnApprovalReqMatr(){
	fnMessageModalConfirm("Notification", "선택 요청을 승인하시겠습니까?", function(chk){
		if(chk){
			ApprovalReqMatr();
		}
	});
}

function ApprovalReqMatr() {
	
	var selc_rowid = $("#grid_req").jqGrid('getGridParam', 'selrow');
	
	/*********************그리드 체크여부 확인 : Start*********************/
	if(selc_rowid == null || selc_rowid == 0)
	{
		fnMessageModalAlert("Notification(SCM)", "선택 된 데이터가 없습니다.");
 		return;
	}
	
	/*********************그리드 체크여부 확인 : End*********************/
	
	
	/********************* status 승인(f2)로 업데이트 : Start*********************/

		var page_url = "/frontend/scm/approval_req_matr";
		var postData = 'ref_doc_no=' + encodeURIComponent(selc_rowid);
		
		$.ajax({
		    url: page_url,
		    data: postData,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
		    		fnMessageModalAlert("Notification(SCM)", "해당 오더가 승인되었습니다.");	
		    	} else {
		    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    	fnSearchReqMastGrid();
		    	$("#grid_req_sernr").jqGrid('clearGridData');
		    	$("#grid_req_bdmng").jqGrid('clearGridData');
		    	
		    	$("#btn_approval_cancel").hide();
		    	$("#btn_req_approval").hide();
		    	$("#req_conf").hide();
		    	$("#btn_req_cancel").hide();
		    }
		});
		/********************* status 승인(f2)로 업데이트 : End*********************/
}

function fnCancelReqMatr(){
	fnMessageModalConfirm("Notification", "선택 요청을 처리취소하시겠습니까?", function(chk){
		if(chk){
			cancelReqMatr();
		}
	});
}

function cancelReqMatr() {
	
	var selc_rowid = $("#grid_req").jqGrid('getGridParam', 'selrow');
	
	if(selc_rowid == null || selc_rowid == 0)
	{
		fnMessageModalAlert("Notification(SCM)", "선택 된 데이터가 없습니다.");
 		return;
	}
	
	
	
	var page_url = "/frontend/scm/cancel_req_matr";
	var postData = 'ref_doc_no=' + encodeURIComponent(selc_rowid);
	
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		console.log(data);
	    		if(data.rows[0].ev_status == 'S') {
	    		fnMessageModalAlert("Notification(SCM)", "해당 오더가 취소되었습니다. <br/> ***sap 전송 결과*** <br/>ev_status : : " 
    					+ data.rows[0].ev_status	+ "<br/>ev_message : "+ data.rows[0].ev_message);
	    		} else {
	    			fnMessageModalAlert("Notification(SCM)", "해당 오더의 취소에 실패했습니다. <br/> ***sap 전송 결과*** <br/>ev_status : : " 
	    					+ data.rows[0].ev_status	+ "<br/>ev_message : "+ data.rows[0].ev_message);
	    		}
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	fnSearchReqMastGrid();
	    	$("#grid_req_sernr").jqGrid('clearGridData');
	    	$("#grid_req_bdmng").jqGrid('clearGridData');
	    	
	    	$("#btn_approval_cancel").hide();
	    	$("#btn_req_approval").hide();
	    	$("#req_conf").hide();
	    	$("#btn_req_cancel").hide();
	    }
	});
}

function approval_btn_chk() {
// 	if(rolenm == 'A' || rolenm == 'B' || rolenm == 'C') {
	if(true) {
		return true;
	} else {
		return false;
	}
}

function fnCancelApprovalMatr(){
	fnMessageModalConfirm("Notification", "선택 요청을 승인취소하시겠습니까?", function(chk){
		if(chk){
			cancelApprovalMatr();
		}
	});
}

function cancelApprovalMatr() {
var selc_rowid = $("#grid_req").jqGrid('getGridParam', 'selrow');
	
	if(selc_rowid == null || selc_rowid == 0)
	{
		fnMessageModalAlert("Notification(SCM)", "선택 된 데이터가 없습니다.");
 		return;
	}
	
	var page_url = "/frontend/scm/cancel_approval_matr";
	var postData = 'ref_doc_no=' + encodeURIComponent(selc_rowid);
	
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		console.log(data);
	    		fnMessageModalAlert("Notification(SCM)", "해당 오더가 승인취소되었습니다.");	
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	fnSearchReqMastGrid();
	    	$("#grid_req_sernr").jqGrid('clearGridData');
	    	$("#grid_req_bdmng").jqGrid('clearGridData');
	    	
	    	$("#btn_approval_cancel").hide();
	    	$("#btn_req_approval").hide();
	    	$("#req_conf").hide();
	    	$("#btn_req_cancel").hide();
	    }
	});
}

function getStrotageList() {

	initOptions($('#s_sloc'));

	var page_url = "/frontend/scm/cost_type_select"
		 
		$.ajax({
		    url: page_url,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    		$('#s_sloc').append($('<option>', { 
							value: '',
					        text : '-'
					    }));
					if( (data.rows).length>0 ){
						$.each(data.rows, function (i, item) {
							$('#s_sloc').append($('<option>', { 
								value: item.kostl,
						        text : item.ktext
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
</script>
</body>
</html>