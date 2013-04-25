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
    nombre      = (String) request.getAttribute("nombre");

    Empleado empleado = pnManager.getEmpleado(idEmpleado);

    List<PnValoracion> fromParticipante = pnManager.getValoracionIndividualCapitulosFromEmpleado(
            idEmpleado);

    List<PnCualitativa> cualitativas = pnManager.getPnCualitativasFromEmpleadoTipoFormato(
            idEmpleado, 2 // FORMATO 2 INDIVIDUALPOR CAPITULO
    );

%>
<br>
<b>Evaluaci&oacute;n</b>
<br>
<h3><%=nombre%></h3>
<b>de</b>
<br>
<h3><%=empleado.getPersonaByIdPersona().getNombreCompleto()%></h3>

<table border="1" width="100%">
<%
    int oldCapitulo = 0;
    int oldCategoriaCriterio = 0;
    PnCualitativa cualitativa = null;
    for (int i = 0; i < fromParticipante.size(); i++) {
        PnValoracion vv = fromParticipante.get(i);
        if (oldCapitulo != vv.getPnCapituloByIdCapitulo().getId()) {
            oldCapitulo = vv.getPnCapituloByIdCapitulo().getId();
            cualitativa = cualitativas.get(vv.getPnCapituloByIdCapitulo().getId()-1);
        }
%>
    <%

        if (1 == vv.getPnCriterioByIdPnCriterio().getId()) {
    %>
    <tr>
        <td colspan="2">&nbsp</td>
    </tr>
    <tr>
        <td colspan="2" align="center" style="color: white; background-color: #003399; font-weight: bolder; font-size: larger;">
            <%=vv.getPnCapituloByIdCapitulo().getNombreCapitulo()%>
        </td>
    </tr>
    <tr><th class="alert-info">Valoraci&oacute;n Global de la Organizaci&oacute;n</th></tr>
    <tr><td><%=cualitativa.getVision()%></td></tr>
    <tr><th colspan="2" class="alert-info">Fortalezas</th></tr>
    <tr><td colspan="2"><%=cualitativa.getFortalezas()%></td></tr>
    <tr><th colspan="2" class="alert-info">Oportunidades de Mejora</th></tr>
    <tr><td colspan="2"><%=cualitativa.getOportunidades()%></td></tr>
    <tr><th colspan="2" class="alert-info">Pendientes Vista de Campo</th></tr>
    <tr><td colspan="2"><%=cualitativa.getPendientesVisita()%></td></tr>
    <%
        }
        if (oldCategoriaCriterio != vv.getPnCriterioByIdPnCriterio().getPnCategoriaCriterioByIdCategoriaCriterio().getId()) {
            oldCategoriaCriterio = vv.getPnCriterioByIdPnCriterio().getPnCategoriaCriterioByIdCategoriaCriterio().getId();
    %>
    <tr>
        <th align="center" colspan="2" class="btn-inverse"><%=vv.getPnCriterioByIdPnCriterio().getPnCategoriaCriterioByIdCategoriaCriterio().getCategoriaCriterio()%></th>
    </tr>
    <%
        }
    %>
    <tr>
        <td><%=vv.getPnCriterioByIdPnCriterio().getCriterio()%></td>
        <td align="right"><%=vv.getValor()%></td>
    </tr>

<%
    }
    System.out.println("cualitativas.size() = " + cualitativas.size());
%>
</table>
                    <%--<table border="1" width="100%">
                        <tr><th class="alert-info">Fortalezas</th></tr>
                        <tr><td><%=cualitativa.getFortalezas()%></td></tr>
                        <tr><th class="alert-info">Oportunidades de Mejora</th></tr>
                        <tr><td><%=cualitativa.getOportunidades()%></td></tr>
                        <tr><th class="alert-info">Pendientes Vista de Campo</th></tr>
                        <tr><td><%=cualitativa.getPendientesVisita()%></td></tr>
                    </table>
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
                            &lt;%&ndash;<td><%=v.getPnCapituloByIdCapitulo().getNombreCapitulo()%></td>&ndash;%&gt;
                            <td><%=v.getPnCriterioByIdPnCriterio().getCriterio()%></td>
                            <td align="right"><%=v.getValor()%></td>
                        </tr>
                        <%
                            }
                        %>
                    </table>--%>


