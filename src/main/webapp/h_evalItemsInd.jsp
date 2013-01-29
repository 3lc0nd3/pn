<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Texto texto16 = pnManager.getTexto(18);
    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Empresa empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();

    List<PnCategoriaCriterio> categoriasCriterio = pnManager.getCategoriasCriterio();

%>

<individual>
    <div class="row">
        <div class="container">
            <div class="span8">
                <h2><%=texto16.getTexto1()%></h2>
                para <strong><%=empresa.getNombreEmpresa()%></strong>
                <br>
                <br>
            </div>
            <div class="span4">
            </div>
        </div>

    </div>
</individual>









<jsp:include page="c_footer_r.jsp"/>