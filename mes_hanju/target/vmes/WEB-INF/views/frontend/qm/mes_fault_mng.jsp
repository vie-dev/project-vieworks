<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
	String member_id = SessionUtil.getMemberId(request);
	String member_nm = SessionUtil.getMemberNm(request);
	String member_emp_no = SessionUtil.getMemberEmpNo(request);
%>
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
            <jsp:param name="selected_menu_cd" value="1113" />
        </jsp:include>

        <div class="content-wrapper">
            <section class="content-header">
                <h1>
					품질관리 <small> 불량자재관리</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="#"><i class="fa fa-dashboard"></i> 품질관리 </a></li>
                    <li class="active">불량자재관리</li>
                </ol>
            </section>
            <section class="content">
                <div class="row">
                    <section class="col-lg-12">
                        <div class="box box-success box-solid" style="min-height: 70px;">
                            <div class="box-header with-border">
                                <h3 class="box-title">조회조건</h3>
                                <div class="box-tools pull-right">
                                    <button type="button" id="btn_search_csr" class="btn btn-primary btn-sm" onclick="fnSearchRoleGrid();">조회</button>
                                </div>
                            </div>
                            <div id="" class="box-body">
                                <div class="row">
                                    <div class="col-sm-2">
                                     <!--발생일 품목 품목명 SN 오더번호 품목코드 오더품목명 오더품목SN 불량LEVEL1234 -->
                                        <div class="form-group">
                                            <label>발생일</label> 
                                            <div class="input-group">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <input type="text" class="form-control pull-right input-sm" id="serch_date_range" >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>품목</label>
                                           	<input type="input" id=s_matnr name="s_matnr" class="form-control input-sm" placeholder="" maxlength="30"> 
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>품목명</label> 
                                           	<input type="input" id="s_maktx" name="s_maktx" class="form-control input-sm" placeholder="" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>SN</label> 
                                           	<input type="input" id="s_sernr" name="s_sernr" class="form-control input-sm" placeholder="" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>생산오더번호</label> 
                                           	<input type="input" id="s_pordno" name="s_pordno" class="form-control input-sm" placeholder="" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>생산오더품목코드</label> 
                                           	<input type="input" id="s_ord_matnr" name="s_ord_matnr" class="form-control input-sm" placeholder="" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>생산오더품목명</label> 
                                           	<input type="input" id="s_ord_maktx" name="s_ord_maktx" class="form-control input-sm" placeholder="" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>생산오더품목SN</label> 
                                           	<input type="input" id="s_ord_sernr" name="s_ord_sernr" class="form-control input-sm" placeholder="" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                        	<label>플랜트</label> 
                                        	<select id="plant" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
<!-- 												<option value="">전체</option> -->
												<option value="1110">의료</option>
												<option value="1210">광</option>
											</select>
                                        </div>
                                    </div>
                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <label>그룹선택</label> 
                                         <!--   	<input type="input" id="s_level_1" name="s_level_1" class="form-control input-sm" placeholder="" maxlength="30"> -->
                                           	<select id="sel_step1" class="form-control select2 input-sm" onChange="changeStep($(this).val(),'step1');">
                                           	<option>-</option>
											</select>
                                        </div>
                                    </div>
                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <label>Lv.1</label> 
                                           <select id="sel_step2" class="form-control select2 input-sm" onChange="changeStep($(this).val(),'step2');">
                                      		<option>-</option>
											</select>
                                        </div>
                                    </div>
                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <label>Lv.2</label> 
                                           	<select id="sel_step3" class="form-control select2 input-sm" onChange="changeStep($(this).val(),'step3');">
                                            <option>-</option>
											</select>                                        
                                        </div>
                                    </div>
                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <label>Lv.3</label> 
                                           <select id="sel_step4" class="form-control select2 input-sm"> 
                                           <option>-</option>
											</select>  
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box box-default box-solid" style="min-height: 600px;">
                            <div class="box-header with-border">
                            	 <h3 class="box-title">검사내역</h3>
                            	  <div class="box-tools pull-right">
	                            	 	<button type="button" id="" class="btn btn-success btn-sm" onclick = "ord_process('O');" style="color: white;">불량판정완료</button>
										<button type="button" id="" class="btn btn-danger btn-sm" onclick = "ord_process('P');"style="color: white;">불량취소</button>
<!-- 										<button type="button" id="" class="btn btn-warning btn-sm" onclick = "ord_process('N');"style="color: white;">취소</button> -->
										<button type="button" class="btn bg-maroon btn-sm grid_attach_down" onclick="excelFileDownload('grid_role');" data-selfilepath="/upload" data-selfilename="test.xlsx">
								    		<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
										</button>
                            	  </div>
                            </div>
                            <div class="box-body">
                            	<div class="row">
									<div class="col-md-12">
										<div id="grid_role" style="width: 100%; height: 500px;"></div>
									</div>
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
	
<script type="text/javascript">
var member_id = "<%=member_id%>";
var member_nm = '<%=member_nm%>';
var member_emp_no = '<%=member_emp_no%>';

// var issueData_lv_1 = [];
// var issueData_lv_2 = [];
// var issueData_lv_3 = [];

var issueData_all = [];

$(function($) {
	fnLoadCommonOption();
	initOptions($('#sel_step1'));
	initOptions($('#sel_step2'));
	initOptions($('#sel_step3'));
	initOptions($('#sel_step4'));
	makeSelStep1();
// 	issueDataSelc();
	fnLoadRoleGrid();
	

});



$('#plant').change(function() {

	initOptions($('#sel_step1'));
	initOptions($('#sel_step2'));
	initOptions($('#sel_step3'));
	initOptions($('#sel_step4'));
	makeSelStep1();

	});

function fnLoadCommonOption() {
	
	$("#serch_date_range").daterangepicker({
		opens: "right",
		locale: {
			format: "YYYY-MM-DD" // inputbox 에 "2011/04/29" 로표시
			,monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
			,daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ]
			,showMonthAfterYear: true
			,yearSuffix: "년"
			,orientation: "top left"
	    }
	});
	
// 	$("#grid_role").on('change', function(event) {
// 		var tmpObj = {};
// 		tmpObj.id = "1111" ;
// 		tmpObj.text = "2322";
		
// 		issueData_lv_2 = [];
// 		issueData_lv_2.push(tmpObj);
// 		//w2ui['grid_role'].refresh();
// 		console.log(issueData_lv_2);
// 	});

	initScreenSizeModal();
}

function initOptions(obj) {
    $(obj)
        .find('option')
        .remove()
        .end()
        //.append('<option value="">선택</option>')
        .val();
}

var issueData_lv_1 = [];
var issueData_lv_2 = [];
var issueData_lv_3 = [];

function fnLoadRoleGrid(){
// 	console.log('fnLoadRoleGrid()');
	$("#grid_role").w2grid({
		name : 'grid_role',
		show : {
			lineNumbers : true,
			selectColumn: true,
            footer: true
        },
        columns : [
			{ field:'fault_no', caption:'NO', size:'100px', hidden:true},
			{ field:'fault_no_seq', caption:'SEQ', size:'50px', hidden:true},
			{ field:'fault_status', caption:'상태', size:'100px' ,render:function(record, index, col_index){					

				if (this.getCellValue(index, col_index)=='R') {
					return '판정대기';	
				}
				
				else if(this.getCellValue(index, col_index)=='O') {
					return '불량판정완료';
				}
					
				else if(this.getCellValue(index, col_index)=='P') {
					return '불량취소';
				}
  
			}
		},
			{ field:'matnr', caption:'자재코드', size:'114px'},
			{ field:'maktx', caption:'자재내역', size:'129px'},
			{ field:'sernr', caption:'시리얼번호', size:'97px'},
			{ field:'meins', caption:'단위', size:'39px', hidden:true},
			{ field:'bdmng', caption:'수량', size:'50px'},
			{ field:'f_lgort', caption:'from 창고code', size:'80px', hidden:true},
			{ field:'f_lgort_nm', caption:'from 창고', size:'100px'},
			{ field:'t_lgort', caption:'to 창고', size:'10px', render:'int', hidden:true},
			{ field:'routing_nm', caption:'발생공정', size:'100px'},
			{ field:'routing_no', caption:'발생공정 code', size:'64px', hidden:true},
			{ field:'creator', caption:'불량등록자', size:'80px', style:'text-align:center' },
			{ field:'date_created', caption:'불량등록일자', size:'89px', style:'text-align:center'},
			{ field:'updater', caption:'관리자', size:'80px'},
			{ field:'date_updated', caption:'처리일자', size:'89px', style:'text-align:center'},
			{ field:'issue_code', caption:'불량코드', size:'10px', style:'text-align:center', hidden:true},
			{ field:'issue_memo', caption:'불량코드 desc', size:'10px', hidden:true},
			{ field:'issue_remark', caption:'불량내역 코멘트', size:'150px'},
			{ field:'in_gubun', caption:'투입여부', size:'62px', style:'text-align:center'},
			{ field:'gr_code', caption:'그룹이름', size:'70px', style:'text-align:center', editable : { type: 'select', items: [{id:'',text:''}]}
				, render:function(record, index, col_index){					

					if (this.getCellValue(index, col_index)=='IS10') {
						return '광영상';	
					}
						
					else if(this.getCellValue(index, col_index)=='IS02') {
						return 'RF';
					}
						
					else if(this.getCellValue(index, col_index)=='IS01') {
						return 'VIVIX';
					}
				}
			},
			{ field:'level1_code', caption:'Lv.1', size:'97px', style:'text-align:center', editable: { type: 'select', items: [{id:'',text:''}]}
				, render:function(record, index, col_index) {
					var sbox_arr = this.columns[22].editable.items;
					if(sbox_arr == undefined) {
						return record.level1_name;	
					}
                    var s_id = this.getCellValue(index, col_index);
                    var s_text = "";
                    for(var i=0 ; i<sbox_arr.length; i++) {
                    	if(s_id == sbox_arr[i].id) {
                    		s_text = sbox_arr[i].text;
                    		record.level1_name = s_text;
                    	}
                    }
                    return record.level1_name;
                }
			},
			{ field:'level2_code', caption:'Lv.2', size:'97px', style:'text-align:center', editable: { type: 'select', items: [{id:'',text:''}]}
				, render:function(record, index, col_index) {
					var sbox_arr = this.columns[23].editable.items;
					if(sbox_arr == undefined) {
						return record.level2_name;	
					}
	                var s_id = this.getCellValue(index, col_index);
	                var s_text = "";
	                for(var i=0 ; i<sbox_arr.length; i++) {
                    	if(s_id == sbox_arr[i].id) {
                    		s_text = sbox_arr[i].text;
                    		record.level2_name = s_text;
                    	}
                    }
                    return record.level2_name;
	            }
			},
			{ field:'level3_code', caption:'Lv.3', size:'165px', style:'text-align:center', editable: { type: 'select', items: [{id:'',text:''}]}
				, render:function(record, index, col_index) {
					var sbox_arr = this.columns[24].editable.items;
					if(sbox_arr == undefined) {
						return record.level3_name;	
					}
	                var s_id = this.getCellValue(index, col_index);
	                var s_text = "";
	                for(var i=0 ; i<sbox_arr.length; i++) {
                    	if(s_id == sbox_arr[i].id) {
                    		s_text = sbox_arr[i].text;
                    		record.level3_name = s_text;
                    	}
                    }
                    return record.level3_name;
	            }
			},
			
			{ field:'pordno', caption:'생산오더번호', size:'94px'},
			{ field:'ord_matnr', caption:'생산오더품목코드', size:'120px', style:'text-align:center'},
			{ field:'ord_maktx', caption:'생산오더품목명', size:'200px', style:'text-align:center'},
			{ field:'ord_sernr', caption:'생산오더품목SN', size:'120px', style:'text-align:center'},
			{ field:'werks', caption:'플랜트', size:'51px'}
			],
		sortData: [{field:'fault_no', direction: 'ASC'}],
		records: [],
		total : 0,
		onReload: function(event) {},
		onClick: function (event) {
// 			var sel = this.getSelection();
//             if (sel.length >= 1 && sel[0] == event.recid) {
//                 event.preventDefault();
//             }
		},
		onDblClick: function (event) {
			var selectRecid = [];
			selectRecid.push(event.recid);
			
			var selectItem = w2ui.grid_role.get(selectRecid);
			console.log("===================================================");
			if(selectItem.length == 0) {
				console.log("선택데이터 미인식");
				return;
			} else {
				console.log("선택데이터 인식");
			}
					
			var lv1code = '';
			var lv2code = '';
			var lv3code = '';
			var gr_code = '';
			
			if( selectItem[0].w2ui!=undefined){
				if(selectItem[0].w2ui.changes !=undefined) {
					if(selectItem[0].w2ui.changes.gr_code!=undefined) {
						gr_code = selectItem[0].w2ui.changes.gr_code;	
					} else {
						gr_code = selectItem[0].gr_code	
					}	
				} else {
					gr_code = selectItem[0].gr_code
				}
			} else {
				gr_code = selectItem[0].gr_code
			}
			
			if( selectItem[0].w2ui!=undefined){
				if(selectItem[0].w2ui.changes !=undefined) {
					if(selectItem[0].w2ui.changes.level1_code!=undefined) {
						lv1code = selectItem[0].w2ui.changes.level1_code;	
					} else {
						lv1code = selectItem[0].level1_code	
					}	
				} else {
					lv1code = selectItem[0].level1_code
				}
			} else {
				lv1code = selectItem[0].level1_code
			}
			
			if( selectItem[0].w2ui!=undefined){
				if(selectItem[0].w2ui.changes !=undefined) {
					if(selectItem[0].w2ui.changes.level2_code!=undefined) {
						lv2code = selectItem[0].w2ui.changes.level2_code;	
					} else {
						lv2code = selectItem[0].level2_code	
					}	
				} else {
					lv2code = selectItem[0].level2_code
				}
			} else {
				lv2code = selectItem[0].level2_code
			}
			

			if( selectItem[0].w2ui!=undefined){
				if(selectItem[0].w2ui.changes !=undefined) {
					if(selectItem[0].w2ui.changes.level3_code!=undefined) {
						lv3code = selectItem[0].w2ui.changes.level3_code;	
					} else {
						lv3code = selectItem[0].level3_code	
					}	
				} else {
					lv3code = selectItem[0].level3_code
				}
			} else {
				lv3code = selectItem[0].level3_code
			}
			
			var grid = this;
			
			var issueData_lv_1 = [{}];
			var issueData_lv_2 = [{}];
			var issueData_lv_3 = [{}];
			
			if(event.column ==  '21') {
				var gr_1110 = [{id:"IS01" ,text:"VIVIX"},{id:"IS02" ,text:"RF"}];
				var gr_1210 = [{id:"IS10" ,text:"광영상"}]; 
				
				if(selectItem[0].werks == '1110') {
					grid.columns[21].editable = { type: 'select', items: gr_1110};	
				} else {
					grid.columns[21].editable = { type: 'select', items: gr_1210};
				}
				grid.columns[22].editable = { type: 'select', items: issueData_lv_1};
				grid.columns[23].editable = { type: 'select', items: issueData_lv_2};
				grid.columns[24].editable = { type: 'select', items: issueData_lv_3};
// 				grid.set(event.recid, {level1_name: '', level2_name: '', level3_name: '' });
				console.log(event.recid + "행(3개) :: 초기화");
			}
			else if(event.column ==  '22') {
				issueData_lv_1 = issueDataSelc(event.column, selectItem[0].werks, '', '', gr_code);
				issueData_lv_2 = [];
				issueData_lv_3 = [];
				grid.columns[22].editable = { type: 'select', items: issueData_lv_1};
				grid.columns[23].editable = { type: 'select', items: issueData_lv_2};
				grid.columns[24].editable = { type: 'select', items: issueData_lv_3};
				console.log(grid);
				//grid.set(event.recid, { level2_name: '', level3_name: '' });
				console.log(event.recid + "행(2개) :: 초기화");
			} else if(event.column ==  '23') {
				if($("#grid_grid_role_data_"+ (Number(event.recid)-1)+"_22").text().length == 0 )
				{
					fnMessageModalAlert("Error", "이전 레벨 데이터가 선택되지 않았습니다.");
					grid.set(event.recid, { level2_code: ''});
					return;
				}
				issueData_lv_2 = issueDataSelc(event.column, selectItem[0].werks, lv1code, '', gr_code);
				issueData_lv_3 = [];
				grid.columns[23].editable = { type: 'select', items: issueData_lv_2};
				grid.columns[24].editable = { type: 'select', items: issueData_lv_3};
				//grid.set(event.recid, {level3_name: '' });
				console.log(event.recid + "행(1개) :: 초기화");
			} else if(event.column ==  '24') {
				if($("#grid_grid_role_data_"+ (Number(event.recid)-1)+"_22").text().length == 0 || $("#grid_grid_role_data_"+ (Number(event.recid)-1)+"_23").text().length == 0 )
				{
					fnMessageModalAlert("Error", "이전 레벨 데이터가 선택되지 않았습니다.");
					//grid.set(event.recid, { level3_name: ''});
					return;
				}
				issueData_lv_3 = issueDataSelc(event.column, selectItem[0].werks, lv1code, lv2code, gr_code);
				grid.columns[24].editable = { type: 'select', items: issueData_lv_3};
			}
			
			console.log("gr_code :: " + gr_code);
			console.log("lv1code :: " + lv1code);
			console.log("lv2code :: " + lv2code);
			console.log("lv3code :: " + lv3code);
			
			console.log("이슈데이터 목록 : start");
			console.log(issueData_lv_1);
			console.log(issueData_lv_2);
			console.log(issueData_lv_3);
			console.log("이슈데이터 목록 : end");
			console.log("===================================================");
		}
	});
	w2ui.grid_role.recordHeight = 30;
}

function fnSearchRoleGrid(){
	w2ui.grid_role.columns[22].editable.items = undefined;
	w2ui.grid_role.columns[23].editable.items = undefined;
	w2ui.grid_role.columns[24].editable.items = undefined;
	
	
	var f_date = replaceAll($("#serch_date_range").val().substring(0,10),'-','');
	var t_date = replaceAll($("#serch_date_range").val().substring(13,23),'-','');
	
	var slevel0_code = replaceAll($('#sel_step1').val(),'-','');
	var slevel1_code = replaceAll($('#sel_step2').val(),'-','');
	var slevel2_code = replaceAll($('#sel_step3').val(),'-','');
	var slevel3_code = replaceAll($('#sel_step4').val(),'-','');
	
	 
	var page_url = "/frontend/qm/select_fault_his_data"
				 + "?f_date="  + encodeURIComponent(f_date)
				 + "&t_date=" + encodeURIComponent(t_date)
				 + "&matnr=" + encodeURIComponent($('#s_matnr').val())
				 + "&maktx=" + encodeURIComponent($('#s_maktx').val())
				 + "&sernr="+ encodeURIComponent($('#s_sernr').val())
				 + "&pordno="+ encodeURIComponent($('#s_pordno').val())
				 + "&ord_matnr="+ encodeURIComponent($('#s_ord_matnr').val())
				 + "&ord_maktx="+ encodeURIComponent($('#s_ord_maktx').val())
				 + "&ord_sernr="+ encodeURIComponent($('#s_ord_sernr').val())
				 + "&werks="+  encodeURIComponent($("#plant").val())  
				 + "&gr_code="+ encodeURIComponent(slevel0_code)
				 + "&level1_code="+ encodeURIComponent(slevel1_code)
				 + "&level2_code="+ encodeURIComponent(slevel2_code)
				 + "&level3_code="+ encodeURIComponent(slevel3_code);
	
	w2ui['grid_role'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST', 
		dataType : 'json',
		async:false,
		success : function( data ) {
			if(data.status == 200) {
				if((data.rows).length>0) {
					var rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
					});
					w2ui['grid_role'].records = rowArr;	
				} else {
					w2ui['grid_role'].clear();
				}
			} 
			w2ui['grid_role'].refresh();
			w2ui['grid_role'].unlock();
		},
		complete: function () {}
	});
}

function jqgridHighlightFormatterSapSendFlag(cellvalue, options, rowObject) {
// 	if (cellvalue != null && cellvalue != "" && cellvalue == "V001") {
	if(rowObject.routing_no != rowObject.transfer_routing) {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#E5D85C\">전송미대상</span>';
	} else if (rowObject.sap_send_yn == 'Y') {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#2F9D27\">전송완료</span>';
	} else if(rowObject.sap_send_yn == 'N'){
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FFFFFF;background-color:#BDBDBD\">전송대기</span>';
	}
}

function excelFileDownload(gridName) {
	var gridCols = w2ui[gridName].columns;
	var gridData = w2ui[gridName].records;
	
	var fileName = '';
	var sheetTitle = '';
	var sheetName = '';
	if( gridName=='grid_role' ) {
		fileName = '불량관리.xlsx';
		sheetTitle = '불량관리';
		sheetName = '불량관리';
	}
	
	var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
	var is_rownum = true;
	
	if(gridCols != null && gridCols.length > 0){
		// w2grid 는 linenumber column info not exist
		param_col_name = "No"
		param_col_id = "rownum";
		param_col_align = "center";
		param_col_width = "80";
// 		param_col_name += ",선택";
// 		param_col_id += ",rn";
// 		param_col_align += ",left";
// 		param_col_width += ",80";
		//--------------------------------------------
		for(var i=0; i<gridCols.length; i++){
			if(!gridCols[i].hidden){
				var caption = gridCols[i].caption;
// 				if( gridName=='gridProc' && (caption=='요청수량' || caption=='요청일자' || caption=='분기 미승인' )){
// 					param_col_name += "," + caption + '(*)';
// 				}else if( gridName=='gridSernr' && caption=='순차관리번호' ){
// 					param_col_name += "," + caption + '(*)';
// 				}else if( gridName=='gridProcSubSernr' && caption=='순차관리번호' ){
// 					param_col_name += "," + caption + '(*)';
// 				}else{
					param_col_name += "," + caption;
// 				}
				param_col_id += "," + gridCols[i].field;
				param_col_align += ",left";
				param_col_width += "," + (gridCols[i].width==undefined?"80":(gridCols[i].width).replace('px',''));
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
// 		console.log(export_data);
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

function issueDataSelc(col_no, dept_cd,level1_code, level2_code, gr_code) {
	console.log("이슈 데이터 파라미터  : start");
	console.log(col_no, dept_cd,level1_code, level2_code, gr_code);
	console.log("이슈 데이터 파라미터  : end");
	var r_data = [];
	
	var page_url = "/frontend/qm/issueDataSelc";
	var postData = "dept_cd="  + encodeURIComponent(dept_cd);
	if(col_no == '22') {
		postData += "&level_case="  + encodeURIComponent("c1");
		postData += "&gr_code="  + encodeURIComponent(gr_code);
	} 
	if(col_no == '23') {
		postData += "&level_case="  + encodeURIComponent("c2");
		postData += "&level1_code="  + encodeURIComponent(level1_code);
		postData += "&gr_code="  + encodeURIComponent(gr_code);
	}
	if(col_no == '24') {
		postData += "&level_case="  + encodeURIComponent("c3");
		postData += "&level1_code="  + encodeURIComponent(level1_code);
		postData += "&level2_code="  + encodeURIComponent(level2_code);
		postData += "&gr_code="  + encodeURIComponent(gr_code);
	}

	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async:false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				var dataRows = data.rows;
				for(var i=0 ; i<dataRows.length ; i++) {
					if(col_no == '22') {
						var tmpObj = {};
						tmpObj.id = dataRows[i].level1_code;
						tmpObj.text = dataRows[i].level1_name;
						r_data.push(tmpObj);
					}
					if(col_no == '23') {
						var tmpObj = {};
						tmpObj.id = dataRows[i].level2_code;
						tmpObj.text = dataRows[i].level2_name;
						r_data.push(tmpObj);
					}
					if(col_no == '24') {
						var tmpObj = {};
						tmpObj.id = dataRows[i].level3_code;
						tmpObj.text = dataRows[i].level3_name;
						r_data.push(tmpObj);
					}
				}
			} else {
				fnMessageModalAlert("Error", "이슈코드 마스터 데이터를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "이슈코드 마스터 데이터를 가져오지 못했습니다.");
		}
	});

	return r_data;
}

function ord_process(status) {
	/*
	O : 관리자 판정OK(통계집계)
	P : 관리자판정 OK(통계집계안함)
	N : 취소
	*/
	
	
	
	var selection = w2ui.grid_role.getSelection();
	var selectData = w2ui.grid_role.get(selection);
	
	
	if(selection.length == 0 ) {
		fnMessageModalAlert("Error", "선택된 데이터가 없습니다.");
		return;
	}
	
	
	var empty_flag = 0;
	var valid_flag = 0
	$.each(selectData, function(idx, row) {
		if(row.w2ui !=undefined) {
			if(row.w2ui.changes !=undefined) {
				if(row.w2ui.changes.gr_code!=undefined ) {
					row.gr_code = row.w2ui.changes.gr_code;
				}
				if(row.w2ui.changes.level1_code!=undefined ) {
					row.level1_code = row.w2ui.changes.level1_code;
				}
				if(row.w2ui.changes.level2_code!=undefined ) {
					row.level2_code = row.w2ui.changes.level2_code;
				}
				if(row.w2ui.changes.level3_code!=undefined ) {
					row.level3_code = row.w2ui.changes.level3_code;	
				}
			}
		} 
		
		if(row.gr_code.length == 0 || row.level1_code == 0 || row.level2_code == 0 || row.level3_code == 0) {
			empty_flag++;
		}
	});
	
	
	
	if( empty_flag > 0) {
		fnMessageModalAlert("Error", "입력되지 않은 불량항목이 있습니다.");
		return;
	}
	
	var jsonStr = JSON.stringify(selectData);
	
	var chk = issueValidChk(jsonStr);
	if(chk > 0) {
		fnMessageModalAlert("Error", "올바르게 입력되지 않은 이슈코드가 있습니다.<br>단계별로 선택해주세요.");
		return;	
	}
	

	var page_url = "/frontend/qm/issueDataProc";
	var postData = "status="  + encodeURIComponent(status);
  	postData += "&member_id="  + encodeURIComponent(member_id);   
	postData += "&jsonStr="  + encodeURIComponent(jsonStr);
	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async:false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnMessageModalAlert("Success", "데이터를 성공적으로 저장했습니다.");
				fnSearchRoleGrid();
			} else {
				fnMessageModalAlert("Error", "이슈코드 마스터 데이터를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "이슈코드 마스터 데이터를 가져오지 못했습니다.");
		}
	});
}

function issueValidChk(jsonStr) {
	var rtn_data = 0;
	var page_url = "/frontend/qm/issueValidChk";
	var postData = "jsonStr="  + encodeURIComponent(jsonStr);

	$.ajax({
		url : page_url,
		data : postData,
		type : "POST",
		async:false,
		success : function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				rtn_data = data.result
			} else {
				fnMessageModalAlert("Error", "이슈코드 마스터 데이터를 가져오지 못했습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("Error", "이슈코드 마스터 데이터를 가져오지 못했습니다.");
		}
	});
	
	return rtn_data;
}

function makeSelStep1() {
// 	console.log('makeSelStep1()');
 	 
	var i_dept_cd = $("#plant").val();
	
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
	    		fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 실패하였습니다.");	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification(MES)", "상태 코드 정보를 가져오는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {}
	});
}

function changeStep(selVal, step) {
// 	console.log('changeStep(',selVal,',',step,')');
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