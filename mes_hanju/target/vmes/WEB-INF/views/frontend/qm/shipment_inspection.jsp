<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		<jsp:param name="selected_menu_p_cd" value="1011" />
		<jsp:param name="selected_menu_cd" value="1035" />
	</jsp:include>

<div class="content-wrapper">
	<section class="content-header">
		<h1>
			MES <small>출하지시조회</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> MES</a></li>
			<li class="active">출하지시조회</li>
		</ol>
	</section>
	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 180px;">
					<div class="box-header with-border">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_search_csr"
								class="btn btn-primary btn-sm">조회</button>
							<button type="button" id="btn_search_init"
								class="btn btn-primary btn-sm">조건초기화</button>
							| <button type="button" id="btn_search_csr"
								class="btn btn-primary btn-sm">완료</button>
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
									<label>지시일</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right"
											id="csr_register_date_range">
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>지시번호</label> <input type="input"
										id="customer_member_nm" name="customer_member_nm"
										class="form-control" placeholder="ex) 10010010010"
										maxlength="30">
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>품명</label> <input type="input" id="customer_member_nm"
										name="customer_member_nm" class="form-control"
										placeholder="ex) REL  PCNF DLV  PRC  GMCO MANC SETC"
										maxlength="50">
								</div>
							</div>

							<div class="col-sm-2">
								<div class="form-group">
									<label>상태</label><br /> 
									<label> <input type="radio"
										name="rdo_csr_req_type" class="flat-red" value="" checked>
										전체
									</label> <label> <input type="radio" name="rdo_csr_req_type"
										class="flat-red" value="01"> 지시
									</label> <label> <input type="radio" name="rdo_csr_req_type"
										class="flat-red" value="02"> 완료
									</label>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box box-default box-solid" style="min-height: 680px;">
					<div class="box-header with-border">
						<h3 class="box-title">출하지시내역</h3>
					</div>
					<div class="box-body">
						<div class="row">
							<div id="dv_grid_role" class="col-sm-12">
								<table id="grid_role"></table>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</section>
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
	fnLoadRoleGrid();
})

function fnLoadCommonOption() {
	$('input[type="radio"].flat-red').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green',
		handle: 'radio'
	});

	$("#csr_register_date_range").pressEnter(function(e) {
		e.preventDefault();
		if(e.target.id == "csr_register_date_range"){
			fnSearchMasterCodeGrid();
		}
	});
		
	$('#csr_register_date_range').daterangepicker({
		locale: {
		      format: 'YYYY-MM-DD',
			  opens: 'right'
		}
	});
}

function fnSearchMasterCodeGrid() {
	var page_url = "/backend/prod/prod_select";
		page_url += "?jidat=" + encodeURIComponent("2016-10-05");
		page_url += "&prod_memo=" + encodeURIComponent($("#csr_register_date_range").val());
	
	$("#grid_role").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_role").trigger("reloadGrid");
}

function fnLoadRoleGrid() {
	var page_url = "/backend/prod/prod_select";
		page_url += "?jidat=" + encodeURIComponent("2016-10-05");
	
	$("#grid_role").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['','확정일','지시번호', '지시일','품명','메모'],
		colModel:[
			{name:'chk',index:'chk', width:4, editable: true, align:'center', edittype: 'checkbox', editoptions: { value: "true:false", defaultValue: "false" },
	            formatter: "checkbox", formatoptions: { disabled: false }},
	        {name:'confdt',index:'confdt', width:20, sorttype:"text", sortable:true},
			{name:'pordno_pop',index:'pordno_pop', width:30, sorttype:"text", sortable:true, key:true},
			{name:'jidat',index:'jidat', width:20, sorttype:"text", sortable:true},
			{name:'pordno_status',index:'pordno_status', width:70,sorttype:"text", sortable:true},
			{name:'prod_memo',index:'prod_memo', width:50,sorttype:"text", sortable:true},
		],
		rowNum:1000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 550,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    sortable: true,
    //sortname: "detail_code",
    
    //onSelectRow: function(rowid, selected) {
	//		if(rowid != null) {
	//			selected_role_cd = $("#grid_role").jqGrid('getRowData', rowid).filter1_val;
	//			selected_role_nm = $("#grid_role").jqGrid('getRowData', rowid).code_nm;
	//			fnSearchRoleUserGrid(selected_role_cd);
	//		}					
	//	},
	//	loadComplete : function() {
	//		
	//	}
	});
}

function fnLoadMasterCodeGrid() {
	var page_url = "/backend/code/data_codegrid";
	page_url += "?code_nm=" + encodeURIComponent($("#mcode_search").val());
	
	$("#grid_mcode").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['MCode','코드명', '코드명(En)','출력순서', '사용여부', '설명', '', '', ''],
		colModel:[
			{name:'master_code',index:'master_code', width:50, sorttype:"text", sortable:true, key: true},
			{name:'code_nm',index:'code_nm', sorttype:"text", sortable:true},
			{name:'code_nm_en',index:'code_nm_en', sorttype:"text", sortable:true, hidden:true},
			{name:'code_order',index:'code_order', width:90, sorttype:"int", sortable:true},
			{name:'code_use_yn',index:'code_use_yn', width:40},
			{name:'code_dscr',index:'code_dscr', width:150},
			{name:'filter1_val',index:'filter1_val', hidden:true},
			{name:'filter2_val',index:'filter2_val', hidden:true},
			{name:'filter3_val',index:'filter3_val', hidden:true}
		],
		rowNum:-1,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 550,
		altRows: true,
		rownumbers: true, 
    	rownumWidth: 25, 
		onSelectRow: function(rowid, selected) {
			if(rowid != null) {
				fnSearchDetailCodeGrid(rowid);
			}					
		},
		loadComplete : function() {
		}
	});
}

</script>
</body>
</html>