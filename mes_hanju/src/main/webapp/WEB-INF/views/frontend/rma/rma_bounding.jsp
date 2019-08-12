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
		<jsp:param name="selected_menu_p_cd" value="1011" />
		<jsp:param name="selected_menu_cd" value="1035" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        RMA
        <small>RMA 입/출고</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> RMA</a></li><li class="active">RMA 입/출고</li>
      </ol>
    </section>

    <section class="content">
      <div class="row">
        <section class="col-lg-12 connectedSortable">
          <div class="box" style="min-height: 150px;">
            <div class="box-header with-border">
              <h3 class="box-title">조회조건</h3>
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
          <div class="box" style="min-height: 680px;">
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
</body>
</html>