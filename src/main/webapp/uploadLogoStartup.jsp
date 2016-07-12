<%@ page import="org.apache.commons.fileupload.FileUploadException" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="co.com.elramireza.sw.dao.SwDAO" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Vector" %>
<%@ page import="static java.lang.String.format" %>
<%@ page import="co.com.elramireza.sw.upload.UploadListener" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.FileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="co.com.elramireza.sw.upload.MonitoredDiskFileItemFactory" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="co.com.elramireza.sw.model.Participante" %>
<%@ page import="org.apache.commons.fileupload.FileUploadBase" %>
<%@ page import="static java.lang.String.format" %>
<%@ page import="co.com.elramireza.sw.model.Startup" %>
<html>
<body>

<%

    String msg = "";

    Logger logger  = Logger.getLogger(SwDAO.class);

    Hashtable parameters = new Hashtable();

    SwDAO swDAO = (SwDAO) application.getAttribute("swManager");
    logger.info("swDAO 88888888888888888888888888888888888888 = " + swDAO);

    UploadListener listener = new UploadListener(request, 1);
    logger.info("listener = " + listener);

    // Create a factory for disk-based file items
    FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);
    logger.info("factory = " + factory);

    // Create a new file upload handler
    ServletFileUpload upload = new ServletFileUpload(factory);
    logger.info("upload = " + upload);

    upload.setSizeMax(130000);

    Participante participante;
    participante = (Participante) session.getAttribute("participante");
    participante = swDAO.getParticipante(participante.getIdParticipante());

    logger.info("participante.getNombreParticipante() = " + participante.getNombreParticipante());

    Startup startup = null;

    if(true) {  // SI HAY UNA IDEA
        try {
            /**
             * Parse the request
             */
            List items = upload.parseRequest(request);


            for (Object item1 : items) {
                FileItem item = (FileItem) item1;
                /*
                * Handle Form Fields.
                */
                if (item.isFormField()) {
                    String name = item.getFieldName();
                    logger.info("name = " + name);
                    String value = item.getString();
                    if(name.equals("idStartup")){      // EL ID DE LA STARTUP
                        logger.info("value = " + value);
                        startup = swDAO.getStartup(Integer.parseInt(value));
                        logger.info("startup.getNombreStartup() = " + startup.getNombreStartup());
                    }
                    Vector existingValues = (Vector) parameters.get(name);

                    if (existingValues == null) {
                        existingValues = new Vector();
                        parameters.put(name, existingValues);
                    }
                    existingValues.addElement(value);

//                System.out.println("Field Name = " + name + ", Value = " + item.getString());
                } else {
                    //Handle Uploaded files.
//                System.out.println("Field Name = " + item.getFieldName() +
//                        ", File Name = " + item.getName() +
//                        ", Content type = " + item.getContentType() +
//                        ", File Size = " + item.getSize());
                    /*
                    * Write fileSRC to the ultimate location.
                    */

/*

                News news = swDAO.getNews(Integer.parseInt(idNews));
                Newsfile newsfile = new Newsfile();
                newsfile.setNewsByNewsid(news);
*/

                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");

                    String fileName = item.getName();

                    String extencion;
                    extencion = SwDAO.getExtFromFile(fileName);

                    String cuerpo = SwDAO.getNameFromFile(fileName);


                    fileName = format("%s-%s.%s", "s"+startup.getIdStartup(), df.format(new Date()), extencion);
                    String path;
                    path = application.getRealPath("/photo");
                    path = swDAO.getTexto(5).getTexto();
                    
                    logger.info("path = " + path);

                    File fileSRC = new File(format("%s/%s", path, fileName));
                    logger.info("fileSRC = " + fileSRC);
                    /**
                     * solo si viene un archivo
                     */
                    if (!item.getName().equals("")) {
                        logger.info("Si es archivo");
                        item.write(fileSRC);

                        if(startup.getLogoStartup() != null){ // TOCA BORRAR EL ARCHIVO ANTERIOR
                            File fileAnterior = new File(format("%s/%s", path, startup.getLogoStartup()));
                            fileAnterior.delete();
                        }

                        // PONGO EL MSG PARA MOSTRAR
                        msg = format("archivo subido <br>%s", fileName);
                        msg = fileName;

                        startup.setLogoStartup(fileName);
                        swDAO.getHibernateTemplate().update(startup);

                        swDAO.saveNoticiaProyectoActualizado(participante, startup);

                        logger.info("************* INICIA");
                        logger.info("************* fin");
//                    out.write("Guardado: " + fileName);
                    } else {
                        logger.info("No es ARCHIVO");
                        //System.out.println("no");
                    }

//                Thread.sleep(10000);

                }
            }
        } catch (FileUploadBase.SizeLimitExceededException e){
            logger.info("e = " + e.getMessage());
//        e.printStackTrace();
            msg = "<span style=\"color: red;\">Error al subir imagen <br>Tama&ntilde;o m&aacute;ximo de imagen : 120 kb</span>";
        } catch(FileUploadException ex) {
            System.out.println("Error encountered while parsing the request " + ex.getMessage());
        } catch(Exception ex) {
            System.out.println("Error encountered while uploading file " + ex.getMessage());
        }

    } else {  // NO TIENE STARTUP
        msg = "Registre una idea primero";
    }

%>

<script type="text/javascript">
    parent.globalEstadoConversion = true;

    parent.archivoCargado = '<%=msg%>';

    var myGlobal = parent.globalEstadoConversion;

</script>


</body>
</html>