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
                <jsp:param name="selected_menu_cd" value="1094"/>
            </jsp:include>

            <div class="content-wrapper">
                <section class="content-header">
                    <h1>EIS<small>월별 판매</small></h1>
                    <ol class="breadcrumb">
                        <li><a href="#"><i class="fa fa-dashboard"></i> EIS</a></li><li class="active">월별 판매</li>
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
            });

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
                return [
                    '제품',
                    '수량',
                    '금액',
                    '비율',
                    '수량',
                    '금액',
                    '비율',
                    '수량',
                    '금액',
                    '수량',
                    '금액',
                    '비율',
                    '수량',
                    '금액',
                    '비율',
                    '수량',
                    '금액'
                ];
            }

            function updateGroupHeader() {
                var yyyymm = $("#ym_date").val();
                $('#ym_span_1').text(moment(yyyymm, 'YYYYMM').format('MM월'));
                $('#ym_span_2').text(moment(yyyymm, 'YYYYMM').format('MM월'));
                $('#ym_span_3').text(moment(yyyymm, 'YYYYMM').format('MM월'));
                $('#ym_span_4').text(moment(yyyymm, 'YYYYMM').format('MM월'));
            }

            function makeGridUrl() {
                return "/eis/zmpfm_co003_rt_output08"
                        + "?IV_GJAHR=" + $("#ym_date").val()
                        + "&IV_GSBER=" + $("#sel_scope_cd").val();
            }

            function makeChartUrl() {
                return "/eis/zmpfm_co003_rt_output01"
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
                        {name: 'paph3_t', width: 140, align: 'left'},
                        {name: 'cp_quan'},
                        {name: 'cp_amnt'},
                        {name: 'cp_rati'},
                        {name: 'cr_quan'},
                        {name: 'cr_amnt'},
                        {name: 'cr_rati'},
                        {name: 'cd_quan'},
                        {name: 'cd_amnt'},
                        {name: 'ap_quan'},
                        {name: 'ap_amnt'},
                        {name: 'ap_rati'},
                        {name: 'ar_quan'},
                        {name: 'ar_amnt'},
                        {name: 'ar_rati'},
                        {name: 'ad_quan'},
                        {name: 'ad_amnt'}
                    ],
                    autowidth: true,
                    height: 'auto',
                    scrollOffset: 0
                });

                $("#grid").jqGrid('setGroupHeaders', {
                    useColSpanStyle: true,
                    groupHeaders: [
                        {startColumnName: 'paph3_t', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'cp_quan', numberOfColumns: 8, titleText: '매출액 (당월)'},
                        {startColumnName: 'ap_quan', numberOfColumns: 8, titleText: '매출액 (누적)'}
                    ]
                });

                $("#grid").jqGrid('setGroupHeaders', {
                    useColSpanStyle: true,
                    groupHeaders: [
                        {startColumnName: 'paph3_t', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'cp_quan', numberOfColumns: 3, titleText: '<span id="ym_span_1"></span> 계획'},
                        {startColumnName: 'cr_quan', numberOfColumns: 3, titleText: '<span id="ym_span_2"></span> 실적'},
                        {startColumnName: 'cd_quan', numberOfColumns: 2, titleText: '차이'},
                        {startColumnName: 'ap_quan', numberOfColumns: 3, titleText: '<span id="ym_span_3"></span> 계획 (누적)'},
                        {startColumnName: 'ar_quan', numberOfColumns: 3, titleText: '<span id="ym_span_4"></span> 실적 (누적)'},
                        {startColumnName: 'ad_quan', numberOfColumns: 2, titleText: '차이'}
                    ]
                });

                updateGroupHeader();
            }

            function fnLoadChart() {
                rMateChartH5.create("chart", "chartHolder", chartVars);
            }

            function fnSearch() {
                if (!$("#ym_date").val()) {
                    fnMessageModalAlert("Notification(EIS)", "년월을 입력하세요.");
                    return;
                }

                $("#grid").jqGrid('setGridParam', {url: makeGridUrl()});
                updateGroupHeader();
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
                    + '<Caption text="월별 판매"/>'
                    + '<Legend useVisibleCheck="false" horizontalGap="0" position="bottom" horizontalScrollPolicy="off"/>'
                    + '</Options>'
                    + '<NumberFormatter id="numfmt" useThousandsSeparator="true"/>'
                    + '<Combination2DChart showDataTips="true">'
                    + '<horizontalAxis>'
                    + '<CategoryAxis categoryField="perbl" padding="1"/>'
                    + '</horizontalAxis>'
                    + '<verticalAxis>'
                    + '<LinearAxis id="vAxis1" formatter="{numfmt}"/>'
                    + '</verticalAxis>'
                    + '<series>'
                    + '<Column2DSeries labelPosition="outside" yField="cur_amnt" displayName="실적" columnWidthRatio="0.54">'
                    + '<fill>'
                    + '<SolidColor color="#41b2e6"/>'
                    + '</fill>'
                    + '<showDataEffect>'
                    + '<SeriesInterpolate/>'
                    + '</showDataEffect>'
                    + '</Column2DSeries>'
                    + '<Line2DSeries radius="6" yField="cur_amnt_plan" displayName="경영" itemRenderer="CircleItemRenderer">'
                    + '<verticalAxis>'
                    + '<LinearAxis id="vAxis2"/>'
                    + '</verticalAxis>'
                    + '<showDataEffect>'
                    + '<SeriesInterpolate/>'
                    + '</showDataEffect>'
                    + '<lineStroke>'
                    + '<Stroke color="#f9bd03" weight="4"/>'
                    + '</lineStroke>'
                    + '<stroke>'
                    + '<Stroke color="#f9bd03" weight="3"/>'
                    + '</stroke>'
                    + '</Line2DSeries>'
                    + '<Line2DSeries radius="6" yField="pre_amnt" displayName="전년" itemRenderer="CircleItemRenderer">'
                    + '<verticalAxis>'
                    + '<LinearAxis id="vAxis2" interval="40" maximum="320"/>'
                    + '</verticalAxis>'
                    + '<showDataEffect>'
                    + '<SeriesInterpolate/>'
                    + '</showDataEffect>'
                    + '<lineStroke>'
                    + '<Stroke color="#5587a2" weight="4"/>'
                    + '</lineStroke>'
                    + '<stroke>'
                    + '<Stroke color="#5587a2" weight="3"/>'
                    + '</stroke>'
                    + '</Line2DSeries>'
                    + '</series>'
                    + '<verticalAxisRenderers>'
                    + '<Axis2DRenderer axis="{vAxis1}" showLine="false"/>'
                    + '<Axis2DRenderer axis="{vAxis2}" showLine="false"/>'
                    + '</verticalAxisRenderers>'
                    + '</Combination2DChart>'
                    + '</rMateChart>';
        </script>
    </body>
</html>