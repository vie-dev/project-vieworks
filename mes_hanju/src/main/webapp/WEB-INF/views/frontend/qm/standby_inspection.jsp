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
            <jsp:param name="selected_menu_cd" value="1080" />
        </jsp:include>

        <div class="content-wrapper">
            <section class="content-header">
                <h1>
                    MES <small>품질처리</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="#"><i class="fa fa-dashboard"></i> MES</a></li>
                    <li class="active">품질처리</li>
                </ol>
            </section>
            <section class="content">
                <div class="row">
                    <section class="col-lg-12">
                        <div class="box box-success box-solid" style="min-height: 70px;">
                            <div class="box-header with-border">
                                <h3 class="box-title">조회조건</h3>
                                <div class="box-tools pull-right">
                                    <button type="button" id="btn_search_csr" class="btn btn-primary btn-sm" onclick="fnSearchInspGrid();">조회</button>
                                    <button type="button" id="process" class="btn btn-success btn-sm" onclick = "modal_open();"style="color: white;">처리</button>
                                    <button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_role');" data-selfilepath="/upload" data-selfilename="test.xlsx">
									 	<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
									</button>
                                </div>
                            </div>
                            <div id="" class="box-body">
                                <div class="row">
                                	<div class="col-sm-2 to_p">
                                        <div class="form-group">
                                            <label>Lot 유형</label><br/>
                                            <input type="radio"	name="t_gubun"   value="tp"  onclick="successYn();"> STOCK
                                            <input type="radio" name="t_gubun"   value="tw" checked onclick="successYn();"> NON STOCK
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                       		<label>생성일</label><br/>
<!--                                        		<label> <input type="radio" name="date_type" class="flat-red" value="cm" checked> 생성일	</label> -->
<!--  											<label> <input type="radio" name="date_type" class="flat-red" value="su"> 처리일</label> -->
                                            <div class="input-group">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <input type="text" class="form-control pull-right" id="req_date_range">
                                            </div>

                                        </div>
                                    </div>
                                     <div class="col-sm-2" style="padding-right: 0px;">
                                    	<label>Plant 구분</label><br/>
										<select id="m_wkctr" class="form-control select2" data-placeholder="" style="width: 100%;">
											<option value="">전체</option>
											<option value="1110">의료영상</option>
											<option value="1210">광영상</option>
										</select>
									</div>
                                                                 
<!--                                      <div class="col-sm-2"> -->
<!-- 	                                    <button type="button" id="process" class="btn btn-warning btn-sm" onclick = "modal_open();"style="width: 210px;color: white;height: 60px;">처리</button> -->
<!--                        				 </div> -->
                       				
                       				 <div class="col-sm-2">
                                        <div class="form-group">
                                        	<label>생산오더번호</label><br/>
											<input type="text" id="i_pordno" class="form-control">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                        	<label>생산오더품목코드</label><br/>
											<input type="text" id="i_matnr" class="form-control">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                        	<label>생산오더품목명</label><br/>
											<input type="text" id="i_maktx" class="form-control">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                        	<label>생산오더품목 SN</label><br/>
											<input type="text" id="i_sernr" class="form-control">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>그룹선택</label> 
                                           	<select id="c_sel_step1" class="form-control select2 input-sm" onChange="c_changeStep($(this).val(),'step1');">
                                           	<option>-</option>
											</select>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>Lv.1</label> 
                                           <select id="c_sel_step2" class="form-control select2 input-sm" onChange="c_changeStep($(this).val(),'step2');">
                                      		<option>-</option>
											</select>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>Lv.2</label> 
                                           	<select id="c_sel_step3" class="form-control select2 input-sm" onChange="c_changeStep($(this).val(),'step3');">
                                            <option>-</option>
											</select>                                        
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>Lv.3</label> 
                                           <select id="c_sel_step4" class="form-control select2 input-sm"> 
                                           <option>-</option>
											</select>  
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>상태</label><br />
                                            <label> <input type="radio"	name="insts" class="flat-red" value="" checked>전체</label>
                                            <label> <input type="radio" name="insts" class="flat-red" value="ST"> 대기</label>
                                            <label> <input type="radio" name="insts" class="flat-red" value="SS"> 처리완료</label>
                                        </div>
                                    </div>
                                    
                                    
                                </div>
                            </div>
                        </div>
               <!--          <div class="box box-default box-solid" style="min-height: 680px;">
                            <div class="box-header with-border">
                            	<div class="col-sm-2">
                            	</div>
                            	<div class="col-sm-2">
                                	합격/불합격
                                	<form name="mform">
                                    <input type="radio"	name="success_yn" value="p9" onclick="successYn();" checked>합격
                                    <input type="radio" name="success_yn" value="p10" onclick="successYn();"> 불합격
                                    </form>
                                </div>
                                <div class="col-sm-2">
                                	플랜트 구분
									<select id="s_werks" class="form-control select2" data-placeholder="유형 선택" style="width: 100%;">
										<option value="1110">의료</option>
										<option value="1210">광</option>
									</select>
								</div>
								<div class="col-sm-2">
                                	From 창고
									<select id="s_from" class="form-control select2" data-placeholder="유형 선택" style="width: 100%;">
									</select>
								</div>
									<button type="button" id="process" class="btn btn-primary btn-sm" onclick = "modal_open();"style="width: 210px;color: white;height: 60px;">처리</button>
									<button type="button" id="cancel_process" class="btn btn-warning btn-sm" onclick = "cancel_open();"style="width: 210px;color: white;height: 60px;">취소</button>
                            </div>
                            <div class="box-body">
                                <div class="row">
                                    <div id="dv_grid_role" class="col-sm-12">
                                        <table id="grid_role"></table>
                                        <div id="grid_role_pager"></div>
                                    </div>
                                </div>
                            </div>
                        </div> -->
                        <div class="box-body">
                        <div class="col-sm-12 text-right" style="font-weight:bold; color:red;">
									<i class="fa fa-check" aria-hidden="true"></i> <span id="warningTxt">1. 자재불량내역을 선택 2.불량항목 level선택 3. 입력 버튼 클릭  :::::::  순서로 불량내역을 등록해주세요.</span></div>
                        <div class="row">
							<div class="col-sm-2">
								<label for="m_type" class="col-sm-4 control-label">Type</label>
								<select id="sel_step1" class="form-control select2" onChange="changeStep($(this).val(),'step1');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-3">
								<label for="m_lv1" class="col-sm-2 control-label">Lv.01</label>
								<select id="sel_step2" class="form-control select2" onChange="changeStep($(this).val(),'step2');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-3">
								<label for="m_lv2" class="col-sm-2 control-label">Lv.02</label>
								<select id="sel_step3" class="form-control select2" onChange="changeStep($(this).val(),'step3');">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-3">
								<label for="m_lv3" class="col-sm-2 control-label">Lv.03</label>
								<select id="sel_step4" class="form-control select2">
								<option>-</option>
								</select>
							</div>
							<div class="col-sm-1">
								<label for="lv_c" class="col-sm-1 control-label"></label>
								<button type="button" id="" onclick="input_code();" class="btn btn-primary btn-sm" style="height: 55px;width: 55px;">입력</button>
							</div>
						</div>
	        			</div>
                        <div class="box-body">
                                <div class="row">
                                    <div id="dv_grid_role" class="col-sm-12">
                                        <table id="grid_role"></table>
                                        <div id="grid_role_pager"></div>
                                    </div>
                                </div>
                         </div>
                    </section>
                </div>
            </section>
        </div>
    </div>
    <jsp:include page="/common/footer_inc" flush="true">
        <jsp:param name="page_title" value="0" />
    </jsp:include>

    <jsp:include page="/common/sidebar_rview_inc" flush="true">
        <jsp:param name="page_title" value="0" />
    </jsp:include>
    
    <!--  modal area1 -->
<div class="modal fade" id="modal_detail" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">불량확정처리</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
<!-- 				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal"> -->
					<div class="row">
						<div class=" col-md-12">
						 &nbsp; 처리일자와 처리구분을 선택해주세요.
						</div>	
					</div>
					<div class="row">
						<div class=" col-md-12">
							<div class="box">								
								<div class="row">
								<div class=" col-md-12">
								<div class="box">
<!-- 								<div class="box-header with-border"> -->
<!-- 									<h3 class="box-title">검사결과 처리</h3> -->
<!-- 								</div> -->
								<div class="form-group">
										<label for="" class="col-sm-3 control-label">처리일자</label>
										<div class="col-sm-9">
											<input type="input" id="r_conf_date" name="r_conf_date"  placeholder="" maxlength="10" style="height: 33px;">
										</div>
								</div>
								<div class="form-group">
										<label for="" class="col-sm-3 control-label">처리 구분</label>
										<div class="col-sm-9">
                                            <label class="flat-red pass"> 양품</label><input type="radio" name="s_flag" class="flat-red" value="Y" checked>
                                            <label class="flat-red npass">  불량</label><input type="radio" name="s_flag" class="flat-red" value="F">
<!--                                             <label> <input type="radio" name="s_flag" class="flat-red" value="N"> 폐기</label> -->
<!--                                             <label> <input type="radio" name="s_flag" class="flat-red" value="R"> 재작업</label> -->
<!--                                             <label> <input type="radio" name="s_flag" class="flat-red" value="M"> 원자재불량</label> -->
										</div>
								</div>
								<div class="form-group to_p">
										<label for="" class="col-sm-3 control-label">To 플랜트</label>
										<div class="col-sm-9">
											<input type="input" id="s_to_werks" name="s_to_werks"  placeholder="" maxlength="10" style="height: 33px;" readonly="readonly">
 										<!--
										<select id="s_to_werks" class="form-control select2" data-placeholder="유형 선택" style="width: 100%;">
											<option value="">전체</option>
											<option value="1110">의료</option>
											<option value="1210">광</option>
										</select>
										-->
										</div>
								</div>
										 
								<div class="form-group to_s">
										<label for="" class="col-sm-3 control-label">To 창고</label>
										<div class="col-sm-9">
										<select id="s_to" class="form-control select2" data-placeholder="유형 선택" style="width: 100%;">
										</select>
										</div>
								</div>
								</div>
								</div>
								</div>
							</div>
						</div>
					</div>
<!-- 				</form> -->
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-success" onclick="process_yn();">요청</button>
					<button type="button" id="" class="btn btn-default" onclick="modal_detail_close();">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- modal area start -->
<div class="modal fade" id="modal_sernr_add" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">시리얼 입력 내역</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="box box-warning box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">시리얼 입력</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_worker_add" class="btn btn-success btn-sm" onclick="inputSernr();">시리얼입력</button>
						</div>
					</div>
					<form id="frm_worker_add" name="frm_worker_add" class="form-horizontal">
					<div class="box-body">
						<div class="form-group">
							<label for="mes_po" class="col-sm-3 control-label">Lot No.</label>
							<div class="col-sm-9">
								<input type="input" id="m_lotno" name="m_lotno" class="form-control"  maxlength="20" readonly="readonly">
							</div>
						</div>
						<div class="form-group">
							<label for="mes_po" class="col-sm-3 control-label">시리얼 입력 내역</label>
							<div class="col-sm-9 box-body" id="dv_grid_sernr" >
								<table id="grid_sernr"></table>							
							</div>
						</div>         
					</div>
					</form>
				</div><!-- end box -->
			</div><!-- end modal body -->
		</div><!-- end modal-content -->
	</div><!-- end modal dialog -->
</div><!-- end modal div -->
<!-- main serial insert -->
<script type="text/javascript">
var selected_pordno_pop;

$(function($) {
	fnLoadCommonOption();
	fnLoadSernrAddGrid();
	fnLoadInspGrid();
	
	
	initOptions($('#c_sel_step1'));
	initOptions($('#c_sel_step2'));
	initOptions($('#c_sel_step3'));
	initOptions($('#c_sel_step4'));
	c_makeSelStep1();
	$('#m_wkctr').change(function(){
		initOptions($('#c_sel_step1'));
		initOptions($('#c_sel_step2'));
		initOptions($('#c_sel_step3'));
		initOptions($('#c_sel_step4'));
		c_makeSelStep1();
		makeSelStep1();
	});

	$("input[name=s_flag]").change(function() { 
		getToStrList();
	}); 
	                             
	
	$(".pass").text("합격");
	$(".npass").text("불합격");
	$(".to_p").hide()
	$(".to_s").hide()
	
	/*
	$("input[name=t_gubun]").change(function() { 
		if($(':radio[name="t_gubun"]:checked').val() == "tp") {
	 		$(".pass").text("양품");
	 		$(".npass").text("불량");
	 		$(".to_p").show();
	 		$(".to_s").show();
		}
		if($(':radio[name="t_gubun"]:checked').val() == "tw") {
	 		$(".pass").text("합격");
	 		$(".npass").text("불합격");
	 		$(".to_p").hide()
	 		$(".to_s").hide()
		}
	}); 
 	*/
	                                             
	$("#r_conf_date").datepicker({
		language: "kr",
		todayHighlight: true,
		format: "yyyymmdd",
		autoclose: true
  	});
	
	$(window).bind('resize', function() {
		resizeJqGrid("grid_role", false);
	}).trigger('resize');
	
	$('#r_conf_date').val($.datepicker.formatDate('yymmdd', new Date()));
	
	$('#req_date_range').daterangepicker({
		 locale: {
			format: 'YYYY-MM-DD' // inputbox 에 '2011/04/29' 로표시
			,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			,dayNames: ['일', '월', '화', '수', '목', '금', '토']
			,dayNames : ['일', '월', '화', '수', '목', '금', '토']
			,dayNamesShort : ['일', '월', '화', '수', '목', '금', '토']
			,dayNamesMin : ['일', '월', '화', '수', '목', '금', '토']
			,showMonthAfterYear: true
			,yearSuffix: '년'
			,orientation: "top left"
	    }
	});
	
	initScreenSizeModal();
})


function fnLoadCommonOption()
{
		
		/* $('input[type="radio"].flat-red').iCheck({
			checkboxClass : 'icheckbox_flat-green',
			radioClass : 'iradio_flat-green',
			handle : 'radio'
		}); */
	}

	function fnSearchInspGrid() {
		 
		var date1 = $("#req_date_range").val().substring(0,10).replace("-","").replace("-","");
		var date2 = $("#req_date_range").val().substring(13,23).replace("-","").replace("-","");
		
       /*t_gubun  value="tp"    제품不
         t_gubun  value="tw"    공정不
         t_gubun  value="tl"    최종검사不
         t_gubun  value="td"    포장검사不 
         insts            value="ST"    대기
         insts            value="SS"    처리완료
         */
		
// 		var chked_gubun = encodeURIComponent($(':radio[name="t_gubun"]:checked').val());
       var chked_gubun = "tw";
		var chked_insts= encodeURIComponent($(':radio[name="insts"]:checked').val());
		
	
 
		var page_url = "/frontend/qm/standby_inspection_select" ;
		page_url += "?gubun=" + encodeURIComponent(chked_gubun)
		page_url += "&dept_cd="+encodeURIComponent($("#m_wkctr").val())
		page_url += "&insts="+ encodeURIComponent(chked_insts)

		page_url += "&from_budat=" + encodeURIComponent(date1)
		page_url += "&to_budat=" + encodeURIComponent(date2)

		page_url += "&org_no=" + encodeURIComponent($("#i_pordno").val())
		page_url += "&matnr=" + encodeURIComponent($("#i_matnr").val())
		page_url += "&maktx=" + encodeURIComponent($("#i_maktx").val())
		page_url += "&sernp_no=" + encodeURIComponent($("#i_sernr").val());
		
		page_url += "&gr_code=" + encodeURIComponent($("#c_sel_step1").val() == null?'':$("#c_sel_step1").val());
		page_url += "&level1_code=" + encodeURIComponent($("#c_sel_step2").val() == null?'':$("#c_sel_step2").val());
		page_url += "&level2_code=" + encodeURIComponent($("#c_sel_step3").val() == null?'':$("#c_sel_step3").val());
		page_url += "&level3_code=" + encodeURIComponent($("#c_sel_step4").val() == null?'':$("#c_sel_step4").val());
		
		$("#grid_role").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
		$("#grid_role").setGridParam({ page: 1 }).trigger("reloadGrid");
		
		if (chked_gubun=="tw") {
			
			$('#grid_role').showCol('org_issue_memo');
			$('#grid_role').showCol('org_remark');

			} else {

			$('#grid_role').hideCol('org_issue_memo');
			$('#grid_role').hideCol('org_remark');

		}
		
		 $("#grid_role").trigger("resize");

		
		initOptions($('#sel_step1'));
		initOptions($('#sel_step2'));
		initOptions($('#sel_step3'));
		initOptions($('#sel_step4'));
		makeSelStep1();
	}
	
	function fnLoadInspGrid() {
		$("#grid_role").jqGrid({
			datatype : "json",
			colNames : ['상태','결과', '생산오더번호','자재코드','자재내역','시리얼번호', '수량', '발생공정','검사lot' ,'불량등록자', '불량등록일자','처리일','플랜트','임시불량메모', '불량내역 Type', '불량내역 Lv.1', '불량내역 Lv.2','불량내역 Lv.3', 
			           /*'확정불량내역 Type', '확정불량내역 Lv.1', '확정불량내역 Lv.2', '확정불량내역 Lv.3',*/ '이슈코드', 'insts', 'werks', '자재문서번호', '문서년도', '참조문서번호', 'meins', 'lgort', 'sernp' ],
			colModel : [
 				        
				{name : 'insts_nm',index : 'insts_nm',width : 70,sorttype : "text",sortable : true},	//상태
				{name : 'insp_yn',index : 'insp_yn',width : 70,sorttype : "text",sortable : true, formatter:jqgridHighlightFormatterYn}, //결과
				{name : 'org_no',index : 'org_no',width : 120,sorttype : "text",sortable : true},	//생산계획번호
				{name : 'matnr',index : 'matnr',width : 140,sorttype : "text",sortable : true}, //자제코드
				{name : 'maktx',index : 'maktx',width : 200,sorttype : "text",sortable : true},	//자재내역
				{name : 'sernp_no',index : 'sernp_no',width : 110,sorttype : "text",sortable : true}, //시리얼번호
				{name : 'bdmng',index : 'bdmng',width : 80,sorttype : "text",sortable : true, align:'right'}, //수량
				{name : 'routing_nm',index : 'routing_nm',width : 80,sorttype : "text",	sortable : true}, //발생공정
				{name : 'inspec_lot',index : 'inspec_lot',width : 140,	sorttype : "text",sortable : true, key : true, hidden:true},	//검사lot 
				{name : 'creator',index : 'creator',width : 100,	sorttype : "text",sortable : true}, //불량등록자
				{name : 'budat',index : 'budat',width : 100,sorttype : "text",	sortable : true}, //불량등록일자
				{name : 'cmdat',index : 'cmdat',width : 100,	sorttype : "text",sortable : true}, //처리일
				//{name : 'f_sernp_no',index : 'f_sernp_no',width : 80,sorttype : "text",sortable : true, formatter:sernrYn}, //시리얼여부
				{name : 'werks_nm',index : 'werks_nm',width : 60,sorttype : "text",sortable : true}, //플랜트
				{name : 'org_remark',index : 'org_remark',width : 110,sorttype : "text",sortable : true, hidden:true},	//임시불량메모
				{name : 'org_gr_nm',index : 'org_gr_name',width : 150,sorttype : "text",sortable : true},	//임시불량내역 Type
				{name : 'org_level1_name',index : 'org_level1_name',width : 150,sorttype : "text",sortable : true},	//임시불량내역 Lv.1
				{name : 'org_level2_name',index : 'org_level2_name',width : 150,sorttype : "text",sortable : true},	//임시불량내역 Lv.2
				{name : 'org_issue_memo',index : 'org_issue_memo',width : 150,sorttype : "text",sortable : true},	//임시불량내역 Lv.3
// 				{name : 'gr_nm',index : 'gr_nm',width : 115,sorttype : "text",sortable : true},	//확정불량내역 Type
// 				{name : 'level1_name',index : 'level1_name',width : 110,sorttype : "text",sortable : true},	//확정불량내역 Lv.1
// 				{name : 'level2_name',index : 'level2_name',width : 110,sorttype : "text",sortable : true},	//확정불량내역 Lv.2
// 				{name : 'issue_memo',index : 'issue_memo',width : 110,sorttype : "text",sortable : true},	//확정불량내역 Lv.3
				{name : 'issue_code',index : 'issue_code',width : 60,sorttype : "text",sortable : true, hidden:true},	//이슈코드
				
				{name : 'insts',index : 'insts',width : 5,sorttype : "text",sortable : true, hidden:true},	//insts
				{name : 'werks',index : 'werks',width : 10,sorttype : "text",sortable : true, hidden:true}, //werks 
				{name : 'mblnr',index : 'mblnr',width : 10,sorttype : "text",sortable : true, hidden:true}, //자재문서번호
				{name : 'mjahr',index : 'mjahr',width : 10,sorttype : "text",sortable : true, hidden:true}, //문서년도
				{name : 'ref_doc_no',index : 'ref_doc_no',width : 10,sorttype : "text",sortable : true, hidden:true}, //참조문서번호
				{name : 'meins',index : 'meins',width : 10,sorttype : "text",sortable : true, hidden:true}, //meins
				
				{name : 'lgort',index : 'lgort',width : 10,sorttype : "text",sortable : true, hidden:true}, //lgort
				{name : 'sernp',index : 'sernp',width : 10,sorttype : "text",sortable : true, hidden:true}, //sernp
			],
			rowNum:20,
			rowList : [ 20, 50, 100 ],
			pager : "#grid_role_pager",
			viewrecords : true,
			autowidth : true,
			shrinkToFit : false,
			multiselect : true,
			height : 430,
			altRows : true,
			rownumbers : true,
			rownumWidth : 25,
			autoencode : true,
			loadonce : false,
			sortable : true,
			cellEdit:true,
		    cellsubmit : 'clientArray',
			jsonReader : {
		    	root : "list_data",
		      records : "records",
		      repeatitems : false,
	 	      id : "inspec_lot"
		    },
		    onCellSelect : function(rowid, selected) {
				
				if (rowid != null && selected) {
					var rowData = $("#grid_role").jqGrid('getRowData', rowid);
				    
				 	console.log (rowData.insts);
					if (rowData.insts =='ST' ){ //ST대기 SS 완료 
						 $('#process').prop('disabled', false);	 
					}else{
						 $('#process').prop('disabled', true);
					}	
					
					if(selected == 13 && rowData.sernp == 'V001' && rowData.insts =='ST') {
						sernrInput(rowid);
					}
				}
				
				
			},
			afterEditCell: function (rowid, cellname, value, iRow, iCol) {
	            if(cellname=='sernp_no') {
	            	setTimeout(function () {
			            e = jQuery.Event("keydown");
			            e.keyCode = $.ui.keyCode.ENTER;
			            //get the edited thing
			            edit = $(".edit-cell > *");
			            edit.blur(function() {	
			                edit.trigger(e);
			            });
	        		}, 200);
	            }	    	
			},
			beforeSelectRow: function (rowId, e) {
				$(this).jqGrid("resetSelection");
			    return true;
			},
			loadComplete : function(data) {
				console.log(data);
			 
			}
		});
	}

 
	
	/*********************
	*To 창고 select box 구성
	*********************/
	function getToStrList() {
		console.log("getToStrList()");
		initOptions($('#s_to'));
		
		
		var rowData = $("#grid_role").getRowData($('#grid_role').jqGrid('getGridParam','selrow'));
		var lgort = rowData.lgort.substring(0,2);

		var s_flag = $(':radio[name="s_flag"]:checked').val();
		
		console.log("test :: "  + s_flag);
// 		if($(':radio[name="s_flag"]:checked').val() == "Y") { 
// 				$("#s_to").val("2010");   //양품
// 			} else if ($(':radio[name="s_flag"]:checked').val() == "F") { 
// 				$("#s_to").val("2700");   //불량
// 			}
		
		var page_url = "/frontend/scm/scm_sloc_code_select"
		var postData = 'werks=' + encodeURIComponent(rowData.werks);
		
		var first_cell = '';
		var chk = true;
		//postData += '&lgort=' + encodeURIComponent("2");		//like 검색 2로 시작하는 창고들 로드

		$.ajax({
		    url: page_url,
		    data: postData,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
					if( (data.rows).length>0 ){
						$.each(data.rows, function (i, item) {
							
							if($("#s_to_werks").val() == '1110') {
								if(s_flag == 'Y') {
									if(lgort + "00" == item.lgort)
									{
										$('#s_to').append($('<option>', { 
											value: item.lgort,
									        text : item.lgobe 
									    }));			
										if(chk) {
											first_cell = item.lgort;  
											chk = false;
										}
									}
								} else if(s_flag == 'F') {
									if(lgort + "70" == item.lgort)
									{
										$('#s_to').append($('<option>', { 
											value: item.lgort,
									        text : item.lgobe 
									    }));
										if(chk) {
											first_cell = item.lgort;
											chk = false;
										}
									}
								}
							} else {
								if(s_flag == 'Y') {
									if(lgort + "00" == item.lgort || lgort + "0A" == item.lgort|| lgort + "0B" == item.lgort|| lgort + "0C" == item.lgort|| lgort + "0D" == item.lgort)
									{
										$('#s_to').append($('<option>', { 
											value: item.lgort,
									        text : item.lgobe 
									    }));
										if(chk) {
											first_cell = item.lgort;
											chk = false;
										}
									}
								} else if(s_flag == 'F') {
									if(lgort + "70" == item.lgort)
									{
										$('#s_to').append($('<option>', { 
											value: item.lgort,
									        text : item.lgobe 
									    }));
										if(chk) {
											first_cell = item.lgort;
											chk = false;
										}
									}
								}
							}
						});
						console.log("aaa :: " + first_cell);
						$("#s_to").val(first_cell);
					}
		    	} else {
		    		fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 실패하였습니다.");	
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    	
		    	 
		    	
				//처리상태  별로 케이스를 나눠 데이터를 가져온다.. like 검색
// 		    		if($(':radio[name="s_flag"]:checked').val() == "Y") { 
// 		 				$("#s_to").val("2010");   //양품
// 		 			} else if ($(':radio[name="s_flag"]:checked').val() == "F") { 
// 		 				$("#s_to").val("2700");   //불량
// 		 			} else if ($(':radio[name="s_flag"]:checked').val() == "N") { 
// 		 				$("#s_to").val("2800");   //폐기
// 		 			} else if ($(':radio[name="s_flag"]:checked').val() == "R") {  
// 		 				$("#s_to").val("2010");   //재작업 
// 		 			} else if ($(':radio[name="s_flag"]:checked').val() == "M") { 
// 		 				$("#s_to").val("1620");   //원자재불량
// 		 			} 
		 		 
		    }
		});
	}

	function initOptions(obj) {
	    $(obj)
	        .find('option')
	        .remove()
	        .end()
	        //.append('<option value="">선택</option>')
	        .val();
	}
	
	function successYn() {
		//	getFromStrList();
// 			getToStrList();
			fnSearchInspGrid();
	}

	function process_yn() {
		fnMessageModalConfirm("Notification(QM)", "접수를 승인하시겠습니까?", function(result){
			if(result) {
				process();	
			}
		});
	}
	
	function process(){
		
		$("#grid_role").jqGrid('setGridParam', {cellEdit: false});
		
		var gridDataArr = $('#grid_role').jqGrid('getRowData');

		var keyArr = $('#grid_role').jqGrid('getDataIDs');
		var pordnos = '';
		
		$("#grid_role").jqGrid('setGridParam', {cellEdit: true});
		
		var params = [];
		var params_1 = [];
		for (var i = 0; i < keyArr.length; i++) { //row id수만큼 실행           
	    	if($("input:checkbox[id='jqg_grid_role_"+keyArr[i]+"']").is(":checked")){ //checkbox checked 여부 판단
	    		var rowdata = $("#grid_role").getRowData(keyArr[i]); // 해당 id의 row 데이터를 가져옴

	    		if($("#grid_role").getRowData(keyArr[i]).cmdat.length >5)		//처리날짜는 8자리이므로 5로 조건..처리안하면 값없음..
	    		{
	   				fnMessageModalAlert("Notification(QM)", "이미 처리된 데이터가 있습니다.");
	    	 		return;
	    		}
	    		
			    params.push(rowdata); //배열에 맵처럼 담김         
		    }
		}
				
		/*********************그리드 체크여부 확인 : Start*********************/
		if(params.length == 0)
		{
			fnMessageModalAlert("Notification(QM)", "체크 된 데이터가 없습니다.");
	 		return;
		}
		/*********************그리드 체크여부 확인 : End*********************/
		
		
		var jsonStr = "";

// 		sernrArray=params[0].sernp_no.split(',');
		
		var cnt = Number(params[0].bdmng);
		if(params[0].sernp == 'V001' && Number(params[0].bdmng) > 1) {
			
			for(var i=0 ; i<cnt; i++) {
				params[0].bdmng = '1';
				params_1.push(params[0]);
			}
			jsonStr = JSON.stringify(params_1);
			
		} else {
			jsonStr = JSON.stringify(params);
		}
		
		console.log(jsonStr);
// 		var jsonStr = JSON.stringify(params);


		/********************* 데이터 insert 및 rfc 전송 : Start*********************/
			
		var chked_t_gubun= encodeURIComponent($(':radio[name="t_gubun"]:checked').val());

		
			var page_url = "/frontend/qm/standby_inspection_process";
			var postData = 'jsonStr=' + encodeURIComponent(jsonStr)
			postData += '&cmdat=' + encodeURIComponent($("#r_conf_date").val())
			postData += '&move_plant=' + encodeURIComponent($("#s_to_werks").val())
			postData += '&move_stloc=' + encodeURIComponent($("#s_to").val())
			postData += "&insts="+ encodeURIComponent(chked_t_gubun)
			postData += "&sernpNos="+ encodeURIComponent(params[0].sernp_no)
			postData += "&insp_yn=" + encodeURIComponent($(':radio[name="s_flag"]:checked').val());			//처리 유형 값 	
			
			
			$.ajax({
			    url: page_url,
			    data: postData,
			    async : false,
			    type: "POST",
			    success:function(data, textStatus, jqXHR){
			    	if(data.status == "200") {
			    		if(data.e_return == 'S') {
			    			fnMessageModalAlert("Notification(QM)", "정보를 저장했습니다. <br/> ***sap 전송 결과*** <br/>e_return : : " 
		    					+ data.e_return	+ "<br/>e_message : "+ data.e_message);	
			    		} else if(data.e_return == 'E') {
							fnMessageModalAlert("Notification(QM)", "정보를 저장하는데 에러가 발생했습니다. <br/> ***sap 전송 결과*** <br/>e_return : : " 
				    			+ data.e_return	+ "<br/>e_message : "+ data.e_message);
			    		} 
						
			    	} else {
			    		fnMessageModalAlert("Notification(QM)", "정보를 저장하는데 에러가 발생하였습니다.");	
			    	}
			    	$("#modal_detail").modal('hide');
			    	fnSearchInspGrid();
			    },
			    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("Notification(QM)", "정보를 저장하는데 에러가 발생하였습니다.");	
			    },
			    complete: function() {
			    }
			});
			
			
			/********************* 데이터 insert 및 rfc 전송 : End*********************/
	}

	function modal_open() {
		
		var selected_rows_id = $("#grid_role").jqGrid('getGridParam', 'selarrrow');
		
		var s_sernp = $("#grid_role").getRowData(selected_rows_id[0]).sernp;
		var s_sernp_no = $("#grid_role").getRowData(selected_rows_id[0]).sernp_no;
		var s_issue_code = $("#grid_role").getRowData(selected_rows_id[0]).issue_code;
// 		if(s_sernp == 'V001') {
// 			if(s_sernp_no.length == 0) {
// 				fnMessageModalAlert("Notification(QM)", "시리얼 대상 실적입니다.<br>시리얼번호 공란을 클릭해 시리얼을 입력해주세요.");
// 				return;
// 			}
// 		}
		

		if(s_issue_code.length == 0) {
			fnMessageModalAlert("Notification(QM)", "입력된 불량내역이없습니다.");
			return;
		}

				
		if(selected_rows_id.length == 0) {
			fnMessageModalAlert("Notification(QM)", "체크 된 데이터가 없습니다.");
			return;
		}
		
		var chk;
		for(var i =0 ; i<selected_rows_id.length; i++) {
			var s_werks = $("#grid_role").getRowData(selected_rows_id[i]).werks;
			
			if(i==0) {
				chk = s_werks;	
			}
			
			console.log(chk, s_werks);
			if(chk != s_werks) {
				fnMessageModalAlert("Notification(QM)", "체크 된 데이터의 플랜트 내역은 모두 동일해야합니다.");
				return;
			}
		}
			
		$("#s_to_werks").val(chk);
		getToStrList();
		$("#modal_detail").modal('show');
	}
	
	function modal_detail_close() {
		$("#modal_detail").modal('hide');
	}
	
	function process_cancel(){
		
		var pordno;
		var ref_doc_no;
		var mblnr;     
		var mjahr;     
		var sudat;
		
		var chk_cnt =0;
		
		$("#grid_role").jqGrid('setGridParam', {cellEdit: false});
		
		var gridDataArr = $('#grid_role').jqGrid('getRowData');
		var keyArr = $('#grid_role').jqGrid('getDataIDs');
				
		$("#grid_role").jqGrid('setGridParam', {cellEdit: true});
		
		for (var i = 0; i < keyArr.length; i++) { //row id수만큼 실행           
	    	if($("input:checkbox[id='jqg_grid_role_"+keyArr[i]+"']").is(":checked")){ //checkbox checked 여부 판단
	    		var rowdata = $("#grid_role").getRowData(keyArr[i]); // 해당 id의 row 데이터를 가져옴
	    		    		
	    		if($("#grid_role").getRowData(keyArr[i]).sudat.length < 5)		//처리날짜는 8자리이므로 5로 조건..처리안하면 값없음..
	    		{
	   				fnMessageModalAlert("Notification(QM)", "미처리 데이터가 선택되었습니다.");
	    	 		return;
	    		}
				pordno = $("#grid_role").getRowData(keyArr[i]).pordno;
	    		ref_doc_no = $("#grid_role").getRowData(keyArr[i]).ref_doc_no;
	    		mblnr = $("#grid_role").getRowData(keyArr[i]).mblnr;
	    		mjahr = $("#grid_role").getRowData(keyArr[i]).mjahr;
	    		sudat = $("#grid_role").getRowData(keyArr[i]).sudat
	    		
	    		chk_cnt = chk_cnt + 1;
		    }
		}
		
		/*********************그리드 체크 확인 : Start*********************/
		if(chk_cnt == 0)
		{
			fnMessageModalAlert("Notification(QM)", "체크 된 데이터가 없습니다.");
	 		return;
		}
		
		if(chk_cnt != 1)
		{
			fnMessageModalAlert("Notification(QM)", "한개의 항목만 체크해주세요.");
	 		return;
		}
		/*********************그리드 체크 확인 : End*********************/
		
		///////////////////////////////////////
		var params_data = new Array() ;
		
		var iv_materialdocument = [];
		var iv_matdocumentyear = [];
		var iv_goodsmvt_pstng_date = [];
		var iv_documentheader_text = [];
		
		var data = new Object();
						
		data.	iv_materialdocument = mblnr;
		data.	iv_matdocumentyear = mjahr;
		data.	iv_goodsmvt_pstng_date = sudat;
		data.	iv_documentheader_text ="";
		
		params_data.push(data);
		
		var jstr = JSON.stringify(params_data);
		
		var page_url = "/frontend/qm/inspection_delete";
		var postData = 'jstr=' + encodeURIComponent(jstr)
		postData += '&pordno=' + encodeURIComponent(pordno)
		postData += '&func_name=' + encodeURIComponent("ZMMFM_GOODSMVT_CANCEL")
		postData += "&gubun=" + encodeURIComponent($(':radio[name="t_gubun"]:checked').val());
		
		$.ajax({
		    url: page_url,
		    data: postData,
		    type: "POST",
		    async : false,
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
		    		if(data.rows[0].ev_status == 'E') {
		    			fnMessageModalAlert("Notification(QM)", "해당 실적을 삭제하는데 에러가 발생했습니다. <br/> ***sap 전송 결과*** <br/>ev_status : " 
				    			+ data.rows[0].ev_status	+ "<br/>e_message : "+ data.rows[0].ev_message);
		    		} else if(data.rows[0].ev_status == 'S') {
		    			fnMessageModalAlert("Notification(QM)", "해당 실적을 삭제완료했습니다. <br/> ***sap 전송 결과*** <br/>ev_status : " 
		    					+ data.rows[0].ev_status	+ "<br/>e_message : "+ data.rows[0].ev_message);	
		    		}
		    	} else {
		    		fnMessageModalAlert("Notification(QM)", "해당 실적을 삭제하는데 에러가 발생했습니다.");	
		    	}
		    	fnSearchInspGrid();
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(QM)", "해당 실적을 삭제하는데 에러가 발생했습니다.");	
		    },
		    complete: function() {
		    }
		});
		
	}
	
	function cancel_open() {
		fnMessageModalConfirm("Notification(QM)", "해당 검사내역을 취소하시겠습니까?", function(result){
			if(result) {
				process_cancel();	
			}
		});
	}
	
	function makeSelStep1() {
		console.log('makeSelStep1()');
		
		var page_url = "/frontend/scm/issue_getStep1";
		$.ajax({
		    url: page_url,
		    data: '',
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    		console.log(data);
		    	if(data.status == "200") {
					if( (data.rows).length>0 ){
						$('#sel_step1').append($('<option>', { 
					        text : '-'
					    }));
						$.each(data.rows, function (i, item) {
							$('#sel_step1').append($('<option>', { 
						        value: item.gr_code,
						        text : item.gr_nm 
						    }));
						});
					}
		    	} else {
		    		fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 실패하였습니다.");	
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {}
		});
	}
	
	var step1Val = '';
	var step2Val = '';
	var step3Val = '';
	var step4Val = '';
	function changeStep(selVal, step) {
		console.log('changeStep(',selVal,',',step,')');
		var compName = '';
		if( step=='step1' ) {
			initOptions($('#sel_step2'));
			initOptions($('#sel_step3'));
			initOptions($('#sel_step4'));
			step1Val = selVal;
			compName = 'sel_step2';
		} else if( step=='step2' ) {
			initOptions($('#sel_step3'));
			initOptions($('#sel_step4'));
			step2Val = selVal;
			compName = 'sel_step3';
		} else if( step=='step3' ) {
			initOptions($('#sel_step4'));
			step3Val = selVal;
			compName = 'sel_step4';
		} 
//	 	else if( step=='step4' ) {
//	 		step4Val = selVal;
		
		var page_url = "/frontend/scm/issue_getSteps";
		var params = "";
		if( step=='step1' ) {
			params += "gr_code=" + encodeURIComponent(step1Val);
		} 
		if( step=='step2' ) {
			params += "gr_code=" + encodeURIComponent(step1Val);
			params += "&level1_code=" + encodeURIComponent(step2Val);
		}
		if( step=='step3' ) {
			params += "gr_code=" + encodeURIComponent(step1Val);
			params += "&level1_code=" + encodeURIComponent(step2Val);
			params += "&level2_code=" + encodeURIComponent(step3Val);
		}
//	 	else if( step=='step4' )
//	 		params += "?level3_code=" + encodeURIComponent(step4Val);
		
		$.ajax({
		    url: page_url,
		    data: params,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
					if( (data.rows).length>0 ){
						$('#'+compName).append($('<option>', { 
					        text : '-'
					    }));
						$.each(data.rows, function (i, item) {
							if( step=='step1' ) {
								$('#'+compName).append($('<option>', { 
							        value: item.level1_code,
							        text : item.level1_name 
							    }));
							} else if( step=='step2' ) {
								$('#'+compName).append($('<option>', { 
									value: item.level2_code,
							        text : item.level2_name 
							    }));
							} else if( step=='step3' ) {
								$('#'+compName).append($('<option>', { 
									value: item.level3_code,
							        text : item.level3_name 
							    }));
							} 
						});
					}
		    	} else {
		    		fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 실패하였습니다.");	
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Fail", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {}
		});
	}
		
	function initOptions(obj) {
	    $(obj)
	        .find('option')
	        .remove()
	        .end()
//	         .append('<option value="">선택</option>')
	        .val();
	}
	
	function input_code() {
		
		var s_id = $('#grid_role').jqGrid('getGridParam', 'selrow');
		
		var sel_step1 = $("#sel_step1").val();
		var sel_step2 = $("#sel_step2").val();
		var sel_step3 = $("#sel_step3").val();
		var sel_step4 = $("#sel_step4").val();
		
		var sel_step1_t = $("#sel_step1 option:selected").text();
		var sel_step2_t = $("#sel_step2 option:selected").text();
		var sel_step3_t = $("#sel_step3 option:selected").text();
		var sel_step4_t = $("#sel_step4 option:selected").text();
		
		if(s_id == null) {
			fnMessageModalAlert("Notification(QM)", "불량코드가 입력 될 자재불량내역을 선택해 주세요.");
			return;
		}
		
		if(sel_step4_t == '' || sel_step4_t == '-') {
			fnMessageModalAlert("Notification(QM)", "lv.03 까지 불량내역을 지정해주세요.");
			return;
		}
		
		$('#grid_role').jqGrid('setCell', s_id, 'org_gr_nm', sel_step1_t);
		$('#grid_role').jqGrid('setCell', s_id, 'org_level1_name', sel_step2_t);
		$('#grid_role').jqGrid('setCell', s_id, 'org_level2_name', sel_step3_t);
		$('#grid_role').jqGrid('setCell', s_id, 'org_issue_memo', sel_step4_t);
		
		$('#grid_role').jqGrid('setCell', s_id, 'issue_code', sel_step4);
	}
	
	function jqgridHighlightFormatterYn(cellvalue, options, rowObject) {
//	 	if (cellvalue != null && cellvalue != "" && cellvalue == "V001") {
		if (rowObject.insp_yn == 'Y') {
			return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">합격</span>';
		} else if (rowObject.insp_yn == 'F') {
			return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">불합격</span>';
		} else {
			return '';
		}
	}
	
	function sernrYn(cellvalue, options, rowObject) {
		if (rowObject.sernp == 'V001') {
			return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FF0000;background-color:#FFFFFF\">관리</span>';
		} else {
			return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#000000;background-color:#FFFFFF\">비관리</span>';
		} 
	}
	
	function sernrInput(inspec_lot) {
		console.log(inspec_lot);
		
		$('#grid_sernr').jqGrid('clearGridData');
		
		$('#m_lotno').val(inspec_lot);
		var gridRowData = $("#grid_role").getRowData(inspec_lot);
		
		for(var i=0 ; i<Number(gridRowData.bdmng); i++) {
				$("#grid_sernr").jqGrid('addRow',
						{position  :"last", 
						initdata  :  {
							inspec_lot:gridRowData.inspec_lot
							,matnr:gridRowData.matnr
							,maktx:gridRowData.maktx
							,sernr:""
							}
						}
				);
		}
		
		$("#modal_sernr_add").modal('show');
	}
	
	function fnLoadSernrAddGrid() {
		$("#grid_sernr").jqGrid({
			datatype : "json",
			colNames : ['검사Lot', '자재','자재내역','시리얼' ],
			colModel : [ 
				{name : 'inspec_lot', index : 'inspec_lot', width : 80, sorttype : "text", sortable : true}, 
				{name : 'matnr', index : 'matnr', width : 90, sorttype : "text", sortable : true}, 
				{name : 'maktx', index : 'maktx', width : 100, sorttype : "text", sortable : true}, 	 
				{name : 'sernr', index : 'sernr', width : 100, sorttype : "text", sortable : true, editable: true,} ],  
			rowNum : 1000,
			viewrecords : true,
			autowidth : true,
			shrinkToFit : true,
			multiselect : false,
			height : 270,
			altRows : true,
			rownumbers : true,
			rownumWidth : 25,
			autoencode : true,
			cellEdit : true,
		    cellsubmit : 'clientArray',
			loadonce : true,
			onCellSelect : function(rowid, selected) {
				if (rowid != null) { 
				}
				 
			},
			
			loadComplete : function() {}
		});
	}
 
	function inputSernr() {
		var rowdata = $("#grid_sernr").getRowData();
		var keyArr = $('#grid_sernr').jqGrid('getDataIDs');
		var sernrs = "";
		for(var idx=0; idx<rowdata.length; idx++){
			var sernr =  $('#'+keyArr[idx]+'_sernr').val();
			if(sernr.length == 0) {
				fnMessageModalAlert("Notification(QM)", "시리얼 내역을 모두 입력해주세요.");
				return;
			}
			sernrs = sernrs + sernr + "," 
		}
		sernrs = sernrs.substring(0, sernrs.length-1);
		
		console.log($("#grid_role"));
		console.log($("#grid_role").children().children());
		
		$("#grid_role").jqGrid('setCell', $('#m_lotno').val(), 'sernp_no', sernrs);
		
		$("#modal_sernr_add").modal('hide');
		
	}
	
	function excelFileDownload(gridName) {
//	 	console.log('excelFileDownload('+gridName+')');
		var tmpArr = [];
		var getColNames = $("#grid_role").jqGrid('getGridParam','colNames');
		getColNames[1] = '';
		var getColModels = $("#grid_role").jqGrid('getGridParam','colModel');
		$.each(getColModels, function(idx, mrow){
			if( mrow.hidden==false && getColNames[idx]!='' ) {
				mrow.caption = getColNames[idx]; 
				tmpArr.push(mrow);  
			}
		});
		
		var gridCols = tmpArr;
		var gridData = $("#grid_role").getRowData();

		for(var i=0 ; i<gridData.length ; i++) {
			var insp_yn = gridData[i].insp_yn; 
			var f_sernp_no = gridData[i].f_sernp_no;
			
			if(insp_yn == '') {
				gridData[i].insp_yn = '';
			} else if ( insp_yn.indexOf('불합격') != -1) {
				gridData[i].insp_yn = '불합격';
			} else {
				gridData[i].insp_yn = '합격';
			}
			
			if(f_sernp_no == '') {
				gridData[i].f_sernp_no = '';
			} else if ( f_sernp_no.indexOf('비관리') != -1) {
				gridData[i].f_sernp_no = '비관리';
			} else {
				gridData[i].f_sernp_no = '관리';
			}
		}
		
		var fileName = '';
		var sheetTitle = '';
		var sheetName = '';
		if( gridName=='grid_role' ) {
			fileName = '검사Lot처리.xlsx';
			sheetTitle = '검사Lot처리';
			sheetName = '검사Lot처리';
		}
		
		var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
		var is_rownum = true;
		
		if(gridCols != null && gridCols.length > 0){
			// w2grid 는 linenumber column info not exist
			param_col_name = "No"
			param_col_id = "rownum";
			param_col_align = "center";
			param_col_width = "80";
			//--------------------------------------------
			console.log(gridCols);
			for(var i=0; i<gridCols.length; i++){
				if(!gridCols[i].hidden){
					var caption = gridCols[i].caption;
					param_col_name += "," + caption;
					param_col_id += "," + gridCols[i].name;
					param_col_align += ",left";
					param_col_width += "," + (gridCols[i].width==undefined?"80":(gridCols[i].width));
				}
			}
		}
		
		var export_url = "/export/export_client_jqgrid";
		var export_data = "file_name="+encodeURIComponent(fileName);
			export_data += "&sheet_title="+encodeURIComponent(sheetTitle);
			export_data += "&sheet_name="+encodeURIComponent(sheetName);
			export_data += "&header_col_names="+encodeURIComponent(param_col_name);
			export_data += "&header_col_ids="+encodeURIComponent(param_col_id);
			export_data += "&header_col_aligns="+encodeURIComponent(param_col_align);
			export_data += "&header_col_widths="+encodeURIComponent(param_col_width);
			export_data += "&cmd="+encodeURIComponent("grid_goods_detail");
			export_data += "&body_data="+encodeURIComponent(JSON.stringify(gridData));

		$.ajax({
		  url:export_url,
		  data:export_data,
		  type:'POST',
		  dataType: 'json',
		  success: function( data ) {
		  	if(data.status == 200) {
		  		var file_path = data.file_path;
		  		var file_name = data.file_name;
		  		var protocol = jQuery(location).attr('protocol');
	  			var host = jQuery(location).attr('host');
	  			var link_url = "/file/attach_download";
	  			link_url += "?file_path="+encodeURIComponent(file_path);
	  			link_url += "&file_name="+encodeURIComponent(file_name);
	  			$(location).attr('href', link_url);
		  	}
		  },
		  complete: function () {}
		});
	}
	
	function Left(str,n){
	    if (n <= 0){
	       return "";
	    }else if (n > String(str).length){
	       return str;
	    }else{
	       return String(str).substring(0,n);
	    }
	}

	function Right(str,n){
	    if (n <= 0){
	       return "";
	    }else if (n > String(str).length){
	       return str;
	    }else{
	       var iLen = String(str).length;
	       return String(str).substring(iLen, iLen - n);
	    }
	}


	function LMainsernr_enter(text){
		if(text.value.length > 6) {
			
		    if(text.value.length > 30 && Left(text.value,2) == 01  ){
		    	 
		    	$('#project_no').val(Right(text.value,9));
		    	}
		    
		    fnSearchInspGrid();
		   
		} else {
			fnMessageModalAlert("Notification(MES)", "바코드 길이는 7자리 이상이어야 합니다.<br/>입력값 : " + $('#project_no').val());
			$('#project_no').val("");
	    } 
	}
	
	function c_makeSelStep1() {
//	 	console.log('makeSelStep1()');
	 	 
		var i_dept_cd = $("#m_wkctr").val();
		
		var page_url = "/frontend/scm/issue_getStep1";
		var postData = "dept_cd=" +  encodeURIComponent(i_dept_cd);
		
		$.ajax({
		    url: page_url,
		    data : postData,
		    async:false,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
					if( (data.rows).length>0 ){
						$('#c_sel_step1').append($('<option>', {
							value: '',
					        text : '-'
					    }));
						$.each(data.rows, function (i, item) {
							$('#c_sel_step1').append($('<option>', { 
						        value: item.gr_code,
						        text : item.gr_nm 
						    }));
						});
					}
		    	} else {
		    		fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 실패하였습니다.");	
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {}
		});
	}
	
	function c_changeStep(selVal, step) {
//	 	console.log('changeStep(',selVal,',',step,')');
		var compName = '';
		if( step=='step1' ) {
			initOptions($('#c_sel_step2'));
			initOptions($('#c_sel_step3'));
			initOptions($('#c_sel_step4'));
			step1Val = selVal;
			compName = 'c_sel_step2';
		} else if( step=='step2' ) {
			initOptions($('#c_sel_step3'));
			initOptions($('#c_sel_step4'));
			step2Val = selVal;
			compName = 'c_sel_step3';
		} else if( step=='step3' ) {
			initOptions($('#c_sel_step4'));
			step3Val = selVal;
			compName = 'c_sel_step4';
		} 
			
		var page_url = "/frontend/scm/issue_getSteps";
		var params = "";
		if( step=='step1' ) {
			params += "gr_code=" + encodeURIComponent(step1Val);
		} 
		if( step=='step2' ) {
			params += "gr_code=" + encodeURIComponent(step1Val);
			params += "&level1_code=" + encodeURIComponent(step2Val);
		}
		if( step=='step3' ) {
			params += "gr_code=" + encodeURIComponent(step1Val);
			params += "&level1_code=" + encodeURIComponent(step2Val);
			params += "&level2_code=" + encodeURIComponent(step3Val);
		}
			
		$.ajax({
		    url: page_url,
		    data: params,
		    async:false,
		    type: "POST",
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
					if( (data.rows).length>0 ){
						$('#'+compName).append($('<option>', { 
							value: '',
							text : '-'
					    }));
						$.each(data.rows, function (i, item) {
							if( step=='step1' ) {
								$('#'+compName).append($('<option>', { 
							        value: item.level1_code,
							        text : item.level1_name 
							    }));
							} else if( step=='step2' ) {
								$('#'+compName).append($('<option>', { 
									value: item.level2_code,
							        text : item.level2_name 
							    }));
							} else if( step=='step3' ) {
								$('#'+compName).append($('<option>', { 
									value: item.level3_code,
							        text : item.level3_name 
							    }));
							} 
						});
					}
		    	} else {
		    		fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 실패하였습니다.");	
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {}
		});
	}
</script>
</body>
</html>