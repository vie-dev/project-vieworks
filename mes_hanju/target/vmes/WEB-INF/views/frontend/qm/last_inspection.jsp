<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
	String member_id = SessionUtil.getMemberId(request);
	String member_nm = SessionUtil.getMemberNm(request);
	String member_emp_no = SessionUtil.getMemberEmpNo(request);
%>
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
            <jsp:param name="selected_menu_p_cd" value="1011" />
            <jsp:param name="selected_menu_cd" value="1034" />
        </jsp:include>

        <div class="content-wrapper">
            <section class="content-header">
                <h1>
					품질관리 <small> 최종검사</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="#"><i class="fa fa-dashboard"></i> 품질관리 </a></li>
                    <li class="active">최종검사</li>
                </ol>
            </section>
            <section class="content">
                <div class="row">
                    <section class="col-lg-12">
                        <div class="box box-success box-solid" style="min-height: 70px;">
                            <div class="box-header with-border">
                                <h3 class="box-title">조회조건</h3>
                                <div class="box-tools pull-right">
                                    <button type="button" id="btn_search_csr" class="btn btn-primary btn-sm" onclick="fnSearchInspGrid();">조회</button>
                                </div>
                            </div>
                            <div id="" class="box-body">
                                <div class="row">
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label> <input type="radio" name="date_type" class="flat-red" value="cm" checked> 완성일	</label>
											<label> <input type="radio" name="date_type" class="flat-red" value="su"> 처리일</label>
                                            <div class="input-group">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <input type="text" class="form-control pull-right input-sm" id="req_date_range" >
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <label>시리얼번호</label> 
                                         <!--    <input type="input" id="project_no" name="project_no" class="form-control input-sm" placeholder="" maxlength="30"> -->
                                        	<input type="input"  id="project_no" name="project_no" class="form-control input-sm"  maxlength="100"  
											onkeypress="if(event.keyCode==13) {LMainsernr_enter(this); return false;}">
                                        </div>
                                    </div>
                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <label>플랜트</label> 
                                            <select id="plnt" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
													<option value="">전체</option>
													<option value="1110">의료</option>
													<option value="1210">광</option>
											</select>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>제품</label> <input type="input" id="itnbr" name="itnbr" class="form-control input-sm" placeholder="" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>모델명</label> <input type="input" id="pordno_status" name="pordno_status" class="form-control input-sm" placeholder="" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>생산오더번호</label> <input type="input" id="pordno" name="pordno" class="form-control input-sm" placeholder="" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>상태</label><br />
                                            <label> <input type="radio"	name="pdsts" class="flat-red" value="" checked>전체</label>
                                            <label> <input type="radio" name="pdsts"	 class="flat-red" value="p8"> 대기</label>
                                            <label> <input type="radio" name="pdsts" class="flat-red" value="p9"> 합격</label>
                                            <label> <input type="radio" name="pdsts" class="flat-red" value="p10"> 불합격</label>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group" style="display:none;">
                                            <h3 class="box-title">test</h3>
                                            <input type="radio"	name="inspection_type" value="L" checked onclick="successYn();">최종검사
                                            <input type="radio" name="inspection_type" value="S" onclick="successYn();"> 출하검사
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box box-default box-solid" style="min-height: 600px;">
                            <div class="box-header with-border">
                            	 <h3 class="box-title">검사내역</h3>
                            	  <div class="box-tools pull-right">
	                            	 	<button type="button" id="" class="btn btn-primary btn-sm" onclick="selfInspModal();" style="color: white;">자주검사</button>
	                            	 	<button type="button" id="btn_success_process" class="btn btn-success btn-sm" onclick = "success_process();" style="color: white;">합격</button>
										<button type="button" id="btn_fail_process" class="btn btn-danger btn-sm" onclick = "fail_process();"style="color: white;">불합격</button>
										<button type="button" id="cancel_process" class="btn btn-warning btn-sm" onclick = "cancel_open();"style="color: white;">취소</button>
										<button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_role');" data-selfilepath="/upload" data-selfilename="test.xlsx">
								    		<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
										</button>
                            	  </div>
                            </div>
                            <div class="box-body" style="padding-bottom: 0px;padding-top: 0px;">
                            	<div class="box-header with-border">
	                            	<div class="row" class="col-sm-12">
										<div class="col-sm-4" style="height: 20px;"></div>
			                            <div class="col-sm-4" style="height: 20px;">
										<label for="" class="col-sm-3 control-label">검사진행</label>
											<div class="col-sm-9">
												<button type="button" id="inspStart" class="btn btn-success btn-sm" onclick="insp_start();">검사시작</button>
												<button type="button" id="inspPuase" class="btn btn-success btn-sm" onclick="insp_puase();">검사보류</button>
												<button type="button" id="inspRestart" class="btn btn-success btn-sm" onclick="insp_restart();">검사재시작</button>
												<button type="button" id="inspEnd" class="btn btn-success btn-sm" onclick="insp_end();">검사종료</button>
												<div id='insp_txt' style="font-weight:bold; color:red;">
													<label for="" class="col-sm-12 control-label">검사진행이 완료됐습니다.</label>
												</div>
											</div>
										</div>
					                </div>
					            </div>
					        </div>  
							<div class="box-body" style="padding-bottom: 0px;padding-top: 0px;">
                            	<div class="box-header">
	                            	<div class="row">
										<div class="col-sm-2">
											<label for="m_type" class="col-sm-4 control-label">Type</label>
											<select id="sel_step1" class="form-control select2 input-sm" onChange="changeStep($(this).val(),'step1');">
											<option>-</option>
											</select>
										</div>
										<div class="col-sm-3">
											<label for="m_lv1" class="col-sm-2 control-label">Lv.01</label>
											<select id="sel_step2" class="form-control select2 input-sm" onChange="changeStep($(this).val(),'step2');">
											<option>-</option>
											</select>
										</div>
										<div class="col-sm-3">
											<label for="m_lv2" class="col-sm-2 control-label">Lv.02</label>
											<select id="sel_step3" class="form-control select2 input-sm" onChange="changeStep($(this).val(),'step3');">
											<option>-</option>
											</select>
										</div>
										<div class="col-sm-3">
											<label for="m_lv3" class="col-sm-2 control-label">Lv.03</label>
											<select id="sel_step4" class="form-control select2 input-sm">
											<option>-</option>
											</select>
										</div>
										<div class="col-sm-1">
											<label for="lv_c" class="col-sm-1 control-label"></label>
											<button type="button" id="" onclick="input_code();" class="btn btn-primary btn-sm" style="height: 50px;width: 55px;"">입력</button>
										</div>
									</div>
	                            </div>
	                        </div>
                            <div class="box-body">
                                <div class="row">
                                    <div id="dv_grid_role" class="col-sm-12">
                                        <table id="grid_role"></table>
                                        <div id="grid_role_pager"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
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
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">제품선택</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class=" col-md-12">
						 &nbsp; 처리일자와 To창고를 선택해주세요.
						</div>	
					</div>
					<div class="row">
						<div class=" col-md-12">
							<div class="box" style="margin-bottom: 0px;">								
								<div class="row">
								<div class=" col-md-12">
								<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">최종승인</h3>
								</div>
<!-- 								<div class="form-group"> -->
<!-- 								<label for="" class="col-sm-3 control-label">검사진행</label> -->
<!-- 									<div class="col-sm-9"> -->
<!-- 										<button type="button" id="inspStart" class="btn btn-success" onclick="insp_start();">검사시작</button> -->
<!-- 										<button type="button" id="inspPuase" class="btn btn-success" onclick="insp_puase();">검사보류</button> -->
<!-- 										<button type="button" id="inspRestart" class="btn btn-success" onclick="insp_restart();">검사재시작</button> -->
<!-- 										<button type="button" id="inspEnd" class="btn btn-success" onclick="insp_end();">검사종료</button> -->
<!-- 										<div id='insp_txt' style="font-weight:bold; color:red;"> -->
<!-- 											<label for="" class="col-sm-12 control-label">검사진행이 완료됐습니다.</label> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
								<div class="form-group">
										<label for="" class="col-sm-3 control-label">처리일자</label>
										<div class="col-sm-9">
											<input type="text" id="r_conf_date" name="r_conf_date"  placeholder="" maxlength="10" style="height: 33px;" readonly="readonly">
										</div>
								</div>
								<div class="form-group">
										<label for="" class="col-sm-3 control-label">To 창고</label>
										<div class="col-sm-9">
										<select id="s_to" class="form-control select2" data-placeholder="유형 선택" style="width: 100%;">
										</select>
										<label id="s_to_msg" for="" class="col-sm-12">창고이동 대상이 아닙니다. 합불판정만 진행됩니다.</label>
										</div>
								</div>
								</div>
								</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_process_yn" class="btn btn-success" onclick="process_yn();">요청</button>
					<button type="button" id="" class="btn btn-default" onclick="modal_detail_close();">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- ************************등급대상실적들 창고 입력 : Start ************************-->
  <div class="modal fade" id="grade_mng" data-backdrop="static">
    <div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">등급창고입력내역</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
			<div class="box box-warning box-solid">
			<div class="box-header with-border">
						<h3 class="box-title">등급창고입력</h3>
						<div class="box-tools pull-right" style="padding-top: 3px;">
									<button type="button" id="" onclick="work_end_proc();" class="btn btn-primary btn-sm">진행</button>
								</div>
					</div>
			<div class="modal-body" id="modal_code_body">
						<div class="box-body">				
			            <form id="frm_grid_grade_mng" name="frm_grid_grade_mng" class="form-horizontal">
						
						<div class="row">
						<table id=grid_grade_mng></table>
						</div>

						</form>
						</div>
	        </div>
	        </div>
	        </div>
		</div>
	</div>
</div>
<!-- ************************등급대상실적들 창고 입력 : End ************************-->

<!-- ************************등급창고 지정 : Start ************************-->
<div class="modal fade" id="grade_loc_add_1" data-backdrop="static">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">등급창고지정</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
	            <form id="frm_serial_add_1" name="frm_serial_add_1" class="form-horizontal">
					<div class="form-group">
						<label for="" class="col-sm-3 control-label">제품번호</label>
						<div class="col-sm-9">
							<input type="input" id="grade_loc_matnr_1" name="grade_loc_matnr_1" class="form-control"  readonly="readonly">
						</div>
					</div>
	                <div class="form-group input_2">
						<label for="" class="col-sm-3 control-label">창고</label>
						<div class="col-sm-9">
<!-- 							<input type="input"  id="fsa_loc" name="fsa_loc" class="form-control"  maxlength="20" > -->
							<select id="grade_loc_1" class="form-control select2">
								<option value="210A">생산 창고 - S등급</option>
								<option value="210B">생산 창고 - CS등급</option>
								<option value="210C">생산 창고 - C등급</option>
								<option value="210D">생산 창고 - D등급</option>
							</select> 
						</div>
	                </div>
	            </form>
	        </div>
			<div class="modal-footer center-block">
		        <button type="button" class="btn btn-sm btn-primary" onclick="locInputMng_1();">확인</button>
		        <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- ************************등급창고 지정 : End ************************-->
<!-- 자주검사  -->
<div class="modal fade" id="modal_selfInsp" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">자주검사 <span id="pono"></span></h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12">
						<div id="grid_selfInsp_header" style="width: 100%; height: 300px;"></div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-10"></div>
					<div class="col-md-2">
						<select id="self_insp_routing" class="form-control select2 input-sm" style="margin-top: 10px;"
							onChange="showSelfInspGrid();"></select>
					</div>
				</div>
				<div class="row" style="height: 400px; overflow-y: auto; overflow-x: hidden;">
					<div id="1110" class="col-md-12">
						<!-- 
			grid_v12_area		grid_v12	//	
			grid_v13_area		grid_v13	//	
			grid_v14_area		grid_v14	//	
			grid_v17_area		grid_v17	//	
			grid_r10_area		grid_r10	//	
			grid_r11_area		grid_r11	//	
			grid_r12_area		grid_r12	//	
			grid_r21_area		grid_r21	//	
			grid_r22_area		grid_r22	//	
			grid_r23_area		grid_r23	//	
			grid_r31_area		grid_r31	//	
			grid_r32_area		grid_r32	//	
			grid_r52_area		grid_r52	//	
			grid_qt_area	grid_qt	//	
			grid_qo_area	grid_qo	//	 
			grid_qa_area	grid_qa	//	
			 -->
						<div class="row">
							<!-- darkimage검사 -->
							<div class="col-md-12" id="grid_v12_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_v12" style="width: 100%; height: 400px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- calibration -->
							<div class="col-md-12" id="grid_v13_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_v13" style="width: 100%; height: 400px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- osf -->
							<div class="col-md-12" id="grid_v14_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_v14" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 최종 검사 -->
							<div class="col-md-12" id="grid_v17_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_v17" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 1차조립 -->
							<div class="col-md-12" id="grid_r10_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r10" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 공정 검사 -->
							<div class="col-md-12" id="grid_r11_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r11" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 최종 조립 -->
							<div class="col-md-12" id="grid_r12_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r12" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 공정 검사 -->
							<div class="col-md-12" id="grid_r21_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r21" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- on/off test -->
							<div class="col-md-12" id="grid_r22_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r22" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 최종 조립 -->
							<div class="col-md-12" id="grid_r23_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r23" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- ghost 작업 -->
							<div class="col-md-12" id="grid_r31_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r31" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- Backup -->
							<div class="col-md-12" id="grid_r32_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r32" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 공정검사 -->
							<div class="col-md-12" id="grid_r52_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_r52" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 품질 최종 검사 -->
							<div class="col-md-12" id="grid_qt_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_qt" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 품질 1차 검사  -->
							<div class="col-md-12" id="grid_qo_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_qo" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<!-- 품질 Aging -->
							<div class="col-md-12" id="grid_qa_area"
								style="margin-top: 10px; display: none;">
								<div id="grid_qa" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
					</div>
					<div id="1210" class="col-md-12">
						<div class="row">
							<div class="col-md-12" id="grid_p1_area" style="margin-top: 10px;">
								<div id="grid_p1" style="width: 100%; height: 400px;"></div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12" id="grid_p2_area" style="margin-top: 10px;">
								<div id="grid_p2" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12" id="grid_p5_area" style="margin-top: 10px;">
								<div id="grid_p5" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12" id="grid_t1_area" style="margin-top: 10px;">
								<div id="grid_t1" style="width: 100%; height: 200px;"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- end modal body -->
			<div class="modal-footer">
				<div class="text-center">
					<button type="button" class="btn btn-sm btn-primary" onclick="saveSelfInsp();">저장</button>
					<button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div> <!-- end modal-content -->
	</div> <!-- end modal dialog -->
</div> <!-- end modal div -->
<script type="text/javascript">

var selected_pordno_pop;
var member_nm = '<%=member_nm%>';
var member_emp_no = '<%=member_emp_no%>';

$(function($) {
	fnLoadCommonOption();
	fnLoadInspGrid();
	fnLoadGradeMngGrid();
});

function fnLoadCommonOption() {
	$("#r_conf_date").datepicker({
		language: "kr",
		todayHighlight: true,
		format: "yyyymmdd",
		autoclose: true
  	});
	
	$("#r_conf_date").datepicker( "setDate", new Date());
	
	$(window).bind('resize', function() {
		resizeJqGrid("grid_role", false);
	}).trigger('resize');
	
	$("#req_date_range").daterangepicker({
		opens: "right",
		locale: {
			format: "YYYY-MM-DD" // inputbox 에 "2011/04/29" 로표시
			,monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
			,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
			,showMonthAfterYear: true
			,yearSuffix: "년"
			,orientation: "top left"
	    }
	});
	
	initScreenSizeModal();
	
	$("#inspStart").hide();
	$("#inspPuase").hide();
	$("#inspRestart").hide();
	$("#inspEnd").hide();
	$("#insp_txt").hide();
	$("#btn_process_yn").hide();
	
	// selfInsp
	initGridSelgInspHeader();
	init_grid_v12();
	init_grid_v13();
	init_grid_v14();
	init_grid_v17();
	init_grid_r10();
	init_grid_r11();
	init_grid_r12();
	init_grid_r21();
	init_grid_r22();
	init_grid_r23();
	init_grid_r31();
	init_grid_r32();
	init_grid_r52();
	init_grid_qt();
	init_grid_qo();
	init_grid_qa();
	init_grid_p1();
	init_grid_p2();
	init_grid_p5();
	init_grid_t1();
}

function fnSearchInspGrid() {
	
	$("#inspStart").hide();
	$("#inspPuase").hide();
	$("#inspRestart").hide();
	$("#inspEnd").hide();
	$("#insp_txt").hide();
	$("#btn_process_yn").hide();
		
	var date1 = $("#req_date_range").val().substring(0,10).replace("-","").replace("-","");
	var date2 = $("#req_date_range").val().substring(13,23).replace("-","").replace("-","");
	
	var f_date_type ="";
	var t_date_type ="";
	
	if($(':radio[name="date_type"]:checked').val() == "su") {
		f_date_type = "from_sudate";
		t_date_type = "to_sudate";
	} else {
		f_date_type = "from_cmdate";
		t_date_type = "to_cmdate";
	}
	
	var chked_gubun = encodeURIComponent($(':radio[name="inspection_type"]:checked').val());
	var chked_pdsts= encodeURIComponent($(':radio[name="pdsts"]:checked').val());
// 	console.log(chked_pdsts);
	var page_url = "/frontend/qm/inspection_select";
	page_url += "?gubun=" + encodeURIComponent(chked_gubun)
	page_url += "&"+f_date_type+ "=" + encodeURIComponent(date1)
	page_url += "&"+t_date_type+ "=" + encodeURIComponent(date2)
	page_url += "&pordno=" + encodeURIComponent($("#pordno").val())
	page_url += "&pordno_status=" + encodeURIComponent($("#pordno_status").val())
	page_url += "&dept_cd=" + encodeURIComponent($("#plnt").val())
	page_url += "&itnbr=" + encodeURIComponent($("#itnbr").val())
	if(chked_gubun == "L") {
		page_url += "&pdsts=" + encodeURIComponent(chked_pdsts)
	} else {
		if(chked_pdsts == "p8") {	//생산완료와 출하 대기의 status는 동일
			page_url += "&pdsts=" + encodeURIComponent("p9")
		} else if(chked_pdsts == "p9") {
			page_url += "&pdsts=" + encodeURIComponent("p11")
		} else if(chked_pdsts == "p10") {
			page_url += "&pdsts=" + encodeURIComponent("p12")
		}
	}
	page_url += "&project_no=" + encodeURIComponent($("#project_no").val());
	
	$("#grid_role").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_role").setGridParam({ page: 1 }).trigger("reloadGrid");
}
	
function fnLoadInspGrid() {
	$("#grid_role").jqGrid({
		datatype : "json",
		colNames : ['uni_key','확정일', '처리일', '상태', '검사진행코드', '검사진행상태', '플랜트', '저장위치', '검사자', '생산오더번호', '라우팅dscr','오더유형','오더유형', '등급', '자재문서번호', '문서년도', '참조문서번호', '제품', '모델명', '단위',
		            '수량','sap전송','sap전송','자재유형', '시리얼번호', '불량내역', 'pdsts', 'dept_cd', 't1_routing_no', 'wkctr', '불량코드명', 'issue_code', 'pordno_seq', 'transfer_routing', 'kzumw'],
		colModel : [
			{name : 'uni_key',index : 'uni_key',width : 10,sorttype : "text",	sortable : true, key : true, hidden:true}, 
			{name : 'cmdat',index : 'cmdat',width : 10,sorttype : "text",	sortable : true}, 
			{name : 'sudat',index : 'sudat',width : 10,	sorttype : "text",sortable : true}, 
			{name : 'pdsts_nm',index : 'pdsts_nm',width : 15,sorttype : "text",sortable : true},
			{name : 'last_sts',index : 'last_sts',width : 15,sorttype : "text",sortable : true, hidden:true},
			{name : 'last_sts_nm',index : 'last_sts_nm',width : 15,sorttype : "text",sortable : true},
			{name : 'dept_cd_nm',index : 'dept_cd_nm',width : 10,sorttype : "text",sortable : true},
			{name : 'lgort',index : 'lgort',width : 10,sorttype : "text",sortable : true, hidden:true},
			{name : 'member_nm',index : 'member_nm',width : 10,sorttype : "text",sortable : true},
			{name : 'pordno',index : 'pordno',width : 15,sorttype : "text",sortable : true},				
			{name : 'routing_dscr',index : 'routing_dscr',width : 15,sorttype : "text",sortable : true},				
			{name : 'auart',index : 'auart',width : 10,sorttype : "text",sortable : true, hidden:true},
			{name : 'auart_nm',index : 'auart_nm',width : 10,sorttype : "text",sortable : true },
			{name : 'zgrade',index : 'zgrade',width : 10,sorttype : "text",sortable : true},
			{name : 'mblnr',index : 'mblnr',width : 15,sorttype : "text",sortable : true, hidden:true},
			{name : 'mjahr',index : 'mjahr',width : 10,sorttype : "text",sortable : true, hidden:true},
			{name : 'ref_doc_no',index : 'ref_doc_no',width : 25,sorttype : "text",sortable : true, hidden:true},
			{name : 'itnbr',index : 'itnbr',width : 20,sorttype : "text",sortable : true},
			{name : 'pordno_status',index : 'pordno_status',width : 30,sorttype : "text",sortable : true},
			{name : 'meins',index : 'meins',width : 10,sorttype : "text",sortable : true, hidden:true},
			{name : 'pdqty',index : 'pdqty',width : 10,sorttype : "text",sortable : true, align:"right"},
			{name : 'sap_send_yn',index : 'sap_send_yn',width : 10,sorttype : "text",sortable : true, align:"center", hidden:true},
			{name : 'f_sap_send_yn',index : 'f_sap_send_yn',width : 15,sorttype : "text",sortable : true, formatter:jqgridHighlightFormatterSapSendFlag},
			{name : 'mtart',index : 'mtart',width : 10,sorttype : "text",sortable : true, hidden:true},
			{name : 'project_no',index : 'project_no',width : 20,sorttype : "text",sortable : true},
			{name : 'issue_memo',index : 'issue_memo',width : 35,sorttype : "text",sortable : true, editable:true},
			{name : 'pdsts',index : 'pdsts',width : 5,sorttype : "text",sortable : true, hidden:true},
			{name : 'dept_cd',index : 'dept_cd',width : 10,sorttype : "text",sortable : true, hidden:true},
			{name : 'routing_no',index : 'routing_no',width : 10,sorttype : "text",sortable : true, hidden:true}, //cs 재작업 오더들 라우팅no
			{name : 'wkctr',index : 'wkctr',width : 10,sorttype : "text",sortable : true, hidden:true},
			{name : 'issue_code_nm',index : 'issue_code_nm',width : 10,sorttype : "text",sortable : true, width : 20, hidden:false},
			{name : 'issue_code',index : 'issue_code',width : 10,sorttype : "text",sortable : true, hidden:true},
			{name : 'pordno_seq',index : 'pordno_seq',width : 10,sorttype : "text",sortable : true, hidden:true},
			{name : 'transfer_routing',index : 'transfer_routing',width : 10,sorttype : "text",sortable : true, hidden:true},
			{name : 'kzumw',index : 'kzumw',width : 10,sorttype : "text",sortable : true, hidden:true},
		],
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		pager : "#grid_role_pager",
		viewrecords : true,
		autowidth : true,
		shrinkToFit : true,
		multiselect : true,
		height : 330,
		altRows : true,
		rownumbers : true,
		rownumWidth : 25,
		autoencode : true,
		loadonce : false,
		sortable : true,
		cellEdit:true,
	    cellsubmit : 'clientArray',
		jsonReader : {
	    	root : "list_data",
		    records : "records",
		    repeatitems : false,
 	     	id : "uni_key"
	    },
	    onSelectRow : function(rowid, selected) {
			initOptions($('#sel_step1'));
			initOptions($('#sel_step2'));
			initOptions($('#sel_step3'));
			initOptions($('#sel_step4'));
			makeSelStep1();
			
			var rowData = $("#grid_role").getRowData(rowid);
			status_control(rowid, rowData.routing_no);	
		},
		beforeSelectRow: function (rowId, e) {
			var colNm = e.target.getAttribute("aria-describedby");
			var thisId = $(this).getGridParam("id");
			
			if(colNm == thisId + "_issue_memo"
							|| colNm == thisId + "_issue_memo"){
						return true; //return true로 흘려보낸다.
					}else{
						$(this).editCell(0,0,false); // edit셀이 아닌 곳을 edit한것처럼 속여서 나머지 편집중인 셀을 닫아버림
		                                                                 // grid는 jqgrid 셀렉터
					}
			$(this).resetSelection(); //selection제거
			$(this).setSelection(rowId, true); //선택한 row만 select
		},
		loadComplete : function(data) {},
		afterEditCell: function(id,name,val,iRow,iCol){
			  $("#"+iRow+"_"+name).bind('blur',function(){
				  console.log("save!!!!!!");
				$('#grid_role').saveCell(iRow,iCol);
			  });
		},
		afterInsertRow:function(rowid, rowdata, rowelem){
			if( rowdata.pdsts=='p8' ) { // 대기  green
				$("tr.jqgrow#"+rowid).css("color","#0FA60F");
			} else if( rowdata.pdsts=='p9' ) {	// 합격 blue
				$("tr.jqgrow#"+rowid).css("color","#0F18A6");
			} else if( rowdata.pdsts=='p10' ) { // 불합격 red
				$("tr.jqgrow#"+rowid).css("color","#A6190F");
			}
		}
	});
}

/*********************
*To 창고 select box 구성
*********************/
function getToStrList(pass) {
	console.log("pass :: " + pass);
	
	var maching_gubun = '';
	
	initOptions($('#s_to'));
	
	var sel_key_arr = $("#grid_role").jqGrid('getGridParam', 'selarrrow');		 
	var i_rowData = $("#grid_role").getRowData(sel_key_arr[0]);

	if(pass == 'p9') {
		if(i_rowData.kzumw == 'Y' && i_rowData.dept_cd == '1210') {
			maching_gubun = 'P_grd';	
		} else {
			maching_gubun = 'P';
		}
	} else {
		maching_gubun = 'F';
	}
	
	var page_url = "/frontend/scm/mes_stock_tbl_select"
	var postData = 'dept_cd=' + encodeURIComponent(i_rowData.dept_cd);
	postData += '&maching_gubun=' + encodeURIComponent(maching_gubun);
	postData += '&menu_code=' + encodeURIComponent('mst02');
	postData += '&fromto_gubun=' + encodeURIComponent('to');
	if(i_rowData.dept_cd == '1110' && pass == 'p10') {
		postData += '&lgort=' + encodeURIComponent(i_rowData.lgort);
	}

	$.ajax({
	    url: page_url,
	    data: postData,
	    async:false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$.each(data.rows, function (i, item) {
						$('#s_to').append($('<option>', { 
							value: item.stock_code,
					        text : "("+item.stock_code+") "+item.stock_name 
					    }));
					});
				}
	    	} else {
	    		fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
// 		    	//최종검사, 춣하검사 별로 케이스를 나눠 데이터를 가져온다.. like 검색
// 				if($(':radio[name="inspection_type"]:checked').val() == "L") {
// 					$("#s_to").val("2040");
// 				} else {
// 					$("#s_to").val("2050");
// 				}
    	
		    }
	});
}

function initOptions(obj) {
    $(obj)
        .find('option')
        .remove()
        .end()
        //.append('<option value="">선택</option>')
        .val();
}
	
function successYn() {
	getToStrList();
	fnSearchInspGrid();
}

function process_yn() {
	fnMessageModalConfirm("Notification(QM)", "접수를 승인하시겠습니까?", function(result){
		if(result) {
			process(s_pass, s_transfer_yn);	
		}
	});
}
	
function process_notransfer_yn(pass, transfer_yn) {
	fnMessageModalConfirm("Notification(QM)", "접수를 승인하시겠습니까?", function(result){
		if(result) {
			process(pass, transfer_yn);	
		}
	});
}
	
function process(pass, transfer_yn){
	
	$("#grid_role").jqGrid('setGridParam', {cellEdit: false});
	
	var gridDataArr = $('#grid_role').jqGrid('getRowData');
	var keyArr = $('#grid_role').jqGrid('getDataIDs');
	
	$("#grid_role").jqGrid('setGridParam', {cellEdit: true});
	var rowdata;
	var params = [];
	for (var i = 0; i < keyArr.length; i++) { //row id수만큼 실행           
    	if($("input:checkbox[id='jqg_grid_role_"+keyArr[i]+"']").is(":checked")){ //checkbox checked 여부 판단
    		rowdata = $("#grid_role").getRowData(keyArr[i]); // 해당 id의 row 데이터를 가져옴
    		
    		if($("#grid_role").getRowData(keyArr[i]).sudat.length >5)		//처리날짜는 8자리이므로 5로 조건..처리안하면 값없음..
    		{
   				fnMessageModalAlert("Notification(QM)", "이미 처리된 데이터가 있습니다.");
    	 		return;
    		}
    		
		    params.push(rowdata); //배열에 맵처럼 담김         
	    }
	}
				
	/*********************그리드 체크여부 확인 : Start*********************/
	if(params.length == 0)	{
		fnMessageModalAlert("Notification(QM)", "체크 된 데이터가 없습니다.");
 		return;
	}
	/*********************그리드 체크여부 확인 : End*********************/
	
	var jsonStr = JSON.stringify(params);

	/********************* 데이터 insert 및 rfc 전송 : Start*********************/
		
	var s_plnt = rowdata.dept_cd;
	var s_lgort = rowdata.lgort;
	var issue_code = rowdata.issue_code;
	
	var stge_loc ="";
	
	var page_url = "/frontend/qm/inspection_process";
	var postData = 'gridData=' + encodeURIComponent(jsonStr)
		postData += '&plant=' + encodeURIComponent(s_plnt)
		postData += '&stge_loc=' + encodeURIComponent(s_lgort)
		postData += '&move_plant=' + encodeURIComponent(s_plnt)
		postData += '&move_stloc=' + encodeURIComponent($("#s_to").val())
		postData += '&conf_date=' + encodeURIComponent($("#r_conf_date").val())
		postData += '&issue_code=' + encodeURIComponent(issue_code)
		postData += "&gubun=" + encodeURIComponent(transfer_yn)			//창고이동여부		
		postData += "&pdsts=" + encodeURIComponent(pass);					//합격 : p9 .....불합격 : p10
		
		//상태코드를 최종, 출하 별로 따로 지정한다...최종검사를 기본으로 두고 조건문으로 출하검사 상태 설정
// 		if($(':radio[name="inspection_type"]:checked').val() == 'S' && ($(':radio[name="success_yn"]:checked').val() == 'p9' )) {
// 			postData += '&pdsts=' + encodeURIComponent("p11");
// 		} if($(':radio[name="inspection_type"]:checked').val() == 'S' && ($(':radio[name="success_yn"]:checked').val() == 'p10' )) {
// 			postData += '&pdsts=' + encodeURIComponent("p12");
// 		} else {
// 			postData += "&pdsts=" + encodeURIComponent($(':radio[name="success_yn"]:checked').val());
// 		}
		
	$.ajax({
	    url: page_url,
	    data: postData,
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		if(transfer_yn == "Y") {
		    		if(data.e_return == 'S') {
		    			fnMessageModalAlert("Notification(QM)", "정보를 저장했습니다. <br/> ***sap 전송 결과*** <br/>e_return : : " 
								+ data.e_return	+ "<br/>e_message : "+ data.e_message);	
		    			if(s_plnt == '1210' && pass == 'p10') {
		    				SaveInspLot();	
		    			}
		    		} else if(data.e_return == 'E') {
						fnMessageModalAlert("Notification(QM)", "정보를 저장하는데 에러가 발생했습니다. <br/> ***sap 전송 결과*** <br/>e_return : : " 
			    			+ data.e_return	+ "<br/>e_message : "+ data.e_message);
		    		} 
	    		} else {
	    			fnMessageModalAlert("Notification(QM)", "정보를 저장했습니다.");
	    		}
	    	} else {
	    		fnMessageModalAlert("Notification(QM)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    	$("#modal_detail").modal('hide');
	    	fnSearchInspGrid();
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(HUB)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    }
	});
	/********************* 데이터 insert 및 rfc 전송 : End*********************/
}

function status_control(selected_rows_id, selected_routing_no) {
	var prodHisData;
	
	if(selected_rows_id.length == '0') {
		fnMessageModalAlert("Notification(QM)", "체크 된 데이터가 없습니다.");
		return;
	}

	var page_url = "/frontend/prod/pop_prod_his_select"
		 + "?pordno_pop=" + encodeURIComponent(selected_rows_id.substring(0,10) + "0010")
	     + "&routing_no=" + encodeURIComponent(selected_routing_no);
	$.ajax({
		url : page_url,
		type : "POST",
		async : false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				prodHisData = data.rows;
			} else {
				fnMessageModalAlert("Notification(QM)", "선택된 생산지시오더 시리얼등록을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(QM)", "선택된 생산지시오더 시리얼등록 중 오류가 발생하였습니다.");
		},
		complete : function() {
		}
	});

	if(prodHisData.length == 0) {
		$("#inspStart").show();
		$("#inspPuase").hide();
		$("#inspRestart").hide();
		$("#inspEnd").hide();
		$("#insp_txt").hide();
		$("#btn_process_yn").hide();

	} else if(prodHisData[prodHisData.length -1].start_dt_tm.length >0 ){
		$("#inspStart").hide();
		$("#inspPuase").show();
		$("#inspRestart").hide();
		$("#inspEnd").show();
		$("#insp_txt").hide();
		$("#btn_process_yn").hide();

	}else if(prodHisData[prodHisData.length -1].end_dt_tm.length >0 ){
		$("#inspStart").hide();
		$("#inspPuase").hide();
		$("#inspRestart").hide();
		$("#inspEnd").hide();
		$("#insp_txt").show();
		$("#btn_process_yn").show();

	} else if(prodHisData[prodHisData.length -1].pause_start_dt_tm.length >0 ){
		$("#inspStart").hide();
		$("#inspPuase").hide();
		$("#inspRestart").show();
		$("#inspEnd").hide();
		$("#insp_txt").hide();
		$("#btn_process_yn").hide();

	} else if(prodHisData[prodHisData.length -1].pause_end_dt_tm.length >0 ){
		$("#inspStart").hide();
		$("#inspPuase").show();
		$("#inspRestart").hide();
		$("#inspEnd").show();
		$("#insp_txt").hide();
		$("#btn_process_yn").hide();

	}
	
	var s_last_sts = $("#grid_role").getRowData(selected_rows_id).last_sts;
	if(s_last_sts == 'L5') {
		$("#inspStart").hide();
		$("#inspPuase").hide();
		$("#inspRestart").hide();
		$("#inspEnd").hide();
		$("#insp_txt").show();
		$("#btn_process_yn").show();
	}
}
	
var s_pass = '';
var s_transfer_yn = '';

function modal_open(pass, transfer_yn) {
	s_pass = pass;       
	s_transfer_yn = transfer_yn;
	var selected_rows_id = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
	if(selected_rows_id.length == 0) {
		fnMessageModalAlert("Notification(QM)", "체크 된 데이터가 없습니다.");
		return;
	}
	getToStrList(pass);
	$("#modal_detail").modal('show');
}

function modal_detail_close() {
	$("#modal_detail").modal('hide');
}
	
function process_cancel(){
	var pordno;
	var ref_doc_no;
	var mblnr;     
	var mjahr;     
	var sudat;
	
	var auart;
	var transfer_yn;
	var pordno_seq;
	var chk_cnt =0;
	var sap_send_yn;
	
	$("#grid_role").jqGrid('setGridParam', {cellEdit: false});
	
	var gridDataArr = $('#grid_role').jqGrid('getRowData');
	var keyArr = $('#grid_role').jqGrid('getDataIDs');
			
	$("#grid_role").jqGrid('setGridParam', {cellEdit: true});
	
	for (var i = 0; i < keyArr.length; i++) { //row id수만큼 실행           
    	if($("input:checkbox[id='jqg_grid_role_"+keyArr[i]+"']").is(":checked")){ //checkbox checked 여부 판단
    		var rowdata = $("#grid_role").getRowData(keyArr[i]); // 해당 id의 row 데이터를 가져옴
    		    		
    	/* 	if($("#grid_role").getRowData(keyArr[i]).sap_send_yn == "N")		//처리날짜는 8자리이므로 5로 조건..처리안하면 값없음..
    		{
   				fnMessageModalAlert("Notification(QM)", "SAP 전송 미처리 데이터가 선택되었습니다.");
    	 		return;
    		} */
			pordno = $("#grid_role").getRowData(keyArr[i]).pordno;
    		ref_doc_no = $("#grid_role").getRowData(keyArr[i]).ref_doc_no;
    		mblnr = $("#grid_role").getRowData(keyArr[i]).mblnr;
    		mjahr = $("#grid_role").getRowData(keyArr[i]).mjahr;
    		sudat = $("#grid_role").getRowData(keyArr[i]).sudat;
    		
    		auart = $("#grid_role").getRowData(keyArr[i]).auart;
    		pordno_seq = $("#grid_role").getRowData(keyArr[i]).pordno_seq;
    		
    		sap_send_yn = $("#grid_role").getRowData(keyArr[i]).sap_send_yn;
    		
    		chk_cnt = chk_cnt + 1;
	    }
	}
	/*********************그리드 체크 확인 : Start*********************/
	if(chk_cnt == 0)	{
		fnMessageModalAlert("Notification(QM)", "체크 된 데이터가 없습니다.");
 		return;
	}
	
	if(chk_cnt != 1)	{
		fnMessageModalAlert("Notification(QM)", "한개의 항목만 체크해주세요.");
 		return;
	}
	/*********************그리드 체크 확인 : End*********************/
		
	var params_data = new Array() ;
	var iv_materialdocument = [];
	var iv_matdocumentyear = [];
	var iv_goodsmvt_pstng_date = [];
	var iv_documentheader_text = [];
	
	var data = new Object();
					
	data.iv_materialdocument = mblnr;
	data.iv_matdocumentyear = mjahr;
	data.iv_goodsmvt_pstng_date = sudat;
	data.iv_documentheader_text ="";
	
	params_data.push(data);
	
	var jstr = JSON.stringify(params_data);
	var s_id = $('#grid_role').jqGrid('getGridParam', 'selrow');
	var s_rowData = $("#grid_role").getRowData(s_id);
	
	if(sap_send_yn=='N') {
		transfer_yn = 'N';
	} else {
		transfer_yn = 'Y';
	}
	var page_url = "/frontend/qm/inspection_delete";
	var postData = 'jstr=' + encodeURIComponent(jstr)
		postData += '&pordno=' + encodeURIComponent(pordno)
		postData += '&pordno_seq=' + encodeURIComponent(pordno_seq)
		postData += '&func_name=' + encodeURIComponent("ZMMFM_GOODSMVT_CANCEL")
		postData += "&gubun=" + encodeURIComponent(transfer_yn);
		
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    async : false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		if(transfer_yn == "Y") {
		    		if(data.rows[0].ev_status == 'E') {
		    			fnMessageModalAlert("Notification(QM)", "해당 실적을 삭제하는데 에러가 발생했습니다. <br/> ***sap 전송 결과*** <br/>ev_status : " 
				    			+ data.rows[0].ev_status	+ "<br/>e_message : "+ data.rows[0].ev_message);
		    		} else if(data.rows[0].ev_status == 'S') {
		    			fnMessageModalAlert("Notification(QM)", "해당 실적을 삭제완료했습니다. <br/> ***sap 전송 결과*** <br/>ev_status : " 
		    					+ data.rows[0].ev_status	+ "<br/>e_message : "+ data.rows[0].ev_message);	
		    		}
	    		} else {
	    			fnMessageModalAlert("Notification(QM)", "해당 실적을 취소했습니다.");
	    		}
	    	} else {
	    		fnMessageModalAlert("Notification(HUB)", "해당 실적을 취소하는데 에러가 발생했습니다.");	
	    	}
	    	fnSearchInspGrid();
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(HUB)", "해당 실적을 취소하는데 에러가 발생했습니다.");	
	    },
	    complete: function() {
	    }
	});
}
	
function cancel_open() {
	fnMessageModalConfirm("Notification(QM)", "해당 검사내역을 취소하시겠습니까?", function(result){
		if(result) {
			process_cancel();	
		}
	});
}

function insp_start() {
	console.log("작업시작");
	fnWorkerAdd();
	//lastStsUpdate('L2');	//검사자 업데이트할때 처리함...
	fnSearchInspGrid();
}

function insp_puase() {
	fnWorkChnStat('pause_start');
	lastStsUpdate('L3');
	fnSearchInspGrid();
}

function insp_restart() {
	fnWorkChnStat('pause_end');
	lastStsUpdate('L4');
	fnSearchInspGrid();
}

function insp_end() {
	grade_chk();
	lastStsUpdate('L5');
	fnSearchInspGrid();
}

function fnWorkChnStat(flag) {
//	 	console.log('fnWorkChnStat(', flag, ')');
	var sel_key_arr = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
// 	console.log(sel_key_arr.length);
	if (sel_key_arr.length ==0 ) {
		fnMessageModalAlert("Notification(ProdConfirm)", "선택된 생산지시오더 없습니다.");
		return;
	} else if(sel_key_arr.length != 1){
		fnMessageModalAlert("Notification(ProdConfirm)", "1개 내역씩 처리 가능합니다.");
		return;
	}
	
	$("#grid_role").getRowData(sel_key_arr[0]);
	var i_rowData = $("#grid_role").getRowData(sel_key_arr[0]);
	var s_pordno_pop = i_rowData.pordno + "0010";
	var s_routing_no = i_rowData.routing_no; 
	var page_url = '/frontend/prod/workChangeStatus';
	var postData = 'pordno_pop=' + encodeURIComponent(s_pordno_pop)
				 + '&routing_no=' + encodeURIComponent(s_routing_no);
	var pdsts = 'p2';
	var success_msg = '';
	var fail_msg = '';
	if( flag=='end' ) {	// 작업종료
		pdsts = 'p6';
		success_msg = '선택된 지시가 검사완료 성공했습니다.';
		fail_msg = '선택된 지시가 검사완료 실패했습니다.';
	} else if( flag=='pause_start' ){	// 비가동 시작
		pdsts = 'p4';
		success_msg = '선택된 지시가 검사보류 시작에 성공했습니다.';
		fail_msg = '선택된 지시가 검사보류 시작에 실패했습니다.';
	} else if( flag=='pause_end' ){	// 비가동 종료
		pdsts = 'p5';
		success_msg = '선택된 지시가 검사재시작에 성공했습니다.';
		fail_msg = '선택된 지시가 검사재시작에 실패했습니다.';
	} else if( flag=='start'){	// 작업시작
		pdsts = 'p3';
		success_msg = '선택된 지시가 검사시작 성공했습니다.';
		fail_msg = '선택된 지시가 검사시작 실패했습니다.';
	}
	postData += '&pdsts=' + pdsts;
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async:false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnMessageModalAlert("Notification(ProdConfirm)", data.rtn_msg);
				if(data.status_change_yn == 'N') {
					console.log("데이터 변동 없음..")
					return 'N';
				}
				/********************생산 완료 시 sap로 실적 전송 : Start*******************/
				if(pdsts == 'p6') {
					if(prodEndChk()) {					//routing_header_master의 routng_plast_gubun 값... 현재 라우팅이 생산종료 단계인지 체크
						console.log("생산실적처리");			 	
						toSapProdIn();					//생산입고 rfc (ZIFFM_MES_PP008) 실행
						toSapProdData();				//생산실적 rfc (ZIFFM_MES_PP006) 실행
					}
					var t1Chk_rtn = t1Chk(i_rowData.pordno); 
					if(t1Chk_rtn.length > 1) 	{	// 다음 공정이 T1 인지 체크..T1이면 최종검사테이블 insert
						console.log("toMesLastInspec();    // 최종검사!!!!");
						toMesLastInspec(i_rowData.pordno, t1Chk_rtn);	
					}	
				}
				/********************생산 완료 시 sap로 실적 전송 : End  *******************/
					fnMessageModalAlert("Notification(ProdConfirm)", success_msg);
			} else {
				fnMessageModalAlert("Notification(ProdConfirm)", fail_msg);
				return 'N';
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(ProdConfirm)", fail_msg);
			return 'N';
		},
		complete : function() {}
	});
		
// 		fnSearchInspGrid();
	$("#grade_mng").modal('hide');	
	$("#modal_detail").modal('hide');
}
	
function fnWorkerAdd() {
	var sel_key_arr = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
	var i_rowData = $("#grid_role").getRowData(sel_key_arr[0]);
	var s_pordno_pop = i_rowData.pordno + "0010";
	var s_routing_no = i_rowData.routing_no; 
	var s_pordno_seq = i_rowData.pordno_seq;
	var s_pordno = i_rowData.pordno;		
	var s_zgrade = i_rowData.zgrade;
	var rtn = "";
	var postData = $("#frm_worker_add").serializeArray();
	var page_url = "/frontend/prod/worker_update";
	var postData = "pordno_pop=" + encodeURIComponent(s_pordno_pop);
		postData += "&routing_no=" + encodeURIComponent(s_routing_no);
	// 작업자 등록
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async:false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				if ( data.returnMsg=='Already registered' ){
					rtn  = fnWorkChnStat('start');
				} else {
					rtn  = fnWorkChnStat('start');
				}
				//검사자, 검사진행상태, zgrade 업데이트
				if(rtn != 'N') {
					fnLastInspWorkerAdd(s_pordno, s_pordno_seq, s_zgrade);
				}
			} else {
				fnMessageModalAlert("Notification(fnWorkerAdd)", "작업자 등록에 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(fnWorkerAdd)", "작업자 등록에 실패했습니다.");
		},
		complete : function() {
			fwa_member_emp_no = '';
			fwa_member_nm= '';
		}
	});
}
		
function fnProdFaultConf() {
	var sel_key_arr = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
	var i_rowData = $("#grid_role").getRowData(sel_key_arr[0]);
	var s_pordno_pop = i_rowData.pordno + "0010";
	var s_routing_no = i_rowData.routing_no;
	
	var DataArr = [];
	var jsonStr = JSON.stringify(DataArr);
	/********************* 데이터 insert 및 rfc 전송 : Start*********************/
	var page_url = "/frontend/prod/fnProdFaultConf";
	var postData = 'jsonStr=' + encodeURIComponent(jsonStr);
		postData += '&pordno_pop=' + encodeURIComponent(s_pordno_pop);
		postData += '&routing_no=' + encodeURIComponent(s_routing_no);
		postData += '&t_gubun=' + encodeURIComponent("tw");
	$.ajax({
	    url: page_url,
	    data: postData,
	    async : false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
// 	    	console.log(data);
	    	if(data.status == "200") {
	    		fnMessageModalAlert("Notification(MES)", "정보를 저장했습니다.");	
	    	} else {
	    		fnMessageModalAlert("Notification(MES)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(MES)", "정보를 저장하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	selected_pordno='';
			fnSearchMasterCodeGrid();
	    }
	});
	$("#modal_detail_serial_add").modal('hide');
	$("#grid_req_sernr").modal('hide');
	$("#fault_mng").modal('hide');
	/********************* 데이터 insert 및 rfc 전송 : End*********************/
}
	
function toSapProdIn() {
// 	console.log('toSapProdIn()');
	var sel_key_arr = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
	var i_rowData = $("#grid_role").getRowData(sel_key_arr[0]);
	var s_pordno_pop = i_rowData.pordno + "0010";
	var s_routing_no = i_rowData.routing_no;
	
	var page_url = "/sap_master/ziffm_mes_pp008";			
	var postData = "funcName=" + encodeURIComponent("ZIFFM_MES_PP008");	
		postData +=	'&pordno=' + encodeURIComponent(i_rowData.pordno);
		postData +=	'&pordno_pop=' + encodeURIComponent(s_pordno_pop);
		postData +=	'&routing_no=' + encodeURIComponent(s_routing_no);
// 		console.log(i_rowData.pordno, s_pordno_pop, s_routing_no);
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200"){
			} else {
				fnMessageModalAlert("Notification(MES)",	"SAP 생산실적 전송을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "SAP 생산실적 전송을 실패했습니다.");
		},
		complete : function() {}
	});
}

function toSapProdData() {
// 	console.log('toSapProdData()');	
	
	var sel_key_arr = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
	var i_rowData = $("#grid_role").getRowData(sel_key_arr[0]);
	var s_pordno_pop = i_rowData.pordno + "0010";
	var s_routing_no = i_rowData.routing_no;
	
	var page_url = "/sap_master/ziffm_mes_pp006";			
	var postData = "funcName=" + encodeURIComponent("ZIFFM_MES_PP006");	
		postData +=	'&pordno=' + encodeURIComponent(i_rowData.pordno);
		postData +=	'&pordno_pop=' + encodeURIComponent(s_pordno_pop);
		postData +=	'&routing_no=' + encodeURIComponent(i_rowData.routing_no);
		postData +=	'&dept_cd=' + encodeURIComponent(i_rowData.dept_cd);
		postData +=	'&wkctr=' + encodeURIComponent(i_rowData.wkctr);
	
// 		console.log(i_rowData.pordno, s_pordno_pop, i_rowData.routing_no, i_rowData.dept_cd, i_rowData.wkctr);
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {	
			} else {
				fnMessageModalAlert("Notification(MES)", "SAP 생산실적 전송을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "SAP 생산실적 전송을 실패했습니다.");
		},
		complete : function() {}
	});
}
	
function prodEndChk() {
// 	console.log('prodEndChk()');
	var sel_key_arr = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
	var i_rowData = $("#grid_role").getRowData(sel_key_arr[0]);
	var s_pordno_pop = i_rowData.pordno + "0010";
	var s_routing_no = i_rowData.routing_no;
	var page_url = "/frontend/prod/prod_end_chk";			
	var postData =	'routing_no=' + encodeURIComponent(s_routing_no);
	var chk_result;
	
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				chk_result = data.result;
			} else {
				fnMessageModalAlert("Notification(MES)",	"현재 실적의 라우팅 정보에서 생산종료확인 데이터를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)", "현재 실적의 라우팅 정보에서 생산종료확인 데이터를 가져오지 못했습니다.");
		},
		complete : function() {}
	});
	
	if(chk_result == 'Y') {
		return true;
	} else {
		return false;
	} 
}
	
function t1Chk(pordno) {
	var res_data;
	var rtn_data = "";

	//T1이 공정 중간에 있을때..
	var page_url = "/frontend/prod/pop_prod_select"
	var postData = "pordno=" + encodeURIComponent(pordno);
	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
				res_data = data.rows;
			} else {
				fnMessageModalAlert("Notification(MES)",	"현재 실적의 공정관리테이블의 데이터를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(MES)",	"현재 실적의 공정관리테이블의 데이터를 가져오지 못했습니다.");
		},
		complete : function() {}
	});
// 	console.log(res_data);
	for(var i=0 ;i<res_data.length; i++) {
		if(res_data[i].routing_code == 'T1' && i!=0) {
			if(res_data[i-1].pdsts == "p6" && res_data[i].pdsts != "p6") {
				rtn_data =  res_data[i].routing_no;
				break;
			} 
		}
	}
// 	console.log("rtn_data :: " + rtn_data);
	return rtn_data;
}

function toMesLastInspec(pordno, t1_routing_no) {
	var page_url = "/frontend/prod/lastInspec_insert";			
	var postData = 'pordno=' + encodeURIComponent(pordno);
		postData += '&routing_no=' + encodeURIComponent(t1_routing_no);

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
			} else {
				fnMessageModalAlert("Notification(QM)",	"최종검사 데이터 생성을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(QM)",	"최종검사 데이터 생성을 실패했습니다.");
		},
		complete : function() {
		}
	});
}
	
//검사자, 검사진행상태, zgrade 업데이트
function fnLastInspWorkerAdd(s_pordno, s_pordno_seq, s_zgrade) {
	var page_url = "/frontend/prod/fnLastInspWorkerAdd";			
	var postData = "pordno=" + encodeURIComponent(s_pordno);
		postData += "&pordno_seq=" + encodeURIComponent(s_pordno_seq)
		postData += "&zgrade=" + encodeURIComponent(s_zgrade);

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
			} else {
				fnMessageModalAlert("Notification(QM)",	"검사자 등록을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(QM)",	"검사자 등록을 실패했습니다.");
		},
		complete : function() {}
	});
}
	
function lastStsUpdate(s_last_sts) {
	var sel_key_arr = $("#grid_role").jqGrid('getGridParam', 'selarrrow');		 
	var i_rowData = $("#grid_role").getRowData(sel_key_arr[0]);
	var s_pordno = i_rowData.pordno;		
	var s_pordno_seq = i_rowData.pordno_seq;
	
	var page_url = "/frontend/prod/lastStsUpdate";			
	var postData = "pordno=" + encodeURIComponent(s_pordno);
		postData += "&pordno_seq=" + encodeURIComponent(s_pordno_seq)
		postData += "&last_sts=" + encodeURIComponent(s_last_sts);

	$.ajax({
		url : page_url,
		data : postData,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200") {
			} else {
				fnMessageModalAlert("Notification(QM)",	"검사자 등록을 실패했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Notification(QM)",	"검사자 등록을 실패했습니다.");
		},
		complete : function() {}
	});
}
	
function initOptions(obj) {
    $(obj)
        .find('option')
        .remove()
        .end()
        .val();
}
	
var step1Val = '';
var step2Val = '';
var step3Val = '';
var step4Val = '';
function changeStep(selVal, step) {
// 	console.log('changeStep(',selVal,',',step,')');
	var compName = '';
	if( step=='step1' ) {
		initOptions($('#sel_step2'));
		initOptions($('#sel_step3'));
		initOptions($('#sel_step4'));
		step1Val = selVal;
		compName = 'sel_step2';
	} else if( step=='step2' ) {
		initOptions($('#sel_step3'));
		initOptions($('#sel_step4'));
		step2Val = selVal;
		compName = 'sel_step3';
	} else if( step=='step3' ) {
		initOptions($('#sel_step4'));
		step3Val = selVal;
		compName = 'sel_step4';
	} 
		
	var page_url = "/frontend/scm/issue_getSteps";
	var params = "";
	if( step=='step1' ) {
		params += "gr_code=" + encodeURIComponent(step1Val);
	} 
	if( step=='step2' ) {
		params += "gr_code=" + encodeURIComponent(step1Val);
		params += "&level1_code=" + encodeURIComponent(step2Val);
	}
	if( step=='step3' ) {
		params += "gr_code=" + encodeURIComponent(step1Val);
		params += "&level1_code=" + encodeURIComponent(step2Val);
		params += "&level2_code=" + encodeURIComponent(step3Val);
	}
		
	$.ajax({
	    url: page_url,
	    data: params,
	    async:false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$('#'+compName).append($('<option>', { 
				        text : '-'
				    }));
					$.each(data.rows, function (i, item) {
						if( step=='step1' ) {
							$('#'+compName).append($('<option>', { 
						        value: item.level1_code,
						        text : item.level1_name 
						    }));
						} else if( step=='step2' ) {
							$('#'+compName).append($('<option>', { 
								value: item.level2_code,
						        text : item.level2_name 
						    }));
						} else if( step=='step3' ) {
							$('#'+compName).append($('<option>', { 
								value: item.level3_code,
						        text : item.level3_name 
						    }));
						} 
					});
				}
	    	} else {
	    		fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}
		
function makeSelStep1() {
// 	console.log('makeSelStep1()');
	
	var sel_key_arr = $("#grid_role").jqGrid('getGridParam', 'selarrrow');		 
	var i_dept_cd = $("#grid_role").getRowData(sel_key_arr[0]).dept_cd;
	
	var page_url = "/frontend/scm/issue_getStep1";
	var postData = "dept_cd=" +  encodeURIComponent(i_dept_cd);
	
	$.ajax({
	    url: page_url,
	    data : postData,
	    async:false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$('#sel_step1').append($('<option>', { 
				        text : '-'
				    }));
					$.each(data.rows, function (i, item) {
						$('#sel_step1').append($('<option>', { 
					        value: item.gr_code,
					        text : item.gr_nm 
					    }));
					});
				}
	    	} else {
	    		fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}

function input_code() {
	
	var s_id = $('#grid_role').jqGrid('getGridParam', 'selrow');
	
	var sel_step1 = $("#sel_step1").val();
	var sel_step2 = $("#sel_step2").val();
	var sel_step3 = $("#sel_step3").val();
	var sel_step4 = $("#sel_step4").val();
	
	var sel_step1_t = $("#sel_step1 option:selected").text();
	var sel_step2_t = $("#sel_step2 option:selected").text();
	var sel_step3_t = $("#sel_step3 option:selected").text();
	var sel_step4_t = $("#sel_step4 option:selected").text();
	
	if(s_id == null) {
		fnMessageModalAlert("Notification(MES)", "불량코드가 입력 될 제품불량내역을 선택해 주세요.");
		return;
	}
	
	if(sel_step4_t == '' || sel_step4_t == '-') {
		fnMessageModalAlert("Notification(MES)", "lv.03 까지 불량내역을 지정해주세요.");
		return;
	}
	$('#grid_role').jqGrid('setCell', s_id, 'issue_code_nm', sel_step4_t);
	$('#grid_role').jqGrid('setCell', s_id, 'issue_code', sel_step4);
}
	
function success_process() {
	var s_id = $('#grid_role').jqGrid('getGridParam', 'selrow');
	var s_rowData = $("#grid_role").getRowData(s_id);
	if(s_rowData.transfer_routing == s_rowData.routing_no) {
		$('#s_to').show();
		$('#s_to_msg').hide();
	} else {
		$('#s_to').hide();
		$('#s_to_msg').show();
	}
	
   	modal_open('p9','N');
}
	
function fail_process() {
	var s_id = $('#grid_role').jqGrid('getGridParam', 'selrow');
	var s_rowData = $("#grid_role").getRowData(s_id);

	if(s_rowData.issue_code_nm.length == 0) {
		fnMessageModalAlert("Notification(QM)", "선택 내역에 불량코드가 입력되지 않았습니다.<br/>불량코드 입력 후 불합격 처리를 진행해주세요.");
		return;
	}
	
	if(s_rowData.transfer_routing == s_rowData.routing_no) {
		$('#s_to').show();
		$('#s_to_msg').hide();
	} else {
		$('#s_to').hide();
		$('#s_to_msg').show();
	}
	
    modal_open('p10','N');
}
	
function SaveInspLot() {
	var rowData = $("#grid_role").getRowData($("#grid_role").getGridParam('selrow'));
	var page_url = "/frontend/qm/fnSaveInspLot";
	var postData = 'werks=' + encodeURIComponent(rowData.dept_cd);
		postData += '&lgort=' + encodeURIComponent(rowData.lgort);
		postData += '&t_gubun=' + encodeURIComponent("tp");
		postData += '&matnr=' + encodeURIComponent(rowData.itnbr);
		postData += '&maktx=' + encodeURIComponent(rowData.maktx);
		postData += '&meins=' + encodeURIComponent(rowData.meins);
		postData += '&bdmng=' + encodeURIComponent(rowData.pdqty);
		postData += '&insts=' + encodeURIComponent("ST");
	
	$.ajax({
	    url: page_url,
	    data: postData,
	    async:false,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    	} else {
	    		fnMessageModalAlert("Notification(QM)", "검사 Lot 생성을 실패했습니다.");
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(QM)", "검사 Lot 생성을 실패했습니다.");	
	    },
	    complete: function() {
	    	
	    }
	});
}
	
function from_loc(s_plnt, s_lgort) {
	var rtn = "";
	var page_url = "/frontend/scm/mes_stock_tbl_select"
	var postData = 'dept_cd=' + encodeURIComponent(s_plnt);
		postData += '&menu_code=' + encodeURIComponent('mst02');
		postData += '&fromto_gubun=' + encodeURIComponent('from');
		postData += '&lgort=' + encodeURIComponent(s_lgort);
	
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    async:false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				rtn = data.rows[0].stock_code;
	    	} else {
	    		fnMessageModalAlert("Notification(QM)", "창고코드를 가져오는데 실패했습니다.");
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(QM)", "창고코드를 가져오는데 실패했습니다.");	
	    },
	    complete: function() {
	    	
	    }
	});
	return rtn;
}		
	
function grade_chk() {

	$("#grid_grade_mng").jqGrid('clearGridData');
	var selKey = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
	var pordnos = "";
	var r_data = [];
	for(var i=0 ; i<selKey.length; i++) {
		var selectedData = $("#grid_role").getRowData(selKey[i]);
		if(prodEndChk(selectedData.routing_no)) {//routing_header_master의 routng_plast_gubun 값... 현재 라우팅이 생산종료 단계인지 체크
			pordnos = pordnos + selectedData.pordno + ",";
		}
	}
	pordnos = pordnos.substring(0, pordnos.length-1);
	
	var page_url = "/frontend/mes/grade_matnr_chk";
	var postData = "&pordnos=" + encodeURIComponent(pordnos);
	$.ajax({
		url: page_url,
		data : postData,
		type: "POST",
		async : false,
		success:function(data, textStatus, jqXHR){
			if(data.status == "200") {
				r_data = data.rows;
			} else {
				fnMessageModalAlert("Fail", "데이터를 불러오는데 실패하였습니다.");	
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("Fail", "데이터를 불러오는데 실패하였습니다.");	
		},
		complete: function() {}
	});

	for(var i=0 ; i<r_data.length; i++) {
		var tmpObj = {};
		
		tmpObj.pordno = r_data[i].pordno;
		tmpObj.project_no = r_data[i].project_no;
		tmpObj.matnr = r_data[i].matnr;
		tmpObj.maktx = r_data[i].maktx;
		tmpObj.wrkst = r_data[i].wrkst;
		tmpObj.kzumw = r_data[i].kzumw;
		tmpObj.lgort = r_data[i].lgort;
		$('#grid_grade_mng').addRowData( i, tmpObj, 'last');
	}
	if(r_data.length > 0) {
		$("#grade_mng").modal('show');	
	} else {
		//작업종료 진행
		fnWorkChnStat('end');
	}
}
	
function fnLoadGradeMngGrid() {
//  	console.log('fnLoadWorkerAddGrid()');
	
	$("#grid_grade_mng").jqGrid({
		datatype : "json",
		colNames : ['P/O', '시리얼번호','제품명','제품내역', 'Spec.','등급창고여부', '저장창고'],
		colModel : [ 
		    {name : 'pordno', index : 'member_emp_no', width : 100, sorttype : "text", sortable : true}, 
			{name : 'project_no', index : 'member_id', width : 100, sorttype : "text", sortable : true}, 
			{name : 'matnr', index : 'member_nm', width : 100, sorttype : "text", sortable : true}, 
			{name : 'maktx', index : 'member_nm', width : 190, sorttype : "text", sortable : true}, 
			{name : 'wrkst', index : 'member_nm', width : 190, sorttype : "text", sortable : true}, 
			{name : 'kzumw', index : 'member_nm', width : 100, sorttype : "text", sortable : true}, 
			{name : 'lgort', index : 'dept_cd', width : 100, sorttype : "text", sortable : true} 
			],
			
		rowNum : 1000,
		viewrecords : true,
		autowidth : true,
		shrinkToFit : true,
		multiselect : false,
		height : 270,
		altRows : true,
		rownumbers : true,
		rownumWidth : 25,
		autoencode : true,
		loadonce : true,
		sortable : true,
		onCellSelect : function(rowid, selected) {
			if ( rowid != null && selected ) { 
				if(selected == '7') {
					var selGridData = $("#grid_grade_mng").getRowData(rowid);
					$("#grade_loc_matnr_1").val(selGridData.matnr);
					
					$("#grade_loc_add_1").modal('show');
				}	
			}
		},
		loadComplete : function() {}
	});
}
	
function locInputMng_1() {
//  	console.log('sernrInputMng()');
	var gridRowData = $("#grid_grade_mng").getRowData($("#grid_grade_mng").getGridParam('selrow'));
		
	gridRowData.lgort = $('#grade_loc_1').val();
	
	$("#grid_grade_mng").setRowData($("#grid_grade_mng").getGridParam('selrow'), gridRowData, {});
	$("#grade_loc_add_1").modal('hide');
}

function work_end_proc() {
	var selKey = $("#grid_grade_mng").jqGrid('getGridParam', 'selarrrow');
	var selGridData = $("#grid_grade_mng").getRowData();
	
	for(var i=0 ;i<selGridData.length; i++) {
		if(selGridData[i].lgort.length == 0) {
			fnMessageModalAlert("Notification(MES)", "조회내역의 저장위치 항목에 데이터가 없습니다.<br/>해당 셀을 클릭해 데이터를 입력해주세요.");
	 		return;
		}
	}
	//lgort업데이트
	grade_loc_update();
}

function grade_loc_update(){
	var selGridData = $("#grid_grade_mng").getRowData();
	var page_url = "/frontend/mes/grade_loc_update";
	var postData = "&params=" + encodeURIComponent(JSON.stringify(selGridData));

	$.ajax({
		url: page_url,
		data : postData,
		async : false,
		type: "POST",
		success:function(data, textStatus, jqXHR){
			if(data.status == "200") {
				fnWorkChnStat('end');
			} else {
				fnMessageModalAlert("Fail", "데이터를 불러오는데 실패하였습니다.");	
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("Fail", "데이터를 불러오는데 실패하였습니다.");	
		},
		complete: function() {}
	});
}

function selfInspModal() {
//  	console.log('selfInspModal()');
 	//grid_role
	var selKey = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
//  	console.log(selKey);
	selfDetail = [];
	if ( selKey.length==0 ) {
		fnMessageModalAlert("Warning", "검사내역에서 한건의 데이터를 선택하여야 합니다.");
		return;
	} else if ( selKey.length>1 ) {
		fnMessageModalAlert("Warning", "검사내역에서 한건의 데이터만 선택하여야 합니다.");
		return;
	}
	
	var selectData = $("#grid_role").getRowData(selKey[0]);	// auart : ZP02, ZP04
	if( selectData.itnbr=='' || selectData.itnbr=='재고' ) {
		fnMessageModalAlert("Warning", "해당 공정은 자재내역이 조회되지 않아 자주검사가 불가능 합니다.");
		return;
	} else {
		var headerCheck = loadSelfInspHeader();
		if( headerCheck ) {
			makeSelectBox();
		 	loadSelfInspDetail();
			$("#pono").text("( 지시번호 : " + selectData.pordno + " )");	// 2018-01-24 : iris add
			$("#modal_selfInsp").modal('show');
		 	showSelfInspGrid();
			setTimeout(function(){
				w2ui.grid_selfInsp_header.resize();
				w2ui.grid_selfInsp_header.refresh();
				$.each(selfDetail, function(idx, opt){
					w2ui['grid_' + opt].resize();
					w2ui['grid_' + opt].refresh();
				});
			}, 200);		
		} else {
			return;
		}
	}
}

function loadSelfInspHeader() {
// 	console.log('loadSelfInspHeader()');
	var selData = $("#grid_role").jqGrid("getRowData", $("#grid_role").getGridParam("selrow"));
// 	console.log(selData);
	var page_url = "/frontend/mes/select_selfinsp_header"
				+ "?dept_cd=" + encodeURIComponent(selData.dept_cd)
				+ "&pordno=" + encodeURIComponent(selData.pordno)
				+ "&matnr=" + encodeURIComponent(selData.itnbr);
	var returnVal = false;
	var rowArr = [];
	w2ui.grid_selfInsp_header.lock('loading...', true);
	$.ajax({
		url : page_url,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200" ) {
				if( (data.rows).length>0 ) {
					rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
						if( row.siheader_seq=='1' )
							row.item_value = row.simaster_gr_nm;
					});
					w2ui.grid_selfInsp_header.records = rowArr;
					w2ui.grid_selfInsp_header.total = rowArr.length;
					returnVal = true;
				} else {
					fnMessageModalAlert("Warning", "해당 공정(" + selData.pordno + ") 에 해당하는 자주검사 정보가 없습니다.");
				}
			} else if(data.status == "200" && (data.rows).length==0 ) {
				fnMessageModalAlert("Check", "해당 데이터는 자주검사 대상이 아닙니다.");
			}else {
				fnMessageModalAlert("Fail",	"정보를 가져오는 중 오류가 발생하였습니다.");
			}
			w2ui.grid_selfInsp_header.refresh();
			w2ui.grid_selfInsp_header.unlock();
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "정보를 가져오는 중 오류가 발생하였습니다.");
		},
		complete : function() {}
	});
	return returnVal;
}

function showSelfInspGrid() {
// 	console.log('showSelfInspGrid()');
// 	console.log(selfDetail);
	$.each(selfDetail, function(idx, opt){
		$("#grid_" + opt + "_area").hide();
	});
	var code = $("#self_insp_routing").val().toLowerCase();
	if( code==null || code=='-' ) {	//전체
		$.each(selfDetail, function(idx, opt){
			$("#grid_" + opt + "_area").show();
			w2ui['grid_' + opt].resize();
			w2ui['grid_' + opt].refresh();
		});
	} else {
		$("#grid_" + code + "_area").show();
		w2ui['grid_' + code].resize();
		w2ui['grid_' + code].refresh();
	}
}

var selfDetail = [];
function makeSelectBox() {
// 	console.log('makeSelectBox()');
	var selData = $("#grid_role").jqGrid("getRowData", $("#grid_role").getGridParam("selrow"));
	
	$("#self_insp_routing").empty();
	var selectHeader = w2ui.grid_selfInsp_header.records[0];
	var page_url = "";
	if( selData.dept_cd=='1110' ) {
		page_url = "/frontend/mes/select_selfInspCode_1110"
				 + "?ref1=" + encodeURIComponent(selectHeader.simaster_gr_no);
	} else {
		page_url = "/frontend/mes/select_selfInspCode_1210"
			 	 + "?ref1=" +  + encodeURIComponent(selData.dept_cd);		
	}
	$.ajax({
	    url: page_url,
	    type: "POST",
	    async : false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
				if( (data.rows).length>0 ){
					$("#self_insp_routing").append($('<option>', {
						value: '-', 
				        text : '전체'
				    }));
					$.each(data.rows, function (i, item) {
						$("#self_insp_routing").append($('<option>', { 
					        value: item.code,
					        text : item.code_nm
					    }));
						selfDetail.push((item.code).toLowerCase());
					});
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

function loadSelfInspDetail() {
// 	console.log('loadSelfInspDetail()');
// 	var selData = w2ui.grid_group.get(w2ui.grid_group.getSelection()[0]);
	var selData = $("#grid_role").jqGrid("getRowData", $("#grid_role").getGridParam("selrow"));
	if( selData.dept_cd=="1110" ) {
		$("#1110").show(); 
		$("#1210").hide(); 
	} else {
		$("#1110").hide(); 
		$("#1210").show();
	}
	var headerData = w2ui.grid_selfInsp_header.get(1);
	var simaster_gr_no = headerData.simaster_gr_no;
	var page_url = "/frontend/mes/select_selfinsp_detail"
				+ "?dept_cd=" + encodeURIComponent(selData.dept_cd)
				+ "&pordno=" + encodeURIComponent(selData.pordno)
				+ "&use_yn=" + encodeURIComponent("Y")
				+ "&simaster_gr_no=" + encodeURIComponent(simaster_gr_no);

	var detailObj = {};
	$.each(selfDetail, function(idx, code){
		w2ui['grid_' + code].lock('loading...', true);
	});

	$.ajax({
		url : page_url,
		async : false,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if(data.status == "200" && (data.rows).length>0 ) {
				$.each(data.rows, function(idx, row){
					if( row.insp_state=='' || row.insp_state==undefined )
						row.insp_state = 'i2';
					var subCode = '';
					if( selData.dept_cd=="1110" ) {
						subCode = (row.routing_code_sub).toLowerCase();
					} else {
						subCode = (row.routing_code).toLowerCase();
					}
					if( selData.dept_cd=="1110" || (selData.dept_cd=="1210" && (subCode=='p1'||subCode=='p2'||subCode=='p5'||subCode=='t1')) ) {
						if ( detailObj[subCode]==undefined ) {
							var tmpArr = [];
							tmpArr.push(row);
							detailObj[subCode] = tmpArr;
						} else {
							detailObj[subCode].push(row);				
						}
					}
				});
				
				$.each(detailObj, function(key, arr){
					$.each(arr, function(i, row){
						row.recid = i+1;
					});
					w2ui['grid_' + key].records = arr; 
					w2ui['grid_' + key].total = arr.length;
				});
			} 
			$.each(selfDetail, function(idx, code){
				w2ui['grid_' + code].refresh();
				w2ui['grid_' + code].unlock();
			});
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "정보를 가져오는 중 오류가 발생하였습니다.");
		},
		complete : function() {}
	});
}

function showSelfInspGrid() {
// 	console.log('showSelfInspGrid()');
	$.each(selfDetail, function(idx, opt){
		$("#grid_" + opt + "_area").hide();
	});
	var code = $("#self_insp_routing").val().toLowerCase();
	if( code==null || code=='-' ) {	//전체
		$.each(selfDetail, function(idx, opt){
			$("#grid_" + opt + "_area").show();
			w2ui['grid_' + opt].resize();
			w2ui['grid_' + opt].refresh();
		});
	} else {
		$("#grid_" + code + "_area").show();
		w2ui['grid_' + code].resize();
		w2ui['grid_' + code].refresh();
	}
}

//grid_selfInsp_header
function initGridSelgInspHeader() {
//	console.log('initGridSelgInspHeader()');
	$("#grid_selfInsp_header").w2grid({
		name : 'grid_selfInsp_header',
		header : '제품 이력카드',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'simaster_gr_no', hidden:true},
	        { field:'siheader_seq', caption:'', hidden:true},
	        { field:'siheader_code', caption:'모델명', hidden:true},
	        { field:'display_seq', caption:'seq', hidden:true},
	        { field:'main_name', caption:'대분류', size:'20%', style:'text-align:center'},
	        { field:'sub_name', caption:'소분류', size:'40%', style:'text-align:center'},
	        { field:'item_value', caption:'입력란', size:'40%', sortable:true, editable: { type: 'text'}}
	        ],
		records: [],
		recordHeight : 30,
		total : 0
	});
}

function init_grid_v12() {
// 	console.log('init_grid_v12()');
	$("#grid_v12").w2grid({
		name : 'grid_v12',
		header : 'DarkImage검사',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
				render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
						return replaceAll(getTodayDate(),'.','-');
					else
						return this.getCellValue(index, col_index);
				}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_v12.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_v12.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_v12.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_v12.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_v13() {
// 	console.log('init_grid_v13()');
	$("#grid_v13").w2grid({
		name : 'grid_v13',
		header : 'Calibration',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_v13.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_v13.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_v13.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_v13.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_v14() {
// 	console.log('init_grid_v14()');
	$("#grid_v14").w2grid({
		name : 'grid_v14',
		header : 'OSF',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_v14.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_v14.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_v14.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_v14.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_v17() {
// 	console.log('init_grid_v17()');
	$("#grid_v17").w2grid({
		name : 'grid_v17',
		header : '최종 검사',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_v17.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_v17.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_v17.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_v17.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_r10() {
// 	console.log('init_grid_r10()');
	$("#grid_r10").w2grid({
		name : 'grid_r10',
		header : '1차조립',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r10.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r10.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r10.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r10.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_r11() {
// 	console.log('init_grid_r11()');
	$("#grid_r11").w2grid({
		name : 'grid_r11',
		header : '공정 검사',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r11.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r11.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r11.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r11.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_r12() {
// 	console.log('init_grid_r12()');
	$("#grid_r12").w2grid({
		name : 'grid_r12',
		header : '최종 조립',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r12.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r12.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r12.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r12.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_r21() {
// 	console.log('init_grid_r21()');
	$("#grid_r21").w2grid({
		name : 'grid_r21',
		header : '공정 검사',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r21.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r21.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r21.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r21.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_r22() {
// 	console.log('init_grid_r22()');
	$("#grid_r22").w2grid({
		name : 'grid_r22',
		header : 'ON/OFF Test',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r22.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r22.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r22.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r22.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_r23() {
// 	console.log('init_grid_r23()');
	$("#grid_r23").w2grid({
		name : 'grid_r23',
		header : '최종 조립',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r23.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r23.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r23.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r23.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_r31() {
// 	console.log('init_grid_r31()');
	$("#grid_r31").w2grid({
		name : 'grid_r31',
		header : 'Ghost 작업',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r31.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r31.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r31.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r31.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_r32() {
// 	console.log('init_grid_r32()');
	$("#grid_r32").w2grid({
		name : 'grid_r32',
		header : 'Backup',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r32.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r32.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r32.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r32.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_r52() {
// 	console.log('init_grid_r52()');
	$("#grid_r52").w2grid({
		name : 'grid_r52',
		header : '공정검사',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_r52.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_r52.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_r52.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_r52.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_qt() {
// 	console.log('init_grid_qt()');
	$("#grid_qt").w2grid({
		name : 'grid_qt',
		header : '품질 최종 검사',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_qt.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_qt.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_qt.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_qt.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_qo() {
// 	console.log('init_grid_qo()');
	$("#grid_qo").w2grid({
		name : 'grid_qo',
		header : '품질 1차 검사',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_qo.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_qo.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_qo.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_qo.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_qa() {
// 	console.log('init_grid_qa()');
	$("#grid_qa").w2grid({
		name : 'grid_qa',
		header : '품질 Aging',
		show : { header : true },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
 			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
 			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', size:'90px',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', size:'50px', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
      		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
          	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},//member_id
			{ field:'member_nm', caption:'작업자', size:'50px', style:'text-align:center'
// 				editable:{type:'text'}, 	
// 				, render : function(record, index, col_index){
// 				if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null)
// 					return member_nm;
// 				else
// 					return this.getCellValue(index, col_index);}
			},
			{ field:'work_date', caption:'작업일', size:'90px', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
					render : function(record, index, col_index){
						if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
							return replaceAll(getTodayDate(),'.','-');
						else
							return this.getCellValue(index, col_index);
					}},
			{ field:'remark', caption:'비고', size:'90px',editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_qa.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_qa.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_qa.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_qa.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_p1() {
// 	console.log('init_grid_p1()');
	$("#grid_p1").w2grid({
		name : 'grid_p1',
		header : 'Master 검사 공정',
		show : {
			header : true
        },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
   			{ field:'minsp_name', caption:'항목(대분류)', style:'text-align:center'},
   			{ field:'sinsp_name', caption:'항목(소분류)', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정',editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
        		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
            	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', style:'text-align:center'},
			{ field:'work_date', caption:'작업일', editable:{ type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
				render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
						return replaceAll(getTodayDate(),'.','-');
					else
						return this.getCellValue(index, col_index);
				}},
			{ field:'remark', caption:'비고', editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==9 || event.column==10 || event.column==14 ) {
					w2ui.grid_p1.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_p1.set(event.recid, {'member_nm' :member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==12) {
				w2ui.grid_p1.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_p1.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_p2() {
// 	console.log('init_grid_p2()');
	$("#grid_p2").w2grid({
		name : 'grid_p2',
		header : '조립 공정',
		show : {
			header : true
        },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
   			{ field:'minsp_name', caption:'항목', style:'text-align:center'},
			{ field:'insp_standard', caption:'검사기준', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
        		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
            	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', editable:{type:'text'}, style:'text-align:center'},
			{ field:'work_date', caption:'작업일', editable: { type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
				render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
						return replaceAll(getTodayDate(),'.','-');
					else
						return this.getCellValue(index, col_index);
				}},
			{ field:'remark', caption:'비고', editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==8 || event.column==9 || event.column==13 ) {
					w2ui.grid_p2.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_p2.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==11) {
				w2ui.grid_p2.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_p2.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_p5() {
// 	console.log('init_grid_p5()');
	$("#grid_p5").w2grid({
		name : 'grid_p5',
		header : '조정 공정',
		show : {
			header : true
        },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
   			{ field:'minsp_name', caption:'항목', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
        		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
            	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', editable:{type:'text'}, style:'text-align:center'},
			{ field:'work_date', caption:'작업일', editable: { type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
				render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
						return replaceAll(getTodayDate(),'.','-');
					else
						return this.getCellValue(index, col_index);
				}},
			{ field:'remark', caption:'비고', editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==7 || event.column==8 || event.column==12 ) {
					w2ui.grid_p5.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_p5.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==10) {
				w2ui.grid_p5.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_p5.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function init_grid_t1() {
// 	console.log('init_grid_t5()');
	$("#grid_t1").w2grid({
		name : 'grid_t1',
		header : '최종검사 공정',
		show : {
			header : true
        },
		columns :[
	        { field:'simaster_gr_no', caption:'마스터 gr코드', hidden:true},
	        { field:'sidetail_seq', caption:'deatil seq', hidden:true},
	        { field:'sidetail_code', caption:'', hidden:true},
	        { field:'dept_cd', caption:'사업부코드', hidden:true},
	        { field:'display_seq', caption:'Display 순번', hidden:true},
	        { field:'routing_code', caption:'공정 매핑 코드', hidden:true},
   			{ field:'minsp_name', caption:'항목', style:'text-align:center'},
			{ field:'insp_value', caption:'측정', editable:{type:'text'}, style:'text-align:right'},
			{ field:'insp_state', caption:'결과', editable:{type:'select', items:[{id:'i2', text:'OK'},{id:'i3', text:'NG'}]},
        		render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='i2')	return 'OK';
					else if(this.getCellValue(index, col_index)=='i3')	return 'NG';
            	},style:'text-align:center'},
			{ field:'member_emp_no', caption:'검사작업자사번', hidden:true},
			{ field:'member_nm', caption:'작업자', editable:{type:'text'}, style:'text-align:center'},
			{ field:'work_date', caption:'작업일', editable: { type: 'date', format: 'yyyy-mm-dd'}, style:'text-align:center',
				render : function(record, index, col_index){
					if(this.getCellValue(index, col_index)=='' || this.getCellValue(index, col_index)==null) 
						return replaceAll(getTodayDate(),'.','-');
					else
						return this.getCellValue(index, col_index);
				}},
			{ field:'remark', caption:'비고', editable:{ type: 'text'}} ],
		records: [],
		recordHeight : 30,
		total : 0,
		onChange: function(event) {
			event.onComplete = function () {
				if( event.column==7 || event.column==8 || event.column==12 ) {
					w2ui.grid_t1.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
					w2ui.grid_t1.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
				}
			}
		},
		onDblClick: function(event) {
			if( event.column==10) {
				w2ui.grid_t1.set(event.recid, {'member_nm' : '', 'member_emp_no' : ''});
				w2ui.grid_t1.set(event.recid, {'member_nm' : member_nm, 'member_emp_no' : member_emp_no});
			}
	    }
	});
}

function saveSelfInsp() {
// 	console.log('saveSelfInsp()');
	var selData = $("#grid_role").jqGrid("getRowData", $("#grid_role").getGridParam("selrow"));
	var pordno = selData.pordno;
	var headerData = w2ui.grid_selfInsp_header.records;
	$.each(headerData, function(idx, row){
		if( row.w2ui!=undefined ){
			row.item_value = row.w2ui.changes.item_value;
		}
	});
// 	console.log(headerData);
	var detailObj = {};
	$.each(selfDetail, function(idx, opt){
		detailObj[opt] = dataSetselfinspDetail(w2ui['grid_' + opt].records);
	});
	
	var page_url = "";
	var params = "";
	if( selData.dept_cd=="1110" ) {
		page_url = "/frontend/mes/saveSelfInsp_1110"
				 + "?pordno=" + encodeURIComponent(pordno)
				 + "&dept_cd=" + encodeURIComponent(selData.dept_cd); 
		params = "&headerData=" + encodeURIComponent(JSON.stringify(headerData))
				+ "&detailData=" + encodeURIComponent(JSON.stringify(detailObj));
	} else {
		page_url = "/frontend/mes/saveSelfInsp_1210"
				 + "?pordno=" + encodeURIComponent(pordno)
				 + "&dept_cd=" + encodeURIComponent(selData.dept_cd);
		params = "&headerData=" + encodeURIComponent(JSON.stringify(headerData))
				+ "&grid_p1_data=" + encodeURIComponent(JSON.stringify(dataSetselfinspDetail(w2ui.grid_p1.records)))
				+ "&grid_p2_data=" + encodeURIComponent(JSON.stringify(dataSetselfinspDetail(w2ui.grid_p2.records)))
				+ "&grid_p5_data=" + encodeURIComponent(JSON.stringify(dataSetselfinspDetail(w2ui.grid_p5.records)))
				+ "&grid_t1_data=" + encodeURIComponent(JSON.stringify(dataSetselfinspDetail(w2ui.grid_t1.records)));
	}
	$.ajax({
		url: page_url,
		data : params,
		type: "POST",
		success:function(data, textStatus, jqXHR){
			if(data.status == "200") {
				fnMessageModalAlert("Success", "저장을 완료 하였습니다.");
				$("#modal_selfInsp").modal('hide');
				$("#pono").text("");	// 2018-01-24 : iris add, 지시번호 표시
			} else {
				fnMessageModalAlert("Fail", "데이터 저장을 실패하였습니다.");	
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("Fail", "데이터 저장하는데 에러가 발생하였습니다.");	
		},
		complete: function() {}
	});
}

function dataSetselfinspDetail(dataArr) {
// 	console.log('dataSetselfinspDetail()');
	$.each(dataArr, function(idx, row){
		if( row.w2ui!=undefined ){
			var chnObj = row.w2ui.changes;
			if( chnObj.insp_value!=undefined )
				row.insp_value = chnObj.insp_value;
			if( chnObj.insp_state!=undefined )
				row.insp_state = chnObj.insp_state;
			if( chnObj.member_nm!=undefined )
				row.member_nm = chnObj.member_nm;
			if( chnObj.work_date!=undefined )
				row.work_date = chnObj.work_date;
			if( chnObj.remark!=undefined )
				row.remark = chnObj.remark;
		}
		if( row.work_date=='' ) {
			row.work_date = replaceAll(getTodayDate(),'.','-'); 
		}
	});
	return dataArr;
}

function setRecid(arr) {
	var resultArr = [];	
	$.each(arr, function(idx, row){
		row.recid = idx+1;
		resultArr.push(row);
	});
	return resultArr;
}

function jqgridHighlightFormatterSapSendFlag(cellvalue, options, rowObject) {
// 	if (cellvalue != null && cellvalue != "" && cellvalue == "V001") {
	if(rowObject.routing_no != rowObject.transfer_routing) {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#E5D85C\">전송미대상</span>';
	} else if (rowObject.sap_send_yn == 'Y') {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#2F9D27\">전송완료</span>';
	} else if(rowObject.sap_send_yn == 'N'){
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">전송대기</span>';
	}
}

function Left(str,n){
    if (n <= 0){
       return "";
    }else if (n > String(str).length){
       return str;
    }else{
       return String(str).substring(0,n);
    }
}

function Right(str,n){
    if (n <= 0){
       return "";
    }else if (n > String(str).length){
       return str;
    }else{
       var iLen = String(str).length;
       return String(str).substring(iLen, iLen - n);
    }
}


function LMainsernr_enter(text){
	if(text.value.length > 6) {
		
	    if(text.value.length > 30 && Left(text.value,2) == 01  ){
	    	 
	    	$('#project_no').val(Right(text.value,9));
	    	}
	    
	    fnSearchInspGrid();
	   
	} else {
		fnMessageModalAlert("Notification(MES)", "바코드 길이는 7자리 이상이어야 합니다.<br/>입력값 : " + $('#project_no').val());
		$('#project_no').val("");
    } 
}


function excelFileDownload(gridName) {
// 	console.log('excelFileDownload('+gridName+')');
	var tmpArr = [];
	var getColNames = $("#grid_role").jqGrid('getGridParam','colNames');
	var getColModels = $("#grid_role").jqGrid('getGridParam','colModel');
	$.each(getColModels, function(idx, mrow){
		if( mrow.hidden==false && getColNames[idx]!='' ) {
			mrow.caption = getColNames[idx]; 
			tmpArr.push(mrow);  
		}
	});
	
	getColModels[1] = "";
	
	var gridCols = tmpArr;
	var gridData = $("#grid_role").getRowData();

	for(var i =0 ;i<gridData.length;i++) {
		if(gridData[i].sap_send_yn == 'Y') {
			gridData[i].f_sap_send_yn = "전송완료";
		} else if(gridData[i].sap_send_yn == 'N') {
			gridData[i].f_sap_send_yn = "전송대기";
		} else {
			gridData[i].f_sap_send_yn = "전송대기";
		}
	}
	
	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	if( gridName=='grid_role' ) {
		fileName = '최종검사.xlsx';
		sheetTitle = '최종검사';
		sheetName = '최종검사';
	}
	
	var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
	var is_rownum = true;
	
	if(gridCols != null && gridCols.length > 0){
		// w2grid 는 linenumber column info not exist
		param_col_name = "No"
		param_col_id = "rownum";
		param_col_align = "center";
		param_col_width = "80";
		//--------------------------------------------
		console.log(gridCols);
		for(var i=0; i<gridCols.length; i++){
			if(!gridCols[i].hidden){
				var caption = gridCols[i].caption;
				
				if(i == 0) {
					caption = "";
				}
				param_col_name += "," + caption;
				param_col_id += "," + gridCols[i].name;
				param_col_align += ",left";
				param_col_width += "," + (gridCols[i].width==undefined?"80":(gridCols[i].width));
			}
		}
	}
	
	var export_url = "/export/export_client_jqgrid";
	var export_data = "file_name="+encodeURIComponent(fileName);
		export_data += "&sheet_title="+encodeURIComponent(sheetTitle);
		export_data += "&sheet_name="+encodeURIComponent(sheetName);
		export_data += "&header_col_names="+encodeURIComponent(param_col_name);
		export_data += "&header_col_ids="+encodeURIComponent(param_col_id);
		export_data += "&header_col_aligns="+encodeURIComponent(param_col_align);
		export_data += "&header_col_widths="+encodeURIComponent(param_col_width);
		export_data += "&cmd="+encodeURIComponent("grid_goods_detail");
		export_data += "&body_data="+encodeURIComponent(JSON.stringify(gridData));

	$.ajax({
	  url:export_url,
	  data:export_data,
	  type:'POST',
	  dataType: 'json',
	  success: function( data ) {
	  	if(data.status == 200) {
	  		var file_path = data.file_path;
	  		var file_name = data.file_name;
	  		var protocol = jQuery(location).attr('protocol');
  			var host = jQuery(location).attr('host');
  			var link_url = "/file/attach_download";
  			link_url += "?file_path="+encodeURIComponent(file_path);
  			link_url += "&file_name="+encodeURIComponent(file_name);
  			$(location).attr('href', link_url);
	  	}
	  },
	  complete: function () {}
	});
}

</script>
</body>
</html>