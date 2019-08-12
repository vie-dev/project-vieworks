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


<div class="modal fade" id="modal_detail" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">제품선택</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class=" col-md-12">
						 &nbsp;시리얼 항목을 모두 입력하고 수량을 확인한 뒤 요청을 처리해주세요.
						</div>	
					</div>
					<div class="row">
						<div class=" col-md-12">
							<div class="box" style="margin-bottom: 0px;">								
								<div class="row">
								<div class=" col-md-6">
								<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">자재 목록</h3>
									<div class="box-tools pull-right">
										<button type="button" id="" class="btn btn-primary" onclick="fnSearchItnbrGrid();">조회</button> |
										<button type="button" id="" class="btn btn-warning btn-sm" onclick="addItnbrDetail();">
								              <i class="fa fa-forward" aria-hidden="true"></i>
								        </button>
									</div>
								</div>
								<div class="form-group">
										<label for="" class="col-sm-3 control-label">자재번호</label>
										<div class="col-sm-9">
											<input type="input" id="s_matnr" name="s_matnr" class="form-control input-sm" placeholder="">
										</div>
								</div>
								<div class="form-group">
										<label for="" class="col-sm-3 control-label">플랜트</label>
										<div class="col-sm-9">
											<select id="s_werks" class="form-control select2" data-placeholder="유형 선택" style="width: 100%;">
												<option value="">전체</option>
												<option value="1110">의료</option>
												<option value="1210">광</option>
											</select>
										</div>
								</div>
								<div class="form-group">
										<label for="" class="col-sm-3 control-label">자재내역</label>
										<div class="col-sm-9">
											<input type="input" id="s_maktx" name="s_maktx" class="form-control input-sm" placeholder="">
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
										<h3 class="box-title">이동.타출 요청 자재</h3>
										<div class="box-tools pull-right">
											<button type="button" id="" class="btn btn-warning btn-sm" onclick="deleteItnbrDetail();">
												<i class="fa fa-backward" aria-hidden="true"></i></button>
										</div>
									</div>
									<div class="form-group">
										<label for="" class="col-sm-3 control-label">플랜트</label>
										<div class="col-sm-9">
											<select id="s_plnt" class="form-control select2" data-placeholder="유형 선택" style="width: 100%;">
												<option value="1110">의료</option>
												<option value="1210">광</option>
											</select>
										</div>
										</div>
										<div class="form-group">
												<label for="" class="col-sm-3 control-label">창고</label>
												<div class="col-sm-9">
													<select id="s_str" class="form-control select2" data-placeholder="유형 선택" style="width: 100%;">
													</select>
												</div>
										</div>
										<div class="form-group">
											<label for="" class="col-sm-3 control-label">이동유형</label>
											<div class="col-sm-9">
												<select id="s_move_type" class="form-control select2" data-placeholder="유형 선택" style="width: 100%;">
													<option value="">-</option>
												</select>
											</div>
										</div>										
										<div class="form-group">
											<label for="" class="col-sm-3 control-label">코스트센터</label>
											<div class="col-sm-9">
												<select id="s_cc" class="form-control select2" data-placeholder="유형 선택" style="width: 100%;">
													<option value="">-</option>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="col-sm-3 control-label">I/O</label>
											<div class="col-sm-9">
												<select id="s_io" class="form-control select2" data-placeholder="유형 선택" style="width: 100%;">
													<option value="">-</option>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="col-sm-3 control-label">전표헤더텍스트</label>
											<div class="col-sm-9">
												<input type="input" id="s_header_txt" name="s_header_txt" class="form-control input-sm" placeholder="">
											</div>
										</div>
									<div id="dv_grid_addItnbr_list" class="box-body">
										<table id="grid_addItnbr_list"></table>
									</div>
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
					<button type="button" id="" class="btn btn-success" onclick="confirmReqeust();">요청</button>
					<button type="button" id="" class="btn btn-default" onclick="modal_detail_close();">닫기</button>
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
		colNames:['요청번호','문서번호','자재번호','요청수량', '시리얼번호', '단위', '요청자', '플랜트', '저장창고'],
		colModel:[
			{name:'ref_doc_no',index:'ref_doc_no'},
			{name:'matdoc_itm',index:'matdoc_itm', hidden:true},
			{name:'material',index:'material'},
			{name:'entry_qnt',index:'entry_qnt'},
			{name:'serial',index:'serial', editable:true},			//시리얼 관리 대상 땐 승인수량 데이터 받음;;;...
			{name:'entry_uom',index:'entry_uom', hidden:true},
			{name:'gr_rcptr',index:'gr_rcpt', hidden:true},
			{name:'plant',index:'plant', hidden:true},
			{name:'stge_loc',index:'stge_loc', hidden:true}
		],
		cmTemplate: {sortable: false},
		rowNum:10000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
// 	    multiselect : true,
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
		colNames:['요청번호','문서번호','자재번호','요청수량', '승인수량', '단위', '요청자', '플랜트', '저장창고'],
		colModel:[
			{name:'ref_doc_no',index:'ref_doc_no'},
			{name:'matdoc_itm',index:'matdoc_itm', hidden:true},
			{name:'material',index:'material'},
			{name:'entry_qnt',index:'entry_qnt'},
			{name:'serial',index:'serial', editable:true, hidden:true},			//시리얼 관리 대상 땐 승인수량 데이터 받음;;;...
			{name:'entry_uom',index:'entry_uom', hidden:true},
			{name:'gr_rcptr',index:'gr_rcptr', hidden:true},
			{name:'plant',index:'plant', hidden:true},
			{name:'stge_loc',index:'stge_loc', hidden:true}
		],
		cmTemplate: {sortable: false},
		rowNum:10000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
// 	    multiselect : true,
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
	
	selc_id = mas_key;
	selected_mas_key = rowid;
	
	$('#grid_req_sernr').jqGrid('clearGridData');
	$('#grid_req_bdmng').jqGrid('clearGridData');
	
	var page_url = "/frontend/scm/fwother_select_nopage"
	var postData = "ref_doc_no=" + encodeURIComponent(mas_key)

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
			
					var entry_qnt = Number(data.rows[i].entry_qnt);
					console.log(data);
					// 승인 대기, 시리얼 관리대상 데이터 생성
					if(data.rows[i].serial_yn == "Y"){
						$('#grid_req_sernr').setColProp('serial', {editable:true});
						for(var j=0; j<entry_qnt; j++ ){
								var tmpObj = {};
								tmpObj.ref_doc_no = data.rows[i].ref_doc_no;
								tmpObj.matdoc_itm = data.rows[i].matdoc_itm;
								tmpObj.material = data.rows[i].material;
								tmpObj.entry_qnt = "1.000"; 
								tmpObj.serial = data.rows[i].serial;
								tmpObj.entry_uom =  data.rows[i].entry_uom;
								tmpObj.gr_rcptr = data.rows[i].gr_rcptr;
								tmpObj.plant = data.rows[i].plant;
								tmpObj.stge_loc = data.rows[i].stge_loc;
							
								arrTmpObj.push(tmpObj);
						
						}
					} else {				
						// 승인 대기, 시리얼 비관리대상 데이터 생성
						$('#grid_req_bdmng').setColProp('serial', {editable:true});
						var tmpObj = {};
					
						tmpObj.ref_doc_no = data.rows[i].ref_doc_no;
						tmpObj.matdoc_itm = data.rows[i].matdoc_itm;
						tmpObj.material = data.rows[i].material;
						tmpObj.entry_qnt = data.rows[i].entry_qnt;
						tmpObj.serial = data.rows[i].serial;
						tmpObj.entry_uom =  data.rows[i].entry_uom;
						tmpObj.gr_rcptr = data.rows[i].gr_rcptr;
						tmpObj.plant = data.rows[i].plant;
						tmpObj.stge_loc = data.rows[i].stge_loc;						
					
						arrTmpObj_1.push(tmpObj);
					}
				}
				$('#grid_req_sernr').jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj }).trigger('reloadGrid');	
				$('#grid_req_bdmng').jqGrid('setGridParam', { datatype: 'local', data: arrTmpObj_1 }).trigger('reloadGrid');	
			} else
			{
				fnMessageModalAlert("Notification(SCM)",
				"요청처리를 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(SCM)",
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
	var gridDataArr_1 = $('#grid_req_bdmng').jqGrid('getRowData');
	
	$("#grid_req_sernr").jqGrid('setGridParam', {cellEdit: true});
	$("#grid_req_bdmng").jqGrid('setGridParam', {cellEdit: true});
	
	/*********************그리드 체크여부 확인 : Start*********************/
	if(gridDataArr.length == 0 && gridDataArr_1.length == 0)
	{
		fnMessageModalAlert("Notification(HUB)", "체크 된 데이터가 없습니다.");
 		return;
	}
	/*********************그리드 체크여부 확인 : End*********************/
	
	var jsonStr = JSON.stringify(gridDataArr);
	var jsonStr_1 = JSON.stringify(gridDataArr_1);


	/********************* 데이터 insert 및 rfc 전송 : Start*********************/

		var selc_header_txt = $("#grid_reg").getRowData(selected_mas_key).header_txt;	
		var selc_status = $("#grid_reg").getRowData(selected_mas_key).status;
		
		var page_url = "/frontend/scm/conf_req_matr";
		var postData = 'jsonStr=' + encodeURIComponent(jsonStr)
		postData += '&jsonStr_1=' + encodeURIComponent(jsonStr_1)
		postData += '&conf_date=' + encodeURIComponent($("#r_conf_date_1").val())
		postData += '&ref_doc_no=' + encodeURIComponent(selc_id)
		postData += '&pre_status=' + encodeURIComponent(selc_status)
		postData += '&header_txt=' + encodeURIComponent(selc_header_txt);

		$.ajax({
		    url: page_url,
		    data: postData,
		    async : false,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    	if(data.e_return == 'S') {
			    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하였습니다. <br/> ***sap 전송 결과*** <br/>e_return : : " 
		    					+ data.e_return	+ "<br/>e_message : "+ data.e_message);
			    		} else {
			    			fnMessageModalAlert("Notification(SCM)", "정보를 저장하지 못했습니다. <br/> ***sap 전송 결과*** <br/>e_return : : " 
			    					+ data.e_return	+ "<br/>e_message : "+ data.e_message);
			    		}
			    	lastSel = null;
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
		
		fnSearchRegListGrid();
		$("#modal_conf").modal('hide');
		
		/********************* 데이터 insert 및 rfc 전송 : End*********************/
}

function modal_conf_close() {
	$("#modal_conf").modal('hide');
}

</script>