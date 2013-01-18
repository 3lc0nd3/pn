<%@ page import="co.com.elramireza.pn.model.Texto" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    Texto texto = pnManager.getTexto(1);
    Texto textoRegistro = pnManager.getTexto(10);
    PnPremio premio = pnManager.getPnPremioActivo();
%>

<jsp:include page="c_slider01.jsp"/>

<!-- Hero Unit -->

<%--<div class="row">
    <div class="span12">
        <h2><%=texto.getTexto1()%></h2>
        <p>
            <%=texto.getTexto2()%>
        </p>
    </div>
</div>--%>

<!-- Hero Ends -->
<%--<div class="border"></div>--%>

<%--  LOGIN  --%>
<div class="register">
    <div class="row">
        <div class="span6">
            <div class="formy">
                <h5>Ingresa a tu cuenta</h5>
                <div class="form">
                    <!-- Login form (not working)-->
                    <form class="form-horizontal">
                        <!-- Username -->
                        <div class="control-group">
                            <label class="control-label" for="username">Usuario</label>
                            <div class="controls">
                                <input type="text" class="input-large" name="username" id="username">
                            </div>
                        </div>
                        <!-- Password -->
                        <div class="control-group">
                            <label class="control-label" for="password">Contrase&ntilde;a</label>
                            <div class="controls">
                                <input type="password" class="input-large" name="password" id="password">
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="controls">
                                <label class="checkbox">
                                    <input type="checkbox">
                                    Recuerdame
                                </label>
                            </div>
                        </div>
                        <!-- Buttons -->
                        <div class="form-actions">
                            <!-- Buttons -->
                            <button type="submit" class="btn">Ingreso</button>
                            <button type="reset" class="btn">Reset</button>
                        </div>
                    </form>
                    No tiene una cuenta? <a href="#registro">Reg&iacute;strese</a>
                </div>
            </div>

        </div>

        <div class="span6">
            <h2><%=texto.getTexto1()%></h2>
            <p class="big grey">
                <%=texto.getTexto2()%>
            </p>
            <p style="text-align:justify;">
                <%=texto.getTexto3()%>
            </p>

        </div>
    </div>
</div>

<%--  END LOGIN  --%>

<div class="border"></div>

<%--  REGISTER  --%>
<%
    if(premio!=null){ // SI HAY UN PnPREMIO ACTIVO
%>
<div class="register">
    <div class="row">
        <div class="span4">
            <h2>
                <%=textoRegistro.getTexto1()%>
            </h2>
            <p class="big grey">        
                <%=textoRegistro.getTexto2()%>
                a la versi&oacute;n <%=premio.getNombrePremio()%>
            </p>
            <p style="text-align:justify;">
                <%=textoRegistro.getTexto3()%>
            </p>

        </div>
        <div class="span8">
            <div class="formy">
                <div class="form">
                    <!-- Register form (not working)-->
                    <form id="registroP" class="form-horizontal" autocomplete="off">
                        <A name="registro"></A><h5>Datos generales organizaci&oacute;n postulante</h5>
                        <!-- nit -->
                        <div class="control-group">
                            <label class="control-label" for="nit">Nit</label>
                            <div class="controls">
                                <input type="text" class="input-large required" <%--max="36" min="23"--%> id="nit" name="nit">
                            </div>
                        </div>
                        <!-- nombre empresa-->
                        <div class="control-group">
                            <label class="control-label" for="nombreEmpresa">Nombre o Raz&oacute;n Social</label>
                            <div class="controls">
                                <input type="text" class="input-large required" id="nombreEmpresa" name="nombreEmpresa">
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
                            <label class="control-label" for="locCiudadEmpresa">Ciudad</label>
                            <div class="controls">
                                <select id="locCiudadEmpresa"  name="locCiudadEmpresa" ><%--***********--%>
                                    <option value="0">Seleccione...</option>
                                </select>
                            </div>
                        </div>

                        <!-- direccion empresa -->
                        <div class="control-group">
                            <label class="control-label required" for="direccionEmpresa">Direcci&oacute;n</label>
                            <div class="controls">
                                <input type="text" class="input-large required" id="direccionEmpresa" name="direccionEmpresa">
                            </div>
                        </div>

                        <!-- telFijoEmpresa -->
                        <div class="control-group">
                            <label class="control-label required" for="telFijoEmpresa">Tel&eacute;fono Fijo</label>
                            <div class="controls">
                                <input type="text" class="input-large required" id="telFijoEmpresa" name="telFijoEmpresa">
                            </div>
                        </div>

                        <!-- telMovilEmpresa -->
                        <div class="control-group">
                            <label class="control-label" for="telMovilEmpresa">Tel&eacute;fono M&oacute;vil</label>
                            <div class="controls">
                                <input type="text" class="input-large digits" id="telMovilEmpresa" name="telMovilEmpresa" maxlength="10">
                            </div>
                        </div>

                        <!-- Email -->
                        <div class="control-group">
                            <label class="control-label" for="emailEmpresa">Email</label>
                            <div class="controls">
                                <input type="text" class="input-large required email" id="emailEmpresa" name="emailEmpresa">
                            </div>
                        </div>

                        <!-- webEmpresa -->
                        <div class="control-group">
                            <label class="control-label" for="webEmpresa">P&aacute;gina Web</label>
                            <div class="controls">
                                <input type="text" class="input-large url" id="webEmpresa" name="webEmpresa" placeholder="http://">
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

                        <!-- productos -->
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
                                <select id="alcanceMercado"  name="alcanceMercado">
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

                        <!-- certificado const Empresa -->
                        <div class="control-group">
                            <label class="control-label" for="fileCertificadoConstitucionFile">Certificado Constituci&oacute;n Legal PDF</label>
                            <div class="controls">
                                <input type="file" class=" required" name="fileCertificadoConstitucionFile" id="fileCertificadoConstitucionFile">
                            </div>
                        </div>

                        <!-- fileEstadoFinanciero Empresa -->
                        <div class="control-group">
                            <label class="control-label" for="fileEstadoFinancieroFile">Estados Financieros (3 a&ntilde;os) PDF</label>
                            <div class="controls">
                                <input type="file" class=" required"  name="fileEstadoFinancieroFile" id="fileEstadoFinancieroFile">
                            </div>
                        </div>

                        <!-- fileConsignacion Empresa -->
                        <div class="control-group">
                            <label class="control-label" for="fileConsignacionFile">Recibo de Consignaci&oacute;n (50%) PDF</label>
                            <div class="controls">
                                <input type="file" class=" required"  name="fileConsignacionFile" id="fileConsignacionFile">
                            </div>
                        </div>

                        <h5>Datos del Primer Directivo</h5>

                        <!-- Documento de Identidad -->
                        <div class="control-group">
                            <label class="control-label" for="documentoDirectivo">Documento Identidad</label>
                            <div class="controls">
                                <input type="text" class="input-large required" id="documentoDirectivo" name="documentoDirectivo">
                            </div>
                        </div>

                        <!-- Nombre Directivo-->
                        <div class="control-group">
                            <label class="control-label" for="nombreDirectivo">Nombre</label>
                            <div class="controls">
                                <input type="text" class="input-large required" id="nombreDirectivo" name="nombreDirectivo">
                            </div>
                        </div>

                        <!-- Apellido Directivo-->
                        <div class="control-group">
                            <label class="control-label" for="apellidoDirectivo">Apellido</label>
                            <div class="controls">
                                <input type="text" class="input-large required" id="apellidoDirectivo" name="apellidoDirectivo">
                            </div>
                        </div>

                        <!-- TElefono Directivo-->
                        <div class="control-group">
                            <label class="control-label" for="telefonoDirectivo">Tel&eacute;fono Directo</label>
                            <div class="controls">
                                <input type="text" class="input-large required" id="telefonoDirectivo" name="telefonoDirectivo">
                            </div>
                        </div>

                        <!-- Email Directivo-->
                        <div class="control-group">
                            <label class="control-label" for="emailDirectivo">Email</label>
                            <div class="controls">
                                <input type="text" class="input-large required email" id="emailDirectivo" name="emailDirectivo">
                            </div>
                        </div>

                        <h5>Datos del Encargado del Proceso</h5>

                        <!-- Documento de Identidad Empleado -->
                        <div class="control-group">
                            <label class="control-label" for="documentoEmpleado">Documento Identidad</label>
                            <div class="controls">
                                <input type="text" class="input-large required" id="documentoEmpleado" name="documentoEmpleado">
                            </div>
                        </div>

                        <!-- Nombre Empleado-->
                        <div class="control-group">
                            <label class="control-label" for="nombreEmpleado">Nombre</label>
                            <div class="controls">
                                <input type="text" class="input-large required" id="nombreEmpleado" name="nombreEmpleado">
                            </div>
                        </div>

                        <!-- Apellido Empleado-->
                        <div class="control-group">
                            <label class="control-label" for="apellidoEmpleado">Apellido</label>
                            <div class="controls">
                                <input type="text" class="input-large required" id="apellidoEmpleado" name="apellidoEmpleado">
                            </div>
                        </div>

                        <!-- TElefono Empleado-->
                        <div class="control-group">
                            <label class="control-label" for="telefonoEmpleado">Tel&eacute;fono Directo</label>
                            <div class="controls">
                                <input type="text" class="input-large required" id="telefonoEmpleado" name="telefonoEmpleado">
                            </div>
                        </div>

                        <!-- Email Empleado-->
                        <div class="control-group">
                            <label class="control-label" for="emailCorpEmpleado">Email Corporativo</label>
                            <div class="controls">
                                <input type="text" class="input-large required email" id="emailCorpEmpleado" name="emailCorpEmpleado">
                            </div>
                        </div>

                        <!-- Email Personal Empleado-->
                        <div class="control-group">
                            <label class="control-label" for="emailPersonalEmpleado">Email Personal</label>
                            <div class="controls">
                                <input type="text" class="input-large required email" id="emailPersonalEmpleado" name="email-Personal-Empleado">
                            </div>
                        </div>

                        <!-- cargo Empleado  -->
                        <div class="control-group">
                            <label class="control-label" for="idCargoEmpleado">Cargo en la Empresa</label>
                            <div class="controls">
                                <select id="idCargoEmpleado" name="idCargoEmpleado" onchange="">
                                    <option value="0">Seleccione...</option>
                                    <%
                                        for (CargoEmpleado cargoEmpleado: pnManager.getCargoEmpleadosParticipante()){
                                    %>
                                    <option value="<%=cargoEmpleado.getId()%>"><%=cargoEmpleado.getCargo()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>


                        <!-- Username -->
                        <%--<div class="control-group">
                            <label class="control-label" for="username">Username</label>
                            <div class="controls">
                                <input type="text" class="input-large" id="username">
                            </div>
                        </div>--%>
                        <!-- Password -->
                        <%--<div class="control-group">
                            <label class="control-label" for="password">Password</label>
                            <div class="controls">
                                <input type="password" class="input-large" id="password">
                            </div>
                        </div>--%>
                        <!-- Checkbox -->
                        <div class="control-group">
                            <div class="controls">
                                <label class="checkbox inline">
                                    <input type="checkbox" id="inlineCheckbox1" name="inlineCheckbox1" class="required" value="agree">
                                    Acepto T&eacute;rminos y Condiciones
                                </label>
                            </div>
                        </div>



                        <!-- Buttons -->
                        <div class="form-actions">
                            <!-- Buttons -->
                            <%--<button type="button" class="btn" onclick="registraP();">Registrar</button>--%>
                            <input class="submit" type="submit" value="Registrar"/>
                            <%--<button type="reset" class="btn">Reset</button>--%>
                        </div>
                    </form>
                    <%--Already have an Account? <a href="login.html">Login</a>--%>
                </div> <%--  END DIV FORM  --%>
            </div><%--  END FORMY  --%>

        </div>
    </div>
</div>
<%
    }  /* END IF HAY UN PREMIO PN ACTIVO */
%>
<%--  END REGISTER  --%>

<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">
    function changeEstado(){
        dwr.util.removeAllOptions("locCiudadEmpresa");
        var idEstado = dwr.util.getValue("departamento");
        pnRemoto.getLocCiudadesFromEstado(idEstado, function(data){
            dwr.util.addOptions("locCiudadEmpresa", data, "idCiudad", "nombreCiudad");
        });
    }

    function revisaNit(){
        var nit = dwr.util.getValue("nit");
        pnRemoto.getEmpresaFromNit(nit, function(data){
            if(data!= null){
                dwr.util.setValues(data);
                dwr.util.setValue("departamento", data.locCiudadByIdCiudad.locEstadoByIdEstado.idEstado);
                dwr.util.setValue("locCiudadEmpresa", data.locCiudadByIdCiudad.idCiudad);
                dwr.util.setValue("idEmpresaCategoria",         data.empresaCategoriaByIdCategoriaEmpresa.id);
                dwr.util.setValue("idEmpresaCategoriaTamano",   data.empresaCategoriaTamanoByIdCategoriaTamanoEmpresa.id);
            }
        });
    }

    function registraP(){
//        alert("Si o no");
        var empresa = {
            nit : null,
            nombreEmpresa : null,
            locCiudadEmpresa : null,
            direccionEmpresa : null,
            telFijoEmpresa : null,
            telMovilEmpresa : null,
            emailEmpresa : null,
            webEmpresa : null,
            actividadPrincipal : null,
            productos : null,
            marcas : null,
            alcanceMercado : null,
            empleados : null,
            valorActivos : null,
            idEmpresaCategoria : null,
            idEmpresaCategoriaTamano : null,
            publicaEmpresa : null,
            fileCertificadoConstitucionFile : null,
            fileEstadoFinancieroFile : null,
            fileConsignacionFile : null
        };
        dwr.util.getValues(empresa);

//        alert("empresa.nombre = " + empresa.nombreEmpresa);

        var directivo = {
            documentoDirectivo : null,
            nombreDirectivo : null,
            apellidoDirectivo : null,
            telefonoDirectivo : null,
            emailDirectivo : null
        };
        dwr.util.getValues(directivo);

        var encargado = {
            documentoEmpleado : null,
            nombreEmpleado : null,
            apellidoEmpleado : null,
            telefonoEmpleado : null,
            emailCorpEmpleado : null,
            emailPersonalEmpleado : null,
            idCargoEmpleado : null
        };
        dwr.util.getValues(encargado);

        var personaDirectivo = {
            documentoIdentidad : directivo.documentoDirectivo,
            nombrePersona : directivo.nombreDirectivo,
            apellido : directivo.apellidoDirectivo,
            telefonoFijo : directivo.telefonoDirectivo,
            emailCorporativo : directivo.emailDirectivo
        };

        var personaEncargado = {
            documentoIdentidad : encargado.documentoEmpleado,
            nombrePersona : encargado.nombreEmpleado,
            apellido : encargado.apellidoEmpleado,
            telefonoFijo : encargado.telefonoEmpleado,
            emailCorporativo : encargado.emailCorpEmpleado,
            emailPersonal : encargado.emailPersonalEmpleado,
            idCargoEmpleado : encargado.idCargoEmpleado
        };

        pnRemoto.saveInscrito(empresa, personaDirectivo, personaEncargado,
                function(data){
                    if(data == 1){
                        var formCS = dwr.util.byId("registroP");
                        formCS.reset();
                        alert("Gracias por su registro");
                    }
                });

//        alert("personaDirectivo.documentoIdentidad = " + personaDirectivo.documentoIdentidad);
    }

    jQuery.validator.addMethod("fieldDiff", function(value, element, arg){
        return arg != value;
    }, jQuery.validator.messages.required);

    jQuery.validator.addMethod("selectNoZero", function(value, element, arg){
        return "0" != value;
    }, jQuery.validator.messages.required);

    jQuery.validator.addMethod("money", function (value, element) {
        return this.optional(element) || /^((\d{1,5})+\.\d{2})?$|^\$?[\.]([\d][\d]?)$/.test(value);
    }, 'Moneda' );

    jQuery(document).ready(function() {
        jQuery("#registroP").validate({
            rules: {
                locCiudadEmpresa:   "selectNoZero",
                alcanceMercado:     "selectNoZero",
                idEmpresaCategoria: "selectNoZero",
                idEmpresaCategoriaTamano: "selectNoZero",
                publicaEmpresa: "selectNoZero",
                idCargoEmpleado: "selectNoZero"/*,
                valorActivos: "money"*/
            }
        });
    });



    jQuery.validator.setDefaults({
        submitHandler: function() {
            registraP();
        }
    });
</script>