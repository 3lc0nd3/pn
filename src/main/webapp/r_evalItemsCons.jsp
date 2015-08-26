<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="co.com.elramireza.pn.util.MyKey" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />


<%
    int idEmpleado;

    String id = request.getParameter("id");
    Texto nombre = new Texto();
    if (id == null) {
        idEmpleado  = (Integer) request.getAttribute("id");
//        System.out.println("nombre = " + nombre);
    } else {
        idEmpleado = Integer.parseInt(id);
    }
    nombre      = (Texto) request.getAttribute("nombre");

    Empleado empleado = pnManager.getEmpleado(idEmpleado);

    List<PnCuantitativa> cuantitativas = pnManager.getCuantitativaConsensoFromEmpleado(
            idEmpleado);

    List<MyKey> totalesItems = pnManager.getTotalesItems(idEmpleado, 4); // 4 ITEM CONS
    System.out.println("totalesItems.size() = " + totalesItems.size());

%>
<br>
<b>Evaluaci&oacute;n</b>
<br>
<h3><%=nombre.getTexto2()%></h3>
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
            if (oldIdCapitulo != c.getPnSubCapituloByIdSubCapitulo().getPnCapituloByIdCapitulo().getNumeroCapitulo()) { //DIFERENTES
                oldIdCapitulo = c.getPnSubCapituloByIdSubCapitulo().getPnCapituloByIdCapitulo().getNumeroCapitulo();
    %>
    <tr class="btn-inverse">
        <th align="center" >
            <%=c.getPnSubCapituloByIdSubCapitulo().getPnCapituloByIdCapitulo().getNumeroCapitulo()%>
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