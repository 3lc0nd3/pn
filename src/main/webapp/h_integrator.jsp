<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%@ page import="java.text.MessageFormat" %>
<%@ page import="static java.text.MessageFormat.format" %>
<%@ page import="co.com.elramireza.pn.model.Texto" %>
<jsp:include page="c_head.jsp"/>

<%--
EDWARD
<div class="purchase">
    <div class="container">
        <div class="row">
            <div class="span7">
                <p>Buy this theme for $5. Limited Period Offer. Don't miss it.</p>
            </div>
            <div class="span5">
                <div class="pur-button">
                    <a href="#"

                       target="_blank">Buy Now</a>
                    &nbsp;<a href="#" target="_blank">Other Themes</a>
                </div>
            </div>
        </div>
    </div>
</div>--%>

<!-- Header Starts -->

<jsp:include page="c_banner.jsp"/>


<jsp:include page="c_menu_index.jsp"/>



<div class="content">
<div class="container">

<%
    String servicio = (String) request.getAttribute("servicio");
//    System.out.println("servicio = " + servicio);
    if(servicio!= null){
        servicio = format("h_{0}.jsp", servicio);
        try{
%>
    <jsp:include page="<%=servicio%>"/>
<%
    } catch (Exception jasperException){

    }
    }
%>


