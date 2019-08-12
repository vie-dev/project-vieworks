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
                <jsp:param name="selected_menu_cd" value="1102"/>
            </jsp:include>

            <div class="content-wrapper">
                <section class="content-header">
                    <h1>EIS<small>자재그룹별 재고</small></h1>
                    <ol class="breadcrumb">
                        <li><a href="#"><i class="fa fa-dashboard"></i> EIS</a></li><li class="active">자재그룹별 재고</li>
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
                                        <div class="col-sm-2">
                                            <div class="form-group">
                                                <label>| 년</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                    <input type="text" class="form-control pull-right input-sm" id="ym_date" name="ym_date" placeholder="">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
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
                        <div class="col-md-12">
                            <div class="box">
                                <div id="chartHolder" style="height: 300px;"></div>
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
                $("#ym_date").datepicker({
                    language: "kr",
                    startView: "years",
                    minViewMode: "years",
                    format: "yyyy",
                    autoclose: true
                });

                $('#ym_date').val($.datepicker.formatDate('yy', new Date()));
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
                    '수량', '금액'
                ];
            }

            function makeGridUrl() {
                return "/eis/zmmfm_get_monthly_stock_et_output"
                        + "?IV_YEAR=" + $("#ym_date").val()
                        + "&IV_WERKS=" + $("#sel_scope_cd").val();
            }

            function makeChartUrl() {
                return "/eis/zmmfm_get_monthly_stock_et_output_graph"
                        + "?IV_YEAR=" + $("#ym_date").val()
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
                        {name: 'wgbez', align: 'left'},
                        {name: 'zlabst_01'},
                        {name: 'zdmbtr_01'},
                        {name: 'zlabst_02'},
                        {name: 'zdmbtr_02'},
                        {name: 'zlabst_03'},
                        {name: 'zdmbtr_03'},
                        {name: 'zlabst_04'},
                        {name: 'zdmbtr_04'},
                        {name: 'zlabst_05'},
                        {name: 'zdmbtr_05'},
                        {name: 'zlabst_06'},
                        {name: 'zdmbtr_06'},
                        {name: 'zlabst_07'},
                        {name: 'zdmbtr_07'},
                        {name: 'zlabst_08'},
                        {name: 'zdmbtr_08'},
                        {name: 'zlabst_09'},
                        {name: 'zdmbtr_09'},
                        {name: 'zlabst_10'},
                        {name: 'zdmbtr_10'},
                        {name: 'zlabst_11'},
                        {name: 'zdmbtr_11'},
                        {name: 'zlabst_12'},
                        {name: 'zdmbtr_12'}
                    ],
                    autowidth: true,
                    height: 'auto',
                    scrollOffset: 0
                });

                $("#grid").jqGrid('setGroupHeaders', {
                    useColSpanStyle: true,
                    groupHeaders: [
                        {startColumnName: 'wgbez', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'zlabst_01', numberOfColumns: 2, titleText: '01월'},
                        {startColumnName: 'zlabst_02', numberOfColumns: 2, titleText: '02월'},
                        {startColumnName: 'zlabst_03', numberOfColumns: 2, titleText: '03월'},
                        {startColumnName: 'zlabst_04', numberOfColumns: 2, titleText: '04월'},
                        {startColumnName: 'zlabst_05', numberOfColumns: 2, titleText: '05월'},
                        {startColumnName: 'zlabst_06', numberOfColumns: 2, titleText: '06월'},
                        {startColumnName: 'zlabst_07', numberOfColumns: 2, titleText: '07월'},
                        {startColumnName: 'zlabst_08', numberOfColumns: 2, titleText: '08월'},
                        {startColumnName: 'zlabst_09', numberOfColumns: 2, titleText: '09월'},
                        {startColumnName: 'zlabst_10', numberOfColumns: 2, titleText: '10월'},
                        {startColumnName: 'zlabst_11', numberOfColumns: 2, titleText: '11월'},
                        {startColumnName: 'zlabst_12', numberOfColumns: 2, titleText: '12월'}
                    ]
                });
            }

            function fnLoadChart() {
                rMateChartH5.create("chart", "chartHolder", chartVars);
            }

            function fnSearch() {
                if (!$("#ym_date").val()) {
                    fnMessageModalAlert("Notification(EIS)", "년을 입력하세요.");
                    return;
                }

                $("#grid").jqGrid('setGridParam', {url: makeGridUrl()});
                $("#grid").trigger("reloadGrid");

                document.getElementById('chart').setDataURL(makeChartUrl());
            }
        </script>

        <script type="text/javascript">
            var chartVars = "rMateOnLoadCallFunction=chartReadyHandler";

            function chartReadyHandler(id) {
                document.getElementById(id).setLayout(chartLayout);
                document.getElementById(id).setDataType('json');
                document.getElementById(id).setDataURL(makeChartUrl());
            }

            var chartLayout =
                    '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
                    + '<Options>'
                    + '<Caption text="자재그룹별 재고"/>'
                    + '</Options>'
                    + '<SeriesInterpolate id="ss"/>'
                    + '<Column2DChart showDataTips="true" selectionMode="multiple" columnWidthRatio="0.48">'
                    + '<horizontalAxis>'
                    + '<CategoryAxis categoryField="spmon"/>'
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