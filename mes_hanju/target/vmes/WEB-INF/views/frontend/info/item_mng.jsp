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
		<jsp:param name="selected_menu_cd" value="1125" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
       	 제품 관리
        <small>기준정보관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 제품 관리</a></li><li class="active">기준정보관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px;">
					<div class="box-header with-border">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
						    <!-- <button type="button" id="btn_create_id" class="btn btn-primary btn-sm" onclick="create_veid();">Mes계정 생성</button> |
					     	<button type="button" id="btn_sync_sap" class="btn btn-primary btn-sm" onclick="openSyncSAP();">SAP 동기화</button> | -->
					     	<button type="button" id="btn_create" class="btn btn-info btn-sm" onclick="insertItem();">등록/수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-info btn-sm" onclick="deleteItem();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="fnLoadItemGrid();" class="btn btn-info btn-sm" onclick="">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-2" style="padding-right: 0px;">
								<div class="form-group">
									<label>고객사명</label> <input type="input" id="vendor_name" name="vendor_name" class="form-control input-sm">
								</div>
							</div>
							<div class="col-sm-1" >
								<div style="line-height: 24px;">
									<br>
									<button type="button" id="" class="btn btn-info btn-sm" onclick="fnSearchVendor();"><i class="fa fa-search"></i></button>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									 <label>제품명</label> <input type="input" id="item_name" name="item_name" class="form-control input-sm">
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									 <label>제품번호</label> <input type="input" id="item_code" name="item_code" class="form-control input-sm">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="grid_item" style="width: 100%; height: 620px;"></div>
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
<div class="modal fade" id="modal_item" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_title">등록</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">제품코드</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="col6" disabled>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">고객사</label>
							<div class="col-sm-1">
								<button type="button" id="" class="btn btn-info btn-sm" onclick="fnSearchVendor();"><i class="fa fa-search"></i></button>
							</div>
							<div class="col-sm-6">
								<input type="text" class="form-control input-sm pull-right" id="vendor_name">
								<input type="hidden" class="form-control input-sm pull-right" id="vendor_code">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">차종</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="col1">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">품명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="col2">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">품번</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="col3">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">생산여부</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="col4">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">설명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="col5">
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveItem();">저장</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- vendor modal -->
<div class="modal fade" id="modal_vendor" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_vtitle">거래처 목록</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<div id="grid_vendor" style="width: 100%; height: 500px;"></div>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-success btn-sm" onclick="fnSelectVendor();">저장</button>
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
 	fnSetItemGrid();
 	fnSetVendorGrid();
})

function fnLoadCommonOption() {
	console.log('fnLoadCommonOption()');
}
 
//serch parameter setting
function fnLoadItemGrid(){
	console.log('fnLoadItemGrid()');
	/* var page_url = "/frontend/hub/selectVendortbl"
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

function fnSetItemGrid(){
	console.log('fnSetItemGrid()');
	
	var rowArr = [];
	
	$('#grid_item').w2grid({ 
        name: 'grid_item',
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
			{ field:'col1', caption:'item code', hidden:true},
			{ field:'col2', caption:'차종', size:'10%', style:'text-align:center'},
			{ field:'col3', caption:'품명', size:'10%', style:'text-align:center'},
			{ field:'col4', caption:'품번', size:'10%', style:'text-align:center'},
			{ field:'col5', caption:'생산여부', size:'10%'},
			{ field:'col6', caption:'고객사 코드', hidden:true},
			{ field:'col7', caption:'고객사명', size:'15%'},
			{ field:'col8', caption:'설명', size:'15%'}
			], 
		records: rowArr,
		onReload: function(event) {
			fnLoadItemGrid();
		},
		onClick: function (event) {}
	});
	fnLoadItemGrid();
}

function fnSetVendorGrid(){
//	 console.log(page_url);
	var rowArr = [];
	
	$('#grid_vendor').w2grid({ 
       name: 'grid_vendor',
       show: {
			toolbar: true,
			selectColumn: true,
			lineNumbers : true,
			footer: true
       },
       multiSearch: true,
       searches: [
                  { field: 'name', caption: '거래처명 ', type: 'text' },
                  { field: 'company_no', caption: '사업자번호', type: 'text' }
              ],
       columns: [                
			{ field:'vendor_code', caption:'거래처코드', size:'80px', style:'text-align:center', frozen: true},
			{ field:'id_yn', caption:'계정생성', size:'70px', style:'font-weight:bold;color:blue;background-color:rgba(255,255,0,0.3);text-align:center', frozen: true},
			{ field:'name', caption:'거래처명', size:'200px', frozen: true},
			{ field:'land1', caption:'국가', size:'50px', style:'text-align:center', frozen: true},
			{ field:'addr', caption:'주소', size:'150px'},
			{ field:'telf1', caption:'전화번호', size:'120px', style:'text-align:right'},
			{ field:'telfx', caption:'팩스', size:'120px', style:'text-align:center'},
			{ field:'smtp_addr', caption:'이메일주소', size:'200px', style:'text-align:center'},
			{ field:'company_no', caption:'사업자번호', size:'120px', style:'text-align:center'},
			{ field:'j_1kfrepre', caption:'대표자', size:'100px', style:'text-align:center'},
			{ field:'txt30', caption:'계정그룹명', hidden:true},
			{ field:'telf2', caption:'이동전화', hidden:true},
			{ field:'j_1kftbus', caption:'업태', hidden:true},
			{ field:'j_1kftind', caption:'업종', hidden:true}
//			{ field:'altkn', caption:'이전업체코드', hidden:true} 
			], 
		sortData: [{field: 'lifnr', direction: 'ASC'}],
		records: rowArr,
		onReload: function(event) {
			fnSetLoadVendorGrid();
		},
		onClick: function (event) {}
	});
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
	});
//			console.log($('div.noResultsDiv').hasClass('jstHidden'));
//			if ($('div.noResultsDiv').hasClass('jstHidden')) {
//				$('div.noResultsDiv').removeClass('jstHidden');
//		    }
}

function insertItem() {
	console.log('insertItem()');
	var key = w2ui.grid_item.getSelection();
	if( key.length==0 ) {
		// insert
// 		fnMessageModalAlert("Notification", "정상적으로 처리되었습니다.");
		$("#modal_title").text('등록');
		$("#col1").val('');
		$("#col2").val('');
		$("#col3").val('');
		$("#col4").val('');
		$("#col5").val('');
	} else if( key.length==1 ) {
		// update
		$("#modal_title").text('수정');
		var data = w2ui.grid_item.get(key[0]);
		$("#col6").val(data.col6);
		$("#col1").val(data.col1);
		$("#col2").val(data.col2);
		$("#col3").val(data.col3);
		$("#col4").val(data.col4);
		$("#col5").val(data.col5);
	} else {
		fnMessageModalAlert("Notification", "수정하고자 하는 항목을 1개 선택하여야 합니다.");
	}
	
	$("#modal_item").modal('show');
}

function saveItem() {
	console.log('saveItem()');
	/*
	var vendor_code = $("#vendor_code").val();
	var name = $("#name").val();
	var land1 = $("#land1").val();
	var addr = $("#addr").val();
	var telf1 = $("#telf1").val();
	var telfx = $("#telfx").val();
	var smtp_addr = $("#smtp_addr").val();
	var company_no = $("#company_no").val();
	var j_1kfrepre = $("#j_1kfrepre").val();
	var txt30 = $("#txt30").val();
	var telf2 = $("#telf2").val();
	var j_1kftbus = $("#j_1kftbus").val();
	var j_1kftind = $("#j_1kftind").val();
	
	var flag = nullToBlank(vendor_code)==''?"I":"U";
		
	$("#modal_vendor").modal('hide');
	
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

function deleteItem() {
	console.log('deleteItem()');

	var keys = w2ui.grid_item.getSelection();
	if( keys.length==0 ) {
		fnMessageModalAlert("Notification", "삭제하고자 하는 항목을 1개 선택하여야 합니다.");
		return;
	} else {
		var vCodeList = [];
		$.each(keys, function(idx, key){
			var data = w2ui.grid_item.get(key);
			vCodeList.push(data.grid_item);
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

function fnSearchVendor() {
	console.log('fnSearchVendor()');
	
	$("#modal_vendor").modal('show');
	
	setTimeout(function(){
		w2ui['grid_vendor'].resize();
		w2ui['grid_vendor'].refresh();
	}, 200);
	
}
</script>

</body>
</html>