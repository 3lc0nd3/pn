<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    SimpleDateFormat dfLarge = new SimpleDateFormat("dd MMMMMM, yyyy HH:mm:ss");
    SimpleDateFormat dfL = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
    String nombre = "reporte_SMS_"+dfL.format(new Date())+".xls";

    response.setContentType( "application/x-download" );
    response.setHeader("Content-type","application/vnd.ms-excel");
    response.setHeader("Content-Disposition","attachment; filename=\""+ nombre + "\"");
    Persona persona = (Persona) session.getAttribute("persona");

    if(persona!=null && pnManager.isAdministrador(persona.getIdPersona())){

    PnTipoPremio tipoPremio = (PnTipoPremio) session.getAttribute("tipoPremio");
    String mensajePremios;
    List<Participante> participantes;

    String organizaciones = "Empresas";
    if(tipoPremio.getId()==2){
        organizaciones = "Colegios";
    }

    PnPremio premioActivo = (PnPremio) session.getAttribute("premioActivo");
    if(premioActivo != null){
        mensajePremios =
                premioActivo.getNombrePremio() + " V. " +
                premioActivo.getVersion();
        participantes =pnManager.getHibernateTemplate().find(
                "from Participante where pnPremioByIdConvocatoria.id = ? ",
                premioActivo.getIdPnPremio()
        );
    } else {
        mensajePremios = "Todos los premios: " + tipoPremio.getSigla();
//        participantes = pnManager.getParticipantes();
        participantes =pnManager.getHibernateTemplate().find(
                "from Participante where pnPremioByIdConvocatoria.tipoPremioById.id = ? ",
                tipoPremio.getId()
        );
    }
%>


    <table cellpadding="0" cellspacing="0" border="1" class="display" id="participantesT">
        <thead>
        <tr>
            <th colspan="8">
                <h3 style="color: darkslategray;">Participantes seg&uacute;n: <span class="color"><%=mensajePremios%></span></h3>
            </th>
        </tr>
        <tr>
            <th colspan="8">
                <h3 style="color: darkslategray;">
                    Generado: <%=dfLarge.format(new Date())%>
                </h3>
            </th>
        </tr>
        <tr>
            <th>id</th>
            <th>Premio</th>
            <th>Vers</th>
            <th>Participante</th>
            <th>NIT</th>
            <th>Etapa</th>
            <th>Fecha</th>
            <th>Estado</th>
        </tr>
        </thead>
        <%  //
            String imageActive;
            String messaActive;

            for (Participante participante : participantes){
                if(participante.getEstado()){
                    imageActive = "activo";
                } else {
                    imageActive = "inactivo";
                }
                Empresa empresa = participante.getEmpresaByIdEmpresa();
                PnPremio premio = participante.getPnPremioByIdConvocatoria();
        %>
        <tr>
            <td><%=participante.getIdParticipante()%></td>
            <td>
                <%=premio.getTipoPremioById().getSigla()%>
            </td>
            <td>
                <%=premio.getVersion()%>
            </td>
            <td>
                <%=empresa.getNombreEmpresa()%>
            </td>
            <td>
                <%=empresa.getNit()%>
            </td>
            <td><%=participante.getPnEtapaParticipanteByIdEtapaParticipante().getEtapaParticipante()%></td>
            <TD>
                <%=pnManager.dfDateTime.format(participante.getFechaIngreso())%>
            </td>
            <td><%=imageActive%></td>
        </tr>
        <%
            }
        %>
    </table>

<%
    }  //  END IF ES ADMIN
%>


