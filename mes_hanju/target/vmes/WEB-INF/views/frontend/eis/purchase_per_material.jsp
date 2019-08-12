<%@page language="java"%>
<%@page pageEncoding="UTF-8"%>
<%@page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

        <title>Vieworks MES | VMES</title>

        <jsp:include page="/common/header_inc" flush="true">
            <jsp:param name="page_title" value="0"/>
        </jsp:include>

        <link rel="stylesheet" href="/res/plugins/rMateChartH5/Assets/Css/rMateChartH5.css">
        <script src="/res/plugins/rMateChartH5/rMateChartH5License.js"></script>
        <script src="/res/plugins/rMateChartH5/JS/rMateChartH5.js"></script>
    </head>

    <body class="hold-transition skin-green-light sidebar-mini">
        <div class="wrapper">
            <jsp:include page="/common/top_menu_inc" flush="true">
                <jsp:param name="fb_div" value="F"/>
                <jsp:param name="page_title" value="0"/>
            </jsp:include>

            <jsp:include page="/common/sidebar_menu_inc" flush="true">
                <jsp:param name="menu_div" value="F"/>
                <jsp:param name="selected_menu_p_cd" value="1087"/>
                <jsp:param name="selected_menu_cd" value="1100"/>
            </jsp:include>

            <div class="content-wrapper">
                <section class="content-header">
                    <h1>EIS<small>자재그룹별 매입</small></h1>
                    <ol class="breadcrumb">
                        <li><a href="#"><i class="fa fa-dashboard"></i> EIS</a></li><li class="active">자재그룹별 매입</li>
                    </ol>
                </section>

                <section class="content">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="box box-success box-solid">
                                <div class="box-header with-border">
                                    <h3 class="box-title">조회조건</h3>
                                    <div class="box-tools pull-right">
                                        <button class="btn btn-primary btn-sm" onclick="fnSearch();">조회</button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <label>| 기간</label>
                                                <div class="input-group">
                                                    <label><input type="radio" name="rdo_period" class="flat-red" value="Y" checked>당해연도</label>
                                                    &nbsp;
                                                    <label><input type="radio" name="rdo_period" class="flat-red" value="M">이전 12개월</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <label>| 사업영역</label>
                                                <div class="input-group">
                                                    <select id="sel_scope_cd" class="form-control select2 input-sm">
                                                        <option value="">전체</option>
                                                        <option value="1110">의료</option>
                                                        <option value="1210">광</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-12 text-right" style="">
                                            백만원
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="box">
                                <table id="grid"></table>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="box">
                                <div id="chartHolder1" style="height: 300px;"></div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="box">
                                <div id="chartHolder2" style="height: 300px;"></div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>

            <jsp:include page="/common/footer_inc" flush="true">
                <jsp:param name="page_title" value="0"/>
            </jsp:include>

            <jsp:include page="/common/sidebar_rview_inc" flush="true">
                <jsp:param name="page_title" value="0"/>
            </jsp:include>
        </div>

        <script type="text/javascript">
            $(function () {
                fnInitCondition();
                fnLoadCommonOption();
                fnLoadGrid();
                fnLoadChart();
            });

            function fnInitCondition() {
            }

            function fnLoadCommonOption() {
                $(window).bind('resize', function () {
                    resizeJqGrid("grid", false);
                }).trigger('resize');
            }

            function makeColNames() {
                return [
                    '자재',
                    '수량', '금액',
                    '수량', '금액',
                    '수량', '금액',
                    '수량', '금액',
                    '수량', '금액',
                    '수량', '금액',
                    '수량', '금액',
                    '수량', '금액',
                    '수량', '금액',
                    '수량', '금액',
                    '수량', '금액',
                    '수량', '금액',
                    '수량', '금액'
                ];
            }
            
            function updateGroupHeader() {
                if($(':radio[name="rdo_period"]:checked').val() == 'Y'){
                    $('#m_11').text('01');
                    $('#m_10').text('02');
                    $('#m_09').text('03');
                    $('#m_08').text('04');
                    $('#m_07').text('05');
                    $('#m_06').text('06');
                    $('#m_05').text('07');
                    $('#m_04').text('08');
                    $('#m_03').text('09');
                    $('#m_02').text('10');
                    $('#m_01').text('11');
                    $('#m_00').text('12');
                } else if($(':radio[name="rdo_period"]:checked').val() == 'M'){
                    $('#m_11').text(moment().subtract(11, 'months').format('MM'));
                    $('#m_10').text(moment().subtract(10, 'months').format('MM'));
                    $('#m_09').text(moment().subtract(9, 'months').format('MM'));
                    $('#m_08').text(moment().subtract(8, 'months').format('MM'));
                    $('#m_07').text(moment().subtract(7, 'months').format('MM'));
                    $('#m_06').text(moment().subtract(6, 'months').format('MM'));
                    $('#m_05').text(moment().subtract(5, 'months').format('MM'));
                    $('#m_04').text(moment().subtract(4, 'months').format('MM'));
                    $('#m_03').text(moment().subtract(3, 'months').format('MM'));
                    $('#m_02').text(moment().subtract(2, 'months').format('MM'));
                    $('#m_01').text(moment().subtract(1, 'months').format('MM'));
                    $('#m_00').text(moment().subtract(0, 'months').format('MM'));
                }
            }

            function makeGridUrl() {
                return "/eis/zmpfm_mm001_et_output"
                        + "?IV_GROUP=M"
                        + "&IV_YM_FLAG=" + $(':radio[name="rdo_period"]:checked').val()
                        + "&IV_WERKS=" + $("#sel_scope_cd").val();
            }

            function makeChartUrl1() {
                return "/eis/zmpfm_mm001_et_output_graph"
                        + "?IV_GROUP=M"
                        + "&IV_YM_FLAG=" + $(':radio[name="rdo_period"]:checked').val()
                        + "&IV_WERKS=" + $("#sel_scope_cd").val();
            }

            function makeChartUrl2() {
                return "/eis/zmpfm_mm001_et_output_graph2"
                        + "?IV_GROUP=M"
                        + "&IV_YM_FLAG=" + $(':radio[name="rdo_period"]:checked').val()
                        + "&IV_WERKS=" + $("#sel_scope_cd").val();
            }

            function fnLoadGrid() {
                $("#grid").jqGrid({
                    mtype: 'GET',
                    url: makeGridUrl(),
                    datatype: 'json',
                    colNames: makeColNames(),
                    cmTemplate: {sortable: false, width: 100, align: 'right'},
                    colModel: [
                        {name: 'text', align: 'left'},
                        {name: 'menge_01'},
                        {name: 'dmbtr_01'},
                        {name: 'menge_02'},
                        {name: 'dmbtr_02'},
                        {name: 'menge_03'},
                        {name: 'dmbtr_03'},
                        {name: 'menge_04'},
                        {name: 'dmbtr_04'},
                        {name: 'menge_05'},
                        {name: 'dmbtr_05'},
                        {name: 'menge_06'},
                        {name: 'dmbtr_06'},
                        {name: 'menge_07'},
                        {name: 'dmbtr_07'},
                        {name: 'menge_08'},
                        {name: 'dmbtr_08'},
                        {name: 'menge_09'},
                        {name: 'dmbtr_09'},
                        {name: 'menge_10'},
                        {name: 'dmbtr_10'},
                        {name: 'menge_11'},
                        {name: 'dmbtr_11'},
                        {name: 'menge_12'},
                        {name: 'dmbtr_12'},
                        {name: 'menge_sum'},
                        {name: 'dmbtr_sum'}
                    ],
                    autowidth: true,
                    height: 'auto',
                    scrollOffset: 0
                });

                $("#grid").jqGrid('setGroupHeaders', {
                    useColSpanStyle: true,
                    groupHeaders: [
                        {startColumnName: 'text', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'menge_01', numberOfColumns: 2, titleText: '<span id="m_11"></span>월'},
                        {startColumnName: 'menge_02', numberOfColumns: 2, titleText: '<span id="m_10"></span>월'},
                        {startColumnName: 'menge_03', numberOfColumns: 2, titleText: '<span id="m_09"></span>월'},
                        {startColumnName: 'menge_04', numberOfColumns: 2, titleText: '<span id="m_08"></span>월'},
                        {startColumnName: 'menge_05', numberOfColumns: 2, titleText: '<span id="m_07"></span>월'},
                        {startColumnName: 'menge_06', numberOfColumns: 2, titleText: '<span id="m_06"></span>월'},
                        {startColumnName: 'menge_07', numberOfColumns: 2, titleText: '<span id="m_05"></span>월'},
                        {startColumnName: 'menge_08', numberOfColumns: 2, titleText: '<span id="m_04"></span>월'},
                        {startColumnName: 'menge_09', numberOfColumns: 2, titleText: '<span id="m_03"></span>월'},
                        {startColumnName: 'menge_10', numberOfColumns: 2, titleText: '<span id="m_02"></span>월'},
                        {startColumnName: 'menge_11', numberOfColumns: 2, titleText: '<span id="m_01"></span>월'},
                        {startColumnName: 'menge_12', numberOfColumns: 2, titleText: '<span id="m_00"></span>월'},
                        {startColumnName: 'menge_sum', numberOfColumns: 2, titleText: '합계'}
                    ]
                });
                
                updateGroupHeader();
            }

            function fnLoadChart() {
                rMateChartH5.create("chart1", "chartHolder1", chartVars1);
                rMateChartH5.create("chart2", "chartHolder2", chartVars2);
            }

            function fnSearch() {
                $("#grid").jqGrid('setGridParam', {url: makeGridUrl()});
                updateGroupHeader();
                $("#grid").trigger("reloadGrid");

                document.getElementById('chart1').setDataURL(makeChartUrl1());
                document.getElementById('chart2').setDataURL(makeChartUrl2());
            }
        </script>

        <script type="text/javascript">
            var chartVars1 = "rMateOnLoadCallFunction=chartReadyHandler1";
            var chartVars2 = "rMateOnLoadCallFunction=chartReadyHandler2";

            function chartReadyHandler1(id) {
                document.getElementById(id).setLayout(chartLayout1);
                document.getElementById(id).setDataType('json');
                document.getElementById(id).setDataURL(makeChartUrl1());
            }

            function chartReadyHandler2(id) {
                document.getElementById(id).setLayout(chartLayout2);
                document.getElementById(id).setDataType('json');
                document.getElementById(id).setDataURL(makeChartUrl2());
            }

            var chartLayout1 =
                    '<rMateChart backgroundColor="#FFFFFF" borderStyle="none" >'
                    + '<Options>'
                    + '<Caption text="자재그룹별 매입"/>'
                    + '<Legend useVisibleCheck="false"/>'
                    + '</Options>'
                    + '<Pie2DChart showDataTips="true">'
                    + '<series>'
                    + '<Pie2DSeries nameField="text" field="dmbtr" labelPosition="inside" color="#ffffff" startAngle="136">'
                    + '<showDataEffect>'
                    + '<SeriesSlide duration="1000"/>'
                    + '</showDataEffect>'
                    + '</Pie2DSeries>'
                    + '</series>'
                    + '</Pie2DChart>'
                    + '</rMateChart>'
                    ;
            var chartLayout2 =
                    '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
                    + '<Options>'
                    + '<Caption text="자재그룹별 매입"/>'
                    + '</Options>'
                    + '<SeriesInterpolate id="ss"/>'
                    + '<Column2DChart showDataTips="true" selectionMode="multiple" columnWidthRatio="0.48">'
                    + '<horizontalAxis>'
                    + '<CategoryAxis categoryField="lfmon"/>'
                    + '</horizontalAxis>'
                    + '<verticalAxis>'
                    + '<LinearAxis/>'
                    + '</verticalAxis>'
                    + '<series>'
                    + '<Column2DSeries labelPosition="outside" yField="dmbtr" showDataEffect="{ss}">'
                    + '</Column2DSeries>'
                    + '</series>'
                    + '</Column2DChart>'
                    + '</rMateChart>'
                    ;
        </script>
    </body>
</html>