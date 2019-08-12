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
		.daterangepicker tr:hover {
		    background-color: #F2CB61;
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
            <jsp:param name="selected_menu_cd" value="1099" />
        </jsp:include>

        <div class="content-wrapper">
            <section class="content-header">
                <h1>
					품질관리 <small> 최종검사진행현황(기간별추이)</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="#"><i class="fa fa-dashboard"></i> 품질관리 </a></li>
                    <li class="active">최종검사진행현황(기간별추이)</li>
                </ol>
            </section>
            <section class="content">
                <div class="row">
                    <section class="col-lg-12">
                        <div class="box box-success box-solid" style="min-height: 70px;">
                            <div class="box-header with-border">
                                <h3 class="box-title">조회조건</h3>
                                <div class="box-tools pull-right">
                                    <button type="button" id="btn_searchcsr" class="btn btn-primary btn-sm" onclick="fnSearchInspGrid();">조회</button>
                                    <button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_role');" data-selfilepath="/upload" data-selfilename="test.xlsx">
									 	<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
									</button>
                                </div>
                            </div>
                            <div id="" class="box-body">
                                <div class="row">
                                	<div class="col-sm-2">
                                        <div class="form-group">
                                        	<label>| 조회연도</label> 
                                            <div class="input-group" style="width: 100%;">
                                            	<select id="m_year" class="form-control select2 col-sm-2 input-sm" data-placeholder="">
												</select>
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
	getYearList();
	fnLoadInspGrid();
});

function dateSetting() {
    	var val = $("#pickdate").val();
		var s_date = moment(val, "YYYY-MM-DD").day(0).format("YYYY-MM-DD")
		var e_date = moment(val, "YYYY-MM-DD").day(6).format("YYYY-MM-DD")
       
		console.log(s_date, e_date);
		$("#pickdate").val(s_date + " - "+ e_date);
}

function fnLoadCommonOption() {

	$(window).bind('resize', function() {
		resizeJqGrid("grid_role", false);
	}).trigger('resize');
	
	$("#pickdate").daterangepicker({
		opens: "right",
		singleDatePicker: true,
		locale: {
			format: "YYYY-MM-DD" // inputbox 에 "2011/04/29" 로표시
			,monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
			,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
			,showMonthAfterYear: true
			,yearSuffix: "년"
			,orientation: "top left"
	    }
	});

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
		

	var page_url = "/frontend/qm/inspection_state_monthly_select";
	page_url += "?atwtb_l=" + encodeURIComponent($("#m_level_1").val())
	page_url += "&atwtb_m=" + encodeURIComponent($("#m_level_2").val())
	page_url += "&cmdat=" + encodeURIComponent($("#m_year").val())
	page_url += "&werks=" + encodeURIComponent($("#m_wkctr").val());
	
	
	$("#grid_role").jqGrid('setGridParam', { url : page_url, datatype : 'json' });
	$("#grid_role").trigger("reloadGrid");
}
	
function fnLoadInspGrid() {
	$("#grid_role").jqGrid({
		datatype : "json",
		colNames : ['Lv.1 - Lv.2', 'Lv.1', 'Lv.2', 'Lv.3',
		            'h1','검사수량', '합격수량', '합격율(%)',
		            'h2','검사수량', '합격수량', '합격율(%)',
		            'h3','검사수량', '합격수량', '합격율(%)',
		            'h4','검사수량', '합격수량', '합격율(%)',
		            'h5','검사수량', '합격수량', '합격율(%)',
		            'h6','검사수량', '합격수량', '합격율(%)',
		            'h7','검사수량', '합격수량', '합격율(%)',
		            'h8','검사수량', '합격수량', '합격율(%)',
		            'h9','검사수량', '합격수량', '합격율(%)',
		            'h10','검사수량', '합격수량', '합격율(%)',
		            'h11','검사수량', '합격수량', '합격율(%)',
		            'h12','검사수량', '합격수량', '합격율(%)'],
		colModel : [
			{name : 'group_key',index : 'group_key',width : 10,sorttype : "text"},
			{name : 'atwtb_l',index : 'atwtb_l',width : 80,sorttype : "text",	sortable : true,summaryType:'count', summaryTpl : '소계({0})'},
			{name : 'atwtb_m',index : 'atwtb_m',width : 80,sorttype : "text",	sortable : true},
			{name : 'atwtb_s',index : 'atwtb_s',width : 80,sorttype : "text",	sortable : true},
			{name : 'h1',index : 'h1',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'onenow_done_cnt',index : 'onenow_done_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'onenow_pass_cnt',index : 'onenow_pass_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'onepass_rate',index : 'onepass_rate',width : 60, align:"right", sorttype:'integer',formatter:'integer' },
			{name : 'h2',index : 'h2',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'twonow_done_cnt',index : 'twonow_done_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'twonow_pass_cnt',index : 'twonow_pass_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'twopass_rate',index : 'twopass_rate',width : 60, align:"right", sorttype:'integer',formatter:'integer' },
			{name : 'h3',index : 'h3',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'threenow_done_cnt',index : 'threenow_done_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'threenow_pass_cnt',index : 'threenow_pass_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'threepass_rate',index : 'threepass_rate',width : 60, align:"right", sorttype:'integer',formatter:'integer' },
			{name : 'h4',index : 'h4',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'fournow_done_cnt',index : 'fournow_done_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'fournow_pass_cnt',index : 'fournow_pass_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'fourpass_rate',index : 'fourpass_rate',width : 60, align:"right", sorttype:'integer',formatter:'integer' },
			{name : 'h5',index : 'h5',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'fivenow_done_cnt',index : 'fivenow_done_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'fivenow_pass_cnt',index : 'fivenow_pass_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'fivepass_rate',index : 'fivepass_rate',width : 60, align:"right", sorttype:'integer',formatter:'integer' },
			{name : 'h6',index : 'h6',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'sixnow_done_cnt',index : 'sixnow_done_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'sixnow_pass_cnt',index : 'sixnow_pass_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'sixpass_rate',index : 'sixpass_rate',width : 60, align:"right", sorttype:'integer',formatter:'integer' },
			{name : 'h7',index : 'h7',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'sevennow_done_cnt',index : 'sevennow_done_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'sevennow_pass_cnt',index : 'sevennow_pass_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'sevenpass_rate',index : 'sevenpass_rate',width : 60, align:"right", sorttype:'integer',formatter:'integer' },
			{name : 'h8',index : 'h8',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'eightnow_done_cnt',index : 'eightnow_done_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'eightnow_pass_cnt',index : 'eightnow_pass_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'eightpass_rate',index : 'eightpass_rate',width : 60, align:"right", sorttype:'integer',formatter:'integer' },
			{name : 'h9',index : 'h9',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'ninenow_done_cnt',index : 'ninenow_done_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'ninenow_pass_cnt',index : 'ninenow_pass_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'ninepass_rate',index : 'ninepass_rate',width : 60, align:"right", sorttype:'integer',formatter:'integer' },
			{name : 'h10',index : 'h10',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'tennow_done_cnt',index : 'tennow_done_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'tennow_pass_cnt',index : 'tennow_pass_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'tenpass_rate',index : 'tenpass_rate',width : 60, align:"right", sorttype:'integer',formatter:'integer' },
			{name : 'h11',index : 'h11',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'elevennow_done_cnt',index : 'elevennow_done_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'elevennow_pass_cnt',index : 'elevennow_pass_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'elevenpass_rate',index : 'elevenpass_rate',width : 60, align:"right", sorttype:'integer',formatter:'integer' },
			{name : 'h12',index : 'h12',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'twelvenow_done_cnt',index : 'twelvenow_done_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'twelvenow_pass_cnt',index : 'twelvenow_pass_cnt',width : 60, align:"right", sorttype:'integer',formatter:'integer', summaryType:'sum'},
			{name : 'twelvepass_rate',index : 'twelvepass_rate',width : 60, align:"right", sorttype:'integer',formatter:'integer' },
		],
		rowNum:15000,
		viewrecords : true,
		autowidth : true,
		shrinkToFit : false,
		multiselect : false,
		height : 600,
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
	

	
	
	$("#grid_role").jqGrid('setGroupHeaders', {
		useColSpanStyle: true, 
		groupHeaders:[		  
		  {startColumnName: 'h1', numberOfColumns: 4, titleText: '1월'},
		  {startColumnName: 'h2', numberOfColumns: 4, titleText: '2월'},
		  {startColumnName: 'h3', numberOfColumns: 4, titleText: '3월'},
		  {startColumnName: 'h4', numberOfColumns: 4, titleText: '4월'},
		  {startColumnName: 'h5', numberOfColumns: 4, titleText: '5월'},
		  {startColumnName: 'h6', numberOfColumns: 4, titleText: '6월'},
		  {startColumnName: 'h7', numberOfColumns: 4, titleText: '7월'},
		  {startColumnName: 'h8', numberOfColumns: 4, titleText: '8월'},
		  {startColumnName: 'h9', numberOfColumns: 4, titleText: '9월'},
		  {startColumnName: 'h10', numberOfColumns: 4, titleText: '10월'},
		  {startColumnName: 'h11', numberOfColumns: 4, titleText: '11월'},
		  {startColumnName: 'h12', numberOfColumns: 4, titleText: '12월'}
		]
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

	$("#grid_role").jqGrid('destroyGroupHeader');

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
		fileName = '최종검사진행현황(기간별추이).xlsx';
		sheetTitle = '최종검사진행현황(기간별추이)';
		sheetName = '최종검사진행현황(기간별추이)';
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
		
		var month_nm = '';
		var no = 0;
		
		for(var i=0; i<gridCols.length; i++){
			if(!gridCols[i].hidden && gridCols[i].name != ''){
				var caption = gridCols[i].caption;
				if(caption == '검사수량') {
					no++;
					month_nm =  no + '월 ';   
				}
				caption = month_nm + caption;
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
	  async:false,
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
	
	
	$("#grid_role").jqGrid('setGroupHeaders', {
		useColSpanStyle: true, 
		groupHeaders:[		  
		  {startColumnName: 'h1', numberOfColumns: 4, titleText: '1월'},
		  {startColumnName: 'h2', numberOfColumns: 4, titleText: '2월'},
		  {startColumnName: 'h3', numberOfColumns: 4, titleText: '3월'},
		  {startColumnName: 'h4', numberOfColumns: 4, titleText: '4월'},
		  {startColumnName: 'h5', numberOfColumns: 4, titleText: '5월'},
		  {startColumnName: 'h6', numberOfColumns: 4, titleText: '6월'},
		  {startColumnName: 'h7', numberOfColumns: 4, titleText: '7월'},
		  {startColumnName: 'h8', numberOfColumns: 4, titleText: '8월'},
		  {startColumnName: 'h9', numberOfColumns: 4, titleText: '9월'},
		  {startColumnName: 'h10', numberOfColumns: 4, titleText: '10월'},
		  {startColumnName: 'h11', numberOfColumns: 4, titleText: '11월'},
		  {startColumnName: 'h12', numberOfColumns: 4, titleText: '12월'}
		]
	});	
}

function getYearList() {

	var s_year = new Date().getFullYear();

	while(true) {
		$('#m_year').append($('<option>', { 
			value: s_year,
	        text : s_year + " 년"
	    }));
		
		if(s_year == "2018") {
			break;	
		}
		s_year =s_year - 1;
	}
}
</script>
</body>
</html>