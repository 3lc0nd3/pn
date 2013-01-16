<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.sw.model.Startup" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="swManager" class="co.com.elramireza.sw.dao.SwDAO" scope="application" />
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<h1>
    TEST
</h1>
<br>
Hola Mundo

</body>
</html>

<%
    List<Startup> startups = swManager.getHibernateTemplate().find("from Startup ");
    for(Startup startup: startups){
        swManager.vinculaStartupConCertamen(startup.getIdStartup(), 1);
    }

%>