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
	

	<style type="text/css">
	.popupText {
		margin-top:7px;
		font-weight: bold;
		font-size:15px;
		color: #566573;
	}
	</style>


</head>

<body class="hold-transition skin-green-light sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1011" />
		<jsp:param name="selected_menu_cd" value="1054" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>품질관리<small>수입검사</small></h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 품질관리</a></li><li class="active">수입검사</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-success box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
							<button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_insp');" data-selfilepath="/upload" data-selfilename="test.xlsx">
									 	<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
							</button>	
							<button type="button" class="btn btn-info btn-sm" onclick="drwDownload('drw');">
								도면 다운로드
							</button>
							<button type="button" id="btn_search"
								class="btn btn-primary btn-sm" onClick="fnSearchInspGrid();">조회</button>
							<button type="button" id="btn_search_init" class="btn btn-primary btn-sm" onClick="initCondition();">조건초기화</button>
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
									<label>| 구매문서 번호</label>
									<div class="form-group">
										<input type="text" id="i_ebeln" class="form-control input-sm">
									</div>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>| 검사 구분</label>
									<div class="form-group">
										<select id="i_inspGubun" class="form-control input-sm">
											<option value="">입하/입고 선택</option>
											<option value="IB">입하</option>
											<option value="IF">입고</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>| 상태</label>
									<div class="form-group">
										<select id="i_inspStatus" class="form-control input-sm">
											<option value="">선택</option>
											<option value="i1">수입검사 대기</option>
											<option value="i2">합격</option>
											<option value="i3">불합격</option>
										</select>
									</div>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>| 플랜트</label>
									<div class="form-group">
										<select id="i_werks" class="form-control input-sm">
											<option value="">선택</option>
											<option value="1110">의료영상</option>
											<option value="1210">광영상</option> 
										</select>
										 
									</div>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>
									<input type="radio" name="rdo_dateChk" class="flat-red" value="confirmDate">
									| 납품일자</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right input-sm" id="i_confirmDate">
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>
									<input type="radio" name="rdo_dateChk" class="flat-red" value="inFailDate">
									| 불합격 일자</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right input-sm" id="i_inFailDate">
									</div>
								</div>
							</div>
							
						</div>
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
									<label>| 자재 번호</label>
									<div class="form-group">
										<input type="text" id="i_matnr" class="form-control input-sm">
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>| 자재 내역</label>
									<div class="form-group">
										<input type="text" id="i_maktx" class="form-control input-sm">
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>| 자재 규격</label>
									<div class="form-group">
										<input type="text" id="i_wrkst" class="form-control input-sm">
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>| 업체명</label>
									<div class="form-group">
										<input type="text" id="i_name1" class="form-control input-sm">
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>
									<input type="radio" name="rdo_dateChk" class="flat-red" value="inDeliveryDate" checked>
									| 입하일자</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right input-sm" id="i_inDeliveryDate">
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>
									<input type="radio" name="rdo_dateChk" class="flat-red" value="inConfirmDate">
									| 입고일자(합격일자)</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right input-sm" id="i_inConfirmDate">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-12">
				<div id="dv_grid_insp" class="col-sm-12">
					<table id="grid_insp"></table>
				</div>
			</div>
		</section>
 	</div>
 	<div id='doctest' style="display:none">
	</div>
<!--  modal area1 -->
<div class="modal fade" id="modal_detail" data-backdrop="static">
	<div class="modal-dialog modal-bg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">합격/불합격 처리</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="box box-warning box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">선택항목 기본정보</h3>
						<div class="box-tools pull-right">
<!-- 							<button type="button" id="button0" onclick="printDoc();" class="btn btn-sm btn-primary">입고검사성적서 출력</button> -->
							<button type="button" id="button0" onclick="fn_print_doc();" class="btn btn-sm btn-primary">입고검사성적서 출력</button>
							
							<button type="button" id="button1" onclick="resultProcess('success');" class="btn btn-sm btn-primary">합격</button>
							<button type="button" id="button2" onclick="resultProcess('fail');" class="btn btn-sm btn-danger">불합격</button>
							<button type="button" id="button3" onclick="inspSave();" class="btn btn-sm btn-danger">내역수정</button>
						</div>
					</div>
					<div id="" class="box-body">
						<table class="table table-condensed">
							<tr>
<!-- 							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> LOT번호</th> -->
<!-- 							  <td class="col-md-2"> <div id="p_labnr" name="p_labnr" class="popupText" style="margin-top: 3px;">-</div> </td> -->
							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 최종납품일자</th>
							  <td class="col-md-2"> <div id="p_condate" name="p_condate" class="popupText" style="margin-top: 3px;">-</div> </td>
							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 품목명번호</th>
							  <td class="col-md-2"> <div id="p_matnr" name="p_matnr" class="popupText" style="margin-top: 3px;">-</div> </td>
<!-- 							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> PO번호</th> -->
<!-- 							  <td class="col-md-2"> <div id="p_ebeln" name="p_ebeln" class="popupText" style="margin-top: 3px;">-</div> </td> -->
							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 납품수량</th>
							  <td class="col-md-2"> <div id="p_zmenge" name="p_zmenge" class="popupText" style="margin-top: 3px;">-</div> </td>
							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 자재내역</th>
							  <td class="col-md-2"> <div id="p_maktx" name="p_maktx" class="popupText" style="margin-top: 3px;">-</div> </td>
							</tr>
							<tr>
							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 검사방법</th>
							  <td class="col-md-2"> <div id="p_inspCheckGubun" name="p_inspCheckGubun" class="popupText" style="margin-top: 3px;"></div> </td>
							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 상태</th>
							  <td class="col-md-2"> <div id="p_insp_status_nm" name="p_insp_status_nm" class="popupText" style="margin-top: 3px;"></div> </td>
							  <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 규격</th>
							  <td class="col-md-2"> <div id="p_wrkst" name="p_wrkst" class="popupText" style="margin-top: 3px;">-</div> </td>
						      <th class="bg-warning col-md-1 text-center" style="padding-top: 8px;"> 업체명</th>
							  <td class="col-md-2"> <div id="p_name1" name="p_name1" class="popupText" style="margin-top: 3px;">-</div> </td>
							</tr>
						</table>
						<input type="hidden" id="p_labnr">
						<input type="hidden" id="p_ebeln">
						<input type="hidden" id="p_ebelp">
						<input type="hidden" id="p_partialSeq">
						<input type="hidden" id="p_mblnr">
						<input type="hidden" id="p_mjahr">
						<input type="hidden" id="p_in_labnr">
						<input type="hidden" id="p_lgort">
						<input type="hidden" id="p_zdeli_menge">
						<input type="hidden" id="p_meins">
						<input type="hidden" id="p_maktx">
						<input type="hidden" id="p_werks">
<!-- 						<form id="info" name="info" class="form-horizontal"> -->
<!-- 							<div class="form-group" style="margin-bottom: 0px;"> -->
<!-- 								<div class="row"> -->
<!-- 									<div class="col-md-3"> -->
<!-- 										<div class="row"> -->
<!-- 											<label for="p_labnr" class="col-md-4 control-label">| LOT번호</label> -->
<!-- 											<div class="col-md-8"> -->
<!-- 												<div id="p_labnr" name="p_labnr" class="popupText">-</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 										<div class="row"> -->
<!-- 											<label for="p_matnr" class="col-sm-4 control-label">| 품목명번호</label> -->
<!-- 											<div class="col-sm-8"> -->
<!-- 												<div id="p_matnr" name="p_matnr" class="popupText">-</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="col-md-3"> -->
<!-- 										<div class="row"> -->
<!-- 											<label for="p_ebeln" class="col-sm-4 control-label">| PO번호</label> -->
<!-- 											<div class="col-sm-8"> -->
<!-- 												<div id="p_ebeln" name="p_ebeln" class="popupText">-</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 										<div class="row"> -->
<!-- 											<label for="p_maktx" class="col-sm-4 control-label">| 자재내역</label> -->
<!-- 											<div class="col-sm-8"> -->
<!-- 												<div id="p_maktx" name="p_maktx" class="popupText">-</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="col-md-4"> -->
<!-- 										<div class="row"> -->
<!-- 									 		<label for="p_inspCheckGubun" class="col-sm-3 control-label">| 검사방법</label> -->
<!-- 											<div class="col-sm-3"> -->
<!-- 												<div id="p_inspCheckGubun" name="p_inspCheckGubun" class="popupText"></div> -->
<!-- 											</div>	    -->
<!-- 											<label for="p_insp_status_nm" class="col-sm-2 control-label">|상태</label> -->
<!-- 											<div class="col-sm-3"> -->
<!-- 												<div id="p_insp_status_nm" name="p_insp_status_nm" class="popupText"></div> -->
<!-- 											</div>	 -->
<!-- 										</div> -->
<!-- 										<div class="row"> -->
<!-- 											<label for="p_wrkst" class="col-sm-3 control-label">| 규격</label> -->
<!-- 											<div class="col-sm-3"> -->
<!-- 												<div id="p_wrkst" name="p_wrkst" class="popupText">-</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<input type="hidden" id="p_ebelp"> -->
<!-- 									<input type="hidden" id="p_partialSeq"> -->
<!-- 									<input type="hidden" id="p_mblnr"> -->
<!-- 									<input type="hidden" id="p_mjahr"> -->
<!-- 									<input type="hidden" id="p_in_labnr"> -->
<!-- 									<input type="hidden" id="p_lgort"> -->
<!-- 									<input type="hidden" id="p_zdeli_menge"> -->
<!-- 									<input type="hidden" id="p_meins"> -->
<!-- 									<input type="hidden" id="p_maktx"> -->
<!-- 									<input type="hidden" id="p_werks"> -->
<!-- 									<div class="col-md-2 text-center"> -->
<!-- 										<button type="button" id="button1" onclick="resultProcess('success');" class="btn btn-primary btn-lg" style="height:60px; width:100px;">합격</button> -->
<!-- 										<button type="button" id="button2" onclick="resultProcess('fail');" class="btn btn-danger btn-lg" style="height:60px; width:100px;">불합격</button> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</form> -->
					</div>
				</div><!-- end box -->
				<div class="row">
					<div class="col-sm-1">
						<div class="form-group">
							<label>| 모델</label>
								<div class="form-group">
									<input type="text" id="i_model" class="form-control input-sm">
								</div>
						</div>
					</div>
					<div class="col-sm-2">
						<div class="form-group">
							<label>| ECR notice</label>
								<div class="form-group">
									<input type="text" id="i_ecr" class="form-control input-sm">
								</div>
						</div>
					</div>
					<div class="col-sm-2">
						<div class="form-group">
							<label>| 치수검사 AQL</label>
								<div class="form-group">
									<input type="text" id="i_insp_1" class="form-control input-sm">
								</div>
						</div>
					</div>
					<div class="col-sm-2">
						<div class="form-group">
							<label>| 외관/기능/형합성검사 AQL</label>
								<div class="form-group">
									<input type="text" id="i_insp_2" class="form-control input-sm">
								</div>
						</div>
					</div>
					<div class="col-sm-2">
						<div class="form-group">
							<label>| 문서번호</label>
								<div class="form-group">
									<input type="text" id="i_doc_no" class="form-control input-sm">
								</div>
						</div>
					</div>
					
					<div class="col-sm-3">
						<div class="form-group">
							<label>| 비고</label>
								<div class="form-group">
									<input type="text" id="i_insp_remark" class="form-control input-sm">
								</div>
						</div>
					</div>
					
					<div class="col-sm-2"  id="sample_type">
						<div class="form-group">
							<label>| Sample</label>
								<div class="form-group">
									<span>
										<input type="radio" id="8s_rdo" name="rdo_sampleChk" value="E" checked>8 Sample</input>
										<input type="radio" id="32s_rdo" name="rdo_sampleChk" value="T">32 Sample</input>
									</span>
								</div>
						</div>
					</div>
				</div>
<!-- 				<div style="height:500px;width:100%;"> -->
				<div id="dv_grid_inspDetail">
					<table id="grid_inspDetail"></table>
				</div>
<!-- 				</div> -->
			</div><!-- end modal body -->
		</div><!-- end modal content -->
	</div><!-- end modal dialog -->
</div><!-- end modal area1 --> 	


<%@include file="./import_inspection_doc.jsp"%>

  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>

<script src="/res/plugins/jquery-printme.js"></script>
<script type="text/javascript">
$(function($) {
	fnLoadCommonOption();
	
	$("input[name=rdo_sampleChk]").change(function() { 
		if($(':radio[name="rdo_sampleChk"]:checked').val() == "E") {
			console.log("8s");	 	

			$("#grid_inspDetail").setGridWidth(1550);
			$(".ui-jqgrid-htable").css("width",1550);
			$(".ui-jqgrid-btable").css("width",1550);

			$("#grid_inspDetail").jqGrid('setGridParam', {shrinkToFit: true});
		
			fnSettingGrid_inspDetail_8s();
		}
		if($(':radio[name="rdo_sampleChk"]:checked').val() == "T") {
			console.log("32s");
			
			var gridWidth = $("#grid_inspDetail").width();
			console.log(gridWidth);
			$("#grid_inspDetail").setGridWidth(1555);
			$(".ui-jqgrid-htable").css("width",1555);
			$(".ui-jqgrid-btable").css("width",1555);

			$("#grid_inspDetail").jqGrid('setGridParam', {shrinkToFit: false});

			fnSettingGrid_inspDetail_32s();
		}
	});
})

function fnSettingGrid_inspDetail_8s() {
	$("#grid_inspDetail").jqGrid("hideCol", [
	                                         "inspection_value9", "inspection_value10", "inspection_value11", "inspection_value12","inspection_value13",
	                                         "inspection_value14", "inspection_value15", "inspection_value16", "inspection_value17","inspection_value18",
	                                         "inspection_value19", "inspection_value20", "inspection_value21", "inspection_value22","inspection_value23",
	                                         "inspection_value24", "inspection_value25", "inspection_value26", "inspection_value27","inspection_value28",
	                                         "inspection_value29", "inspection_value30", "inspection_value31", "inspection_value32"
	                                         ]);
}

function fnSettingGrid_inspDetail_32s() {
	$("#grid_inspDetail").jqGrid("showCol", [
	                                         "inspection_value9", "inspection_value10", "inspection_value11", "inspection_value12","inspection_value13",
	                                         "inspection_value14", "inspection_value15", "inspection_value16", "inspection_value17","inspection_value18",
	                                         "inspection_value19", "inspection_value20", "inspection_value21", "inspection_value22","inspection_value23",
	                                         "inspection_value24", "inspection_value25", "inspection_value26", "inspection_value27","inspection_value28",
	                                         "inspection_value29", "inspection_value30", "inspection_value31", "inspection_value32"
	                                         ]);
}

// search component setting
function fnLoadCommonOption() {
	console.info('fnLoadCommonOption()');
	
	$(window).bind('resize', function() {
		resizeJqGrid("grid_insp", false);
		resizeJqGrid("grid_inspDetail", false);
	}).trigger('resize');
	
	$('input[type="radio"].flat-red').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green',
		handle: 'radio'
	});
	
	$('#i_confirmDate').daterangepicker({
		 locale: {
			format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
			,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
			,showMonthAfterYear: true
			,yearSuffix: '년'
			,orientation: "top left"
	    }
		,startDate : new Date().getFullYear() + '-' + (new Date().getMonth()+1) + '-01'
		,endDate : new Date()
	});
	$('#i_inFailDate').daterangepicker({
		 locale: {
			format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
			,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
			,showMonthAfterYear: true
			,yearSuffix: '년'
			,orientation: "top left"
	    }
		,startDate : new Date().getFullYear() + '-' + (new Date().getMonth()+1) + '-01'
		,endDate : new Date()
	});
	$('#i_inDeliveryDate').daterangepicker({
		 locale: {
			format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
			,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
			,showMonthAfterYear: true
			,yearSuffix: '년'
			,orientation: "top left"
	    }
		,startDate : new Date().getFullYear() + '-' + (new Date().getMonth()+1) + '-01'
		,endDate : new Date()
	});
	$('#i_inConfirmDate').daterangepicker({
		 locale: {
			format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
			,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
			,showMonthAfterYear: true
			,yearSuffix: '년'
			,orientation: "top left"
	    }
		,startDate : new Date().getFullYear() + '-' + (new Date().getMonth()+1) + '-01'
		,endDate : new Date()
	});
	initScreenSizeModal();
	fnLoadInspGrid();
	fnLoadInspDetailGrid();
	
	$("#8s_rdo").prop("checked", true)
	fnSettingGrid_inspDetail_8s();
}

function initCondition() {
// 	console.info('initCondition()');
	$("#i_ebeln").val("");
//	$("#i_werks").val("");
	$("#i_inspGubun").val("");
	$("#i_inspStatus").val("");
	$("#i_matnr").val("");
	$("#i_maktx").val("");
	$("#i_wrkst").val("");
	$("#i_name1").val("");
}

// serch result grid
function fnSearchInspGrid(){
// 	console.log('fnSearchInspGrid()');
	
	var jidate_from = '';
	var jidate_to = '';
	
	var page_url = "/frontend/mes/inInsp_select"
				 + "?ebeln=" + encodeURIComponent($("#i_ebeln").val())
				 + "&werks=" + encodeURIComponent($("#i_werks").val())
				 + "&insp_gubun=" + encodeURIComponent($("#i_inspGubun").val())
				 + "&insp_status=" + encodeURIComponent($("#i_inspStatus").val())
				 + "&matnr=" + encodeURIComponent($("#i_matnr").val())
				 + "&maktx=" + encodeURIComponent($("#i_maktx").val())
				 + "&wrkst=" + encodeURIComponent($("#i_wrkst").val())
				 + "&name1=" + encodeURIComponent($("#i_name1").val());
	
	// 일자 선택
	var chkVal = $(":input:radio[name=rdo_dateChk]:checked").val();
	if( chkVal=='confirmDate' ){
		jidate_from = $("#i_confirmDate").val().substring(0,10);
		jidate_to = $("#i_confirmDate").val().substring(13,23);
		page_url += "&confirm_date_from=" + encodeURIComponent(jidate_from)
				 + "&confirm_date_to=" + encodeURIComponent(jidate_to);
	} else if( chkVal=='inConfirmDate' ){
		jidate_from = $("#i_inConfirmDate").val().substring(0,10);
		jidate_to = $("#i_inConfirmDate").val().substring(13,23);
		page_url += "&in_confirm_date_from=" + encodeURIComponent(jidate_from)
			 	 + "&in_confirm_date_to=" + encodeURIComponent(jidate_to);
	} else if( chkVal=='inDeliveryDate' ){
		jidate_from = $("#i_inDeliveryDate").val().substring(0,10);
		jidate_to = $("#i_inDeliveryDate").val().substring(13,23);
		page_url += "&in_delivery_date_from=" + encodeURIComponent(jidate_from)
				 + "&in_delivery_date_to=" + encodeURIComponent(jidate_to);
	} else if( chkVal=='inFailDate' ){
		jidate_from = $("#i_inFailDate").val().substring(0,10);
		jidate_to = $("#i_inFailDate").val().substring(13,23);
		page_url += "&in_fail_date_from=" + encodeURIComponent(jidate_from)
				 + "&in_fail_date_to=" + encodeURIComponent(jidate_to);
	}
	
	$("#grid_insp").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_insp").trigger("reloadGrid");
}

// init grid
function fnLoadInspGrid(){
// 	console.log('fnLoadInspGrid()');
	// search condition : enter date range, vendor code, item name
	var jidate_from = '';
	var jidate_to = '';
	var page_url = "/frontend/mes/inInsp_select"
				 + "?ebeln=" + encodeURIComponent($("#i_ebeln").val())
				 + "&werks=" + encodeURIComponent($("#i_werks").val())
				 + "&insp_gubun=" + encodeURIComponent($("#i_inspGubun").val())
				 + "&insp_status=" + encodeURIComponent($("#i_inspStatus").val())
				 + "&matnr=" + encodeURIComponent($("#i_matnr").val())
				 + "&maktx=" + encodeURIComponent($("#i_maktx").val())
				 + "&wrkst=" + encodeURIComponent($("#i_wrkst").val())
				 + "&name1=" + encodeURIComponent($("#i_name1").val());

	// 일자 선택
	var chkVal = $(":input:radio[name=rdo_dateChk]:checked").val();
	if( chkVal=='confirmDate' ){
		jidate_from = $("#i_confirmDate").val().substring(0,10);
		jidate_to = $("#i_confirmDate").val().substring(13,23);
		page_url += "&confirm_date_from=" + encodeURIComponent(jidate_from)
				 + "&confirm_date_to=" + encodeURIComponent(jidate_to);
	} else if( chkVal=='inConfirmDate' ){
		jidate_from = $("#i_inConfirmDate").val().substring(0,10);
		jidate_to = $("#i_inConfirmDate").val().substring(13,23);
		page_url += "&in_confirm_date_from=" + encodeURIComponent(jidate_from)
			 	 + "&in_confirm_date_to=" + encodeURIComponent(jidate_to);
	} else if( chkVal=='inDeliveryDate' ){
		jidate_from = $("#i_inDeliveryDate").val().substring(0,10);
		jidate_to = $("#i_inDeliveryDate").val().substring(13,23);
		page_url += "&in_delivery_date_from=" + encodeURIComponent(jidate_from)
				 + "&in_delivery_date_to=" + encodeURIComponent(jidate_to);
	} else if( chkVal=='inFailDate' ){
		jidate_from = $("#i_inFailDate").val().substring(0,10);
		jidate_to = $("#i_inFailDate").val().substring(13,23);
		page_url += "&in_fail_date_from=" + encodeURIComponent(jidate_from)
				 + "&in_fail_date_to=" + encodeURIComponent(jidate_to);
	}
	
	$("#grid_insp").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['구매문서번호','품목번호', '순번', '업체명','품번', '자재내역', '규격', '단위', '검사 구분코드', '검사 구분', '검사상세코드', '검사상세', '상태코드', '상태',
		          '최종납품일자', '입하일자', '입고일자', '불합격일자', '구매오더일자', '납품요청일자', '요청수량', '납품수량',
		          '플랜트', '회사코드', '저장위치', '자재문서번호', '자재문서연도', '납품문서번호', '납품일정번호', 'in_labnr', '공급업체계정번호',
		          '성공여부', '실패여부', '공급업체명', '납품내역', '처리메세지', 'insp_model', 'insp_maql', 'insp_vaql', 'insp_doc', 'insp_ecr', 'insp_remark'],
		colModel:[
	        {name:'ebeln', index:'ebeln', width:25, sorttype:"text", sortable:true},
	        {name:'ebelp', index:'ebelp', width:20, sorttype:"text", sortable:true},
	        {name:'partial_seq', index:'partial_seq', width:15, sorttype:"text", sortable:true},
	        {name:'name1', index:'name1', width:35, sorttype:"text", sortable:true},
        	{name:'matnr', index:'matnr', width:40, sorttype:"text", sortable:true},
        	{name:'maktx', index:'maktx', width:50, sorttype:"text", sortable:true},
        	{name:'wrkst', index:'wrkst', width:50, sorttype:"text", sortable:true},
        	{name:'meins', index:'meins', width:10, sorttype:"text", sortable:true, hidden:true},
        	{name:'insp_gubun', index:'insp_gubun', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'insp_gubun_nm', index:'insp_gubun_nm', width:20, sorttype:"text", sortable:true },
        	{name:'insp_check_gubun', index:'insp_check_gubun', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'insp_check_gubun_nm', index:'insp_check_gubun_nm', width:25, sorttype:"text", sortable:true },
        	{name:'insp_status', index:'insp_status', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'insp_status_nm', index:'insp_status_nm', width:25, sorttype:"text", sortable:true },
        	{name:'confirm_date', index:'confirm_date', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'in_delivery_date', index:'in_delivery_date', width:20, sorttype:"text", sortable:true},
        	{name:'in_confirm_date', index:'in_confirm_date', width:20, sorttype:"text", sortable:true},
        	{name:'in_fail_date', index:'in_fail_date', width:25, sorttype:"text", sortable:true},
        	{name:'order_delivery_date', index:'order_delivery_date', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'vendor_delivery_date', index:'vendor_delivery_date', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'menge', index:'menge', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'zdeli_menge', index:'zdeli_menge', width:20, sorttype:"text", sortable:true},
        	{name:'werks', index:'werks', width:20, sorttype:"text", sortable:true},
        	{name:'bukrs', index:'bukrs', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'lgort', index:'lgort', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'mblnr', index:'mblnr', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'mjahr', index:'mjahr', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'sap_doc_no', index:'sap_doc_no', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'labnr', index:'labnr', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'in_labnr', index:'in_labnr', hidden:true},
        	{name:'lifnr', index:'lifnr', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'success_yn', index:'success_yn', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'fail_yn', index:'fail_yn', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'name1', index:'name1', width:20, sorttype:"text", sortable:true , hidden:true},
        	{name:'txz01', index:'txz01', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'remark', index:'remark', width:100, sorttype:"text"},
        	{name:'insp_model', index:'insp_model', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'insp_maql', index:'insp_maql', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'insp_vaql', index:'insp_vaql', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'insp_doc', index:'insp_doc', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'insp_ecr', index:'insp_ecr', width:20, sorttype:"text", sortable:true, hidden:true},
        	{name:'insp_remark', index:'insp_remark', width:20, sorttype:"text", sortable:true, hidden:true}
		],
		rowNum:-1,
	    height: 500,
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
	    loadComplete : function(data){
	    },
		onSelectRow: function(rowid, selected) {
			if(rowid != null) {
				var selected_row = $("#grid_insp").getRowData($('#grid_insp').jqGrid('getGridParam','selrow'));
				if(selected_row.insp_status == 'i1') {
					$("#sample_type").show();
				} else {
					$("#sample_type").hide();
				}
					
				$("#8s_rdo").prop("checked", true)
// 				fnSettingGrid_inspDetail_8s();
                
				$("#i_model").val(selected_row.insp_model);
				$("#i_ecr").val(selected_row.insp_ecr);
				$("#i_insp_1").val(selected_row.insp_maql);
				$("#i_insp_2").val(selected_row.insp_vaql);
				$("#i_doc_no").val(selected_row.insp_doc); 
				$("#i_insp_remark").val(selected_row.insp_remark); 
				
				showDetailPopup();
			}					
		}
	}); 
}

//serch result grid
function fnSearchInspDetailGrid(){
// 	console.log('fnSearchInspDetailGrid()');
	var inspData = $("#grid_insp").getRowData($('#grid_insp').jqGrid('getGridParam','selrow'));
	var page_url = "/frontend/qm/inInspDetail_select"
				 + "?matnr=" + encodeURIComponent(inspData.matnr);
	
	$("#grid_inspDetail").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_inspDetail").trigger("reloadGrid");
}

//serch result grid
function fnSearchInspResultGrid(){
	console.log('fnSearchInspDetailGrid()');
	var inspData = $("#grid_insp").getRowData($('#grid_insp').jqGrid('getGridParam','selrow'));
	var page_url = "/frontend/qm/inInspResult_select"
				 + "?ebeln=" + encodeURIComponent(inspData.ebeln)
				 + "&ebelp=" + encodeURIComponent(inspData.ebelp)
				 + "&partial_seq=" + encodeURIComponent(inspData.partial_seq)
	
	$("#grid_inspDetail").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_inspDetail").trigger("reloadGrid");
}

function setRadio(cellVAlue, option){
// 	console.log('setRadio(',cellVAlue, option,')');
    if (cellVAlue=='Y'){
    	var htmlCode = "합격 <input type='radio' name='deci_"+option.rowId+"' value='Y' checked/> / "
		 + "불합격 <input type='radio' name='deci_"+option.rowId+"' value='N'/>";
    }else if(cellVAlue=='N'){
    	var htmlCode = "합격 <input type='radio' name='deci_"+option.rowId+"' value='Y' /> / "
		 + "불합격 <input type='radio' name='deci_"+option.rowId+"' value='N' checked/>";
    }else{
    	var htmlCode = "합격 <input type='radio' name='deci_"+option.rowId+"' value='Y' checked/> / "
		 + "불합격 <input type='radio' name='deci_"+option.rowId+"' value='N'/>";
    }
	return htmlCode;
}

function fnLoadInspDetailGrid(){
	console.log('fnLoadInspDetailGrid()');
	var inspData = $("#grid_insp").getRowData($('#grid_insp').jqGrid('getGridParam','selrow'));
	$("#grid_inspDetail").jqGrid({
		url:'',
		datatype: "json",
		colNames:['검사항목', '검사기준', '검사방법', 
				  '#1','#2','#3','#4','#5',
				  '#6','#7','#8','#9','#10',
				  '#11','#12','#13','#14','#15',
				  '#16','#17','#18','#19','#20',
				  '#21','#22','#23','#24','#25',
				  '#26','#27','#28','#29','#30',
				  '#31','#32',
		          'C/N','합/불', 'inspection_value_low', 'inspection_value_max',
		          'inspection_remark_code', 'inspection_code', 'inspection_gcode', 'inspection_gnm', 'inspection_type','insp_header_seq' ],		
		colModel:[
	        {name:'inspection_list', index:'inspection_list', width:80, sorttype:"text", sortable:true},
	        {name:'inspection_standard', index:'inspection_standard', width:180, sorttype:"text", sortable:true},
        	{name:'inspection_remark', index:'inspection_remark', width:90, sorttype:"text", sortable:true},
        	{name:'inspection_value1', index:'inspection_value1', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value2', index:'inspection_value2', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value3', index:'inspection_value3', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value4', index:'inspection_value4', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value5', index:'inspection_value5', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value6', index:'inspection_value6', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value7', index:'inspection_value7', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value8', index:'inspection_value8', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value9', index:'inspection_value9', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value10', index:'inspection_value10', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value11', index:'inspection_value11', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value12', index:'inspection_value12', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value13', index:'inspection_value13', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value14', index:'inspection_value14', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value15', index:'inspection_value15', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value16', index:'inspection_value16', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value17', index:'inspection_value17', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value18', index:'inspection_value18', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value19', index:'inspection_value19', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value20', index:'inspection_value20', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value21', index:'insp_check_gubun21', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value22', index:'insp_check_gubun22', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value23', index:'insp_check_gubun23', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value24', index:'insp_check_gubun24', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value25', index:'insp_check_gubun25', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value26', index:'insp_check_gubun26', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value27', index:'insp_check_gubun27', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value28', index:'insp_check_gubun28', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value29', index:'insp_check_gubun29', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value30', index:'insp_check_gubun30', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value31', index:'insp_check_gubun31', width:90, sorttype:"text",sortable:true, editable:true},
        	{name:'inspection_value32', index:'insp_check_gubun32', width:90, sorttype:"text",sortable:true, editable:true},
        	
        	{name:'inspection_cn', index:'inspection_cn', width:50, sorttype:"text",sortable:true},
        	{name:'inspection_decision', index:'inspection_decision', width:150, edittype:"radio", formatter:setRadio},
        	{name:'inspection_value_low', index:'inspection_value_low', hidden:true},
        	{name:'inspection_value_max', index:'inspection_value_max', hidden:true},
        	{name:'inspection_remark_code', index:'inspection_remark_code', hidden:true},
        	{name:'inspection_code', index:'inspection_code', hidden:true},
        	{name:'inspection_gcode', index:'inspection_gcode', hidden:true},
        	{name:'inspection_gnm', index:'inspection_gnm', hidden:true},
        	{name:'inspection_type', index:'inspection_type', hidden:true},
        	{name:'insp_header_seq', index:'insp_header_seq', hidden:true}
		],
		rowNum:1000,
	    height: 480,
	    rownumWidth: 25,
		viewrecords : true,
	    autowidth : false,
	    shrinkToFit: false, 
	    multiselect : true,
		altRows: true,
		rownumbers: true, 
	    autoencode: true,
	    loadonce: true,
	    sortable: true,
		cellEdit:true,
		cellsubmit : 'clientArray',
	    loadComplete : function(data){
	    	if(data.rows.length > 0) {
// 	    		$("#grid_inspDetail").jqGrid('destroyGroupHeader');
	    		if(data.rows[0].inspection_type == 'T') {
	    			$("#grid_inspDetail").jqGrid('setGridParam', {shrinkToFit: false});
	    			fnSettingGrid_inspDetail_32s();	    			
	    		} else {
	    			$("#grid_inspDetail").jqGrid('setGridParam', {shrinkToFit: true});
	    			fnSettingGrid_inspDetail_8s();
	    		}

	    		$("#grid_inspDetail").jqGrid('destroyGroupHeader');
	    		setTimeout(function(){
	    			fnsetGroupHeaders();
				}, 200);		
	    	}
	    },
	    onSelectRow: function(rowid, selected) {
			if(rowid != null) {}					
		},
	    onCellSelect: function(rowid, index, contents, event){ 
// 	    	console.log(rowid, index, contents, event);
	    	var rowData = $("#grid_inspDetail").getRowData();
	    	var remarkCode = rowData.inspection_remark_code;
	    	var colModels = $(this).getGridParam('colModel'); 
	    	var colName = colModels[index].name;
	    	if( colName=='inspection_value' && (remarkCode!='RI1') || colName=='inspection_cn' && (remarkCode!='RI1')  )   { 
	    		$(this).setColProp(colName, { editable: true }); 
	    		$(this).editCell($("#grid_inspDetail").getInd(rowid), index, true);
	    	} 
	    },
	    afterEditCell: function (rowid, cellname, value, iRow, iCol) {
// 	    	console.warn(rowid, cellname, value, iRow, iCol);
			//This code saves the state of the box when focus is lost in a pretty horrible
            //way, may be they will add support for this in the future
            //set up horrible hack for pressing enter when leaving cell
//             if((cellname=='inspection_value1') || (cellname=='inspection_cn'))   {
			if((cellname.indexOf('inspection_value')) || (cellname.indexOf('inspection_cn'))) {
	            e = jQuery.Event("keydown");
	            e.keyCode = $.ui.keyCode.ENTER;
	            //get the edited thing
	            edit = $(".edit-cell > *");
	            edit.blur(function() {
	                edit.trigger(e);
	            });
            }
    	}
	});
}

function fnsetGroupHeaders() {
	$("#grid_inspDetail").jqGrid('setGroupHeaders', {
		useColSpanStyle: true, 
		groupHeaders:[		  
		  {startColumnName: 'inspection_value1', numberOfColumns: 32, titleText: '검사입력(수치)'}
		]
	});	
}

function fndestroyGroupHeaders() {
	$("#grid_inspDetail").jqGrid('setGroupHeaders', {
		useColSpanStyle: true, 
		groupHeaders:[		  
		  {startColumnName: 'inspection_value1', numberOfColumns: 32, titleText: '검사입력(수치)'}
		]
	});	
}


function showDetailPopup() {
// 	console.info('showDetailPopup()');
	
	var inspData = $("#grid_insp").getRowData($('#grid_insp').jqGrid('getGridParam','selrow'));
// 	console.log(inspData);
	$("#p_labnr").val(inspData.labnr);
	$("#p_ebeln").val(inspData.ebeln);
	$("#p_condate").text(inspData.confirm_date);
	$("#p_zmenge").text(inspData.zdeli_menge + " " + inspData.meins);
	$("#p_inspCheckGubun").text(inspData.insp_check_gubun_nm);
	$("#p_matnr").text(inspData.matnr);
	$("#p_maktx").text(inspData.maktx);
	$("#p_wrkst").text(inspData.wrkst);
	$("#p_ebelp").val(inspData.ebelp);
	$("#p_partialSeq").val(inspData.partial_seq);
	$("#p_mblnr").val(inspData.mblnr);	
	$("#p_mjahr").val(inspData.mjahr);	
	$("#p_in_labnr").val(inspData.in_labnr);	
	$("#p_lgort").val(inspData.lgort);	
	$("#p_zdeli_menge").val(inspData.zdeli_menge);	
	$("#p_meins").val(inspData.meins);	
	$("#p_werks").val(inspData.werks);
	$("#p_insp_status_nm").text(inspData.insp_status_nm);
	$("#p_name1").text(inspData.name1);
	 
	if (inspData.insp_status =='i1' ){
		 $('#button1').prop('disabled', false);
		 $('#button2').prop('disabled', false);
		 $('#button0').prop('disabled', true);
		 $('#button3').prop('disabled', true);
		fnSearchInspDetailGrid();
	}else{
		 $('#button1').prop('disabled', true);
		 $('#button2').prop('disabled', true);
		 $('#button0').prop('disabled', false);
		 $('#button3').prop('disabled', false);
		fnSearchInspResultGrid();
	}
	
	s_inspData = {};
	$("#modal_detail").modal('show');
	
	resizeJqGrid("grid_inspDetail", false);
}

var s_inspData = {};

function resultProcess(result) {
// 	console.log('resultProcess(',result,')');
	
	var inspData = $("#grid_insp").getRowData($("#grid_insp").jqGrid('getGridParam','selrow')); 
	var checkGridData = [];
	var keyArr = $("#grid_inspDetail").jqGrid('getDataIDs');
	var cnt = 0;
	for (var i=0; i<keyArr.length; i++) { //row id수만큼 실행           
    	if($("input:checkbox[id='jqg_grid_inspDetail_"+keyArr[i]+"']").is(":checked")){ //checkbox checked 여부 판단
    		var selRow = {};
    		cnt++;
    		selRow = $("#grid_inspDetail").getRowData(keyArr[i]);
    		selRow.inspection_decision = $('input[name=deci_'+keyArr[i]+']:checked').val();
    		selRow.insp_gubun = inspData.insp_gubun;
    		
    		selRow.inspection_type =  $(':radio[name="rdo_sampleChk"]:checked').val();
    		
    		checkGridData.push(selRow);
    	}
   	}
	 
	if( cnt==0 ){
		fnMessageModalAlert("확인하세요.", "처리할 데이터가 체크되지 않았습니다.");
		return;
	}
	var tmpDay = new Date();
	var toDay = getFormatDate(tmpDay);
	
	var successData = [];
	var failData = [];
	$.each(checkGridData, function(idx, row){
// 		console.log(idx, row);
		row.ebeln = $("#p_ebeln").val();
		row.ebelp = $("#p_ebelp").val();
	 	row.partial_seq = $("#p_partialSeq").val();
	 	row.matnr = $("#p_matnr").text();
	 	row.insp_check_gubun = $("#p_inspCheckGubun").text();
		row.maktx = $("#p_maktx").text();
		row.wrkst = $("#p_wrkst").text();
		row.mblnr = $("#p_mblnr").val();	
		row.mjahr = $("#p_mjahr").val();	
		row.in_labnr = $("#p_in_labnr").val();	
		row.lgort = $("#p_lgort").val();	
		row.zdeli_menge = $("#p_zdeli_menge").val();	
		row.meins = $("#p_meins").val();
		row.werks = $("#p_werks").val();
		inspData.mblnr = $("#p_mblnr").val();	
		inspData.mjahr = $("#p_mjahr").val();	
	 	if( result=='success' ) {
	 		row.insp_status = 'i2';
	 		row.in_cofirm_date = toDay;
	 		row.in_fail_date = '';
	 		inspData.insp_status = 'i2';
	 		inspData.in_cofirm_date = toDay;
	 		inspData.in_fail_date = '';
	 		successData.push(row);
	 	} else {
	 		row.insp_status = 'i3';
	 		row.in_cofirm_date = '';
	 		row.in_fail_date = toDay;
	 		inspData.insp_status = 'i3';
	 		inspData.in_cofirm_date = '';
	 		inspData.in_fail_date = toDay;
	 		failData.push(row);
		}
	});
	
	var page_url = "/frontend/qm/inspResultProcess";
	
	var postData  = 'funcName=' + encodeURIComponent("ZMMFM_GOODSMVT_PO")
	//var postData = '?funcName=ZMMFM_GOODSMVT_PO'
				 + '&gubun=' + encodeURIComponent(result)
				 + '&headerJson=' + encodeURIComponent(JSON.stringify(inspData));
	if( result=='success' ) {
		postData += '&params=' + encodeURIComponent(JSON.stringify(successData));
	} else {
		postData += '&params=' + encodeURIComponent(JSON.stringify(failData));
	}
	
	postData += '&insp_model=' + encodeURIComponent($("#i_model").val());
	postData += '&insp_ecr=' + encodeURIComponent($("#i_ecr").val());
	postData += '&insp_maql=' + encodeURIComponent($("#i_insp_1").val());
	postData += '&insp_vaql=' + encodeURIComponent($("#i_insp_2").val());
	postData += '&insp_doc=' + encodeURIComponent($("#i_doc_no").val());
	postData += '&insp_remark=' + encodeURIComponent($("#i_insp_remark").val());
// 	console.log(result);
 	console.log(inspData);
// 	console.log(successData);
// 	console.log(failData);

	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    async:false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "S") {	    		
	    	//	fnMessageModalConfirm("Notification(HUB)", "정보를 저장하였습니다. >>>>>>>> sap 전송 결과) e_return : " + data.e_return + " // e_message : "+ data.e_message, function(chk){	
		     	fnMessageModalConfirm("Notification(SCM)", "정보를 저장하였습니다.", function(chk){
		    		if(chk){
		    			$("#modal_detail").modal('hide');
		    			fnSearchInspGrid();
		    			
		    			setTimeout(function(){
		    				s_inspData = loadInspData(inspData);  	
		 
		    				$("#p_labnr").val(s_inspData.labnr);
		    				$("#p_ebeln").val(s_inspData.ebeln);
		    				$("#p_condate").text(s_inspData.confirm_date);
		    				$("#p_zmenge").text(s_inspData.zdeli_menge + " " + s_inspData.meins);
		    				$("#p_inspCheckGubun").text(s_inspData.insp_check_gubun_nm);
		    				$("#p_matnr").text(s_inspData.matnr);
		    				$("#p_maktx").text(s_inspData.maktx);
		    				$("#p_wrkst").text(s_inspData.wrkst);
		    				$("#p_ebelp").val(s_inspData.ebelp);
		    				$("#p_partialSeq").val(s_inspData.partial_seq);
		    				$("#p_mblnr").val(s_inspData.mblnr);	
		    				$("#p_mjahr").val(s_inspData.mjahr);	
		    				$("#p_in_labnr").val(s_inspData.in_labnr);	
		    				$("#p_lgort").val(s_inspData.lgort);	
		    				$("#p_zdeli_menge").val(s_inspData.zdeli_menge);	
		    				$("#p_meins").val(s_inspData.meins);	
		    				$("#p_werks").val(s_inspData.werks);
		    				$("#p_insp_status_nm").text(s_inspData.insp_status_nm);
		    				$("#p_name1").text(s_inspData.name1);
		    			
		    			 	$('#button1').prop('disabled', true);
		    				$('#button2').prop('disabled', true);
		    				$('#button0').prop('disabled', false);
		    				$('#button3').prop('disabled', false);
		    				
		    				loadInspResultData(s_inspData);
		    				$("#modal_detail").modal('show');
		    				
		    				resizeJqGrid("grid_inspDetail", false);
		    			}, 500);
	    			}
	    		});
	    	} else {
	    		fnMessageModalAlert("Notification(SCM)", "정보를 저장하는데 에러가 발생하였습니다." + data.message );	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
	
	
	
}

function getFormatDate(d) {
	var month = d.getMonth();
	if( month==12 ) month = 0;
	else month += 1; 
	var date = d.getDate();
	month = (month < 10) ? "0" + month : month;
	date = (date < 10) ? "0" + date : date;
	return d.getFullYear() + '-' + month + '-' + date;
}

function printDoc() {

	var selGridRowData = $("#grid_insp").getRowData($('#grid_insp').jqGrid('getGridParam','selrow'));
	
	var keyArr = $('#grid_inspDetail').jqGrid('getDataIDs');
	
	var selDetailGridRowData = $("#grid_inspDetail").getRowData();
		
	var cnt =0;
	
	//10개 이하면 1장에 처리
	if(selDetailGridRowData.length <16) {
		
		var my_tbody = document.getElementById('my0-tbody_1');
		
		$('#s_model_1').html(' ');
		$('#s_comp_1').html(selGridRowData.name1);
		$('#s_matnr_1').html(selGridRowData.matnr);
		$('#s_matnr_nm_1').html(selGridRowData.txz01);
		
		
		$('#attention_1').html('주의사항 : <br/>');
		$('#ecr_1').html('ECR notice: : <br/>');
		
		
		if(selGridRowData.insp_status == 'i2') {
			$('#insp_day_1_1').html(selGridRowData.in_confirm_date);
			$('#insp_day_2_1').html(selGridRowData.in_confirm_date);
			
			$('#result_1').html("합격");
		} else if(selGridRowData.insp_status == 'i3') {
			$('#insp_day_1_1').html(selGridRowData.in_fail_date);
			$('#insp_day_2_1').html(selGridRowData.in_fail_date);
			
			$('#result_1').html('불합격');
		}
		$('#cnt_1').html(selGridRowData.zdeli_menge);
		
		for(var i=0 ; i<selDetailGridRowData.length ; i++) {
			var oRow = my_tbody.insertRow();	
			var oCell1 = oRow.insertCell();
			oCell1.id = "oCell1";
			var oCell2 = oRow.insertCell();
			oCell2.id = "oCell2";
			var oCell3 = oRow.insertCell();
			oCell3.id = "oCell3";
			var oCell4 = oRow.insertCell();
			oCell4.id = "oCell4";
			var oCell5 = oRow.insertCell();
			oCell5.id = "oCell5";
			var oCell6 = oRow.insertCell();
			oCell6.id = "oCell6";
			var oCell7 = oRow.insertCell();
			oCell7.id = "oCell7";
			var oCell8 = oRow.insertCell();
			oCell8.id = "oCell8";
			var oCell9 = oRow.insertCell();
			oCell9.id = "oCell9";
			 
			oCell1.innerHTML= "<a style='font-size: 8px;'>" + Number(i) +"</a>";
			oCell2.innerHTML= "<a style='font-size: 8px;'>" + selDetailGridRowData[i].inspection_list+"</a>";
			oCell3.innerHTML= "<a style='font-size: 8px;'>" + selDetailGridRowData[i].inspection_standard+"</a>";
			oCell4.innerHTML= "<a style='font-size: 8px;'>" + 'G I'+"</a>";
			oCell5.innerHTML= "<a style='font-size: 8px;'>" + selDetailGridRowData[i].inspection_remark+"</a>";
			oCell6.innerHTML= ' ';
			oCell7.innerHTML= ' ';
			oCell8.innerHTML= "<a style='font-size: 8px;'>" + selDetailGridRowData[i].inspection_value+"</a>";
				  
				 
			if( $('input[name=deci_'+(i+1)+']:checked').val() == 'Y') {
				oCell9.innerHTML= "<a style='font-size: 8px;'>" + '◎' +"</a>";	
			} else {
				oCell9.innerHTML=  "<a style='font-size: 8px;'>" +'x' +"</a>";	
			}
			
				
			var oRow = my_tbody.insertRow();
			 
			var aCell1 = oRow.insertCell();
			aCell1.id = "aCell1";
			var aCell2 = oRow.insertCell();
			aCell2.id = "aCell2";
			var aCell3 = oRow.insertCell();
			aCell3.id = "aCell3";
				 
			aCell1.innerHTML= "<a style='font-size: 8px;'>1.5</a>";
			aCell2.innerHTML= "<a style='font-size: 8px;'>&nbsp;</a>";
			aCell3.innerHTML= "<a style='font-size: 8px;'>"+selDetailGridRowData[i].inspection_cn+"</a>";
			
			oCell1.rowSpan=2;
			oCell2.rowSpan=2;
			oCell3.rowSpan=2;
			oCell5.rowSpan=2;
			oCell6.rowSpan=2;
			oCell8.rowSpan=2;
		}

	}
	//2장짜리
	if(selDetailGridRowData.length > 21  &&  selDetailGridRowData.length < 41) {
		//page 1
		
		$('#s_model_2').html(' ');
		$('#s_comp_2').html(selGridRowData.name1);
		$('#s_matnr_2').html(selGridRowData.matnr);
		$('#s_matnr_nm_2').html(selGridRowData.txz01);
		
		$('#attention_2').html('주의사항 : <br/>');		
		$('#ecr_2').html('ECR notice: : <br/>');
		
		if(selGridRowData.insp_status == 'i2') {
			$('#insp_day_1_2').html(selGridRowData.in_confirm_date);
			$('#insp_day_2_2').html(selGridRowData.in_confirm_date);
			
			$('#result_2').html("합격");
		} else if(selGridRowData.insp_status == 'i3') {
			$('#insp_day_1_2').html(selGridRowData.in_fail_date);
			$('#insp_day_2_2').html(selGridRowData.in_fail_date);
			
			$('#result_2').html('불합격');
		}
		$('#cnt_2').html(selGridRowData.zdeli_menge);
		
		for(var i=0 ; i<20 ; i++) {

			var my_tbody = document.getElementById('my1-tbody_1');
			
			var oRow = my_tbody.insertRow();	
			
			var oCell1 = oRow.insertCell();
			oCell1.id = "oCell1";
			var oCell2 = oRow.insertCell();
			oCell2.id = "oCell2";
			var oCell3 = oRow.insertCell();
			oCell3.id = "oCell3";
			var oCell4 = oRow.insertCell();
			oCell4.id = "oCell4";
			var oCell5 = oRow.insertCell();
			oCell5.id = "oCell5";
			var oCell6 = oRow.insertCell();
			oCell6.id = "oCell6";
			var oCell7 = oRow.insertCell();
			oCell7.id = "oCell7";
			var oCell8 = oRow.insertCell();
			oCell8.id = "oCell8";
			var oCell9 = oRow.insertCell();
			oCell9.id = "oCell9";
				 
			oCell1.innerHTML= "<a style='font-size: 8px;'>" + Number(i) +"</a>";
			oCell2.innerHTML= "<a style='font-size: 8px;'>" + selDetailGridRowData[i].inspection_list+"</a>";
			oCell3.innerHTML= "<a style='font-size: 8px;'>" + selDetailGridRowData[i].inspection_standard+"</a>";
			oCell4.innerHTML= "<a style='font-size: 8px;'>" + 'G I'+"</a>";
			oCell5.innerHTML= "<a style='font-size: 8px;'>" + selDetailGridRowData[i].inspection_remark+"</a>";
			oCell6.innerHTML= ' ';
			oCell7.innerHTML= ' ';
			oCell8.innerHTML= "<a style='font-size: 8px;'>" + selDetailGridRowData[i].inspection_value+"</a>";
				  
				 
			if( $('input[name=deci_'+(i+1)+']:checked').val() == 'Y') {
				oCell9.innerHTML= "<a style='font-size: 8px;'>" + '◎' +"</a>";	
			} else {
				oCell9.innerHTML=  "<a style='font-size: 8px;'>" +'x' +"</a>";	
			}
				
				
			var oRow = my_tbody.insertRow();
			 
			var aCell1 = oRow.insertCell();
			aCell1.id = "aCell1";
			var aCell2 = oRow.insertCell();
			aCell2.id = "aCell2";
			var aCell3 = oRow.insertCell();
			aCell3.id = "aCell3";
				 
			aCell1.innerHTML= "<a style='font-size: 8px;'>1.5</a>";
			aCell2.innerHTML= "<a style='font-size: 8px;'>&nbsp;</a>";
			aCell3.innerHTML= "<a style='font-size: 8px;'>"+selDetailGridRowData[i].inspection_cn+"</a>";
				
			oCell1.rowSpan=2;
			oCell2.rowSpan=2;
			oCell3.rowSpan=2;
			oCell5.rowSpan=2;
			oCell6.rowSpan=2;
			oCell8.rowSpan=2;
		}
		
		
			//page 2
	
			
	
		for(var i=20 ; i<selDetailGridRowData.length ; i++) {
	
			var my_tbody = document.getElementById('my1-tbody_2');
				
			var oRow = my_tbody.insertRow();	
			
			var oCell1 = oRow.insertCell();
			oCell1.id = "oCell1";
			var oCell2 = oRow.insertCell();
			oCell2.id = "oCell2";
			var oCell3 = oRow.insertCell();
			oCell3.id = "oCell3";
			var oCell4 = oRow.insertCell();
			oCell4.id = "oCell4";
			var oCell5 = oRow.insertCell();
			oCell5.id = "oCell5";
			var oCell6 = oRow.insertCell();
			oCell6.id = "oCell6";
			var oCell7 = oRow.insertCell();
			oCell7.id = "oCell7";
			var oCell8 = oRow.insertCell();
			oCell8.id = "oCell8";
			var oCell9 = oRow.insertCell();
			oCell9.id = "oCell9";
				 
			oCell1.innerHTML= "<a style='font-size: 8px;'>" + Number(i) +"</a>";
			oCell2.innerHTML= "<a style='font-size: 8px;'>" + selDetailGridRowData[i].inspection_list+"</a>";
			oCell3.innerHTML= "<a style='font-size: 8px;'>" + selDetailGridRowData[i].inspection_standard+"</a>";
			oCell4.innerHTML= "<a style='font-size: 8px;'>" + 'G I'+"</a>";
			oCell5.innerHTML= "<a style='font-size: 8px;'>" + selDetailGridRowData[i].inspection_remark+"</a>";
			oCell6.innerHTML= ' ';
			oCell7.innerHTML= ' ';
			oCell8.innerHTML= "<a style='font-size: 8px;'>" + selDetailGridRowData[i].inspection_value+"</a>";
				  
				 
			if( $('input[name=deci_'+(i+1)+']:checked').val() == 'Y') {
				oCell9.innerHTML= "<a style='font-size: 8px;'>" + '◎' +"</a>";	
			} else {
				oCell9.innerHTML=  "<a style='font-size: 8px;'>" +'x' +"</a>";	
			}
				
				
			var oRow = my_tbody.insertRow();
				 
			var aCell1 = oRow.insertCell();
			aCell1.id = "aCell1";
			var aCell2 = oRow.insertCell();
			aCell2.id = "aCell2";
			var aCell3 = oRow.insertCell();
			aCell3.id = "aCell3";
			
			aCell1.innerHTML= "<a style='font-size: 8px;'>1.5</a>";
			aCell2.innerHTML= "<a style='font-size: 8px;'>&nbsp;</a>";
			aCell3.innerHTML= "<a style='font-size: 8px;'>"+selDetailGridRowData[i].inspection_cn+"</a>";
			
			oCell1.rowSpan=2;
			oCell2.rowSpan=2;
			oCell3.rowSpan=2;
			oCell5.rowSpan=2;
			oCell6.rowSpan=2;
			oCell8.rowSpan=2;
			
		}
	}
	
	if(selDetailGridRowData.length <16) {
		$("#inspDoc_1").printMe(
				{
					"path": ["/res/bootstrap/css/printme.css"] 
				}
			);
		
		for(var i=0 ; i<selDetailGridRowData.length; i++) {
			document.getElementById("insertTable_1_1").deleteRow(2);	
			document.getElementById("insertTable_1_1").deleteRow(2);
		}		
	} else {
		$("#inspDoc_2").printMe(
				{
					"path": ["/res/bootstrap/css/printme.css"] 
				}
			);	
		for(var i=0 ; i<20; i++) {
			document.getElementById("insertTable_2_1").deleteRow(2);	
			document.getElementById("insertTable_2_1").deleteRow(2);	
		}
		for(var i=0 ; i<selDetailGridRowData.length-20; i++) {
			document.getElementById("insertTable_2_2").deleteRow(0);
			document.getElementById("insertTable_2_2").deleteRow(0);
		}
	}
	
}

function drwDownload(file_cate) {
	
	var cate = '';
	if(file_cate == 'drw') {
		cate = '도면';
	} else if(file_cate == 'ord') {
		cate = '작업표준서';
	}
	
	var selKey = $("#grid_insp").jqGrid('getGridParam', 'selrow');
	
	if(selKey.length == 0) {
		fnMessageModalAlert("Notification(MES)", "선택된 지시내역이 없습니다.");
		return;
	}
	
	var rowData = $("#grid_insp").getRowData(selKey);
	
	if(rowData.matnr.lengh == 0 || rowData.matnr == undefined || rowData.matnr == '') {
		fnMessageModalAlert("Notification(MES)", "선택된 내역은 자재정보가 없는 지시입니다.");
		return;
	}
	
	fnMessageModalConfirm("Notification", "선택된 오더의 자재( " + rowData.matnr + " )에 대한 " + cate + " 파일을 다운로드 받습니다.<br/>"
			+ "계속 진행하시겠습니까?", function(chk){
			if(chk){
				
				var r_data = ''	;
				
				if(file_cate == 'drw') {
					var page_url = "/file/file_select_nopage";
					page_url += "?file_cate=" + encodeURIComponent(file_cate)
					page_url += "&file_name=" + encodeURIComponent(rowData.matnr)
					page_url += "&file_del_yn=" + encodeURIComponent("N");
				} else if(file_cate == 'ord'){
					var page_url = "/file/file_select_nopage";
					page_url += "?file_cate=" + encodeURIComponent(file_cate)
					page_url += "&matnr=" + encodeURIComponent(rowData.matnr)
					page_url += "&file_del_yn=" + encodeURIComponent("N");
				}
				$.ajax({
					url : page_url,
					async: false,
					type : "POST",
					success : function(data, textStatus, jqXHR) {
						if (data.status == "200") {
							if(data.rows.length > 0) {
								r_data = data.rows;	
								
								var protocol = jQuery(location).attr('protocol');
							  	var host = jQuery(location).attr('host');
							    var link_url = "/file/attach_download";
							 	link_url += "?file_path="+encodeURIComponent(r_data[0].file_path);
							 	link_url += "&file_name="+encodeURIComponent(r_data[0].file_name);
							  
							 	$(location).attr('href', link_url);  		
							} else {
								fnMessageModalAlert("Notification(MES)", "선택된 지시에 대한 " + cate + " 파일정보가 존재하지 않습니다.");
								return;
							}
						} else {
							fnMessageModalAlert("Notification(MES)", "선택된 지시에 대한 " + cate + " 파일정보를 가져오지 못했습니다.");
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						fnMessageModalAlert("Notification(MES)", "선택된 지시에 대한 " + cate + " 파일정보를 가져오지 못했습니다.");
					},
					complete : function() {}
				});
			}
	});
}

function excelFileDownload(gridName) {
// 	console.log('excelFileDownload('+gridName+')');
	var tmpArr = [];
	var getColNames = $("#grid_insp").jqGrid('getGridParam','colNames');
	var getColModels = $("#grid_insp").jqGrid('getGridParam','colModel');
	$.each(getColModels, function(idx, mrow){
		if( mrow.hidden==false && getColNames[idx]!='' ) {
			mrow.caption = getColNames[idx]; 
			tmpArr.push(mrow);  
		}
	});
	
	var gridCols = tmpArr;
	var gridData = $("#grid_insp").getRowData();

	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	if( gridName=='grid_insp' ) {
		fileName = '수입검사.xlsx';
		sheetTitle = '수입검사';
		sheetName = '수입검사';
	}
	
	var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
	var is_rownum = true;
	
	if(gridCols != null && gridCols.length > 0){
		// w2grid 는 linenumber column info not exist
		param_col_name = "No"
		param_col_id = "rownum";
		param_col_align = "center";
		param_col_width = "80";
		//--------------------------------------------
		console.log(gridCols);
		for(var i=0; i<gridCols.length; i++){
			if(!gridCols[i].hidden){
				var caption = gridCols[i].caption;
				param_col_name += "," + caption;
				param_col_id += "," + gridCols[i].name;
				param_col_align += ",left";
				param_col_width += "," + (gridCols[i].width==undefined?"80":(gridCols[i].width));
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

function fn_print_doc() {
	var selDetailGridRowData = $("#grid_inspDetail").getRowData();
	
	if(selDetailGridRowData.length > 0) {
		if(selDetailGridRowData[0].inspection_type == 'E') {
			print_doc_1();
		} else {
			print_doc_2();
		}
	}
}

function print_doc_1() {
	
	var aa = document.getElementById("doctest");
	
// 	var i = 0;
	
	var text ="<table style='width: 100%;'>"
		+"<tbody>"
		+"<tr>"
		+"<td style='width: 15%; height:20px;'>"
		+"<div style='text-align: center;'><img src='/res/images/common/logo.png'/></div>"
		+"</td>"
		+"<td style='width: 85%;'>"
		+"<div style='text-align: center;'><span style='font-size: 24px;'>입 &nbsp;고 &nbsp;검 &nbsp;사 &nbsp;성 &nbsp;적 &nbsp;서</span></div>"
		+"</td>"
		+"</tr>"
		+"</tbody>"
		+"</table>"
		+"<br/>"
		
		text = text + "<table style='width: 100%;'>"
		+"<tbody>"
		+"<tr>"
		+"<th style='width: 5%; height:20px;'><span style='font-size: 12px;'>납품처</span></th>"
		+"<td style='width: 12%; text-align: center;'>"
		+"<span id='row_1_1' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th style='width: 5%;'><span style='font-size: 12px;'>납품일자</span></th>"
		+"<td style='width: 12%; text-align: center;'>"
		+"<span id='row_1_2' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th style='width: 5%;'><span style='font-size: 12px;'>납품수량</span></th>"
		+"<td style='width: 12%; text-align: center;'>"
		+"<span id='row_1_3' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th style='width: 5%;'><span style='font-size: 12px;'>적용모델</span></th>"
		+"<td style='width: 12%; text-align: center;'>"
		+"<span id='row_1_4' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th rowspan='3' style='width: 5%;'><span style='font-size: 12px;'>결재</span>"
		+"<br>"
		+"</th>"
		+"<th colspan='2' style='width: 20%;'><span style='font-size: 12px;'>Vieworks</span>"
		+"<br>"
		+"</th>"
		+"</tr>"
		+"<tr>"
		+"<th style='width: 5%; height:20px;'><span style='font-size: 12px;'>품번</span></th>"
		+"<td style='width: 12%; text-align: center;'>"
		+"<span id='row_2_1' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th style='width: 5%;'><span style='font-size: 12px;'>품명</span></th>"
		+"<td colspan='3' style='width: 29%; text-align: center;'>"
		+"<span id='row_2_2' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th style='width: 5%;'><span style='font-size: 12px;'>검사일자</span></th>"
		+"<td style='width: 12%; text-align: center;'>"
		+"<span id='row_2_3' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th style='width: 10%;'><span style='font-size: 12px;'>담당자</span></th>"
		+"<th style='width: 10%;'><span style='font-size: 12px;'>승인</span></th>"
		+"</tr>"
		+"<tr>"
		+"<th rowspan='2' style='width: 5%;'><span style='font-size: 12px;'>ECR"
		+"<br>notice:</span></th>"
		+"<td colspan='3' rowspan='2' style='width: 29%;'>"
		+"<span id='row_3_1' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th rowspan='2' style='width: 5%;'><span style='font-size: 12px;'>검사수준 및 방식</span></th>"
		+"<td colspan='3' rowspan='2' style='width: 29%;'>"
		+"<span id='row_3_2' style='font-size: 8px;'></span>"
		+"</td>"
		+"<td style='width: 10%; height:50px;'>"
		+"<br>"
		+"</td>"
		+"<td style='width: 10%;'>"
		+"<br>"
		+"</td>"
		+"</tr>"
		+"<tr>"
		+"<th style='width: 5%; height:20px;'><span style='font-size: 12px;'>판정</span></th>"
		+"<td style='width: 10%; text-align: center;'>"
		+"<span id='row_4_1' style='font-size: 8px;'></span>"
		+"</td>"
		+"<td style='width: 10%; text-align: center;'>"
		+"<span id='row_4_2' style='font-size: 8px;'></span>"
		+"</td>"
		+"</tr>"
		+"</tbody>"
		+"</table>"
		
		text = text + "&nbsp;&nbsp;&nbsp;<span style='font-size: 12px;'>※범례 : 합격 ◎, 채용 ○, 특채 ▲, 불합격 x</span>"
		
		text = text + "<table  name='insertTable' id='insertTable_1_1' style='width: 100%;'>"
		+"<tbody id='my0-tbody_1'>"
		+"<tr>"
		+"<th rowspan='2' style='width: 3%; text-align: center; height:20px'><span style='font-size: 8px;'>No</span></th>"
		+"<th rowspan='2' style='width: 5%; text-align: center;'><span style='font-size: 8px;'>검사항목</span></th>"
		+"<th rowspan='2' style='width: 10%; text-align: center;'><span style='font-size: 8px;'>검사기준</span></th>"
		+"<th rowspan='2' style='width: 5%; text-align: center;'><span style='font-size: 8px;'>측정기</span></th>"
		
		text = text + "<th colspan='10' style='width: 77%; text-align: center;'><span style='font-size: 8px;'>입고검사측정결과</span></th>"
		+"</tr>"
		+"<tr>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#1</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#2</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#3</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#4</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#5</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#6</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#7</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#8</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>c/n</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>결과</span></th>"
		+"</tr>"
		+"</tbody>"
		+"</table>"
		+"<br/>"
		
		text = text + "<table style='width: 100%;'>"
		+"<tbody>"
		+"<tr>"
		+"<td style='width: 3%; text-align: center;'><span style='font-size: 8px;'>비고</span></td>"
		+"<td style='width: 97%;'>"   
		+"<span style='font-size: 8px;' id='insp_remark'></span>"
		+"</td>"
		+"</tr>"
		+"</tbody>"
		+"</table>"
		+"<footer>"
		+"<div style='width:100%;'>"
		+"<div style='float:left;' id='insp_doc'></div>"
// 		+"<div style='float:right;'>Vieworks Co., Ltd.</div>"
		+"</div>"
		+"</footer>";
		
		
	aa.innerHTML = text;
		
	//var selGridRowData = $("#grid_insp").getRowData($('#grid_insp').jqGrid('getGridParam','selrow'));
	var selGridRowData = s_inspData;
	var keyArr = $('#grid_inspDetail').jqGrid('getDataIDs');
	var selDetailGridRowData = $("#grid_inspDetail").getRowData();
	
	var my_tbody = document.getElementById('my0-tbody_1');
	
	var row_1_1 = selGridRowData.name1;
	var row_1_2 = selGridRowData.confirm_date;  
	var row_1_3 = selGridRowData.zdeli_menge;
	var row_1_4 = $("#i_model").val();
	var row_2_1 = selGridRowData.matnr;
	var row_2_2 = selGridRowData.txz01;
	
 	/* var row_3_1 = '□ ' + $("#i_ecr").val(); */
    var row_3_1 = ' ' + $("#i_ecr").val();
	var row_3_2 = '치수검사 : '+ $("#i_insp_1").val() + '<br/>외관/기능/형합성검사 AQL : ' + $("#i_insp_2").val();

	var row_4_2 = '';
	
	$('#insp_remark').html($("#i_insp_remark").val());
	$('#insp_doc').html("Doc. No : " + $("#i_doc_no").val());
	
	if(selGridRowData.insp_status == 'i2') {
		$('#row_2_3').html(selGridRowData.in_confirm_date);
		$('#row_4_1').html("합격");
	} else if(selGridRowData.insp_status == 'i3') {
		$('#row_2_3').html(selGridRowData.in_fail_date);
		$('#row_4_1').html('불합격');
	}

	$('#row_1_1').html(row_1_1);
	$('#row_1_2').html(row_1_2);
	$('#row_1_3').html(row_1_3);
	$('#row_1_4').html(row_1_4);
	
	$('#row_2_1').html(row_2_1);
	$('#row_2_2').html(row_2_2);
// 	$('#row_2_3').html(row_2_3);
		
	$('#row_3_1').html(row_3_1);
	$('#row_3_2').html(row_3_2);
	
// 	$('#row_4_1').html(row_4_1);
	$('#row_4_2').html(row_4_2);
	
	for(var i=0 ; i<selDetailGridRowData.length; i++) {
		var oRow = my_tbody.insertRow();	
		var oCell1 = oRow.insertCell();
		oCell1.id = "import_inspection_cell";
		var oCell2 = oRow.insertCell();
		oCell2.id = "import_inspection_cell";
		var oCell3 = oRow.insertCell();
		oCell3.id = "import_inspection_cell";
		var oCell4 = oRow.insertCell();
		oCell4.id = "import_inspection_cell";
		var oCell5 = oRow.insertCell();
		oCell5.id = "import_inspection_cell";
		var oCell6 = oRow.insertCell();
		oCell6.id = "import_inspection_cell";
		var oCell7 = oRow.insertCell();
		oCell7.id = "import_inspection_cell";
		var oCell8 = oRow.insertCell();
		oCell8.id = "import_inspection_cell";
		var oCell9 = oRow.insertCell();
		oCell9.id = "import_inspection_cell";
		var oCell10 = oRow.insertCell();
		oCell10.id = "import_inspection_cell";
		var oCell11 = oRow.insertCell();
		oCell11.id = "import_inspection_cell";
		var oCell12 = oRow.insertCell();
		oCell12.id = "import_inspection_cell";
		var oCell37 = oRow.insertCell();
		oCell37.id = "import_inspection_cell";
		var oCell38 = oRow.insertCell();
		oCell38.id = "import_inspection_cell";
		
		oCell1.innerHTML=  "<a style='font-size: 10px;'><small>" + (i+1)  +"</small></a>";
		oCell2.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[i].inspection_list +"</small></a>";
		oCell3.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[i].inspection_standard +"</small></a>";
		oCell4.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[i].inspection_remark +"</small></a>";
		oCell5.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[i].inspection_value1 +"</small></a>";
		oCell6.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[i].inspection_value2 +"</small></a>";
		oCell7.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[i].inspection_value3 +"</small></a>";
		oCell8.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[i].inspection_value4 +"</small></a>";
		oCell9.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[i].inspection_value5 +"</small></a>";
		oCell10.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[i].inspection_value6 +"</small></a>";
		oCell11.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[i].inspection_value7 +"</small></a>";
		oCell12.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[i].inspection_value8 +"</small></a>";
		oCell37.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[i].inspection_cn +"</small></a>";
		if( $('input[name=deci_'+(i+1)+']:checked').val() == 'Y') {
			oCell38.innerHTML=  "<a style='font-size: 10px;'><small>" + "◎" +"</small></a>";	
		} else {
			oCell38.innerHTML=  "<a style='font-size: 10px;'><small>" + "x" +"</small></a>";
		}
		
	}
		 	
	console.log($("#doctest").height());
	
	$("#doctest").printMe(
		{	"path": ["/res/bootstrap/css/printme.css"] }
	);	
}

function print_doc_2() {

	var aa = document.getElementById("doctest");
	
// 	var i = 0;
	
	var text ="<table style='width: 100%;'>"
		+"<tbody>"
		+"<tr>"
		+"<td style='width: 15%; height:20px;'>"
		+"<div style='text-align: center;'><span style='font-size: 24px;'>VIEWORKS</span></div>"
		+"</td>"
		+"<td style='width: 85%;'>"
		+"<div style='text-align: center;'><span style='font-size: 24px;'>입 &nbsp;고 &nbsp;검 &nbsp;사 &nbsp;성 &nbsp;적 &nbsp;서</span></div>"
		+"</td>"
		+"</tr>"
		+"</tbody>"
		+"</table>"
		+"<br/>"
		
		text = text + "<table style='width: 100%;'>"
		+"<tbody>"
		+"<tr>"
		+"<th style='width: 5%; height:20px;'><span style='font-size: 12px;'>납품처</span></th>"
		+"<td style='width: 12%; text-align: center;'>"
		+"<span id='row_1_1' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th style='width: 5%;'><span style='font-size: 12px;'>납품일자</span></th>"
		+"<td style='width: 12%; text-align: center;'>"
		+"<span id='row_1_2' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th style='width: 5%;'><span style='font-size: 12px;'>납품수량</span></th>"
		+"<td style='width: 12%; text-align: center;'>"
		+"<span id='row_1_3' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th style='width: 5%;'><span style='font-size: 12px;'>적용모델</span></th>"
		+"<td style='width: 12%; text-align: center;'>"
		+"<span id='row_1_4' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th rowspan='3' style='width: 5%;'><span style='font-size: 12px;'>결재</span>"
		+"<br>"
		+"</th>"
		+"<th colspan='2' style='width: 20%;'><span style='font-size: 12px;'>Vieworks</span>"
		+"<br>"
		+"</th>"
		+"</tr>"
		+"<tr>"
		+"<th style='width: 5%; height:20px;'><span style='font-size: 12px;'>품번</span></th>"
		+"<td style='width: 12%; text-align: center;'>"
		+"<span id='row_2_1' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th style='width: 5%;'><span style='font-size: 12px;'>품명</span></th>"
		+"<td colspan='3' style='width: 29%; text-align: center;'>"
		+"<span id='row_2_2' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th style='width: 5%;'><span style='font-size: 12px;'>검사일자</span></th>"
		+"<td style='width: 12%; text-align: center;'>"
		+"<span id='row_2_3' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th style='width: 10%;'><span style='font-size: 12px;'>담당자</span></th>"
		+"<th style='width: 10%;'><span style='font-size: 12px;'>승인</span></th>"
		+"</tr>"
		+"<tr>"
		+"<th rowspan='2' style='width: 5%;'><span style='font-size: 12px;'>ECR"
		+"<br>notice:</span></th>"
		+"<td colspan='3' rowspan='2' style='width: 29%;'>"
		+"<span id='row_3_1' style='font-size: 8px;'></span>"
		+"</td>"
		+"<th rowspan='2' style='width: 5%;'><span style='font-size: 12px;'>검사수준 및 방식</span></th>"
		+"<td colspan='3' rowspan='2' style='width: 29%;'>"
		+"<span id='row_3_2' style='font-size: 8px;'></span>"
		+"</td>"
		+"<td style='width: 10%; height:50px;'>"
		+"<br>"
		+"</td>"
		+"<td style='width: 10%;'>"
		+"<br>"
		+"</td>"
		+"</tr>"
		+"<tr>"
		+"<th style='width: 5%; height:20px;'><span style='font-size: 12px;'>판정</span></th>"
		+"<td style='width: 10%; text-align: center;'>"
		+"<span id='row_4_1' style='font-size: 8px;'></span>"
		+"</td>"
		+"<td style='width: 10%; text-align: center;'>"
		+"<span id='row_4_2' style='font-size: 8px;'></span>"
		+"</td>"
		+"</tr>"
		+"</tbody>"
		+"</table>"
		
		text = text + "&nbsp;&nbsp;&nbsp;<span style='font-size: 12px;'>※범례 : 합격 ◎, 채용 ○, 특채 ▲, 불합격 x</span>"
		+"<br/>"
		
		+"<table  name='insertTable' id='part_1' style='width: 100%;'>"
		+"<tbody id='my0-tbody_1'>"
		+ "<tr>"
		+"<th rowspan='2' style='width: 3%; text-align: center; height:20px'><span style='font-size: 8px;'>No</span></th>"
		+"<th rowspan='2' style='width: 5%; text-align: center;'><span style='font-size: 8px;'>검사항목</span></th>"
		+"<th rowspan='2' style='width: 10%; text-align: center;'><span style='font-size: 8px;'>검사기준</span></th>"
		+"<th rowspan='2' style='width: 5%; text-align: center;'><span style='font-size: 8px;'>측정기</span></th>"
		+"<th colspan='34' style='width: 77%; text-align: center;'><span style='font-size: 8px;'>입고검사측정결과</span></th>"
		+"</tr>"
		+"<tr>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#1</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#2</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#3</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#4</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#5</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#6</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#7</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#8</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>c/n</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>결과</span></th>"
		+"</tr>"
		+"</tbody>"
		+"</table>"
		+"<div style='page-break-before:always'></div>"


		+"<table style='width: 100%;'>"
		+"<tbody>"
		+"<tr>"
		+"<td style='width: 15%; height:20px;'>"
		+"<div style='text-align: center;'><span style='font-size: 24px;'>VIEWORKS</span></div>"
		+"</td>"
		+"<td style='width: 85%;'>"
		+"<div style='text-align: center;'><span style='font-size: 24px;'>입 &nbsp;고 &nbsp;검 &nbsp;사 &nbsp;성 &nbsp;적 &nbsp;서</span></div>"
		+"</td>"
		+"</tr>"
		+"</tbody>"
		+"</table>"
		+"<br/>"
		+"<table  name='insertTable' id='part_2' style='width: 100%;'>"
		+"<tbody id='my0-tbody_2'>"
		+ "<tr>"
		+"<th rowspan='2' style='width: 3%; text-align: center; height:20px'><span style='font-size: 8px;'>No</span></th>"
		+"<th rowspan='2' style='width: 5%; text-align: center;'><span style='font-size: 8px;'>검사항목</span></th>"
		+"<th rowspan='2' style='width: 10%; text-align: center;'><span style='font-size: 8px;'>검사기준</span></th>"
		+"<th rowspan='2' style='width: 5%; text-align: center;'><span style='font-size: 8px;'>측정기</span></th>"
		+"<th colspan='34' style='width: 77%; text-align: center;'><span style='font-size: 8px;'>입고검사측정결과</span></th>"
		+"</tr>"
		+"<tr>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#9</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#10</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#11</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#12</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#13</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#14</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#15</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#16</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>c/n</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>결과</span></th>"
		+"</tr>"
		+"</tbody>"
		+"</table>"
		+"<div style='page-break-before:always'></div>"
		
		+"<table style='width: 100%;'>"
		+"<tbody>"
		+"<tr>"
		+"<td style='width: 15%; height:20px;'>"
		+"<div style='text-align: center;'><span style='font-size: 24px;'>VIEWORKS</span></div>"
		+"</td>"
		+"<td style='width: 85%;'>"
		+"<div style='text-align: center;'><span style='font-size: 24px;'>입 &nbsp;고 &nbsp;검 &nbsp;사 &nbsp;성 &nbsp;적 &nbsp;서</span></div>"
		+"</td>"
		+"</tr>"
		+"</tbody>"
		+"</table>"
		+"<br/>"
		+"<table  name='insertTable' id='part_3' style='width: 100%;'>"
		+"<tbody id='my0-tbody_3'>"
		+ "<tr>"
		+"<th rowspan='2' style='width: 3%; text-align: center; height:20px'><span style='font-size: 8px;'>No</span></th>"
		+"<th rowspan='2' style='width: 5%; text-align: center;'><span style='font-size: 8px;'>검사항목</span></th>"
		+"<th rowspan='2' style='width: 10%; text-align: center;'><span style='font-size: 8px;'>검사기준</span></th>"
		+"<th rowspan='2' style='width: 5%; text-align: center;'><span style='font-size: 8px;'>측정기</span></th>"
		+"<th colspan='34' style='width: 77%; text-align: center;'><span style='font-size: 8px;'>입고검사측정결과</span></th>"
		+"</tr>"
		+"<tr>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#17</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#18</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#19</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#20</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#21</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#22</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#23</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#24</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>c/n</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>결과</span></th>"
		+"</tr>"
		+"</tbody>"
		+"</table>"
		+"<div style='page-break-before:always'></div>"
		
		+"<table style='width: 100%;'>"
		+"<tbody>"
		+"<tr>"
		+"<td style='width: 15%; height:20px;'>"
		+"<div style='text-align: center;'><span style='font-size: 24px;'>VIEWORKS</span></div>"
		+"</td>"
		+"<td style='width: 85%;'>"
		+"<div style='text-align: center;'><span style='font-size: 24px;'>입 &nbsp;고 &nbsp;검 &nbsp;사 &nbsp;성 &nbsp;적 &nbsp;서</span></div>"
		+"</td>"
		+"</tr>"
		+"</tbody>"
		+"</table>"
		+"<br/>"
		+"<table  name='insertTable' id='part_4' style='width: 100%;'>"
		+"<tbody id='my0-tbody_4'>"
		+ "<tr>"
		+"<th rowspan='2' style='width: 3%; text-align: center; height:20px'><span style='font-size: 8px;'>No</span></th>"
		+"<th rowspan='2' style='width: 5%; text-align: center;'><span style='font-size: 8px;'>검사항목</span></th>"
		+"<th rowspan='2' style='width: 10%; text-align: center;'><span style='font-size: 8px;'>검사기준</span></th>"
		+"<th rowspan='2' style='width: 5%; text-align: center;'><span style='font-size: 8px;'>측정기</span></th>"
		+"<th colspan='34' style='width: 77%; text-align: center;'><span style='font-size: 8px;'>입고검사측정결과</span></th>"
		+"</tr>"
		+"<tr>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#25</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#26</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#27</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#28</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#29</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#30</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#31</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>&nbsp;#32</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>c/n</span></th>"
		+"<th style='text-align: center;'><span style='font-size: 8px;'>결과</span></th>"
		+"</tr>"
		+"</tbody>"
		+"</table>"
		+"<br/>"
		
		text = text + "<table style='width: 100%;'>"
		+"<tbody>"
		+"<tr>"
		+"<td style='width: 3%; text-align: center;'><span style='font-size: 8px;'>비고</span></td>"
		+"<td style='width: 97%;'>"   
		+"<span style='font-size: 8px;' id='insp_remark'></span>"
		+"</td>"
		+"</tr>"
		+"</tbody>"
		+"</table>"
		+"<footer>"
		+"<div id='insp_doc'></div>"
// 		+"<div style='float:right;'>Vieworks Co., Ltd.</div>"
		+"</footer>";

	
	aa.innerHTML = text;

	var selGridRowData = s_inspData;
	var keyArr = $('#grid_inspDetail').jqGrid('getDataIDs');
	var selDetailGridRowData = $("#grid_inspDetail").getRowData();
		
	var row_1_1 = selGridRowData.name1;
	var row_1_2 = selGridRowData.confirm_date;  
	var row_1_3 = selGridRowData.zdeli_menge;
	var row_1_4 = $("#i_model").val();
	var row_2_1 = selGridRowData.matnr;
	var row_2_2 = selGridRowData.txz01;
	
 /* 	var row_3_1 = '□ ' + $("#i_ecr").val(); */
    var row_3_1 = ' ' + $("#i_ecr").val();
	var row_3_2 = '치수검사 : '+ $("#i_insp_1").val() + '<br/>외관/기능/형합성검사 AQL : ' + $("#i_insp_2").val();

	var row_4_2 = '';
	
	$('#insp_remark').html(selGridRowData.insp_remark);
	$('#insp_doc').html("Doc. No : " + $("#i_doc_no").val());
	
	if(selGridRowData.insp_status == 'i2') {
		$('#row_2_3').html(selGridRowData.in_confirm_date);
		$('#row_4_1').html("합격");
	} else if(selGridRowData.insp_status == 'i3') {
		$('#row_2_3').html(selGridRowData.in_fail_date);
		$('#row_4_1').html('불합격');
	}
	
	
	$('#row_1_1').html(row_1_1);
	$('#row_1_2').html(row_1_2);
	$('#row_1_3').html(row_1_3);
	$('#row_1_4').html(row_1_4);
	
	$('#row_2_1').html(row_2_1);
	$('#row_2_2').html(row_2_2);
// 	$('#row_2_3').html(row_2_3);
		
	$('#row_3_1').html(row_3_1);
	$('#row_3_2').html(row_3_2);
	
// 	$('#row_4_1').html(row_4_1);
	$('#row_4_2').html(row_4_2);
	
	for(var i=0 ; i<4; i++) {
		for(var j=0 ; j<selDetailGridRowData.length; j++) {
			var oRow = document.getElementById('my0-tbody_' + (i+1)).insertRow();	
			var oCell1 = oRow.insertCell();
			oCell1.id = "import_inspection_cell";
			var oCell2 = oRow.insertCell();
			oCell2.id = "import_inspection_cell";
			var oCell3 = oRow.insertCell();
			oCell3.id = "import_inspection_cell";
			var oCell4 = oRow.insertCell();
			oCell4.id = "import_inspection_cell";
			var oCell5 = oRow.insertCell();
			oCell5.id = "import_inspection_cell";
			var oCell6 = oRow.insertCell();
			oCell6.id = "import_inspection_cell";
			var oCell7 = oRow.insertCell();
			oCell7.id = "import_inspection_cell";
			var oCell8 = oRow.insertCell();
			oCell8.id = "import_inspection_cell";
			var oCell9 = oRow.insertCell();
			oCell9.id = "import_inspection_cell";
			var oCell10 = oRow.insertCell();
			oCell10.id = "import_inspection_cell";
			var oCell11 = oRow.insertCell();
			oCell11.id = "import_inspection_cell";
			var oCell12 = oRow.insertCell();
			oCell12.id = "import_inspection_cell";
			var oCell37 = oRow.insertCell();
			oCell37.id = "import_inspection_cell";
			var oCell38 = oRow.insertCell();
			oCell38.id = "import_inspection_cell";
						
			oCell1.innerHTML=  "<a style='font-size: 10px;'><small>" + (j+1)  +"</small></a>";
			oCell2.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_list +"</small></a>";
			oCell3.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_standard +"</small></a>";
			oCell4.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_remark +"</small></a>";

			if(i == 0) {
				oCell5.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value1 +"</small></a>";
				oCell6.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value2 +"</small></a>";
				oCell7.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value3 +"</small></a>";
				oCell8.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value4 +"</small></a>";
				oCell9.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value5 +"</small></a>";
				oCell10.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value6 +"</small></a>";
				oCell11.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value7 +"</small></a>";
				oCell12.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value8 +"</small></a>";	
			} else if(i == 1) {
				oCell5.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value9 +"</small></a>";
				oCell6.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value10 +"</small></a>";
				oCell7.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value11 +"</small></a>";
				oCell8.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value12 +"</small></a>";
				oCell9.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value13 +"</small></a>";
				oCell10.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value14 +"</small></a>";
				oCell11.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value15 +"</small></a>";
				oCell12.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value16 +"</small></a>";
			} else if(i == 2) {
				oCell5.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value17 +"</small></a>";
				oCell6.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value18 +"</small></a>";
				oCell7.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value19 +"</small></a>";
				oCell8.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value20 +"</small></a>";
				oCell9.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value21 +"</small></a>";
				oCell10.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value22 +"</small></a>";
				oCell11.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value23 +"</small></a>";
				oCell12.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value24 +"</small></a>";
			} else if(i == 3) {
				oCell5.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value25 +"</small></a>";
				oCell6.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value26 +"</small></a>";
				oCell7.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value27 +"</small></a>";
				oCell8.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value28 +"</small></a>";
				oCell9.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value29 +"</small></a>";
				oCell10.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value30 +"</small></a>";
				oCell11.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value31 +"</small></a>";
				oCell12.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_value32 +"</small></a>";
			}
			
			oCell37.innerHTML=  "<a style='font-size: 10px;'><small>" + selDetailGridRowData[j].inspection_cn +"</small></a>";
			if( $('input[name=deci_'+(j+1)+']:checked').val() == 'Y') {
				oCell38.innerHTML=  "<a style='font-size: 10px;'><small>" + "◎" +"</small></a>";	
			} else {
				oCell38.innerHTML=  "<a style='font-size: 10px;'><small>" + "x" +"</small></a>";
			}
		}
	}	 	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		
		
	$("#doctest").printMe(
		{	"path": ["/res/bootstrap/css/printme.css"] }
	);	
}

function inspSave() {
	var headerData = [];
	var inspData = $("#grid_insp").getRowData($("#grid_insp").jqGrid('getGridParam','selrow')); 
	var checkGridData = [];
	var keyArr = $("#grid_inspDetail").jqGrid('getDataIDs');
	var cnt = 0;
	for (var i=0; i<keyArr.length; i++) { //row id수만큼 실행           
    	if($("input:checkbox[id='jqg_grid_inspDetail_"+keyArr[i]+"']").is(":checked")){ //checkbox checked 여부 판단
    		var selRow = {};
    		cnt++;
    		selRow = $("#grid_inspDetail").getRowData(keyArr[i]);
    		selRow.inspection_decision = $('input[name=deci_'+keyArr[i]+']:checked').val();
    		selRow.insp_gubun = inspData.insp_gubun;
    		
    		selRow.inspection_type =  $(':radio[name="rdo_sampleChk"]:checked').val();
    		
    		checkGridData.push(selRow);
    	}
   	}
	 
// 	if( cnt==0 ){
// 		fnMessageModalAlert("확인하세요.", "처리할 데이터가 체크되지 않았습니다.");
// 		return;
// 	}
	
	headerData.push(inspData);
	
	var page_url = "/frontend/qm/inspSave"
		+ '?headerJson=' + encodeURIComponent(JSON.stringify(headerData))
		+ '&detailJson=' + encodeURIComponent(JSON.stringify(checkGridData))
		
		+ '&insp_model=' + encodeURIComponent($("#i_model").val())
		+ '&insp_ecr=' + encodeURIComponent($("#i_ecr").val())
		+ '&insp_maql=' + encodeURIComponent($("#i_insp_1").val())
		+ '&insp_vaql=' + encodeURIComponent($("#i_insp_2").val())
		+ '&insp_doc=' + encodeURIComponent($("#i_doc_no").val())
	    + '&insp_remark=' + encodeURIComponent($("#i_insp_remark").val());
	
	
	$.ajax({
	    url: page_url,
	    async:false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				fnMessageModalAlert("Notification(QM)", "수정 성공");
	    	} else {
	    		fnMessageModalAlert("Notification(QM)", "수정 실패");
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(QM)", "수정 실패");	
	    },
	    complete: function() {
	    	
	    }
	});
	
	$("#modal_detail").modal('hide');
	fnSearchInspGrid();	
}

function loadInspData(inspData) {
	var rtn_data = {};
	var page_url = "/frontend/mes/inInsp_select"
		 + "?ebeln=" + encodeURIComponent(inspData.ebeln);
console.log(inspData);
	$.ajax({
		  url:page_url,
		  type:'POST',
		  dataType: 'json',
		  async:false,
		  success: function( data ) {
		  	if(data.status == 200) {
		  		var r_data = data.rows;
		  		for(var i=0 ; i<r_data.length; i++) {
		  			if(r_data[i].ebelp == inspData.ebelp) {
		  				if(r_data[i].partial_seq == inspData.partial_seq) {
		  				rtn_data = r_data[i]; 
		  				}
		  			}
		  		}
		  	}
		  },
		  complete: function () {}
		});
	return rtn_data;
}

function loadInspResultData(inspData){
	console.log(inspData);
	var page_url = "/frontend/qm/inInspResult_select"
				 + "?ebeln=" + encodeURIComponent(inspData.ebeln)
				 + "&ebelp=" + encodeURIComponent(inspData.ebelp)
				 + "&partial_seq=" + encodeURIComponent(inspData.partial_seq)
	
	$("#grid_inspDetail").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_inspDetail").trigger("reloadGrid");
}
</script>
</body>
</html>