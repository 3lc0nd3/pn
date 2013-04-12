<%@ page import="java.util.ArrayList" %>
<%@ page import="co.com.elramireza.pn.model.Texto" %>
<%@ page import="co.com.elramireza.pn.model.Participante" %>
<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.Empresa" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<h1> Participantes</h1>
<table border="1">


<%
    List<Participante> participantes = pnManager.getParticipantes();

    for (int i = 0; i < participantes.size(); i++) {
        Participante participante = participantes.get(i);
        participante.setFileInformePostula("ip-"+participante.getEmpresaByIdEmpresa().getNit()+"-"+participante.getIdParticipante()+".pdf");
        participante.setFileConsignacion("co-"+participante.getEmpresaByIdEmpresa().getNit()+"-"+participante.getIdParticipante()+".pdf");
        pnManager.getHibernateTemplate().update(participante);
%>

    <tr>
        <td>
            <%=participante.getEmpresaByIdEmpresa().getNombreEmpresa()%>
        </td>
        <td>
            <%=participante.getIdParticipante()%>
        </td>
        <td>
            <%=participante.getEmpresaByIdEmpresa().getNit()%>
        </td>
        <td>
            <%=participante.getFileInformePostula()%>
        </td>
        <td>
            <%=participante.getFileConsignacion()%>
        </td>
    </tr>
<%

    }
%>
</table>
<br>

<h1>Empresas</h1>

<table border="1">
    <%
        List<Empresa> empresas = pnManager.getEmpresas();
        for (int i = 0; i < empresas.size(); i++) {
            Empresa empresa = empresas.get(i);
            empresa.setFileCertificadoConstitucion("cc-"+empresa.getNit()+".pdf");
            empresa.setFileEstadoFinanciero("ef-" + empresa.getNit() + ".pdf");
            pnManager.getHibernateTemplate().update(empresa);
    %>
    <tr>
        <td>
            <%=empresa.getNombreEmpresa()%>
        </td>
        <td>
            <%=empresa.getIdEmpresa()%>
        </td>
        <td>
            <%=empresa.getNit()%>
        </td>
        <td>
            <%=empresa.getFileCertificadoConstitucion()%>
        </td>
        <Td>
            <%=empresa.getFileEstadoFinanciero()%>
        </Td>
    </tr>
    <%
        }
    %>
</table>