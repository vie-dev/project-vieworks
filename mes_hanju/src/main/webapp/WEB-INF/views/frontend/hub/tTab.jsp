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
		<jsp:param name="selected_menu_p_cd" value="1020"  />
		<jsp:param name="selected_menu_cd" value="1129" />
	</jsp:include>
	<div class="content-wrapper">
		<section class="content-header">
			<h1>
				프로젝트 관리 <small>관리계획</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> 프로젝트 관리</a></li>
				<li class="active">관리계획</li>
			</ol>
		</section>

		<!-- 내용  -->
		<section class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="box" style="margin-bottom: 0px;">
						
							<div class="box-body" style="height:760px;">
								<div class="row">
									<div class="col-md-12">
										<div id="exTab3">	
											<ul class="nav nav-pills">
												<li id="list_tab" class="active"><a href="#list" data-toggle="tab">프로젝트 대상 목록</a></li>
												<li id="plan_tab"><a href="#plan" data-toggle="tab">사원 관리 편성</a></li>
											</ul>
											<div class="tab-content"><!-- clearfix -->
											
												<div class="tab-pane active" id="list" style="height:680px;">	
													<div class="row">
														<div class="col-sm-3">
															<div class="form-group" style="margin-bottom: 0px;">
																<label>| 등록일</label>
																<div class="input-group">
							                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
							                                            <input type="text" class="form-control pull-right input-sm" id="pr_date"> 
							                                     </div>
															</div>
														</div>
														<div class="col-sm-3">
															<div class="form-group" style="margin-bottom: 0px;">
																<label>| 번호</label>
																<div class="form-group" style="margin-bottom: 0px;">
																	<input type="hidden" class="form-control input-sm" id="pr" value="">
																	<div class="input-group">
																      <input type="text" class="form-control input-sm" id="pr_no" placeholder="" ><!-- disabled -->
																      <span class="input-group-btn">
																        <button class="btn btn-primary btn-sm" type="button" onClick="fnPopupInfo('V');">
																          <span class="glyphicon glyphicon-search" aria-hidden="true"></span><!-- 서치 아이콘 -->
																        </button>
																      </span>
																    </div>
																</div>
															</div>
														</div>
							
														<div class="col-sm-3">
														    <div class="form-group" style="margin-bottom: 0px;">
																<label>| 프로젝트명</label>
																<div class="form-group" style="margin-bottom: 0px;">
																	<input type="hidden" class="form-control input-sm" id="prNo" value="">
																	<div class="input-group">
																      <input type="text" class="form-control input-sm" id="pr_nm" placeholder="" > <!-- disabled -->
																      <span class="input-group-btn">
																        <button class="btn btn-primary btn-sm" type="button" onClick="fnPopupInfo('P');">
																          <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
																        </button>
																      </span>
																    </div>
																</div>
															</div>
														</div>
														<!-- 
														<div class="col-sm-3">
															<div class="form-group text-right" style="margin-bottom: 0px;">
																<div class="form-group" style="margin-bottom: 0px;">
																	<input type="text" class="form-control pull-right input-sm" id="project_no">
																	<button class="w2ui-btn" onclick="w2ui.grid_list.selectNone();">Select None</button>
																</div>
															</div>
														</div>
														 -->
														
														<div class="col-sm-3">
															<div class="form-group text-right" style="margin-bottom: 0px;">
																<label>&nbsp;&nbsp;</label>
																<div class="form-group" style="margin-bottom: 0px;">
	<!-- 																<input type="text" class="form-control pull-right input-sm" id="project_no"> -->
																	<!-- <button type="button" class="btn btn-primary btn-sm" onClick="project_modal();">조회</button>   -->
																
																	<!-- <div class="row" style="margin-bottom:10px;">
																		<div class="col-md-12 text-right"> -->
																		
																			<button type="button" id="" onclick="fnPopupInfo('N');" class="btn btn-success btn-sm">등록</button>
																			<button type="button" id="" onclick="fnPopupInfo('U');" class="btn btn-success btn-sm">수정</button>
																			<button type="button" id="" onclick="fnDelete();" class="btn btn-danger btn-sm">삭제</button>
																			<!-- <button type="button" id="" onclick="loadList();" class="btn btn-primary btn-sm">조회</button> -->
																		<!-- </div>
																	</div> -->
																																		
																</div>
															</div>
														</div>
													</div>
													<div class="row" style="padding-top: 10px; height: 625px;">
														<div class="col-md-12" style="height:100%;width: 100%;">
															<div id="grid_list" style="width: 100%; height: 560px; "></div>
															<div id="pagination" class="text-center"></div><!-- 페이지 -->
														</div>
													</div>
												</div>
											
											
											
												<!-- 오른쪽 탭 -->
												<div class="tab-pane" id="plan"  style="height:680px;">
													<!-- <div class="row text-right">
														<div class="col-md-12" style="height:100%;width: 100%;">
															<button type="button" onclick="fnShipmentPlanCommit();" class="btn btn-success btn-sm">관리계획</button>
														</div>
													</div>
													<div class="row" style="padding-top: 10px; height: 625px;">
														<div class="col-md-12" style="height:100%;width: 100%;">
															<div id="grid_plan" style="width: 100%; height: 600px; "></div>
															<div id="pagination1" class="text-center"></div>
														</div>
													</div> -->
													<div class="row">
														<div class="col-sm-3">
															<div class="form-group" style="margin-bottom: 0px;">
																<label>| 등록일</label>
																<div class="input-group">
							                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
							                                            <input type="text" class="form-control pull-right input-sm" id="mm_date"> 
							                                     </div>
															</div>
														</div>
														<div class="col-sm-3">
															<div class="form-group" style="margin-bottom: 0px;">
																<label>| 번호</label>
																<div class="form-group" style="margin-bottom: 0px;">
																	<input type="hidden" class="form-control input-sm" id="mm" value="">
																	<div class="input-group">
																      <input type="text" class="form-control input-sm" id="mm_no" placeholder="" > <!-- disabled -->
																      <span class="input-group-btn">
																        <button class="btn btn-primary btn-sm" type="button" onClick="fnPopupInfo('V');">
																          <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
																        </button>
																      </span>
																    </div>
																</div>
															</div>
														</div>
							
														<div class="col-sm-3">
														    <div class="form-group" style="margin-bottom: 0px;">
																<label>| 사원명</label>
																<div class="form-group" style="margin-bottom: 0px;">
																	<input type="hidden" class="form-control input-sm" id="mmNo" value="">
																	<div class="input-group">
																      <input type="text" class="form-control input-sm" id="mm_nm" placeholder="" ><!-- disabled -->
																      <span class="input-group-btn">
																        <button class="btn btn-primary btn-sm" type="button" onClick="fnPopupInfo('P');">
																          <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
																        </button>
																      </span>
																    </div>
																</div>
															</div>
														</div>
														<div class="col-sm-3">
															<div class="form-group text-right" style="margin-bottom: 0px;">
																<label>&nbsp;&nbsp;</label>
																<div class="form-group" style="margin-bottom: 0px;">
	<!-- 																<input type="text" class="form-control pull-right input-sm" id="project_no"> -->
																	<button type="button" class="btn btn-primary btn-sm" onClick="member_modal();">조회</button>  
																</div>
															</div>
														</div>
														
														
													</div>
													
													<div class="row" style="padding-top: 10px; height: 625px;">
														<div class="col-md-12" style="height:100%;width: 100%;">
															<div id="grid_list2" style="width: 100%; height: 560px; "></div>
															<!-- <div id="pagination2" class="text-center"></div> -->
														</div>
													</div>
												</div><!-- 오른쪽탭 -->
												
												
											</div>	
											
											
										</div>
									</div><!-- tab area -->
								</div> <!-- class=row -->
							</div>
						</div>
					</div> <!-- 공정그룹 목록 -->
					</div><!-- 젤 앞의  row -->
				</section>
			</div> <!-- content-wrapper -->
		<!-- 내용 End -->
		
		<!-- modal -->
			<!-- start plan_select -->
			<div class="modal fade" id="member_modal" aria-hidden="true" style="display: none; z-index: 1060;"><!-- data-backdrop="static"> -->
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="member_title">조회</h4>
						</div>
						<div class="modal-body" id="">
							<form id="member_info" name="member_info" class="form-horizontal">
											
								<div id="member_no" class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">사원번호</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="mem_no" value="" disabled><!-- disabled : 비활성화 -->
									</div>
									<div class="col-sm-1"></div>
								</div>
												
												
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">사원 ID</label>
									<div class="col-sm-7">
											<input type="text" class="form-control input-sm" id="mem_id" value="" disabled>
									</div>
									<div class="col-sm-1"></div>
								</div>
								
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">이메일</label>
									<div class="col-sm-7">
											<input type="text" class="form-control input-sm" id="mem_email" value="" disabled>
									</div>
									<div class="col-sm-1"></div>
								</div>
								
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">패스워드</label>
									<div class="col-sm-7">
											<input type="text" class="form-control input-sm" id="mem_pwd" value="" disabled>
									</div>
									<div class="col-sm-1"></div>
								</div>
								
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">사원명</label>
									<div class="col-sm-7">
											<input type="text" class="form-control input-sm" id="mem_nm" value="" disabled>
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
			
			<!-- start list-modal select/insert/update  -->
			<div class="modal fade" id="modal_info" aria-hidden="true" style="display: none; z-index: 1060;"><!-- data-backdrop="static"> -->
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="modal_title">등록</h4>
			        	</div>
						<div class="modal-body" id="">
							<form id="frm_info" name="frm_info" class="form-horizontal">							
								<div id="a_project_no" class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">프로젝트 코드</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="p_project_no" value="" maxlength="20" disabled>
									</div>
									<div class="col-sm-1"></div>
								</div>
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">프로젝트명</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="p_project_nm" value="" maxlength="50">
									</div>
									<div class="col-sm-1"></div>
								</div>
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;"> 구분</label>
									<div class="col-sm-7">
										<select id="p_gubun" name="p_gubun" class="form-control select2 input-sm" data-placeholder="">
											<option value="00">신규</option>
											<option value="01">재진행</option>
										</select>
									</div>
									<div class="col-sm-1"></div>
								</div>
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">수주업체 정보</label>
									<div class="col-sm-6">
										<input type="text" class="form-control input-sm" id="p_lifnr_nm" value="" maxlength="50" disabled>
									</div>
									<div class="col-sm-1" style="padding-left: 0px;">
										<button type="button" onclick="fnPopupInfo('V');" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
									</div>
									<div class="col-sm-1"></div>
								</div>
								<div class="form-group row">
									<div class="col-sm-4"></div>
									<div class="col-sm-6">
										<input type="text" class="form-control input-sm" id="p_lifnr" value="" maxlength="10" disabled><!-- lifnr -->
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">발주금액</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="p_netwr" value="" style="text-align: right;" maxlength="13">
									</div>
									<div class="col-sm-1"></div>
								</div>
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">수량</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="p_menge" value="" style="text-align: right;" maxlength="16">
									</div>
									<div class="col-sm-1"></div>
								</div>
								<div id="a_success_yn" class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">완료유무</label>
									<div class="col-sm-3">
										<label class="ichk_label"> <input type="radio" id="p_success_yn" name="p_success_yn" value="Y" disabled> 완료</label>
									</div>
									<div class="col-sm-4">
										<label class="ichk_label"> <input type="radio" id="p_success_yn" name="p_success_yn" value="N" disabled> 미완료</label> 
									</div>
									<div class="col-sm-1"></div>
								</div>
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">완료일자</label>
									<div class="col-sm-7">
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input type="text" class="form-control pull-right input-sm" id="p_eindt">
										</div>
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
											<input type="text" class="form-control pull-right input-sm" id="p_date_created">
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
											<input type="text" class="form-control pull-right input-sm" id="p_date_updated">
										</div>
									</div>
									<div class="col-sm-1"></div>
								</div>								
							</form>
						</div>
						<div class="modal-footer">
							<div class="col-md-12 text-center">
								<button type="button" id="btn_dmr_save" class="btn btn-success btn-sm" onclick="fnInsert();">Save</button>
								<button type="button" id="btn_dmr_cancel" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div> 					
			<!-- end list-modal select/insert/update  -->
			
		<!-- modal End -->
		
		<jsp:include page="/common/footer_inc" flush="true">
			<jsp:param name="page_title" value="0" />
		</jsp:include>
		
		<jsp:include page="/common/sidebar_rview_inc" flush="true">
			<jsp:param name="page_title" value="0" />
		</jsp:include>

	</div>
	
	<style>
		.tab {
		    width: 100%;
		    height: 300px;
		    border: 1px solid silver;
		    border-top: 0px;
		    display: none;
		    padding: 10px;
		    overflow: auto;
		}
		
		#exTab3 .nav-pills > li > a {
		  border-radius: 4px 4px 0 0 ;
		}
		
		#exTab3 .tab-content {
		/*   color : white; */
		  border : 1px solid #428bca;
		  background-color: white;
		  padding : 5px 15px;
		}
		
	</style>
	
	<script src="/res/plugins/pagination.js"></script>
	<script src="/res/plugins/pagination1.js"></script>
	<script type="text/javascript">
		var page = 1; 		// 화면에서 사용할 page
		var pageNum = 0; 	// 서버에 넘겨줄 page -> mysql 은 0 부터 시작
		var rowPerPage = 20;
		var rowLength = 0;
		var totalPage = 0;
		var cntRowPagination = 5;	// << 1 2 3 4 5 >>
	
		// var selsel; // 그리드 순번
		
		$(function($) {
			initComponent(); // 달력
			
			initGridPlan(); // 두번째 그리드
			initGridList(); // 첫 그리드
		
			minDate = getFormatDate(new Date()),
			mdTemp = new Date(), 
			maxDate = getFormatDate(new Date(mdTemp.setDate(mdTemp.getDate() + 7)));
			 
			$('#p_eindt, #p_date_created, #p_date_updated').daterangepicker({
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
			
			$("#p_netwr, #p_menge").keyup(function(event) {
				if(event.which >= 37 && event.which <= 40) return;
				$(this).val(function(index, value) {
					return value
					.replace(/\D/g, "")
					.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				});
			});
			
		})	
	
	
		// 달력
		function initComponent() {
			console.info('initComponent()');
			
			$('#pr_date, #mm_date').daterangepicker({
				opens: 'right',
				locale: {
					format : 'YYYY-MM-DD'	,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear : true,
					yearSuffix : '년'
			    },
		 	     /* startDate: getTodayDate(),
		 	     endDate: getTodayDate() */
		 	     startDate: '2019-05-01',
		 	     endDate: '2019-05-30'
			});
			
			$(".nav > li > a").click(function(event){
		    	$(".nav").find(".active").removeClass("active");
		    	$(".tab-content").find(".active").removeClass("active");
		    	$( this ).parent( 'li' ).addClass( 'active' );
//		     	var clickTab = event.target.innerText.trim();
		    	var id = $(event.target).parent()[0].id;
//		     	console.log(id);

		    	if( id=='list_tab' ) {
		    		$("#list").addClass("active");
		    		 loadList();
		    		w2ui['grid_list'].resize();
		    		w2ui['grid_list'].refresh();
		    	} else if ( id=='plan_tab' ) {
		    		$("#plan").addClass("active");
		    		  loadList2();
		    		w2ui['grid_plan'].resize();
		    		w2ui['grid_plan'].refresh();
		    	}
		    });
		} // 
	
		// 첫 그리드
	 	function initGridList() {
			console.log('initGridList()');
			var rowArr = [];
			
			// project_manager
			$('#grid_list').w2grid({ 
		        name: 'grid_list', 
		        show: { footer: true, selectColumn: true},
		        columnGroups: [
		                       { caption: 'No', master: true },
		                       { caption: '사업자번호',master: true },
		                       { caption: '사업체명',master: true },
		                       { caption: '구분', master: true },
		                       { caption: '프로젝트', span: 4 },
		                       { caption: '프로젝트 진행', span: 6 }
		                   ],
		        multiSelect: true,
		        columns: [
			           
			            { field: 'recid', caption: 'No', size: '50px', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'lifnr', caption: '사업자 번호', size: '10%', sortable: true, attr: 'align=center', resizable: true },//, hidden:true
			            { field: 'lifnr_nm', caption: '사업체명', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'project_division', caption: '구분', size: '50px', sortable: true, attr: 'align=center', resizable: true,
			            	render : function(record, index, col_index){
			              		var value = this.getCellValue(index, col_index);
			              		if( value=='00' )
			              			return '신규';
			              		else
			              			return '재진행';
			            	}},
			            { field: 'project_no', caption: '프로젝트 코드', size:'10%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'project_nm', caption: '프로젝트명', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'netwr', caption: '발주금액', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'menge', caption: '수량', size: '50px', sortable: true, attr: 'align=center', resizable: true },
			            
			            { field: 'success_yn', caption: '완료유무', size: '65px', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'eindt', caption: '완료일자', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'date_created', caption: '생성일', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'date_updated', caption: '수정일', size: '10%', sortable: true, attr: 'align=center', resizable: true }
			    ],
		        sortData: [
					{field: 'lifnr', direction: 'ASC'},
					{field: 'lifnr_nm', direction: 'ASC'}
				],
				records: [],
				total : 0,
				recordHeight : 30,
				onReload: function(event) {},
				onClick: function (event) {},
				onDblClick: function (event) {
					var flag = 'R';
					fnPopupInfo(flag);
				}
		    }); 
			loadList();
			// w2ui['grid_list'].multiSelect = this.checked; w2ui['grid_list'].selectNone(); << 버튼으로 쓰면 다중 선택 됐다가 안됐다가~
		}
		
		// 첫 그리드
		function loadList(){
			
			// for grid_list
			console.log('loadList()');
//		 	var gubun = $("#reg_gubun").val();
			var beforePage = page; 
			/* if( pageNum==undefined ){
				page=1;
				pageNum = 0;
			} else {
				page=pageNum;
				pageNum = (pageNum-1)*rowPerPage;
			}
 */
			var pr_date_cre = $("#pr_date").val().substr(0,10); // 음 이건..생성일
			var pr_date_upd =  $("#pr_date").val().substr(13);		// 수정일
			
			
			var page_url = "/frontend/tTab_select"/* ;
						  + "?lifnr=" + encodeURIComponent(posale_dt_from)
								 
						 + "&project_no=" + encodeURIComponent($("#prNo").val())
						 + "&project_nm=" + encodeURIComponent($("#pr").val())
						 */
						 + "?page="+ encodeURIComponent(pageNum)
						 + "&rows="+ encodeURIComponent(rowPerPage);
			
			// w2ui['grid_list'].lock('loading...', true);
			var rowArr = [];
			$.ajax({
				url : page_url,
				type : 'POST',
				dataType : 'json',
				async : false,
				success : function( data ) {
					if(data.status == 200 && (data.rows).length>0 ) {
						rowArr = data.rows;
						
						console.log("TT");
						
						$.each(rowArr, function(idx, row){
							row.recid = idx+1;
						});
						if(data.pageTotal == 0){
							$("#pagination").empty();
						} else {
							totalPage = data.pageTotal;
							pagination();
						}
						w2ui['grid_list'].records = rowArr;
						w2ui['grid_list'].total = data.rowTotal;
					} else if(data.status == 200 && (data.rows).length == 0) {
						w2ui.grid_list.clear();
						$("#pagination").empty();
						w2ui['grid_list'].records = rowArr;
						w2ui['grid_list'].total = 0;
					}
					w2ui['grid_list'].refresh();
					w2ui['grid_list'].unlock();
				},complete: function () { console.log(rowArr);}
			});
		}
		
		// 첫번째 조회 모달
		//function project_modal() {
		function fnPopupInfo(flag) {
			console.log('fnPopupInfo(' + flag + ')');
			
//			$("#modal_info").modal("show");
			
			var sel = w2ui.grid_list.getSelection();	
			console.log("sel = " + sel);
			
			if(flag == 'R'){ // 조회
				var selIdxArr = w2ui.grid_list.getSelection();
				var row = w2ui.grid_list.get(selIdxArr[0]);
				
				var chkLen = selIdxArr.length;
				console.log(chkLen);
			
				//if(selIdxArr == null || selIdxArr == '' ){ alert('다시 선택해 주세요!'); return; }
				
				$("#modal_title").text("조회");
				$("#modal_info").modal('show');
				
				$("#p_project_no").attr('disabled', true);
				$("#p_project_nm").attr('disabled', true);
				$("#p_gubun").attr('disabled', true);
				$("#p_lifnr_nm").attr('disabled', true);
				$("#p_lifnr").attr('disabled', true);
				$("#p_netwr").attr('disabled', true);
				$("#p_menge").attr('disabled', true);
				//$("#success_yn").attr('disabled', false);
				$("#p_eindt").attr('disabled', true);	
				$("#p_date_created").attr('disabled', true);
				$("#p_date_updated").attr('disabled', true);
				
				$("#btn_dmr_save").css("display","none");
				
				
				
				$("#p_project_no").val(row.project_no);
				$("#p_project_nm").val(row.project_nm);
				$("#p_project_division").val(row.project_division);
				$("#p_lifnr_nm").val(row.lifnr_nm);
				$("#p_lifnr").val(row.lifnr);
				$("#p_netwr").val(row.netwr);
				$(":radio[name=p_success_yn][value="+row.success_yn+"]").iCheck("check");
				$("#p_eindt").val(row.eindt);
				$("#p_menge").val(row.menge);
				$("#p_date_created").val(row.date_created);
				$("#p_date_updated").val(row.date_updated);
				
				
				$("#btn_dmr_save").css("display","none");
				
				
			} else if (flag=='N'){ // 등록
				$("#p_project_no").val("");
				$("#p_project_nm").val("");
				
				$("#p_lifnr_nm").val("");
				$("#p_lifnr").val("");
				$("#p_netwr").val("");
				$("#p_menge").val("");
				$("#p_eindt").val("");
				$("#p_date_created").val("");
				$("#p_date_updated").val("");
				
				$("#a_project_no").css("display","none");
				$("#btn_dmr_save").css("display","");
				$("#modal_title").text("등록");
				$("#modal_info").modal('show');
				
				//
				// init form component 
				var inputObj = $("#modal_info").find('input');
				$.each(inputObj, function(idx, obj){
					if( $(obj).attr('type')!='radio' )
						$(obj).val("");
				});
				$(":radio[name=p_success_yn][value=N]").iCheck("check");
				
				$("#modal_info").modal('show');
				$("#modal_title").text("등록");
				
				$("#p_project_no").attr('disabled', false);
				$("#p_project_nm").attr('disabled', false);
				$("#p_gubun").attr('disabled', false);
				
		 		$("#p_lifnr_nm").attr('disabled', false);
		 		$("#p_lifnr").attr('disabled', false);
		 		
				$("#p_netwr").attr('disabled', false);
				$("#p_menge").attr('disabled', false);
				$("#p_eindt").attr('disabled', false);
				$("#p_date_created").attr('disabled', false);
				$("#p_date_updated").attr('disabled', false);
				//
				
			} else if( flag=='U') {
				var selIdxArr = w2ui.grid_list.getSelection();
				var chkLen = selIdxArr.length;
				if( chkLen==0 ) {
					fnMessageModalAlert('Alert', '수정할 항목을 목록에서 선택해야 합니다.');			
				} else if( chkLen>1 ) {
					fnMessageModalAlert('Alert', '수정할 항목은 목록에서 1개 선택해야 합니다.');
				} else {
//		 			console.log(w2ui.grid.get(selIdxArr[0]));
					var row = w2ui.grid_list.get(selIdxArr[0]);
					 
					$("#p_project_no").val(row.project_no);
					$("#p_project_nm").val(row.project_nm);
					$("#p_project_division").val(row.project_division);
					$("#p_lifnr_nm").val(row.lifnr_nm);
					$("#p_lifnr").val(row.lifnr);
					$("#p_netwr").val(row.netwr);
					$(":radio[name=p_success_yn][value="+row.success_yn+"]").iCheck("check");
					$("#p_eindt").val(row.eindt);
					$("#p_menge").val(row.menge);
					$("#p_date_created").val(row.date_created);
					$("#p_date_updated").val(row.date_updated);
					 
					$("#modal_info").modal('show');
					$("#modal_title").text("수정");
					$("#btn_dmr_save").css("display","");
					
					$("#p_project_no").attr('disabled', true);
					$("#p_lifnr_nm").attr('disabled', true);
					$("#p_lifnr").attr('disabled', true);
					$("#p_gubun").attr('disabled', true);
					$("#p_project_nm").attr('disabled', false);
					$("#p_netwr").attr('disabled', false);
					$("#p_menge").attr('disabled', false);
					$("#p_eindt").attr('disabled', false);
					
					//
			
					$("#p_date_created").attr('disabled', true);
					$("#p_date_updated").attr('disabled', false);
					
				}
			} /* else if( flag=='V' ) {	
				$("#modal_vendor").modal('show');
				fnSetLoadVendorGrid();
				w2ui.grid_vendor.resize();
				w2ui.grid_vendor.refresh();
			} else {	// flag=='P'
				$("#a_project_no").css("display","");
				$("#a_zdue_menge").css("display","");
				$("#a_plan_dt").css("display","");
				$("#a_purdt").css("display","");
				$("#a_file_group").css("display","");
				
				$("#modal_print").modal('show');
				fnSearchRegListGrid();
//		 		w2ui.grid_reg.resize();
//		 		w2ui.grid_reg.refresh();
			} */
			
		}
		
		// 등록 함수
		function fnInsert() {
			console.log('fnInsert()',$("#p_project_no").val());
			
			
			if( $("#p_project_no").val()=="" ) { // 등록이면
				console.log("등록합니다.");
				
				var page_url = "/frontend/tTab_insert"
							 + "?project_division=" + encodeURIComponent($("#p_gubun").val())
							 + "&project_nm=" + escape(encodeURIComponent($("#p_project_nm").val()))
							 + "&lifnr=" + encodeURIComponent($("#p_lifnr").val())
							 + "&lifnr_nm=" + escape(encodeURIComponent($("#p_lifnr_nm").val()))
							 + "&netwr=" + encodeURIComponent($("#p_netwr").val().replace(/[,\s]/gi,""))
							 + "&menge=" + encodeURIComponent($("#p_menge").val().replace(/[,\s]/gi,""))
							 + "&success_yn=N"
							 
							 + "&eindt=" + encodeURIComponent($("#p_eindt").val())
						
							 + "&date_created=" + encodeURIComponent($("#p_date_created").val())
							 + "&date_updated=" + encodeURIComponent($("#p_date_updated").val());
				
				w2ui['grid_list'].lock('loading...', true);
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
			} else {	// 수정이면
				fnUpdate();
			}
		}
		
		// 수정이면
		function fnUpdate() {
			console.log("수정합니다");
			var page_url = "/frontend/tTab_update"
				 + "?project_no=" + encodeURIComponent($("#p_project_no").val())
				 + "&project_nm=" + escape(encodeURIComponent($("#p_project_nm").val()))
				 + "&netwr=" + encodeURIComponent($("#p_netwr").val().replace(/[,\s]/gi,""))
				 + "&menge=" + encodeURIComponent($("#p_menge").val().replace(/[,\s]/gi,""))
				 /*
				 + "&netwr=" + encodeURIComponent($("#p_netwr").val())
				 + "&menge=" + encodeURIComponent($("#p_menge").val())
				 */
				 + "&success_yn=" + escape(encodeURIComponent($("#p_success_yn").val()))
				 + "&eindt=" + encodeURIComponent($("#p_eindt").val())
				 + "&date_updated=" + encodeURIComponent($("#p_date_updated").val());
	
	// w2ui['grid'].lock('loading...', true);
	var rowArr = [];
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		async : false,
		success : function( data ) {
			if(data.status == 200 && data.cnt>0 ) {
				fnMessageModalAlert("Info", '수정이 완료 되었습니다.');
			} else {
				fnMessageModalAlert("Info", '수정이 실패 하었습니다.');
			}
			$("#modal_info").modal('hide');
			loadList();
		},complete: function () {}
	});
		}
		
		// 삭제면
		function fnDelete() { 
			if(confirm("선택한 내용을 삭제하시겠습니까?")) {
				
				console.log("삭제합니다");
				var selIdxArr = w2ui.grid_list.getSelection();
				var chkLen = selIdxArr.length;
				if( chkLen==0 ) {
					fnMessageModalAlert('Alert', '삭제할 항목을 목록에서 선택해야 합니다.');			
				} else if( chkLen>1 ) {
					fnMessageModalAlert('Alert', '삭제할 항목은 목록에서 1개 선택해야 합니다.');
				} else {
					var row = w2ui.grid_list.get(selIdxArr[0]);
					if ( Number(fnChkProject(row.project_no))>0 ) {
						fnMessageModalAlert('Alert', '수주등록에 연결된 항목이 있습니다.<br>확인 후 다시 시도하시기 바랍니다.');
					} else {
						var page_url = "/frontend/tTab_delete"
									 + "?project_no=" + encodeURIComponent(row.project_no);
						// w2ui['grid_list'].lock('loading...', true);
						var rowArr = [];
						$.ajax({
							url : page_url,
							type : 'POST',
							dataType : 'json',
							async : false,
							success : function( data ) {
								if(data.status == 200 && data.cnt>0 ) {
									fnMessageModalAlert("Info", '삭제가 완료 되었습니다.');
								} else {
									fnMessageModalAlert("Info", '삭제 실패 하었습니다.');
								}
								loadList();
							},complete: function () {}
						});
					}
				}
			}
		}
		
		function fnChkProject(proj_no) {
			console.log("fnChkProject()");
			/*
			before delete check connection poreg table
			*/
			var resultCnt = 0;
			var page_url = "/frontend/projectDeleteBefore"
						 + "?project_no=" + encodeURIComponent(proj_no);
			$.ajax({
				url : page_url,
				type : 'POST',
				dataType : 'json',
				async : false,
				success : function( data ) {
					if(data.status == 200  ) {
						resultCnt = data.cnt;
					} else {
						resultCnt = 0;
					}
					loadList();
				},complete: function () {}
			});
			return resultCnt;
		}
		
		// 두 번째 그리드 >> 강제 삽입
		function initGridPlan(){
			console.log('initGridPlan()');
			var rowArr = [];
			
			// project_manager
			$('#grid_list2').w2grid({ 
		        name: 'grid_plan', 
		        show: { footer: true },
		        multiSelect: false,
		        columns: [			           
			           	  { field: 'recid', caption: 'No', size: '30%', sortable: true, attr: 'align=center', resizable: true },
		                  { field: 'member_emp_no', caption: '사원번호', size: '30%', sortable: true, attr: 'align=center', resizable: true },
		                  { field: 'member_id', caption: '사원 ID', size: '30%', sortable: true, attr: 'align=center', resizable: true },
		                  { field: 'member_email', caption: '이메일', size: '30%', sortable: true, attr: 'align=center', resizable: true },
		                  { field: 'member_pwd', caption: '패스워드', size: '30%', sortable: true, attr: 'align=center', resizable: true },
		                  { field: 'member_nm', caption: '사원명', size: '30%', sortable: true, attr: 'align=center', resizable: true }
			    ],
		        sortData: [
					{field: 'member_emp_no', direction: 'ASC'},
					{field: 'member_nm', direction: 'ASC'}
				],
				records: [
				  //        { recid: 1, member_emp_no: '9999', member_nm: 'Gatos'}
				],
				total : 0,
				recordHeight : 30,
				onReload: function(event) {},
				onClick: function (event) {

				},
				onDblClick: function(event) { 		
					console.log("member_modal 더블 이벤트");
				   // event.onComplete = function () {
				    //	selsel = this.getSelection();
				   //     console.log('selection:', selsel);
				    //    member_modal(selsel);
				       member_modal();
				    
				}
		    }); 
			
			loadList2();
		}
		
		function loadList2() {
			console.log('loadList2()');
			// 데이터 받아오기
			
			var page_url = "/frontend/test"
				//var page_url = "/frontend/project_select"
						/*  + "?project_division=" + encodeURIComponent($("#project_division").val())
						 + "&project_no=" + encodeURIComponent($("#project_no").val())
						 + "&project_nm=" + encodeURIComponent($("#project_nm").val())
						 + "&lifnr=" + encodeURIComponent($("#lifnr").val()) */
						 
						
						 + "?page="+ encodeURIComponent(pageNum)
						 + "&rows="+ encodeURIComponent(rowPerPage);
			
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
						w2ui['grid_plan'].records = rowArr;
						w2ui['grid_plan'].total = data.rowTotal;
					} else if(data.status == 200 && (data.rows).length == 0) {
						w2ui.grid.clear();
						$("#pagination").empty();
						w2ui['grid_plan'].records = rowArr;
						w2ui['grid_plan'].total = 0;
					}
					w2ui['grid_plan'].refresh();
					w2ui['grid_plan'].unlock();
				},complete: function () {}
			});
		}
		
		function member_modal() {
			console.log("member_modal 더블 이벤트 이동완료");
			
			$("#member_modal").modal("show");
			
			var sel = w2ui.grid_plan.getSelection();
			
			console.log("sel = " + sel);

			var mem_no = w2ui.grid_plan.records[sel -1].member_emp_no;
			var member_id = w2ui.grid_plan.records[sel -1].member_id;
			var member_email = w2ui.grid_plan.records[sel -1].member_email;
			var member_pwd = w2ui.grid_plan.records[sel -1].member_pwd;		
			var mem_nm = w2ui.grid_plan.records[sel -1].member_nm;

			$("#mem_no").val(mem_no);
			$("#mem_id").val(member_id);
			$("#mem_email").val(member_email);
			$("#mem_pwd").val(member_pwd); 
			$("#mem_nm").val(mem_nm);
		}
		
		

		function getFormatDate(d) {
			var month = d.getMonth() + 1;
			var date = d.getDate();
			month = (month < 10) ? "0" + month : month;
			date = (date < 10) ? "0" + date : date;
			return d.getFullYear() + '-' + month + '-' + date;
		}

	</script>
</body>
</html>