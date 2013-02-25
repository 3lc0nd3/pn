<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    Texto texto = pnManager.getTexto(13);

    List<Empresa> empresas = pnManager.getHibernateTemplate().find(
            "from Empresa where id > 1 "
    );

%>
<div class="register">
    <div class="row">
        <div class="span10">
            <div class="formy">
                <a name="datosDeEmpresa"></a><h5>Datos de Empresa</h5>
                <div class="form">
                    <!-- Login form (not working)-->
                    <form id="registroEmpresa" class="form-horizontal" autocomplete="off">
                        <!-- nombrePersona -->
                        <div class="control-group">
                            <label class="control-label" for="nit">Nit</label>
                            <div class="controls">
                                <input type="text" class="input-large required" name="nit" id="nit">
                            </div>
                        </div>
                        <!-- nombrePersona -->                   
                        <div class="control-group">
                            <label class="control-label" for="nombreEmpresa">Nombre</label>
                            <div class="controls">
                                <input type="hidden" id="idEmpresa" >

                                <input type="text" class="input-large required" name="nombreEmpresa" id="nombreEmpresa">
                            </div>
                        </div>
                        <!-- departamento -->
                        <div class="control-group">
                            <label class="control-label" for="departamento">Departamento</label>
                            <div class="controls">
                                <select id="departamento" onchange="changeEstado();">
                                    <%
                                        for (LocEstado estado: pnManager.getLocEstados()){
                                    %>
                                    <option value="<%=estado.getIdEstado()%>"><%=estado.getNombreEstado()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <!-- ciudad -->
                        <div class="control-group">
                            <label class="control-label" for="locCiudadEmpresa">Ciudad</label>
                            <div class="controls">
                                <select id="locCiudadEmpresa"  name="locCiudadEmpresa" >
                                    <option value="0">Seleccione...</option>
                                </select>
                            </div>
                        </div>
                        <!-- apellido -->
                        <div class="control-group">
                            <label class="control-label" for="direccionEmpresa">Direcci&oacute;n</label>
                            <div class="controls">
                                <input type="text" class="input-large required" name="direccionEmpresa" id="direccionEmpresa">
                            </div>
                        </div>
                        <!-- tel fijo -->
                        <div class="control-group">
                            <label class="control-label" for="telFijoEmpresa">Tel&eacute;fono Fijo</label>
                            <div class="controls">
                                <input type="text" class="input-large required" name="telFijoEmpresa" id="telFijoEmpresa"> 
                            </div>
                        </div>
                        <!-- celular -->
                        <div class="control-group">
                            <label class="control-label" for="telMovilEmpresa">Tel&eacute;fono Celular</label>
                            <div class="controls">
                                <input type="text" class="input-large digits" name="telMovilEmpresa" maxlength="10" min="3000000000" id="telMovilEmpresa">
                            </div>
                        </div>
                        <!-- webEmpresa -->
                        <div class="control-group">
                            <label class="control-label" for="webEmpresa">P&aacute;gina Web</label>
                            <div class="controls">
                                <input type="text" class="input-large url" id="webEmpresa" name="webEmpresa" placeholder="http://">
                            </div>
                        </div>
                        <!-- emailCorporativo -->
                        <div class="control-group">
                            <label class="control-label" for="emailEmpresa">Email</label>
                            <div class="controls">
                                <input type="text" class="input-large email" name="emailEmpresa" id="emailEmpresa">
                            </div>
                        </div>
                        <!-- actividadPrincipal -->
                        <div class="control-group">
                            <label class="control-label" for="actividadPrincipal">Actividad Principal</label>
                            <div class="controls">
                                <!--<input type="text" class="input-large required" id="actividadPrincipal" name="actividadPrincipal">-->
                                <textarea  class="input-large required" id="actividadPrincipal" name="actividadPrincipal"></textarea>
                            </div>
                        </div>
                        <!-- productos -->
                        <div class="control-group">
                            <label class="control-label" for="productos">Productos</label>
                            <div class="controls">
                                <!--<input type="text" class="input-large required" id="productos" name="productos"> -->
                                <textarea  class="input-large required" id="productos" name="productos"></textarea>
                            </div>
                        </div>
                        <!-- marcas -->
                        <div class="control-group">
                            <label class="control-label" for="marcas">Marcas</label>
                            <div class="controls">
                                <!--<input type="text" class="input-large required" id="marcas" name="marcas">-->
                                <textarea  class="input-large required" id="marcas" name="marcas"></textarea>
                            </div>
                        </div>
                        <!-- alcanceMercado -->
                        <div class="control-group">
                            <label class="control-label" for="alcanceMercado">Alcance del Mercado</label>
                            <div class="controls">
                                <select id="alcanceMercado"  name="alcanceMercado" >
                                    <option value="0">Seleccione...</option>
                                    <option value="1">Nacional</option>
                                    <option value="2">Internacional</option>
                                </select>
                            </div>
                        </div>

                        <!-- empleados -->
                        <div class="control-group">
                            <label class="control-label" for="empleados">N&uacute;mero de Empleados</label>
                            <div class="controls">
                                <input type="text" class="input-large required digits" id="empleados" name="empleados">
                            </div>
                        </div>

                        <!-- valorActivos -->
                        <div class="control-group">
                            <label class="control-label" for="valorActivos">Valor de Activos</label>
                            <div class="controls">
                                <input type="text" class="input-large required currency" id="valorActivos" name="valorActivos">
                            </div>
                        </div>

                        <!-- idEmpresaCategoria  -->
                        <div class="control-group">
                            <label class="control-label" for="idEmpresaCategoria">Categor&iacute;a</label>
                            <div class="controls">
                                <select id="idEmpresaCategoria" name="idEmpresaCategoria" onchange="">
                                    <option value="0">Seleccione...</option>
                                    <%
                                        for (EmpresaCategoria categoria: pnManager.getEmpresaCategorias()){
                                    %>
                                    <option value="<%=categoria.getId()%>"><%=categoria.getCategoria()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>

                        <!-- idEmpresaCategoriaTamano  -->
                        <div class="control-group">
                            <label class="control-label" for="idEmpresaCategoriaTamano">Tama&ntilde;o de la Empresa</label>
                            <div class="controls">
                                <select id="idEmpresaCategoriaTamano"  name="idEmpresaCategoriaTamano"  onchange="">
                                    <option value="0">Seleccione...</option>
                                    <%
                                        for (EmpresaCategoriaTamano tamano: pnManager.getEmpresaCategoriaTamanos()){
                                    %>
                                    <option value="<%=tamano.getId()%>"><%=tamano.getTamano()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>

                        <!-- publicaEmpresa -->
                        <div class="control-group">
                            <label class="control-label" for="publicaEmpresa">Es Empresa P&uacute;blica</label>
                            <div class="controls">
                                <select id="publicaEmpresa" name="publicaEmpresa" onchange="changeEstado();">
                                    <option value="0">Seleccione...</option>
                                    <option value="1">Si</option>
                                    <option value="2">No</option>
                                </select>
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

        <div class="span2">
            <h2><%=texto.getTexto1()%></h2>
            <p class="big grey">
                <%=texto.getTexto2()%>
            </p>
            <p style="text-align:justify;">
                <%=texto.getTexto3()%>
            </p>

        </div>
    </div>
</div> <%-- END MIEMBRO FORM --%>
<div class="border"></div>

<div class="row">

<div class="miembros">
    <table cellpadding="0" cellspacing="0" border="0" class="display" id="empresas" style="width:100%;">
        <thead>
        <tr>
            <th> Nit </th>
            <th> Nombre </th>
            <th> Direcci&oacute;n </th>
            <th> Categor&iacute;a </th>
            <%--<th> Tama&ntilde;o</th>--%>
            <%--<th> Email Personal</th>--%>
            <th> Tel&eacute;fonos </th>
            <th> Email </th>
            <th> Ciudad </th>
            <th width="28"> &nbsp;&nbsp;&nbsp;<%--&nbsp;&nbsp;&nbsp;--%> </th>
            <th width="28"> &nbsp;&nbsp;&nbsp;<%--&nbsp;&nbsp;&nbsp;--%> </th>
            <th width="28"> &nbsp;&nbsp;&nbsp;<%--&nbsp;&nbsp;&nbsp;--%> </th>
        </tr>
        </thead>
        <%
            String imageActive;
            String messaActive;
            for (Empresa empresa: empresas){
                if(empresa.getEstado()){
                    imageActive = "img/positive.png";
                    messaActive = "Desactivar?";
                } else {
                    imageActive = "img/negative.png";
                    messaActive = "Activar?";
                }
        %>
        <tr>
            <td> <%=empresa.getNit() %></td>
            <td> <%=empresa.getNombreEmpresa() %></td>
            <td> <%=empresa.getDireccionEmpresa() %></td>
            <td> <%=empresa.getEmpresaCategoriaByIdCategoriaEmpresa().getCategoria() %></td>
            <%--<td> <%=empresa.getEmpresaCategoriaTamanoByIdCategoriaTamanoEmpresa().getTamano() %></td>--%>
            <td>
                <%=empresa.getTelFijoEmpresa() %>
                <br>
                <%=empresa.getTelMovilEmpresa() %>
            </td>
            <td> <%=empresa.getEmailEmpresa() %></td>
            <td> <%=empresa.getLocCiudadByIdCiudad().getNombreCiudad() %></td>
            <td><img id="imgActiveEmpresa<%=empresa.getIdEmpresa()%>" width="28" onclick="activaDesactiva(<%=empresa.getIdEmpresa()%>);" src="<%=imageActive%>" alt="<%=messaActive%>" title="<%=messaActive%>"></td>
            <td><img width="32" onclick="revisaEmpresa(<%=empresa.getIdEmpresa()%>);" src="img/view.png" alt="ver" title="ver"></td>
            <td>
                <img width="32" onclick="cargaEmpresa(<%=empresa.getIdEmpresa()%>);" src="img/edit.png" alt="edita" title="edita">
            </td>
        </tr>
        <%
            }
        %>
    </table>
</div>
<br>
<br>
    <div class="border"></div>

    <div id="labelDetalle">
        <a name="detalleEmpresa"></a>
        <h3 class="color">Detalle de la Empresa</h3>
    </div>
<div id="empresaDiv"></div>

</div>

<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">
    function registarEmpresa(){
        var empresa = {
            idEmpresa : null,
            nombreEmpresa : null,
            locCiudadEmpresa : null,
            nit : null,
            direccionEmpresa : null,
            telFijoEmpresa : null,
            telMovilEmpresa : null,
            webEmpresa : null,
            emailEmpresa : null,
            actividadPrincipal : null,
            productos : null,
            marcas : null,
            alcanceMercado : null,
            empleados : null,
            valorActivos : null,
            idEmpresaCategoria : null,
            idEmpresaCategoriaTamano : null,
            publicaEmpresa : null
        };
        dwr.util.getValues(empresa);

        pnRemoto.saveEmpresaR(empresa, function(data){
            if(data!= null){
                if(data == 1){
                    alert("Registro Correcto");
                    window.location = "empresas.htm";
                }
            }
        });
    }

    jQuery.validator.addMethod("fieldDiff", function(value, element, arg){
        return arg != value;
    }, jQuery.validator.messages.required);

    jQuery.validator.addMethod("selectNoZero", function(value, element, arg){
        return "0" != value;
    }, jQuery.validator.messages.required);

    jQuery(document).ready(function() {
        jQuery("#labelDetalle").hide();

        jQuery("#registroEmpresa").validate({
            rules: {
                locCiudadPersona:   "selectNoZero",
                alcanceMercado:     "selectNoZero",
                idEmpresaCategoria: "selectNoZero",
                idEmpresaCategoriaTamano: "selectNoZero",
                publicaEmpresa: "selectNoZero"
            }
        });
    });

    jQuery.validator.setDefaults({
        submitHandler: function() {
            registarEmpresa();
        }
    });

    function cargaEmpresa(id){
        pnRemoto.getEmpresa(id, function(data){
            dwr.util.setValues(data);
            dwr.util.setValue("departamento", data.locCiudadByIdCiudad.locEstadoByIdEstado.idEstado);
            dwr.engine.beginBatch();
            changeEstado();
            dwr.util.setValue("locCiudadEmpresa", data.locCiudadByIdCiudad.idCiudad);
            dwr.util.setValue("idEmpresaCategoria",         data.empresaCategoriaByIdCategoriaEmpresa.id);
            dwr.util.setValue("idEmpresaCategoriaTamano",   data.empresaCategoriaTamanoByIdCategoriaTamanoEmpresa.id);
            dwr.engine.endBatch();
            window.location = '#datosDeEmpresa';
        });
    }

    function changeEstado(){
        dwr.util.removeAllOptions("locCiudadEmpresa");
        var idEstado = dwr.util.getValue("departamento");
        pnRemoto.getLocCiudadesFromEstado(idEstado, function(data){
            dwr.util.addOptions("locCiudadEmpresa", data, "idCiudad", "nombreCiudad");
        });
    }

    function revisaEmpresa(id){
        frontController.getIncludeEmpresaAdmon(id, function(data){
            jQuery("#labelDetalle").show();
            dwr.util.setValue("empresaDiv", data, { escapeHtml:false });
            window.location = '#detalleEmpresa';
        });
    }

    function activaDesactiva(id){
        $("#imgActiveEmpresa"+id).attr("src","images/loading.gif");
        pnRemoto.activeDesactiveEmpresa(id, function(data){
            if(data!=null){
                if(data){
                    $("#imgActiveEmpresa"+id).attr("src","img/positive.png");
                    $("#imgActiveEmpresa"+id).attr("title", "Desactivar?");
                    $("#imgActiveEmpresa"+id).attr("alt",   "Desactivar?");
                } else {
                    $("#imgActiveEmpresa"+id).attr("src","img/negative.png");
                    $("#imgActiveEmpresa"+id).attr("title", "Activar?");
                    $("#imgActiveEmpresa"+id).attr("alt",   "Activar?");
                }
            } else {
                alert("Problemas !");
            }
        });
    }

    $(document).ready(function() {
        $('#empresas').dataTable( {
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