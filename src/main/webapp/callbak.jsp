<%@ page import="co.com.elramireza.sw.oauth.Facebook" %>
<%@ page import="java.net.URL" %>
<%@ page import="com.visural.common.IOUtil" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="co.com.elramireza.sw.model.Participante" %>
<jsp:useBean id="swManager" scope="application" class="co.com.elramireza.sw.dao.SwDAO" /><%
    String r =request.getRequestURI();
    System.out.println("r = " + r);
    String ctrl = (String) request.getAttribute("ctrl");
    System.out.println("ctrl = " + ctrl);

String code = request.getParameter("code");
    System.out.println("code = " + code);
    if(code != null){
        String authURL = Facebook.getAuthURL(code);
        URL url = new URL(authURL);
        String result = Facebook.readURL(url);

        String accessToken = null;
        Integer expires = null;

        String[] pairs = result.split("&");
        for (String pair : pairs) {
            String[] kv = pair.split("=");
            if (kv.length != 2) {
                throw new RuntimeException("Unexpected auth response");
            } else {
                if (kv[0].equals("access_token")) {
                    accessToken = kv[1];
                }
                if (kv[0].equals("expires")) {
                    expires = Integer.valueOf(kv[1]);
                }
            }
        }

        System.out.println("accessToken = " + accessToken);
        System.out.println("expires = " + expires);

        if (accessToken != null && expires != null) {
            JSONObject resp = new JSONObject(
                IOUtil.urlToString(new URL("https://graph.facebook.com/me?access_token=" + accessToken))
            );
            String id = resp.getString("id");
            System.out.println("id = " + id);

            String firstName = "";
            if (resp.has("first_name")) {
                firstName = resp.getString("first_name") + " ";
                System.out.println("firstName = " + firstName);
            }

            String middleName = "";
            if (resp.has("middle_name")) {
                middleName = resp.getString("middle_name") + " ";
                System.out.println("middleName = " + middleName);
            }

            String lastName = "";
            if (resp.has("last_name")) {
                lastName = resp.getString("last_name");
                System.out.println("lastName = " + lastName);
            }

            String email = resp.getString("email");
            System.out.println("email = " + email);

            // SESSION
            Participante participante = (Participante) session.getAttribute("participante");
            if (participante == null) {  // NO HAY USUARIO EN SESSION - CREA NUEVO USUARIO
                System.out.println("id FACEBOOK = " + id);
                participante = swManager.getParticipanteFB(id);
                if (participante == null) {  // NO EXISTE IdFB EN DB CREA UNO NUEVO
                    participante = new Participante();
                    participante.setIdFacebook(id);
                    participante.setEspecialidadByIdEspecialidad(swManager.getEspecialidad(4)); // SIN ESPECIALIDAD
                    participante.setNombreParticipante(firstName + middleName + lastName);
                    participante.setEmailParticipante(email);
                    participante.setPassword(swManager.getRandomPassword());

                    String[] emails = {email};
                    int ok = swManager.enviaEmail(
                            emails,
                            "p4s.co Bienvenido",
                            "Se ha registrado en http://p4s.co  <br>" +
                                    "Su login es " + email +
                                    "<br>Su password es: " + participante.getPassword() +
                                    "<br>igualmente puede ingresar con su cuenta de facebook",
                            null,
                            1
                    );
                    participante = swManager.saveParticipante(participante);
                }

                participante.setToken(accessToken);
                session.setAttribute("participante", participante);  // SESSION

                Participante enSession = (Participante) session.getAttribute("participante");
                System.out.println("enSession = " + enSession);
                if(enSession!= null){
                    System.out.println("enSession.getNombreParticipante() = " + enSession.getNombreParticipante());
                }
                response.sendRedirect("index.htm");
            } else { // SI HAY USUARIO EN SESSION - VINCULA EL USUARIO A FB
                participante = swManager.setIdFacebookAParticipante(participante, id);
                participante.setToken(accessToken);
                session.setAttribute("participante", participante);  // SESSION
                response.sendRedirect("admonParticipante.htm");
            }
        } else {
            throw new RuntimeException("Access token and expires not found");
        }

    }

    String errorReason = request.getParameter("error_reason");
    if(errorReason != null){  // PROBLE DE ACCESO
        String error = request.getParameter("error");
        String description = request.getParameter("error_description");
//        response.sendError(HttpServletResponse.SC_UNAUTHORIZED, description);
        System.out.println(errorReason);
        System.out.println(error);
        System.out.println(description);

        response.sendRedirect("index.htm?problema=1");

    }


%>