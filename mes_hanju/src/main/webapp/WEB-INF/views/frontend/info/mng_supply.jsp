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
		<jsp:param name="selected_menu_cd" value="1122" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
        고객사 정보관리
        <small>기준정보관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 고객사 정보관리</a></li><li class="active">기준정보관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px;">
				<!-- Progress Bar 
				 	<div id="hiddenDivLoading" style="visibility:hidden">
					다중 코드 입력 창 iframe 
					    <iframe id="iframeLoading" frameborder="0" style="z-index:-1; position:absolute; visibility:hidden"></iframe>
 					        <div id='load_List'><img src='/img/loading.gif' /></div>
						
 					</div> -->
					<!-- Progress Bar -->

					<div class="box-header with-border">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
						    <!-- <button type="button" id="btn_create_id" class="btn btn-primary btn-sm" onclick="create_veid();">Mes계정 생성</button> |
					     	<button type="button" id="btn_sync_sap" class="btn btn-primary btn-sm" onclick="openSyncSAP();">SAP 동기화</button> | -->
					     	<button type="button" id="btn_create" class="btn btn-info btn-sm" onclick="insertVendor();">등록/수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-info btn-sm" onclick="deleteVendor();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="fnSetLoadVendorGrid();" class="btn btn-info btn-sm" onclick="">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
									<label>거래처코드</label> <input type="input" id="LIFNR" name="LIFNR" class="form-control input-sm" placeholder="ex) 100000"
										maxlength="10">
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									 <label>거래처명</label> <input type="input" id="name1" name="name1" class="form-control input-sm" placeholder="ex) 거래처명"
										maxlength="30">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="grid_vendor" style="width: 100%; height: 620px;"></div>
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
<div class="modal fade" id="modal_vendor" data-backdrop="static">
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
							<label for="" class="col-sm-3 control-label">거래처코드</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="vendor_code">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">거래처명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="name">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">국가</label>
							<div class="col-sm-7">
								<select class="form_group input-sm" id="land1">
									<option value="KR">KR</option>
									<option value="CH">CH</option>
									<option value="JA">JA</option>
								</select>
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
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">전화번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="telf1">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">팩스</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="telfx">
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
							<label for="" class="col-sm-3 control-label">대표자</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="j_1kfrepre">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사업자번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="company_no">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">계정그룹명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="txt30">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">전화</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="telf2">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">업태</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="j_1kftbus">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">업종</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="j_1kftind">
							</div>
						</div>
					</div>
					<!-- <div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">이전업체코드</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="altkn">
							</div>
						</div>
					</div> -->
					<div class="row">
						<div class="col-md-12" id="msg" style="font-weight:bold; color:blue;"></div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveVendor();">저장</button>
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
 	fnLoadVendorGrid()
})

function fnLoadCommonOption() {
	console.log('fnLoadCommonOption()');
	
	$('#request_date_range').daterangepicker({
		opens: 'right', 
		locale: {
			format: 'YYYY-MM-DD', // inputbox 에 '2011/04/29' 로표시
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			dayNames: ['일', '월', '화', '수', '목', '금', '토'],
			dayNames : ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear: true,
			yearSuffix: '년',
			orientation: "top left"
		},
	});
}
/* 
function openSyncSAP() {
	$("#msg").text("");
	$('#modal_sap_sync').modal('show');
} */
/* 
function confirmSapSync(){
	
	var date1 = $("#request_date_range").val().substring(0,10);
		date1 = replaceAll(date1, "-", "");
	var date2 = $("#request_date_range").val().substring(13,23);
		date2 = replaceAll(date2, "-", "");
	
	var page_url = "/sap_master/zmmfm_ven_master"
	var postData = "func_name=" + encodeURIComponent("ZMMFM_VEN_MASTER")
				 + "&IV_FDATE=" + encodeURIComponent(date1)
				 + "&IV_TDATE=" + encodeURIComponent(date2)
				 + "&IV_IF=X" ;
		
	$("#msg").text("동기화 작업 중...");
    $.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				$("#msg").text(data.message);
			} else {
				$("#msg").text("vendor master 수신에 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(vendor_insert)", "vendor master 수신에 실패했습니다.");
		},
		complete : function() {
			fnSetLoadVendorGrid();
		}
	});
} */
 
//serch parameter setting
function fnSetLoadVendorGrid(){
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
	});
}

function fnLoadVendorGrid(){
// 	 console.log(page_url);
	var rowArr = [];
	
	$('#grid_vendor').w2grid({ 
        name: 'grid_vendor',
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
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
// 			{ field:'altkn', caption:'이전업체코드', hidden:true} 
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
// 			console.log($('div.noResultsDiv').hasClass('jstHidden'));
// 			if ($('div.noResultsDiv').hasClass('jstHidden')) {
// 				$('div.noResultsDiv').removeClass('jstHidden');
// 		    }
}

function formatOpt1(cellvalue, options, rowObject){ 
	
	var pordno_pop = '\'' + rowObject.pordno_pop + '\'';
	var pordno_status = '\''+ rowObject.pordno_status + '\'';
	
	//return '<input type="button" onclick="mng_fault(\''+pordno_pop+'\','+'\''+pordno_status+'\')" class="btn btn-danger btn-sm" value="수정" /> '+ rowObject.pordno_status.substring(0, 5) + '.....';
	return '<input type="button" onclick="mng_fault('+pordno_pop+','+pordno_status+')" class="btn btn-danger btn-sm" value="수정" /> '+ rowObject.pordno_status.substring(0, 20) + '.....';
}

function mng_fault(pordno_pop, pordno_status ) {
	$("#m_pordno").val(pordno_pop);
	$("#pordno_status").val(pordno_status);
	$("#modal_mcode").modal('show');
}

function fnSaveMemo(){
	var postData = $("#frm_mcode").serializeArray();
	var formURL = "/frontend/prod/faultMemo_update";
	
	$.ajax({
	      url : formURL,
	      type: "POST",
	      data : postData,
	      success:function(data, textStatus, jqXHR){
	      	if(data.status == "200") {
	      		fnMessageModalAlert("Notification(Menu)", "입력하신 내용를 저장했습니다.");
	      		$("#modal_mcode").modal('hide');
	      		fnSearchMasterCodeGrid();
	      	} else {
	      		fnMessageModalAlert("Notification(Menu)", "메뉴를 저장하는데 에러가 발생하였습니다.");	
	      	}
	      },
	      error: function(jqXHR, textStatus, errorThrown){
	        fnMessageModalAlert("Notification(Menu)", "메뉴를 저장하는데 에러가 발생하였습니다.");	
	      }
	});
}
/* 
// vendor mes 계정및 role 자동 생성
function create_veid() {
// 	console.log('deleteRoutingDetail()');
   
	var selectJob =   w2ui.grid_vendor.get(w2ui.grid_vendor.getSelection());
	var key = w2ui.grid_vendor.getSelection();
	var groupInfo = w2ui.grid_vendor.get(key)[0];
	 
    var params = [];
    var record = this.record;
    var fields = this.fields;
    var dept_cd = '1063';
    
    for (var i=0, l=selectJob.length; i<l; i++) {
     	 
    	var selRow = {};
		 
		selRow.member_emp_no =w2ui.grid_vendor.get(w2ui.grid_vendor.getSelection()[i]).lifnr;
		selRow.member_id =w2ui.grid_vendor.get(w2ui.grid_vendor.getSelection()[i]).lifnr;
		selRow.member_email =w2ui.grid_vendor.get(w2ui.grid_vendor.getSelection()[i]).smtp_addr;
		selRow.member_pwd = "password('v1234')";
		selRow.member_nm = w2ui.grid_vendor.get(w2ui.grid_vendor.getSelection()[i]).name1;
		selRow.member_nm_en = '';
		selRow.company_cd ='1000';
		selRow.init_yn ='Y';
		selRow.pwd_chg_date ='';
		selRow.member_lang ='ko' ;
		
    	params.push(selRow); //배열에 맵처럼 담김      
 	
    }
        
    console.log(params);
 
	var gridData = w2ui.grid_vendor.get(w2ui.grid_vendor.getSelection());
	if( gridData.length==0 ){
		fnMessageModalAlert("Warning", "선택된 정보가 없습니다..");
		return;
	  
	} else {
		$.ajax({
		    url: "/frontend/hub/create_veid",
		    data: "dept_cd="+encodeURIComponent(dept_cd)+ "&params=" + encodeURIComponent(JSON.stringify(params)),
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    	fnMessageModalAlert("Notification(MES)", "정상적으로 처리되었습니다.");
			    	
			    	fnLoadVendorGrid();
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    }
		});
	}
} */

function insertVendor() {
	console.log('insertVendor()');
	/* $("#modal_vendor > .input-sm").val(''); */
	var key = w2ui.grid_vendor.getSelection();
	if( key.length==0 ) {
		// insert
// 		fnMessageModalAlert("Notification", "정상적으로 처리되었습니다.");
		$("#modal_code_title").text('등록');
 		$("#vendor_code").attr('disabled',true);
		$("#name").val('');
		$("#land1").val('');
		$("#addr").val('');
		$("#telf1").val('');
		$("#telfx").val('');
		$("#smtp_addr").val('');
		$("#company_no").val('');
		$("#j_1kfrepre").val('');
		$("#txt30").val('');
		$("#telf2").val('');
		$("#j_1kftbus").val('');
		$("#j_1kftind").val('');
	} else if( key.length==1 ) {
		// update
		$("#modal_code_title").text('수정');
		var data = w2ui.grid_vendor.get(key[0]);
		$("#vendor_code").attr('disabled',true);
		$("#vendor_code").val(data.vendor_code);
		$("#name").val(data.name);
		$("#land1").val(data.land1);
		$("#addr").val(data.addr);
		$("#telf1").val(data.telf1);
		$("#telfx").val(data.telfx);
		$("#smtp_addr").val(data.smtp_addr);
		$("#company_no").val(data.company_no);
		$("#j_1kfrepre").val(data.j_1kfrepre);
		$("#txt30").val(data.txt30);
		$("#telf2").val(data.telf2);
		$("#j_1kftbus").val(data.j_1kftbus);
		$("#j_1kftind").val(data.j_1kftind);
	} else {
		fnMessageModalAlert("Notification", "수정하고자 하는 항목을 1개 선택하여야 합니다.");
	}
	
	$("#modal_vendor").modal('show');
}

function saveVendor() {
	console.log('saveVendor()');
	
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
		
	console.log($("#vendor_code").val());
	console.log($("#name").val());
	console.log($("#land1").val());
	console.log($("#addr").val());
	console.log($("#telf1").val());
	console.log($("#telfx").val());
	console.log($("#smtp_addr").val());
	console.log($("#company_no").val());
	console.log($("#j_1kfrepre").val());
	console.log($("#txt30").val());
	console.log($("#telf2").val());
	console.log($("#j_1kftbus").val());
	console.log($("#j_1kftind").val());
	
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
	});
}

function deleteVendor() {
	console.log('deleteVendor()');

	var keys = w2ui.grid_vendor.getSelection();
	if( keys.length==0 ) {
		fnMessageModalAlert("Notification", "삭제하고자 하는 항목을 1개 선택하여야 합니다.");
		return;
	} else {
		var vCodeList = [];
		$.each(keys, function(idx, key){
			var data = w2ui.grid_vendor.get(key);
			vCodeList.push(data.vendor_code);
		});
		var strUrl = "/frontend/hub/deleteVendor?codeList=" + vCodeList;
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
		});
		/* 
		// update
		$("#modal_code_title").text('수정');
		var data = w2ui.grid_vendor.get(key[0]);
		$("#vendor_code").attr('disabled',true);
		$("#vendor_code").val(data.vendor_code);
		$("#name").val(data.name);
		$("#land1").val(data.land1);
		$("#addr").val(data.addr);
		$("#telf1").val(data.telf1);
		$("#telfx").val(data.telfx);
		$("#smtp_addr").val(data.smtp_addr);
		$("#company_no").val(data.company_no);
		$("#j_1kfrepre").val(data.j_1kfrepre);
		$("#txt30").val(data.txt30);
		$("#telf2").val(data.telf2);
		$("#j_1kftbus").val(data.j_1kftbus);
		$("#j_1kftind").val(data.j_1kftind); */
	} 
}
</script>

</body>
</html>