<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Texto texto16 = pnManager.getTexto(17);
    Texto texto19 = pnManager.getTexto(19);
    Texto texto20 = pnManager.getTexto(21);
    Texto texto22 = pnManager.getTexto(22);
    Texto texto23 = pnManager.getTexto(23);
    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Participante participanteByIdParticipante = empleo.getParticipanteByIdParticipante();
    Empresa empresa = participanteByIdParticipante.getEmpresaByIdEmpresa();

    List<PnCategoriaCriterio> categoriasCriterio = pnManager.getCategoriasCriterio();
//    categoriasCriterio.remove(categoriasCriterio.size()-1);

%>

<individual>
    <div id="contenedor" class="container">
        <div class="row">
            <div class="span8">
                <h2><%=texto16.getTexto2()%></h2>
                para <strong><%=empresa.getNombreEmpresa()%></strong>
                <br>
                <br>
                <%
                    List<PnValoracion> fromParticipante = pnManager.getValoracionConsensoCapitulosFromEmpleado(
                            empleo.getIdEmpleado());

                    List<PnCualitativa> cualitativas = pnManager.getPnCualitativasFromEmpleadoTipoFormato(
                            empleo.getIdEmpleado(), 7 // FORMATO 7 CONSENSO POR CAPITULO
                    );

                    if (participanteByIdParticipante.getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante() != 2) {
                %>
                <div class="alert">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <%=texto22.getTexto1()%>
                    <img src="img/stop.png" width="50">
                </div>
                <%
                    }
//                    System.out.println("fromParticipante.size() = " + fromParticipante.size());
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
                    Datos ingresados el <%=pnManager.dfDateTime.format(cualitativas.get(0).getFechaCreacion())%>
                    <%--<%
                        if (empleo.isEvaluaCapitulos()) {
                    %>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    Datos Finales
                    <img width="100" src="images/flag.png" alt="Final" title="Final">

                    <%
                        }
                    %>--%>
                </div>
                <%
                    }

                    //MEGA FOR DE CAPITULOS
                    List<PnCapitulo> pnCapitulos = pnManager.getPnCapitulos();
                    for (PnCapitulo capitulo: pnCapitulos){
                        String bg;
                        if(capitulo.getId()%2 == 1){
                            bg = "#dad9d9";
                        } else {
                            bg = "#eeeded";
                        }

                %>
                <br>
                <div class="esquinasRedondas" style="background-color:<%=bg%>; text-align:center;">
                    <br>
                    <h4 class="color"><%=capitulo.getNombreCapitulo()%></h4>
                    <br>
                    <table border="1" width="70%" align="center">
                        <tr><th class="alert-info"><%=texto20.getTexto1()%></th></tr>
                        <tr><td>
                            <textarea id="vision-<%=capitulo.getId()%>" class="field span6" placeholder="<%=texto20.getTexto2()%>" rows="4" cols="10"></textarea>
                        </td></tr>
                        <tr><th class="alert-info">Fortalezas</th></tr>
                        <tr><td>
                            <textarea id="fortalezas-<%=capitulo.getId()%>" class="field span6" placeholder="<%=texto19.getTexto1()%>" rows="4" cols="10"></textarea>
                        </td></tr>
                        <tr><th class="alert-info">Oportunidades de Mejora</th></tr>
                        <tr><td>
                            <textarea id="oportunidades-<%=capitulo.getId()%>" class="field span6" placeholder="<%=texto19.getTexto2()%>" rows="4" cols="10"></textarea>
                        </td></tr>
                        <tr><th class="alert-info">Pendientes Vista de Campo</th></tr>
                        <tr><td>
                            <textarea id="pendientesVisita-<%=capitulo.getId()%>" class="field span6" placeholder="Puntos para tener en cuenta" rows="4" cols="10"></textarea>
                        </td></tr>
                    </table>
                    <br>
                    <table border="1" align="center" width="90%">
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
                                <img src="images/help.png" onclick="muestraAyudaCriterio('<%=criterio.getId()%>','<%=capitulo.getId()%>', true);" width="24" alt="Contenido" title="Contenido">
                                <%
                                    if (criterio.getId()!=15){
                                %>
                                <%=criterio.getCriterio()%>
                                <%
                                    } else {
                                %>
                                <%=texto23.getTexto2()%>
                                <%
                                    }
                                %>
                            </td>
                            <td class="btn-primary">
                                <%
                                    if (criterio.getId() != 15) {
                                %>
                                <select name="<%=capitulo.getId()%>-<%=criterio.getId()%>" id="<%=criterio.getId()%>" onchange="muestraAyudaCriterio(<%=criterio.getId()%>, '<%=capitulo.getId()%>', false)" class="selEval">
                                    <%
                                        for (Integer v: pnManager.getValoresValoracion()){
                                    %>
                                    <option <%=v==50?"selected":""%> class="selEval" value="<%=v%>"><%=v%></option>
                                    <%
                                        }
                                    %>
                                </select>
                                <%
                                } else {
                                %>
                                <span id="<%=capitulo.getId()%>-15" class="btn-primary selEval"></span>
                                <%
                                    }
                                %>
                            </td>
                        </tr>
                        <tr id="<%=capitulo.getId()%>-contenido<%=criterio.getId()%>" style="display:none;">
                            <td colspan="2">
                                <table cellpadding="0" cellspacing="0" border="1" width="100%">
                                    <tr>
                                        <td width="50%" class="contenido">
                                            <span id="<%=capitulo.getId()%>-evalua<%=criterio.getId()%>"></span>
                                            <%--<%=item.getEvalua()%>--%>
                                        </td>
                                        <td width="50%" class="contenido">
                                            <span id="<%=capitulo.getId()%>-ayuda<%=criterio.getId()%>"></span>
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
                    <br>&nbsp;<button id="b1" class="btn  btn-primary" onclick="guardaIndividualCapitulos(false);">Guardar Avance</button>
                </div>
                <%
                    } //  END DEL MEGA FOR DE CAPITULOS
                %>
                <%
//                    if (!empleo.isEvaluaCapitulos()) {
                %>
                <br>

                <button id="b1" class="btn  btn-primary" onclick="guardaIndividualCapitulos(false);">Guardar</button>
                <%--<button id="b2" class="btn  btn-primary" onclick="guardaIndividualCapitulos(true);">Guardar Final</button>--%>
                <%
//                    }
                %>
            </div><%--  FIN SPAN8 --%>
            <div class="span4">
                <jsp:include page="c_empresa_admon.jsp"    />
            </div>
        </div>
    </div>
</individual>


<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function guardaIndividualCapitulos(definitivo){
        var dataVision   = new Array();
        var dataFortaleza   = new Array();
        var dataOportunidad = new Array();
        var dataPendiente   = new Array();

        var dataValores = new Array();

    <%

                        int total=0;
        for (PnCapitulo capitulo : pnCapitulos) {
    %>
        dataVision.push     ({id:<%=capitulo.getId()%>, text: dwr.util.getValue("vision-<%=capitulo.getId()%>")});
        dataFortaleza.push  ({id:<%=capitulo.getId()%>, text: dwr.util.getValue("fortalezas-<%=capitulo.getId()%>")});
        dataOportunidad.push({id:<%=capitulo.getId()%>, text: dwr.util.getValue("oportunidades-<%=capitulo.getId()%>")});
        dataPendiente.push  ({id:<%=capitulo.getId()%>, text: dwr.util.getValue("pendientesVisita-<%=capitulo.getId()%>")});
    <%
            for (PnCriterio criterio : pnManager.getPnCriterios()){
    %>
        dataValores.push    ({id:<%=capitulo.getId()%>, criterio:<%=criterio.getId()%>,
            value: dwr.util.getValue("<%=capitulo.getId()%>-<%=criterio.getId()%>")});
    <%
            }
        }
    %>
//        alert(dwr.util.toDescriptiveString(dataValores, 2));

        if (definitivo) {
            disableId("b2");
        } else {
            disableId("b1");
        }

        pnRemoto.saveValoracionConsensoCapitulos(definitivo,
                dataVision,
                dataFortaleza,
                dataOportunidad,
                dataPendiente,
                dataValores, function(data){
                    if(data == 1){
                        alert("Registro Correcto");
                        window.location = "conCapInd.htm";
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
                            if(valoracion.getPnCriterioByIdPnCriterio().getId()==1){
                                total = 0;
                            }

                            if (valoracion.getPnCriterioByIdPnCriterio().getId()!=15){
                                total += valoracion.getValor();
                            }
    %>
    dwr.util.setValue("<%=valoracion.getPnCapituloByIdCapitulo().getId()%>-<%=valoracion.getPnCriterioByIdPnCriterio().getId()%>", <%=valoracion.getValor()%>);
    <%

                            if(valoracion.getPnCriterioByIdPnCriterio().getId() ==15){
    %>
    dwr.util.setValue("<%=valoracion.getPnCapituloByIdCapitulo().getId()%>-15", "<%=total/14%>");
    <%
                            }
    %>
    <%
                        }
                    } else { // aca
                            System.out.println("ADIOS");
                            }
                    if(cualitativas != null){
                        for (PnCualitativa cualitativa: cualitativas){
    %>
    dwr.util.setValue(          "vision-<%=cualitativa.getPnCapituloByIdCapitulo().getId()%>",  poneSaltosDeLinea('<%=cualitativa.getVision().replace("\n", "<br>").replace("\r", "").replace("'","\"")%>'));
    dwr.util.setValue(      "fortalezas-<%=cualitativa.getPnCapituloByIdCapitulo().getId()%>",  poneSaltosDeLinea('<%=cualitativa.getFortalezas().replace("\n", "<br>").replace("\r", "").replace("'","\"")%>'));
    dwr.util.setValue(   "oportunidades-<%=cualitativa.getPnCapituloByIdCapitulo().getId()%>",  poneSaltosDeLinea('<%=cualitativa.getOportunidades().replace("\n", "<br>").replace("\r", "").replace("'","\"")%>'));
    dwr.util.setValue("pendientesVisita-<%=cualitativa.getPnCapituloByIdCapitulo().getId()%>",  poneSaltosDeLinea('<%=cualitativa.getPendientesVisita().replace("\n", "<br>").replace("\r", "").replace("'","\"")%>'));
    <%
                        } // FOR CUALITATIVAS
                    } // IF NULL
    %>
    <%
    if(empleo.isEvaluaCapitulos()){
    %>
//    $('#contenedor').find('select, textarea').attr('disabled','disabled');
    <%
    }
    %>
</script>