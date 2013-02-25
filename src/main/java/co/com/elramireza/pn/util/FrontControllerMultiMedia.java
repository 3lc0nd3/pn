package co.com.elramireza.pn.util;

import co.com.elramireza.pn.model.Participante;
import org.apache.log4j.Logger;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.impl.LoginRequiredException;

import javax.servlet.ServletException;
import java.io.IOException;
import static java.lang.String.format;

import co.com.elramireza.pn.dao.PnDAO;
import co.com.elramireza.pn.model.Empresa;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: Jul 27, 2011
 * Time: 3:27:57 PM
 */
public class FrontControllerMultiMedia {

    public final int VIDEO    =1;
    public final int AUDIO    =2;
    public final int IMAGEN   =3;
    public final int OTRO     =4;

    Logger logger  = Logger.getLogger(FrontControllerMultiMedia.class);

    public String getInclude(String page) throws ServletException, IOException {
        WebContext wctx = WebContextFactory.get();
//        logger.info("page = " + page);
        String url = format("/%s.jsp", page);
//        logger.info("url = " + url);
        String respuesta = null;
        try {
            respuesta = wctx.forwardToString(url);
        } catch (ServletException e) {
            e.printStackTrace();
            logger.debug(e.getMessage());
            throw new LoginRequiredException("La sesión a terminado. Vuelva a ingresar al sistema.") ;
        } catch (IOException e) {
            e.printStackTrace();
            logger.debug(e.getMessage());
            throw new LoginRequiredException("La sesión a terminado. Vuelva a ingresar al sistema.") ;
        }
//        logger.info("respuesta = " + respuesta);
        return respuesta;
    }

    public String getHitosPage(int inicia)
            throws ServletException, IOException {
//        logger.info("inicia = " + inicia);
        WebContext wctx = WebContextFactory.get();
        wctx.getHttpServletRequest().setAttribute("iniciaHitos", inicia);
        String url = "/private/00-inicio/hitos.jsp";
        String res = wctx.forwardToString(url);
//        logger.info("res.length() = " + res.length());
        return res;
    }

    public String getIncludeNews(int idNews,
                                 String page,
                                 int role)
            throws ServletException, IOException {
        WebContext wctx = WebContextFactory.get();
        wctx.getHttpServletRequest().setAttribute("idNews", idNews);
        String url = format("/%s.jsp?role="+role, page);
        return wctx.forwardToString(url);
    }

    public String getIncludeGrafAdmon(int id) throws IOException, ServletException {
        WebContext wctx = WebContextFactory.get();
        Participante participante = pnDAO.getParticipante(id);
        wctx.getHttpServletRequest().setAttribute("participante", participante);
        return wctx.forwardToString("/h_graficaEmpresa.jsp");
    }

    public String getIncludePartAdmon(int id) throws IOException, ServletException {
        WebContext wctx = WebContextFactory.get();
        Participante participante = pnDAO.getParticipante(id);
        wctx.getHttpServletRequest().setAttribute("participante", participante);
        return wctx.forwardToString("/c_empresa_admon.jsp");
    }

    public String getIncludeEmpresaAdmon(int id) throws IOException, ServletException {
        WebContext wctx = WebContextFactory.get();
        Empresa empresa = pnDAO.getEmpresa(id);
        wctx.getHttpServletRequest().setAttribute("empresa", empresa);
        return wctx.forwardToString("/c_empresa_admon.jsp");
    }

    public String getPlayer(int idFile, int tipoSource, String filename) throws IOException, ServletException {
        WebContext wctx = WebContextFactory.get();
        String page;
        switch (tipoSource){
            case VIDEO:
                page = "Video";
                break;
            case AUDIO:
                page = "Audio";
                break;
            case IMAGEN:
                page = "Imagen";
                break;
            default:
                page = "Otro";
        }//fin switch

        String url = format("/player/player%s.jsp?idFile=%d&tipoSource=%d&fileName=%s", page, idFile, tipoSource, filename);
        logger.debug("url = " + url);
        return wctx.forwardToString(url);
    }

    private PnDAO pnDAO;

    public PnDAO getPnDAO() {
        return pnDAO;
    }

    public void setPnDAO(PnDAO pnDAO) {
        this.pnDAO = pnDAO;
    }
}
