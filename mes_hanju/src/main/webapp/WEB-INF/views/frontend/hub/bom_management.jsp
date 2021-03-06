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

<body class="hold-transition skin-<%=thema%> sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1020" />
		<jsp:param name="selected_menu_cd" value="1022" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        HUB
        <small>BOM 관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> HUB</a></li><li class="active">BOM 관리</li>
      </ol>
    </section>
  	<section class="content" style="padding-bottom: 0px;">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px;">
					<div class="box-header with-border">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
<!-- 							<button type="button" id="btn_sync_sap" class="btn btn-primary btn-sm" onclick="$('#modal_sap_sync').modal('show');">SAP 동기화</button> | -->
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-primary btn-sm">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
									<label>플랜트</label>
									<select id="sel_dept_cd" class="form-control select2 input-sm" style="width: 100%;">
										<option value="">전체</option>
										<option value="1110">의료영상 </option>
										<option value="1210">광영상 </option>
									</select>
			                    </div> 
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>BOM 전개일자</label>
									<div class="input-group">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right input-sm" id="serch_date_range">
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>자재번호</label>
									<input type="input" id="matnr_num" name="matnr_num" class="form-control input-sm" placeholder="ex) 10010010010" maxlength="30">
								</div>
							</div>
							<div class="col-sm-12 text-left" style="font-weight:bold; padding-left: 15px;">
								<i class="fa fa-check" aria-hidden="true"></i>Material 생성 정보가 없는경우 BOM 조회가 되지 않습니다.
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div id="grid_role" style="width: 100%; height: 535px;"></div>
						<div id="pagination" class="text-center"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
<!--   <div class="modal fade" id="modal_sap_sync" data-backdrop="static"> -->
<!-- 	<div class="modal-dialog modal-md"> -->
<!-- 		<div class="modal-content"> -->
<!-- 			<div class="modal-header"> -->
<!-- <!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- <!-- 					<span aria-hidden="true">&times;</span> -->
<!-- <!-- 				</button> -->
<!-- 				<h4 class="modal-title" id="modal_code_title">BOM마스터 동기화</h4> -->
<!--         	</div> -->
<!-- 			<div class="modal-body" id="modal_code_body"> -->
<!-- 				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal"> -->
<!-- 					<div class="form-group"> -->
<!-- 						<label for="" class="col-sm-3 control-label">플랜트</label> -->
<!-- 						<div class="col-sm-7"> -->
<!-- 							<select id="isel_dept_cd" class="form-control select2 input-sm"> -->
<!-- 								<option value="1110">의료영상 </option> -->
<!-- 								<option value="1210">광영상 </option> -->
<!-- 						    </select> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="form-group"> -->
<!-- 						<label for="" class="col-sm-3 control-label">동기일자</label> -->
<!-- 						<div class="col-sm-7"> -->
<!-- 							<div class="input-group"> -->
<!-- 								<div class="input-group-addon"> -->
<!-- 									<i class="fa fa-calendar"></i> -->
<!-- 								</div> -->
<!-- 								<input type="text" class="form-control pull-right input-sm" id="request_date_range"> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-md-12" id="msg" style="font-weight:bold; color:blue;"></div> -->
<!-- 					</div> -->
<!-- 				</form> -->
<!-- 			</div> -->
<!-- 			<div class="modal-footer"> -->
<!-- 				<div class="col-md-12 text-center"> -->
<!-- 					<button type="button" id="btn_confirm" class="btn btn-sm btn-success" onclick="confirmSapSync();">확인</button> -->
<!-- 					<button type="button" id="btn_close" class="btn btn-sm btn-default" data-dismiss="modal">닫기</button> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->

  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>
<!-- ./wrapper -->
<script src="/res/plugins/pagination.js"></script>
<script type="text/javascript">
//for pagination
var page = 1; 		// 화면에서 사용할 page
var pageNum = 0; 	// 서버에 넘겨줄 page -> mysql 은 0 부터 시작
var rowPerPage = 20;
var rowLength = 0;
var totalPage = 0;
var cntRowPagination = 5;	// << 1 2 3 4 5 >>

var selected_pordno_pop;

$(function($) {
 	fnLoadCommonOption();
 	fnLoadRoleGrid();
 	loadList();
})

function fnLoadCommonOption() {
	$("#serch_date_range").pressEnter(function(e) {
		e.preventDefault();
		if(e.target.id == "serch_date_range"){
			loadList();
		}
	});
	
	$('#serch_date_range').daterangepicker({
		 locale: {
			format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
			,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
			,showMonthAfterYear: true
			,yearSuffix: '년'
			,orientation: "top left"
	    }
	});
	
	$('#request_date_range').daterangepicker({
		 locale: {
			format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
			,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
			,showMonthAfterYear: true
			,yearSuffix: '년'
			,orientation: "top left"
	    }
	});
	
	initScreenSizeModal();
}

//serch parameter setting
// function fnSetSelectBomGrid(){
function loadList(pageNum){
// 	console.log('loadList()');
	
	if( pageNum==undefined ){
		page=1;
		pageNum = 0;
	} else {
		page=pageNum;
// 		pageNum = pageNum-1;
		pageNum = (pageNum-1)*rowPerPage;
	}
	
	var date1 = $("#serch_date_range").val().substring(0,10);
	var rowArr = [];
	var page_url = "/frontend/hub/selectBomtbl"
				 + "?matnr="  + encodeURIComponent($('#matnr_num').val())    
				 + "&iv_date=" + encodeURIComponent(date1)
				 + "&werks=" + encodeURIComponent($('#sel_dept_cd').val())
				 + "&page="+ encodeURIComponent(pageNum)
				 + "&rows="+ encodeURIComponent(rowPerPage);
	
	w2ui['grid_role'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				if(data.pageTotal == 0){
					$("#pagination").empty();
				} else {
					totalPage = data.pageTotal;
					pagination();
				}
				w2ui['grid_role'].records = rowArr;
				w2ui['grid_role'].total = data.rowTotal;
			}
			w2ui['grid_role'].refresh();
			w2ui['grid_role'].unlock();
		},complete: function () {}
	});
}

function fnLoadRoleGrid(){
// 	console.log('fnLoadRoleGrid()');
	var rowArr = [];
	$("#grid_role").w2grid({
		name : 'grid_role',
		show : {
			lineNumbers : true,
            footer: true
        },
        columns : [
			{ field:'matnr', caption:'자재번호', size:'100px'},
			{ field:'werks', caption:'플랜트', size:'70px', render:function(record, index, col_index){
				if (this.getCellValue(index, col_index)=='1110')
					return '의료';
				else
					return '광영상';
			}, style:'text-align:center'},
			{ field:'stlan', caption:'용도', hidden:true},	//key:true
			{ field:'stlal', caption:'대체', hidden:true},
			{ field:'stufe', caption:'경로', size:'50px'},
			{ field:'maktx', caption:'최상위품명', size:'250px'},
			{ field:'zmatnr', caption:'모품목', size:'250px'},
			{ field:'zmaktx', caption:'모품명', size:'250px'},
			{ field:'idnrk', caption:'자품목', size:'200px'},
			{ field:'ojtxp', caption:'자품명', size:'250px'},
			{ field:'menge', caption:'수량', size:'70px', render:'int'},
			{ field:'meins', caption:'단위', size:'50px', style:'text-align:center'},
			{ field:'sortf', caption:'문자정렬식', hidden:true},
			{ field:'potx1', caption:'라인1', hidden:true},
			{ field:'schgt', caption:'BOM벌크', hidden:true},
			{ field:'mschg', caption:'자재벌크', hidden:true},
			{ field:'sobsl', caption:'특별조달유형(자재)', size:'210px'},
			{ field:'sobsk', caption:'특별조달유형(BOM)', size:'210px', style:'text-align:center'},
			{ field:'sernp', caption:'일련번호', size:'70px', render:function(record, index, col_index){
				if (this.getCellValue(index, col_index)=='V001')
					return '대상';
				else
					return '비대상';
			}, style:'text-align:center'},
			{ field:'datuv', caption:'효력 시작일', size:'80px', style:'text-align:center'},
			{ field:'aennr', caption:'변경번호 시작', size:'80px', style:'text-align:center'},
			{ field:'datub', caption:'효력 종료일', size:'80px', style:'text-align:center'},
			{ field:'aenra', caption:'변경번호 종료', size:'80px', style:'text-align:center'} ],
		sortData: [{field: 'matnr', direction: 'ASC'}],
		records: [],
		total : 0,
		onReload: function(event) {},
		onClick: function (event) {}
	});
	w2ui.grid_role.recordHeight = 30;
	pordno = "";
}
	
function confirmSapSync(){
	$("#btn_confirm").prop("disabled", true);
	$("#btn_close").prop("disabled", true);
	$("#msg").text("동기화 작업 중...");
	
	var date1 = $("#request_date_range").val().substring(0,10);
	date1 = replaceAll(date1, "-", "");
 
	var page_url = "/sap_master/ziffm_mes_pp002"
				 + "?func_name=ZIFFM_MES_PP002"
				 + "&IV_MATNR="  + encodeURIComponent($('#imatnr_num').val())    
				 + "&IV_DATE=" + encodeURIComponent(date1)
				 + "&IV_WERKS=" + encodeURIComponent($('#isel_dept_cd').val())
				 + "&IV_IF=X" ;

	$.ajax({
		url:page_url,
		type:'POST',
		success : function(data, textStatus, jqXHR) {
		  	if(data.status == 200) {
		  		fnMessageModalAlert("Success",data.message);
		  	} else {
		  		fnMessageModalAlert("Warning","SAP와 동기화를 실패했습니다.");
		  	}
		  	$("#btn_confirm").prop("disabled", false);
			$("#btn_close").prop("disabled", false);
			$("#msg").text("");
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Fail","SAP와 동기화를 실패했습니다.");
		},
		complete: function () {}
	});
}

function formatOpt1(cellvalue, options, rowObject){ 
	var pordno_pop = '\'' + rowObject.pordno_pop + '\'';
	var pordno_status = '\''+ rowObject.pordno_status + '\'';
	
	return '<input type="button" onclick="mng_fault('+pordno_pop+','+pordno_status+')" class="btn btn-danger btn-sm" value="수정" /> '+ rowObject.pordno_status.substring(0, 20) + '.....';
}

function mng_fault(pordno_pop, pordno_status ) {
	$("#m_pordno").val(pordno_pop);
	$("#pordno_status").val(pordno_status);
	$("#modal_mcode").modal('show');
}
	
function fnSaveMemo(){
 	var postData = $("#frm_mcode").serializeArray();
	var formURL = "/frontend/prod/faultMemo_update";
  
	$.ajax({
    	url : formURL,
    	type: "POST",
    	data : postData,
    	success:function(data, textStatus, jqXHR){
	      	if(data.status == "200") {
	      		fnMessageModalAlert("Notification(Menu)", "입력하신 내용를 저장했습니다.");
	      		$("#modal_mcode").modal('hide');
	      		fnSearchMasterCodeGrid();
	      	} else {
	      		fnMessageModalAlert("Notification(Menu)", "메뉴를 저장하는데 에러가 발생하였습니다.");	
	      	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(Menu)", "메뉴를 저장하는데 에러가 발생하였습니다.");	
	    }
	});
}



</script>

</body>
</html>