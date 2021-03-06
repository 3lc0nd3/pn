<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%

    PnPremio premioActivo = (PnPremio) session.getAttribute("premioActivo");
    PnTipoPremio tipoPremio = (PnTipoPremio) session.getAttribute("tipoPremio");

    long ct = System.currentTimeMillis();
    int idPerfil = 0;
    int idPerfilOriginal = 0;
    int vieneDeFront = 0;
    String imgSrcRepor;
    imgSrcRepor = "images/document.png";

    Empleado empleo = (Empleado) session.getAttribute("empleo");
//    System.out.println("empleo = " + empleo);
    Empresa empresa = (Empresa) request.getAttribute("empresa");
//    System.out.println("empresa = " + empresa);
    if(empresa!=null){
        vieneDeFront =1;
    }
        /**
         * RECARGO EL EMPLEADO SOLO SI NO ES ADMON
         */
    if(empresa == null){
        if (empleo!=null) {
            empleo = pnManager.getEmpleado(empleo.getIdEmpleado());
        }
    }

    Participante participante = null;
    if(empresa == null){ // NO VIENE DE FRONTCONTROLLER
        if(empleo != null){ // TIENE QUE ESTAR LOGUEADO
            empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();
            participante = pnManager.getParticipante(empleo.getParticipanteByIdParticipante().getIdParticipante());
        }
    }


    if (empleo == null) {  // SOLO PARA ADMON
        idPerfil = 1;
        idPerfilOriginal = 1;
    } else {
        idPerfil = empleo.getPerfilByIdPerfil().getId();
        idPerfilOriginal = empleo.getPerfilByIdPerfil().getId();
    }

    Empleado encargadoProceso=null;
    Participante participante1Req = (Participante) request.getAttribute("participante");
    if (participante1Req != null) { // SI VIENE DE  FRONTCONTROLLER
        vieneDeFront =1 ;
        participante = participante1Req;
        empresa = participante.getEmpresaByIdEmpresa();
        idPerfil = 7; // PARA QUE VEA TODOS LOS EVALUADORES

        List<Empleado> listaEncargado = pnManager.getHibernateTemplate().find(
                "from Empleado where participanteByIdParticipante.id = ? and perfilByIdPerfil.id=3",
                participante.getIdParticipante()
        );
        if(listaEncargado.size()>0){
            encargadoProceso = listaEncargado.get(0);
        }
    }

    System.out.println("DEsde ADMON jsp idPerfil = " + idPerfil);
    System.out.println("vieneDeFront = " + vieneDeFront);
    System.out.println("idPerfilOriginal = " + idPerfilOriginal);

//    if (empresa != null) {
//        System.out.println("empresa.getNombreEmpresa() = " + empresa.getNombreEmpresa());
//    }
    if(empresa != null && empresa.getIdEmpresa()!=1){ // HAY EMPRESA

%>

<h2>  <%=empresa.getNombreEmpresa()%></h2>
<span class="color">Direcci&oacute;n</span> <%=empresa.getDireccionEmpresa()%>
<%
    if(tipoPremio.getId()!=2){
%>
<br>
<span class="color">Categor&iacute;a</span> <%=empresa.getEmpresaCategoriaByIdCategoriaEmpresa().getCategoria()%>
<br>
<span class="color">Tama&ntilde;o</span> <%=empresa.getEmpresaCategoriaTamanoByIdCategoriaTamanoEmpresa().getTamano()%>
<%
    } // FIN ES TIPO 2 PEGI
%>
<%
    if(empleo!=null && empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa().getIdEmpresa()!=1){
%>
<br>
<span class="color">Etapa</span> <%=participante.getPnEtapaParticipanteByIdEtapaParticipante().getEtapaParticipante()%>
<%
    } // FIN ETAPA

    if(encargadoProceso!=null){  // ENCARGADO
%>
<br>
<h4>Encargado del Proceso</h4>
<span class="color">Nombre</span> <%=encargadoProceso.getPersonaByIdPersona().getNombreCompleto()%>
<br>
<span class="color">Celular</span> <%=encargadoProceso.getPersonaByIdPersona().getCelular()%>
<br>
<span class="color">Tel&eacute;fono</span> <%=encargadoProceso.getPersonaByIdPersona().getTelefonoFijo()%>
<br>
<span class="color">Email Corp</span> <%=encargadoProceso.getPersonaByIdPersona().getEmailCorporativo()%>
<br>
<span class="color">Email Personal</span> <%=encargadoProceso.getPersonaByIdPersona().getEmailPersonal()%>
<br>
<%
    } // FIN ENCARGADO

    if (true)  { // SOLO PARA LIDER
%>
<a name="inicioResultados"></a>
<%
    //        System.out.println("empleo.getPerfilByIdPerfil().getId() = " + empleo.getPerfilByIdPerfil().getId());
    List<Empleado> evaluadoresFromParticipante = new ArrayList<Empleado>();
    if (idPerfil == 7 ) { // SI ES LIDER
        evaluadoresFromParticipante = pnManager.getEvaluadoresFromParticipante(participante.getIdParticipante());
    } else if(idPerfil == 2 ) {  // SI ES EVALUADOR
        evaluadoresFromParticipante.add(empleo);
    }

    if(idPerfil == 7 && evaluadoresFromParticipante.size()>1){ // GARANTIZO QUE VIENE UN LIDER EVALUADOR
        Empleado lider = null;
        for (Empleado evaluador : evaluadoresFromParticipante){
            if(evaluador.getPerfilByIdPerfil().getId() == 7){
                lider = evaluador;
            }
        }
        List<PnValoracion>   datosConsensoGlobalFromEmpleado =       new ArrayList<PnValoracion>();
        List<PnValoracion>   datosConsensoCapitulosFromEmpleado =    new ArrayList<PnValoracion>();
        List<PnCuantitativa> datosCuantitativaConsensoFromEmpleado = new ArrayList<PnCuantitativa>();
        if(lider!=null){
            datosConsensoGlobalFromEmpleado = pnManager.getValoracionConsensoGlobalFromEmpleado(
                    lider.getIdEmpleado());
            datosConsensoCapitulosFromEmpleado = pnManager.getValoracionConsensoCapitulosFromEmpleado(
                    lider.getIdEmpleado());
            datosCuantitativaConsensoFromEmpleado = pnManager.getCuantitativaConsensoFromEmpleado(
                    lider.getIdEmpleado());

        }
%>
<br>
<blockquote>
    <span class="color">Evaluaci&oacute;n Consenso </span> <%=lider!=null?lider.getPersonaByIdPersona().getNombreCompleto():""%>
    <blockquote><span style="cursor: pointer;" onclick="cargaResultado(<%=lider.getIdEmpleado()%>,'evalGlobalCons', 16);"><img src="<%=imgSrcRepor%>" width="36">
        Eval. Global Individual
        <img width="28" src="img/<%=datosConsensoGlobalFromEmpleado.size()!=0?"ok":"stop"%>.png" alt="">
        </span>
        <br>
        <span style="cursor: pointer;" onclick="cargaResultado(<%=lider.getIdEmpleado()%>,'evalCapCons', 17);"><img src="<%=imgSrcRepor%>" width="36">
        Eval. Cap&iacute;tulos Individual
        <img width="28" src="img/<%=datosConsensoCapitulosFromEmpleado.size()!=0?"ok":"stop"%>.png" alt="">
        </span>
        <br>
        <span style="cursor: pointer;"  onclick="cargaResultado(<%=lider.getIdEmpleado()%>,'evalItemsCons', 18);"><img src="<%=imgSrcRepor%>" width="36">
        Eval.&Iacute;tems Individual
        <img width="28" src="img/<%=datosCuantitativaConsensoFromEmpleado.size()!=0?"ok":"stop"%>.png" alt="">
        </span>
    </blockquote>
    <br>
</blockquote>
<%
    }
%>
<br>
<span class="color">Evaluadores:</span>
<blockquote>
    <%
        for (Empleado evaluador : evaluadoresFromParticipante){
    %>
    <span class="color"><%=evaluador.getPerfilByIdPerfil().getPerfil()%></span>
    <%=evaluador.getPersonaByIdPersona().getNombreCompleto()%>
    <blockquote><span style="cursor: pointer;" onclick="cargaResultado(<%=evaluador.getIdEmpleado()%>,'evalGlobalInd', 16);"><img src="<%=imgSrcRepor%>" width="36">
        Eval. Global Individual
        <img width="28" src="img/<%=evaluador.isEvaluaGlobal()?"ok":"stop"%>.png" alt="">
        </span>
        <br>
        <span style="cursor: pointer;" onclick="cargaResultado(<%=evaluador.getIdEmpleado()%>,'evalCapInd', 17);"><img src="<%=imgSrcRepor%>" width="36">
        Eval. Cap&iacute;tulos Individual
        <img width="28" src="img/<%=evaluador.isEvaluaCapitulos()?"ok":"stop"%>.png" alt="">
        </span>
        <br>
        <span style="cursor: pointer;"  onclick="cargaResultado(<%=evaluador.getIdEmpleado()%>,'evalItemsInd', 18);"><img src="<%=imgSrcRepor%>" width="36">
        Eval.&Iacute;tems Individual
        <img width="28" src="img/<%=evaluador.isEvaluaItems()?"ok":"stop"%>.png" alt="">
        </span>
    </blockquote>
    <br>
    <%
        }  //  END FOR EVALUADORES
    %>
</blockquote>
<%
    }
%>
<%--<jsp:include page="r_evalGlobalInd.jsp?id=8"/>--%>
<a name="aResultado"></a>
<br>
<a style="cursor: pointer;" onclick="scrollToAnchor('inicioResultados')"><img width="32" src="images/back.png" alt="volver" title="volver">Ir arriba</a>
<div id="resultado">

</div>
<br>
<%
    if(participante!=null && participante.getFileInformePostula()!=null){
%>
<a href="pdfs/ip-<%=empresa.getNit()%>-<%=participante.getIdParticipante()%>.pdf?T=<%=ct%>" target="<%=empresa.getNit()%>">
    <img src="img/pdf.png" alt="abrir" title="abrir" width="48">
    <span class="color">Informe de Postulaci&oacute;n PDF</span>
</a>
<%
} else {
    if(participante!=null){
%>
<img src="img/stop.png" alt="abrir" title="abrir" width="48">
No hay Informe de Postulaci&oacute;n
<%
        }
    }
%>
<%
    if (idPerfil == 1 || idPerfil == 3 || vieneDeFront == 1) {
%>
<br>
<%
    if(empresa.getFileCertificadoConstitucion()!=null){
%>
<a href="pdfs/cc-<%=empresa.getNit()%>.pdf?T=<%=ct%>" target="<%=empresa.getNit()%>">
    <img src="img/pdf.png" alt="abrir" title="abrir" width="48">
    <span class="color">Certificado Constituci&oacute;n Legal PDF</span>
</a>
<%
    } else {
%>
<img src="img/stop.png" alt="abrir" title="abrir" width="48">
Certificado Constituci&oacute;n Legal
<%
    }
%>
<br>
<%
    if(tipoPremio.getId()!=2){

    if(empresa.getFileEstadoFinanciero()!=null){
%>
<a href="pdfs/ef-<%=empresa.getNit()%>.pdf?T=<%=ct%>" target="<%=empresa.getNit()%>">
    <img src="img/pdf.png" alt="abrir" title="abrir" width="48">
    <span class="color">Estados Financieros (3 a&ntilde;os) PDF</span>
</a>
<%
} else {
%>
<img src="img/stop.png" alt="abrir" title="abrir" width="48">
Estados Financieros (3 a&ntilde;os)
<%
    }
    }
%>
<br>
<%
    if(tipoPremio.getId()!=2){
    if(participante!=null && participante.getFileConsignacion()!=null){
%>
<a href="pdfs/co-<%=empresa.getNit()%>-<%=participante.getIdParticipante()%>.pdf?T=<%=ct%>" target="<%=empresa.getNit()%>">
    <img src="img/pdf.png" alt="abrir" title="abrir" width="48">
    <span class="color">Recibo de Consignaci&oacute;n (50%) PDF</span>
</a>
<%
} else {
    if(participante!=null){

%>
<img src="img/stop.png" alt="abrir" title="abrir" width="48">
Recibo de Consignaci&oacute;n (50%)
<%
        }
    }
    }
%>
<%
    }  /* END MUESTRA ARCHIVOS SEGUN PERFILES  */
%>
<br>
<a style="cursor: pointer;" onclick="scrollToAnchor('inicioResultados')"><img width="32" src="images/back.png" alt="volver" title="volver">Ir arriba</a>

<br>
<br>
<br>

<%
    } // FIN HAY EMPRESA
%>