<%@ page import="co.com.elramireza.pn.model.Empresa" %>
<%@ page import="co.com.elramireza.pn.model.Empleado" %>
<%@ page import="co.com.elramireza.pn.model.Participante" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="co.com.elramireza.pn.model.Texto" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    String imgSrcRepor;
    imgSrcRepor = "http://cdn1.iconfinder.com/data/icons/prettyoffice4/128/report.png";
    imgSrcRepor = "http://cdn1.iconfinder.com/data/icons/Futurosoft%20Icons%200.5.2/128x128/mimetypes/document.png";

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
    if (
            (empleo.getPerfilByIdPerfil().getId() == 7
                    || empleo.getPerfilByIdPerfil().getId() == 1
                    || empleo.getPerfilByIdPerfil().getId() == 2
            )  // PARA LIDERES Y ADMON
//                    &&
//            participante.getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante() == 1

            ) { // SOLO PARA LIDER
%>
<a name="inicioResultados"></a>
<br>
<span class="color">Evaluadores:</span>
<blockquote>
    <%
//        System.out.println("empleo.getPerfilByIdPerfil().getId() = " + empleo.getPerfilByIdPerfil().getId());
        List<Empleado> evaluadoresFromParticipante = new ArrayList<Empleado>();
        if (empleo.getPerfilByIdPerfil().getId() == 7 ) { // SI ES LIDER
            evaluadoresFromParticipante = pnManager.getEvaluadoresFromParticipante(participante.getIdParticipante());
        } else if(empleo.getPerfilByIdPerfil().getId() == 2 ) {  // SI ES EVALUADOR
            evaluadoresFromParticipante.add(empleo);
        }

        for (Empleado evaluador : evaluadoresFromParticipante){
    %>
    <span class="color"><%=evaluador.getPerfilByIdPerfil().getPerfil()%></span>
    <%=evaluador.getPersonaByIdPersona().getNombreCompleto()%>
    <blockquote><span onclick="cargaResultado(<%=evaluador.getIdEmpleado()%>,'evalGlobalInd', 16);"><img src="<%=imgSrcRepor%>" width="36">
        Ind. Global
        <img width="28" src="img/<%=evaluador.isEvaluaGlobal()?"ok":"stop"%>.png" alt="">
        </span>
        <br>
        <span onclick="cargaResultado(<%=evaluador.getIdEmpleado()%>,'evalCapInd', 17);"><img src="<%=imgSrcRepor%>" width="36">
        Ind. Cap&iacute;tulos
        <img width="28" src="img/<%=evaluador.isEvaluaCapitulos()?"ok":"stop"%>.png" alt="">
        </span>
        <br>
        <span  onclick="cargaResultado(<%=evaluador.getIdEmpleado()%>,'evalItemsInd', 18);"><img src="<%=imgSrcRepor%>" width="36">
        Cuantitativa (&Iacute;tems)
        <img width="28" src="img/<%=evaluador.isEvaluaItems()?"ok":"stop"%>.png" alt="">
        </span>
    </blockquote>
    <br>
    <%
        }
    %>
</blockquote>
<%
    }
%>
<%--<jsp:include page="r_evalGlobalInd.jsp?id=8"/>--%>
<a name="aResultado"></a>
<br>
<a onclick="scrollToAnchor('inicioResultados')"><img width="32" src="images/back.png" alt="volver" title="volver">Ir arriba</a>
<div id="resultado">

</div>
<br>
<a href="pdfs/ip-<%=empresa.getNit()%>.pdf" target="<%=empresa.getNit()%>">
    <img src="img/pdf.png" alt="abrir" title="abrir" width="48">
    <span class="color">Informe de Postulaci&oacute;n PDF</span>
</a>
<br>
<a href="pdfs/cc-<%=empresa.getNit()%>.pdf" target="<%=empresa.getNit()%>">
    <img src="img/pdf.png" alt="abrir" title="abrir" width="48">
    <span class="color">Certificado Constituci&oacute;n Legal PDF</span>
</a>
<br>
<a href="pdfs/ef-<%=empresa.getNit()%>.pdf" target="<%=empresa.getNit()%>">
    <img src="img/pdf.png" alt="abrir" title="abrir" width="48">
    <span class="color">Estados Financieros (3 a&ntilde;os) PDF</span>
</a>
<br>
<a href="pdfs/co-<%=empresa.getNit()%>.pdf" target="<%=empresa.getNit()%>">
    <img src="img/pdf.png" alt="abrir" title="abrir" width="48">
    <span class="color">Recibo de Consignaci&oacute;n (50%) PDF</span>
</a>
<br>
<a onclick="scrollToAnchor('inicioResultados')"><img width="32" src="images/back.png" alt="volver" title="volver">Ir arriba</a>

<br>
<br>
<br>

<%
    } // FIN HAY EMPRESA
%>