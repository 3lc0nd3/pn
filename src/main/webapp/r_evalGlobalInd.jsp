<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />


<%
    int idEmpleado;

    String id = request.getParameter("id");
    String nombre = "";
    if (id == null) {
        idEmpleado  = (Integer) request.getAttribute("id");
//        System.out.println("nombre = " + nombre);
    } else {
        idEmpleado = Integer.parseInt(id);
    }
    nombre      = (String)  request.getAttribute("nombre");
    System.out.println("nombre2222 = " + nombre);

    Empleado empleado = pnManager.getEmpleado(idEmpleado);

    List<PnValoracion> fromParticipante = pnManager.getValoracionIndividualGlobalFromEmpleado(
            idEmpleado);

    PnCualitativa cualitativa = pnManager.getPnCualitativaFromEmpleadoTipoFormato(
            idEmpleado, 1 // FORMATO 1 INDIVIDUAL
    );
    if (cualitativa!= null) {
%>
<br>
<b>Evaluaci&oacute;n</b>
<br>
<h3><%=nombre%></h3>
<b>de</b>
<br>
<h3><%=empleado.getPersonaByIdPersona().getNombreCompleto()%></h3>
<table border="1" width="100%">
    <tr><th class="alert-info">Valoraci&oacute;n Global de la Organizaci&oacute;n</th></tr>
    <tr><td><%=cualitativa.getVision()%></td></tr>
    <tr><th class="alert-info">Pendientes Vista de Campo</th></tr>
    <tr><td><%=cualitativa.getPendientesVisita()%></td></tr>
</table>
<%
    }
%>
<br>
<table border="1" width="100%">
    <%
        int oldCategoriaCriterio = 0;
        for (PnValoracion v: fromParticipante){
            if (oldCategoriaCriterio != v.getPnCriterioByIdPnCriterio().getPnCategoriaCriterioByIdCategoriaCriterio().getId() ) { //DIFERENTES
                oldCategoriaCriterio = v.getPnCriterioByIdPnCriterio().getPnCategoriaCriterioByIdCategoriaCriterio().getId();
    %>
    <tr>
        <th align="center" colspan="2" class="btn-inverse"><%=v.getPnCriterioByIdPnCriterio().getPnCategoriaCriterioByIdCategoriaCriterio().getCategoriaCriterio()%></th>
    </tr>
    <%
            }
    %>
    <tr>
        <%--<td><%=v.getPnCapituloByIdCapitulo().getNombreCapitulo()%></td>--%>
        <td><%=v.getPnCriterioByIdPnCriterio().getCriterio()%></td>
        <td align="right"><%=v.getValor()%></td>
    </tr>
    <%
        }
    %>
</table>


