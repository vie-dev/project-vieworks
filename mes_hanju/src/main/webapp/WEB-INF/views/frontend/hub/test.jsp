<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*" %>
<%
// jsp properties
String thema = SessionUtil.getProperties("mes.thema");
String pageTitle = SessionUtil.getProperties("mes.company");
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	
	 <style type="text/css">
		.ichk_label {
			font-weight: unset;
    		font-size: 12px; }
	 </style>
	 
		<body class="hold-transition skin-<%=thema%> sidebar-mini">
			<jsp:include page="/common/top_menu_inc" flush="true">
				<jsp:param name="fb_div" value="F" />
				<jsp:param name="page_title" value="0" />
			</jsp:include>
		  
			<jsp:include page="/common/sidebar_menu_inc" flush="true">
				<jsp:param name="menu_div" value="F" />
				<jsp:param name="selected_menu_p_cd" value="1020" />
				<jsp:param name="selected_menu_cd" value="1128" />
			</jsp:include>

			<div class="content-wrapper">
			    <section class="content-header">
			        <section class="content-header">
			        <h1>
			           	test
			            <small>test</small>
			        </h1>
			        <ol class="breadcrumb">
			            <li><a href="#"><i class="fa fa-dashboard"></i>test</a></li>
			            <li class="active"> Test</li>
			        </ol>
			    </section>
			
			    <!-- Main content -->
				<section class="content" style="padding-bottom: 0px;">
					<div class="box" style="margin-bottom: 0px;height: 790px;">
						<div class="box-body"><!-- start box body -->
							
							<div style="margin-left: 15px; margin-bottom: 15px;">
								<button type="button" id="" onclick="test();" class="btn btn-success btn-sm">값 가져오기 test</button>
								
								<label for="">이름으로 검색</label>
								<input type="text" id="search" name="search" placeholder="성을 입력하세요" class="" />
								<button type="button" onclick="json_test();" class="btn btn-success btn-sm">json test</button>
								<button type="button" onclick="searchText();" class="btn btn-success btn-sm">검색 test</button>
								
								<button type="button" id="" onclick="fnPopupInfo('N');" class="btn btn-success btn-sm">등록</button>
								<!-- <button type="button" id="" onclick="fnPopupInfo('U');" class="btn btn-success btn-sm">수정</button>
								<button type="button" id="" onclick="fnDelete();" class="btn btn-danger btn-sm">삭제</button>		 -->					
							</div>
							
							
							<!-- start select -->
							<div class="modal fade" id="modal_test" aria-hidden="true" style="display: none; z-index: 1060;"><!-- data-backdrop="static"> -->
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="test_title">조회</h4>
							        	</div>
										<div class="modal-body" id="">
											<form id="test_info" name="frm_info" class="form-horizontal">
											
												<div id="test_project_no" class="form-group row">
													<div class="col-sm-1"></div>
													<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">번호</label>
													<div class="col-sm-7">
														<input type="text" class="form-control input-sm" id="js_no" value="" ><!-- disabled : 비활성화 -->
													</div>
													<div class="col-sm-1"></div>
												</div>
												
												
												<div class="form-group row">
													<div class="col-sm-1"></div>
													<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">이름</label>
													<div class="col-sm-7">
														<input type="text" class="form-control input-sm" id="js_nm" value="">
													</div>
													<div class="col-sm-1"></div>
												</div>
												
											</form>
										</div>
										<div class="modal-footer">
											<div class="col-md-12 text-center">
												<button type="button" id="test_btn_dmr_cancel" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
											</div>
										</div>
										
									</div>
								</div>
							</div> <!-- end modal select -->
							
							<!-- start insert -->
							<div class="modal fade" id="modal_info" aria-hidden="true" style="display: none; z-index: 1060;"><!-- data-backdrop="static"> -->
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="modal_title">조회</h4>
							        	</div>
										<div class="modal-body" id="">
											<form id="frm_info" name="frm_info" class="form-horizontal">
											
												<div id="a_project_no" class="form-group row">
													<div class="col-sm-1"></div>
													<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">번호</label>
													<div class="col-sm-7">
														<input type="text" class="form-control input-sm" id="test_no" value="" status=""><!-- disabled : 비활성화 -->
													</div>
													<div class="col-sm-1"></div>
												</div>
												
												<div class="form-group row">
													<div class="col-sm-1"></div>
													<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">멤버 ID</label>
													<div class="col-sm-7">
														<input type="text" class="form-control input-sm" id="test_id" value="">
													</div>
													<div class="col-sm-1"></div>
												</div>
												
												<div class="form-group row">
													<div class="col-sm-1"></div>
													<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">멤버 이름</label>
													<div class="col-sm-7">
														<input type="text" class="form-control input-sm" id="test_name" value="">
													</div>
													<div class="col-sm-1"></div>
												</div>
												
												<div class="form-group row">
													<div class="col-sm-1"></div>
													<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">패스워드</label>
													<div class="col-sm-7">
														<input type="text" class="form-control input-sm" id="test_pwd" value="">
													</div>
													<div class="col-sm-1"></div>
												</div>
												
												<div class="form-group row">
													<div class="col-sm-1"></div>
													<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">생성일자</label>
													<div class="col-sm-7">
														<div class="input-group">
															<div class="input-group-addon">
																<i class="fa fa-calendar"></i>
															</div>
															<input type="text" class="form-control pull-right input-sm" id="test_created">
														</div>
													</div>
													<div class="col-sm-1"></div>
												</div>
												
												<div class="form-group row">
													<div class="col-sm-1"></div>
													<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">수정일자</label>
													<div class="col-sm-7">
														<div class="input-group">
															<div class="input-group-addon">
																<i class="fa fa-calendar"></i>
															</div>
															<input type="text" class="form-control pull-right input-sm" id="test_updated">
														</div>
													</div>
													<div class="col-sm-1"></div>
												</div>
												
											</form>
										</div>
										<div class="modal-footer">
											<div class="col-md-12 text-center">
												<button type="button" id="btn_dmr_save" class="btn btn-success btn-sm" onclick="fnInsert();">Save</button>
												<button type="button" id="btn_dmr_cancel" class="btn btn-default btn-sm " data-dismiss="modal">Close</button>
											</div>
										</div>
										
									</div>
								</div>
							</div> <!-- end modal update -->
							
							<div style="display: none;">	
								<label>test 1</label>		
								<input type="text" id="js_noV" value="" />
								<input type="text" id="js_nmV" value="" />
							</div>
							<div class="col-md-12">
									<div id="grid" style="width: 100%; height: 600px;"></div>
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

		<script src="/res/plugins/pagination.js"></script>
		
		<script type="text/javascript">
		// for pagination
		var page = 1; 		// 화면에서 사용할 page
		var pageNum = 0; 	// 서버에 넘겨줄 page -> mysql 은 0 부터 시작
		var rowPerPage = 20;
		var rowLength = 0;
		var totalPage = 0;
		var cntRowPagination = 5;	// << 1 2 3 4 5 >> 

		var upload_data;

	
		$(function($) {
			
			
			
			minDate = getFormatDate(new Date()),
			mdTemp = new Date(), 
			maxDate = getFormatDate(new Date(mdTemp.setDate(mdTemp.getDate() + 7)));
			 
			$('#test_created, #test_updated').daterangepicker({
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
			
			
			var rowArr = [];
			
			$('#grid').w2grid({ 
				name : "grid" ,
				show: { footer: true },
		        multiSelect: false,
		        columns: [
		                  { field: 'recid', caption: 'recid', size: '30%', sortable: true, attr: 'align=center', resizable: true },
		                  { field: 'member_emp_no', caption: 'No', size: '30%', sortable: true, attr: 'align=center', resizable: true },
		                  { field: 'member_nm', caption: 'Name', size: '30%', sortable: true, attr: 'align=center', resizable: true }
		                  ],
		        sortData: [{field: 'plan_dt', direction: 'ASC'}],
				records: [   
				         ],
				total : 0,
				recordHeight : 30,
				onReload: function(event) {},
				// sssssbbbb
				onClick: function (event) {
				
				},
				onDblClick: function(event) {
					test();
				}
		    });
			loadList();
			
			
		});
		
		
		function getFormatDate(d) {
			var month = d.getMonth() + 1;
			var date = d.getDate();
			month = (month < 10) ? "0" + month : month;
			date = (date < 10) ? "0" + date : date;
			return d.getFullYear() + '-' + month + '-' + date;
		}
		
		// 현재 그리드의 값을 모달에 가져오는 방법
		function test(event) 
		{
			$("#modal_test").modal("show");
			
			// $("#p_project_no").val(row.project_no);
			var sel = w2ui.grid.getSelection();
			
			//
				 //w2ui.grid.records[event.recid-1]; // .project_no
				 
		//	alert(sel);
			
			 var jsno = w2ui.grid.records[sel -1].member_emp_no; //$("#js_noV").val();
			 var jsnm = w2ui.grid.records[sel -1].member_nm;  //$("#js_nmV").val();
			
			console.log(jsno);
			console.log(jsnm);
			
			
			$("#js_no").val(jsno);
			$("#js_nm").val(jsnm); 
		}
		
		
		// 레코드 값들 가져오는 함수 
		function loadList(){  // 전역변수 설정함 
		
				var page_url = "/frontend/test"
					//var page_url = "/frontend/project_select"
							/*  + "?project_division=" + encodeURIComponent($("#project_division").val())
							 + "&project_no=" + encodeURIComponent($("#project_no").val())
							 + "&project_nm=" + encodeURIComponent($("#project_nm").val())
							 + "&lifnr=" + encodeURIComponent($("#lifnr").val()) */
							 
							
							 + "?page="+ encodeURIComponent(pageNum)
							 + "&rows="+ encodeURIComponent(rowPerPage)
							 + "&search="+ encodeURIComponent(search);
				
				//w2ui['grid'].lock('loading...', true);
				// 주석 안주면 계속 loading..
				var rowArr = [];
				$.ajax({
					url : page_url,
					type : 'POST',
					dataType : 'json',
					async : false,
					success : function( data ) {
						console.log(data.rows);
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
							w2ui['grid'].records = rowArr;
							w2ui['grid'].total = data.rowTotal;
						} else if(data.status == 200 && (data.rows).length == 0) {
							w2ui.grid.clear();
							$("#pagination").empty();
							w2ui['grid'].records = rowArr;
							w2ui['grid'].total = 0;
						}
						w2ui['grid'].refresh();
						w2ui['grid'].unlock();
					},complete: function () {}
				});
			}
		
		// 검색 조건에 따라 나오는 값..	
		function searchText(){

			console.log("searchText 버튼 클릭");
			
			var search = $("#search").val();
			
			if(!chkSubmit($("#search"), "검색어를")) return;
			
			//var tf = isNaN(search);
			//console.log("tf : " + tf);

			// if(true == tf) return; 
			// if(true != tf) return;
			 // << 한글만 받으렴~
			 
			
			console.log("그리드에 다시 값 가져오기");
			
			var page_url = "/frontend/searchText";
						 //+ "?page="+ encodeURIComponent(pageNum)
						// + "&rows="+ encodeURIComponent(rowPerPage)
						// + "&search="+ encodeURI(encodeURIComponent(JSON.stringify(search)));	// JSON.stringify(  )
									 //encodeURI(encodeURIComponent(JSON.stringify(gridData)))
						 
									 
			var postData = "member_nm=" + encodeURIComponent(search);
			postData += "&page="+ encodeURIComponent(pageNum);
			postData += "&rows="+ encodeURIComponent(rowPerPage);
			
			
			//w2ui['grid'].lock('loading...', true);
			// 주석 안주면 계속 loading..
			var rowArr = [];
			$.ajax({
				url : page_url,
				type : 'POST',
				data : postData,
				dataType : 'json',
				async : false,
				success : function( data ) {
					console.log(data.rows);
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
						w2ui['grid'].records = rowArr;
						w2ui['grid'].total = data.rowTotal;
					} else if(data.status == 200 && (data.rows).length == 0) {
						w2ui.grid.clear();
						$("#pagination").empty();
						w2ui['grid'].records = rowArr;
						w2ui['grid'].total = 0;
					}
					w2ui['grid'].refresh();
					w2ui['grid'].unlock();
				},complete: function () {alert("완료");}
			});
			
		}
		
		// 등록 or 수정 클릭시
		function fnPopupInfo(flag) {
			console.log('fnPopupInfo(' + flag + ')');

			$("#test_no").val("");
			$("#test_id").val("");
			$("#test_pwd").val("");
			$("#test_created").val("");
			$("#test_updated").val("");
			$("#test_name").val("");
			
			$("#test_no").attr("readonly",true).attr("disabled",true); 
			
			if( flag=='N' ) {
			
				$("#modal_info").modal('show');
				$("#modal_title").text("등록");
				
				$("#test_no").attr("readonly",false).attr("disabled",false); 
				$("#test_no").attr("status","C");
				
				
			}else if( flag=='U' ) {
				$("#test_no").attr("status","U");
				
				var selIdxArr = w2ui.grid.getSelection();
				var chkLen = selIdxArr.length;
				if( chkLen==0 ) {
					fnMessageModalAlert('Alert', '수정할 항목을 목록에서 선택해야 합니다.');			
				} else if( chkLen>1 ) {
					fnMessageModalAlert('Alert', '수정할 항목은 목록에서 1개 선택해야 합니다.');
				} else {
		 			console.log(w2ui.grid.get(selIdxArr[0]));
					var row = w2ui.grid.get(selIdxArr[0]);

					
				}
			}
		}
		
		// 등록  버튼 Save 클릭시 >>> 수정 버튼 클릭시 아래 fnUpdate
		function fnInsert() {
			console.log($("#test_no").val());

			var s = $("#test_no").attr("status");
			
			console.log("test_no의 status 값 = " + s);
			
			if(s = "C"){
				if(!chkSubmit($("#test_no"), "no를")) return;
			}
			
			if(!chkSubmit($("#test_id"), "멤버 ID를")) return;
			else if(!chkSubmit($("#test_pwd"), "패스워드를")) return;
			else if(!chkSubmit($("#test_created"), "생성일자를")) return;
			else if(!chkSubmit($("#test_updated"), "수정일자를")) return;
			else if(!chkSubmit($("#test_name"), "회원 이름을")) return;
			
			if( $("#test_no").val().replace(/\s/g,"")!="" ) {
				var page_url = "/frontend/test_insert"
					 + "?member_emp_no=" + encodeURIComponent($("#test_no").val())
					 + "&member_id=" + encodeURIComponent($("#test_id").val())
					 + "&member_pwd=" + encodeURIComponent($("#test_pwd").val())
					 + "&date_created=" + encodeURIComponent($("#test_created").val())
					 + "&date_updated=" + encodeURIComponent($("#test_updated").val())
					 + "&member_nm=" + escape(encodeURIComponent($("#test_name").val()))
			
				w2ui['grid'].lock('loading...', true);
				var rowArr = [];
				$.ajax({
					url : page_url,
					type : 'POST',
					dataType : 'json',
					async : false,
					success : function( data ) {
						if(data.status == 200 && data.cnt>0 ) {
							fnMessageModalAlert("Info", '등록이 완료 되었습니다.');
						} else {
							fnMessageModalAlert("Info", '등록이 실패 하었습니다.');
						}
						$("#modal_info").modal('hide');
						loadList();
					},complete: function () {}
				});
			} else {
				fnUpdate();
			}
		}
		
		// 수정 버튼 Save 클릭시
		function fnUpdate() {
			alert("수정~");
			
		}
		
		// 미 입력시
		function chkSubmit(item, msg){
			if(item.val().replace(/\s/g,"")==""){
				alert(msg+ " 입력해 주세요.");
				item.val("");
				item.focus();
				return false;
			} else {
				return true;
			}
		}
		
		
		function json_test() 
		{
			
			
			
			// 08-06일에 해야 할 숙제 
			// 현재 이 그리드에서 가져온 값을 Controller에서 syso로 값 찍어주기
			var gridData = w2ui.grid.records;
			console.log(gridData);
			
			/*
			var gridData = [];
			var o1 = w2ui.grid.records[0];
			var o2 = w2ui.grid.records[1];
			var o3 = w2ui.grid.records[2];
					
			gridData.push(o1);
			gridData.push(o2);
			gridData.push(o3);
			//console.log(gridData);
			*/
			
			
			// 컨트롤러에 보낼 때 JSON으로 보낼 수 없다.. 그렇기에 stringify()로 String으로 바꾼 뒤에 보낸다.
			var page_url = "/frontend/json_test";
			
			
			var postData = "gridData=" + encodeURI(encodeURIComponent(JSON.stringify(gridData)));
			postData += "&page="+ encodeURIComponent(pageNum);
			postData += "&rows="+ encodeURIComponent(rowPerPage);
			
			
// 						 +  "?gridData="+ encodeURI(encodeURIComponent(JSON.stringify(gridData)))
// 						 + "&page="+ encodeURIComponent(pageNum)
// 						 + "&rows="+ encodeURIComponent(rowPerPage);
			
			var rowArr = [];
			$.ajax({
				url : page_url,
				type : 'POST',
				data: postData,
				dataType : 'json',
				async : false,
				success : function( data ) {
					console.log(data.rows);
					if(data.status == 200 && (data.rows).length>0 ) { // 상태가 200이고 rows가 0이상일때 
						rowArr = data.rows;		
					}
				},complete: function () {console.log("확인");}
			});
			
			
			return;
			
			
			
			var mas = [];
			
			var obj1 = new Object();
			obj1.test1 = "111";
			obj1.test2 = "222";
			obj1.test3 = "333";
			
			mas.push(obj1);
			
			var obj2 = new Object();
			obj2.test1 = "aaa";
			obj2.test2 = "bbb";
			obj2.test3 = "ccc";
			
			mas.push(obj2);
			
			console.log(JSON.stringify(mas));
			
			
			// X
			//encodeURI(encodeURIComponent(JSON.stringify(sendData)));

			/* var page_url = "/frontend/json_test"
			
						 + "?params="+ encodeURI(encodeURIComponent(JSON.stringify(mas)));
			
			var rowArr = [];
		 	$.ajax({
				url : page_url,
				type : 'POST',
				dataType : 'json',
				async : false,
				success : function( data ) {
					console.log(data.rows);
					if(data.status == 200 && (data.rows).length>0 ) { // 상태가 200이고 rows가 0이상일때 
						rowArr = data.rows;		
					}
				},complete: function () {}
			});  */
			

		}
		</script>
		
		</body>
</html>