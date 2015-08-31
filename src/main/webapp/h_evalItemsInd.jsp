<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="co.com.elramireza.pn.util.MyKey" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Texto texto16 = pnManager.getTexto(18);
    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Empresa empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();

    List<PnSubCapitulo> items = pnManager.getPnSubCapitulos(
            empleo.getParticipanteByIdParticipante().getPnPremioByIdConvocatoria().getTipoPremioById().getId()
    );

    List<PnCuantitativa> cuantitativas = pnManager.getCuantitativaIndividualFromEmpleado(
            empleo.getIdEmpleado());

    if(
            empleo.isEvaluaGlobal()
        &&
            empleo.isEvaluaCapitulos()
            ){  //  IF COMPLETO LA GLOBAL
%>

<individual>
    <div id="contenedor" class="container">
        <div class="row">
            <div class="span8">
                <h2><%=texto16.getTexto1()%></h2>
                para <strong><%=empresa.getNombreEmpresa()%> en
                <%=empleo.getParticipanteByIdParticipante().getPnPremioByIdConvocatoria().getTipoPremioById().getSigla()%></strong>
                <br>
                <br>

                <%

                    if(cuantitativas.size()==0){  //  NO HAY VALORES
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
                        if (empleo.isEvaluaItems()) {
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

                <table border="1" width="100%" align="center">
                    <%
                        int idCapituloOld = 0;
                        for (PnSubCapitulo item: items){
                            if(idCapituloOld != item.getPnCapituloByIdCapitulo().getId()){
                                idCapituloOld = item.getPnCapituloByIdCapitulo().getId();
                    %>
                    <tr>
                        <th>
                            <%=item.getPnCapituloByIdCapitulo().getNumeroCapitulo()%>
                        </th>
                        <th colspan="1">
                            <img style="cursor: pointer;" src="images/help.png" onclick="muestraAyudaGeneral('evaluaCap-<%=item.getPnCapituloByIdCapitulo().getId()%>');" width="24" alt="Contenido" title="Contenido">
                            <%=item.getPnCapituloByIdCapitulo().getNombreCapitulo()%>
                        </th>
                        <th width="50" >Puntaje</th>
                        <th width="70" >Valor</th>
                        <th width="50" >
                            Total
                            <br>
                            <span class="color" id="t-<%=item.getPnCapituloByIdCapitulo().getId()%>"></span>
                        </th>
                    </tr>
                    <tr id="evaluaCap-<%=item.getPnCapituloByIdCapitulo().getId()%>" style="display:none;">
                        <td colspan="5">
                            <div class="textoCapitulos"><%=item.getPnCapituloByIdCapitulo().getEvaluaCapitulo()%></div>
                        </td>
                    </tr>
                    <%
                            }
                    %>
                    <tr>
                        <td>
                            <%=item.getCodigoItem()%>
                            <br>
                            <img style="cursor: pointer;" src="images/help.png" onclick="muestraAyuda('<%=item.getId()%>', true);" width="24" alt="Contenido" title="Contenido">
                        </td>
                        <td>
                            <%=item.getSubCapitulo()%>
                        </td>
                        <td align="right">
                            <%=item.getPonderacion()%>
                        </td>
                        <td>
                            <select onchange="sValorItem(<%=item.getId()%>, this);" name="i<%=item.getId()%>" id="i<%=item.getId()%>" class="selEval">
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
                        <td colspan="6">
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

                <%
                    if (!empleo.isEvaluaItems()) {
                %>
                <br>
                <button id="b1" class="btn  btn-primary" onclick="guardaItems(false);">Guardar Avance</button>
                <button id="b2" class="btn  btn-primary" onclick="guardaFinal();">Guardar Final</button>
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
<%

    }  //  END IF COMPLETO LA GLOBAL

    else {
%>
<div class="alert alert-danger">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    Debe completar la Eval. Global Individual
    <br>
    y
    <br>
    Debe completar la Eval. Capítulos Individual
</div>
<%
    }
%>

<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    <%
    if(cuantitativas.size()==0){  //  NO HAY VALORES
    %>
    $(".selEval option[value=50]").attr('selected','selected');
    <%
    }
    %>
    <%
        for (PnSubCapitulo item: items){
    %>
    var tmp<%=item.getId()%> = <%=item.getPonderacion()%>;
    <%
        }
    %>

    function guardaFinal(){
        if (confirm("Si acepta, no podra hacer mas cambios")) {
            if (confirm("Seguro")) {
                guardaItems(true);
            }
        }
    }

    function guardaItems(definitivo){
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

        if (definitivo) {
            disableId("b2");
        } else {
            disableId("b1");
        }

        pnRemoto.saveValoracionIndividualItems(definitivo, dataValores, function(data){
            if(data == 1){
                alert("Registro Correcto");
                window.location = "evalItemsInd.htm";
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

    function sValorItem(id, t){
//        alrt("t = " + t.value);
//        alert("id = " + id);
        var valor = $("#i"+id).val();
//        alrt("valor = " + valor);
        var aux = valor * eval('tmp'+id) / 100;
        
        dwr.util.setValue("l"+id, Math.ceil(aux));
        muestraAyuda(id, false);
    }

    <%
        int totalM = 0;
        for (MyKey key : pnManager.getTotalesItems(empleo.getIdEmpleado(), 3)) { //INDIVIDUAL
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


    <%
    if(empleo.isEvaluaItems()){
    %>
    $('#contenedor').find('select, textarea').attr('disabled','disabled');
    <%
    }
    %>

</script>