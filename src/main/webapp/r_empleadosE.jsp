<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
    Persona personaSession = (Persona) session.getAttribute("persona");
    String mensajePremios;

    if(personaSession!=null && pnManager.isAdministrador(personaSession.getIdPersona())){

        List<Participante> participantes;
        List<Empleado> empleados;PnTipoPremio tipoPremio = (PnTipoPremio) session.getAttribute("tipoPremio");

        PnPremio premioActivo = (PnPremio) session.getAttribute("premioActivo");
        if(premioActivo != null){
            mensajePremios = premioActivo.getNombrePremio();
            participantes =pnManager.getHibernateTemplate().find(
                    "from Participante where pnPremioByIdConvocatoria.id = ? order by empresaByIdEmpresa.nombreEmpresa",
                    premioActivo.getIdPnPremio()
            );

            empleados = pnManager.getHibernateTemplate().find("" +
                            "from Empleado where participanteByIdParticipante.empresaByIdEmpresa.idEmpresa <> 1" +
                            " and participanteByIdParticipante.pnPremioByIdConvocatoria.id = ? " +
                            " order by participanteByIdParticipante.empresaByIdEmpresa.nombreEmpresa , personaByIdPersona.nombrePersona , personaByIdPersona.apellido ",
                    premioActivo.getIdPnPremio());
        } else {
            mensajePremios = "Todos los premios " + tipoPremio.getSigla();
            participantes = pnManager.getParticipantes(tipoPremio);
            empleados = pnManager.getHibernateTemplate().find("" +
                            " from Empleado where  participanteByIdParticipante.empresaByIdEmpresa.idEmpresa <> 1 " +
                            " and participanteByIdParticipante.pnPremioByIdConvocatoria.tipoPremioById.id = ? " +
                            " order by participanteByIdParticipante.empresaByIdEmpresa.nombreEmpresa , personaByIdPersona.nombrePersona , personaByIdPersona.apellido ",
                    tipoPremio.getId());
        }
%>





    <table cellpadding="0" cellspacing="0" border="1" class="display" id="participantesT">
        <thead>
        <tr>
            <th colspan="14">
                <h3 style="color: darkslategray;">Empleados seg&uacute;n: <span class="color"><%=mensajePremios%></span></h3>
            </th>
        </tr>
        <tr>
            <th colspan="14">
                <h3 style="color: darkslategray;">
                    Generado: <%=dfLarge.format(new Date())%>
                </h3>
            </th>
        </tr>
        <tr>
            <th>id</th>
            <th>Premio</th>
            <th>Vers</th>
            <th>Instituci&oacute;n</th>
            <th>NIT</th>
            <th>Cargo</th>
            <th>Perfil</th>
            <th>Empleado</th>
            <th>email personal</th>
            <th>email corp.</th>
            <th>celular</th>
            <th>tel. fijo</th>
            <th>Estado</th>
            <th>Fecha Vinc</th>
        </tr>
        </thead>
        <%  // TODO HACER ESTO EN UNA SOLA CONSULTA
            String imageActive;

            for (Empleado empleado: empleados){
                Participante participante = empleado.getParticipanteByIdParticipante();
                Persona persona = empleado.getPersonaByIdPersona();
                if(persona.getEstado()){
                    imageActive = "activo";
                } else {
                    imageActive = "inactivo";
                }
        %>
        <tr>
            <td> <%=empleado.getIdEmpleado()%></td>
            <td> <%=participante.getPnPremioByIdConvocatoria().getTipoPremioById().getSigla()%></td>
            <td> <%=participante.getPnPremioByIdConvocatoria().getVersion()%></td>
            <td>
                <%=participante.getEmpresaByIdEmpresa().getNombreEmpresa()%>
            </td>
            <Td>
                <%=participante.getEmpresaByIdEmpresa().getNit()%></Td>
            <td> <%=empleado.getCargoEmpleadoByIdCargo().getCargo()%>
            </td>
            <td> <%=empleado.getPerfilByIdPerfil().getPerfil()%>
            </td>
            <td>
                <%=persona.getNombreCompleto()%>
            </td>
            <td><%=persona.getEmailPersonal()%></td>
            <td><%=persona.getEmailCorporativo()%></td>
            <td><%=persona.getCelular()%></td>
            <td><%=persona.getTelefonoFijo()%></td>
            <td><%=imageActive%>
            </td>
            <td>
                <%=empleado.getFechaIngreso()%>
            </td>
        </tr>
        <%
            }
        %>
    </table>
<%
    }  //  END IF ES ADMIN
%>