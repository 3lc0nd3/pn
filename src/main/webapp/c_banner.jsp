<%@ page import="co.com.elramireza.pn.model.Texto" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<header>
    <div class="container">
        <div class="row">
            <div class="span12">
                <div class="logo">
                    <h1><a href="#">
                        <%
                            Texto titulo;
                            titulo = pnManager.getTexto(11);
                        %>
                        <%=titulo.getTexto1()%>  <br>
                        <span class="color">
                            <%=titulo.getTexto2()%>
                        </span></a></h1>
                    <div class="hmeta">
                        <%=titulo.getTexto3()%>
                    </div>
                </div>
            </div>   <%--SPAN 12--%>
            <%--<div class="span6">
                <div class="form">
                    <form method="get" id="searchform" action="#" class="form-search">
                        <input type="text" value="" name="s" id="s" class="input-medium"/>
                        <button type="submit" class="btn">Buscar</button>
                    </form>
                </div>
            </div>--%>
        </div>
    </div>
</header>