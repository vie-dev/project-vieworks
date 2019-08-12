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
		<jsp:param name="selected_menu_p_cd" value="1043" />
		<jsp:param name="selected_menu_cd" value="1055" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        출하 관리
        <small>출하모니터링</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 출하 관리</a></li><li class="active">출하모니터링</li>
      </ol>
    </section>

    <!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-md-6">
			<div id="line-chart" style="height: 300px;"></div>
		</div>
		<div class="col-md-6">
			<div id="grid" style="width:100%; height:500px;"></div>
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
<!-- FLOT CHARTS -->
<script src="/res/plugins/flot/jquery.flot.min.js"></script>
<!-- FLOT RESIZE PLUGIN - allows the chart to redraw when the window is resized -->
<script src="/res/plugins/flot/jquery.flot.resize.min.js"></script>
<!-- FLOT PIE PLUGIN - also used to draw donut charts -->
<script src="/res/plugins/flot/jquery.flot.pie.min.js"></script>
<!-- FLOT CATEGORIES PLUGIN - Used to draw bar charts -->
<script src="/res/plugins/flot/jquery.flot.categories.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	drawGrid();
	drawLineChart();
	initScreenSizeModal();
});

function drawGrid() {
	$("#grid").w2grid({
		name : 'grid',
		header : 'test grid',
		show : {
			header : true,
			lineNumbers : true,
	        footer: true
	    },
	    columns : [
			{ field:'gubun', caption:'구분', size:'15%'},
	        { field:'percent', caption:'불량률', size:'25%', render:'percent'},
	        { field:'date', caption:'일자', size:'30%'}],
		recordHeight : 30,
		sortData: [{field: 'gubun', direction: 'ASC'}],
		records: [{recid:1, gubun:'ViVIX', percent:'1.0', date:'2017-01'},
		      	{ recid:2, gubun:'ViVIX', percent:'1.0', date:'2017-02'},
		    	{ recid:3, gubun:'ViVIX', percent:'2.0', date:'2017-03'},
		    	{ recid:4, gubun:'ViVIX', percent:'1.0', date:'2017-04'},
		    	{ recid:5, gubun:'ViVIX', percent:'1.0', date:'2017-05'},
		    	{ recid:6, gubun:'ViVIX', percent:'1.0', date:'2017-06'},
		    	{ recid:7, gubun:'RF_Camera', percent:'2.0', date:'2017-01'},
		    	{ recid:8, gubun:'RF_Camera', percent:'5.0', date:'2017-02'},
		    	{ recid:9, gubun:'RF_Camera', percent:'1.0', date:'2017-03'},
		    	{ recid:10, gubun:'RF_Camera', percent:'0.0', date:'2017-04'},
		    	{ recid:11, gubun:'RF_Camera', percent:'2.0', date:'2017-05'},
		    	{ recid:12, gubun:'RF_Camera', percent:'3.0', date:'2017-06'},
		    	{ recid:13, gubun:'RF_SCU', percent:'3.0', date:'2017-01'},
		    	{ recid:14, gubun:'RF_SCU', percent:'0.0', date:'2017-02'},
		    	{ recid:15, gubun:'RF_SCU', percent:'10.0', date:'2017-03'},
		    	{ recid:16, gubun:'RF_SCU', percent:'0.0', date:'2017-04'},
		    	{ recid:17, gubun:'RF_SCU', percent:'3.0', date:'2017-05'},
		    	{ recid:18, gubun:'RF_SCU', percent:'3.0', date:'2017-06'},
		    	{ recid:19, gubun:'RF_PC', percent:'4.0', date:'2017-01'},
		    	{ recid:20, gubun:'RF_PC', percent:'0.0', date:'2017-02'},
		    	{ recid:21, gubun:'RF_PC', percent:'5.0', date:'2017-03'},
		    	{ recid:22, gubun:'RF_PC', percent:'3.0', date:'2017-04'},
		    	{ recid:23, gubun:'RF_PC', percent:'4.0', date:'2017-05'},
		    	{ recid:24, gubun:'RF_PC', percent:'4.0', date:'2017-06'}],
		total : 0
	});
}

function drawLineChart() {
	/*
     * LINE CHART
     * ----------
     */
    //LINE randomly generated data
	var dataArr = [];
	/*
	{
    "label": "Europe (EU27)",
    "data": [[1999, 3.0], [2000, 3.9], [2001, 2.0], [2002, 1.2], [2003, 1.3], [2004, 2.5], [2005, 2.0], [2006, 3.1], [2007, 2.9], [2008, 0.9]]
}
	*/
	// get group
	var labelArr = [];
	$.each(w2ui.grid.records, function(idx, row){
		labelArr.push(row.gubun);
    });
	$.unique(labelArr);
	$.each(labelArr, function(idx, label){
// 		dataArr
		var obj = {};
		obj.label = label;
		obj.data = [];
		dataArr.push(obj);
	});
	for(var i=0; i<dataArr.length; i++) {
	    $.each(w2ui.grid.records, function(idx, row){
			var tmpArr = [];
			if(row.gubun==dataArr[i].label) {
				tmpArr.push(row.date);
				tmpArr.push(row.percent);
				(dataArr[i].data).push(tmpArr);
			}
	    });
	}
	console.log(dataArr);
    var sin = [], cos = [];
    for (var i = 0; i < 14; i += 0.5) {
      sin.push([i, Math.sin(i)]);
      cos.push([i, Math.cos(i)]);
    }
    var line_data1 = {
      data: dataArr[0].data,
      color: "#3c8dbc"
    };
    var line_data2 = {
      data: dataArr[1].data,
      color: "#00c0ef"
    };
    $.plot("#line-chart", dataArr, {
      grid: {
        hoverable: true,
        borderColor: "#f3f3f3",
        borderWidth: 1,
        tickColor: "#f3f3f3"
      },
      series: {
        shadowSize: 0,
        lines: {
          show: true
        },
        points: {
          show: false
        }
      },
      lines: {
        fill: false,
        color: ["#3c8dbc", "#f56954", "#cccccc", "#BBBBBB"]
      },
      yaxis: {
        show: true,
      },
      xaxis: {
          mode: "categories",
          tickLength: 0
        }
    });
    //Initialize tooltip on hover
    $('<div class="tooltip-inner" id="line-chart-tooltip"></div>').css({
      position: "absolute",
      display: "none",
      opacity: 0.8
    }).appendTo("body");
    $("#line-chart").bind("plothover", function (event, pos, item) {

      if (item) {
        var x = item.datapoint[0].toFixed(2),
            y = item.datapoint[1].toFixed(2);

        $("#line-chart-tooltip").html(item.series.label + " of " + x + " = " + y)
            .css({top: item.pageY + 5, left: item.pageX + 5})
            .fadeIn(200);
      } else {
        $("#line-chart-tooltip").hide();
      }

    });
    /* END LINE CHART */
}
</script>
</body>
</html>