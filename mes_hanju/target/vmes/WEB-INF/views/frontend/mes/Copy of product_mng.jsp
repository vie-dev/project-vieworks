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
		<jsp:param name="selected_menu_p_cd" value="1010" />
		<jsp:param name="selected_menu_cd" value="1117" />
	</jsp:include>
		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					MES <small>생산계획</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> MES</a></li>
					<li class="active">생산계획</li>
				</ol>
			</section>

			<section class="content">

				<div class="row">
					<section class="col-lg-12">
						<div class="box box-default box-solid" style="min-height: 580px; margin-bottom: 0px;">
							<div class="box-body">
								<div class="row">
									<div class="col-sm-2">
										<div class="form-group">
											<label>| 계획시작일</label>
											<div class="input-group">
												<div class="input-group-addon">
													<i class="fa fa-calendar"></i>
												</div>
												<input type="text" class="form-control pull-right  input-sm" id="csr_register_date_range">
											</div>
										</div>
									</div>
									<div class="col-sm-1">
										<div class="form-group">
											<label>| 오더유형</label> 
											<select id="auart" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
													<option value="">전체</option>
													<option value="ZP01">생산</option>
													<option value="ZP02">재작업</option>
													<option value="ZP03">C/S 수리</option>
													<option value="ZP04">연구소</option>
													<option value="ZP05">S/W</option>
													<option value="ZP06">C/S 생산 수리</option>
													<option value="ZP07">Mount교체(광영상)</option>
													<option value="ZP09">C/S 로너 수리</option>
												</select>
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label>| 작업장</label>
											<div class="row" style="padding: 0px;">
<!-- 												<div class="col-sm-6" style="padding-right: 0px;"> -->
<!-- 													<select id="m_wkctr" class="form-control select2 col-sm-2 input-sm" data-placeholder="" style="width: 100%;"> -->
<!-- 														<option value="">전체</option> -->
<!-- 														<option value="1110">의료영상</option> -->
<!-- 														<option value="1120">의료영상서비스</option> -->
<!-- 														<option value="1210">광영상</option> -->
<!-- 														<option value="1220">광영상서비스</option> -->
<!-- 													</select> -->
<!-- 												</div> -->
												<div class="col-sm-6">
													<select id="d_wkctr" class="form-control select2 col-sm-2 input-sm" data-placeholder="" style="width: 100%;">
													</select>
												</div>
											</div>
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label>| 지시번호</label> 
											<input type="input" id="pordno" name="pordno" class="form-control input-sm" placeholder="ex) 1001001" maxlength="30">
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label>| 자재코드</label> 
											<input type="input" id="itnbr" name="itnbr" class="form-control input-sm" placeholder="ex) HV2002" maxlength="30">
										</div>
									</div>
									<div class="col-sm-2" style="display:none;">
										<div class="form-group">
											<label>| 자재내역</label> 
											<input type="input" id="pordno_status" name="pordno_status" class="form-control input-sm" placeholder="ex) REL  PCNF DLV  PRC  GMCO MANC SETC" maxlength="50">
										</div>
									</div>
									<div class="col-sm-1">
										<div class="form-group">
											<label>| 확정여부</label><br /> 
											<select id="prod_confirm_chk" class="form-control input-sm input-sm">
												<option value="">전체</option>
												<option value="p2">확정</option>
												<option value="p1">미확정</option>
											</select>
										</div>
									</div>
								</div>
								<div class="row" style="margin-bottom:10px;">
									<div class="col-md-12 text-right">
										<button type="button" id="" onclick="fnPopupInfo('N');" class="btn btn-success btn-sm">등록</button>
										<button type="button" id="" onclick="fnPopupInfo('U');" class="btn btn-success btn-sm">수정</button>
										<button type="button" id="" onclick="fnDelete();" class="btn btn-danger btn-sm">삭제</button>
										<button type="button" id="" onclick="loadList();" class="btn btn-primary btn-sm">조회</button>
										<button type="button" id="" onclick="fnDownload();" class="btn btn-warning btn-sm">Excel Download</button>
									</div>
								</div>
								<div class="row"> <!--  grid  -->
									<div class="col-md-12">
										<div id="grid_role" style="width: 100%; height: 600px;"></div>
										<div id="pagination" class="text-center"></div>
									</div>
								</div>
							</div>
						</div>
				</div>
		</div>
	</div>
	</section>
		</div>
		<jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>


<!-- start modal jocod add-->
  <div class="modal fade" id="jocod_add" data-backdrop="static">
    <div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="modal_close()">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">작업자 정보 등록</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
			<div class="box box-warning box-solid">
			<div class="box-header with-border">
						<h3 class="box-title">작업자 Line 정보 등록</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_fault_conf" class="btn btn-success btn-sm" onclick="fnSerialChk();">진행</button>
						</div>
					</div>
<!-- 					<div class="col-sm-12 text-right" style="font-weight:bold; color:red;"> -->
<!-- 							<i class="fa fa-check" aria-hidden="true"></i> <span id="warningTxt">광영상 오더는 작업자 정보를 등록해야 합니다.</span> -->
<!-- 					</div> -->
			<div class="modal-body" id="modal_code_body">
				<div class="box-body">
			    	<div class="col-sm-2">
						<div class="form-group">
							<label>| 조 일괄설정</label><br /> 
							<select id="jo_select" class="form-control input-sm input-sm">
							</select>
						</div>
					</div>
					<div class="row">
						<div id="frm_jocod_add" class="col-sm-12">
							<table id="grid_jocod_add"></table>
						</div>
					</div>
				</div>
	        </div>
	        </div>
	        </div>
		</div>
	</div>
</div>
<!-- end modal jocod add-->

<script type="text/javascript">

var jocod_list = "";

$(function($) {
	jo_selectbox_init();
	fnDateInit();
	fnLoadCommonOption();
	fnLoadRoleGrid();
	fnLoadJoGrid();
	initScreenSizeModal();
	
})

function fnLoadCommonOption() {
	$('input[type="radio"].flat-red').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green',
		handle: 'radio'
	});
	
	getDWkctrList($("#m_wkctr").val());
	
	$('#d_wkctr').append($('<option>', { 
        value: "",
        text : "전체" 
    }));
	
	$('#m_wkctr').change(function(){
		getDWkctrList($("#m_wkctr").val());
	});
	
	$('#jo_select').change(function(){
		var jocodKeyArr = $('#grid_jocod_add').jqGrid('getDataIDs');
		var gridJocodData = $('#grid_jocod_add').jqGrid('getRowData');
		
		var jocode = $('#jo_select').val();
		for(var k=0 ; k<jocodKeyArr.length ; k++) {
				$('#'+jocodKeyArr[k]+'_jocod').val(jocode);
		}
	});
	
	
	$("#csr_register_date_range").pressEnter(function(e) {
		e.preventDefault();
		if(e.target.id == "csr_register_date_range"){
			fnSearchMasterCodeGrid();
		}
	});

    $(window).bind("resize", function () {
//     	resizeJqGrid("grid_role", true);
    	resizeJqGrid("grid_jocod_add", true);
    });

// 	지시일 선택 시 일주일 기간 자동 선택
// 		startDate:new Date(),
// 		endDate: moment(new Date()).add('days', 7)
// 	},
// 	function(end, start) {
// 		$('#csr_register_date_range span').html(start.format('YYYY-MM-DD') + ' ~ ' + end.format('YYYY-MM-DD'));
// 	});
// 	$('#csr_register_date_range').on('apply.daterangepicker', function(ev, picker) {
// 		$('#csr_register_date_range').data('daterangepicker').setEndDate(moment(picker.startDate.format('YYYY-MM-DD')).add('days', 6).format('YYYY-MM-DD'));
// 	});
	
	$( "#btn_search_csr" ).on('click', function(e) {
		e.preventDefault();
		fnSearchMasterCodeGrid();
	});
	
	$( "#btn_confirm" ).on('click', function(e) {
		e.preventDefault();
		
		var arr =  [];
		var uniqueArr = [];
		
		var ord_type = '';
		var keyArr = $('#grid_role').jqGrid('getDataIDs');
		var rowdata =$('#grid_role').jqGrid('getRowData');		
		
		for(var i=0 ; i<rowdata.length ; i++ ) {
			if (rowdata[i].chk == 'Y') {
				arr.push(rowdata[i].dept_cd);			
			}	
		}
		
		$.each(arr, function(i, el){
			if($.inArray(el, uniqueArr) === -1) uniqueArr.push(el);
		});
		
		if(uniqueArr.length == 1) {
			ord_type = uniqueArr[0];
		} else {
			fnMessageModalAlert("Notification(ProdConfirm)", "의료와 광 생산지시오더를 동시에 처리할 수 없습니다.<br/>각각 나누어 처리해주세요.");
 	 		return;
		}
		
		if(ord_type == '1110') {
			fnProdOrdConfirm();	
		} else if(ord_type == '1210'){
		///////////////////////////////////////////////////////////

		var rowdata = $('#grid_role').jqGrid('getRowData');
		
		var columnNames = $("#grid_role").jqGrid('getGridParam','colNames');
		
		var chks = "", c_date = "", pordnos = "", dateBySeq = "";
		var confJsonArr = [];
		var tmpJson = {};	// for seq check
		for (var i = 0; i < rowdata.length; i++) {
			
			var confJson = {};
			
			if( i==0 ){	
				tmpJson[columnNames[18]] = [];
				tmpJson[columnNames[20]] = [];
				tmpJson[columnNames[22]] = [];
				tmpJson[columnNames[24]] = [];
				tmpJson[columnNames[26]] = [];
				tmpJson[columnNames[28]] = [];
				tmpJson[columnNames[30]] = [];
			}
			if (rowdata[i].chk == 'Y') {
				c_date = "";
		
				
				if (rowdata[i].day_0 == 'V') {
					c_date = columnNames[18];
					dateBySeq = trim(rowdata[i].day_0_seq);
				} else if (rowdata[i].day_1 == 'V') {
					c_date = columnNames[20];
					dateBySeq = trim(rowdata[i].day_1_seq);
				} else if (rowdata[i].day_2 == 'V') {
					c_date = columnNames[22];
					dateBySeq = trim(rowdata[i].day_2_seq);
				} else if (rowdata[i].day_3 == 'V') {
					c_date = columnNames[24];
					dateBySeq = trim(rowdata[i].day_3_seq);
				} else if (rowdata[i].day_4 == 'V') {
					c_date = columnNames[26];
					dateBySeq = trim(rowdata[i].day_4_seq);
				} else if (rowdata[i].day_5 == 'V') {
					c_date = columnNames[28];
					dateBySeq = trim(rowdata[i].day_5_seq);
				} else if (rowdata[i].day_6 == 'V') {
					c_date = columnNames[30];
					dateBySeq = trim(rowdata[i].day_6_seq);
				}
				confJson['prodNo'] = rowdata[i].pordno;
				pordnos += rowdata[i].pordno + ',';
				confJson['c_date'] = replaceAll(c_date, "-", "");
				confJson['dateBySeq'] = dateBySeq;
							 
				
				confJsonArr.push(confJson);
				/*********************************************************
				* 생산확정일 체크 확인...그리드의 확정일 선택 V 체크 부분
				**********************************************************/
				if (c_date == '') {
					fnMessageModalAlert("확인하세요!", "확정하려는 데이터의 일자를 선택하지 않았습니다.");
					$("#grid_role").jqGrid('setGridParam', {cellEdit: true});
					return;
				} 
				
				/********************************************
				* 선택된 오더의 자재 라우팅 정보 유무확인
				********************************************/
				if (rowdata[i].routing_yn.length == 0) {
		 	 		fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더의 라우팅정보가 없습니다.");
		 	 		return;
				}
				
				/********************************************
				* 선택된 오더의 확정여부확인
				********************************************/
				if (rowdata[i].cmdat.length > 0) {
		 	 		fnMessageModalAlert("Notification(MES)", "선택된 생산지시오더에 확정처리내역이 있습니다.");
		 	 		return;
				}
				
				else if ( $.inArray( dateBySeq, tmpJson[c_date] ) != -1 ) {
					if(dateBySeq != '') { 
						fnMessageModalAlert("확인하세요!", "확정하려는 일자("+ c_date + ")의 생산오더의 순서(" + dateBySeq + ")가 중복 되었습니다.");
						$("#grid_role").jqGrid('setGridParam', {cellEdit: true});
						return;
					}
				}
				tmpJson[c_date].push(dateBySeq);
			}
		}
		//////////////////////////////////////////////////////////
		modal_open();
		}
		 
	});
	
	$( "#btn_non_confirm" ).on('click', function(e) {
		e.preventDefault();
		fnProdOrdNonConfirm();
	});
}

// init Search Condition
function fnSearchConditionInit() {
	fnDateInit();
	$('#pordno').val('');
	$('#pordno_status').val('');
	
	$.each($(':radio[name="rdo_prod_comfirm_chk"]'), function(idx, obj){
		if( idx==0 ) {
			$(obj).prop('checked',true);
			$(obj).parent().addClass('checked');
			$(obj).addClass('checked');
		} else {
			$(obj).prop('checked',false);
			$(obj).parent().removeClass('checked');
			$(obj).removeClass('checked');
		}
	});
}

function fnDateInit() {
	minDate = getFormatDate(new Date()),
	mdTemp = new Date(), 
	maxDate = getFormatDate(new Date(mdTemp.setDate(mdTemp.getDate() + 7)));
	
	$('#csr_register_date_range').daterangepicker({
		opens: 'right', 
		locale: {
			format: 'YYYY-MM-DD', // inputbox 에 '2011/04/29' 로표시
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
			showMonthAfterYear: true,
			yearSuffix: '년',
			orientation: "top left"
		},
		startDate : moment(minDate),
		endDate :  moment(maxDate)
	});
}

function getFormatDate(d) {
// 	console.log('getFormatDate()');
	var month = d.getMonth()+1;
	var date = d.getDate();
	month = (month < 10) ? "0" + month : month;
	date = (date < 10) ? "0" + date : date;
	return d.getFullYear() + '-' + month + '-' + date;
}

function confirmDaySelcReload(date1) {	//조회하고 나서 확정일 선택 부분 날짜... 조회시작 지시일 기준 +7 로 그리드헤더 재설정
// 	console.info('confirmDaySelcReload(',date1,')');
	var secDate=date1;
	var t_year = secDate.substr(0,4);
	var t_month = secDate.substr(4,2);
	var t_day = secDate.substr(6,2);

	var t_date = new Date(t_year, t_month-1, t_day);  // date로 변경
	t_date.setDate(t_date.getDate()-1);		//확정일 선택 부분...조회 조건일보다 하루전날을 기준일로... 밑에 반복문 도는거 때문에... 
	var colModel = $("#grid_role").jqGrid('getGridParam', 'colModel');
	
	var tmp_dateArr=[];
	for(var m=11;m<18;m++) {
		tmp_dateArr.push(getFormatDate(new Date(t_date.setDate(t_date.getDate() + 1))));
	}
	for(var m=11;m<18;m++) {
// 		$("#grid_role").jqGrid("setLabel", colModel[2*m-10]['name'], tmp_dateArr[m-11]);
		$("#grid_role").jqGrid("setLabel", colModel[2*m-4]['name'], tmp_dateArr[m-11]);
	}
 	$('#warningTxt').text('확정 시 ' + tmp_dateArr[0] + ' ~ ' + tmp_dateArr[6] + ' 사이의 일자를 선택해야 합니다.(필수)');
}

function fnSearchMasterCodeGrid(){
	console.log('fnSearchMasterCodeGrid()');
	// 지시일
	var date1 = $("#csr_register_date_range").val().substring(0,10);
	date1 = replaceAll(date1, "-", "");
	var date2 = $("#csr_register_date_range").val().substring(13,23);
	date2 = replaceAll(date2, "-", "");
	// 지시번호
	var pordno = $("#pordno").val();
	// 작업품명
	var pordno_status = $('#pordno_status').val();
	// 확정여부
// 	var chkVal = $(":input:radio[name=rdo_prod_confirm_chk]:checked").val();
	var chkVal = $("#prod_confirm_chk").val();
	
	var page_url = "/sap_master/ziffm_mes_pp003"
				 + "?func_name=" + encodeURIComponent("ZIFFM_MES_PP003")
				 + "&IV_FDATE=" + encodeURIComponent(date1)
				 + "&IV_TDATE=" + encodeURIComponent(date2)
				 + "&jidat_from=" + encodeURIComponent(date1)
				 + "&jidat_to=" + encodeURIComponent(date2)
				 + "&pordno=" + encodeURIComponent(pordno)
				 + "&pordno_status=" + encodeURIComponent(pordno_status)
				 + "&pdsts=" + encodeURIComponent(chkVal)
			     + "&dept_cd=" + encodeURIComponent($("#m_wkctr").val())
				 + "&wkctr=" + encodeURIComponent($("#d_wkctr").val())
				 + "&itnbr=" + encodeURIComponent($("#itnbr").val())
				 + "&auart=" + encodeURIComponent($("#auart").val());

	/*********************************************************
	* 확정일 선택 부분 날짜 재설정.. 조회일자 시작일부터 7일
	**********************************************************/
	confirmDaySelcReload(date1);
	$("#grid_role").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_role").setGridParam({ page: 1 }).trigger("reloadGrid");
}

function fnGetDate(d) {	
	//mindate + d 한 날짜 반환
	mdTemp = new Date(), 
	fgd_date = getFormatDate(new Date(mdTemp.setDate(mdTemp.getDate() + d)));
	return fgd_date;
}

function fnLoadRoleGrid(){
// 	console.info('fnLoadRoleGrid()');
	var date1 = $("#csr_register_date_range").val().substring(0,10);
	date1 = replaceAll(date1, "-", "");
	var date2 = $("#csr_register_date_range").val().substring(13,23);
	date2 = replaceAll(date2, "-", "");
	// 지시번호
	var pordno = $("#pordno").val();
	// 작업품명
	var pordno_status = $('#pordno_status').val();
	// 확정여부
// 	var chkVal = $(":input:radio[name=rdo_prod_confirm_chk]:checked").val();
	var chkVal = $("#prod_confirm_chk").val();
	
	var page_url = "/sap_master/ziffm_mes_pp003"
				 + "?func_name=" + encodeURIComponent("ZIFFM_MES_PP003")
				 + "&IV_FDATE=" + encodeURIComponent(date1)
				 + "&IV_TDATE=" + encodeURIComponent(date2)
				 + "&jidat_from=" + encodeURIComponent(date1)
				 + "&jidat_to=" + encodeURIComponent(date2)
				 + "&pordno=" + encodeURIComponent(pordno)
				 + "&pordno_status=" + encodeURIComponent(pordno_status)
				 + "&pdsts=" + encodeURIComponent(chkVal);
				 + "&dept_cd=" + encodeURIComponent($("#m_wkctr").val())
			 	 + "&wkctr=" + encodeURIComponent($("#d_wkctr").val())
			     + "&auart=" + encodeURIComponent($("#auart").val());
				 
	$('#warningTxt').text('확정 시 ' + fnGetDate(0) + ' ~ ' + fnGetDate(6) + ' 사이의 일자를 선택해야 합니다.(필수)');
	
	$("#grid_role").w2grid({
		name: 'grid', 
	     show: { footer: true },
	     columnGroups: [
	         { caption: 'No', master: true },
	         { caption: '사업자번호',master: true },
	         { caption: '사업체명',master: true },
	         { caption: '구분', master: true },
	         { caption: '프로젝트', span: 7 },
	         { caption: '프로젝트 진행', span: 5 }
	     ],
    	 multiSelect: false,
//     	 columns: [                
//     	            { field: 'recid', caption: 'No', size: '40px', sortable: true, attr: 'align=center', resizable: true },
		colNames:['','상태','pdsts','지시번호', '계획시작일','자재','자재내역', '수량', '시리얼넘버', 'DMR' ,'라우팅','포장','오더유형','플랜트','워크센터','조','확정일', 
		          	fnGetDate(0), 'seq', fnGetDate(1), 'seq', fnGetDate(2), 'seq', fnGetDate(3), 'seq', fnGetDate(4), 'seq', 
		          	fnGetDate(5), 'seq', fnGetDate(6), 'seq', 'cmdat_seq', '라우팅존재여부', 'jocod','메모', '라우팅구분', '지시일', 'zzswoption'],
		colModel:[
			{name:'chk',index:'chk', width:20, editable: true, align:'center', edittype: 'checkbox', editoptions: { value: "Y:N", defaultValue: "false" },formatter: "checkbox", formatoptions: { disabled: false }},
	        {name:'pdsts_nm',index:'pdsts', width:40, sorttype:"text", sortable:true, align:"center"},
	        {name:'pdsts',index:'pdsts', width:50, sorttype:"text", sortable:true, hidden:true},
			{name:'pordno',index:'pordno', width:70, sorttype:"text", sortable:true, key:true},
			{name:'sedat',index:'sedat', width:70, sorttype:"text", sortable:true},
			{name:'itnbr',index:'itnbr', width:90,sorttype:"text", sortable:true},
			{name:'pordno_status',index:'pordno_status', width:110,sorttype:"text", sortable:true},
			{name:'pdqty',index:'pdqty', width:40,sorttype:"text", sortable:true, align:'right'},
			{name:'project_no',index:'project_no', width:70,sorttype:"text", sortable:true, align:'center', hidden:false},
			{name:'dmr_no',index:'dmr_no', width:40,sorttype:"text", sortable:true, align:'center', hidden:false},
			{name:'f_routing_yn',index:'f_routing_yn', width:50,sorttype:"text", sortable:true, formatter:jqgridHighlightFormatterRoutingYn},
			{name:'f_routing_gno_gubun',index:'f_routing_gno_gubun', width:50,sorttype:"text", sortable:true, formatter:jqgridHighlightFormatterRoutingGnoYn},
			{name:'auart',index:'auart', width:60,sorttype:"text", sortable:true, hidden:true},
			{name:'dept_cd',index:'dept_cd', width:50,sorttype:"text", sortable:true},
			{name:'wkctr',index:'wkctr', width:80,sorttype:"text", sortable:true, hidden:true},
			{name:'jo_nm',index:'jo_nm', width:60,sorttype:"text", sortable:true},
			{name:'cmdat',index:'cmdat', width:60, sorttype:"text", sortable:true},
			{name:'day_0',index:'day_0', width:80, align:'center'},
			{name:'day_0_seq',index:'day_0_seq', width:30, align:'center', editable:true},
			{name:'day_1',index:'day_1', width:80, align:'center'},
			{name:'day_1_seq',index:'day_1_seq', width:30, align:'center', editable:true},
			{name:'day_2',index:'day_2', width:80, align:'center'},
			{name:'day_2_seq',index:'day_2_seq', width:30, align:'center', editable:true},
			{name:'day_3',index:'day_3', width:80, align:'center'},
			{name:'day_3_seq',index:'day_3_seq', width:30, align:'center', editable:true},
			{name:'day_4',index:'day_4', width:80, align:'center'},
			{name:'day_4_seq',index:'day_4_seq', width:30, align:'center', editable:true},
			{name:'day_5',index:'day_5', width:80, align:'center'},
			{name:'day_5_seq',index:'day_5_seq', width:30, align:'center', editable:true},
			{name:'day_6',index:'day_6', width:80, align:'center'},
			{name:'day_6_seq',index:'day_6_seq', width:30, align:'center', editable:true},
			{name:'cmdat_seq',index:'cmdat_seq', width:80, sorttype:"text", sortable:true, hidden:true},
			{name:'routing_yn',index:'routing_yn', width:50,sorttype:"text", sortable:true, hidden:true},
			{name:'jocod',index:'jocod', width:30,sorttype:"text", sortable:true, hidden:true},
			{name:'prod_memo',index:'prod_memo', width:50,sorttype:"text", sortable:true, hidden:true},
			{name:'routing_gno_gubun',index:'routing_gno_gubun', width:50,sorttype:"text", sortable:true, hidden:true},
			{name:'jidat',index:'jidat', width:50,sorttype:"text", sortable:true, hidden:true},
			{name:'zzswoption',index:'zzswoption', hidden:true}
		],
		rowNum:10000,
	    autowidth : true,
// 	    multiselect : true,
	    viewrecords : true,
	    height: 470,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    autoencode: true,
	    loadonce: false,
	    sortable: true,
	    cellEdit:true,
	    cellsubmit : 'clientArray',
	    shrinkToFit : false,
// 	    forceFit:true,
//      scrollOffset: 0,
	    onSelectRow: function(rowid, selected) {
			if(rowid != null) { }					
		},
		onCellSelect: function(rowid, index, contents, event) {
// 			console.warn(rowid, index, contents, event);
			/*
			rowid : pordno, 
			index : col idx,( 9 10 / 11 12 / 13 14 / 15 16 / 17 18 / 19 20 / 21 22 )
			contents : click 할때의 value
			
			var p = grid.jqGrid("getGridParam"), // get the reference to all parameters
		    iCol = p.iColByName["ColumnName"], // get index by column name
		    cm = p.colModel[iCol]; // item of "ColumnName" column
			*/
			
			if($('#grid_role').getCell(rowid,'cmdat').length == 0) {
				if(index == 18 || index == 20 || index == 22 || index == 24 || index == 26 || index == 28 || index == 30) {
			   		var cm = $(this).jqGrid('getGridParam','colModel');
			   		for(var i=0; i<7; i++) {
					    $(this).jqGrid('setCell', rowid, 'day_'+i, ' ');
					    $(this).jqGrid('setCell', rowid, 'day_' + i + '_seq', ' ');
			   		}
				    var idx = (cm[index].name).substring(4, 5);
				    $(this).jqGrid('setCell', rowid, 'day_'+idx, 'V');
				}
			}
	    },
	    afterEditCell: function (rowid, cellname, value, iRow, iCol) {
// 	    	console.log('rowid:',rowid,'/cellname:',cellname,'/value:',value,'/iRow:',iRow,'/iCol',iCol);
           	e = jQuery.Event("keydown");
			e.keyCode = $.ui.keyCode.ENTER;
           //get the edited thing
			edit = $(".edit-cell > *");
			edit.blur(function() {
				if ( $('#'+iRow+'_'+cellname).val()==' ' ) {
					$('#grid_role').jqGrid('setCell', rowid, cellname.replace('_seq',''), ' ');
				}
				edit.trigger(e);
			});
    	},
		loadComplete : function(data) {
// 			console.log(data);
			pordno = "";
			/*********************************************
			* 그리드 로드시 확정일 선택 내역 V 표시 출력 + 미확정 실적은 지시일로 V표시
			**********************************************/
			fnDrawConfirmChk();	
			

		}
	});
	/*
	$("#grid_role").jqGrid('setGroupHeaders', {
		useColSpanStyle: true, 
		groupHeaders:[
		  {startColumnName: 'day_0', numberOfColumns: 2, titleText: 'test1'},
		  {startColumnName: 'day_1', numberOfColumns: 2, titleText: 'test2'},
		  {startColumnName: 'day_2', numberOfColumns: 2, titleText: 'test3'},
		  {startColumnName: 'day_3', numberOfColumns: 2, titleText: 'test4'},
		  {startColumnName: 'day_4', numberOfColumns: 2, titleText: 'test5'},
		  {startColumnName: 'day_5', numberOfColumns: 2, titleText: 'test6'},
		  {startColumnName: 'day_6', numberOfColumns: 2, titleText: 'test7'}
		]
	});
	*/
}

function fnDrawConfirmChk() {
// 	console.info('fnDrawConfirmChk()');

	var gridData = $('#grid_role').jqGrid('getRowData');
	var columnNames = $("#grid_role").jqGrid('getGridParam','colNames');
	
// 	console.log(gridData);
// 	console.log(columnNames);
	
	for (var i = 0; i < gridData.length; i++) {
		if (gridData[i].cmdat.length > 0) {
// 			index : col idx,( 9 10 / 11 12 / 13 14 / 15 16 / 17 18 / 19 20 / 21 22 )
			for (var b = 0; b < 7; b++) {
				if (replaceAll(columnNames[2*b+18], "-", "") == replaceAll(gridData[i].cmdat, "-", "")) {
					$('#grid_role').jqGrid('setCell', gridData[i].pordno, 'day_' + b, 'V');
					$('#grid_role').jqGrid('setCell', gridData[i].pordno, 'day_' + b + '_seq', gridData[i].cmdat_seq);
				}
			}
		} else {
			for (var b = 0; b < 7; b++) {
				if (replaceAll(columnNames[2*b+18], "-", "") == replaceAll(gridData[i].sedat, "-", "")) {
					$('#grid_role').jqGrid('setCell', gridData[i].pordno, 'day_' + b, 'V');
				}
			}
		}
	}
// 	set_grid_GroupHeader();
	$("#grid_role").trigger("reloadGrid");
}

function fnProdOrdConfirm() {
	console.log('fnProdOrdConfirm()');
	/*******************************
	* 선택된 오더 정보 문자열 생성
	********************************/
	$("#grid_role").jqGrid('setGridParam', {cellEdit: false});
	var gridData = $('#grid_role').jqGrid('getRowData');
	
	var jocodKeyArr = $('#grid_jocod_add').jqGrid('getDataIDs');
	var gridJocodData = $('#grid_jocod_add').jqGrid('getRowData');

	var columnNames = $("#grid_role").jqGrid('getGridParam','colNames');
	
	var chks = "", c_date = "", pordnos = "", dateBySeq = "";
	var confJsonArr = [];
// 	var confJson = {};
	var tmpJson = {};	// for seq check
	for (var i = 0; i < gridData.length; i++) {
		
		var confJson = {};
		
		if( i==0 ){	
			tmpJson[columnNames[18]] = [];
			tmpJson[columnNames[20]] = [];
			tmpJson[columnNames[22]] = [];
			tmpJson[columnNames[24]] = [];
			tmpJson[columnNames[26]] = [];
			tmpJson[columnNames[28]] = [];
			tmpJson[columnNames[30]] = [];
		}
		if (gridData[i].chk == 'Y') {
			c_date = "";
	
			if (gridData[i].day_0 == 'V') {
				c_date = columnNames[18];
				dateBySeq = trim(gridData[i].day_0_seq);
			} else if (gridData[i].day_1 == 'V') {
				c_date = columnNames[20];
				dateBySeq = trim(gridData[i].day_1_seq);
			} else if (gridData[i].day_2 == 'V') {
				c_date = columnNames[22];
				dateBySeq = trim(gridData[i].day_2_seq);
			} else if (gridData[i].day_3 == 'V') {
				c_date = columnNames[24];
				dateBySeq = trim(gridData[i].day_3_seq);
			} else if (gridData[i].day_4 == 'V') {
				c_date = columnNames[26];
				dateBySeq = trim(gridData[i].day_4_seq);
			} else if (gridData[i].day_5 == 'V') {
				c_date = columnNames[28];
				dateBySeq = trim(gridData[i].day_5_seq);
			} else if (gridData[i].day_6 == 'V') {
				c_date = columnNames[30];
				dateBySeq = trim(gridData[i].day_6_seq);
			}
			confJson['prodNo'] = gridData[i].pordno;
			pordnos += gridData[i].pordno + ',';
			confJson['c_date'] = replaceAll(c_date, "-", "");
			confJson['dateBySeq'] = dateBySeq;
			
			for(var k=0 ; k<gridJocodData.length ; k++) {
				if(gridData[i].pordno == gridJocodData[k].pordno) {
					confJson['project_no'] = $('#'+jocodKeyArr[k]+'_project_no').val();	
				}
			}
			confJson['zmesfirm'] = "1";   //생산 확정시 sap 내 확정지시 수정을 막기위해서 확정일경우1 미확정일경우 2 로 전송한다.
			confJson['zzswoption'] = gridData[i].zzswoption;
			confJsonArr.push(confJson);
			/*********************************************************
			* 생산확정일 체크 확인...그리드의 확정일 선택 V 체크 부분
			**********************************************************/
			if (c_date == '') {
				fnMessageModalAlert("확인하세요!", "확정하려는 데이터의 일자를 선택하지 않았습니다.");
				$("#grid_role").jqGrid('setGridParam', {cellEdit: true});
				return;
			} 
			
			/********************************************
			* 선택된 오더의 자재 라우팅 정보 유무확인
			********************************************/
			if (gridData[i].routing_yn.length == 0) {
	 	 		fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더의 라우팅정보가 없습니다.");
	 	 		return;
			}
			
			/*
			else if ( dateBySeq.length == 0) {
				fnMessageModalAlert("확인하세요!", "확정하려는 생산오더의 순서를 지정하지 않았습니다.");
				$("#grid_role").jqGrid('setGridParam', {cellEdit: true});
				return;
			} 
			*/
			else if ( $.inArray( dateBySeq, tmpJson[c_date] ) != -1 ) {
				if(dateBySeq != '') { 
					fnMessageModalAlert("확인하세요!", "확정하려는 일자("+ c_date + ")의 생산오더의 순서(" + dateBySeq + ")가 중복 되었습니다.");
					$("#grid_role").jqGrid('setGridParam', {cellEdit: true});
					return;
				}
			}
			tmpJson[c_date].push(dateBySeq);
		}
	}
	
	$("#grid_role").jqGrid('setGridParam', {cellEdit: true});
	pordnos = pordnos.substr(0, pordnos.length-1);
	/*******************************
	* 선택된 오더 확정 내역 확인
	********************************/
	var prod_his_num = cofirmOrdChk(pordnos);
	if(prod_his_num > 0) {
		fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더에 확정처리내역이 있습니다.");
		fnSearchMasterCodeGrid();
		return;			
	}
	/*******************************
	* 생산오더체크헀는지 확인
	********************************/
	if ( confJsonArr.length==0 ) {
		fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더 없습니다.");
		return;
	}
	/*******************************
	* 확정일자가 당일 이전의 날자이면 실행 못함
	********************************/
	var today = getFormatDate(new Date()).replace(/-/gi, "");
	var tmpArr = [];
	$.each(confJsonArr, function(idx, row){
		var c_date = (row.c_date).replace('-','');
		if(today>c_date) tmpArr.push(row.prodNo); 
	});
	if( tmpArr.length>0 ) {
// 		console.log(tmpArr);
		fnMessageModalAlert("Warning", "확정일이 오늘 일자 이전의 날자가 선택된 항목은 확정처리를 할 수 없습니다.<br>( 지시번호 : " + String(tmpArr) + ")");
		return;
	}
	/***********************************************************************************
	* 선택된 오더 확정 처리(확정 코드(p2) update 및 prod_ord_tbl 데이터 생성)
	***********************************************************************************/
	var page_url = "/sap_master/ziffm_mes_pp011"
				 + "?func_name=" + encodeURIComponent("ZIFFM_MES_PP011")
				 + "&params=" + encodeURIComponent(JSON.stringify(confJsonArr))
				 + "&pdsts=p2";
	
	$.ajax({
		url : page_url,
		type : "POST",
		async:false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnMessageModalAlert("Notification(ProdConfirm)","선택된 생산지시오더 확정을 성공했습니다.");
				/*****************************
				* 광오더 작업자 정보 update
				******************************/
				jocod_proc();
				/*****************************
				* 확정 오더 소요자재 insert
				******************************/
				matr_insert(pordnos);
				/*****************************
				* dmr 정보 update
				******************************/
 				confirm_ord_dmr_update(pordnos);
			} else {
				fnMessageModalAlert("Notification(ProdConfirm)","선택된 생산지시오더 확정을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(ProdConfirm)","선택된 생산지시오더 확정을 실패했습니다.");
		},
		complete : function() {}
	});
	
	fnSearchMasterCodeGrid();
}
	
function matr_insert(pordnos) {
	console.log('matr_insert(',pordnos,')');
	var page_url = "/frontend/prod/matr_insert";
	var postData = "pordnos=" + encodeURIComponent(pordnos);

	$.ajax({
		url : page_url,
		data : postData,
		async:false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnSearchMasterCodeGrid();
			} else {
				fnMessageModalAlert("Notification(matr_insert)", "선택된 생산지시오더의 소요자재 수신에 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(matr_insert)", "선택된 생산지시오더의 소요자재 수신에 실패했습니다.");
		},
		complete : function() {
		}
	});
}

function cofirmOrdChk(pordnos){
	var prod_his_num = null;			//선택 오더의 생산 진행 내역 건수.... 생산 내역이 있으면 미확정 불가.. 
	var page_url = "/frontend/prod/cofirm_ord_chk";
	var postData = "pordnos=" + encodeURIComponent(pordnos);

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				prod_his_num = data.rows.length;
			} else {
				fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더의 생산내역이 확인되지 않습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더의 생산내역이 확인되지 않습니다.");
		},
		complete : function() {
		}
	});
	return  prod_his_num;
}
	
function fnProdOrdNonConfirm() {
	
	/*******************************
	* 선택된 오더 정보 문자열 생성
	********************************/
	$("#grid_role").jqGrid('setGridParam', {cellEdit: false});
	var gridData = $('#grid_role').jqGrid('getRowData');

	var columnNames = $("#grid_role").jqGrid('getGridParam','colNames');
	
	var chks = "", c_date = "", pordnos = "", dateBySeq = "";
	var cnt = 0; //체크한 내역 개수
	var confJsonArr = [];
// 	var confJson = {};
	for (var i = 0; i < gridData.length; i++) {
		
		var confJson = {};
		
		if (gridData[i].chk == 'Y') {
			c_date = "";
			cnt++;
			if (gridData[i].day_0 == 'V') {
				c_date = columnNames[18];
				dateBySeq = trim(gridData[i].day_0_seq);
			} else if (gridData[i].day_1 == 'V') {
				c_date = columnNames[20];
				dateBySeq = trim(gridData[i].day_1_seq);
			} else if (gridData[i].day_2 == 'V') {
				c_date = columnNames[22];
				dateBySeq = trim(gridData[i].day_2_seq);
			} else if (gridData[i].day_3 == 'V') {
				c_date = columnNames[24];
				dateBySeq = trim(gridData[i].day_3_seq);
			} else if (gridData[i].day_4 == 'V') {
				c_date = columnNames[26];
				dateBySeq = trim(gridData[i].day_4_seq);
			} else if (gridData[i].day_5 == 'V') {
				c_date = columnNames[28];
				dateBySeq = trim(gridData[i].day_5_seq);
			} else if (gridData[i].day_6 == 'V') {
				c_date = columnNames[30];
				dateBySeq = trim(gridData[i].day_6_seq);
			}
			confJson['prodNo'] = gridData[i].pordno;
			pordnos += gridData[i].pordno + ',';
			confJson['c_date'] = replaceAll(c_date, "-", "");
			confJson['dateBySeq'] = dateBySeq;
			
			confJson['zmesfirm'] = "2";   //생산 확정시 sap 내 확정지시 수정을 막기위해서 확정일경우1 미확정일경우 2 로 전송한다.
			
			confJsonArr.push(confJson);
			
		}
	}
	
	/*******************************
	* 선택된 오더 확정 내역 확인
	********************************/
	var prod_his_num = cofirmOrdChk(pordnos);
	if(prod_his_num !=  cnt) {
		fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더에 미확정내역이 있습니다.");
		fnSearchMasterCodeGrid();
		return;			
	}
	
	
	
	/*******************************
	* 오더 선택 여부 체크 
	********************************/
	if (pordnos == '') {
		fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더 없습니다.");
		return;
	}
		
	/*******************************************************************
	* 선택된 오더 생산 들어갔는지 체크 (prod_operate_his 내역 확인)
	********************************************************************/
	var prod_his_num = popProdHisChk(pordnos);
	if (prod_his_num != 0) {
		fnMessageModalAlert("Notification(ProdConfirm)", "이미 생산 중인 실적이기 때문에 미확정처리가 불가합니다");
		return;
	}

	/****************************************************************************************************************
	* 미확정 처리...라우팅 처리 된 prod_ord_tbl 데이터 삭제 및 prod_tbl의 pdsts 데이터 p1(지시) 상태로 변경  
	*****************************************************************************************************************/
	var page_url = "/frontend/prod/prod_ord_non_confirm";
	var postData = "pordnos="	+ encodeURIComponent(pordnos.substring(0, pordnos.length - 1));
	postData += "&params=" + encodeURIComponent(JSON.stringify(confJsonArr));
	
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			
			if (data.zifsta == "S") {
				fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더 미확정을 성공했습니다.<br>SAP return : " + data.zifsta + "<br>SAP msg : " + data.zifmsg);
				fnSearchMasterCodeGrid();
				
				/*****************************
				* 확정 오더 소요자재 delete
				******************************/
				matr_delete(pordnos);
			} else {
				fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더 미확정을 실패했습니다.<br>SAP return : " + data.zifsta + "<br>SAP msg : " + data.zifmsg);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더 미확정을 실패했습니다.");
		},
		complete : function() {
		}
	});
}
	
function matr_delete(pordnos) {
	var page_url = "/frontend/prod/matr_delete";
	var postData = "pordnos=" + encodeURIComponent(pordnos);

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnSearchMasterCodeGrid();
			} else {
				fnMessageModalAlert("Notification(matr_insert)", "선택된 생산지시오더의 소요자재 삭제에 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(matr_insert)", "선택된 생산지시오더의 소요자재 삭제에 실패했습니다.");
		},
		complete : function() {
		}
	});
}
	
function popProdHisChk(pordnos) {
	var prod_his_num = null;			//선택 오더의 생산 진행 내역 건수.... 생산 내역이 있으면 미확정 불가.. 
	var page_url = "/frontend/prod/pop_prod_his_chk";
	var postData = "pordnos=" + encodeURIComponent(pordnos);

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				prod_his_num = data.rows.length;
			} else {
				fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더의 생산내역이 확인되지 않습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더의 생산내역이 확인되지 않습니다.");
		},
		complete : function() {
		}
	});
	return  prod_his_num;
}
	
function popProdRoutingChk(pordnos) {
	console.log('popProdRoutingChk()');
	
	var prod_routing_num = null;			//선택 오더의 자재 라우팅 존재 유무 flag.. 라우팅 정보가 없으면 확정불가... 
	var page_url = "/frontend/prod/pop_prod_routing_chk";
	var postData = "pordnos=" + encodeURIComponent(pordnos);

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data == true) {
				prod_routing_num = true;
			} else {
				prod_routing_num = false;	
				fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더 자재의 라우팅정보가 확인되지 않습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더 자재의 라우팅정보가 확인되지 않습니다.");
		},
		complete : function() { }
	});
	return  prod_routing_num;
}

function trim(str) {
	  return str.replace(/^\s+|\s+$/g,'');
}

function getDWkctrList(gubun) {

	initOptions($('#d_wkctr'));
	
	var page_url = "/frontend/prod/wkctr_code_select"
	var postData = 'werks=' + encodeURIComponent(gubun);
				 
	$.ajax({
	    url: page_url,
	    data: postData,
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					
					$('#d_wkctr').append($('<option>', { 
				        value: "",
				        text : "전체" 
				    }));
					
					$.each(data.rows, function (i, item) {
						$('#d_wkctr').append($('<option>', { 
					        value: item.arbpl,
					        text : item.arbpl_nm 
					    }));
					});
				}else{
					
					$('#d_wkctr').append($('<option>', { 
						 value: "",
					        text : "전체" 
					    }));
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
//         .append('<option value="">선택</option>')
        .val();
}

function confirm_ord_dmr_update(pordnos) {
	console.log("confirm_ord_dmr_update("+pordnos+")")
	var page_url = "/frontend/prod/confirm_ord_dmr_update";
	var postData = "pordnos=" + encodeURIComponent(pordnos);

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {

			} else {
				fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더 자재의 DMR 정보 조회에 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더 자재의 DMR 정보 조회에 실패했습니다.");
		},
		complete : function() { }
	});
}

function modal_open() {
		
	$('#jo_select').val('10');
	
	fnSearchJoGrid();
	
	var gridJocodData = $('#grid_jocod_add').jqGrid('getRowData');
	var jocodKeyArr = $('#grid_jocod_add').jqGrid('getDataIDs');
	
	for(var k=0 ; k<jocodKeyArr.length ; k++) {
		if(gridJocodData[k].routing_gno_gubun == "Y")
			$('#'+jocodKeyArr[k]+'_jocod').val("90");
	}

	$("#jocod_add").modal('show');
	
}

function jqgridHighlightFormatterRoutingYn(cellvalue, options, rowObject) {
// 	if (cellvalue != null && cellvalue != "" && cellvalue == "V001") {
	if (rowObject.routing_yn != null && rowObject.routing_yn != "") {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">Y</span>';
	} else {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">N</span>';
		return '';
	}
}

function jqgridHighlightFormatterRoutingGnoYn(cellvalue, options, rowObject) {
	if (rowObject.routing_gno_gubun != null && rowObject.routing_gno_gubun != "" && rowObject.routing_gno_gubun =='Y') {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#6799FF;background-color:#FAF4C0\">포장</span>';
	} else {
		//return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">N</span>';
		return '';
	}
}


function fnSearchJoGrid() {
	console.log("fnSearchJoGrid()");

	$('#grid_jocod_add').jqGrid('clearGridData');

	var rowData = $("#grid_role").getRowData();
	
	for(var i=0 ; i<rowData.length; i++) {
		if (rowData[i].chk == 'Y') {
			$("#grid_jocod_add").jqGrid('addRow',
					{position  :"last", 
					initdata  :  {
						pordno:rowData[i].pordno
						,jidat:rowData[i].jidat
						,itnbr:rowData[i].itnbr
						,pordno_status:rowData[i].pordno_status
						,auart:rowData[i].auart
						,dept_cd:rowData[i].dept_cd
						,wkctr:rowData[i].wkctr
						,routing_gno_gubun:rowData[i].routing_gno_gubun
						}
					}
			);
		}
	}
}

function fnLoadJoGrid() {
	$("#grid_jocod_add").jqGrid({
		datatype: 'json',
		colNames : ['지시번호', '지시일','자재','자재내역', '오더유형', '플랜트', '워크센터', '조', '시리얼번호', 'routing_gno_gubun'],
		colModel : [ 
// 			{name : 'chk', index : 'chk', width : 30, editable : true, align : 'center', edittype : 'checkbox',
// 				multiselect : false,
// 				editoptions : { value : "Y:N", defaultValue : "false"},
// 				formatter : "checkbox",
// 				formatoptions : { disabled : false}}, 
			{name : 'pordno', index : 'pordno', width : 80, sorttype : "text", sortable : true}, 
			{name : 'jidat', index : 'jidat', width : 70, sorttype : "text", sortable : true}, 
			{name : 'itnbr', index : 'itnbr', width : 100, sorttype : "text", sortable : true},
			{name : 'pordno_status', index : 'pordno_status', width : 150, sorttype : "text", sortable : true},
			{name : 'auart', index : 'auart', width : 80, sorttype : "text", sortable : true},
			{name : 'dept_cd', index : 'dept_cd', width : 60, sorttype : "text", sortable : true},
			{name : 'wkctr', index : 'wkctr', width : 80, sorttype : "text", sortable : true},
			{name : 'jocod', index : 'jocod', width : 100, sorttype : "text", editable: true,edittype:"select",editoptions:{value:jocod_list}},
			{name : 'project_no', index : 'project_no', width : 120, sorttype : "text", editable: true,
				editoptions:{
					dataEvents:[
									{
										type:'keydown', fn:function(e){
											if(e.keyCode == 9 || e.keyCode == 13){
												return false;
											}
										}
									}
					            ]
				}
			},
			{name : 'routing_gno_gubun', index : 'routing_gno_gubun', width : 60, sorttype : "text", sortable : true, hidden:true}			
			],
		rowNum : 1000,
		viewrecords : true,
		autowidth : true,
		shrinkToFit : true,
		multiselect : false,
		height : 270,
		altRows : true,
		rownumbers : true,
		cellEdit:true,
		rowEdit:true,
		rownumWidth : 25,
		autoencode : true,
		loadonce : false,
		sortable : true,
		onSelectRow : function(id) {

		},
		loadComplete : function() {}
		});
}

function jo_selectbox_init(){
	var page_url = "/frontend/prod/jo_select";
// 	var code = '';
	
	$.ajax({
		url : page_url,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
 				/******************조 선택 그리드 내 셀렉트박스 설정 : Start******************/
				var r_data = data.rows;
				for(var i=0 ; i<r_data.length; i++) {
					var jocod = r_data[i].jocod;
					var jo_nm = r_data[i].jo_nm;
					var line_nm = r_data[i].line_nm;
					
					jocod_list +=  jocod + ":" + jo_nm +' - ' + line_nm + ";";
				}
				jocod_list = jocod_list.substring(0,jocod_list.length-1);
				/******************조 선택 그리드 내 셀렉트박스 설정 : End******************/
				
				/******************그리드 밖 조 일괄선택 셀렉트박스 설정 : Start******************/
				$.each(r_data, function (i, item) {
						$('#jo_select').append($('<option>', { 
					        value: item.jocod,
					        text : item.jo_nm +' - ' + item.line_nm
					    }));
					});
				/******************그리드 밖 조 일괄선택 셀렉트박스 설정 : End******************/
			} else {
				fnMessageModalAlert("Notification(MES)", "작업자 정보를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "작업자 정보를 가져오지 못했습니다.");
		},
		complete : function() { } 
	});
}

function jocod_proc(){
	
	var keyArr = $('#grid_jocod_add').jqGrid('getDataIDs');
	var rowdata =$('#grid_jocod_add').jqGrid('getRowData');
	
	for(var i=0 ; i<rowdata.length ; i++ ) {
		
		if($('#'+keyArr[i]+'_jocod').val().length == 0) {
			fnMessageModalAlert("Notification(MES)", "조코드를 입력해주세요.");
			return;
		}	
	}
	
	for(var idx=0; idx<rowdata.length; idx++){
		var pordno = rowdata[idx].pordno;
		var jocod =  $('#'+keyArr[idx]+'_jocod').val();
		jocod_update(pordno, jocod);
	}
	
	$("#jocod_add").modal('hide');	
}

function jocod_update(pordno, jocod) {
	
	var page_url = "/frontend/prod/jocod_update";
	var postData = "pordno=" + encodeURIComponent(pordno);
	postData += "&jocod=" + encodeURIComponent(jocod);

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {

			} else {
				fnMessageModalAlert("Notification(MES)", "작업자 조코드 등록에 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "작업자 조코드 등록에 실패했습니다.");
		},
		complete : function() { }
	});
}


function modal_close() {
	$('#grid_jocod_add').jqGrid('clearGridData');
}

function projectNoDupChk(ser_no) {

	var page_url = "/frontend/prod/projectNoDupChk";
	
	var postData = "project_no=" +  encodeURIComponent(ser_no);
	
	var rtn = 0;
	$.ajax({
		url : page_url,
		data : postData,
		async:false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				rtn = data.cnt;
			} else {
				fnMessageModalAlert("Notification(MES)", "생산지시오더의 시리얼 등록 내역 조회에 실패했습니다.");
				return;
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "생산지시오더의 시리얼 등록 내역 조회에 실패했습니다.");
			return;
		},
		complete : function() {
		}
	});
	
	return rtn;
}

function fnSerialChk() {
	var gridJocodData = $('#grid_jocod_add').jqGrid('getRowData');
	var jocodKeyArr = $('#grid_jocod_add').jqGrid('getDataIDs');
	var msg = "";
	var rtn = 0;
	for(var k=0 ; k<jocodKeyArr.length ; k++) {
			 var ser_no = $('#'+jocodKeyArr[k]+'_project_no').val();	
			 if(ser_no.length > 0) {
			 	rtn = projectNoDupChk(ser_no);
			 } else {
				rtn = 0;
			 }
			 if(rtn == 0) {
				 //msg = "시리얼 번호(" + $('#'+jocodKeyArr[k]+'_project_no').val() + ")를 등록합니다. <br>"
			 } else {
				 msg = msg + "* 시리얼 번호(<font color='red'>" + ser_no + "</font>)는 이미 등록된 시리얼입니다. <br>"
			 }
			 
// 			 if( msg.length > 0 ) {
// 				 fnProdOrdConfirmMsgBox(msg);
// 			 } else {
// 				 fnProdOrdConfirm(); 
// 			 }
	}
	 if( msg.length > 0 ) {
		 fnProdOrdConfirmMsgBox(msg);
	 } else {
		 fnProdOrdConfirm(); 
	 }
}

function fnProdOrdConfirmMsgBox(msg){
	fnMessageModalConfirm("Notification(MES)", msg + "<br> 확정을 계속 진행하시겠습니까?", function(chk){
		if(chk){
			fnProdOrdConfirm();
		}
	});
}
</script>
</body>
</html>