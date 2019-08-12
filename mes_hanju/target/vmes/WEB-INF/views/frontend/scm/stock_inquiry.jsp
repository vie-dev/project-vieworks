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
		<jsp:param name="selected_menu_p_cd" value="1013" />
		<jsp:param name="selected_menu_cd" value="1093" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>SCM관리<small>내부재고조회</small></h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> SCM관리</a></li><li class="active">내부재고조회</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box" style="margin-bottom: 0px;">
					<div class="box-body"><!-- start box body -->
						<div class="row">
							<div class="col-md-12">
							<!-- <div class="col-sm-3">
								<div class="form-group">
									<label>| 플랜트 구분</label>
									<div class="form-group">
										<select id="i_werks" class="form-control input-sm">
											<option value="1110">의료</option>
											<option value="1210">광</option>
										</select>
									</div>
								</div>
							</div> -->
								<div class="col-sm-3">
									<div class="form-group">
										<div class="form-group">
										<label>| 창고구분</label>
											<select id="i_lgort" class="form-control select2" data-placeholder="유형 선택" style="width: 100%;">
											</select>
										</div>
									</div>
								</div>
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
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 text-right">
								<div class="box-tools pull-right">
									<button type="button" id="btn_search"
										class="btn btn-primary btn-sm" onClick="loadList();">조회</button>
									<button type="button" id="btn_search_init" class="btn btn-primary btn-sm" onClick="initCondition();">조건초기화</button>
									<button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_insp');" data-selfilepath="/upload" data-selfilename="test.xlsx">
									  <span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
									</button>
								</div>
							</div>
						</div>
						<div class="row" style="margin-top: 10px;">
							<div class="col-md-12">
								<div id="grid_insp" style="width: 100%; height: 620px;"></div>
								<div id="pagination" class="text-center"></div>
<!-- 								<div id="dv_grid_insp" class="col-sm-12"> -->
<!-- 									<table id="grid_insp"></table> -->
<!-- 									<div id="grid_insp_pager"></div> -->
<!-- 								</div> -->
							</div>
						</div>
					</div>
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

<script src="/res/plugins/pagination.js"></script>
<script type="text/javascript">
//for pagination
var page = 1; 		// 화면에서 사용할 page
var pageNum = 0; 	// 서버에 넘겨줄 page -> mysql 은 0 부터 시작
var rowPerPage = 20;
var rowLength = 0;
var totalPage = 0;
var cntRowPagination = 5;	// << 1 2 3 4 5 >>

var lastSel;

$(function($) {
	fnLoadCommonOption();
	initOptions($('#i_lgort'));
	
	getFromStrList();
	fnLoadOperateHisGrid();
	$('#i_werks').change(function(){
		getFromStrList();
	});
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
function loadList(pageNum){
	console.log('loadList()');
// 	$("#grid_insp").jqGrid('clearGridData');
	
	var page_url = "/sap_master/stock_inquiry"
				 + "?werks=" + encodeURIComponent($("#i_werks").val())
				 + "&lgort=" + encodeURIComponent($("#i_lgort").val())
				 + "&gubun=" + encodeURIComponent("M");
// 				 + "&matnr=" + encodeURIComponent($("#i_matnr").val())
// 				 + "&maktx=" + encodeURIComponent($("#i_maktx").val());
	var rtn_data = [];
	w2ui['grid_insp'].lock('loading...', true);
	$.ajax({
	    url: page_url,
	    type: "POST",
	    dataType : 'json',
	    async : false,
	    success:function(data){
	    	if(data.status == "200" && (data.rows).length>0 ) {
// 				for(var i=0 ; i<(data.rows).length ; i++) {
					rtn_data = data.rows;
					$.each(rtn_data, function(idx, row){
						row.recid = idx+1;
						row.lgort_nm = $("#i_lgort option:selected").text();
						row.labst = (Number(row.labst)).toFixed(0);
													
// 						$("#i_maktx").val();
						/* if(($("#i_matnr").val().length == 0) && ($("#i_maktx").val().length == 0)) {
							rtn_data.push(row);
						} else if(($("#i_matnr").val().length != 0) && ($("#i_maktx").val().length == 0)) {
							if((row.matnr.indexOf($("#i_matnr").val())) != -1) {
								rtn_data.push(row);
							}
						} else if(($("#i_matnr").val().length == 0) && ($("#i_maktx").val().length != 0)) {
							if((row.maktx.indexOf($("#i_maktx").val())) != -1) {
								rtn_data.push(row);
							}
						} else {
							if((row.matnr.indexOf($("#i_matnr").val())) != -1 && (row.maktx.indexOf($("#i_maktx").val())) != -1) {
								rtn_data.push(row);
							}
						} */
					});
					if(data.pageTotal == 0){
						$("#pagination").empty();
					} else {
						totalPage = data.pageTotal;
						pagination();
					}
					w2ui['grid_insp'].records = rowArr;
					w2ui['grid_insp'].total = rowArr.length;
// 				}
				
// 				$('#grid_insp').jqGrid('setGridParam', { datatype: 'local', data: rtn_data }).trigger('reloadGrid');
	    	} else {
	    		fnMessageModalAlert("Fail", "조회 실패");
	    	}
	    	w2ui['grid_insp'].refresh();
			w2ui['grid_insp'].unlock();
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Fail", "조회 실패");
	    },
	    complete: function() {	    	
	    }
	});
}

// init grid
function fnLoadInspGrid(){
	console.log('fnLoadInspGrid()');
	
	$("#grid_insp").w2grid({
		name : 'grid_reg',
		show : {
			lineNumbers : true,
            footer: true
        },
        columns : [
			{ field:'matnr', caption:'품목코드', size:'100px'},
			{ field:'maktx', caption:'품목명', size:'100px'},
			{ field:'wrkst', caption:'Spec', size:'100px'},
			{ field:'lgort', caption:'lgort', size:'100px', hidden:true},
			{ field:'lgort_nm', caption:'창고', size:'100px'},
			{ field:'sernp', caption:'sernp', size:'100px', hidden:true},
			{ field:'f_sernp', caption:'시리얼 내역 확인', size:'100px', render: function(rec){
				if (rec.sernp != null && rec.sernp != "" && rec.sernp =='V001') {
					return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">시리얼대상</span>';
				} else {
					return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">비시리얼대상</span>';
				}
			}},
			{ field:'meins', caption:'단위', size:'100px'},
			{ field:'labst', caption:'재고량', size:'100px', style:'text-align:right;'}	],
        sortData: [{field: 'matnr', direction: 'ASC'}],
   		records: [],
   		total : 0,
   		recordHeight : 30,
   		onReload: function(event) {},
   		onClick: function (event) {
   			console.log(event);
   			/*
   			var selGridRowData = $("#grid_insp").getRowData($('#grid_insp').jqGrid('getGridParam','selrow'));
			
			if(selGridRowData.sernp == 'V001') {
				$("#grid_operate_his").jqGrid('clearGridData');
				fnSearchOperateHisGrid();	
				$("#serial_info").modal('show');
			} */
   		}
   	});
   	loadList();
}

function getFromStrList() {
	
	initOptions($('#i_lgort'));
	
	var page_url = "/frontend/scm/scm_sloc_code_select";
	
	var postData = 'werks=' + encodeURIComponent($('#i_werks').val());

	
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    async : false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$.each(data.rows, function (i, item) {
						$('#i_lgort').append($('<option>', { 
							value: item.lgort,
					        text : item.lgobe 
					    }));
					});
				}
	    	} else {
	    		fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}

function initOptions(obj) {
    $(obj)
        .find('option')
        .remove()
        .end()
        //.append('<option value="">선택</option>')
        .val();
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

function fnLoadOperateHisGrid() {
	$('#grid_operate_his').jqGrid({
		datatype: 'json',
		colNames:['품목코드', '창고', '시리얼'],
		colModel:[
			{name:'matnr',index:'matnr', width:150, sorttype:'text'},
			{name:'lgort_nm',index:'lgort_nm', width:190, sorttype:'text'},
			{name:'sernr', index:'sernr', width:190, sorttype:'text'},
		],
		rowNum:10000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 360,
		altRows: true,
		rownumbers: true,
		cellEdit:false,
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true
	});
}

function jqgridHighlightFormatterSernrYn(cellvalue, options, rowObject) {
	if (rowObject.sernp != null && rowObject.sernp != "" && rowObject.sernp =='V001') {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">시리얼대상</span>';
	} else {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">비시리얼대상</span>';
	}
}
</script>
</body>
</html>