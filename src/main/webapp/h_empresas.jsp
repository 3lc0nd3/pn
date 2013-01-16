<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.Persona" %>
<%@ page import="co.com.elramireza.pn.model.Empresa" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    List<Empresa> empresas = pnManager.getHibernateTemplate().find(
            "from Empresa "
    );

%>

<div class="row">

<div class="miembros">
    <table border="1" width="100%">
        <thead>
        <tr>
            <th> Nit </th>
            <th> Nombre </th>
            <th> Direcci&oacute;n </th>
            <th> Categor&iacute;a </th>
            <th> Tama&ntilde;o</th>
            <%--<th> Email Personal</th>--%>
            <th> Tel&eacute;fono </th>
            <th> Email </th>
            <th> Ciudad </th>
            <th width="40"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </th>
        </tr>
        </thead>
        <%
            for (Empresa empresa: empresas){
        %>
        <tr>
            <td> <%=empresa.getNit() %></td>
            <td> <%=empresa.getNombreEmpresa() %></td>
            <td> <%=empresa.getDireccionEmpresa() %></td>
            <td> <%=empresa.getEmpresaCategoriaByIdCategoriaEmpresa().getCategoria() %></td>
            <td> <%=empresa.getEmpresaCategoriaTamanoByIdCategoriaTamanoEmpresa().getTamano() %></td>
            <td> <%=empresa.getTelFijoEmpresa() %></td>
            <td> <%=empresa.getEmailEmpresa() %></td>
            <td> <%=empresa.getLocCiudadByIdCiudad().getNombreCiudad() %></td>
            <td><img width="36" onclick="revisaEmpresa(<%=empresa.getId()%>);" src="img/ojo.png" alt="ver" title="ver"></td>
        </tr>
        <%
            }
        %>
    </table>
</div>
<br>
<div id="empresaDiv"></div>

</div>

<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">
    function revisaEmpresa(id){
        frontController.getIncludeEmpresaAdmon(id, function(data){
            dwr.util.setValue("empresaDiv", data, { escapeHtml:false });
        });
    }
</script>