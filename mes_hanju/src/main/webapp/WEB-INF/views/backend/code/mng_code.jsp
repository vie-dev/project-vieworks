<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
// jsp properties
// String thema = SessionUtil.getProperties("mes.thema");
String pageTitle = SessionUtil.getProperties("mes.company");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title><%=pageTitle %> | Backend</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
	<jsp:include page="/common/header_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</head>

<body class="hold-transition skin-black sidebar-mini">

<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="B" />
		<jsp:param name="selected_menu_p_cd" value="1003" />
		<jsp:param name="selected_menu_cd" value="1004" />
	</jsp:include>

	<div class="content-wrapper">
		<section class="content-header">
			<h1> System Management <small>System Code Management</small> </h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> System Management</a></li>
				<li class="active">System Code Management</li>
			</ol>
		</section>
		<section class="content">
			<div class="row">
				<div class="col-md-6">
					<div class="box" style="min-height: 790px;margin-bottom: 0px;">
						<div class="box-header with-border">
							<h3 class="box-title">Master Code</h3>
							<div class="box-tools pull-right">
								<div class="input-group input-group-sm" style="width: 150px;float: left;">
									<input type="text" id="mcode_search" name="mcode_search" class="form-control pull-right" placeholder="Search">
									<div class="input-group-btn">
										<button type="button" id="btn_mcode_search" class="btn btn-default"><i class="fa fa-search"></i></button>
									</div>
								</div>&nbsp;| 
								<button type="button" id="btn_mcode_add" class="btn btn-danger btn-sm">Code Add</button>
								<button type="button" id="btn_mcode_info" class="btn btn-warning btn-sm">Code Detail</button>
							</div>
						</div>
			            <div class="box-body">
			            	<div class="row">
			            		<div class="col-md-12">
			            			<div id="grid_mcode" style="width: 100%; height: 720px;"></div>
			            		</div>
			            	</div>
						</div>
        			</div>
        		</div>
				<div class="col-md-6" style="padding-left: 0px;">
					<div class="box" style="min-height: 790px;margin-bottom: 0px;">
						<div class="box-header with-border">
							<h3 class="box-title">Detail_Code</h3>
							<div class="box-tools pull-right">
								<div class="input-group input-group-sm" style="width: 150px;float: left;">
									<input type="text" id="dcode_search" name="dcode_search" class="form-control pull-right" placeholder="Search">
									<div class="input-group-btn">
										<button type="button" id="btn_dcode_search" class="btn btn-default"><i class="fa fa-search"></i></button>
									</div>
								</div>&nbsp;| 
								<button type="button" id="btn_dcode_add" class="btn btn-danger btn-sm">Code Add</button>
								<button type="button" id="btn_dcode_info" class="btn btn-warning btn-sm">Code Detail</button>
							</div>
						</div>
						<div class="box-body">
			            	<div class="row">
			            		<div class="col-md-12">
			            			<div id="grid_dcode" style="width: 100%; height: 720px;"></div>
			            		</div>
			            	</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
<!-- master detail popup -->
  <div class="modal fade" id="modal_mcode" data-backdrop="static">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
         	<h4 class="modal-title" id="modal_code_title">System Code Management</h4>
        </div>
        <div class="modal-body" id="modal_code_body">
          <div class="box box-warning box-solid">
            <div class="box-header with-border">
              <h3 class="box-title">Master Code Information</h3>
              <div class="box-tools pull-right">
	              <button type="button" id="btn_mcode_save" class="btn btn-success btn-sm">Save</button>
	              <button type="button" id="btn_mcode_del" class="btn btn-danger btn-sm">Delete</button>
              </div>
            </div>

            <form id="frm_mcode" name="frm_mcode" class="form-horizontal">
            	<input type="hidden" id="m_cmd" name="cmd">
            	<input type="hidden" id="m_code_use_yn" name="code_use_yn" />
              <div class="box-body">
                <div class="form-group">
                  <label for="master_code" class="col-sm-3 control-label">Master_Code</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_master_code" name="master_code" class="form-control" placeholder="Code ID" readonly="readonly">
                  </div>
                </div>
                <div class="form-group">
                  <label for="code_nm" class="col-sm-3 control-label">Code_Name</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_code_nm" name="code_nm" class="form-control" placeholder="Code Name" maxlength="40">
                  </div>
                </div>
                <div class="form-group">
                  <label for="code_nm_en" class="col-sm-3 control-label">Code_Name(Eng)</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_code_nm_en" name="code_nm_en" class="form-control" placeholder="Code Name(Eng)" maxlength="40">
                  </div>
                </div>
                <div class="form-group">
                  <label for="code_dscr" class="col-sm-3 control-label">Code_Description</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_code_dscr" name="code_dscr" class="form-control" placeholder="Code Description" maxlength="100">
                  </div>
                </div>
                <div class="form-group">
                  <label for="code_order" class="col-sm-3 control-label">Code_Display</label>
                  <div class="col-sm-9">
                    <input type="number" id="m_code_order" name="code_order" class="form-control" placeholder="출력순서" maxlength="4" oninput="maxLengthCheck(this);" />
                  </div>
                </div>
                <div class="form-group">
                  <label for="rdo_mcode_use_yn" class="col-sm-3 control-label">Use_Yn</label>
                  <div class="col-sm-9">
                  	<label>
		                  <input type="radio" name="rdo_mcode_use_yn" class="flat-red" value="Y" checked> Use
		                </label>
		                <label>
		                  <input type="radio" name="rdo_mcode_use_yn" class="flat-red" value="N" > No Use
		                </label>
                  </div>
                </div>
                <div class="form-group">
                  <label for="filter1_val" class="col-sm-3 control-label">Expand_Filed01</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_filter1_val" name="filter1_val" class="form-control" placeholder="Expand Filed01" maxlength="20">
                  </div>
                </div>
                <div class="form-group">
                  <label for="filter2_val" class="col-sm-3 control-label">Expand_Filed02</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_filter2_val" name="filter2_val" class="form-control" placeholder="Expand Filed02" maxlength="20">
                  </div>
                </div>
                <div class="form-group">
                  <label for="filter3_val" class="col-sm-3 control-label">Expand Filed03</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_filter3_val" name="filter3_val" class="form-control" placeholder="Expand Filed03" maxlength="20">
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="modal fade" id="modal_dcode" data-backdrop="static">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
         	<h4 class="modal-title" id="modal_code_title">System Code Management</h4>
        </div>
        <div class="modal-body" id="modal_code_body">
          <div class="box box-warning box-solid">
            <div class="box-header with-border">
              <h3 class="box-title">Detail Code information</h3>
              <div class="box-tools pull-right">
	              <button type="button" id="btn_dcode_save" class="btn btn-success btn-sm">Code_Save</button>
	              <button type="button" id="btn_dcode_del" class="btn btn-danger btn-sm">Code_Delete</button>
              </div>
            </div>

            <form id="frm_dcode" name="frm_dcode" class="form-horizontal">
            	<input type="hidden" id="d_cmd" name="cmd">
            	<input type="hidden" id="d_code_use_yn" name="code_use_yn" />
              <div class="box-body">
                <div class="form-group">
                  <label for="master_code" class="col-sm-3 control-label">Master_Code</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_master_code" name="master_code" class="form-control" placeholder="Code ID" readonly="readonly">
                  </div>
                </div>
                <div class="form-group">
                  <label for="detail_code" class="col-sm-3 control-label">Detail_Code</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_detail_code" name="detail_code" class="form-control" placeholder="Code ID" readonly="readonly">
                  </div>
                </div>
                <div class="form-group">
                  <label for="code_nm" class="col-sm-3 control-label">Code_Nm</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_code_nm" name="code_nm" class="form-control" placeholder="Code Name" maxlength="30">
                  </div>
                </div>
                <div class="form-group">
                  <label for="code_nm_en" class="col-sm-3 control-label">Code_Nm_En</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_code_nm_en" name="code_nm_en" class="form-control" placeholder="Code Name(Eng)" maxlength="30">
                  </div>
                </div>
                <div class="form-group">
                  <label for="code_dscr" class="col-sm-3 control-label">Code_Description</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_code_dscr" name="code_dscr" class="form-control" placeholder="Code Description" maxlength="100">
                  </div>
                </div>
                <div class="form-group">
                  <label for="code_order" class="col-sm-3 control-label">Code_Display</label>
                  <div class="col-sm-9">
                    <input type="number" id="d_code_order" name="code_order" class="form-control" placeholder="출력순서" maxlength="4" oninput="maxLengthCheck(this);">
                  </div>
                </div>
                <div class="form-group">
                  <label for="rdo_dcode_use_yn" class="col-sm-3 control-label">Use_Yn</label>
                  <div class="col-sm-9">
                  	<label>
		                  <input type="radio" name="rdo_dcode_use_yn" class="flat-red" value="Y" checked> Use
		                </label>
		                <label>
		                  <input type="radio" name="rdo_dcode_use_yn" class="flat-red" value="N" > No Use
		                </label>
                  </div>
                </div>
                <div class="form-group">
                  <label for="filter1_val" class="col-sm-3 control-label">Expand Filed01</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_filter1_val" name="filter1_val" class="form-control" placeholder="Expand Filed01" maxlength="20">
                  </div>
                </div>
                <div class="form-group">
                  <label for="filter2_val" class="col-sm-3 control-label">Expand Filed02</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_filter2_val" name="filter2_val" class="form-control" placeholder="Expand Filed02" maxlength="20">
                  </div>
                </div>
                <div class="form-group">
                  <label for="filter3_val" class="col-sm-3 control-label">Expand Filed03</label>
                  <div class="col-sm-9">
                    <input type="input" id="d_filter3_val" name="filter3_val" class="form-control" placeholder="Expand Filed03" maxlength="20">
                  </div>
                </div>
              </div>
            </form>
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
<script type="text/javascript">
$(function($) {
	fnLoadCommonOption();
	fnLoadMasterCodeGrid();
	fnLoadDetailCodeGrid();
})

function fnLoadCommonOption(){
	$('input[type="radio"].flat-red').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green',
		handle: 'radio'
	});
	
	$("#mcode_search, #dcode_search").pressEnter(function(e) {
		e.preventDefault();
		if(e.target.id == "mcode_search"){
			fnSearchMasterCodeGrid();
		} else if(e.target.id == "dcode_search"){
			var grid = $("#grid_mcode");
			var selected_master_code = grid.jqGrid('getGridParam',"selrow");
			fnSearchDetailCodeGrid(selected_master_code);
		}
	});
	
	$( "#btn_mcode_search, #btn_dcode_search" ).on('click', function(e) {
		e.preventDefault();
		if(e.target.id == "mcode_search"){
			fnSearchMasterCodeGrid();
		} else if(e.target.id == "dcode_search"){
			var grid = $("#grid_mcode");
			var selected_master_code = grid.jqGrid('getGridParam',"selrow");
			fnSearchDetailCodeGrid(selected_master_code);
		}
	});
	
	$( "#btn_mcode_add, #btn_dcode_add" ).on('click', function(e) {
		e.preventDefault();
		if(e.target.id == "btn_mcode_add"){
			$("form").each(function() {  
		        if(this.name == "frm_mcode") {
		        	this.reset();
		        	$("#m_code_order").val("9999");
		        }  
     		});  
			$("#btn_mcode_del").prop("disabled", true);
			$("#m_cmd").val("insert.master_code");
			
			$("#modal_mcode").modal('show');	
		} else if(e.target.id == "btn_dcode_add"){
			var sel = w2ui.grid_mcode.getSelection();
			var mrow = w2ui.grid_mcode.get(sel[0]);
			if( sel.length==0 ) {
				fnMessageModalAlert("Notification(Code)", "마스터 코드를 선택하세요.");
				return;
			}
			$("form").each(function() {  
		        if(this.name == "frm_dcode") {
		        	this.reset();
		        	$("#d_code_order").val("9999");
		        	$("#d_master_code").val(mrow.master_code);
		        }  
     	});
			$("#btn_dcode_del").prop("disabled", true);
			$("#d_cmd").val("insert.detail_code");
			
			$("#modal_dcode").modal('show');
		}
	});
	
	$( "#btn_mcode_info, #btn_dcode_info" ).on('click', function(e) {
		e.preventDefault();
		if( e.target.id == 'btn_mcode_info' ){
			var selection = w2ui.grid_mcode.getSelection();
			if( selection.length==0 ) {
				fnMessageModalAlert("Notification(Code)", "마스터 코드를 선택하세요.");
				return;
			} else {
				var rowData = w2ui.grid_mcode.get(selection[0]);
				$("#m_master_code").val(rowData.master_code);
				$("#m_code_nm").val(rowData.code_nm);
				$("#m_code_nm_en").val(rowData.code_nm_en);
				$("#m_code_order").val(rowData.code_order);
				$("#m_code_dscr").val(rowData.code_dscr);
				$("#m_code_use_yn").val(rowData.code_use_yn);
				$("#m_filter1_val").val(rowData.filter1_val);
				$("#m_filter2_val").val(rowData.filter2_val);
				$("#m_filter3_val").val(rowData.filter3_val);
				$(':radio[name="rdo_mcode_use_yn"][value="'+rowData.code_use_yn+'"]').iCheck('check');
				$(':radio[name="rdo_mcode_use_yn"]').iCheck('update');
				
				$("#m_cmd").val("update.master_code");
				$("#btn_mcode_del").prop("disabled", false);
				
				$("#modal_mcode").modal('show');
			}
		} else if(e.target.id == "btn_dcode_info"){
			var selection = w2ui.grid_dcode.getSelection();
			if( selection.length==0 ) {
				fnMessageModalAlert("Notification(Code)", "디테일 코드를 선택하세요.");
				return;
			} else {
				var rowData = w2ui.grid_dcode.get(selection[0]);
				$("#d_master_code").val(rowData.master_code);
				$("#d_detail_code").val(rowData.detail_code);
				$("#d_code_nm").val(rowData.code_nm);
				$("#d_code_nm_en").val(rowData.code_nm_en);
				$("#d_code_order").val(rowData.code_order);
				$("#d_code_dscr").val(rowData.code_dscr);
				$("#d_code_use_yn").val(rowData.code_use_yn);
				$("#d_filter1_val").val(rowData.filter1_val);
				$("#d_filter2_val").val(rowData.filter2_val);
				$("#d_filter3_val").val(rowData.filter3_val);
				
				$(':radio[name="rdo_dcode_use_yn"][value="'+rowData.code_use_yn+'"]').iCheck('check');
				$(':radio[name="rdo_dcode_use_yn"]').iCheck('update');
				
				$("#d_cmd").val("update.detail_code");
				$("#btn_dcode_del").prop("disabled", false);
				
				$("#modal_dcode").modal('show');
			}
		}
	});
	
	$( "#btn_mcode_save, #btn_dcode_save" ).on('click', function(e) {
		e.preventDefault();
		if(e.target.id == "btn_mcode_save"){
			if($.trim($("#m_code_nm").val()).length == 0 || $.trim($("#m_code_nm_en").val()).length == 0) {
				fnMessageModalAlert("Notification(Code)", "코드명을 입력하세요.(영문코드포함)");
				return;
			}
			
			if($.trim($("#m_code_order").val()).length != 4) {
				fnMessageModalAlert("Notification(Code)", "코드출력순서를 4자리를 입력하세요.");
				return;
			}
			$("#m_code_use_yn").val($(':radio[name="rdo_mcode_use_yn"]:checked').val());

			fnSaveCode("frm_mcode");
		} else if(e.target.id == "btn_dcode_save"){
			
			if($.trim($("#d_code_nm").val()).length == 0 || $.trim($("#d_code_nm_en").val()).length == 0) {
				fnMessageModalAlert("Notification(Code)", "코드명을 입력하세요.(영문코드포함)");
				return;
			}
			
			if($.trim($("#d_code_order").val()).length != 4) {
				fnMessageModalAlert("Notification(Code)", "코드출력순서를 4자리를 입력하세요.");
				return;
			}
			$("#d_code_use_yn").val($(':radio[name="rdo_dcode_use_yn"]:checked').val());
			fnSaveCode("frm_dcode");
		}
	});	
	
	$( "#btn_mcode_del, #btn_dcode_del" ).on('click', function(e) {
		e.preventDefault();
		
		if(e.target.id == "btn_mcode_del"){
			fnMessageModalConfirm("Confirm(Code)", "마스터코드를 삭제하시겠습니까?<br/>[주의] 삭제된 데이터는 복구되지 않습니다.<br/>[주의] 마스터 하위코드들도 삭제처리 됩니다.", function(result){
				if(result) {
					$("#m_cmd").val("delete.master_code");
					fnDeleteCode("frm_mcode");
				}
			});
			
		} else if(e.target.id == "btn_dcode_del"){
			fnMessageModalConfirm("Confirm(Code)", "디테일코드를 삭제하시겠습니까?<br/>[주의] 삭제된 데이터는 복구되지 않습니다.", function(result){
				if(result) {
					$("#d_cmd").val("delete.detail_code");
					fnDeleteCode("frm_dcode");
				}
			});
		}
	});	
}

function fnLoadMasterCodeGrid(){
	$("#grid_mcode").w2grid({
		name : 'grid_mcode',
		show : {
			lineNumbers : true,
            footer: true
        },
        multiSelect: false,
        columns : [
// 			{ field:, caption:, size:'px', style:'text-align:center;'},
			{ field:'master_code', caption:'Code', size:'15', sortable:true},
			{ field:'code_nm', caption:'Code Name', size:'15', sortable:true},
			{ field:'code_nm_en', caption:'Code Name(En)', hidden:true},
			{ field:'code_order', caption:'Display', size:'10', sortable:true},
			{ field:'code_use_yn', caption:'UseYN', size:'10'},
			{ field:'code_dscr', caption:'Description', size:'50'},
			{ field:'filter1_val', caption:'', hidden:true},
			{ field:'filter2_val', caption:'', hidden:true},
			{ field:'filter3_val', caption:'', hidden:true} ],
		sortData: [{field: 'master_code', direction: 'DESC'}],
		records: [],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},
		onClick: function (event) {
			var rowData = $(this)[0].get(event.recid);
			w2ui.grid_dcode.clear();
			fnSearchDetailCodeGrid(rowData.master_code);
		}
	});
	fnSearchMasterCodeGrid();
}

function fnSearchMasterCodeGrid(){
	var page_url = "/backend/code/data_codegrid"
				 + "?code_nm=" + encodeURIComponent($("#mcode_search").val());
	var rowArr = [];
	w2ui['grid_mcode'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		async : false,
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				w2ui['grid_mcode'].records = rowArr;
				w2ui['grid_mcode'].total = rowArr.length;
			}
			w2ui['grid_mcode'].refresh();
			w2ui['grid_mcode'].unlock();
		},complete: function () {}
	});
}

function fnLoadDetailCodeGrid(){
	$("#grid_dcode").w2grid({
		name : 'grid_dcode',
		show : {
			lineNumbers : true,
            footer: true
        },
        columns : [
			{ field:'detail_code', caption:'Code', size:'10%', sortable:true},
			{ field:'master_code', caption:'MCode', hidden:true},
			{ field:'code_nm', caption:'Code Name', size:'15%', sortable:true},
			{ field:'code_nm_en', caption:'Code Name(En)', hidden:true},
			{ field:'code_order', caption:'Display', size:'10%', sortable:true},
			{ field:'code_use_yn', caption:'Use YN', size:'10%'},
			{ field:'code_dscr', caption:'Description', size:'25%', sortable:false},
			{ field:'filter1_val', caption:'filter1', size:'10%'},
			{ field:'filter2_val', caption:'filter2', size:'10%'},
			{ field:'filter3_val', caption:'filter3', size:'10%'}	],
		sortData: [{field: 'detail_code', direction: 'DESC'}],
		records: [],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},
		onClick: function (event) {},
	});
}

function fnSearchDetailCodeGrid(mcode){
	var page_url = "/backend/code/data_codegrid"
				 + "?master_code=" + encodeURIComponent(mcode)
				 + "&code_nm=" + encodeURIComponent($("#dcode_search").val());
	
	var rowArr = [];
	w2ui['grid_dcode'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		async : false,
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				w2ui['grid_dcode'].records = rowArr;
				w2ui['grid_dcode'].total = rowArr.length;
			}
			w2ui['grid_dcode'].refresh();
			w2ui['grid_dcode'].unlock();
		},complete: function () {}
	});
}

function fnSaveCode(frm_name){
	var postData = $("#"+frm_name).serializeArray();
	var formURL = "/backend/code/save_code";
	
	$.ajax({
		url : formURL,
		type: "POST",
		data : postData,
		success:function(data, textStatus, jqXHR){
			if(data.status == "200") {
				fnMessageModalAlert("Notification(Code)", "입력하신 코드를 저장하였습니다.");
				if(data.division == "master") {
					fnSearchMasterCodeGrid();	
					$("#modal_mcode").modal('hide');
				} else {
					var rowData = w2ui.grid_mcode.get(w2ui.grid_mcode.getSelection()[0]);
					fnSearchDetailCodeGrid(rowData.master_code);
					$("#modal_dcode").modal('hide');
				}
			} else {
				fnMessageModalAlert("Notification(Code)", "코드를 저장하는데 에러가 발생하였습니다.");
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("Notification(Code)", "코드를 저장하는데 에러가 발생하였습니다.");
		}
	});
}

function fnDeleteCode(frm_name){
	var postData = $("#"+frm_name).serializeArray();
	var formURL = "/backend/code/del_code";
  
	$.ajax({
		url : formURL,
		type: "POST",
		data : postData,
		success:function(data, textStatus, jqXHR){
			if(data.status == "200") {
				fnMessageModalAlert("Notification(Code)", "코드를 삭제하였습니다.");
				if(data.division == "master") {
					fnSearchMasterCodeGrid();
					$("#modal_mcode").modal('hide');
				} else {
					var grid = $("#grid_mcode");
					var selected_master_code = grid.jqGrid('getGridParam',"selrow");
					fnSearchDetailCodeGrid(selected_master_code);
					$("#modal_dcode").modal('hide');
				}
			} else {
				fnMessageModalAlert("Notification(Code)", "코드를 삭제하는데 에러가 발생하였습니다.");	
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("Notification(Code)", "코드를 삭제하는데 에러가 발생하였습니다.");	
		}
	});
}
</script>
</body>
</html>