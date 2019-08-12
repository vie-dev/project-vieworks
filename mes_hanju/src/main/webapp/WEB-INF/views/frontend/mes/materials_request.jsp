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
		<jsp:param name="selected_menu_p_cd" value="1010" />
		<jsp:param name="selected_menu_cd" value="1058" />
	</jsp:include>

	<div class="content-wrapper">
		<section class="content-header">
			<h1>
				MES <small>자재 요청</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> MES</a></li>
				<li class="active">자재 요청</li>
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
									class="btn btn-primary btn-sm">조회</button>
								<button type="button" id="btn_search_init"
									class="btn btn-primary btn-sm">조건초기화</button>
							</div>
						</div>
						<div id="" class="box-body">
							<div class="row">
								<div class="col-sm-2">
									<div class="form-group">
										<label>| 확정내역일자</label>
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input type="text" class="form-control pull-right"
												id="register_date_range">
										</div>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="form-group">
										<label>| 요청여부</label><br /> <label> <input type="radio"
											name="rdo_req_type" class="flat-red" value="" checked>
											전체 
										</label> <label> <input type="radio" name="rdo_req_type"
											class="flat-red" value="Y"> 요청
										</label> <label> <input type="radio" name="rdo_req_type"
											class="flat-red" value="N"> 미요청
										</label>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">확정 내용 목록</h3>
								</div>
								<div id="dv_grid_reg" class="box-body">
<!-- 								<div class="box-body"> -->
<!-- 									<div class="box-tools" style="padding-bottom: 5px;"></div> -->
<!-- 								</div> -->
									<table id="grid_reg"></table>
									<div id="grid_reg_pager"></div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">확정 내용 상세 정보</h3>
								</div>
								<div id="dv_grid_reg_detail" class="box-body">
									<table id="grid_reg_detail"></table>
									<div id="grid_reg_detail_pager"></div>
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
<script type="text/javascript">
$(function($) {
	fnLoadCommonOption();
	fnLoadRegListGrid();//fnSearchMainGrid
	fnLoadRegListDetailGrid();//fnSearchMainGrid
	initScreenSizeModal();
})

// search component setting
function fnLoadCommonOption() {
	$(window).bind('resize', function() {
		resizeJqGrid("grid_reg", false);
		resizeJqGrid("grid_reg_detail", false);
	}).trigger('resize');
	
	$('input[type="radio"].flat-red').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green',
		handle: 'radio'
	});
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
}

// serch parameter setting
function fnSearchMasterCodeGrid(){
	var date1 = $("#register_date_range").val().substring(0,10);
	var date2 = $("#register_date_range").val().substring(13,23);
 
	var page_url = "/frontend/mes/metrial_req_select"
				 + "?jidat_from=" + encodeURIComponent(date1)
				 + "&jidat_to=" + encodeURIComponent(date2)
				 + "&requester_status=" + encodeURIComponent($(':radio[name="rdo_req_type"]:checked').val());
	
	$("#grid_reg").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_reg").trigger("reloadGrid");
}

// serch result grid
function fnLoadRegListGrid(){
	var date1 = $("#register_date_range").val().substring(0,10);
	var date2 = $("#register_date_range").val().substring(13,23);
	
	var page_url = "/frontend/mes/metrial_req_select"
				 + "?jidat_from=" + encodeURIComponent(date1)
				 + "&jidat_to=" + encodeURIComponent(date2)
				 + "&requester_status=" + encodeURIComponent($(':radio[name="rdo_req_type"]:checked').val());

	$("#grid_reg").jqGrid({
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
		pager : "#grid_reg_pager",
		rowNum:20,
		rowList : [ 20, 50, 100 ],
	    height: 455,
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
// 	    	console.log(data);
	    },
		onSelectRow: function(rowid, selected) {
			if(rowid != null) {
				fnSearchDetailGrid(rowid);
			}					
		}
	}); 
}

//master grid click row => search detail
function fnSearchDetailGrid(rowid) {
	var pordNo = $('#grid_reg').jqGrid('getRowData', rowid).pordno;
	var page_url = "/frontend/mes/metrial_req_detail_select"
// 		 + "?pordno=" + encodeURIComponent(pordNo)
		 + "?pordno=1000001"
		 + "&functionName=ZIFFM_POP_PP004";
	
	$("#grid_reg_detail").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_reg_detail").trigger("reloadGrid");
}

// detail grid setting
function fnLoadRegListDetailGrid() {
	
	var grid = $("#grid_reg");
	// check pordno
	var selected_master_code = grid.jqGrid('getGridParam',"selrow");
// 	console.log(selected_master_code);
	$("#grid_reg_detail").jqGrid({
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
		pager : "#grid_reg_detail_pager",
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    height: 455,
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

</script>
</body>
</html>