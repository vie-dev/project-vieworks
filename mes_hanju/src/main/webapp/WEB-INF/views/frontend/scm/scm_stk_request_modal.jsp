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
					<div class="col-md-6" style="padding-right: 0px;">
						<div class="box" style="margin-bottom: 0px;">
							<div class="box-header with-border">
								<h3 class="box-title">자재 목록</h3>
								<div class="box-tools pull-right">
									<button type="button" id="" class="btn btn-sm btn-primary" onclick="fnSearchItnbrGrid();">조회</button> |
									<button type="button" id="" class="btn btn-sm btn-warning btn-sm" onclick="addItnbrDetail();">
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
										<select id="s_werks" class="form-control select2 input-sm" data-placeholder="유형 선택" style="width: 100%;">
											<option value="">전체</option>
											<option value="1110">의료</option>
											<option value="1210">광</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">자재내역</label>
									<div class="col-sm-7">
										<input type="input" id="s_maktx" name="s_maktx" class="form-control input-sm" placeholder="">
									</div>
								</div>
								<div id="dv_grid_itnbrlist">
									<table id="grid_itnbrlist"></table>
									<div id="grid_itnbrlist_pager"></div>
								</div>
							</div><!-- end box-body -->
						</div><!-- end box -->
					</div><!-- end col-md-6 -->
					<div class="col-md-6">
						<div class="box" style="margin-bottom: 0px;">
							<div class="box-header with-border">
								<h3 class="box-title">환입(이동)입력 자재</h3>
								<div class="box-tools pull-right">
									<button type="button" id="" class="btn btn-sm btn-primary" onclick="fnStockSelc();">재고조회</button> |
									<button type="button" id="" class="btn btn-sm btn-warning btn-sm" onclick="deleteItnbrDetail();">
										<i class="fa fa-backward" aria-hidden="true"></i></button>
								</div>
							</div>
							<div class="box-body">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">플랜트</label>
									<div class="col-sm-3">
										<select id="s_from_plnt" class="form-control select2 input-sm" data-placeholder="유형 선택" style="width: 100%;">
											<option value="1110">의료</option>
											<option value="1210">광</option>
										</select>
									</div>
									<div class="col-sm-1"><span class="glyphicon glyphicon-arrow-right" style="line-height: 30px;"></span></div>
									<div class="col-sm-3">
										<select id="s_to_plnt" class="form-control select2 input-sm" data-placeholder="유형 선택" style="width: 100%;">
											<option value="1110">의료</option>
											<option value="1210">광</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">창고</label>
									<div class="col-sm-3">
										<select id="s_from_str" class="form-control select2 input-sm" data-placeholder="유형 선택" style="width: 100%;">
										</select>
									</div>
									<div class="col-sm-1"><span class="glyphicon glyphicon-arrow-right" style="line-height: 30px;"></span></div>
									<div class="col-sm-3">
										<select id="s_to_str" class="form-control select2 input-sm" data-placeholder="유형 선택" style="width: 100%;">
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">즉시처리구분</label>
									<div class="col-sm-9">
										<input type="radio"	id="t_gubun_1" name="t_gubun"  value=""  checked> 승인  단계 있음&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                                	<input type="radio"  name="t_gubun"  value="Y"> 승인 단계 없음
									</div>
								</div>
								<div id="dv_grid_addItnbr_list" class="box-body" style="width:400px;">
									<table id="grid_addItnbr_list"></table>
								</div>
							</div><!-- end box-body -->
						</div><!-- end box -->
					</div><!-- end col-md-6 -->
				</div><!-- end row -->
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-sm btn-success" onclick="confirmReqeust();">완료</button>
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

	getFromStrList($("#s_from_plnt").val());
	getToStrList($("#s_to_plnt").val());
	
	$('#s_from_plnt').change(function(){
		getFromStrList($("#s_from_plnt").val());
	});
		
	$('#s_to_plnt').change(function(){
		getToStrList($("#s_to_plnt").val());
	});
	initScreenSizeModal();
})



function fnSearchItnbrGrid() {
	var s_matnr = $('#s_matnr').val();
	var s_werks = $('#s_werks').val();
	var s_maktx = $('#s_maktx').val();

	var page_url = "/frontend/scm/matnr_select"
		 + "?matnr=" + encodeURIComponent(s_matnr)
		 + "&werks=" + encodeURIComponent(s_werks)
		 + "&maktx=" + encodeURIComponent(s_maktx)
	
	$("#grid_itnbrlist").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_itnbrlist").setGridParam({ page: 1 }).trigger("reloadGrid");
}

function initItnbrGrid() {

	var page_url = "/frontend/scm/matnr_select"

	$('#grid_itnbrlist').jqGrid({
		url:page_url,
		datatype: 'json',
		colNames:['자재','werks', '플랜트','단위','자재내역', 'Spec & Dimension', '등급관리여부', '시리얼관리여부'],
		colModel:[
			{name:'matnr',index:'matnr', width:100, sorttype:'text', sortable:true},
			{name:'werks', index:'werks', hidden:true},
			{name:'werks_nm', index:'werks_nm', width:50, sorttype:'text', sortable:true},
			{name:'meins',index:'meins', width:40, sorttype:'text', sortable:true, hidden:true},
			{name:'maktx',index:'maktx', width:90, sorttype:'text', sortable:true},
			{name:'wrkst',index:'wrkst', hidden:false},
			{name:'grade_yn',index:'grade_yn', hidden:true},
			{name:'serial_yn',index:'serial_yn', hidden:true}
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
	      repeatitems : false
// 	      id : "member_emp_no"
	    },
		loadComplete : function() {
		}
	});
}

function initItnbReqTmpGrid() {
	var page_url = "/frontend/scm/matnr_select"
	$('#grid_tmp_itnbrlist').jqGrid({
		url:page_url,
		datatype: 'json',
		colNames:['자재','플랜트','단위','자재내역', 'Spec & Dimension', '요청수량',  '등급여부'],
		colModel:[
			{name:'matnr',index:'matnr', width:90, sorttype:'text', sortable:true},
			{name:'werks', index:'werks', width:50, sorttype:'text', sortable:true},
			{name:'meins',index:'meins', width:20, sorttype:'text', sortable:true, sortable:true},
			{name:'maktx',index:'maktx', width:130, sorttype:'text', sortable:true},
			{name:'wrkst',index:'wrkst', width:130, sorttype:'text', sortable:true, sortable:true},
			{name:'request_bdmng',index:'request_bdmng', width:130, sorttype:'text', sortable:true, sortable:true},
			{name:'grade_yn',index:'grade_yn', width:70, sorttype:'text', sortable:true, sortable:true, hidden:true}
		],
		pager : '#grid_itnbrlist_pager',
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : true,
	    height: 340,
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
	      repeatitems : false
// 	      id : "member_emp_no"
	    },
		loadComplete : function() {
		}
	});
}

function initNewItnbrGrid() {
	$("#grid_addItnbr_list").jqGrid({
		url:'',
		datatype: 'json',
		colNames:['자재','자재내역','werks','플랜트','재고량','요청수량', '등급여부', '단위'],
		colModel:[
			{name:'matnr',index:'matnr', width:100, sorttype:'text', sortable:true, key:true},
			{name:'maktx',index:'maktx', width:70, sorttype:'text', sortable:true},
			{name:'werks',index:'werks', width:100, sorttype:'text', sortable:true, hidden:true},
			{name:'werks_nm',index:'werks_nm', width:70, sorttype:'text', sortable:true},
			{name:'labst',index:'labst', width:70, sorttype:'text', sortable:true},
			{name:'request_bdmng',index:'request_bdmng', width:70, sorttype:'text', sortable:true, editable:true},
			{name:'grade_yn',index:'grade_yn', width:70, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'meins',index:'meins', width:50, sorttype:'text', sortable:true, sortable:true, hidden:true}
		],
		rowNum: 1000,
		viewrecords : true,
// 	    autowidth : true,
	    shrinkToFit: false, 
	    multiselect : false,
	    height: 420,
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
	if($("#s_from_str").val() == null || $("#s_to_str").val() == null) {
		fnMessageModalAlert("Notification(SCM)", "From, to 창고를 선택해주세요.");
		return;
	}
	
	var rowdata = $("#grid_addItnbr_list").getRowData();
	var keyArr = $('#grid_addItnbr_list').jqGrid('getDataIDs');
	for(var i=0 ; i<rowdata.length ; i++ ) {
		
		if($('#'+keyArr[i]+'_request_bdmng').val().length == 0) {
			fnMessageModalAlert("Notification(SCM)", "요청수량을 입력해주세요.");
			return;
		}	
	}
	
	fnMessageModalConfirm("Notification", "선택 내역을 이동요청하시겠습니까?", function(chk){
		if(chk){
			fnConfirmReqeust();
		}
	});
}


function fnConfirmReqeust(){
	
	var gridDataArr = $('#grid_addItnbr_list').jqGrid('getRowData');	
	
	var params = new Array() ;
	
	/*********************요청 그리드 data 처리 : Start*********************/
	
	var gridDataArr = $('#grid_addItnbr_list').jqGrid('getRowData');
	var keyArr = $('#grid_addItnbr_list').jqGrid('getDataIDs');
	var jsonObjArr = [];
	
	if( gridDataArr.length==0 ) {
 
	} else {
		for(var idx=0; idx<gridDataArr.length; idx++){
			var tmpJson = {};
			
			tmpJson["matnr"] = gridDataArr[idx].matnr;
			tmpJson["werks"] = gridDataArr[idx].werks;
			tmpJson["grade"] = gridDataArr[idx].grade_yn;
			tmpJson["plant"] = $('#s_from_plnt').val();		
			tmpJson["move_plant"] = $('#s_to_plnt').val();
			tmpJson["stge_loc"] = $('#s_from_str').val();		
			tmpJson["move_stloc"] = $('#s_to_str').val();
			tmpJson["request_bdmng"] = $('#'+keyArr[idx]+'_request_bdmng').val();
			tmpJson["meins"] = gridDataArr[idx].meins;
			tmpJson["proc_gubun"] = $(':radio[name="t_gubun"]:checked').val();
			
			jsonObjArr.push(tmpJson);
		}
	}

	/*********************요청 그리드 data 처리 : End*********************/
	
	var jsonStr = JSON.stringify(jsonObjArr);
	
	var page_url = "/frontend/scm/stk_request_insert"
		var postData = 'jsonStr=' + encodeURIComponent(jsonStr);
		
		$.ajax({
		    url: page_url,
		    data: postData,
		    type: "POST",
		    async: false,
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
		fnMessageModalAlert("Notification(Scm)", "숫자만 입력 가능합니다.");
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

function getFromStrList(gubun) {

	initOptions($('#s_from_str'));
	
	var page_url = "/frontend/scm/scm_sloc_code_select"
	var postData = 'werks=' + encodeURIComponent(gubun);
				 
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$.each(data.rows, function (i, item) {
						$('#s_from_str').append($('<option>', { 
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

function getToStrList(gubun) {

	initOptions($('#s_to_str'));
	
	var page_url = "/frontend/scm/scm_sloc_code_select"
	var postData = 'werks=' + encodeURIComponent(gubun);
				 
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$.each(data.rows, function (i, item) {
						$('#s_to_str').append($('<option>', { 
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
//         .append('<option value="">선택</option>')
        .val();
}

function fnStockSelc() {
	var ids = $("#grid_addItnbr_list").jqGrid('getDataIDs');
	console.log(ids);
	
	var g_id = "0";
	var matnrs = '';
	var rowdata = $("#grid_addItnbr_list").getRowData();
	var flag = false;
	
	for(var i=0 ; i<rowdata.length ; i++ ) {
		matnrs = matnrs + rowdata[i].matnr + ',';
	}
	matnrs.substring(0, matnrs.length-1);	
	
	if($("#s_from_str").val() == null) {
		fnMessageModalAlert("Notification(SCM)", "From 창고를 선택해주세요.");
		return;
	}
	
	if(rowdata.length == 0) {
		fnMessageModalAlert("Notification(SCM)", "요청자재내역이 없습니다.");
		return;
	}
	
	var page_url = "/frontend/scm/req_stock_select"
		 + "?werks=" + encodeURIComponent($("#s_from_plnt").val())
		 + "&lgort=" + encodeURIComponent($("#s_from_str").val())
		 + "&matnrs=" + encodeURIComponent(matnrs);
	
	$.ajax({
	    url: page_url,
	    type: "POST",
	    async:false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					for(var i=0 ; i<rowdata.length ; i++ ) {
						flag = false;
						for(var k=0 ; k<(data.rows).length; k++)
						{
							if(rowdata[i].matnr == data.rows[k].matnr && rowdata[i].werks == data.rows[k].werks) {
								console.log("자재명 :: " + rowdata[i].matnr + "	//	재고량 :: "+ data.rows[k].labst);
								flag = true;
								$("#grid_addItnbr_list").jqGrid('setCell', ids[g_id], 'labst', data.rows[k].labst);
							} 
						}
						if(flag == false) {
							console.log("자재명 :: " + rowdata[i].matnr + "	//	재고량 :: 0.000");
							$("#grid_addItnbr_list").jqGrid('setCell', ids[g_id], 'labst', "0.000");
						}
						g_id++;
					}
				} else {
					for(var i=0 ; i<rowdata.length ; i++ ) {
						$("#grid_addItnbr_list").jqGrid('setCell', ids[i], 'labst', "0.000");
					}
				}
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "재고정보를 가져오지 못했습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SCM)", "재고정보를 가져오지 못했습니다.");		
	    },
	    complete: function() {}
	});
}
</script>