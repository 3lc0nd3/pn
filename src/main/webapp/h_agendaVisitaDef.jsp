<%@ page import="java.util.Date" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Empleado empleo = (Empleado) session.getAttribute("empleo");



%>
<table cellpadding="0" cellspacing="0" border="0"  id="invitados" class="table table-hover table-striped" >
    <thead>
    <tr>
        <th>
            Hora
        </th>
        <th>
            Empleado
        </th>
        <th>
            &Iacute;tem
        </th>
        <th>
            Documentos Requeridos
        </th>
        <th>
            Preguntas
        </th>
        <th>
            Respuestas
        </th>
        <th>
            &nbsp;
            &nbsp;
            &nbsp;
        </th>
    </tr>
    </thead>
    <%
        for (PnAgendaInvitado invitado:  pnManager.getPnAgendaInvitadosFromParticipante(empleo.getParticipanteByIdParticipante().getIdParticipante())){
    %>
    <tr>
        <td>
            <%=invitado.getHora()>12?invitado.getHora()-12:invitado.getHora()%>:00<%=invitado.getHora()<12?"A.M.":"P.M."%>
        </td>
        <td>
            <%=invitado.getIdEmpleado()%>
        </td>
        <td>
            <%=invitado.getPnSubCapituloByIdPnSubcapitulo().getCodigoItem()%>
            <%=invitado.getPnSubCapituloByIdPnSubcapitulo().getSubCapitulo()%>
        </td>
        <td>
            <%=invitado.getDocumentos().replace("\n", "<br>")%>
        </td>
        <td>
            <%=invitado.getPreguntas().replace("\n", "<br>")%>
        </td>
        <td>
            <%=invitado.getResultados()!=null?invitado.getResultados().replace("\n", "<br>"):""%>
        </td>
        <td></td>
    </tr>
    <%
        }
    %>
</table>

<jsp:include page="c_footer_r.jsp"/>
