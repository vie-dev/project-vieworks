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
		<jsp:param name="selected_menu_cd" value="1123" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
        작업자 정보관리
        <small>기준정보관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 작업자 정보관리</a></li><li class="active">기준정보관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px;">
					<!-- Progress Bar -->
					<div class="box-header with-border">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
						    <!-- <button type="button" id="btn_create_id" class="btn btn-primary btn-sm" onclick="create_veid();">Mes계정 생성</button> |
					     	<button type="button" id="btn_sync_sap" class="btn btn-primary btn-sm" onclick="openSyncSAP();">SAP 동기화</button> | -->
					     	<button type="button" id="btn_create" class="btn btn-info btn-sm" onclick="insertWorker();">등록/수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-info btn-sm" onclick="deleteWorker();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="fnLoadWorkerGrid();" class="btn btn-info btn-sm" onclick="">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
									<label>이름</label> <input type="input" id="s_name" name="name" class="form-control input-sm" maxlength="10">
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									 <label>주소</label> <input type="input" id="s_addr" name="addr" class="form-control input-sm" maxlength="30">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="grid_worker" style="width: 100%; height: 620px;"></div>
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
<div class="modal fade" id="modal_worker" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">등록</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">아이디</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="id">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">성명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="name">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">연락처(mobile)</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="phone1">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">연락처(home)</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="phone2">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">이메일주소</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="smtp_addr">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">주소</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="addr">
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
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveWorker();">저장</button>
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
 	fnSetLoadWorkerGrid()
})

// init component
function fnLoadCommonOption() {
// 	console.log('fnLoadCommonOption()');
}
 
// search list
function fnLoadWorkerGrid(){
// 	console.log('fnLoadWorkerGrid()');
	/* 
	var page_url = "/frontend/hub/selectVendortbl"
		 + "?func_name=" + encodeURIComponent("selectVendortbl")
		 + "&NAME1=" + encodeURIComponent($("#name1").val())
		 + "&LIFNR=" + encodeURIComponent($("#LIFNR").val());

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

// init grid
function fnSetLoadWorkerGrid(){
// 	 console.log('fnSetLoadWorkerGrid()');
	var rowArr = [];
	
	$('#grid_worker').w2grid({ 
        name: 'grid_worker',
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
			{ field:'id', caption:'아이디', size:'80px', style:'text-align:center'},
			{ field:'name', caption:'이름', size:'200px', frozen: true},
			{ field:'email', caption:'이메일주소', size:'200px'},
			{ field:'phone1', caption:'핸드폰', size:'120px' },
			{ field:'phone2', caption:'집전화', size:'120px'},
			{ field:'addr', caption:'주소', size:'150px'}
			], 
		sortData: [{field: 'id', direction: 'ASC'}],
		records: rowArr,
		onReload: function(event) {
			fnLoadWorkerGrid();
		},
		onClick: function (event) {}
	});
	fnLoadWorkerGrid();
}

function insertWorker() {
// 	console.log('insertWorker()');
	var key = w2ui.grid_worker.getSelection();
	if( key.length==0 ) {
		// insert
		$("#modal_code_title").text('등록');
 		$("#id").attr('disabled',true);
		$("#name").val('');
		$("#phone1").val('');
		$("#phone2").val('');
		$("#email").val('');
		$("#addr").val('');
	} else if( key.length==1 ) {
		// update
		$("#modal_code_title").text('수정');
		var data = w2ui.grid_vendor.get(key[0]);
		$("#id").attr('disabled',true);
		$("#name").val(data.name);
		$("#phone1").val(data.land1);
		$("#phone2").val(data.addr);
		$("#email").val(data.j_1kftbus);
		$("#addr").val(data.j_1kftind);
	} else {
		fnMessageModalAlert("Notification", "수정하고자 하는 항목을 1개 선택하여야 합니다.");
	}
	$("#modal_worker").modal('show');
}

function saveWorker() {
// 	console.log('saveWorker()');
	
	var id = $("#id").val();
	var name = $("#name").val();
	var phone1 = $("#phone1").val();
	var phone2 = $("#phone2").val();
	var email = $("#email").val();
	var addr = $("#addr").val();
	
	var flag = nullToBlank(id)==''?"I":"U";
	/* 	
	console.log(id);
	console.log(name);
	console.log(phone1);
	console.log(phone2);
	console.log(email);
	console.log(addr); */
	
	$("#modal_worker").modal('hide');
	/*
	save ajax flow
	*/
}

function deleteWorker() {
// 	console.log('deleteWorker()');

	var keys = w2ui.grid_worker.getSelection();
	if( keys.length==0 ) {
		fnMessageModalAlert("Notification", "삭제하고자 하는 항목을 1개 선택하여야 합니다.");
		return;
	} else {
		var vCodeList = [];	// delete key array
		$.each(keys, function(idx, key){
			var data = w2ui.grid_worker.get(key);
// 			vCodeList.push(data.vendor_code);
		});
		/* 
		delete ajax flow
		var strUrl = "/frontend/hub/deleteVendor?codeList=" + vCodeList;
		$.ajax({
			 url: strUrl,
			 type: "POST",
			 async : false,
			 success:function(data, textStatus, jqXHR){
			 	if(data.status == "200") {
			 		console.log(data);
			 		fnSetLoadWorkerGrid();
			    	fnMessageModalAlert("Notification(MES)", "정상적으로 처리되었습니다.");
			 	}
			 },
			 error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
			 },
			 complete: function() {
			 }
		}); 
		*/
	} 
}
</script>

</body>
</html>