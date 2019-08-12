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
</head>

<body class="hold-transition skin-<%=thema%> sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1020" />
		<jsp:param name="selected_menu_cd" value="1021" />
	</jsp:include>

	<div class="content-wrapper">
	    <section class="content-header">
	        <h1>
	           	생산품 재고 관리
	            <small>HUB</small>
	        </h1>
	        <ol class="breadcrumb">
	            <li><a href="#"><i class="fa fa-dashboard"></i> 생산품 재고 관리</a></li>
	            <li class="active">HUB</li>
	        </ol>
	    </section>
	
	    <!-- Main content -->
		<section class="content" style="padding-bottom: 0px;">
			<div class="box" style="margin-bottom: 0px;height: 760px;">
				<div class="box-body"><!-- start box body -->
					<div class="row" style="margin-bottom:10px;">
						<div class="col-md-12">
							<div class="col-sm-2">
	                        	<label>| 고객사명</label><br>
								<input type="input" id="vendor_name" name="vendor_name" class="form-control input-sm">
								</select>
					    	</div>
					    	<div class="col-sm-1" style="padding-left: 0px;">
								<div style="line-height: 24px;">
									<br>
									<button type="button" id="" class="btn btn-info btn-sm" onclick="fnSearchVendor();"><i class="fa fa-search"></i></button>
								</div>
							</div>
							<div class="col-sm-2">
								<label>| 제품명</label>
								<input type="input" id="item_name" name="item_name" class="form-control input-sm">
							</div>
							<div class="col-sm-2">
								<label>| 제품번호</label>
								<input type="input" id="item_code" name="item_code" class="form-control input-sm">
							</div>
						</div>
					</div><!-- end row:search condition -->
					<div class="row" style="margin-bottom:10px;">
						<div class="col-md-12 text-right">
<!-- 							<button type="button" id="" onclick="fnPopupInfo('I');" class="btn btn-success btn-sm">등록</button> -->
<!-- 							<button type="button" id="" onclick="fnPopupInfo('N');" class="btn btn-success btn-sm">새자재등록</button> -->
							<button type="button" id="" onclick="fnPopupInfo('U');" class="btn btn-success btn-sm">수량수정</button>
							<button type="button" id="" onclick="loadList();" class="btn btn-primary btn-sm">조회</button>
						</div>
					</div>
					<div class="row"> <!--  grid  -->
						<div class="col-md-12">
							<div id="grid_item" style="width: 100%; height: 620px;"></div>
<!-- 							<div id="pagination" class="text-center"></div> -->
						</div>
					</div>
				</div>
			</div>
		</section>
	    <!-- /.content -->
	</div>
<!-- /.content-wrapper -->
<div class="modal fade" id="modal_matnr" aria-hidden="true" style="display: none; z-index: 1070;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modal_matnr_title">자재 목록</h4>
        	</div>
			<div class="modal-body" id="">
				<form id="frm_matnr" name="frm_matnr" ><!-- class="form-horizontal" -->
					<div class="form-group row">
						<label for="" class="col-sm-2 col-form-label text-right" style="line-height: 25px;"> 자재유형</label>
						<div class="col-sm-2" style="padding-right: 0px;">
							<select id="MC1010" name="MC1010" class="form-control select2 input-sm" data-placeholder=""></select>
							<!-- <select id="ps_gubun" name="p_gubun" class="form-control select2 input-sm" data-placeholder="">
								<option value="A">부품</option>
								<option value="B">완제품</option>
								<option value="C">반제품</option>
							</select> -->
						</div>
						<label for="" class="col-sm-2 col-form-label text-right" style="line-height: 25px;">자재코드</label>
						<div class="col-sm-2" style="padding: 0px;">
							<input type="text" class="form-control input-sm" id="ps_matnr" value="">
						</div>
						<label for="" class="col-sm-2 col-form-label text-right" style="line-height: 25px;">자재내역</label>
						<div class="col-sm-2" style="padding: 0px;">
							<input type="text" class="form-control input-sm" id="ps_maktx" value="">
						</div>
<!-- 						<div class="col-sm-1"></div> -->
					</div>
				</form>
				<div class="row" style="padding-bottom: 10px;">
					<div class="col-md-12 text-right">
						<button type="button" id="" onclick="loadList1();" class="btn btn-primary btn-sm">검색</button>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div id="grid_mat" style="width: 100%; height: 500px;"></div>
						<div id="pagination1" class="text-center"></div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_mat_save" class="btn btn-success btn-sm" onclick="fnInsert();">Save</button>
					<button type="button" id="btn_mat_cancel" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- start insert/update -->
<div class="modal fade" id="modal_info" aria-hidden="true" style="display: none; z-index: 1060;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modal_title">입고 등록</h4>
        	</div>
			<div class="modal-body" id="">
				<form id="frm_info" name="frm_info" class="form-horizontal">
					<div class="form-group row">
						<div class="col-sm-11 text-right">
							<button type="button" id="btn_matnr_list" onclick="fnPopupInfo('M');" class="btn btn-success btn-sm">자재 선택</button>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;"> 자재유형</label>
						<div class="col-sm-7"><!-- mtart -->
							<select id="MC1010_1" name="MC1010_1" class="form-control select2 input-sm" data-placeholder="" disabled></select>
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">자재코드</label>
						<div class="col-sm-7">
							<input type="text" class="form-control input-sm" id="p_matnr" value="" readonly>
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">자재내역</label>
						<div class="col-sm-7">
							<input type="text" class="form-control input-sm" id="p_maktx" value="" readonly>
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">Spec & Dimension</label>
						<div class="col-sm-7">
							<input type="text" class="form-control input-sm" id="p_wrkst" value="" readonly>
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;"> 자재그룹명</label>
						<div class="col-sm-7">
							<select id="MC1011_1" name="MC1011_1" class="form-control select2 input-sm" data-placeholder="" disabled></select>
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">수량</label>
						<div class="col-sm-7">
							<input type="number" class="form-control input-sm" id="p_bdmg" value="" style="text-align: right;">
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">환율</label>
						<div class="col-sm-7">
							<input type="number" class="form-control input-sm" id="p_wkurs" value="1" style="text-align: right;">
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">통화</label>
						<div class="col-sm-7">
<!-- 							<input type="text" class="form-control input-sm" id="p_waers" value="" style="text-align: right;"> -->
							<select id="p_waers" name="p_waers" class="form-control select2 input-sm" data-placeholder="">
								<option value="KRW">KRW</option>
								<option value="USD">USD</option>
								<option value="CNY">CNY</option>
							</select>
						</div>
						<div class="col-sm-1"></div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_dmr_save" class="btn btn-success btn-sm" onclick="fnInsert();">Save</button>
					<button type="button" id="btn_dmr_cancel" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div> <!-- end modal insert/update -->

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

<script src="/res/plugins/pagination.js"></script>
<script src="/res/plugins/pagination1.js"></script>
<script type="text/javascript">
// for pagination
var page = 1; 		// 화면에서 사용할 page
var pageNum = 0; 	// 서버에 넘겨줄 page -> mysql 은 0 부터 시작
var rowPerPage = 20;
var rowLength = 0;
var totalPage = 0;
var cntRowPagination = 5;	// << 1 2 3 4 5 >> 

var upload_data;

var selArrObj = {};
var grpCodeArr = [
	'MC1010',	// 자재유형
	'MC1011'	// 자재그룹명
];

$(function($) {
// 	fnPageLoadOption();
	fnSelectComponent();
	fnSetItemGrid();
	fnSetVendorGrid();
// 	fnLoadFileHandler();
});

/* function fnPageLoadOption(){
	$("#s_matnr, #s_maktx, #s_wrkst").pressEnter(function(e) {
		e.preventDefault();
		loadList();
	});
	
	$("#p_stprs").keyup(function(event) {
		if(event.which >= 37 && event.which <= 40) return;
		$(this).val(function(index, value) {
			console.log(index, value);
			return value
			.replace(/\D/g, "")
			.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		});
	});
} */

function fnSelectComponent() {
// 	console.log('fnSelectComponent()');
	var page_url = "/frontend/commCode/comm_code_select"
		 		 + "?grpCodeArr=" + encodeURIComponent(grpCodeArr.toString());
	$.ajax({
		url:page_url,
		type:'POST',
		dataType: 'json',
		async : false,
		success: function( data ) {
			if(data.status == 200) {
				$.each(grpCodeArr, function(idx, it){
					selArrObj[it] = [{detail_code:'', dcode_nm:''}];
				});
				$.each(data.rows, function(idx, row){
					var tmpObj = {
							detail_code:row.detail_code, 
							dcode_nm:row.dcode_nm
					};
					selArrObj[row.master_code].push(tmpObj);
				});
				for ( code in selArrObj ) {
			 		$.each(selArrObj[code], function(idx, row){
			 			$("#"+code).append("<option value=" + row.detail_code + ">" + row.dcode_nm + "</option>");
			 			$("#"+code+"_1").append("<option value=" + row.detail_code + ">" + row.dcode_nm + "</option>");
			 		});
				}
			}
		},
		complete: function () {}
	});
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
			{ field:'col1', caption:'상품번호', size:'10%', style:'text-align:center'},
			{ field:'col2', caption:'차종', size:'10%', style:'text-align:center'},
			{ field:'col3', caption:'품명', size:'10%', style:'text-align:center'},
			{ field:'col4', caption:'품번', size:'10%', style:'text-align:center'},
			{ field:'col5', caption:'생산여부', size:'10%'},
			{ field:'col6', caption:'고객사 코드', hidden:true},
			{ field:'col7', caption:'고객사명', size:'15%'},
			{ field:'col8', caption:'수량', size:'5%'}
			], 
		records: rowArr,
		onReload: function(event) {
			fnLoadItemGrid();
		},
		onClick: function (event) {}
	});
	fnLoadItemGrid();
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

function getFormatDate(d) {
	var month = d.getMonth() + 1;
	var date = d.getDate();
	month = (month < 10) ? "0" + month : month;
	date = (date < 10) ? "0" + date : date;
	return d.getFullYear() + '-' + month + '-' + date;
}

function fnSearchConditionInit() {
	$("input").val("");
	$("#reg_gubun").val("G");
} 

function fnSaveMesMaterial(){
// 	console.log('fnSaveMesMaterial()');
	var dept_cd = $("#deptCD").val();
	var gubun = $("#reg_gubun").val();
	
	var selection = w2ui.grid_item.getSelection();
	if(selection.length==0){
		fnMessageModalAlert("Warning", "저장하고자 하는 항목을 선택하시기 바랍니다.");
		return;
	}
	
	// mess_medical_yn, mess_optical_yn
	var records = [];
	$.each(w2ui.grid_matnr.records, function(idx, row){
		if( row.w2ui!=undefined ) records.push(row);
	});
	
	if( records.length>0 ) {
		if( dept_cd=='1110' ) {
			$.each(records, function(idx, row){
				if( row.w2ui!=undefined && row.w2ui.changes.mess_medical_yn!=undefined ){
					row.mess_medical_yn = row.w2ui.changes.mess_medical_yn;
				}
			});
		} else {
			$.each(records, function(idx, row){
				if( row.w2ui!=undefined && row.w2ui.changes.mess_optical_yn!=undefined ){
					row.mess_optical_yn = row.w2ui.changes.mess_optical_yn;
				}
			});
		}
		//mesg_medical_yn, mesg_optical_yn
		if( dept_cd=='1110' ) {
			$.each(records, function(idx, row){
				if( row.w2ui!=undefined && row.w2ui.changes.mesg_medical_yn!=undefined ){
					row.mesg_medical_yn = row.w2ui.changes.mesg_medical_yn;
				}
			});
		} else {
			$.each(records, function(idx, row){
				if( row.w2ui!=undefined && row.w2ui.changes.mesg_optical_yn!=undefined ){
					row.mesg_optical_yn = row.w2ui.changes.mesg_optical_yn;
				}
			});
		}
	}
	
	var page_url = "/frontend/hub/save_mes_master_material";
	var postData = "params=" + encodeURIComponent(JSON.stringify(records))
	             + "&dept_cd=" + encodeURIComponent(dept_cd);
	$.ajax({
		url : page_url,
		type : "POST",
		data : postData,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnMessageModalAlert("Success", "변경한 사용여부를 " + data.cnt + "건 저장하였습니다.");
				loadList();
			} else {
				fnMessageModalAlert("Error", "사용여부를 저장하는데 에러가 발생하였습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "사용여부를 저장하는데 에러가 발생하였습니다.");
		}
	});
}

function fnPopupInfo(flag) {
	console.log('fnPopupInfo(' + flag + ')');
	$("#btn_matnr_list").hide();
	if( flag=='U' ) { 
		var selIdxArr = w2ui.grid_item.getSelection();
		var chkLen = selIdxArr.length;
		if( chkLen==0 ) {
			fnMessageModalAlert('Alert', '수정할 항목을 목록에서 선택해야 합니다.');			
		} else if( chkLen>1 ) {
			fnMessageModalAlert('Alert', '수정할 항목은 목록에서 1개 선택해야 합니다.');
		} else { // chkLen==1
			$("#modal_info").modal('show');
			$("#modal_title").text('수정');
			
			console.log(w2ui.grid_matnr.get(selIdxArr[0]));
			var row = w2ui.grid_matnr.get(selIdxArr[0]);
			$("#MC1010_1").val(row.mtart);
			$("#p_matnr").val(row.matnr);
			$("#p_maktx").val(row.maktx);
			$("#p_wrkst").val(row.wrkst);
			$("#MC1011_1").val(row.wgbez);
			$("#p_bdmg").val(row.bdmg);
			$("#p_wkurs").val(row.wkurs);
			$("#p_waers").val(row.waers);
					
			$("#p_matnr").attr('disabled', true);
			$("#p_maktx").attr('disabled', true);
			$("#p_wrkst").attr('disabled', true);
			$("#p_cnt").attr('disabled', false);
		}
	}
}

function fnInsert() {
	console.log('fnInsert()');
	
	if( !insertDupChk() ) { 
		var page_url = "/frontend/material_mng_insert"
		 	 		 + "?matnr=" + encodeURIComponent($("#p_matnr").val())
					 + "&bdmg=" + encodeURIComponent($("#p_bdmg").val())
					 + "&wkurs=" + encodeURIComponent($("#p_wkurs").val())
					 + "&maktx=" + encodeURIComponent($("#p_maktx").val())
					 + "&waers=" + encodeURIComponent($("#p_waers").val());
		$.ajax({
			url:page_url,
			type:'POST',
			dataType: 'json',
			async : false,
			success: function( data ) {
				if(data.status == 200 && data.cnt>0 ) {
					fnMessageModalAlert('Info','저장되었습니다.');
				} else {
					fnMessageModalAlert('Info','저장 실패 되었습니다.');
				}
				$('#modal_info').modal('hide');
				loadList();
			},
			complete: function () {}
		});
	} else {
		var page_url = "/frontend/material_mng_update"
					 + "?matnr=" + encodeURIComponent($("#p_matnr").val())
					 + "&bdmg=" + encodeURIComponent($("#p_bdmg").val())
					 + "&wkurs=" + encodeURIComponent($("#p_wkurs").val())
					 + "&maktx=" + encodeURIComponent($("#p_maktx").val())
					 + "&waers=" + encodeURIComponent($("#p_waers").val());
		$.ajax({
			url:page_url,
			type:'POST',
			dataType: 'json',
			async : false,
			success: function( data ) {
				if(data.status == 200 && data.cnt>0 ) {
					fnMessageModalAlert('Info','수정되었습니다.');
				} else {
					fnMessageModalAlert('Info','수정 실패 되었습니다.');
				}
				$('#modal_info').modal('hide');
				loadList();
			},
			complete: function () {}
		});
	}
	
}

function insertDupChk(){
	if( nullToBlank($("#p_matnr").val())=='' ) {
		fnMessageModalAlert("Notification", '자재코드가 입력되지 않았습니다.');
		return;
	}
	var result = false;
	var page_url = "/frontend/material_mng_select_count"
			 	 + "?matnr=" + encodeURIComponent($("#p_matnr").val());
	$.ajax({
		url:page_url,
		type:'POST',
		dataType: 'json',
		async : false,
		success: function( data ) {
			console.log(data);
			if(data.status == 200) {
				if( data.cnt>0 ) {
					// 중복된 데이터 있음
					result = true;
				} else {
					// 중복된 데이터  없음
				}
			}
		},
		complete: function () {}
	});
	return result;
}

function fnUpdate() {
	
}

function fnDelete() {
	var selIdxArr = w2ui.grid_item.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('Alert', '삭제할 항목을 목록에서 선택해야 합니다.');			
	} else if( chkLen>1 ) {
		fnMessageModalAlert('Alert', '삭제할 항목은 목록에서 1개 선택해야 합니다.');
	} else {
		fnMessageModalConfirm('Confirm', '삭제 하시겠습니까?', function(ev){
			if( ev ) {
				var page_url = "/frontend/material_mng_delete"
					 		 + "?matnr=" + encodeURIComponent(w2ui.grid_matnr.get(selIdxArr[0]).matnr);
				$.ajax({
					url:page_url,
					type:'POST',
					dataType: 'json',
					async : false,
					success: function( data ) {
						if(data.status == 200 && data.cnt>0 ) {
							fnMessageModalAlert('Info','삭제 되었습니다.');
						} else {
							fnMessageModalAlert('Info','삭제 실패 되었습니다.');
						}
// 						w2ui.grid_matnr.remove(selIdxArr[0]);
						loadList();
					},
					complete: function () {}
				});
			}
		}); 
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
</script>
</body>
</html>