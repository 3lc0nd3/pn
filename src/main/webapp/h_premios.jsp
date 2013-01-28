<%@ page import="co.com.elramireza.pn.model.Texto" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    Texto texto = pnManager.getTexto(1);
    Texto textoRegistro = pnManager.getTexto(10);
%>


<premios>
<div class="register">
    <div class="row">
        <div class="span6">
            <div class="formy">
                <a name="formPremio"></a><h5>Premios</h5>
                <div class="form">
                    <!-- Login form (not working)-->
                    <form id="formPremiof" class="form-inline">

                        <input id="idPnPremio" type="hidden" > 

                        <!-- Username -->
                        <div class="control-group">
                            <label class="control-label" for="nombrePremio">Nombre</label>
                            <div class="controls">
                                <input type="text" class="input-large required" name="nombrePremio" id="nombrePremio">
                            </div>
                        </div>
                        <!-- fecha desde -->
                        <div class="control-group">
                            <label class="control-label" for="tmpFechaDesde">Fecha Desde</label>
                            <div class="controls">
                                <input type="text" readonly class="input-large required" name="tmpFechaDesde" id="tmpFechaDesde">
                            </div>
                        </div>
                        <!-- fecha  hasta-->
                        <div class="control-group">
                            <label class="control-label" for="tmpFechaHasta">Fecha Desde</label>
                            <div class="controls">
                                <input type="text" readonly class="input-large required" name="tmpFechaHasta" id="tmpFechaHasta">
                            </div>
                        </div>
                        <!-- Buttons -->
                        <div class="form-actions">
                            <!-- Buttons -->
                            <button type="submit" class="btn">Crear</button>
                            <button type="submit" class="btn">Modificar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="span6">
            <%--<h2><%=texto.getTexto1()%></h2>--%>
            <p class="big grey">
                <%=texto.getTexto2()%>
            </p>
            <p style="text-align:justify;">
                <%=texto.getTexto3()%>
            </p>

        </div>
    </div>
</div>
</premios>

<div class="row-fluid">
    <br>
    <table cellpadding="0" cellspacing="0" border="0" class="display" id="premiosT">
        <thead>
        <tr>
            <th>Id</th>
            <th>Nombre</th>
            <th>Fecha Desde</th>
            <th>Fecha Hasta</th>
            <th>Estado Inscripci&oacute;n</th>
            <th>Editar</th>
        </tr>
        </thead>
        <%
            String imageActive;
            String messaActive;
            SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
            for (PnPremio premio : pnManager.getPnPremios()){
                if(premio.getEstadoInscripcion()){
                    imageActive = "img/positive.png";
                    messaActive = "Desactivar?";
                } else {
                    imageActive = "img/negative.png";
                    messaActive = "Activar?";
                }
        %>
        <tr>
            <td><%=premio.getIdPnPremio()%></td>
            <td><%=premio.getNombrePremio()%></td>
            <td><%=df.format(premio.getFechaDesde())%></td>
            <td><%=df.format(premio.getFechaHasta())%></td>
            <td><img id="imgActiveInscripcion<%=premio.getIdPnPremio()%>" width="28" onclick="activaDesactiva(<%=premio.getIdPnPremio()%>);" src="<%=imageActive%>" alt="<%=messaActive%>" title="<%=messaActive%>"></td>
            <td>
                <img width="36" onclick="editaPremio(<%=premio.getIdPnPremio()%>);" src="img/edit.png" alt="edita" title="edita">
            </td>
        </tr>
        <%
            }
        %>
    </table>
</div>


<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function activaDesactiva(id){
        if (id == 1) {
            alert("Para uso interno, no lo puedes activar.");
        } else {
            $("#imgActiveInscripcion" + id).attr("src", "images/loading.gif");
            pnRemoto.activeDesactivePremioN(id, function(data) {
                if (data == 3) {
                    alert("Problemas !");
                } else if (data == 2) {
                    alert("No puede haber mas de un Premio Activo");
                    $("#imgActiveInscripcion" + id).attr("src", "img/negative.png");
                    $("#imgActiveInscripcion" + id).attr("title", "Activar?");
                    $("#imgActiveInscripcion" + id).attr("alt", "Activar?");
                } else {
                    if (data == 1) {
                        $("#imgActiveInscripcion" + id).attr("src", "img/positive.png");
                        $("#imgActiveInscripcion" + id).attr("title", "Desactivar?");
                        $("#imgActiveInscripcion" + id).attr("alt", "Desactivar?");
                    } else {
                        $("#imgActiveInscripcion" + id).attr("src", "img/negative.png");
                        $("#imgActiveInscripcion" + id).attr("title", "Activar?");
                        $("#imgActiveInscripcion" + id).attr("alt", "Activar?");
                    }
                }
            });
        }
    }

    function editaPremio(id){
        pnRemoto.getPnPremio(id, function(data){
            if(data!=null){
//                alert("Guardado");
                dwr.util.setValues(data);
                window.location = '#formPremio';
            } else {
//                alert("Problema!");
            }
        });
        
    }

    function resetFormPremio(){
        dwr.util.byId('formPremiof').reset();
        dwr.util.setValue('idPnPremio', 0);
    }

    function guardaPremio(){
        var premio = {
            idPnPremio : null,
            nombrePremio : null,
            tmpFechaDesde : null,
            tmpFechaHasta : null
        };

        dwr.util.getValues(premio);
//        alert("premio.idPnPremio = " + premio.idPnPremio);

        pnRemoto.savePnPremio(premio, function(data){
            if(data==1){
                alert('Guardado');
                window.location = "premios.htm";
            } else {
                alert('Problemas!');
            }
        });

    }

    $('#tmpFechaDesde').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true
    });
    $('#tmpFechaHasta').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true
    }).on('changeDate', function(ev){
    });

    jQuery(document).ready(function() {
        jQuery("#formPremiof").validate();
    });



    jQuery.validator.setDefaults({
        submitHandler: function() {
            guardaPremio();
        }
    });

    $(document).ready(function() {
        $('#premiosT').dataTable( {
            "aaSorting": [[ 1, "asc" ]],
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
</script>