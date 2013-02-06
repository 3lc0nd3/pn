<%@ page import="java.util.Date" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Empleado empleo = (Empleado) session.getAttribute("empleo");
%>

<agenda>
    <div class="container">
        <div class="row">
            <div class="span8">
                <div class="formy">
                    <h5>Agenda de Visita</h5>
                    <br>
                    <%
                        int idParticipante = empleo.getParticipanteByIdParticipante().getIdParticipante();
                        System.out.println("idParticipante = " + idParticipante);
                        PnAgenda pnAgenda = pnManager.getPnAgendaFromParticipante(idParticipante);
                        System.out.println("pnAgenda = " + pnAgenda);
                        if(pnAgenda == null){ // NO HAY 
                    %>
                    <div class="alert">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                        no hay valores
                    </div>
                    <%
                    } else {
                    %>

                    <div class="alert alert-success">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                        Datos ingresados el
                        <%=pnManager.dfDateTime.format(pnAgenda.getFechaCreacion())%>
                    </div>
                    <%
                        }
                    %>
                    <br>
                    <div class="form">
                        <!-- -->
                        <form class="form-horizontal">

                            <!-- fecha desde -->
                            <div class="control-group">
                                <label class="control-label" for="tmpFechaDesde">Fecha de Visita</label>
                                <div class="controls">
                                    <input type="text" readonly class="input-large required" name="tmpFechaDesde" id="tmpFechaDesde">
                                </div>
                            </div>
                            <!-- Buttons -->
                            <div class="form-actions">
                                <!-- Buttons -->
                                <%--<button type="button" class="btn">Consultar</button>--%>
                                <button id="b1" onclick="definaFecha();"           type="button" class="btn">Defina Fecha</button>
                                <%
                                    if(pnAgenda != null){ // SOLO SI HAY
                                %>
                                <button id="b3" onclick="saltaADespuesDeVisita();"  type="button" class="btn">Avanza a Retroalimentaci&oacute;n</button>
                                <%
                                    }
                                %>
                            </div>
                        </form>
                    </div>
                </div>
                <%
                    if(pnAgenda != null){ // SOLO SI HAY
                %>
                <br>
                <div class="formy">
                    <h5>Invitar Personas a Visita</h5>
                    <div class="form">
                        <!-- -->
                        <form class="form-horizontal">

                            <!-- Empleado -->
                            <div class="control-group">
                                <label class="control-label" for="idEmpleado">Persona</label>
                                <div class="controls">
                                    <%--<input type="text" class="input-large" name="username" id="username">--%>
                                    <select id="idEmpleado" name="idEmpleado">
                                        <%
                                            for (Empleado empleado: pnManager.getEmpleadosFromParticipante(empleo.getParticipanteByIdParticipante().getIdParticipante())){
                                        %>
                                        <option value="<%=empleado.getIdEmpleado()%>">
                                            <%=empleado.getPersonaByIdPersona().getNombreCompleto()%>
                                            -
                                            <%=empleado.getPerfilByIdPerfil().getPerfil()%>
                                        </option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <!-- Item -->
                            <div class="control-group">
                                <label class="control-label" for="item">&Iacute;tem</label>
                                <div class="controls">
                                    <%--<input type="text" class="input-large" name="username" id="username">--%>
                                    <select id="idItem" name="item">
                                        <%
                                            String oldCapitulo = "";
                                            boolean cambia = false;
                                            for (PnSubCapitulo item: pnManager.getPnSubCapitulos()){
                                                if(!oldCapitulo.equals(item.getPnCapituloByIdCapitulo().getNombreCapitulo())){
                                                    oldCapitulo = item.getPnCapituloByIdCapitulo().getNombreCapitulo();
                                                    cambia = true;
                                                } else {
                                                    cambia = false;
                                                }
                                                if(cambia){
                                        %>
                                        <optgroup label="<%=oldCapitulo%>">
                                            <%
                                                }
                                            %>
                                            <option value="<%=item.getId()%>"><%=item.getSubCapitulo()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <!-- Text Docs -->
                            <div class="control-group">
                                <label class="control-label" for="documentos">Documentos</label>
                                <div class="controls">
                                    <textarea id="documentos" class="field span2" placeholder="Si desea solicitar documentos" rows="3" cols="5"></textarea>
                                </div>
                            </div>
                            <!-- Text Preguntas -->
                            <div class="control-group">
                                <label class="control-label" for="preguntas">Preguntas</label>
                                <div class="controls">
                                    <textarea id="preguntas" class="field span2" placeholder="Interrogantes a resolver en la visita" rows="3" cols="5"></textarea>
                                </div>
                            </div>
                            <!-- Buttons -->
                            <div class="form-actions">
                                <!-- Buttons -->
                                <%--<button type="button" class="btn">Consultar</button>--%>
                                <button id="b2" onclick="invitarEmpleado();" type="button" class="btn">Invitar</button>
                            </div>
                        </form>
                    </div>
                </div>
                <%
                    }
                %>
                <br>
                <br>
                <table cellpadding="0" cellspacing="0" border="0" class="display" id="invitados">
                    <thead>
                    <tr>
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
                            Persona persona = invitado.getEmpleadoByIdEmpleado().getPersonaByIdPersona();
                    %>
                    <tr>
                        <td>
                            <%=persona.getNombreCompleto()%> <br>
                            <%=persona.getEmailPersonal()%> <br>
                            <%=persona.getEmailCorporativo()%> <br>
                            <%=persona.getTelefonoFijo()%> <br>
                            <%=persona.getCelular()%> 
                        </td>
                        <td>
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
            </div>
            <div class="span4">
                <jsp:include page="c_empresa_admon.jsp"    />
            </div>
        </div>
    </div>
</agenda>



<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function saltaADespuesDeVisita(){
        disableId("b3");
//        alert("1");
        pnRemoto.saltaADespuesDeVisita(function(data){
//            alert("data = " + data);
            if(data == 1){
                alert("Cambio de Etapa Correcto");
            } else {
                alert("Problemas !");
            }
            enableId("b3");
        });
//        alert("2");
        var a = 9;
    }

    function definaFecha(){
        disableId("b1");

        var tmpFechaDesde = dwr.util.getValue("tmpFechaDesde");
        if(tmpFechaDesde == ''){
            alert("Por seleccione una fecha");
            enableId("b1");
        } else {
            pnRemoto.saveAgenda(tmpFechaDesde, function(data){
                if(data == 1){
//                    alert("Registro Correcto");
                    window.location = "agendaVisita.htm";
                } else {
                    alert("Problemas !");
                }
                enableId("b1");
            });
        }
    }

    function invitarEmpleado(){
        disableId("b2");
        var invitado = {
            idEmpleado : null,
            idItem : null,
            documentos : null,
            preguntas : null
        };

        dwr.util.getValues(invitado);

        pnRemoto.saveInvitadoEnPnAgenda(invitado, function(data){
            if(data == 1){
//                alert("Registro Correcto");
                window.location = "agendaVisita.htm";
            } else {
                alert("Problemas !");
            }
            enableId("b2");
        });
        

    }

    $('#tmpFechaDesde').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true
    });

    <%
        if(pnAgenda != null){ // SI HAY
    %>
        dwr.util.setValue("tmpFechaDesde", "<%=pnManager.df.format(new Date(pnAgenda.getFechaAgenda().getTime()))%>");

    $(document).ready(function() {
        $('#invitados').dataTable( {
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
                "sLengthMenu": 'Mostrar <select>'+
                               '<option value="5">5</option>'+
                               '<option value="10">10</option>'+
                               '<option value="20">20</option>'+
                               '<option value="30">30</option>'+
                               '<option value="40">40</option>'+
                               '<option value="50">50</option>'+
                               '<option value="-1">All</option>'+
                               '</select> registros'
            }
        } );
    } );

    <%
        }
    %>

</script>