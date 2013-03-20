<%@ page import="java.util.Date" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Empleado empleo = (Empleado) session.getAttribute("empleo");
    PnAgenda pnAgenda = pnManager.getPnAgendaFromParticipante(empleo.getParticipanteByIdParticipante().getIdParticipante());

    if (empleo.getParticipanteByIdParticipante().getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante() == 3){
%>
<button id="b3" onclick="saltaADespuesDeVisita();"  type="button" class="btn btn-primary">Avanza a Retroalimentaci&oacute;n</button>
<%
    }
%>

<table cellpadding="0" cellspacing="0" border="0"  id="invitados" class="table table-hover table-striped" >
    <thead>
    <tr>
        <%--<th>Hora</th>--%>
        <th>
            Cargo o Persona
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
        <%--<td><%=invitado.getHora()>12?invitado.getHora()-12:invitado.getHora()%>:00<%=invitado.getHora()<12?"A.M.":"P.M."%></td>--%>
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
        <%--<td><%=invitado.getResultados()!=null?invitado.getResultados().replace("\n", "<br>"):""%></td>--%>
        <%--<td></td>--%>
    </tr>
    <%
        }
    %>
</table>

<br>
<span style="font-weight: bold">
    Notas
</span>
<br>
<textarea id="notas" style="width: 80%" ROWS="8"><%=pnAgenda.getNotas()%></textarea>
<br>
<button id="b4" onclick="guardaNotasAgenda();"  type="button" class="btn  btn-primary">Guarda Notas</button>

<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function guardaNotasAgenda(){
        disableId("b3");
        var nota = dwr.util.getValue("notas");
        pnRemoto.guardaNotasAgenda(nota, function(data){
            if(data ==1){
                alert("Guardado Correcto");
            } else {
                alert("Problemas !");
            }
            enableId("b4");
        });
    }

    function saltaADespuesDeVisita(){
        disableId("b3");
//        alert("1");
        pnRemoto.saltaADespuesDeVisita(function(data){
//            alert("data = " + data);
            if(data == 1){
                alert("Cambio de Etapa Correcto");
                window.location = "evalItemsDespuesVisita.htm";
            } else {
                alert("Problemas !");
            }
            enableId("b3");
        });
//        alert("2");
        var a = 9;
    }

</script>
