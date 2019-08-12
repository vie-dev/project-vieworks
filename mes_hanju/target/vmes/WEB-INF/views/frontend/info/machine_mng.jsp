<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
// jsp properties
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
	
	<style type="text/css">
		.ichk_label {
			font-weight: unset;
    		font-size: 12px; }
	</style>
</head>

<body class="hold-transition skin-<%=thema%> sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1121" />
		<jsp:param name="selected_menu_cd" value="1124" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header" style="padding-bottom: 0px;">
      <h1>
        설비정보 관리
        <small>기준정보관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 설비정보 관리</a></li><li class="active">기준정보관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-md-6">
				<div class="box box-info box-solid" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">설비 목록</h3>
						<div class="box-tools pull-right">
						    <!-- <button type="button" id="btn_create_id" class="btn btn-primary btn-sm" onclick="create_veid();">Mes계정 생성</button> |
					     	<button type="button" id="btn_sync_sap" class="btn btn-primary btn-sm" onclick="openSyncSAP();">SAP 동기화</button> | -->
					     	<button type="button" id="btn_create" class="btn btn-warning btn-sm" onclick="insertMacM();">등록/수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-warning btn-sm" onclick="deleteMacM();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="fnLoadMacMGrid();" class="btn btn-warning btn-sm" onclick="">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row" style="padding-bottom: 10px;">
							<div class="col-sm-2 text-right" style="line-height: 30px;">
								<label>설비명</label> 
							</div>
							<div class="col-sm-3">
								<input type="input" id="s_name" name="name" class="form-control input-sm" maxlength="10">
							</div>
							<div class="col-sm-1"></div>
							<div class="col-sm-2 text-right" style="line-height: 30px;">
								<label>모델</label> 
							</div>
							<div class="col-sm-3">
								<input type="input" id="s_addr" name="addr" class="form-control input-sm" maxlength="30">
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div id="grid_macM" style="width: 100%; height: 650px;"></div>
							</div>
						</div>
					</div>
				</div>
			</section>
			<section class="col-md-6" style="padding-left: 0px;">
				<div class="box box-info box-solid" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">공구 목록</h3>
						<div class="box-tools pull-right">
					     	<button type="button" id="btn_create" class="btn btn-warning btn-sm" onclick="insertMacC();">등록/수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-warning btn-sm" onclick="deleteMacC();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="fnLoadMacCGrid();" class="btn btn-warning btn-sm" onclick="">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row" style="padding-bottom: 10px;">
							<div class="col-sm-2 text-right" style="line-height: 30px;">
								<label>공구명</label> 
							</div>
							<div class="col-sm-3">
								<input type="input" id="s_name" name="name" class="form-control input-sm" maxlength="10">
							</div>
							<div class="col-sm-1"></div>
							<div class="col-sm-2 text-right" style="line-height: 30px;">
								<label>모델</label> 
							</div>
							<div class="col-sm-3">
								<input type="input" id="s_addr" name="addr" class="form-control input-sm" maxlength="30">
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div id="grid_macC" style="width: 100%; height: 650px;"></div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
<!-- 설비 정보 modal -->
<div class="modal fade" id="modal_macM" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="macm_title">등록</h4>
        	</div>
			<div class="modal-body">
				<form id="frm_macm" name="frm_macm" class="form-horizontal">
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">설비코드</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="macm_code">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">설비명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="macm_name">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">모델</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="macm_model">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">설명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="macm_desc">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12" id="msg" style="font-weight:bold; color:blue;"></div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveMacM();">저장</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 공구 정보 modal -->
<div class="modal fade" id="modal_macC" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="macc_title">등록</h4>
        	</div>
			<div class="modal-body">
				<form id="frm_macc" name="frm_macc" class="form-horizontal">
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">공구코드</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="macc_code">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">공구명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="macc_name">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">모델</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="macc_model">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">최종교환일</label>
							<div class="col-sm-7">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right input-sm" id="macc_chndate">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">설명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="macc_desc">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12" id="msg" style="font-weight:bold; color:blue;"></div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveMacC();">저장</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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
</div>
<!-- ./wrapper -->

<script type="text/javascript">
$(function($) {
 	fnLoadCommonOption(); 	 
 	fnSetMacMGrid();
 	fnSetMacCGrid();
})

// init Component
function fnLoadCommonOption() {
	console.log('fnLoadCommonOption()');
	
	var minDate = getFormatDate(new Date());
	$('#macc_chndate').daterangepicker({
		opens: 'right', 
		singleDatePicker: true,
		locale: {
			format: 'YYYY-MM-DD', // inputbox 에 '2011/04/29' 로표시
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
			showMonthAfterYear: true,
			yearSuffix: '년',
			orientation: "top left"
		},
		startDate : moment(minDate)
	});
}

function getFormatDate(d) {
	var month = d.getMonth() + 1;
	var date = d.getDate();
	month = (month < 10) ? "0" + month : month;
	date = (date < 10) ? "0" + date : date;
	return d.getFullYear() + '-' + month + '-' + date;
}

//search 설비목록
function fnLoadMacMGrid(){
	console.log('fnLoadMacMGrid()');
	var rowArr = [
	              {recid:1, col1:'111', col2:'설비1', col3:'A', col4:'test1', col5:'', col6:'', col7:'', col8:''},
	              {recid:2, col1:'222', col2:'설비2', col3:'A', col4:'test2', col5:'', col6:'', col7:'', col8:''},
	              {recid:3, col1:'333', col2:'설비3', col3:'B', col4:'test3', col5:'', col6:'', col7:'', col8:''},
	              {recid:4, col1:'444', col2:'설비4', col3:'C', col4:'test4', col5:'', col6:'', col7:'', col8:''},
	              {recid:5, col1:'555', col2:'설비5', col3:'D', col4:'test5', col5:'', col6:'', col7:'', col8:''} ];
	
	w2ui.grid_macM.record = rowArr;
	
	/* 
	var page_url = "/frontend/hub/selectVendortbl"
				 + "?name=" + encodeURIComponent($("#name1").val()) 
				 + "&vendor_code=" + encodeURIComponent($("#LIFNR").val());
	
	w2ui['grid_vendor'].lock('loading...', true);
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
				w2ui['grid_vendor'].records = rowArr;
			}
			w2ui['grid_vendor'].refresh();
			w2ui['grid_vendor'].unlock();
		},complete: function () {}
	}); */
}

//search 공구목록
function fnLoadMacCGrid(macM_code){
	console.log('fnLoadMacCGrid()');
	
	var dataArr = [
	              {recid:1, col6:'111', col1:'111', col2:'공구1', col3:'w', col4:'2019-07-01', col5:'test'},
	              {recid:2, col6:'222', col1:'222', col2:'공구2', col3:'r', col4:'2019-07-01', col5:'test'},
	              {recid:3, col6:'333', col1:'333', col2:'공구3', col3:'f', col4:'2019-07-01', col5:'test'},
	              {recid:4, col6:'444', col1:'444', col2:'공구4', col3:'e', col4:'2019-07-01', col5:'test'},
	              {recid:5, col6:'444', col1:'444', col2:'공구5', col3:'g', col4:'2019-07-01', col5:'test'},
	              {recid:6, col6:'444', col1:'444', col2:'공구6', col3:'e', col4:'2019-07-01', col5:'test'},
	              {recid:7, col6:'777', col1:'777', col2:'공구7', col3:'g', col4:'2019-07-01', col5:'test'},
	              {recid:8, col6:'888', col1:'888', col2:'공구8', col3:'w', col4:'2019-07-01', col5:'test'},
	              {recid:9, col6:'999', col1:'999', col2:'공구9', col3:'q', col4:'2019-07-01', col5:'test'},
	              {recid:10, col6:'555',  col1:'555', col2:'공구10', col3:'e', col4:'2019-07-01', col5:'test'}
	              ];
	var arr = [];
	
	if( nullToBlank(macM_code)=='' ) {
		w2ui['grid_macC'].records = dataArr;
	} else {
		$.each(dataArr, function(idx, row){
			if(row.col6==macM_code) {
				arr.push(row);
			}
		});
		$.each(arr, function(idx, row){
			row.recid = idx+1;
		});
		w2ui['grid_macC'].records = arr;
	}
	w2ui['grid_macC'].refresh();
	/* 
	var page_url = "/frontend/hub/selectVendortbl"
				 + "?name=" + encodeURIComponent($("#name1").val()) 
				 + "&vendor_code=" + encodeURIComponent($("#LIFNR").val());
	
	w2ui['grid_vendor'].lock('loading...', true);
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
				w2ui['grid_vendor'].records = rowArr;
			}
			w2ui['grid_vendor'].refresh();
			w2ui['grid_vendor'].unlock();
		},complete: function () {}
	}); */
}

// init 설비목록
function fnSetMacMGrid(){
// 	 console.log('fnSetMacMGrid()');
	var rowArr = [
	              {recid:1, col1:'111', col2:'설비1', col3:'A', col4:'test1', col5:'', col6:'', col7:'', col8:''},
	              {recid:2, col1:'222', col2:'설비2', col3:'A', col4:'test2', col5:'', col6:'', col7:'', col8:''},
	              {recid:3, col1:'333', col2:'설비3', col3:'B', col4:'test3', col5:'', col6:'', col7:'', col8:''},
	              {recid:4, col1:'444', col2:'설비4', col3:'C', col4:'test4', col5:'', col6:'', col7:'', col8:''},
	              {recid:5, col1:'555', col2:'설비5', col3:'D', col4:'test5', col5:'', col6:'', col7:'', col8:''} ];
	
	$('#grid_macM').w2grid({ 
        name: 'grid_macM',
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
			{ field:'col1', caption:'설비코드', hidden:true},
			{ field:'col2', caption:'설비명', size:'20%'},
			{ field:'col3', caption:'모델', size:'30%'},
			{ field:'col4', caption:'설명', size:'50%'},
			{ field:'col5', caption:'등록자', hidden:true},
			{ field:'col6', caption:'수정자', hidden:true},
			{ field:'col7', caption:'등록일', hidden:true},
			{ field:'col8', caption:'수정일', hidden:true}
		], 
// 		sortData: [{field: 'lifnr', direction: 'ASC'}],
		records: rowArr,
		onReload: function(event) {
			fnLoadMacMGrid();
		},
		onClick: function (event) {
			var mscM_code = (this.records[Number(event.recid)-1]).col1;
// 			console.log(mscM_code);
			// search 공구목록
			fnLoadMacCGrid(mscM_code);
		}
	});
	fnLoadMacMGrid();
}

// init 공구목록
function fnSetMacCGrid(){
// 	 console.log('fnSetMacCGrid()');
	var rowArr = [
	              {recid:1, col6:'111', col1:'111', col2:'공구1', col3:'w', col4:'2019-07-01', col5:'test'},
	              {recid:2, col6:'222', col1:'222', col2:'공구2', col3:'r', col4:'2019-07-01', col5:'test'},
	              {recid:3, col6:'333', col1:'333', col2:'공구3', col3:'f', col4:'2019-07-01', col5:'test'},
	              {recid:4, col6:'444', col1:'444', col2:'공구4', col3:'e', col4:'2019-07-01', col5:'test'},
	              {recid:5, col6:'444', col1:'444', col2:'공구5', col3:'g', col4:'2019-07-01', col5:'test'},
	              {recid:6, col6:'444', col1:'444', col2:'공구6', col3:'e', col4:'2019-07-01', col5:'test'},
	              {recid:7, col6:'777', col1:'777', col2:'공구7', col3:'g', col4:'2019-07-01', col5:'test'},
	              {recid:8, col6:'888', col1:'888', col2:'공구8', col3:'w', col4:'2019-07-01', col5:'test'},
	              {recid:9, col6:'999', col1:'999', col2:'공구9', col3:'q', col4:'2019-07-01', col5:'test'},
	              {recid:10, col6:'555',  col1:'555', col2:'공구10', col3:'e', col4:'2019-07-01', col5:'test'}
	              ];
	
	$('#grid_macC').w2grid({ 
        name: 'grid_macC',
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
			{ field:'col1', caption:'공구코드', hidden:true},
			{ field:'col2', caption:'공구명', size:'20%'},
			{ field:'col3', caption:'모델', size:'30%'},
			{ field:'col4', caption:'최종교환일 ', size:'50%'},
			{ field:'col5', caption:'설명', size:'50%'},
			{ field:'col6', caption:'설비코드', hidden:true}
// 			{ field:'col1', caption:'등록자', hidden:true},
// 			{ field:'col1', caption:'수정자', hidden:true},
// 			{ field:'col1', caption:'등록일', hidden:true},
// 			{ field:'col1', caption:'수정일', hidden:true}
		], 
// 		sortData: [{field: 'lifnr', direction: 'ASC'}],
		records: rowArr,
		onReload: function(event) {
			fnLoadMacCGrid();
		},
		onClick: function (event) {}
	});
	fnLoadMacCGrid();
}

function insertMacM() {
	console.log('insertMacM()');

	var key = w2ui.grid_macM.getSelection();
	if( key.length==0 ) {
		// insert
// 		fnMessageModalAlert("Notification", "정상적으로 처리되었습니다.");
		$("#macm_title").text('등록');
 		$("#macm_code").attr('disabled',true);
 		$("#macm_code").val('');
		$("#macm_name").val('');
		$("#macm_model").val('');
		$("#macm_desc").val('');
	} else if( key.length==1 ) {
		// update
		$("#macm_title").text('수정');
		var data = w2ui.grid_macM.get(key[0]);
		$("#macm_code").attr('disabled',true);
		$("#macm_code").val(data.col1);
		$("#macm_name").val(data.col2);
		$("#macm_model").val(data.col3);
		$("#macm_desc").val(data.col4);
	} else {
		fnMessageModalAlert("Notification", "수정하고자 하는 항목을 1개 선택하여야 합니다.");
	}
	
	$("#modal_macM").modal('show');
}

function saveMacM() {
	console.log('saveMacM()');
	
	var macm_code = $("#macm_code").val();
	var macm_name = $("#macm_name").val();
	var macm_model = $("#macm_model").val();
	var macm_desc = $("#macm_desc").val();
	
	var flag = nullToBlank(macm_code)==''?"I":"U";
		
	$("#modal_macM").modal('hide');
	/* 
	var strUrl = "/frontend/hub/saveVendor?flag=" + flag
			   + "&vendor_code=" + vendor_code
			   + "&name=" + name
			   + "&land1=" + land1
			   + "&addr=" + addr
			   + "&telf1=" + telf1
			   + "&telfx=" + telfx
			   + "&smtp_addr=" + smtp_addr
			   + "&company_no=" + company_no
			   + "&j_1kfrepre=" + j_1kfrepre
			   + "&txt30=" + txt30
			   + "&telf2=" + telf2
			   + "&j_1kftbus=" + j_1kftbus
			   + "&j_1kftind=" + j_1kftind;
	$.ajax({
	    url: strUrl,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalAlert("Notification(MES)", "정상적으로 처리되었습니다.");
		    	fnSetLoadVendorGrid();
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    }
	}); */
}

function deleteMacM() {
	console.log('deleteMacM()');

	var keys = w2ui.grid_macM.getSelection();
	if( keys.length==0 ) {
		fnMessageModalAlert("Notification", "삭제하고자 하는 항목을 1개 선택하여야 합니다.");
		return;
	} else {
		var vCodeList = [];
		$.each(keys, function(idx, key){
			var data = w2ui.grid_macM.get(key);
			vCodeList.push(data.macm_code);
		});
		/* var strUrl = "/frontend/hub/deleteVendor?codeList=" + vCodeList;
		$.ajax({
			 url: strUrl,
			 type: "POST",
			 async : false,
			 success:function(data, textStatus, jqXHR){
			 	if(data.status == "200") {
			 		console.log(data);
			 		fnSetLoadVendorGrid();
			    	fnMessageModalAlert("Notification(MES)", "정상적으로 처리되었습니다.");
			 	}
			 },
			 error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
			 },
			 complete: function() {
			 }
		}); */
	} 
}

function insertMacC() {
	console.log('insertMacC()');

	var key = w2ui.grid_macC.getSelection();
	if( key.length==0 ) {
		// insert
// 		fnMessageModalAlert("Notification", "정상적으로 처리되었습니다.");
		$("#macc_title").text('등록');
 		$("#macc_code").attr('disabled',true);
 		$("#macc_code").val('');
		$("#macc_name").val('');
		$("#macc_model").val('');
		$("#macc_chndate").val('');
		$("#macc_desc").val('');
	} else if( key.length==1 ) {
		// update
		$("#macc_title").text('수정');
		var data = w2ui.grid_macC.get(key[0]);
		$("#macc_code").attr('disabled',true);
		$("#macc_code").val(data.col1);
		$("#macc_name").val(data.col2);
		$("#macc_model").val(data.col3);
		$("#macc_chndate").val(data.col4);
		$("#macc_desc").val(data.col5);
	} else {
		fnMessageModalAlert("Notification", "수정하고자 하는 항목을 1개 선택하여야 합니다.");
	}
	
	$("#modal_macC").modal('show');
}

function saveMacC() {
	console.log('saveMacC()');
	
	var macc_code = $("#macc_code").val();
	var macc_name = $("#macc_name").val();
	var macc_model = $("#macc_model").val();
	var macc_desc = $("#macc_desc").val();
	
	var flag = nullToBlank(macc_code)==''?"I":"U";
		
	$("#modal_macC").modal('hide');
	/* 
	var strUrl = "/frontend/hub/saveVendor?flag=" + flag
			   + "&vendor_code=" + vendor_code
			   + "&name=" + name
			   + "&land1=" + land1
			   + "&addr=" + addr
			   + "&telf1=" + telf1
			   + "&telfx=" + telfx
			   + "&smtp_addr=" + smtp_addr
			   + "&company_no=" + company_no
			   + "&j_1kfrepre=" + j_1kfrepre
			   + "&txt30=" + txt30
			   + "&telf2=" + telf2
			   + "&j_1kftbus=" + j_1kftbus
			   + "&j_1kftind=" + j_1kftind;
	$.ajax({
	    url: strUrl,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalAlert("Notification(MES)", "정상적으로 처리되었습니다.");
		    	fnSetLoadVendorGrid();
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    }
	}); */
}

function deleteMacC() {
	console.log('deleteMacC()');

	var keys = w2ui.grid_macC.getSelection();
	if( keys.length==0 ) {
		fnMessageModalAlert("Notification", "삭제하고자 하는 항목을 1개 선택하여야 합니다.");
		return;
	} else {
		var vCodeList = [];
		$.each(keys, function(idx, key){
			var data = w2ui.grid_macC.get(key);
			vCodeList.push(data.macc_code);
		});
		/* var strUrl = "/frontend/hub/deleteVendor?codeList=" + vCodeList;
		$.ajax({
			 url: strUrl,
			 type: "POST",
			 async : false,
			 success:function(data, textStatus, jqXHR){
			 	if(data.status == "200") {
			 		console.log(data);
			 		fnSetLoadVendorGrid();
			    	fnMessageModalAlert("Notification(MES)", "정상적으로 처리되었습니다.");
			 	}
			 },
			 error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
			 },
			 complete: function() {
			 }
		}); */
	} 
}
</script>

</body>
</html>