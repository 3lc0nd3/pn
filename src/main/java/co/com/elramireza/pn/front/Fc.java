package co.com.elramireza.pn.front;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: Jan 7, 2013
 * Time: 3:36:56 PM
 */
public class Fc extends HttpServlet{

    protected void process(HttpServletRequest request, HttpServletResponse response){
        String r;
        r = request.getParameter("ctrl_req");
        String requestURI = request.getRequestURI();
//        System.out.println("requestURI = " + requestURI);
        if(r == null){ // para lo del mapping
            r = reqMVC(request);
        }
//        System.out.println("el R = " + r);
        request.setAttribute("servicio",r);

        RequestDispatcher rd=request.getRequestDispatcher("h_integrator.jsp");
        try{
            rd.forward(request,response);
        }catch(Exception e){
            System.out.println("Exception distpatcher forward error: "+e);
        }
    }


    public static String reqMVC(HttpServletRequest request){
//        System.out.println("request.getRequestURI() = " + request.getRequestURI());
        String requestURI = request.getRequestURI();
//        System.out.println("requestURI = " + requestURI);
        int i = requestURI.lastIndexOf("/");
        int j = request.getRequestURI().lastIndexOf(".htm");
        return request.getRequestURI().substring(i + 1, j);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response){
        process(request, response);
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response){
        process(request, response);
    }

}
