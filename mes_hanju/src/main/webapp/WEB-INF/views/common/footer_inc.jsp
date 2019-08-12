<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.mes.util.*"%>
<%
String ver = SessionUtil.getProperties("mes.footer.ver");
String year = SessionUtil.getProperties("mes.footer.year");
String link = SessionUtil.getProperties("mes.footer.link");
String compfullname = SessionUtil.getProperties("mes.footer.compfullname");
%>
<footer class="main-footer">
  <div class="pull-right hidden-xs">
    <b>Version</b> <%=ver %>
  </div>
  <strong>Copyright &copy; <%=year %> <a href="<%=link %>"><%=compfullname %></a></strong> All rights reserved.
</footer>