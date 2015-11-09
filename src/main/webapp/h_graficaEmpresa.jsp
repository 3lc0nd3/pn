<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="co.com.elramireza.pn.util.MyKey" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.math.BigDecimal" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Empresa empresa;
    Participante participante;
    int vieneDeFront = 0;

    Texto texto22 = pnManager.getTexto(22);
    Participante participante1Req = (Participante) request.getAttribute("participante");
    if (participante1Req != null) { // VIENE DE FRONT CONTROLLER
        participante = participante1Req;
        empresa = participante.getEmpresaByIdEmpresa();
        vieneDeFront =1;

    } else {
        Empleado empleo = (Empleado) session.getAttribute("empleo");
        empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();

        participante = pnManager.getParticipante(empleo.getParticipanteByIdParticipante().getIdParticipante());
    }

    System.out.println("graphics participante = " + participante);
    System.out.println("graphics empresa = " + empresa);


    List<Empleado> evaluadoresFromParticipante = null;
    if (participante != null) {
        evaluadoresFromParticipante = pnManager.getEvaluadoresFromParticipante(participante.getIdParticipante());
    }

    System.out.println("evaluadoresFromParticipante.size() = " + evaluadoresFromParticipante.size());

    List<MyKey> totalesItems= new ArrayList<MyKey>();;
    List <PnCuantitativa> cuantitativaDespues= new ArrayList<PnCuantitativa>();
    if (evaluadoresFromParticipante != null &&
            evaluadoresFromParticipante.size()>0) {
//        TODO CAMBIAR ESTO
//        totalesItems = pnManager.getTotalesItems(evaluadoresFromParticipante.get(0).getIdEmpleado(), 5);

        String hql = "select pnSubCapituloByIdSubCapitulo.pnCapituloByIdCapitulo.id, " +
                " pnSubCapituloByIdSubCapitulo.pnCapituloByIdCapitulo.nombreCapitulo, " +
                " sum(total) from PnCuantitativa " +
                " where tipoFormatoByIdTipoFormato.id = ? and empleadoByIdEmpleado.idEmpleado = ? " +
                " group by pnSubCapituloByIdSubCapitulo.pnCapituloByIdCapitulo" +
                " order by pnSubCapituloByIdSubCapitulo.pnCapituloByIdCapitulo.numeroCapitulo";
        int idEmpleado = evaluadoresFromParticipante.get(0).getIdEmpleado();
        System.out.println("idEmpleado guardo eval FINAL = " + idEmpleado);
        Object o[] = {5, idEmpleado};

        cuantitativaDespues = pnManager.getCuantitativaDespuesVisitaFromEmpleado(idEmpleado);
        List<Object[]> sumas = pnManager.getHibernateTemplate().find(
                hql,
                o);
        System.out.println("sumas.size() = " + sumas.size());
//        List<MyKey> totales = new ArrayList<MyKey>();
        for (Object[] objects : sumas) {
            MyKey key = new MyKey();
            key.setId((Integer) objects[0]);
            key.setText((String) objects[1]);
            key.setValue((new BigDecimal((Long) objects[2])).intValue());
            totalesItems.add(key);
        }

        if (totalesItems.size()==0) {

            totalesItems = new ArrayList<MyKey>();
            List<PnCapitulo> capitulos = pnManager.getPnCapitulos(
                    participante.getPnPremioByIdConvocatoria().getTipoPremioById().getId()
            );
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
        List<PnCapitulo> capitulos = pnManager.getPnCapitulos(
                participante.getPnPremioByIdConvocatoria().getTipoPremioById().getId()
        );
        for (PnCapitulo capitulo : capitulos) {
            MyKey key = new MyKey();
            key.setText(capitulo.getNombreCapitulo());
            key.setValue(0);
            key.setId(capitulo.getId());
            totalesItems.add(key);
        }
    }

//    System.out.println("totalesItems.size() = " + totalesItems.size());

    //  SOLO PARA ETAPA 5
    if (participante.getPnEtapaParticipanteByIdEtapaParticipante().getIdEtapaParticipante() != 5) {
%>
<div class="alert">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <%=texto22.getTexto1()%>
    <img src="img/stop.png" width="50">
</div>
<%
    } else { //  END IF ETAPA 5
%>
<div class="container">
    <div class="row">
        <div class="span8">
            <div id="chart2" style="height:400px;/*width:100%;*/ "></div>
            <div id="chart1" style="height:400px;/*width:100%;*/ "></div>

            <br>
            <table class="table table-hover " width="100%">
                <tr style="color: #ffffff; background-color: #002a80; font-weight: bolder;">
                    <tH colspan="2" >
                    Cap&iacute;tulo
                    </tH>
                    <th></th>
                    <th style=" text-align: right;">Puntaje</th>
                    <th style=" text-align: right;">%</th>
                </tr>
                <%
                    int idCapOld = 0;
                    int contCapitulos = -1;
                    int total=0;
                    for(PnCuantitativa pnCuantitativa: cuantitativaDespues){
                        if(idCapOld != pnCuantitativa.getPnSubCapituloByIdSubCapitulo().getPnCapituloByIdCapitulo().getId()){
                            idCapOld = pnCuantitativa.getPnSubCapituloByIdSubCapitulo().getPnCapituloByIdCapitulo().getId();
                            contCapitulos++;
                            MyKey myKey = totalesItems.get(contCapitulos);
                            total+= myKey.getValue();
                %>
                <tr style="color: #ffffff; background-color: #002a80; font-weight: bolder;">
                    <td><%=pnCuantitativa.getPnSubCapituloByIdSubCapitulo().getPnCapituloByIdCapitulo().getNumeroCapitulo()%></td>
                    <td><%=pnCuantitativa.getPnSubCapituloByIdSubCapitulo().getPnCapituloByIdCapitulo().getNombreCapitulo()%></td>
                    <td><%=pnCuantitativa.getPnSubCapituloByIdSubCapitulo().getPnCapituloByIdCapitulo().getMaximo()%></td>
                    <td style=" text-align: right"><%=myKey.getValue()%></td>
                    <td style=" text-align: right"><%=pnCuantitativa.getPnSubCapituloByIdSubCapitulo().getPnCapituloByIdCapitulo().getMaximo()!=0?(100* myKey.getValue()/pnCuantitativa.getPnSubCapituloByIdSubCapitulo().getPnCapituloByIdCapitulo().getMaximo()):0%>%</td>
                </tr>
                <%
                        }  //  END IF NUEVO CAPITULO
                %>
                <tr>
                    <td style="font-weight: bold;"><%=pnCuantitativa.getPnSubCapituloByIdSubCapitulo().getCodigoItem()%></td>
                    <td style="font-weight: bold;"><%=pnCuantitativa.getPnSubCapituloByIdSubCapitulo().getSubCapitulo()%></td>
                    <td style="font-weight: normal;"><%=pnCuantitativa.getPnSubCapituloByIdSubCapitulo().getPonderacion()%></td>
                    <td style="font-weight: bold; text-align: right"><%=pnCuantitativa.getTotal()%></td>
                    <td style="font-weight: bold; text-align: right"><%=pnCuantitativa.getValor()%>%</td>
                </tr>
                <%
                    }  //  END FOR CUANTITATIVAS
                %>

                <tr style="color: #ffffff; background-color: #002a80; font-weight: bolder;">
                    <TH COLSPAN="2"></TH>
                    <th>Total</th>
                    <th style="font-weight: bold; text-align: right"><%=total%></th>
                    <Th></Th>
                </tr>
            </table>
            <br>

        </div>
        <div class="span4">
            <%
                if (participante1Req == null) {
            %>
            <jsp:include page="c_empresa_admon.jsp"    />
            <%}%>
        </div>
    </div>
</div>  <%--  END CONTAINER  --%>
            <%
                }  // END ELSE ETAPA 5
            %>


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
        alrt("Cargando!");

        var line1 = [
            <%
            int c_a=0;
                for (MyKey capitulo : totalesItems){
//                System.out.println(c_a++ +"capitulo.getId() = " + capitulo.getId());
                PnCapitulo capi = pnManager.getPnCapitulo(capitulo.getId());

            %>
            ['<%=capitulo.getText().trim()%>', <%=100*capitulo.getValue()/capi.getMaximo()%>],
            <%
                }
            %>
        ];

        var s1 = [
            <%
            System.out.println("2 ___");
            c_a=0;
                for (MyKey capitulo : totalesItems){

//                System.out.println(c_a++ +"capitulo.getId() = " + capitulo.getId());
                PnCapitulo capi = pnManager.getPnCapitulo(capitulo.getId());

            %>
            <%=100*capitulo.getValue()/capi.getMaximo()%>,
            <%
                }
            %>
        ];
        var ticks = [
            <%
            System.out.println("3");
            c_a=0;
                for (MyKey capitulo : totalesItems){
                PnCapitulo capi = pnManager.getPnCapitulo(capitulo.getId());

            %>
            "<%=capitulo.getText().trim()%>",
            <%

//                System.out.println(c_a++ +"capitulo.getId() = " + capitulo.getId());
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