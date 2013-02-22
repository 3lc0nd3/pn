<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="co.com.elramireza.pn.util.MyKey" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Empresa empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();

    Participante participante;
    participante = pnManager.getParticipante(empleo.getParticipanteByIdParticipante().getIdParticipante());

    List<Empleado> evaluadoresFromParticipante = null;
    if (participante != null) {
        evaluadoresFromParticipante = pnManager.getEvaluadoresFromParticipante(participante.getIdParticipante());
    }

    List<MyKey> totalesItems;
    if (evaluadoresFromParticipante != null) {
        totalesItems = pnManager.getTotalesItems(evaluadoresFromParticipante.get(0).getIdEmpleado(), 5);
    } else {
        totalesItems = new ArrayList<MyKey>();
    }
%>

<div class="container">
    <div class="row">
        <div class="span8">
            <div id="chart1" style="height:400px;/*width:100%;*/ "></div>
            <br>
            <table class="table table-hover table-striped" width="50%">
                <tr>
                    <th>Cap&iacute;tulo</th>
                    <th>Puntaje</th>
                </tr>
                <%
                    int total = 0;
                    for (MyKey key : totalesItems){
                        total += key.getValue();
                %>
                <tr>
                    <td><%=key.getText()%></td>
                    <td><%=key.getValue()%></td>
                </tr>
                <%
                    }
                %>
                <tr>
                    <th>Total</th>
                    <th><%=total%></th>
                </tr>
            </table>
        </div>
        <div class="span4">
            <jsp:include page="c_empresa_admon.jsp"    />
        </div>
    </div>
</div>



<jsp:include page="c_footer_r.jsp"/>

<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="js/jqPlot/excanvas.min.js"></script><![endif]-->
<script language="javascript" type="text/javascript" src="js/jqPlot/jquery.jqplot.min.js"></script>
<link rel="stylesheet" type="text/css" href="js/jqPlot/jquery.jqplot.css" />

<script type="text/javascript" src="js/jqPlot/plugins/jqplot.dateAxisRenderer.min.js"></script>
<script type="text/javascript" src="js/jqPlot/plugins/jqplot.canvasTextRenderer.min.js"></script>
<script type="text/javascript" src="js/jqPlot/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
<script type="text/javascript" src="js/jqPlot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="js/jqPlot/plugins/jqplot.barRenderer.min.js"></script>

<script type="text/javascript">

    $(document).ready(function(){
        var line11 = [
            ['Cup Holder Pinion Bob', 7],
            ['Generic Fog Lamp', 9],
            ['HDTV Receiver', 15],
            ['8 Track Control Module', 12],
            [' Sludge Pump Fourier Modulator', 3],
            ['Transcender/Spice Rack', 6],
            ['Hair Spray Danger Indicator', 18]
        ];

        var line1 = [
            <%
                for (MyKey capitulo : totalesItems){
            %>
            ['<%=capitulo.getText()%>', <%=capitulo.getValue()%>],
            <%
                }
            %>
        ];

        var plot1 = $.jqplot('chart1', [line1], {
            animate: true,
            title: '<%=empresa.getNombreEmpresa()%> <br> Desempe&ntilde;o por Cap&iacute;tulos',
//            series:[{renderer:$.jqplot.BarRenderer}],
            axesDefaults: {
                tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
                tickOptions: {
                    angle: 45,
                    fontSize: '10pt'
                }
            },
            axes: {
                xaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer
                }
            }
        });
    });
</script>