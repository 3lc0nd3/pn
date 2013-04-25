<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="co.com.elramireza.pn.util.MyKey" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Texto texto16 = pnManager.getTexto(18);
    Texto texto22 = pnManager.getTexto(22);
    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Participante participanteByIdParticipante = empleo.getParticipanteByIdParticipante();
    Empresa empresa = participanteByIdParticipante.getEmpresaByIdEmpresa();

    List<PnSubCapitulo> items = pnManager.getPnSubCapitulos();

    List<PnCuantitativa> cuantitativas = pnManager.getCuantitativaConsensoFromEmpleado(
            empleo.getIdEmpleado());

    List<Empleado> evaluadores = pnManager.getEvaluadoresFromParticipante(empleo.getParticipanteByIdParticipante().getIdParticipante());

    List<List<PnCuantitativa>> otros = new ArrayList<List<PnCuantitativa>>();

    boolean hayDatosEvaluadores = true;
    for (Empleado evaluador: evaluadores){
        List<PnCuantitativa> cuantitativaEval = pnManager.getCuantitativaIndividualFromEmpleado(
                evaluador.getIdEmpleado());
//        System.out.println("cuantitativaEval.size() = " + cuantitativaEval.size());
        if(cuantitativaEval.size() == 0){
            hayDatosEvaluadores = false;
        }
        otros.add(cuantitativaEval);
    }
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
                    Participante participante = pnManager.getParticipante(empleo.getParticipanteByIdParticipante().getIdParticipante());
                    if(cuantitativas.size()>0
                            && participante.getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante() == 2 //CONSENSO
                            ){ // SOLO SI HAY DATA y CONSENSO
                %>
                <button id="b2" class="btn  btn-primary" onclick="saltaAVisita();">Avanza a Agenda de Visita</button>
                <%
                    }
                    if (participanteByIdParticipante.getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante() != 2) {
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
                    <%
                        if (participante.getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante() > 2) {
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
                    if (hayDatosEvaluadores){
                %>

                <table class="mytable" border="1" width="100%" align="center">
                    <%
                        int idCapituloOld = 0;
                        int i=-1;
                        for (PnSubCapitulo item: items){
                            i++;
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
                        <%
                            for (Empleado evaluador : evaluadores){
                        %>
                        <th style="vertical-align: bottom;" class="vertical">
                            <%--Hola Mundo y mas coasa--%>
                            <%--<%=evaluador.getPersonaByIdPersona().getNombreCompleto()%>--%>
                            <%=evaluador.getPersonaByIdPersona().getNombrePersona()%>
                            <%--<br>--%>
                            <%=evaluador.getPersonaByIdPersona().getApellido()%>
                        </th>
                        <%
                            }
                        %>
                        <th width="50" >Puntaje</th>
                        <th width="50" >Valor</th>
                        <th width="50" >
                            Total
                            <br>
                            <span class="color" id="t-<%=item.getPnCapituloByIdCapitulo().getId()%>"></span>
                        </th>
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
                        <td class="contenido">
                            <%=item.getSubCapitulo()%>
                        </td>
                        <%
                            for (int j = 0; j < evaluadores.size(); j++) {
                                Empleado evaluador = evaluadores.get(j);
                                List<PnCuantitativa> results = otros.get(j);

                        %>
                        <td align="center">
                            <%--<%=results.get(i).getPnSubCapituloByIdSubCapitulo().getSubCapitulo()%>--%>
                            <%=results.get(i).getValor()%>%
                            <br>
                            <%=results.get(i).getTotal()%>
                        </td>
                        <%
                            }
                        %>
                        <td align="center">
                            <%=item.getPonderacion()%>
                        </td>
                        <td>
                            <select style="width: 60px" onchange="sValorItem(<%=item.getId()%>);" name="i<%=item.getId()%>" id="i<%=item.getId()%>" class="selEval" >
                            <%
                                for (Integer v: pnManager.getValoresValoracion()){
                            %>
                                <option class="selEval" value="<%=v%>"><%=v%></option>
                            <%
                                }
                            %>
                            </select>
                        </td>
                        <td align="center">
                            <span style="text-align:right;" id="l<%=item.getId()%>">0</span>
                        </td>
                    </tr>
                    <tr id="contenido<%=item.getId()%>" style="display:none;">
                        <td colspan="<%=5+evaluadores.size()%>">
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
                    <tr>
                        <th align="right" colspan="2">
                            Puntuaci&oacute;n Total
                            &nbsp;
                            &nbsp;
                            &nbsp;
                            &nbsp;
                        </th>
                        <%
                            int totalEval;
                            for (int j = 0; j < evaluadores.size(); j++) {
                                Empleado evaluador = evaluadores.get(j);
                                List<MyKey> totalesItems = pnManager.getTotalesItems(evaluador.getIdEmpleado(), 3);

                                totalEval = 0;
                                for (int k = 0; k < totalesItems.size(); k++) {
                                    MyKey myKey = totalesItems.get(k);
                                    totalEval += myKey.getValue();
                                }

                        %>
                        <th align="center">
                            <%--<%=results.get(i).getPnSubCapituloByIdSubCapitulo().getSubCapitulo()%>--%>
                            <%=totalEval%>

                        </th>
                        <%
                            }
                        %>
                        <td colspan="2"></td>
                        <th align="center">
                            <span class="color" id="totalM">0</span>
                        </th>
                    </tr>
                </table>
                <table border="1" align="center" width="100%">
                    <tr>
                        <th align="right">
                            &nbsp;
                            &nbsp;
                            &nbsp;
                            &nbsp;

                        </th>
                    </tr>
                </table>
                <br>
                <button id="b1" class="btn  btn-primary" onclick="guardaItems();">Guardar</button>
                <%
                    if(cuantitativas.size()>0
                            && empleo.getParticipanteByIdParticipante().getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante() == 2 //CONSENSO
                            ){ // SOLO SI HAY DATA y CONSENSO
                %>

                <%
                    }
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
                window.location = "evalItemsConsenso.htm";
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

        pnRemoto.saveValoracionConsensoItems(dataValores, function(data){
            enableId("b1");
            if(data == 1){
                alert("Registro Correcto");
                window.location = "evalItemsConsenso.htm";
            } else {
                alert("Problemas !");
            }
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
        int totalM = 0;
        for (MyKey key : pnManager.getTotalesItems(empleo.getIdEmpleado(), 4)) { // CONSENSO
            totalM += key.getValue();
    %>
    dwr.util.setValue("t-<%=key.getId()%>", <%=key.getValue()%>);
    <%
        }
    %>
    dwr.util.setValue("totalM", <%=totalM%>);
    <%
        for(PnCuantitativa item:  cuantitativas){
    %>
        dwr.util.setValue("i<%=item.getPnSubCapituloByIdSubCapitulo().getId()%>", <%=item.getValor()%>);
        dwr.util.setValue("l<%=item.getPnSubCapituloByIdSubCapitulo().getId()%>", <%=item.getTotal()%>);
    <%
        }
    %>


    $(document).ready(function(){
        $('.mytable').rotateTableCellContent();
    });

    <%
    if(participante.getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante()>2){
    %>
    $('#contenedor').find('select, textarea').attr('disabled','disabled');
    <%
    }
    %>

</script>