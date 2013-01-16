<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.Persona" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    List<Persona> personas = pnManager.getHibernateTemplate().find(
            "from Persona "
    );

%>
<div class="miembros">
    <table border="1">
        <thead>
        <tr>
            <th> Documento </th>
            <th> Nombre </th>
            <th> Apellido </th>
            <th> Email Corp.</th>
            <%--<th> Email Personal</th>--%>
            <th> Tel&eacute;fono </th>
            <th> Celular </th>
            <%--<th> Ciudad </th>--%>
        </tr>
        </thead>
        <%
            for (Persona persona: personas){
        %>
        <tr>
            <td> <%=persona.getDocumentoIdentidad() %></td>
            <td> <%=persona.getNombrePersona() %></td>
            <td> <%=persona.getApellido() %></td>
            <td> <%=persona.getEmailCorporativo() %></td>
            <%--<td> <%=persona.getEmailPersonal() %></td>--%>
            <td> <%=persona.getTelefonoFijo() %></td>
            <td> <%=persona.getCelular() %></td>
            <%--<td> <%=persona.getLocCiudadByIdCiudad().getNombreCiudad() %></td>--%>
        </tr>
        <%
            }
        %>
    </table>
</div>

<jsp:include page="c_footer_r.jsp"/>