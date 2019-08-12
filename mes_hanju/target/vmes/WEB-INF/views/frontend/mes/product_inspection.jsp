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
		<jsp:param name="selected_menu_cd" value="1033" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        MES
        <small>생산품질검사(자주검사)</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> MES</a></li><li class="active">생산품질검사(자주검사)</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
     	<div class="row">
     		<div class="col-md-6">
     			<div class="box" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">그룹정보</h3>
						<div class="box-tools pull-right">
							<div class="form-group">
								<button type="button" id="" onclick="loadGroupMaster();" class="btn btn-primary btn-sm">조회</button>   
								<button type="button" id="" onclick="editGroupPopup();" class="btn btn-primary btn-sm">수정/삭제</button>   
								<button type="button" id="" onclick="openModalIntGroup()" class="btn btn-primary btn-sm">추가</button>   
							</div>
						</div>
					</div>
					<div class="box-body" style="padding-bottom: 0px;">
						<div class="row">
							<div class="col-sm-3">
							    <div class="form-group" style="margin-bottom: 0px;">
									<label>| 그룹코드</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="gr_no">
									</div>
								</div>
							</div>
							<div class="col-sm-3">
							    <div class="form-group" style="margin-bottom: 0px;">
									<label>| 그룹명</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="gr_nm">
									</div>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 자재코드</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" class="form-control pull-right input-sm" id="matnr">
									</div>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 사용여부</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="use_yn" class="form-control input-sm">
											<option value="">전체</option>
											<option value="Y">사용</option>
											<option value="N">미사용</option>
										</select>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-body">
						<div id="grid_group" style="width: 100%; height: 640px;"></div>
					</div>
				</div>
     		</div>
     		<div class="col-md-6">
     			<div class="row">
     				<div class="col-md-12" style="padding-left: 0px;">
     				<div class="box">
						<div class="box-header with-border">
							<h3 class="box-title">이력카드</h3>
							<div class="box-tools pull-right">
								<div class="form-group">
									<button type="button" id="btn_edit_header" onclick="editHeaderPopup();" class="btn btn-primary btn-sm">수정/삭제</button>   
									<button type="button" id="btn_add_header" onclick="newHeaderPopup();" class="btn btn-primary btn-sm">새 이력카드 추가</button>   
								</div>
							</div>
						</div>
						<div class="box-body" style="padding: 0px;">
							<div id="grid_header" style="width: 100%; height: 330px;"></div>
						</div>
					</div>
					</div>
     			</div>
     			<div class="row">
     				<div class="col-md-12" style="padding-left: 0px;">
     				<div class="box" style="margin-bottom: 0px;">
						<div class="box-header with-border">
							<h3 class="box-title">검사정보</h3>
							<div class="box-tools pull-right">
								<div class="form-group">
									<button type="button" id="btn_edit_detail" onclick="editDetailPopup();" class="btn btn-primary btn-sm">수정/삭제</button>   
									<button type="button" id="btn_add_detail" onclick="newDetailPopup();" class="btn btn-primary btn-sm">새 검사정보 추가</button>   
								</div>
							</div>
						</div>
						<div class="box-body" style="padding: 0px;">
							<div id="grid_detail" style="width: 100%; height: 330px;"></div>
						</div>
					</div>
					</div>
     			</div>
     		</div>
     	</div>
    </section>
    <!-- /.content -->
  </div>
<div class="modal fade" id="edit_group" data-backdrop="static">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">그룹정보 수정/삭제</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12">
						<form id="frm_product" name="frm_product" class="form-horizontal">
						<div class="form-group">
							<label for="master_gr_no" class="col-sm-3 control-label text-right">그룹코드</label>
							<div class="col-sm-8">
								<input type="text" class="form-control pull-right input-sm" id="master_gr_no" name="master_gr_no" readonly>
							</div>
						</div>
						<div class="form-group">
							<label for="master_seq" class="col-sm-3 control-label text-right">순번</label>
							<div class="col-sm-8">
								<input type="text" class="form-control pull-right input-sm" id="master_seq" name="master_seq" readonly>
							</div>
						</div>
						<div class="form-group">
							<label for="master_gr_nm" class="col-sm-3 control-label text-right">그룹명</label>
							<div class="col-sm-8">
								<input type="text" class="form-control pull-right input-sm" id="master_gr_nm" name="master_gr_nm">
							</div>
						</div>
						<div class="form-group">
							<label for="matnr" class="col-sm-3 control-label text-right">자재</label>
							<div class="col-sm-8">
								<div class="input-group input-group-sm" style="width: 270px;float: left;">
									<input type="text" id="g_matnr" name="g_matnr" class="form-control pull-right" placeholder="검색 후 선택">
									<div class="input-group-btn">
				                    	<button type="button" id="" class="btn btn-default" onclick="openMatnrModal('g_matnr');"><i class="fa fa-search"></i></button>
									</div>
				                </div>
				            </div>
						</div>
						<div class="form-group">
							<label for="master_gr_nm" class="col-sm-3 control-label text-right">사용유무</label>
							<div class="col-sm-8">
								<select id="use_yn_edit" name="use_yn_edit" class="form-control input-sm">
									<option value="Y">사용</option>
									<option value="N">미사용</option>
								</select>
								<span style="color:red;font-weight:bold;">* 삭제하고자 하는 경우 사용유무를 [미사용]으로 선택하시기 바랍니다.</span>
				            </div>
						</div>
						</form>
					</div>
				</div>
	        </div>
	        <div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_upt_group" class="btn btn-success btn-sm" onclick="updateGroupInfo();">수정</button>
					<button type="button" id="btn_upt_group_cancel" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="edit_header" data-backdrop="static">
    <div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">이력정보 수정/삭제</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12 text-right">
						<button type="button" class="btn btn-primary btn-sm" onclick="updateHeaderAddItem();">항목 추가</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="updateHeaderDelItem();">추가한 항목 삭제</button>
						<br>
						<span>삭제 항목은 사용유무 "N"으로 변경 후 저장하시기 바랍니다.</span>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div id="grid_uptHeader" style="width: 100%; height: 330px;"></div>
					</div>
				</div>
	        </div>
	        <div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_upt_group" class="btn btn-success btn-sm" onclick="updateHeaderInfo();">수정</button>
					<button type="button" id="btn_upt_group_cancel" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="int_header" data-backdrop="static">
    <div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
				<h4 class="modal-title" id="modal_code_title">새 이력카드 추가</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12 text-right">
						<button type="button" class="btn btn-primary btn-sm" onclick="insertHeaderAddItem();">추가</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="insertHeaderDelItem();">삭제</button>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div id="grid_intHeader" style="width: 100%; height: 330px;"></div>
					</div>
				</div>
	        </div>
	        <div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_int_header" class="btn btn-success btn-sm" onclick="insertHeaderInfo();">저장</button>
					<button type="button" id="btn_int_header_cancel" onClick="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="int_detail" data-backdrop="static">
    <div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
				<h4 class="modal-title" id="modal_code_title">새 검사정보 추가</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12 text-right">
						<button type="button" class="btn btn-primary btn-sm" onclick="insertDetailAddItem();">추가</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="insertDetailDelItem();">삭제</button>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div id="grid_intDetail" style="width: 100%; height: 330px;"></div>
					</div>
				</div>
	        </div>
	        <div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_int_detail" class="btn btn-success btn-sm" onclick="insertDetailInfo();">저장</button>
					<button type="button" id="btn_int_detail_cancel" onclick="w2ui['grid_intDetail'].destroy();" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="int_group" data-backdrop="static">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
				<h4 class="modal-title" id="modal_code_title">그룹정보 추가</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_product" name="frm_product" class="form-horizontal">
				<div class="row">
					<div class="form-group">
						<label for="master_seq" class="col-sm-3 control-label text-right">선택</label>
						<div class="col-sm-7">
							<select id="gubun" name="gubun" class="form-control input-sm text-center">
								<option value="group">신규 그룹추가</option>
								<option value="matnr">기존 그룹에 자재 추가</option>
							</select>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="form-group" id="group_code" style="display:none;">
							<label for="master_gr_no_select" class="col-sm-3 control-label text-right">그룹코드</label>
							<div class="col-sm-8">
<!-- 								<input type="text" class="form-control pull-right input-sm" id="master_gr_no" name="master_gr_no" readonly> -->
								<select id="master_gr_no_select" class="form-control input-sm text-center">
									<option>선택</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="master_gr_nm_int" class="col-sm-3 control-label text-right">그룹명</label>
							<div class="col-sm-8">
								<input type="text" class="form-control pull-right input-sm" id="master_gr_nm_int" name="master_gr_nm_int">
							</div>
						</div>
						<div class="form-group">
							<label for="matnr" class="col-sm-3 control-label text-right">자재</label>
							<div class="col-sm-8">
								<div class="input-group input-group-sm" style="width: 270px;float: left;">
									<input type="text" id="g_matnr_int" name="g_matnr_int" class="form-control pull-right" placeholder="검색 후 선택">
									<div class="input-group-btn">
				                    	<button type="button" id="" class="btn btn-default" onclick="openMatnrModal('g_matnr_int');"><i class="fa fa-search"></i></button>
									</div>
				                </div>
				            </div>
						</div>
						</form>
					</div>
				</div>
	        </div>
	        <div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_int_group" class="btn btn-success btn-sm" onclick="insertGroup();">저장</button>
					<button type="button" id="btn_int_group_cancel" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="searchMatnrPopup" data-backdrop="static">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">자재정보</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12">
						<form id="frm_product" name="frm_product" class="form-horizontal">
						<div class="form-group">
							<label for="m_matnr" class="col-sm-3 control-label text-right">자재코드</label>
							<div class="col-sm-8">
								<input type="text" class="form-control pull-right input-sm" id="m_matnr" name="m_matnr">
							</div>
						</div>
						<div class="form-group">
							<label for="m_maktx" class="col-sm-3 control-label text-right">자재내역</label>
							<div class="col-sm-8">
								<input type="text" class="form-control pull-right input-sm" id="m_maktx" name="m_maktx">
							</div>
						</div>
						<div class="text-right">
							<button type="button" id="" class="btn btn-warning btn-sm" onclick="searchMatnr();">검색</button>
							<input type="hidden" id="compId" value="">
						</div>
						</form>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div id="grid_matnr" style="width: 100%; height: 400px;"></div>
					</div>
				</div>
	        </div>
	        <div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-success btn-sm" onclick="inputMatnr();">적용</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="edit_detail" data-backdrop="static">
    <div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">검사정보 수정/삭제</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12 text-right">
						<button type="button" class="btn btn-primary btn-sm" onclick="updateDetailAddItem();">항목 추가</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="updateDetailDelItem();">추가한 항목 삭제</button>
						<br>
						<span>삭제 항목은 사용유무 "N"으로 변경 후 저장하시기 바랍니다.</span>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div id="grid_uptDetail" style="width: 100%; height: 330px;"></div>
					</div>
				</div>
	        </div>
	        <div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_upt_detail" class="btn btn-success btn-sm" onclick="updateDetailInfo();">수정</button>
					<button type="button" id="btn_upt_detail_cancel" class="btn btn-default btn-sm" onClick="w2ui['grid_uptDetail'].destroy();" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
  <!-- /.content-wrapper -->
  
  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
  </jsp:include>
</div>
<script type="text/javascript">
$(function($) {
	gridGroupGen();
	loadGroupMaster();
	gridHeaderGen();
	gridDetailGen();
	gridMatnrGen();
	
	gridUptHeaderGen();
	gridIntHeaderGen();
	
	$("#gubun").change(function(){
		if( $(this).val()=='matnr' ) {
			initOptions($("#master_gr_no_select"));
			var arr = [];
			$.each(w2ui.grid_group.records, function(idx, row){
				arr.push(row.simaster_gr_no);
			});
			$.unique(arr);
			$.each(arr, function(idx, aa){
				$("#master_gr_no_select").append($('<option>', { 
			        value: aa, text : aa 
			    }));		
			});
			$("#master_gr_no_select").val('');
			$("#master_gr_nm_int").attr("readonly", true);
			$("#group_code").show();
		} else {
			$("#master_gr_nm_int").removeAttr("readonly");
			$("#group_code").hide();
			$("#master_gr_nm_int").val("");
		}
	});
	
	$("#master_gr_no_select").change(function(){
		var selectVal = $(this).val();
		$.each(w2ui.grid_group.records, function(idx, line){
			if( selectVal==line.simaster_gr_no ) {
				$("#master_gr_nm_int").val(line.simaster_gr_nm);
				return true;
			}
		});
	});
});

function gridGroupGen() {
// 	console.info('gridGroupGen()');
	
	$("#grid_group").w2grid({
		name : "grid_group",
		show : {
			lineNumbers : true,
// 			selectColumn: true,
            footer: true
        },
		columns : [
	        { field:'simaster_gr_no', caption:'그룹코드', sortable:true, size:'20%', style:'text-align:center'},
	        { field:'simaster_seq', caption:'순번',size:'15%', render:'int'},
	        { field:'simaster_gr_nm', caption:'그룹명', size:'35%', sortable:true},
	        { field:'matnr', caption:'자재', size:'20%', sortable:true},
	        { field:'use_yn', caption:'사용유무', size:'10%', sortable:true, style:'text-align:center'}
		],
		sortData: [{field: 'simaster_gr_no', direction: 'ASC'}, {field: 'simaster_seq', direction: 'ASC'}],
// 		multiSelect : false,
		records: [],
		recordHeight : 30,
		onSelect: function(event) {
// 			console.log('select');
			event.onComplete = function () {
				w2ui.grid_header.clear();
				w2ui.grid_detail.clear();
				loadHeader();
				loadDetail();
			}
		},
		onUnselect: function(event) {
			event.onComplete = function () {
				w2ui.grid_header.clear();
				w2ui.grid_detail.clear();
			}
	    }
	});
}

function loadGroupMaster() {
	var page_url = "/frontend/mes/select_selfinsp_master"
				 + "?simaster_gr_no=" + encodeURIComponent($("#gr_no").val())
				 + "&simaster_gr_nm=" + encodeURIComponent($("#gr_nm").val())
				 + "&matnr=" + encodeURIComponent($("#matnr").val())
			 	 + "&use_yn=" + encodeURIComponent($("#use_yn").val());

	var rowArr = [];
	w2ui['grid_group'].clear();
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

function gridHeaderGen() {
// 	console.log('gridHeaderGen()');
	$("#grid_header").w2grid({
		name : "grid_header",
		show : {
			lineNumbers : true,
// 			selectColumn: true,
            footer: true
        },
		columns : [
	        { field:'simaster_gr_no', caption:'그룹코드', hidden:true},
	        { field:'siheader_seq', caption:'순번',size:'5%'},
	        { field:'siheader_code', caption:'Code', size:'10%'},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'main_name', caption:'메인 name', size:'25%', sortable:true},
	        { field:'sub_name', caption:'중간 name', size:'25%', sortable:true},
	        { field:'item_value', caption:'input 값', size:'25%', sortable:true},
	        { field:'rn_no', caption:'rn 번호', size:'', sortable:true},
	        { field:'dmr_no', caption:'dmr 번호', size:'', sortable:true},
	        { field:'sernp', caption:'set s/n(광영상)', size:'', sortable:true},
	        { field:'use_yn', caption:'사용유무', size:'10%', sortable:true, style:'text-align:center'}
		],
		sortData: [{field: 'simaster_seq', direction: 'ASC'}],
// 		multiSelect : false,
		records: [],
		recordHeight : 30
	});
}

function gridUptHeaderGen() {
// 	console.log('gridUptHeaderGen()');
	$("#grid_uptHeader").w2grid({
		name : "grid_uptHeader",
		show : {
			selectColumn: true,
			lineNumbers : true,
            footer: true
        },
		columns : [
	        { field:'simaster_gr_no', caption:'그룹코드', hidden:true},
	        { field:'siheader_seq', caption:'순번',size:'5%'},
	        { field:'siheader_code', caption:'Code', size:'10%'},
	        { field:'dept_cd', caption:'사업부코드', size:'10%'},
	        { field:'main_name', caption:'메인 name', size:'25%', editable : {type:'text'}},
	        { field:'sub_name', caption:'중간 name', size:'20%', editable : {type:'text'}},
	        { field:'item_value', caption:'input 값', size:'20%', editable : {type:'text'}},
// 	        { field:'rn_no', caption:'rn 번호', size:'80px', editable : {type:'text'}},
// 	        { field:'dmr_no', caption:'dmr 번호', size:'80px', editable : {type:'text'}},
// 	        { field:'sernp', caption:'set s/n(광영상)', size:'80px', editable : {type:'text'}},
	        { field:'use_yn', caption:'사용유무', size:'10%',  editable: { type: 'select', items: [{ id:'Y', text:'Y' }, { id:'N', text:'N' }]}}
		],
		sortData: [],
		multiSelect: true,
		records: [],
		recordHeight : 30
	});
}

function gridIntHeaderGen() {
// 	console.log('gridIntHeaderGen()');
	$("#grid_intHeader").w2grid({
		name : "grid_intHeader",
		show : {
			selectColumn: true,
			lineNumbers : true,
            footer: true
        },
		columns : [
	        { field:'simaster_gr_no', caption:'그룹코드', hidden:true},
	        { field:'siheader_seq', caption:'순번',size:'5%'},
	        { field:'siheader_code', caption:'Code', size:'10%'},
	        { field:'dept_cd', caption:'사업부코드', size:'10%', editable: { type: 'select', items: [{ id:'1110', text:'의료' }, 
	       	{ id:'1210', text:'광영상' }]}, render: function (record, index, col_index) {
				if (this.getCellValue(index, col_index)=='1110')
					return '의료';
				else
					return '광영상'; }},
	        { field:'main_name', caption:'메인 name', size:'25%', editable : {type:'text'}},
	        { field:'sub_name', caption:'중간 name', size:'20%', editable : {type:'text'}},
	        { field:'item_value', caption:'input 값', size:'20%', editable : {type:'text'}},
	        { field:'use_yn', caption:'사용유무', size:'10%',  editable: { type: 'select', items: [{ id:'Y', text:'Y' }, { id:'N', text:'N' }]}}
		],
		sortData: [],
		multiSelect: true,
		records: [],
		recordHeight : 30
	});
}

//grid_uptHeader
function loadHeader() {
// 	console.log('loadHeader()');
	
	var selectGroup = w2ui.grid_group.get(w2ui.grid_group.getSelection())[0];
	var page_url = "/frontend/mes/select_selfinsp_header_list"
				 + "?simaster_gr_no=" + encodeURIComponent(selectGroup.simaster_gr_no)
				 + "&matnr=" + encodeURIComponent(selectGroup.matnr);

	var rowArr = [];
	w2ui['grid_header'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : "POST",
		async : false,
		success : function(data, textStatus, jqXHR) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = setRecid(data.rows);
				w2ui['grid_header'].records = rowArr;
				w2ui['grid_header'].total = rowArr.length;
				$("#btn_edit_header").show();
				$("#btn_add_header").hide();
			} else {
				$("#btn_edit_header").hide();
				$("#btn_add_header").show();
			}
			w2ui['grid_header'].refresh();
			w2ui['grid_header'].unlock();
		}
	});
} 

var routingArr_1 = [];
function gridDetailGen() {
// 	console.log('gridDetailGen()');
// 	var routingArr = [];
// 	if( (w2ui.grid_header.records).length!=0 ) {
// 		var getHeader = w2ui.grid_header.records[0];
// 		if( getHeader.dept_cd=='1110' )
// 			routingArr = getSelfInspCode('1110');
// 		else
// 			routingArr = getSelfInspCode('1210');
// 	}
// 	console.log(routingArr);
	$("#grid_detail").w2grid({
		name : "grid_detail",
		show : {
			lineNumbers : true,
            footer: true
        },
		columns : [
	        { field:'simaster_gr_no', caption:'그룹코드', hidden:true},
	        { field:'sidetail_seq', caption:'순번',size:'50px', render:'int'},
	        { field:'sidetail_code', caption:'Code',size:'70px'},
	        { field:'dept_cd', caption:'사업부코드', sortable:true, hidden:true},
// 			{ field:'routing_code', caption:'공정 매핑 코드', size:'100px'},
// 			{ field:'routing_code_sub', caption:'서브 공정 매핑코드', size:'100px'},
			{ field:'routing_code', caption:'공정 매핑 코드', size:'100px', editable : function(record, index, col_index) {
				return {type:'select', items:routingArr_1};
			}, render: function (record, index, col_index) {
       				var val = this.getCellValue(index, col_index);
       				var displayText = '';
       				$.each(routingArr_1, function(idx, r){
       					if( r.id==val ) {
       						displayText = r.text;
       						return true;
       					}
       				}); 
       				return displayText;
       			} },
			{ field:'routing_code_sub', caption:'서브 공정 매핑코드', size:'100px', editable : function(record, index, col_index) {
				return {type:'select', items:routingArr_1};
			}, render: function (record, index, col_index) {
       				var val = this.getCellValue(index, col_index);
       				var displayText = '';
       				$.each(routingArr_1, function(idx, r){
       					if( r.id==val ) {
       						displayText = r.text;
       						return true;
       					}
       				}); 
       				return displayText;
       			} },
	        { field:'minsp_name', caption:'메인 name', size:'100px', sortable:true},
	        { field:'sinsp_name', caption:'중간 name', size:'100px', sortable:true},
			{ field:'insp_standard', caption:'검사기준', size:'200px'},
			{ field:'insp_value', caption:'측정값', size:'100px'},
			{ field:'insp_state', caption:'insp_state', hidden:true},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'검사작업자명', hidden:true},
			{ field:'remark', caption:'비고', size:'100px'},
	        { field:'use_yn', caption:'사용유무', size:'50px', sortable:true, style:'text-align:center'}
		],
		sortData: [{field: 'simaster_seq', direction: 'ASC'}],
		records: [],
		recordHeight : 30
	});
}

function gridUptDetailGen() {
// 	console.log('gridUptDetailGen()');
	
	var routingArr = [];
	if( (w2ui.grid_header.records).length!=0 ) {
		var getHeader = w2ui.grid_header.records[0];
		if( getHeader.dept_cd=='1110' )
			routingArr = getSelfInspCode('1110');
		else
			routingArr = getSelfInspCode('1210');
	}
// 	console.log(routingArr);
	$("#grid_uptDetail").w2grid({
		name : "grid_uptDetail",
		show : {
			selectColumn: true,
			lineNumbers : true,
            footer: true
        },
		columns : [
	        { field:'simaster_gr_no', caption:'그룹코드', hidden:true},
	        { field:'sidetail_seq', caption:'순번',size:'50px', render:'int'},
	        { field:'sidetail_code', caption:'Code',size:'70px'},
	        { field:'dept_cd', caption:'사업부코드', size:'100px', 
	        	render: function (record, index, col_index) {
       	       		if (this.getCellValue(index, col_index)=='1110')
       					return '의료';
       				else
       					return '광영상'; }},
			{ field:'routing_code', caption:'공정 매핑 코드', size:'100px', editable : function(record, index, col_index) {
				return {type:'select', items:routingArr};
			}, render: function (record, index, col_index) {
       				var val = this.getCellValue(index, col_index);
       				var displayText = '';
       				$.each(routingArr, function(idx, r){
       					if( r.id==val ) {
       						displayText = r.text;
       						return true;
       					}
       				}); 
       				return displayText;
       			} },
			{ field:'routing_code_sub', caption:'서브 공정 매핑코드', size:'100px', editable : function(record, index, col_index) {
				return {type:'select', items:routingArr};
			}, render: function (record, index, col_index) {
       				var val = this.getCellValue(index, col_index);
       				var displayText = '';
       				$.each(routingArr, function(idx, r){
       					if( r.id==val ) {
       						displayText = r.text;
       						return true;
       					}
       				}); 
       				return displayText;
       			} },
	        { field:'minsp_name', caption:'메인 name', size:'100px', sortable:true, editable:{type:'text'}},
	        { field:'sinsp_name', caption:'중간 name', size:'100px', sortable:true, editable:{type:'text'}},
			{ field:'insp_standard', caption:'검사기준', size:'200px', editable:{type:'text'}},
			{ field:'insp_value', caption:'측정값', size:'100px', editable:{type:'text'}},
			{ field:'insp_state', caption:'insp_state', hidden:true},
			{ field:'member_emp_no', caption:'검사작업자사번', size:'100px', hidden:true},
			{ field:'member_nm', caption:'검사작업자명', size:'100px', hidden:true},
			{ field:'remark', caption:'비고', size:'100px', editable:{type:'text'}},
	        { field:'use_yn', caption:'사용유무', size:'50px', sortable:true, style:'text-align:center', 
				editable: { type: 'select', items: [{ id:'Y', text:'Y' }, { id:'N', text:'N' }]}}
		],
		sortData: [{field: 'simaster_seq', direction: 'ASC'}],
		multiSelect : false,
		records: [],
		recordHeight : 30
	});
}

function gridIntDetailGen() {
// 	console.log('gridIntDetailGen()');
	
	var routingArr = [];
	if( (w2ui.grid_header.records).length!=0 ) {
		var getHeader = w2ui.grid_header.records[0];
		if( getHeader.dept_cd=='1110' )
			routingArr = getSelfInspCode('1110');
		else
			routingArr = getSelfInspCode('1210');
	}
// 	console.log(routingArr);
	$("#grid_intDetail").w2grid({
		name : "grid_intDetail",
		show : {
			selectColumn: true,
			lineNumbers : true,
            footer: true
        },
		columns : [
	        { field:'simaster_gr_no', caption:'그룹코드', hidden:true},
	        { field:'sidetail_seq', caption:'순번',size:'50px', render:'int'},
	        { field:'sidetail_code', caption:'Code',size:'70px'},
	        { field:'dept_cd', caption:'사업부코드', size:'100px',editable: { type: 'select', items: [{ id:'1110', text:'의료' }, 
     	       	{ id:'1210', text:'광영상' }]}, render: function (record, index, col_index) {
    				if (this.getCellValue(index, col_index)=='1110')
    					return '의료';
    				else
    					return '광영상'; }},
			{ field:'routing_code', caption:'공정 매핑 코드', size:'100px', editable : function(record, index, col_index) {
				return {type:'select', items:routingArr};
			}, render: function (record, index, col_index) {
       				var val = this.getCellValue(index, col_index);
       				var displayText = '';
       				$.each(routingArr, function(idx, r){
       					if( r.id==val ) {
       						displayText = r.text;
       						return true;
       					}
       				}); 
       				return displayText;
       			} },
			{ field:'routing_code_sub', caption:'서브 공정 매핑코드', size:'100px', editable : function(record, index, col_index) {
				return {type:'select', items:routingArr};
			}, render: function (record, index, col_index) {
       				var val = this.getCellValue(index, col_index);
       				var displayText = '';
       				$.each(routingArr, function(idx, r){
       					if( r.id==val ) {
       						displayText = r.text;
       						return true;
       					}
       				}); 
       				return displayText;
       			} },
	        { field:'minsp_name', caption:'메인 name', size:'100px', sortable:true, editable:{type:'text'}},
	        { field:'sinsp_name', caption:'중간 name', size:'100px', sortable:true, editable:{type:'text'}},
			{ field:'insp_standard', caption:'검사기준', size:'200px', editable:{type:'text'}},
			{ field:'insp_value', caption:'측정값', size:'100px', editable:{type:'text'}},
			{ field:'insp_state', caption:'insp_state', hidden:true},
			{ field:'member_emp_no', caption:'검사작업자사번', size:'100px', editable:{type:'text'}},
			{ field:'member_nm', caption:'검사작업자명', size:'100px', editable:{type:'text'}},
			{ field:'remark', caption:'비고', size:'100px', editable:{type:'text'}},
	        { field:'use_yn', caption:'사용유무', size:'50px', sortable:true, style:'text-align:center', 
				editable: { type: 'select', items: [{ id:'Y', text:'Y' }, { id:'N', text:'N' }]}}
		],
		sortData: [{field: 'simaster_seq', direction: 'ASC'}],
		multiSelect : false,
		records: [],
		recordHeight : 30
	});
}

function getSelfInspCode(dept_cd) {
// 	console.log('getSelfInspCode()');
	var page_url = "/frontend/mes/select_selfInspCode_1210"
				 + "?ref1=" + encodeURIComponent(dept_cd);
	var rowArr = [];
	$.ajax({
		url : page_url,
		type : "POST",
		async : false,
		success : function(data, textStatus, jqXHR) {
			if(data.status == 200 && (data.rows).length>0 ) {
				$.each((data.rows), function(idx, item){
					rowArr.push({'id':item.code, 'text':item.code_nm});
				});
			}
		}
	});
	return rowArr;
}

function gridMatnrGen() {
// 	console.log('gridMatnrGen()');
	
	$("#grid_matnr").w2grid({
		name : 'grid_matnr',
		show : {
			selectColumn: true,
			lineNumbers : true,
            footer: true
        },
		columns : [
			{ field:'matnr', caption:'자재코드', size:'30%', sortable:true},
			{ field:'maktx', caption:'자재내역', size:'35%', sortable:true},
			{ field:'wrkst', caption:'Spec.', size:'35%', sortable:true} ],
		records: [],
		multiSelect : false,
		total : 0,
		recordHeight : 30
	});
}

function loadDetail() {
// 	console.log('loadDetail()');
	
	if( (w2ui.grid_header.records).length!=0 ) {
 		var getHeader = w2ui.grid_header.records[0];
 		if( getHeader.dept_cd=='1110' )
 			routingArr_1 = getSelfInspCode('1110');
 		else
 			routingArr_1 = getSelfInspCode('1210');
 	}
			 	
	var selectGroup = w2ui.grid_group.get(w2ui.grid_group.getSelection())[0];
	var page_url = "/frontend/mes/select_selfinsp_detail_list"
				 + "?simaster_gr_no=" + encodeURIComponent(selectGroup.simaster_gr_no);
// 				 + "&matnr=" + encodeURIComponent(selectGroup.matnr);

	var rowArr = [];
	w2ui['grid_detail'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = setRecid(data.rows);
				w2ui['grid_detail'].records = rowArr;
				w2ui['grid_detail'].total = rowArr.length;
				$("#btn_edit_detail").show();
				$("#btn_add_detail").hide();
			} else {
				$("#btn_edit_detail").hide();
				$("#btn_add_detail").show();
			}
			w2ui['grid_detail'].refresh();
			w2ui['grid_detail'].unlock();
		}
	});
} 

function editGroupPopup() {
// 	console.log('editGroupPopup()');
	
	var selected = w2ui.grid_group.get(w2ui.grid_group.getSelection());
	//
	if( selected.length==0 ) {
		fnMessageModalAlert("Warning", "수정/삭제 하고자 하는 데이터를 목록에서 선택하세요.");
		return;
	}
	$("#master_gr_no").val(selected[0].simaster_gr_no);
	$("#master_seq").val(selected[0].simaster_seq);
	$("#master_gr_nm").val(selected[0].simaster_gr_nm);
	$("#g_matnr").val(selected[0].matnr);
	$("#use_yn_edit").val(selected[0].use_yn);
	$("#edit_group").modal("show");
}

function insertGroup() {
// 	console.log('insertGroup()');
	$("#btn_int_group").prop("disabled", true);
	$("#btn_int_group_cancel").prop("disabled", true);
	
	//check matnr
	var chkObj = checkMatnr($("#g_matnr_int").val());
	if( chkObj.length>0 ) {
		$("#btn_int_group").prop("disabled", false);
		$("#btn_int_group_cancel").prop("disabled", false);
		fnMessageModalAlert("Warning", "그룹코드 [" + chkObj[0].simaster_gr_no + "] 에 이미 등록되어 있습니다.");
		return;
	}
			
	var page_url = '/frontend/mes/selfInspMaster_insert'
				 + '?gubun=' + encodeURIComponent($("#gubun").val())
				 + '&matnr=' + encodeURIComponent($("#g_matnr_int").val())
				 + '&simaster_gr_nm=' + encodeURIComponent($("#master_gr_nm_int").val());
	if( $("#gubun").val()=="matnr" )
		page_url += '&simaster_gr_no=' + encodeURIComponent($("#master_gr_no_select").val());
	
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 ) {
				fnMessageModalAlert("Success", "저장이 완료되었습니다.");
				loadGroupMaster();
			} else {
				fnMessageModalAlert("Fail", "저장 중 오류가 발생하였습니다.");
			}
			$("#btn_int_group").prop("disabled", false);   
			$("#btn_int_group_cancel").prop("disabled", false);
		},complete: function () {}
	});
	$("#master_gr_nm_int").val('');
	$("#g_matnr_int").val('');
	$("#int_group").modal("hide");
	initOptions($("#master_gr_no_select"));
}

function checkMatnr(matnr) {
// 	console.log('checkMatnr()');
	var page_url = '/frontend/mes/checkDuplicateMatnr'
				 + '?matnr=' + encodeURIComponent($("#g_matnr_int").val());
	var returnObj = null;
	$.ajax({
		url : page_url,
		type : 'POST',
		async : false,
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 ) {
				returnObj = data.rows;
			}
		},complete: function () {}
	});
	return returnObj;
}

function openMatnrModal(compId) {
// 	console.log('openMatnrModal()');
	w2ui.grid_matnr.clear();
	$("#m_matnr").val("");
	$("#m_maktx").val("");
	
	$("#compId").val(compId);
	$("#searchMatnrPopup").modal("show");
	setTimeout(function(){
		w2ui.grid_matnr.resize();
		w2ui.grid_matnr.refresh();
	}, 200);
}

function searchMatnr() {
// 	console.log('searchMatnr()');
	var page_url = '/frontend/hub/material_recv_master_select_w2ui'
				 + '?matnr=' + encodeURIComponent($("#m_matnr").val())
				 + '&maktx=' + encodeURIComponent($("#m_maktx").val())
				 + '&page=' + encodeURIComponent(0)
				 + '&rows=' + encodeURIComponent(100000);

	w2ui['grid_matnr'].clear();
	w2ui['grid_matnr'].lock('loading...', true);
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
				w2ui['grid_matnr'].records = rowArr;
				w2ui['grid_matnr'].total = data.rowTotal;
			}
			w2ui['grid_matnr'].refresh();
			w2ui['grid_matnr'].unlock();
		},complete: function () {}
	});
}

function inputMatnr() {
// 	console.log('inputMatnr()');
	var selected = w2ui.grid_matnr.get(w2ui.grid_matnr.getSelection())[0];
	$("#"+$("#compId").val()).val(selected.matnr);
	$("#compId").val("");
	$("#searchMatnrPopup").modal("hide");
}

function updateGroupInfo() {
// 	console.log('updateGroupInfo()');

	$("#btn_upt_group").prop("disabled", true);
	$("#btn_upt_group_cancel").prop("disabled", true);
	var page_url = '/frontend/mes/selfInspMaster_update'
				 + '?simaster_gr_no=' + encodeURIComponent($("#master_gr_no").val())
				 + '&simaster_seq=' + encodeURIComponent($("#master_seq").val())
				 + '&simaster_gr_nm=' + encodeURIComponent($("#master_gr_nm").val())
				 + '&matnr=' + encodeURIComponent($("#g_matnr").val())
				 + '&use_yn=' + encodeURIComponent($("#use_yn_edit").val());
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 ) {
				loadGroupMaster();
			}
			$("#btn_upt_group").prop("disabled", false);
			$("#btn_upt_group_cancel").prop("disabled", false);
		},complete: function () {}
	});
	$("#edit_group").modal("hide");
}

function editHeaderPopup() {
// 	console.log('editHeaderPopup()');
	var selected = w2ui.grid_group.get(w2ui.grid_group.getSelection());
	if( selected.length==0 ) {
		fnMessageModalAlert("Warning", "수정/삭제 하고자 하는 이력카드의 그룹정보를 목록에서 선택하세요.");
		return;
	}
	w2ui.grid_uptHeader.records = w2ui.grid_header.records;
	$("#edit_header").modal("show");
	setTimeout(function(){
		w2ui.grid_uptHeader.resize();
		w2ui.grid_uptHeader.refresh();
	}, 200);
}

function editDetailPopup() {
// 	console.log('editDetailPopup()');
	var selected = w2ui.grid_group.get(w2ui.grid_group.getSelection());
	if( selected.length==0 ) {
		fnMessageModalAlert("Warning", "수정/삭제 하고자 하는 검사정보의 그룹정보를 목록에서 선택하세요.");
		return;
	}
	gridUptDetailGen();
	w2ui.grid_uptDetail.records = w2ui.grid_detail.records;
	$("#edit_detail").modal("show");
	setTimeout(function(){
		w2ui.grid_uptDetail.resize();
		w2ui.grid_uptDetail.refresh();
	}, 200);
}

function newHeaderPopup() {
// 	console.log('newHeaderPopup()');
	var selected = w2ui.grid_group.get(w2ui.grid_group.getSelection());
	if( selected.length==0 ) {
		fnMessageModalAlert("Warning", "추가 하고자 하는 이력카드의 그룹정보를 목록에서 선택하세요.");
		return;
	}
	w2ui.grid_intHeader.clear();
	$("#int_header").modal("show");
	setTimeout(function(){
		w2ui.grid_intHeader.resize();
		w2ui.grid_intHeader.refresh();
	}, 200);
}

function newDetailPopup() {
// 	console.log('newDetailPopup()');
	var selected = w2ui.grid_group.get(w2ui.grid_group.getSelection());
	if( selected.length==0 ) {
		fnMessageModalAlert("Warning", "추가 하고자 하는 검사정보의 그룹정보를 목록에서 선택하세요.");
		return;
	}
	
	gridIntDetailGen();
	$("#int_detail").modal("show");
	setTimeout(function(){
		w2ui.grid_intDetail.resize();
		w2ui.grid_intDetail.refresh();
	}, 200);
}

function updateHeaderAddItem() {
// 	console.log('updateHeaderAddItem()');
	var gridRecords = w2ui.grid_uptHeader.records;
	var getHeader = (w2ui.grid_header.records)[0];
	var addItem = {
			recid : gridRecords.length+1,
			simaster_gr_no : getHeader.simaster_gr_no,
	        siheader_seq : gridRecords.length+1, 
	        siheader_code : '',
	        dept_cd : getHeader.dept_cd,
	        main_name : '',
	        sub_name : '',
	        item_value : '',
	        use_yn : 'Y'};
	w2ui.grid_uptHeader.add(addItem);
	w2ui.grid_uptHeader.refresh();
}

function updateDetailAddItem() { 
// 	console.log('updateDetailAddItem()');
	var gridRecords = w2ui.grid_uptDetail.records;
	var seqArr = [];
	$.each(gridRecords, function(idx, row){
		seqArr.push(Number(row.sidetail_seq));
	});
	var getDetail = (w2ui.grid_detail.records)[0];
	var addItem = {
			recid : gridRecords.length+1,
			simaster_gr_no : getDetail.simaster_gr_no,
	        sidetail_seq : Math.max.apply(Math,seqArr)+1, 
	        sidetail_code : '',
	        dept_cd : getDetail.dept_cd,
// 	        minsp_name : '',
// 	        sinsp_name : '',
// 	        item_value : '',
	        use_yn : 'Y'};
	w2ui.grid_uptDetail.add(addItem);
	w2ui.grid_uptDetail.refresh();
}

function updateHeaderDelItem() {
// 	console.log('updateHeaderDelItem()');
	var selectedData = w2ui.grid_uptHeader.get(w2ui.grid_uptHeader.getSelection());
	if( selectedData.length==0 ) {
		fnMessageModalAlert("Warning", "삭제 하고자 하는 데이터를 목록에서 선택하세요.");
		return;		
	}
	var chkCnt = 0;
	$.each(selectedData, function(idx, row){
		if( row.siheader_code!='' ) chkCnt++;
	});
	if( chkCnt>0 ) {
		fnMessageModalAlert("Warning", "새로 추가한 항목에 대하여만 삭제가 가능합니다.<br> 기존 등록된 항목은 사용유무에서 [N]을 선택한 후 저장하시기 바랍니다.");
		return;
	}
	w2ui.grid_uptHeader.delete(true);
}

function updateDetailDelItem() {
// 	console.log('updateDetailDelItem()');
	var selectedData = w2ui.grid_uptDetail.get(w2ui.grid_uptDetail.getSelection());
	if( selectedData.length==0 ) {
		fnMessageModalAlert("Warning", "삭제 하고자 하는 데이터를 목록에서 선택하세요.");
		return;		
	}
	var chkCnt = 0;
	$.each(selectedData, function(idx, row){
		if( row.sidetail_code!='' ) chkCnt++;
	});
	if( chkCnt>0 ) {
		fnMessageModalAlert("Warning", "새로 추가한 항목에 대하여만 삭제가 가능합니다.<br> 기존 등록된 항목은 사용유무에서 [N]을 선택한 후 저장하시기 바랍니다.");
		return;
	}
	w2ui.grid_uptDetail.delete(true);
}

function insertHeaderAddItem() {
// 	console.log('insertHeaderAddItem()');
	var getGroup = w2ui.grid_group.get(w2ui.grid_group.getSelection())[0];
	var gridRecords = w2ui.grid_intHeader.records;
	var addItem = {
			recid : gridRecords.length+1,
			simaster_gr_no : getGroup.simaster_gr_no,
	        siheader_seq : gridRecords.length+1, 
	        siheader_code : '',
	        dept_cd : '',
	        main_name : '',
	        sub_name : '',
	        item_value : '',
	        use_yn : 'Y'};
	w2ui.grid_intHeader.add(addItem);
	w2ui.grid_intHeader.refresh();
}

function insertHeaderDelItem() {
// 	console.log('insertHeaderDelItem()');
	var select = w2ui.grid_intHeader.get(w2ui.grid_intHeader.getSelection());
	if( select.length==0 ) {
		fnMessageModalAlert("Warning", "삭제하고자 하는 데이터를 선택하지 않았습니다.");
		return;
	}
	w2ui.grid_intHeader.delete(true);
	var refreshRecords = [];
	$.each(w2ui.grid_intHeader.records, function(idx, row){
		row.recid = idx+1;
		row.siheader_seq = idx+1;
		refreshRecords.push(row);
	});
	w2ui.grid_intHeader.records = refreshRecords;
	w2ui.grid_intHeader.refresh();
}

function insertDetailAddItem() {
// 	console.log('insertDetailAddItem()');
	var getGroup = w2ui.grid_group.get(w2ui.grid_group.getSelection())[0];
	var gridHeader = w2ui.grid_header.records;
	var dept_cd = '1110';
	if( gridHeader.length>0 )
		dept_cd = gridHeader[0].dept_cd; 
	var gridRecords = w2ui.grid_intDetail.records;
	var addItem = {
			recid : gridRecords.length+1,
			simaster_gr_no : getGroup.simaster_gr_no,
	        sidetail_seq : gridRecords.length+1, 
	        sidetail_code : '',
	        dept_cd : dept_cd,
	        use_yn : 'Y'};
	w2ui.grid_intDetail.add(addItem);
	w2ui.grid_intDetail.refresh();
}

function insertDetailDelItem() {
// 	console.log('insertDetailDelItem()');
	var select = w2ui.grid_intDetail.get(w2ui.grid_intDetail.getSelection());
	if( select.length==0 ) {
		fnMessageModalAlert("Warning", "삭제하고자 하는 데이터를 선택하지 않았습니다.");
		return;
	}
	w2ui.grid_intDetail.delete(true);
	var refreshRecords = [];
	$.each(w2ui.grid_intDetail.records, function(idx, row){
		row.recid = idx+1;
		row.sidetail_seq = idx+1;
		refreshRecords.push(row);
	});
	w2ui.grid_intDetail.records = refreshRecords;
	w2ui.grid_intDetail.refresh();
}

function updateHeaderInfo() {
// 	console.log('updateHeaderInfo()');
	var selectGroup = w2ui.grid_group.get(w2ui.grid_group.getSelection())[0];
	var getGridData = w2ui.grid_uptHeader.records;
	var updateData = [];
	var insertData = [];
	$.each(getGridData, function(idx, row){
		if( row.siheader_code=='' ) {	
			// insert
			if( row.w2ui!=undefined ) {
				var tmpObj = row.w2ui.changes;
				if( tmpObj.main_name!=undefined )
					row.main_name = tmpObj.main_name;
				if( tmpObj.sub_name!=undefined )
					row.sub_name = tmpObj.sub_name;
				if( tmpObj.item_value!=undefined )
					row.item_value = tmpObj.item_value;
				if( tmpObj.use_yn!=undefined )
					row.use_yn = tmpObj.use_yn;
				row.display_seq = row.siheader_seq ;
				insertData.push(row);
			}
		} else {	
			// update
			if( row.w2ui!=undefined ) {
				var tmpObj = row.w2ui.changes;
				if( tmpObj.main_name!=undefined )
					row.main_name = tmpObj.main_name;
				if( tmpObj.sub_name!=undefined )
					row.sub_name = tmpObj.sub_name;
				if( tmpObj.item_value!=undefined )
					row.item_value = tmpObj.item_value;
				if( tmpObj.use_yn!=undefined )
					row.use_yn = tmpObj.use_yn;
				updateData.push(row);
			}
		}
	});
	
	var chkCnt = 0;
	$.each(getGridData, function(idx, row){
		if( row.main_name=='' || row.dept_cd=='' ) chkCnt++;
	});
	if( chkCnt>0 ) {
		fnMessageModalAlert("Warning", "추가 데이터의 필수항목(메인 name, 사업부코드)이 정의 되지 않았습니다.");
		return;
	}
// 	console.log('insertData-->');
// 	console.log(insertData);
// 	console.log('updateData-->');
// 	console.log(updateData);
	var page_url = '/frontend/mes/update_selfinsp_header'
				 + '?insertData=' + encodeURIComponent(JSON.stringify(insertData))
				 + '&updateData=' + encodeURIComponent(JSON.stringify(updateData));
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 ) {
				fnMessageModalAlert("Success", "정상적으로 수정되었습니다.");
				loadHeader();
			} else {
				fnMessageModalAlert("Fail", "수정에 실패하였습니다.");
			}
		},complete: function () {}
	});
	$("#edit_header").modal("hide");
}

function updateDetailInfo() {
// 	console.log('updateDetailInfo()');
	var selectGroup = w2ui.grid_group.get(w2ui.grid_group.getSelection())[0];
	var getGridData = w2ui.grid_uptDetail.records;
	var updateData = [];
	var insertData = [];
	
	$.each(getGridData, function(idx, row){
		if( row.sidetail_code=='' ) {	
			// insert
			if( row.w2ui!=undefined ) {
				var tmpObj = row.w2ui.changes;
				if( tmpObj.routing_code!=undefined )
					row.routing_code = tmpObj.routing_code;
				if( tmpObj.routing_code_sub!=undefined )
					row.routing_code_sub = tmpObj.routing_code_sub;
				if( tmpObj.minsp_name!=undefined )
					row.minsp_name = tmpObj.minsp_name;
				if( tmpObj.sinsp_name!=undefined )
					row.sinsp_name = tmpObj.sinsp_name;
				if( tmpObj.insp_standard!=undefined )
					row.insp_standard = tmpObj.insp_standard;
				if( tmpObj.insp_value!=undefined )
					row.insp_value = tmpObj.insp_value;
				if( tmpObj.member_emp_no!=undefined )
					row.member_emp_no = tmpObj.member_emp_no;
				if( tmpObj.member_nm!=undefined )
					row.member_nm = tmpObj.member_nm;
				if( tmpObj.remark!=undefined )
					row.remark = tmpObj.remark;
				if( tmpObj.item_value!=undefined )
					row.item_value = tmpObj.item_value;
				if( tmpObj.use_yn!=undefined )
					row.use_yn = tmpObj.use_yn;
				row.display_seq = row.sidetail_seq ;
				insertData.push(row);
			}
		} else {	
			// update
			if( row.w2ui!=undefined ) {
				var tmpObj = row.w2ui.changes;
				if( tmpObj.routing_code!=undefined )
					row.routing_code = tmpObj.routing_code;
				if( tmpObj.routing_code_sub!=undefined )
					row.routing_code_sub = tmpObj.routing_code_sub;
				if( tmpObj.minsp_name!=undefined )
					row.minsp_name = tmpObj.minsp_name;
				if( tmpObj.sinsp_name!=undefined )
					row.sinsp_name = tmpObj.sinsp_name;
				if( tmpObj.insp_standard!=undefined )
					row.insp_standard = tmpObj.insp_standard;
				if( tmpObj.insp_value!=undefined )
					row.insp_value = tmpObj.insp_value;
				if( tmpObj.member_emp_no!=undefined )
					row.member_emp_no = tmpObj.member_emp_no;
				if( tmpObj.member_nm!=undefined )
					row.member_nm = tmpObj.member_nm;
				if( tmpObj.remark!=undefined )
					row.remark = tmpObj.remark;
				if( tmpObj.item_value!=undefined )
					row.item_value = tmpObj.item_value;
				if( tmpObj.use_yn!=undefined )
					row.use_yn = tmpObj.use_yn;
				updateData.push(row);
			}
		}
	});
	
	var chkCnt = 0;
	$.each(getGridData, function(idx, row){
		if( row.minsp_name=='' || row.dept_cd=='' ) chkCnt++;
	});
	if( chkCnt>0 ) {
		fnMessageModalAlert("Warning", "추가 데이터의 필수항목(메인 name, 사업부코드)이 정의 되지 않았습니다.");
		return;
	}
// 	console.log('insertData-->');
// 	console.log(insertData);
// 	console.log('updateData-->');
// 	console.log(updateData);
	var page_url = '/frontend/mes/update_selfinsp_detail'
				 + '?insertData=' + encodeURIComponent(JSON.stringify(insertData))
				 + '&updateData=' + encodeURIComponent(JSON.stringify(updateData));
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 ) {
				fnMessageModalAlert("Success", "정상적으로 수정되었습니다.");
				loadDetail();
			} else {
				fnMessageModalAlert("Fail", "수정에 실패하였습니다.");
			}
		},complete: function () {}
	});
	$("#edit_detail").modal("hide");
	w2ui['grid_uptDetail'].destroy();
}

function insertHeaderInfo() {
// 	console.log('insertHeaderInfo()');
	var gridData = w2ui.grid_intHeader.records;
// 	console.log(gridData);
	var chkCnt = 0;
	var chkDeptCd = [];
	var chkDeptCnt = 0;
	var insertData = [];
	$.each(gridData, function(idx, row){
		if( row.w2ui!=undefined ) {
			var tmpObj = row.w2ui.changes;
			if( tmpObj.main_name!=undefined )
				row.main_name = tmpObj.main_name;
			if( tmpObj.sub_name!=undefined )
				row.sub_name = tmpObj.sub_name;
			if( tmpObj.item_value!=undefined )
				row.item_value = tmpObj.item_value;
			if( tmpObj.use_yn!=undefined )
				row.use_yn = tmpObj.use_yn;
			if( tmpObj.dept_cd!=undefined ) {
				row.dept_cd = tmpObj.dept_cd;
				chkDeptCd.push(row.dept_cd);
			} else {
				chkDeptCnt++;
			}
			row.display_seq = row.siheader_seq ;
			insertData.push(row);
		}
	});
	if( insertData.length==0 ){
		fnMessageModalAlert("Warning", "항목추가 후 입력된 데이터가 없습니다. <br>필수항목(사업부코드, 메인name)은 입력해야 합니다.");
		return;	
	}
	
	$.unique(chkDeptCd);
	if( chkDeptCd.length>1 ) {
		fnMessageModalAlert("Warning", "사업부 코드는 동일해야 합니다.");
		return;
	}
	if( chkDeptCnt>0 ) {
		fnMessageModalAlert("Warning", "사업부 코드는 필수항목입니다.");
		return;
	}
	
	$.each(insertData, function(idx, row){
		if( row.main_name==undefined || row.main_name=='' ) chkCnt++;
	});
	if( chkCnt>0 ) {
		fnMessageModalAlert("Warning", "필수항목(메인 name)이 등록되지 않았습니다.");
		return;
	}
	var page_url = '/frontend/mes/update_selfinsp_header'
		 		 + '?insertData=' + encodeURIComponent(JSON.stringify(insertData));
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 ) {
				fnMessageModalAlert("Success", "정상적으로 저장되었습니다.");
				loadHeader();
			} else {
				fnMessageModalAlert("Fail", "저장에 실패하였습니다.");
			}
		},complete: function () {}
	});
	$("#int_header").modal("hide");
}

function insertDetailInfo() {
// 	console.log('insertDetailInfo()');
	var gridData = w2ui.grid_intDetail.records;
// 	console.log(gridData);
	var chkCnt = 0;
	var chkDeptCd = [];
	var chkDeptCnt = 0;
	var insertData = [];
	$.each(gridData, function(idx, row){
		if( row.w2ui!=undefined ) {
			var tmpObj = row.w2ui.changes;
			if( tmpObj.routing_code!=undefined )
				row.routing_code = tmpObj.routing_code;
			if( tmpObj.routing_code_sub!=undefined )
				row.routing_code_sub = tmpObj.routing_code_sub;
			if( tmpObj.minsp_name!=undefined )
				row.minsp_name = tmpObj.minsp_name;
			if( tmpObj.sinsp_name!=undefined )
				row.sinsp_name = tmpObj.sinsp_name;
			if( tmpObj.insp_standard!=undefined )
				row.insp_standard = tmpObj.insp_standard;
			if( tmpObj.insp_value!=undefined )
				row.insp_value = tmpObj.insp_value;
			if( tmpObj.member_emp_no!=undefined )
				row.member_emp_no = tmpObj.member_emp_no;
			if( tmpObj.member_nm!=undefined )
				row.member_nm = tmpObj.member_nm;
			if( tmpObj.remark!=undefined )
				row.remark = tmpObj.remark;
			if( tmpObj.item_value!=undefined )
				row.item_value = tmpObj.item_value;
			if( tmpObj.use_yn!=undefined )
				row.use_yn = tmpObj.use_yn;
			if( tmpObj.dept_cd!=undefined ) {
				row.dept_cd = tmpObj.dept_cd;
				chkDeptCd.push(row.dept_cd);
			} else {
				chkDeptCnt++;
			}
			row.display_seq = row.sidetail_seq ;
			insertData.push(row);
		}
	});
	if( insertData.length==0 ){
		fnMessageModalAlert("Warning", "항목추가 후 입력된 데이터가 없습니다. <br>필수항목(사업부코드, 메인name)은 입력해야 합니다.");
		return;	
	}
	
	$.unique(chkDeptCd);
	if( chkDeptCd.length>1 ) {
		fnMessageModalAlert("Warning", "사업부 코드는 동일해야 합니다.");
		return;
	}
	if( chkDeptCnt==0 ) {
		fnMessageModalAlert("Warning", "사업부 코드는 필수항목입니다.");
		return;
	}
	
	$.each(insertData, function(idx, row){
		if( row.dept_cd=='' || row.routing_code=='' || row.routing_code_sub=='' || row.minsp_name=='' ) chkCnt++;
	});
	if( chkCnt>0 ) {
		fnMessageModalAlert("Warning", "필수항목(사업부코드, 공정 매핑코드, 서브 공정 매핑코드, 메인name)이 등록되지 않았습니다.");
		return;
	}
	var page_url = '/frontend/mes/update_selfinsp_detail'
		 		 + '?insertData=' + encodeURIComponent(JSON.stringify(insertData));
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 ) {
				fnMessageModalAlert("Success", "정상적으로 저장되었습니다.");
				loadDetail();
			} else {
				fnMessageModalAlert("Fail", "저장에 실패하였습니다.");
			}
		},complete: function () {}
	});
	$("#int_detail").modal("hide");
	w2ui['grid_intDetail'].destroy();
}

function setRecid(objArr) {
// 	console.log('setRecid()');
	$.each(objArr, function(idx, row){
		row.recid = idx+1;
	});
	return objArr;
}

function initOptions(obj) {
    $(obj)
        .find('option')
        .remove()
        .end()
        .val();
}

function openModalIntGroup() {
	$("#master_gr_no_select").val('');
	$("#master_gr_nm_int").val('');
	$("#g_matnr_int").val('');
	$("#int_group").modal("show");
}
</script>
</body>
</html>