<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Texto texto16 = pnManager.getTexto(16);
    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Empresa empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();

    List<PnCategoriaCriterio> categoriasCriterio = pnManager.getCategoriasCriterio();

%>

<individual>
    <div class="container">
        <div class="row">
            <div class="span8">
                <h2><%=texto16.getTexto1()%></h2>
                para <strong><%=empresa.getNombreEmpresa()%></strong>
                <br>
                <br>
                <%
                    List<PnValoracion> fromParticipante = pnManager.getValoracionIndividualGlobalFromEmpleado(
                            empleo.getIdEmpleado());

                    PnCualitativa cualitativa = pnManager.getPnCualitativaFromEmpleadoTipoFormato(
                            empleo.getIdEmpleado(), 1 // FORMATO 1 INDIVIDUAL
                    );
                    if(fromParticipante.size()==0){
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
                    Datos ingresados el <%=pnManager.dfDateTime.format(cualitativa.getFechaCreacion())%>
                </div>
                <%
                    }
                %>
                <br>
                <table border="1" width="70%">
                    <tr><th class="alert-info">Fortalezas</th></tr>
                    <tr><td>
                        <textarea id="fortalezas" class="field span6" placeholder="Lo que lo ayudar&aacute; en crisis" rows="4" cols="10"></textarea>
                    </td></tr>
                    <tr><th class="alert-info">Oportunidades de Mejora</th></tr>
                    <tr><td>
                        <textarea id="oportunidades" class="field span6" placeholder="Tips de mejora" rows="4" cols="10"></textarea>
                    </td></tr>
                    <tr><th class="alert-info">Pendientes Vista de Campo</th></tr>
                    <tr><td>
                        <textarea id="pendientesVisita" class="field span6" placeholder="Puntos para tener en cuenta" rows="4" cols="10"></textarea>
                    </td></tr>
                </table>
                <br>
                <table border="1">
                    <%
                        for (PnCategoriaCriterio categoriaCriterio:  categoriasCriterio){
                    %>
                    <tr>
                        <th colspan="2" class="btn-inverse"><%=categoriaCriterio.getCategoriaCriterio()%></th>
                    </tr>
                    <%
                            for (PnCriterio criterio: pnManager.getPnCriteriosFromCategoria(categoriaCriterio.getId())){
                    %>
                    <tr>
                        <td class=" btn-primary"><%=criterio.getCriterio()%></td>
                        <td>
                            <select name="<%=criterio.getId()%>" id="<%=criterio.getId()%>" class="btn-primary selEval">
                            <%
                                for (Integer v: pnManager.getValoresValoracion()){
                            %>
                                <option class=" btn-primary" value="<%=v%>"><%=v%></option>
                            <%
                                }
                            %>
                            </select>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </table>
                <br>
                <br>
                <button id="b1" class="btn  btn-primary" onclick="guardaIndividual(false);">Guardar Avance</button>
                <button id="b2" class="btn  btn-primary" onclick="guardaIndividual(true);">Guardar Final</button>
            </div><%--  FIN SPAN8 --%>
            <div class="span4">
                <jsp:include page="c_empresa_admon.jsp" />
            </div>
        </div>
    </div>
</individual>


<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function guardaIndividual(definitivo){
        var valoresCriterios = [[],[]];

    <%
        for (int i = 0; i < pnManager.getPnCriterios().size(); i++) {
            PnCriterio criterio = pnManager.getPnCriterios().get(i);
    %>
        valoresCriterios[<%=i%>] = [<%=criterio.getId()%>,dwr.util.getValue("<%=criterio.getId()%>")];
    <%
        }
    %>
        if (definitivo) {
            disableId("b2");
        } else {
            disableId("b1");
        }

        pnRemoto.saveVAloracionIndividual(definitivo,
                valoresCriterios,
                dwr.util.getValue("fortalezas"),
                dwr.util.getValue("oportunidades"),
                dwr.util.getValue("pendientesVisita"), function(data){
            if(data == 1){
                alert("Registro Correcto");
                window.location = "evalGlobalInd.htm";
            } else {
                alert("Problemas !");
            }

                    if (definitivo) {
                        enableId("b2");
                    } else {
                        enableId("b1");
                    }
        });

    }

    <%


                    if(fromParticipante.size()>0){  // SOLO SI HAY VALORACION
                        for (PnValoracion valoracion : fromParticipante){
    %>
    dwr.util.setValue("<%=valoracion.getPnCriterioByIdPnCriterio().getId()%>", <%=valoracion.getValor()%>);
    <%
                        }
                    } else { // aca
                            System.out.println("ADIOS");
                            }
//                    System.out.println("cualitativa = " + cualitativa.getFortalezas());
                    if(cualitativa != null){
    %>
    dwr.util.setValue("fortalezas", poneSaltosDeLinea('<%=cualitativa.getFortalezas().replace("\n", "<br>")%>'));
    dwr.util.setValue("oportunidades", poneSaltosDeLinea('<%=cualitativa.getOportunidades().replace("\n", "<br>")%>'));
    dwr.util.setValue("pendientesVisita", poneSaltosDeLinea('<%=cualitativa.getPendientesVisita().replace("\n", "<br>")%>'));
    <%
                    }
    %>
</script>