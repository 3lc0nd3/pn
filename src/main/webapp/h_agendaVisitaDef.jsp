<%@ page import="java.util.Date" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Empleado empleo = (Empleado) session.getAttribute("empleo");
    PnAgenda pnAgenda = pnManager.getPnAgendaFromParticipante(empleo.getParticipanteByIdParticipante().getIdParticipante());
    List<Empleado> evaluadores = pnManager.getEvaluadoresFromParticipante(empleo.getParticipanteByIdParticipante().getIdParticipante());

    if (pnAgenda==null) {
%>
<div class="alert">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    No hay fecha asignada
</div>
<%
    } else {  //  SI HAY AGENDA

        if (empleo.getParticipanteByIdParticipante().getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante() == 3
            &&
            empleo.getPerfilByIdPerfil().getId() == 7){
%>
<button id="b10" onclick="window.location = 'agendaVisita.htm';"  type="button" class="btn btn-primary">Volver a definir Agenda</button>
<button id="b3" onclick="saltaADespuesDeVisita();"  type="button" class="btn btn-primary">Avanza a Eval. Final</button>
<%
        }  //  END IF ALGO DEL PERFIL
%>

<h4>
    Visita programada para:  <%=pnManager.dfNameMonth.format(pnAgenda.getFechaAgenda())%>
</h4>
<br>
<h5>
    Evaluadores:
</h5>
<blockquote><ul  type = disc style="margin-left: 20px;">
<%
    for (Empleado evaluador: evaluadores){
%>
<li style="text-transform: capitalize;"><%=evaluador.getPersonaByIdPersona().getNombreCompleto()%></li>

<%
    }  //  END FOR EVALUADORES
%>
</ul></blockquote>
<br>
<h5>Agenda Planeada</h5>
<table cellpadding="0" cellspacing="0" border="0"  id="invitados" class="table table-hover table-striped" >
    <thead>
    <tr>
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
    </tr>
    <%
        }  //  END FOR INVITADOS AGENDA
    %>
</table>

<br>
<%
    if(empleo.getPerfilByIdPerfil().getId() == 7){
%>
<span style="font-weight: bold">
    Notas
</span>
<br>
<textarea id="notas" style="width: 80%" ROWS="8"><%=pnAgenda.getNotas()==null?"":pnAgenda.getNotas()%></textarea>
<br>
<button id="b4" onclick="guardaNotasAgenda();"  type="button" class="btn  btn-primary">Guarda Notas</button>

<%
        }  //  END IF NOTAS LIDER
    }  //  FIN SI HAY AGENDA
%>

<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function guardaNotasAgenda(){
        disableId("b3");
        var nota = dwr.util.getValue("notas");
        pnRemoto.guardaNotasAgenda(nota, function(data){
            if(data ==1){
                alrt("Guardado Correcto");
            } else {
                alrtError("Problemas !");
            }
            enableId("b4");
        });
    }

    function saltaADespuesDeVisita(){
        if (confirm("Si avanza no puede hacer cambios en Agenda.")) {
            botonEnProceso("b3");
//        alert("1");
            pnRemoto.saltaADespuesDeVisita(function(data){
    //            alert("data = " + data);
                if(data == 1){
                    alert("Cambio de Etapa Correcto");
                    window.location = "evalItemsDespuesVisita.htm";
                } else {
                    alert("Problemas !");
                }
                botonOperativo("b3");
            });
//        alert("2");
            var a = 9;
        }
    }

</script>
