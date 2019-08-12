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
<style>
#caseByCase .nav-pills > li > a {
  border-radius: 4px 4px 0 0 ;
}

#caseByCase .tab-content {
  border : 1px solid #cccccc;
  padding : 5px 15px;
  border-radius: 0 0 4px 4px ;
}

.nav-pills > li.active > a, .nav-pills > li.active > a:hover, .nav-pills > li.active > a:focus {
	color: #000000;
    background-color: #cccccc;
}
</style>
<body class="hold-transition skin-green-light sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1010" />
		<jsp:param name="selected_menu_cd" value="1063" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        MES
        <small>자재이동요청</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> MES</a></li><li class="active">소요자재조회</li>
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
								<button type="button" id="btn_search"			
									class="btn btn-primary btn-sm" onclick="fnSearchMatRequirementGrid();">조회</button>
								<button type="button" id="btn_search_init"
									class="btn btn-primary btn-sm" onclick="test();">조건초기화</button>
							</div>
						</div>
						<div id="" class="box-body">
							<div class="row">
								<div class="col-sm-2">
									<div class="form-group">
										<label>| 자재소요계획일자</label>
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input type="text" class="form-control pull-right"
												id="decide_date_range">
										</div>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group">
										<label>| Plant 구분</label><br />
										<label> <input type="radio" name="rdo_plant_type"
											class="flat-red" value="1110" checked> 의료
										</label> <label> <input type="radio" name="rdo_plant_type"
											class="flat-red" value="1210"> 광
										</label>
									</div>
								</div>
<!-- 								<div class="col-sm-2"> -->
<!-- 									<div class="form-group"> -->
<!-- 										<label>| 요청여부</label><br /> <label> <input type="radio" -->
<!-- 											name="rdo_req_type" class="flat-red" value="" checked> -->
<!-- 											전체  -->
<!-- 										</label> <label> <input type="radio" name="rdo_req_type" -->
<!-- 											class="flat-red" value="Y"> 요청 -->
<!-- 										</label> <label> <input type="radio" name="rdo_req_type" -->
<!-- 											class="flat-red" value="N"> 미요청 -->
<!-- 										</label> -->
<!-- 									</div> -->
<!-- 								</div> -->
								<div class="col-sm-3">
									<div class="form-group">
										<label>| 요청수량여부</label><br /> <label> <input type="radio"
											name="rdo_req_cnt" class="flat-red" value="" checked>
											전체 
										</label> <label> <input type="radio" name="rdo_req_cnt"
											class="flat-red" value="n_zero"> 요청수량 있음
										</label> <label> <input type="radio" name="rdo_req_cnt"
											class="flat-red" value="y_zero"> 요청수량 없음
										</label>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="form-group">
										<label>| To 창고</label><br />
										<div class="input-group">
											<select id="s_str" class="form-control" data-placeholder="유형 선택" style="width: 100%;">
											</select>
										</div>
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
									<h3 class="box-title" style="margin-right: 50px;">자재소요량</h3>
									<span id="infoTxt" style="font-weight:bold; color:red;"></span>
									<div class="box-tools pull-right">
										<button type="button" id="btn_search" class="btn btn-primary btn-sm" onclick="fnRequestMatRequirement();">요청</button>
										<button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_mat_requirement');" data-selfilepath="/upload" data-selfilename="test.xlsx">
										 	<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
										</button>		
									</div>
								</div>
								<div id="dv_grid_mat_requirement" class="box-body">
									<table id="grid_mat_requirement"></table>
<!-- 									<div id="grid_mat_requirement_pager"></div> -->
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">PO 리스트</h3>
								</div>
								<div id="dv_grid_po_list" class="box-body">
									<table id="grid_po_list"></table>
									<div id="grid_po_list_pager"></div>
								</div>
							</div>
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">PO별 소요 자재량</h3>
								</div>
								<div id="dv_grid_po_mat" class="box-body">
									<table id="grid_po_mat"></table>
									<div id="grid_po_mat_pager"></div>
								</div>
							</div>
						</div>
					</div>
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
var mainKey;
var newDate;
var arrtSetting = function (rowId, val, rawObject, cm) {
    var attr = rawObject.attr[cm.name], result;
    if (attr.rowspan) {
        result = ' rowspan=' + '"' + attr.rowspan + '"';
    } else if (attr.display) {
        result = ' style="display:' + attr.display + '"';
    }
    return result;
};


$(function($) {
	fnLoadCommonOption();
	fnDateInit();
	fnLoadMatRequirementGrid();
	fnLoadPoListGrid();
	fnLoadPoMatGrid();
	initScreenSizeModal();
	getStrList();
	
	$(':radio[name="rdo_plant_type"]').change(function(){
		getStrList();
	});
	
})

function test(){
	var gridData = $('#grid_mat_requirement').jqGrid('getRowData');
	var columnNames = $("#grid_mat_requirement").jqGrid('getGridParam','colNames')
	
	for (var i = 0; i < gridData.length; i++) {
// 		console.log(gridData[i].matnr);
			$('#grid_mat_requirement').jqGrid('setCell', gridData[i].matnr, 'werks', ' ');
	}
}
// search component setting
function fnLoadCommonOption() {
// 	console.info('fnLoadCommonOption()');
	$(window).bind('resize', function() {
		resizeJqGrid("grid_mat_requirement", false);
		resizeJqGrid("grid_po_list", false);
		resizeJqGrid("grid_po_mat", false);
	}).trigger('resize');

	$('#decide_date_range').daterangepicker({
		 locale: {
			format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
			,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			,dayNames : ['일', '월', '화', '수', '목', '금', '토']
			,dayNamesShort : ['일', '월', '화', '수', '목', '금', '토']
			,dayNamesMin : ['일', '월', '화', '수', '목', '금', '토']
			,showMonthAfterYear: true
			,yearSuffix: '년'
			,orientation: "top left"
	    }
	});	
}


function fnLoadMatRequirementGrid(){
		
	$("#grid_mat_requirement").jqGrid({
		datatype : "json",
// 		colNames : ['idx', '품번', '자재명', '플랜트', '저장위치', '소요일자', '소요량', '단위', 'From', 'To', '등급', '재고수량', '요청수량', 'lgfsb', 'lgpro'],
// 		colModel : [
// 					{name : 'idx',index : 'idx',width : 20,sorttype : "int", hidden:true, key : true },
// 		            {name : 'matnr',index : 'matnr',width : 20,sorttype : "text", cellattr: arrtSetting}, 
// 		            {name : 'maktx',index : 'maktx',width : 20,sorttype : "text", cellattr: arrtSetting}, 
// 		            {name : 'werks',index : 'werks',width : 10,sorttype : "text", cellattr: arrtSetting, hidden: true }, 
// 		            {name : 'lgort',index : 'lgort',width : 20,sorttype : "text", cellattr: arrtSetting, hidden: true},					            
// 		            {name : 'bdter',index : 'bdter',width : 20, sorttype : "text", cellattr: arrtSetting, hidden: true},
// 		            {name : 'bdmng',index : 'bdmng',width : 10,sorttype : "text", cellattr: arrtSetting}, 
// 		            {name : 'meins',index : 'meins',	width : 10,sorttype : "text", cellattr: arrtSetting, hidden: true},		
// 		            {name : 'lgobe_lgfsb',index : 'lgobe_lgfsb',width : 20, sorttype : "text", hidden: true},
// 		            {name : 'lgobe_lgpro',index : 'lgobe_lgpro',width : 20, sorttype : "text", hidden: false},
// 		            {name : 'grade',index : 'grade',	width : 15,sorttype : "text"},		
// 		            {name : 'labst',index : 'labst',	width : 20,sorttype : "text"},		
// 		            {name : 'request_bdmng',index : 'request_bdmng',	width : 20,sorttype : "text", editable:true},    
// 		            {name : 'lgfsb',index : 'lgfsb',	width : 20,sorttype : "text", hidden: true},    
// 		            {name : 'lgpro',index : 'lgpro',	width : 20,sorttype : "text", hidden: true}    
// 		            ],

		colNames : ['idx', '품번', '자재명', '등급', 'To', 'To창고 재고수량', '소요량', '플랜트', '저장위치', '소요일자', '단위', 'From', '요청수량', 'lgfsb', 'lgpro'],
		colModel : [
					{name : 'idx',index : 'idx',width : 20,sorttype : "int", hidden:true, key : true },
		            {name : 'matnr',index : 'matnr',width : 20,sorttype : "text", cellattr: arrtSetting}, 
		            {name : 'maktx',index : 'maktx',width : 20,sorttype : "text", cellattr: arrtSetting}, 
		            {name : 'grade',index : 'grade',	width : 15,sorttype : "text"},
		            {name : 'lgobe_lgpro',index : 'lgobe_lgpro',width : 20, sorttype : "text", hidden: false},
		            {name : 'labst',index : 'labst',	width : 20,sorttype : "text"},
		            {name : 'bdmng',index : 'bdmng',width : 10,sorttype : "text", cellattr: arrtSetting},
		            {name : 'werks',index : 'werks',width : 10,sorttype : "text", cellattr: arrtSetting, hidden: true }, 
		            {name : 'lgort',index : 'lgort',width : 20,sorttype : "text", cellattr: arrtSetting, hidden: true},					            
		            {name : 'bdter',index : 'bdter',width : 20, sorttype : "text", cellattr: arrtSetting, hidden: true},
		            {name : 'meins',index : 'meins',	width : 10,sorttype : "text", cellattr: arrtSetting, hidden: true},		
		            {name : 'lgobe_lgfsb',index : 'lgobe_lgfsb',width : 20, sorttype : "text", hidden: true},
		            {name : 'request_bdmng',index : 'request_bdmng',	width : 20,sorttype : "text", editable:true},
		            {name : 'lgfsb',index : 'lgfsb',	width : 20,sorttype : "text", hidden: true},    
		            {name : 'lgpro',index : 'lgpro',	width : 20,sorttype : "text", hidden: true}    
		            ],
		rowNum : 10000,
		cmTemplate: {sortable: false},
		viewrecords : true,
		autowidth : true,
		shrinkToFit : true,
		multiselect : true,
		height : 640,
		altRows : true,
		rownumbers : true,
		rownumWidth : 25,
		autoencode : true,
		loadonce : true,
		sortable : true,
		sortname: 'idx',
		cellEdit:true,
	    cellsubmit : 'clientArray',					    
		loadComplete : function(data) {
			console.log(data);
		},
		afterEditCell: function(id,name,val,iRow,iCol){
			  $("#"+iRow+"_"+name).bind('blur',function(){
				$('#grid_mat_requirement').saveCell(iRow,iCol);
				//$("#grid_mat_requirement").jqGrid('editCell',1,12,true);
					//$("#grid_mat_requirement").jqGrid('editCell',iRow+1,12,true);
			  });
		}
	});
}

function fnSearchPoss(){
	
	var fDate = $("#decide_date_range").val().substring(0,10);
	var tDate = $("#decide_date_range").val().substring(13,23);
	fDate = replaceAll(fDate, "-", "");
	tDate = replaceAll(tDate, "-", "");
	
	var page_url = "/frontend/prod/sap_prod_select"
		 + "?jidat_from=" + encodeURIComponent(fDate)
		 + "&jidat_to=" + encodeURIComponent(tDate)
		 + "&pdsts=" + encodeURIComponent('p2')
		 + "&dept_cd=" + encodeURIComponent($(':radio[name="rdo_plant_type"]:checked').val())
		
	$("#grid_po_list").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_po_list").setGridParam({ page: 1 }).trigger("reloadGrid");
}


function fnLoadPoListGrid(){
	var page_url = "";
	
	$("#grid_po_list").jqGrid({
		url : page_url,
		datatype : "json",
		colNames : [ '확정', '지시번호', '지시일', '상태', '시리얼' ],
		colModel : [
		            {name : 'pdsts',index : 'pdsts',width : 10,sorttype : "text",	sortable : true}, 
		            {name : 'pordno',index : 'pordno',width : 20,sorttype : "text",sortable : true,key : true}, 
		            {name : 'jidat',index : 'jidat',width : 20,sorttype : "text",sortable : true},
		            {name : 'pordno_status',index : 'pordno_status',width : 50,sorttype : "text",sortable : true}, 
		            {name : 'project_no',index : 'project_no',	width : 50,sorttype : "text",	sortable : true}, ],
		pager : "#grid_po_list_pager",
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		viewrecords : true,
		autowidth : true,
		shrinkToFit : true,
		multiselect : false,
		height : 200,
		altRows : true,
		rownumbers : true,
		rownumWidth : 25,
		autoencode : true,
		loadonce : true,
		sortable : true,
		sortname: 'pordno',
		onSelectRow : function(rowid, selected) {
			if (rowid != null) {					
				fnSearchPoMatGrid(rowid);
			}
		},
		loadComplete : function() {
		}
	});
}

function fnLoadPoMatGrid(){
	var page_url = "";

	$('#grid_po_mat').jqGrid({
		url:page_url,
		datatype: 'json',
		colNames:['자재','소요량','단위','일련번호 프로파일', '예약품목번호', '생산오더번호'],
		colModel:[
			{name:'matnr',index:'matnr', width:100, sorttype:'text', sortable:true, key: true},
			{name:'bdmng', index:'bdmng', width:100, sorttype:'text', sortable:true},
			{name:'meins',index:'meins', width:100, sorttype:'text', sortable:true, sortable:true},
			{name:'sernp',index:'sernp', width:100, sorttype:'text', sortable:true, hidden:false},
			{name:'rspos',index:'rspos', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true},
			{name:'aufnr',index:'aufnr', width:0, sorttype:'text', sortable:true, sortable:true, hidden:true}
		],
		pager : '#grid_po_mat_pager',
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		viewrecords : true,
		autowidth : true,
		shrinkToFit: true, 
		multiselect : false,
		height: 200,
		altRows: true,
		rownumbers: true, 
		rownumWidth: 25,
		autoencode: true,
		loadonce: true,
		sortable: true,
		sortname: 'matnr',
		loadComplete : function(data) {}
	});
}

function fnSearchPoMatGrid(rowid){
	var page_url = "/sap_master/ziffm_mes_pp004"
		 + "?func_name=" + encodeURIComponent("ZIFFM_MES_PP004")
		 + "&IV_AUFNR=" + encodeURIComponent(rowid)
		 + "&IV_IF=X";
		
	$("#grid_po_mat").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_po_mat").setGridParam({ page: 1 }).trigger("reloadGrid");
}

function fnDateInit() {
// 	var minDate = getFormatDate(new Date()); 
// 	var mdTemp = new Date();
// 	var maxDate = getFormatDate(new Date(mdTemp.setDate(mdTemp.getDate() + 30)));

	var mdTemp = new Date();
	var minDate = getFormatDate(new Date(mdTemp.setDate(mdTemp.getDate() - (mdTemp.getDay()-1))));
	mdTemp = new Date();
	var maxDate = getFormatDate(new Date(mdTemp.setDate(mdTemp.getDate() +(5-mdTemp.getDay()))));
	$("#decide_date_range").val(minDate + " - " + maxDate);
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

function fnSearchMatRequirementGrid(){
	$('#infoTxt').text('데이터 로딩 중입니다...');
	$('#grid_mat_requirement').jqGrid('clearGridData');
	$("#grid_po_mat").jqGrid('clearGridData');
	$("#grid_req_detail").jqGrid('clearGridData');
	
	var fDate = $("#decide_date_range").val().substring(0,10);
	var tDate = $("#decide_date_range").val().substring(13,23);
	fDate = replaceAll(fDate, "-", "");
	tDate = replaceAll(tDate, "-", "");
	
	var page_url = "/frontend/prod/matrequirement_select";
	var postData = "fdate=" + fDate;
	postData += "&tdate=" + tDate;
	postData += "&werks=" + encodeURIComponent($(':radio[name="rdo_plant_type"]:checked').val())
	postData += "&f_lgpro=" + encodeURIComponent($('#s_str').val())
	postData += "&funcName=ZIFFM_MES_PP013";
	
	$.ajax({
		  url:page_url,
		  data:postData,
		  type:'POST',
		  success : function(data, textStatus, jqXHR) {
		  	if(data.status == 200) {		  	
		  		var mydata = data.rows;
				var selected_data = [];
				var rdo_req_cnt = $(':radio[name="rdo_req_cnt"]:checked').val();
								
				if(rdo_req_cnt == 'n_zero') {						
					for(var i=0 ; i<mydata.length ; i++) {

						var flag = true;
						
						for(var k=0 ; k<mydata.length ; k++) {
							if(mydata[i].matnr == mydata[k].matnr) {
								if((mydata[k].request_bdmng == 0)) {
									flag = false;
								}	
							}
						}
						
						if(flag) {
							selected_data.push(mydata[i]);				//등급자재의 경우) 등급자재 중에 한개의 등급이라도 요청수량이 있으면 나머지 등급자재의 요청수량이 0이라도 모두 display 해준다.
						}
					}
				} else if(rdo_req_cnt == 'y_zero') {
					for(var i=0 ; i<mydata.length ; i++) {
						
						var flag = true;
						
						for(var k=0 ; k<mydata.length ; k++) {
							if(mydata[i].matnr == mydata[k].matnr) {
								if((mydata[k].request_bdmng == 0)) {
									flag = false;
								}	
							}
						}
						if(!flag) {
							selected_data.push(mydata[i]);				//등급자재의 경우) 등급자재 중에 각등급의 자재의 요청수량이 모두 0이면 display 하지 않는다.
						}
					}
				} else {
					selected_data = mydata;
				}
				
		  		$('#grid_mat_requirement').jqGrid('setGridParam', { datatype: 'local', data: selected_data }).trigger('reloadGrid');
		  		$('#infoTxt').text('');
		  	} else {
		  		fnMessageModalAlert("Notification(mes)","SAP와 동기화를 실패했습니다.");
		  		$('#infoTxt').text('');
		  	}
		  },
		  error : function(jqXHR, textStatus, errorThrown) {
			  fnMessageModalAlert("Notification(mes)","SAP와 동기화를 실패했습니다.");
			  $('#infoTxt').text('');
		  },
		  complete: function () {				
			  $('#modal_ing').modal('hide');
			  fnSearchPoss();
		  }
		});
}

function fnRequestMatRequirement(){
	fnMessageModalConfirm("Notification(MES)", "자재이동요청을 진행하시겠습니까?", function(chk){
		if(chk){
			fnRequestMatRequirement_proc();
		}
	});
}

function fnRequestMatRequirement_proc(){
	
	$("#grid_mat_requirement").jqGrid('setGridParam', {cellEdit: false});
	
	var gridDataArr = $('#grid_mat_requirement').jqGrid('getRowData');
	var keyArr = $('#grid_mat_requirement').jqGrid('getDataIDs');

	if( gridDataArr.length==0 ) {
 		fnMessageModalAlert("Notification(MES)", "조회 된 데이터가 없습니다.");
 		$("#grid_mat_requirement").jqGrid('setGridParam', {cellEdit: true});
 		return;
	}
	
	$("#grid_mat_requirement").jqGrid('setGridParam', {cellEdit: true});
	
	var matnr_arr = [];
	var reqm_matnr_tbl_data = [];
	var reqd_matnr_tbl_data = [];
	
// 	var params = [];
	
	for (var i = 0; i < keyArr.length; i++) { //row id수만큼 실행           
    	if($("input:checkbox[id='jqg_grid_mat_requirement_"+keyArr[i]+"']").is(":checked")){ //checkbox checked 여부 판단
    		var rowdata = $("#grid_mat_requirement").getRowData(keyArr[i]); // 해당 id의 row 데이터를 가져옴
    		if($("#grid_mat_requirement").getRowData(keyArr[i]).request_bdmng.length >20) {
    			fnMessageModalAlert("Notification(MES)", "요청수량 입력이 제대로 되지 않았습니다. \n 입력 후 엔터를 쳐주세요");
    	 		return;
    		}
    		
    		matnr_arr.push(rowdata.matnr);	// 선택된 품번 값들
    		
    		/*********************Detail 테이블 data 처리 : Start*********************/
    		var data = new Object();
    		
    		data.matnr = $("#grid_mat_requirement").getRowData(keyArr[i]).matnr;
    		data.grade_nm = $("#grid_mat_requirement").getRowData(keyArr[i]).grade;
    		data.request_bdmng = $("#grid_mat_requirement").getRowData(keyArr[i]).request_bdmng;
    		data.werks = $("#grid_mat_requirement").getRowData(keyArr[i]).werks;
    		data.lgfsb = $("#grid_mat_requirement").getRowData(keyArr[i]).lgfsb;
    		data.lgpro = $("#grid_mat_requirement").getRowData(keyArr[i]).lgpro;
    		
    		reqd_matnr_tbl_data.push(data);
    		/*********************Detail 테이블 data 처리 : End*********************/
// 		    params.push(rowdata); //배열에 맵처럼 담김
	    }
	}
	/*********************Master 테이블 data 처리 : Start*********************/
	
	var matnr_uniq_arr = [];
	matnr_uniq_arr = matnr_arr.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);		//등급떄문에 그리드에 여러개 생긴 중복 품번값들을 제거한 배열

	for(var i=0 ; i<matnr_uniq_arr.length ; i++){
		var data = new Object();
		var tmp_request_bdmng_sum =0;
		for(var j=0 ; j<gridDataArr.length ; j++) {
			if(matnr_uniq_arr[i] == gridDataArr[j].matnr) {
				tmp_request_bdmng_sum =Number(tmp_request_bdmng_sum) + Number(gridDataArr[j].request_bdmng);
			
				var matnr = gridDataArr[j].matnr;
				var werks = gridDataArr[j].werks; 
				var lgort = gridDataArr[j].lgort;     
				var lgobe_lgfsb = gridDataArr[j].lgobe_lgfsb;
				var lgobe_lgpro = gridDataArr[j].lgobe_lgpro;
				var bdter = gridDataArr[j].bdter;
				var bdmng = gridDataArr[j].bdmng;
				var meins = gridDataArr[j].meins;
				var grade = gridDataArr[j].grade;
			}					
		}
		data.matnr = matnr;
		data.werks = werks;
		data.lgort = lgort;
		data.lgobe_lgfsb = lgobe_lgfsb;
		data.lgobe_lgpro = lgobe_lgpro;
		data.bdter = bdter;
		data.bdmng = bdmng;
		data.meins = meins;
		data.grade = grade;
		data.request_bdmng = tmp_request_bdmng_sum;
		
// 		console.log(data);
		reqm_matnr_tbl_data.push(data);
		
// 		console.log("품번 : " + matnr_uniq_arr[i]+ " // 합계 : " + tmp_request_bdmng_sum);
	}
// 	console.log(reqm_matnr_tbl_data);	// master
// 	console.log(reqd_matnr_tbl_data);	// detail
	/*********************Master 테이블 data 처리 : End*********************/
	/*********************그리드 체크여부 확인 : Start*********************/
	if(reqd_matnr_tbl_data.length == 0) {
		fnMessageModalAlert("Notification(MES)", "체크 된 데이터가 없습니다.");
 		return;
	}
	/*********************그리드 체크여부 확인 : End*********************/
	var m_jsonStr = JSON.stringify(reqm_matnr_tbl_data);
	var d_jsonStr = JSON.stringify(reqd_matnr_tbl_data);
	var page_url = "/frontend/mes/reqm_matnr_tbl_insert"
	var postData = 'reqm_matnr_tbl_data=' + encodeURIComponent(m_jsonStr);
		postData += '&reqd_matnr_tbl_data=' + encodeURIComponent(d_jsonStr);
		postData += '&pgm_nm=' + encodeURIComponent("MES");
	
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		fnMessageModalAlert("Notification(MES)", "정보를 저장하였습니다.");	
	    	} else {
	    		fnMessageModalAlert("Notification(MES)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(MES)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {	    	
	    	$("#grid_po_mat").jqGrid('clearGridData');
	    	$("#grid_req_detail").jqGrid('clearGridData');
	    	$("#grid_mat_requirement").jqGrid('clearGridData');
	    	
	    }
	});
}



function getStrList() {

	initOptions($('#s_str'));
// 	var page_url = "/frontend/scm/scm_sloc_code_select";
// 	var postData = 'werks=' + encodeURIComponent($(':radio[name="rdo_plant_type"]:checked').val());
	
	var page_url = "/frontend/scm/mes_stock_tbl_select";
	var postData = 'dept_cd=' + encodeURIComponent($(':radio[name="rdo_plant_type"]:checked').val());
	postData += '&menu_code=' + encodeURIComponent('mst01');
				 
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$('#s_str').append($('<option>', { 
						value: '',
				        text : '- 전체 -'
				    }));
					
					var d_cd = $(':radio[name="rdo_plant_type"]:checked').val();
					
					if(d_cd == '1110') {
						$.each(data.rows, function (i, item) {
							if(item.stock_code == '2100' || item.stock_code == '2200'|| item.stock_code == '2300'|| item.stock_code == '3100'|| item.stock_code == '3200') 
							{
								$('#s_str').append($('<option>', { 
									value: item.stock_code,
							        text : "("+item.stock_code+") " + item.stock_name
							    }));
							}
						});					
					} else {
						$.each(data.rows, function (i, item) {
							$('#s_str').append($('<option>', { 
								value: item.stock_code,
						        text : "("+item.stock_code+") " + item.stock_name
						    }));
						});
					}
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

function initOptions(obj) {
    $(obj)
        .find('option')
        .remove()
        .end()
        .val();
}

function excelFileDownload(gridName) {
// 	console.log('excelFileDownload('+gridName+')');
	var tmpArr = [];
	var getColNames = $("#grid_mat_requirement").jqGrid('getGridParam','colNames');
	getColNames[1] = '';
	var getColModels = $("#grid_mat_requirement").jqGrid('getGridParam','colModel');
	$.each(getColModels, function(idx, mrow){
		if( mrow.hidden==false && getColNames[idx]!='' ) {
			mrow.caption = getColNames[idx]; 
			tmpArr.push(mrow);  
		}
	});
	
	var gridCols = tmpArr;
	var gridData = $("#grid_mat_requirement").getRowData();

	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	if( gridName=='grid_mat_requirement' ) {
		fileName = '자재소요량.xlsx';
		sheetTitle = '자재소요량';
		sheetName = '자재소요량';
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