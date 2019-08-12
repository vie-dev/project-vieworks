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
		<jsp:param name="selected_menu_cd" value="1072" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        SCM관리
        <small>이동승인&처리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> SCM관리</a></li><li class="active">이동승인&처리</li>
      </ol>
    </section>

	<section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="box box-success box-solid">
						<div class="box-header with-border">
							<h3 class="box-title">조회조건</h3>
							<div class="box-tools pull-right">
								<button type="button" id="btn_search"
									class="btn btn-primary btn-sm" onclick="fnSearchReqMastGrid();">조회</button>	
								<button type="button" id="btn_search_init"
									class="btn btn-primary btn-sm">조건초기화</button>
							</div>
						</div>
						<div id="" class="box-body">
							<div class="row">
								<div class="col-sm-2">
									<div class="form-group">
										<label>| 요청내역일자</label>
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input type="text" class="form-control pull-right"
												id="req_date_range">
										</div>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group">
										<label>| 승인여부</label><br /> <label> <input type="radio"
											name="rdo_req_type" class="flat-red" value="" checked>
											전체 
										</label> <label> <input type="radio" name="rdo_req_type"
											class="flat-red" value="Y"> 승인
										</label> <label> <input type="radio" name="rdo_req_type"
											class="flat-red" value="N"> 미승인
										</label>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group">
										<label>| Plant 구분</label><br /> <label> <input type="radio"
											name="rdo_plant_type" class="flat-red" value="" checked>
											전체 
										</label> <label> <input type="radio" name="rdo_plant_type"
											class="flat-red" value="1110"> 의료
										</label> <label> <input type="radio" name="rdo_plant_type"
											class="flat-red" value="1210"> 광
										</label>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-4">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">요청 내역</h3>
								</div>
								<div id="dv_grid_req" class="box-body">
									<table id="grid_req"></table>
									<div id="grid_req_pager"></div>
								</div>
							</div>
						</div>
						<div class="col-md-8">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">요청 내역 상세 정보</h3>
									<div class="box-tools pull-right">
										<button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_req_sernr');" data-selfilepath="/upload" data-selfilename="test.xlsx">
									 		<span class="glyphicon glyphicon-download-alt" aria-hidden="true">시리얼관리대상</span>
										</button>
										<button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_req_bdmng');" data-selfilepath="/upload" data-selfilename="test.xlsx">
									 		<span class="glyphicon glyphicon-download-alt" aria-hidden="true">수량관리대상</span>
										</button> |
	               					   <label for="r_conf_date">요청승인일자</label>
						               <input type="input" id="r_conf_date" name="r_conf_date"  placeholder="" maxlength="10">
										<button type="button" id="btn_search" 	class="btn btn-primary btn-sm" onclick="fnConfReqMatr();">요청승인</button>
									</div>
								</div>
								<div id="dv_grid_req" class="box-body">
									<div class="col-md-6">
										<div id="dv_grid_req_sernr" class="box-body">
											<table id="grid_req_sernr"></table>
										</div>
									</div>
									<div class="col-md-6">
										<div id="dv_grid_req_bdmng" class="box-body">
											<table id="grid_req_bdmng"></table>
										</div>
									</div>
								</div>
							</div>
						</div>
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
<!-- ./wrapper -->
<script type="text/javascript">
var lastSel;

var selected_sernp;
var selected_mas_key;
var selected_sub_key;

$(function($) {
	fnLoadCommonOption();
	fnLoadReqMastGrid();
	fnLoadReqDet1Grid();
	fnLoadReqDet2Grid();
	$("#cb_"+$("#grid_req")[0].id).hide();		// grid_req 그리드 전체 체크박스 invisible 처리..  
})

// search component setting
function fnLoadCommonOption() {
	$(window).bind('resize', function() {
		resizeJqGrid("grid_req", false);
		resizeJqGrid("grid_req_sernr", false);
		resizeJqGrid("grid_req_bdmng", false);
	}).trigger('resize');
	
	$('#req_date_range').daterangepicker({
		 locale: {
			format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
			,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			,dayNames: ['일', '월', '화', '수', '목', '금', '토']
			,dayNames : ['일', '월', '화', '수', '목', '금', '토']
			,dayNamesShort : ['일', '월', '화', '수', '목', '금', '토']
			,dayNamesMin : ['일', '월', '화', '수', '목', '금', '토']
			,showMonthAfterYear: true
			,yearSuffix: '년'
			,orientation: "top left"
	    }
	});
	
	
	$("#r_conf_date").datepicker({
		language: "kr",
		todayHighlight: true,
		format: "yyyymmdd",
		autoclose: true
  	});
	
	$('#r_conf_date').val($.datepicker.formatDate('yymmdd', new Date()));
}
function fnLoadReqMastGrid(){
	var date1 = $("#req_date_range").val().substring(0,10);
	var date2 = $("#req_date_range").val().substring(13,23);
	
	$("#grid_req").jqGrid({
		datatype: "json",
		colNames:['승인','요청번호','플랜트', '출고플랜트','출고플랜트', '출고창고','출고창고', '입고플랜트','입고플랜트', '입고창고', '입고창고','요청자','요청일자'],
		colModel:[
			{name:'grantor_status',index:'grantor_status', width:15, sorttype:"text"},
	        {name:'reqm_matnr_key',index:'reqm_matnr_key', width:20, sorttype:"text"},
	        {name:'werks',index:'werks', width:20, sorttype:"text", hidden:true},
	        {name:'plant',index:'plant', width:20, sorttype:"text", hidden:true},
	        {name:'plant_nm',index:'plant_nm', width:20, sorttype:"text"},
	        {name:'stge_loc',index:'stge_loc', width:20, sorttype:"text", hidden:true},
	        {name:'stge_loc_nm',index:'stge_loc_nm', width:20, sorttype:"text"},
	        {name:'move_plant',index:'move_plant', width:20, sorttype:"text", hidden:true},
	        {name:'move_plant_nm',index:'move_plant_nm', width:20, sorttype:"text"},
	        {name:'move_stloc',index:'move_stloc', width:20, sorttype:"text", hidden:true},
	        {name:'move_stloc_nm',index:'move_stloc_nm', width:20, sorttype:"text"},
	        {name:'creator',index:'creator', width:20, sorttype:"text"},
	        {name:'creator_date',index:'creator_date', width:20, sorttype:"text"},
		],
		cmTemplate: {sortable: false},
		pager : "#grid_req_pager",
		rowNum:20,
		rowList : [ 20, 50, 100 ],
	    height: 455,
	    width:270,
	    rownumWidth: 25,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : true,
		altRows: true,
		rownumbers: true, 
	    autoencode: true,
	    loadonce: true,
	    sortable : true,
		sortname: 'reqm_matnr_key',
	    emptyrecords: "0 records found",
	    loadComplete : function(data){
	    	
	    },
		onSelectRow: function (rowId, status, e) {
	        if (rowId == lastSel) {
	            $(this).jqGrid("resetSelection");
	            lastSel = undefined;
	            status = false;
	        } else {
	            lastSel = rowId;
	        }
	        
			if(rowId != null) {
				
				selected_mas_key =  $(this).getCell(rowId, getColumnIndexByName($(this),"reqm_matnr_key"));
				var selected_grantor_status =  $(this).getCell(rowId, getColumnIndexByName($(this),"grantor_status"));

				if(selected_grantor_status == "N") {
					fnSearchReqDetGrid_N(selected_mas_key);	//미승인상태일때
				} else if(selected_grantor_status == "Y") {
					fnSearchReqDetGrid_Y(selected_mas_key);	//승인상태일때
				}
				
					
			}					
	    },
		beforeSelectRow: function (rowId, e) {
				$(this).jqGrid("resetSelection");
			    return true;
		}
	}); 
}



function fnSearchReqMastGrid(){

	$("#grid_req_sernr").jqGrid('clearGridData');
	$("#grid_req_bdmng").jqGrid('clearGridData');
	
	var date1 = $("#req_date_range").val().substring(0,10);
	var date2 = $("#req_date_range").val().substring(13,23);
 
	
	var page_url = "/frontend/hub/material_req_mas_select_1"
				 + "?from_req_date=" + encodeURIComponent(date1)
				 + "&to_req_date=" + encodeURIComponent(date2)
				 + "&grantor_status=" + encodeURIComponent($(':radio[name="rdo_req_type"]:checked').val())
				 + "&werks=" + encodeURIComponent($(':radio[name="rdo_plant_type"]:checked').val())
				 + "&pgm_nm=" + encodeURIComponent("SCM");
	
	$("#grid_req").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_req").trigger("reloadGrid");
}

//detail grid setting
function fnLoadReqDet1Grid() {
	
	$("#grid_req_sernr").jqGrid({
		datatype: "json",
		colNames:['요청번호','요청번호순번','reqd_matnr_key','자재번호','품목명','등급','요청수량', '시리얼번호', '단위', '요청자', '플랜트'],
		colModel:[
			{name:'reqm_matnr_key',index:'reqm_matnr_key'},
			{name:'reqm_sub_key',index:'reqm_sub_key', hidden:true},
			{name:'reqd_matnr_key',index:'reqd_matnr_key', hidden:true},
			{name:'matnr',index:'matnr'},
			{name:'maktx',index:'maktx'},
			{name:'grade_nm',index:'grade_nm', hidden:true},
			{name:'request_bdmng',index:'request_bdmng'},
			{name:'serial',index:'serial', editable:true},			//시리얼 관리 대상 땐 승인수량 데이터 받음;;;...
			{name:'meins',index:'meins', hidden:true},
			{name:'creator',index:'creator', hidden:true},
			{name:'werks',index:'werks', hidden:true},
		],
		cmTemplate: {sortable: false},
		rowNum:10000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : true,
	    height: 505,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    cellEdit:true,
	    cellsubmit : 'clientArray',
	    emptyrecords: "0 records found",
	    loadComplete : function() {
		},
		afterEditCell: function(id,name,val,iRow,iCol){
			  $("#"+iRow+"_"+name).bind('blur',function(){
				$('#grid_req_sernr').saveCell(iRow,iCol);
			  });
		}
	});
}

function fnLoadReqDet2Grid() {
	
	$("#grid_req_bdmng").jqGrid({
		datatype: "json",
		colNames:['요청번호','요청번호순번','reqd_matnr_key','자재번호','품목명','등급','요청수량', '승인수량', '단위', '요청자', '플랜트'],
		colModel:[
			{name:'reqm_matnr_key',index:'reqm_matnr_key'},
			{name:'reqm_sub_key',index:'reqm_sub_key', hidden:true},
			{name:'reqd_matnr_key',index:'reqd_matnr_key', hidden:true},
			{name:'matnr',index:'matnr'},
			{name:'maktx',index:'maktx'},
			{name:'grade_nm',index:'grade_nm', hidden:true},
			{name:'request_bdmng',index:'request_bdmng'},
			{name:'serial',index:'serial', editable:true},			//시리얼 관리 대상 땐 승인수량 데이터 받음;;;...
			{name:'meins',index:'meins', hidden:true},
			{name:'creator',index:'creator', hidden:true},
			{name:'werks',index:'werks', hidden:true},
		],
		cmTemplate: {sortable: false},
		rowNum:10000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : true,
	    height: 505,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    cellEdit:true,
	    cellsubmit : 'clientArray',
	    emptyrecords: "0 records found",
	    loadComplete : function() {
		},
		afterEditCell: function(id,name,val,iRow,iCol){
			  $("#"+iRow+"_"+name).bind('blur',function(){
				$('#grid_req_bdmng').saveCell(iRow,iCol);
			  });
		}
	});
}

function fnSearchReqDetGrid_Y(mas_key) {

	$('#grid_req_sernr').jqGrid('clearGridData');
	$('#grid_req_bdmng').jqGrid('clearGridData');
	
	var page_url_senr = "/frontend/hub/material_req_done_select"
	var page_url_bdmng = "/frontend/hub/material_req_det_select"
	var postData = "reqm_matnr_key=" + encodeURIComponent(mas_key);
	postData += "&matdoc_itm=" + encodeURIComponent("Y");
	postData += "&grantor_status=" + encodeURIComponent("Y");
	postData += "&sernp=" + encodeURIComponent("N");
	
	$.ajax({
		url : page_url_senr,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			
			var arrTmpObj = [];
			
			if(data.status == "200")
			{
				$('#grid_req_sernr').setColProp('serial', {editable:false});
				
				for(var i=0; i<data.rows.length; i++ ){
					// 시리얼 관리대상 승인 완료 데이터 조회
								var tmpObj = {};
								tmpObj.reqm_matnr_key = data.rows[i].reqm_matnr_key;
								tmpObj.reqm_sub_key = data.rows[i].reqm_sub_key;
								tmpObj.reqd_matnr_key = data.rows[i].reqd_matnr_key;
								tmpObj.matnr = data.rows[i].matnr;
								tmpObj.maktx = data.rows[i].maktx;
								tmpObj.grade_nm = data.rows[i].grade_nm;
								tmpObj.request_bdmng = "1.000"; 
								tmpObj.serial = data.rows[i].sernr;
	
								arrTmpObj.push(tmpObj);
								
				}
				
				$('#grid_req_sernr').jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj }).trigger('reloadGrid');
			} else
			{
				fnMessageModalAlert("Notification(HUB)",
				"요청처리를 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(HUB)",
			"요청처리를 실패했습니다.");
		},
		complete : function() {
		}
	});
	
	$.ajax({
		url : page_url_bdmng,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			
			var arrTmpObj_1 = [];
			
			if(data.status == "200")
			{
				$('#grid_req_bdmng').setColProp('serial', {editable:false});
				
				for(var i=0; i<data.rows.length; i++ ){
						//시리얼 비관리대상 승인 완료 데이터 조회
						$('#grid_req_bdmng').setColProp('serial', {editable:false});
						var tmpObj = {};
						tmpObj.reqm_matnr_key = data.rows[i].reqm_matnr_key;
						tmpObj.reqm_sub_key = data.rows[i].reqm_sub_key;
						tmpObj.reqd_matnr_key = data.rows[i].reqd_matnr_key;
						tmpObj.matnr = data.rows[i].matnr;
						tmpObj.maktx = data.rows[i].maktx;
						tmpObj.grade_nm = data.rows[i].grade_nm;
						tmpObj.request_bdmng = data.rows[i].request_bdmng; 
						tmpObj.serial = data.rows[i].confirm_bdmng;

						arrTmpObj_1.push(tmpObj);
								
				}
				
				$('#grid_req_bdmng').jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj_1 }).trigger('reloadGrid');	
			} else
			{
				fnMessageModalAlert("Notification(HUB)",
				"요청처리를 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(HUB)",
			"요청처리를 실패했습니다.");
		},
		complete : function() {
		}
	});
}

function fnSearchReqDetGrid_N(mas_key) {

	$('#grid_req_sernr').jqGrid('clearGridData');
	$('#grid_req_bdmng').jqGrid('clearGridData');
	
	var page_url = "/frontend/hub/material_req_det_select"
	
	var postData = "reqm_matnr_key=" + encodeURIComponent(mas_key)

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			
			var arrTmpObj = [];
			var arrTmpObj_1 = [];
			
			console.log(data.rows);	
			
			if(data.status == "200")
			{				
				for(var i=0; i<data.rows.length; i++ ){
				
					var request_bdmng = Number(data.rows[i].request_bdmng);
		
					// 승인 대기, 시리얼 관리대상 데이터 생성
					if(data.rows[i].sernp == "Y"){
						$('#grid_req_sernr').setColProp('serial', {editable:true});
						for(var j=0; j<request_bdmng; j++ ){
								var tmpObj = {};
								tmpObj.reqm_matnr_key = data.rows[i].reqm_matnr_key;
								tmpObj.reqm_sub_key = data.rows[i].reqm_sub_key;
								tmpObj.reqd_matnr_key = data.rows[i].reqd_matnr_key;
								tmpObj.matnr = data.rows[i].matnr;
								tmpObj.maktx = data.rows[i].maktx;
								tmpObj.grade_nm = data.rows[i].grade_nm;
								tmpObj.request_bdmng = "1.000"; 
								tmpObj.serial = "";
								tmpObj.meins = data.rows[i].meins;
								tmpObj.creator = data.rows[i].creator;
								tmpObj.werks = data.rows[i].werks;
								
								arrTmpObj.push(tmpObj);
						}
					} else {				
						// 승인 대기, 시리얼 비관리대상 데이터 생성
						$('#grid_req_bdmng').setColProp('serial', {editable:true});
						var tmpObj = {};
						tmpObj.reqm_matnr_key = data.rows[i].reqm_matnr_key;
						tmpObj.reqm_sub_key = data.rows[i].reqm_sub_key;
						tmpObj.reqd_matnr_key = data.rows[i].reqd_matnr_key;
						tmpObj.matnr = data.rows[i].matnr;
						tmpObj.maktx = data.rows[i].maktx;
						tmpObj.grade_nm = data.rows[i].grade_nm;
						tmpObj.request_bdmng = request_bdmng;
						tmpObj.confirm_bdmng = "";
						tmpObj.serial = "";
						tmpObj.meins = data.rows[i].meins;
						tmpObj.creator = data.rows[i].creator;
						tmpObj.werks = data.rows[i].werks;
						tmpObj.serial = data.rows[i].request_bdmng;
						arrTmpObj_1.push(tmpObj);
					}
				}
				$('#grid_req_sernr').jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj }).trigger('reloadGrid');	
				$('#grid_req_bdmng').jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj_1 }).trigger('reloadGrid');	
			} else
			{
				fnMessageModalAlert("Notification(HUB)",
				"요청처리를 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(HUB)",
			"요청처리를 실패했습니다.");
		},
		complete : function() {
		}			
	});
}

var getColumnIndexByName = function(grid,columnName) {
    var cm = grid.jqGrid('getGridParam','colModel');
    for (var i=0,l=cm.length; i<l; i++) {
        if (cm[i].name===columnName) {
            return i; // return the index
        }
    }
    return -1;
}

function fnConfReqMatr(){
	$("#grid_req_sernr").jqGrid('setGridParam', {cellEdit: false});
	$("#grid_req_bdmng").jqGrid('setGridParam', {cellEdit: false});
	
	var gridDataArr = $('#grid_req_sernr').jqGrid('getRowData');
	var keyArr = $('#grid_req_sernr').jqGrid('getDataIDs');
	
	var gridDataArr_1 = $('#grid_req_bdmng').jqGrid('getRowData');
	var keyArr_1 = $('#grid_req_bdmng').jqGrid('getDataIDs');
		
	$("#grid_req_sernr").jqGrid('setGridParam', {cellEdit: true});
	$("#grid_req_bdmng").jqGrid('setGridParam', {cellEdit: true});
	
	var params = [];
	for (var i = 0; i < keyArr.length; i++) { //row id수만큼 실행           
    	if($("input:checkbox[id='jqg_grid_req_sernr_"+keyArr[i]+"']").is(":checked")){ //checkbox checked 여부 판단
    		var rowdata = $("#grid_req_sernr").getRowData(keyArr[i]); // 해당 id의 row 데이터를 가져옴
    		if($("#grid_req_sernr").getRowData(keyArr[i]).serial.length >20)
    		{
   				fnMessageModalAlert("Notification(HUB)", "시리얼 입력이 제대로 되지 않았습니다. \n 입력 후 엔터를 쳐주세요");
    	 		return;
    		}
		    params.push(rowdata); //배열에 맵처럼 담김         
	    }
	}
	
	var params_1 = [];
	for (var i = 0; i < keyArr_1.length; i++) { //row id수만큼 실행           
    	if($("input:checkbox[id='jqg_grid_req_bdmng_"+keyArr_1[i]+"']").is(":checked")){ //checkbox checked 여부 판단
    		var rowdata = $("#grid_req_bdmng").getRowData(keyArr_1[i]); // 해당 id의 row 데이터를 가져옴
    		if($("#grid_req_bdmng").getRowData(keyArr_1[i]).serial.length >20)
    		{
   				fnMessageModalAlert("Notification(HUB)", "승인수량이 제대로 되지 않았습니다. \n 입력 후 엔터를 쳐주세요");
    	 		return;
    		}
		    params_1.push(rowdata); //배열에 맵처럼 담김         
	    }
	}
	
	/*********************그리드 체크여부 확인 : Start*********************/
	if(params.length == 0 && params_1.length == 0)
	{
		fnMessageModalAlert("Notification(HUB)", "체크 된 데이터가 없습니다.");
 		return;
	}
	/*********************그리드 체크여부 확인 : End*********************/
	
	var jsonStr = JSON.stringify(params);
	var jsonStr_1 = JSON.stringify(params_1);

	/*********************저장 전 상태체크 및 입력 시리얼 중복 체크 : Start*********************/
 	console.log("jsonStr ::: " + jsonStr);
 	console.log("jsonStr_1 ::: " + jsonStr_1);
 	
 	if(params.length != 0) {
 		var rawValidationChk_result = rawValidationChk(jsonStr);		
 		
 		if(rawValidationChk_result == false)
 		{
 			return;
 		}	
 	}
 		
	
 	if(params_1.length != 0) {
		var rawValidationChk_result_1 = confChk(jsonStr_1);				//수량만 넣는 실적이니깐 이전에 처리되었었는지만 체크
	 	
		if(rawValidationChk_result_1 == false)
		{
			return;
		}
 	}
	
	/*********************저장 전 상태체크 및 순차관리번호 중복 체크(시리얼 등록 대상만) : End*********************/

	/********************* 데이터 insert 및 rfc 전송 : Start*********************/
// 	if(selected_sernp == "Y") {
		var page_url = "/frontend/hub/req_confirm";
		var postData = 'reqm_matnr_key=' + encodeURIComponent(selected_mas_key)		
		postData += '&gridData=' + encodeURIComponent(jsonStr)
		postData += '&gridData_1=' + encodeURIComponent(jsonStr_1)
		postData += '&conf_date=' + encodeURIComponent($("#r_conf_date").val());
		
	
		
		$.ajax({
		    url: page_url,
		    data: postData,
		    type: "POST",
		    async : false,
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
		    		if(data.e_return == "S") {
		    			fnMessageModalAlert("Notification(HUB)", "정보를 저장하였습니다. <br/> *****sap 전송 결과***** <br/> e_return : " 
				    			+ data.e_return + "<br/>e_message : "+ data.e_message);	
		    		} else {
		    			fnMessageModalAlert("Notification(HUB)", "정보 저장에 실패했습니다. <br/> *****sap 전송 결과***** <br/> e_return : " 
				    			+ data.e_return + "<br/>e_message : "+ data.e_message);
		    		}
		    	} else {
		    		fnMessageModalAlert("Notification(HUB)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(HUB)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    	fnSearchReqMastGrid();
		    	fnSearchReqDetGrid_Y(selected_mas_key);
		    }
		});
		/********************* 데이터 insert 및 rfc 전송 : End*********************/
}

function rawValidationChk(jsonStr)
{		
	var rawValidationChk_result = null;
	var parsedJson = JSON.parse(jsonStr); 
	var raw_num_seqs = '';
	var Sernrs = '';

	var s_reqm_matnr_key = parsedJson[0].reqm_matnr_key;
	var s_reqm_sub_key =  parsedJson[0].reqm_sub_key;
	
	var arrSernr = [];
	var arrSernrTmp = [];
	
	for(var i=0;i<parsedJson.length;i++)
	{
		/*********************순차관리 입력 여부 체크 : Start*********************/
		if(parsedJson[i].serial == null || parsedJson[i].serial == '')
		{
			fnMessageModalAlert("Notification(StatusChk)", "시리얼을 입력해주십시오.");
			rawValidationChk_result = false;
			return rawValidationChk_result;
		}
		/*********************순차관리 입력 여부 체크 : End*********************/
		
		Sernrs += parsedJson[i].serial+ ',';
		arrSernr.push(parsedJson[i].serial);
	}
		
		
	/*********************순차관리 중복 입력 여부 체크 : Start*********************/
	$.each(arrSernr, function(i, el){
		if($.inArray(el, arrSernrTmp) === -1)
		{
			arrSernrTmp.push(el);
		} else {
			fnMessageModalAlert("Notification(StatusChk)", "시리얼 번호를 중복 입력했습니다.");
			rawValidationChk_result = false;
			return rawValidationChk_result;
		}
	});
	/*********************순차관리 중복 입력 여부 체크 : End*********************/		
	
		
	/*********************처리상태 체크 : Start*********************/

	var page_url = "/frontend/hub/req_status_chk";
		var postData = "reqm_matnr_key=" + encodeURIComponent(s_reqm_matnr_key);
		postData += "&reqm_sub_key=" + encodeURIComponent(s_reqm_sub_key);

		$.ajax({
			url : page_url,
			data : postData,
			async : false,
			type : "POST",
			success : function(data, textStatus, jqXHR) {
				if(data.status == "200")
				{
					var resultJson = JSON.parse(JSON.stringify(data));
					var result = resultJson.rows[0].grantor_status;
					if(result != 'N')
					{
						rawValidationChk_result = false;
						fnMessageModalAlert("Notification(HUB)", "이미 요청처리가 완료된 데이터 입니다.");
					}
				}else
				{
					rawValidationChk_result = false;	
					fnMessageModalAlert("Notification(HUB)", "요청처리를 실패했습니다.");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("Notification(HUB)", "요청처리를 실패했습니다.");
			},
			complete : function() {
			}			
		});
		if(rawValidationChk_result == false)
		{
			return rawValidationChk_result;
		}
	/*********************처리상태 체크 : End*********************/
}

function jqgridChkFormatter(cellvalue, options, rowObject) {
	if (cellvalue != null && cellvalue != "" && cellvalue == "Y") {	
		return '<i class="fa fa-check" aria-hidden="true"></i>';
	} else {
		return "";
	}
}

function jqgridConfFormatter(cellvalue, options, rowObject) {
	if (cellvalue != null && cellvalue != "" && cellvalue == "Y") {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">승인</span>';
	} else if (cellvalue != null && cellvalue != "" && cellvalue == "N") {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#8C8C8C\">미승인</span>';
	} else {
		return "";
	}
}

function confChk(jsonStr_1){
	
	var rawValidationChk_result = null;
	var parsedJson = JSON.parse(jsonStr_1); 

	var s_reqm_matnr_key = parsedJson[0].reqm_matnr_key;
	var s_reqm_sub_key =  parsedJson[0].reqm_sub_key;
	
	var rawValidationChk_result;
	
	var page_url = "/frontend/hub/req_status_chk";
	var postData = "reqm_matnr_key=" + encodeURIComponent(s_reqm_matnr_key);
	postData += "&reqm_sub_key=" + encodeURIComponent(s_reqm_sub_key);

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200")
			{
				var resultJson = JSON.parse(JSON.stringify(data));
				var result = resultJson.rows[0].grantor_status;

				if(result != 'N')
				{
					rawValidationChk_result = false;
					fnMessageModalAlert("Notification(HUB)", "이미 요청처리가 완료된 데이터 입니다.");
				} else {
					rawValidationChk_result = true;
				}
				
			}else
			{
				rawValidationChk_result = false;	
				fnMessageModalAlert("Notification(HUB)", "요청처리를 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			rawValidationChk_result = false;	
			fnMessageModalAlert("Notification(HUB)", "요청처리를 실패했습니다.");
		},
		complete : function() {
		}			
	});
	
		return rawValidationChk_result;
}

function excelFileDownload(gridName) {
// 	console.log('excelFileDownload('+gridName+')');
	var tmpArr = [];
	
	var getColNames;
	var getColModels; 
	
	if(gridName == 'grid_req_bdmng') {
		getColNames = $("#grid_req_bdmng").jqGrid('getGridParam','colNames');
		getColModels = $("#grid_req_bdmng").jqGrid('getGridParam','colModel');
	} else {
		getColNames = $("#grid_req_sernr").jqGrid('getGridParam','colNames');
		getColModels = $("#grid_req_sernr").jqGrid('getGridParam','colModel');
	}

	getColNames[1] = '';
	
	$.each(getColModels, function(idx, mrow){
		if( mrow.hidden==false && getColNames[idx]!='' ) {
			mrow.caption = getColNames[idx]; 
			tmpArr.push(mrow);  
		}
	});
	
	var gridCols = tmpArr;
	
	var gridData;
	if(gridName == 'grid_req_bdmng') {
		gridData = $("#grid_req_bdmng").getRowData();
	} else {
		gridData = $("#grid_req_sernr").getRowData();
	}
	
	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	if( gridName=='grid_req_bdmng' ) {
		fileName = '비시리얼관리대상_요청내역.xlsx';
		sheetTitle = '비시리얼관리대상_요청내역';
		sheetName = '비시리얼관리대상_요청내역';
	} else {
		fileName = '시리얼관리대상_요청내역.xlsx';
		sheetTitle = '시리얼관리대상_요청내역';
		sheetName = '시리얼관리대상_요청내역';
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