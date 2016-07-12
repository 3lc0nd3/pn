<%@ page import="co.com.elramireza.sw.model.Texto" %>
<%@ page import="co.com.elramireza.sw.model.Participante" %>
<jsp:useBean id="swManager" class="co.com.elramireza.sw.dao.SwDAO" scope="application" />
<%

    String salir = request.getParameter("exit");
    if(salir!= null){
        System.out.println("procedo a salir k jsp");
        Participante participante = (Participante) session.getAttribute("participante");
        System.out.println("participante = " + participante);
        if (participante!= null) {
            session.invalidate();
            String tokenFb = participante.getToken();
            System.out.println("tokenFb = " + tokenFb);
            if(tokenFb == null){
                response.sendRedirect("index.htm");
            } else {
                System.out.println("Salir token="+tokenFb);
                response.sendRedirect("https://www.facebook.com/logout.php?confirm=1&next=http://p4s.co&access_token="+tokenFb);
            }
        }  else {
            response.sendRedirect("index.htm");
        }
    }
    Texto texto1 = swManager.getTexto(1);
%>