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
    
<!--     <style type="text/css"> 
		.daterangepicker tr:hover {
		    background-color: #F2CB61;
		}
 	</style> -->
	
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
            <jsp:param name="selected_menu_cd" value="1098" />
        </jsp:include>

        <div class="content-wrapper">
            <section class="content-header">
                <h1>
					품질관리 <small> 최종검사진행현황</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="#"><i class="fa fa-dashboard"></i> 품질관리 </a></li>
                    <li class="active">최종검사진행현황</li>
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
                                    <button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_role');" data-selfilepath="/upload" data-selfilename="test.xlsx">
									 	<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
									</button>
                                </div>
                            </div>
                            <div id="" class="box-body">
                                <div class="row">
                                	<div class="col-sm-2">
                                        <div class="form-group">
                                        	<label>완성일</label> 
                                            <div class="input-group">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <input type="text" class="form-control pull-right input-sm" id="req_date_range" >
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                        	<label>| 플랜트</label> 
                                            <div class="input-group" style="width: 100%;">
                                            	<select id="m_wkctr" class="form-control select2 col-sm-2 input-sm" data-placeholder="">
													<option value="">전체</option>
													<option value="1110">의료</option>
													<option value="1210">광</option>
												</select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                        	<label>| Lv.1</label> 
                                            <input type="input" id="m_level_1" name="m_level_1" class="form-control input-sm"/>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                        	<label>| Lv.2</label> 
		                                    <input type="input" id="m_level_2" name="m_level_2" class="form-control input-sm"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box box-default box-solid" style="min-height: 600px;">
                            <div class="box-header with-border">
                            	 <h3 class="box-title">검사내역</h3>
                            </div>
                            <div class="box-body">
                                <div class="row">
                                    <div id="dv_grid_role" class="col-sm-12">
                                        <table id="grid_role"></table>
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
<script type="text/javascript">

var selected_pordno_pop;
var member_nm = '<%=member_nm%>';
var member_emp_no = '<%=member_emp_no%>';

$(function($) {
	fnLoadCommonOption();
	fnLoadInspGrid();
});

// function dateSetting() {
//     	var val = $("#pickdate").val();
// 		var s_date = moment(val, "YYYY-MM-DD").day(0).format("YYYY-MM-DD")
// 		var e_date = moment(val, "YYYY-MM-DD").day(6).format("YYYY-MM-DD")
       
// 		console.log(s_date, e_date);
// 		$("#pickdate").val(s_date + " - "+ e_date);
// }

function fnLoadCommonOption() {

	$(window).bind('resize', function() {
		resizeJqGrid("grid_role", false);
	}).trigger('resize');
	
// 	$("#pickdate").daterangepicker({
// 		opens: "right",
// 		singleDatePicker: true,
// 		locale: {
// 			format: "YYYY-MM-DD" // inputbox 에 "2011/04/29" 로표시
// 			,monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
// 			,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
// 			,showMonthAfterYear: true
// 			,yearSuffix: "년"
// 			,orientation: "top left"
// 	    }
// 	});
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
	});
	
	initScreenSizeModal();

}

function fnSearchInspGrid() {
		
	var date1 = $("#req_date_range").val().substring(0,10).replace("-","").replace("-","");
	var date2 = $("#req_date_range").val().substring(13,23).replace("-","").replace("-","");


	var page_url = "/frontend/qm/inspection_state_select";
	page_url += "?f_cmdat=" + encodeURIComponent(date1)
	page_url += "&t_cmdat=" + encodeURIComponent(date2)
	page_url += "&atwtb_l=" + encodeURIComponent($("#m_level_1").val())
	page_url += "&atwtb_m=" + encodeURIComponent($("#m_level_2").val())
	page_url += "&werks=" + encodeURIComponent($("#m_wkctr").val());
	
	$("#grid_role").jqGrid('setGridParam', { url : page_url, datatype : 'json' });
	$("#grid_role").trigger("reloadGrid");
}
	
function fnLoadInspGrid() {
	$("#grid_role").jqGrid({
		datatype : "json",
		colNames : ['Lv.1 - Lv.2', 'Lv.1', 'Lv.2', 'Lv.3', '이월수량', '생산완료', '검사대상수량', '검사수량', '검사잔량', '합격수량', '불합격수량', '합격율(%)'],
		colModel : [
// 			{name : 'group_key',index : 'group_key',width : 10,sorttype : "text",	sortable : true, hidden:true, key : true, summaryTpl : 'total'}, 
			{name : 'group_key',index : 'group_key',width : 10,sorttype : "text"},
			{name : 'atwtb_l',index : 'atwtb_l',width : 10,sorttype : "text",	sortable : true,summaryType:'count', summaryTpl : '소계({0})'},
			{name : 'atwtb_m',index : 'atwtb_m',width : 10,sorttype : "text",	sortable : true},
			{name : 'atwtb_s',index : 'atwtb_s',width : 10,sorttype : "text",	sortable : true},
			{name : 'pre_remain_cnt',index : 'pre_remain_cnt',width : 10, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'}, 
			{name : 'now_remain_cnt',index : 'now_remain_cnt',width : 10, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'}, 
			{name : 'total_remain_cnt',index : 'total_remain_cnt',width : 10, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'now_done_cnt',index : 'now_done_cnt',width : 10, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'entire_remain_cnt',index : 'entire_remain_cnt',width : 10, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'now_pass_cnt',index : 'now_pass_cnt',width : 10, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'now_nonpass_cnt',index : 'now_nonpass_cnt',width : 10, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
// 			{name : 'pass_rate',index : 'pass_rate',width : 10, align:"right", sorttype:'number',formatter:'number', summaryType:'avg'},
			{name : 'pass_rate',index : 'pass_rate',width : 10, align:"right", sorttype:'integer',formatter:'integer'},
		],
		rowNum:15000,
		viewrecords : true,
		autowidth : true,
		shrinkToFit : true,
		multiselect : false,
		height : 550,
		altRows : true,
		rownumbers : true,
		rownumWidth : 25,
		autoencode : true,
		loadonce : false,
		sortable : false,
		cellEdit:true,
		grouping:true,
	   	groupingView : {
	   		groupField : ['group_key'],
	   		groupSummary : [true],
	   		groupColumnShow : [false],
	   		groupText : ['<b>{0}</b>'],
	   		groupCollapse : false,
			groupOrder: ['asc']
	   	},
	    onSelectRow : function(rowid, selected) {	
		},
		loadComplete : function(data) {
			console.log(data);
		}
	});
}

function jqgridHighlightFormatterSapSendFlag(cellvalue, options, rowObject) {
// 	if (cellvalue != null && cellvalue != "" && cellvalue == "V001") {
	if(rowObject.routing_no != rowObject.transfer_routing) {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#E5D85C\">전송미대상</span>';
	} else if (rowObject.sap_send_yn == 'Y') {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#2F9D27\">전송완료</span>';
	} else if(rowObject.sap_send_yn == 'N'){
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">전송대기</span>';
	}
}

function excelFileDownload(gridName) {
// 	console.log('excelFileDownload('+gridName+')');
	var tmpArr = [];
	var getColNames = $("#grid_role").jqGrid('getGridParam','colNames');
	var getColModels = $("#grid_role").jqGrid('getGridParam','colModel');
	$.each(getColModels, function(idx, mrow){
		if( mrow.hidden==false && getColNames[idx]!='' ) {
			mrow.caption = getColNames[idx]; 
			tmpArr.push(mrow);  
		}
	});
	
	var gridCols = tmpArr;
	var gridData = $("#grid_role").getRowData();

	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	if( gridName=='grid_role' ) {
		fileName = '최종검사진행현황.xlsx';
		sheetTitle = '최종검사진행현황';
		sheetName = '최종검사진행현황';
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
</script>
</body>
</html>