package co.com.elramireza.pn.front;

import co.com.elramireza.pn.dao.PnDAO;
import co.com.elramireza.pn.model.PnTipoPremio;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created with Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 22/07/15
 * Time: 10:52 PM
 * To change this template use File | Settings | File Templates.
 */
public class PremioFc extends HttpServlet {

    protected void process(HttpServletRequest request, HttpServletResponse response){
        String r;
        r = request.getParameter("ctrl_req");
        String requestURI = request.getRequestURI();
//        System.out.println("requestURI = " + requestURI);
        if(r == null){ // para lo del mapping
            r = reqMVC(request);
        }
//        System.out.println("el R = " + r);
        request.setAttribute("servicio","index");

        RequestDispatcher rd=request.getRequestDispatcher("h_integrator.jsp");
        try{
            rd.forward(request,response);
        }catch(Exception e){
            System.out.println("Exception distpatcher forward error: "+e);
        }
    }


    public static String reqMVC(HttpServletRequest request){

        HttpSession session = request.getSession();
        ServletContext context = session.getServletContext();

        PnDAO pnDAO = (PnDAO) context.getAttribute("pnManager");

//        System.out.println("request.getRequestURI() = " + request.getRequestURI());
        String requestURI = request.getRequestURI();
//        System.out.println("requestURI = " + requestURI);
        int i = requestURI.lastIndexOf("/");
        int j;

        j = request.getRequestURI().lastIndexOf(".premio");
        System.out.println("j = " + j);

        String sigla = request.getRequestURI().substring(i + 1, j);

        PnTipoPremio tipoPremio = null;
        if (pnDAO!=null) {
            tipoPremio = pnDAO.getPnTipoPremioFromSigla(sigla);
        }
        if(tipoPremio!=null){
            session.setAttribute("tipoPremio", tipoPremio);
        }
        return sigla;
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response){
        process(request, response);
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response){
        process(request, response);
    }
}
