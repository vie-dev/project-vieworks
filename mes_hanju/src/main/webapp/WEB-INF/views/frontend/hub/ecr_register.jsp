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
  <title><%=pageTitle %></title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
	<jsp:include page="/common/header_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</head>
<style>
#caseByCase .nav-pills > li > a {
  border-radius: 4px 4px 0 0 ;
}

.caseByCase .tab-content {
  border : 1px solid #cccccc;
  padding : 5px 15px;
  border-radius: 0 0 4px 4px ;
}

.nav-pills > li.active > a, .nav-pills > li.active > a:hover, .nav-pills > li.active > a:focus {
	color: #000000;
    background-color: #cccccc;
}
</style>
<body class="hold-transition skin-<%=thema%> sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1020" />
		<jsp:param name="selected_menu_cd" value="1078" />
	</jsp:include>

 <div class="content-wrapper">
	<section class="content-header">
		<h1>
        	HUB <small>ECR 등록 및 조회</small>
		</h1>
      	<ol class="breadcrumb">
        	<li><a href="#"><i class="fa fa-dashboard"></i> HUB</a></li><li class="active">ECR 등록 및 조회</li>
      	</ol>
	</section>
    <!-- Main content -->
	<section class="content">
    	<div class="row">
    		<div class="col-md-3">
    			<div class="box" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title"></h3>
						<div class="box-tools pull-right" style="padding-right: 185px;">
							<select id="werks" class="form-control select2 input-sm" style="width: 100%;" onchange="searchProduct();">
								<option value="">전체</option>
								<option value="1110">의료영상 </option>
								<option value="1210">광영상</option>
							</select>
						</div>
						<div class="box-tools pull-right">
							<div class="input-group input-group-sm" style="width: 150px;float: left;">
								<input type="text" id="s_productNm" name="" class="form-control pull-right" placeholder="product name">
								<div class="input-group-btn">
			                    	<button type="button" id="" class="btn btn-default" onclick="searchProduct();"><i class="fa fa-search"></i></button>
								</div>
			                </div>
							<button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_pd');" data-selfilepath="/upload" data-selfilename="test.xlsx">
							  <span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
							</button>
						</div>
					</div>
					<div class="box-body" style="padding: 0px;">
						<div id="dv_grid_pd" class="box-body" style="padding:0px;">
							<table id="grid_pd"></table>
							<div id="grid_pd_pager"></div>
						</div>
					</div>
				</div>
    		</div>
    		<div class="col-md-9 caseByCase" style="padding-left: 0px;">
    			<ul class="nav nav-pills">
					<li class="active" id="tap1">
						<a href="#case1" data-toggle="tab">등록정보</a>
					</li>
					<li id="tap3">
						<a href="#case3" data-toggle="tab" onclick="">ECR 등록</a>
					</li>
				</ul>
				<div class="tab-content" style="height:733px;">
					<div class="tab-pane active" id="case1">
						<input type="hidden" id="t_gr_no" name="t_gr_no">
						<input type="hidden" id="t_gr_seq" name="t_gr_seq">
						<div class="row"><br><br>
							<div class="col-md-1"></div>
							<div class="col-md-10">
								<table class="table">
									<tr>
										<th class="col-md-3 text-center active">사업부 구분</td>
										<td><div id="t_dept_cd" name="t_dept_cd"></div></td>
									</tr>
									<tr>
										<th class="col-md-3 text-center active">설계변경 번호</td>
										<td><div id="t_ecr_no" name="t_ecr_no"></div></td>
									</tr>
									<tr>
										<th class="col-md-3 text-center active" style="height: 100px;">제품 모델</td>
										<td><p id="t_change_remark" name="t_change_remark"></p></td>
									</tr>
									<tr>
										<th class="col-md-3 text-center active">효력1시작일</td>
										<td><div id="t_confirm_date" name="t_confirm_date"></div></td>
									</tr>
									<tr>
										<th class="col-md-3 text-center active" style="height: 100px;">세부항목</td>
										<td><p id="t_special_note" name="t_special_note"></p></td>
									</tr>
									<tr>
										<th class="col-md-3 text-center active" style="height: 100px;">Information</td>
										<td><p id="t_change_memo" name="t_change_memo"></p></td>
									</tr>	 
								</table>
							</div>
						</div>
					</div><!-- end tab-pane case1 -->
					<div class="tab-pane" id="case2">
						<div class="row">
							<div id="dv_grid_verlist" class="box-body" style="padding:0px;">
								<table id="grid_verlist"></table>
								<div id="grid_verlist_pager"></div>
							</div>
						</div>
					</div><!-- end tab-pane case2 -->
					<div class="tab-pane" id="case3">
						<div class="row">
							<div class="row pull-right" style="padding-right: 20px;">
				                <button type="button" id="btn_gModal_save" class="btn btn-warning btn-sm" onclick="saveEcrInfo();">저장</button>
							</div>
							<br><br>
							<div class="col-md-12">
								<div class="box box-default box-solid">
									<div class="box-header with-border">
										<h3 class="box-title">정보 등록</h3>
									</div>
									<div class="box-body" style="padding: 0px;height: 500px;overflow-y: auto;overflow-x: hidden;">
	<!-- 									<div style="height: 500px;"> -->
										<form id="frm_product" name="frm_product" class="form-horizontal">
											<input type="hidden" id="p_gr_no" name="p_gr_no">
											<input type="hidden" id="p_gr_seq" name="p_gr_seq">
											<div class="form-group">		 
											</div>
											<div class="form-group">			 
											</div>
											<div class="form-group">
											</div>
											<div class="form-group">
											</div>
											<div class="form-group">
												<div class="col-sm-1"></div>
												<label for="p_dept_cd" class="col-sm-2 control-label">사업부 구분</label>
												<div class="col-sm-7">
													<select id="p_dept_cd" name="p_dept_cd" class="form-control input-sm">
														<option value="1110">의료영상</option>
														<option value="1210">광영상</option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-1"></div>
												<label for="p_ecr_no" class="col-sm-2 control-label">설계변경 번호</label>
												<div class="col-sm-5">
													<input type="input" id="p_ecr_no" name="p_ecr_no" class="form-control input-sm" placeholder="">
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-1"></div>
												<label for="p_change_remark" class="col-sm-2 control-label">제품모델<br>
												<font style="font-size: small; color: gray;">(max:40)</font></label>
												<div class="col-sm-7">
													<textarea id="p_change_remark" name="p_change_remark" class="form-control input-sm" rows="3" maxlength="40"></textarea>
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-1"></div>
												<label for="p_confirm_date" class="col-sm-2 control-label">효력시작일시</label>
												<div class="col-sm-5">
													<input type="input" id="p_confirm_date" name="p_confirm_date" class="form-control input-sm text-center" placeholder="input date" maxlength="10">
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-1"></div>
												<label for="p_change_memo" class="col-sm-2 control-label">세부항목<br>
												<font style="font-size: small; color: gray;">(max:40)</font></label>
												<div class="col-sm-7">
													<textarea id="p_change_memo" name="p_change_memo" class="form-control input-sm" rows="3" maxlength="40"></textarea>
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-1"></div>
												<label for="p_special_note" class="col-sm-2 control-label">INFORMATION<br>
												<font style="font-size: small; color: gray;">(max:200)</font></label>
												<div class="col-sm-7">
													<textarea id="p_special_note" name="p_special_note" class="form-control input-sm" rows="3" maxlength="200"></textarea>
												</div>
											</div>
										</form>
									</div><!-- end box-body -->
								</div><!--  end box -->
							</div>
						</div><!--  end row -->
					</div><!-- end tab-pane case3 -->
				</div><!-- end tab content -->
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
	initComponent();
})

function initComponent() {
// 	console.log('initComponent()');
	
	$(window).bind('resize', function() {
		resizeJqGrid("grid_pd", false);
	}).trigger('resize');
	
	$("#p_change_date, #p_confirm_date").datepicker({
		language: "kr",
		todayHighlight: true,
		format: "yyyy.mm.dd",
		autoclose: true
	}).on('changeDate',function(selected){
		 newDate = new Date(selected.date);
		// Extract the current date from Date object
		newDate.setDate(newDate.getDate());
		chDateStr = $.datepicker.formatDate('yymmdd',selected.date);
	});
	
	$("#tap1").click(function(){
		$("#p_ecr_no").val("");
		$("#p_change_remark").text("");
		$("#p_confirm_date").val("");
		$("#p_special_note").text("");
		$("#p_change_memo").text("");
	});
	initScreenSizeModal();
	initGridProduct();
}

// main product grid init
function initGridProduct() {
	console.info('initGridProduct()');
	
	var page_url = "/frontend/hub/ecrMaster_select"
				 + "?aennr=" + encodeURIComponent($("#s_productNm").val()) 
		         + "&werks=" + encodeURIComponent($("#werks").val());
		       
	$("#grid_pd").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['사업부구분','사업부명', '설계변경번호', '제품모델', '효력시작일', '세부항목', 'INFORM','생성자명','수정자명'],// 
		colModel:[
				{ name:'werks', index:'', sorttype:"text", sortable:true, hidden:true },
				{ name:'werks_nm', index:'', sorttype:"text", sortable:true },
				{ name:'aennr', index:'', sorttype:"text", sortable:true },
				{ name:'aetxt', index:'', sorttype:"text", sortable:true, hidden:true},
				{ name:'datuv', index:'', sorttype:"text", sortable:true},
				{ name:'aegru', index:'', sorttype:"text", sortable:true },
				{ name:'ltext', index:'', sorttype:"text", sortable:true, hidden:true},
				{ name:'creator', index:'', sorttype:"text", sortable:true, hidden:true},
				{ name:'updater', index:'', sorttype:"text", sortable:true, hidden:true} ],
		rowNum:50,
// 		rowList : [ 20, 50, 100 ],
// 		pager : "#grid_pd_pager",
	    height: 685,
	    rownumWidth: 25,
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
		altRows: true,
		rownumbers: true, 
	    autoencode: true,
	    loadonce: false,
	    sortable: true,
	    sortorder: 'desc',
	    cellsubmit : 'clientArray',
	    loadComplete : function(data){
// 	    	console.log(data.rows);
	    	if( (data.rows).length>0 )
	    		$("#grid_pd").jqGrid('setSelection', (data.rows)[0].aennr, true);
	    
	    },
		onSelectRow: function(rowid, selected) {
// 			console.log(rowid, selected);
			setGroupData(rowid);
		}
	}); 
// 	$('.ui-jqgrid-hdiv').hide();
}

// row selected -> set data(tab1, tab3)
function setGroupData(rowid) {
	console.log('setGroupData()');
	var rowData = $("#grid_pd").getRowData(rowid);
	// #case1
	var dept_nm = "광영상";
	if( rowData.werks=="1110" )
		dept_nm = "의료영상";
	$("#t_dept_cd").text(dept_nm);
	$("#t_ecr_no").text(rowData.aennr);
	$("#t_change_remark").text(rowData.aetxt);
	$("#t_confirm_date").text(rowData.datuv);
	$("#t_special_note").text(rowData.aegru);
	$("#t_change_memo").text(rowData.ltext);
}

// 제품 이름으로 검색
function searchProduct() {
	console.log('searchProduct()');
	var page_url = "/frontend/hub/ecrMaster_select"
		 + "?aennr=" + encodeURIComponent($("#s_productNm").val()) 
         + "&werks=" + encodeURIComponent($("#werks").val());
      
	$("#grid_pd").jqGrid('setGridParam',{url:page_url, datatype:'json'});
	$("#grid_pd").trigger("reloadGrid");
}

//  ECR INFORM SAVE
function saveEcrInfo() {
	console.log('saveEcrInfo()');
	// master info
	var formData = $("#frm_product").serializeArray();
	var formJson = {};
	$.each(formData, function(idx, comp){
		formJson[comp.name] = comp.value;
	});
	formJson.p_confirm_date = replaceAll(formJson.p_confirm_date, ".", "");
 
	var pageURI = "/frontend/hub/ecrMaster_insert";
	var postData = "masterData=" + encodeURIComponent(JSON.stringify(formJson));
	 
	$.ajax({
		url: pageURI,
		data: postData,
		type: "POST",
		success:function(data, textStatus, jqXHR){
			if(data.status == "200") {
				fnMessageModalAlert("결과", "정보를 성공적으로 추가하였습니다.");
				searchProduct();
			} else {
				fnMessageModalAlert("결과", "정보를 추가하는데 에러가 발생하였습니다.");	
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("결과", "정보를 삭제하는데 에러가 발생하였습니다.");	
		},
		complete: function() {
			searchProduct();
		}
	});
}

//remove new itnbr list
function deleteItnbrDetail() {
	$("#grid_pba").jqGrid('delRowData', $("#grid_pba").getGridParam('selrow'));
}

function excelFileDownload(gridName) {
// 	console.log('excelFileDownload('+gridName+')');
	var tmpArr = [];
	var getColNames = $("#grid_pd").jqGrid('getGridParam','colNames');
	var getColModels = $("#grid_pd").jqGrid('getGridParam','colModel');
	$.each(getColModels, function(idx, mrow){
		if( mrow.hidden==false && getColNames[idx]!='' ) {
			mrow.caption = getColNames[idx]; 
			tmpArr.push(mrow);  
		}
	});
	
	var gridCols = tmpArr;
	var gridData = $("#grid_pd").getRowData();

	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	if( gridName=='grid_pd' ) {
		fileName = 'ECR_목록.xlsx';
		sheetTitle = 'ECR_목록';
		sheetName = 'ECR_목록';
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