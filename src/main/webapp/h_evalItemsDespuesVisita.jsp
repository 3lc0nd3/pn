<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="co.com.elramireza.pn.util.MyKey" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Texto texto16 = pnManager.getTexto(18);
    Texto texto19 = pnManager.getTexto(19);
    Texto texto22 = pnManager.getTexto(22);
    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Participante participanteByIdParticipante = empleo.getParticipanteByIdParticipante();
    Empresa empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();

    List<PnSubCapitulo> items = pnManager.getPnSubCapitulos();

%>

<individual>
    <div class="container">
        <div class="row">
            <div class="span8">
                <h2><%=texto16.getTexto3()%></h2>
                para <strong><%=empresa.getNombreEmpresa()%></strong>
                <br>
                <br>

                <%
                    List<PnCuantitativa> cuantitativas = pnManager.getCuantitativaDespuesVisitaFromEmpleado(
                            empleo.getIdEmpleado());

                    if (participanteByIdParticipante.getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante() != 4) {
                %>
                <div class="alert">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <%=texto22.getTexto1()%>
                    <img src="img/stop.png" width="50">
                </div>
                <%
                    }
                    if(cuantitativas.size()==0){ // NO HAY DATA
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
                    Datos ingresados el
                    <%=pnManager.dfDateTime.format(cuantitativas.get(0).getFechaCreacion())%>
                </div>
                <%
                    }
                %>

                <table border="1" width="100%" align="center">
                    <%
                        int idCapituloOld = 0;
                        for (PnSubCapitulo item: items){
                            if(idCapituloOld != item.getPnCapituloByIdCapitulo().getId()){
                                idCapituloOld = item.getPnCapituloByIdCapitulo().getId();
                    %>
                    <tr>
                        <th>
                            <%=item.getPnCapituloByIdCapitulo().getId()%>
                        </th>
                        <th colspan="1">
                            <%=item.getPnCapituloByIdCapitulo().getNombreCapitulo()%>
                        </th>
                        <th width="50" >Puntaje</th>
                        <th width="50" >Valor</th>
                        <th width="50" >
                            Total
                            <br>
                            <span class="color" id="t-<%=item.getPnCapituloByIdCapitulo().getId()%>"></span>
                        </th>
                    </tr>
                    <tr>
                        <th colspan="5" class="alert-info">Fortalezas</th>
                    </tr>
                    <tr>
                        <td  colspan="5">
                            <textarea id="fortalezas<%=item.getPnCapituloByIdCapitulo().getId()%>" class="field span6" placeholder="<%=texto19.getTexto1()%>" rows="4" cols="10"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="5" class="alert-info">Oportunidades de Mejora</th>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <textarea id="oportunidades<%=item.getPnCapituloByIdCapitulo().getId()%>" class="field span6" placeholder="<%=texto19.getTexto2()%>" rows="4" cols="10"></textarea>
                        </td>
                    </tr>
                    <%
                            }
                    %>
                    <tr>
                        <td>
                            <%=item.getCodigoItem()%>
                            <br>
                            <img src="images/help.png" onclick="muestraAyuda('<%=item.getId()%>', true);" width="24" alt="Contenido" title="Contenido">
                        </td>
                        <td>
                            <%=item.getSubCapitulo()%>
                        </td>
                        <td align="right">
                            <%=item.getPonderacion()%>
                        </td>
                        <td width="70">
                            <select onchange="sValorItem(<%=item.getId()%>);" name="i<%=item.getId()%>" id="i<%=item.getId()%>" class="selEval">
                            <%
                                for (Integer v: pnManager.getValoresValoracion()){
                            %>
                                <option class="selEval" value="<%=v%>"><%=v%></option>
                            <%
                                }
                            %>
                            </select>
                        </td>
                        <td align="right">
                            <span style="text-align:right;" id="l<%=item.getId()%>">0</span>
                        </td>
                    </tr>
                    <tr id="contenido<%=item.getId()%>" style="display:none;">
                        <td colspan="5">
                            <table width="100%" border="1">
                                <tr>
                                    <td width="50%" class="contenido">
                                        <span id="evalua<%=item.getId()%>"></span>
                                        <%--<%=item.getEvalua()%>--%>
                                    </td>
                                    <td width="50%" class="contenido">
                                        <span id="ayuda<%=item.getId()%>"></span>
                                    </td>
                                </tr>
                            </table>
                        </td>

                    </tr>
                    
                    <%
                        }
                    %>
                </table>
                <table border="1" align="center" width="100%">
                    <tr>
                        <th align="right">Puntuaci&oacute;n Total
                            &nbsp;
                            &nbsp;
                            &nbsp;
                            &nbsp;
                            <span class="color" id="totalM">0</span>
                        </th>
                    </tr>
                </table>
                <br>
                <button id="b1" class="btn  btn-primary" onclick="guardaItems();">Guardar</button>
                <%
                    if(cuantitativas.size()>0){ // SOLO SI HAY DATA
                %>
                <%
                    }
                %>
            </div>
            <div class="span4">
                <jsp:include page="c_empresa_admon.jsp"    />
            </div>
        </div>

    </div>
</individual>


<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function saltaAVisita(){
        disableId("b2");
        pnRemoto.saltaAVisita(function(data){
            if(data == 1){
                alert("Cambio de Etapa Correcto");
            } else {
                alert("Problemas !");
            }
            enableId("b2");
        });
    }

    <%
        for (PnSubCapitulo item: items){
    %>
    var tmp<%=item.getId()%> = <%=item.getPonderacion()%>;
    <%
        }
    %>

    function guardaItems(){
        var retro = new Array();
    <%
        for (PnCapitulo capitulo : pnManager.getPnCapitulos()){
    %>
        retro.push({
            id:<%=capitulo.getId()%>,
            text: dwr.util.getValue("fortalezas<%=capitulo.getId()%>"), // fortalezas
            text2:dwr.util.getValue("oportunidades<%=capitulo.getId()%>") // oportunidades
        });
    <%
        }
    %>

        var dataValores = new Array();

    <%
        for (PnSubCapitulo item: items){
    %>
        dataValores.push({
            id:<%=item.getId()%>,
            criterio: dwr.util.getValue("i<%=item.getId()%>"),  // VALOR
            value: dwr.util.getValue("l<%=item.getId()%>") // TOTAL
        });
    <%
        }
    %>
//        alert(dwr.util.toDescriptiveString(dataValores, 2));
        disableId("b1");

        pnRemoto.saveValoracionDespuesVisitaItems(dataValores, retro, function(data){
            if(data == 1){
                alert("Registro Correcto");
                window.location = "evalItemsDespuesVisita.htm";
            } else {
                alert("Problemas !");
            }
            enableId("b1");
        });
    }

    function sValorItem(id){
//        alert("id = " + id);
        var valor = dwr.util.getValue("i"+id);
//        alert("item = " + eval('tmp'+id));
        var aux = valor * eval('tmp'+id) / 100;
        
        dwr.util.setValue("l"+id, Math.ceil(aux));
        muestraAyuda(id, false);
    }

    <%
        for(PnCuantitativa item:  cuantitativas){
    %>
        dwr.util.setValue("i<%=item.getPnSubCapituloByIdSubCapitulo().getId()%>", <%=item.getValor()%>);
        dwr.util.setValue("l<%=item.getPnSubCapituloByIdSubCapitulo().getId()%>", <%=item.getTotal()%>);
    <%
        }
    %>

    <%
        int totalM = 0;
        for (MyKey key : pnManager.getTotalesItems(empleo.getIdEmpleado(), 5)) { // DESPUES DE VISITA
            totalM += key.getValue();
    %>
    dwr.util.setValue("t-<%=key.getId()%>", <%=key.getValue()%>);
    <%
        }
    %>
    dwr.util.setValue("totalM", <%=totalM%>);
    <%
        for (PnRetroalimentacion retroalimentacion : pnManager.getPnRetroalimentaciones(empleo.getParticipanteByIdParticipante().getIdParticipante())){
    %>
    dwr.util.setValue(   "fortalezas<%=retroalimentacion.getPnCapituloByIdPnCapitulo().getId()%>",  poneSaltosDeLinea('<%=retroalimentacion.getFortalezas().replace("\n", "<br>").replace("\r", "").replace("'","\"")%>'));
    dwr.util.setValue("oportunidades<%=retroalimentacion.getPnCapituloByIdPnCapitulo().getId()%>",  poneSaltosDeLinea('<%=retroalimentacion.getOportunidades().replace("\n", "<br>").replace("\r", "").replace("'","\"")%>'));
    <%
        }
    %>

</script>