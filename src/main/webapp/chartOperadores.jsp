
<%@ page import="co.com.elramireza.sw.dao.SwDAO" %>
<%@ page import="org.jfree.chart.JFreeChart" %>
<%@ page import="co.com.elramireza.sw.model.Archivo" %>
<%@ page import="static java.lang.String.format" %>
<%@ page import="co.com.elramireza.sw.model.Operador" %>
<%@ page import="co.com.elramireza.sw.model.Outbox" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="org.hibernate.criterion.DetachedCriteria" %>
<%@ page import="org.hibernate.criterion.ProjectionList" %>
<%@ page import="org.hibernate.criterion.Projections" %>
<%@ page import="org.hibernate.criterion.Restrictions" %>
<%@ page import="org.jfree.chart.ChartFactory" %>
<%@ page import="org.jfree.chart.ChartUtilities" %>
<%@ page import="org.jfree.chart.labels.StandardPieSectionLabelGenerator" %>
<%@ page import="org.jfree.chart.plot.PiePlot3D" %>
<%@ page import="org.jfree.chart.title.TextTitle" %>
<%@ page import="org.jfree.data.general.DatasetUtilities" %>
<%@ page import="org.jfree.data.general.DefaultPieDataset" %>
<%@ page import="org.jfree.ui.RectangleEdge" %>
<%@ page import="org.jfree.ui.VerticalAlignment" %>
<%@ page import="org.jfree.util.Rotation" %>
<%@ page import="static java.lang.Integer.parseInt" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="smsManager" class="co.com.elramireza.sw.dao.SwDAO" scope="application"/>

<%
    String title;

    String idArchivoS = request.getParameter("idArchivo");
    int idArchivo = 0;
    if(idArchivoS != null){
        idArchivo = parseInt(idArchivoS);
    }

    String enviadosS = request.getParameter("enviados");
    int enviados = 0;
    if(enviadosS != null){
        enviados = parseInt(enviadosS);
    }

    Logger logger = Logger.getLogger(SwDAO.class);

    response.setContentType("image/jpeg");

    OutputStream salida = response.getOutputStream();


    int ancho = (880);
    int alto = (600);

    DetachedCriteria crit = DetachedCriteria.forClass(Outbox.class);

    ProjectionList projList = Projections.projectionList();
    projList.add(Projections.rowCount(), "cuenta");
    projList.add(Projections.groupProperty("operadorByIdOperador"), "op");

    crit.setProjection(projList);
    if (idArchivo != 0) {
        Archivo archivo = smsManager.getArchivo(idArchivo);
        title = archivo.getNombreArchivo();
        crit.add(Restrictions.eq("archivoByIdArchivo.idArchivo", idArchivo));
    } else {
        title = "Todos los archivos";
    }

    if(enviados == 1){
        crit.add(Restrictions.eq("processed", 1));
    }

    DefaultPieDataset data = new DefaultPieDataset();
    List list = smsManager.getHibernateTemplate().findByCriteria(crit);
    for (Object aList : list) {
        Object o[] = (Object[]) aList;
//        System.out.println("cuenta = " + (Integer) o[0] + "\t Operador " + ((Operador) o[1]).getNombreOperador());
        String operador;
        if (o[1] != null) {
            operador = ((Operador) o[1]).getNombreOperador();
        } else {
            operador = "Desconocido";
        }
        data.setValue(operador, (Integer) o[0]);
    }


    int total = (int) DatasetUtilities.calculatePieDatasetTotal(data);
    String subTitle = "Total " + total;

    if(enviados == 1){
        subTitle += " Solo Enviados";
        crit.add(Restrictions.eq("processed", 1));
    }

    JFreeChart chart = ChartFactory.createPieChart3D(
            title,  // chart title
            data,                   // data
            true,                   // include legend
            true,
            true
    );


    final TextTitle subtitle = new TextTitle(subTitle);
    subtitle.setFont(new Font("SansSerif", Font.PLAIN, 12));
        subtitle.setPosition(RectangleEdge.TOP);
//        subtitle.setSpacer(new Spacer(Spacer.RELATIVE, 0.05, 0.05, 0.05, 0.05));
        subtitle.setVerticalAlignment(VerticalAlignment.BOTTOM);
        chart.addSubtitle(subtitle);

    PiePlot3D plot = (PiePlot3D) chart.getPlot();
        plot.setStartAngle(290);
        plot.setDirection(Rotation.CLOCKWISE);
        plot.setForegroundAlpha(0.5f);
        plot.setNoDataMessage("No data to display");

        plot.setLabelGenerator(new StandardPieSectionLabelGenerator(
                "{0} {1} = {2}", NumberFormat.getNumberInstance(), NumberFormat.getPercentInstance()
        ));
//        plot.setLabelGenerator(new CustomLabelGenerator());


    ChartUtilities.writeChartAsJPEG(salida, chart, ancho,alto);

    salida.close();

%>
