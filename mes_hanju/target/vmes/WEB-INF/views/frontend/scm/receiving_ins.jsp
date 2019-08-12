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
		<jsp:param name="selected_menu_cd" value="1041" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        SCM관리
        <small>수입검사</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> SCM관리</a></li><li class="active">수입검사</li>
      </ol>
    </section>

    <!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<div class="box box-success box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_search" class="btn btn-primary btn-sm">조회</button>
							<button type="button" id="btn_search_init" class="btn btn-primary btn-sm">조건초기화</button>
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-4">
								<div class="form-group">
									<label>| 확정내역일자</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right" id="register_date_range">
									</div>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group">
									<label>| 요청여부</label>
									<div class="form-group">
						                <select id="sel_req_type" class="form-control select2" data-placeholder="메뉴분류선택" style="width: 100%;">
						                  <option value="">전체</option>
						                  <option value="Y">요청</option>
						                  <option value="N">미요청</option>
						                </select>
						              </div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="box box-success box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">납품확인</h3>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-12">
								<div class="col-sm-6">
									<label>| 납품일자</label>
									<div class="form-group">
										<input type="input" id="deliver_date" name="deliver_date" class="form-control" placeholder="Dept Start Date" maxlength="10">
									</div>
								</div>
								<div class="col-sm-6">
									<label>&nbsp;</label>
									<div class="form-group">
										<button type="button" id="btn_buyreq" class="btn btn-success" onclick="deliveryConfirm()">납품확정</button>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="col-sm-12">
									<label>| 비고</label>
									<div class="form-group">
										<textarea id="deliver_status" name="deliver_status" class="form-control" placeholder="비고항목"></textarea>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div><!-- end row -->
		<div class="row">
			<div class="col-md-12">
				<div class="row">
					<div class="col-md-6">
						<div class="box" style="min-height: 350px;">
							<div class="box-header with-border">
								<h3 class="box-title">거래요청 목록</h3>
							</div>
							<div id="dv_grid_po" class="box-body">
								<table id="grid_po"></table>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="box" style="min-height: 350px;">
							<div class="box-header with-border">
								<h3 class="box-title">거래요청 상세 정보</h3>
							</div>
							<div id="dv_grid_po_detail" class="box-body">
								<table id="grid_po_detail"></table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div><!-- end row -->
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
	fnLoadRegListGrid();//fnSearchMainGrid
	fnLoadRegListDetailGrid();//fnSearchMainGrid
})

// search component setting
function fnLoadCommonOption() {
	$("#register_date_range").pressEnter(function(e) {
		e.preventDefault();
		if(e.target.id == "register_date_range"){
			fnSearchMasterCodeGrid();
		}
	});
	$('#register_date_range').daterangepicker({
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
	$( "#btn_search" ).on('click', function(e) {
		e.preventDefault();
		fnSearchMasterCodeGrid();
	});
	
	$("#deliver_date").datepicker({
		language: "kr",
		todayHighlight: true,
		format: "yyyy.mm.dd",
		autoclose: true
  	});
	
	$(window).bind('resize', function() {
		resizeJqGrid("grid_po", false);
		resizeJqGrid("grid_po_detail", false);
	}).trigger('resize');
}

// serch parameter setting
function fnSearchMasterCodeGrid(){
	var date1 = $("#register_date_range").val().substring(0,10);
	var date2 = $("#register_date_range").val().substring(13,23);
 
	var page_url = "/frontend/mes/metrial_req_select"
				 + "?jidat_from=" + encodeURIComponent(date1)
				 + "&jidat_to=" + encodeURIComponent(date2)
				 + "&requester_status=" + encodeURIComponent($('sel_req_type').val());
	
	$("#grid_po").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_po").trigger("reloadGrid");
}

// serch result grid
function fnLoadRegListGrid(){
	var date1 = $("#register_date_range").val().substring(0,10);
	var date2 = $("#register_date_range").val().substring(13,23);
	
	var page_url = "/frontend/mes/metrial_req_select"
				 + "?jidat_from=" + encodeURIComponent(date1)
				 + "&jidat_to=" + encodeURIComponent(date2)
				 + "&requester_status=" + encodeURIComponent($('sel_req_type').val());

	/*
	pordno_pop, pordno, rsnum, rspos, matnr, bdmng, meins,
	xloek, schgt, werks, lgort, dept_cd, requester_status, requester_if_status,
	request_if_msg, grantor_status, grantor_if_status, grantor_if_msg,
	creator, grantor, creator_date, grantor_date, date_created, date_updated

	
	*/
	$("#grid_po").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['','key', '사업부코드','사업부코드','확정코드', '요청상태', '요청사유', '작성자','요청일자', '생성일자','수정일자'],
		colModel:[
			{name:'chk',index:'chk', width:4, editable: true, align:'center', edittype: 'checkbox', editoptions: { value: "true:false", defaultValue: "false" },
	            formatter: "checkbox", formatoptions: { disabled: false }},
	        {name:'pordno_pop',index:'pordno_pop', width:20, sorttype:"text", sortable:true, hidden:true},
	        {name:'dept_cd',index:'dept_cd', width:20, sorttype:"text", sortable:true, hidden:true},
	        {name:'dept_nm',index:'dept_nm', width:20, sorttype:"text", sortable:true},
	        {name:'pordno',index:'pordno', width:20, sorttype:"text", sortable:true},
	        {name:'requester_status',index:'requester_status', width:20, sorttype:"text", sortable:true},
	        {name:'requester_if_status',index:'requester_if_status', width:20, sorttype:"text", sortable:true, hidden:true},
			{name:'creator',index:'creator', width:10, sorttype:"text", sortable:true},
			{name:'creator_date',index:'creator_date', width:20, sorttype:"text", sortable:true},
			{name:'date_created',index:'date_created', width:20, sorttype:"text", sortable:true},
			{name:'date_updated',index:'date_updated', width:20, sorttype:"text", sortable:true}
		],
		rowNum:1000,
	    height: 550,
	    width:270,
	    rownumWidth: 25,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
		altRows: true,
		rownumbers: true, 
	    autoencode: true,
	    loadonce: true,
	    sortable: true,
	    emptyrecords: "0 records found",
	    loadComplete : function(data){
	    	console.log(data);
	    },
		onSelectRow: function(rowid, selected) {
			if(rowid != null) {
				fnSearchDetailGrid(rowid);
			}					
		}
	}); 
}

// detail grid setting
function fnLoadRegListDetailGrid() {
	
	var grid = $("#grid_po");
	// check pordno
	var selected_master_code = grid.jqGrid('getGridParam',"selrow");
	console.log(selected_master_code);
	$("#grid_po_detail").jqGrid({
// 		url:page_url,
		datatype: "json",
		colNames:['예약번호','예약품목번호','자재번호','소요량','단위', '삭제표시', '벌크', '플랜트', '저장위치'],
		colModel:[
			{name:'rsnum',index:'rsnum', width:50, sorttype:"text", sortable:true, key: true},
			{name:'rspos',index:'rspos', hidden:true},
			{name:'matnr',index:'matnr', sorttype:"text", sortable:true},
			{name:'bdmng',index:'bdmng', sorttype:"text", sortable:true, hidden:true},
			{name:'meins',index:'meins', width:90, sorttype:"int", sortable:true},
			{name:'xloek',index:'xloek', width:40},
			{name:'schgt',index:'schgt', width:150, sortable:false},
			{name:'werks',index:'werks', width:60},
			{name:'lgort',index:'lgort', width:60}
		],
		rowNum:1000,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 550,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: true,
	    sortable: true,
	    sortname: "detail_code",
		loadComplete : function() {
		}
	});
	if(selected_master_code=!null){
		fnSearchDetailGrid(selected_master_code);
	}
}

// master grid click row => search detail
function fnSearchDetailGrid(rowid) {
	var pordNo = $('#grid_po').jqGrid('getRowData', rowid).pordno;
	var page_url = "/frontend/mes/metrial_req_detail_select"
// 		 + "?pordno=" + encodeURIComponent(pordNo)
		 + "?pordno=1000001"
		 + "&functionName=ZIFFM_POP_PP004";
	
	$("#grid_po_detail").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_po_detail").trigger("reloadGrid");
}

// push buying request button
function deliveryConfirm() {
	var altStr = '- 구매목록의 체크된 항목을 확인한다.\n'
				+ '- 한번에 체크된 한개의 구매목록만 요청처리한다.\n'
				+ '- 구매 상세 목록은 db에 저장되어 있는 것이 아니므로 상세 항목을 저장한다.\n'
				+ '- 요청 처리 프로세스 가동한다.\n'
				+ '- 구매요청이 확정되면 구매요청 목록 리프레쉬\n'
				+ '- 목록에 상태도 보여지지만 상태에 따라 거래명세서를 출력할 수 있도록 버튼이 생성된다.\n';
	alert(altStr);
}
</script>
</body>
</html>