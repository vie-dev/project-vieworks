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
                <jsp:param name="selected_menu_cd" value="1088"/>
            </jsp:include>

            <div class="content-wrapper">
                <section class="content-header">
                    <h1>EIS<small>계획 vs 실적</small></h1>
                    <ol class="breadcrumb">
                        <li><a href="#"><i class="fa fa-dashboard"></i> EIS</a></li><li class="active">계획 vs 실적</li>
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
                                                <label>| 년월</label>
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

                //zmpfm_co001();
            });

            function zmpfm_co001() {
                $.ajax({
                    url: '/eis/zmpfm_co001',
                    data: {
                        IV_SPMON: $("#ym_date").val(),
                        IV_RBUSA: $("#sel_scope_cd").val()
                    },
                    success: function (data, textStatus, jqXHR) {
                        if (data.status == "200") {
                            $("#grid")[0].addJSONData(data);
                            document.getElementById('chart').setData(data.graph);
                        } else {
                            fnMessageModalAlert("Notification(QM)", "조회 실패");
                        }
                        console.log(data);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        fnMessageModalAlert("Notification(QM)", "조회 실패");
                    }
                });
            }

            function fnInitCondition() {
                $("#ym_date").datepicker({
                    language: "kr",
                    startView: "months",
                    minViewMode: "months",
                    format: "yyyymm",
                    autoclose: true
                });

                $('#ym_date').val($.datepicker.formatDate('yymm', new Date()));
            }

            function fnLoadCommonOption() {
                $(window).bind('resize', function () {
                    resizeJqGrid("grid", false);
                }).trigger('resize');
            }

            function makeColNames() {
                var yyyymm = $("#ym_date").val();
                var thisYearThisMonth = moment(yyyymm, 'YYYYMM');
                var prevYearThisMonth = moment(thisYearThisMonth).subtract(1, 'years');
                var thisYearPrevMonth = moment(thisYearThisMonth).subtract(1, 'months');

                return [
                    '구분<br/>&nbsp;',
                    moment(prevYearThisMonth).format('YY년 MM월') + '<br/>실적',
                    moment(thisYearPrevMonth).format('YY년 MM월') + '<br/>실적(A)',
                    moment(thisYearThisMonth).format('YY년 MM월') + '<br/>실적(B)',
                    '전월 대비<br/>(B-A)',
                    moment(prevYearThisMonth).format('YY년 MM월') + '<br/>누적(C)',
                    moment(thisYearThisMonth).format('YY년 MM월') + '<br/>누적(D)',
                    '전년 대비<br/>(D-C)',
                    '경영 계획<br/>누적(E)',
                    '달성율<br/>(D/E)'
                ];
            }

            function makeGridUrl() {
                return "/eis/zmpfm_co001_et_output01"
                        + "?IV_SPMON=" + $("#ym_date").val()
                        + "&IV_RBUSA=" + $("#sel_scope_cd").val();
            }

            function makeChartUrl() {
                return "/eis/zmpfm_co001_et_output02_graph"
                        + "?IV_SPMON=" + $("#ym_date").val()
                        + "&IV_RBUSA=" + $("#sel_scope_cd").val();
            }

            function fnLoadGrid() {
                $("#grid").jqGrid({
                    mtype: 'GET',
                    url: makeGridUrl(),
                    datatype: 'json',
                    colNames: makeColNames(),
                    cmTemplate: {sortable: false, width: 100},
                    colModel: [
                        {name: 'group_text'},
                        {name: 'by_nm_p', align: 'right'},
                        {name: 'ny_bm_p', align: 'right'},
                        {name: 'ny_nm_p', align: 'right'},
                        {name: 'mon_cal', align: 'right'},
                        {name: 'by_ny_a', align: 'right'},
                        {name: 'ny_nm_a', align: 'right'},
                        {name: 'year_cal', align: 'right'},
                        {name: 'plan', align: 'right'},
                        {name: 'ach_rate', align: 'right'}
                    ],
                    autowidth: true,
                    height: 'auto',
                    scrollOffset: 0
                });
            }

            function fnLoadChart() {
                rMateChartH5.create("chart", "chartHolder", chartVars);
            }

            function fnSearch() {
                if (!$("#ym_date").val()) {
                    fnMessageModalAlert("Notification(EIS)", "년월을 입력하세요.");
                    return;
                }

                //zmpfm_co001();

                $("#grid").jqGrid('setGridParam', {url: makeGridUrl()});

                var colNames = makeColNames();
                $("#grid").jqGrid('setLabel', 'by_nm_p', colNames[1]);
                $("#grid").jqGrid('setLabel', 'ny_bm_p', colNames[2]);
                $("#grid").jqGrid('setLabel', 'ny_nm_p', colNames[3]);
                $("#grid").jqGrid('setLabel', 'by_ny_a', colNames[5]);
                $("#grid").jqGrid('setLabel', 'ny_nm_a', colNames[6]);
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
                    + '<Caption text="계획 vs 실적"/>'
                    + '<Legend useVisibleCheck="false" horizontalGap="0" position="bottom" horizontalScrollPolicy="off"/>'
                    + '</Options>'
                    + '<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
                    + '<Combination2DChart showDataTips="true">'
                    + '<horizontalAxis>'
                    + '<CategoryAxis categoryField="spmon" padding="0.7"/>'
                    + '</horizontalAxis>'
                    + '<verticalAxis>'
                    + '<LinearAxis id="vAxis1" formatter="{numFmt}"/>'
                    + '</verticalAxis>'
                    + '<series>'
                    + '<Column2DSet type="clustered">'
                    + '<series>'
                    + '<Column2DSeries yField="data1" displayName="매출액" labelPosition="outside">'
                    + '<fill>'
                    + '<SolidColor color="#40b2e6"/>'
                    + '</fill>'
                    + '<showDataEffect>'
                    + '<SeriesInterpolate/>'
                    + '</showDataEffect>'
                    + '</Column2DSeries>'
                    + '<Column2DSeries yField="data9" displayName="영업이익" labelPosition="outside">'
                    + '<fill>'
                    + '<SolidColor color="#4453a8"/>'
                    + '</fill>'
                    + '<showDataEffect>'
                    + '<SeriesInterpolate/>'
                    + '</showDataEffect>'
                    + '</Column2DSeries>'
                    + '</series>'
                    + '</Column2DSet>'
                    + '<Line2DSeries selectable="true" yField="data10" radius="4" form="curve" displayName="영업이익율" itemRenderer="CircleItemRenderer">'
                    + '<stroke>'
                    + '<Stroke color="#f9bd03" weight="3"/>'
                    + '</stroke>'
                    + '<lineStroke>'
                    + '<Stroke color="#f9bd03" weight="3"/>'
                    + '</lineStroke>'
                    + '<verticalAxis>'
                    + '<LinearAxis id="vAxis2" formatter="{numFmt}" maximum="100"/>'
                    + '</verticalAxis>'
                    + '<showDataEffect>'
                    + '<SeriesInterpolate/>'
                    + '</showDataEffect>'
                    + '</Line2DSeries>'
                    + '</series>'
                    + '<verticalAxisRenderers>'
                    + '<Axis2DRenderer axis="{vAxis1}" showLine="false"/>'
                    + '<Axis2DRenderer axis="{vAxis2}" showLine="true">'
                    + '<axisStroke>'
                    + '<Stroke color="#f9bd03"/>'
                    + '</axisStroke>'
                    + '</Axis2DRenderer>'
                    + '</verticalAxisRenderers>'
                    + '</Combination2DChart>'
                    + '</rMateChart>'
                    ;

            var chartData = [
                {"Month": "Jan", "Profit": 400, "Cost": 550, "Revenue": 550},
                {"Month": "Feb", "Profit": 650, "Cost": 800, "Revenue": 900},
                {"Month": "Mar", "Profit": 1400, "Cost": 1600, "Revenue": 1500},
                {"Month": "Apr", "Profit": 1000, "Cost": 700, "Revenue": 900},
                {"Month": "May", "Profit": 300, "Cost": 650, "Revenue": 450},
                {"Month": "Jun", "Profit": 800, "Cost": 700, "Revenue": 780},
                {"Month": "Jul", "Profit": 600, "Cost": 400, "Revenue": 420}];
        </script>
    </body>
</html>