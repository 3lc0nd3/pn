<%@ page import="java.util.Date" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Participante participanteByIdParticipante = empleo.getParticipanteByIdParticipante();
    Texto texto22 = pnManager.getTexto(22);
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

                        if (participanteByIdParticipante.getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante() != 3) {
                    %>
                    <div class="alert">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                        <%=texto22.getTexto1()%>
                        <img src="img/stop.png" width="50">
                    </div>
                    <%
                        }
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
                        <%
                            if (empleo.getParticipanteByIdParticipante().getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante()>3) {
                        %>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        Datos Finales
                        <img width="100" src="images/flag.png" alt="Final" title="Final">
                        <%
                            }
                        %>
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
//                    System.out.println("pnAgenda 8888888888888= " + pnAgenda);
//                    System.out.println("empleo.getParticipanteByIdParticipante().getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante() = " + empleo.getParticipanteByIdParticipante().getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante());
                    if(pnAgenda != null &&
                            empleo.getParticipanteByIdParticipante().getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante()==3
                            ){ // SOLO SI HAY
//                        System.out.println("999999977777777777777777777777");
                %>
                <br>
                <div class="formy">
                    <h5>Invitar Personas a Visita</h5>
                    <div class="form">
                        <!-- -->
                        <form class="form-horizontal">

                            <!-- Hora -->
                            <%--<div class="control-group">
                                <label class="control-label" for="idEmpleado">Hora</label>
                                <div class="controls">
                                    &lt;%&ndash;<input type="text" class="input-large" name="username" id="username">&ndash;%&gt;
                                    <select id="hora" name="hora">
                                        <%
                                        for (int i=6; i<=20; i++) {
                                        
                                    %>
                                        <option value="<%=i%>"><%=i>12?i-12:i%>:00 <%=i<12?"A.M.":"P.M."%></option>
                                    <%
                                        }
                                    %>
                                    </select>
                                </div>
                            </div>
                            --%>
                            <input type="hidden" id="hora" name="hora" value="9">
                            <!-- Empleado -->
                            <div class="control-group">
                                <label class="control-label" for="idEmpleado">Persona o Cargo</label>
                                <div class="controls">
                                    <%--<input type="text" class="input-large" name="username" id="username">--%>
                                    <input type="text" id="idEmpleado" name="idEmpleado" >
                                </div>
                            </div>
                            <!-- Item -->
                            <div class="control-group">
                                <label class="control-label" for="item">&Iacute;tem</label>
                                <div class="controls">
                                    <%--<input type="text" class="input-large" name="username" id="username">--%>
                                    <select id="idItem" class="input-large" name="item">
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
                                            <option value="<%=item.getId()%>">
                                                <%=item.getCodigoItem()%>
                                                <%=item.getSubCapitulo()%>
                                            </option>
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
                                    <textarea id="documentos" class="field span2" placeholder="Documentos de verificaci&oacute;n requeridos durante la visita" rows="3" cols="5"></textarea>
                                </div>
                            </div>
                            <!-- Text Preguntas -->
                            <div class="control-group">
                                <label class="control-label" for="preguntas">Preguntas</label>
                                <div class="controls">
                                    <textarea id="preguntas" class="field span2" placeholder="Inquietud, interrogante, duda a resolver durante la visita" rows="3" cols="5"></textarea>
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
                        <th>idHora</th>
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
                        <%--<td><%=invitado.getHora()%></td>--%>
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
                window.location = "evalItemsDespuesVisita.htm";
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
            hora : null,
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
        var miTabla = $('#invitados').dataTable( {
//            "aaSorting": [[ 1, "asc" ]],
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

        miTabla.fnSetColumnVis(0, false) ;

    } );

    <%
        }
    %>

</script>