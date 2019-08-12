<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id='doctest' style="display:none">
</div>

<div id='transDoc' style="display:none">
<p style="text-align: center;"><span style="font-size: 20px;"><strong>거 &nbsp; &nbsp;래 &nbsp; &nbsp;명 &nbsp; &nbsp;세 &nbsp; &nbsp;표</strong></span></p>

<table style="width: 100%;border: 0px;" >
	<tbody style="border: 0px;">
		<tr style="border: 0px;">
			<td style="width: 39%;border: 0px;">
				<div>
					<br><span style="font-size: 8px;"><strong>납품일자 :&nbsp;</strong><a id="row_1" style="font-size: 8px;"></a></span>
					<br><span style="font-size: 8px;"><strong>납품번호 :&nbsp;</strong><a id="row_2" style="font-size: 8px;"></a></span>
					<br><span style="font-size: 8px;"><strong>발주번호 :&nbsp;</strong><a id="row_3" style="font-size: 8px;"></a></span>
					<br>
				</div>
			</td>
			<td style="width: 41%; text-align: left;border: 0px;">
				<div id="barcode"></div>
			</td>
			<td style="width: 20%;border: 0px;">
				<p style="text-align: right;font-size: 8px;"><strong>VAT 별도</strong></p>
				<table style="width: 100%;">
					<tbody>
						<tr>
							<td style="text-align: center;font-size: 8px;">통화</td>
							<td style="text-align: center;font-size: 8px;">환율</td>
						</tr>
						<tr>
							<td style="text-align: center;font-size: 8px;"><a id="row_4" style="font-size: 8px;"></a></td>
							<td style="text-align: center;font-size: 8px;"><a id="row_5" style="font-size: 8px;"></a></td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</tbody>
</table>


<table style="width: 100%;">
	<tbody>
		<tr>
			<td rowspan="3" style="width: 5%; text-align: center;"><span style="font-size: 8px;"><strong>공급받는자</strong></span>
			</td>
			<td style="height:25px; width: 10%; text-align: center;"><span style="font-size: 8px;"><strong>등록번호</strong></span></td>
			<td colspan="3" style="width: 35%; text-align: center;">
				<a id="row_0_2" style="font-size: 8px;"></a>
			</td>
			<td rowspan="3" style="width: 5%; text-align: center;"><span style="font-size: 8px;"><strong>공<br/>급<br/>자</strong></span>
			</td>
			<td style="width: 10%; text-align: center;"><span style="font-size: 8px;"><strong>등록번호</strong></span>
			</td>
			<td colspan="3" style="width: 35%; text-align: center;">
				<a id="row_0_7" style="font-size: 8px;"></a>
			</td>
		</tr>
		<tr>
			<td style="height:25px; width: 10%; text-align: center;"><span style="font-size: 8px;"><strong>상호</strong></span></td>
			<td style="width: 15%; text-align: center;">
				<a id="row_1_2" style="font-size: 8px;"></a>
			</td>
			<td style="width: 10%; text-align: center;"><span style="font-size: 8px;"><strong>대표자성명</strong></span>
			</td>
			<td style="width: 10%; text-align: center;">
				<a id="row_1_4" style="font-size: 8px;"></a>
			</td>
			<td style="width: 10%; text-align: center;"><strong><span style="font-size: 8px;">상호</span></strong></td>
			<td style="width: 15%; text-align: center;">
				<a id="row_1_7" style="font-size: 8px;"></a>
			</td>
			<td style="width: 10%; text-align: center;"><span style="font-size: 8px;"><strong>대표자성명</strong></span>
			</td>
			<td style="width: 10%; text-align: center;">
				<a id="row_1_9" style="font-size: 8px;"></a>
			</td>
		</tr>
		<tr>
			<td style="height:25px; width: 10%; text-align: center;"><span style="font-size: 8px;"><strong>주소</strong></span></td>
			<td colspan="3" style="width: 35%; text-align: center;">
				<a id="row_2_2" style="font-size: 8px;"></a>
			</td>
			<td style="width: 10%; text-align: center;"><span style="font-size: 8px;"><strong>주소</strong></span>
			</td>
			<td colspan="3" style="width: 35%; text-align: center;">
				<a id="row_2_7" style="font-size: 8px;"></a>
			</td>
		</tr>
	</tbody>
</table>

<table style="width: 100%;">
	<tbody id="my0-tbody_1">
		<tr>
			<td style="height:20px; width: 5%; text-align: center;"><span style="font-size: 8px;"><strong>순번</strong></span>
			</td>
			<td style="width: 15%; text-align: center;"><span style="font-size: 8px;"><strong>품목코드</strong></span>
			</td>
			<td style="width: 32%; text-align: center;"><span style="font-size: 8px;"><strong>품목/규격</strong></span>
			</td>
			<td style="width: 8%; text-align: center;"><span style="font-size: 8px;"><strong>플랜트</strong></span>
			</td>
			<td style="width: 8%; text-align: center;"><span style="font-size: 8px;"><strong>입고창고</strong></span>
			</td>
			<td style="width: 8%; text-align: center;"><span style="font-size: 8px;"><strong>수량</strong></span>
			</td>
			<td style="width: 8%; text-align: center;"><span style="font-size: 8px;"><strong>단위</strong></span>
			</td>
			<td style="width: 8%; text-align: center;"><span style="font-size: 8px;"><strong>단가</strong></span>
			</td>
			<td style="width: 8%; text-align: center;"><span style="font-size: 8px;"><strong>공급가액</strong></span>
			</td>
		</tr>
	</tbody>
</table>
<table style="width: 100%;">
	<tbody id="my0-tbody_2"  style="width: 100%;">
	</tbody>
</table>
</div>
