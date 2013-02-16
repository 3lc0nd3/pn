<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%


    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Empresa empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();

    List<PnRetroalimentacion> retros = pnManager.getPnRetroalimentaciones(
            empleo.getParticipanteByIdParticipante().getIdParticipante()
    );

    SimpleDateFormat dfL = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
    String nombre = "informe_"+empresa.getNombreEmpresa()+"_"+dfL.format(new Date())+".doc";

    response.setContentType( "application/x-download" );
    response.setHeader("Content-type","application/vnd.ms-word");
    response.setHeader("Content-Disposition","attachment; filename=\""+ nombre + "\"");
%>



<html>
    <body>


                <h2>Informe de Retroalimentaci&oacute;n</h2>
                para <strong><%=empresa.getNombreEmpresa()%></strong>


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
                            <%=retro.getFortalezas()%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Oportunidades</strong>
                            <br>
                            <%=retro.getOportunidades()%>
                        </td>
                    </tr>
                <%
                    }
                %>
                </table>


    </body>
</html>