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
	
	<style type="text/css">
		.ichk_label {
			font-weight: unset;
    		font-size: 12px; }
	</style>
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
		<jsp:param name="selected_menu_cd" value="1118" />
	</jsp:include>

	<div class="content-wrapper">
	    <section class="content-header">
	        <h1>
	            HUB
	            <small>수주 관리</small>
	        </h1>
	        <ol class="breadcrumb">
	            <li><a href="#"><i class="fa fa-dashboard"></i> HUB</a></li>
	            <li class="active">수주 관리</li>
	        </ol>
	    </section>
	
	    <!-- Main content -->
		<section class="content" style="padding-bottom: 0px;">
			<div class="box" style="margin-bottom: 0px;height: 790px;">
				<div class="box-body"><!-- start box body -->
					<div class="row" style="margin-bottom:10px;">
						<div class="col-md-12">
							<div class="col-sm-2">
	                        	<label>| 주문등록일</label><br>
	                        	<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right input-sm" id="posale_dt">
								</div>
					    	</div>
							<div class="col-sm-2">
	                        	<label>| 납품요청일</label><br>
	                        	<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right input-sm" id="sedat">
								</div>
					    	</div>
							<div class="col-sm-2">
	                        	<label>| 완료일자</label><br>
	                        	<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right input-sm" id="eindt">
								</div>
					    	</div>
					    	<div class="col-sm-2">
								<label>| 수주등록 확정 여부</label>
								<select id="posale_status" class="form-control select2 input-sm">
									<option value="">전체</option>
									<option value="00">확정전</option>
									<option value="01">확정</option>
								</select>
							</div>
					    	<div class="col-sm-2">
								<label>| 출하확정 여부</label>
								<select id="delivery_status" class="form-control select2 input-sm">
									<option value="">전체</option>
									<option value="00">확정전</option>
									<option value="01">확정</option>
								</select>
							</div>
							<div class="col-sm-2">
								<label>| 프로젝트 명</label>
								<input type="input" id="project_nm" name="project_nm" class="form-control input-sm" placeholder="ex) *** 제작" maxlength="30">
							</div>
						</div>
					</div>
					<div class="row" style="margin-bottom:10px;">
						<div class="col-md-12">
							<div class="col-sm-2">
								<label>| 납품처명</label>&nbsp;&nbsp;
								<button type="button" id="" onclick="fnPopupLifnr();" class="btn btn-success btn-xs">납품처 조회</button>
								<input type="input" id="lifnr_nm" name="lifnr_nm" class="form-control input-sm" disabled>
							</div>
							<div class="col-sm-2">
								<label>| 사업자번호</label>
								<input type="input" id="lifnr" name="lifnr" class="form-control input-sm" placeholder="ex) 1234567890" maxlength="10" disabled>
							</div>
						</div>
					</div>
					<!-- end row:search condition -->
					<div class="row" style="margin-bottom:10px;">
						<div class="col-md-12 text-right">
							<button type="button" id="" onclick="fnPopupInfo('N');" class="btn btn-success btn-sm">등록</button>
							<button type="button" id="" onclick="fnPopupInfo('U');" class="btn btn-success btn-sm">수정</button>
							<button type="button" id="" onclick="fnDelete();" class="btn btn-danger btn-sm">삭제</button>
							<button type="button" id="" onclick="loadList();" class="btn btn-primary btn-sm">조회</button>
							<button type="button" id="" onclick="fnDownload();" class="btn btn-warning btn-sm">Excel Download</button>
						</div>
					</div>
					<div class="row"> <!--  grid  -->
						<div class="col-md-12">
							<div id="grid" style="width: 100%; height: 600px;"></div>
							<div id="pagination" class="text-center"></div>
						</div>
					</div>
				</div>
			</div>
		</section>
	    <!-- /.content -->
	</div>
<!-- /.content-wrapper -->
<!-- customer list -->
<div class="modal fade" id="modal_vendor" aria-hidden="true" style="display: none; z-index: 1070;"> <!-- data-backdrop="static"> -->
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modal_v_title">거래처 목록</h4>
        	</div>
			<div class="modal-body" id="">
				<form id="frm_vendor" name="frm_vendor" class="form-horizontal">
					<div class="form-group row">
						<label for="" class="col-sm-2 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 거래처 코드</label>
						<div class="col-sm-3">
							<input type="text" class="form-control input-sm" id="code">
						</div>
						<label for="" class="col-sm-2 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 거래처 명</label>
						<div class="col-sm-4">
							<input type="text" class="form-control input-sm" id="name">
						</div>
						<div class="col-sm-1" style="padding-left: 0px;">
							<button type="button" onclick="fnSetLoadVendorGrid();" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</form>
				<div class="row">
					<div class="col-md-12">
						<div id="grid_vendor" style="width: 100%; height: 500px;"></div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_modal_vandor" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- project list -->
<div class="modal fade" id="modal_proj" aria-hidden="true" style="display: none; z-index: 1070;"> <!-- data-backdrop="static"> -->
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modal_v_title">프로젝트 목록</h4>
        	</div>
			<div class="modal-body" id="">
				<form id="frm_proj" name="frm_proj" class="form-horizontal">
					<div class="form-group row">
						<label for="" class="col-sm-2 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 거래처 코드</label>
						<div class="col-sm-3">
							<input type="text" class="form-control input-sm" id="code">
						</div>
						<label for="" class="col-sm-2 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 거래처 명</label>
						<div class="col-sm-4">
							<input type="text" class="form-control input-sm" id="name">
						</div>
						<div class="col-sm-1" style="padding-left: 0px;">
							<button type="button" onclick="fnSetLoadProjGrid();" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</form>
				<div class="row">
					<div class="col-md-12">
						<div id="grid_proj" style="width: 100%; height: 500px;"></div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_modal_vandor" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- matnr list -->
<div class="modal fade" id="modal_matnr" aria-hidden="true" style="display: none; z-index: 1070;"> <!-- data-backdrop="static"> -->
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modal_v_title">완제품 목록</h4>
        	</div>
			<div class="modal-body" id="">
				<form id="frm_matnr" name="frm_matnr" class="form-horizontal">
					<div class="form-group row">
						<label for="" class="col-sm-2 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 자재내역</label>
						<div class="col-sm-3">
							<input type="text" class="form-control input-sm" id="s_maktx">
						</div>
<!-- 						<label for="" class="col-sm-2 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 거래처 명</label> -->
<!-- 						<div class="col-sm-4"> -->
<!-- 							<input type="text" class="form-control input-sm" id="name"> -->
<!-- 						</div> -->
						<div class="col-sm-1" style="padding-left: 0px;">
							<button type="button" onclick="fnSetLoadMatnrGrid();" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</form>
				<div class="row">
					<div class="col-md-12">
						<div id="grid_matnr" style="width: 100%; height: 500px;"></div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_modal_vandor" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modal_print" aria-hidden="true" style="display: none; z-index: 1070;"> <!-- data-backdrop="static"> -->
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modal_v_title">도면 목록</h4>
        	</div>
			<div class="modal-body" id="">
				<form id="frm_print" name="frm_vendor" class="form-horizontal">
					<div class="form-group row">
						<label for="" class="col-sm-2 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 구분</label>
						<div class="col-sm-3">
							<select id="s_type" name="p_gubun" class="form-control select2 input-sm" data-placeholder="">
								<option value="drw">도면</option>
								<option value="ord">작업표준서</option>
							</select>
						</div>
						<label for="" class="col-sm-2 col-form-label text-right" style="margin-bottom: 0px;line-height: 30px;"> 파일명</label>
						<div class="col-sm-4">
							<input type="text" class="form-control input-sm" id="p_filename">
						</div>
						<div class="col-sm-1" style="padding-left: 0px;">
							<button type="button" onclick="fnSearchRegListGrid();" class="btn btn-success btn-sm"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</form>
				<div class="row">
					<div class="col-md-12">
						<div id="grid_reg" style="width: 100%; height: 500px;"></div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_modal_print" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- start insert/update -->
<div class="modal fade" id="modal_info" aria-hidden="true" style="display: none; z-index: 1060;"><!-- data-backdrop="static"> -->
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modal_title">등록</h4>
        	</div>
			<div class="modal-body" id="">
				<!-- project info -->
				<div class="row">
					<div class="col-md-12">
						<div class="box box-success">
            				<div class="box-header with-border">
              					<h3 class="box-title">Project Info</h3>
              					<div class="box-tools pull-right">
              						<button type="button" class="btn btn-success btn-sm" id="btn_project" onClick="fnProjInfoPop();">
              							조회
              						</button>
              						<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
<!--               						<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button> -->
              					</div>
              				</div>
              				<div class="box-body with-border" style="height: 150px;overflow-y: auto;overflow-x: hidden;">
              					<div class="row">
              						<div class="col-md-12">
										<div class="form-group row">
											<div class="col-sm-1"></div>
											<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">프로젝트 코드</label>
											<div class="col-sm-7">
												<input type="text" class="form-control input-sm" id="i_project_no" value="" disabled>
											</div>
											<div class="col-sm-1"></div>
										</div>
										<div class="form-group row">
											<div class="col-sm-1"></div>
											<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">프로젝트 명</label>
											<div class="col-sm-7">
												<input type="text" class="form-control input-sm" id="i_project_nm" value="" disabled>
											</div>
											<div class="col-sm-1"></div>
										</div>
										<div class="form-group row">
											<div class="col-sm-1"></div>
											<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">업체명</label>
											<div class="col-sm-7">
												<input type="text" class="form-control input-sm" id="i_lifnr_nm" value="" disabled>
											</div>
											<div class="col-sm-1"></div>
										</div>
										<div class="form-group row">
											<div class="col-sm-1"></div>
											<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">업체 사업자번호</label>
											<div class="col-sm-7">
												<input type="text" class="form-control input-sm" id="i_lifnr" value="" disabled>
											</div>
											<div class="col-sm-1"></div>
										</div>
										<div class="form-group row">
											<div class="col-sm-1"></div>
											<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">발주금액</label>
											<div class="col-sm-7">
												<input type="number" class="form-control input-sm" id="i_netwr" value="" style="text-align: right;" disabled>
											</div>
											<div class="col-sm-1"></div>
										</div>
										<div class="form-group row">
											<div class="col-sm-1"></div>
											<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">수량</label>
											<div class="col-sm-7">
												<input type="text" class="form-control input-sm" id="i_menge" value="" style="text-align: right;" disabled>
											</div>
											<div class="col-sm-1"></div>
										</div>
										<div id="a_zdue_menge" class="form-group row">
											<div class="col-sm-1"></div>
											<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">잔량</label>
											<div class="col-sm-7">
												<input type="text" class="form-control input-sm" id="i_zdue_menge" value="" style="text-align: right;" disabled>
											</div>
											<div class="col-sm-1"></div>
										</div>
										<div class="form-group row">
											<div class="col-sm-1"></div>
											<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">단위</label>
											<div class="col-sm-7">
												<select id="i_meins" name="p_meins" class="form-control select2 input-sm" data-placeholder="" disabled>
													<option value="EA">EA</option>
													<option value="M">M</option>
												</select>
											</div>
											<div class="col-sm-1"></div>
										</div>
										<div class="form-group row">
											<div class="col-sm-1"></div>
											<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">요구사항</label>
											<div class="col-sm-7">
												<input type="text" class="form-control input-sm" id="i_remark" value="" disabled>
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
													<input type="text" class="form-control pull-right input-sm" id="i_eindt" disabled>
												</div>
											</div>
											<div class="col-sm-1"></div>
										</div>
										<div id="i_purdt" class="form-group row">
											<div class="col-sm-1"></div>
											<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">구매일자</label>
											<div class="col-sm-7">
												<div class="input-group">
													<div class="input-group-addon">
														<i class="fa fa-calendar"></i>
													</div>
													<input type="text" class="form-control pull-right input-sm" id="i_purdt" disabled>
												</div>
											</div>
											<div class="col-sm-1"></div>
										</div>
										<div id="a_file_group" class="form-group row">
											<div class="col-sm-1"></div>
											<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">도면정보</label>
											<div class="col-sm-7">
												<input type="text" class="form-control input-sm" id="i_file_group" value="" disabled>
											</div>
											<div class="col-sm-1"></div>
										</div>
              						</div>
              					</div>
              				</div>
              			</div>
              			<div class="form-group row" id="posales_no" style="display:none;">
							<div class="col-sm-1"></div>
							<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">수주번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="i_posales_no" value="" disabled>
							</div>
							<div class="col-sm-1"></div>
						</div>
              			<div class="form-group row" id="posales_seq" style="display:none;">
							<div class="col-sm-1"></div>
							<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">수주순번</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="i_posale_seq" value="" disabled>
							</div>
							<div class="col-sm-1"></div>
						</div>
              			<div class="form-group row">
							<div class="col-sm-1"></div>
							<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">생산품 코드</label>
							<div class="col-sm-6">
								<input type="text" class="form-control input-sm" id="i_matnr" value="" disabled>
							</div>
							<div class="col-sm-1">
								<button type="button" class="btn btn-success btn-sm" onClick="fnMatnrInfoPop();">
          							검색
          						</button>
							</div>
							<div class="col-sm-1"></div>
						</div>
              			<div class="form-group row">
							<div class="col-sm-1"></div>
							<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">생산품 내역</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="i_maktx" value="" disabled>
							</div>
							<div class="col-sm-1"></div>
						</div>
              			<div class="form-group row">
							<div class="col-sm-1"></div>
							<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">수량</label>
							<div class="col-sm-7">
								<input type="number" class="form-control input-sm" id="i_project_menge" value="">
							</div>
							<div class="col-sm-1"></div>
						</div>
						<div id="a_posales_status" class="form-group row">
							<div class="col-sm-1"></div>
							<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">수주등록확정구분</label>
							<div class="col-sm-4">
								<label class="ichk_label"> <input type="radio" id="i_posales_status" name="i_posales_status" value="00"> 확정전</label> 
							</div>
							<div class="col-sm-3">
								<label class="ichk_label"> <input type="radio" id="i_posales_status" name="i_posales_status" value="01"> 확정</label>
							</div>
							<div class="col-sm-1"></div>
						</div>
						<div id="a_delivery_status" class="form-group row">
							<div class="col-sm-1"></div>
							<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">출하확정구분</label>
							<div class="col-sm-4">
								<label class="ichk_label"> <input type="radio" id="i_delivery_status" name="i_delivery_status" value="00"> 확정전</label> 
							</div>
							<div class="col-sm-3">
								<label class="ichk_label"> <input type="radio" id="i_delivery_status" name="i_delivery_status" value="01"> 확정</label>
							</div>
							<div class="col-sm-1"></div>
						</div>
              			<div class="form-group row">
							<div class="col-sm-1"></div>
							<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">지시일자</label>
							<div class="col-sm-7">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right input-sm" id="i_jidat">
								</div>
							</div>
							<div class="col-sm-1"></div>
						</div>
              			<div class="form-group row">
							<div class="col-sm-1"></div>
							<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">주문등록일</label>
							<div class="col-sm-7">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right input-sm" id="i_posale_dt">
								</div>
							</div>
							<div class="col-sm-1"></div>
						</div>
              			<div class="form-group row">
							<div class="col-sm-1"></div>
							<label for="" class="col-sm-3 col-form-label" style="line-height: 25px;">납품요청일</label>
							<div class="col-sm-7">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" class="form-control pull-right input-sm" id="i_sedat">
								</div>
							</div>
							<div class="col-sm-1"></div>
						</div>
              		</div>
              	</div>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_save" class="btn btn-success btn-sm">Save</button>
					<button type="button" id="btn_dmr_cancel" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div> <!-- end modal insert/update -->
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

var selArrObj = {};
var grpCodeArr = [
	'MC1010',	// 자재유형
	'MC1011'	// 자재그룹명
];

$(function($) {
	
	fnSelectComponent();
	
	fnPageLoadOption();
	fnLoadPoRegGrid();
	fnLoadFileHandler();
	
	fnLoadVendorGrid();
	fnLoadRegListGrid();
	
	fnLoadProjGrid();
	fnLoadMatnrGrid();
	
	minDate = getFormatDate(new Date()),
	mdTemp = new Date(), 
	maxDate = getFormatDate(new Date(mdTemp.setDate(mdTemp.getDate() + 7)));
	 
	
	$('#p_eindt, #p_plan_dt, #p_purdt, #i_sedat, #i_jidat, #i_posale_dt').daterangepicker({
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
	
	var today = dateNow();
	$('#posale_dt, #sedat, #eindt').daterangepicker({
		opens: 'right',
		startDate : today.from,
		endDate : today.to,
		locale: {
			format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
			,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
			,showMonthAfterYear: true
			,yearSuffix: '년'
			,orientation: "top left"
	    }
	});

	$('input').iCheck({
	    checkboxClass: 'icheckbox_flat-blue',
	    radioClass: 'iradio_flat-blue'
	});
	$(":radio[name=i_posales_status][value=00]").iCheck("check");
	$(":radio[name=i_delivery_status][value=00]").iCheck("check");
	
	$("#i_project_menge").focusout(function() {
		var chk = fnChkMenge($(this).val());
		if( !chk ) {
			$("#i_project_menge").val('');
		}
	});
	
	$("#btn_save").click(function(){
		if( nullToBlank($("#i_posales_no").val())=="" )
			fnInsert();
		else
			fnUpdate();
	});
});

function fnChkMenge(val) {
// 	console.log('fnChkMenge()');
	var menge = Number(val);
	var sum_menge = Number(fnGetSumPmengeByProject())+menge;
// 	console.log(Number(fnGetSumPmengeByProject()), menge);
	var result = true;
	if( nullToBlank($("#i_project_no").val())=='' ) {
		$.notify({ // options
			message: '연관 프로젝트가 선택되지 않았습니다.' 
		},{ // settings
			element: '#modal_info',
			type: 'warning',
			placement: {
				from: "top",
				align: "center"
			},
		});
		result = false;
	} else if( sum_menge>Number($("#i_menge").val()) ) {
		$.notify({ // options
			message: '해당 수량이 프로젝트에 등록한 수량을 초과합니다.' 
		},{ // settings
			element: '#modal_info',
			type: 'warning',
			placement: {
				from: "top",
				align: "center"
			},
		});
		result = false;
	}
	return result;
}

function fnGetSumPmengeByProject() {
// 	console.log("fnGetSumPmengeByProject()");
	
	var sum = 0;
	var page_url = "/frontend/poreg_chk_menge"
			 	 + "?project_no=" + encodeURIComponent($("#i_project_no").val())
			 	 + "?posales_no=" + encodeURIComponent($("#i_posales_no").val());
	$.ajax({
		url:page_url,
		type:'POST',
		dataType: 'json',
		async : false,
		success: function( data ) {
			if(data.status == 200) {
				sum = data.rows;
			}
		},
		complete: function () {}
	});
	return sum;
}

function fnSelectComponent() {
// 	console.log('fnSelectComponent()');
	var page_url = "/frontend/commCode/comm_code_select"
		 		 + "?grpCodeArr=" + encodeURIComponent(grpCodeArr.toString());
	$.ajax({
		url:page_url,
		type:'POST',
		dataType: 'json',
		async : false,
		success: function( data ) {
			if(data.status == 200) {
				$.each(grpCodeArr, function(idx, it){
					selArrObj[it] = [{detail_code:'', dcode_nm:''}];
				});
				$.each(data.rows, function(idx, row){
					var tmpObj = {
							detail_code:row.detail_code, 
							dcode_nm:row.dcode_nm
					};
					selArrObj[row.master_code].push(tmpObj);
				});
				/* for ( code in selArrObj ) {
			 		$.each(selArrObj[code], function(idx, row){
			 			$("#"+code).append("<option value=" + row.detail_code + ">" + row.dcode_nm + "</option>");
			 			$("#"+code+"_1").append("<option value=" + row.detail_code + ">" + row.dcode_nm + "</option>");
			 		});
				} */
			}
		},
		complete: function () {}
	});
}

function fnPageLoadOption(){
	$("#project_division, #project_no, #project_nm").pressEnter(function(e) {
		e.preventDefault();
		loadList();
	});
	/* 
	$("#p_stprs").keyup(function(event) {
		if(event.which >= 37 && event.which <= 40) return;
		$(this).val(function(index, value) {
			console.log(index, value);
			return value
			.replace(/\D/g, "")
			.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		});
	}); */
}
 
function fnLoadPoRegGrid(){
// 	console.log('fnLoadPoRegGrid()');
	var rowArr = [];
	
	$('#grid').w2grid({ 
        name: 'grid', 
//         searches: [                
//             { field: 'lname', caption: 'Last Name', type: 'text' },
//             { field: 'fname', caption: 'First Name', type: 'text' },
//             { field: 'email', caption: 'Email', type: 'text' },
//         ],
        show: { footer: true },
        multiSelect: false,
        columns: [
            { field: 'recid', caption: 'No', size: '40px', sortable: true, attr: 'align=center', resizable: true },
            { field: 'posale_no', caption: '주문번호', size: '10%', sortable: true, resizable: true },
            { field: 'posale_seq', caption: '주문번호-순번', size: '10%', resizable: true },
            { field: 'matnr', caption: '아이템 코드', size: '10%', resizable: true },
            { field: 'maktx', caption: '단위', size: '90px', hidden: true },
            { field: 'posale_status', caption: '수주 등록 확정 구분', size: '10%', resizable: true,
            	render : function(record, index, col_index){
              		var value = this.getCellValue(index, col_index);
              		if( value=='00' )
              			return '확정전';
              		else
              			return '확정';
            	}},
            { field: 'delivery_status', caption: '출하확정구분', size: '10%', resizable: true,
                	render : function(record, index, col_index){
                  		var value = this.getCellValue(index, col_index);
                  		if( value=='00' )
                  			return '확정전';
                  		else
                  			return '확정';
                	}},
			{ field: 'lifnr', caption: '사업자번호', size: '10%', sortable: true, resizable: true },
			{ field: 'lifnr_nm', caption: '납품처명', size: '10%', sortable: true, resizable: true },
			{ field: 'project_no', caption: '프로젝트코드', size: '15%', sortable: true, resizable: true },
            { field: 'project_nm', caption: '프로젝트명', size: '20%', sortable: true, resizable: true },
            { field: 'netwr', caption: '발주금액', size: '90px', sortable: true, resizable: true },
            { field: 'project_menge', caption: '분할수량', size: '10%', resizable: true },
            { field: 'menge', caption: '수량', size: '90px', sortable: true, resizable: true },
            { field: 'meins', caption: '단위', size: '90px', sortable: true, resizable: true },
            { field: 'remark', caption: '요구사항', size: '90px', sortable: true, resizable: true },
            { field: 'plan_dt', caption: '설계일자', size: '90px', sortable: true, resizable: true },
            { field: 'eindt', caption: '완료일자', size: '90px', sortable: true, resizable: true },
            { field: 'purdt', caption: '구매일자', size: '90px', sortable: true, resizable: true },
            { field: 'jidat', caption: '지시일자', size: '90px', sortable: true, resizable: true },
            { field: 'sedat', caption: '납품요청일', size: '90px', sortable: true, resizable: true },
            { field: 'posale_dt', caption: '주문등록일', size: '90px', sortable: true, resizable: true },
            { field: 'file_group', caption: '도면정보', size: '90px', sortable: true, resizable: true }
        ],
        sortData: [
			{field: 'posale_no', direction: 'ASC'},
			{field: 'posale_seq', direction: 'ASC'}
		],
		records: [],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},
		onClick: function (event) {}
    }); 
	loadList();
}

function loadList(pageNum){
// 	console.log('loadList()');
// 	var gubun = $("#reg_gubun").val();
	var beforePage = page; 
	if( pageNum==undefined ){
		page=1;
		pageNum = 0;
	} else {
		page=pageNum;
		pageNum = (pageNum-1)*rowPerPage;
	}

	var posale_dt_from = $("#posale_dt").val().substr(0,10);
	var posale_dt_to =  $("#posale_dt").val().substr(13);
	var sedat_from = $("#sedat").val().substr(0,10); 
	var sedat_to = $("#sedat").val().substr(13); 
	var eindt_from = $("#eindt").val().substr(0,10);
	var eindt_to = $("#eindt").val().substr(13);
	var page_url = "/frontend/sales_select"
				 + "?posale_dt_from=" + encodeURIComponent(posale_dt_from)
				 + "&posale_dt_to=" + encodeURIComponent(posale_dt_to)
				 + "&sedat_from=" + encodeURIComponent(sedat_from)
				 + "&sedat_to=" + encodeURIComponent(sedat_to)
				 + "&eindt_from=" + encodeURIComponent(eindt_from)
				 + "&eindt_to=" + encodeURIComponent(eindt_to)
				 + "&posale_status=" + encodeURIComponent($("#posale_status").val())
				 + "&delivery_status=" + encodeURIComponent($("#delivery_status").val())
				 + "&project_nm=" + encodeURIComponent($("#project_nm").val())
				 + "&lifnr=" + encodeURIComponent($("#lifnr").val())
				 + "&page="+ encodeURIComponent(pageNum)
				 + "&rows="+ encodeURIComponent(rowPerPage);
	
	w2ui['grid'].lock('loading...', true);
	var rowArr = [];
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

function fnLoadFileHandler(){
	var page_url = "/file/item_import_upload";
	
	$('#fileupload').fileupload({
		url : page_url,
		dataType : 'json',
		autoUpload : true,
		acceptFileTypes : /(\.|\/)(xlsx)$/i,
		maxFileSize : 106800000,  
	}).on('fileuploadadd', function(e, data) {
	}).on('fileuploadprocessalways', function(e, data) {
		var index = data.index;
		var file = data.files[index];
		if (file.error) {
			fnMessageModalAlert("Notification", file.error);
		}
	}).on('fileuploaddone', function(e, data) {

		$('#grid_items').jqGrid('clearGridData');
		
		var arrData = data.result.rows;
		
		var d = new Date();
		var month = d.getMonth()+1;
		var date = d.getDate();
		month = (month < 10) ? "0" + month : month;
		date = (date < 10) ? "0" + date : date;
		
		var req_date = d.getFullYear() + month + date;
		
		for(var i=0; i<data.result.rows.length; i++ ){
		    
			var i_tmp = "00000" + (i+1);
		    i_tmp = i_tmp.slice(-4);
		    
		    arrData[i].zrequest_no = req_date + "0001";	// 수정...zrequest_no은 한 번올릴때 구성요소들의 값이 모두 같다...ex) 201709260001
		    arrData[i].zseq = i_tmp;
		}

		$('#grid_items').jqGrid('setGridParam', { datatype: 'local', data: data.result.rows }).trigger('reloadGrid');	
		
	}).on('fileuploadfail', function(e, data) {
		$.each(data.files, function(index) {
			fnMessageModalAlert("Notification", "File upload failed.");
		});
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}

function getFormatDate(d) {
	var month = d.getMonth() + 1;
	var date = d.getDate();
	month = (month < 10) ? "0" + month : month;
	date = (date < 10) ? "0" + date : date;
	return d.getFullYear() + '-' + month + '-' + date;
}

function fnSearchConditionInit() {
	$("input").val("");
	$("#reg_gubun").val("G");
} 

function fnSaveMesMaterial(){
// 	console.log('fnSaveMesMaterial()');
	var dept_cd = $("#deptCD").val();
	var gubun = $("#reg_gubun").val();
	
	var selection = w2ui.grid.getSelection();
	if(selection.length==0){
		fnMessageModalAlert("Warning", "저장하고자 하는 항목을 선택하시기 바랍니다.");
		return;
	}
	
	// mess_medical_yn, mess_optical_yn
	var records = [];
	$.each(w2ui.grid.records, function(idx, row){
		if( row.w2ui!=undefined ) records.push(row);
	});
	
	if( records.length>0 ) {
		if( dept_cd=='1110' ) {
			$.each(records, function(idx, row){
				if( row.w2ui!=undefined && row.w2ui.changes.mess_medical_yn!=undefined ){
					row.mess_medical_yn = row.w2ui.changes.mess_medical_yn;
				}
			});
		} else {
			$.each(records, function(idx, row){
				if( row.w2ui!=undefined && row.w2ui.changes.mess_optical_yn!=undefined ){
					row.mess_optical_yn = row.w2ui.changes.mess_optical_yn;
				}
			});
		}
		//mesg_medical_yn, mesg_optical_yn
		if( dept_cd=='1110' ) {
			$.each(records, function(idx, row){
				if( row.w2ui!=undefined && row.w2ui.changes.mesg_medical_yn!=undefined ){
					row.mesg_medical_yn = row.w2ui.changes.mesg_medical_yn;
				}
			});
		} else {
			$.each(records, function(idx, row){
				if( row.w2ui!=undefined && row.w2ui.changes.mesg_optical_yn!=undefined ){
					row.mesg_optical_yn = row.w2ui.changes.mesg_optical_yn;
				}
			});
		}
	}
	
	var page_url = "/frontend/hub/save_mes_master_material";
	var postData = "params=" + encodeURIComponent(JSON.stringify(records))
	             + "&dept_cd=" + encodeURIComponent(dept_cd);
	$.ajax({
		url : page_url,
		type : "POST",
		data : postData,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnMessageModalAlert("Success", "변경한 사용여부를 " + data.cnt + "건 저장하였습니다.");
				loadList();
			} else {
				fnMessageModalAlert("Error", "사용여부를 저장하는데 에러가 발생하였습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "사용여부를 저장하는데 에러가 발생하였습니다.");
		}
	});
}

function fnPopupLifnr() {
	console.log('fnPopupLifnr()');
	$("#modal_vendor").modal('show');
	fnSetLoadVendorGrid();
	w2ui.grid_vendor.resize();
	w2ui.grid_vendor.refresh();
}

function fnProjInfoPop() {
	console.log('fnProjInfoPop()');
	$("#modal_proj").modal('show');
	fnSetLoadProjGrid();
	w2ui.grid_proj.resize();
	w2ui.grid_proj.refresh();
}

function fnMatnrInfoPop() {
// 	console.log('fnMatnrInfoPop()');
	$("#modal_matnr").modal('show');
	fnSetLoadMatnrGrid();
	w2ui.grid_matnr.resize();
	w2ui.grid_matnr.refresh();
}

function fnPopupInfo(flag) {
// 	console.log('fnPopupInfo(' + flag + ')');
	
	$("#a_project_no").val("");
	$("#a_zdue_menge").val("");
	$("#a_plan_dt").val("");
	$("#a_purdt").val("");
	$("#a_file_group").val("");
	$("#btn_project").css("display","");
	$("#a_project_no").css("display","none");
	$("#a_zdue_menge").css("display","none");
	$("#a_plan_dt").css("display","none");
	$("#a_purdt").css("display","none");
	$("#a_file_group").css("display","none");
	
	if( flag=='N' ) {
		// init form component 
		var inputObj = $("#modal_info").find('input');
		$.each(inputObj, function(idx, obj){
			if( $(obj).attr('type')!='radio' )
				$(obj).val("");
		});
		$(":radio[name=i_posales_status][value=00]").iCheck("check");
		$(":radio[name=i_delivery_status][value=00]").iCheck("check");
				
		$("#modal_info").modal('show');
		$("#modal_title").text("등록");
		
		$("#p_gubun").attr('disabled', false);
// 		$("#p_lifnr_nm").attr('disabled', true);
// 		$("#p_lifnr").attr('disabled', false);
		$("#p_project_nm").attr('disabled', false);
		$("#p_netwr").attr('disabled', false);
		$("#p_menge").attr('disabled', false);
		$("#p_meins").attr('disabled', false);
		$("#p_remark").attr('disabled', false);
		$("#p_eindt").attr('disabled', false);
	} else if( flag=='U' ) {
		var selIdxArr = w2ui.grid.getSelection();
		var chkLen = selIdxArr.length;
		if( chkLen==0 ) {
			fnMessageModalAlert('Alert', '수정할 항목을 목록에서 선택해야 합니다.');			
		} else if( chkLen>1 ) {
			fnMessageModalAlert('Alert', '수정할 항목은 목록에서 1개 선택해야 합니다.');
		} else {
			var row = w2ui.grid.get(selIdxArr[0]);
// 			console.log(row);
			$("#btn_project").css("display","none");
			$("#a_project_no").css("display","");
			$("#a_zdue_menge").css("display","");
			$("#a_plan_dt").css("display","");
			$("#a_purdt").css("display","");
			$("#a_file_group").css("display","");
			
			/*
			jidat: "2019-05-20"
			matnr: "test2"
			posale_dt: "2019-05-20"
			posale_no: "PO00000006"
			posale_seq: 1
			project_menge: "1"
			recid: 1
			sedat: "2019-05-20"
			*/
			$("#i_project_no").val(row.project_no);
			$("#i_project_nm").val(row.project_nm);
			$("#i_lifnr_nm").val(row.lifnr_nm);
			$("#i_lifnr").val(row.lifnr);
			$("#i_remark").val(row.remark);
			$(":radio[name=i_posales_status][value="+row.posale_status+"]").iCheck("check"); 
			$(":radio[name=i_delivery_status][value="+row.delivery_status+"]").iCheck("check");
			$("#i_eindt").val(row.eindt);
			$("#i_file_group").val(row.file_group);
			$("#i_meins").val(row.meins);
			$("#i_menge").val(row.menge);
			$("#i_netwr").val(row.netwr);
			$("#i_plan_dt").val(row.plan_dt);
			$("#i_purdt").val(row.purdt);
			$("#i_zdue_menge").val(row.zdue_menge);
			 
			$("#i_jidat").val(row.jidat);
			$("#i_matnr").val(row.matnr);
			$("#i_maktx").val(row.maktx);
			$("#i_posale_dt").val(row.posale_dt);
			$("#i_posales_no").val(row.posale_no);
			$("#i_posale_seq").val(row.posale_seq);
			$("#i_project_menge").val(row.project_menge);
			$("#i_sedat").val(row.sedat);
			
			$("#modal_info").modal('show');
			$("#posales_no").css("display","");
			$("#posales_seq").css("display","");
			$("#modal_title").text("수정");
// 			$("#p_gubun").attr('disabled', true);
// 			$("#lifnr_nm").attr('disabled', true);
// 			$("#lifnr").attr('disabled', true);
			$("#p_project_nm").attr('disabled', false);
			$("#p_netwr").attr('disabled', false);
			$("#p_menge").attr('disabled', false);
			$("#p_meins").attr('disabled', false);
			$("#p_remark").attr('disabled', false);
			$("#p_eindt").attr('disabled', false);
			
		}
	} else if( flag=='V' ) {	
		$("#modal_vendor").modal('show');
		fnSetLoadVendorGrid();
		w2ui.grid_vendor.resize();
		w2ui.grid_vendor.refresh();
	} else if( flag=='P' ) {	
		$("#a_project_no").css("display","");
		$("#a_zdue_menge").css("display","");
		$("#a_plan_dt").css("display","");
		$("#a_purdt").css("display","");
		$("#a_file_group").css("display","");
		
		$("#modal_print").modal('show');
		fnSearchRegListGrid();
// 		w2ui.grid_reg.resize();
// 		w2ui.grid_reg.refresh();
	}
}

function fnInsert() {
// 	console.log('fnInsert()');
	var page_url = "/frontend/poreg_insert"
				 + "?project_no=" + encodeURIComponent($("#i_project_no").val())
				 + "&matnr=" + escape(encodeURIComponent($("#i_matnr").val()))
				 + "&maktx=" + escape(encodeURIComponent($("#i_maktx").val()))
				 + "&project_menge=" + escape(encodeURIComponent($("#i_project_menge").val()))
				 + "&sedat=" + escape(encodeURIComponent($("#i_sedat").val()))
				 + "&posale_status=" + escape(encodeURIComponent($("#i_posales_status").val()))
				 + "&delivery_status=" + escape(encodeURIComponent($("#i_delivery_status").val()))
				 + "&jidat=" + encodeURIComponent($("#i_jidat").val())
				 + "&posale_dt=" + encodeURIComponent($("#i_posale_dt").val());
	
	w2ui['grid'].lock('loading...', true);
	var rowArr = [];
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		async : false,
		success : function( data ) {
// 			console.log(data);
			if(data.status == 200 && data.cnt>0 ) {
				fnMessageModalAlert("Info", '등록이 완료 되었습니다.');
			} else {
				fnMessageModalAlert("Info", '등록이 실패 하었습니다.');
			}
			$("#modal_info").modal('hide');
			loadList();
		},complete: function () {}
	});
}

function fnUpdate() {
// 	console.log('fnUpdate()');
	var page_url = "/frontend/poreg_update"
				 + "?project_no=" + encodeURIComponent($("#i_project_no").val())
				 + "&posale_no=" + escape(encodeURIComponent($("#i_posales_no").val()))
				 + "&posale_seq=" + escape(encodeURIComponent($("#i_posale_seq").val()))
				 + "&matnr=" + encodeURIComponent($("#i_matnr").val())
				 + "&maktx=" + escape(encodeURIComponent($("#i_maktx").val()))
				 + "&posale_status=" + encodeURIComponent($("#i_posales_status").val())
				 + "&delivery_status=" + encodeURIComponent($("#i_delivery_status").val())
				 + "&project_menge=" + escape(encodeURIComponent($("#i_project_menge").val()))
				 + "&jidat=" + encodeURIComponent($("#i_jidat").val())
				 + "&posale_dt=" + encodeURIComponent($("#i_posale_dt").val())
				 + "&sedat=" + encodeURIComponent($("#i_sedat").val());
 
	w2ui['grid'].lock('loading...', true);
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

function fnDelete() {
	var selIdxArr = w2ui.grid.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('Alert', '삭제할 항목을 목록에서 선택해야 합니다.');			
	} else if( chkLen>1 ) {
		fnMessageModalAlert('Alert', '삭제할 항목은 목록에서 1개 선택해야 합니다.');
	} else {
		var row = w2ui.grid.get(selIdxArr[0]);
		var page_url = "/frontend/poreg_delete"
					 + "?project_no=" + encodeURIComponent(row.project_no)
					 + "&posale_no=" + encodeURIComponent(row.posale_no)
					 + "&posale_seq=" + encodeURIComponent(row.posale_seq);
		w2ui['grid'].lock('loading...', true);
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

function fnUpload() {
	
}

function fnDownload() {
	
}

function fnLoadProjGrid() {
// 	console.log('fnLoadProjGrid()');
	
	var rowArr = [];
	
	$('#grid_proj').w2grid({ 
        name: 'grid_proj', 
//         searches: [                
//             { field: 'lname', caption: 'Last Name', type: 'text' },
//             { field: 'fname', caption: 'First Name', type: 'text' },
//             { field: 'email', caption: 'Email', type: 'text' },
//         ],
        show: { footer: true },
        /* columnGroups: [
            { caption: 'No', master: true },
            { caption: '사업자번호',master: true },
            { caption: '사업체명',master: true },
            { caption: '구분', master: true },
            { caption: '프로젝트', span: 7 },
            { caption: '프로젝트 진행', span: 5 }
        ], */
        multiSelect: false,
        columns: [                
            { field: 'recid', caption: 'No', size: '40px', sortable: true, attr: 'align=center', resizable: true },
            { field: 'lifnr', caption: '사업자번호', size: '10%', sortable: true, resizable: true },
            { field: 'lifnr_nm', caption: '사업체명', size: '10%', sortable: true, resizable: true },
            { field: 'project_division', caption: '구분', size: '5%', sortable: true, resizable: true,
            	render : function(record, index, col_index){
              		var value = this.getCellValue(index, col_index);
              		if( value=='00' )
              			return '신규';
              		else
              			return '재진행';
            	}},
            { field: 'project_no', caption: '프로젝트코드', size: '15%', hidden: true },
            { field: 'project_nm', caption: '프로젝트명', size: '20%', sortable: true, resizable: true },
            { field: 'netwr', caption: '발주금액', size: '90px', sortable: true, resizable: true },
            { field: 'menge', caption: '수량', size: '90px', sortable: true, resizable: true },
            { field: 'zdue_menge', caption: '잔량', size: '90px', sortable: true, resizable: true },
            { field: 'meins', caption: '단위', size: '90px', sortable: true, resizable: true },
            { field: 'remark', caption: '요구사항', size: '90px', sortable: true, resizable: true },
            { field: 'success_yn', caption: '완료유무', size: '90px', hidden: true },
            { field: 'plan_dt', caption: '설계일자', size: '90px', hidden: true },
            { field: 'eindt', caption: '완료일자', size: '90px', sortable: true, resizable: true },
            { field: 'purdt', caption: '구매일자', size: '90px', sortable: true, resizable: true },
            { field: 'file_group', caption: '도면정보', size: '90px', sortable: true, resizable: true }
        ],
        sortData: [{field: 'plan_dt', direction: 'ASC'}],
		records: [],
		total : 0,
		recordHeight : 30,
		onReload: function(event) { fnSetLoadProjGrid(); },
		onDblClick: function(event) {
	        var rowData = w2ui.grid_proj.records[event.recid-1];
			$("#i_project_no").val(rowData.project_no);
			$("#i_project_nm").val(rowData.project_nm);
			$("#i_lifnr").val(rowData.lifnr);
			$("#i_lifnr_nm").val(rowData.lifnr_nm);
			$("#i_netwr").val(rowData.netwr);
			$("#i_menge").val(rowData.menge);
			$("#i_meins").val(rowData.meins);
			$("#i_zdue_menge").val(rowData.zdue_menge);
			$("#i_eindt").val(rowData.eindt);
			$("#i_purdt").val(rowData.purdt);
			$("#i_file_group").val(rowData.file_group);
			$("#i_remark").val(rowData.emark);
	        $("#modal_proj").modal('hide');
	    },
	    onClick: function (event) {}
    }); 
	fnSetLoadProjGrid();
}

function fnLoadMatnrGrid() {
// 	console.log('fnLoadMatnrGrid()');
	
	var rowArr = [];
	
	$('#grid_matnr').w2grid({ 
		name : 'grid_matnr',
		show : {
			lineNumbers : true,
            footer: true
        },
        multiSelect: false,
        columns : [
			{ field:'matnr', caption:'자재코드', size:'100px'} , 
			{ field:'mtart', caption:'자재유형', size:'100px', style:'text-align:center;', sortable:true,
				render: function(record, index, col_index){
          			var value = this.getCellValue(index, col_index);
          			var rr = "";
          			$.each(selArrObj.MC1010, function(idx, obj){
          				if( value==obj.detail_code ) rr = obj.dcode_nm;
          			});
          			return rr;
				}}, 
			{ field:'meins', caption:'기본단위', size:'100px', style:'text-align:center;', sortable:true}, 
			{ field:'maktx', caption:'자재내역', size:'100px', sortable:true}, 
			{ field:'wrkst', caption:'Spec & Dimension', size:'100px', sortable:true}, 
			{ field:'lvorm', caption:'삭제표시', size:'100px', sortable:true},
			{ field:'kzumw', caption:'등급관리여부', size:'100px', sortable:true},
			{ field:'iloos', caption:'검사여부', size:'100px', sortable:true},
			{ field:'ihivi', caption:'입고후검사', size:'100px', sortable:true},
			{ field:'price', caption:'가격', size:'100px', render:'int', sortable:true}, 
			{ field:'brgew', caption:'총중량', size:'100px', render:'int', sortable:true}, 
			{ field:'ntgew', caption:'순중량', size:'100px', render:'int', sortable:true}, 
			{ field:'gewei', caption:'중량단위', size:'100px', style:'text-align:center', sortable:true}, 
			{ field:'wgbez', caption:'자재그룹명', size:'100px', sortable:true,
				render: function(record, index, col_index){
          			var value = this.getCellValue(index, col_index);
          			var rr = "";
          			$.each(selArrObj.MC1011, function(idx, obj){
          				if( value==obj.detail_code ) rr = obj.dcode_nm;
          			});
          			return rr;
				}} ], 
		sortData: [{field: 'matnr', direction: 'ASC'}],
		records: [],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {fnSetLoadMatnrGrid();},
		onDblClick: function(event) {
	        var rowData = w2ui.grid_matnr.records[event.recid-1];
			$("#i_matnr").val(rowData.matnr);
			$("#i_maktx").val(rowData.maktx);
	        $("#modal_matnr").modal('hide');
	    },
		onClick: function (event) {}
    }); 
	fnSetLoadMatnrGrid();
}

function fnLoadVendorGrid(){
//	 console.log(page_url);
	var rowArr = [];
	
	$('#grid_vendor').w2grid({ 
       name: 'grid_vendor',
       show: {
       	selectColumn: false,
			lineNumbers : true,
           footer: true
       },
       columns: [                
			{ field:'lifnr', caption:'거래처코드', size:'80px', style:'text-align:center', frozen: true},
			{ field:'name1', caption:'거래처명', size:'150px', frozen: true},
			{ field:'stenr', caption:'사업자번호', size:'120px', style:'text-align:center'},
			{ field:'smtp_addr', caption:'이메일주소', size:'200px', style:'text-align:center'},
			{ field:'j_1kfrepre', caption:'대표자', size:'100px', style:'text-align:center'},
			{ field:'j_1kftbus', caption:'업태', hidden:true},
			{ field:'j_1kftind', caption:'업종', hidden:true}],
		sortData: [{field: 'lifnr', direction: 'ASC'}],
		records: rowArr,
		onReload: function(event) {
			fnSetLoadVendorGrid();
		},
		onDblClick: function(event) {
	        var rowData = w2ui.grid_vendor.records[event.recid-1];
	        $("#lifnr").val(rowData.stenr);
	        $("#lifnr_nm").val(rowData.name1);
	        $("#modal_vendor").modal('hide');
	    }
	});
	var page_url = "/frontend/hub/selectVendortbl"
		 + "?func_name=" + encodeURIComponent("selectVendortbl")
		 + "&NAME1=" + encodeURIComponent($("#name").val())
		 + "&LIFNR=" + encodeURIComponent($("#code").val());

	w2ui['grid_vendor'].lock('loading...', true);
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
				w2ui['grid_vendor'].records = rowArr;
			}
			w2ui['grid_vendor'].refresh();
			w2ui['grid_vendor'].unlock();
		},complete: function () {}
	});
}

function fnSetLoadVendorGrid(){
	var page_url = "/frontend/hub/selectVendortbl"
				 + "?func_name=" + encodeURIComponent("selectVendortbl")
				 + "&NAME1=" + encodeURIComponent($("#name").val()) 
				 + "&LIFNR=" + encodeURI(encodeURIComponent($("#code").val()));
	
	w2ui['grid_vendor'].lock('loading...', true);
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
				w2ui['grid_vendor'].records = rowArr;
			} else {
				w2ui['grid_vendor'].records = [];
			}
			w2ui['grid_vendor'].refresh();
			w2ui['grid_vendor'].unlock();
		},complete: function () {}
	});
}

function fnSetLoadProjGrid(){
// 	console.log('fnSetLoadProjGrid()');
	var page_url = "/frontend/project_select_popup";
	
	w2ui['grid_proj'].lock('loading...', true);
	var rowArr = [];
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
				
				w2ui['grid_proj'].records = rowArr;
				w2ui['grid_proj'].total = data.rowTotal;
			} else if(data.status == 200 && (data.rows).length == 0) {
				w2ui.grid_proj.clear();
				w2ui['grid_proj'].records = rowArr;
				w2ui['grid_proj'].total = 0;
			}
			w2ui['grid_proj'].refresh();
			w2ui['grid_proj'].unlock();
		},complete: function () {}
	});
}

function fnSetLoadMatnrGrid(){
// 	console.log('fnSetLoadMatnrGrid()');
	
	var page_url = "/frontend/material_master_select_pop"
// 				 + "?matnr=" + encodeURIComponent($("#s_matnr").val())
				 + "?mtart=" + encodeURIComponent('MD1048');
				 + "&maktx=" + encodeURIComponent($("#s_maktx").val())
				 + "&page=" + encodeURIComponent('')
// 				 + "&wgbez=" + encodeURIComponent($("#MC1011").val())
	
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
				if(data.pageTotal == 0){
					$("#pagination").empty();
				} else {
					totalPage = data.pageTotal;
					pagination();
				}
				w2ui['grid_matnr'].records = rowArr;
				w2ui['grid_matnr'].total = data.rowTotal;
			} else if(data.status == 200 && (data.rows).length == 0) {
				w2ui.grid_matnr.clear();
// 				pagination();
// 				$("#pagination").empty();
			}
			w2ui['grid_matnr'].refresh();
			w2ui['grid_matnr'].unlock();
		},complete: function () {}
	});
}

//serch parameter setting
function fnSearchRegListGrid(){
// 	console.log('fnSearchRegListGrid()');
	var page_url = "/file/file_select";
	page_url += "?file_cate=" + encodeURIComponent($("#s_type").val())
	page_url += "&file_nm=" + encodeURIComponent($("#p_filename").val())
// 	page_url += "&creator=" + encodeURIComponent($("#p_creator").val())
	page_url += "&file_del_yn=" + encodeURIComponent('N');
	
	w2ui['grid_reg'].lock('loading...', true);
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
				w2ui['grid_reg'].records = rowArr;
			} else {
				w2ui['grid_reg'].records = [];
			}
			w2ui['grid_reg'].refresh();
			w2ui['grid_reg'].unlock();
		},complete: function () {}
	});
}

//search result grid
function fnLoadRegListGrid(){
	var rowArr = [];
	$('#grid_reg').w2grid({ 
		name: 'grid_reg',
		show: {
			selectColumn: false,
			lineNumbers : true,
			footer: true
		},
		columns: [ 
// 			{ field:'lifnr', caption:'거래처코드', size:'80px', style:'text-align:center', frozen: true},
			{ field : 'file_group', caption:'파일그룹IDX', },
			{ field : 'file_no', caption:'파일NO', hidden:true},
			{ field : 'file_repo', caption:'파일저장소', hidden:true},
			{ field : 'file_path', caption:'파일경로', hidden:true},
			{ field : 'file_name', caption:'파일명'},
			{ field : 'file_ext', caption:'파일확장자', hidden:true},
			{ field : 'file_size', caption:'파일사이즈(KB)'},
			{ field : 'file_del_yn', caption:'삭제여부', hidden:true},
			{ field : 'file_thumnail', caption:'썸네일경로', hidden:true}],
		sortData: [{field: 'file_no', direction: 'ASC'}],
		records: rowArr,
		onReload: function(event) {
			fnSearchRegListGrid();
		},
		onDblClick: function(event) {
	        var rowData = w2ui.grid_reg.records[event.recid-1];
	        $("#p_file_group").val(rowData.file_group);
// 	        $("#vendor_name").val(rowData.name1);
	        $("#modal_print").modal('hide');
	    }
	});
	
	var page_url = "/file/file_select";
		page_url += "?file_cate=" + encodeURIComponent("drw")
// 		page_url += "?file_cate=" + encodeURIComponent($("#s_type").val())
		page_url += "&file_del_yn=" + encodeURIComponent('N');

	w2ui['grid_reg'].lock('loading...', true);
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
				w2ui['grid_reg'].records = rowArr;
			}
			w2ui['grid_reg'].refresh();
			w2ui['grid_reg'].unlock();
		},complete: function () {}
	});
}

function dateNow(){
	var returnObj = {from:'', to:''};
	var now = "";
	var now = new Date()	
	var yyyy = now.getFullYear();
	var firstDayOfMonth = new Date( now.getFullYear(), now.getMonth() , 1 );
	var last = new Date ( firstDayOfMonth.setDate( firstDayOfMonth.getDate() - 1 ) );
	var lastMonth = last.getMonth()+1;
	var mm = now.getMonth()+1;
	var lastDay = new Date(new Date(new Date().setMonth(mm-1)).setDate(0)).getDate();

	mm = lpad(mm+'',2,'0');
	lastMonth = lpad(lastMonth+'',2,'0');
	var from_yy = (lastMonth>mm)?yyyy-1:yyyy;
	returnObj.from = from_yy + "-" + lastMonth + "-01";
	returnObj.to = yyyy + "-" + mm + "-" + lastDay;
		
	return returnObj;
}
</script>
</body>
</html>