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
                <jsp:param name="selected_menu_cd" value="1090"/>
            </jsp:include>

            <div class="content-wrapper">
                <section class="content-header">
                    <h1>EIS<small>영업이익분석</small></h1>
                    <ol class="breadcrumb">
                        <li><a href="#"><i class="fa fa-dashboard"></i> EIS</a></li><li class="active">영업이익분석</li>
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
                                        <div class="col-sm-2">
                                            <div class="form-group">
                                                <label>| 기간</label>
                                                <div class="input-group">
                                                    <label><input type="radio" name="rdo_period" class="flat-red" value="TM" checked>당월</label>
                                                    &nbsp;
                                                    <label><input type="radio" name="rdo_period" class="flat-red" value="ACC">누적</label>
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
                            <div class="box" style="overflow-y: scroll">
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

                //zmpfm_co002();
            });

            function zmpfm_co002() {
                $.ajax({
                    url: '/eis/zmpfm_co002',
                    data: {
                        IV_SPMON: $("#ym_date").val(),
                        IV_GSBER: $("#sel_scope_cd").val(),
                        IV_PERIOD: $(':radio[name="rdo_period"]:checked').val()
                    },
                    success: function (data, textStatus, jqXHR) {
                        if (data.status == "200") {
                            console.log(data.rows);
                            $("#grid")[0].addJSONData(data);
                            document.getElementById('chart').setData(data.graph);
                        } else {
                            fnMessageModalAlert("Notification(QM)", "조회 실패");
                        }
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
                return [
                    '영역',
                    '계층',
                    '매출액',
                    '금액',
                    '비율',
                    '금액',
                    '비율',
                    '금액',
                    '비율',
                    '합계',
                    '(원가율)',
                    '기타매출원가',
                    '사업부직과',
                    '사업부배부',
                    '합계',
                    '영업이익',
                    '영업이익율'
                ];
            }

            function updateGroupHeader() {
                var yyyymm = $("#ym_date").val();
                $('#ym_span').text(moment(yyyymm, 'YYYYMM').format('YY년 MM월'));
                if ($(':radio[name="rdo_period"]:checked').val() == 'TM') {
                    $('#this_accum_span').text('당월');
                } else if ($(':radio[name="rdo_period"]:checked').val() == 'ACC') {
                    $('#this_accum_span').text('누적');
                }
            }

            function makeGridUrl() {
                return "/eis/zmpfm_co002"
                        + "?IV_SPMON=" + $("#ym_date").val()
                        + "&IV_GSBER=" + $("#sel_scope_cd").val()
                        + "&IV_PERIOD=" + $(':radio[name="rdo_period"]:checked').val();
            }

            function makeChartUrl() {
                return "/eis/zmpfm_co002_et_output02_graph"
                        + "?IV_SPMON=" + $("#ym_date").val()
                        + "&IV_GSBER=" + $("#sel_scope_cd").val()
                        + "&IV_PERIOD=" + $(':radio[name="rdo_period"]:checked').val()
            }

            function fnLoadGrid() {
                $("#grid").jqGrid({
                    mtype: 'GET',
                    url: makeGridUrl(),
                    datatype: 'json',
                    colNames: makeColNames(),
                    cmTemplate: {sortable: false, width: 80},
                    colModel: [
                        {name: 'gsber_text', width: 120},
                        {name: 'paph3_text', width: 140},
                        {name: 'amt00', align: 'right'},
                        {name: 'amt01_1', align: 'right'},
                        {name: 'rate01_1', align: 'right'},
                        {name: 'amt01_2', align: 'right'},
                        {name: 'rate01_2', align: 'right'},
                        {name: 'amt01_3', align: 'right'},
                        {name: 'rate01_3', align: 'right'},
                        {name: 'sum01', align: 'right'},
                        {name: 'rate01', align: 'right'},
                        {name: 'amt01_4', align: 'right'},
                        {name: 'amt02_1', align: 'right'},
                        {name: 'amt02_2', align: 'right'},
                        {name: 'sum02', align: 'right'},
                        {name: 'amt03', align: 'right'},
                        {name: 'rate03', align: 'right'}
                    ],
                    autowidth: true,
                    height: 'auto',
                    rowNum: -1,
                    scrollOffset: 0
                });

                $("#grid").jqGrid('setGroupHeaders', {
                    useColSpanStyle: true,
                    groupHeaders: [
                        {startColumnName: 'gsber_text', numberOfColumns: 2, titleText: '구분'},
                        {startColumnName: 'amt00', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'amt01_1', numberOfColumns: 7, titleText: '매출원가'},
                        {startColumnName: 'rate01', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'amt01_4', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'amt02_1', numberOfColumns: 3, titleText: '판관비'},
                        {startColumnName: 'amt03', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'rate03', numberOfColumns: 1, titleText: ''}
                    ]
                });

                $("#grid").jqGrid('setGroupHeaders', {
                    useColSpanStyle: true,
                    groupHeaders: [
                        {startColumnName: 'gsber_text', numberOfColumns: 2, titleText: '<span id="ym_span"></span><br/><span id="this_accum_span"></span>'},
                        {startColumnName: 'amt00', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'amt01_1', numberOfColumns: 2, titleText: '재료비'},
                        {startColumnName: 'amt01_2', numberOfColumns: 2, titleText: '노무비'},
                        {startColumnName: 'amt01_3', numberOfColumns: 2, titleText: '경비'},
                        {startColumnName: 'sum01', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'rate01', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'amt01_4', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'amt02_1', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'amt02_2', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'sum02', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'amt03', numberOfColumns: 1, titleText: ''},
                        {startColumnName: 'rate03', numberOfColumns: 1, titleText: ''}
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

                //zmpfm_co002();

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
                    + '<Caption text="영업이익분석"/>'
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
                    + '<Column2DSeries yField="manu_cost" displayName="제조원가" labelPosition="outside">'
                    + '<fill>'
                    + '<SolidColor color="#40b2e6"/>'
                    + '</fill>'
                    + '<showDataEffect>'
                    + '<SeriesInterpolate/>'
                    + '</showDataEffect>'
                    + '</Column2DSeries>'
                    + '<Column2DSeries yField="mat_cost" displayName="재료비" labelPosition="outside">'
                    + '<fill>'
                    + '<SolidColor color="#4453a8"/>'
                    + '</fill>'
                    + '<showDataEffect>'
                    + '<SeriesInterpolate/>'
                    + '</showDataEffect>'
                    + '</Column2DSeries>'
                    + '</series>'
                    + '</Column2DSet>'
                    + '<Line2DSeries selectable="true" yField="sales_cost_rate" radius="4" form="curve" displayName="매출원가율" itemRenderer="CircleItemRenderer">'
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
                    + '<Line2DSeries selectable="true" yField="mat_cost_rate" radius="4" form="curve" displayName="재료비구성비율" itemRenderer="CircleItemRenderer">'
                    + '<stroke>'
                    + '<Stroke color="#5587a2" weight="3"/>'
                    + '</stroke>'
                    + '<lineStroke>'
                    + '<Stroke color="#5587a2" weight="3"/>'
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
        </script>
    </body>
</html>