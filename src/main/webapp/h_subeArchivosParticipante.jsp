<%@ page import="co.com.elramireza.pn.model.Servicio" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    Servicio servicio = pnManager.getServicio(45);
%>

<h2><%=servicio.getTextoServicio()%></h2>

<div class="row">
    <div class="span6">
        <jsp:include page="c_empresa_admon.jsp"/>
    </div>
    <div class="span6">
        <jsp:include page="c_subeArchivos.jsp"/>
    </div> <%--  END DIV 6 DERECHO--%>
</div> <%--   END ROW  --%>

<div class="row">
    <div class="span12">
    </div>
</div>









<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">
    function subeArchivoInformePostula(){
        disableId("bIp");
        var o = jQuery("#fileInformePostulacionFile").val();
        if (o == '') {
            alert("Por favor seleccione un archivo");
            enableId("bIp");
        } else {
            pnRemoto.subeArchivoPostula(dwr.util.getValue('fileInformePostulacionFile'), function (data) {
                if (data != 0) {
                    alert("Archivo cargado");
//                    window.location = "subeArchivosParticipante.htm";
                    document.location.reload(true);
                } else {
                    alert("Problemas");
                    enableId("bIp");
                }
            });
        }
    }

    function subeArchivoCLegal(){
        disableId("bCc");
        var o = jQuery("#fileCertificadoConstitucionFile").val();
        if (o == '') {
            alert("Por favor seleccione un archivo");
            enableId("bCc");
        } else {
            pnRemoto.subeArchivoCLegal(dwr.util.getValue('fileCertificadoConstitucionFile'), function (data) {
                if (data != 0) {
                    alert("Archivo cargado");
//                    window.location = "subeArchivosParticipante.htm";
                    document.location.reload(true);
                } else {
                    alert("Problemas");
                    enableId("bCc");
                }
            });
        }
    }

    function subeArchivoFinanciero(){
        disableId("bEf");
        var o = jQuery("#").val();
        if (o == 'fileEstadoFinancieroFile') {
            alert("Por favor seleccione un archivo");
            enableId("bEf");
        } else {
            pnRemoto.subeArchivoFinanciero(dwr.util.getValue('fileEstadoFinancieroFile'), function (data) {
                if (data != 0) {
                    alert("Archivo cargado");
//                    window.location = "subeArchivosParticipante.htm";
                    document.location.reload(true);
                } else {
                    alert("Problemas");
                    enableId("bEf");
                }
            });
        }
    }

    function subeArchivoConsigna(){
        disableId("bCo");
        var o = jQuery("#fileConsignacionFile").val();
        if (o == '') {
            alert("Por favor seleccione un archivo");
            enableId("bCo");
        } else {
            pnRemoto.subeArchivoConsigna(dwr.util.getValue('fileConsignacionFile'), function (data) {
                if (data != 0) {
                    alert("Archivo cargado");
//                    window.location = "subeArchivosParticipante.htm";
                    document.location.reload(true);
                } else {
                    alert("Problemas");
                    enableId("bCo");
                }
            });
        }
    }

</script>
