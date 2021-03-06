<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%

    Texto texto22 = pnManager.getTexto(22);
    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Empresa empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();
    Participante participante = pnManager.getParticipante(empleo.getParticipanteByIdParticipante().getIdParticipante());
    List<PnRetroalimentacion> retros = pnManager.getPnRetroalimentaciones(
            empleo.getParticipanteByIdParticipante().getIdParticipante()
    );

%>





<individual>
    <div class="container">
        <div class="row">
            <div class="span8">
                <h2>Informe de Retroalimentaci&oacute;n</h2>
                para <strong><%=empresa.getNombreEmpresa()%></strong>

                <%
                    //  SOLO PARA ETAPA 5
                    if (participante.getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante() != 5) {
                %>
                <div class="alert">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <%=texto22.getTexto1()%>
                    <img src="img/stop.png" width="50">
                </div>
                <%
                    } else {

                        if(retros.size()==0){
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
                    Datos ingresados el <%=pnManager.dfDateTime.format(retros.get(0).getFechaCreacion())%>
                </div>
                <%--<a href="h_informeRetroW.jsp">Exportar <img src="img/word.png" alt="Word" title="Word" width="36"></a>--%>
                <br>
                <br>
                <%
                        }
                %>
                <table border="1" width="100%" align="center">
                <%
                    for (PnRetroalimentacion retro : retros){
                %>
                    <tr>
                        <th>
                            <%=retro.getPnCapituloByIdPnCapitulo().getNombreCapitulo()%>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <strong>Fortalezas</strong>
                            <br>
                            <%=retro.getFortalezas().replace("\n", "<br>")%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Oportunidades</strong>
                            <br>
                            <%=retro.getOportunidades().replace("\n", "<br>")%>
                        </td>
                    </tr>
                <%
                    }
                %>
                </table>
                <%
                    }  //  END IF ETAPA 5
                %>
            </div>
            <div class="span4">
                <jsp:include page="c_empresa_admon.jsp"    />
            </div>
        </div>

    </div>
</individual>



<jsp:include page="c_footer_r.jsp"/>