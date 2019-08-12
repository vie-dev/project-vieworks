<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
// jsp properties
String thema = SessionUtil.getProperties("mes.thema");
String pageTitle = SessionUtil.getProperties("mes.company");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title> <%=pageTitle %> </title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
	<jsp:include page="/common/header_inc" flush="true"> 
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</head>

<body class="hold-transition skin-<%=thema%> sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1043"  />
		<jsp:param name="selected_menu_cd" value="1119" />
	</jsp:include>
	<div class="content-wrapper">
		<section class="content-header">
			<h1>
				출하관리 <small>출하계획</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> 출하관리</a></li>
				<li class="active">출하계획</li>
			</ol>
		</section>
		<section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="box" style="margin-bottom: 0px;">
						<!-- <div class="box-header with-border">
							<h3 class="box-title">조회조건</h3>
							<div class="box-tools pull-right">
								<div class="form-group">
									<select id="i_plant" class="form_group input-sm" onChange="searchGrid();">
									<select id="i_plant" class="form_group input-sm"   >
										<option value="1110">의료</option>
										<option value="1210">광영상</option>
									</select>
									<button type="button" id="" onclick="" class="btn btn-primary btn-sm">조회</button>  
									<button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_group');" data-selfilepath="/upload" data-selfilename="test.xlsx">
										<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
									</button>   
								</div>
							</div>
						</div> -->
						<div class="box-body" style="height:760px;">
							<div class="row">
								<div class="col-md-12">
									<div id="exTab3">	
										<ul class="nav nav-pills">
											<li id="list_tab" class="active"><a href="#list" data-toggle="tab">출하계획대상 목록</a></li>
											<li id="plan_tab"><a href="#plan" data-toggle="tab">출하계획편성</a></li>
<!-- 											<li><a href="#line_group" data-toggle="tab">Line Group</a></li> -->
<!-- 								  			<li><a href="#line" data-toggle="tab">Line</a></li> -->
										</ul>
										<div class="tab-content"><!-- clearfix -->
											<div class="tab-pane active" id="list" style="height:680px;">
												<div class="row">
													<div class="col-sm-3">
														<div class="form-group" style="margin-bottom: 0px;">
															<label>| 주문등록일</label>
															<div class="input-group">
						                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
						                                            <input type="text" class="form-control pull-right input-sm" id="posale_dt"> 
						                                     </div>
														</div>
													</div>
												<!-- 	<div class="col-sm-3">
														<div class="form-group" style="margin-bottom: 0px;">
															<label>| D/O 출고예정일</label>
															<div class="input-group">
						                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
						                                            <input type="text" class="form-control pull-right input-sm" id="wadat_register_date_range"> 
						                                     </div>
														</div>
													</div> -->
													<div class="col-sm-3">
														<div class="form-group" style="margin-bottom: 0px;">
															<label>| 납품처</label>
															<div class="form-group" style="margin-bottom: 0px;">
																<!-- <input type="text" class="form-control pull-right input-sm" id="name1_kunnr_we"> -->
<!-- 																<input type="text" class="form-control input-sm" id="lifnr_nm" value="" disabled> -->
																<input type="hidden" class="form-control input-sm" id="lifnr" value="">
																<div class="input-group">
															      <input type="text" class="form-control input-sm" id="lifnr_nm" placeholder="" disabled>
															      <span class="input-group-btn">
															        <button class="btn btn-primary btn-sm" type="button" onClick="fnPopupInfo('V');">
															          <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
															        </button>
															      </span>
															    </div>
															</div>
														</div>
													</div>
													<!-- <div class="col-sm-2">
													    <div class="form-group" style="margin-bottom: 0px;">
															<label>| 자재</label>
															<div class="form-group" style="margin-bottom: 0px;">
																<input type="text" class="form-control pull-right input-sm" id="matnr">
															</div>
														</div>
													</div> -->
													<div class="col-sm-3">
													    <div class="form-group" style="margin-bottom: 0px;">
															<label>| 프로젝트명</label>
															<div class="form-group" style="margin-bottom: 0px;">
																<!-- <input type="text" class="form-control pull-right input-sm" id="project_nm"> -->
																<input type="hidden" class="form-control input-sm" id="project_no" value="">
																<div class="input-group">
															      <input type="text" class="form-control input-sm" id="project_nm" placeholder="" disabled>
															      <span class="input-group-btn">
															        <button class="btn btn-primary btn-sm" type="button" onClick="fnPopupInfo('P');">
															          <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
															        </button>
															      </span>
															    </div>
															</div>
														</div>
													</div>
													<div class="col-sm-3">
														<div class="form-group text-right" style="margin-bottom: 0px;">
															<label>&nbsp;&nbsp;</label>
															<div class="form-group" style="margin-bottom: 0px;">
<!-- 																<input type="text" class="form-control pull-right input-sm" id="project_no"> -->
																<button type="button" class="btn btn-primary btn-sm" onClick="loadList();">조회</button>  
																<button type="button" class="btn btn-info btn-sm" onClick="fnMoveShipment();">출하계획편성 이동</button>  
															</div>
														</div>
													</div>
												</div>
												<div class="row" style="padding-top: 10px; height: 625px;">
													<div class="col-md-12" style="height:100%;width: 100%;">
														<div id="grid_list" style="width: 100%; height: 560px; "></div>
														<div id="pagination" class="text-center"></div>
													</div>
												</div>
											</div>
											<div class="tab-pane" id="plan"  style="height:680px;">
												<div class="row text-right">
													<div class="col-md-12" style="height:100%;width: 100%;">
														<button type="button" onclick="fnShipmentPlanCommit();" class="btn btn-success btn-sm">출하계획 확정</button>
													</div>
												</div>
												<div class="row" style="padding-top: 10px; height: 625px;">
													<div class="col-md-12" style="height:100%;width: 100%;">
														<div id="grid_plan" style="width: 100%; height: 600px; "></div>
														<div id="pagination1" class="text-center"></div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div><!-- tab area -->
							</div><!-- end tab row -->
						</div>
					</div>
				</div><!-- 공정그룹 목록 -->
		</section>
	</div>
<div class="modal fade" id="check_serial" data-backdrop="static">
    <div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">시리얼 상세<span id="key"></span></h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12">
						<div id="grid_serial" style="width: 100%; height: 500px;"></div>
					</div>
				</div>
	        </div>
		</div>
	</div>
</div>
<!-- start insert/update -->
<div class="modal fade" id="modal_vendor" aria-hidden="true" style="display: none; z-index: 1070;"> <!-- data-backdrop="static"> -->
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modal_v_title">거래처 목록</h4>
        	</div>
			<div class="modal-body" id="">
				<form id="frm_vendor" name="frm_vendor" class="form-horizontal">
					<div class="form-group row">
						<label for="" class="col-sm-2 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 거래처 코드</label>
						<div class="col-sm-3">
							<input type="text" class="form-control input-sm" id="code">
						</div>
						<label for="" class="col-sm-2 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 거래처 명</label>
						<div class="col-sm-4">
							<input type="text" class="form-control input-sm" id="name">
						</div>
						<div class="col-sm-1" style="padding-left: 0px;">
							<button type="button" onclick="fnSetLoadVendorGrid();" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</form>
				<div class="row">
					<div class="col-md-12">
						<div id="grid_vendor" style="width: 100%; height: 500px;"></div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_modal_vandor" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- project list -->
<div class="modal fade" id="modal_proj" aria-hidden="true" style="display: none; z-index: 1070;"> <!-- data-backdrop="static"> -->
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modal_v_title">프로젝트 목록</h4>
        	</div>
			<div class="modal-body" id="">
				<form id="frm_proj" name="frm_proj" class="form-horizontal">
					<div class="form-group row">
						<label for="" class="col-sm-2 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 거래처 코드</label>
						<div class="col-sm-3">
							<input type="text" class="form-control input-sm" id="code">
						</div>
						<label for="" class="col-sm-2 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 거래처 명</label>
						<div class="col-sm-4">
							<input type="text" class="form-control input-sm" id="name">
						</div>
						<div class="col-sm-1" style="padding-left: 0px;">
							<button type="button" onclick="fnSetLoadProjGrid();" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</form>
				<div class="row">
					<div class="col-md-12">
						<div id="grid_proj" style="width: 100%; height: 500px;"></div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_modal_vandor" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- commit list -->
<div class="modal fade" id="modal_commit" aria-hidden="true" style="display: none; z-index: 1070;"> <!-- data-backdrop="static"> -->
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modal_v_title">출하계획 확정</h4>
        	</div>
			<div class="modal-body" id="shipment">
				<!-- <div class="row">
					<div class="col-md-12">
						...
					</div>
				</div> -->
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- commit tamplete -->
<div id="commitTamp" style="display:none;">
<div class="box box-warning">
	<div class="box-header with-border">
		<h3 class="box-title" id="title">Collapsable</h3>
		<div class="box-tools pull-right">
			<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		</div>
	</div>
	<div class="box-body">
		 <form id="frm_temp" name="frm_temp"  class="form-horizontal">
			<div class="form-group row">
				<div class="col-sm-1"></div>
				<label for="" class="col-sm-3 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 출하예정일</label>
				<div class="col-sm-7">
					<input type="text" class="form-control input-sm" id="">
				</div>
				<div class="col-sm-1"></div>
			</div>
			<div class="form-group row">
				<div class="col-sm-1"></div>
				<label for="" class="col-sm-3 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 출하계획명</label>
				<div class="col-sm-7">
					<input type="text" class="form-control input-sm" id="">
				</div>
				<div class="col-sm-1"></div>
			</div>
			<div class="form-group row">
				<div class="col-sm-1"></div>
				<label for="" class="col-sm-3 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 비고</label>
				<div class="col-sm-7">
					<input type="text" class="form-control input-sm" id="">
				</div>
				<div class="col-sm-1"></div>
			</div>
		</form>
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

<style>
.tab {
    width: 100%;
    height: 300px;
    border: 1px solid silver;
    border-top: 0px;
    display: none;
    padding: 10px;
    overflow: auto;
}

#exTab3 .nav-pills > li > a {
  border-radius: 4px 4px 0 0 ;
}

#exTab3 .tab-content {
/*   color : white; */
  border : 1px solid #428bca;
  background-color: white;
  padding : 5px 15px;
}

</style>

<script src="/res/plugins/pagination.js"></script>
<script src="/res/plugins/pagination1.js"></script>
<script type="text/javascript">
//for pagination
var page = 1; 		// 화면에서 사용할 page
var pageNum = 0; 	// 서버에 넘겨줄 page -> mysql 은 0 부터 시작
var rowPerPage = 20;
var rowLength = 0;
var totalPage = 0;
var cntRowPagination = 5;	// << 1 2 3 4 5 >>

$(function($) {
	initComponent();
	initGridPlan();
	initGridList();
	fnLoadVendorGrid();
	fnLoadProjGrid();
// 	initScreenSizeModal();
})

function initComponent() {
	console.info('initComponent()');
/* 	$('#wadat_register_date_range').daterangepicker({
		opens: 'right',
		locale: {
			format : 'YYYY-MM-DD'	,
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
					'7월', '8월', '9월', '10월', '11월', '12월' ],
			daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
			showMonthAfterYear : true,
			yearSuffix : '년'
	    },
 	     startDate: getTodayDate(),
 	     endDate: getTodayDate()
	});  */
	
	$('#posale_dt').daterangepicker({
		opens: 'right',
		locale: {
			format : 'YYYY-MM-DD'	,
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
					'7월', '8월', '9월', '10월', '11월', '12월' ],
			daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
			showMonthAfterYear : true,
			yearSuffix : '년'
	    },
 	     /* startDate: getTodayDate(),
 	     endDate: getTodayDate() */
 	     startDate: '2019-05-01',
 	     endDate: '2019-05-30'
	});
	
	$(".nav > li > a").click(function(event){
    	$(".nav").find(".active").removeClass("active");
    	$(".tab-content").find(".active").removeClass("active");
    	$( this ).parent( 'li' ).addClass( 'active' );
//     	var clickTab = event.target.innerText.trim();
    	var id = $(event.target).parent()[0].id;
//     	console.log(id);
    	if( id=='list_tab' ) {
    		$("#list").addClass("active");
    		loadList();
    		w2ui['grid_list'].resize();
    		w2ui['grid_list'].refresh();
    	} else if ( id=='plan_tab' ) {
    		$("#plan").addClass("active");
    		loadList1();
    		w2ui['grid_plan'].resize();
    		w2ui['grid_plan'].refresh();
    	}
    });
}

function initGridList() {
	console.log('initGridList()');
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list', 
//         searches: [                
//             { field: 'lname', caption: 'Last Name', type: 'text' },
//             { field: 'fname', caption: 'First Name', type: 'text' },
//             { field: 'email', caption: 'Email', type: 'text' },
//         ],
        show: { footer: true },
        multiSelect: false,
        columns: [
            { field: 'recid', caption: 'No', size: '40px', sortable: true, attr: 'align=center', resizable: true },
            { field: 'posale_no', caption: '주문번호', size: '90px', sortable: true, resizable: true },//, hidden:true
            { field: 'posale_seq', caption: '주문번호-순번', size: '90px', resizable: true },
            { field: 'matnr', caption: '아이템 코드', size:'90px', resizable: true },
            { field: 'maktx', caption: '단위', size: '90px', hidden: true },
            { field: 'posale_status', caption: '수주 등록 확정 구분', size: '10%', resizable: true, hidden:true,
            	render : function(record, index, col_index){
              		var value = this.getCellValue(index, col_index);
              		if( value=='00' )
              			return '확정전';
              		else
              			return '확정';
            	}},
            { field: 'delivery_status', caption: '출하확정구분', size: '90px', resizable: true,
                	render : function(record, index, col_index){
                  		var value = this.getCellValue(index, col_index);
                  		if( value=='00' )
                  			return '확정전';
                  		else
                  			return '확정';
                	}},
			{ field: 'lifnr', caption: '사업자번호', size: '90px', sortable: true, resizable: true },
			{ field: 'lifnr_nm', caption: '납품처명', size: '90px', sortable: true, resizable: true },
			{ field: 'project_no', caption: '프로젝트코드', size: '90px', sortable: true, resizable: true },
            { field: 'project_nm', caption: '프로젝트명', size: '90px', sortable: true, resizable: true },
            { field: 'netwr', caption: '발주금액', size: '90px', sortable: true, resizable: true },
            { field: 'project_menge', caption: '분할수량', size: '90px', resizable: true },
            { field: 'menge', caption: '수량', size: '90px', sortable: true, resizable: true },
            { field: 'meins', caption: '단위', size: '90px', sortable: true, resizable: true },
            { field: 'remark', caption: '요구사항', size: '90px', sortable: true, resizable: true },
            { field: 'plan_dt', caption: '설계일자', size: '90px', sortable: true, resizable: true },
            { field: 'eindt', caption: '완료일자', size: '90px', sortable: true, resizable: true },
            { field: 'purdt', caption: '구매일자', size: '90px', sortable: true, resizable: true },
            { field: 'jidat', caption: '지시일자', size: '90px', sortable: true, resizable: true },
            { field: 'sedat', caption: '납품요청일', size: '90px', sortable: true, resizable: true },
            { field: 'posale_dt', caption: '주문등록일', size: '90px', sortable: true, resizable: true },
            { field: 'file_group', caption: '도면정보', size: '90px', sortable: true, resizable: true }
        ],
        sortData: [
			{field: 'posale_no', direction: 'ASC'},
			{field: 'posale_seq', direction: 'ASC'}
		],
		records: [],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},
		onClick: function (event) {}
    }); 
	loadList();
}

function loadList(pageNum){
	// for grid_list
	console.log('loadList()');
// 	var gubun = $("#reg_gubun").val();
	var beforePage = page; 
	if( pageNum==undefined ){
		page=1;
		pageNum = 0;
	} else {
		page=pageNum;
		pageNum = (pageNum-1)*rowPerPage;
	}

	var posale_dt_from = $("#posale_dt").val().substr(0,10);
	var posale_dt_to =  $("#posale_dt").val().substr(13);
	var sedat_from = '';	//$("#sedat").val().substr(0,10); 
	var sedat_to = '';	//$("#sedat").val().substr(13); 
	var eindt_from = '';	//$("#eindt").val().substr(0,10);
	var eindt_to = '';	//$("#eindt").val().substr(13);
	var page_url = "/frontend/sales_select"
				 + "?posale_dt_from=" + encodeURIComponent(posale_dt_from)
				 + "&posale_dt_to=" + encodeURIComponent(posale_dt_to)
				 + "&sedat_from=" + encodeURIComponent(sedat_from)
				 + "&sedat_to=" + encodeURIComponent(sedat_to)
				 + "&eindt_from=" + encodeURIComponent(eindt_from)
				 + "&eindt_to=" + encodeURIComponent(eindt_to)
// 				 + "&posale_status=" + encodeURIComponent($("#posale_status").val())
				 + "&delivery_status=00"
// 				 + "&delivery_status=" + encodeURIComponent($("#delivery_status").val())
				 + "&project_no=" + encodeURIComponent($("#project_no").val())
				 + "&lifnr=" + encodeURIComponent($("#lifnr").val())
				 + "&page="+ encodeURIComponent(pageNum)
				 + "&rows="+ encodeURIComponent(rowPerPage);
	
	w2ui['grid_list'].lock('loading...', true);
	var rowArr = [];
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		async : false,
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				if(data.pageTotal == 0){
					$("#pagination").empty();
				} else {
					totalPage = data.pageTotal;
					pagination();
				}
				w2ui['grid_list'].records = rowArr;
				w2ui['grid_list'].total = data.rowTotal;
			} else if(data.status == 200 && (data.rows).length == 0) {
				w2ui.grid_list.clear();
				$("#pagination").empty();
				w2ui['grid_list'].records = rowArr;
				w2ui['grid_list'].total = 0;
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
		},complete: function () {}
	});
}

function initGridPlan() {
	console.log('initGridPlan()');
	var rowArr = [];
	
	$('#grid_plan').w2grid({ 
        name: 'grid_plan', 
//         searches: [                
//             { field: 'lname', caption: 'Last Name', type: 'text' },
//             { field: 'fname', caption: 'First Name', type: 'text' },
//             { field: 'email', caption: 'Email', type: 'text' },
//         ],
        show: { footer: true, selectColumn: true },
        multiSelect: false,
        columns: [
            { field: 'recid', caption: 'No', size: '40px', sortable: true, attr: 'align=center', resizable: true },
            { field: 'posale_no', caption: '주문번호', size: '90px', sortable: true, resizable: true },//, hidden:true
            { field: 'posale_seq', caption: '주문번호-순번', size: '90px', resizable: true },
            { field: 'matnr', caption: '아이템 코드', size:'90px', resizable: true },
            { field: 'maktx', caption: '단위', size: '90px', hidden: true },
            { field: 'posale_status', caption: '수주 등록 확정 구분', size: '10%', resizable: true, hidden:true,
            	render : function(record, index, col_index){
              		var value = this.getCellValue(index, col_index);
              		if( value=='00' )
              			return '확정전';
              		else
              			return '확정';
            	}},
            { field: 'delivery_status', caption: '출하확정구분', size: '90px', resizable: true,
                	render : function(record, index, col_index){
                  		var value = this.getCellValue(index, col_index);
                  		if( value=='00' )
                  			return '확정전';
                  		else
                  			return '확정';
                	}},
			{ field: 'lifnr', caption: '사업자번호', size: '90px', sortable: true, resizable: true },
			{ field: 'lifnr_nm', caption: '납품처명', size: '90px', sortable: true, resizable: true },
			{ field: 'project_no', caption: '프로젝트코드', size: '90px', sortable: true, resizable: true },
            { field: 'project_nm', caption: '프로젝트명', size: '90px', sortable: true, resizable: true },
            { field: 'netwr', caption: '발주금액', size: '90px', sortable: true, resizable: true },
            { field: 'project_menge', caption: '분할수량', size: '90px', resizable: true },
            { field: 'menge', caption: '수량', size: '90px', sortable: true, resizable: true },
            { field: 'meins', caption: '단위', size: '90px', sortable: true, resizable: true },
            { field: 'remark', caption: '요구사항', size: '90px', sortable: true, resizable: true },
            { field: 'plan_dt', caption: '설계일자', size: '90px', sortable: true, resizable: true },
            { field: 'eindt', caption: '완료일자', size: '90px', sortable: true, resizable: true },
            { field: 'purdt', caption: '구매일자', size: '90px', sortable: true, resizable: true },
            { field: 'jidat', caption: '지시일자', size: '90px', sortable: true, resizable: true },
            { field: 'sedat', caption: '납품요청일', size: '90px', sortable: true, resizable: true },
            { field: 'posale_dt', caption: '주문등록일', size: '90px', sortable: true, resizable: true },
            { field: 'file_group', caption: '도면정보', size: '90px', sortable: true, resizable: true }
        ],
        sortData: [
			{field: 'posale_no', direction: 'ASC'},
			{field: 'posale_seq', direction: 'ASC'}
		],
		records: [],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},
		onClick: function (event) {}
    }); 
	loadList1();
}

function loadList1(pageNum){
	// for grid_list
	console.log('loadList1()');
// 	var gubun = $("#reg_gubun").val();
	var beforePage = page; 
	if( pageNum==undefined ){
		page=1;
		pageNum = 0;
	} else {
		page=pageNum;
		pageNum = (pageNum-1)*rowPerPage;
	}

	var posale_dt_from = $("#posale_dt").val().substr(0,10);
	var posale_dt_to =  $("#posale_dt").val().substr(13);
	var sedat_from = '';	//$("#sedat").val().substr(0,10); 
	var sedat_to = '';	//$("#sedat").val().substr(13); 
	var eindt_from = '';	//$("#eindt").val().substr(0,10);
	var eindt_to = '';	//$("#eindt").val().substr(13);
	var page_url = "/frontend/select_shipment"
/* 				 + "?posale_dt_from=" + encodeURIComponent(posale_dt_from)
				 + "&posale_dt_to=" + encodeURIComponent(posale_dt_to)
				 + "&sedat_from=" + encodeURIComponent(sedat_from)
				 + "&sedat_to=" + encodeURIComponent(sedat_to)
				 + "&eindt_from=" + encodeURIComponent(eindt_from)
				 + "&eindt_to=" + encodeURIComponent(eindt_to)
				 + "&delivery_status=00"
				 + "&project_no=" + encodeURIComponent($("#project_no").val())
				 + "&lifnr=" + encodeURIComponent($("#lifnr").val())*/
				 + "?page="+ encodeURIComponent(pageNum)
				 + "&rows="+ encodeURIComponent(rowPerPage); 
	
	w2ui['grid_plan'].lock('loading...', true);
	var rowArr = [];
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		async : false,
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				if(data.pageTotal == 0){
					$("#pagination1").empty();
				} else {
					totalPage = data.pageTotal;
					pagination1();
				}
				w2ui['grid_plan'].records = rowArr;
				w2ui['grid_plan'].total = data.rowTotal;
			} else if(data.status == 200 && (data.rows).length == 0) {
				if( nullToBlank(w2ui.grid_list)!='' )
					w2ui.grid_list.clear();
				$("#pagination1").empty();
				w2ui['grid_plan'].records = rowArr;
				w2ui['grid_plan'].total = 0;
			}
			w2ui['grid_plan'].refresh();
			w2ui['grid_plan'].unlock();
		},complete: function () {}
	});
}

var moveObj = [];
function fnMoveShipment() {
	console.log('fnMoveShipment()');
	var selections = w2ui.grid_list.getSelection();
// 	var selectData = w2ui.grid_list.get(w2ui.grid_list.getSelection());
	if(selections.length==0) {
		fnMessageModalAlert('Alert', '이동할 항목을 목록에서 선택해야 합니다.');
		return;
	}
	var moveObj = [];
	$.each(selections, function(idx, recid){
		var record = w2ui.grid_list.get(recid);
		console.log(record);
		record.recid = w2ui.grid_plan.records.length+1+idx;
		moveObj.push(record);
		w2ui.grid_list.remove(recid);
	});
	
	//출하계획편성 탭 클릭
	$(".nav").find(".active").removeClass("active");
	$(".tab-content").find(".active").removeClass("active");
	$("#plan_tab").addClass( 'active' );
	$("#plan").addClass("active");
	w2ui['grid_plan'].resize();
	w2ui['grid_plan'].refresh();
	loadList1();
	w2ui.grid_plan.add(moveObj);
}

function fnPopupInfo(flag) {
	console.log('fnPopupInfo(' + flag + ')');
	
	$("#a_project_no").val("");
	$("#a_zdue_menge").val("");
	$("#a_plan_dt").val("");
	$("#a_purdt").val("");
	$("#a_file_group").val("");
	$("#a_project_no").css("display","none");
	$("#a_zdue_menge").css("display","none");
	$("#a_plan_dt").css("display","none");
	$("#a_purdt").css("display","none");
	$("#a_file_group").css("display","none");
	
	if( flag=='V' ) {	
		$("#modal_vendor").modal('show');
		fnSetLoadVendorGrid();
		w2ui.grid_vendor.resize();
		w2ui.grid_vendor.refresh();
	} else {	// flag=='P'
		$("#modal_proj").modal('show');
		fnSetLoadProjGrid();
		w2ui.grid_proj.resize();
		w2ui.grid_proj.refresh();
		
		/* 
		$("#a_project_no").css("display","");
		$("#a_zdue_menge").css("display","");
		$("#a_plan_dt").css("display","");
		$("#a_purdt").css("display","");
		$("#a_file_group").css("display","");
		
		$("#modal_print").modal('show');
		fnSearchRegListGrid(); */
// 		w2ui.grid_reg.resize();
// 		w2ui.grid_reg.refresh();
	}
}

function fnLoadVendorGrid(){
//	 console.log(page_url);
	var rowArr = [];
	
	$('#grid_vendor').w2grid({ 
       name: 'grid_vendor',
       show: {
       	selectColumn: false,
			lineNumbers : true,
           footer: true
       },
       columns: [                
			{ field:'lifnr', caption:'거래처코드', size:'80px', style:'text-align:center', frozen: true},
// 			{ field:'id_yn', caption:'계정생성', size:'70px', style:'font-weight:bold;color:blue;background-color:rgba(255,255,0,0.3);text-align:center', frozen: true},
			{ field:'name1', caption:'거래처명', size:'150px', frozen: true},
// 			{ field:'land1', caption:'국가', size:'50px', style:'text-align:center', frozen: true},
// 			{ field:'pstlz', caption:'우편번호', size:'100px', style:'text-align:center'},
// 			{ field:'ort01', caption:'도시', size:'200px'},
// 			{ field:'telf1', caption:'전화번호', size:'120px', style:'text-align:right'},
// 			{ field:'telfx', caption:'팩스', size:'120px', style:'text-align:center'},
			{ field:'stenr', caption:'사업자번호', size:'120px', style:'text-align:center'},
			{ field:'smtp_addr', caption:'이메일주소', size:'200px', style:'text-align:center'},
			{ field:'j_1kfrepre', caption:'대표자', size:'100px', style:'text-align:center'},
// 			{ field:'erdat', caption:'생성일', size:'100px', style:'text-align:center'},
// 			{ field:'aedat', caption:'변경일', size:'100px', style:'text-align:center'},
// 			{ field:'ktokk', caption:'계정그룹', hidden:true},
// 			{ field:'txt30', caption:'계정그룹명', hidden:true},
// 			{ field:'loevm', caption:'삭제표시', hidden:true},
// 			{ field:'name2', caption:'이름2', hidden:true},
// 			{ field:'mcod1', caption:'검색어1', hidden:true},
// 			{ field:'regio', caption:'시', hidden:true},
// 			{ field:'land1', caption:'국가', hidden:true},
// 			{ field:'telf2', caption:'이동전화', hidden:true},
			{ field:'j_1kftbus', caption:'업태', hidden:true},
			{ field:'j_1kftind', caption:'업종', hidden:true}],
// 			{ field:'altkn', caption:'이전업체코드', hidden:true} ], 
		sortData: [{field: 'lifnr', direction: 'ASC'}],
		records: rowArr,
		onReload: function(event) {
			fnSetLoadVendorGrid();
		},
		onDblClick: function(event) {
	        var rowData = w2ui.grid_vendor.records[event.recid-1];
	        $("#lifnr").val(rowData.stenr);
	        $("#lifnr_nm").val(rowData.name1);
	        $("#modal_vendor").modal('hide');
	    }
	});
	var page_url = "/frontend/hub/selectVendortbl"
		 + "?func_name=" + encodeURIComponent("selectVendortbl")
		 + "&NAME1=" + encodeURIComponent($("#name").val())
		 + "&LIFNR=" + encodeURIComponent($("#code").val());

	w2ui['grid_vendor'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				w2ui['grid_vendor'].records = rowArr;
			}
			w2ui['grid_vendor'].refresh();
			w2ui['grid_vendor'].unlock();
		},complete: function () {}
	});
}

function fnSetLoadVendorGrid(){
	var page_url = "/frontend/hub/selectVendortbl"
				 + "?func_name=" + encodeURIComponent("selectVendortbl")
				 + "&NAME1=" + encodeURIComponent($("#name").val()) 
				 + "&LIFNR=" + encodeURI(encodeURIComponent($("#code").val()));
	
	w2ui['grid_vendor'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				w2ui['grid_vendor'].records = rowArr;
			} else {
				w2ui['grid_vendor'].records = [];
			}
			w2ui['grid_vendor'].refresh();
			w2ui['grid_vendor'].unlock();
		},complete: function () {}
	});
}

function fnLoadProjGrid() {
// 	console.log('fnLoadProjGrid()');
	
	var rowArr = [];
	
	$('#grid_proj').w2grid({ 
        name: 'grid_proj', 
//         searches: [                
//             { field: 'lname', caption: 'Last Name', type: 'text' },
//             { field: 'fname', caption: 'First Name', type: 'text' },
//             { field: 'email', caption: 'Email', type: 'text' },
//         ],
        show: { footer: true },
        /* columnGroups: [
            { caption: 'No', master: true },
            { caption: '사업자번호',master: true },
            { caption: '사업체명',master: true },
            { caption: '구분', master: true },
            { caption: '프로젝트', span: 7 },
            { caption: '프로젝트 진행', span: 5 }
        ], */
        multiSelect: false,
        columns: [                
            { field: 'recid', caption: 'No', size: '40px', sortable: true, attr: 'align=center', resizable: true },
            { field: 'lifnr', caption: '사업자번호', size: '10%', sortable: true, resizable: true },
            { field: 'lifnr_nm', caption: '사업체명', size: '10%', sortable: true, resizable: true },
            { field: 'project_division', caption: '구분', size: '5%', sortable: true, resizable: true,
            	render : function(record, index, col_index){
              		var value = this.getCellValue(index, col_index);
              		if( value=='00' )
              			return '신규';
              		else
              			return '재진행';
            	}},
            { field: 'project_no', caption: '프로젝트코드', size: '15%', hidden: true },
            { field: 'project_nm', caption: '프로젝트명', size: '20%', sortable: true, resizable: true },
            { field: 'netwr', caption: '발주금액', size: '90px', sortable: true, resizable: true },
            { field: 'menge', caption: '수량', size: '90px', sortable: true, resizable: true },
            { field: 'zdue_menge', caption: '잔량', size: '90px', sortable: true, resizable: true },
            { field: 'meins', caption: '단위', size: '90px', sortable: true, resizable: true },
            { field: 'remark', caption: '요구사항', size: '90px', sortable: true, resizable: true },
            { field: 'success_yn', caption: '완료유무', size: '90px', hidden: true },
            { field: 'plan_dt', caption: '설계일자', size: '90px', hidden: true },
            { field: 'eindt', caption: '완료일자', size: '90px', sortable: true, resizable: true },
            { field: 'purdt', caption: '구매일자', size: '90px', sortable: true, resizable: true },
            { field: 'file_group', caption: '도면정보', size: '90px', sortable: true, resizable: true }
        ],
        sortData: [{field: 'plan_dt', direction: 'ASC'}],
		records: [],
		total : 0,
		recordHeight : 30,
		onReload: function(event) { fnSetLoadProjGrid(); },
		onDblClick: function(event) {
	        var rowData = w2ui.grid_proj.records[event.recid-1];
			$("#project_no").val(rowData.project_no);
			$("#project_nm").val(rowData.project_nm);
	        $("#modal_proj").modal('hide');
	    },
	    onClick: function (event) {}
    }); 
	fnSetLoadProjGrid();
}

function fnSetLoadProjGrid(){
// 	console.log('fnSetLoadProjGrid()');
	var page_url = "/frontend/project_select_popup";
	
	w2ui['grid_proj'].lock('loading...', true);
	var rowArr = [];
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		async : false,
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				
				w2ui['grid_proj'].records = rowArr;
				w2ui['grid_proj'].total = data.rowTotal;
			} else if(data.status == 200 && (data.rows).length == 0) {
				w2ui.grid_proj.clear();
				w2ui['grid_proj'].records = rowArr;
				w2ui['grid_proj'].total = 0;
			}
			w2ui['grid_proj'].refresh();
			w2ui['grid_proj'].unlock();
		},complete: function () {}
	});
}

function fnShipmentPlanCommit() {
	console.log('fnShipmentPlanCommit()');
// 	console.log(w2ui.grid_plan.get(w2ui.grid_plan.getSelection()));
	
	var selection = w2ui.grid_plan.getSelection();
	if(selection.length==0) {
		fnMessageModalAlert('Alert', '확정할 항목을 목록에서 선택해야 합니다.');
		return;	
	}
	// 1. 선택한 항목을 팝업창에 띄운다.
	
	var temp = $("#commitTamp").children(".box");
	console.log(temp);
	$("#shipment").append($("#commitTamp").children(".box"));
	$("#modal_commit").modal('show');
	// 2. 출하예정일,출하계획명과 출하계획 비고 를 입력 받는다.
	/*
	동적으로 만들어 body에 해당 항목을 입력받도록 한다.
	헤더 부분엔 [주문번호-seq] 프로젝트명.(프로젝트 명이 10자 이상인 경우...표시하도록)
	<div class="box box-warning">
            <div class="box-header with-border">
              <h3 class="box-title">Collapsable</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
              </div>
              <!-- /.box-tools -->
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              The body of the box
            </div>
            <!-- /.box-body -->
          </div>
	*/
}

function getFormatDate(d) {
	var month = d.getMonth();
	if( month==12 ) month = 0;
	else month += 1; 
	var date = d.getDate();
	month = (month < 10) ? "0" + month : month;
	date = (date < 10) ? "0" + date : date;
// 	console.log(month, date);
	return d.getFullYear() + '-' + month + '-' + date;
}

function excelFileDownload(gridName) {
// 	console.log('excelFileDownload('+gridName+')');
	var gridName1 = '';
	
	if ( $("#i_plant").val()  == '1110'){
		gridName1='grid';
	}else{
		gridName1='grid_O';
	}
	var gridCols = w2ui[gridName1].columns;
	var gridData = w2ui[gridName1].records;

	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	if( gridName1=='grid' ) {
		fileName = '의료영상 출하이력정보.xlsx';
		sheetTitle = '의료영상 출하이력정보';
		sheetName = '의료영상 출하이력정보';
	}else{
		fileName = '광영상 출하이력정보.xlsx';
		sheetTitle = '광영상 출하이력정보';
		sheetName = '광영상 출하이력정보';
		
	}
	
	var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
	var is_rownum = true;
	
	if(gridCols != null && gridCols.length > 0){
		// w2grid 는 linenumber column info not exist
		param_col_name = "No"
		param_col_id = "rownum";
		param_col_align = "center";
		param_col_width = "80";
// 		param_col_name += ",선택";
// 		param_col_id += ",rn";
// 		param_col_align += ",left";
// 		param_col_width += ",80";
		//--------------------------------------------
		for(var i=0; i<gridCols.length; i++){
			if(!gridCols[i].hidden){
				var caption = gridCols[i].caption;
				var fieldN = gridCols[i].field;
		 
 				if( gridName1=='grid' && (fieldN=='dtatwtb_s' || fieldN=='dtsernr' || fieldN=='dtdmr_no'|| fieldN=='dtrn_no' )){
    				param_col_name += "," + caption + '(Detector)';
  				}else if( gridName1=='grid' && (fieldN=='vsatwtb_s' || fieldN=='vssernr' || fieldN=='vsdmr_no'|| fieldN=='vsrn_no' )){
    				param_col_name += "," + caption + '(Vivix SCU)';
  				}else if( gridName1=='grid' && (fieldN=='psatwtb_s' || fieldN=='pssernr' || fieldN=='psdmr_no'|| fieldN=='psrn_no' )){
    				param_col_name += "," + caption + '(PSU)';
  				}else if( gridName1=='grid' && (fieldN=='chatwtb_s' || fieldN=='chsernr' || fieldN=='chdmr_no'|| fieldN=='chrn_no' )){
    				param_col_name += "," + caption + '(Charger)';
  				}else if( gridName1=='grid' && (fieldN=='rcatwtb_s' || fieldN=='rcsernr' || fieldN=='rcdmr_no'|| fieldN=='rcrn_no' )){
    				param_col_name += "," + caption + '(RF HEAD)';
  				}else if( gridName1=='grid' && (fieldN=='rsatwtb_s' || fieldN=='rssernr' || fieldN=='rsdmr_no'|| fieldN=='rsrn_no' )){
    				param_col_name += "," + caption + '(RF SCU)';
  				}else if( gridName1=='grid' && (fieldN=='rwatwtb_s' || fieldN=='rwsernr' || fieldN=='rwdmr_no'|| fieldN=='rwrn_no' )){
    				param_col_name += "," + caption + '(RF Workstation)';
  				}else{
  					param_col_name += "," + caption;
  				}
// 				else if( gridName=='gridSernr' && caption=='순차관리번호' ){
// 					param_col_name += "," + caption + '(*)';
// 				}else if( gridName=='gridProcSubSernr' && caption=='순차관리번호' ){
// 					param_col_name += "," + caption + '(*)';
// 				}else{
				 
// 				}
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
		export_data += "&header_col_ids="+encodeURIComponent(param_col_id);
		export_data += "&header_col_aligns="+encodeURIComponent(param_col_align);
		export_data += "&header_col_widths="+encodeURIComponent(param_col_width);
		export_data += "&cmd="+encodeURIComponent("grid_goods_detail");
		export_data += "&body_data="+encodeURIComponent(JSON.stringify(gridData));
// 		console.log(export_data);
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
  
 