<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Texto texto16 = pnManager.getTexto(18);
    Empleado empleo = (Empleado) session.getAttribute("empleo");
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
                        <th colspan="1">
                            <%=item.getPnCapituloByIdCapitulo().getNombreCapitulo()%>
                        </th>
                        <th width="50" >Puntaje</th>
                        <th width="50" >Valor</th>
                        <th width="50" >Total</th>
                    </tr>
                    <%
                            }
                    %>
                    <tr>
                        <td>
                            <%=item.getSubCapitulo()%>
                        </td>
                        <td align="right">
                            <%=item.getPonderacion()%>
                        </td>
                        <td>
                            <select onchange="sValorItem(<%=item.getId()%>);" name="i<%=item.getId()%>" id="i<%=item.getId()%>" class="btn-primary selEval">
                            <%
                                for (Integer v: pnManager.getValoresValoracion()){
                            %>
                                <option class="btn-primary selEval" value="<%=v%>"><%=v%></option>
                            <%
                                }
                            %>
                            </select>
                        </td>
                        <td align="right">
                            <span style="text-align:right;" id="l<%=item.getId()%>">0</span>
                        </td>
                    </tr>
                    
                    <%
                        }
                    %>
                </table>
                <br>
                <button id="b1" class="btn  btn-primary" onclick="guardaItems();">Guardar</button>
                <%
                    if(cuantitativas.size()>0){ // SOLO SI HAY DATA
                %>
                <button id="b2" class="btn  btn-primary" onclick="saltaAVisita();">Avanza a Agenda de Visita</button>
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

        pnRemoto.saveValoracionDespuesVisitaItems(dataValores, function(data){
            if(data == 1){
                alert("Registro Correcto");
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
    }

    <%
        for(PnCuantitativa item:  cuantitativas){
    %>
        dwr.util.setValue("i<%=item.getPnSubCapituloByIdSubCapitulo().getId()%>", <%=item.getValor()%>);
        dwr.util.setValue("l<%=item.getPnSubCapituloByIdSubCapitulo().getId()%>", <%=item.getTotal()%>);
    <%
        }
    %>

</script>