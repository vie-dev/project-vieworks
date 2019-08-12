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
		<jsp:param name="selected_menu_cd" value="1073" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        SCM관리
        <small>구매오더/입고관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> SCM관리</a></li><li class="active">구매오더/입고관리</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
    	<div class="row">
			<div class="col-md-8">
				<div class="box" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">납품관리</h3>
						<div class="box-tools pull-right">
							<div class="input-group" style="width: 220px; margin-right: 300px;">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" class="form-control pull-right input-sm" id="decide_date_range">
							</div>
						</div>
						<div class="box-tools pull-right">
							<button type="button" id="btn_pstyp" onclick="pstypSernr();" class="btn btn-info btn-sm" style="display:none;">사급처리</button>
							<select id="selectKind" class="select2 input-sm">
								<option value="case1">일정변경</option>
								<option value="case2">입하처리</option>
							</select>
							<button type="button" id="" onclick="reloadGridPo();" class="btn btn-primary btn-sm">조회</button>
							<button type="button" id="" onclick="checkSheduleSearch();" class="btn btn-warning btn-sm">일정변경 확인</button>						
						</div>
					</div>
					<div class="box-body" style="padding-bottom: 0px;">
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-sm-3" style="padding: 0px 5px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| Vendor 코드</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="lifnr">
									</div>
								</div>
							</div>
							<div class="col-sm-3" style="padding: 0px 5px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 구매담당자</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="eknam">
									</div>
								</div>
							</div>
							<div class="col-sm-3" style="padding: 0px 5px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 진행상태</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="rorder_status" class="form-control select2 input-sm" data-placeholder="Vendor 선택" style="width: 100%;">
											<option value="">전체</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-3" style="padding: 0px 5px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 구매문서</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="ebeln">
									</div>
								</div>
							</div>
						</div>
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-sm-3" style="padding: 0px 5px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 문서번호</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="sap_doc_no">
									</div>
								</div>
							</div>
							<div class="col-sm-3" style="padding: 0px 5px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 사급 대상</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="pstyp" class="form-control select2 input-sm" data-placeholder="사급자재 구분" style="width: 100%;">
											<option value="">전체</option>
											<option value="3">대상</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-3" style="padding: 0px 5px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 구매문서유형</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="bsart" class="form-control select2 input-sm" data-placeholder="CSR 번호" style="width: 100%;">
											<option value="">전체</option>
											<option value="ZNB">ZNB</option>
											<option value="ZMAN">ZMAN</option>
											<option value="ZRMA">ZRMA</option>
											<option value="ZMAP">ZMAP</option>
											<option value="ZRND">ZRND</option>
											<option value="ZFOC">ZFOC</option>
											<option value="NB">NB</option>
											<option value="ZSC">ZSC</option>
											<option value="ZFC1">ZFC1</option>
											<option value="ZMAL">ZMAL</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-3" style="padding: 0px 5px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| CSR 번호</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="zcsreq">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="gridPo" style="width: 100%; height: 653px;"></div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="box box-warning" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">입하관리</h3>
						<div class="box-tools pull-right"> <!-- style="min-width:600px;" -->
							<div id="serialBtns" style="float:right; text-align: right;">
								<button type="button" class="btn btn-info btn-sm grid_attach_down" onclick="excelFileDownload('gridSernr');" data-selfilepath="/upload" data-selfilename="test.xlsx">
									<i class="fa fa-check"></i> 다운로드 
								</button>
								<span class="btn btn-warning btn-sm fileinput-button"> 
									<span>시리얼 일괄 처리</span> 
									<input id="sernrfileupload" type="file" name="files[]" multiple>
								</span>
								<button type="button" id="" onclick="modalArrival();" class="btn btn-primary btn-sm">입하처리</button>
<!-- 								<button type="button" id="" onclick="processArrivalGoods();" class="btn btn-primary btn-sm">입하처리</button> -->
<!-- 								<button type="button" id="btn_saveSerial" class="btn btn-success btn-sm" onclick="saveSerials();">저장</button> -->
							</div>
						</div>
					</div>
					<div id="gridSernr" style="width: 100%; height: 731px;"></div>
				</div>
			</div>
		</div>
   	</section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <!-- /.content-wrapper -->
<div class="modal fade" id="modal_comment" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
<!-- 				<button type="button" class="close" onClick="modal_close();" aria-label="Close"> data-dismiss="modal"  -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
				<h4 class="modal-title" id="modal_code_title">일정변경 확인</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_deli_depart" name="frm_deli_depart" class="form-horizontal">
					<div class="row">
						<div class="col-md-12">
							<form id="frm_mcode" name="frm_mcode" class="form-horizontal">
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
									<textarea class="form-control input-sm" id="m_comment" rows="3"></textarea>
								</div>
							</div>
							</form>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_comment_save" class="btn btn-sm btn-success" onclick="checkSheduleSave();" disabled>저장</button>
					<button type="button" id="btn_comment_cancel" class="btn btn-sm btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!--  modal area1 -->
<div class="modal fade" id="modal_procSub" data-backdrop="static">
	<div class="modal-dialog modal-bg" style="width: 1600px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">사급자재 시리얼 등록</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-8">
						<div class="box" style="margin-bottom: 0px;">
							<div class="box-header with-border">
								사급자재 대상
							</div>
							<div id="" class="box-body">
								<div id="gridPoSub" style="width: 100%; height: 500px;"></div>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="box" style="margin-bottom: 0px;">
							<div class="box-header with-border">
								<h3 class="box-title">시리얼 관리</h3>
								<div class="box-tools pull-right" style="min-width:400px;">
<!-- 									<div id="progress" class="col-sm-1 progress" style="float:left;"> -->
<!-- 										<div class="progress-bar progress-bar-warning"></div> -->
<!-- 									</div> -->
									<div id="subSerialBtns" style="float:right; text-align: right;">
										<button type="button" class="btn btn-info btn-sm grid_attach_down" onclick="excelFileDownload('gridPoSubSernr');" data-selfilepath="/upload" data-selfilename="test.xlsx">
											<i class="fa fa-check"></i> 다운로드 
										</button>
										<span class="btn btn-warning btn-sm fileinput-button"> 
											<span>시리얼 일괄 처리</span> 
											<input id="subsernrfileupload" type="file" name="files[]" multiple>
										</span>
										<button type="button" id="btn_saveSubSerial" class="btn btn-success btn-sm" onclick="saveSubSerials();">저장</button>
									</div>
								</div>
							
							</div>
							<div class="box-body" style="padding-bottom: 0px;">
	<!-- 							<div id="msg" style="height:723px; color:red; display:none;"> -->
	<!-- 								<b>해당 데이터는 현재 메뉴에서의 시리얼 입력 대상 내용이 아닙니다.</b> -->
	<!-- 							</div> -->
								<div id="gridPoSubSernr" style="width: 100%; height: 500px;"></div>
							</div>
						</div>
					</div>
				</div>
			</div><!-- end modal body -->
		</div><!-- end modal content -->
	</div><!-- end modal dialog -->
</div><!-- end modal area1 -->
<div class="modal fade" id="modal_arrival" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">입하처리</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12">
						<div id="grid_arrival" style="width: 100%; height: 300px;"></div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12" style="padding-top: 15px;">
					<form id="frm_arrival" name="frm_arrival" class="form-horizontal">
						<div class="form-group" style="margin-bottom: 0px;">
							<label for="a_order_delivery_date" class="col-sm-4 control-label">입하실행일자</label> 
							<div class="input-group col-sm-6">
								<input type="input" id="a_order_delivery_date" name="a_order_delivery_date" class="form-control text-center input-sm" placeholder="일자를 선택하세요" maxlength="10">
							</div>
						</div>
					</form>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_processArrivalGoods" class="btn btn-sm btn-success" onclick="processArrivalGoods();">입하실행</button>
					<button type="button" id="btn_processArrivalGoods_cancel" class="btn btn-sm btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modal_ing" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">입하처리</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12">
						진행중입니다. 잠시만 기다려주세요.
					</div>
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
<!-- 
serial table new 
raw_sernr_select : rawSernr_select / rawProc_sernr_select : rawProcSernr_select
/scm/scm_sernr_insert : scmSernr_insert / scmProc_sernr_insert : scmProcSernr_insert
/scm/raw_sernr_duplication_chk : raw_sernr_duplication_chk / /scm/rawProc_sernr_duplication_chk : rawProc_sernr_duplication_chk
rawSernr_update : rawProcSernr_update
rawSernrEbelp_update : rawProcSernrEbelp_update
scmSernr_insertItem : scmProcSernr_insertItem
 -->
<script type="text/javascript">
$(function($) {
	fnLoadCommonOption();
//	fnLoadProcListGrid();
	
	fnLoadPoSubListGrid();
	fnLoadSernrSubListGrid();
	
	fnLoadSernrListGrid();
})

// search component setting
function fnLoadCommonOption() {
	$('#decide_date_range').daterangepicker({
		opens: 'right',
	/* 	startDate : '2017-11-01',
		endDate : '2017-11-30', */
		startDate :  getTodayDate(),
		endDate :  getTodayDate(),
		locale: {
			format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
			,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
			,showMonthAfterYear: true
			,yearSuffix: '년'
			,orientation: "top left"
	    }
	});

	$("#a_order_delivery_date").datepicker({
		language: "kr",
		todayHighlight: true,
		format: "yyyy-mm-dd",
		autoclose: true
	}).on('changeDate',function(selected){
		var selectDate = $(this).val();
		var today = replaceAll(getTodayDate().substring(0, 10),'.','-');
		if ( selectDate > today ) {
			fnMessageModalAlert("Warning", "당일 일자(" + today + ")이후의 일자는 선택할 수 없습니다.<br>[ 입력일자 : " + selectDate + "]<br>오늘 일자로 초기화합니다.");
			$("#a_order_delivery_date").datepicker("setDate",  today);
		}
// 		 newDate = new Date(selected.date);
		// Extract the current date from Date object
// 		newDate.setDate(newDate.getDate());
		
// 		chDateStr = $.datepicker.formatDate('yymmdd',selected.date);
		$('#vendor_delivery_date').datepicker("setDate",  selected.date);
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
	
	$("#selectKind").change(function(){
		$.each(w2ui.gridPo.getSelection(), function(idx, sel){
			w2ui.gridPo.unselect(sel);
		});
		w2ui.gridSernr.clear();
	});
	
	$("#btn_processArrivalGoods_cancel").click(function(){
		$.each(w2ui.gridPo.records, function(idx, row){
			row.recid = idx+1;
		});
		w2ui['gridPo'].refresh();
	});
	initScreenSizeModal();
	getStatusCodeList('rorder_status');
	
	fnSernrLoadFileHandler();
	fnSubLoadFileHandler();
	initGridArrival();
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
					
					$("#rorder_status option:eq(3)").attr("selected","selected");
					fnLoadProcListGrid();
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

var chkFlag = '';
var chkArr = [];
function fnLoadProcListGrid() {
// 	console.log('fnLoadProcListGrid()');	
	$("#gridPo").w2grid({ 
        name: 'gridPo',
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
			{ field : 'ebeln', caption:'구매문서 ', size: '100px', style:'text-align:center', frozen: true}, 
			{ field : 'ebelp', caption:'문서순번', size: '70px', style:'text-align:center', frozen: true},
			{ field : 'partial_seq', caption:'분기순번', size: '70px', style:'text-align:center', frozen: true},
			{ field : 'matnr', caption:'품목', size: '150px'}, 
			{ field : 'menge', caption:'납품수량', size: '70px', render:'int'}, 
			{ field : 'eindt', caption:'납품일자', size: '100px', style:'text-align:center'}, 
			{ field : 'rorder_status_nm', caption:'요청상태', size: '150px', style:'text-align:center'}, 
			{ field : 'rorder_status', caption:'rorder_status', size: '30%', hidden:true}, 
			{ field : 'rvendor_status_nm', caption:'구매상태', size: '100px', style:'text-align:center'}, 
			{ field : 'rvendor_status', caption:'rvendor_status', size: '30%', hidden:true}, 
			{ field : 'confirm_date', caption:'최종납품일자', size: '100px', style:'text-align:center'}, 
			{ field : 'order_delivery_date', caption:'order_delivery_date', size: '100px', style:'text-align:center', hidden:true}, 
			{ field : 'zdeli_menge', caption:'요청수량', size: '70px', render:'int'}, 
			{ field : 'vendor_delivery_date', caption:'요청일자', size: '100px', style:'text-align:center'}, 
			{ field : 'sap_doc_no', caption:'납품문서번호', size: '100px', style:'text-align:center'}, 
			{ field : 'werks', caption:'플랜트', size: '100px', hidden:true}, 
			{ field : 'lgort', caption:'저장위치', size: '100px', hidden:true}, 
			{ field : 'diff_date', caption:'diff_date', size: '100px', hidden:true}, 
			{ field : 'bukrs', caption:'bukrs', size: '100px', hidden:true}, 
			{ field : 'txz01', caption:'txz01', size: '100px', hidden:true}, 
			{ field : 'aedat', caption:'생성일자', size: '100px'},
			{ field : 'sernp', caption:'시리얼대상', size: '70px'}, 
			{ field : 'meins', caption:'meins', size: '100px', hidden:true}, 
			{ field : 'labnr', caption:'labnr', size: '100px', hidden:true},
			{ field : 'labnr_1', caption:'labnr_1', size: '100px', hidden:true},
			{ field : 'confirm_yn', caption:'confirm_yn', size: '100px', hidden:true},
			{ field : 'key_cnt', caption:'key_cnt', hidden:true},
			{ field : 'pstyp',caption:'사급자재대상', size:'70px'},
			{ field : 'zcsreq',caption:'CSR번호', size:'100px'},
			{ field : 'partial_yn',caption:'partial_yn', hidden:true},
			{ field : 'bsart',caption:'발주유형', hidden:true},
			{ field : 'knttp',caption:'계정범주유형', hidden:true}
        ],
      	sortData: [{field: 'recid', direction: 'ASC'}],
		records: rowArr,
		recordHeight : 30,
		onReload: function(event) {
// 			console.log(event);
			reloadGridPo();
		},
		onClick: function (event) {
			event.onComplete = function () {
// 				console.log(event);
		        var selectArr = w2ui.gridPo.getSelection();
		        var sel = Number(event.recid);
				var selectedData = this.get(sel);
				var kind = $("#selectKind").val();
				var pstypCnt = 0;
	        	$("#btn_pstyp").hide();
	        	$.each(selectArr, function(idx, recid){
	        		if( (w2ui.gridPo.get(recid)).pstyp=='3' ) pstypCnt++;
	        	});
	        	if( pstypCnt>0 ) $("#btn_pstyp").show();
	        	
		        if( $.inArray(sel, chkArr) < 0 ){	// checkbox on
// 		        	console.log("checked");
		        	if( selectArr.length==1 )
						w2ui.gridSernr.clear();
		        	
		        	$.each(w2ui.gridPo.records, function(idx, row){
						if( selectedData.ebeln==row.ebeln ){
							if( kind=="case1" ){	// 일정확인 : 같은po별
								w2ui.gridPo.select(row.recid);
								chkArr.push(row.recid);
							} else {	// 입하처리 : po의 같은 일자 별
								if( selectedData.vendor_delivery_date==row.vendor_delivery_date ){
									w2ui.gridPo.select(row.recid);
									chkArr.push(row.recid);
								}
							}
						}
						$.unique(chkArr);
		        	});
		        	gridPoClickEvent();
		        } else if( $.inArray(sel, chkArr) > -1 ){	// checkbox off
// 		        	console.log("not checked");
		        	// serial grid remove by key
		        	var sernrData = w2ui.gridSernr.records;
		        	$.each(w2ui.gridPo.records, function(idx, row){
						if( selectedData.ebeln==row.ebeln ){
							if( kind=="case1" ){	// 일정확인 : 같은po별
					        	w2ui.gridPo.unselect(row.recid);
					        	chkArr.splice(chkArr.indexOf(row.recid), 1);
					        	$.each(sernrData, function(sdx, srow){
				        			if( row.sernp=='V001' ){
				        				w2ui.gridSernr.select(srow.recid);
				        			} else {
				        				if( srow.ebeln==row.ebeln ){
						        			w2ui.gridSernr.select(srow.recid);
								        	w2ui.gridSernr.delete(true);
								        	return false;
				        				}
				        			}
					        	});
					        	if( row.sernp=='V001' ){
					        		w2ui.gridSernr.delete(true);
					        		return false;
					        	}
							} else {	// 입하처리 : po의 같은 일자 별
								if( selectedData.vendor_delivery_date==row.vendor_delivery_date ){
									w2ui.gridPo.unselect(row.recid);
									chkArr.splice(chkArr.indexOf(row.recid), 1);
						        	$.each(sernrData, function(sdx, srow){
						        		if( row.sernp=='V001' ){
						        			if( srow.ebeln==row.ebeln && srow.ebelp==row.ebelp && srow.partial_seq==row.partial_seq){    			
						        				w2ui.gridSernr.select(srow.recid);
						        			}
						        		} else {
							        		if( srow.ebeln==row.ebeln ){
							        			w2ui.gridSernr.select(srow.recid);
									        	w2ui.gridSernr.delete(true);
							        			return false;
							        		}
						        		}
						        	});
						        	if( row.sernp=='V001' ){
						        		w2ui.gridSernr.delete(true);
						        		return false;
						        	}
								}
							}
						}
		        	});
		        }
		    }
		}
	});
	
	// 납품일정이 변경되면 목록에서 빨간색으로 해당 항목을 표시한다.
	var fDate = $("#decide_date_range").val().substring(0,10);
	var tDate = $("#decide_date_range").val().substring(13,23);
	var order_status = $("#rorder_status").val();
	var ebeln = $("#ebeln").val(); 
	var sap_doc_no = $("#sap_doc_no").val(); 
	var pstyp = $("#pstyp").val();
	var lifnr = $("#lifnr").val();
	var eknam = $("#eknam").val();
	var bsart = $("#bsart").val();
	var zcsreq = $("#zcsreq").val();
// 	var subgridData = [];
	
	var page_url = "/frontend/scm/rawProc_select"
				 + "?jidat_from=" + encodeURIComponent(fDate)
				 + "&jidat_to=" + encodeURIComponent(tDate)
				 + "&confirm_yn=Y"
				 + "&rorder_status=" + encodeURIComponent(order_status)
				 + "&ebeln=" + encodeURIComponent(ebeln)
				 + "&sap_doc_no=" + encodeURIComponent(sap_doc_no)
				 + "&pstyp=" + encodeURIComponent(pstyp)
				 + "&bsart=" + encodeURIComponent(bsart)
				 + "&zcsreq=" + encodeURIComponent(zcsreq);
	if( $.trim(lifnr).length>0 ) 
		page_url += "&lifnr=" + encodeURIComponent($.trim(lifnr));
	if( $.trim(eknam).length>0 ) 
		page_url += "&eknam=" + encodeURIComponent($.trim(eknam));
	
	w2ui['gridPo'].lock('loading...', true);
	var rowArr = [];
	$.ajax({
	  url : page_url,
	  type : 'POST',
	  dataType : 'json',
	  success : function( data ) {
	  	if(data.status == 200 && (data.rows).length>0 ) {
	  		rowArr = data.rows;
	  		$.each(rowArr, function(idx, row){
	  			row.recid = idx+1;
	  			if( row.partial_yn=='Y' || row.diff_date=='Y' || row.confirm_yn=='N' )
	  				row.w2ui = { style : 'background-color: #FBFEC0' };
	  		});
	  		w2ui['gridPo'].records = rowArr;
	  	}
	  	w2ui['gridPo'].refresh();
  		w2ui['gridPo'].unlock();
	  },complete: function () {}
	});
}

function gridPoClickEvent(){
// 	console.log('gridPoClickEvent()');
	//clickArr
	var selectArr = w2ui.gridPo.getSelection();
	var kind = $("#selectKind").val();
// 	console.log(selectArr);
	w2ui.gridSernr.clear();
	w2ui.gridSernr.refresh();
   	$.each(selectArr, function(idx, recid){
   		var selectedData = w2ui.gridPo.get(recid);
		if( kind=="case1" ){	// 일정확인 : 같은po별
			if( selectedData.sernp=="V001" ) {
				if( chkSernrExist(selectedData.ebeln, selectedData.ebelp) ) {
					loadSernrList(recid, true);
				} else {
					makeSernrList(recid);
				}
			} else {
				makeSernrList(recid);
			}	
		} else {	// 입하처리 : po의 같은 일자 별
	        if( selectedData.sernp=="V001" ) {
				if( chkSernrExist(selectedData.ebeln, selectedData.ebelp) ) {
					loadSernrList(recid, true);
				} else {
					makeSernrList(recid);
				}
	        } else {
	        	makeSernrList(recid);
	        }
		}
   	});
}

function reloadGridPo(keyArr) {
// 	console.log('reloadGridPo()');
	var fDate = $("#decide_date_range").val().substring(0,10);
	var tDate = $("#decide_date_range").val().substring(13,23);
	var order_status = $('#rorder_status').val();
	var ebeln = $("#ebeln").val(); 
	var sap_doc_no = $("#sap_doc_no").val(); 
	var pstyp = $("#pstyp").val();
	var lifnr = $("#lifnr").val();
	var eknam = $("#eknam").val();
	var bsart = $("#bsart").val();
	var zcsreq = $("#zcsreq").val();
	
	var page_url = "/frontend/scm/rawProc_select"
				 + "?jidat_from=" + encodeURIComponent(fDate)
				 + "&jidat_to=" + encodeURIComponent(tDate)
				 + "&confirm_yn=Y"
				 + "&rorder_status=" + encodeURIComponent(order_status)
				 + "&ebeln=" + encodeURIComponent(ebeln)
				 + "&sap_doc_no=" + encodeURIComponent(sap_doc_no)
				 + "&pstyp=" + encodeURIComponent(pstyp)
				 + "&bsart=" + encodeURIComponent(bsart)
				 + "&zcsreq=" + encodeURIComponent(zcsreq);
	if( $.trim(lifnr).length>0 ) 
		page_url += "&lifnr=" + encodeURIComponent($.trim(lifnr));
	if( $.trim(eknam).length>0 ) 
		page_url += "&eknam=" + encodeURIComponent($.trim(eknam));
	
	w2ui['gridPo'].clear();
	w2ui['gridSernr'].clear();
	
	w2ui['gridPo'].lock('loading...', true);
	var rowArr = [];
	$.ajax({
	  url : page_url,
	  type : 'POST',
	  async : false,
	  dataType : 'json',
	  success : function( data ) {
	  	if(data.status == 200 && (data.rows).length>0 ) {
	  		rowArr = data.rows;
	  		$.each(rowArr, function(idx, row){
	  			row.recid = idx+1;
	  			if( row.partial_yn=='Y' || row.diff_date=='Y' || row.confirm_yn=='N' )
	  				row.w2ui = { style : 'background-color: #FBFEC0' };
	  		});
	  		w2ui['gridPo'].records = rowArr;
	  	}
	  	w2ui['gridPo'].refresh();
  		w2ui['gridPo'].unlock();
	  },complete: function () {
		  if( keyArr!=undefined ){
			  $.each(keyArr, function(idx, key){
				  w2ui.gridPo.select(key);
			  })
		  }
	  }
	});
}

function fnLoadSernrListGrid() {
// 	console.info('fnLoadSernrListGrid()');

	$("#gridSernr").w2grid({ 
        name: 'gridSernr',
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
			{ field : 'ebeln', caption:'문서번호', size: '100px'}, 
			{ field : 'matnr', caption:'품목', size: '100px'},
			{ field : 'txz01', caption:'내역', size: '150px'},
			{ field : 'menge', caption:'요청수량', size:'60px', render:'int'},
			{ field : 'zdeli_menge', caption:'입하수량', size: '60px', render:'int'}, 
			{ field : 'equnr', caption:'순차관리번호', size: '100px', editable: function(record, index, col_index){
				if (record.sernp=='V001') return { type: 'text'};
				else return false;	}},
// 			, render: function(record, index, col_index){
// 						if (record.sernp=='V001') return this.getCellValue(index, col_index);
// 						else	return '시리얼 비대상';} }, 
			{ field : 'ebelp', caption:'문서품목', size: '0px'}, 
			{ field : 'partial_seq', caption:'분기순번', size: '0px'},
			{ field : 'sernp', caption:'sernp', hidden:true}],
      	sortData: [{field: 'ebeln', direction: 'ASC'}],
      	recordHeight : 30,
		records: []
	});
}

function fnLoadPoSubListGrid() {
// 	console.log('fnLoadPoSubListGrid()');
	$('#gridPoSub').w2grid({ 
        name: 'gridPoSub',
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
			{ field : 'ebeln', caption:'문서번호 ', size: '100px', style:'text-align:center'}, 
			{ field : 'ebelp', caption:'문서품목', size: '60px', style:'text-align:center'},
			{ field : 'matnr', caption:'자재번호', size: '150px'}, 
			{ field : 'maktx', caption:'자재명', size: '200px'},
            { field : 'werks', caption:'werks', size: '70px',hidden:true}, 
            { field : 'werks_nm', caption:'플랜트', size: '70px', style:'text-align:center'}, 
            { field : 'lgort', caption:'저장위치', size: '70px', hidden:true}, 
            { field : 'bdmng', caption:'소요량', size:'50px', render:'int'},
            { field : 'meins', caption:'단위', size:'70px'},
            { field : 'z1110_labst', caption:'의료 재고', size:'75px', render:'int'},
            { field : 'z1210_labst', caption:'광영상 재고', size:'75px', render:'int'},
            { field : 'zvendor_sllab', caption:'vendor 재고', size:'75px', render:'int'},
            { field : 'rsnum', caption: '예약/종속 소요량의 번호', size:'75px', hidden:true},
            { field : 'rspos', caption:'예약/종속 소요량에 대한 품목 번호', size:'75px', hidden:true},
            { field : 'xloek', caption:'삭제여부', size:'75px', hidden:true},
            { field : 'sernp', caption:'시리얼대상', size:'50px'},
            { field : 'date_created', caption:'date_created', hidden:true},
            { field : 'date_updated', caption:'date_updated', hidden:true} ],
      	sortData: [{field: 'recid', direction: 'ASC'}],
      	onReload : function(event){
      		reloadPoSubGrid();
      	}, 
		onClick: function (event) {
		    event.onComplete = function () {
		        var selectArr = w2ui.gridPoSub.getSelection();
		        var sel = Number(event.recid);
				var selectedData = this.get(sel);
// 		    	console.log(selectedData.matnr);
		        if( $.inArray(sel, selectArr) > -1 ){	// checkbox on
// 		        	console.log("checked");
		        	fnSearchSubSernrList(sel);
		        } else {	// checkbox off
// 		        	console.log("not checked");
		        	// serial grid remove by key
		        	var sernrData = w2ui.gridPoSubSernr.records;
// 		        	console.log(sernrData)
		        	$.each(w2ui.gridPoSub.records, function(idx, row){
						if( selectedData.matnr==row.matnr ){
				        	w2ui.gridPoSub.unselect(row.recid);
						}
		        	});
// 		        	var arr = [];
		        	$.each(sernrData, function(sdx, srow){
		        		if( srow.matnr==selectedData.matnr ){
		        			w2ui.gridPoSubSernr.select(srow.recid);
		        		}
		        	});
// 		        	console.log(w2ui.gridPoSubSernr.getSelection());
        			w2ui.gridPoSubSernr.delete(true);
		        }
		    }
		}
	});
}

function fnLoadSernrSubListGrid() {
// 	console.log('fnLoadSernrSubListGrid()');
	$('#gridPoSubSernr').w2grid({ 
        name: 'gridPoSubSernr',
        show: { 
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
			{ field : 'ebeln', caption:'문서번호 ', size: '100px'}, 
			{ field : 'matnr', caption:'품목', size: '150px'}, 
			{ field : 'txz01', caption:'내역', size: '150px'}, 
			{ field : 'menge', caption:'요청수량', size: '70px'}, 
			{ field : 'zdeli_menge', caption:'납품수량', size: '70px'},
			{ field : 'equnr',caption:'순차관리번호', size: '100px', editable: { type: 'text', inTag:'maxlength=13' }},
			{ field : 'ebelp', caption:'문서순번 ', size: '0px'},
			{ field : 'partial_seq', caption:'seq', size: '0px'}
        ],
        onReload : function(event){},
      	sortData: [{field: 'ebeln', direction: 'ASC'}]
	});
}

function fnSearchSubSernrList(sel) {
	console.log('fnSearchSubSernrList(',sel,')');
	
	var selRowData = w2ui['gridPoSub'].get(sel);
	var serialData = w2ui.gridPoSubSernr.records;
	if( selRowData!={} && Number(selRowData.bdmng)>0 && selRowData.sernp=='V001' ){
		// prevent duplaicate serial data
		if( w2ui.gridPoSub.getSelection().length==1 ){
			w2ui.gridPoSubSernr.clear();
		}
		if( chkSernrExist(selRowData.ebeln, selRowData.ebelp) ){
			// already exist data
			var page_url = "/frontend/scm/rawProc_sernr_select"
						 + "?ebeln=" + encodeURIComponent(selRowData.ebeln)
						 + "&ebelp=" + encodeURIComponent(selRowData.ebelp)
						 + "&matnr=" + encodeURIComponent(selRowData.matnr);
			w2ui['gridPoSubSernr'].lock('Loading...', true);
			$.ajax({
			    url: page_url,
			    type: "POST",
			    success:function(data, textStatus, jqXHR){
			    	if(data.status == "200") {
			    		var objArr = data.rows;
			    		var gridSernrRecord = w2ui.gridPoSubSernr.records;
			    		var gridSernrCnt = gridSernrRecord.length;
			    		if ( objArr.length>0 ){
							$.each(objArr, function(idx, row){
								row.recid = gridSernrCnt + (idx+1);
								row.menge = 1;
								row.zdeli_menge = 1;
								row.werks = row.b_werks;
								row.lgort = row.b_lager;
								row.partial_seq = '0000';
							});
							w2ui['gridPoSubSernr'].add(objArr);
			    		}
			    		w2ui['gridPoSubSernr'].unlock();
			    	}else{
			    		fnMessageModalAlert("Error", "정보를 가져오는데 에러가 발생하였습니다.");
			    	}
			    },
			    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("Error", "정보를 가져오는데 에러가 발생하였습니다.");	
			    },
			    complete: function() {
			    }
			});
		} else {
			w2ui['gridPoSubSernr'].lock('Loading...', true);
			var arrTmpObj = [];
			var gridSernrRecord = w2ui.gridPoSubSernr.records;
    		var gridSernrCnt = gridSernrRecord.length;
			for(var idx=0; idx<selRowData.bdmng; idx++ ){
				var tmpObj = {};
				tmpObj.recid = gridSernrCnt + (idx+1); 
				tmpObj.ebeln = selRowData.ebeln;
				tmpObj.ebelp = selRowData.ebelp;
				tmpObj.matnr = selRowData.matnr;
				tmpObj.txz01 = selRowData.maktx;
				tmpObj.menge = 1; 
				tmpObj.zdeli_menge = 1;
				tmpObj.partial_seq = '0000';
				w2ui['gridPoSubSernr'].add(tmpObj);
// 				arrTmpObj.push(tmpObj);
			}
			w2ui['gridPoSubSernr'].unlock();
// 			w2ui['gridPoSubSernr'].add(arrTmpObj);
		}
	}
}

function reloadPoSubGrid(){
// 	console.log('reloadPoSubGrid()');
	var selectedData = w2ui.gridPo.get(w2ui.gridPo.getSelection())[0];
	var page_url = "/frontend/scm/rawProcSub_select"
				 + "?ebeln=" + encodeURIComponent(selectedData.ebeln)
				 + "&ebelp=" + encodeURIComponent(selectedData.ebelp);

	w2ui['gridPoSub'].lock('loading...', true);
	var rowArr = [];
	$.ajax({
	  url : page_url,
	  type : 'POST',
	  dataType : 'json',
	  success : function( data ) {
	  	if(data.status == 200 && (data.rows).length>0 ) {
	  		rowArr = data.rows;
// 	  		console.log(rowArr);
	  		$.each(rowArr, function(idx, row){
	  			row.recid = idx+1;
	  		});
	  		w2ui['gridPoSub'].records = rowArr;
	  	}
  		w2ui['gridPoSub'].refresh();
  		w2ui['gridPoSub'].unlock();
	  },complete: function () {}
	});
}

function chkSernrExist(ebeln, ebelp) {
// 	console.log('chkSernrExist()');

	var page_url = "/frontend/scm/rawProc_sernr_select";
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
	    		fnMessageModalAlert("Error", "정보를 가져오는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Error", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
	return returnVal;
}

function loadSernrList(recid, selected) {
// 	console.info('loadSernrList()');
// 	$('#grid_sernr').jqGrid('clearGridData');
	var serialGridData = w2ui.gridSernr.records;
	var cnt = serialGridData.length;
	var selRowData = w2ui.gridPo.get(recid);
	var page_url = "/frontend/scm/rawProc_sernr_select";
	var postData = "ebeln=" + encodeURIComponent(selRowData.ebeln)
				 + "&ebelp=" + encodeURIComponent(selRowData.ebelp)
				 + "&partial_seq=" + encodeURIComponent(selRowData.partial_seq);

	w2ui['gridSernr'].lock('Loading...', true);
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		var objArr = data.rows;
	    		if ( objArr.length>0 ){
	    			var gridRecords = (w2ui['gridSernr'].records);
	    			var alreadyCnt = gridRecords.length;
					$.each(objArr, function(idx, row){
						row.recid = alreadyCnt + (idx+1);
						row.menge = 1;
						row.zdeli_menge = 1;
						row.werks = row.b_werks;
						row.lgort = row.b_lager;
						row.sernp = 'V001';
					});
					w2ui['gridSernr'].add(objArr);
	    		}
	    		w2ui['gridSernr'].total = (w2ui['gridSernr'].records).length; 
	    	}else{
	    		fnMessageModalAlert("Error", "정보를 가져오는데 에러가 발생하였습니다.");
	    	}
	    	w2ui['gridSernr'].unlock();
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Error", "정보를 가져오는데 에러가 발생하였습니다.");
	    },
	    complete: function() {}
	});
}

function makeSernrList(recid) {
// 	console.info('makeSernrList()', recid);
	var selRowData = w2ui.gridPo.get(recid);
	var serialRowData = w2ui.gridSernr.records;
	// make dataset and add
	var arrTmpObj = [];
	var pad = "0000";
	if( selRowData!={} && selRowData.zdeli_menge>0 ){
		
		if( selRowData.sernp != 'V001' ){
			var tmpObj = {};	
			var idx =0;
			var ans = pad.substring(0, pad.length - (String(idx+serialRowData.length).length)) + String(idx+serialRowData.length);
			tmpObj.ukey = selRowData.ebeln+selRowData.ebelp+ans;
			tmpObj.recid = serialRowData.length + 1; 
			tmpObj.ebeln = selRowData.ebeln;
			tmpObj.ebelp = selRowData.ebelp;
			tmpObj.partial_seq = selRowData.partial_seq;
			tmpObj.matnr = selRowData.matnr;
			tmpObj.txz01 = selRowData.txz01;
			tmpObj.menge = selRowData.menge; 
			tmpObj.zdeli_menge = selRowData.zdeli_menge;
			arrTmpObj.push(tmpObj);
			if( serialRowData.length==0 ) {
				w2ui.gridSernr.records = arrTmpObj;
				w2ui.gridSernr.refresh();
			} else {
				w2ui.gridSernr.add(tmpObj);
			}
			arrTmpObj = [];
		} else {
			for(var idx=0; idx<Number(selRowData.zdeli_menge); idx++ ){
				var tmpObj = {};
				var ans = pad.substring(0, pad.length - (String(idx+serialRowData.length).length)) + String(idx+serialRowData.length);
				tmpObj.recid = idx+(serialRowData.length + 1);
				tmpObj.ukey = selRowData.ebeln+selRowData.ebelp+ans;
				tmpObj.ebeln = selRowData.ebeln;
				tmpObj.ebelp = selRowData.ebelp;
				tmpObj.partial_seq = selRowData.partial_seq;
				tmpObj.matnr = selRowData.matnr;
				tmpObj.txz01 = selRowData.txz01;
				tmpObj.menge = 1; 
				tmpObj.zdeli_menge = 1;
				tmpObj.sernp = 'V001';
				arrTmpObj.push(tmpObj);
			}
// 			console.log(arrTmpObj);
			if( serialRowData.length==0 ){
				w2ui.gridSernr.records = arrTmpObj;
				w2ui.gridSernr.refresh();
			} else {
				w2ui.gridSernr.add(arrTmpObj);
			}
			arrTmpObj = [];
		}
	}
}

function fnSernrLoadFileHandler(){
// 	console.log('fnSernrLoadFileHandler()');
	var page_url = "/file/sernrlist_import_upload";
	
	$('#sernrfileupload').fileupload({
		url : page_url,
		dataType : 'json',
		async:false,
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
		var selRowData = w2ui['gridPo'].get(w2ui['gridPo'].getSelection())
// 		var selRowData = $("#"+selectGridId).getRowData(mainKey);
		
		var backupSernrArr = [];
		$.each(w2ui['gridSernr'].records, function(idx, row){
			if( row.sernp != 'V001' )
				backupSernrArr.push(row);
		});
		var arrData = data.result.rows;
// 		var priData = [];
		$.each(arrData, function(idx, row){
			if( $.trim(row.equnr).length>0 ) {
				var tmpObj = {};
	// 			tmpObj.recid = idx+1;
				tmpObj.ebeln = row.ebeln;
				tmpObj.ebelp = row.ebelp;
				tmpObj.matnr = row.matnr;
				tmpObj.txz01 = row.txz01;
				tmpObj.menge = 1;
	// 			tmpObj.menge = selRowData.menge;
				tmpObj.zdeli_menge = 1;
				tmpObj.partial_seq = row.partial_seq;
				tmpObj.equnr = row.equnr;
				backupSernrArr.push(tmpObj);
// 				priData.push(tmpObj);
			}
		});
		$.each(backupSernrArr, function(idx, row){
			row.recid = idx+1;
		});
		
// 		console.log(backupSernrArr);
		/*
		for(var i=0; i<data.result.rows.length; i++ ){
			var tmpObj = {};
			tmpObj.recid = i;
			tmpObj.ebeln = selRowData[0].ebeln;
			tmpObj.matnr = selRowData[0].matnr;
			tmpObj.txz01 = selRowData[0].txz01;
			tmpObj.menge = 1;
// 			tmpObj.menge = selRowData.menge;
			tmpObj.zdeli_menge = 1;
			tmpObj.partial_seq = selRowData[0].partial_seq;
			tmpObj.equnr = arrData[i].equnr;
			priData.push(tmpObj);
		}
		*/
		w2ui['gridSernr'].records = backupSernrArr;
// 		w2ui['gridSernr'].records = backupSernrArr;
		w2ui['gridSernr'].refresh();
	}).on('fileuploadfail', function(e, data) {
		$.each(data.files, function(index) {
			fnMessageModalAlert("Notification", "File upload failed.");
		});
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}

function fnSubLoadFileHandler(){
	console.log('fnSubLoadFileHandler()');
	var page_url = "/file/sernrlist_import_upload";
	
	$('#subsernrfileupload').fileupload({
		url : page_url,
		dataType : 'json',
		async:false,
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
		var selRowData = w2ui['gridPoSub'].get(w2ui['gridPoSub'].getSelection())
// 		var selRowData = $("#"+selectGridId).getRowData(mainKey);
		var arrData = data.result.rows;
		console.log(arrData);
		var priData = [];
		$.each(arrData, function(idx, row){
			var tmpObj = {};
			tmpObj.recid = idx+1;
			tmpObj.ebeln = row.ebeln;
			tmpObj.ebelp = row.ebelp;
			tmpObj.matnr = row.matnr;
			tmpObj.txz01 = row.txz01;
			tmpObj.menge = 1;
			tmpObj.zdeli_menge = 1;
			tmpObj.equnr = row.equnr;
			priData.push(tmpObj);
		});
		
// 		for(var i=0; i<data.result.rows.length; i++ ){
// 			var tmpObj = {};
// 			tmpObj.recid = i;
// 			tmpObj.ebeln = selRowData[0].ebeln;
// 			tmpObj.matnr = selRowData[0].matnr;
// 			tmpObj.txz01 = selRowData[0].maktx;
// 			tmpObj.menge = 1;
// 			tmpObj.zdeli_menge = 1;
// 			tmpObj.equnr = arrData[i].equnr;
// 			priData.push(tmpObj);
// 		}
		w2ui['gridPoSubSernr'].records = priData;
		w2ui['gridPoSubSernr'].refresh();
	}).on('fileuploadfail', function(e, data) {
		$.each(data.files, function(index) {
			fnMessageModalAlert("Notification", "File upload failed.");
		});
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}

//일정변경확인
function checkSheduleSearch() {
// 	console.log('checkSheduleSearch()->checkSheduleSave()');
	
	var selRowData = w2ui.gridPo.get(w2ui.gridPo.getSelection());
// 	console.log(selRowData);
	if( selRowData.length==0 ){
		fnMessageModalAlert("Warning!", "확인하고자 하는 일정을 선택 후 시도하세요.");
		return;
	}
	// po는 1개이어야 한다. ebeln check
	// po
	var ebelnArr = [];
	$.each(selRowData, function(idx, row){
		ebelnArr.push(row.ebeln);
	});
	$.unique(ebelnArr);
	if(ebelnArr.length>1 ){
		fnMessageModalAlert("Warning!", "일정변경은 구매문서 1건 단위로 처리됩니다.");
		$.each(w2ui.gridPo.getSelection(), function(idx, sel){
			w2ui.gridPo.unselect(sel);
		});
		return;
	}
	
	// partial 입력수량 / 총수량 확인 IRIS
// 	var checkMengeArr = {};
// 	$.each(selRowData, function(idx, row){
// 		var tmpObj = {};
// 		tmpObj = { 'menge' : row.menge, 'zdeli_menge' : row.zdeli_menge };
// 		if( checkMengeArr.ebelp==undefined ) {
// 			checkMengeArr.ebelp = [];
// 		} else {
// 			(checkMengeArr.ebelp).push()tmpObj;
// 		}
// 	});
	/*
	var chkObj = checkPoList(ebelnArr[0]);
	if( chkObj.count!=selRowData.length ) {
		var msg = '다른일자에 해당 구매문서 정보가 존재합니다.<br>'
				+ '일정변경은 구매문서 단위로 처리됩니다.<br>'
				+ 'Tip)조회시 구매문서 전체가 조회되도록 일자 선택을 한 후 [구매문서번호]를 입력하여 조회 후 일정변경확인 을 처리합니다.<br>'
				+ '조회일자 : ' + chkObj.min_eindt + ' ~ ' + chkObj.max_eindt + '<br>'
				+ '구매문서 번호  : ' + chkObj.ebeln;
		fnMessageModalAlert("Warning!", msg);
		$.each(w2ui.gridPo.getSelection(), function(idx, sel){
			w2ui.gridPo.unselect(sel);
		});
		return;
	}
	*/
	// 일정변경 확인 이력 체크
	var chkCount = 0;
	$.each(selRowData, function(idx, row){
		if( row.rorder_status!='r1' && row.labnr_1!=null && row.labnr_1!='' && row.partial_yn=='Y' )
			chkCount++;
	});
	if( chkCount>0 ){
		fnMessageModalAlert("Warning!", "이미 진행중인 변경내역이 있습니다.<br>잠시후 재진행하시기 바랍니다.");
		return;
	}
	
	$("#m_choice").val('');
	$("#m_comment").val('');
	$('#commentArea').hide();
	$("#btn_comment_save").removeAttr("disabled");
	$("#btn_comment_cancel").removeAttr("disabled");
	$("#modal_comment").modal('show');
}

function checkPoList(ebeln) {
	console.log('checkPoList()');

	var page_url = "/frontend/scm/rawProc_select"
	var postData = 'ebeln=' + encodeURIComponent(ebeln);
	var returnObj = {};
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async : false,
		success : function(data, textStatus, jqXHR){
			if(data.status == "200") {
				var arrRows = data.rows;
				var arrDate = [];
				$.each(arrRows, function(idx, row){
					arrDate.push(new Date(row.eindt));
				});
				
				var maxDate = (new Date(Math.max.apply(null, arrDate))).toISOString().substr(0,10);
				var minDate = (new Date(Math.min.apply(null, arrDate))).toISOString().substr(0,10);
				
				returnObj.ebeln = ebeln;
				returnObj.count = arrRows.length;
				returnObj.max_eindt = maxDate;
				returnObj.min_eindt = minDate;
			} else {
				console.error('checkPoList(',ebeln,')');	
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			console.error('checkPoList(',ebeln,')');	
		},
		complete: function() {}
	});
	return returnObj;
}

function checkSheduleSave() {
// 	console.log('checkSheduleSave()');
	if( $('#m_choice').val()=='' ) {
		fnMessageModalAlert("warning", "처리방법을 선택 후 저장버튼을 누르세요.");		
	} else {
		$("#btn_comment_save").attr("disabled", true);
		$("#btn_comment_cancel").attr("disabled", true);
		if( $('#m_choice').val()=='A' ){
			// 확인
			setTimeout(function(){
				updateStatus('r3'); }, 1000);
		} else if( $('#m_choice').val()=='B' ){
			// 반려
			updateStatus('r2');
		}	
	}
}

function updateStatus(status) {
	console.log('updateStatus(',status,')');
	var dataArr = w2ui.gridPo.get(w2ui.gridPo.getSelection());
	var sendDataArr = [];
	$.each(dataArr, function(idx, row){
		if( row.rvendor_status!='v4' && row.rorder_status!='r4' ) {
			sendDataArr.push(row);
			if( row.vendor_delivery_date==null || row.vendor_delivery_date=='' ) {
				row.vendor_delivery_date = row.eindt;
			}
		}
	});
	
	var page_url = "/frontend/scm/confirmSchedule_proc"
	var postData = 'gridData=' + encodeURIComponent(JSON.stringify(sendDataArr))
				 + '&rorder_status=' + encodeURIComponent(status)
// 				 + '&confirm_yn=Y'
				 + "&jidat_from=" + encodeURIComponent($("#decide_date_range").val().substring(0,10))
				 + "&jidat_to=" + encodeURIComponent($("#decide_date_range").val().substring(13,23));

	if( status=='r2' ){
		postData += '&comment=' + encodeURIComponent($("#m_comment").val());
		postData += '&order_delivery_date=' + encodeURIComponent(sendDataArr[0].order_delivery_date);
		postData += '&rvendor_status=v3';
	} else {
		postData += '&diff_date=' + encodeURIComponent('N')
				 + '&rvendor_status=v2';
	}
	
	$.ajax({
	    url : page_url,
	    data : postData,
	    type : "POST",
	    async : false,
	    success : function(data, textStatus, jqXHR){
	    	$('#modal_comment').modal('hide');
			$("#btn_comment_save").removeAttr("disabled");
			$("#btn_comment_cancel").removeAttr("disabled");
	    	if(data.status == "200") {
		    	fnMessageModalConfirm("처리결과", "정보를 저장하였습니다.", function(chk){
	    			if(chk){
	    				$('#grid_sernr').jqGrid('clearGridData');
 						reloadGridPo();
	    			}
	    		});
	    	} else {
	    		fnMessageModalAlert("오류발생", "정보를 저장하는데 에러가 발생하였습니다.");	
	    		
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("오류발생", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
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

function excelFileDownload(gridName) {
// 	console.log('excelFileDownload('+gridName+')');
	
	var gridCols = w2ui[gridName].columns;
	var gridData = w2ui[gridName].records;

	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	
	if( gridName=='gridSernr' ) {
		fileName = '시리얼_대상목록.xlsx';
		sheetTitle = '시리얼 대상목록';
		sheetName = '시리얼 대상목록';
	} else if( gridName=='gridPoSubSernr' ) {
		fileName = '사급자재_시리얼_대상목록.xlsx';
		sheetTitle = '사급자재 시리얼 대상목록';
		sheetName = '사급자재 시리얼 대상목록';
	}
	
// 	if( gridName=='gridProc' ) {
// 		fileName = '입고요청목록.xlsx';
// 		sheetTitle = '입고요청목록';
// 		sheetName = '입고요청목록';

	
	var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
	var is_rownum = true;
	
	if(gridCols != null && gridCols.length > 0){
		// w2grid 는 linenumber column info not exist
		param_col_name = "No"
		param_col_id = "rownum";
		param_col_align = "center";
		param_col_width = "80";
		param_col_name += ",선택";
		param_col_id += ",rn";
		param_col_align += ",left";
		param_col_width += ",80";
		//--------------------------------------------
		for(var i=0; i<gridCols.length; i++){
			if(!gridCols[i].hidden){
				var caption = gridCols[i].caption;
				if( gridName=='gridPo' && (caption=='벤더 요청일자' || caption=='납품수량')){
					param_col_name += "," + caption + '(*)';
				}else if( gridName=='gridSernr' && caption=='순차관리번호' ){
					param_col_name += "," + caption + '(*)';
				}else if( gridName=='gridPoSubSernr' && caption=='순차관리번호' ){
					param_col_name += "," + caption + '(*)';
				}else{
					param_col_name += "," + caption;
				}
				param_col_id += "," + gridCols[i].field;
				param_col_align += ",left";
				param_col_width += "," + (gridCols[i].width==undefined?"80":(gridCols[i].width).replace('px',''));
			}
		}
	}
	
	var export_url = "/export/export_client_jqgrid";
	var export_data = "file_name="+encodeURIComponent(fileName);
		export_data += "&sheet_title="+encodeURIComponent(sheetTitle);
		export_data += "&sheet_name="+encodeURIComponent(sheetName);
		export_data += "&header_col_names="+encodeURIComponent(param_col_name);
		export_data += "&header_col_names="+encodeURIComponent(param_col_name);
		export_data += "&header_col_ids="+encodeURIComponent(param_col_id);
		export_data += "&header_col_aligns="+encodeURIComponent(param_col_align);
		export_data += "&header_col_widths="+encodeURIComponent(param_col_width);
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

function saveSerials(selSernrData, selRowData) {
// 	console.log('saveSerials()');	
 
 	var returnVal = false;
	var rawValidationChk_result = rawValidationChk(selSernrData);		
	if(rawValidationChk_result == false) {
		//fnSearchGoodsList();
		//$('#grid_po').jqGrid('setSelection',mainKey, true);
		return;
	}
// 	var gridDataArr = w2ui.gridSernr.records;
// 	var selectPo = w2ui.gridPo.get(w2ui.gridPo.getSelection()[0]);
// 	console.log(selectPo);
	// 그리드에서 직접 수정하는 경우 w2ui.changes.의 해당 컬럼명으로 변경된 데이터가 들어온다
	// 엑셀에서 시리얼을 입력하는 경우 records로 데이터를 가져올 수 있다
// 	if (gridDataArr[0].w2ui!=undefined){
// 		$.each(gridDataArr, function(idx, row){
// 			var equnr;
// 			if(row.w2ui==undefined)
// 				equnr = row.equnr;
// 			else
// 				equnr = row.w2ui.changes.equnr;
// 			row.equnr = equnr;
// 		});
// 	}
// 	$.each(gridDataArr, function(idx, row){
// 		row.ebelp = selectPo.ebelp;
// 	})
	
// 	console.log(gridDataArr);
// 	var selection = w2ui.gridPo.getSelection()[0];
// 	var selGridRowData = w2ui.gridPo.get(selection);
	var page_url = "/frontend/scm/scmProc_sernr_insert"
	var postData = 'gridData=' + encodeURIComponent(JSON.stringify(selSernrData))
				 + '&werks=' + encodeURIComponent(selRowData.werks)
				 + '&lgort=' + encodeURIComponent(selRowData.lgort);
// 				 + '&werks=' + encodeURIComponent(selGridRowData.werks)
// 				 + '&lgort=' + encodeURIComponent(selGridRowData.lgort);

// 	return;
// 	console.log(gridDataArr);
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    async : false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
// 	    		console.log('시리얼 정보 저장');
// 		    	fnMessageModalConfirm("Notification(SCM)", "정보를 저장하였습니다.", function(chk){
// 		    		if(chk){
						reloadGridPo();
// 						w2ui.gridSernr.clear();
// 	    				w2ui.gridPo.select(selection);
	    				returnVal = true;
// 	    			}
// 	    		});
	    	} else {
	    		fnMessageModalAlert("Fail", "시리얼 정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Error", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
	return returnVal;
}

function rawValidationChk(selSernrData) {
// 	console.log('rawValidationChk()');
	
	var rawValidationChk_result = null;
// 	var gridDataArr = w2ui.gridSernr.records;
// 	var selRowData = w2ui.gridPo.get(w2ui.gridPo.getSelection());
	var arrSernr = [];

	$.each(selSernrData, function(idx, row){
		arrSernr.push(row.equnr);
	});
// 	if (gridDataArr[0].w2ui!=undefined){
// 		$.each(gridDataArr, function(idx, row){
// 			var equnr;
// 			if(row.w2ui==undefined)
// 				equnr = row.equnr;
// 			else
// 				equnr = row.w2ui.changes.equnr;
// 			row.equnr = equnr;
// 			arrSernr.push(equnr);
// 		});
// 	} else {
// 		$.each(gridDataArr, function(idx, row){
// 			arrSernr.push(row.equnr);
// 		});
// 	}

	// 순차관리  체크 박스
// 	var cntSerGridIDs = w2ui.gridSernr.get(w2ui.gridSernr.getSelection());
// 	if( gridDataArr.length!=cntSerGridIDs.length ){
// 		fnMessageModalAlert("Warning", "체크되지 않은 항목이 았습니다.<br>모든 항목을 체크해 주시기 바랍니다.");
// 		rawValidationChk_result = false;
// 		return false;
// 	}

	// 순차관리 null 입력 여부 체크 
	$.each(selSernrData, function(idx, row){
		if( row.equnr == null || row.equnr == '') {
			fnMessageModalAlert("Warning", "순차관리번호를 입력해주십시오.");
			rawValidationChk_result = false;
			return false;
		}
	});	
// 	$.each(gridDataArr, function(idx, row){
// 		if( row.equnr == null || row.equnr == '') {
// 			fnMessageModalAlert("Warning", "순차관리번호를 입력해주십시오.");
// 			rawValidationChk_result = false;
// 			return false;
// 		}
// 	});	
	
	// 순차관리 중복 입력 여부 체크 
	$.unique(arrSernr);
	if( selSernrData.length!=arrSernr.length ){
		fnMessageModalAlert("Warning", "순차관리 번호를 중복 입력하였습니다.");
		rawValidationChk_result = false;
	}

	if(rawValidationChk_result == false) {
		return rawValidationChk_result;
	}
	
	// 시리얼번호  중복 DB 체크
	var page_url = "/frontend/scm/rawProc_sernr_duplication_chk";
	var postData = "sernrs=" + encodeURIComponent(arrSernr.toString());
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				var resultJson = JSON.parse(JSON.stringify(data));
				var rows = resultJson.rows;
// 				console.log(resultJson);
// 				console.log(selRowData[0].ebeln);
// 				console.log(rows[0].ebeln);
// 				console.log(rows[0].ebelp);
				var result_len = resultJson.rows.length;
				if(result_len > 0 && (selSernrData[0].ebeln!=rows[0].ebeln) && (selSernrData[0].ebelp!=rows[0].ebelp)) {
				
				//	fnMessageModalAlert("Warning", "순차관리번호가 기존 등록된 내역과 중복됩니다.");
					
					fnMessageModalConfirm("Warning", "시리얼번호가 기 등록된 내역과 중복됩니다.진행하시겠습니까? <br> 반품출고에 경우 확인버튼을 클릭하여 진행하세요", function(chk){
						if(chk){
						   
						}else
							rawValidationChk_result = false;
					});
			
				}	
		
			} else {
				rawValidationChk_result = false;	
				fnMessageModalAlert("Error", "시리얼번호 중복처리 확인을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "시리얼번호 중복처리 요청작업을 실패했습니다.");
		},
		complete : function() {}			
	});
	if(rawValidationChk_result == false) {
		return rawValidationChk_result;
	}
}

function pstypSernr() {
// 	console.log('pstypSernr()');
	/*
	1. 선택된 목록을 가져온다.
	2. 목록 중 po가 여러개인것은 처리 할 수 없다는 오류 메세지 표시하여 한개의 po만 가져올 수 있도록 한다.
	3. 한개의 po만 있다면, 사급상세 오더의 시리얼 번호를 입력하기 위한 팝업 창을 띄운다.
	*/
	var selectdGridData = w2ui.gridPo.get(w2ui.gridPo.getSelection());
	var ebelnArr = [];
	$.each(selectdGridData, function(idx, row){
		ebelnArr.push(row.ebeln);
	});
	var ebelnCnt = ($.unique(ebelnArr)).length;
	if ( ebelnCnt>1 ){
		fnMessageModalAlert("Warning...", "한개의 문서번호를 선택하여야 합니다.");
		return;
	}
	w2ui.gridPoSubSernr.clear();
	$("#modal_procSub").modal('show');
	
	setTimeout(function(){
		w2ui.gridPoSub.resize();
		reloadPoSubGrid();
		w2ui.gridPoSubSernr.resize();
// 		w2ui.gridPoSub.refresh();
		w2ui.gridPoSubSernr.refresh();
// 		w2ui.gridPoSub.reload();
		w2ui.gridPoSubSernr.reload();	
	}, 300);
	
}


function saveSubSerials() {
	console.log('saveSubSerials()');	
	
	var gridDataArr = w2ui['gridPoSubSernr'].records;
	$.each(gridDataArr, function(idx, row){
		row.partial_seq = '-';		
		if(row.w2ui!=undefined)
			row.equnr = row.w2ui.changes.equnr;
	});	
	var selection = w2ui['gridPoSub'].getSelection()[0];
	var selGridRowData = w2ui['gridPoSub'].get(w2ui['gridPoSub'].getSelection())[0];
	var page_url = "/frontend/scm/scmProc_sernr_insert"
	var postData = 'gridData=' + encodeURIComponent(JSON.stringify(gridDataArr))
				 + '&partial_seq=' + encodeURIComponent('-')
				 + '&ebelp=' + encodeURIComponent(selGridRowData.ebelp)
				 + '&werks=' + encodeURIComponent(selGridRowData.werks)
				 + '&lgort=' + encodeURIComponent(selGridRowData.lgort);
// 	console.log(selGridRowData);
// 	console.log(gridDataArr);
// 	return;
	
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalConfirm("Notification(SCM)", "정보를 저장하였습니다.", function(chk){
		    		if(chk){
// 						updateStatus();
// 	    				w2ui['gridPoSubSernr'].clear();
// 	    				reloadGridProc();
// 	    				w2ui['gridProc'].select(selection);
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
	/*
	var gridDataArr = w2ui['gridPoSubSernr'].records;
	var selection = w2ui['gridPoSub'].getSelection()[0];
	var selGridRowData = w2ui['gridPoSub'].get(w2ui['gridPoSub'].getSelection())[0];
	console.log(selGridRowData);
	var page_url = "/frontend/scm/scmProc_sernr_insert"
	var postData = 'gridData=' + encodeURIComponent(JSON.stringify(gridDataArr))
				 + '&partial_seq=' + encodeURIComponent('-')
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
// 						updateStatus();
// 	    				w2ui['gridProcSubSernr'].clear();
// 	    				reloadGridProc();
// 	    				w2ui['gridProc'].select(selection);
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
	*/
}

function initGridArrival() {
// 	console.log('initGridArrival()');
	$("#grid_arrival").w2grid({ 
        name: 'grid_arrival',
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
			{ field : 'ebeln', caption:'구매문서 ', size:'100px', style:'text-align:center'}, 
			{ field : 'ebelp', caption:'문서순번 ', size:'50px', style:'text-align:center'}, 
			{ field : 'aedat', caption:'생성일자', size:'95px', style:'text-align:center'}, 
			{ field : 'eindt', caption:'납품일자', size:'95px', style:'text-align:center'}, 
			{ field : 'vendor_delivery_date', caption:'요청일자(Vendor)', size:'95px', style:'text-align:center'}, 
			{ field : 'confirm_date', caption:'최종납품일자', size:'95px', style:'text-align:center'}, 
			{ field : 'partial_seq', caption:'분기순번', hidden:true} ],
      	sortData: [{field: 'ebeln', direction: 'ASC'}, {field: 'ebelp', direction: 'ASC'}],
      	records : []
	});
}

function modalArrival() {
// 	console.log('modalArrival()');
	
	if( $("#selectKind").val()!="case2" ){
		fnMessageModalAlert("Warning", "납품관리 목록 상단의 선택에서 [입하처리] 상태로 선택한 후 다시 이용하시기 바랍니다.<BR>입하처리는 구매문서별 요청 일자별로 실행됩니다.");
		return;
	}
	
	var selRowData = w2ui.gridPo.get(w2ui.gridPo.getSelection());
	if( selRowData.length==0 ){
		fnMessageModalAlert("Warning", "입하처리 대상이 선택되지 않았습니다.");
		return;
	}
	// partial_yn 이 한건이라도 "Y"가 있는 경우 그리고.. confirm_date가 없는 경우, 일정변경 확인을 반드시 누르도록 유도 한다.
	var cnt_partialYN = 0;
	var cnt_diffdate = 0;
	var cnt_menge = 0;
	$.each(selRowData, function(idx, row){
		if( row.partial_yn=="Y" ) cnt_partialYN++;
		if( row.diff_date=="Y" && (row.vendor_delivery_date!=null || row.vendor_delivery_date!=undefined || row.vendor_delivery_date!='')) cnt_diffdate++;
		if( row.zdeli_menge!=row.menge ) cnt_menge++;
	});

// 	console.log('cnt_partialYN : ', cnt_partialYN);
// 	console.log('cnt_menge : ',cnt_menge);
// 	console.log('cnt_diffdate : ',cnt_diffdate);
	
	if( cnt_partialYN>0 ) {
		if( cnt_menge>0 ) {
			var msg = "반드시 [일정변경확인] 버튼을 눌러 실행 후 입하처리를 하여야 합니다.<br>"
					+ "* 구매오더 확인(Vendor) 에서 구매문서내용을 분기한 경우<br>"
					+ "* 최종 납품일자가 확정되지 않은 경우<br>"
					+ " &nbsp;(Vendor에서 내용을 분기 후 저장하지 않은 경우)"
					+ "* 만약 일정 변경을 했다면, 해당 데이터가 SAP시스템에서 update되지 않은 경우<br>";
			fnMessageModalAlert("Warning", msg);
			return;
		}
	} else {
		if( cnt_diffdate>0 ) {
			var msg = "반드시 [일정변경확인] 버튼을 눌러 실행 후 입하처리를 하여야 합니다.<br>"
					+ "* 구매오더 확인(Vendor) 에서 구매문서내용을 분기한 경우<br>"
					+ "* 최종 납품일자가 확정되지 않은 경우<br>"
					+ " &nbsp;(Vendor에서 내용을 분기 후 저장하지 않은 경우)";
			fnMessageModalAlert("Warning", msg);
			return;
		}
	}
	
	w2ui.grid_arrival.clear();
// 	var selRowData = w2ui.gridPo.get(w2ui.gridPo.getSelection());
	var dataArr = [];
	$.each(selRowData, function(idx, row){
		var tmpObj = {};		
		tmpObj.recid = idx+1;
		tmpObj.ebeln = row.ebeln;
		tmpObj.ebelp = row.ebelp;
		tmpObj.partial_seq = row.partial_seq;
		tmpObj.aedat = row.aedat;
		tmpObj.eindt = row.eindt;
		tmpObj.vendor_delivery_date = row.vendor_delivery_date;
		tmpObj.confirm_date = row.confirm_date;
		dataArr.push(tmpObj);
	});
//  	console.log(selRowData);
	w2ui.grid_arrival.records = dataArr;
	
	$("#a_order_delivery_date").datepicker("setDate",  replaceAll(getTodayDate().substring(0, 10),'.','-'));
		
	$("#modal_arrival").modal('show');
	setTimeout(function(){
		w2ui.grid_arrival.resize();
		w2ui.grid_arrival.refresh();
	}, 200);
}

//입하처리
function processArrivalGoods() {
// 	console.info('processArrivalGoods()');
	var validateChk = false;
	var serialRowData = w2ui.gridSernr.records;
	$.each(serialRowData, function(idx, row){
		if( row.w2ui!=undefined && row.w2ui.changes.equnr!=undefined ){
			row.equnr = row.w2ui.changes.equnr;
		}
	});
	
	var poData = w2ui.gridPo.get(w2ui.gridPo.getSelection());
	var arrivalData = w2ui.grid_arrival.get(w2ui.grid_arrival.getSelection());
	var selRowData = [];
	// 납품관리 목록에서 선택된 사항을 팝업 그리드에서 뿌려준다.
	// 팝업 그리드에서 선택된 데이터만 추출하여 입하처리데이터로 전송한다.
	if( arrivalData.length==0 || arrivalData.length==(w2ui.grid_arrival.records).length ) {
		// 팝업  그리드에서 아무것도 선택하지 않거나 모두 선택한 경우 납품관리목록에서  선택한 전체 데이터를 입하대상으로 본다. 
		selRowData = poData;
	} else {
		// 팝업에서 선택한 데이터의 경우, 정보가 충분하지 않으므로 해당 정보 ebeln, ebelp, partial_seq로 비교하여 해당데이터를 추출한다.
		$.each(arrivalData, function(idx, row){
			$.each(poData, function(idx2, prow){
				if( row.ebeln==prow.ebeln && row.ebelp==prow.ebelp && row.partial_seq==prow.partial_seq ) {
					selRowData.push(prow);
				}
			});	
		});
	}
// 	console.log(selRowData);
	// 입력한 입하일자로 세팅해준다.
 	$.each(selRowData, function(idx, row){
		row.order_delivery_date = $("#a_order_delivery_date").val();
 	});
	
 	// 입하대상 데이터가 확정되었으니 시리얼 데이터도 해당데이터만 넘기도록 한다.
 	var selSernrData = [];
 	if( arrivalData.length==0 || arrivalData.length==(w2ui.grid_arrival.records).length ) {
		// 팝업  그리드에서 아무것도 선택하지 않거나 모두 선택한 경우 납품관리목록에서  선택한 전체 데이터를 입하대상으로 본다. 
		selSernrData = serialRowData;
	} else {
		// 팝업에서 선택한 데이터의 경우, 정보가 충분하지 않으므로 해당 정보 ebeln, ebelp, partial_seq로 비교하여 해당데이터를 추출한다.
		$.each(selRowData, function(idx, row){
			$.each(serialRowData, function(idx2, srow){
				if( row.ebeln==srow.ebeln && row.ebelp==srow.ebelp && row.partial_seq==srow.partial_seq ) {
					selSernrData.push(srow);
				}
			});	
		});
	}
 	// for refresh select data
// 	var keyArr = w2ui.gridPo.getSelection();
	var keyArr = [];
	$.each(selRowData, function(idx, row){
		keyArr.push(row.recid);
	});
	
	// validate
	// 입하처리는 PO의 날자 단위로 처리된다.
	var poArr = [];
	var delDateArr = [];
	$.each(selRowData, function(idx, row){
		if( row.vendor_delivery_date=='' || row.vendor_delivery_date==undefined ) {
			row.vendor_delivery_date = row.eindt;
		}
		if( row.confirm_date==null || row.confirm_date=='' ){
			row.confirm_date = row.vendor_delivery_date;
		}
		if( row.order_delivery_date=='' || row.order_delivery_date==undefined )
			row.order_delivery_date = row.vendor_delivery_date; 
		poArr.push(row.ebeln);
		delDateArr.push(row.vendor_delivery_date);
	});
	$.unique(poArr);
	$.unique(delDateArr);
	if( poArr.length>1 ){
		fnMessageModalAlert("Warning", "입하처리는 구매문서 건단위로 처리됩니다.<br>관리 목록에서 다시 선택해 주시기 바랍니다.");
		return;
	}
	if( delDateArr.length>1 ){
		fnMessageModalAlert("Warning", "입하처리는 구매문서 건단위, 일자별로 처리됩니다.<br>관리 목록에서 다시 선택해 주시기 바랍니다.");
		return;
	}
	
	// 시리얼 대상자 체크 ??
	var cnt = 0;
	var serialSave = false;
	$.each(selSernrData, function(idx, row){
		if( row.sernp=='V001' && (row.equnr=='' || row.equnr==undefined) ) cnt++;
	});
	if( cnt>0 ){
		fnMessageModalAlert("Warning", "시리얼 대상이므로 반드시 시리얼 번호를 모두 입력->저장 후, 입하처리를 실행하여야 합니다.<br>시리얼 번호를 모두 입력하였는지 확인하세요.");
		return;
	}
	/*
	if( selRowData[0].sernp=='V001' ){
		$.each(serialRowData, function(idx, row){
			if( row.equnr=='' || row.equnr==undefined ) cnt++;			
		});
		if( cnt>0 ){
			fnMessageModalAlert("Warning", "시리얼 대상이므로 반드시 시리얼 번호를 모두 입력->저장 후, 입하처리를 실행하여야 합니다.<br>시리얼 번호를 모두 입력하였는지 확인하세요.");
			return;
		}
	}
	*/
	if( (selRowData[0].sernp=='V001') && cnt==0 ) {
		serialSave = saveSerials(selSernrData, selRowData[0]);
		if( !serialSave ) return;
	}
	
	// checkbox
// 	var selectSernrData = w2ui.gridSernr.get(w2ui.gridSernr.getSelection());
// 	if( serialRowData.length!=selectSernrData.length ){
// 		fnMessageModalAlert("Warning", "체크되지 않은 항목이 았습니다.<br>모든 항목을 체크해 주시기 바랍니다.");
// 		validateChk = true;
//  		return false;
// 	}

	if( validateChk ) {
		return;
	}
	
	var page_url = "/frontend/scm/arrivalOfGoods_proc"
	var postData = 'funcName=ZMMFM_GOODSMVT_PO'
				 + '&selRowData=' + encodeURIComponent(JSON.stringify(selRowData))
				 + '&serialData=' + encodeURIComponent(JSON.stringify(selSernrData))
				 + '&uKeyArr=' + encodeURIComponent(JSON.stringify(poArr));
// 	console.log(poArr);
	$("#btn_processArrivalGoods").attr("disabled", true);
	$("#btn_processArrivalGoods_cancel").attr("disabled", true);
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
// 	    	console.warn(data);
	    	if(data.status == "200") {
// 	    		fnMessageModalAlert("Notification(SCM)", "success - "+JSON.stringify(data.rows));	
// 				console.log(data.rows);
				if( data.rows.EV_STATUS=="S" ){
					fnMessageModalConfirm("Success", "정보를 저장하였습니다.<br>(YEAR : "+ data.rows.EV_MJAHR +" / MMDOC : "+ data.rows.EV_MBLNR +")", function(chk){
						if(chk) {
							reloadGridPo(keyArr);
						}
					});
				} else {
// 					var msg = '';
// 					if( data.rows.EV_MESSAGE != null ) msg = data.rows.EV_MESSAGE; 
					if( data.rows.EV_MESSAGE==null ){
						fnMessageModalAlert("Fail", "정보를 저장하는데 에러가 발생하였습니다.");
					} else {
						fnMessageModalAlert("Fail", "정보를 저장하는데 에러가 발생하였습니다.<br>rfc-message) " + msg);	
					}
				}
	    	} else {
	    		var msg = '';
				if( data.rows.EV_MESSAGE != null ) msg = data.rows.EV_MESSAGE;
	    		fnMessageModalAlert("Fail(500)", "정보를 저장하는데 에러가 발생하였습니다.<br>rfc-message) " + msg);
	    	}
			$("#btn_processArrivalGoods").removeAttr("disabled");
			$("#btn_processArrivalGoods_cancel").removeAttr("disabled");
	    	$("#modal_arrival").modal('hide');
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

// function modal_close() {
// 	console.log('modal_close()');
// 	if( $("#btn_comment_save").attr("disabled")!=undefined || $("#btn_comment_save").attr("disabled")!=null ) {
// 		fnMessageModalAlert("Warning", "처리중입니다.<br>다시 시도할 경우 문제가 발생할 수 있으니 기다려주시기 바랍니다.");
// 		return;
// 	} else {
// 		$("#modal_comment").modal("hide");
// 	}
// }

</script>
</body>
</html>