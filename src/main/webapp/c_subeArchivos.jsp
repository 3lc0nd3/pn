
<div class="formy">
    <div class="form">
        <%--<form id="registroP" class="form-horizontal" autocomplete="off">--%>
        <!-- informe de postulacion-->
        <div class="control-group">
            <label class="control-label" for="fileInformePostulacionFile">Informe de Postulaci&oacute;n PDF</label>
            <div class="controls">
                <input type="file" name="fileInformePostulacionFile" id="fileInformePostulacionFile">
                <br>
                <input id="bIp" onclick="subeArchivoInformePostula();" type="button" value="enviar">
            </div>
        </div>
        <%--</form>--%>
    </div>
</div>
<br>
<div class="formy">
    <div class="form">
        <!-- certificado const Empresa -->
        <div class="control-group">
            <label class="control-label" for="fileCertificadoConstitucionFile">Certificado Constituci&oacute;n Legal PDF</label>
            <div class="controls">
                <input type="file" class=" required" name="fileCertificadoConstitucionFile" id="fileCertificadoConstitucionFile">
                <br>
                <input id="bCc" onclick="subeArchivoCLegal();" type="button" value="enviar">
            </div>
        </div>


    </div>
</div>
<br>
<div class="formy">
    <div class="form">
        <!-- fileEstadoFinanciero Empresa -->
        <div class="control-group">
            <label class="control-label" for="fileEstadoFinancieroFile">Estados Financieros (3 a&ntilde;os) PDF</label>
            <div class="controls">
                <input type="file" class=" required"  name="fileEstadoFinancieroFile" id="fileEstadoFinancieroFile">
                <br>
                <input id="bEf" onclick="subeArchivoFinanciero();" type="button" value="enviar">
            </div>
        </div>
    </div>
</div>
<br>
<div class="formy">
    <div class="form">
        <!-- fileConsignacion Empresa -->
        <div class="control-group">
            <label class="control-label" for="fileConsignacionFile">Recibo de Consignaci&oacute;n (50%) PDF</label>
            <div class="controls">
                <input type="file" name="fileConsignacionFile" id="fileConsignacionFile">
                <br>
                <input id="bCo" onclick="subeArchivoConsigna();" type="button" value="enviar">
            </div>
        </div>
    </div>
</div>