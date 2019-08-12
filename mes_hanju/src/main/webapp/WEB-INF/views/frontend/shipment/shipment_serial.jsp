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
		<jsp:param name="selected_menu_cd" value="1055" />
	</jsp:include>
	<div class="content-wrapper">
		<section class="content-header">
			<h1>
				MES <small>출하이력정보 조회</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> MES</a></li>
				<li class="active">출하이력정보 조회</li>
			</ol>
		</section>
		<section class="content">
			<div class="row">
			<div class="col-md-12">
				<div class="box" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
							<div class="form-group">
							<!-- 	<select id="i_plant" class="form_group input-sm" onChange="searchGrid();"> -->
								<select id="i_plant" class="form_group input-sm"   >
									<option value="1110">의료</option>
									<option value="1210">광영상</option>
								</select>
								<button type="button" id="" onclick="searchGrid();" class="btn btn-primary btn-sm">조회</button>  
								<button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_group');" data-selfilepath="/upload" data-selfilename="test.xlsx">
									<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
								</button>   
							</div>
						</div>
					</div>
					<div class="box-body" style="padding-bottom: 0px;">
						<div class="row">
							<div class="col-sm-3">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 출하완료일</label>
									<div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                            <input type="text" class="form-control pull-right input-sm" id="wadat_ist_register_date_range"> 
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
							<div class="col-sm-2">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 거래처</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="name1_kunnr_we">
									</div>
								</div>
							</div>
							<div class="col-sm-2">
							    <div class="form-group" style="margin-bottom: 0px;">
									<label>| 자재</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="matnr">
									</div>
								</div>
							</div>
							<div class="col-sm-2">
							    <div class="form-group" style="margin-bottom: 0px;">
										<label>| 대표시리얼</label>
										<div class="form-group" style="margin-bottom: 0px;">
											<input type="text" class="form-control pull-right input-sm" id="project_no">
										</div>
									</div>
							</div>
						</div>
					</div>
					<div class="box-body">
						<div class="row">
						
							<div class="col-md-12" id="grid_area" style="margin-top: 10px; display: none;">
								<div id="grid" style="width: 100%; height: 640px; "></div>
							</div>
						</div>
						<div class="row">
					
							<div class="col-md-12" id="grid_O_area" style="margin-top: 10px; display: none;">
								<div id="grid_O" style="width: 100%; height: 640px; "></div>
							</div>
						</div>
						
						
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
	<jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
	
	<jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>

<script type="text/javascript">

$(function($) {
	initComponent();
	initScreenSizeModal();
})

function initComponent() {
// 	console.info('initComponent()');
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
	
	$('#wadat_ist_register_date_range').daterangepicker({
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
	});  
	gridGen();
	gridGenO();
	searchGrid();
	gridSernrGen();
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

function gridGenO() {
// 	console.info('gridGroupGen()');
	$("#grid_O").w2grid({
		name : 'grid_O',
		show : {
		 	lineNumbers : true,
			footer: true
        },
        columnGroups: [     
                        { span:4, caption: '' },
                        { span: 14, caption: '' }, /*
                        { span: 4, caption: 'RF SCU' },
                        { span: 4, caption: 'RF Workstation' },
                       */
                   ],
                  
		columns : [
	        /* { field:'vbeln', caption:'DO번호', sortable:true, size:'120px', style:'text-align:center', hidden:true},
	        { field:'posnr', caption:'Item No', size:'80px', style:'text-align:center', sortable:true, hidden:true}, */
	        { field:'wadat_ist', caption:'출하일 ', size:'100px', style:'text-align:center', sortable:true,  frozen: true  }, 
	        { field:'shipment_status_nm', caption:'출하상태 ', size:'150px', style:'text-align:center', sortable:true,  frozen: true  },
	        { field:'vgbel', size:'150px', caption:'판매오더',  frozen: true },
	        { field:'vgpos', size:'100px', caption:'판매오더 품목',  frozen: true },
	        { field:'name1_kunnr_we', caption:'거래처명', size:'150px', sortable:true },
	        { field:'matnr', caption:'자재', size:'200px' }, 
	        { field:'arktx', caption:'자재내역', size:'250px' },
	        { field:'zzswoption', caption:'S/W', size:'100px' },
	        { field:'sernr', caption:'S/N', size:'150px', style:'text-align:center' } 
	     /*    { field:'dtatwtb_s', caption:'모델명', size:'80px', style:'text-align:center'}, 
	        { field:'dtsernr', caption:'S/N', size:'80px', style:'text-align:center'}, 
	        { field:'dtdmr_no', caption:'DMR', size:'80px', style:'text-align:center'}, 
	        { field:'dtrn_no', caption:'RN', size:'80px', style:'text-align:center'}, 
	        { field:'vsatwtb_s', caption:'모델명', size:'80px', style:'text-align:center'}, 
	        { field:'vssernr', caption:'S/N', size:'80px', style:'text-align:center'}, 
	        { field:'vsdmr_no', caption:'DMR', size:'80px', style:'text-align:center'}, 
	        { field:'vsrn_no', caption:'RN', size:'80px', style:'text-align:center'}, 
	        { field:'psatwtb_s', caption:'모델명', size:'80px', style:'text-align:center'}, 
	        { field:'pssernr', caption:'S/N', size:'80px', style:'text-align:center'}, 
	        { field:'psdmr_no', caption:'DMR', size:'80px', style:'text-align:center'}, 
	        { field:'psrn_no', caption:'RN', size:'80px', style:'text-align:center'}  */
		],
		sortData: [{field: 'vgbel', direction: 'ASC'}],
		multiSelect : false,
		records: [],
		recordHeight : 20,
		onSelect: function(event) {
// 			console.log('select');
			event.onComplete = function () {
				/* 		var selRowData = w2ui.grid.get(event.recid);
				$("#key").text("(" + selRowData.vbeln + " - " + selRowData.posnr + ")");
				$("#check_serial").modal("show"); */
				
				setTimeout(function(){
					w2ui.grid_O.resize();
				/* 	w2ui.grid_serial.resize();
					searchSerial(selRowData.vbeln, selRowData.posnr); */
				}, 10);
			}
		}
	});
}


function gridGen() {
// 	console.info('gridGroupGen()');
	$("#grid").w2grid({
		name : 'grid',
		show : {
		 	lineNumbers : true,
			footer: true
        },
        columnGroups: [     
                        { span:9, caption: '' },
                        { span: 4, caption: 'Detector' },
                        { span: 4, caption: 'VIVIX SCU' },
                        { span: 4, caption: 'PSU' },
                        { span: 4, caption: 'Charger' },
                        { span: 4, caption: 'RF HEAD' },
                        { span: 4, caption: 'RF SCU' },
                        { span: 4, caption: 'RF Workstation' },
                      
                   ],
                  
		columns : [
	        /* { field:'vbeln', caption:'DO번호', sortable:true, size:'120px', style:'text-align:center', hidden:true},
	        { field:'posnr', caption:'Item No', size:'80px', style:'text-align:center', sortable:true, hidden:true}, */
	        { field:'wadat_ist', caption:'출하일 ', size:'80px', style:'text-align:center', sortable:true,  frozen: true  }, 
	        { field:'shipment_status_nm', caption:'출하상태 ', size:'80px', style:'text-align:center', sortable:true,  frozen: true  },
	        { field:'vgbel', size:'100px', caption:'판매오더',  frozen: true },
	        { field:'vgpos', size:'80px', caption:'판매오더 품목',  frozen: true },
	        { field:'name1_kunnr_we', caption:'거래처명', size:'100px', sortable:true,  frozen: true },
	        { field:'matnr', caption:'자재', size:'100px',  frozen: true }, 
	        { field:'arktx', caption:'자재내역', size:'150px',  frozen: true },
	        { field:'zzswoption', caption:'S/W', size:'80px',  frozen: true },
	        { field:'sernr', caption:'S/N', size:'150px', style:'text-align:center',  frozen: true }, 
	        { field:'dtatwtb_s', caption:'모델명', size:'80px', style:'text-align:center'}, 
	        { field:'dtsernr', caption:'S/N', size:'100px', style:'text-align:center'}, 
	        { field:'dtdmr_no', caption:'DMR', size:'80px', style:'text-align:center'}, 
	        { field:'dtrn_no', caption:'RN', size:'80px', style:'text-align:center'}, 
	        { field:'vsatwtb_s', caption:'모델명', size:'80px', style:'text-align:center'}, 
	        { field:'vssernr', caption:'S/N', size:'100px', style:'text-align:center'}, 
	        { field:'vsdmr_no', caption:'DMR', size:'80px', style:'text-align:center'}, 
	        { field:'vsrn_no', caption:'RN', size:'80px', style:'text-align:center'}, 
	        { field:'psatwtb_s', caption:'모델명', size:'80px', style:'text-align:center'}, 
	        { field:'pssernr', caption:'S/N', size:'100px', style:'text-align:center'}, 
	        { field:'psdmr_no', caption:'DMR', size:'80px', style:'text-align:center'}, 
	        { field:'psrn_no', caption:'RN', size:'80px', style:'text-align:center'}, 
	        { field:'chatwtb_s', caption:'모델명', size:'80px', style:'text-align:center'}, 
	        { field:'chsernr', caption:'S/N', size:'100px', style:'text-align:center'}, 
	        { field:'chdmr_no', caption:'DMR', size:'80px', style:'text-align:center'}, 
	        { field:'chrn_no', caption:'RN', size:'80px', style:'text-align:center'} ,
	        { field:'rcatwtb_s', caption:'모델명', size:'80px', style:'text-align:center'}, 
	        { field:'rcsernr', caption:'S/N', size:'100px', style:'text-align:center'}, 
	        { field:'rcdmr_no', caption:'DMR', size:'80px', style:'text-align:center'}, 
	        { field:'rcrn_no', caption:'RN', size:'80px', style:'text-align:center'} ,
	        { field:'rsatwtb_s', caption:'모델명', size:'80px', style:'text-align:center'}, 
	        { field:'rssernr', caption:'S/N', size:'100px', style:'text-align:center'}, 
	        { field:'rsdmr_no', caption:'DMR', size:'80px', style:'text-align:center'}, 
	        { field:'rsrn_no', caption:'RN', size:'80px', style:'text-align:center'} ,
	        { field:'rwatwtb_s', caption:'모델명', size:'80px', style:'text-align:center'}, 
	        { field:'rwsernr', caption:'S/N', size:'100px', style:'text-align:center'}, 
	        { field:'rwdmr_no', caption:'DMR', size:'80px', style:'text-align:center'}, 
	        { field:'rwrn_no', caption:'RN', size:'80px', style:'text-align:center'} 
		],
		sortData: [{field: 'vgbel', direction: 'ASC'}],
		multiSelect : false,
		records: [],
		recordHeight : 20,
		onSelect: function(event) {
// 			console.log('select');
			event.onComplete = function () {
				/* 		var selRowData = w2ui.grid.get(event.recid);
				$("#key").text("(" + selRowData.vbeln + " - " + selRowData.posnr + ")");
				$("#check_serial").modal("show"); */
				
				setTimeout(function(){
					w2ui.grid.resize();
				/* 	w2ui.grid_serial.resize();
					searchSerial(selRowData.vbeln, selRowData.posnr); */
				}, 10);
			}
		}
	});
}


function gridSernrGen() {
	console.info('gridSernrGen()');
	
	$("#grid_serial").w2grid({
		name : 'grid_serial',
		show : {
			lineNumbers : true,
            footer: true
        },
		columns : [
	        { field:'pordno_status', caption:'작업내역', size:'90px', sortable:true, style:'text-align:center'},
	        { field:'itnbr', caption:'품목코드', size:'100px', sortable:true},
	        { field:'project_no', caption:'시리얼번호', size:'120px', sortable:true},
	        { field:'sub_sernr', caption:'공정투입자재 시리얼', size:'150px', sortable:true},
	        { field:'gr_no', caption:'변경점관리 GR번호', size:'120px', sortable:true},
	        { field:'ecr_no', caption:'변경점관리 ECR번호', size:'120px', sortable:true},
	        { field:'rn_no', caption:'변경점관리 RN번호', size:'120px'},
	        { field:'dmr_no', caption:'변경점관리 DMR번호', size:'120px'}
		],
		sortData: [{field: 'pordno_status', direction: 'ASC'}],
		records: [],
		recordHeight : 30
	});
}

//공정 그룹 목록 조회
function searchGrid() {
	console.log('searchGrid()');
	
   	w2ui.grid.clear();
	w2ui.grid.refresh();
	
	w2ui.grid_O.clear();
	w2ui.grid_O.refresh();    
	
/* 	var wadat_from = $("#wadat_register_date_range").val().substring(0,10);
	var wadat_to = $("#wadat_register_date_range").val().substring(13,23); */
    var wadat_ist_from = replaceAll($("#wadat_ist_register_date_range").val().substring(0,10),'-','');
	var wadat_ist_to = replaceAll($("#wadat_ist_register_date_range").val().substring(13,23),'-','');
	var sernr = $("#project_no").val();
	var name1_kunnr_we = $('#name1_kunnr_we').val(); 
	var matnr = $('#matnr').val(); 
	
  	var page_url = "/frontendShip/shipment/shipment_select"
/* 				 + "?wadat_from=" + encodeURIComponent(wadat_from)
				 + "&wadat_to=" + encodeURIComponent(wadat_to) */
				 + "?wadat_ist_from=" + encodeURIComponent(wadat_ist_from)
				 + "&wadat_ist_to=" + encodeURIComponent(wadat_ist_to)
				 + "&sernr=" + encodeURIComponent(sernr)
			 	 + "&name1_kunnr_we=" + encodeURIComponent(name1_kunnr_we)
			 	 + "&vstel=" + encodeURIComponent($("#i_plant").val())
			 	 + "&matnr=" + encodeURIComponent($("#matnr").val());
  	
  	if (encodeURIComponent($("#i_plant").val()) == '1110'){
  		
  		$("#grid_O_area").hide();
  		$("#grid_area").show();
		w2ui['grid'].resize();
		w2ui['grid'].refresh();
  		
  	  	var rowArr = [];
  	  	w2ui['grid'].lock('loading...', true);
  	 	$.ajax({
  			url : page_url,
  			type : "POST",
  			success : function(data, textStatus, jqXHR) {
  				if(data.status == 200 && (data.rows).length>0 ) {
  					rowArr = setRecid(data.rows);
  					w2ui['grid'].records = rowArr;
  					w2ui['grid'].total = rowArr.length;
  				}
  				w2ui['grid'].refresh();
  				w2ui['grid'].unlock();
  			}
  		});
  		
  		
  	}else{
  		
  		$("#grid_area").hide();
  		$("#grid_O_area").show();
		w2ui['grid_O'].resize();
		w2ui['grid_O'].refresh();
		
  	  	var rowArr = [];
  	  	w2ui['grid_O'].lock('loading...', true);
  	 	$.ajax({
  			url : page_url,
  			type : "POST",
  			success : function(data, textStatus, jqXHR) {
  				if(data.status == 200 && (data.rows).length>0 ) {
  					rowArr = setRecid(data.rows);
  					w2ui['grid_O'].records = rowArr;
  					w2ui['grid_O'].total = rowArr.length;
  				}
  				w2ui['grid_O'].refresh();
  				w2ui['grid_O'].unlock();
  			}
  		});
  		
  		
  	}


}      

function searchSerial(key1, key2) {

	var page_url = "/frontendShip/shipment/getSerialInfo";
	var postData = "vbeln=" + encodeURIComponent(key1)
				 + "&posnr=" + encodeURIComponent(key2);
	var shipment_arr = [];
	w2ui['grid_serial'].clear();
	w2ui['grid_serial'].lock('loading...', true);
	$.ajax({
	    url: page_url,
	    data: postData,
	    async:false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		shipment_arr = setRecid(data.rows);
	    		w2ui['grid_serial'].records = shipment_arr;
				w2ui['grid_serial'].total = shipment_arr.length;
	    	} else {
	    		fnMessageModalAlert("Fail", "정보를 저장하는데 실패하였습니다.");	
	    	}
			w2ui['grid_serial'].refresh();
			w2ui['grid_serial'].unlock();
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SHIP)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    }
	});
}

function setRecid(objArr) {
// 	console.log('setRecid()');
	$.each(objArr, function(idx, row){
		row.recid = idx+1;
	});
	return objArr;
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
  
 