package co.com.elramireza.pn.filter;

import org.directwebremoting.AjaxFilter;
import org.directwebremoting.AjaxFilterChain;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.impl.LoginRequiredException;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletContext;
import java.lang.reflect.Method;

import co.com.elramireza.pn.model.Participante;
import co.com.elramireza.pn.model.Servicio;
import co.com.elramireza.pn.dao.PnDAO;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: Jul 27, 2011
 * Time: 5:28:34 PM
 */
public class DwrFilter implements AjaxFilter {

    Logger logger = Logger.getLogger(DwrFilter.class);

    public Object doFilter(Object obj,
                           Method method,
                           Object[] params,
                           AjaxFilterChain chain) throws Exception {
//        logger.debug("");
//        logger.debug("");
//        logger.debug("/////////////////////////////***********************//////////////////////////////////////");
//        logger.debug("/////////////////////////////****   DWR Filter 1 ***//////////////////////////////////////");
//        logger.debug("/////////////////////////////***********************//////////////////////////////////////");


        /**
         * Con esto se obtiene el Objeto que hace la llamada
         */
        /*
        NewsDAO newsDAO = (NewsDAO) obj;
        logger.debug("newsDAO.getMedia(1).getName() = " + newsDAO.getMedia(1).getName());
        */

        /**
         * Tambien se tiene acceso al metodo invocado
         */
        /*
        logger.debug("method.getName() = " + method.getName());
        */


        WebContext webContext = WebContextFactory.get();

        ServletContext context = webContext.getServletContext();
        PnDAO pnDAO = (PnDAO) context.getAttribute("pnManager");

//        logger.info("pnDAO = " + pnDAO);
        /*if (pnDAO != null) {
            logger.info("pnDAO.test(\"Edward\") = " + pnDAO.test("Edward"));
        }*/

        /*
        Container c = webContext.getContainer();
        Collection<String> g = c.getBeanNames();
        for (String s : g) {
            logger.debug("s = " + s);
        }
*/
        HttpServletRequest req = webContext.getHttpServletRequest();
        Participante participante = (Participante) req.getSession().getAttribute("participante");
//        logger.info("participante = " + participante);
//        logger.info("method.getName() = " + method.getName());

		Servicio servicioSeguridad = pnDAO.getServicio(1);
		
        boolean publicoAjax = false;

		if (servicioSeguridad.getPublico()==0) {  // SI HAY SEGURIDAD
			for(Servicio servicio: pnDAO.getServiciosAjaxPublicos()){
				if(method.getName().equals(servicio.getServicio())){
					publicoAjax = true;
				}
			}
		} else { /* NO HAY SEGURIDAD */
			publicoAjax = true;
		}

		if (participante == null && !publicoAjax) {
            logger.debug("Usuario Nulo - no hay usuario en session");
            throw new LoginRequiredException("Por favor ingrese al sistema.") ;
        }
//        else {
//            logger.debug("user.getCompleteName() = " + participante.getNombreParticipante());
//        }

        return chain.doFilter(obj, method, params);
    }
}
