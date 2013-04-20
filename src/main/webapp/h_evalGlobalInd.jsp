<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Texto texto16 = pnManager.getTexto(16);
    Texto texto19 = pnManager.getTexto(19);
    Texto texto20 = pnManager.getTexto(20);
    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Empresa empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();

    List<PnCategoriaCriterio> categoriasCriterio = pnManager.getCategoriasCriterio();

%>

<individual>
    <div id="contenedor" class="container">
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
                    <%
                        if (empleo.isEvaluaGlobal()) {
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
                <table border="1" width="70%">
                    <tr><th class="alert-info"><%=texto20.getTexto1()%></th></tr>
                    <tr><td>
                        <textarea id="vision" class="field span6" placeholder="<%=texto20.getTexto2()%>" rows="4" cols="10"></textarea>
                    </td></tr>
                    <tr style="display: none; visibility: hidden;"><th class="alert-info">Fortalezas</th></tr>
                    <tr style="display: none; visibility: hidden;"><td>
                        <textarea id="fortalezas" class="field span6" placeholder="<%=texto19.getTexto1()%>" rows="4" cols="10"></textarea>
                    </td></tr>
                    <tr style="display: none; visibility: hidden;"><th class="alert-info">Oportunidades de Mejora</th></tr>
                    <tr style="display: none; visibility: hidden;"><td>
                        <textarea id="oportunidades" class="field span6" placeholder="<%=texto19.getTexto2()%>" rows="4" cols="10"></textarea>
                    </td></tr>
                    <tr><th class="alert-info">Puntos Pendientes Visita de Campo</th></tr>
                    <tr><td>
                        <textarea id="pendientesVisita" class="field span6" placeholder="Puntos para tener en cuenta" rows="4" cols="10"></textarea>
                    </td></tr>
                </table>
                <br>
                <table border="1" width="90%">
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
                        <td class=" btn-primary">
                            <img src="images/help.png" onclick="muestraAyudaCriterio('<%=criterio.getId()%>',1, true);" width="24" alt="Contenido" title="Contenido">
                            <%=criterio.getCriterio()%>
                        </td>
                        <td class="btn-primary">
                            <%
                                if (criterio.getId() != 15) {
                            %>
                            <select name="1-<%=criterio.getId()%>" id="1-<%=criterio.getId()%>" onchange="muestraAyudaCriterio(<%=criterio.getId()%>, 1, false)" class="selEval">
                            <%
                                for (Integer v: pnManager.getValoresValoracion()){
                            %>
                                <option <%=v==50?"selected":""%> class=" btn-primary" value="<%=v%>"><%=v%></option>
                            <%
                                }
                            %>
                            </select>
                            <%
                                } else {
                            %>
                            <span id="1-15" class="selEval"></span>
                            <%
                                }
                            %>
                        </td>
                    </tr>
                    <tr id="1-contenido<%=criterio.getId()%>" style="display:none;">
                        <td colspan="2">
                            <table cellpadding="0" cellspacing="0" border="1" width="100%">
                                <tr>
                                    <td width="50%" class="contenido">
                                        <span id="1-evalua<%=criterio.getId()%>"></span>
                                        <%--<%=item.getEvalua()%>--%>
                                    </td>
                                    <td width="50%" class="contenido">
                                        <span id="1-ayuda<%=criterio.getId()%>"></span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </table>
                <%
                    if (!empleo.isEvaluaGlobal()) {
                %>
                <br>
                <br>
                <button id="b1" class="btn  btn-primary" onclick="guardaIndividual(false);">Guardar Avance</button>
                <button id="b2" class="btn  btn-primary" onclick="guardaFinal() ;">Guardar Final</button>
                <%
                    }
                %>
            </div><%--  FIN SPAN8 --%>
            <div class="span4">
                <jsp:include page="c_empresa_admon.jsp" />
            </div>
        </div>
    </div>
</individual>


<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function guardaFinal(){
        if (confirm("Si acepta, no podra hacer mas cambios")) {
            guardaIndividual(true);
        }
    }

    function guardaIndividual(definitivo){
        var valoresCriterios = [[],[]];

    <%
        for (int i = 0; i < pnManager.getPnCriterios().size(); i++) {
            PnCriterio criterio = pnManager.getPnCriterios().get(i);
    %>
        valoresCriterios[<%=i%>] = [<%=criterio.getId()%>,dwr.util.getValue("1-<%=criterio.getId()%>")];
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
                dwr.util.getValue("vision"),
                dwr.util.getValue("fortalezas"),
                dwr.util.getValue("oportunidades"),
                dwr.util.getValue("pendientesVisita"),
                function(data){
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
                       System.out.println("fromParticipante.size() = " + fromParticipante.size());

                    if(fromParticipante.size()>0){  // SOLO SI HAY VALORACION
                        int total = 0;
                        for (PnValoracion valoracion : fromParticipante){
                            if (valoracion.getPnCriterioByIdPnCriterio().getId() != 15) {
                                total += valoracion.getValor();
//                                System.out.println("total = " + total);


    %>
                dwr.util.setValue("1-<%=valoracion.getPnCriterioByIdPnCriterio().getId()%>", <%=valoracion.getValor()%>);
    <%
                            } else {
    %>
                dwr.util.setValue("1-15", "<%=total/14%>");
    <%
                            }
                        } // END FOR
                    } else { // aca
                            System.out.println("ADIOS");
                            }
//                    System.out.println("cualitativa = " + cualitativa.getFortalezas());
                    if(cualitativa != null){
    %>
    dwr.util.setValue("vision",             poneSaltosDeLinea('<%=cualitativa.getVision().replace("\n", "<br>").replace("\r", "").replace("'","\"")%>'));
    dwr.util.setValue("fortalezas",         poneSaltosDeLinea('<%=cualitativa.getFortalezas().replace("\n", "<br>").replace("\r", "").replace("'","\"")%>'));
    dwr.util.setValue("oportunidades",      poneSaltosDeLinea('<%=cualitativa.getOportunidades().replace("\n", "<br>").replace("\r", "").replace("'","\"")%>'));
    dwr.util.setValue("pendientesVisita",   poneSaltosDeLinea('<%=cualitativa.getPendientesVisita().replace("\n", "<br>").replace("\r", "").replace("'","\"")%>'));
    <%
                    }
    %>


    <%
    if(empleo.isEvaluaGlobal()){
    %>
    $('#contenedor').find('select, textarea').attr('disabled','disabled');
    <%
    }
    %>

</script>