<%@ page contentType="text/html; charset=utf-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
//    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
//    response.setHeader("Pragma","no-cache"); //HTTP 1.0
//    response.setDateHeader ("Expires", 0); //prevent caching at the proxy server

    response.sendRedirect("index.htm");
%>

<body><h1>Hola</h1>
</body>
</html>