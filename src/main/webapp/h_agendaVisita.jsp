<%@ page import="co.com.elramireza.pn.model.PnPremio" %>
<%@ page import="co.com.elramireza.pn.model.Empleado" %>
<%@ page import="co.com.elramireza.pn.model.PnSubCapitulo" %>
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
                                <button id="b1" onclick="definaFecha();" type="button" class="btn">Defina Fecha</button>
                            </div>
                        </form>
                    </div>
                </div>
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
            </div>
            <div class="span4">
                <jsp:include page="c_empresa_admon.jsp"    />
            </div>
        </div>
    </div>
</agenda>


<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function definaFecha(){

    }

    function invitarEmpleado(){

    }

    $('#tmpFechaDesde').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true
    });

</script>