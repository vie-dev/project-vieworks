<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>MES </title>
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
		<jsp:param name="selected_menu_p_cd" value="1112"  />
		<jsp:param name="selected_menu_cd" value="1114" />
	</jsp:include>
	<div class="content-wrapper">
		<section class="content-header">
			<h1>
				w2grid Test<small>test</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> w2grid</a></li>
				<li class="active">test</li>
			</ol>
		</section>
		<!-- Main content -->
    <section class="content">
    	<div class="box" style="margin-bottom: 0px;height: 790px;overflow-y: auto;">
			<div class="box-body"><!-- start box body -->
				<div id="grid" style="width: 100%; height: 550px;"></div>
		    </div><!-- end box body -->
		</div><!-- end box -->
   	</section>
   	</div>
    <!-- /.content -->
	<jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
	
	<jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>	

<style>
</style>

<script type="text/javascript">
$(function () {
	$('#grid').w2grid({ 
        name: 'grid', 
//         searches: [                
//             { field: 'lname', caption: 'Last Name', type: 'text' },
//             { field: 'fname', caption: 'First Name', type: 'text' },
//             { field: 'email', caption: 'Email', type: 'text' },
//         ],
        show: { footer: true },
//         sortData: [ { field: 'recid', direction: 'asc' } ],
        columnGroups: [
            { caption: 'No', master: true },
            { caption: '사업자번호',master: true },
            { caption: '구분', master: true },
            { caption: '프로젝트', span: 7 },
            { caption: '프로젝트 진행', span: 3 }
        ],
        columns: [                
            { field: 'recid', caption: 'No', size: '50px', sortable: true, attr: 'align=center', resizable: true },
            { field: 'com_num', caption: '사업자번호', size: '30%', sortable: true, resizable: true },
            { field: 'gubun', caption: '구분', size: '30%', sortable: true, resizable: true },
            { field: 'prod_code', caption: '프로젝트코드', size: '40%', sortable: true, resizable: true },
            { field: 'prod_name', caption: '프로젝트명', size: '90px', sortable: true, resizable: true },
            { field: 'money', caption: '발주금액', size: '90px', sortable: true, resizable: true },
            { field: 'cnt', caption: '수량', size: '90px', sortable: true, resizable: true },
            { field: 'grade', caption: '단위', size: '90px', sortable: true, resizable: true },
            { field: 'yo', caption: '요구사항', size: '90px', sortable: true, resizable: true },
            { field: 'comp_yn', caption: '완료유무', size: '90px', sortable: true, resizable: true },
            { field: 'sul', caption: '설계', size: '90px', sortable: true, resizable: true },
            { field: 'com_date', caption: '완료일자', size: '90px', sortable: true, resizable: true },
            { field: 'bying_date', caption: '구매일자', size: '90px', sortable: true, resizable: true }
        ]
        /* ,
        records: [
            { recid: 1, fname: 'Jane', lname: 'Doe', email: 'jdoe@gmail.com', sdate: '4/3/2012', edate: '12/3/2012' },
            { recid: 2, fname: 'Stuart', lname: 'Motzart', email: 'jdoe@gmail.com', sdate: '4/3/2012', edate: '11/3/2012' },
            { recid: 3, fname: 'Jin', lname: 'Franson', email: 'peter@gmail.com', sdate: '4/3/2012', edate: '4/3/2012' },
            { recid: 4, fname: 'Susan', lname: 'Ottie', email: 'frank@gmail.com', sdate: '9/3/2012', edate: '10/3/2012' },
            { recid: 5, fname: 'Kelly', lname: 'Silver', email: 'jdoe@gmail.com', sdate: '6/3/2012', edate: '4/24/2012' },
            { recid: 6, fname: 'Francis', lname: 'Gatos', email: 'jdoe@gmail.com', sdate: '2/3/2012', edate: '6/3/2012' },
            { recid: 7, fname: 'Mark', lname: 'Welldo', email: 'susan@gmail.com', sdate: '4/3/2012', edate: '6/23/2012' },
            { recid: 8, fname: 'Thomas', lname: 'Bahh', email: 'david@gmail.com', sdate: '9/3/2012', edate: '4/16/2012' },
            { recid: 9, fname: 'Sergei', lname: 'Rachmaninov', email: 'magi@gmail.com', sdate: '4/3/2012', edate: '4/3/2012' },
            { recid: 20, fname: 'Jill', lname: 'Doe', email: 'jdoe@gmail.com', sdate: '4/3/2012', edate: '4/3/2012' },
            { recid: 21, fname: 'Frank', lname: 'Motzart', email: 'peterson@gmail.com', sdate: '4/3/2012', edate: '4/3/2012' },
            { recid: 22, fname: 'Peter', lname: 'Franson', email: 'jdoe@gmail.com', sdate: '4/3/2012', edate: '8/3/2012' },
            { recid: 23, fname: 'Andrew', lname: 'Ottie', email: 'magi@gmail.com', sdate: '6/3/2012', edate: '4/19/2012' },
            { recid: 24, fname: 'Manny', lname: 'Silver', email: 'jdoe@gmail.com', sdate: '4/3/2012', edate: '8/5/2012' },
            { recid: 25, fname: 'Ben', lname: 'Gatos', email: 'peter@gmail.com', sdate: '9/3/2012', edate: '4/3/2012' },
            { recid: 26, fname: 'Doer', lname: 'Welldo', email: 'magi@gmail.com', sdate: '4/3/2012', edate: '4/7/2012' },
            { recid: 27, fname: 'Shashi', lname: 'Bahh', email: 'jdoe@gmail.com', sdate: '4/3/2012', edate: '4/3/2012' },
            { recid: 28, fname: 'Av', lname: 'Rachmaninov', email: 'joe@gmail.com', sdate: '9/3/2012', edate: '12/6/2012' }
        ] */
    }); 
});

</script>

</body>
</html>
  
 