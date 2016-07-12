<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="co.com.elramireza.sw.dao.SwDAO" %>
<%@ page import="static java.lang.Integer.parseInt" %>
<%@ page import="co.com.elramireza.sw.model.Archivo" %>
<%@ page import="co.com.elramireza.sw.model.Outbox" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.hibernate.criterion.DetachedCriteria" %>
<%@ page import="org.hibernate.criterion.Restrictions" %>
<%@ page import="java.util.Calendar" %>
<jsp:useBean id="smsManager" class="co.com.elramireza.sw.dao.SwDAO" scope="application"/>
<%--<%@page contentType="application/vnd.ms-excel"%>--%>
<%!
    SimpleDateFormat dfLarge = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Logger logger = Logger.getLogger(SwDAO.class);

    /**
     * estado segun el campo processed y el campo error
     *
     * @param outbox a
     * @return estado
     */
    String getEstado(Outbox outbox){
        if (outbox.getError() == 0) {
            switch (outbox.getProcessed()){
                case 3 : return "Pendiente";
                case 0 : return "* En Proceso";
                case 1 : return "-> Enviado";
                default: return "";
            }
        } else {
            return "Error enviando";
        }
    }

    /**
     * fecha de envio solo para los enviados
     * @param outbox a
     * @return fecha
     */
    String getFechaEnvio(Outbox outbox){
        if(outbox.getProcessed() == 1){
//            logger.debug("outbox.getIdPnPremio() = " + outbox.getIdPnPremio());
//            logger.debug("outbox.getProcessedDate() = " + outbox.getProcessedDate());
            String s;
            if (outbox.getProcessedDate() != null) {
                s = dfLarge.format(outbox.getProcessedDate());
            } else {
                s = "";
            }
            return s;
        } else {
            return "";
        }
    }
%>

<html>
    <body>
<%


    SimpleDateFormat dfL = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
    String nombre = "reporte_SMS_"+dfL.format(new Date())+".xls";

    response.setContentType( "application/x-download" );
    response.setHeader("Content-type","application/vnd.ms-excel");
    response.setHeader("Content-Disposition","attachment; filename=\""+ nombre + "\"");

    SimpleDateFormat df = new SimpleDateFormat("dd-MMMMMMM-yyyy");
    SimpleDateFormat dfDate = new SimpleDateFormat("yyyy-MM-dd");

    String idArchivoS = request.getParameter("idArchivo");
    int idArchivo = 0;
    if(idArchivoS != null){
        idArchivo = parseInt(idArchivoS);
    }

    String fecha1S = request.getParameter("fecha1");
    String fecha2S = request.getParameter("fecha2");


    List<Outbox> list;

    Archivo archivo = null;
    if (idArchivo!=0) {
        archivo = smsManager.getArchivoCompleto(idArchivo);
        list = archivo.getOutboxes();
    } else if(fecha1S != null){


        Date fecha1 = dfDate.parse(fecha1S);
        Date fecha2 = dfDate.parse(fecha2S);


        logger.debug("iNTERVALO");
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(fecha2);
        calendar.add(Calendar.DATE, 1);
        fecha2 = calendar.getTime();
        logger.debug("fecha2 = " + fecha2);
        DetachedCriteria cr = DetachedCriteria.forClass(Outbox.class);
        cr.add(Restrictions.between("processedDate", fecha1, fecha2));

        list = smsManager.getHibernateTemplate().findByCriteria(cr);
    } else {
        list = new ArrayList<Outbox>();
    }

    String bgColor;
//    bgColor = "darkblue";
    bgColor = "#010167";
%>
<p>

</p>
        <table border="1">
            <tr height="80">
                <td bgcolor="<%=bgColor%>" colspan="7" align="center">
                    <img
                            <%--src="http://localhost:8080/sw/img/logos_header.jpg" --%>
                            src="http://www.catedraenlinea.com/images/logos_header.jpg"
                            <%--src="http://lhapp.dyndns.org:8080/sw/img/log_out.jpg" --%>
                            width="525" height="75">
                </td>
            </tr>
<%
    if(idArchivo!=0){
%>            
            <tr>
                <th bgcolor="<%=bgColor%>" colspan="5" align="center">
                    <font color="white" >
                        Archivo
                    </font>
                </th>
                <th bgcolor="<%=bgColor%>" colspan="2" align="center">
                    <font color="white" >
                        Fecha
                    </font>
                </th>
            </tr>
            <tr>
                <td colspan="5">
                    <%=archivo.getNombreArchivo()%>
                </td>
                <td colspan="2">
                    <%=df.format(archivo.getFecha())%>
                </td>
            </tr>
<%
    }
%>
            <tr>
                <th bgcolor="<%=bgColor%>">
                    <font color="white" >
                    Id
                    </font>
                </th>
                <th bgcolor="<%=bgColor%>">
                    <font color="white" >
                    N&uacute;mero
                    </font>
                </th>
                <th bgcolor="<%=bgColor%>">
                    <font color="white" >
                    Mensaje
                    </font>
                </th>
                <th bgcolor="<%=bgColor%>">
                    <font color="white" >
                    Operador
                    </font>
                </th>
                <th bgcolor="<%=bgColor%>">
                    <font color="white" >
                    Lote
                    </font>
                </th>
                <th bgcolor="<%=bgColor%>">
                    <font color="white" >
                    Estado
                    </font>
                </th>
                <th bgcolor="<%=bgColor%>">
                    <font color="white" >
                    Fecha Enviado
                    </font>
                </th>
            </tr>
<%
    for (int i = 0; i < list.size(); i++) {
        Outbox outbox = list.get(i);
%>
            <tr>
                <td>
                    <%=outbox.getId()%>
                </td>
                <td>
                    <%=outbox.getNumber()%>
                </td>
                <td>
                    <%=outbox.getText()%>
                </td>
                <td>
                    <%=outbox.getOperadorByIdOperador()!=null?outbox.getOperadorByIdOperador().getNombreOperador():"ninguno"%>
                </td>
                <td>
                    <%=outbox.getIdLote()!=null?outbox.getIdLote():"ninguno"%>
                </td>
                <td>
                    <%=getEstado(outbox)%>
                </td>
                <td>
                    <%=getFechaEnvio(outbox)%>
                </td>
            </tr>
<%
    }
%>
        </table>
    </body>
</html>
