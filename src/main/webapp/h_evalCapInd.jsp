<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Texto texto16 = pnManager.getTexto(17);
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
                    List<PnValoracion> fromParticipante = pnManager.getValoracionIndividualCapitulosFromEmpleado(
                            empleo.getIdEmpleado());

                    List<PnCualitativa> cualitativas = pnManager.getPnCualitativasFromEmpleadoTipoFormato(
                            empleo.getIdEmpleado(), 2 // FORMATO 2 INDIVIDUALPOR CAPITULO
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
                    Datos ingresados el <%=pnManager.dfDateTime.format(cualitativas.get(0).getFechaCreacion())%>
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
                    <tr><th class="alert-info">Fortalezas</th></tr>
                    <tr><td>
                        <textarea id="fortalezas-<%=capitulo.getId()%>" class="field span6" placeholder="Lo que lo ayudar&aacute; en crisis" rows="4" cols="10"></textarea>
                    </td></tr>
                    <tr><th class="alert-info">Oportunidades de Mejora</th></tr>
                    <tr><td>
                        <textarea id="oportunidades-<%=capitulo.getId()%>" class="field span6" placeholder="Tips de mejora" rows="4" cols="10"></textarea>
                    </td></tr>
                    <tr><th class="alert-info">Pendientes Vista de Campo</th></tr>
                    <tr><td>
                        <textarea id="pendientesVisita-<%=capitulo.getId()%>" class="field span6" placeholder="Puntos para tener en cuenta" rows="4" cols="10"></textarea>
                    </td></tr>
                </table>
                <br>
                <table border="1" align="center">
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
                            <select name="<%=capitulo.getId()%>-<%=criterio.getId()%>" id="<%=criterio.getId()%>" class="" style="width:100px; background-color:#1570a6; height:100%;">
                            <%
                                for (Integer v: pnManager.getValoresValoracion()){
                            %>
                                <option value="<%=v%>"><%=v%></option>
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
                    <br>&nbsp;
                    </div>
                <%
                    } //  END DEL MEGA FOR DE CAPITULOS
                %>
                                         <br>
                
                <button id="b1" class="btn  btn-primary" onclick="guardaIndividualCapitulos();">Guardar</button>
            </div><%--  FIN SPAN8 --%>
            <div class="span4">
                <jsp:include page="c_empresa_admon.jsp"    />
            </div>
        </div>
    </div>
</individual>


<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function guardaIndividualCapitulos(){
        var dataFortaleza   = new Array();
        var dataOportunidad = new Array();
        var dataPendiente   = new Array();

        var dataValores = new Array();

    <%
        for (PnCapitulo capitulo : pnCapitulos) {
    %>
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

        disableId("b1");

        pnRemoto.saveValoracionIndividualCapitulos(dataFortaleza,
                dataOportunidad,
                dataPendiente,
                dataValores, function(data){
            if(data == 1){
                alert("Registro Correcto");
            } else {
                alert("Problemas !");
            }
            enableId("b1");
        });

    }

    <%


                    if(fromParticipante.size()>0){  // SOLO SI HAY VALORACION
                        for (PnValoracion valoracion : fromParticipante){
    %>
    dwr.util.setValue("<%=valoracion.getPnCapituloByIdCapitulo().getId()%>-<%=valoracion.getPnCriterioByIdPnCriterio().getId()%>", <%=valoracion.getValor()%>);
    <%
                        }
                    } else { // aca
                            System.out.println("ADIOS");
                            }
                    if(cualitativas != null){
                        for (PnCualitativa cualitativa: cualitativas){
    %>
    dwr.util.setValue("fortalezas-<%=cualitativa.getPnCapituloByIdCapitulo().getId()%>",        poneSaltosDeLinea("<%=cualitativa.getFortalezas().replace("\n", "<br>")%>"));
    dwr.util.setValue("oportunidades-<%=cualitativa.getPnCapituloByIdCapitulo().getId()%>",     poneSaltosDeLinea('<%=cualitativa.getOportunidades().replace("\n", "<br>")%>'));
    dwr.util.setValue("pendientesVisita-<%=cualitativa.getPnCapituloByIdCapitulo().getId()%>",  poneSaltosDeLinea('<%=cualitativa.getPendientesVisita().replace("\n", "<br>")%>'));
    <%
                        } // FOR CUALITATIVAS
                    } // IF NULL
    %>
</script>