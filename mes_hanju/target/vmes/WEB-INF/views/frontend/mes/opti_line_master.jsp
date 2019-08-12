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

<body class="hold-transition skin-green-light sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1010" />
		<jsp:param name="selected_menu_cd" value="1085" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        MES<small>LINE 관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> MES</a></li><li class="active">LINE 관리</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
    	<div class="row">
			<div class="col-md-6">
				<div class="row">
					<div class=" col-md-12">
						<div class="box">
							<div class="box-header with-border">
								<h3 class="box-title">LINE 정보</h3>
 					    	
								<div class="box-tools pull-right">
									<div class="input-group input-group-sm" style="width: 100px;float: left;">
										<select id="sel_dept_cd" class="form-control select2 input-sm" style="width: 100%;" onchange="searchRoutingHeader();">
											<option value="">전체</option>
											<option value="1110">의료영상</option>
											<option value="1120">의료영상서비스</option>
											<option value="1210">광영상</option>
											<option value="1220">광영상서비스</option>
										</select>
					                </div> | 
<!-- 									<button type="button" id="" onclick="searchRoutingHeader();" class="btn btn-primary btn-sm">조회</button> -->
<!-- 									<button type="button" id="" onclick="addRoutingHeader();" class="btn btn-primary btn-sm">LINE 정보 추가</button> -->
										<button type="button" id="" onclick="addLineHeader();" class="btn btn-primary btn-sm">LINE 정보 추가</button> 
 								    	<button type="button" id="" onclick="deleteLineHeader();" class="btn btn-warning btn-sm">삭제</button>
 								    	<button type="button" id="" onclick="saveLineHeader();" class="btn btn-danger btn-sm">저장</button>  
								</div>
							</div>
							<div class="box-body" style="padding-bottom: 0px;">
								<div id="grid_mas" style="width: 100%; height: 660px;"></div>
							</div>
						</div>
					</div>
				</div>
				 
			</div>
			<div class="col-md-6">
				<div class="box" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">LINE MEMBER</h3>
						<div class="box-tools pull-right">
			          <!--       <div class="input-group input-group-sm" style="width: 150px;float: left;">
			                   <input type="text" id="itnbr_search" name="itnbr_search" class="form-control pull-right input-sm" placeholder="name Search">  
								<div class="input-group-btn">
			                    <button type="button" id="btn_itnbr_search" class="btn btn-default " onclick="searchItnbr();"><i class="fa fa-search"></i></button>
			                  </div>
			                </div> -->
			                &nbsp;|
			                <button type="button" id="" class="btn btn-warning btn-sm" onclick="addmember();">MEMBER 추가</button>
			                <button type="button" id="btn_itnbr_del" class="btn btn-danger btn-sm" onclick="line_member_delete();">삭제</button>
						</div>
					</div>
					<div class="box-body" style="padding-bottom:0px;">
					<!-- 	<div id="grid_itnbr" style="width: 100%; height: 660px;"></div> -->
					    <div id="grid_member" style="width: 100%; height: 660px;"></div>
					    <div id="pagination" class="text-center"></div>
					</div>
				</div>
			</div>
		</div>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <!-- popup include -->
 
 <div class="modal fade" id="modal_worker_add" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
		 <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				 
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="box box-warning box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">작업자정보</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_worker_add" class="btn btn-success btn-sm" onclick="fnWorkerAdd();">저 장</button>
						</div>
					</div>
					<form id="frm_worker_add" name="frm_worker_add" class="form-horizontal">
					<div class="box-body">
						<div class="form-group">
							<label for="mes_po" class="col-sm-3 control-label">라인 이름</label>
							<div class="col-sm-9">
								<input type="input" id="i_line_nm" name="i_line_nm" class="form-control"  maxlength="20" readonly="readonly">
							</div>
						</div>
						<div class="form-group">
							<label for="mes_po" class="col-sm-3 control-label">작업 구분</label>
							<div class="col-sm-9">
								<input type="input" id="i_jo_nm" name="i_jo_nm" class="form-control"  maxlength="20" readonly="readonly">
							</div>
						</div>
						 
						<div class="form-group">
						 
							<div class="col-sm-12 box-body" id="dv_grid_worker" >
								<div id="grid_worker" style="width: 100%; height: 660px;"></div>  
			  				  <div id="pagination" class="text-center"></div>						
							</div>
						</div>         
					</div>
					</form>
				</div><!-- end box -->
			</div><!-- end modal body -->
		</div><!-- end modal-content -->
	</div><!-- end modal dialog -->
</div><!-- end modal div --> 
			
  



 
  	 
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
document.getElementById("sel_dept_cd").selectedIndex=3;

$(function($) {
//	fnLoadCommonOption();
	loadlineHeader();  //loadRoutingHeader();
	initScreenSizeModal();
	
})

// search component setting
/* function fnLoadCommonOption() {
	$( "#btn_search" ).on('click', function(e) {
		e.preventDefault();
		fnSearchMaster();
	});
	
	$('#btn_itnbr_del').hide();
} */
  
// serch result grid
function loadlineHeader(){
// 	console.info('loadRoutingHeader()');
	$("#grid_mas").w2grid({
		name : 'grid_mas',
		show : {
		 
			header : true,
			lineNumbers : true,
            footer: true
        },
		columns : [
			{ field:'jocod', caption:'LINE코드', size:'100px', sortable:true, style:'text-align:center', editable:{ type: 'text'}},
			{ field:'line_nm', caption:'라인명', sortable:true, editable:{ type: 'text'}},
			{ field:'jo_nm', caption:'작업조명', sortable:true, editable:{ type: 'text'}},
			{ field:'dept_cd', caption:'사업부코드', sortable:true, hidden:true},
			{ field:'dept_nm', caption:'사업부명', sortable:true } ],
// 		sortData: [{field: 'routing_gno', direction: 'ASC'}],
		records: [],
		total : 0,
		recordHeight : 30,
		onSelect: function(event) {
// 			console.log(event.recid);
//			$('#btn_itnbr_del').show();
			var jocod = w2ui.grid_mas.get(event.recid).jocod;
//			searchRoutingHeaderItem(routing_gno);
// 			searchRoutingDetail(routing_gno);
			searchMemberHeader(jocod);
			setTimeout(loadMemberList, 300);
		}
	});
	var rowArr = [];
	var lastsel2;
	//var page_url = "/frontend/prod/routing_header_select"
	var page_url = "/frontend/prod/line_header_select"
		 		 + "?dept_cd=" + encodeURIComponent($('#sel_dept_cd').val());
	w2ui['grid_mas'].lock('loading...', true);
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
				w2ui['grid_mas'].records = rowArr;
				w2ui['grid_mas'].total = rowArr.length;
			}
			w2ui['grid_mas'].refresh();
			w2ui['grid_mas'].unlock();
		},complete: function () {}
	});
}

function addLineHeader() {
	w2ui.grid_mas.add({recid:(w2ui.grid_mas.records).length+1});	
}

//group info save
function saveLineHeader() {
// 	console.log('saveLineHeader()');
	// master info

	var lineData = w2ui.grid_mas.records;
 
 
	if( lineData.length>0 ){
		$.each(lineData, function(idx, row){
			if( row.w2ui!=undefined ){
				var change = row.w2ui.changes;
				if( change.jocod !=undefined )
					row.jocod = change.jocod;
				if( change.line_nm !=undefined )
					row.line_nm = change.line_nm;
				if( change.jo_nm !=undefined )
					row.jo_nm = change.jo_nm;	 
			}
		});
	}

	var gubun = "";
	if ( $("#p_gr_no").val()=='' )
		gubun = "addGroup";
		
	var pageURI = "/frontend/prod/line_header_save";
	var postData = "lineData=" + encodeURIComponent(JSON.stringify(lineData))
				 + "&dept_cd="+encodeURIComponent($('#sel_dept_cd').val());
 
 	console.log(lineData);
 	 
	$.ajax({
		url: pageURI,
		data: postData,
		type: "POST",
		success:function(data, textStatus, jqXHR){
			if(data.status == "200") {
				fnMessageModalAlert("결과", "정보를 성공적으로 추가하였습니다.");
				loadlineHeader();
			} else {
				fnMessageModalAlert("결과", "정보를 추가하는데 에러가 발생하였습니다.");	
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("결과", "정보를 삭제하는데 에러가 발생하였습니다.");	
		},
		complete: function() {}
	});
}


function deleteLineHeader() {
// 	console.log('deleteGridFw()');
	var selection =  w2ui.grid_mas.getSelection();
	if( selection.length>0 ){
		$.each(selection, function(idx, recid){
			w2ui.grid_mas.select(recid);
			w2ui.grid_mas.delete(true);
		});
	}
}

//INIT PRODUCT LIST grid
function searchMemberHeader() {
	console.log('searchMemberHeader()');
	
	$("#grid_member").w2grid({
		name : 'grid_member',
		show : {
			lineNumbers : true,
	        footer: true
	    },
	    columns : [
			{ field:'jocod', caption:'LINE코드', size:'10%', sortable:true},	//key: true
			{ field:'line_nm', caption:'LINE명', size:'20%', sortable:true},
			{ field:'jo_nm', caption:'작업구분', size:'20%',   sortable:true},
			{ field:'member_id', caption:'아이디', size:'20%',   sortable:true},
			{ field:'member_nm', caption:'이름', size:'30%',   sortable:true}
		],
	    sortData: [{field: 'member_id', direction: 'ASC'}],
	    records: [],
		total : 0,
		recordHeight : 30
	});
	loadMemberList();
}

function loadMemberList(pageNum) {
  	console.log('loadMemberList(' + pageNum + ')');
	
	w2ui.grid_member.clear();
	
	if( pageNum==undefined ){
		page=1;
		pageNum = 0;
	} else {
		page=pageNum;
		pageNum = pageNum-1;
	}
	
	var selection = w2ui.grid_mas.getSelection();
	var page_url = '';
	if( selection.length==0 ) {
// 		console.log('case1');
		/* page_url = '/frontend/prod/routing_material_recv_master_select_w2ui'
					 + "?page="+ encodeURIComponent(pageNum)
					 + "&rows="+ encodeURIComponent(rowPerPage);	 */
	} else {
// 		console.log('case2 ',pageNum,rowPerPage);
		page_url = "/frontend/prod/line_member_select"
	 			 + "?jocod=" + encodeURIComponent(w2ui.grid_mas.get(selection[0]).jocod)
	 			 + "&page="+ encodeURIComponent(pageNum)
				 + "&rows="+ encodeURIComponent(rowPerPage);
	}
	w2ui['grid_member'].lock('loading...', true);
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
// 					console.log(data.pageTotal);
					totalPage = data.pageTotal;
					pagination();
				}
				w2ui['grid_member'].records = rowArr;
				w2ui['grid_member'].total = data.rowTotal;
			}
			w2ui['grid_member'].refresh();
			w2ui['grid_member'].unlock();
		},complete: function () {}
	});
}
 
 
// line_member_delete
function line_member_delete() {
// 	console.log('deleteRoutingDetail()');
	var jocod = w2ui.grid_mas.get(w2ui.grid_mas.getSelection()[0]).jocod;
	var gridData = w2ui.grid_member.get(w2ui.grid_member.getSelection());
	if( gridData.length==0 ){
		fnMessageModalAlert("Warning", "삭제 하려는 정보를 목록에서 선택하지 않았습니다.");
		return;
	} else if( gridData.length>1){
		fnMessageModalAlert("Warning", "항목한개씩 선택해 주시기 바랍니다.");
		return;
	} else {
		$.ajax({
		    url: "/frontend/prod/line_member_delete",
		    data: "jocod=" + encodeURIComponent(jocod)+ "&member_id=" + encodeURIComponent(gridData[0].member_id),
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    	fnMessageModalAlert("Notification(MES)", "정상적으로 삭제되었습니다.");
			    	loadMemberList();
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    }
		});
	}
}


// addmember
function addmember() {
	console.log('addmember()');
	var key = w2ui.grid_mas.getSelection();
	if( key.length==0 ){
		fnMessageModalAlert("Warning", "LINE정보을 선택하세요.");
	} else {
		var groupInfo = w2ui.grid_mas.get(key)[0];
	/* 	$('#routing_gno_itnbr').val(groupInfo.routing_gno);
		$('#routing_gnm_itnbr').val(groupInfo.routing_gnm);
		$('#dept_cd_itnbr').val(groupInfo.dept_cd);
		searchItnbrpopup();
		$("#grid_addItnbr_list").jqGrid('clearGridData'); */
		
	  
	 
		$("#i_line_nm").val(groupInfo.line_nm);
		$("#i_jo_nm").val(groupInfo.jo_nm);	
		
		
	
		loadmemberinfo();
	}
}

  


function loadmemberinfo(pageNum) {
  	console.log('loadmemberinfo(' + pageNum + ')');
	$('#modal_worker_add').modal('show');
  	$("#grid_worker").w2grid({
		name : 'grid_worker',
		show : {
			
			selectColumn: true,
			lineNumbers : true,
	        footer: true
	    },
 
	    columns : [
			{ field:'dept_nm', caption:'사업부구분', size: '30%',   sortable:true},
			{ field:'member_id', caption:'아이디', size:'30%',   sortable:true},
			{ field:'member_nm', caption:'이름', size:'40%',   sortable:true}
		],
	    sortData: [{field: 'member_id', direction: 'ASC'}],
	    records: [],
		total : 0,
		recordHeight : 30
	});
  	
  	
	w2ui.grid_worker.clear();
	w2ui.grid_worker.resize();
	w2ui['grid_worker'].refresh();
	
	if( pageNum==undefined ){
		page=1;
		pageNum = 0;
	} else {
		page=pageNum;
		pageNum = pageNum-1;
	}
	
	var selection = w2ui.grid_mas.getSelection();
	var page_url = '';
  
		page_url = "/frontend/prod/loadmemberinfo"
	 			 + "?dept_cd=" + encodeURIComponent($('#sel_dept_cd').val())
	 			 + "&page="+ encodeURIComponent(pageNum)
				 + "&rows="+ encodeURIComponent(rowPerPage);
 
	w2ui['grid_worker'].lock('loading...', true);
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
// 					console.log(data.pageTotal);
					totalPage = data.pageTotal;
					pagination();
				}
				w2ui['grid_worker'].records = rowArr;
				w2ui['grid_worker'].total = data.rowTotal;
			}
			
			setTimeout(function(){
				w2ui.grid_worker.resize();
				w2ui['grid_worker'].refresh();
			}, 100);
		//	w2ui.grid_worker.resize();
		 
			w2ui['grid_worker'].refresh();
			w2ui['grid_worker'].unlock();
		},complete: function () {
			
		
			
			
		}
	});
}
 

// line_member_delete
function fnWorkerAdd() {
// 	console.log('deleteRoutingDetail()');


	var selectJob =   w2ui.grid_worker.get(w2ui.grid_worker.getSelection());
	var key = w2ui.grid_mas.getSelection();
	var groupInfo = w2ui.grid_mas.get(key)[0];
	 
    var params = [];
    var record = this.record;
    var fields = this.fields;
    for (var i=0, l=selectJob.length; i<l; i++) {
     	 
    	var selRow = {};
		 
		selRow.member_id =w2ui.grid_worker.get(w2ui.grid_worker.getSelection()[i]).member_id;
		selRow.member_nm =w2ui.grid_worker.get(w2ui.grid_worker.getSelection()[i]).member_nm;
		
		
    	 params.push(selRow); //배열에 맵처럼 담김      
 	
    }
        
    console.log(params);
 
	var gridData = w2ui.grid_worker.get(w2ui.grid_worker.getSelection());
	if( gridData.length==0 ){
		fnMessageModalAlert("Warning", "선택된 정보가 없습니다..");
		return;
	  
	} else {
		$.ajax({
		    url: "/frontend/prod/fnWorkerAdd",
		    data: "jocod=" + encodeURIComponent(groupInfo.jocod)+ "&dept_cd=" + encodeURIComponent(groupInfo.dept_cd)+ "&params=" + encodeURIComponent(JSON.stringify(params)),
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    	fnMessageModalAlert("Notification(MES)", "정상적으로 처리되었습니다.");
			    	$('#modal_worker_add').modal('hide');
			    	loadMemberList();
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    }
		});
	}
}

 
</script>
</body>
</html>