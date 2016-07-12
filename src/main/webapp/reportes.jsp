<link href="style/cssCalendar/steel/steel.css" type="text/css" rel="stylesheet">
<br>
<div class="esquinasRedondas2" style="width:90%">
    <table width="80%" border="00" cellpadding="0">
    <tr>
        <td width="30%">
            Archivos:
        </td>
        <td>
            <%--<input type="button" onclick="getContentOfFile();">--%>
            <select id="archivosMenu3" onchange="getContentOfFile2();"></select>
        </td>
        <td>
            <LABEL FOR="enviados">
            <input type="checkbox" id="enviados"/> Solo Enviados
            </LABEL>
        </td>
        <td>
            <input type="button" <%--style="background-color:#ffcccc;"--%> value="Reporte Gr&aacute;fico" onclick="reporteArchivo();" >
        </td>
        <td>
            <input type="button" value="Excel" onclick="reporteExcel();" >
        </td>
    </tr>
</table></div>
<br>
<div class="esquinasRedondas2" style="width:90%">
    <table width="80%" border="00" cellpadding="0">
        <TR>
            <td>
                Intervalo Desde:
            </td>
            <td>
                <input type="text" class="required" id="fecha1" name="fecha2" size="10" readonly/>
                <input type="button" id="fechaB1" value="..."/>
            </td>
            <td>
                Hasta:
            </td>
            <td>
                <input type="text" class="required" id="fecha2" name="fecha2" size="10" readonly/>
                <input type="button" id="fechaB2" value="..."/>
            </td>
            <td>
                <input type="button" value="Excel" onclick="reporteExcel2();" >
            </td>
        </TR>
    </table>
</div>



<img src="images/spacer.gif" alt="" id="imageC" style="margin-top:10px">

<script type="text/javascript">

    function updateFields(cal) {
        //          alrt("true = " + true);

        //cal.hide();
    }
    var myCal = Calendar.setup({
        //cont            : "cont",
        //        showTime        : true,
        fdow            : 0,
        weekNumbers     : true,
        onSelect        : updateFields,
        selection       : Calendar.dateToInt(new Date()),
        onTimeChange    : updateFields,
        titleFormat     : "%b %d de %Y",
        //        trigger:    "calendar-trigger",
        //        inputField: "fechaBusqueda",
        animation       : true
    });

    myCal.manageFields("fechaB1", "fecha1","%Y-%m-%d");
    myCal.manageFields("fechaB2", "fecha2","%Y-%m-%d");
//]]>
</script>