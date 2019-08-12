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
		<jsp:param name="selected_menu_cd" value="1130" />
	</jsp:include>
	<div class="content-wrapper">
		<section class="content-header">
			<h1>
				생산 일보 <small>MES</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i>생산 일보</a></li>
				<li class="active">MES</li>
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
											<!-- <ul class="nav nav-pills">
												<li id="list_tab" class="active"><a href="#list" data-toggle="tab">프로젝트 대상 목록</a></li>
												<li id="plan_tab"><a href="#plan" data-toggle="tab">사원 관리 편성</a></li>
											</ul> -->
											<div class="tab-content"><!-- clearfix -->
											
												<div class="tab-pane active" id="list" style="height:680px;">	
													<div class="row">
														
														<!-- row -->
														
													<div class="col-md-12">
														<!-- <div class="col-sm-2" style="float:left;">
															<div class="form-group">
																<label>| 고객사명</label> 
																<input type="input" id="s_pordno" name="s_pordno" class="form-control input-sm" placeholder="고객사" maxlength="30">
															</div>
														</div>
													
														<div class="col-sm-1" style="padding-left: 0px;">
															<div style="line-height: 24px;">
																<br>
																<button type="button" id="" onclick="search_a();" class="btn btn-primary btn-sm"><i class="fa fa-search"></i></button>	
																<button type="button" id="" class="btn btn-info btn-sm" onclick="fnSearchVendor();"><i class="fa fa-search"></i></button>
															</div>
														</div> -->
														<div class="col-sm-2">
															<div class="form-group" style="margin-bottom: 0px;">
																<label>| 고객사명</label>
																<div class="form-group" style="margin-bottom: 0px;">
																	<div class="input-group">
																      <input type="text" class="form-control input-sm" id="hga" placeholder="고객사" ><!-- disabled -->
																      <span class="input-group-btn">
																        <button class="btn btn-primary btn-sm" type="button" onClick="searchInfo('G');">
																          <span class="glyphicon glyphicon-search" aria-hidden="true"></span><!-- 서치 아이콘 -->
																        </button>
																      </span>
																    </div>
																</div>
															</div>
														</div>
													
														<div class="col-sm-2">
															<div class="form-group">
																<label>| 작업일</label>
																<div class="input-group">
																	
																	<input type="text" 
																	class="form-control pull-right input-sm" style="" id="p_date" placeholder="yyyy/mm/dd~yyyy/mm/dd">
																	<div class="input-group-addon">
																		<i class="fa fa-calendar"></i>
																	</div>
																</div>
															</div>
														</div>
		<!-- 					
														<div class="col-sm-2">
															<div class="form-group">
																<label>| 작업자</label> 
																<input type="input" id="s_itnbr" name="s_itnbr" class="form-control input-sm" placeholder="설비" maxlength="30">
															</div>
														</div>
							
														<div class="col-sm-1" style="padding-left: 0px;">
															<div style="line-height: 24px;">
																<br>
																<button type="button" id="" onclick="search_a();" class="btn btn-primary btn-sm"><i class="fa fa-search"></i></button>	
																<button type="button" id="" class="btn btn-info btn-sm" onclick="fnSearchVendor();"><i class="fa fa-search"></i></button>
															</div>
														</div> -->
							
														
														<div class="col-sm-2">
															<div class="form-group" style="margin-bottom: 0px;">
																<label>| 작업자</label>
																<div class="form-group" style="margin-bottom: 0px;">
																	<div class="input-group">
																      <input type="text" class="form-control input-sm" id="jaup" placeholder="설비" ><!-- disabled -->
																      <span class="input-group-btn">
																        <button class="btn btn-primary btn-sm" type="button" onClick="searchInfo('J');">
																          <span class="glyphicon glyphicon-search" aria-hidden="true"></span><!-- 서치 아이콘 -->
																        </button>
																      </span>
																    </div>
																</div>
															</div>
														</div>
							
							
														<!-- <div class="col-sm-2">
															<div class="form-group">
																<label>| 제품 아이템</label> 
																<input type="input" id="s_itnbr" name="s_itnbr" class="form-control input-sm" placeholder="제품" maxlength="30">
															</div>
														</div>
														
														<div class="col-sm-1" style="padding-left: 0px;">
															<div style="line-height: 24px;">
																<br>
																<button type="button" id="" onclick="search_a();" class="btn btn-primary btn-sm"><i class="fa fa-search"></i></button>	
																<button type="button" id="" class="btn btn-info btn-sm" onclick="fnSearchVendor();"><i class="fa fa-search"></i></button>
															</div>
														</div> -->							
														
														<div class="col-sm-2">
															<div class="form-group" style="margin-bottom: 0px;">
																<label>| 제품 ITEM</label>
																<div class="form-group" style="margin-bottom: 0px;">
																	<div class="input-group">
																      <input type="text" class="form-control input-sm" id="prod_no" placeholder="제품" ><!-- disabled -->
																      <span class="input-group-btn">
																        <button class="btn btn-primary btn-sm" type="button" onClick="searchInfo('I');">
																          <span class="glyphicon glyphicon-search" aria-hidden="true"></span><!-- 서치 아이콘 -->
																        </button>
																      </span>
																    </div>
																</div>
															</div>
														</div>
														
														<!-- <div class="col-sm-2">
															<div class="form-group">
																<label>| 설비</label> 
																<input type="input" id="s_itnbr" name="s_itnbr" class="form-control input-sm" placeholder="설비" maxlength="30">
															</div>
														</div>
							
														<div class="col-sm-1" style="padding-left: 0px;">
															<div style="line-height: 24px;">
																<br>
																<button type="button" id="" onclick="search_a();" class="btn btn-primary btn-sm"><i class="fa fa-search"></i></button>	
																<button type="button" id="" class="btn btn-info btn-sm" onclick="fnSearchVendor();"><i class="fa fa-search"></i></button>
															</div>
														</div> -->
														
														<div class="col-sm-2">
															<div class="form-group" style="margin-bottom: 0px;">
																<label>| 설비</label>
																<div class="form-group" style="margin-bottom: 0px;">
																	<div class="input-group">
																      <input type="text" class="form-control input-sm" id="sulbi" placeholder="설비" ><!-- disabled -->
																      <span class="input-group-btn">
																        <button class="btn btn-primary btn-sm" type="button" onClick="searchInfo('S');">
																          <span class="glyphicon glyphicon-search" aria-hidden="true"></span><!-- 서치 아이콘 -->
																        </button>
																      </span>
																    </div>
																</div>
															</div>
														</div>
																										
													<div class="row" style="">
														<div class="col-md-12 text-right" style="margin-bottom: 10px;">
															<button type="button" id="" onclick="fnPopupInfo('R');" class="btn btn-primary btn-sm">조회</button>
															<button type="button" id="" onclick="fnDownload();" class="btn btn-warning btn-sm">다운로드</button>
															<button type="button" id="" onclick="fnPopupInfo('N');" class="btn btn-success btn-sm">등록</button>
														</div>
													</div>
															
													</div>

														
														<!-- row end -->
													</div>
													<div class="row" style="padding-top: 10px; height: 625px;">
														<div class="col-md-12" style="height:100%;width: 100%;">
															<div id="grid_list" style="width: 100%; height: 560px; "></div>
															<div id="pagination" class="text-center"></div><!-- 페이지 -->
														</div>
													</div>
												</div>
											
											
										
												
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
			
			<!-- start list-modal select/insert/update  -->
			<div class="modal fade" id="modal_info" aria-hidden="true" style="display: none; z-index: 1060;"><!-- data-backdrop="static"> -->
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="modal_title">등록</h4>
			        	</div>
						<div class="modal-body" id="">
									<!-- frm_info -->
							<form id="frm_insertInfo" name="frm_insertInfo" class="form-horizontal">							
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">작업일</label>
									<div class="col-sm-7">
										<div class="input-group">
											<input type="text" class="form-control pull-right input-sm" id="m_jaup_date">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
										</div>
									</div>
									<div class="col-sm-1"></div>
								</div>	
								
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">설비</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="m_sulbi" value="" maxlength="50">
									</div>
									<div class="col-sm-1"></div>
								</div>
								
								<!-- search -->								
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">고객사명</label>
									<div class="col-sm-6">
										<input type="text" class="form-control input-sm" id="m_sulbi" value=""><!-- style="padding-right:0px" -->
									</div>
									<div class="col-sm-1" style="padding-left: 0px;">
										<button type="button" onclick="searchInfo('G');" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
									</div>
									<div class="col-sm-1"></div>
								</div>
								
								
								
								<div class="form-group row">
									
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">제품 ITEM</label>
									<div class="col-sm-6">
										<input type="text" class="form-control input-sm" id="m_sulbi" value="" maxlength="50"><!-- style="padding-right:0px" -->
									</div>
									<div class="col-sm-1" style="padding-left: 0px;">
										<button type="button" onclick="searchInfo('I');" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
									</div>
									<div class="col-sm-1"></div>
									
								</div>
									
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">작업자</label>
									<div class="col-sm-6">
										<input type="text" class="form-control input-sm" id="m_jaup" value="" maxlength="50"><!-- style="padding-right:0px" -->
									</div>
									<div class="col-sm-1" style="padding-left: 0px;">
										<button type="button" onclick="searchInfo('J');" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
									</div>
									<div class="col-sm-1"></div>
								</div>
								
								
								<div class="form-group row">
								
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">설비</label>
									<div class="col-sm-6">
										<input type="text" class="form-control input-sm" id="m_sulbi_search" value="" maxlength="50"><!-- style="padding-right:0px" -->
									</div>
									<div class="col-sm-1" style="padding-left: 0px;">
										<button type="button" onclick="searchInfo('S');" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
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
			
			<!-- 고객사 모달 -->
			
			<div class="modal fade" id="modal_go" aria-hidden="true" style="display: none; z-index: 1060;"><!-- data-backdrop="static"> -->
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="modal_title">고객사 목록</h4>
			        	</div>
						<div class="modal-body" id="">
							<form id="go_fm" name="go_fm" class="form-horizontal">							
	
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">고객사명</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="m_m_go" value="" maxlength="50">
									</div>
									<div class="col-sm-1"></div>
								</div>
								
								<!-- search -->								
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">사업자번호</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="m_m_saup" value=""><!-- style="padding-right:0px" -->
									</div>
									<!-- <div class="col-sm-1" style="padding-left: 0px;">
										<button type="button" onclick="searchInfo('G');" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
									</div> -->
									<div class="col-sm-1"></div>
								</div>

									
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">담당자</label>
									<div class="col-sm-6">
										<input type="text" class="form-control input-sm" id="m_m_damdang" value="" maxlength="50"><!-- style="padding-right:0px" -->
									</div>
									<div class="col-sm-1" style="padding-left: 0px;">
										<button type="button" onclick="searchInfo('');" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
									</div>
									<div class="col-sm-1"></div>
								</div>
	
	
								<div class="form-group row">
									<div class="col-sm-1"></div>
									
								<!-- <div class="form-group row">
									<div class="col-sm-1"></div>
									<div class="col-sm-10"> -->
											<!-- <table class="table table-bordered">
												<thead>
													<tr style="border: 1px solid black;">
														<th>설비명</th>
														<th>성명</th>
														<th>이메일</th>
													</tr>
												</thead>
											</table> -->
											<!-- <div>w2ui.Grid</div> >> -->
												<!-- <div class="row" style="padding-top: 10px; height: 200px;">
												 -->		<div class="col-md-11" style="height:100%;width: 100%;">
															<div id="goGrid" style="width: 560px; height: 180px; "></div>
														</div>
												<!-- </div> --> 
								<!-- 	</div>
								</div> -->
								</div>
					
							</form>
							
						</div>
						
						<div class="modal-footer">
							<div class="col-md-12 text-center">
								<button type="button" id="btn_dmr_cancel" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div> 
			
			<!-- 고객사 모달 끝 -->
			
			<!-- 제품 ITEM 모달 -->
			
						
			<div class="modal fade" id="modal_proItem" aria-hidden="true" style="display: none; z-index: 1060;"><!-- data-backdrop="static"> -->
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="modal_title">제품 ITEM 목록</h4>
			        	</div>
						<div class="modal-body" id="">
							<form id="it_fm" name="it_fm" class="form-horizontal">							
	
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">품명</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="m_proName" value="" maxlength="50">
									</div>
									<div class="col-sm-1"></div>
								</div>
								
								<!-- search -->								
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">품번</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="m_proNo" value=""><!-- style="padding-right:0px" -->
									</div>
									<!-- <div class="col-sm-1" style="padding-left: 0px;">
										<button type="button" onclick="searchInfo('G');" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
									</div> -->
									<div class="col-sm-1"></div>
								</div>

									
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">고객사명</label>
									<div class="col-sm-6">
										<input type="text" class="form-control input-sm" id="m_goName" value="" maxlength="50"><!-- style="padding-right:0px" -->
									</div>
									<div class="col-sm-1" style="padding-left: 0px;">
										<button type="button" onclick="searchInfo('');" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
									</div>
									<div class="col-sm-1"></div>
								</div>
	
								<!-- <div class="form-group row">
									<div class="col-sm-1"></div>
									<div class="col-sm-10">
											<table class="table table-bordered">
												<thead>
													<tr style="border: 1px solid black;">
														<th>설비명</th>
														<th>성명</th>
														<th>이메일</th>
													</tr>
												</thead>
											</table>
											<div>w2ui.Grid</div> >> 
											
									</div>
								</div> -->
								

								<div class="form-group row">
									<div class="col-sm-1"></div>
									
								<!-- <div class="form-group row">
									<div class="col-sm-1"></div>
									<div class="col-sm-10"> -->
											<!-- <table class="table table-bordered">
												<thead>
													<tr style="border: 1px solid black;">
														<th>설비명</th>
														<th>성명</th>
														<th>이메일</th>
													</tr>
												</thead>
											</table> -->
											<!-- <div>w2ui.Grid</div> >> -->
												<!-- <div class="row" style="padding-top: 10px; height: 200px;">
												 -->		<div class="col-md-11" style="height:100%;width: 100%;">
															<div id="itemGrid" style="width: 560px; height: 180px; "></div>
														</div>
												<!-- </div> --> 
								<!-- 	</div>
								</div> -->
								</div>
					
						
							</form>
							
						</div>
						
						<div class="modal-footer">
							<div class="col-md-12 text-center">
								<button type="button" id="btn_dmr_cancel" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div> 
			
			<!-- 제품 ITEM 모달 끝 -->
			
			<!-- 작업자 목록 모달 -->
			
			<div class="modal fade" id="modal_jaup" aria-hidden="true" style="display: none; z-index: 1060;"><!-- data-backdrop="static"> -->
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="modal_title">작업자 목록</h4>
			        	</div>
						<div class="modal-body" id="">
							<form id="jaup_fm" name="jaup_fm" class="form-horizontal">							
	
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">성명</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="m_sungName" value="" maxlength="50">
									</div>
									<div class="col-sm-1"></div>
								</div>
								
								<!-- search -->								

								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">사번</label>
									<div class="col-sm-6">
										<input type="text" class="form-control input-sm" id="m_jaup_sabun" value="" maxlength="50"><!-- style="padding-right:0px" -->
									</div>
									<div class="col-sm-1" style="padding-left: 0px;">
										<button type="button" onclick="searchInfo('');" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
									</div>
									<div class="col-sm-1"></div>
								</div>
	
<!-- 								<div class="form-group row">
									<div class="col-sm-1"></div>
									<div class="col-sm-10">
											<table class="table table-bordered">
												<thead>
													<tr style="border: 1px solid black;">
														<th>설비명</th>
														<th>성명</th>
														<th>이메일</th>
													</tr>
												</thead>
											</table>
											<div>w2ui.Grid</div> >> 
									</div>
								</div> -->
					
								<div class="form-group row">
									<div class="col-sm-1"></div>
									
								<!-- <div class="form-group row">
									<div class="col-sm-1"></div>
									<div class="col-sm-10"> -->
											<!-- <table class="table table-bordered">
												<thead>
													<tr style="border: 1px solid black;">
														<th>설비명</th>
														<th>성명</th>
														<th>이메일</th>
													</tr>
												</thead>
											</table> -->
											<!-- <div>w2ui.Grid</div> >> -->
												<!-- <div class="row" style="padding-top: 10px; height: 200px;">
												 -->		<div class="col-md-11" style="height:100%;width: 100%;">
															<div id="jaupGrid" style="width: 560px; height: 180px; "></div>
														</div>
												<!-- </div> --> 
								<!-- 	</div>
								</div> -->
								</div>
					
					
							</form>
							
						</div>
						
						<div class="modal-footer">
							<div class="col-md-12 text-center">
								<button type="button" id="btn_dmr_cancel" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div> 
			
			<!-- 작업자 목록 모달 끝 -->
			
			<!-- 설비 목록 모달 -->
			
			<div class="modal fade" id="modal_sulbi" aria-hidden="true" style="display: none; z-index: 1060;"><!-- data-backdrop="static"> -->
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="modal_title">설비 목록</h4>
			        	</div>
						<div class="modal-body" id="">
							<form id="sulbi_fm" name="sulbi_fm" class="form-horizontal">							
	
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">설비명</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="m_sulbi_name" value="" maxlength="50">
									</div>
									<div class="col-sm-1"></div>
								</div>
								
								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">품명</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="m_sulbi_pName" value="" maxlength="50">
									</div>
									<div class="col-sm-1"></div>
								</div>
								
								<!-- search -->								

								<div class="form-group row">
									<div class="col-sm-1"></div>
									<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">품번</label>
									<div class="col-sm-6">
										<input type="text" class="form-control input-sm" id="m_sulbi_pNo" value="" maxlength="50"><!-- style="padding-right:0px" -->
									</div>
									<div class="col-sm-1" style="padding-left: 0px;">
										<button type="button" onclick="searchInfo('');" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
									</div>
									<div class="col-sm-1"></div>
								</div>
	
								<!-- <div class="form-group row">
									<div class="col-sm-1"></div>
									<div class="col-sm-10">
											<table class="table table-bordered">
												<thead>
													<tr style="border: 1px solid black;">
														<th>설비명</th>
														<th>성명</th>
														<th>이메일</th>
													</tr>
												</thead>
											</table>
											<div>w2ui.Grid</div> >> 
									</div>
								</div> -->
								
								<div class="form-group row">
									<div class="col-sm-1"></div>
									
								<!-- <div class="form-group row">
									<div class="col-sm-1"></div>
									<div class="col-sm-10"> -->
											<!-- <table class="table table-bordered">
												<thead>
													<tr style="border: 1px solid black;">
														<th>설비명</th>
														<th>성명</th>
														<th>이메일</th>
													</tr>
												</thead>
											</table> -->
											<!-- <div>w2ui.Grid</div> >> -->
												<!-- <div class="row" style="padding-top: 10px; height: 200px;">
												 -->		<div class="col-md-11" style="height:100%;width: 100%;">
															<div id="sulbiGrid" style="width: 560px; height: 180px; "></div>
														</div>
												<!-- </div> --> 
								<!-- 	</div>
								</div> -->
								</div>
					
					
							</form>
							
						</div>
						
						<div class="modal-footer">
							<div class="col-md-12 text-center">
								<button type="button" id="btn_dmr_cancel" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div> 
			
			<!-- 설비 목록 모달 끝 -->
		<!-- modal End -->
		
		<jsp:include page="/common/footer_inc" flush="true">
			<jsp:param name="page_title" value="0" />
		</jsp:include>
		
		<jsp:include page="/common/sidebar_rview_inc" flush="true">
			<jsp:param name="page_title" value="0" />
		</jsp:include>

	</div>
	
	<style>
		/* .input-group .form-control:first-child, .input-group-addon:first-child,
		.input-group-btn:first-child > .btn,
		.input-group-btn:first-child > .btn-group > .btn,
		.input-group-btn:first-child > .dropdown-toggle, 
		.input-group-btn:last-child > .btn:not(:last-child):not(.dropdown-toggle), 
		.input-group-btn:last-child > .btn-group:not(:last-child) > .btn 
		{
				border-top-right-radius: 0;
	    		border-bottom-right-radius: 0;
		} */
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
		
		#exTab3 .tab-content {
			border: none;
		}
		
		.w2ui-grid-box {
			width : 560px;
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

			initGridList(); // 첫 그리드
		
			minDate = getFormatDate(new Date()),
			mdTemp = new Date(), 
			maxDate = getFormatDate(new Date(mdTemp.setDate(mdTemp.getDate() + 7)));
			 
		/* 	$('#p_eindt, #p_date_created, #p_date_updated').daterangepicker({
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
			}); */
			
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
			
			/* $('#p_date, #m_jaup_date').daterangepicker({
				opens: 'right',
				locale: {
					format : 'YYYY-MM-DD'	,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear : true,
					yearSuffix : '년'
			    },
		 	     /*- startDate: getTodayDate(),
		 	     endDate: getTodayDate() *-/
		 	    /*-  startDate: '2019-05-01', *-/
		 	     endDate: '2019-08-31' 
			}); */
			
			// Single Date Picker - http://www.daterangepicker.com/
			 $('#p_date, #m_jaup_date').daterangepicker({
				    singleDatePicker: true,
				    showDropdowns: true,
				    minYear: 1901,
				    maxYear: parseInt(moment().format('YYYY'),10)
				  }, function(start, end, label) {
				    var years = moment().diff(start, 'years');
				  /*   alert("You are " + years + " years old!"); */
				  });

		} // 
		
		
		// 검색 searchInfo
		function searchInfo(flag){
			
			if(flag == 'G'){ // 고객사명
				console.log("searchInfo = " + flag);
			
				setTimeout(function(){
				      w2ui['goGrid'].resize();
				      w2ui['goGrid'].refresh();
				   }, 200);
				
				$("#modal_go").modal('show');
				goGrid();
			
			} else if(flag == 'I'){ // 제품 ITEM
				console.log("searchInfo = " + flag);
			
				setTimeout(function(){
				      w2ui['itemGrid'].resize();
				      w2ui['itemGrid'].refresh();
				   }, 200);
			
				$("#modal_proItem").modal('show');
				itemGrid();
			
			
			} else if(flag == 'J'){ // 작업자
				console.log("searchInfo = " + flag);
			
				setTimeout(function(){
				      w2ui['jaupGrid'].resize();
				      w2ui['jaupGrid'].refresh();
				   }, 200);
			
				$("#modal_jaup").modal('show');
				jaupGrid();
			
			} else if(flag == 'S'){ // 설비
				console.log("searchInfo = " + flag);
			
				setTimeout(function(){
				      w2ui['sulbiGrid'].resize();
				      w2ui['sulbiGrid'].refresh();
				   }, 200);
			
				$("#modal_sulbi").modal('show');
				sulbiGrid();
			
			}
		}
	
		// 첫 그리드
	 	function initGridList() {
			console.log('initGridList()');
			var rowArr = [];
			
			// project_manager
			$('#grid_list').w2grid({ 
		        name: 'grid_list', 
		        show: { footer: true}, // , selectColumn: true
		        columnGroups: [
		                     /*   { caption: 'No', master: true }, */
		                       { caption: '일자',master: true },
		                       { caption: '장비호기',master: true },
		                       { caption: '품번',master: true },
		                       { caption: '품명', master: true },
		                       { caption: '근무조', master: true },
		                       { caption: 'UPH', master: true },
		                       
		                       { caption: '주/야', span: 1 },
		                       { caption: '생산', span: 2 },
		                       { caption: '비가동 현황', span: 6 },
		                      
		                       { caption: '비가동 시간 (분)', master: true },
		                       { caption: '공정불량', master: true },
		                       { caption: '생산수량', master: true },
		                       
		                       { caption: '주야', span: 1  },
		                       
		                       { caption: '가동효율', master: true },
		                       { caption: '비가동(%)', master: true },
		                       { caption: '불명(%)', master: true },
		                       { caption: '공정불량율(%)', master: true },
		                   ],
		        multiSelect: true,
		        columns: [
						{ field: 'date', caption: '일자', size: '50px', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'jangbi', caption: '장비 호기', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'pNo', caption: '품번', size: '10%', sortable: true, attr: 'align=center', resizable: true },//, hidden:true
			            { field: 'pNo_nm', caption: '품명', size: '20%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'jTeam', caption: '근무조', size: '10%', sortable: true, attr: 'align=center', resizable: true},
			            
			            { field: 'uph', caption: 'UPH', size:'10%', sortable: true, attr: 'align=center', resizable: true },
			            /* { field: 'ju_ya', caption: '주/야', size: '10%', sortable: true, attr: 'align=center', resizable: true }, */
			            { field: 'ju_jaup', caption: '작업자', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            
			            { field: 'tuip', caption: '투입시점', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'go_surang', caption: '목표수량', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            
			            { field: 'jungri', caption: '계획정리', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'time', caption: '청소시간', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'sulbierror', caption: '설비이상', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'gonggu', caption: '공구교환', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'seting', caption: '셋팅', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'sojae', caption: '소재결품', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			   
			            { field: 'bigadong', caption: '비가동 시간(분)', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'errorsu', caption: '공정불량', size: '10%', sortable: true, attr: 'align=center', resizable: true },
			            { field: 'madesu', caption: '생산수량', size: '10%', sortable: true, attr: 'align=center', resizable: true }
			   
			    ],
		        sortData: [
					{field: 'lifnr', direction: 'ASC'},
					{field: 'lifnr_nm', direction: 'ASC'}
				],
				records: [
				
				          
				          
				],
				total : 0,
				recordHeight : 30,
				onReload: function(event) {},
				onClick: function (event) {},
				onDblClick: function (event) {
					var flag = 'R';
					fnPopupInfo(flag);
				}
		    }); 
		
			// w2ui['grid_list'].multiSelect = this.checked; w2ui['grid_list'].selectNone(); << 버튼으로 쓰면 다중 선택 됐다가 안됐다가~
		}

		
		// 첫번째 조회 모달
		//function project_modal() {
		function fnPopupInfo(flag) {
			console.log('fnPopupInfo(' + flag + ')');
			
			var sel = w2ui.grid_list.getSelection();	
			console.log("sel = " + sel);
			
			if(flag == 'R'){ // 조회
				var selIdxArr = w2ui.grid_list.getSelection();
				var row = w2ui.grid_list.get(selIdxArr[0]);
				
				var chkLen = selIdxArr.length;
				console.log(chkLen);
			
				//if(selIdxArr == null || selIdxArr == '' ){ alert('다시 선택해 주세요!'); return; }
				/* 
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
				 */
				
				/* 
				$("#").val(row.);
				$("#").val(row.);
				$("#").val(row.);
				$("#").val(row.);
				$("#").val(row.);
				$("#").val(row.);
				$(":radio[name=][value="+row.+"]").iCheck("check");
				$("#").val(row.eindt);
				$("#").val(row.menge);
				$("#").val(row.date_created);
				$("#").val(row.date_updated);
				 */
				
				// $("#btn_dmr_save").css("display","none");
				
				
			} else if (flag=='N'){ // 등록
				
				$("#modal_info").modal("show");
				
				/* $("#p_project_no").val("");
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
				$("#p_date_updated").attr('disabled', false); */
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
			} 
			
		}

		
		function goGrid(){
			console.log('goGrid()');
			
			var rowArr = [];
			
			$('#goGrid').w2grid({ 
				name : "goGrid" ,
				show: { footer: true },
		        multiSelect: false,
		        columns: [
		                  { field: 'gog_Name', caption: '고객사명', size: '185px', sortable: true, attr: 'align=center', resizable: true },
		                  { field: 'saup_No', caption: '사업자 번호', size: '185px', sortable: true, attr: 'align=center', resizable: true },
		                  { field: 'damda', caption: '담당자', size: '185px', sortable: true, attr: 'align=center', resizable: true }
		                 ],
		        sortData: [{field: 'damda', direction: 'ASC'}],
				records: [   
				         ],
				total : 0,
				recordHeight : 30,
				onReload: function(event) {},
				// sssssbbbb
				onClick: function (event) {
				
				},
				onDblClick: function(event) {
					
				}
		    }); 
			
		}
		
		
		function itemGrid(){
			console.log('itemGrid()');
			
			var rowArr = [];
			
			$('#itemGrid').w2grid({ 
				name : "itemGrid" ,
				show: { footer: true },
		        multiSelect: false,
		        columns: [
		                  { field: 'pom_name', caption: '품명', size: '185px', sortable: true, attr: 'align=center', resizable: true },
		                  { field: 'pom_no', caption: '품번', size: '185px', sortable: true, attr: 'align=center', resizable: true },
		                  { field: 'goga_name', caption: '고객사명', size: '185px', sortable: true, attr: 'align=center', resizable: true }
		                 ],
		        sortData: [{field: 'pom_no', direction: 'ASC'}],
				records: [   
				         ],
				total : 0,
				recordHeight : 30,
				onReload: function(event) {},
				// sssssbbbb
				onClick: function (event) {
				
				},
				onDblClick: function(event) {
					
				}
		    }); 
			
		}
		

		function jaupGrid(){
			console.log('jaupGrid()');
			
			var rowArr = [];
			
			$('#jaupGrid').w2grid({ 
				name : "jaupGrid" ,
				show: { footer: true },
		        multiSelect: false,
		        columns: [
		                  { field: 's_name', caption: '성명', size: '278px', sortable: true, attr: 'align=center', resizable: true },
		                  { field: 'sa_no', caption: '사번', size: '278px', sortable: true, attr: 'align=center', resizable: true }
		                 ],
		        sortData: [{field: 'sa_no', direction: 'ASC'}],
				records: [   
				         ],
				total : 0,
				recordHeight : 30,
				onReload: function(event) {},
				// sssssbbbb
				onClick: function (event) {
				
				},
				onDblClick: function(event) {
					
				}
		    }); 
			
		}
		
		
		function sulbiGrid(){
			console.log('sulbiGrid()');
			
			var rowArr = [];
			
			$('#sulbiGrid').w2grid({ 
				name : "sulbiGrid" ,
				show: { footer: true },
		        multiSelect: false,
		        columns: [
		                  { field: 's_name', caption: '설비명', size: '185px', sortable: true, attr: 'align=center', resizable: true },
		                  { field: 'pomName', caption: '품명', size: '185px', sortable: true, attr: 'align=center', resizable: true },
		                  { field: 'pomNo', caption: '품번', size: '185px', sortable: true, attr: 'align=center', resizable: true }
		                 ],
		        sortData: [{field: 'pomNo', direction: 'ASC'}],
				records: [ ],
				total : 0,
				recordHeight : 30,
				onReload: function(event) {},
				// sssssbbbb
				onClick: function (event) {
				
				},
				onDblClick: function(event) {
					
				}
		    }); 
			
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