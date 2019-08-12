<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
	String member_id = SessionUtil.getMemberId(request);
	String member_nm = SessionUtil.getMemberNm(request);
	String member_emp_no = SessionUtil.getMemberEmpNo(request);
%>
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
/* 			margin-top:7px; */
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
            <jsp:param name="selected_menu_cd" value="1107" />
        </jsp:include>

        <div class="content-wrapper">
            <section class="content-header">
                <h1>
					품질관리 <small> 외주생산품 관리</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="#"><i class="fa fa-dashboard"></i> 품질관리 </a></li>
                    <li class="active">외주생산품 관리</li>
                </ol>
            </section>
            <section class="content">
                <div class="row">
                    <section class="col-lg-12">
                        <div class="box box-success box-solid" style="min-height: 70px;">
                            <div class="box-header with-border">
                                <h3 class="box-title">조회조건</h3>
                                <div class="box-tools pull-right">
                                    <button type="button" id="btn_search_csr" class="btn btn-primary btn-sm" onclick="fnSearchInspGrid();">조회</button>
                                    <button type="button" id="" class="btn btn-primary btn-sm" onclick="makeOrderModal();" style="color: white;">검사내역생성</button>
                                </div>
                            </div>
                            <div id="" class="box-body">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label>생성일</label>
                                            <div class="input-group">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <input type="text" class="form-control pull-right input-sm" id="req_date_range" >
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label>품목코드</label> <input type="input" id="itnbr" name="itnbr" class="form-control input-sm" placeholder="" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label>품목명</label> <input type="input" id="pordno_status" name="pordno_status" class="form-control input-sm" placeholder="" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label>시리얼번호</label> 
                                         <!--    <input type="input" id="project_no" name="project_no" class="form-control input-sm" placeholder="" maxlength="30"> -->
                                        	<input type="input"  id="project_no" name="project_no" class="form-control input-sm"  maxlength="100"  
											onkeypress="if(event.keyCode==13) {LMainsernr_enter(this); return false;}">
                                        </div>
                                    </div>
								</div>
								<div class="row">
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label>오더번호</label> <input type="input" id="pordno" name="pordno" class="form-control input-sm" placeholder="" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-sm-3 search_param">
										<div class="form-group">
											<label>| 업체코드</label>
											<div class="form-group">
												<input type="text" id="i_lifnr" class="form-control input-sm">
											</div>
										</div>
									</div>
									<div class="col-sm-3 search_param">
										<div class="form-group">
											<label>| 업체명</label>
											<div class="form-group">
												<input type="text" id="i_name1" class="form-control input-sm">
											</div>
										</div>
								    </div>	
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label>상태</label><br />
                                            <label> <input type="radio"	name="pdsts" class="flat-red" value="" checked>전체</label>
                                            <label> <input type="radio" name="pdsts"	 class="flat-red" value="v1"> 대기</label>
                                            <label> <input type="radio" name="pdsts" class="flat-red" value="v2"> 처리</label>
                                            <label> <input type="radio" name="pdsts" class="flat-red" value="v3"> 완료</label>
                                        </div>
                                    </div>
								</div>
                            </div>
                        </div>
                        <div class="box box-default box-solid" style="min-height: 600px;">
                            <div class="box-header with-border">
                            	 <h3 class="box-title">검사내역</h3>
                            	  <div class="box-tools pull-right">
                            	  		<button type="button" id="" class="btn btn-sm bg-teal" onclick="fnSelfInspSernrSave();" style="color: white;">시리얼등록</button>
	                            	 	<button type="button" id="" class="btn btn-primary btn-sm" onclick="selfInspModal();" style="color: white;">이력카드</button>
	                            	 	<button type="button" class="btn btn-info btn-sm" onclick="drwDownload('ord');" style="color: white;">작업표준서 다운로드	</button>                
										 | <button type="button" id="btn_conf_process" class="btn btn-danger btn-sm" onclick = "v3_vOrdStatusChange()"style="color: white;">완료</button>
										 <button type="button" id="btn_conf_process" class="btn bg-navy btn-sm" onclick = "vorder_del()"style="color: white;">삭제</button>		
                            	  </div>
                            </div>
                            <div class="box-body">
                                <div class="row">
                                    <div id="dv_grid_role" class="col-sm-12">
                                        <table id="grid_role"></table>
                                        <div id="grid_role_pager"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </section>
        </div>
    </div>
    <jsp:include page="/common/footer_inc" flush="true">
        <jsp:param name="page_title" value="0" />
    </jsp:include>

    <jsp:include page="/common/sidebar_rview_inc" flush="true">
        <jsp:param name="page_title" value="0" />
    </jsp:include>
    

<!-- 자주검사  -->
<div class="modal fade" id="modal_selfInsp" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">이력카드 <span id="pono"></span></h4>
				<div class="" id="gr" style="display: none;">
					<div id="p_vpordno" name="popupText" class=""></div>
					<div id="p_gr_no" name="popupText" class=""></div>
					<div id="p_gr_seq" name="popupText" class=""></div>
				</div>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12">
						<div id="grid_selfInsp_header" style="width: 100%; height: 300px;"></div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-10" style="padding-top: 10px;">
						<table class="table table-condensed" style="margin-bottom: 0px;">
							<tr>
								<th class="bg-warning col-md-1 text-center"> DMR no.</th>
							  	<td class="col-md-2"> <div id="p_dmr" name="popupText" class="popupText">-</div> </td>
							  	<th class="bg-warning col-md-1 text-center"> RN no.</th>
							  	<td class="col-md-2"> <div id="p_rn" name="popupText" class="popupText">-</div> </td>
							</tr>
						</table>
					</div>
					<div class="col-md-2">
						<select id="self_insp_routing" class="form-control select2 input-sm" style="margin-top: 10px;"
							onChange="showSelfInspGrid();"></select>
					</div>
				</div>
				<div class="row" style="height: 400px; overflow-y: auto; overflow-x: hidden;">
					<div id="1110" class="col-md-12">
						<div class="row">
							<!-- darkimage검사 -->
							<div class="col-md-12" id="grid_v12_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_v12" style="width: 100%; height: 400px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- calibration -->
							<div class="col-md-12" id="grid_v13_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_v13" style="width: 100%; height: 400px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- osf -->
							<div class="col-md-12" id="grid_v14_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_v14" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 최종 검사 -->
							<div class="col-md-12" id="grid_v17_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_v17" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 1차조립 -->
							<div class="col-md-12" id="grid_r10_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r10" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 공정 검사 -->
							<div class="col-md-12" id="grid_r11_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r11" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 최종 조립 -->
							<div class="col-md-12" id="grid_r12_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r12" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 공정 검사 -->
							<div class="col-md-12" id="grid_r21_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r21" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- on/off test -->
							<div class="col-md-12" id="grid_r22_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r22" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 최종 조립 -->
							<div class="col-md-12" id="grid_r23_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r23" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- ghost 작업 -->
							<div class="col-md-12" id="grid_r31_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r31" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- Backup -->
							<div class="col-md-12" id="grid_r32_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r32" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 공정검사 -->
							<div class="col-md-12" id="grid_r52_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r52" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 품질 최종 검사 -->
							<div class="col-md-12" id="grid_qt_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_qt" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 품질 1차 검사  -->
							<div class="col-md-12" id="grid_qo_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_qo" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 품질 Aging -->
							<div class="col-md-12" id="grid_qa_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_qa" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
					</div>
					<div id="1210" class="col-md-12">
						<div class="row">
							<div class="col-md-12" id="grid_p1_area" style="margin-top: 10px;">
								<div id="grid_p1" style="width: 100%; height: 400px;"></div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12" id="grid_p2_area" style="margin-top: 10px;">
								<div id="grid_p2" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12" id="grid_p5_area" style="margin-top: 10px;">
								<div id="grid_p5" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12" id="grid_t1_area" style="margin-top: 10px;">
								<div id="grid_t1" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- end modal body -->
			<div class="modal-footer">
				<div class="text-center">
					<button type="button" class="btn btn-sm btn-primary" onclick="saveSelfInsp();" id="selfInspSave">저장</button>
					<button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div> <!-- end modal-content -->
	</div> <!-- end modal dialog -->
</div> <!-- end modal div -->

<div class="modal fade" id="searchMatnrPopup" data-backdrop="static">
    <div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">자재정보</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12">
						<form id="frm_product" name="frm_product" class="form-horizontal">
						<div class="form-group">
							<label for="m_matnr" class="col-sm-3 control-label text-right">자재코드</label>
							<div class="col-sm-8">
								<input type="text" class="form-control pull-right input-sm" id="m_matnr" name="m_matnr">
							</div>
						</div>
						<div class="form-group">
							<label for="m_maktx" class="col-sm-3 control-label text-right">자재내역</label>
							<div class="col-sm-8">
								<input type="text" class="form-control pull-right input-sm" id="m_maktx" name="m_maktx">
							</div>
						</div>
						<div class="text-right" style="padding-bottom: 10px;">
							<button type="button" id="" class="btn btn-warning btn-sm" onclick="searchMatnr();">검색</button>
						</div>
						</form>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div id="grid_matnr" style="width: 100%; height: 400px;"></div>
					</div>
				</div>
	        </div>
	        <div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_matnr');" data-selfilepath="/upload" data-selfilename="test.xlsx">
						<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
					</button>
					<button class="btn btn-warning btn-sm fileinput-button" style="color: white;"> 
						<span>Excel 일괄처리</span> 
						<input id="sernrfileupload" type="file" name="files[]" multiple>
					</button>
					<button type="button" id="" class="btn btn-success btn-sm" onclick="makeOrder();">생성</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">

var selected_pordno_pop;
var member_nm = '<%=member_nm%>';
var member_emp_no = '<%=member_emp_no%>';
var member_id = "<%=member_id%>";

$(function($) {
	
	var lifnr = fnChkUser();
	if(lifnr.length > 0) {
		$("#i_lifnr").val(lifnr);
		$(".search_param").hide();
	}
	
	fnLoadCommonOption();
	fnLoadInspGrid();
	gridMatnrGen();
	fnSernrLoadFileHandler();
});

function fnLoadCommonOption() {
	$("#r_conf_date").datepicker({
		language: "kr",
		todayHighlight: true,
		format: "yyyymmdd",
		autoclose: true
  	});
	
	$("#r_conf_date").datepicker( "setDate", new Date());
	
	$(window).bind('resize', function() {
		resizeJqGrid("grid_role", false);
	}).trigger('resize');
	
	$("#req_date_range").daterangepicker({
		opens: "right",
		locale: {
			format: "YYYY-MM-DD" // inputbox 에 "2011/04/29" 로표시
			,monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
			,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
			,showMonthAfterYear: true
			,yearSuffix: "년"
			,orientation: "top left"
	    }
		,startDate : new Date().getFullYear() + '-' + (new Date().getMonth()+1) + '-01'
		,endDate : new Date()
	});
	
	initScreenSizeModal();
	
// 	$("#inspStart").hide();
// 	$("#inspPuase").hide();
// 	$("#inspRestart").hide();
// 	$("#inspEnd").hide();
// 	$("#insp_txt").hide();
// 	$("#btn_process_yn").hide();
	
	// selfInsp
	initGridSelgInspHeader();
	init_grid_v12();
	init_grid_v13();
	init_grid_v14();
	init_grid_v17();
	init_grid_r10();
	init_grid_r11();
	init_grid_r12();
	init_grid_r21();
	init_grid_r22();
	init_grid_r23();
	init_grid_r31();
	init_grid_r32();
	init_grid_r52();
	init_grid_qt();
	init_grid_qo();
	init_grid_qa();
	init_grid_p1();
	init_grid_p2();
	init_grid_p5();
	init_grid_t1();
}

function fnSearchInspGrid() {
		
	var date1 = $("#req_date_range").val().substring(0,10).replace("-","").replace("-","");
	var date2 = $("#req_date_range").val().substring(13,23).replace("-","").replace("-","");
	
	var page_url = "/frontend/qm/vprod_select";
	page_url += "?f_date=" + encodeURIComponent(date1);
	page_url += "&t_date=" + encodeURIComponent(date2);
	page_url += "&vpordno=" + encodeURIComponent($("#pordno").val());
	page_url += "&matnr=" + encodeURIComponent($("#itnbr").val());
	page_url += "&maktx=" + encodeURIComponent($("#pordno_status").val());
	page_url += "&sernr=" + encodeURIComponent($("#project_no").val());
	page_url += "&vpdsts=" + encodeURIComponent($(':radio[name="pdsts"]:checked').val());
	page_url += "&lifnr=" + encodeURIComponent($("#i_lifnr").val());
	page_url += "&name1=" + encodeURIComponent($("#i_name1").val());
	
	$("#grid_role").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_role").setGridParam({ page: 1 }).trigger("reloadGrid");
}
	
function fnLoadInspGrid() {
	
	var date1 = $("#req_date_range").val().substring(0,10).replace("-","").replace("-","");
	var date2 = $("#req_date_range").val().substring(13,23).replace("-","").replace("-","");
	
	var page_url = "/frontend/qm/vprod_select";
	page_url += "?f_date=" + encodeURIComponent(date1);
	page_url += "&t_date=" + encodeURIComponent(date2);
	page_url += "&lifnr=" + encodeURIComponent($("#i_lifnr").val());
	
	$("#grid_role").jqGrid({
		url:page_url,
		datatype : "json",
		colNames : ['오더번호', '생성일','플랜트','dept_cd','업체코드','업체명','품목코드','품목명','S/N','상태','vpdsts','종료여부','납품여부','gr_no','gr_seq'],
		colModel : [
			{name : 'vpordno',index : 'vpordno',width : 10,sorttype : "text",	sortable : true, key : true}, 
			{name : 'vreg_date',index : 'vreg_date',width : 10,sorttype : "text",	sortable : true},
			{name : 'f_dept_cd',index : 'dept_cd',width : 10,	sorttype : "text",sortable : true, formatter:jqgridHighlightFormatterDeptCd},
			{name : 'dept_cd',index : 'dept_cd',width : 10,	sorttype : "text",sortable : true, hidden:true},
			{name : 'lifnr',index : 'lifnr',width : 10,	sorttype : "text",sortable : true},
			{name : 'name1',index : 'name1',width : 10,	sorttype : "text",sortable : true},
			{name : 'matnr',index : 'matnr',width : 10,	sorttype : "text",sortable : true}, 
			{name : 'maktx',index : 'maktx',width : 15,sorttype : "text",sortable : true},
			{name : 'sernr',index : 'sernr',width : 15,sorttype : "text",sortable : true, editable:true},
			{name : 'f_vpdsts',index : 'vpdsts',width : 15,sorttype : "text",sortable : true, formatter:jqgridHighlightFormatterVpdsts},
			{name : 'vpdsts',index : 'vpdsts',width : 15,sorttype : "text",sortable : true, hidden:true},
			{name : 'confirm_yn',index : 'confirm_yn',width : 10,sorttype : "text",sortable : true},
			{name : 'delivery_yn',index : 'delivery_yn',width : 10,sorttype : "text",sortable : true, hidden:false},
			{name : 'gr_no',index : 'gr_no',width : 10,sorttype : "text",sortable : true, hidden:true},
			{name : 'gr_seq',index : 'gr_seq',width : 10,sorttype : "text",sortable : true, hidden:true}
		],
		rowNum:15,
		rowList : [ 15, 50, 100 ],
		pager : "#grid_role_pager",
		viewrecords : true,
		autowidth : true,
		shrinkToFit : true,
		multiselect : true,
		height : 460,
		altRows : true,
		rownumbers : true,
		rownumWidth : 25,
		autoencode : true,
		loadonce : true,
		sortable : true,
		cellEdit:true,
	    cellsubmit : 'clientArray',
	    onSelectRow : function(rowid, selected) {		
		},
		loadComplete : function(data) {},
		afterEditCell: function(id,name,val,iRow,iCol){
			  $("#"+iRow+"_"+name).bind('blur',function(){
				  console.log("save!!!!!!");
				$('#grid_role').saveCell(iRow,iCol);
			  });
		}
	});
}

/*********************
*To 창고 select box 구성
*********************/
function getToStrList(pass) {
	console.log("pass :: " + pass);
	
	var maching_gubun = '';
	
	initOptions($('#s_to'));
	
	var sel_key_arr = $("#grid_role").jqGrid('getGridParam', 'selarrrow');		 
	var i_rowData = $("#grid_role").getRowData(sel_key_arr[0]);

	if(pass == 'p9') {
		if(i_rowData.kzumw == 'Y' && i_rowData.dept_cd == '1210') {
			maching_gubun = 'P_grd';	
		} else {
			maching_gubun = 'P';
		}
	} else {
		maching_gubun = 'F';
	}
	
	var page_url = "/frontend/scm/mes_stock_tbl_select"
	var postData = 'dept_cd=' + encodeURIComponent(i_rowData.dept_cd);
	postData += '&maching_gubun=' + encodeURIComponent(maching_gubun);
	postData += '&menu_code=' + encodeURIComponent('mst02');
	postData += '&fromto_gubun=' + encodeURIComponent('to');
	if(i_rowData.dept_cd == '1110' && pass == 'p10') {
		postData += '&lgort=' + encodeURIComponent(i_rowData.lgort);
	}

	$.ajax({
	    url: page_url,
	    data: postData,
	    async:false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$.each(data.rows, function (i, item) {
						$('#s_to').append($('<option>', { 
							value: item.stock_code,
					        text : "("+item.stock_code+") "+item.stock_name 
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
	    complete: function() {
// 		    	//최종검사, 춣하검사 별로 케이스를 나눠 데이터를 가져온다.. like 검색
// 				if($(':radio[name="inspection_type"]:checked').val() == "L") {
// 					$("#s_to").val("2040");
// 				} else {
// 					$("#s_to").val("2050");
// 				}
    	
		    }
	});
}

function initOptions(obj) {
    $(obj)
        .find('option')
        .remove()
        .end()
        //.append('<option value="">선택</option>')
        .val();
}

function selfInspModal() {
//  	console.log('selfInspModal()');
 	//grid_role
	var selKey = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
//  	console.log(selKey);
	selfDetail = [];
	if ( selKey.length==0 ) {
		fnMessageModalAlert("Warning", "검사내역에서 한건의 데이터를 선택하여야 합니다.");
		return;
	} else if ( selKey.length>1 ) {
		fnMessageModalAlert("Warning", "검사내역에서 한건의 데이터만 선택하여야 합니다.");
		return;
	}
	
	for(var i=0 ; i<selKey.length; i++) {
		var p_data_obj = $("#grid_role").getRowData(selKey[i]);
		if(p_data_obj.sernr.length == 0) {
			fnMessageModalAlert("Notification(QM)",	"작업을 시작하시기 전에 시리얼번호를 먼저 등록해주세요.");
			return;	
		}
	}
	
	
	
	var c_vpdsts = chkVpdsts();
	
	if(c_vpdsts == 'v3') {
// 		fnMessageModalAlert("Warning", "이미 완료처리 된 오더입니다.");
// 		fnSearchInspGrid();
// 		return;
		$("#selfInspSave").hide();
	} else {
		$("#selfInspSave").show();
	}
	
	var selectData = $("#grid_role").getRowData(selKey[0]);	// auart : ZP02, ZP04
	if( selectData.matnr=='' || selectData.matnr=='재고' ) {
		fnMessageModalAlert("Warning", "해당 공정은 자재내역이 조회되지 않아 자주검사가 불가능 합니다.");
		return;
	} else {
		var headerCheck = loadSelfInspHeader();
		if( headerCheck ) {
			makeSelectBox();
		 	loadSelfInspDetail();
			$("#pono").text("( 지시번호 : " + selectData.vpordno + " )");	// 2018-01-24 : iris add
			$("#modal_selfInsp").modal('show');
			showDmrInfo();
		 	showSelfInspGrid();
			setTimeout(function(){
				w2ui.grid_selfInsp_header.resize();
				w2ui.grid_selfInsp_header.refresh();
				$.each(selfDetail, function(idx, opt){
					w2ui['grid_' + opt].resize();
					w2ui['grid_' + opt].refresh();
				});
			}, 200);		
		} else {
			return;
		}
	}
}

function loadSelfInspHeader() {
// 	console.log('loadSelfInspHeader()');
	var selData = $("#grid_role").jqGrid("getRowData", $("#grid_role").getGridParam("selrow"));
// 	console.log(selData);
	var page_url = "/frontend/mes/select_selfinsp_header"
				+ "?dept_cd=" + encodeURIComponent(selData.dept_cd)
				+ "&pordno=" + encodeURIComponent(selData.vpordno)
				+ "&matnr=" + encodeURIComponent(selData.matnr);
	var returnVal = false;
	var rowArr = [];
	w2ui.grid_selfInsp_header.lock('loading...', true);
	$.ajax({
		url : page_url,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200" ) {
				if( (data.rows).length>0 ) {
					rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
						if( row.siheader_seq=='1' )
							row.item_value = row.simaster_gr_nm;
					});
					w2ui.grid_selfInsp_header.records = rowArr;
					w2ui.grid_selfInsp_header.total = rowArr.length;
					returnVal = true;
				} else {
					fnMessageModalAlert("Warning", "해당 공정(" + selData.vpordno + ") 에 해당하는 이력카드 정보가 없습니다.");
				}
			} else if(data.status == "200" && (data.rows).length==0 ) {
				fnMessageModalAlert("Check", "해당 데이터는 자주검사 대상이 아닙니다.");
			}else {
				fnMessageModalAlert("Fail",	"정보를 가져오는 중 오류가 발생하였습니다.");
			}
			w2ui.grid_selfInsp_header.refresh();
			w2ui.grid_selfInsp_header.unlock();
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "정보를 가져오는 중 오류가 발생하였습니다.");
		},
		complete : function() {}
	});
	return returnVal;
}



var selfDetail = [];
function makeSelectBox() {
// 	console.log('makeSelectBox()');
	var selData = $("#grid_role").jqGrid("getRowData", $("#grid_role").getGridParam("selrow"));
	
	$("#self_insp_routing").empty();
	var selectHeader = w2ui.grid_selfInsp_header.records[0];

	var page_url = "";
	if( selData.dept_cd=='1110' ) {
		page_url = "/frontend/mes/select_selfInspCode_1110"
				 + "?ref1=" + encodeURIComponent(selectHeader.simaster_gr_no);
	} else {
		page_url = "/frontend/mes/select_selfInspCode_1210"
			 	 + "?ref1=" +  + encodeURIComponent(selData.dept_cd);		
	}
	$.ajax({
	    url: page_url,
	    type: "POST",
	    async : false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$("#self_insp_routing").append($('<option>', {
						value: '-', 
				        text : '전체'
				    }));
					$.each(data.rows, function (i, item) {
						$("#self_insp_routing").append($('<option>', { 
					        value: item.code,
					        text : item.code_nm
					    }));
						selfDetail.push((item.code).toLowerCase());
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

function loadSelfInspDetail() {
// 	console.log('loadSelfInspDetail()');
// 	var selData = w2ui.grid_group.get(w2ui.grid_group.getSelection()[0]);
	var selData = $("#grid_role").jqGrid("getRowData", $("#grid_role").getGridParam("selrow"));
	if( selData.dept_cd=="1110" ) {
		$("#1110").show(); 
		$("#1210").hide(); 
	} else {
		$("#1110").hide(); 
		$("#1210").show();
	}
	var headerData = w2ui.grid_selfInsp_header.get(1);
	var simaster_gr_no = headerData.simaster_gr_no;
	var page_url = "/frontend/mes/select_selfinsp_detail"
				+ "?dept_cd=" + encodeURIComponent(selData.dept_cd)
				+ "&pordno=" + encodeURIComponent(selData.vpordno)
				+ "&use_yn=" + encodeURIComponent("Y")
				+ "&simaster_gr_no=" + encodeURIComponent(simaster_gr_no);

	var detailObj = {};
	$.each(selfDetail, function(idx, code){
		w2ui['grid_' + code].lock('loading...', true);
	});

	$.ajax({
		url : page_url,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200" && (data.rows).length>0 ) {
				$.each(data.rows, function(idx, row){
					if( row.insp_state=='' || row.insp_state==undefined )
						row.insp_state = 'i2';
					var subCode = '';
					if( selData.dept_cd=="1110" ) {
						subCode = (row.routing_code_sub).toLowerCase();
					} else {
						subCode = (row.routing_code).toLowerCase();
					}
					if( selData.dept_cd=="1110" || (selData.dept_cd=="1210" && (subCode=='p1'||subCode=='p2'||subCode=='p5'||subCode=='t1')) ) {
						if ( detailObj[subCode]==undefined ) {
							var tmpArr = [];
							tmpArr.push(row);
							detailObj[subCode] = tmpArr;
						} else {
							detailObj[subCode].push(row);				
						}
					}
				});
				
				$.each(detailObj, function(key, arr){
					$.each(arr, function(i, row){
						row.recid = i+1;
					});
					w2ui['grid_' + key].records = arr; 
					w2ui['grid_' + key].total = arr.length;
				});
			} 
			$.each(selfDetail, function(idx, code){
				w2ui['grid_' + code].refresh();
				w2ui['grid_' + code].unlock();
			});
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "정보를 가져오는 중 오류가 발생하였습니다.");
		},
		complete : function() {}
	});
}

function showSelfInspGrid() {
// 	console.log('showSelfInspGrid()');
	$.each(selfDetail, function(idx, opt){
		$("#grid_" + opt + "_area").hide();
	});
	var code = $("#self_insp_routing").val().toLowerCase();
	if( code==null || code=='-' ) {	//전체
		$.each(selfDetail, function(idx, opt){
			$("#grid_" + opt + "_area").show();
			w2ui['grid_' + opt].resize();
			w2ui['grid_' + opt].refresh();
		});
	} else {
		$("#grid_" + code + "_area").show();
		w2ui['grid_' + code].resize();
		w2ui['grid_' + code].refresh();
	}
}

//grid_selfInsp_header
function initGridSelgInspHeader() {
//	console.log('initGridSelgInspHeader()');
	$("#grid_selfInsp_header").w2grid({
		name : 'grid_selfInsp_header',
		header : '제품 이력카드',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'simaster_gr_no', hidden:true},
	        { field:'siheader_seq', caption:'', hidden:true},
	        { field:'siheader_code', caption:'모델명', hidden:true},
	        { field:'display_seq', caption:'seq', hidden:true},
	        { field:'main_name', caption:'대분류', size:'20%', style:'text-align:center'},
	        { field:'sub_name', caption:'소분류', size:'40%', style:'text-align:center'},
	        { field:'item_value', caption:'입력란', size:'40%', sortable:true, editable: { type: 'text'}}
	        ],
		records: [],
		recordHeight : 30,
		total : 0
	});
}

function init_grid_v12() {
// 	console.log('init_grid_v12()');
	$("#grid_v12").w2grid({
		name : 'grid_v12',
		header : 'DarkImage검사',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
				render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
						return replaceAll(getTodayDate(),'.','-');
					else
						return this.getCellValue(index, col_index);
				}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_v12.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_v12.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_v13() {
// 	console.log('init_grid_v13()');
	$("#grid_v13").w2grid({
		name : 'grid_v13',
		header : 'Calibration',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_v13.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_v13.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_v14() {
// 	console.log('init_grid_v14()');
	$("#grid_v14").w2grid({
		name : 'grid_v14',
		header : 'OSF',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_v14.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_v14.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_v17() {
// 	console.log('init_grid_v17()');
	$("#grid_v17").w2grid({
		name : 'grid_v17',
		header : '최종 검사',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_v17.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_v17.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_r10() {
// 	console.log('init_grid_r10()');
	$("#grid_r10").w2grid({
		name : 'grid_r10',
		header : '1차조립',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r10.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r10.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_r11() {
// 	console.log('init_grid_r11()');
	$("#grid_r11").w2grid({
		name : 'grid_r11',
		header : '공정 검사',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r11.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r11.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_r12() {
// 	console.log('init_grid_r12()');
	$("#grid_r12").w2grid({
		name : 'grid_r12',
		header : '최종 조립',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r12.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r12.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_r21() {
// 	console.log('init_grid_r21()');
	$("#grid_r21").w2grid({
		name : 'grid_r21',
		header : '공정 검사',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r21.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r21.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_r22() {
// 	console.log('init_grid_r22()');
	$("#grid_r22").w2grid({
		name : 'grid_r22',
		header : 'ON/OFF Test',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r22.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r22.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_r23() {
// 	console.log('init_grid_r23()');
	$("#grid_r23").w2grid({
		name : 'grid_r23',
		header : '최종 조립',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r23.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r23.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_r31() {
// 	console.log('init_grid_r31()');
	$("#grid_r31").w2grid({
		name : 'grid_r31',
		header : 'Ghost 작업',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r31.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r31.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_r32() {
// 	console.log('init_grid_r32()');
	$("#grid_r32").w2grid({
		name : 'grid_r32',
		header : 'Backup',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r32.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r32.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_r52() {
// 	console.log('init_grid_r52()');
	$("#grid_r52").w2grid({
		name : 'grid_r52',
		header : '공정검사',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r52.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r52.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_qt() {
// 	console.log('init_grid_qt()');
	$("#grid_qt").w2grid({
		name : 'grid_qt',
		header : '품질 최종 검사',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_qt.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_qt.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_qo() {
// 	console.log('init_grid_qo()');
	$("#grid_qo").w2grid({
		name : 'grid_qo',
		header : '품질 1차 검사',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_qo.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_qo.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_qa() {
// 	console.log('init_grid_qa()');
	$("#grid_qa").w2grid({
		name : 'grid_qa',
		header : '품질 Aging',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},//member_id
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_qa.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_qa.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_p1() {
// 	console.log('init_grid_p1()');
	$("#grid_p1").w2grid({
		name : 'grid_p1',
		header : 'Master 검사 공정',
		show : {
			header : true
        },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
   			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
   			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
        		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
            	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
				render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
						return replaceAll(getTodayDate(),'.','-');
					else
						return this.getCellValue(index, col_index);
				}},
			{ field:'remark', caption:'비고', editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_p1.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_p1.set(event.recid, {'member_nm' :member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_p2() {
// 	console.log('init_grid_p2()');
	$("#grid_p2").w2grid({
		name : 'grid_p2',
		header : '조립 공정',
		show : {
			header : true
        },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
   			{ field:'minsp_name', caption:'항목', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
        		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
            	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', editable:{type:'text'}, style:'text-align:center'},
			{ field:'work_date', caption:'작업일', editable: { type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
				render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
						return replaceAll(getTodayDate(),'.','-');
					else
						return this.getCellValue(index, col_index);
				}},
			{ field:'remark', caption:'비고', editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==8 || event.column==9 || event.column==13 ) {
					w2ui.grid_p2.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_p2.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_p5() {
// 	console.log('init_grid_p5()');
	$("#grid_p5").w2grid({
		name : 'grid_p5',
		header : '조정 공정',
		show : {
			header : true
        },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
   			{ field:'minsp_name', caption:'항목', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
        		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
            	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', editable:{type:'text'}, style:'text-align:center'},
			{ field:'work_date', caption:'작업일', editable: { type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
				render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
						return replaceAll(getTodayDate(),'.','-');
					else
						return this.getCellValue(index, col_index);
				}},
			{ field:'remark', caption:'비고', editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==7 || event.column==8 || event.column==12 ) {
					w2ui.grid_p5.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_p5.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}

function init_grid_t1() {
// 	console.log('init_grid_t5()');
	$("#grid_t1").w2grid({
		name : 'grid_t1',
		header : '최종검사 공정',
		show : {
			header : true
        },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
   			{ field:'minsp_name', caption:'항목', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
        		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
            	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', editable:{type:'text'}, style:'text-align:center'},
			{ field:'work_date', caption:'작업일', editable: { type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
				render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
						return replaceAll(getTodayDate(),'.','-');
					else
						return this.getCellValue(index, col_index);
				}},
			{ field:'remark', caption:'비고', editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==7 || event.column==8 || event.column==12 ) {
					w2ui.grid_t1.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_t1.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		}
	});
}


function dataSetselfinspDetail(dataArr) {
// 	console.log('dataSetselfinspDetail()');
	$.each(dataArr, function(idx, row){
		if( row.w2ui!=undefined ){
			var chnObj = row.w2ui.changes;
			if( chnObj.insp_value!=undefined )
				row.insp_value = chnObj.insp_value;
			if( chnObj.insp_state!=undefined )
				row.insp_state = chnObj.insp_state;
			if( chnObj.member_nm!=undefined )
				row.member_nm = chnObj.member_nm;
			if( chnObj.work_date!=undefined )
				row.work_date = chnObj.work_date;
			if( chnObj.remark!=undefined )
				row.remark = chnObj.remark;
		}
		if( row.work_date=='' ) {
			row.work_date = replaceAll(getTodayDate(),'.','-'); 
		}
	});
	return dataArr;
}

function setRecid(arr) {
	var resultArr = [];	
	$.each(arr, function(idx, row){
		row.recid = idx+1;
		resultArr.push(row);
	});
	return resultArr;
}

function Left(str,n){
    if (n <= 0){
       return "";
    }else if (n > String(str).length){
       return str;
    }else{
       return String(str).substring(0,n);
    }
}

function Right(str,n){
    if (n <= 0){
       return "";
    }else if (n > String(str).length){
       return str;
    }else{
       var iLen = String(str).length;
       return String(str).substring(iLen, iLen - n);
    }
}


function LMainsernr_enter(text){
	if(text.value.length > 6) {
		
	    if(text.value.length > 30 && Left(text.value,2) == 01  ){
	    	 
	    	$('#project_no').val(Right(text.value,9));
	    	}
	    
	    fnSearchInspGrid();
	   
	} else {
		fnMessageModalAlert("Notification(MES)", "바코드 길이는 7자리 이상이어야 합니다.<br/>입력값 : " + $('#project_no').val());
		$('#project_no').val("");
    } 
}

function makeOrderModal() {
	w2ui.grid_matnr.clear();
	$("#m_matnr").val("");
	$("#m_maktx").val("");
		
	$("#searchMatnrPopup").modal("show");
	setTimeout(function(){
		w2ui.grid_matnr.resize();
		w2ui.grid_matnr.refresh();
	}, 200);
	
	searchMatnr();
}

function searchMatnr() {
// 	console.log('searchMatnr()');
	var page_url = '/frontend/qm/v_prod_matnr_select'
				 + '?matnr=' + encodeURIComponent($("#m_matnr").val())
				 + '&maktx=' + encodeURIComponent($("#m_maktx").val())
				 + '&page=' + encodeURIComponent(0)
				 + '&rows=' + encodeURIComponent(100000);

	w2ui['grid_matnr'].clear();
	w2ui['grid_matnr'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					row.pdqty = 1;
				});
				w2ui['grid_matnr'].records = rowArr;
				w2ui['grid_matnr'].total = data.rowTotal;
			}
			w2ui['grid_matnr'].refresh();
			w2ui['grid_matnr'].unlock();
		},complete: function () {
		}
	});
}


function gridMatnrGen() {
// 	console.log('gridMatnrGen()');
	
	$("#grid_matnr").w2grid({
		name : 'grid_matnr',
		show : {
			selectColumn: true,
			lineNumbers : true,
            footer: true
        },
		columns : [
			{ field:'dept_cd', caption:'플랜트', size:'15%', sortable:true, render:function(record, index, col_index){
				if (this.getCellValue(index, col_index)=='1110')
					return '의료';
				else if(this.getCellValue(index, col_index)=='1210')
					return '광영상';
			}, style:'text-align:center'},
			{ field:'matnr', caption:'자재코드', size:'25%', sortable:true},
			{ field:'maktx', caption:'자재내역', size:'30%', sortable:true},
			{ field:'wrkst', caption:'Spec.', size:'30%', sortable:true},
			{ field:'pdqty', caption:'수량', size:'10%', sortable:true, editable: { type: 'text'}, style:'text-align:right'},
			{ field:'menge', caption:'menge.', sortable:true, hidden:true}
			],
		records: [],
		multiSelect : true,
		total : 0,
		recordHeight : 30
	});
}

function makeOrder() {
	var record = w2ui.grid_matnr.get(w2ui.grid_matnr.getSelection());
	var pData = record;
	$.each(pData, function(idx, row){
		if( row.w2ui!=undefined ){
			row.pdqty = row.w2ui.changes.pdqty;
		}
	});
	
	var page_url = "/frontend/qm/vendor_prod_insert";			
	var postData = 'record=' + encodeURIComponent(JSON.stringify(record));	
	
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				fnMessageModalAlert("Notification(MES)",	"오더생성을 완료했습니다");
			} else {
				fnMessageModalAlert("Notification(MES)",	"오더생성을 실패했습니다");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)",	"오더생성을 실패했습니다");
		},
		complete : function() {
			w2ui.grid_matnr.clear();
			$("#m_matnr").val("");
			$("#m_maktx").val("");
			
			fnSearchInspGrid();
			
			$("#searchMatnrPopup").modal("hide");
		}
	});
}

function saveSelfInsp() {

	var selData = $("#grid_role").jqGrid("getRowData", $("#grid_role").getGridParam("selrow"));
	var vpordno = selData.vpordno;
	var headerData = w2ui.grid_selfInsp_header.records;
	$.each(headerData, function(idx, row){
		if( row.w2ui!=undefined ){
			row.item_value = row.w2ui.changes.item_value;
		}
	});
	
	var detailObj = {};
	$.each(selfDetail, function(idx, opt){
		detailObj[opt] = dataSetselfinspDetail(w2ui['grid_' + opt].records);
	});
	
	var page_url = "";
	var params = "";
	if( selData.dept_cd=="1110" ) {
		page_url = "/frontend/mes/saveSelfInsp_1110"
				 + "?pordno=" + encodeURIComponent(vpordno)
				 + "&dept_cd=" + encodeURIComponent(selData.dept_cd); 
		params = "&headerData=" + encodeURIComponent(JSON.stringify(headerData))
				+ "&detailData=" + encodeURIComponent(JSON.stringify(detailObj));
	} else {
		page_url = "/frontend/mes/saveSelfInsp_1210"
				 + "?pordno=" + encodeURIComponent(vpordno)
				 + "&dept_cd=" + encodeURIComponent(selData.dept_cd);
		params = "&headerData=" + encodeURIComponent(JSON.stringify(headerData))
				+ "&grid_p1_data=" + encodeURIComponent(JSON.stringify(dataSetselfinspDetail(w2ui.grid_p1.records)))
				+ "&grid_p2_data=" + encodeURIComponent(JSON.stringify(dataSetselfinspDetail(w2ui.grid_p2.records)))
				+ "&grid_p5_data=" + encodeURIComponent(JSON.stringify(dataSetselfinspDetail(w2ui.grid_p5.records)))
				+ "&grid_t1_data=" + encodeURIComponent(JSON.stringify(dataSetselfinspDetail(w2ui.grid_t1.records)));
	}
	$.ajax({
		url: page_url,
		data : params,
		type: "POST",
		async:false,
		success:function(data, textStatus, jqXHR){
			if(data.status == "200") {
				if(data.flag == "true") {
					vOrdStatusChange("v2");
					fnMessageModalAlert("Notification(QM)", "저장을 완료 하였습니다.");	
					updateDmr();
				} else if(data.flag == "false") {
					fnMessageModalAlert("Notification(QM)","해당 오더의 상태가 작업 중 변경되었습니다.<br/>자주검사등록이 취소되었습니다.");		
				}
				
				$("#modal_selfInsp").modal('hide');
				$("#pono").text("");	// 2018-01-24 : iris add, 지시번호 표시
			} else {
				fnMessageModalAlert("Fail", "데이터 저장을 실패하였습니다.");	
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("Fail", "데이터 저장하는데 에러가 발생하였습니다.");	
		},
		complete: function() {
			fnSearchInspGrid();
		}
	});
}

function excelFileDownload(gridName) {
// 	console.log('excelFileDownload('+gridName+')');

	var gridCols = w2ui[gridName].columns;
	var gridData = w2ui.grid_matnr.get(w2ui.grid_matnr.getSelection());
	
	var pData = gridData;
	$.each(pData, function(idx, row){
		if( row.w2ui!=undefined ){
			row.pdqty = row.w2ui.changes.pdqty;
		}
	});

	
	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	if( gridName=='grid_matnr' ) {
		fileName = '외주생산정보.xlsx';
		sheetTitle = '외주생산정보';
		sheetName = '외주생산정보';
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
		
		for(var i=0; i<gridCols.length; i++){
			if(!gridCols[i].hidden){
				var caption = gridCols[i].caption;
				param_col_name += "," + caption;
				param_col_id += "," + gridCols[i].field;
				param_col_align += ",left";
				param_col_width += "," + (gridCols[i].width==undefined?"80":(gridCols[i].width).replace('px',''));
			}
		}
		
		param_col_name += ",시리얼";
		param_col_id += ",sernr";
		param_col_align += ",left";
		param_col_width += ",80";
		
	}
	
	var p_gridData = [];
	
	for(var i=0 ; i<gridData.length; i++) {
		for(var j=0 ; j<gridData[i].pdqty; j++) {
			p_gridData.push(gridData[i]);	
		}
	}
	
	for(var i=0 ; i<p_gridData.length; i++) {
		p_gridData[i].pdqty = '1';	
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
		export_data += "&body_data="+encodeURIComponent(JSON.stringify(p_gridData));

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

function drwDownload(file_cate) {
	
	var cate = '';
	if(file_cate == 'drw') {
		cate = '도면';
	} else if(file_cate == 'ord') {
		cate = '작업표준서';
	}
	
	var selKey = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
	
	if (selKey.length > 1) {
		fnMessageModalAlert("Notification(MES)", "한개의 오더만 선택해주세요.");
		return;
	} else if(selKey.length == 0) {
		fnMessageModalAlert("Notification(MES)", "선택된 생산지시오더가 없습니다.");
		return;
	}
	
	var rowData = $("#grid_role").getRowData(selKey[0]);
	
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

function fnSernrLoadFileHandler(){
// 	console.log('fnSernrLoadFileHandler()');
	var page_url = "/file/vendor_insp_ord_upload";
	
	
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


		var rtn_data = data.result.rows;
			
		var msg = '';
		
		for(var i=0 ;i<rtn_data.length; i++) {
			msg +=  "자재번호 : " + rtn_data[i].matnr + " // 시리얼번호 : " + rtn_data[i].sernr + "<br/>" 
		}
		msg += "<br/> 상기와 같은 내용으로 오더를 생성하시겠습니까?"
				
		fnMessageModalConfirm("Notification", msg, function(chk){
			if(chk){
				
				var record = [];
				for(var i=0 ;i<rtn_data.length; i++) {
					param_obj = {};
					param_obj.matnr = rtn_data[i].matnr;
					param_obj.maktx = rtn_data[i].maktx;
					param_obj.sernr = rtn_data[i].sernr;
					param_obj.pdqty = "1";
					param_obj.menge = "1";
					param_obj.dept_cd = rtn_data[i].werks;
					
					record.push(param_obj);
				}
				
				
				var page_url = "/frontend/qm/vendor_prod_insert";			
				var postData = 'record=' + encodeURIComponent(JSON.stringify(record));	
				
				$.ajax({
					url : page_url,
					data : postData,
					async : false,
					type : "POST",
					success : function(data, textStatus, jqXHR) {
						if(data.status == "200") {
							fnMessageModalAlert("Notification(MES)",	"오더생성을 완료했습니다");
						} else {
							fnMessageModalAlert("Notification(MES)",	"오더생성을 실패했습니다");
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						fnMessageModalAlert("Notification(MES)",	"오더생성을 실패했습니다");
					},
					complete : function() {
						fnSearchInspGrid();
						$("#searchMatnrPopup").modal("hide");
					}
				});	 
			}
		});	
	}).on('fileuploadfail', function(e, data) {
		$.each(data.files, function(index) {
			fnMessageModalAlert("Notification", "File upload failed.");
		});
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}

function selfInspSernrSave() {
	
	var selKey = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
	
	if(selKey.length == 0) {
		fnMessageModalAlert("Notification(QM)",	"선택된 오더가 없습니다.");
		return;
	}

	var c_vpdsts = chkVpdsts();

	if(c_vpdsts == 'v3') {
		fnMessageModalAlert("Warning", "이미 완료처리 된 오더입니다.");
		return;
	}
	
	
	var p_data = [];
	var vpordnos = "";
	for(var i=0 ; i<selKey.length; i++) {
		var p_data_obj = $("#grid_role").getRowData(selKey[i]);
		p_data.push(p_data_obj);
		vpordnos = vpordnos + p_data_obj.vpordno + ",";
	}
	vpordnos = vpordnos.substring(0, vpordnos.length-1);
	
	
	var page_url = "/frontend/qm/selfInspSernrSave";			
	var postData = 'record=' + encodeURIComponent(JSON.stringify(p_data));
	postData += '&vpordnos=' + encodeURIComponent(vpordnos);	
	
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				if(data.flag == "true") {
					fnMessageModalAlert("Notification(QM)",	"시리얼등록을 완료했습니다");	
				} else {
					fnMessageModalAlert("Notification(QM)",	"해당 오더의 상태가 작업 중 변경되었습니다.<br/>시리얼 등록이 취소되었습니다.");
				}
				
			} else {
				fnMessageModalAlert("Notification(QM)",	"시리얼등록을 실패했습니다");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(QM)",	"시리얼등록을 실패했습니다");
		},
		complete : function() {

			fnSearchInspGrid();
			
		}
	});
}

function vOrdStatusChange(vpdsts) {
	console.log("vOrdStatusChange("+vpdsts+")");
	var selKey = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
	
	if(selKey.length == 0) {
		fnMessageModalAlert("Notification(QM)",	"선택된 오더가 없습니다.");
		return;
	}

	if(vpdsts == 'v3') {
		console.log(vpdsts);
		for(var i=0 ; i<selKey.length; i++) {
			var p_data_obj = $("#grid_role").getRowData(selKey[i]);
			if(p_data_obj.vpdsts == 'v1') {
				fnMessageModalAlert("Notification(QM)",	"선택된 오더는가 대기상태입니다.<br/>처리를 하신 뒤 완료 해야합니다.");
				return;
			}
			if(p_data_obj.vpdsts == 'v3') {
				fnMessageModalAlert("Notification(QM)",	"선택된 오더는 이미 완료됐습니다.");
				return;
			}
		}
	}
	
	var p_data = [];
	var vpordnos = "";	
	for(var i=0 ; i<selKey.length; i++) {
		var p_data_obj = $("#grid_role").getRowData(selKey[i]);
		p_data.push(p_data_obj);
		vpordnos = vpordnos + p_data_obj.vpordno + ",";
	}
	
	vpordnos = vpordnos.substring(0, vpordnos.length-1);

	var page_url = "/frontend/qm/vOrdStatusChange";			
	var postData = 'record=' + encodeURIComponent(JSON.stringify(p_data));
	postData += '&vpdsts=' + encodeURIComponent(vpdsts);
	postData += '&vpordnos=' + encodeURIComponent(vpordnos);
	
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				if(data.flag == "true") {
					fnMessageModalAlert("Notification(QM)",	"선택된 오더의 상태를 변경했습니다.");	
				} else if(data.flag == "false") {
					fnMessageModalAlert("Notification(QM)","해당 오더의 상태가 작업 중 변경되었습니다.<br/>선택된 오더의 상태 변경을 취소했습니다.");		
				}
			} else {
				fnMessageModalAlert("Notification(QM)",	"선택된 오더의 상태변경을 실패했습니다");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(QM)",	"선택된 오더의 상태변경을 실패했습니다");
		},
		complete : function() {

			fnSearchInspGrid();
			
		}
	});
}

function chkVpdsts() {
	var selKey = $("#grid_role").jqGrid('getGridParam', 'selarrrow');

	var selected_key = selKey[0]
	

	var page_url = "/frontend/qm/chkVpdsts";			
	var postData = 'vpordno=' + encodeURIComponent(selected_key);
	var rtn_result;
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				if(data.rows.length > 0) {
					rtn_result = data.rows[0].vpdsts;
				}
			} else {
				fnMessageModalAlert("Notification(QM)",	"상태값 조회를 실패했습니다.");
				return;
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(QM)",	"상태값 조회를 실패했습니다.");
			return;
		},
		complete : function() {
		}
	});
	
	return rtn_result;
}

function v3_vOrdStatusChange(){
	var selKey = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
	
	if(selKey.length == 0) {
		fnMessageModalAlert("Notification(QM)",	"선택된 오더가 없습니다.");
		return;
	}

	
	for(var i=0 ; i<selKey.length; i++) {
		var p_data_obj = $("#grid_role").getRowData(selKey[i]);
		if(p_data_obj.vpdsts == 'v1') {
			fnMessageModalAlert("Notification(QM)",	"선택된 오더는가 대기상태입니다.<br/>처리를 하신 뒤 완료 해야합니다.");
			return;
		}
		if(p_data_obj.vpdsts == 'v3') {
			fnMessageModalAlert("Notification(QM)",	"선택된 오더는 이미 완료됐습니다.");
			return;
		}
	}
	
	fnMessageModalConfirm("Notification", "선택된 오더를 완료처리하시겠습니까?", function(chk){
		
		if(chk){
			vOrdStatusChange('v3');		 
		}
	});	
}

function fnSelfInspSernrSave() {
	
	var selKey = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
	
	var inputSernr = [];
	
	if(selKey.length == 0) {
		fnMessageModalAlert("Notification(QM)", "선택된 생산지시오더가 없습니다.");
		return;	
	}
	
	for(var i=0 ; i<selKey.length; i++) {
		var p_data_obj = $("#grid_role").getRowData(selKey[i]);
		if(p_data_obj.vpdsts == 'v3') {
			fnMessageModalAlert("Notification(QM)", "이미 완료처리 된 항목이 포함되어 있습니다.");
			return;	
		}
		if(p_data_obj.sernr.length == 0) {
			fnMessageModalAlert("Notification(QM)", "시리얼이 입력되지 않은 항목이 있습니다.");
			return;	
		}
		inputSernr.push(p_data_obj.sernr);
	}
	
	var uniqueSernr = [];

	$.each(inputSernr, function(i, el){
		if($.inArray(el, uniqueSernr) === -1) uniqueSernr.push(el);
	});

	//입렵한 시리얼 내역 중복 체크
	if(uniqueSernr.length != inputSernr.length) {
		fnMessageModalAlert("Notification(QM)", "중복해서 입력한 시리얼이 있습니다.<br/>확인후 다시 진행해주세요.");
		return;
	}
	
	//기존에 DB에 저장된 시리얼 내역 중복 체크
	if(vph_chkDupSernr() == false) {
		return;
	}
	
	fnMessageModalConfirm("Notification(QM)",  "선택된 오더의 시리얼등록을 진행하시겠습니까?", function(chk){
		if(chk){
			selfInspSernrSave();		 
		}
	});	
}

function jqgridHighlightFormatterDeptCd(cellvalue, options, rowObject) {
	if (rowObject.dept_cd == '1110') {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">의료</span>';
	} else if (rowObject.dept_cd == '1210') {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">광</span>';
	}
}

function jqgridHighlightFormatterVpdsts(cellvalue, options, rowObject) {
	if (rowObject.vpdsts == 'v1') {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#353535;background-color:#CEFBC9\">대기</span>';
	} else if (rowObject.vpdsts == 'v2') {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#353535;background-color:#FFE08C\">처리</span>';
	} else if (rowObject.vpdsts == 'v3') {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#353535;background-color:#FFA7A7\">완료</span>';
	}
}

function vorder_del() {
	var selKey = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
	
	if(selKey.length == 0) {
		fnMessageModalAlert("Notification(QM)",	"선택된 오더가 없습니다.");
		return;
	}

	
	
	for(var i=0 ; i<selKey.length; i++) {
		var p_data_obj = $("#grid_role").getRowData(selKey[i]);
		if(p_data_obj.vpdsts != 'v1') {
			fnMessageModalAlert("Notification(QM)",	"오더삭제는 대기상태일때만 가능합니다.");
			return;		
		}
	}
	
	fnMessageModalConfirm("Notification(QM)",  "선택된 오더 삭제를 진행하시겠습니까?", function(chk){
		if(chk){
			fn_vorder_del();		 
		}
	});
}
function fn_vorder_del() {
	var selKey = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
	
	
	var p_data = [];
	var vpordnos = "";
	for(var i=0 ; i<selKey.length; i++) {
		var p_data_obj = $("#grid_role").getRowData(selKey[i]);
		p_data.push(p_data_obj);
		vpordnos = vpordnos + p_data_obj.vpordno + ",";
	}
	
	vpordnos = vpordnos.substring(0, vpordnos.length-1);

	var page_url = "/frontend/qm/vorder_del";			
	var postData = 'record=' + encodeURIComponent(JSON.stringify(p_data));
	postData += '&vpordnos=' + encodeURIComponent(vpordnos);
	
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				
				if(data.flag == "true") {
					fnMessageModalAlert("Notification(QM)",	"선택된 오더를 삭제했습니다.");	
				} else if(data.flag == "false") {
					fnMessageModalAlert("Notification(QM)","해당 오더의 상태가 작업 중 변경되었습니다.<br/>선택된 오더는 이미 삭제되었거나 삭제가능한 상태가 아닙니다.");		
				}
			} else {
				fnMessageModalAlert("Notification(QM)",	"선택된 오더를 삭제하지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(QM)", "선택된 오더를 삭제하지 못했습니다.");
		},
		complete : function() {

			fnSearchInspGrid();
			
		}
	});
}

function fnChkUser() {
	//console.log('fnChkUser()');
	
	var  lifnr = '';
	var page_url = "/frontend/scm/checkVenderMember";
	var params = "member_emp_no="+encodeURIComponent(member_id);
	
	$.ajax({
		url : page_url,
		data : params,
		type : 'POST',
		async : false,
		dataType : 'json',
		success: function( data ) {
			if(data.status == 200) {
				var dept_cd = data.result;
				if( data.result=='1063') lifnr = member_id;
				else lifnr = '';
			}
		},
		complete: function () {}
	});
	return lifnr;
}

function showDmrInfo() {

	var sel_key_arr = $("#grid_role").jqGrid('getGridParam', 'selarrrow');		 
	var i_rowData = $("#grid_role").getRowData(sel_key_arr[0]);
	
	var page_url = "/frontend/qm/showDmrInfo";
	var params = "matnr="+encodeURIComponent(i_rowData.matnr);
	params += "&apply_yn="+encodeURIComponent("Y");
	params += "&use_yn="+encodeURIComponent("Y");
	params += "&gr_no="+encodeURIComponent(i_rowData.gr_no);
	params += "&gr_seq="+encodeURIComponent(i_rowData.gr_seq);
	params += "&vpordno="+encodeURIComponent(i_rowData.vpordno);
	
	$.ajax({
		url : page_url,
		data : params,
		type : 'POST',
		async : false,
		dataType : 'json',
		success: function( data ) {
			if(data.status == 200) {
				console.log(data);
				if(data.rows.length > 0) {
					$("#p_vpordno").text(sel_key_arr[0]);
					$("#p_dmr").text(data.rows[0].dmr_no);
					$("#p_rn").text(data.rows[0].rn_no);
					$("#p_gr_no").text(data.rows[0].gr_no);
					$("#p_gr_seq").text(data.rows[0].gr_seq);
				}else {
					$("#p_dmr").text("-");
					$("#p_rn").text("-");
				}
			}
		},
		complete: function () {}
	});
}

function vph_chkDupSernr() {
	
	var rtn_result;
	var params = [];

	var selKey = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
	
	for(var i=0 ; i<selKey.length; i++) {
		params.push($("#grid_role").getRowData(selKey[i]));	
	}
	
	var page_url = "/frontend/qm/vph_chkDupSernr";
	var params = "params="+encodeURIComponent(JSON.stringify(params));
	
	$.ajax({
		url : page_url,
		data : params,
		type : 'POST',
		async : false,
		dataType : 'json',
		success: function( data ) {
			if(data.status == 200) {
				if(data.rtn_msg == 'Y') {
					fnMessageModalAlert("Notification(QM)", "입력하신 시리얼은 이미 등록된 내역입니다.<br/>확인하고 다시 진행해주세요.");
					rtn_result = false;			
				}else {
					rtn_result = true;
				}
			}
		},
		complete: function () {}
	});
	
	return rtn_result;
}

function updateDmr() {
	
	if($("#p_gr_no").text().length == 0) {
		return;
	}
	
	var p_vpordno = $("#p_vpordno").text();
	var p_gr_no = $("#p_gr_no").text();
	var p_gr_seq = $("#p_gr_seq").text();
	
	var page_url = "/frontend/qm/updateDmr";
	var params = "vpordno="+encodeURIComponent(p_vpordno);
	params += "&gr_no="+encodeURIComponent(p_gr_no);
	params += "&gr_seq="+encodeURIComponent(p_gr_seq);
	
	$.ajax({
		url : page_url,
		data : params,
		type : 'POST',
		async : false,
		dataType : 'json',
		success: function( data ) {
			if(data.status == 200) {
			}else {
				fnMessageModalAlert("Notification(QM)", "DMR정보를 입력하는데 실패했습니다.");
				return;
			}
		},
		complete: function () {}
	});
}
</script>
</body>
</html>