<%@ page import="co.com.elramireza.pn.model.Servicio" %>
<%@ page import="co.com.elramireza.pn.model.Persona" %>
<%@ page import="co.com.elramireza.pn.model.ServicioRol" %>
<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.Empleado" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    Persona persona = (Persona) session.getAttribute("persona");
    Empleado empleo = (Empleado) session.getAttribute("empleo");
%>

<!-- Navigation bar starts -->
<div class="navbar">
    <div class="navbar-inner">
        <div class="container">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span>Menu</span>
            </a>
            <div class="nav-collapse collapse">
                <ul class="nav">
                    <%
                        if(persona != null && pnManager.isAdministrador(persona.getIdPersona())){ //SI ES ADMON LE CARGO PERFIL 1
                            List<ServicioRol> servicioRols = pnManager.getServiciosFromPerfil(1);
                    %>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administraci&oacute;n<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <%  for (ServicioRol servicioRol: servicioRols){
                            %>
                            <li><a href="<%=servicioRol.getServicioByIdServicio().getServicio()%>.htm"><%=servicioRol.getServicioByIdServicio().getTextoServicio()%></a></li>
                            <%
                                } // EN FOR SERVICIOS PERFIL 1
                            %>
                        </ul>
                    </li>
                    <%
                        }
                        for (Servicio servicio: pnManager.getServiciosPublicosVisibles()){
                    %>
                    <li><a href="<%=servicio.getServicio()%>.htm"><%=servicio.getTextoServicio()%></a></li>
                    <%
                        }

                        if(empleo != null && empleo.getPerfilByIdPerfil().getId()!=1){ // CARGO LOS SERVICIOS DEL PERFIL
                            List<ServicioRol> servicioRols = pnManager.getServiciosFromPerfil(
                                    empleo.getPerfilByIdPerfil().getId()
                            );
                    %>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><%=empleo.getPerfilByIdPerfil().getPerfil()%><b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <%
                                for (ServicioRol servicioRol: servicioRols){
                            %>
                            <li><a href="<%=servicioRol.getServicioByIdServicio().getServicio()%>.htm"><%=servicioRol.getServicioByIdServicio().getTextoServicio()%></a></li>
                            <%
                                } // EN FOR SERVICIOS PERFIL 1
                            %>
                        </ul>
                    </li>
                    <%
                        }

                        if(persona != null){
                    %>
                    <li><a href="chpass.htm">Cambio de Contrase&ntilde;a</a></li>
                    <%
                        }
                    %>
                    <%--
                    EDWARD
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Pages <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="pricing.html">Pricing Table</a></li>
                            <li><a href="features.html">Features</a></li>
                            <li><a href="support.html">Support</a></li>
                            <li><a href="sitemap.html">Sitemap</a></li>
                            <li><a href="404.html">404</a></li>
                            <li><a href="faq.html">FAQ</a></li>
                            <li><a href="register.html">Register</a></li>
                            <li><a href="login.html">Login</a></li>
                        </ul>
                    </li>
                    <li><a href="service.html">Service</a></li>
                    <li><a href="aboutus.html">About Us</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Blog <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="blog.html">Blog</a></li>
                            <li><a href="blog-single.html">Blog Single</a></li>
                        </ul>
                    </li>

                    <li><a href="portfolio.html">Portfolio</a></li>
                    <li><a href="contactus.html">Contact</a></li>--%>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Navigation bar ends -->