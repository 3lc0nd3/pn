<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="co.com.elramireza.pn.util.MyKey" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Empresa empresa;
    Participante participante;

    Participante participante1Req = (Participante) request.getAttribute("participante");
    if (participante1Req != null) { // VIENE DE FRONT CONTROLLER
        participante = participante1Req;
        empresa = participante.getEmpresaByIdEmpresa();

    } else {
        Empleado empleo = (Empleado) session.getAttribute("empleo");
        empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();

        participante = pnManager.getParticipante(empleo.getParticipanteByIdParticipante().getIdParticipante());
    }

    System.out.println("participante = " + participante);
    System.out.println("empresa = " + empresa);


    List<Empleado> evaluadoresFromParticipante = null;
    if (participante != null) {
        evaluadoresFromParticipante = pnManager.getEvaluadoresFromParticipante(participante.getIdParticipante());
    }

    System.out.println("evaluadoresFromParticipante.size() = " + evaluadoresFromParticipante.size());

    List<MyKey> totalesItems;
    if (evaluadoresFromParticipante != null &&
            evaluadoresFromParticipante.size()>0) {
//        System.out.println("evaluadoresFromParticipante.size() = " + evaluadoresFromParticipante.size());
        totalesItems = pnManager.getTotalesItems(evaluadoresFromParticipante.get(0).getIdEmpleado(), 5);
        if (totalesItems.size()==0) {

            totalesItems = new ArrayList<MyKey>();
            List<PnCapitulo> capitulos = pnManager.getPnCapitulos();
            for (PnCapitulo capitulo : capitulos) {
                MyKey key = new MyKey();
                key.setId(capitulo.getId());
                key.setText(capitulo.getNombreCapitulo());
                key.setValue(0);
                totalesItems.add(key);
            }
        }
    } else {
        totalesItems = new ArrayList<MyKey>();
        List<PnCapitulo> capitulos = pnManager.getPnCapitulos();
        for (PnCapitulo capitulo : capitulos) {
            MyKey key = new MyKey();
            key.setText(capitulo.getNombreCapitulo());
            key.setValue(0);
            key.setId(capitulo.getId());
            totalesItems.add(key);
        }
    }

//    System.out.println("totalesItems.size() = " + totalesItems.size());
%>

<div class="container">
    <div class="row">
        <div class="span8">
            <div id="chart2" style="height:400px;/*width:100%;*/ "></div>
            <div id="chart1" style="height:400px;/*width:100%;*/ "></div>
            <br>
            <table class="table table-hover table-striped" width="50%">
                <tr>
                    <th>Cap&iacute;tulo</th>
                    <th>Puntaje</th>
                    <th>%</th>
                </tr>
                <%
                    int total = 0;
                    for (MyKey key : totalesItems){
                        total += key.getValue();
                        PnCapitulo capitulo = pnManager.getPnCapitulo(key.getId());
//                        System.out.println("key.getId() = " + key.getId());
//                        System.out.println("key.getText() = " + key.getText());
//                        System.out.println("capitulo = " + capitulo);
//                        System.out.println("capitulo.getMaximo() = " + capitulo.getMaximo());
                %>
                <tr>
                    <td><%=key.getText()%></td>
                    <td><%=key.getValue()%></td>
                    <td><%=capitulo.getMaximo()!=0?(100*key.getValue()/capitulo.getMaximo()):0%></td>
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
            <%
                if (participante1Req == null) {
            %>
            <jsp:include page="c_empresa_admon.jsp"    />
            <%}%>
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
        /*var line11 = [
            ['Cup Holder Pinion Bob', 7],
            ['Generic Fog Lamp', 9],
            ['HDTV Receiver', 15],
            ['8 Track Control Module', 12],
            [' Sludge Pump Fourier Modulator', 3],
            ['Transcender/Spice Rack', 6],
            ['Hair Spray Danger Indicator', 18]
        ];
*/
        var line1 = [
            <%
                for (MyKey capitulo : totalesItems){
                PnCapitulo capi = pnManager.getPnCapitulo(capitulo.getId());

            %>
            ['<%=capitulo.getText()%>', <%=100*capitulo.getValue()/capi.getMaximo()%>],
            <%
                }
            %>
        ];

        var s1 = [
            <%
                for (MyKey capitulo : totalesItems){
                PnCapitulo capi = pnManager.getPnCapitulo(capitulo.getId());

            %>
            <%=100*capitulo.getValue()/capi.getMaximo()%>,
            <%
                }
            %>
        ];
        var ticks = [
            <%
                for (MyKey capitulo : totalesItems){
                PnCapitulo capi = pnManager.getPnCapitulo(capitulo.getId());

            %>
            "<%=capitulo.getText()%>",
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


        var plot2 =  $.jqplot('chart2', [s1], {
            // Only animate if we're not using excanvas (not in IE 7 or IE 8)..
            animate: !$.jqplot.use_excanvas,
            seriesDefaults:{
                renderer:$.jqplot.BarRenderer,
                pointLabels: { show: true }
            },
            axesDefaults: {
                tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
                tickOptions: {
                    angle: 45,
                    fontSize: '10pt'
                }
            },
            axes: {
                xaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer,
                    ticks: ticks
                }
            },
            highlighter: { show: false }
        });
    });
</script>