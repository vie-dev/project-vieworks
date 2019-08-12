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
		<jsp:param name="selected_menu_p_cd" value="1020" />
		<jsp:param name="selected_menu_cd" value="1116" />
	</jsp:include>

	<div class="content-wrapper">
	    <section class="content-header">
	        <h1>
	            HUB
	            <small>자재 마스터</small>
	        </h1>
	        <ol class="breadcrumb">
	            <li><a href="#"><i class="fa fa-dashboard"></i> HUB</a></li>
	            <li class="active">자재 마스터</li>
	        </ol>
	    </section>
	
	    <!-- Main content -->
		<section class="content" style="padding-bottom: 0px;">
			<div class="box" style="margin-bottom: 0px;height: 790px;">
				<div class="box-body"><!-- start box body -->
					<div class="row" style="margin-bottom:10px;">
						<div class="col-md-12">
							<div class="col-sm-2">
	                        	<label>| 자재유형</label><br>
								<select id="MC1010" name="MC1010" class="form-control select2 input-sm" data-placeholder="">
								</select>
					    	</div>
							<div class="col-sm-2">
	                        	<label>| 자재그룹</label><br>
								<select id="MC1011" name="MC1011" class="form-control select2 input-sm" data-placeholder="">
								</select>
					    	</div>
							<div class="col-sm-2">
								<label>| 자재코드</label>
								<input type="input" id="s_matnr" name="s_matnr" class="form-control input-sm" placeholder="ex) 1100-4001-01A" maxlength="30">
							</div>
							<div class="col-sm-2">
								<label>| 자재내역</label>
								<input type="input" id="s_maktx" name="s_maktx" class="form-control input-sm" placeholder="ex) RXD-500 PACKING ASS'Y" maxlength="30">
							</div>
							
							<div class="col-sm-2">
								<label>| Spec&Dimension</label>
								<input type="input" id="s_wrkst" name="s_wrkst" class="form-control input-sm" placeholder="ex) RXD-500 PACKING ASS'Y" maxlength="50">
							</div>
						</div>
					</div><!-- end row:search condition -->
					<div class="row" style="margin-bottom:10px;">
						<div class="col-md-12 text-right">
<!-- 							<button type="button" id="" onclick="fnPopupInfo('I');" class="btn btn-success btn-sm">입고</button> -->
<!-- 							<button type="button" id="" onclick="fnPopupInfo('N');" class="btn btn-success btn-sm">새자재등록</button> -->
<!-- 							<button type="button" id="" onclick="fnPopupInfo('U');" class="btn btn-success btn-sm">자재 항목 수정</button> -->
							<button type="button" id="" onclick="loadList();" class="btn btn-success btn-sm">조회</button>
							<button type="button" id="" onclick="fnPopupInfo('I');" class="btn btn-primary btn-sm">추가</button>
							<button type="button" id="" onclick="fnPopupInfo('U');" class="btn btn-primary btn-sm">수정</button>
							<button type="button" id="" onclick="fnDelete();" class="btn btn-danger btn-sm">삭제</button>
							<button type="button" id="" onclick="fnUpload();" class="btn btn-warning btn-sm">Excel Upload</button>
							<button type="button" id="" onclick="fnDownload();" class="btn btn-warning btn-sm">Excel Download</button>
						</div>
					</div>
					<div class="row"> <!--  grid  -->
						<div class="col-md-12">
							<div id="grid_matnr" style="width: 100%; height: 620px;"></div>
							<div id="pagination" class="text-center"></div>
						</div>
					</div>
				</div>
			</div>
		</section>
	    <!-- /.content -->
	</div>
<!-- /.content-wrapper -->
<!-- <div class="modal fade" id="modal_matnr" aria-hidden="true" style="display: none; z-index: 1070;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modal_title">자재 목록</h4>
        	</div>
			<div class="modal-body" id="">
				<form id="frm_matnr" name="frm_matnr" class="form-horizontal">
					<div class="form-group row">
						<label for="" class="col-sm-2 col-form-label text-right" style="line-height: 25px;"> 구분</label>
						<div class="col-sm-2">
							<select id="ps_gubun" name="p_gubun" class="form-control select2 input-sm" data-placeholder="">
								<option value="A">부품</option>
								<option value="B">완제품</option>
								<option value="C">반제품</option>
							</select>
						</div>
						<label for="" class="col-sm-2 col-form-label text-right" style="line-height: 25px;">자재코드</label>
						<div class="col-sm-2">
							<input type="text" class="form-control input-sm" id="ps_matnr" value="">
						</div>
						<label for="" class="col-sm-2 col-form-label text-right" style="line-height: 25px;">자재유형</label>
						<div class="col-sm-2">
							<input type="text" class="form-control input-sm" id="ps_mtart" value="">
						</div>
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
</div> -->
<!-- start insert/update -->
<div class="modal fade" id="modal_info" aria-hidden="true" style="display: none; z-index: 1060;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modal_title">자재 신규등록</h4>
        	</div>
			<div class="modal-body" id="">
				<form id="frm_info" name="frm_info" class="form-horizontal">
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;"> 자재유형</label>
						<div class="col-sm-7">
							<select id="MC1010_1" name="MC1010_1" class="form-control select2 input-sm" data-placeholder=""></select>
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">자재코드</label>
						<div class="col-sm-7">
							<input type="text" class="form-control input-sm" id="p_matnr" value="">
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">기본단위</label>
						<div class="col-sm-7">
							<select id="p_meins" name="p_meins" class="form-control select2 input-sm" data-placeholder="">
								<option value="EA">EA</option>
								<option value="M">M</option>
							</select>
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">자재내역</label>
						<div class="col-sm-7">
							<input type="text" class="form-control input-sm" id="p_maktx" value="">
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">Spec & Dimension</label>
						<div class="col-sm-7">
							<input type="text" class="form-control input-sm" id="p_wrkst" value="">
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">삭제표시</label>
						<div class="col-sm-3">
							<label class="ichk_label"> <input type="radio" id="p_lvorm" name="p_lvorm" value="N"> 사용대상</label>
						</div>
						<div class="col-sm-4">
							<label class="ichk_label"> <input type="radio" id="p_lvorm" name="p_lvorm" value="Y"> 삭제</label> 
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">등급관리여부</label>
						<div class="col-sm-3">
							<label class="ichk_label"> <input type="radio" id="p_kzumw" name="p_kzumw" value="Y"> 사용</label>
						</div>
						<div class="col-sm-4">
							<label class="ichk_label"> <input type="radio" id="p_kzumw" name="p_kzumw" value="N"> 미사용</label> 
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">검사여부</label>
						<div class="col-sm-3">
							<label class="ichk_label"> <input type="radio" id="p_iloos" name="p_iloos" value="Y"> 사용</label>
						</div>
						<div class="col-sm-4">
							<label class="ichk_label"> <input type="radio" id="p_iloos" name="p_iloos" value="N"> 미사용</label> 
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">입고후검사</label>
						<div class="col-sm-3">
							<label class="ichk_label"> <input type="radio" id="p_ihivi" name="p_ihivi" value="Y"> 사용</label>
						</div>
						<div class="col-sm-4">
							<label class="ichk_label"> <input type="radio" id="p_ihivi" name="p_ihivi" value="N"> 미사용</label> 
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;"> 가격</label>
						<div class="col-sm-7">
							<input id="p_price" name="p_price" type="number" class="form-control input-sm text-right">
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;"> 총중량</label>
						<div class="col-sm-7">
							<input id="p_brgew" name="p_brgew" type="number" class="form-control input-sm text-right">
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;"> 순중량</label>
						<div class="col-sm-7">
							<input id="p_ntgew" name="p_ntgew" type="number" class="form-control input-sm text-right">
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;"> 중량단위</label>
						<div class="col-sm-7">
							<select id="p_gewei" name="p_gewei" class="form-control select2 input-sm" data-placeholder="">
								<option value="g">g</option>
								<option value="Kg">Kg</option>
							</select>
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;"> 자재그룹명</label>
						<div class="col-sm-7">
							<select id="MC1011_1" name="MC1011_1" class="form-control select2 input-sm" data-placeholder=""></select>
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
<jsp:include page="/common/footer_inc" flush="true">
	<jsp:param name="page_title" value="0" />
</jsp:include>
  
<jsp:include page="/common/sidebar_rview_inc" flush="true">
	<jsp:param name="page_title" value="0" />
</jsp:include>
</div>
<!-- ./wrapper -->

<script src="/res/plugins/pagination.js"></script>
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
	fnSelectComponent();
	fnPageLoadOption();
	fnLoadMaterialGrid();
// 	fnLoadMaterialGridSample();
	fnLoadFileHandler();
});

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

function fnPageLoadOption(){
	$("#s_matnr, #s_maktx, #s_wrkst").pressEnter(function(e) {
		e.preventDefault();
		loadList();
	});
	
	 $('input').iCheck({
		    checkboxClass: 'icheckbox_flat-blue',
		    radioClass: 'iradio_flat-blue'
		  });
	/* 
	$("#p_stprs").keyup(function(event) {
		if(event.which >= 37 && event.which <= 40) return;
		$(this).val(function(index, value) {
			console.log(index, value);
			return value
			.replace(/\D/g, "")
			.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		});
	}); */
}

function fnLoadMaterialGrid(){
// 	console.log('fnLoadMaterialGrid()');
	var rowArr = [];
	
	$("#grid_matnr").w2grid({
		name : 'grid_matnr',
		show : {
			lineNumbers : true,
            footer: true
        },
        multiSelect: false,
        columns : [
			{ field:'matnr', caption:'자재코드', size:'10%'} , 
			{ field:'mtart', caption:'자재유형', size:'10%', style:'text-align:center;', sortable:true,
				render: function(record, index, col_index){
          			var value = this.getCellValue(index, col_index);
          			var rr = "";
          			$.each(selArrObj.MC1010, function(idx, obj){
          				if( value==obj.detail_code ) rr = obj.dcode_nm;
          			});
          			return rr;
				}}, 
			{ field:'meins', caption:'기본단위', size:'5%', style:'text-align:center;', sortable:true}, 
			{ field:'maktx', caption:'자재내역', size:'15%', sortable:true}, 
			{ field:'wrkst', caption:'Spec & Dimension', size:'10%', sortable:true}, 
			{ field:'lvorm', caption:'삭제표시', size:'5%', sortable:true},
			{ field:'kzumw', caption:'등급관리여부', size:'5%', sortable:true},
			{ field:'iloos', caption:'검사여부', size:'5%', sortable:true},
			{ field:'ihivi', caption:'입고후검사', size:'5%', sortable:true},
			{ field:'price', caption:'가격', size:'5%', render:'int', sortable:true}, 
			{ field:'brgew', caption:'총중량', size:'5%', render:'int', sortable:true}, 
			{ field:'ntgew', caption:'순중량', size:'5%', render:'int', sortable:true}, 
			{ field:'gewei', caption:'중량단위', size:'5%', style:'text-align:center', sortable:true}, 
			{ field:'wgbez', caption:'자재그룹명', size:'5%', sortable:true,
				render: function(record, index, col_index){
          			var value = this.getCellValue(index, col_index);
          			var rr = "";
          			$.each(selArrObj.MC1011, function(idx, obj){
          				if( value==obj.detail_code ) rr = obj.dcode_nm;
          			});
          			return rr;
				}} ], 
		sortData: [{field: 'matnr', direction: 'ASC'}],
		records: [],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},
		onClick: function (event) {}
	});
	loadList();
}

function loadList(pageNum){
// 	console.log('loadList()');
	var gubun = $("#reg_gubun").val();
	var beforePage = page; 
	if( pageNum==undefined ){
		page=1;
		pageNum = 0;
	} else {
		page=pageNum;
		pageNum = (pageNum-1)*rowPerPage;
	}
	var page_url = "/frontend/material_master_select"
				 + "?matnr=" + encodeURIComponent($("#s_matnr").val())
				 + "&maktx=" + encodeURIComponent($("#s_maktx").val())
				 + "&mtart=" + encodeURIComponent($("#MC1010").val())
				 + "&wrkst=" + encodeURIComponent($("#s_wrkst").val())
				 + "&wgbez=" + encodeURIComponent($("#MC1011").val())
				 + "&page="+ encodeURIComponent(pageNum)
				 + "&rows="+ encodeURIComponent(rowPerPage);
	
	w2ui['grid_matnr'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
// 				console.log(rowArr);
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				if(data.pageTotal == 0){
					$("#pagination").empty();
				} else {
					totalPage = data.pageTotal;
					pagination();
				}
				w2ui['grid_matnr'].records = rowArr;
				w2ui['grid_matnr'].total = data.rowTotal;
			} else if(data.status == 200 && (data.rows).length == 0) {
				w2ui.grid_matnr.clear();
				pagination();
				$("#pagination").empty();
			}
			w2ui['grid_matnr'].refresh();
			w2ui['grid_matnr'].unlock();
		},complete: function () {}
	});
}

function fnLoadFileHandler(){
	var page_url = "/file/item_import_upload";
	
	$('#fileupload').fileupload({
		url : page_url,
		dataType : 'json',
		autoUpload : true,
		acceptFileTypes : /(\.|\/)(xlsx)$/i,
		maxFileSize : 106800000,  
	}).on('fileuploadadd', function(e, data) {
	}).on('fileuploadprocessalways', function(e, data) {
		var index = data.index;
		var file = data.files[index];
		if (file.error) {
			fnMessageModalAlert("Notification", file.error);
		}
	}).on('fileuploaddone', function(e, data) {

		$('#grid_items').jqGrid('clearGridData');
		
		var arrData = data.result.rows;
		
		var d = new Date();
		var month = d.getMonth()+1;
		var date = d.getDate();
		month = (month < 10) ? "0" + month : month;
		date = (date < 10) ? "0" + date : date;
		
		var req_date = d.getFullYear() + month + date;
		
		for(var i=0; i<data.result.rows.length; i++ ){
		    
			var i_tmp = "00000" + (i+1);
		    i_tmp = i_tmp.slice(-4);
		    
		    arrData[i].zrequest_no = req_date + "0001";	// 수정...zrequest_no은 한 번올릴때 구성요소들의 값이 모두 같다...ex) 201709260001
		    arrData[i].zseq = i_tmp;
		}

		$('#grid_items').jqGrid('setGridParam', { datatype: 'local', data: data.result.rows }).trigger('reloadGrid');	
		
	}).on('fileuploadfail', function(e, data) {
		$.each(data.files, function(index) {
			fnMessageModalAlert("Notification", "File upload failed.");
		});
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
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
	
	var selection = w2ui.grid_matnr.getSelection();
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
	
	$("#MC1010_1").val('');
	$("#p_matnr").val('');
	$("#p_meins").val('');
	$("#p_maktx").val('');
	$("#p_wrkst").val('');
	$("#p_price").val('');
	$("#p_ntgew").val('');
	$("#p_brgew").val('');
	$("#MC1011_1").val('');
	
	if( flag=='I' ) {
		$("#modal_info").modal('show');
		$("#modal_title").text('자재 신규 등록');
		$("#MC1010_1").attr('disabled', false);
		$("#p_matnr").attr('disabled', false);
		$("#p_meins").attr('disabled', false);
		$("#p_maktx").attr('disabled', false);
		$("#p_wrkst").attr('disabled', false);
		$(":radio[name=p_lvorm][value=N]").iCheck("check");
		$(":radio[name=p_kzumw][value=N]").iCheck("check");
		$(":radio[name=p_iloos][value=N]").iCheck("check");
		$(":radio[name=p_ihivi][value=N]").iCheck("check");
		$("#p_gewei").attr('disabled', false);
		$("#p_price").attr('disabled', false);
		$("#p_ntgew").attr('disabled', false);
		$("#p_brgew").attr('disabled', false);
		$("#MC1011_1").attr('disabled', false);
	} else if( flag=='U' ) { 
		var selIdxArr = w2ui.grid_matnr.getSelection();
		var chkLen = selIdxArr.length;
		if( chkLen==0 ) {
			fnMessageModalAlert('Alert', '수정할 항목을 목록에서 선택해야 합니다.');			
		} else if( chkLen>1 ) {
			fnMessageModalAlert('Alert', '수정할 항목은 목록에서 1개 선택해야 합니다.');
		} else { // chkLen==1
			var selData = w2ui.grid_matnr.get(selIdxArr[0]);
			/* 
  			var p_mtart,p_wgbez = "";
  			$.each(selArrObj.MC1010, function(idx, obj){
  				if( selData.mtart==obj.detail_code ) p_mtart = obj.dcode_nm;
  			});
  			$.each(selArrObj.MC1011, function(idx, obj){
  				if( selData.wgbez==obj.detail_code ) p_wgbez = obj.dcode_nm;
  			});
  			
  			console.log(p_mtart, p_wgbez); */
  			
			$("#p_brgew").val(selData.brgew);
			$("#p_gewei").val(selData.gewei);
			$("#p_maktx").val(selData.maktx);
			$("#p_matnr").val(selData.matnr);
			$("#p_meins").val(selData.meins);
			$("#MC1010_1").val(selData.mtart);
// 			$('select[name="MC1010_1"]').find('option[value="'+selData.mtart+'"]').attr("selected",true);
			$("#p_ntgew").val(selData.ntgew);
			$("#p_price").val(selData.price);
			$("#MC1011_1").val(selData.wgbez);
// 			$('select[name="p_wgbez"]').find('option[value="'+selData.wgbez+'"]').attr("selected",true);
			$("#p_wrkst").val(selData.wrkst);
		
			$(":radio[name=p_lvorm][value="+selData.lvorm+"]").iCheck("check");
			$(":radio[name=p_kzumw][value="+selData.kzumw+"]").iCheck("check");
			$(":radio[name=p_iloos][value="+selData.iloos+"]").iCheck("check");
			$(":radio[name=p_ihivi][value="+selData.ihivi+"]").iCheck("check");
			
			$("#modal_info").modal('show');
			$("#modal_title").text('수정');
			
			$("#MC1010_1").attr('disabled', false);
			$("#p_matnr").attr('disabled', true);
			$("#p_meins").attr('disabled', false);
			$("#p_maktx").attr('disabled', false);
			$("#p_wrkst").attr('disabled', false);
			
			$("#p_gewei").attr('disabled', false);
			$("#p_price").attr('disabled', true);
			$("#p_ntgew").attr('disabled', false);
			$("#p_brgew").attr('disabled', false);
			$("#MC1011_1").attr('disabled', false);
		}
	}
}

function fnInsert() {
// 	console.log('fnInsert()');
	
	if( !insertDupChk() ) { 
		/* console.log($("#MC1010_1").val());
		console.log($("#p_matnr").val());
		console.log($("#p_meins").val());
		console.log($("#p_maktx").val());
		console.log($("#p_wrkst").val());
		console.log($(':radio[name="p_lvorm"]:checked').val());
		console.log($(':radio[name="p_kzumw"]:checked').val());
		console.log($(':radio[name="p_iloos"]:checked').val());
		console.log($(':radio[name="p_ihivi"]:checked').val());
		console.log($("#p_gewei").val());
		console.log($("#p_ntgew").val());
		console.log($("#p_brgew").val());
		console.log($("#p_price").val());
		console.log($("#MC1011_1").val()); */
		
		var page_url = "/frontend/material_master_insert"
		 	 		 + "?matnr=" + encodeURIComponent($("#p_matnr").val())
					 + "&mtart=" + encodeURIComponent($("#MC1010_1").val())
					 + "&meins=" + encodeURIComponent($("#p_meins").val())
					 + "&maktx=" + encodeURIComponent($("#p_maktx").val())
					 + "&wrkst=" + encodeURIComponent($("#p_wrkst").val())
					 + "&lvorm=" + encodeURIComponent($(':radio[name="p_lvorm"]:checked').val())
					 + "&kzumw=" + encodeURIComponent($(':radio[name="p_kzumw"]:checked').val())
					 + "&iloos=" + encodeURIComponent($(':radio[name="p_iloos"]:checked').val())
					 + "&ihivi=" + encodeURIComponent($(':radio[name="p_ihivi"]:checked').val())
					 + "&gewei=" + encodeURIComponent($("#p_gewei").val())
					 + "&price=" + encodeURIComponent($("#p_price").val())
					 + "&brgew=" + encodeURIComponent($("#p_brgew").val())
					 + "&ntgew=" + encodeURIComponent($("#p_ntgew").val())
					 + "&wgbez=" + encodeURIComponent($("#MC1011_1").val());
		$.ajax({
			url:page_url,
			type:'POST',
			dataType: 'json',
			async : false,
			success: function( data ) {
				console.log(data);
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
		var page_url = "/frontend/material_master_update"
			 		 + "?matnr=" + encodeURIComponent($("#p_matnr").val())
					 + "&mtart=" + encodeURIComponent($("#MC1010_1").val())
					 + "&meins=" + encodeURIComponent($("#p_meins").val())
					 + "&maktx=" + encodeURIComponent($("#p_maktx").val())
					 + "&wrkst=" + encodeURIComponent($("#p_wrkst").val())
					 + "&lvorm=" + encodeURIComponent($(':radio[name="p_lvorm"]:checked').val())
					 + "&kzumw=" + encodeURIComponent($(':radio[name="p_kzumw"]:checked').val())
					 + "&iloos=" + encodeURIComponent($(':radio[name="p_iloos"]:checked').val())
					 + "&ihivi=" + encodeURIComponent($(':radio[name="p_ihivi"]:checked').val())
					 + "&gewei=" + encodeURIComponent($("#p_gewei").val())
					 + "&price=" + encodeURIComponent($("#p_price").val())
					 + "&brgew=" + encodeURIComponent($("#p_brgew").val())
					 + "&ntgew=" + encodeURIComponent($("#p_ntgew").val())
					 + "&wgbez=" + encodeURIComponent($("#MC1011_1").val());
		$.ajax({
			url:page_url,
			type:'POST',
			dataType: 'json',
			async : false,
			success: function( data ) {
				console.log(data);
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
	var page_url = "/frontend/material_master_dup_check"
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

// function fnUpdate() {}

function fnDelete() {
	var selIdxArr = w2ui.grid_matnr.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('Alert', '삭제할 항목을 목록에서 선택해야 합니다.');			
	} else if( chkLen>1 ) {
		fnMessageModalAlert('Alert', '삭제할 항목은 목록에서 1개 선택해야 합니다.');
	} else {
		fnMessageModalConfirm('Confirm', '삭제 하시겠습니까?', function(ev){
			if( ev ) {
				var page_url = "/frontend/material_master_delete"
					 		 + "?matnr=" + encodeURIComponent(w2ui.grid_matnr.get(selIdxArr[0]).matnr);
				$.ajax({
					url:page_url,
					type:'POST',
					dataType: 'json',
					async : false,
					success: function( data ) {
						console.log(data);
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

function fnUpload() {
	fnMessageModalAlert('Info', '진행중 입니다.');	
}

function fnDownload() {
	fnMessageModalAlert('Info', '진행중 입니다.');	
}
</script>
</body>
</html>