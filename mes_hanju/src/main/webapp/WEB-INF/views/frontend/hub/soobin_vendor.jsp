<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*" %>
<%
// jsp properties
String thema = SessionUtil.getProperties("mes.thema");
String pageTitle = SessionUtil.getProperties("mes.company");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	
	 <style type="text/css">
		.ichk_label {
			font-weight: unset;
    		font-size: 12px; }
	 </style>
	 
		<body class="hold-transition skin-<%=thema%> sidebar-mini">
			<jsp:include page="/common/top_menu_inc" flush="true">
				<jsp:param name="fb_div" value="F" />
				<jsp:param name="page_title" value="0" />
			</jsp:include>
		  
			<jsp:include page="/common/sidebar_menu_inc" flush="true">
				<jsp:param name="menu_div" value="F" />
				<jsp:param name="selected_menu_p_cd" value="1020" />
				<jsp:param name="selected_menu_cd" value="1128" />
			</jsp:include>

			<div class="content-wrapper">
			    <section class="content-header">
			        <section class="content-header">
			        <h1>
			           	도매업 관리
			            <small>HUB</small>
			        </h1>
			        <ol class="breadcrumb">
			            <li><a href="#"><i class="fa fa-dashboard"></i>주문 관리</a></li>
			            <li class="active"> HUB</li>
			        </ol>
			    </section>
			
			    <!-- Main content -->
				<section class="content" style="padding-bottom: 0px;">
					<div class="box" style="margin-bottom: 0px;height: 790px;">
						<div class="box-body"><!-- start box body -->
							<div class="row" style="margin-bottom:10px;">
								<div class="col-md-12">
									<div class="col-sm-2">
			                        	<label>| 계약 구분</label><br>
										<select id="project_division" name="project_division" class="form-control select2 input-sm" data-placeholder="">
											<option value="">전체</option>
											<option value="00">신규</option>
											<option value="01">재진행</option>
										</select>
							    	</div>
									<div class="col-sm-2">
										<label>| 기업 코드</label>
										<input type="input" id="project_no" name="project_no" class="form-control input-sm" placeholder="ex) P20190301_0001" maxlength="30">
									</div>
									<div class="col-sm-2">
										<label>| 기업명</label>
										<input type="input" id="project_nm" name="project_nm" class="form-control input-sm" placeholder="ex) *** 제작" maxlength="30">
									</div>
									<div class="col-sm-2">
										<label>| 사업자번호</label>
										<input type="input" id="lifnr" name="lifnr" class="form-control input-sm" placeholder="ex) 1234567890" maxlength="10">
									</div>
								</div>
							</div><!-- end row:search condition -->
							<div class="row" style="margin-bottom:10px;">
								<div class="col-md-12 text-right">
								<button type="button" id="" onclick="test();" class="btn btn-success btn-sm">test</button>
									<button type="button" id="" onclick="fnPopupInfo('N');" class="btn btn-success btn-sm">등록</button>
									<button type="button" id="" onclick="fnPopupInfo('U');" class="btn btn-success btn-sm">수정</button>
									<button type="button" id="" onclick="fnDelete();" class="btn btn-danger btn-sm">삭제</button>
									<button type="button" id="" onclick="loadList();" class="btn btn-primary btn-sm">조회</button>
								</div>
							</div>
							<div class="row"> <!--  grid!!!!!!  -->
								<div class="col-md-12">
									<div id="grid" style="width: 100%; height: 600px;"></div>
									<div id="pagination" class="text-center"></div>
								</div>
							</div>
						</div>
					</div>
				</section>
			    <!-- /.content -->
			</div>
		<!-- /.content-wrapper -->
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
		<div class="modal fade" id="modal_print" aria-hidden="true" style="display: none; z-index: 1070;"> <!-- data-backdrop="static"> -->
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="modal_v_title">도면 목록</h4>
		        	</div>
					<div class="modal-body" id="">
						<form id="frm_print" name="frm_vendor" class="form-horizontal">
							<div class="form-group row">
								<label for="" class="col-sm-2 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 구분</label>
								<div class="col-sm-3">
									<select id="s_type" name="p_gubun" class="form-control select2 input-sm" data-placeholder="">
										<option value="drw">도면</option>
										<option value="ord">작업표준서</option>
									</select>
								</div>
								<label for="" class="col-sm-2 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 파일명</label>
								<div class="col-sm-4">
									<input type="text" class="form-control input-sm" id="p_filename">
								</div>
								<div class="col-sm-1" style="padding-left: 0px;">
									<button type="button" onclick="fnSearchRegListGrid();" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
								</div>
							</div>
						</form>
						<div class="row">
							<div class="col-md-12">
								<div id="grid_reg" style="width: 100%; height: 500px;"></div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-md-12 text-center">
							<button type="button" id="btn_modal_print" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- start insert/update -->
		<div class="modal fade" id="modal_info" aria-hidden="true" style="display: none; z-index: 1060;"><!-- data-backdrop="static"> -->
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="modal_title">등록</h4>
		        	</div>
					<div class="modal-body" id="">
						<form id="frm_info" name="frm_info" class="form-horizontal">
							<div id="a_project_no" class="form-group row">
								<div class="col-sm-1"></div>
								<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">프로젝트 코드</label>
								<div class="col-sm-7">
									<input type="text" class="form-control input-sm" id="p_project_no" value="" disabled>
								</div>
								<div class="col-sm-1"></div>
							</div>
							<div class="form-group row">
								<div class="col-sm-1"></div>
								<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">프로젝트명</label>
								<div class="col-sm-7">
									<input type="text" class="form-control input-sm" id="p_project_nm" value="">
								</div>
								<div class="col-sm-1"></div>
							</div>
							<div class="form-group row">
								<div class="col-sm-1"></div>
								<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;"> 구분</label>
								<div class="col-sm-7">
									<select id="p_gubun" name="p_gubun" class="form-control select2 input-sm" data-placeholder="">
										<option value="00">신규</option>
										<option value="01">재진행</option>
									</select>
								</div>
								<div class="col-sm-1"></div>
							</div>
							<div class="form-group row">
								<div class="col-sm-1"></div>
								<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">수주업체 정보</label>
								<div class="col-sm-6">
									<input type="text" class="form-control input-sm" id="p_lifnr_nm" value="" disabled>
								</div>
								<div class="col-sm-1" style="padding-left: 0px;"> <!-- 도면 목록 버튼 -->
									<button type="button" onclick="fnPopupInfo('V');" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
								</div>
								<div class="col-sm-1"></div>
							</div>
							<div class="form-group row">
								<div class="col-sm-4"></div>
								<div class="col-sm-6">
									<input type="text" class="form-control input-sm" id="p_lifnr" value="" disabled>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-sm-1"></div>
								<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">발주금액</label>
								<div class="col-sm-7">
									<input type="text" class="form-control input-sm" id="p_netwr" value="" style="text-align: right;">
								</div>
								<div class="col-sm-1"></div>
							</div>
							<div class="form-group row">
								<div class="col-sm-1"></div>
								<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">수량</label>
								<div class="col-sm-7">
									<input type="text" class="form-control input-sm" id="p_menge" value="" style="text-align: right;">
								</div>
								<div class="col-sm-1"></div>
							</div>
							<div id="a_zdue_menge" class="form-group row">
								<div class="col-sm-1"></div>
								<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">잔량</label>
								<div class="col-sm-7">
									<input type="text" class="form-control input-sm" id="p_zdue_menge" value="" style="text-align: right;">
								</div>
								<div class="col-sm-1"></div>
							</div>
							<div class="form-group row">
								<div class="col-sm-1"></div>
								<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">단위</label>
								<div class="col-sm-7">
									<select id="p_meins" name="p_meins" class="form-control select2 input-sm" data-placeholder="">
										<option value="EA">EA</option>
										<option value="M">M</option>
									</select>
								</div>
								<div class="col-sm-1"></div>
							</div>
							<div class="form-group row">
								<div class="col-sm-1"></div>
								<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">요구사항</label>
								<div class="col-sm-7">
									<input type="text" class="form-control input-sm" id="p_remark" value="">
								</div>
								<div class="col-sm-1"></div>
							</div>
							<div id="a_success_yn" class="form-group row">
								<div class="col-sm-1"></div>
								<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">완료유무</label>
								<div class="col-sm-3">
									<label class="ichk_label"> <input type="radio" id="p_success_yn" name="p_success_yn" value="Y" disabled> 완료</label>
								</div>
								<div class="col-sm-4">
									<label class="ichk_label"> <input type="radio" id="p_success_yn" name="p_success_yn" value="N" disabled> 미완료</label> 
								</div>
								<div class="col-sm-1"></div>
							</div>
							<div class="form-group row">
								<div class="col-sm-1"></div>
								<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">완료일자</label>
								<div class="col-sm-7">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right input-sm" id="p_eindt">
									</div>
								</div>
								<div class="col-sm-1"></div>
							</div>
							<div id="a_plan_dt" class="form-group row">
								<div class="col-sm-1"></div>
								<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">설계일자</label>
								<div class="col-sm-7">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right input-sm" id="p_plan_dt">
									</div>
								</div>
								<div class="col-sm-1"></div>
							</div>
							<div id="a_purdt" class="form-group row">
								<div class="col-sm-1"></div>
								<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">구매일자</label>
								<div class="col-sm-7">
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right input-sm" id="p_purdt">
									</div>
								</div>
								<div class="col-sm-1"></div>
							</div>
							<div id="a_file_group" class="form-group row">
								<div class="col-sm-1"></div>
								<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">도면정보</label>
								<div class="col-sm-6">
									<input type="text" class="form-control input-sm" id="p_file_group" value="">
								</div>
								<div class="col-sm-1" style="padding-left: 0px;">
									<button type="button" onclick="fnPopupInfo('P');" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
								</div>
								<div class="col-sm-1"></div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<div class="col-md-12 text-center">
							<button type="button" id="btn_dmr_save" class="btn btn-success btn-sm" onclick="fnInsert();">Save</button>
							<button type="button" id="btn_dmr_cancel" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div> <!-- end modal insert/update -->
		<jsp:include page="/common/footer_inc" flush="true">
			<jsp:param name="page_title" value="0" />
		</jsp:include>
		  
		<jsp:include page="/common/sidebar_rview_inc" flush="true">
			<jsp:param name="page_title" value="0" />
		</jsp:include>
		</div>
		<!-- ./wrapper -->

		<script src="/res/plugins/pagination.js"></script>
		
		<script type="text/javascript">
// for pagination
var page = 1; 		// 화면에서 사용할 page
var pageNum = 0; 	// 서버에 넘겨줄 page -> mysql 은 0 부터 시작
var rowPerPage = 20;
var rowLength = 0;
var totalPage = 0;
var cntRowPagination = 5;	// << 1 2 3 4 5 >> 

var upload_data;

$(function($) {
	fnPageLoadOption();
	fnLoadProjectGrid();
	fnLoadFileHandler();
	
	fnLoadVendorGrid();
	fnLoadRegListGrid();
	
	minDate = getFormatDate(new Date()),
	mdTemp = new Date(), 
	maxDate = getFormatDate(new Date(mdTemp.setDate(mdTemp.getDate() + 7)));
	 
	$('#p_eindt, #p_plan_dt, #p_purdt').daterangepicker({
		opens: 'right', 
		singleDatePicker: true,
		locale: {
			format: 'YYYY-MM-DD', // inputbox 에 '2011/04/29' 로표시
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
			showMonthAfterYear: true,
			yearSuffix: '년',
			orientation: "top left"
		},
		startDate : moment(minDate)
	});
	
	$("#p_netwr, #p_menge").keyup(function(event) {
		if(event.which >= 37 && event.which <= 40) return;
		$(this).val(function(index, value) {
			return value
			.replace(/\D/g, "")
			.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		});
	});
	
	$('input').iCheck({
	    checkboxClass: 'icheckbox_flat-blue',
	    radioClass: 'iradio_flat-blue'
	  });
});

function fnPageLoadOption(){
	$("#project_division, #project_no, #project_nm").pressEnter(function(e) {
		e.preventDefault();
		loadList();
	});
	/* 
	$("#p_stprs").keyup(function(event) {
		if(event.which >= 37 && event.which <= 40) return;
		$(this).val(function(index, value) {
			console.log(index, value);
			return value
			.replace(/\D/g, "")
			.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		});
	}); */
}
 
// 그리드~~
function fnLoadProjectGrid(){
// 	console.log('fnLoadMaterialGrid()');
	var rowArr = [];
	
	$('#grid').w2grid({ 
        name: 'grid', 
//         searches: [                
//             { field: 'lname', caption: 'Last Name', type: 'text' },
//             { field: 'fname', caption: 'First Name', type: 'text' },
//             { field: 'email', caption: 'Email', type: 'text' },
//         ],
        show: { footer: true },
        columnGroups: [
            { caption: 'No', master: true },
            { caption: '사업자번호',master: true },
            { caption: '사업체명',master: true },
            { caption: '구분', master: true },
            { caption: '프로젝트', span: 7 },
            { caption: '프로젝트 진행', span: 5 }
        ],
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
            { field: 'project_no', caption: '프로젝트코드', size: '15%', sortable: true, resizable: true },
            { field: 'project_nm', caption: '프로젝트명', size: '20%', sortable: true, resizable: true },
            { field: 'netwr', caption: '발주금액', size: '90px', sortable: true, resizable: true },
            { field: 'menge', caption: '수량', size: '90px', sortable: true, resizable: true },
            { field: 'zdue_menge', caption: '잔량', size: '90px', sortable: true, resizable: true },
            { field: 'meins', caption: '단위', size: '90px', sortable: true, resizable: true },
            { field: 'remark', caption: '요구사항', size: '90px', sortable: true, resizable: true },
            { field: 'success_yn', caption: '완료유무', size: '90px', sortable: true, resizable: true },
            { field: 'plan_dt', caption: '설계일자', size: '90px', sortable: true, resizable: true },
            { field: 'eindt', caption: '완료일자', size: '90px', sortable: true, resizable: true },
            { field: 'purdt', caption: '구매일자', size: '90px', sortable: true, resizable: true },
            { field: 'file_group', caption: '도면정보', size: '90px', sortable: true, resizable: true }
        ],
        sortData: [{field: 'plan_dt', direction: 'ASC'}],
		records: [],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},
		// sssssbbbb
		onClick: function (event) {
			/* var selIdxArr = w2ui.grid.getSelection(); // 선택하면 null값이 가끔 나옴.
			console.log(selIdxArr);
			var row = w2ui.grid.get(selIdxArr[0]);
			console.log(row); */
		},
		onDblClick: function(event) {
			/**
			var selIdxArr = w2ui.grid.getSelection();
			console.log(selIdxArr);
			var row = w2ui.grid.get(selIdxArr[0]);
			console.log(row);
			
			console.log(row.project_no);
			
			*/
			
			//alert("onDblClick~~");
			
			/* var selIdxArr = w2ui.grid.getSelection(); // 선택하면 null값이 가끔 나옴.
			console.log(selIdxArr);
			var row = w2ui.grid.get(selIdxArr[0]);
			console.log(row); */
			
			//console.log(w2ui.grid.records[event.recid-1].project_no);
			//var rowData = w2ui.grid.records[event.recid-1];
			
			// row = rowData
			$("#modal_info").modal('show');
				
			$("#modal_title").html("조회");
			
			
			// $("#p_project_no").val(row.project_no);
			var sel = w2ui.grid.getSelection();
			
			  
			 var project_no = w2ui.grid.records[sel -1].project_no;
			 var project_nm = w2ui.grid.records[sel -1].project_nm; 
			 var netwr = w2ui.grid.records[sel -1].netwr;
			 var menge = w2ui.grid.records[sel -1].menge; 
			 var zdue_menge = w2ui.grid.records[sel -1].zdue_menge;
			 var meins = w2ui.grid.records[sel -1].meins; 
			 var remark = w2ui.grid.records[sel -1].remark;
			 var success_yn = w2ui.grid.records[sel -1].success_yn; 
			//$("#p_success_yn").val(success_yn);
	
			 var plan_dt = w2ui.grid.records[sel -1].plan_dt;
			 var eindt = w2ui.grid.records[sel -1].eindt; 
			 var purdt = w2ui.grid.records[sel -1].purdt;
			 var file_group = w2ui.grid.records[sel -1].file_group;  
			 
			 var lifnr_nm = w2ui.grid.records[sel -1].lifnr_nm;  
			 var lifnr = w2ui.grid.records[sel -1].lifnr;  
			 var file_group = w2ui.grid.records[sel -1].file_group;  
			 
			/*
			 $("#p_project_no").val(project_no);
			 $("#p_project_nm").val(project_nm);
			 $("#p_netwr").val(netwr);
			 $("#p_menge").val(menge);
			 $("#p_zdue_menge").val(zdue_menge);
			 $("#p_meins").val(meins);
			 $("#p_remark").val(remark);
			 $("#p_success_yn").val(success_yn);
			 $("#p_plan_dt").val(plan_dt);
			 $("#p_eindt").val(eindt);
			 $("#p_purdt").val(purdt);
			 $("#p_file_group").val(file_group);
			 
			 // 수주업체 정보
			 $("#p_lifnr_nm").val(lifnr_nm);
			 
			 console.log(p_lifnr);
			 
			 $("#p_lifnr").val(lifnr); */
			 
			$("#p_project_no").val(project_no);
			$("#p_project_nm").val(project_nm);
			$("#p_project_division").val(project_division);
			$("#p_lifnr_nm").val(lifnr_nm);
			$("#p_lifnr").val(lifnr);
			$("#p_remark").val(remark);
			$(":radio[name=p_success_yn][value="+success_yn+"]").iCheck("check");
			$("#p_eindt").val(eindt);
			$("#p_file_group").val(file_group);
			$("#p_meins").val(meins);
			$("#p_menge").val(menge);
			$("#p_netwr").val(netwr);
			$("#p_plan_dt").val(plan_dt);
			$("#p_purdt").val(purdt);
			$("#p_zdue_menge").val(zdue_menge);
			 
		}
    }); 
	loadList();
}

function loadList(pageNum){
// 	console.log('loadList()');
// 	var gubun = $("#reg_gubun").val();
	var beforePage = page; 
	if( pageNum==undefined ){
		page=1;
		pageNum = 0;
	} else {
		page=pageNum;
		pageNum = (pageNum-1)*rowPerPage;
	}
	var page_url = "/frontend/soobin_vendor"
		//var page_url = "/frontend/project_select"
				 + "?project_division=" + encodeURIComponent($("#project_division").val())
				 + "&project_no=" + encodeURIComponent($("#project_no").val())
				 + "&project_nm=" + encodeURIComponent($("#project_nm").val())
				 + "&lifnr=" + encodeURIComponent($("#lifnr").val())
				 + "&page="+ encodeURIComponent(pageNum)
				 + "&rows="+ encodeURIComponent(rowPerPage);
	
	//w2ui['grid'].lock('loading...', true);
	// 주석 안주면 계속 loading..
	var rowArr = [];
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		async : false,
		success : function( data ) {
			console.log(data.rows);
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
				w2ui['grid'].records = rowArr;
				w2ui['grid'].total = data.rowTotal;
			} else if(data.status == 200 && (data.rows).length == 0) {
				w2ui.grid.clear();
				$("#pagination").empty();
				w2ui['grid'].records = rowArr;
				w2ui['grid'].total = 0;
			}
			w2ui['grid'].refresh();
			w2ui['grid'].unlock();
		},complete: function () {}
	});
}

function fnLoadFileHandler(){
	var page_url = "/file/item_import_upload";
	
	$('#fileupload').fileupload({
		url : page_url,
		dataType : 'json',
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
	}).on('fileuploaddone', function(e, data) {

		$('#grid_items').jqGrid('clearGridData');
		
		var arrData = data.result.rows;
		
		var d = new Date();
		var month = d.getMonth()+1;
		var date = d.getDate();
		month = (month < 10) ? "0" + month : month;
		date = (date < 10) ? "0" + date : date;
		
		var req_date = d.getFullYear() + month + date;
		
		for(var i=0; i<data.result.rows.length; i++ ){
		    
			var i_tmp = "00000" + (i+1);
		    i_tmp = i_tmp.slice(-4);
		    
		    arrData[i].zrequest_no = req_date + "0001";	// 수정...zrequest_no은 한 번올릴때 구성요소들의 값이 모두 같다...ex) 201709260001
		    arrData[i].zseq = i_tmp;
		}

		$('#grid_items').jqGrid('setGridParam', { datatype: 'local', data: data.result.rows }).trigger('reloadGrid');	
		
	}).on('fileuploadfail', function(e, data) {
		$.each(data.files, function(index) {
			fnMessageModalAlert("Notification", "File upload failed.");
		});
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}

function getFormatDate(d) {
	var month = d.getMonth() + 1;
	var date = d.getDate();
	month = (month < 10) ? "0" + month : month;
	date = (date < 10) ? "0" + date : date;
	return d.getFullYear() + '-' + month + '-' + date;
}

function fnSearchConditionInit() {
	$("input").val("");
	$("#reg_gubun").val("G");
} 

function fnSaveMesMaterial(){
// 	console.log('fnSaveMesMaterial()');
	var dept_cd = $("#deptCD").val();
	var gubun = $("#reg_gubun").val();
	
	var selection = w2ui.grid.getSelection();
	if(selection.length==0){
		fnMessageModalAlert("Warning", "저장하고자 하는 항목을 선택하시기 바랍니다.");
		return;
	}
	
	// mess_medical_yn, mess_optical_yn
	var records = [];
	$.each(w2ui.grid.records, function(idx, row){
		if( row.w2ui!=undefined ) records.push(row);
	});
	
	if( records.length>0 ) {
		if( dept_cd=='1110' ) {
			$.each(records, function(idx, row){
				if( row.w2ui!=undefined && row.w2ui.changes.mess_medical_yn!=undefined ){
					row.mess_medical_yn = row.w2ui.changes.mess_medical_yn;
				}
			});
		} else {
			$.each(records, function(idx, row){
				if( row.w2ui!=undefined && row.w2ui.changes.mess_optical_yn!=undefined ){
					row.mess_optical_yn = row.w2ui.changes.mess_optical_yn;
				}
			});
		}
		//mesg_medical_yn, mesg_optical_yn
		if( dept_cd=='1110' ) {
			$.each(records, function(idx, row){
				if( row.w2ui!=undefined && row.w2ui.changes.mesg_medical_yn!=undefined ){
					row.mesg_medical_yn = row.w2ui.changes.mesg_medical_yn;
				}
			});
		} else {
			$.each(records, function(idx, row){
				if( row.w2ui!=undefined && row.w2ui.changes.mesg_optical_yn!=undefined ){
					row.mesg_optical_yn = row.w2ui.changes.mesg_optical_yn;
				}
			});
		}
	}
	
	var page_url = "/frontend/hub/save_mes_master_material";
	var postData = "params=" + encodeURIComponent(JSON.stringify(records))
	             + "&dept_cd=" + encodeURIComponent(dept_cd);
	$.ajax({
		url : page_url,
		type : "POST",
		data : postData,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnMessageModalAlert("Success", "변경한 사용여부를 " + data.cnt + "건 저장하였습니다.");
				loadList();
			} else {
				fnMessageModalAlert("Error", "사용여부를 저장하는데 에러가 발생하였습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "사용여부를 저장하는데 에러가 발생하였습니다.");
		}
	});
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
	
	if( flag=='N' ) {
		// init form component 
		var inputObj = $("#modal_info").find('input');
		$.each(inputObj, function(idx, obj){
			if( $(obj).attr('type')!='radio' )
				$(obj).val("");
		});
		$(":radio[name=p_success_yn][value=N]").iCheck("check");
		
		$("#modal_info").modal('show');
		$("#modal_title").text("등록");
		
		$("#p_gubun").attr('disabled', false);
// 		$("#p_lifnr_nm").attr('disabled', true);
// 		$("#p_lifnr").attr('disabled', false);
		$("#p_project_nm").attr('disabled', false);
		$("#p_netwr").attr('disabled', false);
		$("#p_menge").attr('disabled', false);
		$("#p_meins").attr('disabled', false);
		$("#p_remark").attr('disabled', false);
		$("#p_eindt").attr('disabled', false);
	} else if( flag=='U' ) {
		var selIdxArr = w2ui.grid.getSelection();
		var chkLen = selIdxArr.length;
		if( chkLen==0 ) {
			fnMessageModalAlert('Alert', '수정할 항목을 목록에서 선택해야 합니다.');			
		} else if( chkLen>1 ) {
			fnMessageModalAlert('Alert', '수정할 항목은 목록에서 1개 선택해야 합니다.');
		} else {
// 			console.log(w2ui.grid.get(selIdxArr[0]));
			var row = w2ui.grid.get(selIdxArr[0]);
			$("#a_project_no").css("display","");
			$("#a_zdue_menge").css("display","");
			$("#a_plan_dt").css("display","");
			$("#a_purdt").css("display","");
			$("#a_file_group").css("display","");
			
			 
			$("#p_project_no").val(row.project_no);
			$("#p_project_nm").val(row.project_nm);
			$("#p_project_division").val(row.project_division);
			$("#p_lifnr_nm").val(row.lifnr_nm);
			$("#p_lifnr").val(row.lifnr);
			$("#p_remark").val(row.remark);
			$(":radio[name=p_success_yn][value="+row.success_yn+"]").iCheck("check");
			$("#p_eindt").val(row.eindt);
			$("#p_file_group").val(row.file_group);
			$("#p_meins").val(row.meins);
			$("#p_menge").val(row.menge);
			$("#p_netwr").val(row.netwr);
			$("#p_plan_dt").val(row.plan_dt);
			$("#p_purdt").val(row.purdt);
			$("#p_zdue_menge").val(row.zdue_menge);
			 
			$("#modal_info").modal('show');
			$("#modal_title").text("수정");
			$("#p_gubun").attr('disabled', true);
// 			$("#lifnr_nm").attr('disabled', true);
// 			$("#lifnr").attr('disabled', true);
			$("#p_project_nm").attr('disabled', false);
			$("#p_netwr").attr('disabled', false);
			$("#p_menge").attr('disabled', false);
			$("#p_meins").attr('disabled', false);
			$("#p_remark").attr('disabled', false);
			$("#p_eindt").attr('disabled', false);
			
		}
	} else if( flag=='V' ) {	
		$("#modal_vendor").modal('show');
		fnSetLoadVendorGrid();
		w2ui.grid_vendor.resize();
		w2ui.grid_vendor.refresh();
	} else {	// flag=='P'
		$("#a_project_no").css("display","");
		$("#a_zdue_menge").css("display","");
		$("#a_plan_dt").css("display","");
		$("#a_purdt").css("display","");
		$("#a_file_group").css("display","");
		
		$("#modal_print").modal('show');
		fnSearchRegListGrid();
// 		w2ui.grid_reg.resize();
// 		w2ui.grid_reg.refresh();
	}
}

function fnInsert() {
	console.log('fnInsert()',$("#p_project_no").val());
	/* 
	console.log($("#p_gubun").val());
	console.log($("#lifnr_nm").val());
	console.log($("#lifnr").val());
	console.log($("#p_project_nm").val());
	console.log($("#p_netwr").val());
	console.log($("#p_menge").val());	// (zdue_menge)
	console.log($("#p_meins").val());
	console.log($("#p_remark").val());
	console.log($("#p_eindt").val()); */
	if( $("#p_project_no").val()=="" ) {
		var page_url = "/frontend/project_insert"
					 + "?project_division=" + encodeURIComponent($("#p_gubun").val())
					 + "&project_nm=" + escape(encodeURIComponent($("#p_project_nm").val()))
					 + "&lifnr=" + encodeURIComponent($("#p_lifnr").val())
					 + "&lifnr_nm=" + escape(encodeURIComponent($("#p_lifnr_nm").val()))
					 + "&netwr=" + encodeURIComponent($("#p_netwr").val().replace(/[,\s]/gi,""))
					 + "&menge=" + encodeURIComponent($("#p_menge").val().replace(/[,\s]/gi,""))
					 + "&zdue_menge=" + encodeURIComponent($("#p_menge").val().replace(/[,\s]/gi,""))
					 + "&meins=" + encodeURIComponent($("#p_meins").val())
					 + "&remark=" + escape(encodeURIComponent($("#p_remark").val()))
					 + "&success_yn=N"
					 + "&eindt=" + encodeURIComponent($("#p_eindt").val());
		
		w2ui['grid'].lock('loading...', true);
		var rowArr = [];
		$.ajax({
			url : page_url,
			type : 'POST',
			dataType : 'json',
			async : false,
			success : function( data ) {
				if(data.status == 200 && data.cnt>0 ) {
					fnMessageModalAlert("Info", '등록이 완료 되었습니다.');
				} else {
					fnMessageModalAlert("Info", '등록이 실패 하었습니다.');
				}
				$("#modal_info").modal('hide');
				loadList();
			},complete: function () {}
		});
	} else {
		fnUpdate();
	}
}

function fnUpdate() {
	var page_url = "/frontend/project_update"
				 + "?project_no=" + encodeURIComponent($("#p_project_no").val())
				 + "&project_nm=" + escape(encodeURIComponent($("#p_project_nm").val()))
				 + "&netwr=" + encodeURIComponent($("#p_netwr").val())
				 + "&menge=" + encodeURIComponent($("#p_menge").val())
				 + "&zdue_menge=" + encodeURIComponent($("#p_menge").val())
				 + "&meins=" + encodeURIComponent($("#p_meins").val())
				 + "&remark=" + escape(encodeURIComponent($("#p_remark").val()))
				 + "&success_yn=" + escape(encodeURIComponent($("#p_success_yn").val()))
				 + "&eindt=" + encodeURIComponent($("#p_eindt").val())
				 + "&plan_dt=" + encodeURIComponent($("#p_plan_dt").val())
				 + "&purdt=" + encodeURIComponent($("#p_purdt").val())
				 + "&file_group=" + encodeURIComponent($("#p_file_group").val());
	
	w2ui['grid'].lock('loading...', true);
	var rowArr = [];
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		async : false,
		success : function( data ) {
			if(data.status == 200 && data.cnt>0 ) {
				fnMessageModalAlert("Info", '수정이 완료 되었습니다.');
			} else {
				fnMessageModalAlert("Info", '수정이 실패 하었습니다.');
			}
			$("#modal_info").modal('hide');
			loadList();
		},complete: function () {}
	});
}

function fnDelete() {
	var selIdxArr = w2ui.grid.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('Alert', '삭제할 항목을 목록에서 선택해야 합니다.');			
	} else if( chkLen>1 ) {
		fnMessageModalAlert('Alert', '삭제할 항목은 목록에서 1개 선택해야 합니다.');
	} else {
		var row = w2ui.grid.get(selIdxArr[0]);
		if ( Number(fnChkProject(row.project_no))>0 ) {
			fnMessageModalAlert('Alert', '수주등록에 연결된 항목이 있습니다.<br>확인 후 다시 시도하시기 바랍니다.');
		} else {
			var page_url = "/frontend/project_delete"
						 + "?project_no=" + encodeURIComponent(row.project_no);
			w2ui['grid'].lock('loading...', true);
			var rowArr = [];
			$.ajax({
				url : page_url,
				type : 'POST',
				dataType : 'json',
				async : false,
				success : function( data ) {
					if(data.status == 200 && data.cnt>0 ) {
						fnMessageModalAlert("Info", '삭제가 완료 되었습니다.');
					} else {
						fnMessageModalAlert("Info", '삭제 실패 하었습니다.');
					}
					loadList();
				},complete: function () {}
			});
		}
	}
}

function fnChkProject(proj_no) {
	console.log("fnChkProject()");
	/*
	before delete check connection poreg table
	*/
	var resultCnt = 0;
	var page_url = "/frontend/projectDeleteBefore"
				 + "?project_no=" + encodeURIComponent(proj_no);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		async : false,
		success : function( data ) {
			if(data.status == 200  ) {
				resultCnt = data.cnt;
			} else {
				resultCnt = 0;
			}
			loadList();
		},complete: function () {}
	});
	return resultCnt;
}

function fnUpload() {
	
}

function fnDownload() {
	
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
	        $("#p_lifnr").val(rowData.stenr);
	        $("#p_lifnr_nm").val(rowData.name1);
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

//serch parameter setting
function fnSearchRegListGrid(){
	console.log('fnSearchRegListGrid()');
	var page_url = "/file/file_select";
	page_url += "?file_cate=" + encodeURIComponent($("#s_type").val())
	page_url += "&file_nm=" + encodeURIComponent($("#p_filename").val())
// 	page_url += "&creator=" + encodeURIComponent($("#p_creator").val())
	page_url += "&file_del_yn=" + encodeURIComponent('N');
	
	w2ui['grid_reg'].lock('loading...', true);
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
				w2ui['grid_reg'].records = rowArr;
			} else {
				w2ui['grid_reg'].records = [];
			}
			w2ui['grid_reg'].refresh();
			w2ui['grid_reg'].unlock();
		},complete: function () {}
	});
}

//search result grid
function fnLoadRegListGrid(){
	var rowArr = [];
	$('#grid_reg').w2grid({ 
		name: 'grid_reg',
		show: {
			selectColumn: false,
			lineNumbers : true,
			footer: true
		},
		columns: [ 
// 			{ field:'lifnr', caption:'거래처코드', size:'80px', style:'text-align:center', frozen: true},
			{ field : 'file_group', caption:'파일그룹IDX', },
			{ field : 'file_no', caption:'파일NO', hidden:true},
			{ field : 'file_repo', caption:'파일저장소', hidden:true},
			{ field : 'file_path', caption:'파일경로', hidden:true},
			{ field : 'file_name', caption:'파일명'},
			{ field : 'file_ext', caption:'파일확장자', hidden:true},
			{ field : 'file_size', caption:'파일사이즈(KB)'},
			{ field : 'file_del_yn', caption:'삭제여부', hidden:true},
			{ field : 'file_thumnail', caption:'썸네일경로', hidden:true}],
		sortData: [{field: 'file_no', direction: 'ASC'}],
		records: rowArr,
		onReload: function(event) {
			fnSearchRegListGrid();
		},
		onDblClick: function(event) {
	        var rowData = w2ui.grid_reg.records[event.recid-1];
	        $("#p_file_group").val(rowData.file_group);
// 	        $("#vendor_name").val(rowData.name1);
	        $("#modal_print").modal('hide');
	    }
	});
	
	var page_url = "/file/file_select";
		page_url += "?file_cate=" + encodeURIComponent("drw")
// 		page_url += "?file_cate=" + encodeURIComponent($("#s_type").val())
		page_url += "&file_del_yn=" + encodeURIComponent('N');

	w2ui['grid_reg'].lock('loading...', true);
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
				w2ui['grid_reg'].records = rowArr;
			}
			w2ui['grid_reg'].refresh();
			w2ui['grid_reg'].unlock();
		},complete: function () {}
	});
}


/// test  sssbbbb
function test() 
{
	var selIdxArr = w2ui.grid.getSelection();
	console.log(selIdxArr);
	var row = w2ui.grid.get(selIdxArr[0]);
	console.log(row);
	
	console.log(row.project_no);
	
}
</script>
		
		</body>
</html>