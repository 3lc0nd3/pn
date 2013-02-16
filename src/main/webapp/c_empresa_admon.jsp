<%@ page import="co.com.elramireza.pn.model.Empresa" %>
<%@ page import="co.com.elramireza.pn.model.Empleado" %>
<%@ page import="co.com.elramireza.pn.model.Participante" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%

    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Empresa empresa = (Empresa) request.getAttribute("empresa");
    Participante participante = null;
    if(empresa == null){ // NO VIENE DE FRONTCONTROLLER
        if(empleo != null){ // TIENE QUE ESTAR LOGUEADO
            empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();
            participante = pnManager.getParticipante(empleo.getParticipanteByIdParticipante().getIdParticipante());
        }
    }

    if(empresa != null && empresa.getIdEmpresa()!=1){ // HAY EMPRESA

%>

<h2><%=empresa.getNombreEmpresa()%></h2>
<span class="color">Direcci&oacute;n</span> <%=empresa.getDireccionEmpresa()%>
<br>
<span class="color">Categor&iacute;a</span> <%=empresa.getEmpresaCategoriaByIdCategoriaEmpresa().getCategoria()%>
<br>
<span class="color">Tama&ntilde;o</span> <%=empresa.getEmpresaCategoriaTamanoByIdCategoriaTamanoEmpresa().getTamano()%>
<%
    if(empleo!=null && empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa().getIdEmpresa()!=1){
%>
<br>
<span class="color">Etapa</span> <%=participante.getPnEtapaParticipanteByIdEtapaParticipante().getEtapaParticipante()%>
<%
    }
%>
<br>
<span class="color">Informe de Postulaci&oacute;n PDF</span> <a href="pdfs/ip-<%=empresa.getNit()%>.pdf" target="<%=empresa.getNit()%>"><img src="img/pdf.png" alt="abrir" title="abrir" width="48"></a>
<br>
<span class="color">Certificado Constituci&oacute;n Legal PDF</span> <a href="pdfs/cc-<%=empresa.getNit()%>.pdf" target="<%=empresa.getNit()%>"><img src="img/pdf.png" alt="abrir" title="abrir" width="48"></a>
<br>
<span class="color">Estados Financieros (3 a&ntilde;os) PDF</span>   <a href="pdfs/ef-<%=empresa.getNit()%>.pdf" target="<%=empresa.getNit()%>"><img src="img/pdf.png" alt="abrir" title="abrir" width="48"></a>
<br>
<span class="color">Recibo de Consignaci&oacute;n (50%) PDF</span>   <a href="pdfs/co-<%=empresa.getNit()%>.pdf" target="<%=empresa.getNit()%>"><img src="img/pdf.png" alt="abrir" title="abrir" width="48"></a>
<br>

<br>
<br>
<br>

<%
    } // FIN HAY EMPRESA
%>