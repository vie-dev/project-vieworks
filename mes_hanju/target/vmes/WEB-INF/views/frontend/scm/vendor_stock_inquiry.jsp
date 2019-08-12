<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.bitts.vmes.util.*"%>
<%
String memberId = SessionUtil.getMemberId(request);
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
		<jsp:param name="selected_menu_p_cd" value="1013" />
		<jsp:param name="selected_menu_cd" value="1097" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>SCM관리<small>협력업체 재고조회</small></h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> SCM관리</a></li><li class="active">협력업체 재고조회</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-success box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">조회조건</h3>
						<span id="infoTxt" style="font-weight:bold; color:red;"></span>
						<div class="box-tools pull-right">
							<button type="button" id="btn_search"
								class="btn btn-primary btn-sm" onClick="fnSearchInspGrid();">조회</button>
							<button type="button" id="btn_search_init" class="btn btn-primary btn-sm" onClick="initCondition();">조건초기화</button>
							<button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_insp');" data-selfilepath="/upload" data-selfilename="test.xlsx">
							  <span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
							</button>
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-3">
								<div class="form-group">
									<label>| 품목코드</label>
									<div class="form-group">
										<input type="text" id="i_matnr" class="form-control input-sm">
									</div>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group">
									<label>| 품목명</label>
									<div class="form-group">
										<input type="text" id="i_maktx" class="form-control input-sm">
									</div>
								</div>
							</div>
							<div class="col-sm-3 search_param">
								<div class="form-group">
									<label>| 업체명</label>
									<div class="form-group">
										<input type="text" id="i_name1" class="form-control input-sm">
									</div>
								</div>
							</div>
							<div class="col-sm-3 search_param">
								<div class="form-group">
									<label>| 업체코드</label>
									<div class="form-group">
										<input type="text" id="i_lifnr" class="form-control input-sm">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-12">
				<div id="dv_grid_insp" class="col-sm-12">
					<table id="grid_insp"></table>
					<div id="grid_insp_pager"></div>
				</div>
			</div>
		</section>
 	</div>

<!-- ************************시리얼 정보 : Start ************************-->
<!--   <div class="modal fade" id="operate_his" data-backdrop="static"> -->
  <div class="modal fade" id="serial_info" data-backdrop="static">
    <div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">시리얼 재고 정보</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
			<div class="box box-warning box-solid">
			<div class="box-header with-border">
				<h3 class="box-title">시리얼 내역 조회</h3>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="box-body">				
			    	<form id="frm_operate_his" name="frm_operate_his" class="form-horizontal">
						<div class="row">
							<table id="grid_operate_his"></table>
						</div>
					</form>
				</div>
	        </div>
	        </div>
	        </div>
		</div>
	</div>
</div>
<!-- ************************시리얼 정보 : End ************************-->
  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>

<script type="text/javascript">
var lastSel;
var memberId = "<%=memberId%>";

$(function($) {
	fnLoadCommonOption();
	
	var lifnr = fnChkUser();
	if(lifnr.length > 0) {
		$("#i_lifnr").val(lifnr);
		$(".search_param").hide();
	}
})

// search component setting
function fnLoadCommonOption() {
	console.info('fnLoadCommonOption()');
	
	$(window).bind('resize', function() {
		resizeJqGrid("grid_insp", false);
	}).trigger('resize');
	
	$('input[type="radio"].flat-red').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green',
		handle: 'radio'
	});
	
	fnLoadInspGrid();

}

function initCondition() {
	console.info('initCondition()');
	$("#i_matnr").val("");
	$("#i_maktx").val("");
}

// serch result grid
function fnSearchInspGrid(){
	console.log('fnSearchInspGrid()');
	$("#grid_insp").jqGrid('clearGridData');
// 	$('#infoTxt').text('데이터 로딩 중입니다...');
	
	
	var rtn_data = [];
	var page_url = "/sap_master/vendor_stock_inquiry"
// 				 + "?werks=" + encodeURIComponent($("#i_werks").val())
// 				 + "&lgort=" + encodeURIComponent($("#i_lgort").val())
				 + "?lifnr=" + encodeURIComponent($("#i_lifnr").val())
				 + "&name1=" + encodeURIComponent($("#i_name1").val());
	
	
	$.ajax({
	    url: page_url,
	    type: "POST",
	    async : false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		for(var i=0 ; i<(data.rows_1).length ; i++) {
	    			(data.rows_0).push((data.rows_1)[i]);
	    		}

	    		var names = [];
	    		
				if( (data.rows_0).length>0){
					for(var i=0 ; i<(data.rows_0).length ; i++) {
						
						(data.rows_0)[i].labst = (Number((data.rows_0)[i].labst)).toFixed(0);
						
						if(($("#i_matnr").val().length == 0) && ($("#i_maktx").val().length == 0)) {
							names.push((data.rows_0)[i].lifnr);
							rtn_data.push((data.rows_0)[i]);
						}
						else if(($("#i_matnr").val().length != 0) && ($("#i_maktx").val().length == 0)) {
							if(((data.rows_0)[i].matnr.indexOf($("#i_matnr").val())) != -1) {
								names.push((data.rows_0)[i].lifnr);
								rtn_data.push((data.rows_0)[i]);
							}
						}
						else if(($("#i_matnr").val().length == 0) && ($("#i_maktx").val().length != 0)) {
							if(((data.rows_0)[i].maktx.indexOf($("#i_maktx").val())) != -1) {
								names.push((data.rows_0)[i].lifnr);
								rtn_data.push((data.rows_0)[i]);
							}
						} else {
							if(((data.rows_0)[i].matnr.indexOf($("#i_matnr").val())) != -1 && ((data.rows_0)[i].maktx.indexOf($("#i_maktx").val())) != -1) {
								names.push((data.rows_0)[i].lifnr);
								rtn_data.push((data.rows_0)[i]);
							}
						}
					}
										
					/////////////////////////////////////////
					var uniqueNames = [];
					var lifnrs = "";
					$.each(names, function(i, el){
						if($.inArray(el, uniqueNames) === -1) {
							uniqueNames.push(el);
							lifnrs = el + "," + lifnrs
							}
					});

					lifnrs = lifnrs.substring(0, lifnrs.length-1);
					
					var vendor_nm_rtn = vender_nm_grid_add(lifnrs);
					
					for(var i=0 ; i<rtn_data.length ; i++) {
						for(var j=0 ; j<vendor_nm_rtn.length ; j++) {	
							if(rtn_data[i].lifnr == vendor_nm_rtn[j].lifnr) {
								rtn_data[i].name1 = vendor_nm_rtn[j].name1;
							}
						}				
					}
							
					var rtn_data_nm_filter = [];
					
					if($("#i_name1").val().length != 0) {
						for(var i=0 ; i<rtn_data.length ; i++) {
							var rtn_nm = (rtn_data)[i].name1;
							var p_nm = $("#i_name1").val()
							
							if(rtn_nm == undefined) {
								continue;
							}
							if((rtn_nm.indexOf(p_nm)) != -1) {
								rtn_data_nm_filter.push((rtn_data)[i]);
							}
						}
					} else {
						rtn_data_nm_filter = rtn_data;
					}
					
					$('#grid_insp').jqGrid('setGridParam', { datatype: 'local', data: (rtn_data_nm_filter) }).trigger('reloadGrid');
				}
	    	} else {
	    		fnMessageModalAlert("Fail", "조회 실패");
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Fail", "조회 실패");
	    },
	    complete: function() {	    	
	    }
	});
}

function vender_nm_grid_add(lifnrs) {
	var page_url = "/frontend/scm/vender_nm_grid_add";
	var params = "lifnrs="+encodeURIComponent(lifnrs);
	var rtn = "";
	
	$.ajax({
		url : page_url,
		data : params,
	    type: "POST",
	    async:false,
	    success:function(data, textStatus, jqXHR){
	    		rtn = data.rows;
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    },
	    complete: function() {
	    }
	});
	
	return rtn;
}
// init grid
function fnLoadInspGrid(){
	console.log('fnLoadInspGrid()');

	
	$("#grid_insp").jqGrid({
		datatype: "json",
		colNames:['품목코드', '품목명', 'Spec', 'werks', '플랜트', 'lgort', '업체명','업체코드', 'sernp', '시리얼 내역 확인', '단위', '재고량'],
		colModel:[
	        {name:'matnr', index:'matnr', width:20, key:true},
	        {name:'maktx', index:'maktx', width:20},
        	{name:'wrkst', index:'wrkst', width:20},
        	{name:'werks', index:'werks', width:20, hidden:true},
        	{name:'werks_nm', index:'werks_nm', width:20},
        	{name:'lgort', index:'lgort', width:20, hidden:true},
        	{name:'name1', index:'name1', width:20},
        	{name:'lifnr', index:'lifnr', width:20},
        	{name:'sernp', index:'sernp', width:20, hidden:true},
        	{name:'f_sernp', index:'sernp', width:20, formatter:jqgridHighlightFormatterSernrYn},
        	{name:'meins', index:'meins', width:20},
        	{name:'labst', index:'labst', width:20, align : 'right'}
		],
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		pager : "#grid_insp_pager",
		height: 600,
	    width:270,
	    rownumWidth: 25,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
		altRows: true,
		rownumbers: true, 
	    autoencode: true,
	    loadonce: true,
	    sortable: true,
	    onSelectRow : function(rowid, selected) {
// 	    	var selGridRowData = $("#grid_insp").getRowData($('#grid_insp').jqGrid('getGridParam','selrow'));
			
// 			if(selGridRowData.sernp == 'V001') {
// 				$("#grid_operate_his").jqGrid('clearGridData');
// 				fnSearchOperateHisGrid();	
// 				$("#serial_info").modal('show');
// 			}
	    },
    	loadComplete : function(data){
	    	
	    }
	}); 
}

function excelFileDownload(gridName) {
// 	console.log('excelFileDownload('+gridName+')');
	var tmpArr = [];
	var getColNames = $("#grid_insp").jqGrid('getGridParam','colNames');
	var getColModels = $("#grid_insp").jqGrid('getGridParam','colModel');
	$.each(getColModels, function(idx, mrow){
		if( mrow.hidden==false && getColNames[idx]!='' ) {
			mrow.caption = getColNames[idx]; 
			tmpArr.push(mrow);  
		}
	});
	
	var gridCols = tmpArr;
	var gridData = $("#grid_insp").getRowData();

	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	if( gridName=='grid_insp' ) {
		fileName = '검사Lot생성.xlsx';
		sheetTitle = '검사Lot생성';
		sheetName = '검사Lot생성';
	}
	
	var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
	var is_rownum = true;
	
	if(gridCols != null && gridCols.length > 0){
		// w2grid 는 linenumber column info not exist
		param_col_name = "No"
		param_col_id = "rownum";
		param_col_align = "center";
		param_col_width = "80";
		//--------------------------------------------
		console.log(gridCols);
		for(var i=0; i<gridCols.length; i++){
			if(!gridCols[i].hidden){
				var caption = gridCols[i].caption;
				param_col_name += "," + caption;
				param_col_id += "," + gridCols[i].name;
				param_col_align += ",left";
				param_col_width += "," + (gridCols[i].width==undefined?"80":(gridCols[i].width));
			}
		}
	}
	
	var export_url = "/export/export_client_jqgrid";
	var export_data = "file_name="+encodeURIComponent(fileName);
		export_data += "&sheet_title="+encodeURIComponent(sheetTitle);
		export_data += "&sheet_name="+encodeURIComponent(sheetName);
		export_data += "&header_col_names="+encodeURIComponent(param_col_name);
		export_data += "&header_col_ids="+encodeURIComponent(param_col_id);
		export_data += "&header_col_aligns="+encodeURIComponent(param_col_align);
		export_data += "&header_col_widths="+encodeURIComponent(param_col_width);
		export_data += "&cmd="+encodeURIComponent("grid_goods_detail");
		export_data += "&body_data="+encodeURIComponent(JSON.stringify(gridData));

	$.ajax({
	  url:export_url,
	  data:export_data,
	  type:'POST',
	  dataType: 'json',
	  success: function( data ) {
	  	if(data.status == 200) {
	  		var file_path = data.file_path;
	  		var file_name = data.file_name;
	  		var protocol = jQuery(location).attr('protocol');
  			var host = jQuery(location).attr('host');
  			var link_url = "/file/attach_download";
  			link_url += "?file_path="+encodeURIComponent(file_path);
  			link_url += "&file_name="+encodeURIComponent(file_name);
  			$(location).attr('href', link_url);
	  	}
	  },
	  complete: function () {}
	});
}

function fnSearchOperateHisGrid() {
	
	var selGridRowData = $("#grid_insp").getRowData($('#grid_insp').jqGrid('getGridParam','selrow'));

	var page_url = "/sap_master/stock_inquiry"
		 + "?werks=" + encodeURIComponent($("#i_werks").val())
		 + "&lgort=" + encodeURIComponent($("#i_lgort").val())
		 + "&matnr=" + encodeURIComponent(selGridRowData.matnr)
		 + "&gubun=" + encodeURIComponent("D");
	
	$.ajax({
	    url: page_url,
	    type: "POST",
	    async : false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					console.log((data.rows));
				
					for(var i=0 ; i<(data.rows).length ; i++) {
						(data.rows)[i].lgort_nm = $("#i_lgort option:selected").text();
					}
					$('#grid_operate_his').jqGrid('setGridParam', { datatype: 'local', data: data.rows }).trigger('reloadGrid');
				}
	    	} else {
	    		fnMessageModalAlert("Fail", "조회 실패");
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Fail", "조회 실패");
	    },
	    complete: function() {	    	
	    }
	});
}

function jqgridHighlightFormatterSernrYn(cellvalue, options, rowObject) {
	if (rowObject.sernp != null && rowObject.sernp != "" && rowObject.sernp =='V001') {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">시리얼대상</span>';
	} else {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">비시리얼대상</span>';
	}
}

function fnChkUser() {
	//console.log('fnChkUser()');
	
	var  lifnr = '';
	var page_url = "/frontend/scm/checkVenderMember";
	var params = "member_emp_no="+encodeURIComponent(memberId);
	
	$.ajax({
		url : page_url,
		data : params,
		type : 'POST',
		async : false,
		dataType : 'json',
		success: function( data ) {
			if(data.status == 200) {
				var dept_cd = data.result;
				if( data.result=='1063') lifnr = memberId;
				else lifnr = '';
			}
		},
		complete: function () {}
	});
	return lifnr;
}
</script>
</body>
</html>