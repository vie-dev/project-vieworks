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
            <jsp:param name="selected_menu_cd" value="1106" />
        </jsp:include>

        <div class="content-wrapper">
            <section class="content-header">
                <h1>
					품질관리 <small> 수입검사진행현황(자재,기간별)</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="#"><i class="fa fa-dashboard"></i> 품질관리 </a></li>
                    <li class="active">수입검사진행현황(자재,기간별)</li>
                </ol>
            </section>
            <section class="content">
                <div class="row">
                    <section class="col-lg-12">
                        <div class="box box-success box-solid" style="min-height: 600px;">
                            <div class="box-header with-border">
                            	 <h3 class="box-title">검사내역</h3>
                            	 <div class="box-tools pull-right">
                                    <button type="button" id="btn_search_csr" class="btn btn-primary btn-sm" onclick="fnSearchInspGrid();">조회</button>
                                    <button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_role');" data-selfilepath="/upload" data-selfilename="test.xlsx">
									 	<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
									</button>
                                </div>
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

function fnLoadCommonOption() {

	$(window).bind('resize', function() {
		resizeJqGrid("grid_role", false);
	}).trigger('resize');
	
	initScreenSizeModal();

}

function fnSearchInspGrid() {

	var page_url = "/frontend/qm/import_inspection_m_monthly_state_select";
	
	$("#grid_role").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_role").setGridParam({ page: 1 }).trigger("reloadGrid");
}
	
function fnLoadInspGrid() {
	$("#grid_role").jqGrid({
		datatype : "json",
		colNames : [' ', ' ',
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
			{name : 'dispo',index : 'dispo',width : 130,sorttype : "text",sorttype:'text'},
			{name : 'dsnam',index : 'dsnam',width : 80,sorttype : "text",	sortable : true},
			{name : 'h1',index : 'h1',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'onenow_done_cnt',index : 'onenow_done_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'onenow_pass_cnt',index : 'onenow_pass_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'onepass_rate',index : 'onepass_rate',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'h2',index : 'h2',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'twonow_done_cnt',index : 'twonow_done_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'twonow_pass_cnt',index : 'twonow_pass_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'twopass_rate',index : 'twopass_rate',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'h3',index : 'h3',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'threenow_done_cnt',index : 'threenow_done_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'threenow_pass_cnt',index : 'twonow_pass_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'threepass_rate',index : 'threepass_rate',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'h4',index : 'h4',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'fournow_done_cnt',index : 'fournow_done_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'fournow_pass_cnt',index : 'fournow_pass_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'fourpass_rate',index : 'fourpass_rate',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'h5',index : 'h5',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'fivenow_done_cnt',index : 'fivenow_done_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'fivenow_pass_cnt',index : 'fivenow_pass_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'fivepass_rate',index : 'fivepass_rate',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'h6',index : 'h6',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'sixnow_done_cnt',index : 'sixnow_done_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'sixnow_pass_cnt',index : 'sixnow_pass_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'sixpass_rate',index : 'sixpass_rate',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'h7',index : 'h7',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'sevennow_done_cnt',index : 'sevennow_done_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'sevennow_pass_cnt',index : 'sevennow_pass_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'sevenpass_rate',index : 'sevenpass_rate',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'h8',index : 'h8',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'eightnow_done_cnt',index : 'eightnow_done_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'eightnow_pass_cnt',index : 'eightnow_pass_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'eightpass_rate',index : 'eightpass_rate',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'h9',index : 'h9',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'ninenow_done_cnt',index : 'ninenow_done_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'ninenow_pass_cnt',index : 'ninenow_pass_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'ninepass_rate',index : 'ninepass_rate',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'h10',index : 'h10',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'tennow_done_cnt',index : 'tennow_done_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'tennow_pass_cnt',index : 'tennow_pass_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'tenpass_rate',index : 'tenpass_rate',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'h11',index : 'h11',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'elevennow_done_cnt',index : 'elevennow_done_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'elevennow_pass_cnt',index : 'elevennow_pass_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'elevenpass_rate',index : 'elevenpass_rate',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'h12',index : 'h12',width : 80,sorttype : "text", sortable : true, hidden:true},
			{name : 'twelvenow_done_cnt',index : 'twelvenow_done_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'twelvenow_pass_cnt',index : 'twelvenow_pass_cnt',width : 60, align:"right", sorttype:'text',formatter:'text' },
			{name : 'twelvepass_rate',index : 'twelvepass_rate',width : 60, align:"right", sorttype:'text',formatter:'text' },
		],
		rowNum:-1,
		viewrecords : true,
		autowidth : true,
		shrinkToFit : false,
		multiselect : false,
		height : 600,
		altRows : true,
		rownumbers : true,
		rownumWidth : 25,
		autoencode : true,
		loadonce : true,
		sortable : false,
		cellEdit:true,

	    onSelectRow : function(rowid, selected) {	
		},
		loadComplete : function(data) {
			console.log(data);

			if(data.rows.length > 0) {
				var onenow_done_cnt = 0;
				var onenow_pass_cnt = 0;
				var twonow_done_cnt = 0;
				var twonow_pass_cnt = 0;
				var threenow_done_cnt = 0;
				var threenow_pass_cnt = 0;
				var fournow_done_cnt = 0;
				var fournow_pass_cnt = 0;
				var fivenow_done_cnt = 0;
				var fivenow_pass_cnt = 0;
				var sixnow_done_cnt = 0;
				var sixnow_pass_cnt = 0;
				var sevennow_done_cnt = 0;
				var sevennow_pass_cnt = 0;
				var eightnow_done_cnt = 0;
				var eightnow_pass_cnt = 0;
				var ninenow_done_cnt = 0;
				var ninenow_pass_cnt = 0;
				var tennow_done_cnt = 0;
				var tennow_pass_cnt = 0;
				var elevennow_done_cnt = 0;
				var elevennow_pass_cnt = 0;
				var twelvenow_done_cnt = 0;
				var twelvenow_pass_cnt = 0;

				
				var test = {};
				for(var i=0 ; i<data.rows.length; i++) {
		
					onenow_done_cnt     = onenow_done_cnt     + Number(data.rows[i].onenow_done_cnt);
					onenow_pass_cnt	    = onenow_pass_cnt	  + Number(data.rows[i].onenow_pass_cnt);
					twonow_done_cnt     = twonow_done_cnt     + Number(data.rows[i].twonow_done_cnt);
					twonow_pass_cnt     = twonow_pass_cnt     + Number(data.rows[i].twonow_pass_cnt);
					threenow_done_cnt   = threenow_done_cnt   + Number(data.rows[i].threenow_done_cnt);
					threenow_pass_cnt   = threenow_pass_cnt   + Number(data.rows[i].threenow_pass_cnt);
					fournow_done_cnt    = fournow_done_cnt    + Number(data.rows[i].fournow_done_cnt);
					fournow_pass_cnt    = fournow_pass_cnt    + Number(data.rows[i].fournow_pass_cnt);
					fivenow_done_cnt    = fivenow_done_cnt    + Number(data.rows[i].fivenow_done_cnt);
					fivenow_pass_cnt    = fivenow_pass_cnt    + Number(data.rows[i].fivenow_pass_cnt);
					sixnow_done_cnt     = sixnow_done_cnt     + Number(data.rows[i].sixnow_done_cnt);
					sixnow_pass_cnt     = sixnow_pass_cnt     + Number(data.rows[i].sixnow_pass_cnt);
					sevennow_done_cnt   = sevennow_done_cnt   + Number(data.rows[i].sevennow_done_cnt);
					sevennow_pass_cnt   = sevennow_pass_cnt   + Number(data.rows[i].sevennow_pass_cnt);    
					eightnow_done_cnt   = eightnow_done_cnt   + Number(data.rows[i].eightnow_done_cnt);    
					eightnow_pass_cnt   = eightnow_pass_cnt   + Number(data.rows[i].eightnow_pass_cnt);    
					ninenow_done_cnt    = ninenow_done_cnt    + Number(data.rows[i].ninenow_done_cnt);     
					ninenow_pass_cnt    = ninenow_pass_cnt    + Number(data.rows[i].ninenow_pass_cnt);     
					tennow_done_cnt     = tennow_done_cnt     + Number(data.rows[i].tennow_done_cnt);      
					tennow_pass_cnt     = tennow_pass_cnt     + Number(data.rows[i].tennow_pass_cnt);
					elevennow_done_cnt  = elevennow_done_cnt  + Number(data.rows[i].elevennow_done_cnt);   
					elevennow_pass_cnt  = elevennow_pass_cnt  + Number(data.rows[i].elevennow_pass_cnt);   
					twelvenow_done_cnt = twelvenow_done_cnt + Number(data.rows[i].twelvenow_done_cnt);  
					twelvenow_pass_cnt	= twelvenow_pass_cnt  + Number(data.rows[i].twelvenow_pass_cnt);
					
				}
				test.dispo = '-';
				test.dsnam = '합계 (' + data.rows.length + ')';

				test.onenow_done_cnt    = onenow_done_cnt;
				test.onenow_pass_cnt    = onenow_pass_cnt;
				test.twonow_done_cnt    = twonow_done_cnt;
				test.twonow_pass_cnt    = twonow_pass_cnt;
				test.threenow_done_cnt  = threenow_done_cnt;
				test.threenow_pass_cnt  = threenow_pass_cnt;
				test.fournow_done_cnt   = fournow_done_cnt;
				test.fournow_pass_cnt   = fournow_pass_cnt;
				test.fivenow_done_cnt   = fivenow_done_cnt;
				test.fivenow_pass_cnt   = fivenow_pass_cnt;
				test.sixnow_done_cnt    = sixnow_done_cnt;
				test.sixnow_pass_cnt    = sixnow_pass_cnt;
				test.sevennow_done_cnt  = sevennow_done_cnt;
				test.sevennow_pass_cnt  = sevennow_pass_cnt;
				test.eightnow_done_cnt  = eightnow_done_cnt;
				test.eightnow_pass_cnt  = eightnow_pass_cnt;
				test.ninenow_done_cnt   = ninenow_done_cnt;
				test.ninenow_pass_cnt   = ninenow_pass_cnt;
				test.tennow_done_cnt    = tennow_done_cnt;
				test.tennow_pass_cnt    = tennow_pass_cnt;
				test.elevennow_done_cnt = elevennow_done_cnt;
				test.elevennow_pass_cnt = elevennow_pass_cnt;
				test.twelvenow_done_cnt= twelvenow_done_cnt;
				test.twelvenow_pass_cnt	= twelvenow_pass_cnt;
				
				test.onepass_rate    = "";
				test.twopass_rate    = "";
				test.threepass_rate  = "";
				test.fourpass_rate   = "";
				test.fivepass_rate   = "";
				test.sixpass_rate    = "";
				test.sevenpass_rate  = "";
				test.eightpass_rate  = "";
				test.ninepass_rate   = "";
				test.tenpass_rate    = "";
				test.elevenpass_rate = "";
				test.twelvepass_rate = "";
	
				$('#grid_role').addRowData("addRow", test);
				
				$("#grid_role").setRowData("addRow", false, { background:"#BDBDBD" });
			}
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
		fileName = '수입검사진행현황(자재,기간별).xlsx';
		sheetTitle = '수입검사진행현황(자재,기간별)';
		sheetName = '수입검사진행현황(자재,기간별)';
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
</script>
</body>
</html>