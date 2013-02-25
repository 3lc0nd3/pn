<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%@ page import="co.com.elramireza.pn.model.Persona" %>
<%@ page import="static java.text.MessageFormat.format" %>
<%@ page import="co.com.elramireza.pn.model.Servicio" %>
<jsp:include page="c_head.jsp"/>

<%


    String username = request.getParameter("username");
    String password = request.getParameter("password");

    String mensajeLogin = "";

    if (username != null && password != null) {
        Persona personaLogin = pnManager.getPersonaFromLoginPassword(username, password);
        System.out.println("personaLogin = " + personaLogin);
        if(personaLogin != null){
            mensajeLogin = "Bienvenido: " + personaLogin.getNombreCompleto();
            session.setAttribute("persona", personaLogin);
//            persona = personaLogin;
        } else {
            mensajeLogin = "Error en datos de ingreso";
        }
    }

    request.setAttribute("mensajeLogin", mensajeLogin);

    String exit = request.getParameter("exit");
    if(exit!=null){ // TOCA SALIR
        session.removeAttribute("persona");
        session.removeAttribute("empleo");
//        persona = null;
//        response.sendRedirect("/");
    }

    String cambiarPerfil = request.getParameter("cambiarPerfil");
    if(cambiarPerfil != null){
        session.removeAttribute("empleo");
    }


%>

<!-- Header Starts -->

<jsp:include page="c_banner.jsp"/>


<jsp:include page="c_menu_index.jsp"/>



<div class="content">
<div class="container">

<%
    String servicio = (String) request.getAttribute("servicio");
    // TODO SECURITY
    Servicio servicioModel = pnManager.getServicioFromName(servicio);
    Persona persona = (Persona) session.getAttribute("persona");

    if(persona == null && servicioModel.getPublico()==0){
        servicio = "index";
        request.setAttribute("mensajeLogin", "Por favor ingrese al Sistema !!!");
    }

//    System.out.println("servicio = " + servicio);
    if(servicio!= null){
        servicio = format("h_{0}.jsp", servicio);
        try{
%>
    <jsp:include page="<%=servicio%>"/>
<%
    } catch (Exception jasperException){

    }
    }
%>


