<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
// jsp properties
String thema = SessionUtil.getProperties("mes.thema");
String pageTitle = SessionUtil.getProperties("mes.company");
%>
<div class="modal fade" id="modal_mcode" data-backdrop="static">
<!-- 	<div class="modal-dialog modal-lg"> -->
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">라우팅관리 > 공정 정보 </h4>
        	</div>
			<div class="modal-body" id="" style="padding-bottom: 0px;">
				<form id="frm_routing" name="frm_routing" class="form-horizontal">
					<div class="row">
						<div class=" col-md-12">
							<div class="box">
								<div class="box-header with-border">
									<h3 class="box-title">공정 그룹 정보</h3>
								</div>
								<div class="box-body" style="padding-bottom: 0px;">
									<div class="form-group">
										<label for="routing_gno" class="col-sm-3 control-label">그룹코드</label>
										<div class="col-sm-9">
											<input type="input" id="routing_gno" name="routing_gno" class="form-control input-sm" placeholder="auto" readonly="readonly">
										</div>
									</div>
									<div class="form-group">
										<label for="routing_gnm" class="col-sm-3 control-label">그룹명</label>
										<div class="col-sm-9">
											<input type="input" id="routing_gnm" name="routing_gnm" class="form-control input-sm" placeholder="">
										</div>
									</div>
									<div class="form-group">
										<label for="routing_gnm" class="col-sm-3 control-label">공정명</label>
										<div class="col-sm-9">
											<select id="dept_cd" class="form-control select2 input-sm" style="width: 100%;">
												<option value="1110">의료영상</option>
												<option value="1120">의료영상서비스</option>
												<option value="1210">광영상</option>
												<option value="1220">광영상서비스</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label for="routing_gno_gubun_nm" class="col-sm-3 control-label">포장구분</label>
										<div class="col-sm-9">
											<select id="routing_gno_gubun" class="form-control select2 input-sm" style="width: 100%;">
												<option value="N">생산 Routing</option>
												<option value="Y">포장 Routing</option>
										
											</select>
										</div>
									</div>
									
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class=" col-md-12">
							<div class="box">
								<div class="box-header with-border">
									<h3 class="box-title">공정 정보</h3>
									<div class="box-tools pull-right">
						                <button type="button" id="btn_mcode_add" class="btn btn-danger btn-sm" onclick="appendGrid();">추가</button>
						                <button type="button" id="btn_mcode_info" class="btn btn-warning btn-sm" onclick="deleteGridData();">삭제</button>
									</div>
								</div>
								<div id="dv_grid" class="box-body">
									<div id="grid" style="width: 100%; height:200px;"></div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_mcode_save" class="btn btn-success btn-sm" onclick="saveRoutingHeader();">저장</button>
<!-- 					<button type="button" id="btn_mcode_del" class="btn btn-danger">삭제</button> -->
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modal_headerItem" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">공정 상세 정보 </h4>
        	</div>
			<div class="modal-body" id="" style="padding-bottom: 0px;">
				<form id="frm_routingDetail" name="frm_routingDetail" class="form-horizontal">
					<div class="row">
						<div class=" col-md-12">
							<div class="box">
								<div class="box-header with-border">
									<h3 class="box-title">공정 정보</h3>
									<div class="box-tools pull-right">
						                <button type="button" id="" class="btn btn-danger btn-sm" onclick="insertHeaderItem();">추가</button>
						                <button type="button" id="" class="btn btn-warning btn-sm" onclick="deleteHeaderItem();">삭제</button>
									</div>
								</div>
								<div id="" class="box-body">
									<div id="grid_item" style="width: 100%; height:200px;"></div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_mcode_save" class="btn btn-success btn-sm" onclick="saveRoutingHeaderItem();">저장</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modal_detail" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
				<h4 class="modal-title" id="modal_code_title">제품 공정그룹 등록</h4>
        	</div>
			<div class="modal-body" id="" style="padding-bottom: 0px;">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class=" col-md-12">
							<div class="box">
								<div class="box-header with-border">
									<h3 class="box-title">공정 그룹 정보</h3>
								</div>
								<div class="box-body" style="padding-bottom: 0px;">
									<div class="form-group">
										<label for="routing_gno" class="col-sm-3 control-label">그룹코드</label>
										<div class="col-sm-9">
											<input type="input" id="routing_gno_itnbr" name="routing_gno" class="form-control input-sm" placeholder="auto" readonly="readonly">
										</div>
									</div>
									<div class="form-group">
										<label for="routing_gnm" class="col-sm-3 control-label">그룹명</label>
										<div class="col-sm-9">
											<input type="input" id="routing_gnm_itnbr" name="routing_gnm" class="form-control input-sm" placeholder=""readonly="readonly">
										</div>
									</div>
									<div class="form-group">
										<label for="routing_gno_gubun_la" class="col-sm-3 control-label">공정구분</label>
										<div class="col-sm-9">
											<input type="input" id="routing_gno_gubun_modal" name="routing_gno_gubun_modal" class="form-control input-sm" placeholder=""readonly="readonly">
										</div>
										<div class="col-sm-9">
											<input type="hidden" id="routing_gno_gubun_modal_code" name="routing_gno_gubun_modal_code" class="form-control" placeholder=""readonly="readonly">
										</div>
									</div>
									<div class="form-group">
										<label for="routing_gnm" class="col-sm-3 control-label">공정명</label>
										<div class="col-sm-9">
											<select id="dept_cd_itnbr" class="form-control select2 input-sm" style="width: 100%;" readonly="readonly">
												<option value="1110">의료</option>
												<option value="1210">광</option>
											</select>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class=" col-md-6">
							<div class="box" style="margin-bottom: 0px;">
							 	<div class="box-header with-border">
							 	   <h3 class="box-title">조회 조건</h3>
										<div class="box-tools pull-right">
										  <div class="input-group input-group-sm" style="width: 100px;float: left;">
											    <input type="text" id="matnr_search_popup" name="matnr_search" class="form-control pull-right" placeholder="자재코드">
									  	  </div>   
									  	   
										 <div class="input-group input-group-sm" style="width: 200px;float: left;">
											     <input type="text" id="itnbr_search_popup" name="itnbr_search" class="form-control pull-right" placeholder="자재내역">
											<div class="input-group-btn">
								                    <button type="button" id="btn_itnbr_search_popup" class="btn btn-default" onclick="loadList1();"><i class="fa fa-search"></i></button>
								            </div>
								         </div>
								                <button type="button" id="" class="btn btn-warning btn-sm" onclick="addItnbrDetail();">
								                <i class="fa fa-forward" aria-hidden="true"></i></button> 
										</div>
                                    &nbsp;|
							</div>
							<div id="grid_itnbrlist" style="width: 100%; height: 310px;"></div>
								<div id="pagination1" class="text-center"style=" width:100%;height:40px;"></div>
					 
						 </div>
						</div>
						<div class=" col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">추가 제품 목록</h3>
									<div class="box-tools pull-right">
						                <button type="button" id="" class="btn btn-warning btn-sm" onclick="deleteItnbrDetail();">
						                <i class="fa fa-backward" aria-hidden="true"></i></button>
									</div>
								</div>
									<div id="grid_addItnbr_list" style="width: 100%; height: 350px;"></div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_routing_save" class="btn btn-success btn-sm" onclick="saveRoutingDetail();">저장</button>
					<button type="button" id="btn_routing_close" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- ./wrapper -->
<script src="/res/plugins/pagination1.js"></script>
<script type="text/javascript">
var selectData = [];

$(function($) {
// 	w2ui.grid_itnbrlist.clear();
// 	w2ui.grid_addItnbr_list.clear();
	initScreenSizeModal();
	selectData = [];
	initHeaderGrid();
	initHeaderItemGrid();
	initItnbrGrid();
	initNewItnbrGrid();
})
 
function initHeaderGrid() {
	$("#grid").w2grid({
		name : 'grid',
		show : {
			lineNumbers : true
		},
		columns : [
			{ field:'routing_code', caption:'코드', editable:{type:'text'}},
	        { field:'routing_dscr', caption:'공정명', editable:{type:'text'}},
	        { field:'routing_gubun', caption:'구분', 
	        	editable:{type:'select', items:[{id:'P', text:'생산'},{id:'Q', text:'품질'},{id:'C', text:'출하'},{id:'T', text:'최종검사'}]},
	        	render: function (record, index, col_index) {
// 	        		console.log(index, col_index);
					if (this.getCellValue(index, col_index)=='P')
						return '생산';
					else if (this.getCellValue(index, col_index)=='Q')
						return '품질'; 
					else if (this.getCellValue(index, col_index)=='C')
						return '출하';
					else 
						return '최종검사';} }],
		recordHeight : 30,
		onSelect: function(event) {
// 			console.log(event.recid);
			selectData.push(w2ui.grid_mas.get(event.recid));
			$.unique(selectData);
		},
		onChange: function(event) {
// 	        console.log(event);
		      if( event.column==2 ){
		        	var tmpObj = {routing_code:event.value_new, routing_gubun:event.value_new};
		        	if( tmpObj.routing_gubun=='T')
		        		tmpObj.routing_code = 'T1';
			        w2ui.grid.set(event.recid, tmpObj);
		        }
	    }
	});
}

function initHeaderItemGrid() {
	$("#grid_item").w2grid({
		name : 'grid_item',
		columns : [
			{ field:'routing_code', caption:'코드', editable:{type:'text'}},
	        { field:'routing_dscr', caption:'공정명', editable:{type:'text'}},
	        { field:'routing_gubun', caption:'구분', 
	        	editable:{type:'select', items:[{id:'P', text:'생산'},{id:'Q', text:'품질'},{id:'C', text:'출하'},{id:'T', text:'최종검사'}]},
	        	render: function (record, index, col_index) {
	        		if (this.getCellValue(index, col_index)=='P')
						return '생산';
					else if (this.getCellValue(index, col_index)=='Q')
						return '품질'; 
					else if (this.getCellValue(index, col_index)=='C')
						return '출하';
					else 
						return '최종검사';} },
			{ field:'routing_no', caption:'공정명', hidden:true}],
		recordHeight : 30,
		onSelect: function(event) {
// 			console.log(event.recid);
			selectData.push(w2ui.grid.get(w2ui.grid.getSelection()));
			$.unique(selectData);
		},
		onChange: function(event) {
// 	        console.log(event);
	        if( event.column==2 ){
	        	var tmpObj = {routing_code:event.value_new, routing_gubun:event.value_new};
	        	if( tmpObj.routing_gubun=='T')
	        		tmpObj.routing_code = 'T1';
		        w2ui.grid_item.set(event.recid, tmpObj);
	        }
	    }
	}); 
}

function appendGrid() {
// 	console.log('appendGrid()');
	$.each(w2ui.grid.records, function(idx, row){
		row.recid = idx+1;
	});
	w2ui.grid.refresh();
	w2ui.grid.add({recid:w2ui.grid.records.length+1, routing_dscr:'', routing_code:'P', routing_gubun:'P'});
}

function deleteGridData() {
	var selrows = w2ui.grid.getSelection();
	$.each(selrows, function(idx, key){
		w2ui.grid.select(key);
		w2ui.grid.delete(true);
	});
}

function saveRoutingHeader() {
// 	console.log('saveRoutingHeader()');
	var groupNm = $('#routing_gnm').val();
	var deptCd = $('#dept_cd').val();
	var gridDataArr = w2ui.grid.records;
	
	var routing_gno_gubun = $('#routing_gno_gubun').val();   //포장 화면 추가 개발에 따른 포장 오더 구분자 추가 
	
	if( gridDataArr.length>0 ){
		$.each(gridDataArr, function(idx, row){
			if( row.w2ui!=undefined ){
				var change = row.w2ui.changes;
				if( change.routing_code!=undefined )
					row.routing_code = change.routing_code;
				if( change.routing_dscr!=undefined )
					row.routing_dscr = change.routing_dscr;
				if( change.routing_gubun!=undefined )
					row.routing_gubun = change.routing_gubun;
			}
		});
	}
	if( gridDataArr.length==0 ) {
		fnMessageModalAlert("Warning", "공정 정보를 1개이상 추가 하여야 합니다.");
	} else {
		var page_url = "/frontend/hub/routing_header_insert"
		var postData = "routing_gnm=" + encodeURIComponent(groupNm);
			postData += '&dept_cd='+encodeURIComponent(deptCd);
			postData += '&routing_gno_gubun='+encodeURIComponent(routing_gno_gubun);
			postData += "&gridData=" + encodeURIComponent(JSON.stringify(gridDataArr));
		
		$.ajax({
		    url: page_url,
		    data: postData,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
		    		fnMessageModalConfirm("Notification(Hub)", "정보를 저장하였습니다.", function(chk){
		    			if(chk){
		    				searchRoutingHeader();
		    				$('.close').click();		
		    			}
		    		});
		    	} else {
		    		fnMessageModalAlert("Notification(Hub)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(Hub)", "정보를 저장하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    }
		});
	}
}

function insertHeaderItem() {
	$.each(w2ui.grid_item.records, function(idx, row){
		row.recid = idx+1;
	});
	w2ui.grid_item.refresh();
	w2ui.grid_item.add({recid:w2ui.grid_item.records.length+1, routing_dscr:'', routing_code:'P', routing_gubun:'P' });
// 	console.log(w2ui.grid_item.records);
// 	w2ui.grid_item.add({routing_dscr:'', routing_code:'P', routing_gubun:'P' });
}

var delArr = [];	// 1. delete data
function deleteHeaderItem() {
// 	console.log('deleteHeaderItem()');
	
	var selectedKeys = w2ui.grid_item.getSelection();
	var selrows = w2ui.grid_item.get(selectedKeys);
	if( selrows.length==0 ){
		fnMessageModalAlert("Warning", "선택된 공정이 없습니다.");
		return;
	}

	//기존 로드한 데이터삭제시 모든 로드한 데이터 선택하면 경고창 띄운다.
	// 저장 시 grid_item에 저장할 건수가 없다면... 해당 그룹 삭제 경고창 하고 삭제
	var tmpDel = 0;
	var existCnt = 0;
	$.each(w2ui.grid_item.records, function(idx, row){
		if( row.routing_no!=undefined ) {
			existCnt++;
			$.each(selrows, function(i, srow){
				if( srow.routing_no!=undefined && row.routing_no==srow.routing_no ) {
					tmpDel++;
					return false;
				}
			});
		}
	});
// 	console.log('기존 로드한 데이터 건수 : ' + existCnt);
// 	console.log('삭제 선택한 기존 로드한 데이터 건수 : ' + tmpDel);
	
	if( existCnt==tmpDel ) {
		fnMessageModalConfirm("Warning", "삭제 선택한 항목대상에 불러온 기본의 공정정보가 모두 포함되어 있습니다.<br>"+ 
				"추가의 공정정보가 있지 않다면 저장 시 해당 공정 그룹 정보가 삭제될 수 있습니다.<br> 진행 하시겠습니까?", function(chk){
			if( chk ){
				$.each(selectedKeys, function(idx, key){
					w2ui.grid_item.select(key);
					var row = w2ui.grid_item.get(key);
					if( row.routing_no!=undefined ) {
						delArr.push(row);
					}
				});
				w2ui.grid_item.delete(true);			
			}
		});
	} else {
		$.each(selectedKeys, function(idx, key){
			w2ui.grid_item.select(key);
			var row = w2ui.grid_item.get(key);
			if( row.routing_no!=undefined ) {
				delArr.push(row);
			}
		});
		w2ui.grid_item.delete(true);
	}
	return;
}

function saveRoutingHeaderItem() {
// 	console.log('saveRoutingHeaderItem()');
	
	var groupInfo = w2ui.grid_mas.get(w2ui.grid_mas.getSelection())[0];
	var gridDataArr = w2ui.grid_item.records;
	var gridDetArr = w2ui.grid_det.records;
	
	if( gridDataArr.length==0 ){
		if( delArr.length>0 ) {
			// 저장 시 grid_item에 저장할 건수가 없다면... 해당 그룹 삭제 경고창 하고 삭제
			fnMessageModalConfirm("Warning", "데이터를 모두 삭제하는 경우 대상 공정이 삭제됩니다.<br> 진행하시겠습니까?", function(chk){
				if(!chk) return;
			});
		} else {
			fnMessageModalAlert("Warning", "변경된 데이터가 없습니다.");
			return;	
		}
	}

	var insArr = [];	// 2. insert data
	var uptArr = [];	// 3. update data

	$.each(gridDataArr, function(idx, row){
		if( row.routing_no==undefined ) {
			if( row.w2ui!=undefined ){
				var change = row.w2ui.changes;
				if( change.routing_code!=undefined )
					row.routing_code = change.routing_code;
				if( change.routing_dscr!=undefined )
					row.routing_dscr = change.routing_dscr;
				if( change.routing_gubun!=undefined )
					row.routing_gubun = change.routing_gubun;
				insArr.push(row);
			}
		} else{
			if( row.w2ui!=undefined ){
				var change = row.w2ui.changes;
// 				console.log(row, change);
				//routing_code_ori
// 				row.routing_code_ori = row.routing_code; 
				if( change.routing_code!=undefined )
					row.routing_code = change.routing_code;
				if( change.routing_dscr!=undefined )
					row.routing_dscr = change.routing_dscr;
				if( change.routing_gubun!=undefined )
					row.routing_gubun = change.routing_gubun;
				uptArr.push(row);		
			}	
		}
	});
// 	return;
// 	console.log("insArr : ");
// 	console.log(insArr);
// 	console.log("uptArr : " );
// 	console.log(uptArr);
// 	console.log("delArr : " );
// 	console.log(delArr);
	
	var page_url = "/frontend/hub/routing_headerItem_edit"
	var postData = 'routing_gno=' + encodeURIComponent(groupInfo.routing_gno)
				 + '&routing_gnm=' + encodeURIComponent(groupInfo.routing_gnm)
				 + '&dept_cd='+encodeURIComponent(groupInfo.dept_cd)
				 + '&routing_gno_gubun='+encodeURIComponent(groupInfo.routing_gno_gubun)
				 + '&date_created='+encodeURIComponent(groupInfo.date_created)
				 + '&delData=' + encodeURIComponent(JSON.stringify(delArr))
				 + '&params=' + encodeURIComponent(JSON.stringify(delArr))
				 + '&insData=' + encodeURIComponent(JSON.stringify(insArr))
				 + '&uptData=' + encodeURIComponent(JSON.stringify(uptArr));
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		fnMessageModalConfirm("Notification(Hub)", "정보를 저장하였습니다.", function(chk){
	    			if(chk){
	    				searchRoutingHeaderItem(groupInfo.routing_gno)
	    				$('.close').click();		
	    			}
	    		});
	    	} else {
	    		fnMessageModalAlert("Notification(Hub)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(Hub)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    }
	});
}

function initItnbrGrid() {
// 	console.log('initItnbrGrid()');
	$("#grid_itnbrlist").w2grid({
		name : "grid_itnbrlist",
		show : {
			lineNumbers : true
		},
		columns : [
			{ field:'matnr', caption:'자재코드', size:'100px', sortable:true},
			{ field:'maktx', caption:'자재내역', size:'150px', sortable:true},
			{ field:'wrkst', caption:'Spec.', size:'150px', sortable:true},
			{ field:'vtext', caption:'제품군명', hidden:true},
			{ field:'wgbez', caption:'자재그룹명', hidden:true},
			{ field:'date_created', caption:'생성일자', size:'40px', hidden:true},
			{ field:'date_updated', caption:'수정일자', size:'40px', hidden:true}
		],
		recordHeight : 30,
		multiSelect : false
	});
	loadList1();
}

function initNewItnbrGrid() {
// 	console.log('initNewItnbrGrid()');
	$("#grid_addItnbr_list").w2grid({
		name : 'grid_addItnbr_list',
		show : {
			lineNumbers : true
		},
		columns:[
			{ field:'matnr', caption:'자재코드', size:'100px', sortable:true},
			{ field:'maktx', caption:'자재내역', size:'150px', sortable:true},
			{ field:'wrkst', caption:'Spec.', size:'150px', sortable:true},
			{ field:'vtext', caption:'제품군명', hidden:true},
			{ field:'wgbez', caption:'자재그룹명', hidden:true},
			{ field:'date_created', caption:'생성일자', hidden:true},
			{ field:'date_updated', caption:'수정일자', hidden:true}
		],
		recordHeight : 30
	});
}

// search itnbr list
function loadList1(pageNum) {
// 	console.log('loadList1()');
	
	if( pageNum==undefined ){
		page=1;
		pageNum = 0;
	} else {
		page=pageNum;
		pageNum = (pageNum-1)*rowPerPage;
// 		pageNum = pageNum-1;
	}
	var page_url = "/frontend/hub/routing_material_recv_master_select_w2ui"
				 + "?maktx=" + encodeURIComponent($('#itnbr_search_popup').val())
				 + "&matnr="+ encodeURIComponent($('#matnr_search_popup').val())
				 + "&page="+ encodeURIComponent(pageNum)
				 + "&rows="+ encodeURIComponent(rowPerPage);
	w2ui['grid_itnbrlist'].lock('loading...', true);
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
					$("#pagination1").empty();
				} else {
					totalPage = data.pageTotal;
					pagination1();
				}
				w2ui['grid_itnbrlist'].records = rowArr;
				w2ui['grid_itnbrlist'].total = data.rowTotal;
			} else {
				w2ui['grid_itnbrlist'].clear();
			}
			w2ui['grid_itnbrlist'].refresh();
			w2ui['grid_itnbrlist'].unlock();
		},complete: function () {}
	});
}

var dataArr = [];
//itnbr move to newlist
function addItnbrDetail() {
// 	console.log('addItnbrDetail()');
	var groupInfo = w2ui.grid_itnbrlist.get(w2ui.grid_itnbrlist.getSelection()[0]);
	var gridDataArr = w2ui.grid_addItnbr_list.records;
	// 추가하려는 목록이 선택 되었는가?
	if( groupInfo.length==0 ){
		fnMessageModalAlert("Warning", "추가하려는 항목을 선택해야 합니다.");
	} else {
		// 기존에 추가된 항목인지 확인
		if( gridDataArr.length>0 ){
			var chkCnt = 0;
			$.each(gridDataArr, function(idx, row){
				if( row.matnr==groupInfo.matnr ){
					chkCnt++;
				} 
			});
			// chkCnt가 0보다 크면, 같은 항목이 한개 이상 있다는...
			if( chkCnt==0 ){
				dataArr.push(groupInfo);
				w2ui.grid_addItnbr_list.add(groupInfo);
			}
		}else{
			dataArr.push(groupInfo);
			w2ui.grid_addItnbr_list.add(groupInfo);
		}
	}
}

// remove new itnbr list
function deleteItnbrDetail() {
	w2ui.grid_addItnbr_list.select(w2ui.grid_addItnbr_list.getSelection()[0]);
	w2ui.grid_addItnbr_list.delete(true);
// 	$("#grid_addItnbr_list").jqGrid('delRowData', $("#grid_addItnbr_list").getGridParam('selrow'));
}

// save routing detail
function saveRoutingDetail() {
// 	console.log('saveRoutingDetail()');
	$("#btn_routing_save").prop("disabled", true);
	$("#btn_routing_close").prop("disabled", true);

	var routing_gno = $("#routing_gno_itnbr").val();
	var gridDataArr = w2ui.grid_addItnbr_list.records;
	var routing_gno_gubun = $("#routing_gno_gubun_modal_code").val(); 
	
	if( gridDataArr.length==0 ) {
		$('.close').click();
	} else {
		var jsonStr = JSON.stringify(gridDataArr);
		var page_url = "/frontend/hub/routing_detail_insert"
		var postData = 'routing_gno=' + encodeURIComponent(routing_gno)
		             + '&routing_gno_gubun=' + encodeURIComponent(routing_gno_gubun)
					 + '&gridData=' + encodeURIComponent(jsonStr);
		$.ajax({
		    url: page_url,
		    data: postData,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
		    		fnMessageModalConfirm("Success", "정보를 저장하였습니다.", function(chk){
		    			if(chk){
		    				
		    				w2ui.grid_addItnbr_list.clear();
		    				loadList();
							loadList1();
		    				$('.close').click();
		    			}
		    		});
		    	} else {
		    		fnMessageModalAlert("Fail", "정보를 저장하는데 에러가 발생하였습니다.");	
		    	}
		    	$("#btn_routing_save").prop("disabled", false);
		    	$("#btn_routing_close").prop("disabled", false);
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Error", "정보를 저장하는데 에러가 발생하였습니다.");	
		    }
		});
	}
}
</script>
