<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!--  modal area1 -->
<div class="modal fade" id="modal_conf" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">제품선택 ( 제품을 선택한 뒤 확인 버튼을 눌러주세요. )</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class="col-md-12">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">요청 내역 상세 정보</h3>
									<div class="box-tools pull-right">
	               					   <label for="r_conf_date_1">요청처리일자</label>
						               <input type="input" id="r_conf_date_1" name="r_conf_date_1"  placeholder="" maxlength="10">
										<button type="button" id="btn_search" 	class="btn btn-primary btn-sm" onclick="fnConfReqMatr();">요청처리</button>
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
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-default" onclick="modal_conf_close();">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">

var selc_id;
var selected_sernp;
var selected_mas_key;
var selected_sub_key;

$(function($) {
	
	fnLoadReqDet1Grid();
	fnLoadReqDet2Grid();
	
	$(window).bind('resize', function() {
		resizeJqGrid("grid_req_sernr", false, false);
		resizeJqGrid("grid_req_bdmng", false, false);
	}).trigger('resize');
	initScreenSizeModal();
	$("#r_conf_date_1").datepicker({
		language: "kr",
		todayHighlight: true,
		format: "yyyymmdd",
		autoclose: true
  	});
	
	$('#r_conf_date_1').val($.datepicker.formatDate('yymmdd', new Date()));
})

function fnSearchConditionInit() {
 	resizeJqGrid("grid_req_sernr", false);
	resizeJqGrid("grid_req_bdmng", false);
} 
	
function fnLoadReqDet1Grid() {
	
	$("#grid_req_sernr").jqGrid({
		datatype: "json",
		colNames:['요청번호','요청번호순번','reqd_matnr_key','자재번호','등급','요청수량', '시리얼번호', '단위', '요청자', '플랜트'],
		colModel:[
			{name:'reqm_matnr_key',index:'reqm_matnr_key'},
			{name:'reqm_sub_key',index:'reqm_sub_key', hidden:true},
			{name:'reqd_matnr_key',index:'reqd_matnr_key', hidden:true},
			{name:'matnr',index:'matnr'},
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
		colNames:['요청번호','요청번호순번','reqd_matnr_key','자재번호','등급','요청수량', '승인수량', '단위', '요청자', '플랜트'],
		colModel:[
			{name:'reqm_matnr_key',index:'reqm_matnr_key'},
			{name:'reqm_sub_key',index:'reqm_sub_key', hidden:true},
			{name:'reqd_matnr_key',index:'reqd_matnr_key', hidden:true},
			{name:'matnr',index:'matnr'},
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

function fnSearchReqDetGrid_f2(mas_key, rowid) {
	
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
			

		
		
			if(data.status == "200")
			{				
				for(var i=0; i<data.rows.length; i++ ){
				
					var request_bdmng = Number(data.rows[i].request_bdmng);
					
					// 승인 대기, 시리얼 관리대상 데이터 생성
					if(data.rows[i].sernp == "Y"){
						$('#grid_req_sernr').setColProp('serial', {editable:true});
						for(var j=0; j<request_bdmng; j++ ){
								var tmpObj = {};
								console.log(data.rows[i]);
								tmpObj.reqm_matnr_key = data.rows[i].reqm_matnr_key;
								tmpObj.reqm_sub_key = data.rows[i].reqm_sub_key;
								tmpObj.reqd_matnr_key = data.rows[i].reqd_matnr_key;
								tmpObj.matnr = data.rows[i].matnr;
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
	fnMessageModalConfirm("Notification", "선택 요청을 처리하시겠습니까?", function(chk){
		if(chk){
			confReqMatr();
		}
	});
}

function confReqMatr(){
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
		var m_key = $('#grid_reg').jqGrid('getGridParam', 'selrow');
		var m_reqm_matnr_key = $("#grid_reg").getRowData(m_key).reqm_matnr_key;

		var page_url = "/frontend/hub/req_confirm";
		var postData = 'reqm_matnr_key=' + encodeURIComponent(m_reqm_matnr_key);
		postData += '&gridData=' + encodeURIComponent(jsonStr);
		postData += '&gridData_1=' + encodeURIComponent(jsonStr_1);
		postData += '&conf_date=' + encodeURIComponent($("#r_conf_date_1").val());
		
	
		
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
		    }
		});
		/********************* 데이터 insert 및 rfc 전송 : End*********************/
		
		fnSearchRegListGrid();
		$("#modal_conf").modal('hide');
		
		/********************* 데이터 insert 및 rfc 전송 : End*********************/
}

function modal_conf_close() {
	$("#modal_conf").modal('hide');
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
</script>