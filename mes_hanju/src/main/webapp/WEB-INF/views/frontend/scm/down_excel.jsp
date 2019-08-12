<%@ page import="java.net.URLDecoder, java.net.URLEncoder" %>
<%
	try {
		String docName = "";
		String data = request.getParameter("csvBuffer");
		String fileName = request.getParameter("fileName");
		
		// header
		String header = request.getHeader("User-Agent");
		if( header.contains("MSIE") )	header = "MSIE";
		else if( header.contains("Chrome") ) header = "Chrome";
		else if( header.contains("Opera") ) header = "Opera";
		
		if( data!=null && fileName!=null ){
			data = URLDecoder.decode(data, "UTF-8");
			fileName = URLDecoder.decode(fileName, "UTF-8");
			response.setContentType("application/vnd.ms-excel");
			
			if( header.contains("MSIE") ) {
				docName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
				response.setHeader("Content-Disposition", "attachment;filename=\"" + docName + ".xls");
			} else if( header.contains("Chrome") ) {
				docName = new String(fileName.getBytes("UTF-8"), "ISO--8859-1");
				response.setHeader("Content-Disposition", "attachment;filename=\"" + docName + ".xls\"");
			} else {
				//
			}
			
			response.setHeader("Pragma", "no-cashe;");
			response.setHeader("Expires", "-1");
			out.println(data);
		}
	} catch( Exception e ) {
		e.printStackTrace();
		out.println(e.toString());
	}
%>