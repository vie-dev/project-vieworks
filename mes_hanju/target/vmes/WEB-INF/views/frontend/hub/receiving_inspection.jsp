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
  <title><%=pageTitle %></title>
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
		<jsp:param name="selected_menu_cd" value="1069" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        HUB
        <small>수입검사 마스터 관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> HUB</a></li><li class="active">수입검사 마스터 관리</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
    	<div class="row">
			<div class="col-md-6">
				<div class="row">
					<div class=" col-md-12">
						<div class="box">
							<div class="box-header with-border">
								<h3 class="box-title">검사 그룹</h3>
								<div class="box-tools pull-right">
									<div class="input-group input-group-sm" style="width: 100px;float: left;">
										<select id="sel_dept_cd" class="form-control select2" style="width: 100%;" onchange="searchInspectionHeader();">
											<option value="">전체</option>
											<option value="1110">의료영상 </option>
											<option value="1210">광영상</option>
										</select>
					                </div> | 
									<button type="button" id="" onclick="addInspectionHeader();" class="btn btn-primary btn-sm">검사 그룹 추가</button>
								</div>
							</div>
							<div class="box-body" style="padding-bottom: 0px;">
							</div>
							<div id="dv_grid_mas" class="box-body" style="padding-top: 0px;">
								<table id="grid_mas"></table>
								<div id="grid_mas_pager"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class=" col-md-12">
						<div class="box" style="margin-bottom: 0px;">
							<div class="box-header with-border">
								<h3 class="box-title">검사 정보</h3>
								<div class="box-tools pull-right">
									<button type="button" id="" onclick="addInspectionHeaderItem();" class="btn btn-primary btn-sm">추가</button>
									<button type="button" id="" onclick="deleteInspectionHeaderItem();" class="btn btn-danger btn-sm">삭제</button>
								</div>
							</div>
							<div id="dv_grid_det" class="box-body" style="padding-top: 0px;">
								<table id="grid_det"></table>
								<div id="grid_det_pager"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="box" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">검사 MATNR LIST</h3>
						<div class="box-tools pull-right">
			                <div class="input-group input-group-sm" style="width: 150px;float: left;">
			                  <input type="text" id="itnbr_search" name="itnbr_search" class="form-control pull-right" placeholder="name Search">
								<div class="input-group-btn">
			                    <button type="button" id="btn_itnbr_search" class="btn btn-default" onclick="searchItnbr();"><i class="fa fa-search"></i></button>
			                  </div>
			                </div>
			                &nbsp;|
			                <button type="button" id="" class="btn btn-info btn-sm" onclick="searchMatnr();">자재정보로 그룹검색</button>
			                <button type="button" id="" class="btn btn-warning btn-sm" onclick="addInspectionDetail();">항목 매핑</button>
			                <button type="button" id="btn_itnbr_del" class="btn btn-danger btn-sm" onclick="deleteInspectionDetail();">삭제</button>
						</div>
					</div>
					<div id="dv_grid_itnbr" class="box-body">
						<table id="grid_itnbr"></table>
						<div id="grid_itnbr_pager"></div>
					</div>
				</div>
			</div>
		</div>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <!-- popup include -->
  	<%@include file="./receiving_inspection_modal.jsp"%>
  	
  	<!-- material Search Condition -->
<div class="modal fade" id="modal_mat_search" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">자재정보로 그룹검색</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="text-center" style="font-weight:bold; color:blue;">
					 자재코드, 자재명  검색은 Like 검색을  사용합니다. (검색 입력정보를 포함한 데이터 검색)
				</div>
				<form id="frm_search_condition" name="frm_search_condition" class="form-horizontal">
					<div class="form-group">
						<label for="m_dept_cd" class="col-sm-3 control-label">사업부 구분</label>
						<div class="col-sm-7">
							<select id="m_dept_cd" class="form-control select2 input-sm" style="width: 100%;">
								<option value="">전체</option>
								<option value="1110">의료영상</option>
								<option value="1120">의료영상서비스</option>
								<option value="1210">광영상</option>
								<option value="1220">광영상서비스</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="m_itnbr" class="col-sm-3 control-label">자재코드</label>
						<div class="col-sm-7">
							<input type="input" id="m_itnbr" name="m_itnbr" class="form-control input-sm"  maxlength="20">
						</div>
					</div>
					<div class="form-group">
						<label for="m_itnbr_nm" class="col-sm-3 control-label">자재명</label>
						<div class="col-sm-7">
							<input type="input" id="m_itnbr_nm" name="m_itnbr_nm" class="form-control input-sm"  maxlength="20">
						</div>
					</div>
				</form>
				<div class="text-right">
		        	<button type="button" class="btn btn-sm btn-success" onclick="searchInspGroup();">검색 결과 확인</button>
		        </div>
				<div id="grid_search_group" style="width: 100%; height: 300px; display:none;"></div>
			</div><!-- end modal body -->
			<div class="modal-footer">
				<div class="text-center">
		        	<button type="button" class="btn btn-sm btn-primary" data-dismiss="modal">닫기</button>
		        </div>
			</div>
		</div><!-- end modal-content -->
	</div><!-- end modal dialog -->
</div><!-- end modal div -->


  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>
<!-- ./wrapper -->
<script type="text/javascript">
$(function($) {
	fnLoadCommonOption();
	loadInspectionHeader();
	loadInspectionDetailItem();
	loadInspectionItnbrAll();
	initGroupSearchGrid();
// 	fnLoadRegListGrid();//fnSearchMainGrid
// 	fnLoadRegListDetailGrid();//fnSearchMainGrid
})

// search component setting
function fnLoadCommonOption() {
	$(window).bind('resize', function() {
		resizeJqGrid("grid_mas", false);
		resizeJqGrid("grid_det", false);
		resizeJqGrid("grid_itnbr", false);
	}).trigger('resize');
	
	$( "#btn_search" ).on('click', function(e) {
		e.preventDefault();
		fnSearchMaster();
	});
	
	$('#btn_itnbr_del').hide();
	initScreenSizeModal();
}

// search Inspection_detail_master
function searchInspectionHeader(){
// 	console.info('searchInspectionHeader()');
	var page_url = "/frontend/hub/rinspection_header_select"
				 + "?dept_cd=" + encodeURIComponent($('#sel_dept_cd').val());
	
	$("#grid_mas").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_mas").trigger("reloadGrid");
}

// serch result grid
function loadInspectionHeader(){
// 	console.info('loadInspectionHeader()');
	var lastsel2;
	var page_url = "/frontend/hub/rinspection_header_select"
		 		 + "?dept_cd=" + encodeURIComponent($('#sel_dept_cd').val());
	
	$("#grid_mas").jqGrid({
		url:page_url,
		datatype: "json",
// 		colNames:['그룹코드', '그룹명','사업부코드','수정자', '생성일자','수정일자'],
		colNames:['그룹코드', '그룹명','사업부코드','사업부코드명'],
		colModel:[
	        {name:'inspection_gcode',index:'inspection_gcode', width:20, sorttype:"text", sortable:true, key:true},
	        {name:'inspection_gnm',index:'inspection_gnm', width:20, sorttype:"text", sortable:true, editable: true},
	        {name:'dept_cd',index:'dept_cd', width:20, sorttype:"text", sortable:true, hidden:true},
	        {name:'dept_nm',index:'dept_nm', width:20, sorttype:"text", sortable:true, hidden:true}
// 	        {name:'updater',index:'updater', width:20, sorttype:"text", sortable:true,editable: true},
// 	        {name:'date_created',index:'date_created', width:20, sorttype:"text", sortable:true,editable: true},
// 	        {name:'date_updated',index:'date_updated', width:20, sorttype:"text", sortable:true,editable: true}
		],
// 		pager : "#grid_po_pager",
		rowNum:10000,
// 		rowList : [ 20, 50, 100 ],
	    height: 275,
	    width:270,
// 	    cellEdit:true,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
// 	    multiselect : false,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    sortable: true,
	    loadComplete : function(data){
	    },
		onSelectRow: function(key) {
			if(key != null) {
				$('#btn_itnbr_del').show();
				searchInspectionDetail(key);
				searchInspectionMatnr(key);
			}					
		}
	}); 
}

function addInspectionHeader() {
	$("#grid").jqGrid('clearGridData');	// popup grid
	$('#modal_mcode').modal('show');
}

//master grid click row => search header item
function searchInspectionDetail(key) {
//  	console.log('searchInspectionDetail(',key,')');
	var page_url = "/frontend/hub/rinspection_detailItem_select"   
		 + "?inspection_gcode=" + key
		 + "&dept_cd=" + encodeURIComponent($('#sel_dept_cd').val());
	
	$("#grid_det").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_det").trigger("reloadGrid");
}

//detail grid click row => search matnr
function searchInspectionMatnr(key) {
	var page_url = "/frontend/hub/rinspection_matnr_select"
		 + "?inspection_gcode=" + key;
	$("#grid_itnbr").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_itnbr").trigger("reloadGrid");
}


// detail grid setting
function loadInspectionDetailItem() {
	var grid = $("#grid_mas");
	// check pordno
	var inspection_gcode = grid.jqGrid('getGridParam',"selrow");
	var page_url = "/frontend/hub/rinspection_detailItem_select"
				 + "?dept_cd=" + encodeURIComponent($('#sel_dept_cd').val()) 
 		 		 + "&inspection_gcode=" + encodeURIComponent(inspection_gcode);	
	
	$("#grid_det").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['검사코드','검사항목','검사기준', '최소값','최대값','검사방법','수정자', '생성일자', '수정일자'],
		colModel:[
			{name:'inspection_code',index:'inspection_code', width:70, sorttype:"text", sortable:true, key: true,hidden:true},
			{name:'inspection_list',index:'inspection_list', width:200,sorttype:"text", sortable:true},
			{name:'inspection_standard',index:'inspection_standard', width:200},
			{name:'inspection_value_low',index:'inspection_value_low', width:70, sorttype:"text", sortable:true},
			{name:'inspection_value_max',index:'inspection_value_max', width:70, sortable:true,},
			{name:'inspection_remark',index:'inspection_remark',width:200, sortable:true,},
			{name:'updater',index:'updater', width:90, sortable:true,hidden:true},
			{name:'date_created',index:'date_created', width:90,sortable:true,hidden:true},
			{name:'date_updated',index:'date_updated', width:90,sortable:true,hidden:true}
		],
		pager : "#grid_po_detail_pager",
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		viewrecords : true,
// 	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 275,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
// 	    loadonce: true,
	    sortable: true,
	    sortname: "Inspection_no",
		loadComplete : function() {
		},
		onSelectRow: function(key, selected) {
// 			console.log($("#grid_det").jqGrid('getInd',key) );
		}
	});
// 	$("#grid_det").jqGrid('sortableRows', {
// 		update: function( e, html ){ 
// 			console.log( html.item[0].id )}
// 	});
}

 
// add headrItem
function addInspectionHeaderItem() {
	var key = $("#grid_mas").getGridParam('selrow');
	$("#grid_item").jqGrid('clearGridData');
	if( key==null || key==undefined ){
		fnMessageModalAlert("확인하세요.", "등록하려는 상위 그룹정보가 선택된 항목이 없습니다.");
	} else {
		$('#modal_headerItem').modal('show');
	}
}

// delete detail master 
function deleteInspectionHeaderItem() {
	var groupkey = $("#grid_mas").getGridParam('selrow');
	var key = $("#grid_det").getGridParam('selrow');
	var gridData = $('#grid_det').jqGrid('getRowData');
	
	if( key==null || key==undefined ){
		fnMessageModalAlert("확인하세요.", "삭제 하려는 검사마스터 정보가 없습니다.");
	}else{
		fnMessageModalConfirm("확인하세요.", "이 데이터를 삭제합니다.\n 실행하시겠습니까?", function(chk){
			if( chk ){
				$.ajax({
				    url: "/frontend/hub/rinspection_detailItem_delete",
				    data: "inspection_gcode=" + encodeURIComponent(groupkey) + "&inspection_code=" + encodeURIComponent(key),
				    type: "POST",
				    success:function(data, textStatus, jqXHR){
				    	if(data.status == "200") {
					    	fnMessageModalAlert("Notification(Hub)", "검사정보가 정상적으로 삭제되었습니다.");
					    	searchInspectionHeader();
					    	searchInspectionDetail();
				    	}
				    },
				    error: function(jqXHR, textStatus, errorThrown){
					    	fnMessageModalAlert("Notification(Hub)", "정보를 처리하는데 에러가 발생하였습니다.");	
				    },
				    complete: function() {
				    }
				});
			}	
		});
	}
}

// itnbr product search
function searchItnbr() {
	var page_url = '/frontend/hub/material_recv_master_select'
		 		 + '?wrkst=' + encodeURIComponent($('#itnbr_search').val());
// 	console.log($('#itnbr_search').val());
// 	console.log(page_url);
	$("#grid_itnbr").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_itnbr").trigger("reloadGrid");
}

// INIT PRODUCT LIST grid
function loadInspectionItnbrAll() {
	var page_url = '/frontend/hub/material_recv_master_select';
	$('#grid_itnbr').jqGrid({
		url:page_url,
		datatype: 'json',
		colNames:['자재코드','자재내역',' Spec.', '생성일자', '수정일자'],//'제품군명', '자재그룹명', 
		colModel:[
			{name:'matnr',index:'matnr', width:100, sorttype:'text', sortable:true, key: true},
			{name:'maktx',index:'maktx', width:150, sorttype:'text', sortable:true},
			{name:'wrkst',index:'wrkst', width:150, sorttype:'text', sortable:true, sortable:true},
// 			{name:'vtext',index:'vtext', sorttype:'text', sortable:true, hidden:true},
// 			{name:'wgbez',index:'wgbez', sorttype:'text', sortable:true, hidden:true},
			{name:'date_created',index:'date_created', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'date_updated',index:'date_updated', width:40, sorttype:'text', sortable:true, sortable:true, hidden:true}
		],
		pager : '#grid_itnbr_pager',
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 613,
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
		loadComplete : function(data) {
// 			console.log(data);
		}
	});
}

// Inspection group mapping matrial
function addInspectionDetail() {
	var key = $("#grid_mas").getGridParam('selrow');
	if( key==null || key==undefined ){
		fnMessageModalAlert("확인하세요.", "등록하려는 상위 그룹정보가 선택된 항목이 없습니다.");
	} else {
		var groupInfo = $("#grid_mas").getRowData($("#grid_mas").getGridParam('selrow'));
		$('#inspection_gcode_itnbr').val(groupInfo.inspection_gcode);
		$('#inspection_gnm_itnbr').val(groupInfo.inspection_gnm);
		$('#dept_cd_itnbr').val(groupInfo.dept_cd);
		searchItnbrpopup();
		$("#grid_addItnbr_list").jqGrid('clearGridData');
		$('#modal_detail').modal('show');
	}
}

// delete itnbr from Inspection detail
function deleteInspectionDetail() { 
// 	console.log('deleteInspectionDetail()'); 
	
	var groupkey = $("#grid_mas").getGridParam('selrow');
	var key = $("#grid_itnbr").getGridParam('selrow');
	
	if( key==null || key==undefined ){
		fnMessageModalAlert("확인하세요.", "삭제 하려는 정보를 목록에서 선택하지 않았습니다.");
	} else {
		$.ajax({
		    url: "/frontend/hub/rinspection_matnr_delete",
		    data: "inspection_gcode=" + encodeURIComponent(groupkey) + "&matnr=" + encodeURIComponent(key),
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    	fnMessageModalAlert("Notification(Hub)", "자재매핑 리스트가 정상적으로 삭제되었습니다.");
			    	searchInspectionMatnr(groupkey);
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("Notification(Hub)", "정보를 처리하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    }
		});
	}
}

function searchMatnr() {
	$("#m_itnbr").val('');
	$("#m_itnbr_nm").val('');
	$('#modal_mat_search').modal('show')
}

function searchInspGroup() {
// 	console.log('searchInspGroup()');
	 
	if($("#m_itnbr").val()=='' && $("#m_itnbr_nm").val()=='' ) {
		fnMessageModalAlert("Warning", "자재코드 또는 자재명을 입력한 후 검색하시기 바랍니다.");
		return;
	} 
	w2ui.grid_search_group.clear();
	w2ui.grid_search_group.resize();
	w2ui.grid_search_group.refresh();
	$("#grid_search_group").show();
	
	var page_url = "/frontend/hub/insp_group_byItnbr_select"
				 + "?dept_cd=" + encodeURIComponent($("#m_dept_cd").val())
				 + "&matnr=" + encodeURIComponent($("#m_itnbr").val())
				 + "&maktx=" + encodeURIComponent($("#m_itnbr_nm").val());
 	var rowArr = [];
 	w2ui['grid_search_group'].lock('loading...', true);
	$.ajax({
	    url : page_url,
	    type : "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200" && (data.rows).length>0 ) {
	    		rowArr = data.rows;
	    		$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				w2ui['grid_search_group'].records = rowArr;
				w2ui['grid_search_group'].total = rowArr.length;
			}
			w2ui['grid_search_group'].refresh();
			w2ui['grid_search_group'].unlock();
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    fnMessageModalAlert("Error", "정보를 처리하는데 에러가 발생하였습니다.");	
	    }
	});
}

function initGroupSearchGrid() {
// 	console.log('initGroupSearchGrid()');
	$("#grid_search_group").w2grid({
		name : 'grid_search_group',
		show : {
			lineNumbers : true,
            footer: true
        },
		columns :[
	        { field:'dept_cd', caption:'사업부', size:'20%', sortable:true, style:'text-align:center',
	        	render:function(record, index, col_index){
	        		if( this.getCellValue(index, col_index)=='1110' ) return '의료영상';
	        		else if( this.getCellValue(index, col_index)=='1120' ) return '의료영상 서비스';
	        		else if( this.getCellValue(index, col_index)=='1210' ) return '광영상';
	        		else if( this.getCellValue(index, col_index)=='1220' ) return '광영상 서비스';
	        	}},
	        { field:'inspection_gcode', caption:'그룹코드', size:'20%', sortable:true, style:'text-align:center'},
	        { field:'inspection_gnm', caption:'그룹명', size:'20%', sortable:true},
	        { field:'matnr', caption:'자재코드', size:'20%', sortable:true, style:'text-align:center'},
	        { field:'maktx', caption:'자재명', size:'20%', sortable:true} ],
        sortData: [{field: 'dept_cd', direction: 'ASC'}, {field: 'routing_gno', direction: 'ASC'}],
		records: [],
		recordHeight : 30
	});
}
</script>
</body>
</html>