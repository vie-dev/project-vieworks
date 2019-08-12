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
		<jsp:param name="selected_menu_cd" value="1031" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        CSR
        <small>CSR 등록</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> CSR</a></li><li class="active">CSR 등록</li>
      </ol>
    </section>

    <section class="content">
      <div class="row">
        <section class="col-lg-12">
          <div class="box box-success box-solid" style="min-height: 180px;">
            <div class="box-header with-border">
              <h3 class="box-title">조회조건</h3>
              <div class="box-tools pull-right">
	              <button type="button" id="btn_search_csr" class="btn btn-success btn-sm">조회</button>
	              <button type="button" id="btn_search_init" class="btn btn-info btn-sm">조건초기화</button>
              </div>
            </div>
            <div id="" class="box-body">
            	<div class="row">
            		<div class="col-sm-2">
				   				<div class="form-group">
		                <label>고객사</label>
		                <select id="sel_customer_cd" class="form-control select2" data-placeholder="고객사선택" style="width: 100%;">
		                	<option value="">고객을 선택하세요</option>
		                	<option value="1">Agfa HealthCare NV_Issue</option>
		                	<option value="2">Agfa HealthCare NV_Notice</option>
		                	<option value="3">Al Nawras Grobal Healthcare</option>
		                	<option value="4">APK Image</option>
			              </select>
		              </div>
                </div>
                <div class="col-sm-2">
				   				<div class="form-group">
		                <label>CSR 등록자</label>
		                <input type="input" id="customer_member_nm" name="customer_member_nm" class="form-control" placeholder="고객사 담당자" maxlength="30">
		              </div>
                </div>
                <div class="col-sm-2">
				   				<div class="form-group">
		                <label>거점</label>
		                <select id="sel_company_cd" class="form-control select2" data-placeholder="거점선택" style="width: 100%;">
		                </select>
		              </div>
                </div>
                <div class="col-sm-2">
				   				<div class="form-group">
		                <label>CSR 등록자</label>
		                <input type="input" id="company_member_nm" name="company_member_nm" class="form-control" placeholder="CS 담당자" maxlength="30">
		              </div>
                </div>
                <div class="col-sm-2">
				   				<div class="form-group">
		                <label>CSR 등록일</label>
		                <div class="input-group">
		                  <div class="input-group-addon">
		                    <i class="fa fa-calendar"></i>
		                  </div>
		                  <input type="text" class="form-control pull-right" id="csr_register_date_range">
		                </div>
		              </div>
                </div>
                <div class="col-sm-2">
				   				<div class="form-group">
		                <label>CSR 처리완료일</label>
		                <div class="input-group">
		                  <div class="input-group-addon">
		                    <i class="fa fa-calendar"></i>
		                  </div>
		                  <input type="text" class="form-control pull-right" id="csr_ending_date_range">
		                </div>
		              </div>
                </div>
			        </div>
            	<div class="row">
            		<div class="col-sm-4">
            			<div class="form-group">
					   				<label>CSR 요청유형</label><br/>
					   				<label>
		                  <input type="radio" name="rdo_csr_req_type" class="flat-red" value="" checked> 전체
		                </label>
					   				<label>
		                  <input type="radio" name="rdo_csr_req_type" class="flat-red" value="01"> 고객 불만
		                </label>
		                <label>
		                  <input type="radio" name="rdo_csr_req_type" class="flat-red" value="02" > 단순 문의 및 요청
		                </label>
		                <label>
		                  <input type="radio" name="rdo_csr_req_type" class="flat-red" value="03" > 개선 및 개발 요청
		                </label>
		                <label>
		                  <input type="radio" name="rdo_csr_req_type" class="flat-red" value="04" > 교육 요청
		                </label>
		                <label>
		                  <input type="radio" name="rdo_csr_req_type" class="flat-red" value="05" > 기타
		                </label>
	                </div>
                </div>
                <div class="col-sm-3">
            			<div class="form-group">
					   				<label>CSR 불량유형</label><br/>
					   				<label>
		                  <input type="radio" name="rdo_csr_problom_type" class="flat-red" value="" checked> 전체
		                </label>
					   				<label>
		                  <input type="radio" name="rdo_csr_problom_type" class="flat-red" value="01"> H/W 불량
		                </label>
		                <label>
		                  <input type="radio" name="rdo_csr_problom_type" class="flat-red" value="02" > S/W 불량
		                </label>
		                <label>
		                  <input type="radio" name="rdo_csr_problom_type" class="flat-red" value="03" > 영상 불량
		                </label>
	                </div>
                </div>
                <div class="col-sm-5">
            			<div class="form-group">
					   				<label>CSR 처리단계</label><br/>
					   				<label>
		                  <input type="radio" name="rdo_csr_process_type" class="flat-red" value="" checked> 전체
		                </label>
					   				<label>
		                  <input type="radio" name="rdo_csr_process_type" class="flat-red" value="01"> 진행
		                </label>
		                <label>
		                  <input type="radio" name="rdo_csr_process_type" class="flat-red" value="02" > 분석(연구소)
		                </label>
		                <label>
		                  <input type="radio" name="rdo_csr_process_type" class="flat-red" value="03" > 회신대기
		                </label>
		                <label>
		                  <input type="radio" name="rdo_csr_process_type" class="flat-red" value="04" > S/W변경
		                </label>
		                <label>
		                  <input type="radio" name="rdo_csr_process_type" class="flat-red" value="05" > RMA
		                </label>
		                <label>
		                  <input type="radio" name="rdo_csr_process_type" class="flat-red" value="06" > RMA Canceled
		                </label>
		                <label>
		                  <input type="radio" name="rdo_csr_process_type" class="flat-red" value="07" > 중단
		                </label>
		                <label>
		                  <input type="radio" name="rdo_csr_process_type" class="flat-red" value="08" > 종결
		                </label>
	                </div>
                </div>
			        </div>
            </div>
          </div>
          
          <div class="box box-default box-solid" style="min-height: 680px;">
            <div class="box-header with-border">
              <h3 class="box-title">CSR 목록</h3>
            </div>
            <div id="" class="box-body">
            	<div class="row">
			          
			        </div>
            	<div class="row">
			          
			        </div>
			        <div class="row">
			        </div>
            </div>
          </div>
        </section>
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

<script type="text/javascript">
$(function($) {
	fnPageLoadOption();
});

function fnPageLoadOption(){
	
	$('input[type="radio"].flat-red').iCheck({
    checkboxClass: 'icheckbox_flat-orange',
    radioClass: 'iradio_flat-orange',
    handle: 'radio'
  });
	
	$("#sel_customer_cd").select2({
	});
	
	getSelectCompany($("#sel_company_cd"), false);
	
	$('#csr_register_date_range').daterangepicker();
	$('#csr_ending_date_range').daterangepicker();
}
</script>
</body>
</html>