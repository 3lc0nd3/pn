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

    Empleado empleado = pnManager.getEmpleado(idEmpleado);

    List<PnPrincipioCualitativo> principioCualitativos = pnManager.getHibernateTemplate().find(
            "from PnPrincipioCualitativo where pnTipoPremioById.id=?",
            empleado.getParticipanteByIdParticipante().getPnPremioByIdConvocatoria().getTipoPremioById().getId()
    );

    List<PnValoracion> fromParticipante = pnManager.getValoracionConsensoCapitulosFromEmpleado(
            idEmpleado);

    List<PnCualitativa> cualitativas = pnManager.getPnCualitativasFromEmpleadoTipoFormato(
            idEmpleado, 7 // FORMATO 7 CONSENSO POR CAPITULO
    );

%>
<br>
<b>Evaluaci&oacute;n</b>
<br>
<h3><%=nombre.getTexto2()%></h3>
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
        if (oldCapitulo != vv.getPnCapituloByIdCapitulo().getNumeroCapitulo()) {
            oldCapitulo =  vv.getPnCapituloByIdCapitulo().getNumeroCapitulo();
            cualitativa = cualitativas.get(vv.getPnCapituloByIdCapitulo().getNumeroCapitulo()-1);

    %>
    <tr>
        <td colspan="2">&nbsp</td>
    </tr>
    <tr>
        <td colspan="2" align="center" style="color: white; background-color: #003399; font-weight: bolder; font-size: larger;">
            <%=vv.getPnCapituloByIdCapitulo().getNombreCapitulo()%>
        </td>
    </tr>
    <tr><th colspan="2" class="alert-info"><%=principioCualitativos.get(0).getNombreCualitativa()%></th></tr>
    <tr><td colspan="2"><%=cualitativa.getVision()%></td></tr>
    <tr><th colspan="2" class="alert-info"><%=principioCualitativos.get(1).getNombreCualitativa()%></th></tr>
    <tr><td colspan="2"><%=cualitativa.getFortalezas()%></td></tr>
    <tr><th colspan="2" class="alert-info"><%=principioCualitativos.get(2).getNombreCualitativa()%></th></tr>
    <tr><td colspan="2"><%=cualitativa.getOportunidades()%></td></tr>
    <tr><th colspan="2" class="alert-info"><%=principioCualitativos.get(3).getNombreCualitativa()%></th></tr>
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


