<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    Persona persona = (Persona) session.getAttribute("persona");
    Empleado empleo = (Empleado) session.getAttribute("empleo");

    PnPremio premioActivo = (PnPremio) session.getAttribute("premioActivo");
    PnTipoPremio tipoPremio = (PnTipoPremio) session.getAttribute("tipoPremio");

    Texto titulo;
    if(tipoPremio == null){
        tipoPremio = new PnTipoPremio();
        titulo = pnManager.getTexto(11);
        tipoPremio.setNombreTipoPremio(titulo.getTexto1());
        tipoPremio.setFrase(titulo.getTexto3());
        tipoPremio.setUrlLogo("img/slider01/4.png");
    }
%>
<script type="text/javascript">
    function salir(){
        
        dwr.util.byId("exitF").submit();

    }
</script>
<header>
    <div class="container">
        <div class="row">
            <div class="span8">
                <div class="logo">
                    <img src="<%=tipoPremio.getUrlLogo()%>" width="180" style="margin: 5px 0px 5px 5px;float: left; ">
                    <h1><a>
                        <%=tipoPremio.getNombreTipoPremio()%>
                    </a></h1>
                    <div class="hmeta" style="text-transform:uppercase;">
                        <%=tipoPremio.getFrase()%>
                    </div>
                </div>
            </div>   <%--SPAN 12--%>
            <div class="span4">
                <div class="fosrm">
                    <%
                        if(tipoPremio != null){
                            if(premioActivo != null){
                    %>
                    Actualmente:
                    <b>
                        <%=premioActivo.getTipoPremioById().getSigla()%> -
                        <%=premioActivo.getNombrePremio()%>
                    </b>
                    <%
                            }  //  FIN IF PREMIO ACTIVO
                        }  //  FIN IF TIPO PREMIO
                    %>
                    <%
                        if(persona!=null){
                    %>
                    <br>
                    <img src="images/stock_people.png" width="30" alt="">
                    <%=persona.getNombreCompleto()%>
                    <%

                            if(empleo == null){ // NO TIENE UN EMPLEO SELECCIONADO
                    %>

                    <div class="alert alert-error">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                        No tiene un perfil seleccionado
                    </div>
                    <%
                        } else { // SI TIENE UN EMPLEO
                    %>
                    <br>
                    <strong><%=empleo.getPerfilByIdPerfil().getPerfil()%></strong>
                    <br>
                    en:
                    <%=empleo.getParticipanteByIdParticipante().getPnPremioByIdConvocatoria().getTipoPremioById().getSigla()%>
                    -
                    <%=empleo.getParticipanteByIdParticipante().getPnPremioByIdConvocatoria().getNombrePremio()%>
                    <br>
                    <%=empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa().getNombreEmpresa()%>
                    <%
                        }
                    %>
                    <%
                        } // END IF HAY PERSONA
                        if(tipoPremio.getId()!=0){
                    %>
                    <br>
                    <button type="button" onclick="salir();" class="btn btn-primary">Salir</button>
                    <%
                        }  //  END IF HAY TIPO DE PREMIO
                    %>
                   <form id="exitF" action="index.htm" method="post">
                        <input type="hidden" name="exit" value="1">
                    </form>
                    <%--<br>
                    <form method="get" id="searchform" action="#" class="form-search">
                        <input type="text" value="" name="s" id="s" class="input-medium"/>
                        <button type="submit" class="btn">Buscar</button>
                    </form>--%>
            
                </div>
            </div>
        </div>
    </div>
</header>