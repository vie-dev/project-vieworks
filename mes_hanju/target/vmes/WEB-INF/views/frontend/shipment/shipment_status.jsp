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
		<jsp:param name="selected_menu_cd" value="1046" />
	</jsp:include>
	<div class="content-wrapper">
		<section class="content-header">
			<h1>
				MES <small>출하 관리</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> MES</a></li>
				<li class="active">출하진행관리</li>
			</ol>
		</section>
		<section class="content">
			<div class="row">
			<div class="col-md-5">
				<div class="box" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
							<div class="form-group">
								<select id="i_plant" class="form_group input-sm" onChange="searchGridGroup();">
									<option value="1110">의료</option>
									<option value="1210">광영상</option>
								</select>
								<button type="button" id="" onclick="searchGridGroup();" class="btn btn-primary btn-sm">조회</button>
								<button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_group');" data-selfilepath="/upload" data-selfilename="test.xlsx">
									<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
								</button>   
							</div>
						</div>
					</div>
					<div class="box-body" style="padding-bottom: 0px;">
						<div class="row">
							<div class="col-sm-8">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 출고예정일</label>
									<div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                            <input type="text" class="form-control pull-right input-sm" id="wadat_register_date_range"> 
                                     </div>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 구분</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="i_shipment_gubun" class="form-control input-sm">
											<option value="">전체</option>
											<option value="Z">영업</option>
											<option value="Y">서비스</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-4">
							    <div class="form-group" style="margin-bottom: 0px;">
										<label>| 유형</label>
										<div class="form-group" style="margin-bottom: 0px;">
										<select id="i_lfart" class="form-control input-sm">
											<option value="">전체</option>
											<option value="LF">출하</option>
											<option value="LR">반품</option>
										</select>
									</div>
								</div>
							</div>
							
							<div class="col-sm-4">
							    <div class="form-group" style="margin-bottom: 0px;">
										<label>| 납품처명</label>
										<div class="form-group" style="margin-bottom: 0px;">
											<input type="text" class="form-control pull-right input-sm" id="name1_kunnr_we">
										</div>
									</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 진행상태</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="i_shipment_status" class="form-control input-sm">
											<option value="">전체</option>
											<option value="S1">대기</option>
											<option value="S2">진행중</option>
											<option value="S3">출하완료</option>
										</select>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="dv_grid_group" class="box-body">
						<div id="grid_group" style="width: 100%; height: 590px;"></div>
					</div>
				</div>
			</div><!-- 공정그룹 목록 -->
			<div class="col-md-7">
				<div class="box" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">출하 상세 정보</h3>
						<div class="box-tools pull-right">
							<div class="form-group">
								<button type="button" id="shipmentExe" onclick="shipmentExecute('exe');" class="btn btn-primary btn-sm">출하실행</button>   
								<button type="button" id="shipmentCan" onclick="shipmentExecute('cancel');" class="btn btn-danger btn-sm">출하취소</button>   
							</div>
						</div>
					</div>
					<div class="box-body" style="padding-bottom: 0px;">
						<div class="row">
							<div class="col-sm-12 text-right" style="font-weight:bold; color:blue;">
								<i class="fa fa-check" aria-hidden="true"></i> <span id="warningTxt">
								출하정보 목록을 선택 확인하세요.
								</span></div>
						</div>
						<div class="row">
							<div id="" class="box-body" style="padding-bottom: 0px;">
								<div id="grid_item" style="width: 100%; height: 640px;"></div>
							</div>
						</div>
						<div class="row text-center" style="height:50px">
							<button type="button" id="btn_save_tmp" class="btn bg-teal btn-sm" onClick="saveItemSerialTemp();" 
							style="margin-top: 10px; margin-bottom: 10px;">임시저장</button>
							<button type="button" id="btn_save" class="btn btn-success btn-sm" onClick="saveItemSerial();" 
							style="margin-top: 10px; margin-bottom: 10px;">저장</button>
							<button type="button" id="btn_init" class="btn btn-warning btn-sm" onClick="initItemSerial();" 
							style="margin-top: 10px; margin-bottom: 10px;">초기화</button>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
<div class="modal fade" id="check_serial" data-backdrop="static">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">시리얼 체크</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label for="routing_gno" class="col-sm-3 control-label text-right" style="line-height:30px;">시리얼</label>
							<div class="col-sm-6">
								<!-- <input type="input" id="serial" name="serial" class="form-control input-sm"> -->
								<input type="input"  id="serial" name="serial" class="form-control input-sm"  maxlength="100"  
											onkeypress="if(event.keyCode==13) {LMainsernr_enter(this); return false;}">
											
							</div>
							<div class="col-sm-2">
								<button type="button" id="" onclick="serialCheck();" class="btn btn-primary btn-sm">확인</button>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div id="grid_serial" style="width: 100%; height: 400px;"></div>
						<br>
						<div id="msg" style="display:none;"></div>
					</div>
				</div>
	        </div>
	        <div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-success btn-sm" onclick="checkSerial();">출하진행</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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
var lastSel;
var tmp_vbeln;
var s_key;
var s_cnt =0;
var shipment_arr;

$(function($) {
	initComponent();
	initScreenSizeModal();
	//Binds the Enter key to the grid to save the currently active row
	/*
	$("#grid_item").jqGrid("bindKeys", {
		"onEnter": function (currentId) {
			alert("test");
			//Saves the active row
			saveRow(currentId);

			var nextId = currentId + 1;
			$("#grid_item").jqGrid("editRow", nextId);

			//Updates the last count using the active row
			last_row = $("#grid_item").jqGrid("getRowData", currentId);
		}
	});	    	
	*/
})

function initComponent() {
// 	console.info('initComponent()');
	$('#wadat_register_date_range').daterangepicker({
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
	 //    startDate: '2017-10-01',
	 //    endDate: '2017-11-30'
	});  

	$("#check_serial").on('hidden.bs.modal', function () {
		w2ui.grid_serial.clear();
		w2ui.grid_serial.refresh();
	});
	
	loadDataFromRFC();
	gridGroupGen(); 
	gridItemListGen();
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

// 출하 목록 생성
function loadDataFromRFC() {
// 	console.info('loadDataFromRFC()     여기 나라왓!!!!!!!');
	
	var date1 = $("#wadat_register_date_range").val().substring(0,10);
		date1 = replaceAll(date1, "-", "");
// 		console.info('date1' +date1);
	var date2 = $("#wadat_register_date_range").val().substring(13,23);
		date2 = replaceAll(date2, "-", "");
// 		console.info('date2'+date2);
 
 	var page_url = "/frontendShip/shipment/zsdfm_deliv_dat";
 	var postData = "func_name=" + encodeURIComponent("ZSDFM_DELIV_DAT")
				 + "&iv_fdate=" + encodeURIComponent(date1)
				 + "&iv_tdate=" + encodeURIComponent(date2);

 	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
// 	    		$('#grid_group').jqGrid('clearGridData');
	    	} else {
	    		fnMessageModalAlert("Fail", "출하 정보를 I/F 저장하는데 실패 하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Error", "출하 정보를 I/F 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}

function gridGroupGen() {
// 	console.info('gridGroupGen()');
	
    var wadat_from = $("#wadat_register_date_range").val().substring(0,10);
	var wadat_to = $("#wadat_register_date_range").val().substring(13,23);
	
	var shipment_status = $('#i_shipment_status').val();	// 출하상태코드
	var name1_kunnr_we = $('#name1_kunnr_we').val();		// 납품처 
	var i_shipment_gubun = $('#i_shipment_gubun').val();	// 구분추가 전체 ALL, 영업 Z, 서비스 Y 
	
	$("#grid_group").w2grid({
		name : 'grid_group',
		show : {
			lineNumbers : true,
			selectColumn: true,
            footer: true
        },
		columns : [
	        { field:'vbeln', caption:'DO번호', sortable:true, size:'120px', style:'text-align:center'},
	        { field:'name1_kunnr_we', caption:'납품처', size:'150px', sortable:true},
	        { field:'auart', caption:'오더유형', size:'80px', sortable:true, style:'text-align:center',
	        	render : function(record, index, col_index){
		        	var colData = this.getCellValue(index, col_index);
		        	if( colData=='YFD2' ) return '무상-서비스';
		        	else if( colData=='YKA1' ) return '대여자산 회수-서비스';
		        	else if( colData=='YKB1' ) return '대여자산 출고-서비스';
		        	else if( colData=='YOR1' ) return '유상수리-서비스';
		        	else if( colData=='YRE2' ) return '반품-무상-서비스';
		        	else if( colData=='ZFD2' ) return '무상';
		        	else if( colData=='ZKA1' ) return '대여자산 회수';
		        	else if( colData=='ZKB1' ) return '대여자산 출고';
		        	else if( colData=='ZOR1' ) return '일반';
		        	else return colData;}},
	        { field:'shipment_status_nm', caption:'진행상태', size:'70px', sortable:true, style:'text-align:center'},
	        { field:'wadat', caption:'출고예정일', size:'100px', sortable:true, style:'text-align:center'},
	        { field:'vtext_lfart', caption:'유형', size:'70px', sortable:true, style:'text-align:center'},
	        { field:'posnr', caption:'NO', sortable:true, hidden:true},
	        { field:'edatu', caption:'납품요청일', hidden: true}, 
	        { field:'sernp', caption:'sernp', hidden:true}, 
	        { field:'lgmng', caption:'lgmng', hidden:true}, 
	        { field:'matnr', caption:'matnr', hidden:true}, 
	        { field:'arktx', caption:'arktx', hidden:true},//
	        { field:'shipment_status', caption:'shipment_status', hidden:true},
	        { field:'lfart', caption:'lfart', hidden:true},
	        { field:'vstel', caption:'vstel', hidden:true},
	        { field:'vtext_vstel', caption:'vtext_vstel', hidden:true},
	        { field:'werks', caption:'werks', hidden:true},
	        { field:'name1_werks', caption:'name1_werks', hidden:true},
	        { field:'lgort', caption:'lgort', hidden:true},
	        { field:'lgobe', caption:'lgobe', hidden:true},
	        { field:'lfimg', caption:'lfimg', hidden:true},
	        { field:'vrkme_do', caption:'vrkme_do', hidden:true},
	        { field:'vkorg', caption:'vkorg', hidden:true},
	        { field:'vtext_vkorg', caption:'vtext_vkorg', hidden:true},
	        { field:'vtweg', caption:'vtweg', hidden:true},
	        { field:'vtext_vtweg', caption:'vtext_vtweg', hidden:true},
	        { field:'spart', caption:'spart', hidden:true},
	        { field:'vtext_spart', caption:'vtext_spart', hidden:true},
	        { field:'vkbur', caption:'vkbur', hidden:true},
	        { field:'bezei_vkbur', caption:'bezei_vkbur', hidden:true},
	        { field:'vkgrp', caption:'vkgrp', hidden:true},
	        { field:'bezei_vkgrp', caption:'bezei_vkgrp', hidden:true},
	        { field:'vgbel', caption:'vgbel', hidden:true},
	        { field:'vgpos', caption:'vgpos', hidden:true},
	        { field:'strgr', caption:'strgr', hidden:true}
// 	        { field:'uni_key', caption:'uni_key', sortable:true, hidden:true, key:true}	
		],
		sortData: [{field: 'vbeln', direction: 'ASC'}],
		multiSelect : false,
		records: [],
		recordHeight : 30,
		onSelect: function(event) {
// 			console.log('select');
			event.onComplete = function () {
				w2ui.grid_item.clear();
// 				console.log(event.recid,la	stSel);
// 				if ( event.recid==lastSel) {
// 					w2ui.grid_group.selectNone();
// 					lastSel = undefined;
// 					status = false;
// 				} else {
// 					lastSel = event.recid;
// 				}
				
				var selRowData = w2ui.grid_group.get(event.recid);
// 				console.log( selRowData.shipment_status);

				if(shipment_status_select(selRowData.vbeln) != selRowData.shipment_status) {
					fnMessageModalAlert("Notification(SHIPMENT)", "해당 내역이 업데이트 됐습니다.<br/>출하내역을 재조회합니다.");
					searchGridGroup();
					return;
				}  

				if( selRowData.shipment_status!='s1' ){
					loadItemList(event.recid, true);
				} else {
					makeItemList(event.recid);
				}
				
				$("#shipmentExe").hide();
				$("#shipmentCan").hide();
				$("#btn_save_tmp").hide();
				$("#btn_save").hide();
				$("#btn_init").hide();
				
				if( selRowData.shipment_status == 's1'){
// 					console.log("s1 진입");
					$("#shipmentExe").hide();
					$("#shipmentCan").hide();
					$("#btn_save_tmp").show();
					$("#btn_save").show();
					$("#btn_init").show();
					
				} else if( selRowData.shipment_status == 's2'){
// 					console.log("s2 진입");
					$("#shipmentExe").show();
					$("#shipmentCan").hide();
					$("#btn_save_tmp").show();
					$("#btn_save").show();
					$("#btn_init").show();
					
				} else if( selRowData.shipment_status == 's3'){
// 					console.log("s3 진입");
					$("#shipmentExe").hide();
					$("#shipmentCan").show();
					$("#btn_save_tmp").hide();
					$("#btn_save").hide();
					$("#btn_init").hide();
				} else if( selRowData.shipment_status == 's4'){
// 					console.log("s4 진입");
					$("#shipmentExe").show();
					$("#shipmentCan").hide();
					$("#btn_save_tmp").show();
					$("#btn_save").show();
					$("#btn_init").show();
				}
			}
		},
		onUnselect: function(event) {
// 			console.log('unselect');
// 			var sel = this.getSelection();
// 			if (sel) {
// 			    event.preventDefault();
				event.onComplete = function () {
	// 				console.log('삭제  - ');
					w2ui.grid_item.clear();
					w2ui.grid_item.refresh();
				}
// 			}
	    }
	});
}

function gridItemListGen() {
// 	console.info('gridItemListGen()');
	var copyText = '';
	$("#grid_item").w2grid({
		name : 'grid_item',
		show : {
			lineNumbers : true,
            footer: true
        },
		columns : [
	        { field:'vbeln', caption:'D/O NO', size:'15%', sortable:true, style:'text-align:center'},
	        { field:'posnr', caption:'Item No.', size:'10%', sortable:true, style:'text-align:center'},
	        { field:'matnr', caption:'자재', size:'15%', sortable:true},
	        { field:'arktx', caption:'자재명', size:'30%', sortable:true},
	        { field:'lgmng', caption:'총수량', size:'5%', sortable:true, render:'int'},
	        { field:'f_sernp', caption:'시리얼사용여부', size:'10%', sortable:true, style:'font-weight:bold;color:blue;background-color:rgba(255,255,0,0.3);text-align:center', 
	        	render : function(record, index, col_index){
		        	var sernp = this.getCellValue(index, col_index+3);
		        	if ( sernp!=null && sernp!="" && sernp=="V001" ) {
		        		return '시리얼대상';
		        	} else {
		        		return '시리얼미대상';
		        	}
	        }},
	        { field:'sernr', caption:'시리얼번호', size:'15%', sortable:true, editable: function(record, index, col_index){
	        	var selectGroup = w2ui.grid_group.get(w2ui.grid_group.getSelection()[0]);
				if ( this.getCellValue(index, col_index+2)=='V001' && selectGroup.shipment_status!='s3' ) 
					return { type: 'text'};
				else
					return false;	}},
	        { field:'mng', caption:'수량', hidden:true},
	        { field:'sernp', caption:'sernp', hidden:true}
		],
		sortData: [{field: 'vbeln', direction: 'ASC'}],
		records: [],
		recordHeight : 30,
		onChange : function(event) {
			 var selection = w2ui.grid_item.getSelection();
			 var selectData = w2ui.grid_item.get(selection);
			 
			event.onComplete = function () {
				if(event.value_new.length>100) {
		    		fnMessageModalAlert("Warning", "시리얼번호는 100자리를 초과할 수 없습니다.");
					event.value_new = event.value_previous;
		    		return;
				} else {
					
					  $.each(selectData, function(idx, row) {
		    			  var change = row.w2ui.changes;
						 
		    				  if(change.sernr.length > 30 && Left(change.sernr,2) == 01  ){
		    					  console.log(" Right(change.sernr,9)" ,  Right(change.sernr,9));
		    					  change.sernr = Right(change.sernr,9);  
		    				    	}
				      				 
		  			});
					  
					var result = sapStockChk(event.recid);
					if(result=='N') {
						event.value_new = event.value_previous;
						var returnObj = w2ui.grid_item.get(event.recid);
						returnObj.sernr = '';
						delete returnObj['w2ui']; 
						w2ui.grid_item.set(event.recid, returnObj);
						w2ui.grid_item.refresh();
						event.recid = '';
					}
				}
			}
		},
		onSelect : function(event) {
			event.onComplete = function () {
				copyText = this.getCellValue(event.recid-1, event.column);
			}
		},
		onCopy: function(event) {
		    event.text = copyText;
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
	        { field:'chk', caption:'확인', size:'50px', style:'text-align:center;color:blue;font-weight:bold;'},
	        { field:'vbeln', caption:'D/O NO', size:'90px', sortable:true, style:'text-align:center'},
	        { field:'matnr', caption:'자재', size:'100px', sortable:true},
	        { field:'arktx', caption:'자재명', size:'120px', sortable:true},
	        { field:'lgmng', caption:'총수량', size:'50px', sortable:true, render:'int'},
	        { field:'f_sernp', caption:'시리얼사용여부', size:'122px', sortable:true, style:'font-weight:bold;color:blue;background-color:rgba(255,255,0,0.3);text-align:center', 
	        	render : function(record, index, col_index){
		        	var sernp = this.getCellValue(index, col_index+3);
		        	if ( sernp!=null && sernp!="" && sernp=="V001" ) {
		        		return '시리얼대상';
		        	} else {
		        		return '시리얼미대상';
		        	}
	        }, hidden:true},
	        { field:'sernr', caption:'시리얼번호', size:'120px', sortable:true},
	        { field:'mng', caption:'수량', hidden:true},
	        { field:'sernp', caption:'sernp', hidden:true}
		],
		sortData: [{field: 'vbeln', direction: 'ASC'}],
		records: [],
		recordHeight : 30
	});
}

function serialCheck() {
// 	console.log('serialCheck()');
// 	var itemData = w2ui.grid_item.records;
	var serial = $("#serial").val();
	var serialData = [];
	$.each(w2ui.grid_serial.records, function(idx, row){
		if( row.chk!='V' ) {
			serialData.push(row);
		}
	});
	$.each(serialData, function(idx, row){
		if( serial==row.sernr ) {
			row.chk = 'V';
			w2ui.grid_serial.set(row.recid, row);
		}
	});
}

//공정 그룹 목록 조회
function searchGridGroup() {
	console.log('searchGridGroup()');
	
	$("#shipmentExe").hide();
	$("#shipmentCan").hide();
	$("#btn_save_tmp").hide();
	$("#btn_save").hide();
	$("#btn_init").hide();
	 
	
	w2ui.grid_group.clear();
	w2ui.grid_group.refresh();
	
	loadDataFromRFC();
	
	w2ui.grid_item.clear();
	

	var wadat_from = $("#wadat_register_date_range").val().substring(0,10);
	var wadat_to = $("#wadat_register_date_range").val().substring(13,23);
	
	var shipment_status = $('#i_shipment_status').val();	// 출하상태코드
	var name1_kunnr_we = $('#name1_kunnr_we').val();	// 납품처 
	var lfart = $('#i_lfart').val();	// 유형코드 
	
	// 구분추가 전체 ALL, 영업 Z, 서비스 Y
	var i_shipment_gubun = $('#i_shipment_gubun').val(); 
	
  	var page_url = "/frontendShip/shipment/select_shipment_tbl"
				 + "?wadat_from=" + encodeURIComponent(wadat_from)
				 + "&wadat_to=" + encodeURIComponent(wadat_to)
			//	 + "&posnr=" + encodeURIComponent("000010")   // 꼭 posnr 이 000010 으로 시작하지 않는다. 쿼리 수정으로 해결 이부분은 반드시 주석으로 처리해야함.
				 + "&shipment_status=" + encodeURIComponent(shipment_status)
			 	 + "&name1_kunnr_we=" + encodeURIComponent(name1_kunnr_we)
				 + "&lfart=" + encodeURIComponent(lfart)
				 + "&vbeln_gr=" + encodeURIComponent("Y")
				 + "&i_shipment_gubun=" + encodeURIComponent(i_shipment_gubun)
			 	 + "&werks=" + encodeURIComponent($("#i_plant").val());

  	var rowArr = [];
  	w2ui['grid_group'].lock('loading...', true);
 	$.ajax({
		url : page_url,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = setRecid(data.rows);
				w2ui['grid_group'].records = rowArr;
				w2ui['grid_group'].total = rowArr.length;
			}
			w2ui['grid_group'].refresh();
			w2ui['grid_group'].unlock();
		}
	});
}      

function makeItemList(key) {
// 	console.log('makeItemList(' + key + ')');

	var itemData = w2ui.grid_item.get(w2ui.grid_item.getSelection());
	var cnt = itemData.length;
	var selRowData = w2ui.grid_group.get(key);
	
	var arrData;
	
	var page_url = "/frontendShip/shipment/select_shipment_tbl";
	var postData = "vbeln=" + encodeURIComponent(selRowData.vbeln)
				 + "&matnr=" + encodeURIComponent(selRowData.matnr);
	$.ajax({
	    url: page_url,
	    data: postData,
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	arrData = setRecid(data.rows);
	    	} else {
	    		fnMessageModalAlert("Fail", "정보를 불러오는데 오류가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Error", "정보를 불러오는데 에러가 발생하였습니다.");	
	    }
	});
	// make dataset and add
	var arrTmpObj = [];
	for(var i=0; i<arrData.length; i++) {
		if( arrData[i].sernp != 'V001' ){
// 			console.log('makeItemList case1-1');
			var tmpObj = {};
			tmpObj.vbeln = arrData[i].vbeln;
			tmpObj.posnr = arrData[i].posnr;
			tmpObj.matnr = arrData[i].matnr;
			tmpObj.arktx = arrData[i].arktx;
			tmpObj.lgmng = arrData[i].lgmng;
			tmpObj.sernr = '';
			tmpObj.mng = arrData[i].lgmng;
			tmpObj.sernp = arrData[i].sernp;
			
			arrTmpObj.push(tmpObj);
		} else {
			for(var idx=0; idx<Number(arrData[i].lgmng); idx++ ){
				var tmpObj = {};
				tmpObj.vbeln = arrData[i].vbeln;
				tmpObj.posnr = arrData[i].posnr;
				tmpObj.matnr = arrData[i].matnr;
				tmpObj.arktx = arrData[i].arktx;
				tmpObj.lgmng = arrData[i].lgmng;
				tmpObj.sernr = '';
				tmpObj.mng = 1;
				
				tmpObj.sernp = arrData[i].sernp;
				arrTmpObj.push(tmpObj);
			}
		}
		arrTmpObj = setRecid(arrTmpObj);
		w2ui.grid_item.records = arrTmpObj;
		w2ui.grid_item.total = arrTmpObj.length;
		w2ui.grid_item.refresh();
	}
}

function loadItemList(rowid, selected) {
// 	console.info('loadItemList('+rowid+','+selected+')');

	var itemData = w2ui.grid_item.get(w2ui.grid_item.getSelection());
	var cnt = itemData.length;
	var selRowData = w2ui.grid_group.get(rowid);
	
	var page_url = "/frontendShip/shipment/shipment_do_group_select";
	var postData = "vbeln=" + encodeURIComponent(selRowData.vbeln);
	var shipment_arr = [];
	$.ajax({
	    url: page_url,
	    data: postData,
	    async:false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		shipment_arr = data.rows;    	
	    	} else {
	    		fnMessageModalAlert("Fail", "정보를 저장하는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SHIP)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    }
	});
	console.warn(shipment_arr);
	var page_url = "/frontendShip/shipment/shipmentSernr_select";
	var postData = "vbeln=" + encodeURIComponent(selRowData.vbeln);
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	var arrData = data.rows;
// 		    	console.log("@@@@@@@");	
				console.log(arrData);		    	
		    	for(var i=0; i<arrData.length; i++){
		    		var arktx;
		    		var lgmng;
		    		var sernp;
		    		for(var k=0 ; k<shipment_arr.length ; k++){
// 		    			if(shipment_arr[k].matnr == arrData[i].matnr) {
		    			if(shipment_arr[k].vbeln == arrData[i].vbeln && shipment_arr[k].posnr == arrData[i].posnr ) {
// 		    				console.log(shipment_arr);
		    				arktx = shipment_arr[k].arktx;
		    				lgmng = shipment_arr[k].lgmng;
		    				sernp = shipment_arr[k].sernp;
		    			}
		    		}
		    		arrData[i].arktx = arktx;
		    		arrData[i].lgmng = lgmng;
		    		arrData[i].sernp = sernp;
		    		arrData[i].recid = i+1;
		    		w2ui.grid_item.add(arrData[i]);
// 		    		position: 'first', 'last', 'before', 'after'
		    	}
	    	} else {
	    		fnMessageModalAlert("Notification(SHIP)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SHIP)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    loadComplete : function(data) {
// 			console.log(data);
		},
	    complete: function() {}
	});
}

function initItemSerial() {
// 	console.log('initItemSerial()');
	var selRowData = w2ui.grid_group.get(w2ui.grid_group.getSelection());
	if( selRowData.length==0 ) {
		fnMessageModalAlert("Warning", "선택된 출하정보가 없습니다.");	
		return;
	}
	
	// DO별 체크
	var doArr = [];
	$.each(selRowData, function(idx, row) {
		doArr.push(row.vbeln);
		row.shipment_status = 's1';
	});
	doArr = $.unique(doArr);
	if( doArr.length>1 ){
		fnMessageModalAlert("Warning", "D/O No. 단위로 실행하여 주시기 바랍니다.");
		return;
	}
	
	fnMessageModalConfirm("Notification", "해당 내역을 초기화 하시겠습니까?", function(result){
		if(result) {
			var page_url = "/frontendShip/shipment/shipmentSernr_init";
			var postData = "params=" + encodeURIComponent(JSON.stringify(selRowData));
			$.ajax({
			    url: page_url,
			    data: postData,
			    type: "POST",
			    success:function(data, textStatus, jqXHR){
			    	if(data.status == "200") {
			    		fnMessageModalAlert("Success", "초기화 작업이 정상적으로 완료되었습니다.");
// 			    		console.log(data);
			    		searchGridGroup();
			    	} else {
			    		fnMessageModalAlert("Fail", "정보를 저장하는데 실패하였습니다.");	
			    	}
			    },
			    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("Error", "정보를 저장하는데 에러가 발생하였습니다.");	
			    }
			});
		}
	});
}

function saveItemSerial() {
// 	console.log('saveItemSerial()');
	var selRowData = w2ui.grid_group.get(w2ui.grid_group.getSelection()[0]);
	if( selRowData.length==0 ) {
		fnMessageModalAlert("Warning", "선택된 정보가 없습니다.");	
		return;
	}
	fnMessageModalConfirm("Notification", "해당 일련번호 내역을 저장하시겠습니까?", function(result){
		if(result) {
			var itemList = w2ui.grid_item.records;
			$.each(itemList, function(idx, row){
				if(row.w2ui!=undefined) {
					row.sernr = row.w2ui.changes.sernr;
				} else {
					sapStockChk(row.recid);
				}
			});
			if( selRowData.shipment_status=='s3' ) {
				fnMessageModalAlert("Warning", "이미 출하 완료된 상태입니다.");
				return;
			}
			// DO별 체크
			var doArr = [];
			$.each(itemList, function(idx, row) {
				doArr.push(itemList[idx].vbeln);
			});
			doArr = $.unique(doArr);
// 			console.log(doArr);
			if( doArr.length>1 ){
				fnMessageModalAlert("Warning", "D/O No. 단위로 실행하여 주시기 바랍니다.");
				return;
			}
// 			console.log(itemList);
			var page_url = "/frontendShip/shipment/shipmentSernr_insert";
			var postData = "params=" + encodeURIComponent(JSON.stringify(itemList));
			$.ajax({
			    url: page_url,
			    data: postData,
			    type: "POST",
			    success:function(data, textStatus, jqXHR){
			    	if(data.status == "200") {
			    		fnMessageModalAlert("Success", "정보 저장이 정상적으로 완료되었습니다. <br/> ***SAP 전송결과*** <br/> e_return : " + data.e_return
			    				+ "<br/>e_message : " + data.e_message);
// 			    		console.log(data);
// 			    		var s_id = $('#grid_group').jqGrid('getGridParam','selrow');
			    		searchGridGroup();
			    	} else {
			    		fnMessageModalAlert("Fail", "정보를 저장하는데 실패하였습니다.");	
			    	}
			    },
			    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("Error", "정보를 저장하는데 에러가 발생하였습니다.");	
			    }
			});
		}
	});
}

function saveItemSerialTemp() {
	console.log('saveItemSerialTemp()');
	
	var selRowData = w2ui.grid_group.get(w2ui.grid_group.getSelection()[0]);
	if( selRowData.length==0 ) {
		fnMessageModalAlert("Warning", "선택된 정보가 없습니다.");	
		return;
	}
// 	fnMessageModalConfirm("Notification", "해당 일련번호 내역을 저장하시겠습니까?", function(result){
// 		if(result) {
			var itemList = w2ui.grid_item.records;
			$.each(itemList, function(idx, row){
				if(row.w2ui!=undefined) {
					row.sernr = row.w2ui.changes.sernr;
				} else {
					sapStockChk(row.recid);
				}
			});
			if( selRowData.shipment_status=='s3' ) {
				fnMessageModalAlert("Warning", "이미 출하 완료된 상태입니다.");
				return;
			}
			// DO별 체크
			var doArr = [];
			$.each(itemList, function(idx, row) {
				doArr.push(itemList[idx].vbeln);
			});
			doArr = $.unique(doArr);
// 			console.log(doArr);
			if( doArr.length>1 ){
				fnMessageModalAlert("Warning", "D/O No. 단위로 실행하여 주시기 바랍니다.");
				return;
			}
// 			console.log(itemList);
			var page_url = "/frontendShip/shipment/shipmentSernr_insert_tmp";
			var postData = "params=" + encodeURIComponent(JSON.stringify(itemList));
			$.ajax({
			    url: page_url,
			    data: postData,
			    type: "POST",
			    success:function(data, textStatus, jqXHR){
			    	if(data.status == "200") {
			    		fnMessageModalAlert("Success", "정보 저장이 정상적으로 완료되었습니다.");
// 			    		searchGridGroup();
			    	} else {
			    		fnMessageModalAlert("Fail", "정보를 저장하는데 실패하였습니다.");	
			    	}
			    },
			    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("Error", "정보를 저장하는데 에러가 발생하였습니다.");	
			    }
			});
			
			var selc_row_key = w2ui.grid_group.getSelection()[0];
			searchGridGroup();
			setTimeout(function(){
				w2ui['grid_group'].select(selc_row_key);
			}, 300);
			
			
// 		}
// 	});
}

function shipmentExecute(flag) {
	var selRowData = w2ui.grid_group.get(w2ui.grid_group.getSelection()[0]);
	if(selRowData.vbeln == null) {
		fnMessageModalAlert("Warning", "선택 된 정보가 없습니다.");	
		return;
	}
	if( flag=='exe' ) {
		$("#check_serial").modal('show');
		setTimeout(function(){
			$("#msg").text('');
			$("#msg").hide();
			$("#serial").val('');
			var gridData = w2ui.grid_item.records;
			$.each(gridData, function(idx, row){
				row.chk = '';
			});
			w2ui.grid_serial.records = w2ui.grid_item.records;
			w2ui.grid_serial.total = w2ui.grid_item.records.length;
			w2ui.grid_serial.resize();
			w2ui.grid_serial.refresh();
		}, 200);
		/*
		fnMessageModalConfirm("Notification", "해당 일련번호 내역을 출하실행 하시겠습니까?", function(result){
			if(result) {
				fn_shipmentExecute(flag);
			}
		});
		*/
	} else {
		fnMessageModalConfirm("Notification", "해당 일련번호 내역을 출하취소 하시겠습니까?", function(result){
			if(result) {
				fn_shipmentExecute(flag);
			}
		});		
	}
}

function checkSerial() {
// 	console.log('checkSerial()');
	var gridSerial = w2ui.grid_serial.records;
	var tmpArr = [];
	var checkCnt = 0;
	var msg = '';
	
	$.each(gridSerial, function(idx, row){
		if( row.sernp=='V001' && row.chk=='' ){
			checkCnt++;
			tmpArr.push(row.recid);
		}
	});
	
	if( checkCnt>0 ) {
		msg = '총 ' + checkCnt + '건의 데이터가 시리얼 체크 완료되지 않았습니다.\n\r' +
			  '시리얼 데이터 확인이 모두 완료된 수 출하 진행이 가능합니다.\n\r' + 
		      '( Line : ' + String(tmpArr) + ')';
		$("#msg").text(msg);
		$("#msg").show();
	} else {
		$("#msg").text('');
		$("#msg").hide();
		fnMessageModalConfirm("Notification", "해당 일련번호 내역을 출하실행 하시겠습니까?", function(result){
			if(result) {
				fn_shipmentExecute('exe');
				$("#check_serial").modal('hide');
			}
		});
	}
}

function fn_shipmentExecute(flag) {
	console.info('fn_shipmentExecute('+flag+')');

	// exe , cancel
	//ZSDFM_DELIV_CHANGE
	var if_flag = '';
	if( flag!='exe' ) 
		if_flag = 'D'; 
	
	//shipment_status` CHAR(2) NULL DEFAUCLT 's1' COMMENT '출하대기 \'s1\' , 진행중\'s2\' , 진행완료\'s3\'',
	var itemList = w2ui.grid_item.records;
// 	console.warn(itemList);
// 	var selRowData = $("#grid_group").getRowData($('#grid_group').jqGrid('getGridParam','selrow'));
// 	var pokeyArr = $('#grid_group').jqGrid('getDataIDs');
	var selRowData = w2ui.grid_group.get(w2ui.grid_group.getSelection()[0]);
// 	var selectKey = [];
// 	for (var i = 0; i < pokeyArr.length; i++) { //row id수만큼 실행           
//     	if($("input:checkbox[id='jqg_grid_group_"+pokeyArr[i]+"']").is(":checked")){ //checkbox checked 여부 판단
//     		selRowData.push($("#grid_group").getRowData(pokeyArr[i]));
//     		selectKey.push(pokeyArr[i]);
//     	}
//    	}
	
	// 상태체크
	if( selRowData.shipment_status=='s1' ) {
		fnMessageModalAlert("오류발생", "시리얼 등록 후 실행바랍니다.");
		return;
	}
	// DO별 체크
	var doArr = [];
	for( var idx=0; idx<itemList.length; idx++) {
		doArr.push(itemList[idx].vbeln);
	}
	doArr = $.unique(doArr);
	if( doArr.length>1 ){
		fnMessageModalAlert("오류발생", "D/O No. 단위로 실행하여 주시기 바랍니다.");
		return;
	}

	var page_url = "/frontendShip/shipment/select_shipment_tbl";
	var postData = "vbeln=" + encodeURIComponent(doArr[0]);
	var arrData = [];
	$.ajax({
	    url: page_url,
	    data: postData,
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	arrData = data.rows;
// 		    	console.log(arrData);
	    	} else {
	    		fnMessageModalAlert("Fail", "정보를 저장하는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Error", "정보를 저장하는데 에러가 발생하였습니다.");	
	    }
	});
	////////////////////////////////////////////////
	var page_url = "/frontendShip/shipment/shipmentExecute";
	var postData = "headerJson=" + encodeURIComponent(JSON.stringify(arrData))
				 + "&sernrJson=" + encodeURIComponent(JSON.stringify(itemList))
				 + "&if_flag=" + encodeURIComponent(if_flag)
				 + "&funcName=ZSDFM_DELIV_CHANGE";
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
// 	    		console.log(data);
	    		fnMessageModalAlert("Success", "해당 실적이 처리되었습니다.<br/> ***SAP 전송결과*** <br/> e_return : " + data.ev_status
	    				+ "<br/>e_message : " + data.ev_message);
// 	    		searchGridGroup();
	    	} else {
	    		fnMessageModalAlert("Notification(SHIP)", "정보를 저장하는데 에러가 발생하였습니다.<br/> 이미 처리된 실적일 수 있습니다. 확인해주세요. <br/>" 
	    				+ "<br/> ***SAP 전송결과*** <br/> e_return : " 
	    				+ data.ev_status + "<br/>e_message : " + data.ev_message);	
// 	    		searchGridGroup();
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SHIP)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() { searchGridGroup(); }
	});
}

function sapStockSync(rowid) {
	console.log('sapStockSync()');
	var matnr_arr = [];
	var unique_matnr_arr = [];
// 	matnr_arr.push(rowData.matnr);
// 	var rowData = w2ui.grid_group.get(w2ui.grid_group.getSelection());
	var rowData = w2ui.grid_item.get(w2ui.grid_item.getSelection());
// 	console.log(rowData);
	for(var i =0 ; i<rowData.length; i++) {
		matnr_arr.push(rowData[i].matnr)	
	}

// 	console.log(matnr_arr);
	if(matnr_arr.length==0) {
		return;
	} else {
		$.each(matnr_arr, function(i, el){
			if($.inArray(el, unique_matnr_arr)=== -1) unique_matnr_arr.push(el);
		});
	}
	console.log(unique_matnr_arr);
	var page_url = "/frontendShip/shipment/sapStockSync";
// 	var postData = "matnrs=" + encodeURIComponent(String(matnr_arr));
	var postData = "matnrs=" + encodeURIComponent(String(unique_matnr_arr));
	
	$.ajax({
	    url: page_url,
	    data: postData,
	    async:false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
// 	    		console.log(data);
	    	} else {
	    		fnMessageModalAlert("오류", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SHIP)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    loadComplete : function(data) {
// 			console.log(data);
		},
	    complete: function() {}
	});	
}

function sapStockChk(rowid) {
	console.log('sapStockChk(' + rowid + ')');	
	
	var result = '';
	sapStockSync(rowid);
	var itemData = w2ui.grid_item.get(rowid);
	if( itemData.w2ui!=undefined ) 
		itemData.sernr = itemData.w2ui.changes.sernr;

	console.log(itemData);
	
	var page_url = "/frontendShip/shipment/sapStockChk";
	var postData = "vbeln=" + encodeURIComponent(itemData.vbeln);
		postData += "&posnr=" + encodeURIComponent(itemData.posnr);
		postData += "&sernr=" + encodeURIComponent(itemData.sernr);
		
// 	console.log(postData);
	$.ajax({
	    url: page_url,
	    data: postData,
	    async:false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
// 	    	console.log(data);
	    	if(data.status == "200") {
				if(data.flag == 'N') {
// 					itemData.w2ui.changes.sernr = '';
// 					w2ui.grid.set(1, { changes: { fname: '444' }});
// 					w2ui.grid_item.set(rowid, {changes:{ sernr:''}});
// 					console.warn(itemData.w2ui.changes.sernr);
					
					result = data.flag;
					fnMessageModalAlert("Fail", data.result);
				}
	    	} else {
	    		fnMessageModalAlert("Fail", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Error", "정보를 저장하는데 에러가 발생하였습니다.");	
	    }
	});
	return result;
}

function excelFileDownload(gridName) {
// 	console.log('excelFileDownload('+gridName+')');
	
	var gridCols = w2ui[gridName].columns;
	var gridData = w2ui[gridName].records;

	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	if( gridName=='grid_group' ) {
		fileName = '출하진행목록.xlsx';
		sheetTitle = '출하진행목록';
		sheetName = '출하진행목록';
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

function setRecid(objArr) {
// 	console.log('setRecid()');
	$.each(objArr, function(idx, row){
		row.recid = idx+1;
	});
	return objArr;
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
	    	 
	    	$('#serial').val(Right(text.value,9));
	    	}
	    
	    serialCheck();
	   
	} else {
		fnMessageModalAlert("Notification(MES)", "바코드 길이는 7자리 이상이어야 합니다.<br/>입력값 : " + $('#serial').val());
		$('#serial').val("");
    } 
}

function shipment_status_select(s_vbeln) { 
	var rtn_data = "";
	var page_url = "/frontendShip/shipment/select_shipment_tbl"
	 	 + "?vbeln=" + encodeURIComponent(s_vbeln);
	
	$.ajax({
	    url: page_url,
	    type: "POST",
	    async:false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		rtn_data = data.rows[0].shipment_status
	    	} else {
	    		fnMessageModalAlert("Notification(SHIPMENT)", "출하 정보를 가져오는데 실패했습니다.");
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(SHIPMENT)", "출하 정보를 가져오는데 실패했습니다.");	
	    },
	    complete: function() {}
	});
	
	return rtn_data;

}
</script>

</body>
</html>
  
 