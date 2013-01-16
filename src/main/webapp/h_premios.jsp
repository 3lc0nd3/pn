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
    <table width="90%%" border="1">
        <thead>
        <tr>
            <th>Id</th>
            <th>Nombre</th>
            <th>Fecha Desde</th>
            <th>Fecha Hasta</th>
            <th>&nbsp;</th>
        </tr>
        </thead>
        <%
            SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
            for (PnPremio premio : pnManager.getPnPremios()){
                System.out.println("1");
        %>
        <tr>
            <td><%=premio.getIdPnPremio()%></td>
            <td><%=premio.getNombrePremio()%></td>
            <td><%=df.format(premio.getFechaDesde())%></td>
            <td><%=df.format(premio.getFechaHasta())%></td>
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

</script>