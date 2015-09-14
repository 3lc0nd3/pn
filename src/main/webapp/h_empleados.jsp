<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    String mensajePremios;
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

<div class="register">
    <div class="row">
        <div class="span10">
            <div class="formy">
                <h5>Empleados</h5>
                <div class="form">
                    <!-- Login form (not working)-->
                    <form class="form-horizontal">
                        <!-- Persona -->
                        <div class="control-group">
                            <label class="control-label" for="idPersona">Persona</label>
                            <div class="controls">
                                <%--<input type="text" class="input-large" name="username" id="username">--%>
                                <select id="idPersona" name="idPersona" class="span6">
                                    <%
                                        for (Persona persona: pnManager.getPersonas()){
                                    %>
                                    <option value="<%=persona.getIdPersona()%>"><%=persona.getNombrePersona()%> <%=persona.getApellido()%> - <%=persona.getEmailPersonal()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <!-- Participante -->
                        <div class="control-group">
                            <label class="control-label" for="idParticipante">Participantes</label>
                            <div class="controls">
                                <select id="idParticipante" name="idParticipante" class="span6">
                                    <%
                                        for (Participante participante: participantes){
                                            Empresa empresa = participante.getEmpresaByIdEmpresa();
                                    %>
                                    <option value="<%=participante.getIdParticipante()%>">
                                        <%=participante.getPnPremioByIdConvocatoria().getTipoPremioById().getSigla()%>
                                        -
                                        <%=empresa.getNombreEmpresa()%>
                                        <%=empresa.getNit()%>
                                    </option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <!-- Cargos -->
                        <div class="control-group">
                            <label class="control-label" for="idCargo">Cargo</label>
                            <div class="controls">
                                <select id="idCargo" name="idCargo">
                                    <%
                                        for (CargoEmpleado cargo: pnManager.getCargoEmpleadosParticipante()){
                                    %>
                                    <option value="<%=cargo.getId()%>"><%=cargo.getCargo()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <!-- Cargos -->
                        <div class="control-group">
                            <label class="control-label" for="idPerfil">Perfil en Sistema</label>
                            <div class="controls">
                                <select id="idPerfil" name="idPerfil">
                                    <%
                                        for (Perfil perfil: pnManager.getPerfiles()){
                                    %>
                                    <option value="<%=perfil.getId()%>"><%=perfil.getPerfil()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <!-- Buttons -->
                        <div class="form-actions">
                            <!-- Buttons -->
                            <button id="b1" type="button" class="btn">Consultar</button>
                            <button id="b2" onclick="vincule();" type="button" class="btn">Vincular</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="span2">
        </div>
    </div>
</div>

<div class="border"></div>

<h3 style="color: darkslategray;">Empleados seg&uacute;n: <span class="color"><%=mensajePremios%></span></h3>
<b>
    <a href="r_empleadosE.jsp">Exportar a Excel <img src="img/excel.png" alt="Empleados excel" title="Empleados excel" width="36"></a>
</b>
<div class="row-fluid">
    <br>
    <table cellpadding="0" cellspacing="0" border="0" class="display" id="participantesT">
        <thead>
        <tr>
            <th>id</th>
            <th>Premio</th>
            <th>Empresa</th>
            <th>Cargo</th>
            <th>Perfil</th>
            <th>Empleado</th>
            <th>Estado</th>
            <th>Fecha Vinc</th>
            <th>Opciones</th>
        </tr>
        </thead>
        <%  // TODO HACER ESTO EN UNA SOLA CONSULTA
            String imageActive;
            String messaActive;

            for (Empleado empleado: empleados){
                Participante participante = empleado.getParticipanteByIdParticipante();
                Persona persona = empleado.getPersonaByIdPersona();
                if(persona.getEstado()){
                    imageActive = "img/positive.png";
                    messaActive = "Desactivar?";
                } else {
                    imageActive = "img/negative.png";
                    messaActive = "Activar?";
                }
        %>
        <tr>
            <td> <%=empleado.getIdEmpleado()%></td>
            <td> <%=participante.getPnPremioByIdConvocatoria().getNombrePremio()%></td>
            <td>
                <%=participante.getEmpresaByIdEmpresa().getIdEmpresa()%>.
                <%=participante.getEmpresaByIdEmpresa().getNombreEmpresa()%>
                <br>
                <%=participante.getEmpresaByIdEmpresa().getNit()%>
            </td>
            <td> <%=empleado.getCargoEmpleadoByIdCargo().getCargo()%></td>
            <td> <%=empleado.getPerfilByIdPerfil().getPerfil()%></td>
            <td>
                <%=persona.getIdPersona()%>.
                <%=persona.getNombreCompleto()%>
                <br>
                <%=persona.getEmailPersonal()%>
            </td>
            <td><img id="imgActivePersona<%=persona.getIdPersona()%>" width="28" onclick="activaDesactiva(<%=persona.getIdPersona()%>);" src="<%=imageActive%>" alt="<%=messaActive%>" title="<%=messaActive%>"></td>
            <td>
                <%=empleado.getFechaIngreso()%>
            </td>
            <td>
                <img style="cursor: pointer;" width="40" onclick="activeEmpleado(<%=empleado.getIdEmpleado()%>,'<%=persona.getNombreCompleto()%>');" src="img/plane.png" alt="activa" title="activa">
                <img style="cursor: pointer;" width="28" onclick="desvincule(<%=empleado.getIdEmpleado()%>);" src="img/broken.png" alt="desvincula" title="desvincula">
            </td>
        </tr>
        <%
            }
        %>
    </table>
</div>


<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function desvincule(idEmpleado){
        if (confirm("Si desvincula al Empleado se borran las evaluaciones de esta persona;")) {
            pnRemoto.desvinculaEmpleado(idEmpleado, function(data){
                if(data == ''){
                    alert("Desvinculado Completo");
                    window.location = "empleados.htm";
                } else {
                    alert("Problemas ! " + data);
                }
            });
        }
    }

    /*
    * activa
    *
    */
    function activeEmpleado(idEmpleado, nombre){
        if (confirm("Al activar al Empleado "+nombre+" se le concede acceso al sistema")) {
            pnRemoto.activateEmpleado(idEmpleado, function(data){
                if(data == ''){
                    alrt("Empleado Activado");
                } else {
                    alrtError("Problemas! " + data);
                }
            });
        }
    }

    function vincule(){
        if (dwr.util.getValue("idParticipante") == 1 && dwr.util.getValue("idPerfil") != 1) {
            alert("No puede hacer eso");
        } else {
            disableId('b2');
            pnRemoto.vinculaEmpleado(
                    dwr.util.getValue("idPersona"),
                    dwr.util.getValue("idParticipante"),
                    dwr.util.getValue("idCargo"),
                    dwr.util.getValue("idPerfil"),
                    function(data) {
                        if (data != null) {
                            alert("Registro Completo");
                            window.location = "empleados.htm";
                        } else {
                            alert("Problemas !");
                            enableId('b2');
                        }
                    });
        }
    }

    function activaDesactiva(id){
        $("#imgActivePersona"+id).attr("src","images/loading.gif");
        pnRemoto.activeDesactivePersona(id, function(data){
            if(data!=null){
                if(data){
                    $("#imgActivePersona"+id).attr("src","img/positive.png");
                    $("#imgActivePersona"+id).attr("title", "Desactivar?");
                    $("#imgActivePersona"+id).attr("alt",   "Desactivar?");
                } else {
                    $("#imgActivePersona"+id).attr("src","img/negative.png");
                    $("#imgActivePersona"+id).attr("title", "Activar?");
                    $("#imgActivePersona"+id).attr("alt",   "Activar?");
                }
            } else {
                alert("Problemas !");
            }
        });
    }

    $(document).ready(function() {
        $('#participantesT').dataTable( {
            "aaSorting": [[ 0, "asc" ]],
            "sPaginationType": "full_numbers",
            "oLanguage": {
//                "sLengthMenu": "Mostrar _MENU_ registros",
                "sZeroRecords": "Sin resultados",
                "sInfo": "Mostrando _START_ a _END_ de _TOTAL_ registros",
                "sInfoEmpty": "Mostrando 0 a 0 de 0 registros",
                "sInfoFiltered": "(Filtrado de _MAX_ registros en total)",
                "sSearch": "Buscar en la tabla:",
                "oPaginate": {
                    "sPrevious": "Anterior",
                    "sNext": "Siguiente",
                    "sFirst": "Primera",
                    "sLast": "&Uacute;ltima"
                },
                "sLength" : 5/*,
                "sLengthMenu": 'Mostrar <select>'+
                               '<option value="5">5</option>'+
                               '<option value="10">10</option>'+
                               '<option value="20">20</option>'+
                               '<option value="30">30</option>'+
                               '<option value="40">40</option>'+
                               '<option value="50">50</option>'+
                               '<option value="-1">All</option>'+
                               '</select> registros'*/
            }
        } );
    } );

</script>