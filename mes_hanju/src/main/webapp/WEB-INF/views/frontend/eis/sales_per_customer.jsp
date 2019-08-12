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
                <jsp:param name="selected_menu_cd" value="1095"/>
            </jsp:include>

            <div class="content-wrapper">
                <section class="content-header">
                    <h1>EIS<small>고객별 판매</small></h1>
                    <ol class="breadcrumb">
                        <li><a href="#"><i class="fa fa-dashboard"></i> EIS</a></li><li class="active">고객별 판매</li>
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
                                                        <option value="1100">의료</option>
                                                        <option value="2100">광</option>
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
                    '고객',
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

            function makeGridUrl() {
                return "/eis/zmpfm_co003_rt_output03"
                        + "?IV_GJAHR=" + $("#ym_date").val()
                        + "&IV_GSBER=" + $("#sel_scope_cd").val();
            }

            function makeChartUrl() {
                return "/eis/zmpfm_co003_rt_output03_graph"
                        + "?IV_GJAHR=" + $("#ym_date").val()
                        + "&IV_GSBER=" + $("#sel_scope_cd").val();
            }

            function fnLoadGrid() {
                $("#grid").jqGrid({
                    mtype: 'GET',
                    url: makeGridUrl(),
                    datatype: 'json',
                    colNames: makeColNames(),
                    cmTemplate: {sortable: false, width: 100, align: 'right'},
                    colModel: [
                        {name: 'name1', align: 'left'},
                        {name: 'quan_sum'},
                        {name: 'amnt_sum'},
                        {name: 'quan_01'},
                        {name: 'amnt_01'},
                        {name: 'quan_02'},
                        {name: 'amnt_02'},
                        {name: 'quan_03'},
                        {name: 'amnt_03'},
                        {name: 'quan_04'},
                        {name: 'amnt_04'},
                        {name: 'quan_05'},
                        {name: 'amnt_05'},
                        {name: 'quan_06'},
                        {name: 'amnt_06'},
                        {name: 'quan_07'},
                        {name: 'amnt_07'},
                        {name: 'quan_08'},
                        {name: 'amnt_08'},
                        {name: 'quan_09'},
                        {name: 'amnt_09'},
                        {name: 'quan_10'},
                        {name: 'amnt_10'},
                        {name: 'quan_11'},
                        {name: 'amnt_11'},
                        {name: 'quan_12'},
                        {name: 'amnt_12'}
                    ],
                    autowidth: true,
                    height: 'auto',
                    scrollOffset: 0
                });

                $("#grid").jqGrid('setGroupHeaders', {
                    useColSpanStyle: true,
                    groupHeaders: [
                        {startColumnName: 'name1', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'quan_sum', numberOfColumns: 2, titleText: '합계'},
                        {startColumnName: 'quan_01', numberOfColumns: 2, titleText: '01월'},
                        {startColumnName: 'quan_02', numberOfColumns: 2, titleText: '02월'},
                        {startColumnName: 'quan_03', numberOfColumns: 2, titleText: '03월'},
                        {startColumnName: 'quan_04', numberOfColumns: 2, titleText: '04월'},
                        {startColumnName: 'quan_05', numberOfColumns: 2, titleText: '05월'},
                        {startColumnName: 'quan_06', numberOfColumns: 2, titleText: '06월'},
                        {startColumnName: 'quan_07', numberOfColumns: 2, titleText: '07월'},
                        {startColumnName: 'quan_08', numberOfColumns: 2, titleText: '08월'},
                        {startColumnName: 'quan_09', numberOfColumns: 2, titleText: '09월'},
                        {startColumnName: 'quan_10', numberOfColumns: 2, titleText: '10월'},
                        {startColumnName: 'quan_11', numberOfColumns: 2, titleText: '11월'},
                        {startColumnName: 'quan_12', numberOfColumns: 2, titleText: '12월'}
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
                    '<rMateChart backgroundColor="#FFFFFF" borderStyle="none" >'
                    + '<Options>'
                    + '<Caption text="고객별 판매"/>'
                    + '<Legend useVisibleCheck="false"/>'
                    + '</Options>'
                    + '<Pie2DChart showDataTips="true">'
                    + '<series>'
                    + '<Pie2DSeries nameField="name1" field="amnt_sum" labelPosition="inside" color="#ffffff" startAngle="136">'
                    + '<showDataEffect>'
                    + '<SeriesSlide duration="1000"/>'
                    + '</showDataEffect>'
                    + '</Pie2DSeries>'
                    + '</series>'
                    + '</Pie2DChart>'
                    + '</rMateChart>'
                    ;
        </script>
    </body>
</html>