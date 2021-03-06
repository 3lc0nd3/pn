<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="co.com.elramireza.pn.dao.PnDAO" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Texto texto16 = pnManager.getTexto(17);
    Texto texto19 = pnManager.getTexto(19);
    Texto texto20 = pnManager.getTexto(21);
    Texto texto23 = pnManager.getTexto(23);

    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Empresa empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();

    List<PnPrincipioCualitativo> principioCualitativos = pnManager.getHibernateTemplate().find(
            "from PnPrincipioCualitativo where pnTipoPremioById.id=?",
            empleo.getParticipanteByIdParticipante().getPnPremioByIdConvocatoria().getTipoPremioById().getId()
    );

    List<PnCategoriaCriterio> categoriasCriterio = pnManager.getCategoriasCriterio(
            empleo.getParticipanteByIdParticipante().getPnPremioByIdConvocatoria().getTipoPremioById().getId()
    );
//    categoriasCriterio.remove(categoriasCriterio.size()-1);

    List<PnCapitulo> pnCapitulos = pnManager.getPnCapitulos(
            empleo.getParticipanteByIdParticipante().getPnPremioByIdConvocatoria().getTipoPremioById().getId()
    );

    List<PnValoracion> fromParticipante = pnManager.getValoracionIndividualCapitulosFromEmpleado(
            empleo.getIdEmpleado());

    List<PnCualitativa> cualitativas = pnManager.getPnCualitativasFromEmpleadoTipoFormato(
            empleo.getIdEmpleado(), 2 // FORMATO 2 INDIVIDUALPOR CAPITULO
    );

    empleo = pnManager.getEmpleado(empleo.getIdEmpleado());

    if(empleo.isEvaluaGlobal()){  //  IF COMPLETO LA GLOBAL

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
                    System.out.println("fromParticipante.size() = " + fromParticipante.size());
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
                    Datos ingresados el
                    <%=pnManager.dfDateTime.format(
//                        cualitativas.get(0).getFechaCreacion()
                            fromParticipante.get(0).getFecha()
                    )%>
                    <%
                        if (empleo.isEvaluaCapitulos()) {
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

                    //MEGA FOR DE CAPITULOS
                    for (PnCapitulo capitulo: pnCapitulos){
                        String bg;
                        if(capitulo.getId()%2 == 1){
                            bg = "#dad9d9";
                        } else {
                            bg = "#eeeded";
                        }

                        PnCualitativa cualitativa = pnManager.getPnCualitativa(2, capitulo.getId(), empleo);
                %>
                <br>
                <div class="esquinasRedondas" style="background-color:<%=bg%>; text-align:center;">
                    <br>
                    <h4 class="color">
                        <img style="cursor: pointer;" src="images/help.png" onclick="muestraAyudaGeneral('evaluaCap-<%=capitulo.getId()%>');" width="24" alt="Contenido" title="Contenido">
                        <%=capitulo.getNombreCapitulo()%></h4>
                    <div id="evaluaCap-<%=capitulo.getId()%>" class="textoCapitulos" style="display:none;"><%=capitulo.getEvaluaCapitulo()%></div>
                    <br>
                    <table border="1" width="70%" align="center">
                        <%
                            for (PnPrincipioCualitativo principioCualitativo: principioCualitativos){
                        %>
                        <tr><th class="alert-info">
                            <img style="cursor: pointer;" src="images/help.png" onclick="muestraAyudaCualitativa('<%=principioCualitativo.getCampo()%>','<%=capitulo.getId()%>', true);" width="24" alt="Contenido" title="Contenido">
                            <%=principioCualitativo.getNombreCualitativa()%></th>
                        </tr>
                        <tr>
                            <td class="contenido" bgcolor="white">
                            <span id="<%=principioCualitativo.getCampo()%>-<%=capitulo.getId()%>">
                                <%
                                    Class noparams[] = {};
                                    Class cls = Class.forName("co.com.elramireza.pn.model.PnCualitativa");
                                    Object obj = cualitativa;
                                    String campo = principioCualitativo.getCampo().substring(0, 1).toUpperCase() + principioCualitativo.getCampo().substring(1);
                                    java.lang.reflect.Method method =  cls.getDeclaredMethod("get"+campo, noparams);
                                    String res = (String) method.invoke(obj, null);
                                %>
                                <%=res%>
                            </span>
                                <br>
                                <br>
                                <a onclick="editarCualitativa('<%=principioCualitativo.getCampo()%>', <%=capitulo.getId()%>);">
                                    <img src="images/edit.png" alt="Editar">
                                    Editar
                                </a>
                            </td>
                        </tr>
                        <tr id="<%=principioCualitativo.getCampo()%>-tr-<%=capitulo.getId()%>" style="display:none;"><td>
                            <textarea id="<%=principioCualitativo.getCampo()%>-text-<%=capitulo.getId()%>" class="field span6" placeholder="" rows="4" cols="10"></textarea>
                            <img  style="margin-bottom: 12px;" src="img/atencion.gif" width="25" height="25" alt="">
                            <a style="margin-bottom: 15px;" class="btn btn-danger" onclick="guardaCualitativa('<%=principioCualitativo.getCampo()%>', <%=capitulo.getId()%>);">Guardar</a>
                            <%--<br>&nbsp;--%>
                        </td></tr>
                        <tr id="<%=principioCualitativo.getCampo()%>-<%=capitulo.getId()%>-contenido" style="display:none;">
                            <td  class="contenido">
                                <%=pnManager.txtToHtml(principioCualitativo.getTextoCualitativa())%>
                            </td>
                        </tr>
                        <%
                            }  //  END FOR principioCualitativos
                        %>
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
                                <img style="cursor: pointer;" src="images/help.png" onclick="muestraAyudaCriterio('<%=criterio.getId()%>','<%=capitulo.getId()%>', true);" width="24" alt="Contenido" title="Contenido">
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
                    <br>&nbsp;  <button id="b1" class="btn  btn-primary" onclick="guardaIndividualCapitulos(false);">Guardar Avance</button>
                </div>
                <%
                    } //  END DEL MEGA FOR DE CAPITULOS
                %>
                <%
                    if (!empleo.isEvaluaCapitulos()) {
                %>
                <br>
                <button id="b2" class="btn  btn-primary" onclick="guardaFinal();">Guardar Final</button>
                <%
                    }
                %>
            </div><%--  FIN SPAN8 --%>
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
</div>
<%
    }
%>

<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function guardaFinal(){
        if (confirm("Si acepta, no podra hacer mas cambios")) {
            if (confirm("Seguro")) {
                guardaIndividualCapitulos(true);
            }
        }
    }

    function guardaIndividualCapitulos(definitivo){

        var dataValores = new Array();

        <%

                            int total=0;
            for (PnCapitulo capitulo : pnCapitulos) {
        %>
        <%
                for (PnCriterio criterio : pnManager.getPnCriterios(empleo.getParticipanteByIdParticipante().getPnPremioByIdConvocatoria().getTipoPremioById().getId())){
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

        pnRemoto.saveValoracionIndividualCapitulos(definitivo,
                dataValores, function(data){
                    if(data == 1){
                        alert("Registro Correcto");
                        window.location = "evalCapInd.htm";
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

//                       System.out.println("fromParticipante.size() = " + fromParticipante.size());
                    if(fromParticipante.size()>0){  // SOLO SI HAY VALORACION
                        for (PnValoracion valoracion : fromParticipante){
//                        System.out.println("valoracion.getPnCapituloByIdCapitulo().getId() = " + valoracion.getPnCapituloByIdCapitulo().getId());
//                        System.out.println("\tvaloracion.getPnCriterioByIdPnCriterio().getId() = " + valoracion.getPnCriterioByIdPnCriterio().getId());
                            if(valoracion.getPnCriterioByIdPnCriterio().getId()==1){ // CUANDO REINICIA EL CAPITULO
                                total = 0;
                            }
                           if (valoracion.getPnCriterioByIdPnCriterio().getId()!= 15){
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
                            System.out.println("NO HAY DATOS IND. CAPITULO");
                            }
                    if(cualitativas != null){
                        for (PnCualitativa cualitativa: cualitativas){
    %>
    //    try{
    <%--dwr.util.setValue(          "vision-<%=cualitativa.getPnCapituloByIdCapitulo().getId()%>",  poneSaltosDeLinea('<%=cualitativa.getVision().replaceAll("\n", "<br>").replaceAll("\r", "").replace("'","\"")%>'));--%>
    <%--dwr.util.setValue(      "fortalezas-<%=cualitativa.getPnCapituloByIdCapitulo().getId()%>",  poneSaltosDeLinea('<%=cualitativa.getFortalezas().replaceAll("\n", "<br>").replaceAll("\r", "").replace("'","\"")%>'));--%>
    <%--dwr.util.setValue(   "oportunidades-<%=cualitativa.getPnCapituloByIdCapitulo().getId()%>",  poneSaltosDeLinea('<%=cualitativa.getOportunidades().replaceAll("\n", "<br>").replaceAll("\r", "").replace("'","\"")%>'));--%>
    <%--dwr.util.setValue("pendientesVisita-<%=cualitativa.getPnCapituloByIdCapitulo().getId()%>",  poneSaltosDeLinea('<%=cualitativa.getPendientesVisita().replaceAll("\n", "<br>").replaceAll("\r", "").replace("'","\"")%>'));--%>
    //    } catch(err){

    //    }
    <%
                        } // FOR CUALITATIVAS
                    } // IF NULL
    %>

    <%
    if(empleo.isEvaluaCapitulos()){
    %>
    $('#contenedor').find('select, textarea').attr('disabled','disabled');
    <%
    }
    %>

    /**
     fortalezas oportunidades pendientesVisita vision
     */
    function editarCualitativa(campo, idCapitulo) {
        pnRemoto.getPnCualitativa(2, idCapitulo, null, function(data){
//            alert("data = " + data[campo]);
            $("#"+campo+"-tr-"+idCapitulo).show();
            dwr.util.setValue(campo+"-text-"+idCapitulo, data[campo]);

            var SearchInput = $("#"+campo+"-text-"+idCapitulo);

            // Multiply by 2 to ensure the cursor always ends up at the end;
            // Opera sometimes sees a carriage return as 2 characters.
            var strLength= SearchInput.val().length * 2;

            SearchInput.focus();
            SearchInput[0].setSelectionRange(strLength, strLength);
        });
    }

    function guardaCualitativa(campo, idCapitulo){
        var txt = dwr.util.getValue(campo+"-text-"+idCapitulo);
//        alert("txt = " + txt);
        pnRemoto.actualizaCualitativa(2, idCapitulo, txt, campo, function(data){
//            alert("data = " + data);
            dwr.util.setValue(campo+"-"+idCapitulo, data[campo]);
            dwr.util.setValue(campo+"-text-"+idCapitulo, "");
            $("#"+campo+"-tr-"+idCapitulo).hide();

            alrt("Guardado");
        });
    }
</script>