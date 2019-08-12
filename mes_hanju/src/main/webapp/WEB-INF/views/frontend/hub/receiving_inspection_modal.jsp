<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
// jsp properties
String thema = SessionUtil.getProperties("mes.thema");
String pageTitle = SessionUtil.getProperties("mes.company");
%>
<div class="modal fade" id="modal_mcode" data-backdrop="static">
<!-- 	<div class="modal-dialog modal-lg"> -->
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
				<h4 class="modal-title" id="modal_code_title">수입검사기준 정보 </h4>
        	</div>  
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routing" name="frm_routing" class="form-horizontal">
					<div class="row">
						<div class=" col-md-12">
							<div class="box">
								<div class="box-header with-border">
									<h3 class="box-title">품질특성 그룹 정보</h3>
								</div>
								<div class="box-body" style="padding-bottom: 0px;">
									<div class="form-group">
										<label for="inspection_gcode" class="col-sm-3 control-label">코드</label>
										<div class="col-sm-9">
											<input type="input" id="inspection_gcode" name="inspection_gcode" class="form-control input-sm" placeholder="auto" readonly="readonly">
										</div>
									</div>
									<div class="form-group" style="display:none;">
										<label for="inspection_gnm" class="col-sm-3 control-label">그룹명</label>
										<div class="col-sm-9">
											<input type="input" id="inspection_gnm" name="inspection_gnm" class="form-control input-sm" placeholder="">
										</div>
									</div>
									<div class="form-group">
										<label for="dept_cd" class="col-sm-3 control-label">사업부</label>
										<div class="col-sm-9">
											<select id="dept_cd" class="form-control select2 input-sm" style="width: 100%;">
												<option value="1110">의료영상</option>
												<option value="1210">광영상</option>
											</select>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class=" col-md-12">
							<div class="box">
								<div class="box-header with-border">
									<h3 class="box-title">특성그룹 정보</h3>
									<div class="box-tools pull-right">
						                <button type="button" id="btn_mcode_add" class="btn btn-danger btn-sm" onclick="appendGrid();">추가</button>
						                <button type="button" id="btn_mcode_info" class="btn btn-warning btn-sm" onclick="deleteGridData();">삭제</button>
									</div>
								</div>
								<div id="dv_grid" class="box-body">
									<table id="grid"></table>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_group_save" class="btn btn-sm btn-success" onclick="saveInspectionHeader();">저장</button>
					<button type="button" id="btn_group_cancel" class="btn btn-sm btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modal_headerItem" data-backdrop="static">
	<div class="modal-dialog modal-bg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">검사기준 상세 정보 </h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingDetail" name="frm_routingDetail" class="form-horizontal">
							<div class="box-tools pull-right">
				                <button type="button" id="" class="btn btn-danger btn-sm" onclick="insertHeaderItem();">추가</button>
				                <button type="button" id="" class="btn btn-warning btn-sm" onclick="deleteHeaderItem();">삭제</button>
							</div>
					<div class="row">
						<div class=" col-md-12">
							<div id="dv_grid_item" class="box-body">
								<table id="grid_item"></table>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_detail_save" class="btn btn-sm btn-success" onclick="saveInspectionHeaderItem();">저장</button>
					<button type="button" id="btn_detail_cancel" class="btn btn-sm btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modal_detail" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
				<h4 class="modal-title" id="modal_code_title">수입검사 특성 Master</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class=" col-md-12">
							<div class="box">
								<div class="box-header with-border">
									<h3 class="box-title">검사마스터 그룹 정보</h3>
								</div>
								<div class="box-body" style="padding-bottom: 0px;">
									<div class="form-group">
										<label for="inspection_gcode_itnbr" class="col-sm-3 control-label">그룹코드</label>
										<div class="col-sm-9">
											<input type="input" id="inspection_gcode_itnbr" name="inspection_gcode" class="form-control input-sm" placeholder="auto" readonly>
										</div>
									</div>
									<div class="form-group">
										<label for="inspection_gnm_itnbr" class="col-sm-3 control-label">그룹명</label>
										<div class="col-sm-9">
											<input type="input" id="inspection_gnm_itnbr" name="inspection_gnm" class="form-control input-sm" placeholder="" readonly>
										</div>
									</div>
									<div class="form-group">
										<label for="inspection_gnm" class="col-sm-3 control-label">사업부코드</label>
										<div class="col-sm-9">
											<select id="dept_cd_itnbr" class="form-control select2 input-sm" style="width: 100%;" disabled>
												<option value="1110">의료</option>
												<option value="1210">광</option>
											</select>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class=" col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">제품 목록</h3>
									<div class="box-tools pull-right">
										<div class="input-group input-group-sm" style="width: 150px;float: left;">
						                  <input type="text" id="itnbr_search_popup" name="itnbr_search" class="form-control pull-right" placeholder="matnr. Search">
											<div class="input-group-btn">
						                    <button type="button" id="btn_itnbr_search_popup" class="btn btn-default" onclick="searchItnbrpopup();"><i class="fa fa-search"></i></button>
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
									<h3 class="box-title">추가 제품 목록</h3>
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
					<button type="button" id="btn_mas_save" class="btn btn-sm btn-success" onclick="saveInspectionDetail();">저장</button>
					<button type="button" id="btn_mas_cancel" class="btn btn-sm btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- ./wrapper -->
<script type="text/javascript">
var selectData = [];

$(function($) {
	$("#grid").jqGrid('clearGridData');
	$("#grid_item").jqGrid('clearGridData');
	$("#grid_itnbrlist").jqGrid('clearGridData');
	$("#grid_addItnbr_list").jqGrid('clearGridData');
	selectData = [];
	initHeaderGrid();
	initHeaderItemGrid();
	initItnbrGrid();
	initNewItnbrGrid();
	
	$( ".modal_headerItem" ).dialog({ 
		height: 300,
		width: 1000
	});
	
	initScreenSizeModal();
})
 
function initHeaderGrid() {
	$("#grid").jqGrid({
		url : '',
		datatype: "json",
		colNames:['코드','그룹명'],
		colModel:[
	        {name:'inspection_gcode',index:'inspection_gcode', width:50,hidden:true,editable:false},
	        {name:'inspection_gnm',index:'inspection_gnm', width:200,editable:true}
		],
		rowNum:100,
	    height: 300,
	    viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : true,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    sortable: true,
	    cellEdit:true,
	    loadComplete : function(data){},
		onSelectRow: function(key, selected) {
// 			var sel_id = $("#grid").getGridParam('selrow');
// 			var index = $("#grid").jqGrid('getInd',sel_id); // counting from 1
// 			selectKey = index;
			selectData.push($("#grid").getGridParam('selrow'));
			jQuery.unique(selectData);
		}
	}); 
}

function initHeaderItemGrid() {
	$("#grid_item").jqGrid({
		url : '',
		datatype: "json",
		colNames:['검사항목','검사기준','최대값','최소값','검사방법'],
		colModel:[   //inspection_gcode 수입검사 기준 그룹 마스터 코드, inspection_code 수입검사 항목 key  
	        {name:'inspection_list',width:300,index:'inspection_list', editable:true},
	        {name:'inspection_standard',width:500,index:'inspection_standard', editable:true},
	        {name:'inspection_value_max',width:100,index:'inspection_value_max', editable:true},
	        {name:'inspection_value_low',width:100,index:'inspection_value_low', editable:true},
	        {name:'inspection_remark_code',width:500,index:'inspection_remark_code', editable:true,edittype:"select",
                editoptions: {
                  value:"RI1:육안검사 ;RI2:길이측정(V/C);RI3:길이측정(줄자);RI4:깊이측정(V/C);RI5:두께측정(V/C);RI6:크기측정(V/C);RI7:LAN Tester;RI8:멀티미터;RI9:검사 JIG;RI10:X-ray검사장비;RI11:Height Gauge" } }
			],
		rowNum:100,
	    height: 100,
	    viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : true,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    sortable: true,
	    cellEdit:true,
	    loadComplete : function(data){},
		onSelectRow: function(key, selected) {
// 			var sel_id = $("#grid").getGridParam('selrow');
// 			var index = $("#grid").jqGrid('getInd',sel_id); // counting from 1
// 			selectKey = index;
			selectData.push($("#grid").getGridParam('selrow'));
			jQuery.unique(selectData);
		}
	}); 
}

function appendGrid() {
// 	var dataArr = $("#grid").jqGrid('getDataIDs');
// 	var key = seqNumber(dataArr.length);
	$("#grid").jqGrid('addRow',{position  :"last", initdata  : {'inspection_gnm':'' }});
}

function deleteGridData() {
	var selrows = $('#grid').jqGrid('getGridParam', 'selarrrow');
	while (selrows.length > 0){
	  $('#grid').delRowData(selrows[0]);
	}
}

function saveInspectionHeader() {
	$("#btn_group_save").prop("disabled", true);
	$("#btn_group_cancel").prop("disabled", true);
	var groupNm = $('#inspection_gnm').val();
	var deptCd = $('#dept_cd').val();
	var gridDataArr = $('#grid').jqGrid('getRowData');
	var keyArr = $('#grid').jqGrid('getDataIDs');
	var jsonObjArr = [];
	if( gridDataArr.length==0 ) {
		fnMessageModalAlert("Notification(Hub)", "공정 정보를 1개이상 추가 하여야 합니다.");
	} else {
		for(var idx=0; idx<gridDataArr.length; idx++){
			var tmpJson = {};
			for(key in gridDataArr[idx]){
				tmpJson[key] = $('#'+keyArr[idx]+'_'+key).val(); 
			}
			jsonObjArr.push(tmpJson);
		}
	}
	 
	var jsonStr = JSON.stringify(jsonObjArr);
	var page_url = "/frontend/hub/rinspection_header_insert"
	var postData  = '&dept_cd='+encodeURIComponent(deptCd);
	    postData += "&gridData=" + encodeURIComponent(jsonStr);
 
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		fnMessageModalConfirm("Notification(Hub)", "정보를 저장하였습니다.", function(chk){
	    			if(chk){
	    				searchInspectionHeader();
	    				$('.close').click();		
	    			}
	    		});
	    	} else {
	    		fnMessageModalAlert("Notification(Hub)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    	$("#btn_group_save").prop("disabled", false);
	    	$("#btn_group_cancel").prop("disabled", false);
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(Hub)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    }
	});
}
 

function insertHeaderItem() {
	$("#grid_item").jqGrid('addRow',{position  :"last", initdata  :  {'inspection_list':'','inspection_standard':'','inspection_value_max':'','inspection_value_low':'','inspection_remark_code':'' }});
 }

function deleteHeaderItem() {
	var selrows = $('#grid_item').jqGrid('getGridParam', 'selarrrow');
	while (selrows.length > 0){
	  $('#grid_item').delRowData(selrows[0]);
	}
}

function saveInspectionHeaderItem() {
	$("#btn_detail_save").prop("disabled", true);
	$("#btn_detail_cancel").prop("disabled", true);
	var groupInfo = $("#grid_mas").getRowData($("#grid_mas").getGridParam('selrow'));
	var gridDataArr = $('#grid_item').jqGrid('getRowData');
	var keyArr = $('#grid_item').jqGrid('getDataIDs');
	var jsonObjArr = [];
	if( gridDataArr.length==0 ) {
 
	} else {
		for(var idx=0; idx<gridDataArr.length; idx++){
			var tmpJson = {};
			for(key in gridDataArr[idx]){
				tmpJson[key] = $('#'+keyArr[idx]+'_'+key).val(); 
			}
			jsonObjArr.push(tmpJson);
		}
		var jsonStr = JSON.stringify(jsonObjArr);
		var page_url = "/frontend/hub/rinpsection_detailItem_insert"
		var postData = 'inspection_gcode=' + encodeURIComponent(groupInfo.inspection_gcode)
					 + '&inspection_gnm=' + encodeURIComponent(groupInfo.inspection_gnm)
					 + '&dept_cd='+encodeURIComponent(groupInfo.dept_cd)
					 + '&date_created='+encodeURIComponent(groupInfo.date_created)
					 + '&gridData=' + encodeURIComponent(jsonStr);
		
		$.ajax({
		    url: page_url,
		    data: postData,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
		    		fnMessageModalConfirm("Notification(Hub)", "정보를 저장하였습니다.", function(chk){
		    			if(chk){
		    				searchInspectionDetail(groupInfo.inspection_gcode)
		    				$('.close').click();		
		    			}
		    		});
		    	} else {
		    		fnMessageModalAlert("Notification(Hub)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    	}
		    	$("#btn_detail_save").prop("disabled", false);
		    	$("#btn_detail_cancel").prop("disabled", false);
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(Hub)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    }
		});
	}
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

// search itnbr list
function searchItnbrpopup(){
	var page_url = '/frontend/hub/material_recv_master_select'
				 + '?matnr=' + encodeURIComponent($('#itnbr_search_popup').val()) ;
	    //         + "&mtartList= FERT,HALB,ZRMA"  ;
 
	$("#grid_itnbrlist").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_itnbrlist").trigger("reloadGrid");
}

var dataArr = [];
//itnbr move to newlist
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

// saveInspectionDetail
function saveInspectionDetail() {
// 	console.log('saveInspectionDetail()');
	$("#btn_mas_save").prop("disabled", true);
	$("#btn_mas_cancel").prop("disabled", true);
	var deptcd = $('#dept_cd').val();
	var groupInfo = $("#grid_mas").getRowData($("#grid_mas").getGridParam('selrow'));
	var gridDataArr = $('#grid_addItnbr_list').jqGrid('getRowData');
	var keyArr = $('#grid_addItnbr_list').jqGrid('getDataIDs');
	if( gridDataArr.length==0 ) {
// 		fnMessageModalAlert("Notification(Hub)", "공정 정보를 1개이상 추가 하여야 합니다.");
	} else {
// 		for(var idx=0; idx<gridDataArr.length; idx++){
		var jsonStr = JSON.stringify(gridDataArr);
		var page_url = "/frontend/hub/inspection_matnr_insert"
		var postData = 'inspection_gcode=' + encodeURIComponent(groupInfo.inspection_gcode)
					 + '&inspection_gnm=' + encodeURIComponent(groupInfo.inspection_gnm)
					 + '&dept_cd=' + encodeURIComponent(deptcd)
					 + '&gridData=' + encodeURIComponent(jsonStr);
		
		$.ajax({
		    url: page_url,
		    data: postData,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
		    		fnMessageModalConfirm("Notification(Hub)", "정보를 저장하였습니다.", function(chk){
		    			if(chk){
						//	searchRoutingDetail(groupInfo.inspection_gcode);
							searchInspectionMatnr(groupInfo.inspection_gcode);
		    				$('.close').click();
		    			}
		    		});
		    	} else {
		    		fnMessageModalAlert("Notification(Hub)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    	}
		    	$("#btn_mas_save").prop("disabled", false);
		    	$("#btn_mas_cancel").prop("disabled", false);
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(Hub)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    }
		});
	}
}
</script>
