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
			<section class="content" style="padding-bottom: 0px;">
			<div class="box" style="margin-bottom: 0px;height: 790px;">
				<div class="box-body"><!-- start box body -->
					<div class="row" style="margin-bottom:10px;">
						<div class="col-md-12">
							<div class="col-sm-2">
								<div class="form-group">
									<label>| 지시일자</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right input-sm" id="s_jidat">
									</div>
								</div>
							</div>
							<div class="col-sm-1">
								<div class="form-group">
									<label>| 오더유형</label> 
									<select id="s_auart" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
											<option value="">전체</option>
											<option value="prod">생산</option>
											<option value="repr">재작업</option>
										</select>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>| 지시번호</label> 
									<input type="input" id="s_pordno" name="s_pordno" class="form-control input-sm" placeholder="ex) 1001001" maxlength="30">
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>| 품목코드</label> 
									<input type="input" id="s_itnbr" name="s_itnbr" class="form-control input-sm" placeholder="ex) HV2002" maxlength="30">
								</div>
							</div>
<!-- 							<div class="col-sm-2" style="display:none;"> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label>| 상태</label>  -->
<!-- 									<input type="input" id="s_pdsts" name="s_pdsts" class="form-control input-sm" placeholder="ex) REL  PCNF DLV  PRC  GMCO MANC SETC" maxlength="50"> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 							<div class="col-sm-1"> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label>| 상태</label><br />  -->
<!-- 									<select id="prod_confirm_chk" class="form-control input-sm input-sm"> -->
<!-- 										<option value="">전체</option> -->
<!-- 										<option value="p2">확정</option> -->
<!-- 										<option value="p1">미확정</option> -->
<!-- 									</select> -->
<!-- 								</div> -->
<!-- 							</div> -->
						</div>
					</div>
					<div class="row" style="margin-bottom:10px;">
						<div class="col-md-12 text-right">
							<button type="button" id="" onclick="fnPopupInfo('C');" class="btn btn-success btn-sm">확정</button>
							<button type="button" id="" onclick="fnPopupInfo('U');" class="btn btn-success btn-sm">수정</button>
							<button type="button" id="" onclick="loadList();" class="btn btn-primary btn-sm">조회</button>
							<button type="button" id="" onclick="fnDownload();" class="btn btn-warning btn-sm">Excel Download</button>
							<button type="button" id="" onclick="fnUpload();" class="btn btn-success btn-sm">등록(Excel Upload)</button>
						</div>
					</div>
					<div class="row"> <!--  grid  -->
						<div class="col-md-12">
							<div id="grid_plan" style="width: 100%; height: 600px;"></div>
<!-- 							<div id="pagination" class="text-center"></div> -->
						</div>
					</div>
				</div>
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
</div>

<!-- confirm modal -->
<div class="modal fade" id="modal_conf" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modal_conf_title">생산계획 확정</h4>
        	</div>
			<div class="modal-body" id="modal_conf_body">
				<div class="box-body">
					<div class="row">
				    	<div class="col-sm-4">
							<div class="form-group">
								<label>| 확정일자</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right input-sm" id="m_cmdat">
								</div>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<label>| 확정작업순서</label>
								<input type="number" id="m_cmdat_seq" name="m_cmdat_seq" class="form-control input-sm" placeholder="" maxlength="30">
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer" style="padding-bottom: 0px;">
					<div class="col-md-12 text-center">
						<button type="button" id="btn_mat_save" class="btn btn-success btn-sm" onclick="fnConfirm();">확정</button>
						<button type="button" id="btn_mat_cancel" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
					</div>
				</div>
	        </div>
		</div>
	</div>
</div>

<!-- start modal jocod add-->
  <div class="modal fade" id="modal_new" data-backdrop="static">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="modal_close()">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">생산계획 등록</h4>
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

<!-- <script src="/res/plugins/pagination.js"></script> -->
<script type="text/javascript">
//for pagination
/* var page = 1; 		// 화면에서 사용할 page
var pageNum = 0; 	// 서버에 넘겨줄 page -> mysql 은 0 부터 시작
var rowPerPage = 20;
var rowLength = 0;
var totalPage = 0;
var cntRowPagination = 5;	// << 1 2 3 4 5 >>  */

var opt = { 'pdsts' : {'p1':'지시', 'p2':'확정', 'p3':'작업시작', 'p4':'비가동', 'p5':'재가동', 'p6':'종료', 'p7':'재작업지시', 
						'p8':'생산완료', 'p9':'최종검사합격', 'p10':'최종검사불합격', 'p11':'출하검사합격', 'p12':'출하검사 불합격', 
						'p13':'공정검사대기', 'p14':'공정강제종료'},
			'ji_gubun' : {'i1':'일반', 'i2':'긴급'},
			'auart' : {'prod':'생산', 'repr':'재작업'} };
			
function makeOptions(colnm, loc) {
// 	console.log('makeOptions(',colnm,')');
	initOptions('#'+loc);
	var itemArr = opt[colnm];
	$.each(itemArr, function(key, val){
		//.append('<option value="">선택</option>')
		$("#"+loc).append("<option value=" + key + ">" + val + "</option>");
	});
// 	makeOptions('pdsts', 's_pdsts');
}

$(function($) {
// 	jo_selectbox_init();
	fnDateInit();
	fnLoadCommonOption();
	fnInitGridProd();
// 	fnLoadRoleGrid();
// 	fnLoadJoGrid();
// 	initScreenSizeModal();
})

function fnLoadCommonOption() {
	/* 
	$('input[type="radio"].flat-red').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green',
		handle: 'radio'
	});
	
	$("#csr_register_date_range").pressEnter(function(e) {
		e.preventDefault();
		if(e.target.id == "csr_register_date_range"){
			fnSearchMasterCodeGrid();
		}
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
	 */
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
	
	$('#s_jidat').daterangepicker({
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
	$('#m_cmdat').daterangepicker({
		opens: 'right', 
		singleDatePicker: true,
		locale: {
			format: 'YYYY-MM-DD', // inputbox 에 '2011/04/29' 로표시
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
			showMonthAfterYear: true,
			yearSuffix: '년',
			orientation: "top left"
		},
		startDate : moment(minDate)
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

function fnGetDate(d) {	
	//mindate + d 한 날짜 반환
	mdTemp = new Date(), 
	fgd_date = getFormatDate(new Date(mdTemp.setDate(mdTemp.getDate() + d)));
	return fgd_date;
}

function fnInitGridProd(){
// 	console.info('fnInitGridProd()');
	/* var date1 = $("#csr_register_date_range").val().substring(0,10);
	date1 = replaceAll(date1, "-", "");
	var date2 = $("#csr_register_date_range").val().substring(13,23);
	date2 = replaceAll(date2, "-", ""); */
	// 지시번호
// 	var pordno = $("#pordno").val();
	// 작업품명
// 	var pordno_status = $('#pordno_status').val();
	// 확정여부
// 	var chkVal = $(":input:radio[name=rdo_prod_confirm_chk]:checked").val();
// 	var chkVal = $("#prod_confirm_chk").val();
	/* 
	var page_url = "/sap_master/ziffm_mes_pp003"
				 + "?func_name=" + encodeURIComponent("ZIFFM_MES_PP003")
				 + "&IV_FDATE=" + encodeURIComponent(date1)
				 + "&IV_TDATE=" + encodeURIComponent(date2)
				 + "&jidat_from=" + encodeURIComponent(date1)
				 + "&jidat_to=" + encodeURIComponent(date2)
				 + "&pordno=" + encodeURIComponent(pordno)
				 + "&pordno_status=" + encodeURIComponent(pordno_status)
				 + "&pdsts=" + encodeURIComponent(chkVal);
// 				 + "&dept_cd=" + encodeURIComponent($("#m_wkctr").val())
			     + "&auart=" + encodeURIComponent($("#auart").val());
				  */
// 	$('#warningTxt').text('확정 시 ' + fnGetDate(0) + ' ~ ' + fnGetDate(6) + ' 사이의 일자를 선택해야 합니다.(필수)');
	$("#grid_plan").w2grid({
		name : 'grid_plan',
		show : {
			lineNumbers : true,
            footer: true
        },
        multiselect : false,
        columns : [
			{ field:'pordno', caption:'생산지시번호', size:'10%'} , 
			{ field:'pordno_child', caption:'자식키 기본 ', size:'10%'} , 
			{ field:'pdsts', caption:'상태 코드', size:'10%'} , 
			{ field:'ji_gubun', caption:'긴급여부', size:'10%'} , 
			{ field:'jidat', caption:'지시일자', size:'10%'} , 
			{ field:'sedat', caption:'예정일자', size:'10%'} , 
			{ field:'cmdat', caption:'확정일', size:'10%'} , 
			{ field:'cmdat_seq', caption:'확정 작업순서', size:'10%'} , 
			{ field:'itnbr', caption:'품목코드', size:'10%'} , 
			{ field:'itnbr_spec', caption:'품목spec', size:'10%'} , 
			{ field:'serno', caption:'시리얼번호', size:'10%'} , 
			{ field:'sernp', caption:'시리얼대상여부', size:'10%'} , 
			{ field:'dept_cd', caption:'부서코드', size:'10%'} , 
			{ field:'project_no', caption:'프로젝트코드', size:'10%'} , 
			{ field:'pdqty', caption:'수량', size:'10%'} , 
			{ field:'auart', caption:'오더유형', size:'10%'} , 
			{ field:'lgort', caption:'창고', size:'10%'}  
		],
		sortData: [{field: 'pordno', direction: 'ASC'}],
		records: [],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},
		onDblClick: function(event) {}
	});
	loadList();
}

function loadList(pageNum){
	console.log('loadList()');
	/* 
	var beforePage = page; 
	if( pageNum==undefined ){
		page=1;
		pageNum = 0;
	} else {
		page=pageNum;
		pageNum = (pageNum-1)*rowPerPage;
	} */
	var jidat = $("#s_jidat").val();
	var page_url = "/frontend/prod_tbl_select"
				 + "?pordno=" + encodeURIComponent($("#s_pordno").val())
				 + "&f_jidat=" + encodeURIComponent(jidat.substr(0,10))
				 + "&t_jidat=" + encodeURIComponent(jidat.substr(13))
				 + "&auart=" + encodeURIComponent($("#s_auart").val())
				 + "&itnbr=" + encodeURIComponent($("#s_itnbr").val());
// 				 + "&page="+ encodeURIComponent(pageNum)
// 				 + "&rows="+ encodeURIComponent(rowPerPage);
	
	w2ui['grid_plan'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		async : false,
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
// 				if(data.pageTotal == 0){
// 					$("#pagination").empty();
// 				} else {
// 					totalPage = data.pageTotal;
// 					pagination();
// 				}
				w2ui['grid_plan'].records = rowArr;
				w2ui['grid_plan'].total = data.rowTotal;
			} else if(data.status == 200 && (data.rows).length == 0) {
				w2ui.grid_plan.clear();
// 				$("#pagination").empty();
			}
			w2ui['grid_plan'].refresh();
			w2ui['grid_plan'].unlock();
		},complete: function () {}
	});
}

function fnConfirm() {
	console.log('fnConfirm()');
	$("#modal_conf").modal('hide');
}

function fnPopupInfo(flag) {
	console.log('fnPopupInfo(' + flag + ')');
	/* 
	$("#MC1010_1").val('');
	$("#p_matnr").val('');
	$("#p_meins").val('');
	$("#p_maktx").val('');
	$("#p_wrkst").val('');
	$("#p_price").val('');
	$("#p_ntgew").val('');
	$("#p_brgew").val('');
	$("#MC1011_1").val(''); */
	
	if( flag=='I' ) {
		$("#modal_new").modal('show');
		
		/* 
		$("#modal_title").text('자재 신규 등록');
		$("#MC1010_1").attr('disabled', false);
		$("#p_matnr").attr('disabled', false);
		$("#p_meins").attr('disabled', false);
		$("#p_maktx").attr('disabled', false);
		$("#p_wrkst").attr('disabled', false);
		$(":radio[name=p_lvorm][value=N]").iCheck("check");
		$(":radio[name=p_kzumw][value=N]").iCheck("check");
		$(":radio[name=p_iloos][value=N]").iCheck("check");
		$(":radio[name=p_ihivi][value=N]").iCheck("check");
		$("#p_gewei").attr('disabled', false);
		$("#p_price").attr('disabled', false);
		$("#p_ntgew").attr('disabled', false);
		$("#p_brgew").attr('disabled', false);
		$("#MC1011_1").attr('disabled', false); */
	} else if( flag=='U' ) { 
		/* var selIdxArr = w2ui.grid_matnr.getSelection();
		var chkLen = selIdxArr.length;
		if( chkLen==0 ) {
			fnMessageModalAlert('Alert', '수정할 항목을 목록에서 선택해야 합니다.');			
		} else if( chkLen>1 ) {
			fnMessageModalAlert('Alert', '수정할 항목은 목록에서 1개 선택해야 합니다.');
		} else { // chkLen==1
			var selData = w2ui.grid_matnr.get(selIdxArr[0]);
			/* 
  			var p_mtart,p_wgbez = "";
  			$.each(selArrObj.MC1010, function(idx, obj){
  				if( selData.mtart==obj.detail_code ) p_mtart = obj.dcode_nm;
  			});
  			$.each(selArrObj.MC1011, function(idx, obj){
  				if( selData.wgbez==obj.detail_code ) p_wgbez = obj.dcode_nm;
  			});
  			
  			console.log(p_mtart, p_wgbez); */
  			/*
			$("#p_brgew").val(selData.brgew);
			$("#p_gewei").val(selData.gewei);
			$("#p_maktx").val(selData.maktx);
			$("#p_matnr").val(selData.matnr);
			$("#p_meins").val(selData.meins);
			$("#MC1010_1").val(selData.mtart);
// 			$('select[name="MC1010_1"]').find('option[value="'+selData.mtart+'"]').attr("selected",true);
			$("#p_ntgew").val(selData.ntgew);
			$("#p_price").val(selData.price);
			$("#MC1011_1").val(selData.wgbez);
// 			$('select[name="p_wgbez"]').find('option[value="'+selData.wgbez+'"]').attr("selected",true);
			$("#p_wrkst").val(selData.wrkst);
		
			$(":radio[name=p_lvorm][value="+selData.lvorm+"]").iCheck("check");
			$(":radio[name=p_kzumw][value="+selData.kzumw+"]").iCheck("check");
			$(":radio[name=p_iloos][value="+selData.iloos+"]").iCheck("check");
			$(":radio[name=p_ihivi][value="+selData.ihivi+"]").iCheck("check");
			
			$("#modal_info").modal('show');
			$("#modal_title").text('수정');
			
			$("#MC1010_1").attr('disabled', false);
			$("#p_matnr").attr('disabled', true);
			$("#p_meins").attr('disabled', false);
			$("#p_maktx").attr('disabled', false);
			$("#p_wrkst").attr('disabled', false);
			
			$("#p_gewei").attr('disabled', false);
			$("#p_price").attr('disabled', true);
			$("#p_ntgew").attr('disabled', false);
			$("#p_brgew").attr('disabled', false);
			$("#MC1011_1").attr('disabled', false);
		} */
	} else if( flag=='C' ) { 
		var selIdx = w2ui.grid_plan.getSelection();
		if( selIdx==0 ) {
			fnMessageModalAlert('Alert', '확정할 항목을 목록에서 선택해야 합니다.');
			return;
		} else {
			var selData = w2ui.grid_plan.get(selIdx[0]);
			console.log(selData);
			$("#modal_conf").modal('show');
			// popup을 띄워 확정일, 확정 작업순서를 입력받는다.
			// 확정일 입력받은 후 생산 실행으로 이동
		}
	}
}

function trim(str) {
	  return str.replace(/^\s+|\s+$/g,'');
}

function initOptions(obj) {
    $(obj)
        .find('option')
        .remove()
        .end()
//         .append('<option value="">선택</option>')
        .val();
}
</script>
</body>
</html>