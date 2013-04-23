<%@ page import="co.com.elramireza.pn.model.Persona" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    int myid = 23;
    Persona persona = (Persona) session.getAttribute("persona");
    if(persona == null){
%>
<h1>no way</h1>
<%

    } else if(persona.getIdPersona()!=myid){
%>
<h1>almost</h1>
<%
    } else {
        String idS = request.getParameter("newId");
        if(idS == null){
%>
<h3>newId?</h3>
<%
        } else {
            int id = Integer.parseInt(idS);
            Persona newPersona = pnManager.getPersona(id);
            session.setAttribute("persona", newPersona);
            response.sendRedirect("index.htm");
        }
%>

<%
    }
%>