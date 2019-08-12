<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!--  modal area1 -->
<div class="modal fade" id="modal_detail" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">제품선택 ( 제품을 선택한 뒤 확인 버튼을 눌러주세요. ) </h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class="col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">자재 목록</h3>
									<div class="box-tools pull-right">
										<button type="button" id="" class="btn btn-sm btn-primary" onclick="fnSearchItnbrGrid();">조회</button> |
										<button type="button" id="" class="btn btn-warning btn-sm" onclick="addItnbrDetail();">
								              <i class="fa fa-forward" aria-hidden="true"></i>
								        </button>
									</div>
								</div>
								<div class="box-body">
									<div class="form-group">
										<label for="" class="col-sm-3 control-label">자재번호</label>
										<div class="col-sm-7">
											<input type="input" id="s_matnr" name="s_matnr" class="form-control input-sm" placeholder="">
										</div>
									</div>
									<div class="form-group">
										<label for="" class="col-sm-3 control-label">플랜트</label>
										<div class="col-sm-7">
											<select id="s_werks_req" class="form-control select2 input-sm" data-placeholder="유형 선택" style="width: 100%;">
												<option value="">전체</option>
												<option value="1110">의료</option>
												<option value="1210">광</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label for="" class="col-sm-3 control-label">창고</label>
										<div class="col-sm-7">
											<select id="s_str_inq" class="form-control select2 input-sm" data-placeholder="유형 선택" style="width: 100%;">
											</select>
										</div>
									</div>
								</div>
								<div id="dv_grid_itnbrlist" class="box-body">
									<table id="grid_itnbrlist"></table>
									<div id="grid_itnbrlist_pager"></div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">이동.타출 요청 자재</h3>
									<div class="box-tools pull-right">
										<button type="button" id="" class="btn btn-warning btn-sm" onclick="deleteItnbrDetail();">
											<i class="fa fa-backward" aria-hidden="true"></i></button>
									</div>
								</div>
								<div class="box-body">
									<div class="form-group" style="display:none;">
										<label for="" class="col-sm-5 control-label">플랜트</label>
										<div class="col-sm-7">
											<select id="s_plnt" class="form-control select2 input-sm" data-placeholder="유형 선택" style="width: 100%;">
												<option value="1110">의료</option>
												<option value="1210">광</option>
											</select>
										</div>
									</div>
									<div class="form-group" style="display:none;">
										<label for="" class="col-sm-5 control-label">창고</label>
										<div class="col-sm-7">
											<select id="s_str" class="form-control select2 input-sm" data-placeholder="유형 선택" style="width: 100%;">
											</select>
										</div>
									</div>
									<div class="form-group">
										<label for="" class="col-sm-5 control-label">이동유형</label>
										<div class="col-sm-7">
											<select id="s_move_type" class="form-control select2 input-sm" data-placeholder="유형 선택" style="width: 100%;">
												<option value="">-</option>
											</select>
										</div>
									</div>										
									<div class="form-group">
										<label for="" class="col-sm-5 control-label">코스트센터</label>
										<div class="col-sm-7">
											<select id="s_cc" class="form-control select2 input-sm" data-placeholder="유형 선택" style="width: 100%;">
												<option value="">-</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label for="" class="col-sm-5 control-label">I/O</label>
										<div class="col-sm-7">
											<select id="s_io" class="form-control select2 input-sm" data-placeholder="유형 선택" style="width: 100%;">
												<option value="">-</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label for="" class="col-sm-5 control-label">전표헤더텍스트(RMA번호)</label>
										<div class="col-sm-7">
											<input type="input" id="s_header_txt" name="s_header_txt" class="form-control input-sm" placeholder="">
										</div>
									</div>
									<div class="form-group">
										<label for="" class="col-sm-5 control-label">요청일자</label>
										<div class="col-sm-7">
											<input type="input" id="r_conf_date" name="r_conf_date" class="form-control input-sm" maxlength="10">
										</div>
									</div>
									<div class="form-group">
										<label for="" class="col-sm-5 control-label">특별재고구분</label>
										<div class="col-sm-7">
											<input type="input" id="r_spec_stock" name="r_spec_stock" class="form-control input-sm" maxlength="10">
										</div>
									</div>
									<div class="form-group">
										<label for="" class="col-sm-5 control-label">즉시처리구분</label>
										<div class="col-sm-7">
											<input type="radio"	id="t_gubun_1" name="t_gubun"  value=""  checked> 승인  단계 있음&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                                    	<input type="radio"  id="t_gubun_2" name="t_gubun"  value="Y"> 승인 단계 없음
										</div>
									</div>
									<div id="dv_grid_addItnbr_list">
										<table id="grid_addItnbr_list"></table>
									</div>
								</div>
							</div>
						</div>
					</div><!-- end row -->
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-sm btn-success" onclick="confirmReqeust();">요청</button>
					<button type="button" id="" class="btn btn-sm btn-default" onclick="modal_detail_close();">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

var lastSel;
var dataArr = [];

$(function($) {
	$("#grid_itnbrlist").jqGrid('clearGridData');
	initItnbrGrid();
	initNewItnbrGrid();
	$("#cb_"+$("#grid_itnbrlist")[0].id).hide();		// grid_itnbrlist 그리드 전체 체크박스 invisible 처리..

// 	getStrList();
	getMoveTypeList();
	getStrInqList();
// 	getIoTypeList();
// 	getCostTypeList();
	
// 	$('#s_plnt').change(function(){
// 		getStrList();
// 	});
	
	$('#s_werks_req').change(function(){

		getStrInqList();
	});
	
	$('#s_move_type').change(function(){
		initOptions($('#s_cc'));
		initOptions($('#s_io'));
		
		var bwart = $('#s_move_type').val().split('/')[0];
		var kostl = $('#s_move_type').val().split('/')[1];
		var aufnr = $('#s_move_type').val().split('/')[2];
		console.log($('#s_move_type').val());

		if(bwart == "931") {
			$("#t_gubun_1").prop("checked", false);
			$("#t_gubun_2").prop("checked", true);
		} else {
			$("#t_gubun_1").prop("checked", true);
			$("#t_gubun_2").prop("checked", false);
		}
		
		if(kostl == "Y") {
			getCostTypeList();
		} else {
			initOptions($('#s_cc'));			
		}
		
		if(aufnr == "Y") {
			getIoTypeList();
		} else {
			initOptions($('#s_io'));			
		}
	});
	
	$("#r_conf_date").datepicker({
		language: "kr",
		todayHighlight: true,
		format: "yyyymmdd",
		autoclose: true
  	});
	
	$('#r_conf_date').val($.datepicker.formatDate('yymmdd', new Date()));
	
	initScreenSizeModal();
})



function fnSearchItnbrGrid() {
	var s_matnr = $('#s_matnr').val();
	var s_werks_req = $('#s_werks_req').val();
	var s_lgort = $('#s_str_inq').val();

	var page_url = "/frontend/scm/str_stock_select"
		 + "?matnr=" + encodeURIComponent(s_matnr)
		 + "&werks=" + encodeURIComponent(s_werks_req)
		 + "&lgort=" + encodeURIComponent(s_lgort)
	
	$("#grid_itnbrlist").jqGrid('setGridParam', { url : page_url, datatype : 'json' });
	$("#grid_itnbrlist").trigger("reloadGrid");
}

function initItnbrGrid() {

	var page_url = "/frontend/scm/str_stock_select";

	$('#grid_itnbrlist').jqGrid({
		url:page_url,
		datatype: 'json',
		colNames:['자재','werks','플랜트','lgort','창고','단위', '시리얼관리여부'],
		colModel:[
			{name:'matnr',index:'matnr', width:120, sorttype:'text', sortable:true},
			{name:'werks',index:'werks', width:70, sorttype:'text', sortable:true, hidden:true},
			{name:'werks_nm',index:'werks_nm', width:50, sorttype:'text', sortable:true},
			{name:'lgort',index:'lgort', width:130, sorttype:'text', sortable:true, hidden:true},
			{name:'lgort_nm',index:'lgort_nm', width:110, sorttype:'text', sortable:true},
			{name:'meins',index:'meins', width:50, sorttype:'text', sortable:true},
			{name:'sernp',index:'sernp', width:70, sorttype:'text', sortable:true, hidden:false}
		],
		pager : '#grid_itnbrlist_pager',
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 430,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
// 	    sortable: true,
// 	    sortname: 'matnr',
		loadComplete : function() {
		}
	});
}

function initNewItnbrGrid() {
	$('#grid_addItnbr_list').jqGrid({
		url:'',
		datatype: 'json',
		colNames:['자재','werks','플랜트','요청수량', '단위', '시리얼관리대상여부', '품목텍스트', '창고'],
		colModel:[	
			{name:'matnr',index:'matnr', width:100, sorttype:'text', sortable:true, key:true},
			{name:'werks',index:'werks', width:60, sorttype:'text', sortable:true, hidden:true},
			{name:'werks_nm',index:'werks_nm', width:60, sorttype:'text', sortable:true},
			{name:'request_bdmng',index:'request_bdmng', width:70, sorttype:'text', sortable:true, editable:true},			
			{name:'meins',index:'meins', width:70, sorttype:'text', sortable:true, hidden:true},
			{name:'sernp',index:'sernp', width:70, sorttype:'text', sortable:true, hidden:false},
			{name:'item_text',index:'item_text', width:160, sorttype:'text', sortable:true, editable:true},
			{name:'lgort',index:'lgort', width:160, sorttype:'text', sortable:true},
		],
		rowNum: 10000,
		viewrecords : true,
// 	    autowidth : true,
	    shrinkToFit: false, 
	    multiselect : false,
	    height: 280,
	    width : 420,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    sortable: true,
	    cellEdit:true,
	    cellsubmit : 'clientArray',
	    sortname: 'matnr',
	    onCellSelect: function() {
		},
		loadComplete : function() {}
	});
}

function modal_detail_open(){
	$("#modal_detail").modal('show');
}



function modal_detail_close(){
	$('#grid_addItnbr_list').jqGrid('clearGridData');
	$("#modal_detail").modal('hide');
}

function confirmReqeust(){
	console.log($('#r_conf_date').val());
	if($('#r_conf_date').val() == '') {
		fnMessageModalAlert("Notification(SCM)", "요청일자를 선택해주세요.");
		return;
	}
	
	fnMessageModalConfirm("Notification", "타출 요청을 진행하시겠습니까?", function(chk){
		if(chk){
			fn_confirmReqeust();
		}
	});
}
function fn_confirmReqeust(){

	
	if($('#s_move_type').val().split('/')[0] == '-' ||$('#s_move_type').val().split('/')[0] == '') {
		fnMessageModalAlert("Notification(SCM)", "이동유형을 선택해주세요.");
		return;
	}
	/*********************요청 그리드 data 처리 : Start*********************/
	
	var gridDataArr = $('#grid_addItnbr_list').jqGrid('getRowData');
	
	if( gridDataArr.length==0 ) {
		fnMessageModalAlert("Notification(SCM)", "타출 대상 자재를 오른쪽 그리드로 옮겨주세요.");
		return;
	} 
	///////////////////////////////////////////////
	
	var  plnt_arr = [];
	var  str_arr = [];
	
	for(var i=0; i<gridDataArr.length ; i++) {
		plnt_arr.push(gridDataArr[i].werks);
		str_arr.push(gridDataArr[i].lgort);
	}
	
	var uniquePlnt = [];
	var uniqueStr = [];

	$.each(plnt_arr, function(i, el){
		if($.inArray(el, uniquePlnt) === -1) uniquePlnt.push(el);
	});
	
	$.each(str_arr, function(i, el){
		if($.inArray(el, uniqueStr) === -1) uniqueStr.push(el);
	});
	
	if(uniquePlnt.length != 1) {
		fnMessageModalAlert("Notification(SCM)", "요청 내역의 플랜트항목은 의료/광 중 한 항목으로 통일시켜 처리해야합니다.");
		return;
	}
	
	if(uniqueStr.length != 1) {
		fnMessageModalAlert("Notification(SCM)", "요청 내역의 창고항목이 통일되지않았습니다.<br>타출요청은 동일창고 내 자재 처리만 가능합니다.");
		return;
	}
	///////////////////////////////////////////////
	var keyArr = $('#grid_addItnbr_list').jqGrid('getDataIDs');
	var jsonObjArr = [];


	for(var idx=0; idx<gridDataArr.length; idx++){
		var tmpJson = {};
		
// 		tmpJson["plant"] = $('#s_plnt').val();
// 		tmpJson["stge_loc"] = $('#s_str').val();

		tmpJson["plant"] = uniquePlnt[0];
		tmpJson["stge_loc"] = uniqueStr[0];

		tmpJson["costcenter"] = $('#s_cc').val();
		tmpJson["orderid"] = $('#s_io').val();
		tmpJson["move_type"] = $('#s_move_type').val().split('/')[0];
		tmpJson["header_txt"] = $('#s_header_txt').val();
		tmpJson["spec_stock"] = $('#r_spec_stock').val();
			
		tmpJson["req_dt"] = $('#r_conf_date').val();
		tmpJson["material"] = gridDataArr[idx].matnr;
		tmpJson["entry_qnt"] = $('#'+keyArr[idx]+'_request_bdmng').val();
		tmpJson["entry_uom"] = gridDataArr[idx].meins;			
		tmpJson["serial_yn"] = gridDataArr[idx].sernp;		
		tmpJson["item_text"] = $('#'+keyArr[idx]+'_item_text').val();
		tmpJson["proc_gubun"] = $(':radio[name="t_gubun"]:checked').val();
			
		jsonObjArr.push(tmpJson);
			
		if($('#'+keyArr[idx]+'_request_bdmng').val() == "") {
			fnMessageModalAlert("Notification(SCM)", "요청수량 항목을 작성해주세요.");
			return;
		}
	}

	/*********************요청 그리드 data 처리 : End*********************/
	
	var jsonStr = JSON.stringify(jsonObjArr);
	
	var page_url = "/frontend/scm/fwother_mst_insert"
	var postData = 'jsonStr=' + encodeURIComponent(jsonStr);
		
		$.ajax({
		    url: page_url,
		    data: postData,
		    async:false,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
		    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하였습니다.");
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

	//변수, 객체 데이터 초기화
	$('#grid_addItnbr_list').jqGrid('clearGridData');
	fnSearchRegListGrid();
	$("#modal_detail").modal('hide');

	
}

function numberChk(s){
	var chkStyle =  /^[0-9]*$/ ;      //체크 방식(숫자)
	if(!chkStyle.test(s.value)){
		fnMessageModalAlert("Notification(SCM)", "숫자만 입력 가능합니다.");
// 		$("#request_num").val("");
	}	
}

function addItnbrDetail() {
// 	console.log('addItnbrDetail()');
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
				$("#grid_addItnbr_list").jqGrid('addRow',{position  :"last", initdata  : groupInfo});
			}
		}else{
			dataArr.push(groupInfo);
			$("#grid_addItnbr_list").jqGrid('addRow',{position  :"last", initdata  : groupInfo});	
		}	
	}
}

// remove new itnbr list
function deleteItnbrDetail() {
	$("#grid_addItnbr_list").jqGrid('delRowData', $("#grid_addItnbr_list").getGridParam('selrow'));
}


function getStrList() {

	initOptions($('#s_str'));
	var page_url = "/frontend/scm/scm_sloc_code_select";
	var postData = 'werks=' + encodeURIComponent($('#s_plnt').val());
				 
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$.each(data.rows, function (i, item) {
						$('#s_str').append($('<option>', { 
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

function getStrInqList() {

	initOptions($('#s_str_inq'));
	var page_url = "/frontend/scm/scm_sloc_code_select";
	var postData = 'werks=' + encodeURIComponent($('#s_werks_req').val());
				 
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$('#s_str_inq').append($('<option>', { 
						value: "",
				        text : "전체"
				    }));
					$.each(data.rows, function (i, item) {
						$('#s_str_inq').append($('<option>', { 
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

function getMoveTypeList() {
	
// 	initOptions($('#s_move_type'));
	
	var page_url = "/frontend/scm/move_type_select"
	var postData = 'werks=' + encodeURIComponent($('#s_plnt').val());				 
	
	$.ajax({
	    url: page_url,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$.each(data.rows, function (i, item) {
						$('#s_move_type').append($('<option>', { 
							value: item.bwart + '/'+ item.kostl + '/'+ 	item.aufnr,
					        text : item.btext
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

function getCostTypeList() {
	

	var page_url = "/frontend/scm/cost_type_select"
					 
	$.ajax({
	    url: page_url,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$.each(data.rows, function (i, item) {
						$('#s_cc').append($('<option>', { 
							value: item.kostl,
					        text : item.ktext
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


function getIoTypeList() {
	
	var page_url = "/frontend/scm/io_type_select"
					 
	$.ajax({
	    url: page_url,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$.each(data.rows, function (i, item) {
						$('#s_io').append($('<option>', { 
							value: item.aufnr,
					        text : item.ktext
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
//         .append('<option value="">선택</option>')
        .val();
}
</script>