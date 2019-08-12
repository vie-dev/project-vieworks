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
		<jsp:param name="selected_menu_cd" value="1040" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        SCM관리
        <small>납품관리/입하</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> SCM관리</a></li><li class="active">납품관리/입하</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
    	<div class="row">
			<div class="col-md-6">
				<div class="box" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">납품관리</h3>
						<div class="box-tools pull-right">
							<button type="button" id="" onclick="fnSearchDelivListGrid();" class="btn btn-primary btn-sm">조회</button>
<!-- 							<button type="button" id="" onclick="makeTranDetails();" class="btn btn-primary btn-sm">거래명세서</button> -->
							| 
							<button type="button" id="" onclick="checkSheduleSearch();" class="btn btn-warning btn-sm">일정변경 확인</button>
						</div>
					</div>
					<div class="box-body" style="padding-bottom: 0px;">
						<div class="row">
							<div class="col-sm-6">
								<div class="form-group">
									<label>| 납품요청일자</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right input-sm" id="decide_date_range">
									</div>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 진행상태</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="rorder_status" class="form-control select2 input-sm" data-placeholder="Vendor 선택" style="width: 100%;">
											<option value="">전체</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 문서번호</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="ebeln">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="dv_grid_po" class="box-body">
						<table id="grid_po"></table>
						<div id="grid_po_pager"></div>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="box box-warning" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">입하관리</h3>
						<div class="box-tools pull-right"> <!-- style="min-width:600px;" -->
<!-- 							<div id="progress" class="col-sm-6 progress" style="float:left;"> -->
<!-- 								<div class="progress-bar progress-bar-warning"></div> -->
<!-- 							</div> -->
							<div id="serialBtns" style="float:right; text-align: right; display:none;">
								&nbsp;|&nbsp;<button type="button" class="btn btn-info btn-sm grid_attach_down" onclick="excelFileDownload();" data-selfilepath="/upload" data-selfilename="test.xlsx">
									<i class="fa fa-check"></i> 다운로드 
								</button>
								<span class="btn btn-warning btn-sm fileinput-button"> 
									<span>시리얼 일괄 처리</span> 
									<input id="fileupload" type="file" name="files[]" multiple>
								</span>
							</div>
							<button type="button" id="" onclick="processArrivalGoods();" class="btn btn-primary btn-sm">임하처리</button>
						</div>
					</div>
					<div id="dv_grid_sernr" class="box-body">
						<table id="grid_sernr"></table>
						<div id="grid_sernr_pager"></div>
						<div class="text-center" style="height:54px;">
							<button type="button" id="btn_saveSerial" class="btn btn-success btn-sm" onclick="saveSerials();" style="margin: 10px 0px 10px 0px;">저장</button>
						</div>
					</div>
				</div>
			</div>
		</div>
   	</section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
<div class="modal fade" id="modal_comment" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">일정변경 확인</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_deli_depart" name="frm_deli_depart" class="form-horizontal">
					<div class="row">
						<div class="col-md-12">
							<form id="frm_mcode" name="frm_mcode" class="form-horizontal">
							<div class="form-group">
								<label for="m_ebeln" class="col-sm-3 control-label">문서번호</label>
								<div class="col-sm-9">
									<input type="input" id="m_ebeln" name="m_ebeln" class="form-control input-sm" placeholder="auto" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label for="m_matnr" class="col-sm-3 control-label">품목</label>
								<div class="col-sm-9">
									<input type="input" id="m_matnr" name="m_matnr" class="form-control input-sm" placeholder="auto" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label for="m_txz01" class="col-sm-3 control-label">내역</label>
								<div class="col-sm-9">
									<input type="input" id="m_txz01" name="m_txz01" class="form-control input-sm" placeholder="auto" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label for="m_choice" class="col-sm-3 control-label">처리방법 선택</label>
								<div class="col-sm-9">
									<select class="form-control input-sm" id="m_choice">
										<option value="">선택</option>
										<option value="A">확인처리</option>
										<option value="B">반려처리</option>
									</select>
								</div>
							</div>
							<div class="form-group" id="commentArea" style="display:none;">
								<label for="m_comment" class="col-sm-3 control-label">의견</label>
								<div class="col-sm-9">
									<textarea class="form-control" id="m_comment" rows="3"></textarea>
								</div>
							</div>
							</form>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-sm btn-success" onclick="checkSheduleSave();">저장</button>
					<button type="button" id="" class="btn btn-sm btn-default" data-dismiss="modal">닫기</button>
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
$(function($) {
	fnLoadCommonOption();
	fnLoadDelivListGrid();	//fnSearchMainGrid
	fnLoadDelivSernrListGrid();
})

// search component setting
function fnLoadCommonOption() {
	$(window).bind('resize', function() {
		resizeJqGrid("grid_po", false);
		resizeJqGrid("grid_sernr", false);
	}).trigger('resize');
	
	$("#decide_date_range").pressEnter(function(e) {
		e.preventDefault();
		if(e.target.id == "decide_date_range"){
			fnSearchDelivListGrid();
		}
	});
	$('#decide_date_range').daterangepicker({
		opens: 'right',
		startDate : '2017-10-01',
		endDate : '2017-10-31',
		locale: {
			format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
			,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
			,showMonthAfterYear: true
			,yearSuffix: '년'
			,orientation: "top left"
	    }
	});
	$('#m_choice').change(function() {
		if( $(this).val()=='' ){
			alert('값을 선택하지 않았습니다.');
		} else if( $(this).val()=='A' ) {
			$('#commentArea').hide();
		} else if( $(this).val()=='B' ) {
			$('#commentArea').show();
		}
	});
	initScreenSizeModal();
	getStatusCodeList('rorder_status');
	
	fnLoadFileHandler();
}

//status code select
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
function fnSearchDelivListGrid(){
	console.log('fnSearchDelivListGrid()');
	var fDate = $("#decide_date_range").val().substring(0,10);
	var tDate = $("#decide_date_range").val().substring(13,23);
	$('#grid_sernr').jqGrid('clearGridData');
	var order_status = $('#rorder_status').val();
	var ebeln = $('#ebeln').val();
	
	var page_url = "/frontend/scm/vendor_result_select"
				 + "?jidat_from=" + encodeURIComponent(fDate)
				 + "&jidat_to=" + encodeURIComponent(tDate)
				 + "&rorder_status=" + encodeURIComponent(order_status)
				 + "&ebeln=" + encodeURIComponent(ebeln);
// 				 + "?jidat_from=" + encodeURIComponent(fDate)
// 				 + "&jidat_to=" + encodeURIComponent(tDate)
// 				 + "&rorder_status=" + encodeURIComponent(order_status)
// 				 + "&funcName=" + encodeURIComponent("ZMMFM_PURCH_ORD");

	$("#grid_po").jqGrid('setGridParam',{url:page_url, datatype:'json', loadComplete : function(data){
		if( (data.rows).length>0 ){
			$.each((data.rows), function(idx, item){
				if( item.diff_date=='Y' ){
		    		$("#grid_po").jqGrid('setRowData', idx+1, false, {color: 'red'});
				} else {
					$("#grid_po").jqGrid('setRowData', idx+1, false, {color: 'black'});
				}
			});
		}
	}});
	$("#grid_po").setGridParam({ page: 1 }).trigger("reloadGrid");
}

//serch parameter setting
function fnChkVendorUpdateFromDelivery(){
	console.log('fnChkVendorUpdateFromDelivery()');
	
	$('#grid_po').jqGrid('clearGridData');
	var fDate = $("#decide_date_range").val().substring(0,10);
	var tDate = $("#decide_date_range").val().substring(13,23);
	var order_status = $('#rorder_status').val();
	$("#grid_sernr").jqGrid('clearGridData');
	
	var page_url = "/frontend/scm/vendorUpdateFromDelivery"
				 + "?jidat_from=" + encodeURIComponent(fDate)
				 + "&jidat_to=" + encodeURIComponent(tDate)
				 + "&rorder_status=" + encodeURIComponent(order_status)
				 + "&funcName=" + encodeURIComponent("ZMMFM_PURCH_ORD");
// 	var page_url = "/frontend/scm/delivery_req_select"
// 				 + "?jidat_from=" + encodeURIComponent(fDate)
// 				 + "&jidat_to=" + encodeURIComponent(tDate)
// 				 + "&rvendor_status=" + encodeURIComponent(vendor_status)
// 				 + "&funcName=" + encodeURIComponent("ZMMFM_PURCH_ORD");
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

// search result grid
function fnLoadDelivListGrid(){
	console.info('fnLoadDelivListGrid()');
	// 납품일정이 변경되면 목록에서 빨간색으로 해당 항목을 표시한다.
	var fDate = $("#decide_date_range").val().substring(0,10);
	var tDate = $("#decide_date_range").val().substring(13,23);
	var order_status = $('#rorder_status').val();
// 	var raw_num = $('#raw_num').val();
	var subgridData = [];
	
	var page_url = "/frontend/scm/vendor_result_select"
				 + "?jidat_from=" + encodeURIComponent(fDate)
				 + "&jidat_to=" + encodeURIComponent(tDate)
				 + "&rorder_status=" + encodeURIComponent(order_status);
	
	$("#grid_po").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['구매문서', '문서순번', '분기순번', '품목', '요청상태', '구매상태', '요청상태_code', '구매상태_code','최조납품일자', 
		          '구매오더일자', '납품요청일자', '요청수량', '납품수량', '플랜트','저장위치',
		          'diff_date', 'bukrs', 'eindt','txz01','sernp','meins','labnr'],// 
		colModel:[
				{ name:'ebeln', index:'ebeln', sorttype:"text", sortable:true, width:0},
				{ name:'ebelp', index:'ebelp', sorttype:"text", sortable:true},
				{ name:'partial_seq', index:'partial_seq', sorttype:"text", sortable:true},
				{ name:'matnr', index:'matnr', sorttype:"text", sortable:true},
				{ name:'rorder_status_nm', index:'rorder_status_nm', sorttype:"text", sortable:true},
				{ name:'rvendor_status_nm', index:'rvendor_status_nm', sorttype:"text", sortable:true},
				{ name:'rorder_status', index:'rorder_status', sorttype:"text", sortable:true, hidden:true},
				{ name:'rvendor_status', index:'rvendor_status', sorttype:"text", sortable:true, hidden:true},
				{ name:'confirm_date', index:'confirm_date', sorttype:"text", sortable:true},
				{ name:'order_delivery_date', index:'order_delivery_date', sorttype:"text", sortable:true},
				{ name:'vendor_delivery_date', index:'vendor_delivery_date', sorttype:"text", sortable:true},
				{ name:'menge', index:'menge', sorttype:"number"},
				{ name:'zdeli_menge', index:'zdeli_menge', sortable:true, align:"right",sorttype:'number',formatter:'number', summaryType:'sum'},
				{ name:'werks', index:'werks', sorttype:"text", sortable:true, hidden:true},
				{ name:'lgort', index:'lgort', sorttype:"text", sortable:true, hidden:true},
				{ name:'diff_date', index:'diff_date', sorttype:"text", sortable:true, hidden:true},
				{ name:'bukrs', index:'bukrs', sorttype:"text", sortable:true, hidden:true},
				{ name:'eindt', index:'eindt', sorttype:"text", sortable:true, hidden:true},
				{ name:'txz01', index:'txz01', sorttype:"text", sortable:true, hidden:true},
				{ name:'sernp', index:'sernp', sorttype:"text", sortable:true, hidden:true},
				{ name:'meins', index:'meins', sorttype:"text", sortable:true, hidden:true},
				{ name:'labnr', index:'labnr', hidden:true}],
		rowNum:50,
		rowList : [ 20, 50, 100 ],
		pager : "#grid_po_pager",
	    height: 510,
	    width:270,
	    rownumWidth: 25,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : true,
		altRows: true,
		rownumbers: true, 
	    autoencode: true,
	    loadonce: false,
	    sortable: true,
	    sortname: 'ebeln',
	    sortorder: 'desc',
	    grouping: true,
	    cellsubmit : 'clientArray',
	   	groupingView : {
	   		groupField : ['ebeln', 'vendor_delivery_date'],
	   		groupColumnShow : [false, false],
	   		groupText : ['<b>{0}</b>', '{0}'],
// 	   		groupText : ['<input type="checkbox" name="eee" class="groupHeader" onChange="chkEvent(this);"/> <b>{0}</b>', '{0}'],
	   		groupCollapse : false,
			groupOrder: ['asc', 'asc'],
			groupSummary : [false, false]
	   	},
	    loadComplete : function(data){
// 	    	console.log(data);
	    	if( mainKey!=null || mainKey!=undefined )
            	$("#grid_po").jqGrid('setSelection', mainKey, true);
	    	
	    	if( (data.rows).length>0 ){
				$.each((data.rows), function(idx, item){
					if( item.partial_seq!=undefined && item.partial_seq!='' ){
						$("#"+item.ukey).hide();
					}
				});
			}
	    	var pureDataArr = data.rows;
	    	for(var idx=0; idx<pureDataArr.length; idx++){
	    		if( pureDataArr[idx].diff_date=='Y' ){
// 		    		$("#grid_po").setRowData(pureDataArr[idx].ebeln+'-'+pureDataArr[idx].ebelp, false, {color: 'red'});
		    		$("#grid_po").jqGrid('setRowData', idx+1, false, {color: 'red'});
	    		}
	    	}
	    },
// 	    onCellSelect: function(rowid, index, contents, event){
// 	    	console.warn(rowid, index, contents, event);
// 	    	var selRowData = $("#grid_po").getRowData(rowid);
// 			console.log(selRowData);
// 			mainKey = rowid;
// 			selectGridId = 'grid_po';
// 			//fnSearchGoodsDetailList('grid_po', rowid);
// 	    	if( index>2 && index<19 && selRowData.partial_yn=='Y' ){
// 	    		fnMessageModalAlert("Notification(SCM)", "분할 정보 등록 항목입니다.<br> 하위 노드를 확인하여 주시기 바랍니다.");
// 	    	}
// 	    },
		onSelectRow: function(rowid, selected) {
// 			console.warn(selected);
			var selRowData = $("#grid_po").getRowData(rowid);
// 			console.log(selRowData);
			if( selected ) {
				if( selRowData.sernp!='V001' ){
					$('#serialBtns').hide();
					$('#btn_saveSerial').hide();
					makeSernrList(rowid);
				}else{
					$('#serialBtns').show();
					$('#btn_saveSerial').show();
					if( chkSernrExist(selRowData.ebeln, selRowData.ebelp) ) {
						loadSernrList(rowid, selected);
					} else {
						makeSernrList(rowid);
					}
				}
			} else {
				removeFromSernrGrid(rowid);
			}
		}
	}); 
	$("#grid_po").hideCol("cb");
}

function chkSernrExist(ebeln, ebelp) {
	console.log('chkSernrExist()');

	var page_url = "/frontend/scm/raw_sernr_select";
	var postData = "ebeln=" + encodeURIComponent(ebeln)
				 + "&ebelp=" + encodeURIComponent(ebelp);
	var returnVal = false;	// not exist serial
	$.ajax({
	    url: page_url,
	    data: postData,
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					returnVal = true;
				}
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
	return returnVal;
}

//detail grid setting
function fnLoadDelivSernrListGrid() {
	console.info('fnLoadDelivSernrListGrid()');
	var grid = $("#grid_po");
	var selected_master_code = grid.jqGrid('getGridParam',"selrow");
	$("#grid_sernr").jqGrid({
		datatype: "json",
		colNames:['문서번호', '품목', '내역', '요청수량', '입하수량', '순차관리번호','ebelp','partial_seq', 'ukey'],
		colModel:[
// 			{name:'seq',index:'seq', width:100, sorttype:"text", sortable:true, hidden:true},
			{name:'ebeln',index:'ebeln', width:100, sorttype:"text", sortable:true},
			{name:'matnr',index:'matnr', width:100, sorttype:"text", sortable:true},
			{name:'txz01',index:'txz01', width:100},
			{name:'menge',index:'menge', width:100, sorttype:"text", sortable:true},
			{name:'zdeli_menge',index:'zdeli_menge', width:100},
			{name:'equnr',index:'equnr', width:100,  editoptions: { maxlength: 13}},	//, editable:true
			{name:'ebelp',index:'ebelp', hidden:true},
			{name:'partial_seq',index:'partial_seq', hidden:true},
			{name:'ukey',index:'ukey', hidden:true, key:true}
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
	    sortname: "ebeln",
	    onCellSelect: function(rowid, index, contents, event){ 
// 	    	console.log(rowid, index, contents, event);
// 	    	console.log($("#grid_sernr").getRowData());
	    	var colModels = $(this).getGridParam('colModel'); 
// 	    	var colName = colModels[iCol].name; 
	    	var colName = colModels[index].name; 
	    	if( colName=='equnr' ) { 
	    		$(this).setColProp(colName, { editable: true }); 
	    		$(this).editCell($("#grid_sernr").getInd(rowid), index, true);
	    	} 
	    },
	    afterEditCell: function (rowid, cellname, value, iRow, iCol) {
// 	    	console.log(rowid, cellname, value, iRow, iCol);
			//This code saves the state of the box when focus is lost in a pretty horrible
            //way, may be they will add support for this in the future
            //set up horrible hack for pressing enter when leaving cell
            if(cellname=='equnr') {
	            e = jQuery.Event("keydown");
	            e.keyCode = $.ui.keyCode.ENTER;
	            //get the edited thing
	            edit = $(".edit-cell > *");
	            edit.blur(function() {
	                edit.trigger(e);
	            });
            }
    	},
		loadComplete : function(data) {
		}
	});
}

function saveSerials() {
	console.log('saveSerials()');	
 
	var rawValidationChk_result = rawValidationChk();		
	if(rawValidationChk_result == false) {
		//fnSearchGoodsList();
		//$('#grid_po').jqGrid('setSelection',mainKey, true);
		return;
	}
	var gridDataArr = $('#grid_sernr').jqGrid('getRowData');
	var selGridRowData = $("#grid_po").getRowData($('#grid_po').jqGrid('getGridParam','selrow'));
	var page_url = "/frontend/scm/scm_sernr_insert"
	var postData = 'gridData=' + encodeURIComponent(JSON.stringify(gridDataArr))
// 				 + '&partial_seq=' + encodeURIComponent(selGridRowData.partial_seq)
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
// 						var serTblCnt = chkSubGridData(selGridRowData);
// 						var gridData = $('#grid_po').jqGrid('getRowData');
// 				    	$.each(gridData, function(idx, row){
// 				    		if( (selGridRowData.ebelp==row.ebelp) && (selGridRowData.ebeln==row.ebeln) && (row.partial_seq=='') ){
// 				    			if((Number(row.menge)-serTblCnt)>0){
// 				    				fnMessageModalAlert("Notification(SCM)", "상위 요청에 대한 일부분만 저장이 되었습니다.<br>하위의 모든 요청을 저장하지 않으면 상위요청의 상태는 업데이트 되지 않습니다.");
// 				    				updateVendorStatus('v2');
// 				    			}else{
// 				    				updateVendorStatus('v2');
// 				    				updateDeliveryStatus('v2', serTblCnt);
// 				    			}
// 				    			return false;
// 				    		}
// 				    	});
// 	    				$('#grid_sernr').jqGrid('clearGridData');
	    				fnSearchDelivListGrid();
	    				$('#grid_po').jqGrid('setSelection',$('#grid_po').jqGrid('getGridParam','selrow'), true);
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

function rawValidationChk() {
	console.log('rawValidationChk()');
	
	var rawValidationChk_result = null;
	var gridDataArr = $('#grid_sernr').jqGrid('getRowData');
	var selRowData = $("#grid_po").getRowData($('#grid_po').jqGrid('getGridParam','selrow'));
	var arrSernr = [];

	$.each(gridDataArr, function(idx, row){
		arrSernr.push(row.equnr);
	});
	
	// 순차관리  체크 박스
	var cntSerGridIDs = $("#grid_sernr").jqGrid('getGridParam', 'selarrrow');
	if( gridDataArr.length!=cntSerGridIDs.length ){
		fnMessageModalAlert("Notification(SCM)", "체크되지 않은 항목이 았습니다.<br>모든 항목을 체크해 주시기 바랍니다.");
		rawValidationChk_result = false;
		return false;
	}

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
	/*		
	// 상태 체크
	var page_url = "/frontend/prod/rawDelivery_selectByKey";
	var postData = "ebeln=" + encodeURIComponent(selRowData.ebeln)
				 + "&ebelp=" + encodeURIComponent(selRowData.ebelp);
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
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
	*/
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

function updateVendorStatus(status) {
	console.info('updateVendorStatus(',status,')');
	var selRowData = $("#grid_po").getRowData($("#grid_po").getGridParam('selrow')); 
	var page_url = "/frontend/scm/vendor_status_update"
	var postData = 'ebelp=' + encodeURIComponent(selRowData.ebelp)
				 + '&ebeln=' + encodeURIComponent(selRowData.ebeln)
				 + '&rvendor_status=' + encodeURIComponent(status)
				 + '&diff_date=N'
				 + '&confirm_date=' + encodeURIComponent(selRowData.vendor_delivery_date)
				 + '&partial_seq=' + encodeURIComponent(selRowData.partial_seq);
	console.log(postData);
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
	
	var selRowData = $("#grid_po").getRowData($("#grid_po").getGridParam('selrow'));
	
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

function makeSernrList(rowid) {
	console.info('makeSernrList()');
// 	$('#serialBtns').show();
// 	$('#grid_sernr').jqGrid('clearGridData');
	var selRowData = $("#grid_po").getRowData(rowid);
	var serialRowData = $("#grid_sernr").getRowData();
	console.log(selRowData);
// 	console.log(serialRowData.length);
	// make dataset and add
	var arrTmpObj = [];
	var pad = "0000";
	if( selRowData!={} && selRowData.zdeli_menge>0 ){
		if( selRowData.sernp!='V001' ){
			var tmpObj = {};
// 			tmpObj.seq = serialRowData.length; 
// 			tmpObj.seq = ''; 
// 			tmpObj.ukey = selRowData.ebeln+selRowData.ebelp+selRowData.partial_seq;
			var ans = pad.substring(0, pad.length - (String(idx+serialRowData.length).length)) + String(idx+serialRowData.length);
// 				tmpObj.seq = idx+1;
			tmpObj.ukey = selRowData.ebeln+selRowData.ebelp+ans;
			tmpObj.ebeln = selRowData.ebeln;
			tmpObj.ebelp = selRowData.ebelp;
			tmpObj.partial_seq = selRowData.partial_seq;
			tmpObj.matnr = selRowData.matnr;
			tmpObj.txz01 = selRowData.txz01;
			tmpObj.menge = selRowData.menge; 
			tmpObj.zdeli_menge = selRowData.zdeli_menge;
// 			console.log(tmpObj);
			arrTmpObj.push(tmpObj);
			if( serialRowData.length==0 ){
				$("#grid_sernr").jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj });
				$("#grid_sernr").trigger('reloadGrid');
			} else {
				$('#grid_sernr').addRowData( serialRowData.length, tmpObj, 'first');
// 				$("#grid_sernr").trigger('reloadGrid');
			}
		} else {
// 			console.log('2');
// 			var str = "" + 1
// 			var pad = "0000"
// 			var ans = pad.substring(0, pad.length - str.length) + str

			for(var idx=0; idx<Number(selRowData.zdeli_menge); idx++ ){
				var tmpObj = {};
				var ans = pad.substring(0, pad.length - (String(idx+serialRowData.length).length)) + String(idx+serialRowData.length);
// 				tmpObj.seq = idx+1;
				tmpObj.ukey = selRowData.ebeln+selRowData.ebelp+ans;
				tmpObj.ebeln = selRowData.ebeln;
				tmpObj.ebelp = selRowData.ebelp;
				tmpObj.partial_seq = selRowData.partial_seq;
				tmpObj.matnr = selRowData.matnr;
				tmpObj.txz01 = selRowData.txz01;
				tmpObj.menge = 1; 
				tmpObj.zdeli_menge = 1;
// 				console.warn(tmpObj);
				arrTmpObj.push(tmpObj);
			}
// 			console.error(arrTmpObj);
			if( serialRowData.length==0 ){
// 				console.log('2-1');
				$("#grid_sernr").jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj });
				$("#grid_sernr").trigger('reloadGrid');
			} else {
// 				console.log('2-2');
// 				console.log(arrTmpObj);
				for(var i=0; i<arrTmpObj.length ; i++){
					$('#grid_sernr').addRowData( (serialRowData.length)+i, arrTmpObj[i], 'first');
				}
			}
// 			$("#grid_sernr").jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj });
// 			$("#grid_sernr").trigger('reloadGrid');
		}
	}
}

var complete = false;
function loadSernrList(rowid, selected) {
	console.info('loadSernrList()');
// 	$('#grid_sernr').jqGrid('clearGridData');
	$('#grid_sernr').setColProp('sernr', {editable:false});
	var serialGridData = $("#grid_sernr").getRowData();
	var cnt = serialGridData.length;
	var selRowData = $("#grid_po").getRowData(rowid);
// 	var page_url = "/frontend/scm/raw_sernr_select"
// 				 + "?ebeln=" + encodeURIComponent(selRowData.ebeln)
// 				 + "&ebelp=" + encodeURIComponent(selRowData.ebelp);
	var page_url = "/frontend/scm/raw_sernr_select";
	var postData = "ebeln=" + encodeURIComponent(selRowData.ebeln)
				 + "&ebelp=" + encodeURIComponent(selRowData.ebelp)
				 + "&partial_seq=" + encodeURIComponent(selRowData.partial_seq);
	if( cnt==0 ){
		var pageurl = "/frontend/scm/raw_sernr_select"
			 + "?ebeln=" + encodeURIComponent(selRowData.ebeln)
			 + "&ebelp=" + encodeURIComponent(selRowData.ebelp)
			 + "&partial_seq=" + encodeURIComponent(selRowData.partial_seq);
		$("#grid_sernr").jqGrid('setGridParam',{url:pageurl, datatype:'json', loadComplete : function(data) {
			complete = true;
		}});
		
// 		$("#grid_sernr").trigger("reloadGrid");
	} else {
		$.ajax({
		    url: page_url,
		    data: postData,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    	var arrData = data.rows;
			    	console.log(arrData);
			    	for(var i=0; i<arrData.length; i++){
			    		$('#grid_sernr').addRowData( (cnt-1)+i, arrData[i], 'first');
	// 		    		position: 'first', 'last', 'before', 'after'
			    	}
// 			    	$("#grid_sernr").trigger("reloadGrid");
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
// 	$("#grid_sernr").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_sernr").trigger("reloadGrid");
	/*
	$("#grid_sernr")[0].addJSONData(arrTmpObj);
	*/
}

function removeFromSernrGrid(rowid) {
	console.log('removeFromSernrGrid(',rowid,')');
	var selRowData = $("#grid_po").getRowData(rowid);
	var serialGridData = $("#grid_sernr").getRowData();
// 	console.log(selRowData);
// 	console.log(serialGridData);
	var ids = $("#grid_sernr").getDataIDs();
// 	console.log(ids);
	for (var i=0 ; i<ids.length ; i++ ){
		var tmpRow = $("#grid_sernr").getRowData(ids[i]);
// 		console.log(tmpRow);
// 		console.log(tmpRow.ebeln,selRowData.ebeln , '/',tmpRow.ebelp, selRowData.ebelp  , '/',tmpRow.partial_seq, selRowData.partial_seq);
		if( tmpRow.ebeln==selRowData.ebeln && tmpRow.ebelp==selRowData.ebelp && tmpRow.partial_seq==selRowData.partial_seq ) {
// 			console.log(ids[i]);
			if( serialGridData.length==1 ){
				$('#grid_sernr').jqGrid('clearGridData');
			}else{
				$('#grid_sernr').jqGrid('delRowData',ids[i]);
// 				$('#grid_sernr').jqGrid('delRowData',tmpRow.seq);
// 				$("#grid_sernr").trigger("reloadGrid");
			}
		}else{
// 			console.log(tmpRow);
// 			console.log(selRowData);
		}
	}
}

// 입하처리
function processArrivalGoods() {
	console.info('processArrivalGoods()');
	
	var validateChk = false;
// 	var selRowData = $("#grid_po").getRowData($("#grid_po").getGridParam('selrow'));
	var serialRowData = $("#grid_sernr").jqGrid('getRowData');
	
	var pokeyArr = $('#grid_po').jqGrid('getDataIDs');
	var selRowData = [];
	for (var i = 0; i < pokeyArr.length; i++) { //row id수만큼 실행           
    	if($("input:checkbox[id='jqg_grid_po_"+pokeyArr[i]+"']").is(":checked")){ //checkbox checked 여부 판단
//     		chkKeyArr.push(keyArr[i]);
    		selRowData.push($("#grid_po").getRowData(pokeyArr[i])); 
    	}
   	}
	
// 	var keyArr = $('#grid_sernr').jqGrid('getDataIDs');
// 	for(var idx=0; idx<serialRowData.length; idx++){
// 		console.log();
// 		serialRowData[idx].equnr = $('#'+keyArr[idx]+'_equnr').val(); 				
// 	}
	
	// checkbox
	var cntSerGridIDs = $("#grid_sernr").jqGrid('getGridParam', 'selarrrow');
//		console.log($("#grid_sernr").getGridParam('selrow'));

	if( serialRowData.length!=cntSerGridIDs.length ){
		fnMessageModalAlert("Notification(SCM)", "체크되지 않은 항목이 았습니다.<br>모든 항목을 체크해 주시기 바랍니다.");
		validateChk = true;
 		return false;
	}
// 	$.each($('#grid_sernr').getRowData(), function(idx, row){
// 		console.log(row);
		
// 		if( !$("input:checkbox[id='jqg_grid_sernr_" + row.ukey + "']").is(":checked") ){
// 			fnMessageModalAlert("Notification(SCM)", "체크되지 않은 항목이 았습니다.<br>모든 항목을 체크해 주시기 바랍니다.");
// 			validateChk = true;
// 	 		return false;
// 		}
// 	});
	if( validateChk ) {
		return;
	}
// 	var chkBoxCnt = 0;
// 	for( var idx=0; idx<keyArr.length; idx++){
// 		var chk = $("input:checkbox[id='jqg_grid_sernr_" + keyArr[idx] + "']").is(":checked");
// 		if(chk == true) chkBoxCnt++;
// 	}
	
// 	var gridDataArr = $('#grid_sernr').jqGrid('getRowData');
	
	var page_url = "/frontend/scm/arrivalOfGoods"
	var postData = 'funcName=ZMMFM_GOODSMVT_PO'
				 + '&selRowData=' + encodeURIComponent(JSON.stringify(selRowData))
				 + '&serialData=' + encodeURIComponent(JSON.stringify(serialRowData));
	console.log(selRowData);
	console.log(serialRowData);
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
// 	    		fnMessageModalAlert("Notification(SCM)", "success - "+JSON.stringify(data.rows));	
		    	fnMessageModalConfirm("Notification(SCM)", "정보를 저장하였습니다.", function(chk){
		    		if(chk){
// 						var serTblCnt = chkSubGridData(selGridRowData);
// 						var gridData = $("#grid_po").jqGrid('getRowData');
	    				fnChkVendorUpdateFromDelivery();
	    				$("#grid_po").jqGrid('setSelection',$('#grid_po').jqGrid('getGridParam','selrow'), true);
	    			}
	    		});
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다." + data.message);	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
	/*
	- A, N인 결우의 데이터를 입하차리할 때는 sernr테이블에 저장 후 입하처리한다.
	- Y인 결루 데이터는 그냥 입하처리한다.
	*/
}

// 수기 순차관리번호 입력 처리
function addSernr() {
	console.log('addSernr()');
	var gridDataArr = $('#grid_sernr').jqGrid('getRowData');
	var keyArr = $('#grid_sernr').jqGrid('getDataIDs');
	
	for(var idx=0; idx<gridDataArr.length; idx++){
		gridDataArr[idx].sernr = $('#'+keyArr[idx]+'_sernr').val(); 				
	}
	var jsonStr = JSON.stringify(gridDataArr);
	var page_url = "/frontend/scm/scm_sernr_insert"
	var postData = 'gridData=' + encodeURIComponent(jsonStr);
				 
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
// 		    	updateVendorStatus('v2');
		    	fnMessageModalConfirm("처리결과", "정보를 저장하였습니다.", function(chk){
	    			if(chk){
						fnSearchDelivListGrid();
						alert('입하관리 refesh수정 중');
// 	    				$('#grid_po').jqGrid('setSelection','1', true);
	    			}
	    		});
	    	} else {
	    		fnMessageModalAlert("오류발생", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("오류발생", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    }
	});
}

// 일정변경확인
function checkSheduleSearch() {
	console.log('checkSheduleSearch()->checkSheduleSave()');
	
	var selRowData = $("#grid_po").getRowData($('#grid_po').jqGrid('getGridParam','selrow'));
	if( JSON.stringify(selRowData)=='{}' ){
		fnMessageModalAlert("Warning!", "확인하고자 하는 일정을 선택 후 시도하세요.");
		return;
	}
	if( selRowData.diff_date=='N' ) {
		fnMessageModalAlert("Warning!", "이미 일정변경 확인 처리가 된 항목입니다.");
		return;
	} 
	// serial
// 	console.log(selRowData);
	
	$("#m_ebeln").val(selRowData.ebeln);
	$("#m_matnr").val(selRowData.matnr);
	$("#m_txz01").val(selRowData.txz01);
	$('#modal_comment').modal('show');
}

function checkSheduleSave() {
	console.log('checkSheduleSave()');
	if( $('#m_choice').val()=='' ) {
		fnMessageModalAlert("No.No.", "처리방법을 선택 후 저장버튼을 누르세요.");		
	} else if( $('#m_choice').val()=='A' ){
		// 확인
		updateStatus('r3');
// 		updateVendorStatus('v2');
	} else if( $('#m_choice').val()=='B' ){
		// 반려
		updateStatus('r2');//,insert comment
	}
}

function updateStatus(status) {
	console.log('updateStatus(',status,')');
// 	var selRowData = $("#" + selectGridId).getRowData(mainKey);
// 	console.log(selRowData);
	var keyArr = $('#grid_po').jqGrid('getDataIDs');
// 	var chkKeyArr = [];
	var sendDataArr = [];
	for (var i = 0; i < keyArr.length; i++) { //row id수만큼 실행           
    	if($("input:checkbox[id='jqg_grid_po_"+keyArr[i]+"']").is(":checked")){ //checkbox checked 여부 판단
//     		chkKeyArr.push(keyArr[i]);
    		sendDataArr.push($("#grid_po").getRowData(keyArr[i])); 
    	}
   	}
	console.log(sendDataArr);
	var page_url = "/frontend/scm/confirmSchedule"
	var postData = 'gridData=' + encodeURIComponent(JSON.stringify(sendDataArr))
				 + '&rorder_status=' + encodeURIComponent(status)
				 + "&jidat_from=" + encodeURIComponent($("#decide_date_range").val().substring(0,10))
				 + "&jidat_to=" + encodeURIComponent($("#decide_date_range").val().substring(13,23));

	if( status=='r2' ){
		postData += '&comment=' + encodeURIComponent($('#m_comment').val());
		postData += '&order_delivery_date=' + encodeURIComponent(selRowData.order_delivery_date);
		postData += '&rvendor_status=';
	} else {
		postData += '&diff_date=' + encodeURIComponent('N')
				 + '&rvendor_status=v2';
	}	
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
   				$('#modal_comment').modal('hide');
		    	fnMessageModalConfirm("처리결과", "정보를 저장하였습니다.", function(chk){
	    			if(chk){
	    				if( status=='r3' ){
	    					updateVendorStatus('v2');
	    				}
	    				$('#grid_sernr').jqGrid('clearGridData');
						fnSearchDelivListGrid();
// 						alert('입하관리 refesh수정 중');
// 	    				$('#grid_po').jqGrid('setSelection','1', true);
	    			}
	    		});
	    	} else {
	    		fnMessageModalAlert("오류발생", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("오류발생", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    }
	});
	/*
	//
	var mainKey;
var selectGridId;
		$('#m_matnr').val(selectedData.matnr);
		$('#m_txz01').val(selectedData.txz01);
		$('#m_comment').val('');
	*/
	// insert raw_comment_tbl
	// update raw_vendor_result : rorder_status
	// update raw_delivery_tbl : rorder_status, updater, date_updated
}


function excelFileDownload() {
	console.log('excelFileDownload()');
	
	var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
	var is_rownum = $("#grid_sernr").jqGrid('getGridParam','rownumbers');
	var colNames = $("#grid_sernr").jqGrid('getGridParam','colNames');
	var colModels = $("#grid_sernr").jqGrid('getGridParam','colModel');
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
	export_data += "&header_col_names="+encodeURIComponent(param_col_name);
	export_data += "&header_col_ids="+encodeURIComponent(param_col_id);
	export_data += "&header_col_aligns="+encodeURIComponent(param_col_align);
	export_data += "&header_col_widths="+encodeURIComponent(param_col_width);
	export_data += "&header_col_widths="+encodeURIComponent(param_col_width);
	export_data += "&cmd="+encodeURIComponent("grid_sernr");
	var goods_detail_data = $("#grid_sernr").jqGrid("getRowData");
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
		console.log(1,data);
	}).on('fileuploadprocessalways', function(e, data) {
// 		console.log(2,data);
		var index = data.index;
		var file = data.files[index];
		if (file.error) {
			fnMessageModalAlert("Notification", file.error);
		}
	}).on('fileuploadprogressall', function(e, data) {
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#progress .progress-bar').css('width', progress + '%');
	}).on('fileuploaddone', function(e, data) {
// 		console.log(3, data);
		var selRowData = $("#grid_po").getRowData($('#grid_po').jqGrid('getGridParam','selrow'));
		var arrData = data.result.rows;
		var priData = [];
		var pad = "0000";
		for(var i=0; i<data.result.rows.length; i++ ){
			var tmpObj = {};
// 			tmpObj.seq = i;	//???
// 			tmpObj.ukey = selRowData.ebeln+selRowData.ebelp+selRowData.partial_seq;
// 			var ans = pad.substring(0, pad.length - (String(i+serialRowData.length).length)) + String(i+serialRowData.length);
			var ans = pad.substring(0, pad.length - (String(i).length)) + String(i);
//				tmpObj.seq = idx+1;
			tmpObj.ukey = selRowData.ebeln+selRowData.ebelp+ans;
			tmpObj.ebeln = selRowData.ebeln;
			tmpObj.matnr = selRowData.matnr;
			tmpObj.txz01 = selRowData.txz01;
			tmpObj.menge = 1;
			tmpObj.zdeli_menge = 1;
			tmpObj.partial_seq = selRowData.partial_seq;
			tmpObj.equnr = arrData[i].equnr;
			priData.push(tmpObj);
		}
		$('#grid_sernr').jqGrid('setGridParam', { datatype: 'local', data: priData }).trigger('reloadGrid');	
	}).on('fileuploadfail', function(e, data) {
		$.each(data.files, function(index) {
			fnMessageModalAlert("Notification", "File upload failed.");
		});
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}

</script>
</body>
</html>