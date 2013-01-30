<%@ page import="co.com.elramireza.pn.model.PnPremio" %>
<%@ page import="co.com.elramireza.pn.model.Empresa" %>
<%@ page import="co.com.elramireza.pn.model.Participante" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />


<div class="register">
    <div class="row">
        <div class="span10">
            <div class="formy">
                <h5>Participantes</h5>
                <div class="form">
                    <!-- Login form (not working)-->
                    <form class="form-horizontal">
                        <!-- Premios -->
                        <div class="control-group">
                            <label class="control-label" for="idPremio">Versiones de Premios</label>
                            <div class="controls">
                                <%--<input type="text" class="input-large" name="username" id="username">--%>
                                <select id="idPremio" name="idPremio">
                                    <%
                                        for (PnPremio premio: pnManager.getPnPremios()){
                                    %>
                                    <option value="<%=premio.getIdPnPremio()%>"><%=premio.getNombrePremio()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <!-- Empresas -->
                        <div class="control-group">
                            <label class="control-label" for="idEmpresa">Empresas</label>
                            <div class="controls">
                                <select id="idEmpresa" name="idEmpresa">
                                    <%
                                        for (Empresa empresa: pnManager.getEmpresaActivas()){
                                    %>
                                    <option value="<%=empresa.getIdEmpresa()%>"><%=empresa.getNombreEmpresa()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <!-- Buttons -->
                        <div class="form-actions">
                            <!-- Buttons -->
                            <button type="button" class="btn">Consultar</button>
                            <button onclick="vincule();" type="button" class="btn">Vincular</button>
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

<h3 class="color">Participantes seg&uacute;n Premio</h3>

<div class="row-fluid">
    <br>
    <table cellpadding="0" cellspacing="0" border="0" class="display" id="participantesT">
        <thead>
        <tr>
            <th>Premio</th>
            <th>Etapa</th>
            <th>Fecha</th>
            <th>Estado</th>
            <th>Desvincular</th>
        </tr>
        </thead>
        <%  //
            String imageActive;
            String messaActive;
            for (Participante participante : pnManager.getParticipantes()){
                if(participante.getEstado()){
                    imageActive = "img/positive.png";
                    messaActive = "Desactivar?";
                } else {
                    imageActive = "img/negative.png";
                    messaActive = "Activar?";
                }
                Empresa empresa = participante.getEmpresaByIdEmpresa();
                PnPremio premio = participante.getPnPremioByIdConvocatoria();
        %>
        <tr>
            <td>
                <%=empresa.getNombreEmpresa()%>
                <br>
                <%=premio.getNombrePremio()%>
            </td>
            <td>
                <%=participante.getPnEtapaParticipanteByIdEtapaParticipante().getEtapaParticipante()%>
            </td>
            <TD>
                <%=pnManager.dfDateTime.format(participante.getFechaIngreso())%>
            </td>
            <td><img id="imgActive<%=participante.getIdParticipante()%>" width="28" onclick="activaDesactiva(<%=participante.getIdParticipante()%>);" src="<%=imageActive%>" alt="<%=messaActive%>" title="<%=messaActive%>"></td>
            <td>
                <img width="28" onclick="desvincule(<%=participante.getIdParticipante()%>);" src="images/broken_link.jpg" alt="desvincula" title="desvincula">
            </td>
        </tr>
        <%
            }
        %>
    </table>
</div>


<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function desvincule(idParticipante){
        if (idParticipante == 1) {
            alert("No puedes hacer eso");
        } else {
            pnRemoto.desvincularParticipante(idParticipante, function(data) {
                if (data == '') {
                    alert("Desvinculado Completo");
                    window.location = "participantes.htm";
                } else {
                    alert("Problemas ! " + data);
                }
            });
        }
    }

    function vincule(){
        if (dwr.util.getValue("idEmpresa") == 1) {
            alert("No puedes hacer eso");
        } else {
            pnRemoto.vinculeParticipantePremio(
                    dwr.util.getValue("idPremio"),
                    dwr.util.getValue("idEmpresa"), function(data) {
                if (data != null) {
                    alert("Registro Completo");
                    window.location = "participantes.htm";
                } else {
                    alert("Problemas !");
                }
            });
        }
    }

    function activaDesactiva(id){
        $("#imgActive"+id).attr("src","images/loading.gif");
        pnRemoto.activeDesactiveParticipante(id, function(data){
            if(data!=null){
                if(data){
                    $("#imgActive"+id).attr("src","img/positive.png");
                    $("#imgActive"+id).attr("title", "Desactivar?");
                    $("#imgActive"+id).attr("alt",   "Desactivar?");
                } else {
                    $("#imgActive"+id).attr("src","img/negative.png");
                    $("#imgActive"+id).attr("title", "Activar?");
                    $("#imgActive"+id).attr("alt",   "Activar?");
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