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
		<jsp:param name="selected_menu_p_cd" value="1013" />
		<jsp:param name="selected_menu_cd" value="1041" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        SCM관리
        <small>Vendor 확인</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> SCM관리</a></li><li class="active">Vendor 확인</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
    	<div class="row">
			<div class="col-md-6">
				<div class="box" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">요청 목록</h3>
						<div class="box-tools pull-right">
							<button type="button" id="" onclick="fnSearchGoodsList();" class="btn btn-primary btn-sm">조회</button>
						</div>
					</div>
					<div class="box-body" style="padding-bottom: 0px;">
						<div class="row">
							<div class="col-sm-4">
								<div id="area_decide_date_range" class="form-group">
									<label>| 요청내역일자</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right input-sm" id="decide_date_range">
									</div>
								</div>
								<div id="area_possible_date_range" class="form-group" style="display:none;">
									<label>| 납품가능일자</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right input-sm" id="possible_date_range">
									</div>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 처리상태</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="rvendor_status" class="form-control select2 input-sm" data-placeholder="Vendor 선택" style="width: 100%;">
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 품목코드</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<div class="input-group">
											<input type="text" class="form-control pull-right input-sm" id="mntr_nm" disabled>
											<div class="input-group-btn">
										   		<button type="button" id="btn_mntr_nm" class="btn btn-sm btn-default" onclick="fnSearchMntrNm();"><i class="fa fa-search"></i></button>
										   	</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="box-tools pull-right" style="display:none;">
							<button type="button" id="area_transation" onclick="makeTranDetails();" class="btn btn-success btn-sm" style="display:none;">거래명세서</button>
						</div>
					</div>
					
					<div id="dv_grid_goods" class="box-body" style="padding-top: 0px;">
						<table id="grid_goods"></table>
						<div id="grid_goods_pager"></div>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div id="caseByCase">	
					<div class="box" style="margin-bottom: 0px;">
						<div class="box-header with-border">
							<h3 class="box-title">시리얼 관리</h3>
							<div class="box-tools pull-right" style="min-width:600px;">
								<div id="progress" class="col-sm-6 progress" style="float:left;">
									<div class="progress-bar progress-bar-warning"></div>
								</div>
								<div id="serialBtns" style="float:right; text-align: right; display:none;">
									<button type="button" class="btn btn-info btn-sm grid_attach_down" onclick="excelFileDownload();" data-selfilepath="/upload" data-selfilename="test.xlsx">
										<i class="fa fa-check"></i> 다운로드 
									</button>
									<span class="btn btn-warning btn-sm fileinput-button"> 
										<span>시리얼 일괄 처리</span> 
										<input id="fileupload" type="file" name="files[]" multiple>
									</span>
								</div>
							</div>
						
						</div>
						<div class="box-body" style="padding-bottom: 0px;">
							<div id="msg" style="height:665px; color:red; display:none;">
								<b>해당 데이터는 현재 메뉴에서의 시리얼 입력 대상 내용이 아닙니다.</b>
							</div>
	          				<div id="dv_grid_goods_detail" class="box-body" style="padding: 0px;">
								<table id="grid_goods_detail"></table>
							</div>
							<div class="text-center" style="height:54px;">
								<button type="button" id="btn_saveSerial" class="btn btn-success btn-sm" onclick="saveSerials();" style="margin: 10px 0px 10px 0px;">저장</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
   	</section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
  <div class="modal fade" id="modal_detail" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">품목조회조건</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class=" col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">제품 목록</h3>
									<div class="box-tools pull-right">
										<div class="input-group input-group-sm" style="width: 150px;float: left;">
						                  <input type="text" id="itnbr_search_popup" name="itnbr_search" class="form-control pull-right" placeholder="name Search">
											<div class="input-group-btn">
						                    <button type="button" id="btn_itnbr_search_popup" class="btn btn-default btn-sm" onclick="searchItnbrpopup();"><i class="fa fa-search"></i></button>
						                  </div>
						                </div>
						                &nbsp;|
						                <button type="button" id="" class="btn btn-warning btn-sm" onclick="addItnbrDetail();">
						                <i class="fa fa-forward" aria-hidden="true"></i></button>
									</div>
								</div>
								<div id="dv_grid_itnbrlist" class="box-body">
									<table id="grid_itnbrlist"></table>
									<div id="grid_itnbrlist_pager"></div>
								</div>
							</div>
						</div>
						<div class=" col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">조회 대상 제품 목록</h3>
									<div class="box-tools pull-right">
						                <button type="button" id="" class="btn btn-warning btn-sm" onclick="deleteItnbrDetail();">
						                <i class="fa fa-backward" aria-hidden="true"></i></button>
									</div>
								</div>
								<div id="dv_grid_addItnbr_list" class="box-body">
									<table id="grid_addItnbr_list"></table>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-success btn-sm" onclick="inputMntrs();">조회조건입력</button>
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
var mainKey;
var selectGridId;
var newDate;
var dataArr = [];
$(".progress").hide();
$(function($) {
	fnLoadCommonOption();
	fnLoadGoodsListGrid();
	fnLoadGoodsDetailListGrid();
	initItnbrGrid();
	initNewItnbrGrid(); 
})

// search component setting
function fnLoadCommonOption() {
// 	console.info('fnLoadCommonOption()');
	$(window).bind('resize', function() {
		resizeJqGrid("grid_goods", false);
		resizeJqGrid("grid_goods_detail", false);
	}).trigger('resize');
	
	$("#decide_date_range").pressEnter(function(e) {
		e.preventDefault();
		if(e.target.id == "decide_date_range"){
			fnSearchGoodsList();
		}
	});
	
	var datePickOpt = {
				format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
				,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
				,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
				,showMonthAfterYear: true
				,yearSuffix: '년'
				,orientation: "top left" };
	
	$('#decide_date_range').daterangepicker({
		startDate : '2017-10-01',
		endDate : '2017-10-10',
		opens : 'right',
		locale : datePickOpt
	});
	
	$('#possible_date_range').daterangepicker({
		locale : datePickOpt
	});
	
	$("#delivery_date, #vandor_delivery_date").datepicker({
		language: "kr",
		todayHighlight: true,
		format: "yyyy.mm.dd",
		autoclose: true
	}).on('changeDate',function(selected){
		 newDate = new Date(selected.date);
		// Extract the current date from Date object
		newDate.setDate(newDate.getDate());
		
		chDateStr = $.datepicker.formatDate('yymmdd',selected.date);
		$('#vendor_delivery_date').datepicker("setDate",  selected.date);
	});
	// ignoreReadonly: true
	
	getStatusCodeList('rvendor_status');
	
	$('#rvendor_status').change(function(){
// 			area_decide_date_range
// 			area_possible_date_range / possible_date_range			
		if ( $(this).val()=='v1' || $(this).val()=='' || $(this).val()==null ){	//요청 혹은 그 이전
			$('#area_decide_date_range').show();
			$('#area_possible_date_range').hide();
			$('#area_transation').hide();
		} else {	// 요청 이후의 상태
			$('#area_decide_date_range').hide();
			$('#area_possible_date_range').show();
			$('#area_transation').show();
		}
	});
	
	fnLoadFileHandler();
	
	$("#grid_itnbrlist").jqGrid('clearGridData');
	$("#grid_addItnbr_list").jqGrid('clearGridData');
	
    $('#table').on('check.bs.table', function (e, row, $el) {
    	alert('check index: ' + $el.closest('tr').data('index'));
    });
    $('#table').on('uncheck.bs.table', function (e, row, $el) {
    	alert('uncheck index: ' + $el.closest('tr').data('index'));
    });
    
    initScreenSizeModal();
}

function excelFileDownload() {
	console.log('excelFileDownload()');
	
	var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
	var is_rownum = $("#grid_goods_detail").jqGrid('getGridParam','rownumbers');
	console.log(is_rownum);
	var colNames = $("#grid_goods_detail").jqGrid('getGridParam','colNames');
	console.log(colNames);
	var colModels = $("#grid_goods_detail").jqGrid('getGridParam','colModel');
	console.log(colModels);
	
	if(colModels != null && colModels.length > 0){
		for(var i=0; i<colModels.length; i++){
			if(i==0 && is_rownum) {
				param_col_name = "No"
				param_col_id = "rownum";
				param_col_align = "center";
				param_col_width = "80";
			} else if(i==0 && !colModels[i].hidden){
				param_col_name = colNames[i];
				param_col_id = colModels[i].name;
				param_col_align = (colModels[i].align==undefined?"left":colModels[i].align);
				param_col_width = (colModels[i].width==undefined?"80":colModels[i].width);
			} else if(i==1) {
				param_col_name += "," + "선택";
				param_col_id += "," + colModels[i].name;
				param_col_align += "," + (colModels[i].align==undefined?"left":colModels[i].align);
				param_col_width += "," + (colModels[i].width==undefined?"80":colModels[i].width);
				
			} else if(!colModels[i].hidden){
				param_col_name += "," + colNames[i];
				param_col_id += "," + colModels[i].name;
				param_col_align += "," + (colModels[i].align==undefined?"left":colModels[i].align);
				param_col_width += "," + (colModels[i].width==undefined?"80":colModels[i].width);
			}
		}
	}
	var export_url = "/export/export_client_jqgrid";
	var export_data = "file_name="+encodeURIComponent("Vendor확인_납품일자변경.xlsx");
	export_data += "&sheet_title="+encodeURIComponent("납품일자변경");
	export_data += "&sheet_name="+encodeURIComponent("납품일자변경");
	export_data += "&header_col_names="+encodeURIComponent(param_col_name);
	export_data += "&header_col_ids="+encodeURIComponent(param_col_id);
	export_data += "&header_col_aligns="+encodeURIComponent(param_col_align);
	export_data += "&header_col_widths="+encodeURIComponent(param_col_width);
	export_data += "&cmd="+encodeURIComponent("grid_goods_detail");
	var goods_detail_data = $("#grid_goods_detail").jqGrid("getRowData");
	export_data += "&body_data="+encodeURIComponent(JSON.stringify(goods_detail_data));
	
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

// status code select
function getStatusCodeList(gubun) {
	var page_url = "/frontend/scm/scm_sta_code_select"
	var postData = 'code_cat=' + encodeURIComponent(gubun);
				 
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$.each(data.rows, function (i, item) {
						$('#'+gubun).append($('<option>', { 
					        value: item.code,
					        text : item.code_nm 
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

// serch parameter setting
function fnSearchGoodsList(){
	console.log('fnSearchGoodsList()');
	
	$('#grid_goods_detail').jqGrid('clearGridData');
	var fDate = $("#decide_date_range").val().substring(0,10);
	var tDate = $("#decide_date_range").val().substring(13,23);
	var vendor_status = $('#rvendor_status').val();
	$("#grid_goods").jqGrid('clearGridData');
	var page_url = "/frontend/scm/delivery_req_select"
				 + "?jidat_from=" + encodeURIComponent(fDate)
				 + "&jidat_to=" + encodeURIComponent(tDate)
				 + "&rvendor_status=" + encodeURIComponent(vendor_status)
				 + "&funcName=" + encodeURIComponent("ZMMFM_PURCH_ORD");
	$("#grid_goods").jqGrid('setGridParam',{url: page_url,datatype: 'json',loadComplete : function(data){
//	    	console.log(data);
    	var ids = $(this).jqGrid('getDataIDs');
    	for(var i = 0; i < ids.length; i++) {
			var $targetRow = $('#' +ids[i] , " #grid_goods");
			var rowData = $(this).jqGrid ('getRowData', ids[i]);
			var rmBtnHtml = '';
			if( rowData.level==0 ) {	// root
				rmBtnHtml = '<i class="fa fa-plus-square" aria-hidden="true" onclick="appendGrid(this);"></i>'; 
			} else if ( rowData.level==1 ){	// leaf
				rmBtnHtml = '<i class="fa fa-minus-square" aria-hidden="true" onclick="deleteGridData(this);"></i>'
						  + '&nbsp;&nbsp;<i class="fa fa-floppy-o" aria-hidden="true" onclick="departOrder(this);"></i>';
			}
			$('td:nth-child(20)', $targetRow).html(rmBtnHtml.replace('{id}', ids[i]));
		}
//	    	$("#grid_goods").jqGrid('setFrozenColumns');
    } });
	$("#grid_goods").setGridParam({ page: 1 }).trigger("reloadGrid");
}

// serch result grid
function fnLoadGoodsListGrid() {
	console.log('fnLoadGoodsListGrid()');
	
	var fDate = $("#decide_date_range").val().substring(0,10);
	var tDate = $("#decide_date_range").val().substring(13,23);
	var vendor_status = $('#rvendor_status').val();
	var subgridData = [];
	var page_url = "/frontend/scm/delivery_req_select"
				 + "?jidat_from=" + encodeURIComponent(fDate)
				 + "&jidat_to=" + encodeURIComponent(tDate)
				 + "&funcName=" + encodeURIComponent("ZMMFM_PURCH_ORD")
				 + "&rvendor_status=v1";
	
// 	console.log(vendor_status);
	
	$("#grid_goods").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['#', '진행상태', '요청일자', '문서번호', '문서품목', '품목', '내역', '요청수량', '벤더 요칭일자', '납품수량', 
		          'rvendor_status', 'rorder_status', 'diff_date', 'werks', 'bukrs', 'lgort', 'ukey', '납품일자','act.',
		          'partial_seq', 'zdeli_menge', 'sernp', 'partial_yn', 'item_seq', 'lifnr'],
		colModel:[
				{name:'dummy', index:'dummy', width:30, frozen : true}, 
				{name:'rvendor_status_nm', index:'rorder_status_nm', width:100, sorttype:"text", sortable:true, frozen : true}, 
				{name:'order_delivery_date', width:90, index:'order_delivery_date', sorttype:"text", sortable:true, frozen : true}, 
				{name:'ebeln', index:'ebeln', width:90, sorttype:"text", sortable:true, frozen : true}, 
				{name:'ebelp', index:'ebelp', width:50, sorttype:"text", sortable:true, frozen : true},
				{name:'matnr', index:'matnr', sorttype:"text", width:100, sortable:true}, 
				{name:'txz01', index:'txz01', sorttype:"text", width:120, sortable:true}, 
				{name:'menge', index:'menge', width:60, sorttype:"text", sortable:true}, 
				{name:'vendor_delivery_date', index:'vendor_delivery_date', width:90, sorttype:"text", sortable:true, 
					editoptions: { size: 10, maxlengh: 10, dataInit: function(element) {
						$(element).datepicker({language: "kr",
							todayHighlight: true,
							format: "yyyy-mm-dd",
							autoclose: true}) }}},
				{name:'zdeli_menge', index:'zdeli_menge', width:60, sorttype:"text", sortable:true},
				{name:'rvendor_status', index:'rvendor_status', sorttype:"text", sortable:true, hidden:true}, 
				{name:'rorder_status', index:'rorder_status', sorttype:"text", sortable:true, hidden:true}, 
				{name:'diff_date', index:'diff_date', sorttype:"text", sortable:true, hidden:true},
				{name:'werks', index:'werks', sorttype:"text", sortable:true, hidden:true},
				{name:'bukrs', index:'bukrs', sorttype:"text", sortable:true, hidden:true},
				{name:'lgort', index:'lgort', sorttype:"text", sortable:true, hidden:true},
				{name:'ukey', index:'ukey', sorttype:"text", sortable:true, hidden:true, key:true},
				{name:'eindt', index:'eindt', width:90,sorttype:"text", sortable:true},
				{name:'action',index:'action', width:40, align:"center"},
				{name:'partial_seq',index:'partial_seq', hidden:true},
				{name:'zdeli_menge',index:'zdeli_menge', hidden:true},
				{name:'sernp',index:'sernp', hidden:true},
				{name:'partial_yn',index:'partial_yn', hidden:true},
				{name:'item_seq',index:'item_seq', hidden:true},
				{name:'lifnr',index:'lifnr', hidden:true}
				],
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		pager : "#grid_goods_pager",
	    height: 540,
	    rownumWidth: 25,
		viewrecords : true,
	    autowidth : false,
	    shrinkToFit: false, 
	    multiselect : true,
		altRows: true,
		rownumbers: true, 
	    autoencode: true,
	    loadonce: false,
	    scroll:true,
// 	    sortname: 'ebeln',
	    sortorder: 'desc',
	    sortable: true,
	    sortorder: "asc",
	    treeGrid: true,
	    hiddengrid: true,
	    treeGridModel: "adjacency",
	    jsonReader: { repeatitems: false, root: function (obj) { return obj.rows; } },
	    gridview: true,
	    treedatatype: 'json',
 	    ExpandColumn: 'rvendor_status_nm',
	    ExpandColClick: true,
	    cellEdit:true,
	    cellsubmit : 'clientArray',
	    loadComplete : function(data){
// 	    	console.log(data);
	    	var ids = $(this).jqGrid('getDataIDs');
	    	for(var i = 0; i < ids.length; i++) {
				var $targetRow = $('#' +ids[i] , " #grid_goods");
				var rowData = $(this).jqGrid ('getRowData', ids[i]);
				var rmBtnHtml = '';
				if( rowData.level==0 ) {	// root
					rmBtnHtml = '<i class="fa fa-plus-square" aria-hidden="true" onclick="appendGrid(this);"></i>';
// 							  + '&nbsp;&nbsp;<i class="fa fa-clone" aria-hidden="true" onclcik="copyHeader(this);"></i>'
				} else if ( rowData.level==1 ){	// leaf
					rmBtnHtml = '<i class="fa fa-minus-square" aria-hidden="true" onclick="deleteGridData(this);"></i>'
							  + '&nbsp;&nbsp;<i class="fa fa-floppy-o" aria-hidden="true" onclick="departOrder(this);"></i>';
				}
				$('td:nth-child(20)', $targetRow).html(rmBtnHtml.replace('{id}', ids[i]));
			}
// 	    	$("#grid_goods").jqGrid('setFrozenColumns');
	    },
	    onCellSelect: function(rowid, index, contents, event){
// 	    	console.log(rowid, index, contents);
			var colModels = $(this).getGridParam('colModel');
	    	var rowData = $("#grid_goods").getRowData(rowid);
	    	var colName = colModels[index].name;
	    	
	    	if( index==9 || index==10 || index==19 ){	// 9:vendor_date, 10:z_menge, 19:action btn area
	    		if( (Boolean(rowData.isLeaf) && rowData.level!='0') || rowData.level=='' ){// update edit
	    			if( colName=="zdeli_menge" || colName=="vendor_delivery_date" ) { 
			    		$(this).setColProp(colName, { editable: true }); 
			    		$(this).editCell($("#grid_goods").getInd(rowid), index, true); 
			    	}
		    	}else{ 
					return;
		    	}
	    	} else {
	    		$("#dv_grid_goods_detail").show();
	    		$("#msg").hide();
	    		fnSearchGoodsDetailList('grid_goods', rowid);
	    	}
	    },
	    afterEditCell: function (rowid, cellname, value, iRow, iCol) {
// 	    	console.log(rowid, cellname, value, iRow, iCol);
			//This code saves the state of the box when focus is lost in a pretty horrible
            //way, may be they will add support for this in the future
            //set up horrible hack for pressing enter when leaving cell
            if( cellname!='vendor_delivery_date' ){
            	e = jQuery.Event("keydown");
                e.keyCode = $.ui.keyCode.ENTER;
                //get the edited thing
                edit = $(".edit-cell > *");
                edit.blur(function() {
                    edit.trigger(e);
                });
            } 
    	}
	}); 
	$("#grid_goods").jqGrid("destroyFrozenColumns")
			    .jqGrid("setColProp", "id", { frozen: true })
			    .jqGrid("setFrozenColumns")
			    .trigger("reloadGrid", [{ current: true}]);
}

// search detail list
function fnSearchGoodsDetailList(gridId, key) {
	console.log('fnSearchGoodsDetailList()');
	
	$('#grid_goods_detail').jqGrid('clearGridData');
	var selRowData = $("#"+gridId).getRowData(key);
	if( selRowData.rvendor_status!='v1' ){	//??
	}else{
	}

	if( selRowData!={} && selRowData.menge>0 ){
		if( selRowData.sernp=='V001'&& selRowData.level=='1' ) {	// case1\
// 			console.log('1');
			// make data
			if( selRowData.rvendor_status=='v1' ){
// 				console.log('1-1');
				$('#serialBtns').show();
				var arrTmpObj = [];
// 				for(var idx=0; idx<selRowData.menge; idx++ ){
				for(var idx=0; idx<selRowData.zdeli_menge; idx++ ){
					var tmpObj = {};
					tmpObj.seq = idx; 
					tmpObj.ebeln = selRowData.ebeln;
					tmpObj.matnr = selRowData.matnr;
					tmpObj.txz01 = selRowData.txz01;
					tmpObj.menge = 1; 
					tmpObj.zdeli_menge = 1; 
		
					arrTmpObj.push(tmpObj);
				}
				$('#grid_goods_detail').jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj }).trigger('reloadGrid');
			}else{
// 				console.log('1-2');
				var page_url = "/frontend/scm/raw_sernr_select"
							 + "?ebeln=" + encodeURIComponent(selRowData.ebeln)
							 + "&ebelp=" + encodeURIComponent(selRowData.ebelp);
				if( selRowData.partial_seq!='' || selRowData.partial_seq!=undefined )
					page_url += "&partial_seq=" + encodeURIComponent(selRowData.partial_seq);
				$.ajax({
				    url: page_url,
				    type: "POST",
				    success:function(data, textStatus, jqXHR){
				    	if(data.status == "200") {
				    		var objArr = [];
						   $.each(data.rows, function(idx, row){
							   var tmpObj = {};
							   tmpObj.partial_seq = row.partial_seq;
							   tmpObj.vendor_delivery_date = row.vendor_delivery_date;
							   tmpObj.menge = 1;
							   tmpObj.zdeli_menge = 1;
							   tmpObj.equnr = row.equnr;
							   tmpObj.ebeln = row.ebeln;
							   tmpObj.matnr = row.matnr;
							   tmpObj.txz01 = row.txz01;
//								   tmpObj.rvendor_status = row.rvendor_status;
							   tmpObj.ebelp = row.ebelp;
							   tmpObj.werks = row.b_werks;
							   tmpObj.lgort = row.b_lager;
							   objArr.push(tmpObj);
						   });
						   $('#grid_goods_detail').jqGrid('setGridParam', { datatype: 'local', data: objArr }).trigger('reloadGrid');	
				    	}
				    },
				    error: function(jqXHR, textStatus, errorThrown){
				    	fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
				    },
				    complete: function() {}
				});
			}
		} else {	// case2
			$('#serialBtns').hide();
			$('#btn_saveSerial').hide();
			if( selRowData.sernp=='V001' ) {
				fnMessageModalAlert("Notification(SCM)", "분기한 데이터가 있다면, 해당 데이터를 눌러주세요.<br> 없다면, 데이터를 분기한 후 시도하세요.");
			} else {
// 				fnMessageModalAlert("Notification(SCM)", "해당 데이터는 현재 메뉴에서의 시리얼 입력 대상 내용이 아닙니다.");
				$("#dv_grid_goods_detail").hide();
				$("#msg").show();
			}
		}
	}
}

// detail grid setting
function fnLoadGoodsDetailListGrid() {
// 	console.log('fnLoadGoodsDetailListGrid()');	
	var grid = $("#grid_goods");
	var selected_master_code = grid.jqGrid('getGridParam',"selrow");
	$("#grid_goods_detail").jqGrid({ 		
		datatype:"json",
		colNames:['순서', '문서번호', '품목', '내역', '요청수량', '입하수량', '순차관리번호'],
		colModel:[
			{name:'seq',index:'seq', width:100, sorttype:"text", sortable:true, hidden:true, key: true},
			{name:'ebeln',index:'ebeln', width:100, sorttype:"text", sortable:true},
			{name:'matnr',index:'matnr', width:100, sorttype:"text", sortable:true},
			{name:'txz01',index:'txz01', width:100},
			{name:'menge',index:'menge', width:100, sorttype:"text", sortable:true},
			{name:'zdeli_menge',index:'zdeli_menge', width:100},
			{name:'equnr',index:'equnr', width:100,  editoptions: { maxlength: 13}}	//, editable:true
		],
		rowNum:1000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : true,
	    height: 620,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    sortable: true,
	    cellEdit:true,
	    cellsubmit : 'clientArray',
	    sortname: 'equnr',
	    onCellSelect: function(rowid, index, contents, event){
// 	    	console.log(rowid, index, contents);
			var colModels = $(this).getGridParam('colModel');
	    	var colName = colModels[index].name;
// 	    	var rowData = $("#grid_goods").getRowData(rowid);
	    	if( colName=='equnr' ) { 
	    		$(this).setColProp(colName, { editable: true }); 
	    		$(this).editCell($("#grid_goods_detail").getInd(rowid), index, true); 
	    	}
// 	    	if( index==9 || index==10 || index==19 ){	// 9:vendor_date, 10:z_menge, 19:action btn area
// 	    		if( (Boolean(rowData.isLeaf) && rowData.level!='0') || rowData.level=='' ){// update edit
// 	    			if( colName=="zdeli_menge" || colName=="vendor_delivery_date" ) { 
// 			    		$(this).setColProp(colName, { editable: true }); 
// 			    		$(this).editCell($("#grid_goods").getInd(rowid), index, true); 
// 			    	}
// 		    	}else{ 
// 					return;
// 		    	}
// 	    	} else {
// 	    		fnSearchGoodsDetailList('grid_goods', rowid);
// 	    	}
	    },
	    afterEditCell: function (rowid, cellname, value, iRow, iCol) {
			//This code saves the state of the box when focus is lost in a pretty horrible
            //way, may be they will add support for this in the future
            //set up horrible hack for pressing enter when leaving cell
            e = jQuery.Event("keydown");
            e.keyCode = $.ui.keyCode.ENTER;
            //get the edited thing
            edit = $(".edit-cell > *");
            edit.blur(function() {
                edit.trigger(e);
            });
    	},
		loadComplete : function(data) {
		}
	});
	if(selected_master_code=!null){
	}
}

function saveSerials() {
	console.log('saveSerials()');	
 
	var rawValidationChk_result = rawValidationChk();		
	if(rawValidationChk_result == false) {
		//fnSearchGoodsList();
		//$('#grid_goods').jqGrid('setSelection',mainKey, true);
		return;
	}
	var gridDataArr = $('#grid_goods_detail').jqGrid('getRowData');
	var selGridRowData = $("#grid_goods").getRowData($('#grid_goods').jqGrid('getGridParam','selrow'));
	var page_url = "/frontend/scm/scm_sernr_insert"
	var postData = 'gridData=' + encodeURIComponent(JSON.stringify(gridDataArr))
				 + '&partial_seq=' + encodeURIComponent(selGridRowData.partial_seq)
				 + '&ebelp=' + encodeURIComponent(selGridRowData.ebelp)
				 + '&werks=' + encodeURIComponent(selGridRowData.werks)
				 + '&lgort=' + encodeURIComponent(selGridRowData.lgort);
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalConfirm("Notification(SCM)", "정보를 저장하였습니다.", function(chk){
		    		if(chk){
						var serTblCnt = chkSubGridData(selGridRowData);
						var gridData = $('#grid_goods').jqGrid('getRowData');
				    	$.each(gridData, function(idx, row){
				    		if( (selGridRowData.ebelp==row.ebelp) && (selGridRowData.ebeln==row.ebeln) && (row.partial_seq=='') ){
				    			if((Number(row.menge)-serTblCnt)>0){
				    				fnMessageModalAlert("Notification(SCM)", "상위 요청에 대한 일부분만 저장이 되었습니다.<br>하위의 모든 요청을 저장하지 않으면 상위요청의 상태는 업데이트 되지 않습니다.");
				    				updateVendorStatus('v2');
				    			}else{
				    				updateVendorStatus('v2');
				    				updateDeliveryStatus('v2', serTblCnt);
				    			}
				    			return false;
				    		}
				    	});
	    				$('#grid_goods_detail').jqGrid('clearGridData');
	    				fnSearchGoodsList();
	    				$('#grid_goods').jqGrid('setSelection',mainKey, true);
	    			}
	    		});
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}

function chkSubGridData(subObj) {
	console.log('chkSubGridData()');
	
	var returnVal = 0;
	var page_url = "/frontend/scm/raw_sernr_select"
	var postData = 'ebelp=' + encodeURIComponent(subObj.ebelp)
				 + '&ebeln=' + encodeURIComponent(subObj.ebeln);
	$.ajax({
	    url: page_url,
	    data: postData,
	    async:false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		returnVal = (data.rows).length;
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 실행하는데 에러가 발생하였습니다.(chkSubGridData)");	
	    },
	    complete: function() {
	    }
	});
	return returnVal;
}

/*
function saveCase2() {
// 	console.info('saveCase2()');
	//grid_goods
	var selRowData = $("#grid_goods").getRowData($("#grid_goods").getGridParam('selrow'));
	var delivery_date = $.datepicker.formatDate('yy-mm-dd', $("#delivery_date").datepicker("getDate"));  
	var vendor_delivery_date = $.datepicker.formatDate('yy-mm-dd', newDate);
	var diff_date = (delivery_date==vendor_delivery_date)?'N':'Y'; 
	var page_url = "/frontend/scm/scm_raw_delivery_update";
	var sernr_yn = (selRowData.equnr_yn=='Y')?'A':'N'; 
	var postData = 'raw_num=' + encodeURIComponent(selRowData.raw_num)
				 + '&real_qty=' + encodeURIComponent($('#real_qty_before').val())
				 + '&rvendor_status=' + encodeURIComponent('v2')
				 + '&delivery_date=' + encodeURIComponent(delivery_date)
	 			 + '&vendor_delivery_date=' + encodeURIComponent(vendor_delivery_date)
	 			 + '&diff_date=' + encodeURIComponent(diff_date)
	 			 + '&sernr_yn=' + encodeURIComponent(sernr_yn);
	
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		fnMessageModalConfirm("확인", "정보를 저장하였습니다.", function(chk){
	    			if(chk){
	    				fnSearchGoodsList();
	    				$('#grid_goods').jqGrid('setSelection',mainKey, true);
	    				$('#caseByCase a[href="#case2"]').tab('show') ;
	    			}
	    		});
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    }
	});
}
*/

function updateVendorStatus(status) {
	console.info('updateVendorStatus(',status,')');
	var selRowData = $("#grid_goods").getRowData($("#grid_goods").getGridParam('selrow')); 
	var page_url = "/frontend/scm/vendor_status_update"
	var postData = 'ebelp=' + encodeURIComponent(selRowData.ebelp)
				 + '&ebeln=' + encodeURIComponent(selRowData.ebeln)
				 + '&rvendor_status=' + encodeURIComponent(status)
				 + '&diff_date=' + encodeURIComponent('Y')
				 + '&partial_seq=' + encodeURIComponent(selRowData.partial_seq);
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    }
	});
}

function updateDeliveryStatus(staus, zdeli_menge) {
	console.info('updateDeliveryStatus(',staus,zdeli_menge,')');
	
	var selRowData = $("#grid_goods").getRowData($("#grid_goods").getGridParam('selrow'));
	
// 	var delivery_date = $.datepicker.formatDate('yy-mm-dd', $("#delivery_date").datepicker("getDate"));  // ?
// 	var vendor_delivery_date = $.datepicker.formatDate('yy-mm-dd', newDate);	// ?
	var delivery_date = selRowData.enidt;
	var vendor_delivery_date = selRowData.vendor_delivery_date;
	
	if( selRowData.partial_seq!='' ){
		// 분할 케이스인 경우
		vendor_delivery_date = selRowData.vendor_delivery_date;
	}
	
	var diff_date = (delivery_date==vendor_delivery_date)?'N':'Y';
	
	var page_url = "/frontend/scm/delivery_status_update"
	var postData = 'ebelp=' + encodeURIComponent(selRowData.ebelp)
				 + '&ebeln=' + encodeURIComponent(selRowData.ebeln)
				 + '&rvendor_status=' + encodeURIComponent(staus)
				 + '&delivery_date=' + encodeURIComponent(delivery_date)
	 			 + '&vendor_delivery_date=' + encodeURIComponent(vendor_delivery_date)
	 			 + '&zdeli_menge=' + encodeURIComponent(zdeli_menge)
	 			 + '&diff_date=' + encodeURIComponent(diff_date);
	
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    }
	});
}

//거래명세서 발행-barcode
function makeTranDetails() {
	fnMessageModalAlert("Sorry!", "해당 기능은 준비중입니다.");
}

function fnLoadFileHandler(){
	console.log('fnLoadFileHandler()');
	var page_url = "/file/import_upload";
	
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
	}).on('fileuploadprogressall', function(e, data) {
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#progress .progress-bar').css('width', progress + '%');
	}).on('fileuploaddone', function(e, data) {
		var selRowData = $("#"+selectGridId).getRowData(mainKey);
		var arrData = data.result.rows;
		var priData = [];
		for(var i=0; i<data.result.rows.length; i++ ){
			var tmpObj = {};
			tmpObj.seq = i;
			tmpObj.ebeln = selRowData.ebeln;
			tmpObj.matnr = selRowData.matnr;
			tmpObj.txz01 = selRowData.txz01;
			tmpObj.menge = 1;
// 			tmpObj.menge = selRowData.menge;
			tmpObj.zdeli_menge = 1;
			tmpObj.partial_seq = selRowData.partial_seq;
			tmpObj.equnr = arrData[i].equnr;
			priData.push(tmpObj);
		}
		$('#grid_goods_detail').jqGrid('setGridParam', { datatype: 'local', data: priData }).trigger('reloadGrid');	
	}).on('fileuploadfail', function(e, data) {
		$.each(data.files, function(index) {
			fnMessageModalAlert("Notification", "File upload failed.");
		});
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}

function rawValidationChk() {
	console.log('rawValidationChk()');
	
	var rawValidationChk_result = null;
	var gridDataArr = $('#grid_goods_detail').jqGrid('getRowData');
	var selRowData = $("#grid_goods").getRowData($('#grid_goods').jqGrid('getGridParam','selrow'));
	var arrSernr = [];

	$.each(gridDataArr, function(idx, row){
		arrSernr.push(row.equnr);
	});
	// 순차관리  체크 박스
	$.each(gridDataArr, function(idx, row){
		if( !$("input:checkbox[id='jqg_grid_goods_detail_" + idx + "']").is(":checked") ){
			fnMessageModalAlert("Notification(SCM)", "체크되지 않은 항목이 았습니다.<br>모든 항목을 체크해 주시기 바랍니다.");
			rawValidationChk_result = false;
	 		return false;
		}
	});
	
	// 순차관리 null 입력 여부 체크 
	$.each(gridDataArr, function(idx, row){
		if(row.equnr == null || row.equnr == '') {
			fnMessageModalAlert("Notification(StatusChk)", "순차관리번호를 입력해주십시오.");
			rawValidationChk_result = false;
			return false;
		}
	});	
	
	// 순차관리 중복 입력 여부 체크 
	$.unique(arrSernr);
	if( gridDataArr.length!=arrSernr.length ){
		fnMessageModalAlert("Notification(StatusChk)", "순차관리 번호를 중복 입력하였습니다.");
		rawValidationChk_result = false;
	}
			
	// 상태 체크
	var page_url = "/frontend/prod/rawVendor_selectAll";
	var postData = "ebeln=" + encodeURIComponent(selRowData.ebeln)
				 + "&ebelp=" + encodeURIComponent(selRowData.ebelp)
				 + "&partial_seq=" + encodeURIComponent(selRowData.partial_seq);
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			console.log(data);
			if(data.status == "200") {
				var resultJson = JSON.parse(JSON.stringify(data));
				var result = resultJson.rows[0].rvendor_status;
				if(result != 'v1') {
					rawValidationChk_result = false;
					fnMessageModalAlert("Notification(StatusChk)", "이미 요청처리가 완료된 데이터 입니다.");
				}
			} else {
				rawValidationChk_result = false;	
				fnMessageModalAlert("Notification(StatusChk)", "요청처리를 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(StatusChk)", "요청처리를 실패했습니다.");
		},
		complete : function() { }			
	});
	if(rawValidationChk_result == false) {
		return rawValidationChk_result;
	}
	
	// 순차관리번호 중복 DB 체크
	var page_url = "/frontend/scm/raw_sernr_duplication_chk";
	var postData = "sernrs=" + encodeURIComponent(arrSernr.toString());
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				var resultJson = JSON.parse(JSON.stringify(data));
				var result_len = resultJson.rows.length;
				if(result_len > 0) {
					rawValidationChk_result = false;
					fnMessageModalAlert("Notification(StatusChk)", "순차관리번호가 기존 등록된 내역과 중복됩니다.");
				}		
			} else {
				rawValidationChk_result = false;	
				fnMessageModalAlert("Notification(StatusChk)", "요청처리를 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(StatusChk)", "요청처리를 실패했습니다.");
		},
		complete : function() {}			
	});
	if(rawValidationChk_result == false) {
		return rawValidationChk_result;
	}
}

function fnSearchMntrNm(){
	$('#modal_detail').modal('show');
}

//search itnbr list
function searchItnbrpopup(){
	var page_url = '/frontend/hub/material_recv_master_select'
				 + '?wrkst=' + encodeURIComponent($('#itnbr_search_popup').val());
	$("#grid_itnbrlist").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_itnbrlist").trigger("reloadGrid");
}

function initItnbrGrid() {
	var page_url = '/frontend/hub/material_recv_master_select';
	$('#grid_itnbrlist').jqGrid({
		url:page_url,
		datatype: 'json',
		colNames:['자재코드','자재내역',' Spec.','제품군명', '자재그룹명', '생성일자', '수정일자'],
		colModel:[
			{name:'matnr',index:'matnr', width:100, sorttype:'text', sortable:true, key: true},
			{name:'maktx',index:'maktx', width:150, sorttype:'text', sortable:true},
			{name:'wrkst',index:'wrkst', width:150, sorttype:'text', sortable:true, sortable:true},
			{name:'vtext',index:'vtext', sorttype:'text', sortable:true, hidden:true},
			{name:'wgbez',index:'wgbez', sorttype:'text', sortable:true, hidden:true},
			{name:'date_created',index:'date_created', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'date_updated',index:'date_updated', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true}
		],
		pager : '#grid_itnbrlist_pager',
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 360,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: false,
	    sortable: true,
	    sortname: 'matnr',
	    jsonReader : {
		    root : "list_data",
		    records : "records",
		    repeatitems : false,
		    id : "matnr"
	    },
		loadComplete : function() {
		}
	});
}
function initNewItnbrGrid() {
	$('#grid_addItnbr_list').jqGrid({
		url:'',
		datatype: 'json',
		colNames:['자재코드','자재내역',' Spec.','제품군명', '자재그룹명', '생성일자', '수정일자'],
		colModel:[
			{name:'matnr',index:'matnr', width:100, sorttype:'text', sortable:true, key: true},
			{name:'maktx',index:'maktx', width:150, sorttype:'text', sortable:true},
			{name:'wrkst',index:'wrkst', width:150, sorttype:'text', sortable:true, sortable:true},
			{name:'vtext',index:'vtext', sorttype:'text', sortable:true, hidden:true},
			{name:'wgbez',index:'wgbez', sorttype:'text', sortable:true, hidden:true},
			{name:'date_created',index:'date_created', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'date_updated',index:'date_updated', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true}
		],
// 		pager : '#grid_addItnbr_list_pager',
		rowNum: 20,
// 		rowList : [ 20, 50, 100 ],
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 410,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    sortable: true,
	    sortname: 'matnr',
		loadComplete : function() {
		}
	});
}

var dataArr = [];
function addItnbrDetail() {
	var groupInfo = $("#grid_itnbrlist").getRowData($("#grid_itnbrlist").getGridParam('selrow'));
	var gridDataArr = $('#grid_addItnbr_list').jqGrid('getRowData');
	// 추가하려는 목록이 선택 되었는가?
	if( groupInfo.matnr == undefined || groupInfo.matnr == undefined){
		fnMessageModalAlert("확인하세요", "추가하려는 항목을 선택해야 합니다.");
	} else {
		// 기존에 추가된 항목인지 확인
		if( gridDataArr.length>0 ){
			var chkCnt = 0;
			for(var idx=0; idx<gridDataArr.length; idx++){
				if( gridDataArr[idx].matnr == groupInfo.matnr ){
					chkCnt++;
				}
			}
			// chkCnt가 0보다 크면, 같은 항목이 한개 이상 있다는...
			if( chkCnt==0 ){
				dataArr.push(groupInfo);
				$("#grid_addItnbr_list").jqGrid('addRow',{position  :"last",
						initdata  : groupInfo});
			}
		}else{
			dataArr.push(groupInfo);
			$("#grid_addItnbr_list").jqGrid('addRow',{position  :"last",
					initdata  : groupInfo});	
		}
	}
}

// remove new itnbr list
function deleteItnbrDetail() {
	$("#grid_addItnbr_list").jqGrid('delRowData', $("#grid_addItnbr_list").getGridParam('selrow'));
}

function inputMntrs(){
	var gridDataArr = $('#grid_addItnbr_list').jqGrid('getRowData');
	var matnr = '';
	
	for(var i=0 ; i<gridDataArr.length; i++){
		matnr = matnr + gridDataArr[i].matnr + ',';
	} 
	
	if(matnr.length != 0)
		matnr = matnr.substring(0, matnr.length-1);
	
	$('#mntr_nm').val(matnr);
	$('#grid_addItnbr_list').jqGrid('clearGridData');
	$("#modal_detail").modal('hide');
}

function copyHeader(obj) {
	console.log('copyHeader()');
	fnMessageModalAlert("...", "구현 중입니다.<br>헤더와 같은 내용을 추가할 예정");
	/*
	var selId = $($(obj).parents()[1]).attr('id');
	var rowData = $("#grid_goods").getRowData(selId);
	// insert vendor
	var ukey = String(rowData.ukey);
	var selDatas = { ebeln : ukey.substr(0, 10),
					 ebelp : rowData.ebelp,
					 matnr : rowData.matnr,
					 txz01 : rowData.txz01,
					 menge : rowData.menge,
					 rorder_status : rowData.rorder_status,
					 rvendor_status : rowData.rvendor_status, 
					 menge : rowData.menge, 
					 werks : rowData.werks, 
					 bukrs : rowData.bukrs};
	*/
}

function appendGrid(obj) {
	console.log('appendGrid()');
// 	var rowNum = Number($($($(obj).parents()[1]).children()[0]).attr('title'));
	var selId = $($(obj).parents()[1]).attr('id');
	var rowData = $("#grid_goods").getRowData(selId);
// 	console.log(rowData);
	var ukey = String(rowData.ukey);
	var selDatas = { ebeln : ukey.substr(0, 10),
					 ebelp : rowData.ebelp,
					 matnr : rowData.matnr,
					 txz01 : rowData.txz01,
					 menge : rowData.menge,
					 rorder_status : rowData.rorder_status,
					 rvendor_status : rowData.rvendor_status, 
					 menge : rowData.menge, 
					 werks : rowData.werks, 
					 bukrs : rowData.bukrs};
	//
	var ids = $("#grid_goods").getDataIDs();
	$("#grid_goods").jqGrid('addRowData', ids.length+1, selDatas );
	var $targetRow = $('#' +(ids.length+1), "#grid_goods");
// 	var $targetRow = $('#' +(rowNum+1), "#grid_goods");
	var rmBtnHtml = '<i class="fa fa-floppy-o" aria-hidden="true" onclick="departOrder(this);"></i>'; 
	$('td:nth-child(20)', $targetRow).html(rmBtnHtml.replace('{id}', (ids.length+1)));
}

function deleteGridData() {
	console.log('deleteGridData()');
// 	var selrows = $('#grid_goods').jqGrid('getGridParam', 'selarrrow');
	fnMessageModalConfirm("Notification(SCM)", "정보를 삭제하겠습니까?", function(chk){
		if(chk){
			$('#grid_goods').jqGrid('delRowData',$("#grid_goods").getGridParam('selrow'));
			// 실제 DB에서 삭제 안됐음. 
//		 	departOrder();
		}else
			return;
	});

}

// update raw_delivery_tbl 건수 체크 & partial_yn = 'Y'
// save raw_vendor_result
function departOrder(obj) {
	console.log('departOrder()');
	var selId = $($(obj).parents()[1]).attr('id');
	var gridData = $("#grid_goods").jqGrid("getRowData");
	var selRowData = $("#grid_goods").getRowData(selId);
	
	var zdeli_menge = $("#grid_goods").jqGrid ('getCell', selId, 'zdeli_menge');
	var vendor_delivery_date = $("#grid_goods").jqGrid ('getCell', selId, 'vendor_delivery_date');
	var chk = vendor_delivery_date.indexOf("input");
	if( chk>-1 ) {
		vendor_delivery_date = $("#" + selId + "_vendor_delivery_date").val();
	}
	
	var menge = Number(selRowData.menge);
	// get sum zdeli_menge
	var sum_zdeli_menge = 0;
	var masData;
	$.each(gridData, function(idx, row){
 		if( row.ebeln==selRowData.ebeln && row.ebelp==selRowData.ebelp ){
 			if( row.level!=0 ){
	 			sum_zdeli_menge += Number(row.zdeli_menge);
 			} else {
 				masData = row;
 			}
 		}
	});
	if ( selRowData.partial_seq=="" ) {
		sum_zdeli_menge += Number(zdeli_menge);
	}
	
// 	if( menge != sum_zdeli_menge ){
	if( menge < sum_zdeli_menge ){
		fnMessageModalAlert("Warning...", "분할 하고자하는 수량의 합은 요청수량과 같아야 합니다.<br>(요청수량 : "+menge+" / 분할수량의 합 : " + sum_zdeli_menge + ")");
		$("#grid_goods").jqGrid('setCell', selId, 'zdeli_menge', menge);
		return;
	}
	
	var chiData = { qty : zdeli_menge, date : vendor_delivery_date, level : selRowData.level, partial_seq : selRowData.partial_seq };
	var page_url = "/frontend/scm/departOrder"
	var postData = 'momGridData=' + encodeURIComponent(JSON.stringify(masData))
				 + '&chiData=' + encodeURIComponent(JSON.stringify(chiData));
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		fnSearchGoodsList();
// 				if( (data.rows).length>0 ){
// 					$.each(data.rows, function (i, item) {
// 						$('#'+gubun).append($('<option>', { 
// 					        value: item.code,
// 					        text : item.code_nm 
// 					    }));
// 					});
// 				}
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

function chkNumber(obj){
	if( !cf_isNumber($(obj).val()) ){
		fnMessageModalAlert("Warning...", "수량은 숫자형식으로 입력해야 합니다.");
		$(obj).val('0');
		$(obj).focus();
		return;
	}
}
</script>
</body>
</html>