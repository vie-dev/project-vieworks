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
	
	<style type="text/css">
	.popupText {
		margin-top:7px;
		font-weight: bold;
		font-size:15px;
		color: #566573;
	}
	</style>
</head>

<body class="hold-transition skin-green-light sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1087" />
		<jsp:param name="selected_menu_cd" value="1088" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>EIS<small>EIS_test</small></h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> EIS</a></li><li class="active">EIS_test</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-success box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_search"
								class="btn btn-primary btn-sm" onClick="fnSearchInspGrid();">조회
							</button>
							<button type="button" id="btn_search"
								class="btn btn-primary btn-sm" onClick="ajaxTest();">ajaxTest
							</button>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="form-group">
							<label>| 조건1</label>
							<div class="form-group">
								<input type="text" id="param_1" class="form-control input-sm">
							</div>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="form-group">
							<label>| 조건2</label>
							<div class="form-group">
								<input type="text" id="param_2" class="form-control input-sm">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div id="dv_grid_insp" class="col-sm-12">
					<table id="grid_insp"></table>
				</div>
			</div>
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
var lastSel;

$(function($) {
	fnLoadCommonOption();
})

// search component setting
function fnLoadCommonOption() {
	console.info('fnLoadCommonOption()');
	
	$(window).bind('resize', function() {
		resizeJqGrid("grid_insp", false);
	}).trigger('resize');
	
	fnLoadInspGrid();
}

function initCondition() {
}

function fnSearchInspGrid(){
	console.log('fnSearchInspGrid()');
	
	
	var page_url = "/sap_master/eis_test"
				 + "?param_1=" + encodeURIComponent($("#param_1").val())
				 + "&param_2=" + encodeURIComponent($("#param_2").val());
	
	$("#grid_insp").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_insp").trigger("reloadGrid");
}

// init grid
function fnLoadInspGrid(){
	console.log('fnLoadInspGrid()');

	$("#grid_insp").jqGrid({
		datatype: "json",
		colNames:['aufnr', 'aplzl', 'vornr', 'arbpl', 'werks', 'steus', 'frdlb'],
		colModel:[
	        {name:'aufnr', index:'aufnr', width:20, key:true},
	        {name:'aplzl', index:'aplzl', width:20},
        	{name:'vornr', index:'vornr', width:20},
        	{name:'arbpl', index:'arbpl', width:20},
        	{name:'werks', index:'werks', width:20},
        	{name:'steus', index:'steus', width:20},
        	{name:'frdlb', index:'frdlb', width:20}
		],
		rowNum:10000,
	    height: 500,
	    width:270,
	    rownumWidth: 25,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
		altRows: true,
		cellEdit : true,
		cellsubmit : 'clientArray',
		rownumbers: true, 
	    autoencode: true,
	    loadonce: false,
	    sortable: true,
	    onSelectRow: function(key, selected) {
			
	    },
	    afterEditCell: function (rowid, cellname, value, iRow, iCol) {
    	},
    	loadComplete : function(data){
	    	console.log(data);
	    }
	}); 
}

function ajaxTest() {
	
	
	var page_url = "/sap_master/eis_test"
		 + "?param_1=" + encodeURIComponent($("#param_1").val())
		 + "&param_2=" + encodeURIComponent($("#param_2").val());

	
	$.ajax({
	    url: page_url,
	    type: "POST",
	    async:false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		console.log(data.rows);
				fnMessageModalAlert("Notification(QM)", "조회 성공");
	    	} else {
	    		fnMessageModalAlert("Notification(QM)", "조회 실패");
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(QM)", "조회 실패");	
	    },
	    complete: function() {
	    	
	    }
	});
}
</script>
</body>
</html>