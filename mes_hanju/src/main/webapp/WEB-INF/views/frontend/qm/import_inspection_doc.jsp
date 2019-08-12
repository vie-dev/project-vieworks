<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 입고검사성적서 1장짜리 : Start -->
<div id='inspDoc_1' style="display:none">
<br/><br/>
<table style="width: 100%;">
	<tbody>
		<tr>
			<td style="width: 15%;">
				<div style="text-align: center;"><span style="font-size: 24px;">Vieworks</span></div>
			</td>
			<td style="width: 85%;">
				<div style="text-align: center;"><span style="font-size: 24px;">입 &nbsp;고 &nbsp;검 &nbsp;사 &nbsp;성 &nbsp;적 &nbsp;서</span></div>
			</td>
		</tr>
	</tbody>
</table>
<br/>
<table style="width: 100%;">
	<tbody>
		<tr>
			<th style="width: 10%; height:30px;"><span style="font-size: 12px;">모델</span></th>
			<td style="width: 15%;"><span id='s_model_1' style="font-size: 8px;"></span>
			</td>
			<th style="width: 10%;"><span style="font-size: 12px;">가공처</span></th>
			<td style="width: 15%;"><span id='s_comp_1' style="font-size: 8px;"></span>			
			</td>
			<th rowspan="3" style="width: 10%;"><span style="font-size: 12px;">결<br/>재</span></th>
			<th colspan="2" style="width: 20%;"><span style="font-size: 12px;">납품회사</span></th>
			<th colspan="2" style="width: 20%;"><span style="font-size: 12px;">Vieworks</span></th>
		</tr>
		<tr>
			<th style="width: 10%; height:30px;"><span style="font-size: 12px;">품번</span></th>
			<td style="width: 15%;"><span id='s_matnr_1' style="font-size: 8px;"></span></td>
			<th style="width: 10%;"><span style="font-size: 12px;">품명</span></th>
			<td style="width: 15%;"><span id='s_matnr_nm_1' style="font-size: 8px;"></span></td>
			<th style="width: 10%;"><span style="font-size: 12px;">담당자</span></th>
			<th style="width: 10%;"><span style="font-size: 12px;">승인</span></th>
			<th style="width: 10%;"><span style="font-size: 12px;">담당자</span></th>
			<th style="width: 10%;"><span style="font-size: 12px;">승인</span></th>
		</tr>
		<tr>
			<th colspan="4" style="width: 50%; text-align: left; height:60px;"><span id='ecr_1' style="font-size: 8px;"></span></th>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
		</tr>
		<tr>
			<th colspan="4" rowspan="4" style="width: 50%; text-align: left; height:60px;"><span id='attention_1' style="font-size: 8px;"></span></th>
			<th style="width: 10%;"><span style="font-size: 12px;">납품일</span></th>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
		</tr>
		<tr>
			<th style="width: 10%;"><span style="font-size: 12px;">검사일</span></th>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span id="insp_day_1_1" style="font-size: 8px;"></span></td>
			<td style="width: 10%;"><span id="insp_day_2_1"  style="font-size: 8px;"><br></span></td>
		</tr>
		<tr>
			<th style="width: 10%;"><span style="font-size: 12px;">수량</span></th>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span id="cnt_1" style="font-size: 8px;"></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
		</tr>
		<tr>
			<th style="width: 10%;"><span style="font-size: 12px;">判定<br></span></th>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span id="result_1" style="font-size: 8px;"></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
		</tr>
	</tbody>
</table>
<p><span style="font-size: 12px;">※범례 : 합격 ◎, 채용 ○, 특채 ▲, 불합격 x&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span style="font-size: 12px; align : right">Doc No :</span></p>
	<table  name='insertTable' id='insertTable_1_1' style="width: 100%;">
		<tbody id="my0-tbody_1">
			<tr>
				<th rowspan="2" style="width: 5%; text-align: center;"><span style="font-size: 8px;">No</span></th>
				<th rowspan="2" style="width: 13%; text-align: center;"><span style="font-size: 8px;">검사항목</span></th>
				<th rowspan="2" style="width: 28%; text-align: center;"><span style="font-size: 8px;">검사기준</span></th>
				<th style="width: 9%; text-align: center;"><span style="font-size: 8px;">검사수준</span></th>
				<th rowspan="2" style="width: 9%; text-align: center;"><span style="font-size: 8px;">측정기</span></th>
				<th rowspan="2" style="width: 9%; text-align: center;"><span style="font-size: 8px;">납품업체<br>측정치</span></th>
				<th style="width: 9%; text-align: center;"><span style="font-size: 8px;">결과</span></th>
				<th rowspan="2" style="width: 9%; text-align: center;"><span style="font-size: 8px;">Vieworks<br>측정치</span></th>
				<th style="width: 9%; text-align: center;"><span style="font-size: 8px;">결과</span></th>
			</tr>
			<tr>
				<th style="width: 9%; text-align: center;"><span style="font-size: 8px;">AQL</span></th>
				<th style="width: 9%; text-align: center;"><span style="font-size: 8px;">c/n</span></th>
				<th style="width: 9%; text-align: center;"><span style="font-size: 8px;">c/n</span></th>
			</tr>
		</tbody>
	</table>
</div>
<!-- 입고검사성적서 1장짜리 : End -->

<!-- 입고검사성적서 2장짜리 : Start -->
<div id='inspDoc_2' style="display:none">
<br/><br/>
<table style="width: 100%;">
	<tbody>
		<tr>
			<td style="width: 15%;">
				<div style="text-align: center;"><span style="font-size: 24px;">Vieworks</span></div>
			</td>
			<td style="width: 85%;">
				<div style="text-align: center;"><span style="font-size: 24px;">입 &nbsp;고 &nbsp;검 &nbsp;사 &nbsp;성 &nbsp;적 &nbsp;서</span></div>
			</td>
		</tr>
	</tbody>
</table>
<br/>
<table style="width: 100%;">
	<tbody>
		<tr>
			<th style="width: 10%; height:30px;"><span style="font-size: 12px;">모델</span></th>
			<td style="width: 15%;"><span id='s_model_2' style="font-size: 8px;"></span>
			</td>
			<th style="width: 10%;"><span style="font-size: 12px;">가공처</span></th>
			<td style="width: 15%;"><span id='s_comp_2' style="font-size: 8px;"></span>			
			</td>
			<th rowspan="3" style="width: 10%;"><span style="font-size: 12px;">결<br/>재</span></th>
			<th colspan="2" style="width: 20%;"><span style="font-size: 12px;">납품회사</span></th>
			<th colspan="2" style="width: 20%;"><span style="font-size: 12px;">Vieworks</span></th>
		</tr>
		<tr>
			<th style="width: 10%; height:30px;"><span style="font-size: 12px;">품번</span></th>
			<td style="width: 15%;"><span id='s_matnr_2' style="font-size: 8px;"></span></td>
			<th style="width: 10%;"><span style="font-size: 12px;">품명</span></th>
			<td style="width: 15%;"><span id='s_matnr_nm_2' style="font-size: 8px;"></span></td>
			<th style="width: 10%;"><span style="font-size: 12px;">담당자</span></th>
			<th style="width: 10%;"><span style="font-size: 12px;">승인</span></th>
			<th style="width: 10%;"><span style="font-size: 12px;">담당자</span></th>
			<th style="width: 10%;"><span style="font-size: 12px;">승인</span></th>
		</tr>
		<tr>
			<th colspan="4" style="width: 50%; text-align: left; height:60px;"><span id='ecr_2' style="font-size: 8px;"></span></th>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
		</tr>
		<tr>
			<th colspan="4" rowspan="4" style="width: 50%; text-align: left; height:60px;"><span id='attention_2' style="font-size: 8px;"></span></th>
			<th style="width: 10%;"><span style="font-size: 12px;">납품일</span></th>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
		</tr>
		<tr>
			<th style="width: 10%;"><span style="font-size: 12px;">검사일</span></th>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span id="insp_day_1_2" style="font-size:  8px;"></span></td>
			<td style="width: 10%;"><span id="insp_day_2_2"  style="font-size: 8px;"><br></span></td>
		</tr>
		<tr>
			<th style="width: 10%;"><span style="font-size: 12px;">수량</span></th>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span id="cnt_2" style="font-size: 8px;"></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
		</tr>
		<tr>
			<th style="width: 10%;"><span style="font-size: 12px;">判定<br></span></th>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
			<td style="width: 10%;"><span id="result_2" style="font-size: 8px;"></span></td>
			<td style="width: 10%;"><span style="font-size: 8px;"><br></span></td>
		</tr>
	</tbody>
</table>
<p><span style="font-size: 12px;">※범례 : 합격 ◎, 채용 ○, 특채 ▲, 불합격 x&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span style="font-size: 12px; align : right">Doc No :</span></p>
	<table  name='insertTable' id='insertTable_2_1' style="width: 100%;">
		<tbody id="my1-tbody_1">
			<tr>
				<th rowspan="2" style="width: 5%; text-align: center;"><span style="font-size: 8px;">No</span></th>
				<th rowspan="2" style="width: 13%; text-align: center;"><span style="font-size: 8px;">검사항목</span></th>
				<th rowspan="2" style="width: 28%; text-align: center;"><span style="font-size: 8px;">검사기준</span></th>
				<th style="width: 9%; text-align: center;"><span style="font-size: 8px;">검사수준</span></th>
				<th rowspan="2" style="width: 9%; text-align: center;"><span style="font-size: 8px;">측정기</span></th>
				<th rowspan="2" style="width: 9%; text-align: center;"><span style="font-size: 8px;">납품업체<br>측정치</span></th>
				<th style="width: 9%; text-align: center;"><span style="font-size: 8px;">결과</span></th>
				<th rowspan="2" style="width: 9%; text-align: center;"><span style="font-size: 8px;">Vieworks<br>측정치</span></th>
				<th style="width: 9%; text-align: center;"><span style="font-size: 8px;">결과</span></th>
			</tr>
			<tr>
				<th style="width: 9%; text-align: center;"><span style="font-size: 8px;">AQL</span></th>
				<th style="width: 9%; text-align: center;"><span style="font-size: 8px;">c/n</span></th>
				<th style="width: 9%; text-align: center;"><span style="font-size: 8px;">c/n</span></th>
			</tr>
		</tbody>
	</table>
	<p style='page-break-before:always'></p>
	<br/><br/>
	<table  name='insertTable' id='insertTable_2_2' style="width: 100%;">
		<tbody id="my1-tbody_2">
		</tbody>
	</table>
</div>
<!-- 입고검사성적서 2장짜리 : End -->