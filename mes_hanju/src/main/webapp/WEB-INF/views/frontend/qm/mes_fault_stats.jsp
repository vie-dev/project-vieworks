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
            <jsp:param name="selected_menu_cd" value="1114" />
        </jsp:include>

        <div class="content-wrapper">
            <section class="content-header">
                <h1>
					품질관리 <small> 자재불량집계</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="#"><i class="fa fa-dashboard"></i> 품질관리 </a></li>
                    <li class="active">자재불량집계</li>
                </ol>
            </section>
            <section class="content">
                <div class="row">
                    <section class="col-lg-12">
                        <div class="box box-success box-solid" style="min-height: 70px;">
                            <div class="box-header with-border">
                                <h3 class="box-title">조회조건</h3>
                                <div class="box-tools pull-right">
                                	<button type="button" id="btn_excel_export" class="btn btn-success btn-sm grid_attach_down" onclick="excelFileDownload('grid_mst');">Excel</button>
                                    <button type="button" id="btn_search_csr" class="btn btn-primary btn-sm" onclick="fnSearchMstGrid();">조회</button>
                                </div>
                            </div>
                            <div id="" class="box-body">
                                <div class="row">
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>투입일</label> 
                                            <div class="input-group">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <input type="text" class="form-control pull-right input-sm" id="input_date_range" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>품목</label>
                                           	<input type="input" id=s_matnr name="s_matnr" class="form-control input-sm" placeholder="" maxlength="30"> 
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>품목명</label> 
                                           	<input type="input" id="s_maktx" name="s_maktx" class="form-control input-sm" placeholder="" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>자재그룹</label> 
                                           	<input type="input" id="s_wgbez" name="s_wgbez" class="form-control input-sm" placeholder="" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                        	<label>플랜트</label> 
                                        	<select id="plant" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
<!-- 												<option value="">전체</option> -->
												<option value="1110">의료</option>
												<option value="1210">광</option>
											</select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box box-default box-solid" style="min-height: 420px;">
                            <div class="box-header with-border">
                            	 <h3 class="box-title">자재불량 발생 현황</h3>
                            </div>
                            <div class="box-body">
                            	<div class="row">
									<div class="col-md-12">
										<div id="grid_mst" style="width: 100%; height: 415px;"></div>
									</div>
								</div>
                            </div>
                        </div>
                        <div class="box box-default box-solid" style="min-height: 120px;">
                            <div class="box-header with-border">
                            	 <h3 class="box-title">자재불량 상세 현황</h3>
                            </div>
                            <div class="box-body">
								<div class="row">
									<div class="col-md-12">
										<div id="grid_dtl" style="width: 100%; height: 115px;"></div>
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
var member_id = "<%=member_id%>";
var member_nm = '<%=member_nm%>';
var member_emp_no = '<%=member_emp_no%>';
var g_cSty = 'text-align:right;background-color:rgba(118, 117, 132, 0.2);'; // white-gray
var y_cSty = 'text-align:right;background-color:rgba(255,187,0,0.32);';
var cSty = 'text-align:right;';

$(function($) {
	fnLoadCommonOption();
	fnLoadMstGrid();
	fnLoadDtlGrid();
});



$('#plant').change(function() {
});

function fnLoadCommonOption() {
	$( "#input_date_range" ).daterangepicker({
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

function fnLoadMstGrid(){
// 	console.log('fnLoadRoleGrid()');
	$("#grid_mst").w2grid({
		name : 'grid_mst',
		show : {
			lineNumbers : true,
// 			selectColumn: true,
            footer: true
        },        
        columns : [
			{ field:'matnr', caption:'품목코드', size:'130px'},
			{ field:'maktx', caption:'품목명', size:'130px'},
			{ field:'wrkst', caption:'Spec', size:'130px'},
			{ field:'wgbez', caption:'자재그룹', size:'130px'},
			{ field:'i_bdmng', caption:'투입수량', size:'130px', style:g_cSty},
			{ field:'f_bdmng', caption:'불량수량', size:'130px', style:g_cSty},
			{ field:'fault_rate', caption:'불량률', size:'130px', style:g_cSty},
			{ field:'f_r_bdmng', caption:'원자재불량', size:'130px', style:y_cSty},
			{ field:'f_r_rate', caption:'원자재불량률', size:'130px', style:y_cSty},
			{ field:'f_o_bdmng', caption:'작업불량수', size:'130px', style:y_cSty},
			{ field:'f_o_rate', caption:'작업불량률', size:'130px', style:y_cSty},
			],
		sortData: [{field:'matnr', direction: 'ASC'}],
		records: [],
		total : 0,
		onReload: function(event) {},
		onClick: function (event) {
			event.onComplete = function () {
				var sel = this.getSelection();
		         if (sel.length >= 1 && sel[0] == event.recid) {
		        	 var gridCols = w2ui['grid_dtl'].columns;
		        	 var bb = {};
		        	 bb.cnt = gridCols.length;
	   	 
		        	 
						for(var i=0 ; i<bb.cnt; i++) {
							w2ui['grid_dtl'].removeColumn(gridCols[0].field);	
						}
		        	 var selection = w2ui.grid_mst.getSelection();
		        	 var selectData = w2ui.grid_mst.get(selection);
		        	 fnSearchDtlGrid(selectData[0].matnr);
		         }
			}
		},
		onDblClick: function (event) {
		}
	});
	w2ui.grid_mst.recordHeight = 30;
}

function fnLoadDtlGrid(){
	$("#grid_dtl").w2grid({
		name : 'grid_dtl',
		show : {
			lineNumbers : true,
// 			selectColumn: true,
            footer: true
        },        
        columns : [
			{ field:'matnr', caption:'품목코드', size:'130px'},
			{ field:'maktx', caption:'품목명', size:'130px'},
			{ field:'i_bdmng', caption:'투입수량', size:'130px'},
			{ field:'f_bdmng', caption:'불량수량', size:'130px'},
			],
		sortData: [{field:'fault_no', direction: 'ASC'}],
		records: [],
		total : 0,
		onReload: function(event) {},
		onClick: function (event) {
		},
		onDblClick: function (event) {
		}
	});
	w2ui.grid_dtl.recordHeight = 30;
}

function fnSearchMstGrid(){
	w2ui['grid_mst'].selectNone();
	w2ui['grid_dtl'].clear();
	
	var i_f_date = replaceAll($("#input_date_range").val().substring(0,10),'-','');
	var i_t_date = replaceAll($("#input_date_range").val().substring(13,23),'-','');
	
	var f_f_date = replaceAll($("#input_date_range").val().substring(0,10),'-','');
	var f_t_date = replaceAll($("#input_date_range").val().substring(13,23),'-','');
	 
	var page_url = "/frontend/qm/fault_stats_mst_data"
				 + "?i_f_date="  + encodeURIComponent(i_f_date)
				 + "&i_t_date=" + encodeURIComponent(i_t_date)
				 + "&f_f_date=" + encodeURIComponent(f_f_date)
				 + "&f_t_date=" + encodeURIComponent(f_t_date)
				 + "&matnr=" + encodeURIComponent($("#s_matnr").val())
				 + "&maktx=" + encodeURIComponent($("#s_maktx").val())
				 + "&wgbez=" + encodeURIComponent($("#s_wgbez").val())
				 + "&werks="+  encodeURIComponent($("#plant").val());  
	
	w2ui['grid_mst'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST', 
		dataType : 'json',
		async:false,
		success : function( data ) {
			if(data.status == 200) {
				if((data.rows).length>0) {
					var grid = 'grid_mst';
					var records = data.rows;
					var totArrObj = {w2ui: { summary: true}, recid: 'S-1'};
					var cols = w2ui[grid].columns;	
					var fields = [];
					$.each( cols, function(idx, col){
						fields.push(col.field);
						totArrObj[col.field] = null;
					});
					w2ui[grid].clear();
					w2ui[grid].records = records;
					
					$.each(records, function(idx, row){
						row.recid = idx+1;
						$.each(fields, function(idx, field){
							if( idx==4 || idx==5 || idx==7 || idx==9  ) {
								totArrObj[field] += row[field]*1;
							}
							if((row[field] == null?'':row[field]).length == 0) {
								row[field] = '-';
							}
						});
					});
					totArrObj['matnr'] = '합       계';
					w2ui[grid].records.push(totArrObj);
					w2ui[grid].total = records.length+1;
					w2ui[grid].resize();				
					
				} else {
					w2ui['grid_mst'].clear();
				}
			} 
			w2ui['grid_mst'].refresh();
			w2ui['grid_mst'].unlock();
		},
		complete: function () {
			
		}
	});
}

function fnSearchDtlGrid(p_matnr){
	w2ui['grid_dtl'].clear();

	var f_f_date = replaceAll($("#input_date_range").val().substring(0,10),'-','');
	var f_t_date = replaceAll($("#input_date_range").val().substring(13,23),'-','');
	var page_url = "/frontend/qm/fault_stats_dtl_data"
				 + "?f_f_date=" + encodeURIComponent(f_f_date)
				 + "&f_t_date=" + encodeURIComponent(f_t_date)
				 + "&werks="+  encodeURIComponent($("#plant").val())
				 + "&matnr="+  encodeURIComponent(p_matnr);
	
	w2ui['grid_dtl'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST', 
		dataType : 'json',
		async:false,
		success : function( data ) {
			if(data.status == 200) {
				if((data.rows).length>0) {
					var rowArr = data.rows;
					
				 	var gridCols = 	w2ui['grid_dtl'].columns;
		        	var tmp = {};
		        	tmp.cnt = gridCols.length;
				 	for(var i=0 ; i<tmp.cnt; i++) {
				 		w2ui['grid_dtl'].removeColumn(gridCols[i].field);	
				 	}
				 	
				 	if(rowArr.length != 0) {
				 		var selection = w2ui.grid_mst.getSelection();
				 		var selectData = w2ui.grid_mst.get(selection);
					
				 		var rtnArr_1 = [];
				 		var rtnObj_1 = {};
						
				 		w2ui['grid_dtl'].addColumn({ field:'matnr', caption:'품목코드', size:'130px'});
						w2ui['grid_dtl'].addColumn({ field:'maktx', caption:'품목명', size:'130px'});
						w2ui['grid_dtl'].addColumn({ field:'i_bdmng', caption:'투입수량', size:'130px', style:cSty});
						w2ui['grid_dtl'].addColumn({ field:'f_bdmng', caption:'불량수량', size:'130px', style:cSty});
						
				 		for(var i=0 ; i<rowArr.length; i++) {
				 			w2ui['grid_dtl'].addColumn({ field: rowArr[i].level2_code, caption: "유형 - " + rowArr[i].level2_name, size: '130px', style:cSty });
				 		}
				 		
				 		for(var i=0 ; i<rowArr.length; i++) {
				 			rtnObj_1[rowArr[i].level2_code] = rowArr[i].bdmng;  
				 		}
					
				 		rtnObj_1["matnr"] = selectData[0].matnr;
				 		rtnObj_1["maktx"] = selectData[0].maktx;
				 		rtnObj_1["i_bdmng"] = selectData[0].i_bdmng;
				 		rtnObj_1["f_bdmng"] = selectData[0].f_bdmng;
						 
				 		rtnArr_1.push(rtnObj_1);
				 		rtnArr_1.recid = 1;
					
				 		var rtnArr_2 = [];
				 		var rtnObj_2 = {};
				 		
				 		rtnObj_2["f_bdmng"] = "100.00%";
				 		for(var i=0 ; i<rowArr.length; i++) {
				 			rtnObj_2[rowArr[i].level2_code] = (Number(rowArr[i].bdmng)/Number(selectData[0].f_bdmng) *100).toFixed(2) + "%";  
				 		}
				 		rtnArr_2.push(rtnObj_2);
				 		rtnArr_2.recid = 2;
				 		
				 		total_arr = rtnArr_1.concat(rtnArr_2);
				 		w2ui['grid_dtl'].records = total_arr;
				 		
				 		////////////
// 				 		w2ui['grid_dtl'].columnGroups = [
// 						    { span: 1, caption: '', master: true },
// 						    { span: 1, caption: '', master: true },
// 						    { span: 1, caption: '', master: true },
// 						    { span: 1, caption: '', master: true },
// 						    { span: rowArr.length, caption: '용도' },
// 						];
				 		////////////
				 		w2ui['grid_dtl'].refresh();
				 		w2ui['grid_dtl'].unlock();
				 	}
				} else {
					w2ui['grid_dtl'].clear();
					w2ui['grid_dtl'].refresh();
					w2ui['grid_dtl'].unlock();
				}
			} 
		},
		complete: function () {}
	});
}

function excelFileDownload(gridName) {
	var gridCols = w2ui[gridName].columns;
	var gridData = w2ui[gridName].records;
	
	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	if( gridName=='grid_mst' ) {
		fileName = '자재불량집계.xlsx';
		sheetTitle = '자재불량집계';
		sheetName = '자재불량집계';
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
// 				if( gridName=='gridProc' && (caption=='요청수량' || caption=='요청일자' || caption=='분기 미승인' )){
// 					param_col_name += "," + caption + '(*)';
// 				}else if( gridName=='gridSernr' && caption=='순차관리번호' ){
// 					param_col_name += "," + caption + '(*)';
// 				}else if( gridName=='gridProcSubSernr' && caption=='순차관리번호' ){
// 					param_col_name += "," + caption + '(*)';
// 				}else{
					param_col_name += "," + caption;
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



function issueValidChk(jsonStr) {
	var rtn_data = 0;
	var page_url = "/frontend/qm/issueValidChk";
	var postData = "jsonStr="  + encodeURIComponent(jsonStr);

	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async:false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				rtn_data = data.result
			} else {
				fnMessageModalAlert("Error", "이슈코드 마스터 데이터를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "이슈코드 마스터 데이터를 가져오지 못했습니다.");
		}
	});
	
	return rtn_data;
}

</script>
</body>
</html>