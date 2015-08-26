<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />


<%
    int idEmpleado;

    String id = request.getParameter("id");
    Texto nombre = new Texto();
    if (id == null) {
        idEmpleado  = (Integer) request.getAttribute("id");
//        System.out.println("nombre = " + nombre);
    } else {
        idEmpleado = Integer.parseInt(id);
    }
    nombre      = (Texto) request.getAttribute("nombre");
    System.out.println("nombre2222 = " + nombre);

    Empleado empleado = pnManager.getEmpleado(idEmpleado);

    List<PnPrincipioCualitativo> principioCualitativos = pnManager.getHibernateTemplate().find(
            "from PnPrincipioCualitativo where pnTipoPremioById.id=?",
            empleado.getParticipanteByIdParticipante().getPnPremioByIdConvocatoria().getTipoPremioById().getId()
    );

    List<PnValoracion> fromParticipante = pnManager.getValoracionConsensoGlobalFromEmpleado(
            idEmpleado);

    PnCualitativa cualitativa = pnManager.getPnCualitativaFromEmpleadoTipoFormato(
            idEmpleado, 6 // FORMATO 6 CONSENSO GLOBAL
    );
    if (cualitativa!= null) {
%>
<br>
<b>Evaluaci&oacute;n</b>
<br>
<h3><%=nombre.getTexto2()%></h3>
<b>de</b>
<br>
<h3><%=empleado.getPersonaByIdPersona().getNombreCompleto()%></h3>
<table border="1" width="100%">
    <%--<tr><th class="alert-info">Valoraci&oacute;n Global de la Organizaci&oacute;n</th></tr>
    <tr><td><%=cualitativa.getVision()%></td></tr>
    <tr><th class="alert-info">Pendientes Vista de Campo</th></tr>
    <tr><td><%=cualitativa.getPendientesVisita()%></td></tr>--%>
        <tr><th colspan="2" class="alert-info"><%=principioCualitativos.get(0).getNombreCualitativa()%></th></tr>
        <tr><td colspan="2"><%=cualitativa.getVision()%></td></tr>
        <tr><th colspan="2" class="alert-info"><%=principioCualitativos.get(1).getNombreCualitativa()%></th></tr>
        <tr><td colspan="2"><%=cualitativa.getFortalezas()%></td></tr>
        <tr><th colspan="2" class="alert-info"><%=principioCualitativos.get(2).getNombreCualitativa()%></th></tr>
        <tr><td colspan="2"><%=cualitativa.getOportunidades()%></td></tr>
        <tr><th colspan="2" class="alert-info"><%=principioCualitativos.get(3).getNombreCualitativa()%></th></tr>
        <tr><td colspan="2"><%=cualitativa.getPendientesVisita()%></td></tr>
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


