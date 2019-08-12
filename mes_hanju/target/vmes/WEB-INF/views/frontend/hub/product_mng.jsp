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
<style>
#caseByCase .nav-pills > li > a {
  border-radius: 4px 4px 0 0 ;
}

.caseByCase .tab-content {
  border : 1px solid #cccccc;
  padding : 5px 15px;
  border-radius: 0 0 4px 4px ;
}

.nav-pills > li.active > a, .nav-pills > li.active > a:hover, .nav-pills > li.active > a:focus {
	color: #000000;
    background-color: #cccccc;
}

.header {
	background-color: #f4f4f4;
	font-weight : bold;
    text-align: center;
}
</style>
<script src="/res/plugins/pagination.js"></script>
<script src="/res/plugins/pagination1.js"></script>
<body class="hold-transition skin-<%=thema%> sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1020" />
		<jsp:param name="selected_menu_cd" value="1062" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        HUB 
        <small>변경점 관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> HUB</a></li><li class="active">변경점 관리</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
    	<div class="row">
    		<div class="col-md-3">
    			<div class="box" style="margin-bottom: 0px;">
					<div class="box-header with-border">
						<h3 class="box-title">Product</h3>
						<div class="box-tools pull-right">
							<div class="input-group input-group-sm" style="width: 100px;float: left;margin-right: 10px;">
			                	<select id="s_dept_cd" class="form-control input-sm">
			                		<option value="">전체</option>
			                		<option value="1110">의료</option>
			                		<option value="1210">광영상</option>
			                	</select>
			                </div>&nbsp;&nbsp;
							<div class="input-group input-group-sm" style="width: 100px;float: left;">
			                	<input type="text" id="s_productNm" name="" class="form-control pull-right" placeholder="그룹명">
			                </div>&nbsp;
			                <button type="button" id="" class="btn btn-primary btn-sm" onclick="searchProduct();">조회</button>
						</div>
					</div>
					<div class="box-body" style="padding: 0px;">
						<div id="grid_pd" style="width: 100%; height: 733px;"></div>
					</div>
				</div>
    		</div>
    		<div class="col-md-9 caseByCase" style="padding-left: 0px;">
    			<ul class="nav nav-pills">
					<li class="active" id="tap1">
						<a href="#case1" data-toggle="tab">생산 버전</a>
					</li>
					<li id="tap2">
						<a href="#case2" data-toggle="tab" onclick="">버전 목록</a>
					</li>
					<li id="tap3">
						<a href="#case3" data-toggle="tab" onclick="">버전 관리</a>
					</li>
				</ul>
				<div class="tab-content" style="height:733px;">
					<div class="tab-pane active" id="case1">
						<input type="hidden" id="t_gr_no" name="t_gr_no">
						<input type="hidden" id="t_gr_seq" name="t_gr_seq">
						<div class="row pull-right" style="padding-right: 20px;padding-bottom:5px;">
				                <button type="button" id="btn_gModal_add" class="btn btn-primary btn-sm" onclick="matnrManager();">자재등록</button>           
						</div>		
						<div class="row">
							<div class="col-md-12">
								<div class="box box-default box-solid">
									<div class="box-body">
										<table class="table">
											<tr>
												<th class="col-md-2 text-center active">그룹명</td>
												<td class="col-md-3"><div id="t_gr_nm" name="t_gr_nm"></div></td>
												<th class="col-md-2 text-center active">사업부 구분</td>
												<td class="col-md-3"><div id="t_dept_cd" name="t_dept_cd"></div></td>
											</tr>
											<tr>
												<th class="col-md-2 text-center active">변경일시</td>
												<td class="col-md-3"><div id="t_change_date" name="t_change_date" style="text-align:center;"></div></td>
												<th class="col-md-2 text-center active">적용일시</td>
												<td class="col-md-3"><div id="t_confirm_date" name="t_confirm_date" style="text-align:center;"></div></td>
											</tr>
											<tr>
												<th class="col-md-2 text-center active" style="height: 50px;">변경내용</td>
												<td colspan="3"><p id="t_change_remark" name="t_change_remark"></p></td>
											</tr>
											<tr>
												<th class="col-md-2 text-center active" style="height: 50px;">변경메모</td>
												<td colspan="3"><p id="t_change_memo" name="t_change_memo"></p></td>
											</tr>
											<tr>
												<th class="col-md-2 text-center active" style="height: 50px;">특이사항</td>
												<td colspan="3"><p id="t_special_note" name="t_special_note"></p></td>
											</tr>
											<tr>
												<th class="col-md-2 text-center active">ECR No.</td>
												<td class="col-md-3"><div id="t_ecr_no" name="t_ecr_no" style="text-align:center;"></div></td>
												<th class="col-md-2 text-center active">RN No.</td>
												<td class="col-md-3"><div id="t_rn_no" name="t_rn_no" style="text-align:center;"></div></td>
											</tr>
											<tr>
												<th class="col-md-2 text-center active">DMR No.</td>
												<td class="col-md-3"><div id="t_dmr_no" name="t_dmr_no" style="text-align:center;"></div></td>
												<th class="col-md-2 text-center active">버전적용유무</td>
												<td class="col-md-3"><input type="checkbox" id="t_apply_yn" name="t_apply_yn" disabled></td>
											</tr>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div id="tab1_pba" style="width: 100%; height: 340px;"></div>
							</div>
							<div class="col-md-6">
								<div id="tab1_fw" style="width: 100%; height: 340px;"></div>
							</div>
						</div>
					</div><!-- end tab-pane case1 -->
					<div class="tab-pane" id="case2">
						<div class="row">
							<div class="col-md-12">
								<div id="grid_verlist" style="width: 100%; height: 720px;"></div>
							</div>
						</div>
					</div><!-- end tab-pane case2 -->
					<div class="tab-pane" id="case3">
						<div class="row">
							<div class="row pull-right" style="padding-right: 20px;">
				                <button type="button" id="btn_gModal_add" class="btn btn-primary btn-sm" onclick="addGroupInfo();">그룹추가</button>
				                <button type="button" id="btn_versionUp" class="btn btn-info btn-sm" onclick="addVersion();">버전추가</button>
				                <button type="button" id="btn_gModal_save" class="btn btn-warning btn-sm" onclick="saveGroupInfo();">저장</button>
							</div>
							<br><br>
							<div class="col-md-12">
							<div class="box box-default box-solid" style="margin-bottom: 5px;">
								<div class="box-body">
									<form id="frm_product" name="frm_product" class="form-horizontal">
									<input type="hidden" id="p_gr_no" name="p_gr_no">
									<input type="hidden" id="p_gr_seq" name="p_gr_seq">
									<table class="table">
										<tr>
											<th class="col-md-2 text-center active">그룹명</td>
											<td class="col-md-4"><input type="text" class="form-control input-sm" id="p_gr_nm" name="p_gr_nm" placeholder=""></td>
											<th class="col-md-2 text-center active">사업부 구분</td>
											<td class="col-md-4">
												<select id="p_dept_cd" name="p_dept_cd" class="form-control input-sm">
													<option value="1110">의료영상</option>
													<option value="1210">광영상</option>
												</select></td>
										</tr>
										<tr>
											<th class="col-md-2 text-center active">DMR No.</th>
											<td class="col-md-2"><input type="input" id="p_dmr_no" name="p_dmr_no" class="form-control input-sm" placeholder=""></td>
											<th class="col-md-2 text-center active">ECR No.</th>
											<td class="col-md-2"><input type="input" id="p_ecr_no" name="p_ecr_no" class="form-control input-sm" placeholder=""></td>
										</tr>
										<tr>
											<th class="col-md-2 text-center active">RN No.</th>
											<td class="col-md-2"><input type="input" id="p_rn_no" name="p_rn_no" class="form-control input-sm" placeholder=""></td>
										</tr>
										<tr>
											<th class="col-md-2 text-center active">변경일시</td>
											<td class="col-md-4"><input type="input" id="p_change_date" name="p_change_date" class="form-control input-sm text-center" placeholder="input date" maxlength="10"></td>
											<th class="col-md-2 text-center active">적용일시</td>
											<td class="col-md-4"><input type="input" id="p_confirm_date" name="p_confirm_date" class="form-control input-sm text-center" placeholder="input date" maxlength="10"></td>
										</tr>
										<tr>
											<th class="col-md-2 text-center active" style="height: 50px;">변경내용<br>
 											<font style="font-size: small; color: gray;">(max:200)</font></th>
											<td class="col-md-4"><textarea id="p_change_remark" name="p_change_remark" class="form-control input-sm" rows="2" maxlength="200"></textarea></td>
											<th class="col-md-2 text-center active" style="height: 50px;">변경사유<br>
 											<font style="font-size: small; color: gray;">(max:200)</font></th>
											<td class="col-md-4"><textarea id="p_change_memo" name="p_change_memo" class="form-control input-sm" rows="2" maxlength="200"></textarea></td>
										</tr>
										<tr>
											<th class="col-md-2 text-center active" style="height: 50px;">특이사항<br>
											<font style="font-size: small; color: gray;">(max:200)</font></th>
											<td class="col-md-4"><textarea id="p_special_note" name="p_special_note" class="form-control input-sm" rows="2" maxlength="200"></textarea></td>
											<th class="col-md-2 text-center active">버전적용유무</th>
											<td class="col-md-4"><input type="checkbox" id="p_apply_yn" name="p_apply_yn"></td>
										</tr>
									</table>
									</form>
								</div>
							</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div class="row pull-right" style="padding: 0px 15px 5px 0px;">
									<button type="button" class="btn btn-default btn-xs" onClick="pbaManager();">편집</button>
								</div>
								<div id="grid_pba_adj" style="width: 100%; height: 280px;"></div>
							</div>
							<div class="col-md-6">
								<div class="row pull-right" style="padding: 0px 15px 5px 0px;">
									<button type="button" class="btn btn-default btn-xs" onClick="fwManager();">편집</button>
								</div>
								<div id="grid_fw_adj" style="width:100%;height:280px;"></div>
							</div>
						</div>
					</div><!-- end tab-pane case3 -->
				</div><!-- end tab content -->
    		</div>
		</div>
   	</section>
    <!-- /.content -->
  </div>
<div class="modal fade" id="modal_pba" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">PBA 추가 /삭제</h4>
        	</div>
			<div class="modal-body" id="">
				<form id="frm_pba" name="frm_pba" class="form-horizontal">
					<div class="row">
						<div class=" col-md-6" style="padding-right: 0px;">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">자재 목록</h3>
									<div class="box-tools pull-right">
										<div class="input-group input-group-sm" style="width: 100px;float: left; margin-right: 10px;">
											<input type="input" id="m_matnr" name="m_matnr" class="form-control input-sm" placeholder="자재코드" maxlength="20">
										</div>
										<div class="input-group input-group-sm" style="width: 100px;float: left; margin-right: 10px;">
											<input type="input" id="m_maktx" name="m_maktx" class="form-control input-sm" placeholder="자재내역" maxlength="20">
										</div>
										<button type="button" id="matSearch" class="btn bg-teal btn-sm" onclick="loadList1();">
											<i class="fa fa-search" aria-hidden="true"></i>
										</button>&nbsp;
<!-- 										<button type="button" id="matSearch" class="btn bg-teal btn-sm" onclick="$('#modal_mat_search').modal('show');"> -->
<!-- 											<i class="fa fa-search" aria-hidden="true"></i> -->
<!-- 										</button>&nbsp; -->
										<button type="button" id="" class="btn btn-warning btn-sm" onclick="addItnbrDetail();">
							               <i class="fa fa-forward" aria-hidden="true"></i></button>
									</div>
								</div>
								<div class="box-body" style="padding:0px;">
									<div id="grid_materiallist" style="width:100%; height:500px;"></div>
									<div id="pagination1" class="text-center"style=" width:100%;height:40px;"></div>
								</div>
							</div>
						</div>
						<div class=" col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">PBA 정보</h3>
									<div class="box-tools pull-right">
						                <button type="button" id="" class="btn btn-warning btn-sm" onclick="deleteItnbrDetail();">
											<i class="fa fa-backward" aria-hidden="true"></i></button>
<!-- 						                <button type="button" id="btn_mcode_add" class="btn btn-danger btn-sm" onclick="appendGridPba();">추가</button> -->
<!-- 						                <button type="button" id="btn_mcode_info" class="btn btn-warning btn-sm" onclick="deleteGridPba();">삭제</button> -->
									</div>
								</div>
								<div id="dv_grid_pba" class="box-body" style="height:480px; padding:0px;">
									<div id="grid_pba" style="width:100%;height:540px;"></div>
<!-- 									<div id="pagination1" class="text-center"style=" width:100%;height:40px;"></div> -->
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_mcode_save" class="btn btn-success btn-sm" onclick="saveGridPba();">적용</button>
<!-- 					<button type="button" id="btn_mcode_del" class="btn btn-danger">삭제</button> -->
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>  
<div class="modal fade" id="modal_fw" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">F/W 추가 /삭제</h4>
        	</div>
			<div class="modal-body" id="">
				<form id="frm_fw" name="frm_fw" class="form-horizontal">
					<div class="row">
						<div class=" col-md-12">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">F/W 정보</h3>
									<div class="box-tools pull-right">
						                <button type="button" id="" class="btn btn-danger btn-sm" onclick="appendGridFw();">추가</button>
						                <button type="button" id="" class="btn btn-warning btn-sm" onclick="deleteGridFw();">삭제</button>
									</div>
								</div>
								<div id="dv_grid_fw" class="box-body" style="height:300px;">
									<div id="grid_fw" style="width:100%;height:100%;"></div>
<!-- 									<table id="grid_fw" style="width:100%;'"></table> -->
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveGridFw();">적용</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modal_version" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">버전 상세정보</h4>
        	</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="box box-default box-solid">
							<div class="box-body">
								<input type="hidden" id="v_gr_no" name="v_gr_no">
								<input type="hidden" id="v_gr_seq" name="v_gr_seq">
								<table class="table">
									<tr>
										<th class="col-md-2 text-center active">그룹명</td>
										<td class="col-md-3"><div id="v_gr_nm" name="v_gr_nm"></div></td>
										<th class="col-md-2 text-center active">사업부 구분</td>
										<td class="col-md-3"><div id="v_dept_cd" name="v_dept_cd"></div></td>
									</tr>
									<tr>
										<th class="col-md-2 text-center active">변경일시</td>
										<td class="col-md-3"><div id="v_change_date" name="v_change_date" style="text-align:center;"></div></td>
										<th class="col-md-2 text-center active">적용일시</td>
										<td class="col-md-3"><div id="v_confirm_date" name="v_confirm_date" style="text-align:center;"></div></td>
									</tr>
									<tr>
										<th class="col-md-2 text-center active" style="height: 50px;">변경내용</td>
										<td colspan="3"><p id="v_change_remark" name="v_change_remark"></p></td>
									</tr>
									<tr>
										<th class="col-md-2 text-center active" style="height: 50px;">변경메모</td>
										<td colspan="3"><p id="v_change_memo" name="v_change_memo"></p></td>
									</tr>
									<tr>
										<th class="col-md-2 text-center active" style="height: 50px;">특이사항</td>
										<td colspan="3"><p id="v_special_note" name="v_special_note"></p></td>
									</tr>
									<tr>
										<th class="col-md-2 text-center active">ECR No.</td>
										<td class="col-md-3"><div id="v_ecr_no" name="v_ecr_no" style="text-align:center;"></div></td>
										<th class="col-md-2 text-center active">RN No.</td>
										<td class="col-md-3"><div id="v_rn_no" name="v_rn_no" style="text-align:center;"></div></td>
									</tr>
									<tr>
										<th class="col-md-2 text-center active">DMR No.</td>
										<td class="col-md-3"><div id="v_dmr_no" name="v_dmr_no" style="text-align:center;"></div></td>
										<th class="col-md-2 text-center active">버전적용유무</td>
										<td class="col-md-3"><input type="checkbox" id="v_apply_yn" name="v_apply_yn" disabled></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<div id="grid_pba_adj_v" style="width:100%;height:300px;"></div>
					</div>
					<div class="col-md-6">
						<div id="grid_fw_adj_v" style="width:100%;height:300px;"></div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-success btn-sm" onclick="applyVersion();">버전적용</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- material Search Condition -->
<div class="modal fade" id="modal_mat_search" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">자재목록 검색 조건</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="text-center" style="font-weight:bold; color:blue;">
					 모든 조건 검색은 Like 검색을  사용합니다. (검색 입력정보를 포함한 데이터 검색)
				</div>
				<form id="frm_search_condition" name="frm_search_condition" class="form-horizontal">
					<div class="form-group">
						<label for="m_matnr" class="col-sm-3 control-label">자재코드</label>
						<div class="col-sm-9">
							<input type="input" id="m_matnr" name="m_matnr" class="form-control input-sm"  maxlength="20">
						</div>
					</div>
					<div class="form-group">
						<label for="m_wrkst" class="col-sm-3 control-label">자재명</label>
						<div class="col-sm-9">
							<input type="input" id="m_wrkst" name="m_wrkst" class="form-control input-sm"  maxlength="20">
						</div>
					</div>
					<div class="form-group">
						<label for="m_maktx" class="col-sm-3 control-label">자재내역</label>
						<div class="col-sm-9">
							<input type="input" id="m_maktx" name="m_maktx" class="form-control input-sm"  maxlength="20">
						</div>
					</div>
				</form>
			</div><!-- end modal body -->
			<div class="modal-footer">
				<div class="text-center">
		        <button type="button" class="btn btn-sm btn-primary" onclick="loadList1();">검색</button>
		        <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">닫기</button>
		        </div>
			</div>
		</div><!-- end modal-content -->
	</div><!-- end modal dialog -->
</div>

<div class="modal fade" id="modal_matnr" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
				<h4 class="modal-title" id="modal_code_title">DMR 자재 등록</h4>
        	</div>
			<div class="modal-body" id="">
				<form id="frm_matnr" name="frm_matnr" class="form-horizontal">
					<div class="row">
						<div class=" col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">자재 목록</h3>
									<div class="box-tools pull-right">
										<div class="input-group input-group-sm" style="width: 150px;float: left;">
						                  <input type="text" id="itnbr_search_popup" name="itnbr_search" class="form-control pull-right" placeholder="matnr. Search">
											<div class="input-group-btn">
						                    <button type="button" id="btn_itnbr_search_popup" class="btn btn-default" onclick="loadList();"><i class="fa fa-search"></i></button>
						                  </div><!-- searchItnbrpopup(); -->
						                </div>
						                &nbsp;|
										<button type="button" id="" class="btn btn-warning btn-sm" onclick="graddItnbrDetail();">
							               <i class="fa fa-forward" aria-hidden="true"></i></button>
									</div>
								</div>
								<div class="box-body">
									<div id="grid_grmateriallist" style="width:100%;height:500px;"></div>
									<div id="pagination" class="text-center"style=" width:100%;height:40px;"></div>
								</div>
							</div>
						</div>
						<div class=" col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">등록 자재정보</h3>
									<div class="box-tools pull-right">
						                <button type="button" id="" class="btn btn-warning btn-sm" onclick="grdeleteItnbrDetail();">
											<i class="fa fa-backward" aria-hidden="true"></i></button>
<!-- 						                <button type="button" id="btn_mcode_add" class="btn btn-danger btn-sm" onclick="appendGridPba();">추가</button> -->
<!-- 						                <button type="button" id="btn_mcode_info" class="btn btn-warning btn-sm" onclick="deleteGridPba();">삭제</button> -->
									</div>
								</div>
								<div class="box-body">
									<div id="grid_addItnbr_list" style="width:100%;height:540px"></div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_dmr_save" class="btn btn-success btn-sm" onclick="saveMatnrGrid();">적용</button>
					<button type="button" id="btn_dmr_cancel" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div> <!-- end modal div -->
  <!-- /.content-wrapper -->
  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>
<!-- ./wrapper -->
<script type="text/javascript">
//for pagination
var page = 1; 		// 화면에서 사용할 page
var pageNum = 0; 	// 서버에 넘겨줄 page -> mysql 은 0 부터 시작
var rowPerPage = 20;
var rowLength = 0;
var totalPage = 0;
var cntRowPagination = 5;	// << 1 2 3 4 5 >> 

var addMatObj = {};
// var addgrMatObj = {};

$(function($) {
	initComponent();
})

function initComponent() {
	$("#p_change_date, #p_confirm_date").datepicker({
		language: "kr",
		todayHighlight: true,
		format: "yyyy.mm.dd",
		autoclose: true
	}).on('changeDate',function(selected){
		 newDate = new Date(selected.date);
		// Extract the current date from Date object
		newDate.setDate(newDate.getDate());
		chDateStr = $.datepicker.formatDate('yymmdd',selected.date);
	});
	
	$("#tap1").click(function(){
		w2ui.tab1_pba.resize();
		w2ui.tab1_pba.refresh();
		reloadTab1_pba();
		w2ui.tab1_fw.resize();
		w2ui.tab1_fw.refresh();
		reloadTab1_fw();
	});
	
	$("#tap2").click(function(){
		var select;
		if( (w2ui.grid_pd.getSelection()).length==0 )
			w2ui.grid_pd.click(1);
		
		select = w2ui.grid_pd.get(w2ui.grid_pd.getSelection())[0];
		reloadGridVerlist(select.recid);
	});
	
	$("#tap3").click(function(){
		w2ui.grid_pba_adj.resize();
		w2ui.grid_pba_adj.refresh();
		w2ui.grid_fw_adj.resize();
		w2ui.grid_fw_adj.refresh();
		reloadPbaAdjGrid();
		reloadFwAdjGrid();
// 		resizeJqGrid("grid_fw_adj", false);
// 		resizeJqGrid("grid_materiallist", false);
	});
	initScreenSizeModal();
	
	initGridProduct();
	// tap1
	initTab1_pba();
	initTab1_fw();
	
	initGridVerlist();
	initPbaAdjVGrid();
	initFwAdjVGrid();
	
	initFwGrid();
	initPbaGrid();
	
	initPbaAdjGrid();
	initFwAdjGrid();
	initMaterialGrid();
	initGrMaterialGrid();
	initNewItnbrGrid();
}

// main product grid init
function initGridProduct() {
// 	console.info('initGridProduct()');
	$("#grid_pd").w2grid({
		name : 'grid_pd',
		show : {
			lineNumbers : true,
            footer: true
        },
        columns : [
			{ field: 'gr_no', caption:'gr_no', hidden:true},
			{ field: 'gr_seq', caption:'gr_seq', hidden:true},
			{ field: 'gr_nm', caption:'그룹명', size:'150px', sortable:true, frozen:true},
			{ field: 'dept_cd', caption:'사업부구분', size:'70px', sortable:true, render:function (record, index, col_index) {
				return (record.dept_cd=='1110')?'의료':'광영상';
			}, style:'text-align:center'},
			{ field: 'change_date', caption:'변경일', size:'100px', sortable:true, style:'text-align:center', 
				render:function (record, index, col_index) {
					var date = record.change_date;
					if( date!=''||date!=null||date!=undefined )
						return date.substring(0,4)+'-'+date.substring(4,6)+'-'+date.substring(6,8);
				}},
			{ field: 'confirm_date', caption:'적용일', size:'100px', sortable:true, style:'text-align:center', 
				render:function (record, index, col_index) {
					var date = record.confirm_date;
					if( date!=''||date!=null||date!=undefined )
						return date.substring(0,4)+'-'+date.substring(4,6)+'-'+date.substring(6,8);
				}},
			{ field: 'change_remark', caption:'change_remark', hidden:true},
			{ field: 'change_memo', caption:'change_memo', hidden:true},
			{ field: 'special_note', caption:'special_note', hidden:true},
			{ field: 'ecr_no', caption:'ECR_NO', hidden:true},
			{ field: 'rn_no', caption:'RN_NO', hidden:true},
			{ field: 'dmr_no', caption:'DMR_NO', hidden:true},
			{ field: 'apply_yn', caption:'apply_yn', hidden:true},
			{ field: 'ukey', caption:'ukey', hidden:true}],
		sortData: [{field: 'gr_nm', direction: 'ASC'}],
		records: [],
		recordHeight : 30,
		onSelect: function(event) {
			reloadGridVerlist(event.recid);
			setGroupData(event.recid);
			w2ui.tab1_pba.resize();
			w2ui.tab1_pba.refresh();
			reloadTab1_pba();
			w2ui.tab1_fw.resize();
			w2ui.tab1_fw.refresh();
			reloadTab1_fw();
			
			w2ui.grid_pba_adj.resize();
			w2ui.grid_pba_adj.refresh();
			w2ui.grid_fw_adj.resize();
			w2ui.grid_fw_adj.refresh();
			reloadPbaAdjGrid();
			reloadFwAdjGrid();
		}
	});
	searchProduct();
}

function initTab1_pba() {
//  	console.log('initTab1_pba()');
	$("#tab1_pba").w2grid({
		name : 'tab1_pba',
		header : 'PBA List',
		show : {
			header : true,
			lineNumbers : true,
	        footer: true
	    },
		columns : [
	        { field : 'pba_gubun', caption:'구분', size:'15%'},
	        { field : 'pba_matnr', caption:'자재명', size:'25%'},
	        { field : 'pba_maktx', caption:'자재내역', size:'30%'},
	        { field : 'pba_wrkst', caption:'SPEC.', size:'30%'},
	        { field : 'pba_seq', caption:'pba_seq', hidden:true}
		],
		recordHeight : 30,
		sortData: [{field: 'pba_matnr', direction: 'ASC'}],
		records: [],
		total : 0	
	});
}

function reloadTab1_pba() {
//   	console.log('reloadTab1_pba()');
	var page_url = "/frontend/hub/dmrPba_select"
				+ "?gr_no=" + encodeURIComponent($("#t_gr_no").val())
				+ "&gr_seq=" + encodeURIComponent($("#t_gr_seq").val());
	w2ui['tab1_pba'].lock('loading...', true);
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
				w2ui['tab1_pba'].records = rowArr;
				w2ui['tab1_pba'].total = rowArr.length;
			}else   {
				w2ui['tab1_pba'].clear();
			}
			w2ui['tab1_pba'].refresh();
			w2ui['tab1_pba'].unlock();
		},complete: function () {}
	});
}

function initTab1_fw() {
// 	console.log('initTab1_fw()');
	$("#tab1_fw").w2grid({
		name : 'tab1_fw',
		header : 'F/W List',
		show : {
			header : true,
			lineNumbers : true,
	        footer: true
	    },
		columns : [
	        { field:'fw_gubun', caption:'구분', size:'20%'},
	        { field:'fw_type', caption:'타입', size:'40%'},
	        { field:'fw_info', caption:'버전정보', size:'40%'},
	        { field:'fw_seq', caption:'seq', hidden:true}
		],
		recordHeight : 30,
		sortData: [{field: 'pba_matnr', direction: 'ASC'}],
		records: [],
		total : 0	
	});
}

function reloadTab1_fw() {
// 	console.log('reloadTab1_fw()');
	var page_url = "/frontend/hub/dmrFw_select"
				+ "?gr_no=" + encodeURIComponent($("#t_gr_no").val())
				+ "&gr_seq=" + encodeURIComponent($("#t_gr_seq").val());
	w2ui['tab1_fw'].lock('loading...', true);
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
				w2ui['tab1_fw'].records = rowArr;
				w2ui['tab1_fw'].total = rowArr.length;
			}else   {
				w2ui['tab1_fw'].clear();
			}
			w2ui['tab1_fw'].refresh();
			w2ui['tab1_fw'].unlock();
		},complete: function () {}
	});
}

// version list grid init
function initGridVerlist() {
// 	console.info('initGridVerlist()');
	
	var rowArr = [];
	$("#grid_verlist").w2grid({
		name : 'grid_verlist',
		show : {
			lineNumbers : true,
            footer: true
        },
        columns : [
			{ field:'gr_no', caption:'gr_no', hidden:true},
			{ field:'gr_seq', caption:'버전정보', sortable:true, size:'140px'},
			{ field:'gr_nm', caption:'그룹명', sortable:true, size:'200px'},
			{ field:'dept_cd', caption:'사업부구분', sortable:true, render:function (record, index, col_index) {
				return (record.dept_cd=='1110')?'의료':'광영상';
			}, style:'text-align:center', hidden:true},
			{ field:'change_date', caption:'변경일', sortable:true, size:'100px', style:'text-align:center', 
				render:function (record, index, col_index) {
					var date = record.change_date;
					if( date!=''||date!=null||date!=undefined )
						return date.substring(0,4)+'-'+date.substring(4,6)+'-'+date.substring(6,8);
				}},
			{ field:'confirm_date', caption:'적용일', sortable:true, size:'100px', style:'text-align:center', 
				render:function (record, index, col_index) {
					var date = record.confirm_date;
					if( date!=''||date!=null||date!=undefined )
						return date.substring(0,4)+'-'+date.substring(4,6)+'-'+date.substring(6,8);
				}},
			{ field:'change_remark', caption:'변경내용'},
			{ field:'change_memo', caption:'change_memo', hidden:true},
			{ field:'special_note', caption:'special_note', hidden:true},
			{ field:'ecr_no', caption:'ECR No', size:'110px',  sortable:true, style:'text-align:center'},
			{ field:'rn_no', caption:'RN No', size:'70px', sortable:true, render:'int'},
			{ field:'dmr_no', caption:'DMR No', size:'70px', sortable:true, render:'int'},
			{ field:'apply_yn', caption:'적용여부', size:'70px', sortable:true, style:'text-align:center'},
			{ field:'ukey', caption:'ukey', sortable:true, hidden:true}],
		sortData: [{field: 'gr_seq', direction: 'ASC'}],
		records: [],
		recordHeight : 30,
		onLoad: function(event) {
			console.log(event);
		},
		onSelect: function(event) {
			event.onComplete = function () {
				showVersionDetail(event.recid);
				$("#modal_version").modal('show');
				setTimeout(function(){
					w2ui.grid_pba_adj_v.resize();
					w2ui.grid_pba_adj_v.refresh();
					w2ui.grid_fw_adj_v.resize();
					w2ui.grid_fw_adj_v.refresh();
				}, 200);
			}
		}
	}); 
}

// version list grid reload
function reloadGridVerlist(recid) {
// 	console.info('reloadGridVerlist()',recid);
	if( recid==undefined )
		recid = 1;
	
	var pdGridRowData = w2ui.grid_pd.get(recid);
	var page_url = "/frontend/hub/dmrVersion_select"
				 + "?gr_no=" + encodeURIComponent(pdGridRowData.gr_no);
	
	w2ui['grid_verlist'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					if( row.apply_yn=='Y' ) {
		    			$("#p_gr_no").val(row.gr_no);
		    	     	$("#p_gr_seq").val(row.gr_seq);
		    	    	$("#p_gr_nm").val(row.gr_nm);
		    	    	$("#p_dept_cd").val(row.dept_cd);
		    	    	$("#p_change_date").val(strWithYYMMDD(row.change_date));
		    	    	$("#p_confirm_date").val(strWithYYMMDD(row.confirm_date));
		    	    	$("#p_change_remark").val(row.change_remark);
		    	    	$("#p_change_memo").val(row.change_memo);
		    	    	$("#p_special_note").val(row.special_note);
		    	    	$("#p_ecr_no").val(row.ecr_no);
		    	    	$("#p_rn_no").val(row.rn_no);
		    	    	$("#p_dmr_no").val(row.dmr_no);
		    	    	if( row.apply_yn=="Y" )
		    	    		$("#p_apply_yn").prop('checked', true);
		    	    	else
		    	    		$("#p_apply_yn").prop('checked', false);
		    		}
				});
				w2ui['grid_verlist'].records = rowArr;
				w2ui['grid_verlist'].total = rowArr.length;
			}
			w2ui['grid_verlist'].refresh();
			w2ui['grid_verlist'].unlock();
		},complete: function () {}
	});
}

function showVersionDetail(recid) {
// 	console.log('showVersionDetail()');
	var rowData = w2ui.grid_verlist.get(recid);
	$("#v_gr_no").text(rowData.gr_no);
 	$("#v_gr_seq").text(rowData.gr_seq);
	$("#v_gr_nm").text(rowData.gr_nm);
	$("#v_dept_cd").text( (rowData.dept_cd=='1110')?'의료영상':'광영상' );
	$("#v_change_date").text(strWithYYMMDD(rowData.change_date));
	$("#v_confirm_date").text(strWithYYMMDD(rowData.confirm_date));
	$("#v_change_remark").text(rowData.change_remark);
	$("#v_change_memo").text(rowData.change_memo);
	$("#v_special_note").text(rowData.special_note);
	$("#v_ecr_no").text(rowData.ecr_no);
	$("#v_rn_no").text(rowData.rn_no);
	$("#v_dmr_no").text(rowData.dmr_no);
	if( rowData.apply_yn=="Y" )
		$("#v_apply_yn").prop('checked', true);
	else
		$("#v_apply_yn").prop('checked', false);
	
	reloadPbaAdjVGrid();
	reloadFwAdjVGrid();
}

// row selected -> set data(tab1, tab3)
function setGroupData(recid) {
// 	console.log('setGroupData(',recid,')');
	var rowData = w2ui.grid_pd.get(recid);
	// #case1
	$("#t_gr_no").val(rowData.gr_no);
	$("#t_gr_seq").val(rowData.gr_seq);
	$("#t_gr_nm").text(rowData.gr_nm);
	var dept_nm = "광영상";
	if( rowData.dept_cd=="1110" )
		dept_nm = "의료영상";
	$("#t_dept_cd").text(dept_nm);
	var change_date = rowData.change_date;
	$("#t_change_date").text(change_date.substring(0,4)+"."+change_date.substring(4,6)+"."+change_date.substring(6,8));
	var confirm_date = rowData.confirm_date;
	$("#t_confirm_date").text(confirm_date.substring(0,4)+"."+confirm_date.substring(4,6)+"."+confirm_date.substring(6,8));
	$("#t_change_remark").text(rowData.change_remark);
	$("#t_change_memo").text(rowData.change_memo);
	$("#t_special_note").text(rowData.special_note);
	$("#t_ecr_no").text(rowData.ecr_no);
	$("#t_rn_no").text(rowData.rn_no);
	$("#t_dmr_no").text(rowData.dmr_no);
	if( rowData.apply_yn=="Y" )
		$("#t_apply_yn").prop('checked', true);
	else
		$("#t_apply_yn").prop('checked', false);
	
	// #case2
	$("#t3_gr_no").val(rowData.gr_no);
	$("#t3_gr_seq").val(rowData.gr_seq);
	$("#t3_gr_nm").text(rowData.gr_nm);
	var dept_nm = "광영상";
	if( rowData.dept_cd=="1110" )
		dept_nm = "의료영상";
	$("#t3_dept_cd").text(dept_nm);
	$("#t3_ecr_no").text(rowData.ecr_no);
	$("#t3_rn_no").text(rowData.rn_no);
	$("#t3_dmr_no").text(rowData.dmr_no);

	// #case3
	$("#p_gr_no").val(rowData.gr_no);
 	$("#p_gr_seq").val(rowData.gr_seq);
	$("#p_gr_nm").val(rowData.gr_nm);
	$("#p_dept_cd").val(rowData.dept_cd);
	$("#p_change_date").val(strWithYYMMDD(rowData.change_date));
	$("#p_confirm_date").val(strWithYYMMDD(rowData.confirm_date));
	$("#p_change_remark").val(rowData.change_remark);
	$("#p_change_memo").val(rowData.change_memo);
	$("#p_special_note").val(rowData.special_note);
	$("#p_ecr_no").val(rowData.ecr_no);
	$("#p_rn_no").val(rowData.rn_no);
	$("#p_dmr_no").val(rowData.dmr_no);
	if( rowData.apply_yn=="Y" )
		$("#p_apply_yn").prop('checked', true);
	else
		$("#p_apply_yn").prop('checked', false);
}

// 제품 이름으로 검색
function searchProduct() {
// 	console.log('searchProduct()');
	var page_url = "/frontend/hub/dmrMaster_select"
		 		 + "?gr_nm=" + encodeURIComponent($("#s_productNm").val())
		 		 + "&dept_cd=" + encodeURIComponent($("#s_dept_cd").val());
	var key = w2ui.grid_pd.getSelection()[0];
// 	console.log(key);
	w2ui['grid_pd'].clear();
	w2ui['grid_pd'].lock('loading...', true);
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
				w2ui['grid_pd'].records = rowArr;
			}
			w2ui['grid_pd'].refresh();
			w2ui['grid_pd'].unlock();
			if( key!=undefined )
				w2ui['grid_pd'].click(key);
		},complete: function () {}
	});
}

// group info save
function saveGroupInfo() {
// 	console.log('saveGroupInfo()');
	// master info
	var formData = $("#frm_product").serializeArray();
	var formJson = {};
	$.each(formData, function(idx, comp){
		formJson[comp.name] = comp.value;
	});
	formJson.p_change_date = replaceAll(formJson.p_change_date, ".", "");
	formJson.p_confirm_date = replaceAll(formJson.p_confirm_date, ".", "");
	var apply = "N";
	if( $("input:checkbox[id='p_apply_yn']").is(":checked") )	apply = "Y"
	formJson.p_apply_yn = apply; 
	// pba info
	var pbaData = w2ui.grid_pba_adj.records;
	if( pbaData.length>0 ){
		$.each(pbaData, function(idx, row){
			if( row.w2ui!=undefined ){
				var change = row.w2ui.changes;
				if( change.pba_gubun!=undefined )
					row.pba_gubun = change.pba_gubun;
				if( change.pba_matnr!=undefined )
					row.pba_matnr = change.pba_matnr;
				if( change.pba_maktx!=undefined )
					row.pba_maktx = change.pba_maktx;
				if( change.pba_wrkst!=undefined )
					row.pba_wrkst = change.pba_wrkst;
				if( change.pba_seq!=undefined )
					row.pba_seq = change.pba_seq;
			}
			row.pba_seq = row.recid;
		});
	}
	
	// fw info
	var fwData = w2ui.grid_fw_adj.records;
	if( fwData.length>0 ){
		$.each(fwData, function(idx, row){
			if( row.w2ui!=undefined ){
				var change = row.w2ui.changes;
				if( change.fw_gubun!=undefined )
					row.fw_gubun = change.fw_gubun;
				if( change.fw_type!=undefined )
					row.fw_type = change.fw_type;
				if( change.fw_info!=undefined )
					row.fw_info = change.fw_info;
				if( change.fw_seq!=undefined )
					row.fw_seq = change.fw_seq;
			}
			row.fw_seq = row.recid;
		});
	}
	
	var gubun = "";
	if ( $("#p_gr_no").val()=='' )
		gubun = "addGroup";
		
	var pageURI = "/frontend/hub/dmrMaster_insert";
	var postData = "masterData=" + encodeURIComponent(JSON.stringify(formJson))
				 + "&gubun=" + encodeURIComponent(gubun);
	if(pbaData.length==0) 
		postData += "&pbaData=";
	else
		postData += "&pbaData=" + encodeURIComponent(JSON.stringify(pbaData));
	
	if(fwData.length==0) 
		postData += "&fwData=";
	else
		postData += "&fwData=" + encodeURIComponent(JSON.stringify(fwData));
	
//  	console.log(formJson);
//  	console.log(pbaData);
//  	console.log(fwData);
	var key = w2ui.grid_pd.getSelection()[0];
	console.log(key);
	
// 	return;
	$.ajax({
		url: pageURI,
		data: postData,
		async : false,
		type: "POST",
		success:function(data, textStatus, jqXHR){
			if(data.status == "200") {
				fnMessageModalAlert("결과", "정보를 성공적으로 추가하였습니다.");
				searchProduct();
// 				console.log($("#grid_pd").getRowData());
				w2ui.grid_pd.click(key);
				reloadPbaAdjGrid();
				reloadFwAdjGrid();
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

//group info add
function addGroupInfo() {
// 	console.log('addGropInfo()');
	fnMessageModalConfirm("확인하세요", "새로운 정보를 등록하시겠습니까?<br>입력하던 데이터는 사라집니다.", function(chk){
		if(chk){
			$("#frm_product")[0].reset();
			$("#p_gr_no").val(''); 
			$("#p_gr_seq").val('');
			w2ui.grid_pba_adj.clear();
			w2ui.grid_fw_adj.clear();
// 			$("#grid_pd").jqGrid('resetSelection');
		}else
			return;
	});
}

function matnrManager() {
// 	console.log('matnrManager()');
	var gr_no = $("#t_gr_no").val(); 
	var gr_seq = $("#t_gr_seq").val(); 
	if( gr_no=="" || gr_seq=="" ) {
		fnMessageModalAlert("확인하세요", "기본정보가 등록되어 있어야 추가할 수 있습니다.");
		return;
	}
	
	$("#modal_matnr").modal('show');
	setTimeout(function(){
		w2ui.grid_grmateriallist.resize();
		w2ui.grid_grmateriallist.refresh();
		w2ui.grid_addItnbr_list.resize();
		w2ui.grid_addItnbr_list.refresh();
	}, 200);
	reloadNewItnbrGrid();
}

function pbaManager() {
// 	console.log('pbaManager()');

	var gr_no = $("#p_gr_no").val(); 
	var gr_seq = $("#p_gr_seq").val();
	
	if( gr_no=="" || gr_seq=="" ) {
		fnMessageModalAlert("Warning", "기본정보가 등록되어 있어야 추가할 수 있습니다.");
		return;
	}
	w2ui.grid_pba.clear();
	var oData = w2ui.grid_pba_adj.records;
	w2ui.grid_pba.add(oData);
	$("#modal_pba").modal('show');
	setTimeout(function() {
		w2ui.grid_pba.resize();
		w2ui.grid_pba.refresh();	
		w2ui.grid_materiallist.resize();
		w2ui.grid_materiallist.refresh();	
	}, 200);
}

function fwManager() {
// 	console.log('fwManager()');
// 	initPbaGrid();
	var gr_no = $("#p_gr_no").val(); 
	var gr_seq = $("#p_gr_seq").val(); 
	if( gr_no=="" || gr_seq=="" ) {
		fnMessageModalAlert("확인하세요", "기본정보가 등록되어 있어야 추가할 수 있습니다.");
		return;
	}
	w2ui.grid_fw.clear();
// 	var oData = w2ui.grid_fw_adj.records;
	w2ui.grid_fw.add(w2ui.grid_fw_adj.records);	// all editable
	$("#modal_fw").modal('show');
	setTimeout(function(){
		w2ui.grid_fw.resize();
		w2ui.grid_fw.refresh();
	}, 200);
}

function initPbaAdjVGrid() {
// 	console.log('initPbaAdjVGrid()');
	$("#grid_pba_adj_v").w2grid({
		name : 'grid_pba_adj_v',
		header : 'PBA 정보',
		show: {
			header : true	
		},
		columns : [ 
	        { field:'pba_gubun', caption:'구분', size:'20%', editable:{ type: 'text'}},
	        { field:'pba_matnr', caption:'자재명', size:'30%', editable:{ type: 'text'}},
	        { field:'pba_maktx', caption:'자재내역', size:'30%', editable:{ type: 'text'}},
	        { field:'pba_wrkst', caption:'SPEC.', size:'20%', editable:{ type: 'text'}},
	        { field:'pba_seq', caption:'pba_seq', hidden:true} ],
        sortData: [{field: 'pba_gubun', direction: 'ASC'}],
		records: [],
		recordHeight : 30
	}); 
}

function reloadPbaAdjVGrid() {
// 	console.log('reloadPbaAdjVGrid()');
	var selectVer = w2ui.grid_verlist.get(w2ui.grid_verlist.getSelection()[0]);
	var page_url = "/frontend/hub/dmrPba_select"
				+ "?gr_no=" + encodeURIComponent(selectVer.gr_no)
				+ "&gr_seq=" + encodeURIComponent(selectVer.gr_seq);
	
	w2ui['grid_pba_adj_v'].lock('loading...', true);
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
				w2ui.grid_pba_adj_v.records = rowArr;
				w2ui.grid_pba_adj_v.total = rowArr.rowTotal;
			}else   {
				w2ui['grid_pba_adj_v'].clear();
			}
			w2ui['grid_pba_adj_v'].refresh();
			w2ui['grid_pba_adj_v'].unlock();
		},complete: function () {}
	});
}

function initPbaAdjGrid() {
// 	console.log('initPbaAdjGrid()');
	$("#grid_pba_adj").w2grid({
		name : 'grid_pba_adj',
        header : 'PBA List',
		show : {
			header : true,
			lineNumbers : true,
            footer: true
        },
        columns : [
			{ field:'pba_gubun', caption:'구분', size:'15%'},
	        { field:'pba_matnr', caption:'자재명', size:'25%'},
	        { field:'pba_maktx', caption:'자재내역', size:'30%'},
	        { field:'pba_wrkst', caption:'SPEC.', size:'30%'},
	        { field:'pba_seq', caption:'pba_seq', hidden:true} ],
		recordHeight : 30,
		sortData: [{field: 'pba_matnr', direction: 'ASC'}],
		records: [],
		total : 0
	});
}

function reloadPbaAdjGrid() {
// 	console.log('reloadPbaAdjGrid()');
	var page_url = "/frontend/hub/dmrPba_select"
				+ "?gr_no=" + encodeURIComponent($("#p_gr_no").val())
				+ "&gr_seq=" + encodeURIComponent($("#p_gr_seq").val());
	w2ui['grid_pba_adj'].lock('loading...', true);
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
				w2ui.grid_pba_adj.records = rowArr;
				w2ui.grid_pba_adj.total = rowArr.length;
			}else   {
				w2ui['grid_pba_adj'].clear();
			}
			w2ui['grid_pba_adj'].refresh();
			w2ui['grid_pba_adj'].unlock();
		},complete: function () {}
	});
}

function initFwAdjVGrid() {
// 	console.log('initFwAdjVGrid()');
	$("#grid_fw_adj_v").w2grid({
		name : 'grid_fw_adj_v',
		header : 'F/W 정보',
		show : {
			header : true
		},
		columns : [
	        { field:'fw_gubun', caption:'구분', size:'30%'},
	        { field:'fw_type', caption:'타입', size:'30%'},
	        { field:'fw_info', caption:'버전정보', size:'40%'},
	        { field:'fw_seq', caption:'seq', hidden:true}
		],
		recordHeight : 30
	}); 
}

function reloadFwAdjVGrid() {
// 	console.log('reloadFwAdjVGrid()');
	var selectVer = w2ui.grid_verlist.get(w2ui.grid_verlist.getSelection()[0]);
	var page_url = "/frontend/hub/dmrFw_select"
				+ "?gr_no=" + encodeURIComponent(selectVer.gr_no)
				+ "&gr_seq=" + encodeURIComponent(selectVer.gr_seq);
	w2ui['grid_fw_adj_v'].lock('loading...', true);
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
				w2ui.grid_fw_adj_v.records = rowArr;
				w2ui.grid_fw_adj_v.total = rowArr.rowTotal;
			}else   {
				w2ui['grid_fw_adj_v'].clear();
			}
			w2ui['grid_fw_adj_v'].refresh();
			w2ui['grid_fw_adj_v'].unlock();
		},complete: function () {}
	});
}

function initFwAdjGrid() {
// 	console.log('initFwAdjGrid()');
	$("#grid_fw_adj").w2grid({
		name : 'grid_fw_adj',
		header : 'F/W List',
		show : {
			header : true,
			lineNumbers : true,
	        footer: true
	    },
		columns : [
	        { field:'fw_gubun', caption:'구분', size:'20%'},
	        { field:'fw_type', caption:'타입', size:'40%'},
	        { field:'fw_info', caption:'버전정보', size:'40%'},
	        { field:'fw_seq', caption:'seq', hidden:true}
		],
		records: [],
		total : 0,
		recordHeight : 30,
		sortData: [{field: 'pba_matnr', direction: 'ASC'}]
	});
}

function reloadFwAdjGrid() {
// 	console.log('reloadFwAdjGrid()');
		
	var page_url = "/frontend/hub/dmrFw_select"
				+ "?gr_no=" + encodeURIComponent($("#p_gr_no").val())
				+ "&gr_seq=" + encodeURIComponent($("#p_gr_seq").val());
	w2ui['grid_fw_adj'].lock('loading...', true);
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
				w2ui['grid_fw_adj'].records = rowArr;
				w2ui['grid_fw_adj'].total = rowArr.length;
			}else   {
				w2ui['grid_fw_adj'].clear();
			}
			w2ui['grid_fw_adj'].refresh();
			w2ui['grid_fw_adj'].unlock();
		},complete: function () {}
	});
}

function initPbaGrid() {
// 	console.log('initPbaGrid()');
	$("#grid_pba").w2grid({
		name : 'grid_pba',
		show: { 
			lineNumbers : true,
	        footer: true },
		columns : [
			{ field:'pba_gubun', caption:'구분', size:'15%', editable:{ type: 'text'}},
			{ field:'pba_matnr', caption:'자재명', size:'25%'},
			{ field:'pba_maktx', caption:'자재내역', size:'30%'},
			{ field:'pba_wrkst', caption:'SPEC.', size:'30%'},
			{ field:'pba_seq', caption:'seq', hidden:true} ],
		recordHeight : 30,
		records : []
	}); 
}

function initFwGrid() {
// 	console.log('initFwGrid()');
	$("#grid_fw").w2grid({
		name : 'grid_fw',
		show: { selectColumn: true },
		columns : [
	        { field:'fw_gubun', caption:'구분', size:'30%', editable:{ type: 'text'}},
	        { field:'fw_type', caption:'타입', size:'30%', editable:{ type: 'text'}},
	        { field:'fw_info', caption:'버전정보', size:'30%', editable:{ type: 'text'}},
	        { field:'fw_seq', caption:'seq', hidden:true}
		],
		recordHeight : 30,
		records : []
	}); 
}

function appendGridFw() {
// 	console.log('appendGridFw()');
	w2ui.grid_fw.add({recid:(w2ui.grid_fw.records).length+1});
}

function addVersion() {
	console.log('addVersion()');
	// 저장이랑 같으나 key값 새로 만든다.
	// master info
	var selection = w2ui.grid_pd.getSelection();
	var formData = $("#frm_product").serializeArray();
	if( formData.p_gr_no=="" || formData.p_gr_seq ) {
		fnMessageModalAlert("Warning", "그룹정보가 저장되어 있는 데이터가 아닙니다.<br>저장 후 버전 추가를 시도 하세요.");
		return;
	}
	if( selection.length==0 ){
		fnMessageModalAlert("Warning", "추가하고자 하는 대상 Product를 목록에서 선택하세요.");
		return;
	}
	var formJson = {};
	$.each(formData, function(idx, comp){
		formJson[comp.name] = comp.value;
	});
	formJson.p_change_date = replaceAll(formJson.p_change_date, ".", "");
	formJson.p_confirm_date = replaceAll(formJson.p_confirm_date, ".", "");
	var apply = "N";
	if( $("input:checkbox[id='p_apply_yn']").is(":checked") )	apply = "Y"
	formJson.p_apply_yn = apply; 
	// pba info
	var pbaData = w2ui.grid_pba_adj.records;
	if( pbaData.length>0 ){
		$.each(pbaData, function(idx, row){
			if( row.w2ui!=undefined ){
				var change = row.w2ui.changes;
				if( change.pba_gubun!=undefined )
					row.pba_gubun = change.pba_gubun;
				if( change.pba_matnr!=undefined )
					row.pba_matnr = change.pba_matnr;
				if( change.pba_maktx!=undefined )
					row.pba_maktx = change.pba_maktx;
				if( change.pba_wrkst!=undefined )
					row.pba_wrkst = change.pba_wrkst;
				if( change.pba_seq!=undefined )
					row.pba_seq = change.pba_seq;
			}
		});
	}
	
	// fw info
	var fwData = w2ui.grid_fw_adj.records;
	if( fwData.length>0 ){
		$.each(fwData, function(idx, row){
			if( row.w2ui!=undefined ){
				var change = row.w2ui.changes;
				if( change.fw_gubun!=undefined )
					row.fw_gubun = change.fw_gubun;
				if( change.fw_type!=undefined )
					row.fw_type = change.fw_type;
				if( change.fw_info!=undefined )
					row.fw_info = change.fw_info;
				if( change.fw_seq!=undefined )
					row.fw_seq = change.fw_seq;
			}
		});
	}
	
	fnMessageModalConfirm("Info", "버전 추가를 진행하시겠습니까?", function(chk){
		if(chk) {
			var pageURI = "/frontend/hub/dmrMaster_newVersion";
			var postData = "masterData=" + encodeURIComponent(JSON.stringify(formJson));
			if( pbaData.length>0 )
				postData += "&pbaData=" + encodeURIComponent(JSON.stringify(pbaData));
			if( fwData.length>0 )
				postData += "&fwData=" + encodeURIComponent(JSON.stringify(fwData));
//		 	console.log(postData);
			$.ajax({
				url: pageURI,
				data: postData,
				type: "POST",
				success:function(data, textStatus, jqXHR){
					if(data.status == "200") {
						fnMessageModalAlert("결과", "정보를 성공적으로 추가하였습니다.");
						searchProduct();
						w2ui['grid_pd'].click(selection[0]);
// 						reloadGridVerlist();
// 						reloadPbaAdjGrid();
// 						reloadFwAdjGrid();
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
	});
}

function deleteGridFw() {
// 	console.log('deleteGridFw()');
	var selection =  w2ui.grid_fw.getSelection();
	if( selection.length>0 ){
		$.each(selection, function(idx, recid){
			w2ui.grid_fw.select(recid);
			w2ui.grid_fw.delete(true);
		});
	}
}

function saveGridPba() {
// 	console.log('saveGridPba()');
	var gridDataArr = w2ui.grid_pba.records;
	var jsonObjArr = [];
	if( gridDataArr.length==0 ) {
		fnMessageModalAlert("Warning", "정보를 1개이상 추가 하여야 합니다.");
	} else {
		w2ui.grid_pba_adj.clear();
		w2ui.grid_pba_adj.add(gridDataArr);
		$("#modal_pba").modal('hide');
	}
}

function applyVersion() {
	console.log('applyVersion()');
	var page_url = "/frontend/hub/applyVersion"
	var postData = "gr_no=" + encodeURIComponent($("#v_gr_no").text())
				 + "&gr_seq=" + encodeURIComponent($("#v_gr_seq").text());
	var key = w2ui.grid_pd.getSelection()[0];
	$.ajax({
	    url: page_url,
	    data: postData,
	    type: "POST",
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		fnMessageModalConfirm("Success", "정보를 저장하였습니다.", function(chk){
	    			if(chk){
// 	    				reloadGridVerlist(key);
						var key = w2ui.grid_pd.getSelection()[0];
						searchProduct();
						w2ui.grid_pd.click(key);
	    				$("#modal_version").modal("hide");
	    			}
	    		});
	    	} else {
	    		fnMessageModalAlert("Fail", "정보를 저장하는데 에러가 발생하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Fail", "정보를 저장하는데 에러가 발생하였습니다.");	
	    }
	});
}

function saveGridFw() {
// 	console.log('saveGridFw()');

	var gridDataArr = w2ui.grid_fw.records;
// 	console.log(gridDataArr);
	var jsonObjArr = [];
	if( gridDataArr.length==0 ) {
		fnMessageModalAlert("Warning", "정보를 1개이상 추가 하여야 합니다.");
	} else {
		w2ui.grid_fw_adj.clear();
		w2ui.grid_fw_adj.add(gridDataArr);
		$("#modal_fw").modal('hide');
	}
}

function loadList1(pageNum) {
// 	console.log('loadList1()');
	if( pageNum==undefined ){
		page=1;
		pageNum = 0;
	} else {
		page=pageNum;
// 		pageNum = pageNum-1;
		pageNum = (pageNum-1)*rowPerPage;
	}
	
	var page_url = '/frontend/hub/material_recv_master_select_w2ui'
		 		 + '?matnr=' + encodeURIComponent($("#m_matnr").val())
		 		 + '&wrkst=' + encodeURIComponent($("#m_wrkst").val())
		 		 + '&maktx=' + encodeURIComponent($("#m_maktx").val())
		 		 + '&page=' + encodeURIComponent(pageNum)
		 		 + '&rows=' + encodeURIComponent(rowPerPage);
	
	w2ui['grid_materiallist'].clear();
	w2ui['grid_materiallist'].lock('loading...', true);
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
				w2ui['grid_materiallist'].records = rowArr;
				w2ui['grid_materiallist'].total = data.rowTotal;
			}
			w2ui['grid_materiallist'].refresh();
			w2ui['grid_materiallist'].unlock();
		},complete: function () {}
	});
// 	$("#modal_mat_search").modal('hide');
}

 
function initMaterialGrid() {
// 	console.log('initMaterialGrid()');
	
	$("#grid_materiallist").w2grid({
		name : 'grid_materiallist',
		show : {
			lineNumbers : true,
            footer: true
        },
		columns : [
			{ field:'matnr', caption:'자재코드', size:'30%', sortable:true},
			{ field:'maktx', caption:'자재내역', size:'35%', sortable:true},
			{ field:'wrkst', caption:'Spec.', size:'35%', sortable:true},
			{ field:'vtext', caption:'제품군명', hidden:true},
			{ field:'wgbez', caption:'자재그룹명', hidden:true},
			{ field:'date_created', caption:'생성일자', hidden:true},
			{ field:'date_updated', caption:'수정일자', hidden:true},
			{ field:'meins', caption:'meins', hidden:true},
			{ field:'lgpro', caption:'lgpro', hidden:true} ],
		records: [],
		total : 0,
		recordHeight : 30
	});
	loadList1();
}

// var dataArr = [];
//itnbr move to newlist
function addItnbrDetail() {
// 	console.log('addItnbrDetail()');
	
	var gridDataArr = w2ui.grid_pba.records;
	var selection = w2ui.grid_materiallist.getSelection();
	// 추가하려는 목록이 선택 되었는가?
	if( selection.length==0 ){
		fnMessageModalAlert("Warning", "추가하려는 항목을 선택해야 합니다.");
	} else {
		var selectData = w2ui.grid_materiallist.get(selection);
		var initRecid = w2ui.grid_pba.records.length + 1;
// 		console.log(initRecid);
		// 기존에 추가된 항목인지 확인
		if( gridDataArr.length>0 ){
			var chkCnt = 0;
			$.each(gridDataArr, function(idx, row){
				$.each(selectData, function(i, srow){
					if( row.pba_matnr==srow.matnr ) chkCnt++;
				});
			});
			// chkCnt가 0보다 크면, 같은 항목이 한개 이상 있다는...
			if( chkCnt==0 ){
// 				dataArr.push(addMatObj);
				$.each(selectData, function(idx, row) {
					row.recid = initRecid + 1;
					row.pba_matnr = row.matnr;
					row.pba_gubun = '';
					row.pba_maktx = row.maktx;
					row.pba_wrkst = row.wrkst;
					row.rspos = '';
					row.aufnr = '';
					row.lgort = row.lgpro;
					row.wrkst = row.wrkst;
				});
				w2ui.grid_pba.add(selectData);
			}else{
				fnMessageModalAlert("Warning(Duplicate)", "이미 추가되어 있는 항목입니다.");	
			}
		}else{
			$.each(selectData, function(idx, row) {
				row.recid = initRecid + 1;
				row.pba_matnr = row.matnr;
				row.pba_gubun = '';
				row.pba_maktx = row.maktx;
				row.pba_wrkst = row.wrkst;
				row.rspos = '';
				row.aufnr = '';
				row.lgort = row.lgpro;
				row.wrkst = row.wrkst;
			});
			w2ui.grid_pba.add(selectData);	
		}
	}
 	loadList1();
}

function graddItnbrDetail() {
// 	console.log('graddItnbrDetail()');
	
	var gridDataArr = w2ui.grid_addItnbr_list.records;
	
	// 추가하려는 목록이 선택 되었는가?
	var selection = w2ui.grid_grmateriallist.getSelection();
	if( selection.length==0 ){
		fnMessageModalAlert("Warning", "추가하려는 항목을 선택해야 합니다.");
	} else {
		var selectData = w2ui.grid_grmateriallist.get(selection);
		var initRecid = gridDataArr.length + 1;
		if( gridDataArr.length>0 ){
			var chkCnt = 0;
			$.each(gridDataArr, function(idx, row){
				$.each(selectData, function(i, srow){
					if( row.matnr==srow.matnr ) chkCnt++;
				});
			});
			// chkCnt가 0보다 크면, 같은 항목이 한개 이상 있다는...
			if( chkCnt==0 ){
				$.each(selectData, function(idx, row){
					row.recid = initRecid + idx;
				});
				w2ui.grid_addItnbr_list.add(selectData);
			}else{
				fnMessageModalAlert("Warning", "이미 추가되어 있는 항목입니다.");	
			}
		}else{
			$.each(selectData, function(idx, row){
				row.recid = initRecid + idx;
			});
			w2ui.grid_addItnbr_list.add(selectData);	
		}
	}
	loadList();
}

//remove new itnbr list
function deleteItnbrDetail() {
	var selection = w2ui.grid_pba.getSelection();
	if( selection.length>0 ){
		$.each(selection, function(idx, recid){
			w2ui.grid_pba.select(recid);
			w2ui.grid_pba.delete(true);
		});
	}
}

//remove new itnbr list
function grdeleteItnbrDetail() {
	var selection = w2ui.grid_addItnbr_list.getSelection();
	if( selection.length>0 ){
		$.each(selection, function(idx, recid){
			w2ui.grid_addItnbr_list.select(recid);
			w2ui.grid_addItnbr_list.delete(true);
		});
	}
}


function grmaterialSearch() {
// 	console.log('grmaterialSearch()');
	var page_url = '/frontend/hub/dmr_matnr_select'
		 		 + '?matnr=' + encodeURIComponent($("#m_matnr").val())
		 		 + '&wrkst=' + encodeURIComponent($("#m_wrkst").val())
		 		 + '&maktx=' + encodeURIComponent($("#m_maktx").val());
	
	w2ui['grid_grmateriallist'].lock('loading...', true);
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
				w2ui.grid_grmateriallist.records = rowArr;
				w2ui.grid_grmateriallist.total = rowArr.rowTotal;
			}
			w2ui['grid_grmateriallist'].refresh();
			w2ui['grid_grmateriallist'].unlock();
		},complete: function () {}
	});
	reloadNewItnbrGrid();
	
	$("#modal_mat_search").modal('hide');
}

function initGrMaterialGrid() {
// 	console.log('initGrMaterialGrid()');
// 	console.log('시작 ');
	
	$("#grid_grmateriallist").w2grid({
		name : 'grid_grmateriallist',
		show : {
			lineNumbers : true,
            footer: true
		},
		columns : [
			{ field:'matnr', caption:'자재코드', size:'100px', sortable:true},
			{ field:'maktx', caption:'자재내역', size:'150px', sortable:true},
			{ field:'wrkst', caption:'Spec.', size:'150px', sortable:true},
			{ field:'vtext', caption:'제품군명', hidden:true},
			{ field:'wgbez', caption:'자재그룹명', hidden:true},
			{ field:'date_created', caption:'생성일자', hidden:true},
			{ field:'date_updated', caption:'수정일자', hidden:true},
			{ field:'meins', caption:'meins', hidden:true},
			{ field:'lgpro', caption:'lgpro', hidden:true}
		],
		sortData: [{field: 'matnr', direction: 'ASC'}],
		records: [],
		total : 0,
		recordHeight : 30,
	    onSelect : function(event) {
		}
	});
	loadList();
}

function loadList(pageNum){
// 	console.log('loadList()');
	if( pageNum==undefined ){
		page=1;
		pageNum = 0;
	} else {
		page=pageNum;
		pageNum = pageNum-1;
	}
	
	var page_url = '/frontend/hub/dmr_matnr_select'
		 + '?page=' + encodeURIComponent(pageNum)
		 + '&rows=' + encodeURIComponent(rowPerPage)
		 + '&matnr=' + encodeURIComponent($("#itnbr_search_popup").val());
	
	w2ui['grid_grmateriallist'].lock('loading...', true);
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
			w2ui['grid_grmateriallist'].records = rowArr;
			w2ui['grid_grmateriallist'].total = data.rowTotal;
		}
		w2ui['grid_grmateriallist'].refresh();
		w2ui['grid_grmateriallist'].unlock();
	},complete: function () {}
	});
}

//그룹매칭 자재 grid generate
function initNewItnbrGrid() {
//   	console.log('initNewItnbrGrid()');

  	$("#grid_addItnbr_list").w2grid({
		name : 'grid_addItnbr_list',
		show : {
			lineNumbers : true,
            footer: true
		},
		columns : [
			{ field:'matnr', caption:'자재코드', size:'30%', sortable:true},
			{ field:'maktx', caption:'자재내역', size:'35%', sortable:true},
			{ field:'wrkst', caption:'Spec.', size:'35%', sortable:true}
		],
		sortData: [{field: 'matnr', direction: 'ASC'}],
		records: [],
		total : 0,
		recordHeight : 30
	});
	 
	var page_url = "/frontend/hub/dmrmatnrManageTbl"
		 		 + "?gr_no=" + encodeURIComponent($("#t_gr_no").val());
	w2ui['grid_addItnbr_list'].lock('loading...', true);
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
				w2ui['grid_addItnbr_list'].records = rowArr;
				w2ui['grid_addItnbr_list'].total = rowArr.length;
			}
			w2ui['grid_addItnbr_list'].refresh();
			w2ui['grid_addItnbr_list'].unlock();
		},complete: function () {}
	});
}

//그룹 매칭 자재 저장 대상  grid generate
 function reloadNewItnbrGrid() {
//  	console.info('reloadNewItnbrGrid()');
	
 	w2ui.grid_addItnbr_list.clear();

 	var page_url = "/frontend/hub/dmrmatnrManageTbl"
		 		 + "?gr_no=" + encodeURIComponent($("#t_gr_no").val());
 	
 	w2ui['grid_addItnbr_list'].lock('loading...', true);
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
				console.log(rowArr);
				w2ui.grid_addItnbr_list.records = rowArr;
				w2ui.grid_addItnbr_list.total = rowArr.length;
			}
			w2ui['grid_addItnbr_list'].refresh();
			w2ui['grid_addItnbr_list'].unlock();
		},complete: function () {}
	});
 }
 
 function saveMatnrGrid() {
// 	console.log('saveMatnrGrid()');
	$("#btn_dmr_save").prop("disabled", true);
	$("#btn_dmr_cancel").prop("disabled", true);
	var saveData = w2ui.grid_addItnbr_list.records;
    var page_url = "/frontend/hub/savedmrMatnrGrid";
	var postData = "gr_no=" + encodeURIComponent($("#t_gr_no").val()) 
				 + "&params=" + encodeURIComponent(JSON.stringify(saveData));
	console.log(saveData);
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnMessageModalAlert("Success","선택된 자재를 등록하였습니다.");
			} else {
				fnMessageModalAlert("Fail", "선택된 자재등록에 실패했습니다.");
			}
			$("#btn_dmr_save").prop("disabled", false);
			$("#btn_dmr_cancel").prop("disabled", false);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "선택된 자재등록에 실패했습니다.");
		}
	});
}

//search itnbr list
 function searchItnbrpopup(){
// 	 console.log('grmaterialSearch()');
		
	var page_url = '/frontend/hub/dmr_matnr_select'
		 		 + '?matnr=' + encodeURIComponent($("#itnbr_search_popup").val())
		 		 + '&page=' + encodeURIComponent(0)
				 + "&rows="+ encodeURIComponent(rowPerPage);

	w2ui['grid_grmateriallist'].lock('loading...', true);
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
				w2ui.grid_grmateriallist.records = rowArr;
				w2ui.grid_grmateriallist.total = rowArr.rowTotal;
			}
			w2ui['grid_grmateriallist'].refresh();
			w2ui['grid_grmateriallist'].unlock();
		},complete: function () {}
	});
	reloadNewItnbrGrid();
}

</script>
</body>
</html>