<%@ page import="co.com.elramireza.pn.model.Texto" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    PnTipoPremio tipoPremio = (PnTipoPremio) session.getAttribute("tipoPremio");
    Texto texto = pnManager.getTexto(1);
    Texto textoRegistro = pnManager.getTexto(10);
%>


<premios>
<div class="register">
    <div class="row">
        <div class="span7">
            <div class="formy">
                <a name="formPremio"></a><h5>Premios</h5>
                <div class="1form">
                    <!-- Login form (not working)-->
                    <form id="formPremiof" class="form-inline">

                        <input id="idPnPremio" type="hidden" >

                        <div class="row">
                            <div class="span3">
                                <!-- name -->
                                <div class="control-group">
                                    <label class="control-label" for="nombrePremio">Nombre</label>
                                    <div class="controls">
                                        <input type="text" class="input-large required" name="nombrePremio" id="nombrePremio">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- version -->
                                <div class="control-group">
                                    <label class="control-label" for="version">Versi&oacute;n</label>
                                    <div class="controls">
                                        <input type="text" class="input-large required" name="version" id="version" maxlength="20">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">0 Premio Completo</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="fechaDesde">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="fechaDesde" id="fechaDesde">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="fechaHasta">Fecha Hasta</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="fechaHasta" id="fechaHasta">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">
                                        1	inscripci&oacute;n de evaluadores
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="inscripcionEvaluadoresDesde">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="inscripcionEvaluadoresDesde" id="inscripcionEvaluadoresDesde">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="inscripcionEvaluadoresHasta">Fecha Hasta</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="inscripcionEvaluadoresHasta" id="inscripcionEvaluadoresHasta">
                                    </div>
                                </div>
                            </div>
                        </div>



                        <div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">
                                        2	formaci&oacute;n de evaluadores
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="formacionEvaluadoresDesde">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="formacionEvaluadoresDesde" id="formacionEvaluadoresDesde">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="formacionEvaluadoresHasta">Fecha Hasta</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="formacionEvaluadoresHasta" id="formacionEvaluadoresHasta">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">
                                        3	invitaci&oacute;n a postulaci&oacute;n al premio
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="invitacionPostulacionDesde">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="invitacionPostulacionDesde" id="invitacionPostulacionDesde">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="invitacionPostulacionHasta">Fecha Hasta</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="invitacionPostulacionHasta" id="invitacionPostulacionHasta">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">
                                        4	inscripci&oacute;n de postulantes
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="inscripcionPostulantesDesde">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="inscripcionPostulantesDesde" id="inscripcionPostulantesDesde">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="inscripcionPostulantesHasta">Fecha Hasta</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="inscripcionPostulantesHasta" id="inscripcionPostulantesHasta">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">
                                        5	orientaci&oacute;n y acompa&ntilde;amiento a postulantes
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="orientacionPostulantesDesde">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="orientacionPostulantesDesde" id="orientacionPostulantesDesde">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="orientacionPostulantesHasta">Fecha Hasta</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="orientacionPostulantesHasta" id="orientacionPostulantesHasta">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">
                                        6	entrega de informes ejecutivos a la corporaci&oacute;n calidad
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="entregaInformesEjecutivosDesde">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="entregaInformesEjecutivosDesde" id="entregaInformesEjecutivosDesde">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="entregaInformesEjecutivosHasta">Fecha Hasta</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="entregaInformesEjecutivosHasta" id="entregaInformesEjecutivosHasta">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">
                                        7	evaluaci&oacute;n de las organizaciones postulantes
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="evaluacionOrganizacionesDesde">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="evaluacionOrganizacionesDesde" id="evaluacionOrganizacionesDesde">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="evaluacionOrganizacionesHasta">Fecha Hasta</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="evaluacionOrganizacionesHasta" id="evaluacionOrganizacionesHasta">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">
                                        8	visitas de campo
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="visitasCampoDesde">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="visitasCampoDesde" id="visitasCampoDesde">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="visitasCampoHasta">Fecha Hasta</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="visitasCampoHasta" id="visitasCampoHasta">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">
                                        9	sustentaci&oacute;n ante jurados
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="sustentacionJuradosDesde">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="sustentacionJuradosDesde" id="sustentacionJuradosDesde">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="sustentacionJuradosHasta">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="sustentacionJuradosHasta" id="sustentacionJuradosHasta">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">
                                        10	ceremonia de entrega del premio
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="ceremoniaEntregaPremio">Fecha</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="ceremoniaEntregaPremio" id="ceremoniaEntregaPremio">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">

                            </div>
                        </div>

                        <%--<div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">

                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                        </div>--%>

                        <%--<div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">

                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                        </div>--%>

                        <%--<div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">

                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                        </div>--%>

                        <%--<div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">

                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                        </div>--%>

                        <%--<div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">

                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                        </div>--%>

                        <%--<div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">

                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                        </div>--%>

                        <%--<div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">

                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                        </div>--%>

                        <%--<div class="row">
                            <div class="span1"></div>
                            <div class="span5">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label">

                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="span3">
                                <!-- fecha desde -->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                            <div class="span3">
                                <!-- fecha  hasta-->
                                <div class="control-group">
                                    <label class="control-label" for="">Fecha Desde</label>
                                    <div class="controls">
                                        <input type="text" readonly class="input-large required" name="" id="">
                                    </div>
                                </div>
                            </div>
                        </div>--%>



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

        <div class="span5">

            <%=tipoPremio.getDescripcion()%>
            <%--<h2><%=texto.getTexto1()%></h2>--%>
            <%--<p class="big grey">
                <%=texto.getTexto2()%>
            </p>
            <p style="text-align:justify;">
                <%=texto.getTexto3()%>
            </p>--%>

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
            <th>Sigla</th>
            <th>Nombre</th>
            <th>Versi&oacute;n</th>
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
            for (PnPremio premio : pnManager.getPnPremios(tipoPremio)){
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
            <td><%=premio.getTipoPremioById().getSigla()%></td>
            <td><%=premio.getNombrePremio()%></td>
            <td><%=premio.getVersion()%></td>
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
            pnRemoto.activeDesactivePremioN(id, <%=tipoPremio.getId()%>,function(data) {
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
//                alert("XXXX data.inscripcionEvaluadoresHasta = " + data.inscripcionEvaluadoresHasta);
//                alert("Guardado");
                data.fechaDesde=formatDate(data.fechaDesde,'dd-MM-yyyy');
                data.fechaHasta=formatDate(data.fechaHasta,'dd-MM-yyyy');

                data.inscripcionEvaluadoresDesde=formatDate(data.inscripcionEvaluadoresDesde,'dd-MM-yyyy');
                data.formacionEvaluadoresDesde=formatDate(data.formacionEvaluadoresDesde,'dd-MM-yyyy');
                data.invitacionPostulacionDesde=formatDate(data.invitacionPostulacionDesde,'dd-MM-yyyy');
                data.inscripcionPostulantesDesde=formatDate(data.inscripcionPostulantesDesde,'dd-MM-yyyy');
                data.orientacionPostulantesDesde=formatDate(data.orientacionPostulantesDesde,'dd-MM-yyyy');
                data.entregaInformesEjecutivosDesde=formatDate(data.entregaInformesEjecutivosDesde,'dd-MM-yyyy');
                data.evaluacionOrganizacionesDesde=formatDate(data.evaluacionOrganizacionesDesde,'dd-MM-yyyy');
                data.visitasCampoDesde=formatDate(data.visitasCampoDesde,'dd-MM-yyyy');
                data.sustentacionJuradosDesde=formatDate(data.sustentacionJuradosDesde,'dd-MM-yyyy');
                data.ceremoniaEntregaPremio=formatDate(data.ceremoniaEntregaPremio,'dd-MM-yyyy');
                data.inscripcionEvaluadoresHasta=formatDate(data.inscripcionEvaluadoresHasta,'dd-MM-yyyy');
                data.formacionEvaluadoresHasta=formatDate(data.formacionEvaluadoresHasta,'dd-MM-yyyy');
                data.invitacionPostulacionHasta=formatDate(data.invitacionPostulacionHasta,'dd-MM-yyyy');
                data.inscripcionPostulantesHasta=formatDate(data.inscripcionPostulantesHasta,'dd-MM-yyyy');
                data.orientacionPostulantesHasta=formatDate(data.orientacionPostulantesHasta,'dd-MM-yyyy');
                data.entregaInformesEjecutivosHasta=formatDate(data.entregaInformesEjecutivosHasta,'dd-MM-yyyy');
                data.evaluacionOrganizacionesHasta=formatDate(data.evaluacionOrganizacionesHasta,'dd-MM-yyyy');
                data.visitasCampoHasta=formatDate(data.visitasCampoHasta,'dd-MM-yyyy');
                data.sustentacionJuradosHasta=formatDate(data.sustentacionJuradosHasta,'dd-MM-yyyy');


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
            version : null,
//            tmpFechaDesde : null,
//            tmpFechaHasta : null,
            fechaDesde : null,
            fechaHasta : null,
            inscripcionEvaluadoresDesde : null,
            formacionEvaluadoresDesde : null,
            invitacionPostulacionDesde : null,
            inscripcionPostulantesDesde : null,
            orientacionPostulantesDesde : null,
            entregaInformesEjecutivosDesde : null,
            evaluacionOrganizacionesDesde : null,
            visitasCampoDesde : null,
            sustentacionJuradosDesde : null,
            ceremoniaEntregaPremio : null,
            inscripcionEvaluadoresHasta : null,
            formacionEvaluadoresHasta : null,
            invitacionPostulacionHasta : null,
            inscripcionPostulantesHasta : null,
            orientacionPostulantesHasta : null,
            entregaInformesEjecutivosHasta : null,
            evaluacionOrganizacionesHasta : null,
            visitasCampoHasta : null,
            sustentacionJuradosHasta : null,
            ceremoniaEntregaPremio : null
        };

        dwr.util.getValues(premio);

        premio.fechaDesde = getDateFromFormat(premio.fechaDesde, 'dd-MM-yyyy');
        premio.fechaHasta = getDateFromFormat(premio.fechaHasta, 'dd-MM-yyyy');

        premio.inscripcionEvaluadoresDesde = getDateFromFormat(premio.inscripcionEvaluadoresDesde, 'dd-MM-yyyy');
        premio.formacionEvaluadoresDesde = getDateFromFormat(premio.formacionEvaluadoresDesde, 'dd-MM-yyyy');
        premio.invitacionPostulacionDesde = getDateFromFormat(premio.invitacionPostulacionDesde, 'dd-MM-yyyy');
        premio.inscripcionPostulantesDesde = getDateFromFormat(premio.inscripcionPostulantesDesde, 'dd-MM-yyyy');
        premio.orientacionPostulantesDesde = getDateFromFormat(premio.orientacionPostulantesDesde, 'dd-MM-yyyy');
        premio.entregaInformesEjecutivosDesde = getDateFromFormat(premio.entregaInformesEjecutivosDesde, 'dd-MM-yyyy');
        premio.evaluacionOrganizacionesDesde = getDateFromFormat(premio.evaluacionOrganizacionesDesde, 'dd-MM-yyyy');
        premio.visitasCampoDesde = getDateFromFormat(premio.visitasCampoDesde, 'dd-MM-yyyy');
        premio.sustentacionJuradosDesde = getDateFromFormat(premio.sustentacionJuradosDesde, 'dd-MM-yyyy');
        premio.ceremoniaEntregaPremio = getDateFromFormat(premio.ceremoniaEntregaPremio, 'dd-MM-yyyy');
        premio.inscripcionEvaluadoresHasta = getDateFromFormat(premio.inscripcionEvaluadoresHasta, 'dd-MM-yyyy');
        premio.formacionEvaluadoresHasta = getDateFromFormat(premio.formacionEvaluadoresHasta, 'dd-MM-yyyy');
        premio.invitacionPostulacionHasta = getDateFromFormat(premio.invitacionPostulacionHasta, 'dd-MM-yyyy');
        premio.inscripcionPostulantesHasta = getDateFromFormat(premio.inscripcionPostulantesHasta, 'dd-MM-yyyy');
        premio.orientacionPostulantesHasta = getDateFromFormat(premio.orientacionPostulantesHasta, 'dd-MM-yyyy');
        premio.entregaInformesEjecutivosHasta = getDateFromFormat(premio.entregaInformesEjecutivosHasta, 'dd-MM-yyyy');
        premio.evaluacionOrganizacionesHasta = getDateFromFormat(premio.evaluacionOrganizacionesHasta, 'dd-MM-yyyy');
        premio.visitasCampoHasta = getDateFromFormat(premio.visitasCampoHasta, 'dd-MM-yyyy');
        premio.sustentacionJuradosHasta = getDateFromFormat(premio.sustentacionJuradosHasta, 'dd-MM-yyyy');

//        alert("premio.fechaDesde = " + premio.fechaDesde);
//        alert("premio.fechaHasta = " + premio.fechaHasta);

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

    $('#fechaDesde').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#fechaHasta').datepicker({format: 'dd-mm-yyyy',autoclose: true});

    $('#inscripcionEvaluadoresDesde').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#formacionEvaluadoresDesde').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#invitacionPostulacionDesde').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#inscripcionPostulantesDesde').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#orientacionPostulantesDesde').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#entregaInformesEjecutivosDesde').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#evaluacionOrganizacionesDesde').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#visitasCampoDesde').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#sustentacionJuradosDesde').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#ceremoniaEntregaPremio').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#inscripcionEvaluadoresHasta').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#formacionEvaluadoresHasta').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#invitacionPostulacionHasta').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#inscripcionPostulantesHasta').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#orientacionPostulantesHasta').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#entregaInformesEjecutivosHasta').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#evaluacionOrganizacionesHasta').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#visitasCampoHasta').datepicker({format: 'dd-mm-yyyy',autoclose: true});
    $('#sustentacionJuradosHasta').datepicker({format: 'dd-mm-yyyy',autoclose: true});


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