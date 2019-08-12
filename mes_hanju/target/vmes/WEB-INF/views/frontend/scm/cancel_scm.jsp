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
		<jsp:param name="selected_menu_cd" value="1086" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        SCM관리
        <small>입하/입고/수입검사 취소</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> SCM관리</a></li><li class="active">입하/입고/수입검사 취소</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
    	<div class="row">
			<div class="col-md-12">
				<div class="box" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">검색조건</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_search" class="btn btn-primary btn-sm">조회</button>
							<button type="button" id="btn_calcel" onClick="cancelProcess();" class="btn btn-danger btn-sm">취소</button>
						</div>
					</div>
					<div class="box-body" style="padding-bottom: 0px;">
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-sm-2" style="padding: 0px 5px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 취소 구분</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="cancel_gubun" class="form-control select2 input-sm" data-placeholder="선택" style="width: 100%;">
											<option value="case1">입하/입고 취소</option>
											<option value="case2">수입검사 취소</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-2" style="padding: 0px 5px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 입하/입고일</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input type="text" class="form-control pull-right input-sm" id="decide_date_range">
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-2" style="padding: 0px 5px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| Vendor 코드</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="lifnr">
									</div>
								</div>
							</div>
							<div class="col-sm-2" style="padding: 0px 5px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 구매담당자</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="eknam">
									</div>
								</div>
							</div>
							<div class="col-sm-2" style="padding: 0px 5px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 구매문서</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="ebeln">
									</div>
								</div>
							</div>
							<div class="col-sm-2" style="padding: 0px 5px;">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 문서번호</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="sap_doc_no">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="gridPo" style="width: 100%; height: 653px;"></div>
					<div id="gridInsp" style="width: 100%; height: 653px;"></div>
				</div>
			</div>
		</div>
   	</section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
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
	fnLoadProcListGrid();
	fnLoadInspListGrid();
});

// search component setting
function fnLoadCommonOption() {
	
	$("#gridInsp").hide();
	
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
	
	$("#cancel_gubun").change(function(){
		if( $(this).val()=='case1' ) {
			$("#gridPo").show();
			w2ui.gridPo.resize();
			w2ui.gridPo.refresh();
			w2ui.gridPo.reload();
			$("#gridInsp").hide();
		} else {
			$("#gridInsp").show();
			w2ui.gridInsp.resize();
			w2ui.gridInsp.refresh();
			w2ui.gridInsp.reload();
			$("#gridPo").hide();
		}
	});
	
	$("#btn_search").click(function(){
		var gubun = $("#cancel_gubun").val();
		if( gubun=="case1" ) reloadGridPo();
		else reloadGridInsp();
	});
}

var chkArr = [];
function fnLoadProcListGrid() {
	console.log('fnLoadProcListGrid()');	
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
			{ field : 'confirm_yn', caption:'confirm_yn', size: '100px', hidden:true},
			{ field : 'mblnr',caption:'자재문서번호', size:'100px', style:'text-align:center'},
			{ field : 'mjahr',caption:'자재문서연도', size:'100px', style:'text-align:center'},
			{ field : 'partial_yn',caption:'partial_yn', hidden:true}
        ],
      	sortData: [{field: 'recid', direction: 'ASC'}],
		records: rowArr,
		recordHeight : 30,
		onReload: function(event) {
			reloadGridPo();
		},
		onClick: function (event) {
			event.onComplete = function () {
				var selectArr = w2ui.gridPo.getSelection();
		        var sel = Number(event.recid);
				var selectedData = this.get(sel);
				
				if( $.inArray(sel, chkArr) < 0 ){	// checkbox on
// 		        	console.log("checked");
		        	$.each(w2ui.gridPo.records, function(idx, row){
						if( selectedData.mblnr==row.mblnr && selectedData.mjahr==row.mjahr){
							w2ui.gridPo.select(row.recid);
							chkArr.push(row.recid);
						}
						$.unique(chkArr);
		        	});
		        } else if( $.inArray(sel, chkArr) > -1 ){	// checkbox off
// 		        	console.log("not checked");
		        	$.each(w2ui.gridPo.records, function(idx, row){
		        		if( selectedData.mblnr==row.mblnr && selectedData.mjahr==row.mjahr){
				        	w2ui.gridPo.unselect(row.recid);
				        	chkArr.splice(chkArr.indexOf(row.recid), 1);
						}
		        	});
		        }
		    }
		}
	});
	
	// 납품일정이 변경되면 목록에서 빨간색으로 해당 항목을 표시한다.
	var fDate = $("#decide_date_range").val().substring(0,10);
	var tDate = $("#decide_date_range").val().substring(13,23);
	var ebeln = $("#ebeln").val(); 
	var sap_doc_no = $("#sap_doc_no").val(); 
// 	var lifnr = $("#lifnr").val();
// 	var eknam = $("#eknam").val(); 
// 	var subgridData = [];
	
	var page_url = "/frontend/scm/rawProc_select"
				 + "?jidat_from=" + encodeURIComponent(fDate)
				 + "&jidat_to=" + encodeURIComponent(tDate)
				 + "&confirm_yn=Y"
				 + "&rorder_status=r4"
				 + "&rvendor_status=v4"
				 + "&ebeln=" + encodeURIComponent(ebeln)
				 + "&sap_doc_no=" + encodeURIComponent(sap_doc_no);

// 	if( $.trim(lifnr).length>0 ) 
// 		page_url += "&lifnr=" + encodeURIComponent($.trim(lifnr));
// 	if( $.trim(eknam).length>0 ) 
// 		page_url += "&eknam=" + encodeURIComponent($.trim(eknam));
	
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

function fnLoadInspListGrid() {
	console.log('fnLoadInspListGrid()');

	$("#gridInsp").w2grid({ 
        name: 'gridInsp',
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        columns: [                
// 			{ field : 'ebeln', caption:'구매문서 ', size: '100px', style:'text-align:center', frozen: true}, 
	        { field : 'ebeln', caption:'구매문서번호', size:'100px', style:'text-align:center'},
	        { field : 'ebelp', caption:'분기 순번', size:'70px', style:'text-align:center'},
	        { field : 'partial_seq', caption:'순번', size:'60px', style:'text-align:center'},
	        { field : 'name1', caption:'업체명', size:'120px'},
	    	{ field : 'matnr', caption:'품번', size:'150px'},
	    	{ field : 'maktx', caption:'자재내역', size:'180px'},
	    	{ field : 'wrkst', caption:'규격', size:'150px'},
	    	{ field : 'meins', caption:'단위', size:'50px', style:'text-align:center'},
	    	{ field : 'insp_gubun_nm', caption:'검사 구분', size:'70px', style:'text-align:center'},
	    	{ field : 'insp_check_gubun_nm', caption:'검사상세', size:'70px', style:'text-align:center'},
	    	{ field : 'insp_status_nm', caption:'상태', size:'100px', style:'text-align:center'},
	    	{ field : 'in_delivery_date', caption:'입하일자', size:'100px', style:'text-align:center'},
	    	{ field : 'in_confirm_date', caption:'입고일자', size:'100px', style:'text-align:center'},
	    	{ field : 'in_fail_date', caption:'불합격일자', size:'100px', style:'text-align:center'},
	    	{ field : 'order_delivery_date', caption:'구매오더일자', size:'100px', style:'text-align:center'},
	    	{ field : 'vendor_delivery_date', caption:'납품요청일자', size:'100px', style:'text-align:center'},
	    	{ field : 'menge', caption:'요청수량', size:'70px', render:'int'},
	    	{ field : 'zdeli_menge', caption:'납품수량', size:'70px', render:'int'},
	    	{ field : 'werks', caption:'플랜트', size:'70px', style:'text-align:center', render: function(record, index, col_index){
	    		if(this.getCellValue(index, col_index)=='1110') return '의료';
	    		else return '광';
	    	}},
	    	{ field : 'insp_gubun', caption:'검사 구분코드', hidden:true},
	    	{ field : 'insp_check_gubun', caption:'검사상세코드', hidden:true},
	    	{ field : 'insp_status', caption:'상태코드', hidden:true},
	    	{ field : 'confirm_date', caption:'최종납품일자', hidden:true},
	    	{ field : 'bukrs', caption:'회사코드', hidden:true},
	    	{ field : 'lgort', caption:'저장위치', hidden:true},
	    	{ field : 's_mblnr', caption:'자재문서번호_성공', hidden:true},
	    	{ field : 's_mjahr', caption:'자재문서연도_성공', hidden:true},
	    	{ field : 'mblnr_cancel', caption:'자재문서번호_불합격', hidden:true},
	    	{ field : 'mjahr_cancel', caption:'자재문서연도_불합격', hidden:true},
	    	{ field : 'sap_doc_no', caption:'납품문서번호', hidden:true},
	    	{ field : 'labnr', caption:'납품일정번호', hidden:true},
	    	{ field : 'in_labnr', caption:'in_labnr', hidden:true},
	    	{ field : 'lifnr', caption:'공급업체계정번호', hidden:true},
	    	{ field : 'success_yn', caption:'성공여부', hidden:true},
	    	{ field : 'fail_yn', caption:'실패여부', hidden:true},
	    	{ field : 'name1', caption:'공급업체명', hidden:true},
	    	{ field : 'txz01', caption:'납품내역', hidden:true}
		],
		sortData: [{field: 'recid', direction: 'ASC'}],
		recordHeight : 30,
		onReload: function(event) {
// 			console.log(event);
			reloadGridInsp();
		},
		onClick: function (event) {
			event.onComplete = function () {
				
			}
		}
	});
}

// function searchGrid() {
// 	console.log('searchGrid()');
// 	var gubun = $("#cancel_gubun").val();
// 	if( gubun=="case1" ) {
// 		reloadGridPo();
// 	} else {
// 		reloadGridInsp();
// 	}	
// }

function reloadGridPo() {
	console.log('reloadGridPo()');
	
	var fDate = $("#decide_date_range").val().substring(0,10);
	var tDate = $("#decide_date_range").val().substring(13,23);
	var ebeln = $("#ebeln").val(); 
	var sap_doc_no = $("#sap_doc_no").val(); 
// 	var lifnr = $("#lifnr").val();
// 	var eknam = $("#eknam").val(); 
	
	var page_url = "/frontend/scm/rawProc_select"
				 + "?jidat_from=" + encodeURIComponent(fDate)
				 + "&jidat_to=" + encodeURIComponent(tDate)
				 + "&confirm_yn=Y"
				 + "&rorder_status=r4"
				 + "&rvendor_status=v4"
				 + "&ebeln=" + encodeURIComponent(ebeln)
				 + "&sap_doc_no=" + encodeURIComponent(sap_doc_no);
				 
// 	if( $.trim(lifnr).length>0 ) 
// 		page_url += "&lifnr=" + encodeURIComponent($.trim(lifnr));
// 	if( $.trim(eknam).length>0 ) 
// 		page_url += "&eknam=" + encodeURIComponent($.trim(eknam));
	
	w2ui['gridPo'].clear();
	
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
	  		});
	  		w2ui['gridPo'].records = rowArr;
	  	}
	  	w2ui['gridPo'].refresh();
  		w2ui['gridPo'].unlock();
	  },complete: function () {}
	});
}

function reloadGridInsp() {
	console.log('reloadGridInsp()');
	
	var fDate = $("#decide_date_range").val().substring(0,10);
	var tDate = $("#decide_date_range").val().substring(13,23);
	var ebeln = $("#ebeln").val(); 
	var sap_doc_no = $("#sap_doc_no").val(); 
	
	var page_url = "/frontend/mes/inInsp_select"
		 + "?confirm_date_from=" + encodeURIComponent(fDate)
		 + "&confirm_date_to=" + encodeURIComponent(tDate)
		 + "&rorder_status=r4"
// 		 + "&rvendor_status=v4"
		 + "&ebeln=" + encodeURIComponent(ebeln)
		 + "&sap_doc_no=" + encodeURIComponent(sap_doc_no)
		 + "&not_insp_status=i1";

	
	w2ui['gridInsp'].clear();
	
	w2ui['gridInsp'].lock('loading...', true);
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
	  		});
	  		w2ui['gridInsp'].records = rowArr;
	  	}
	  	w2ui['gridInsp'].refresh();
  		w2ui['gridInsp'].unlock();
	  },complete: function () {}
	});
}

function cancelProcess() {
// 	console.log('cancelProcess()');
	
	var gubun = $("#cancel_gubun").val();
	var selectRowLeg = 0;
	if( gubun=='case1' ) {
		selectRowLeg = (w2ui.gridPo.getSelection()).length;		
	} else {
		selectRowLeg = (w2ui.gridInsp.getSelection()).length;
	}
	
	if( selectRowLeg==0 ) {
		fnMessageModalAlert("Warning", "취소처리 대상이 선택되지 않았습니다.");
		return;
	}
	
	if( gubun=='case1' ) {
		cancelRawProcTbl();		
	} else {
		cancelInspTbl();
	}
}

function cancelRawProcTbl() {
	console.log('cancelRawProcTbl()');

	var selectData = w2ui.gridPo.get(w2ui.gridPo.getSelection());
	var updateObj = [];
	var ebelnArr = [];
	$.each(selectData, function(idx, row){
		ebelnArr.push(row.ebeln);
		
		var tmpObj = {};
		tmpObj.ebeln = row.ebeln;
		tmpObj.ebelp = row.ebelp;
		tmpObj.partial_seq = row.partial_seq;
		updateObj.push(tmpObj);
	});
	$.unique(ebelnArr);
	// ebeln select count check
	if( ebelnArr.length>1 ) {
		fnMessageModalAlert("Warning", "입하/입고 취소는 구매문서의 처리단위로 실행됩니다.<br> 너무 많은 구매문서를 선택하였습니다.<br>다시 선택해 주세요.");
		return;
	}
	// insp_tbl info check
	var inspData = getInspData(selectData);
// 	if( inspData==null ) {
// 		fnMessageModalAlert("Warning", "수입검사 정보에서 해당 문서번호 정보를 조회할 수 없습니다.");
// 		return;
// 	} else if( inspData.length!=selectData.length ) {
	if( inspData!=null ) {
		if( inspData.length!=selectData.length ) {
			fnMessageModalAlert("Warning", "해당건은 다른일자에 동일 납품문서가 존재합니다.<br>일자를 재조회 하시기 바랍니다.");
			return;
		} else {
			$.each(inspData, function(idx, row){
				if( row.insp_status!='i1' ) {
					fnMessageModalAlert("Warning", row.ebeln + "은(는) 수입검사가 이미 완료된 사항입니다.<br>수입검사 취소 후 진행해 주세요.");
					return;
				}
			});
		}
	}
	
	var jObjArr = [];
	var jObj = {};
	jObj["iv_materialdocument"] = selectData[0].mblnr;
	jObj["iv_matdocumentyear"] = selectData[0].mjahr;
	jObj["iv_goodsmvt_pstng_date"] =  selectData[0].confirm_date;
	jObj["iv_documentheader_text"] = '';
	jObjArr.push(jObj);
	
	var page_url = "/frontend/scm/scm_cancel"
				 + "?gubun=" + encodeURIComponent($("#cancel_gubun").val())
				 + "&jstr=" + encodeURIComponent(JSON.stringify(jObjArr))
				 + "&updateObj=" + encodeURIComponent(JSON.stringify(updateObj));
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
			console.log(data);
			if(data.status == 200 ) {
	  			if( data.reason=='update success' ) {
	  				fnMessageModalAlert("Success", "취소 처리가 정상처리 되었습니다.");
	  				reloadGridPo();
	  			}
	  		} else {
	  			if( data.reason=='update fail(none)' ) {
	  				fnMessageModalAlert("Fail", "취소 처리가 실패하였습니다.<br>RAW_PROC_TBL UPDATE FAIL");
	  			}
	  			if( data.reason=='cancel rfc process fail' ) {
	  				fnMessageModalAlert("Fail", "취소 처리가 실패하였습니다.<br>" + data.rows[0].ev_message);
	  			}
	  			if( data.rows.ev_message!=null ) {
	  				fnMessageModalAlert("Fail", "취소 처리가 실패하였습니다.<br>" + data.rows[0].ev_message);
	  			}
	  		}
		},complete: function () {}
	});
}		

function getInspData(selectData) {
// 	console.log('getInspData()');
	
	var returnObj = null;
	var page_url = "/frontend/mes/inInsp_selectKey"
				 + "?mblnr=" + encodeURIComponent(selectData[0].mblnr)
				 + "&mjahr=" + encodeURIComponent(selectData[0].mjahr)
				 + "&ebeln=" + encodeURIComponent(selectData[0].ebeln);
				
	$.ajax({
		url : page_url,
		type : 'POST',
		async : false,
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
	  			returnObj = data.rows;
	  		}
		},complete: function () {}
	});
	return returnObj;
}

function cancelInspTbl() {
	console.log('cancelInspTbl()');
	
	var selectData = w2ui.gridInsp.get(w2ui.gridInsp.getSelection());
	// select count check
	if( selectData.length>1 ) {
		fnMessageModalAlert("Warning", "수입검사 취소는 한건씩 처리됩니다.");
		return;
	}
	
	var updateObj = [];
	$.each(selectData, function(idx, row){
		var tmpObj = {};
		tmpObj.ebeln = row.ebeln;
		tmpObj.ebelp = row.ebelp;
		tmpObj.partial_seq = row.partial_seq;
		updateObj.push(tmpObj);
	});

	var jObjArr = [];
	var jObj = {};
	if( selectData[0].insp_status=='i2' ) {
		jObj["iv_materialdocument"] = selectData[0].s_mblnr;
		jObj["iv_matdocumentyear"] = selectData[0].s_mjahr;
		jObj["iv_goodsmvt_pstng_date"] =  selectData[0].in_confirm_date;
	} else if( selectData[0].insp_status=='i3' ) {
		jObj["iv_materialdocument"] = selectData[0].mblnr_cancel;
		jObj["iv_matdocumentyear"] = selectData[0].mjahr_cancel;
		jObj["iv_goodsmvt_pstng_date"] =  selectData[0].in_fail_date;
	}
	jObj["iv_documentheader_text"] = '';
	jObjArr.push(jObj);
	
	var page_url = "/frontend/scm/scm_cancel"
				 + "?gubun=" + encodeURIComponent($("#cancel_gubun").val())
				 + "&jstr=" + encodeURIComponent(JSON.stringify(jObjArr))
				 + "&updateObj=" + encodeURIComponent(JSON.stringify(updateObj));
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
		 
			if(data.status == 200 ) {
	  			if( data.reason=='update success' ) {
	  				fnMessageModalAlert("Success", "취소 처리가 정상처리 되었습니다.");
	  				reloadGridInsp();
	  			}
	  		} else {
	  			if( data.reason=='update fail(none)' ) {
	  				fnMessageModalAlert("Fail", "취소 처리가 실패하였습니다.<br>RAW_PROC_TBL UPDATE FAIL");
	  			}
	  			if( data.ev_message!=null && data.reason=='cancel rfc process fail' ) {
	  				fnMessageModalAlert("Fail", "취소 처리가 실패하였습니다.<br>" + data.ev_message);
	  			}
	  			if( data.reason=="Exception" ) {
	  				fnMessageModalAlert("Fail", "취소 처리가 실패하였습니다.<br>" + data.rows[0].ev_message);
	  			}
	  		}
		},complete: function () {}
	});
}
</script>
</body>
</html>