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
		<jsp:param name="selected_menu_p_cd" value="1020" />
		<jsp:param name="selected_menu_cd" value="1083" />
	</jsp:include>

	<div class="content-wrapper">
		<section class="content-header">
			<h1>
				HUB <small>파일관리</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> HUB</a></li>
				<li class="active">파일관리</li>
			</ol>
		</section>
		<section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-12">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-body"><!-- start box body -->
									<div class="row">
										<div class="col-md-12">
											<div class="col-sm-2">
												<div class="form-group" style="margin-bottom: 0px;">
													<label>| 구분</label>
													<div class="form-group" style="margin-bottom: 0px;">
														<select id="s_type" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
															<option value="drw">도면</option>
															<option value="ord">작업표준서</option>
														</select>
													</div>
												</div>
											</div>
											<div class="col-sm-2">
													<div class="form-group" style="margin-bottom: 0px;">
														<label>| 파일명</label>
														<div class="form-group" style="margin-bottom: 0px;">
															<input type="input" id="p_filename" name="p_filename" class="form-control input-sm" placeholder="">
														</div>
													</div>
											</div>
											<div class="col-sm-2">
													<div class="form-group" style="margin-bottom: 0px;">
														<label>| 등록자</label>
														<div class="form-group" style="margin-bottom: 0px;">
															<input type="input" id="p_creator" name="p_creator" class="form-control input-sm" placeholder="">
														</div>
													</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12 text-right">
											<div class="box-tools pull-right">
												<button type="button" id="btn_search" class="btn btn-primary btn-sm" onclick="loadList();">조회</button>
												<!--파일업로드 : start -->
												<button type="button" id="btn_stdDoc_mng" class="btn btn-success btn-sm" onclick="stdDocMng();">작업표준서 관리</button>
												<span class="btn btn-danger btn-sm fileinput-button"> 
													<i class="glyphicon glyphicon-plus"></i> 
													<span>파일업로드</span> 
			<!-- 											<input id="fileupload" type="file" name="files[]" multiple> -->
													<input id="fileupload" type="file" name="files[]">
												</span> 
								           	     <!--파일업로드 : end -->
								           	     <!--파일다운로드 : start -->
							          	      <button type="button" class="btn btn-info btn-sm grid_attach_down" onclick="FileDownload();" data-selfilepath="/upload" data-selfilename="test.xlsx">
												<i class="fa fa-check"></i> 다운로드 
												</button>
							       	   	      <!--파일다운로드 : end -->
							       	   	    </div>
										</div>
									</div>
									<div class="row" style="margin-top: 10px;">
										<div class="col-md-12">
											<div id="grid_reg" style="width: 100%; height: 620px;"></div>
											<div id="pagination" class="text-center"></div>
										</div>
									</div>
								</div>
							</div>
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


<!--  modal area1 -->
<div class="modal fade" id="modal_detail" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title"> 작업표준서 관리 </h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class="col-md-6" style="padding-right: 0px;">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">작업표준서 목록</h3>
									<div class="box-tools pull-right">
										<button type="button" id="" class="btn btn-sm btn-primary" onclick="fnSearchItnbrGrid();">조회</button>
									</div>
								</div>
								<div class="box-body">
									<div class="form-group">
										<label for="" class="col-sm-3 control-label">파일그룹IDX</label>
										<div class="col-sm-7">
											<input type="input" id="s_idx" name="s_idx" class="form-control input-sm" placeholder="">
										</div>
									</div>
									<div class="form-group">
										<label for="" class="col-sm-3 control-label">파일명</label>
										<div class="col-sm-7">
											<input type="input" id="s_filename" name="s_filename" class="form-control input-sm" placeholder="">
										</div>
									</div>
									<div class="form-group">
										<label for="" class="col-sm-3 control-label">등록자</label>
										<div class="col-sm-7">
											<input type="input" id="s_creator" name="s_creator" class="form-control input-sm" placeholder="">
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div id="grid_itnbrlist" style="width: 100%; height: 500px;"></div>
										</div>
									</div>
<!-- 								<div id="dv_grid_itnbrlist" class="box-body"> -->
<!-- 									<table id="grid_itnbrlist"></table> -->
<!-- 									<div id="grid_itnbrlist_pager"></div> -->
<!-- 								</div> -->
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">등록 자재 목록</h3>
									<div class="box-tools pull-right">
										<button type="button" id="" class="btn btn-sm btn-primary" onclick="fnAddMatnr();">자재등록</button>
										<button type="button" id="" class="btn btn-sm btn-primary" onclick="fnDelMatnr();">자재삭제</button>
									</div>
								</div>
								<div class="box-body">
									<div id="grid_addItnbr_list" style="width: 100%; height: 635px;"></div>
<!-- 										<div id="dv_grid_addItnbr_list"> -->
<!-- 										<table id="grid_addItnbr_list"></table> -->
<!-- 									</div> -->
								</div>
							</div>
						</div>
					</div><!-- end row -->
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-sm btn-success" onclick="confirmReqeust();">요청</button>
					<button type="button" id="" class="btn btn-sm btn-default" data-dismiss="modal" onclick="">닫기</button>
<!-- 					<button type="button" id="" class="btn btn-sm btn-default" data-dismiss="modal" onclick="modal_detail_close();">닫기</button> -->
				</div>
			</div>
		</div>
	</div>
</div>

<!-- modal area3 -->  
<div class="modal fade" id="modal_matnr_mapping" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">자재등록</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="box box-warning box-solid">
					<form id="frm_detail_serial" name="frm_detail_serial" class="form-horizontal">
						<div class="row">
							<div class=" col-md-12">
								<div class="box" style="margin-bottom: 0px;">
									<div class="box-header with-border">
										<h3 class="box-title">자재 목록</h3>
										<div class="box-tools pull-right">
											<button type="button" id="btn_a" class="btn btn-success btn-sm" onclick="getMatnrList();">조회</button>
<!-- 											<button type="button" id="btn_a" class="btn btn-success btn-sm" onclick="fnSerchMatnr();">조회</button> -->
											<button type="button" id="btn_s" class="btn btn-success btn-sm" onclick="fnSaveMatnr();">등록</button>
										</div>
									</div>
									<div class="box-body">
										<!-- <div class="form-group">
											<label for="" class="col-sm-3 control-label">Plant 구분</label>
											<div class="col-sm-7">
												<label> <input type="radio" name="rdo_plant_type"  value="1110" checked> 의료</label> 
												<label> <input type="radio" name="rdo_plant_type"  value="1210"> 광</label>
											</div>
										</div> -->
										<div class="form-group">
											<label for="" class="col-sm-3 control-label">자재코드</label>
											<div class="col-sm-7">
												<input type="input" id="s_matnr" name="s_matnr" class="form-control input-sm" placeholder="">
											</div>
										</div>
										<div class="form-group">
											<label for="" class="col-sm-3 control-label">자재내역</label>
											<div class="col-sm-7">
												<input type="input" id="s_maktx" name="s_maktx" class="form-control input-sm" placeholder="">
											</div>
										</div>
										<div id="grid_materiallist" style="width: 100%; height: 500px;"></div>
<!-- 										<div id="dv_grid_materiallist" class="box-body"> -->
<!-- 											<table id="grid_materiallist"></table> -->
<!-- 											<div id="grid_materiallist_pager"></div> -->
<!-- 										</div> -->
									</div>
								</div>
							</div>
						</div><!-- end box body-->
					</form>
				</div><!-- end box -->
        	</div><!-- end modal body -->
		</div><!-- end modal content -->
	</div><!-- end modal -->
</div>

<script src="/res/plugins/pagination.js"></script>
<script type="text/javascript">
//for pagination
var page = 1; 		// 화면에서 사용할 page
var pageNum = 0; 	// 서버에 넘겨줄 page -> mysql 은 0 부터 시작
var rowPerPage = 20;
var rowLength = 0;
var totalPage = 0;
var cntRowPagination = 5;	// << 1 2 3 4 5 >> 

$(function($) {
	fnLoadCommonOption();
	fnLoadRegListGrid();//fnSearchMainGrid

	fnLoadFileHandler();
	
	initItnbrGrid();
	initNewItnbrGrid();  
	initMaterialGrid();
	
	$("#btn_stdDoc_mng").hide();
	
	$('#s_type').change(function(){
		loadList();
		
		if($('#s_type').val() == 'drw') {
			$("#btn_stdDoc_mng").hide();
		} else {
			$("#btn_stdDoc_mng").show();	
		} 
		
	});
	
	$(':radio[name="rdo_plant_type"]').change(function(){
		$('#s_matnr').val('');
		$('#s_maktx').val('');
		getMatnrList();
	});
	
})


// search component setting
function fnLoadCommonOption() {
	/* $(window).bind('resize', function() {
		resizeJqGrid("grid_reg", false);
	}).trigger('resize'); */
	
	$('input[type="radio"].flat-red').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green',
		handle: 'radio'
	});
	$("#register_date_range").pressEnter(function(e) {
		e.preventDefault();
		if(e.target.id == "register_date_range"){
// 			fnSearchMasterCodeGrid();
		}
	});
	$('#register_date_range').daterangepicker({
		 locale: {
			format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
			,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			,dayNames: ['일', '월', '화', '수', '목', '금', '토']
			,dayNames : ['일', '월', '화', '수', '목', '금', '토']
			,dayNamesShort : ['일', '월', '화', '수', '목', '금', '토']
			,dayNamesMin : ['일', '월', '화', '수', '목', '금', '토']
			,showMonthAfterYear: true
			,yearSuffix: '년'
			,orientation: "top left"
	    }
	});
	
	initScreenSizeModal();
}

// serch parameter setting
function loadList(pageNum){
	var page_url = "/file/file_select"
				 + "?file_cate=" + encodeURIComponent($("#s_type").val())
				 + "&file_nm=" + encodeURIComponent($("#p_filename").val())
				 + "&creator=" + encodeURIComponent($("#p_creator").val())
				 + "&file_del_yn=" + encodeURIComponent('N');
	var rowArr = [];
	w2ui['grid_reg'].lock('loading...', true);
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
				if(data.pageTotal == 0){
					$("#pagination").empty();
				} else {
					totalPage = data.pageTotal;
					pagination();
				}
				w2ui['grid_reg'].records = rowArr;
				w2ui['grid_reg'].total = rowArr.length;
			}
			w2ui['grid_reg'].refresh();
			w2ui['grid_reg'].unlock();
		},complete: function () {}
	});
}

// serch result grid
function fnLoadRegListGrid(){

	/* var page_url = "/file/file_select";
	page_url += "?file_cate=" + encodeURIComponent($("#s_type").val())
	page_url += "&file_del_yn=" + encodeURIComponent('N'); */
	
	$("#grid_reg").w2grid({
		name : 'grid_reg',
		show : {
			lineNumbers : true,
            footer: true
        },
        columns : [
			{ field:'file_group', caption:'파일그룹IDX', size:'110px', style:'text-align:center;'},
			{ field:'file_no', caption:'파일NO', hidden:true},
			{ field:'file_repo', caption:'파일저장소', hidden:true},
			{ field:'file_cate', caption:'파일카테고리', size:'110px', render: function (rec) {
				var rst_nm = '';
				if( rec.file_cate == 'drw' ) rst_nm = '도면';
				else rst_nm = '작업표준서';
                return '<div>' + rst_nm + '</div>'; }, style:'text-align:center;' },
			{ field:'file_path', caption:'파일경로', hidden:true},
			{ field:'file_name', caption:'파일명', size:'250px'},
			{ field:'file_ext', caption:'파일확장자', hidden:true},
			{ field:'file_size', caption:'파일사이즈(KB)', size:'150px', render:'number', style:'text-align:right;'},
			{ field:'file_del_yn', caption:'삭제여부', hidden:true},
			{ field:'file_thumnail', caption:'썸네일경로', hidden:true},
			{ field:'date_created', caption:'등록일', size:'180px'},
			{ field:'date_updated', caption:'수정일', hidden:true},
			{ field:'creator', caption:'등록자', size:'90px'},
			{ field:'updater', caption:'수정자', hidden:true}
		],
		sortData: [{field: 'file_no', direction: 'ASC'}],
		records: [],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},
		onClick: function (event) {}
	});
	loadList();
}
/* 
function jqgridHighlightFormatterConfYn(cellvalue, options, rowObject) {
	if (cellvalue != null && cellvalue != "" && cellvalue == "Y") {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">승인</span>';
	} else {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">미승인</span>';
	}
} */

function fn_cancel_req_ord() {
	var id = $("#grid_reg").jqGrid('getGridParam', 'selrow');
	var mas_key = $("#grid_reg").getRowData(id).ref_doc_no;
	
	if($("#grid_reg").getRowData(id).status != 'f1') {
		fnMessageModalAlert("Fail", "이미 진행된 항목입니다.");
		return;
	}
	
	if(id == null || id == "undfined") {
		fnMessageModalAlert("Fail", "선택 된 오더가 없습니다.");
		return;
	}
	
	var page_url = "/frontend/scm/cancel_req_ord";
	var postData = '&ref_doc_no=' + encodeURIComponent(mas_key);


	$.ajax({
	    url: page_url,
	    data: postData,
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalAlert("Notification(HUB)", "해당 실적을 삭제 완료했습니다.");	
		    	loadList();
	    	} else {
	    		fnMessageModalAlert("Notification(HUB)", "정보를 삭제하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(HUB)", "정보를 삭제하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
		
	    }
	});
}

function fnLoadFileHandler(){
	console.log('fnLoadFileHandler()');
	
	$('#fileupload').fileupload({
		dataType : 'json',
		async:false,
		autoUpload : true,
// 		acceptFileTypes : /(\.|\/)(xlsx)$/i,
		maxFileSize : 106800000, 
		add: function(e, data){
			/*
			var uploadFile = data.files[0]; isValid = true;
            if (!(/png|jpe?g|gif/i).test(uploadFile.name)) {
                alert('png, jpg, gif 만 가능합니다');
                isValid = false;
            } else if (uploadFile.size > 5000000) { // 5mb
                alert('파일 용량은 5메가를 초과할 수 없습니다.');
                isValid = false;
            }
			*/
			
			//중복체크
			var existFlag = fileExistChk(data.files[0].name, $("#s_type").val());
			
// 			console.log(data.files[0].name);
			 
			if(existFlag == true && ($("#s_type").val() == 'drw' || $("#s_type").val() == 'ord')) {
				fnMessageModalConfirm("Notification", "동일한 이름을 가진 파일이 존재합니다. 기존파일을 삭제한 뒤 파일이 업로드됩니다.<br/>"
				+ "계속 진행하시겠습니까?", function(chk){
					if(chk){
						data.url = "/file/file_upload?file_cate=" + encodeURIComponent($("#s_type").val());
						var isValid = true;
						if($("#s_type").val().length == 0 ) {
							fnMessageModalAlert("Notification(HUB)", "파일 카테고리를 지정해 주세요.");
							isValid = false;
						}			
			            if (isValid) {
			            	//삭제 플래그 처리 후 업로드 진행
			            	delFlagFile(data.files[0].name, $("#s_type").val());
			                data.submit();              
			            }
					} else {
						return;
					}
				}
			)} else {
				data.url = "/file/file_upload?file_cate=" + encodeURIComponent($("#s_type").val());
				var isValid = true;
				if($("#s_type").val().length == 0 ) {
					fnMessageModalAlert("Notification(HUB)", "파일 카테고리를 지정해 주세요.");
					isValid = false;
				}			
	            if (isValid) {
	                data.submit();              
	            }
			}
		},
	}).on('fileuploadadd', function(e, data) {
	}).on('fileuploadprocessalways', function(e, data) {
		var index = data.index;
		var file = data.files[index];
		if (file.error) {
			fnMessageModalAlert("Notification", file.error);
		}
	}).on('fileuploadprogressall', function(e, data) {
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#progress .progress-bar').css('width', progress + '%');
	}).on('fileuploaddone', function(e, data) {
		loadList();		
	}).on('fileuploadfail', function(e, data) {
		$.each(data.files, function(index) {
			fnMessageModalAlert("Notification", "File upload failed.");
		});
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}


function FileDownload() {
	console.log('FileDownload()');
	var rowdata = $("#grid_reg").getRowData($("#grid_reg").getGridParam('selrow'));
	
	var protocol = jQuery(location).attr('protocol');
  	var host = jQuery(location).attr('host');
    var link_url = "/file/attach_download";
 	link_url += "?file_path="+encodeURIComponent(rowdata.file_path);
 	link_url += "&file_name="+encodeURIComponent(rowdata.file_name);
  
 	$(location).attr('href', link_url);  			

}
/* 
function jqgridHighlightFormatterFileType(cellvalue, options, rowObject) {
	if (rowObject.file_cate == 'drw') {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">도면</span>';
	} else if (rowObject.file_cate == 'ord') {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#AAAADD\">작업표준서</span>';
	}
} */

function fileExistChk(filename, file_cate) {
	console.log('fileExistChk()');
	
	var r_data;
	var regExp = /\s/g;
    var filename = filename.replace(regExp,'');
	
	var page_url = "/file/file_select_nopage"
				 + "?file_cate=" + encodeURIComponent(file_cate)
				 + "&file_name=" + encodeURIComponent(filename)
				 + "&file_del_yn=" + encodeURIComponent("N");
	
	$.ajax({
		url : page_url,
		async: false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				r_data = data.rows;	
			} else {
				fnMessageModalAlert("Notification(MES)", "선택된 지시에 대한 도면 파일정보를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "선택된 지시에 대한 도면 파일정보를 가져오지 못했습니다.");
		},
		complete : function() {}
	});
	
	if(r_data.length >0) {
		return true;
	} else {
		return false;
	}
}

function delFlagFile(filename, file_cate) {
	
	var regExp = /\s/g;

    var filename = filename.replace(regExp,'');
    
	var page_url = "/file/delFlagFile";
	page_url += "?file_cate=" + encodeURIComponent(file_cate)
	page_url += "&file_name=" + encodeURIComponent(filename)
	page_url += "&file_del_yn=" + encodeURIComponent("N");
	
	$.ajax({
		url : page_url,
		async: false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				
			} else {
				fnMessageModalAlert("Notification(MES)", "파일 삭제 처리를 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "파일 삭제 처리를 실패했습니다.");
		},
		complete : function() {}
	});
}

function stdDocMng() {
// 	console.log('stdDocMng()');
	$('#s_idx').val('');
	$('#s_filename').val('');
	$('#s_creator').val('');
	
// 	fnSearchItnbrGrid();
// 	$("#grid_addItnbr_list").jqGrid('clearGridData');
	$('#modal_detail').modal('show');
	setTimeout(function(){
		fnSearchItnbrGrid();
		w2ui.grid_itnbrlist.resize();
		w2ui.grid_itnbrlist.refresh();}, 100);
	setTimeout(function(){
		mapping_list_selc();
		w2ui.grid_addItnbr_list.resize();
		w2ui.grid_addItnbr_list.refresh();}, 100);
}

function initItnbrGrid() {
// 	console.log('initItnbrGrid()');
	$("#grid_itnbrlist").w2grid({
		name : 'grid_itnbrlist',
		show : {
			lineNumbers : true,
            footer: true
        },
        columns : [
			{ field:'file_group', caption:'파일그룹IDX', size:'110px'},
			{ field:'file_no', caption:'파일NO', hidden:true},
			{ field:'file_repo', caption:'파일저장소', hidden:true},
			{ field:'file_cate', caption:'파일카테고리', size:'110px', render: function (rec) {
				var rst_nm = '';
				if( rec.file_cate == 'drw' ) rst_nm = '도면';
				else rst_nm = '작업표준서';
                return '<div>' + rst_nm + '</div>'; } },
			{ field:'file_path', caption:'파일경로', hidden:true},
			{ field:'file_name', caption:'파일명', size:'250px'},
			{ field:'file_ext', caption:'파일확장자', hidden:true},
			{ field:'file_size', caption:'파일사이즈(KB)', size:'100px'},
			{ field:'file_del_yn', caption:'삭제여부', hidden:true},
			{ field:'file_thumnail', caption:'썸네일경로', hidden:true},
			{ field:'date_created', caption:'등록일', size:'180px'},
			{ field:'date_updated', caption:'수정일', hidden:true},
			{ field:'creator', caption:'등록자', size:'90px'},
			{ field:'updater', caption:'수정자', hidden:true}
		],
		sortData: [{field: 'file_no', direction: 'ASC'}],
		records: [],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {
			fnSearchItnbrGrid();
		},
		onClick: function (event) {
// 			console.log(w2ui[event.target].get(event.recid));
			var file_name = (w2ui[event.target].get(event.recid)).file_name;
	    	mapping_list_selc(file_name);
		}
	});
	fnSearchItnbrGrid();
	/* 
	    onSelectRow : function(rowid, selected) {
	    	var file_name = $("#grid_itnbrlist").getRowData(rowid).file_name;
	    	mapping_list_selc(file_name);
		} */
}

function initNewItnbrGrid() {
	$('#grid_addItnbr_list').w2grid({
		name : 'grid_addItnbr_list',
		show : {
			lineNumbers : true,
            footer: true
        },
        columns : [ { field:'matnr', caption:'자재', size:'120px', sortable:true},
					{ field:'maktx', caption:'자재명', size:'130px', sortable:true},
					{ field:'dept_cd', caption:'플랜트', size:'60px', sortable:true},
					{ field:'meins', caption:'단위', size:'50px', sortable:true} ],
		sortData: [{field: 'matnr', direction: 'ASC'}],
		records: [],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {
			mapping_list_selc();
		},
		onClick: function (event) {}
	});
	mapping_list_selc();
}

function fnSearchItnbrGrid() {
	console.log('fnSearchItnbrGrid()');
	var s_idx = $('#s_idx').val();
	var s_filename = $('#s_filename').val();
	var s_creator = $('#s_creator').val();

	var page_url = "/file/file_select"
				 + "?file_group=" + encodeURIComponent(s_idx)
				 + "&file_nm=" + encodeURIComponent(s_filename)
				 + "&creator=" + encodeURIComponent(s_creator)
				 + "&file_cate=" + encodeURIComponent('ord')
				 + "&file_del_yn=" + encodeURIComponent('N');
	
	var rowArr = [];
	w2ui['grid_itnbrlist'].lock('loading...', true);
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
				if(data.pageTotal == 0){
// 					$("#pagination").empty();
				} else {
					totalPage = data.pageTotal;
// 					pagination();
				}
				w2ui['grid_itnbrlist'].records = rowArr;
				w2ui['grid_itnbrlist'].total = rowArr.length;
			}
			w2ui['grid_itnbrlist'].refresh();
			w2ui['grid_itnbrlist'].unlock();
		},complete: function () {}
	});
}

function fnAddMatnr() {
// 	$(this).resetSelection(); //selection제거
// 	$(this).setSelection(rowId, true); //선택한 row만 select
	var selKey = w2ui.grid_itnbrlist.getSelection();
	if( selKey.length==0 ) {
		fnMessageModalAlert("Notification(HUB)", "작업표준서 목록에서 파일내역을 선택한 뒤 진행해주세요.");
		return;
	}

	$('#s_matnr').val('');
	$('#s_maktx').val('');
	
	w2ui.grid_materiallist.records = [];
	$('#modal_matnr_mapping').modal('show');
	setTimeout(function(){
		getMatnrList();
		w2ui.grid_materiallist.resize();
		w2ui.grid_materiallist.refresh();}, 100);
}

function initMaterialGrid() {
	$('#grid_materiallist').w2grid({
		name : 'grid_materiallist',
		show : {
			lineNumbers : true,
            footer: true
        },
        columns : [ //{ field:'matnr', caption:'자재', size:'120px', sortable:true}
                    { field:'matnr', caption:'자재코드', size:'110px', sortable:true},
                    { field:'maktx', caption:'자재내역', size:'140px', sortable:true},
                    { field:'wrkst', caption:' Spec.', size:'140px', sortable:true},
                    { field:'vtext', caption:'제품군명', size:'px', sortable:true, hidden:true},
                    { field:'wgbez', caption:'자재그룹명', size:'px', sortable:true, hidden:true},
                    { field:'date_created', caption:'생성일자', size:'40px', sortable:true, hidden:true},
                    { field:'date_updated', caption:'수정일자', size:'40px', sortable:true, hidden:true},
                    { field:'meins', caption:'단위', size:'px', sortable:true, hidden:false},
                    { field:'lgpro', caption:'lgpro', hidden:true},
                    { field:'sernp', caption:'sernp', hidden:true},
                    { field:'kzumw', caption:'kzumw', hidden:true}
        ],
        sortData: [{field: 'matnr', direction: 'ASC'}],
		records: [],
		total : 0,
		recordHeight : 30,
		onReload: function(event) { getMatnrList(); },
		onClick: function (event) {}
	});
        	
	getMatnrList();
}

function getMatnrList() {
	console.log('getMatnrList()');
	var page_url = '/frontend/hub/material_recv_master_select'
// 				 + '?werks=' + encodeURIComponent($(':radio[name="rdo_plant_type"]:checked').val())
				 + '?matnr='+ encodeURIComponent($('#s_matnr').val())
				 + '&maktx='+ encodeURIComponent($('#s_maktx').val());
	var rowArr = [];
	w2ui['grid_materiallist'].lock('loading...', true);
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
				if(data.pageTotal == 0){
// 					$("#pagination").empty();
				} else {
					totalPage = data.pageTotal;
// 					pagination();
				}
				w2ui['grid_materiallist'].records = rowArr;
				w2ui['grid_materiallist'].total = rowArr.length;
			}
			w2ui['grid_materiallist'].refresh();
			w2ui['grid_materiallist'].unlock();
		},complete: function () {}
	});
}

function fnSaveMatnr() {
	fnMessageModalConfirm("Notification", "해당 데이터를 등록 하시겠습니까?", function(chk){
		if(chk){
			saveMatnr();
		}
	});
}

function saveMatnr() {
	
	if(regDupChk()) {
		return;	//기등록된 내역이 있음
	}
	
	var file_name = $("#grid_itnbrlist").getRowData($("#grid_itnbrlist").getGridParam('selrow')).file_name;
	
	var selKeyArr = $("#grid_materiallist").jqGrid('getGridParam', 'selarrrow');		 
	var params = [];	
	for(var i=0 ; i<selKeyArr.length; i++) {
		params.push($("#grid_materiallist").getRowData(selKeyArr[i]));
	}
	
	var page_url = "/frontend/hub/matnr_workstd_mapping";
	var postData = "params=" +  encodeURIComponent(JSON.stringify(params));
	postData += "&file_name=" + encodeURIComponent(file_name); 
	
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async: false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnMessageModalAlert("Success", "등록되었습니다.");
			} else {
				fnMessageModalAlert("Fail", "실패");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Fail", "실패");
		}
	});		
	
	$('#modal_matnr_mapping').modal('hide');
	
	mapping_list_selc(file_name);
}

function mapping_list_selc(file_name) {
	var page_url = "/frontend/hub/mapping_list_selc"
// 				 + "?file_name=" + encodeURIComponent(file_name)
				 + "?file_name=" + encodeURI(encodeURIComponent(file_name))
				 + "&file_del_yn=" + encodeURIComponent('N');
	var rowArr = [];
	w2ui['grid_addItnbr_list'].lock('loading...', true);
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
				if(data.pageTotal == 0){
// 					$("#pagination").empty();
				} else {
					totalPage = data.pageTotal;
// 					pagination();
				}
				w2ui['grid_addItnbr_list'].records = rowArr;
				w2ui['grid_addItnbr_list'].total = rowArr.length;
			}
			w2ui['grid_addItnbr_list'].refresh();
			w2ui['grid_addItnbr_list'].unlock();
		},complete: function () {}
	});
// 	$("#grid_addItnbr_list").jqGrid('setGridParam', { url : page_url, datatype : 'json' });
// 	$("#grid_addItnbr_list").trigger("reloadGrid");	
}

function fnDelMatnr() {
	fnMessageModalConfirm("Notification", "해당 데이터를 삭제 하시겠습니까?", function(chk){
		if(chk){
			DelMatnr();
		}
	});
}

function DelMatnr() {
	
	var selKey = $("#grid_itnbrlist").getGridParam('selrow');
	if(selKey == null) {
		fnMessageModalAlert("Notification(HUB)", "작업표준서 목록에서 파일내역을 선택한 뒤 진행해주세요.");
		return;
	}
	
	var selKey = $("#grid_addItnbr_list").getGridParam('selrow');
	if(selKey == null) {
		fnMessageModalAlert("Notification(HUB)", "등록 자재 목록에서 파일내역을 선택한 뒤 진행해주세요.");
		return;
	}
	
	var file_name = $("#grid_itnbrlist").getRowData($("#grid_itnbrlist").getGridParam('selrow')).file_name;
	
	var selKeyArr = $("#grid_addItnbr_list").jqGrid('getGridParam', 'selarrrow');		 
	var params = [];	
	for(var i=0 ; i<selKeyArr.length; i++) {
		params.push($("#grid_addItnbr_list").getRowData(selKeyArr[i]));
	}
	
	var page_url = "/frontend/hub/fnDelMatnr";
	var postData = "params=" +  encodeURIComponent(JSON.stringify(params));
	postData += "&file_name=" + encodeURIComponent(file_name); 
	
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async: false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnMessageModalAlert("Success", "삭제되었습니다.");
			} else {
				fnMessageModalAlert("Fail", "실패");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Fail", "실패");
		}
	});		
	
	mapping_list_selc(file_name);
}

function regDupChk() {
	var file_name = $("#grid_itnbrlist").getRowData($("#grid_itnbrlist").getGridParam('selrow')).file_name;
	
	var selKeyArr = $("#grid_materiallist").jqGrid('getGridParam', 'selarrrow');		 
	var matnrs = "";	
	for(var i=0 ; i<selKeyArr.length; i++) {
		matnrs = matnrs + selKeyArr[i] + ',';
	}
	 
	matnrs = matnrs.substring(0, matnrs.length - 1);
	
	if(matnrs.length == 0) {
		fnMessageModalAlert("Notification(HUB)", "선택된 자재가 없습니다.");
		return true;
	}
	
	var r_data;
	
	var page_url = "/frontend/hub/mapping_list_selc";
	page_url += "?file_del_yn=" +  encodeURIComponent('N');
	page_url += "&matnrs=" + encodeURIComponent(matnrs);

	$.ajax({
		url : page_url,
		type : "POST",
		async: false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				r_data = data.rows;
			} else {
				fnMessageModalAlert("Fail", "실패");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Fail", "실패");
		}
	});		

	var txt = "";
// 	console.log(r_data);
	if(r_data.length == 0) {
		return false;
	} else {
		for(var i=0 ; i<r_data.length ; i++) {
			txt += " * " + r_data[i].matnr + " 자재는 " + r_data[i].file_name + " 작업지시서 내역에 이미 등록되어있습니다.<br>" 
		}
		fnMessageModalAlert("Notification(HUB)", txt + "<br> 작업표준서를 자재 매핑하려면 기등록된 내역을 삭제하셔야 합니다.");
		return true;
	}
}

function fnSerchMatnr() {
	var page_url = '/frontend/hub/material_recv_master_select'
		 + '?matnr=' + encodeURIComponent($("#s_matnr").val())
		 + '&maktx=' + encodeURIComponent($("#s_maktx").val());
	
	var rowArr = [];
	w2ui['grid_materiallist'].lock('loading...', true);
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
				if(data.pageTotal == 0){
// 					$("#pagination").empty();
				} else {
					totalPage = data.pageTotal;
// 					pagination();
				}
				w2ui['grid_materiallist'].records = rowArr;
				w2ui['grid_materiallist'].total = rowArr.length;
			}
			w2ui['grid_materiallist'].refresh();
			w2ui['grid_materiallist'].unlock();
		},complete: function () {}
	});
}
</script>
</body>
</html>