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
		<jsp:param name="selected_menu_p_cd" value="1011" />
		<jsp:param name="selected_menu_cd" value="1081" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>품질관리<small>검사Lot생성</small></h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 품질관리</a></li><li class="active">검사Lot생성</li>
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
							<button type="button" id="btn_save"
								class="btn btn-primary btn-sm" onClick="fnSaveInspLot();">Lot 생성</button> |
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
									<label>| 플랜트 구분</label>
									<div class="form-group">
										<select id="i_werks" class="form-control input-sm">
											<option value="1110">의료</option>
											<option value="1210">광</option>
										</select>
									</div>
								</div>
							</div>
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
									<label>| 자재 번호</label>
									<div class="form-group">
										<input type="text" id="i_matnr" class="form-control input-sm">
									</div>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group">
									<label>| 자재 내역</label>
									<div class="form-group">
										<input type="text" id="i_maktx" class="form-control input-sm">
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
	initOptions($('#i_lgort'));
	
	getFromStrList();
		
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
function fnSearchInspGrid(){
	console.log('fnSearchInspGrid()');
	
	var jidate_from = '';
	var jidate_to = '';
	
	var page_url = "/frontend/qm/insp_select"
				 + "?werks=" + encodeURIComponent($("#i_werks").val())
				 + "&lgort=" + encodeURIComponent($("#i_lgort").val())
				 + "&matnr=" + encodeURIComponent($("#i_matnr").val())
				 + "&maktx=" + encodeURIComponent($("#i_maktx").val());
	
	$("#grid_insp").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_insp").trigger("reloadGrid");
}

// init grid
function fnLoadInspGrid(){
	console.log('fnLoadInspGrid()');

	
	$("#grid_insp").jqGrid({
		datatype: "json",
		colNames:['자재코드', '자재내역', '자재스펙', 'werks', '플랜트', 'lgort', '창고', '단위', '재고량', '검사수량' ],
		colModel:[
	        {name:'matnr', index:'matnr', width:20, key:true},
	        {name:'maktx', index:'maktx', width:20},
        	{name:'wrkst', index:'wrkst', width:20},
        	{name:'werks', index:'werks', width:20, hidden:true},
        	{name:'werks_nm', index:'werks', width:20},
        	{name:'lgort', index:'lgort', width:20, hidden:true},
        	{name:'lgort_nm', index:'lgort_nm', width:20},
        	{name:'meins', index:'meins', width:20},
        	{name:'labst', index:'labst', width:20, align : 'right'},
        	{name:'inspn', index:'inspn', width:20, editable:true, align : 'right'},
		],
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		pager : "#grid_insp_pager",
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
	    jsonReader : {
	      root : "list_data",
	      records : "records",
	      repeatitems : false,
 	      id : "matnr"
	    },
	    loadonce: false,
	    sortable: true,
	    onSelectRow: function(key, selected) {
			
	    },
	    afterEditCell: function (rowid, cellname, value, iRow, iCol) {
            if(cellname=='inspn') {
	            e = jQuery.Event("keydown");
	            e.keyCode = $.ui.keyCode.ENTER;
	            //get the edited thing
	            edit = $(".edit-cell > *");
	            edit.blur(function() {
	                edit.trigger(e);
	            });
            }
    	},
    	loadComplete : function(data){
	    	console.log(data);

	    }
	}); 
}
function getFromStrList() {
	
	initOptions($('#i_lgort'));
	
	var page_url = "/frontend/scm/scm_sloc_code_select";
	
	var postData = 'werks=' + encodeURIComponent($('#i_werks').val());

	
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
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

function fnSaveInspLot() {
	
	var s_id = $("#grid_insp").getGridParam('selrow')
	var s_inspn = $("#grid_insp").getRowData(s_id).inspn;
	var s_werks_nm = $("#grid_insp").getRowData(s_id).werks_nm;
	var s_matnr = $("#grid_insp").getRowData(s_id).matnr;
	console.log(s_id);
	
	if(s_id == null) {
		fnMessageModalAlert("Notification(QM)", "Lot 생성 대상 내역이 선택되지 않았습니다.");		
		return;
	}
	
	fnMessageModalConfirm("Notification(QM)", "해당 내역의 Lot 생성을 하시겠습니까?<br/><br/> 검사요청수량 : " +  s_inspn +"<br/> 플랜트 : " + s_werks_nm 
			+ "<br/> 자재 : " + s_matnr, function(result){
		if(result) {
			SaveInspLot();	
		}
	});
}

function SaveInspLot() {
	
	var rowData = $("#grid_insp").getRowData($("#grid_insp").getGridParam('selrow'));
	
	
	var page_url = "/frontend/qm/fnSaveInspLot";
	var postData = 'werks=' + encodeURIComponent(rowData.werks);
	postData += '&lgort=' + encodeURIComponent(rowData.lgort);
	postData += '&t_gubun=' + encodeURIComponent("tp");
	postData += '&matnr=' + encodeURIComponent(rowData.matnr);
	postData += '&maktx=' + encodeURIComponent(rowData.maktx);
	postData += '&meins=' + encodeURIComponent(rowData.meins);
	postData += '&bdmng=' + encodeURIComponent(rowData.inspn);
	postData += '&insts=' + encodeURIComponent("ST");

	
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				fnMessageModalAlert("Notification(QM)", "검사 Lot 생성을 성공했습니다. <br/> Lot 번호 : " +  data.inspec_lot);
	    	} else {
	    		fnMessageModalAlert("Notification(QM)", "검사 Lot 생성을 실패했습니다.");
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(QM)", "검사 Lot 생성을 실패했습니다.");	
	    },
	    complete: function() {
	    	
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
</script>
</body>
</html>