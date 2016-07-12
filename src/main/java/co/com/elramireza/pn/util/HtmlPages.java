package co.com.elramireza.pn.util;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import java.io.IOException;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: Feb 26, 2012
 * Time: 12:13:38 PM
 */
public class HtmlPages extends HttpServlet {



    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//        System.out.println("request.getRequestURI() = " + request.getRequestURI());

        String uriS = request.getRequestURI();
//        System.out.println("uriS = " + uriS);
        request.setAttribute("myuri", uriS);

        if (uriS.contains("P4S-")) {
            request.setAttribute("ctrl_serv","03-ideas/p5_startup_sola.jsp");
        } else if(uriS.contains("P4Sc-")){
            request.setAttribute("ctrl_serv","01-eventos/p5_certamen_sola.jsp");
        } else if(uriS.contains("P4Sp-")){
            request.setAttribute("ctrl_serv","04-participantes/p5_participante_sola.jsp");
        } else if(uriS.contains("P4Sg-")){
            request.setAttribute("ctrl_serv","02-grupos/p5_grupos_sola.jsp");
        } else {
            request.setAttribute("ctrl_serv","error.jsp");
        }

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/private/integrator.jsp");
        dispatcher.forward(request, response);

    }
}
