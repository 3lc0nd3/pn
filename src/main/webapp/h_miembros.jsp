<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.Persona" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="co.com.elramireza.pn.model.Texto" %>
<%@ page import="co.com.elramireza.pn.model.LocEstado" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    Texto texto = pnManager.getTexto(12);

    List<Persona> personas = pnManager.getHibernateTemplate().find(
            "from Persona "
    );

%>
<div class="register">
    <div class="row">
        <div class="span10">
            <div class="formy">
                <a name="datosDePersona"></a><h5>Datos de Persona</h5>
                <div class="form">
                    <!-- Login form (not working)-->
                    <form id="registroPersona" class="form-horizontal" autocomplete="off">
                        <!-- nombrePersona -->
                        <div class="control-group">
                            <label class="control-label" for="nombrePersona">Nombre</label>
                            <div class="controls">
                                <input type="hidden" id="idPersona" >
                                
                                <input type="text" class="input-large required" name="nombrePersona" id="nombrePersona">
                            </div>
                        </div>
                        <!-- apellido -->
                        <div class="control-group">
                            <label class="control-label" for="apellido">Apellido</label>
                            <div class="controls">
                                <input type="text" class="input-large required" name="apellido" id="apellido">
                            </div>
                        </div>
                        <!-- documentoIdentidad -->
                        <div class="control-group">
                            <label class="control-label" for="documentoIdentidad">Documento de Identidad</label>
                            <div class="controls">
                                <input type="text" class="input-large required" name="documentoIdentidad" id="documentoIdentidad">
                            </div>
                        </div>
                        <!-- emailPersonal -->
                        <div class="control-group">
                            <label class="control-label" for="emailPersonal">Email Personal</label>
                            <div class="controls">
                                <input type="text" class="input-large required email" name="emailPersonal" id="emailPersonal">
                            </div>
                        </div>
                        <!-- emailCorporativo -->
                        <div class="control-group">
                            <label class="control-label" for="emailCorporativo">Email Corporativo</label>
                            <div class="controls">
                                <input type="text" class="input-large email" name="emailCorporativo" id="emailCorporativo">
                            </div>
                        </div>
                        <!-- twitter -->
                        <div class="control-group">
                            <label class="control-label" for="twitter">Twitter</label>
                            <div class="controls">
                                <input type="text" class="input-large" name="twitter" id="twitter"  placeholder="@">
                            </div>
                        </div>
                        <!-- skype -->
                        <div class="control-group">
                            <label class="control-label" for="skype">Skype</label>
                            <div class="controls">
                                <input type="text" class="input-large" name="skype" id="skype">
                            </div>
                        </div>
                        <!-- telefonoFijo -->
                        <div class="control-group">
                            <label class="control-label" for="telefonoFijo">Telefono Fijo</label>
                            <div class="controls">
                                <input type="text" class="input-large" name="telefonoFijo" id="telefonoFijo">
                            </div>
                        </div>
                        <!-- celular -->
                        <div class="control-group">
                            <label class="control-label" for="celular">Celular</label>
                            <div class="controls">
                                <input type="text" class="input-large digits" name="celular" id="celular" maxlength="10">
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

                        <!-- Select box -->
                        <div class="control-group">
                            <label class="control-label" for="locCiudadPersona">Ciudad</label>
                            <div class="controls">
                                <select id="locCiudadPersona"  name="locCiudadPersona" ><%--***********--%>
                                    <option value="0">Seleccione...</option>
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
            <br>
            <div class="formy">
                <a name=""></a>
                <h5>
                    Cambio de Contrase&ntilde;a
                    <img width="30"  src="img/key.png">
                </h5>
                <div class="form">
                    <!-- Login form (not working)-->
                    <form id="cambioPass" class="form-horizontal" autocomplete="off">
                        <!-- clave -->
                        <div class="control-group">
                            <label class="control-label" for="clave">Contrase&ntilde;a</label>
                            <div class="controls">
                                <input type="password" maxlength="40" class="input-large required" id="clave">
                            </div>
                        </div>
                        <!-- clave2 -->
                        <div class="control-group">
                            <label class="control-label" for="clave">Repita</label>
                            <div class="controls">
                                <input type="password" maxlength="40" class="input-large required" id="clave2">
                            </div>
                        </div>
                        <!-- Buttons -->
                        <div class="form-actions">
                            <!-- Buttons -->
                            <button type="button" onclick="changeP();" class="btn">Modificar</button>
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
<div class="miembros">
    <table cellpadding="0" cellspacing="0" border="0" class="display" id="miembros">
        <thead>
        <tr>
            <th> Doc. </th>
            <th> Nombre </th>
            <th> Apellido </th>
            <th> Emails</th>
            <%--<th> Email Personal</th>--%>
            <th> Tel&eacute;fonos </th>
            <%--<th> Celular </th>--%>
            <th> Estado </th>
            <th width="28"> Editar </th>
        </tr>
        </thead>
        <%
            String imageActive;
            String messaActive;
            for (Persona persona: personas){
                if(persona.getEstado()){
                    imageActive = "img/positive.png";
                    messaActive = "Desactivar?";
                } else {
                    imageActive = "img/negative.png";
                    messaActive = "Activar?";
                }
        %>
        <tr>
            <td> <%=persona.getDocumentoIdentidad() %></td>
            <td> <%=persona.getNombrePersona() %></td>
            <td> <%=persona.getApellido() %></td>
            <td>
                <%=persona.getEmailPersonal()!=null?persona.getEmailPersonal():"" %>
                <br>
                <%=persona.getEmailCorporativo() %>
            </td>
            <td>
                <%=persona.getCelular()!=null?persona.getCelular():""%>
                <br>
                <%=persona.getTelefonoFijo() %>
            </td>
            <td><img id="imgActivePersona<%=persona.getIdPersona()%>" width="28" onclick="activaDesactiva(<%=persona.getIdPersona()%>);" src="<%=imageActive%>" alt="<%=messaActive%>" title="<%=messaActive%>"></td>
            <td>
                <img width="36" onclick="cargaPersona(<%=persona.getIdPersona()%>);" src="img/edit.png" alt="edita" title="edita">
            </td>
            <%--<td> <%=persona.getLocCiudadByIdCiudad().getNombreCiudad() %></td>--%>
        </tr>
        <%
            }
        %>
    </table>
</div>

<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

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

    function cargaPersona(id){
        pnRemoto.getPersona(id, function(data){
            dwr.util.setValues(data);
            dwr.util.setValue("departamento", data.locCiudadByIdCiudad.locEstadoByIdEstado.idEstado);
            dwr.engine.beginBatch();
            changeEstado();
            dwr.util.setValue("locCiudadPersona", data.locCiudadByIdCiudad.idCiudad);
            dwr.engine.endBatch();
            window.location = '#datosDePersona';
        });
    }

    function registarPersona(){
        var persona = {
            idPersona : null,
            nombrePersona : null,
            apellido : null,
            documentoIdentidad : null,
            emailPersonal : null,
            emailCorporativo : null,
            twitter : null,
            skype : null,
            telefonoFijo : null,
            celular : null,
            locCiudadPersona : null
        };
        dwr.util.getValues(persona);

        pnRemoto.savePersona(persona, function(data){
            if(data!= null){
                if(data == 1){
                    alert("Registro Correcto");
                    window.location = "miembros.htm";
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
        jQuery("#registroPersona").validate({
            rules: {
                locCiudadPersona:   "selectNoZero"
            }
        });
    });

    jQuery.validator.setDefaults({
        submitHandler: function() {
            registarPersona();
        }
    });

    function changeP(){
        var id = dwr.util.getValue("idPersona");
        var c1 = dwr.util.getValue("clave");
        var c2 = dwr.util.getValue("clave2");

        if(id==''){
            alert("Por favor seleccione una Persona primero");
        } else if(c1 == ''){
            alert("No puede ser vacio");
        } else if(c1 != c2){
            alert("Valores diferentes");
        } else {
            pnRemoto.cambiaP(id,c1, function(data){
                if(data==1){
                    alert("Cambio correcto");
                    dwr.util.setValue("clave", "");
                    dwr.util.setValue("clave2", "");
                } else {
                    alert("Problemas !");
                }
            });
        }

    }

    function changeEstado(){
        dwr.util.removeAllOptions("locCiudadPersona");
        var idEstado = dwr.util.getValue("departamento");
        pnRemoto.getLocCiudadesFromEstado(idEstado, function(data){
            dwr.util.addOptions("locCiudadPersona", data, "idCiudad", "nombreCiudad");
        });
    }

    $(document).ready(function() {
        $('#miembros').dataTable( {
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