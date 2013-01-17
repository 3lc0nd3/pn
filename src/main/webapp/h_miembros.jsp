<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.Persona" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    List<Persona> personas = pnManager.getHibernateTemplate().find(
            "from Persona "
    );

%>
<div class="miembros">
    <table cellpadding="0" cellspacing="0" border="0" class="display" id="miembros">
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
            for (int i = 0; i<100; i++)
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

<script type="text/javascript">
    $(document).ready(function() {
        $('#miembros').dataTable( {
            "sPaginationType": "full_numbers", 
            "oLanguage": {
                "sLengthMenu": "Mostrar _MENU_ registros",
                "sZeroRecords": "Sin resultados",
                "sInfo": "Mostrando _START_ a _END_ de _TOTAL_ registros",
                "sInfoEmpty": "Mostrando 0 a 0 de 0 registros",
                "sInfoFiltered": "(Filtrado de _MAX_ registros en total)",
                "oPaginate": {
                    "sPrevious": "Anterior",
                    "sNext": "Siguiente",
                    "sFirst": "First page"
                }
            }
        } );
    } );
</script>