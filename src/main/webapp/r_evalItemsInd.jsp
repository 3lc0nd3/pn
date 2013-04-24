<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="co.com.elramireza.pn.util.MyKey" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />


<%
    int idEmpleado;

    String id = request.getParameter("id");
    String nombre = "";
    if (id == null) {
        idEmpleado  = (Integer) request.getAttribute("id");
//        System.out.println("nombre = " + nombre);
    } else {
        idEmpleado = Integer.parseInt(id);
    }
    nombre      = (String) request.getAttribute("nombre");

    Empleado empleado = pnManager.getEmpleado(idEmpleado);

    List<PnCuantitativa> cuantitativas = pnManager.getCuantitativaIndividualFromEmpleado(
            idEmpleado);

    List<MyKey> totalesItems = pnManager.getTotalesItems(idEmpleado, 3);
    System.out.println("totalesItems.size() = " + totalesItems.size());

%>
<br>
<b>Evaluaci&oacute;n</b>
<br>
<h3><%=nombre%></h3>
<b>de</b>
<br>
<h3><%=empleado.getPersonaByIdPersona().getNombreCompleto()%></h3>
<table border="1" width="100%">
    <%
        int total = 0;
        int cap = 0;
        int oldIdCapitulo = 0;
        for (PnCuantitativa c: cuantitativas){
            total += c.getTotal();
            if (oldIdCapitulo != c.getPnSubCapituloByIdSubCapitulo().getPnCapituloByIdCapitulo().getId()) { //DIFERENTES
                oldIdCapitulo = c.getPnSubCapituloByIdSubCapitulo().getPnCapituloByIdCapitulo().getId();
    %>
    <tr class="btn-inverse">
        <th align="center" >
            <%=c.getPnSubCapituloByIdSubCapitulo().getPnCapituloByIdCapitulo().getId()%>
        </th>
        <th align="center">
            <%=c.getPnSubCapituloByIdSubCapitulo().getPnCapituloByIdCapitulo().getNombreCapitulo()%>
        </th>
        <th width="50" >Punt. Max.</th>
        <th width="50" >Valor</th>
        <th width="50" >
            Total
            <br>
            <%=totalesItems.get(oldIdCapitulo-1).getValue()%>
        </th>
    </tr>
    <%
            }
    %>
    <tr>
        <td>
            <%=c.getPnSubCapituloByIdSubCapitulo().getCodigoItem()%>
        </td>
        <td>
            <%=c.getPnSubCapituloByIdSubCapitulo().getSubCapitulo()%>
        </td>
        <td align="right">
            <%=c.getPnSubCapituloByIdSubCapitulo().getPonderacion()%>
        </td>
        <td align="right">
            <%=c.getValor()%>%
        </td>
        <td align="right">
            <%=c.getTotal()%>
        </td>
    </tr>
    <%
            }
    %>
    <tr>
        <th colspan="4">TOTAL</th>
        <th><%=total%></th>
    </tr>
</table>