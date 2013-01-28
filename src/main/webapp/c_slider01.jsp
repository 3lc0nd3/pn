<%@ page import="co.com.elramireza.pn.model.Texto" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<!-- Slider starts -->

<%
    List<Texto> titulos = pnManager.getTextosSlider("sl01");
%>


<div class="row">
    <div class="span12">
        <!-- Slider (Parallax Slider) -->
        <div id="da-slider" class="da-slider">
            <%
                for (Texto texto: titulos){
            %>
            <div class="da-slide">
                <h2>
                    <span>
                        <%=texto.getTexto1()%>
                    </span>
                </h2>
                <p>
                    <%=texto.getTexto2()%>
                </p>
                <a href="#" class="da-link">Leer m&aacute;s</a>
                <div class="da-img"><img src="<%=texto.getImage()%>" alt="image01" /></div>
            </div>
            <%
                }
            %>
            <nav class="da-arrows">
                <span class="da-arrows-prev"></span>
                <span class="da-arrows-next"></span>
            </nav>
        </div>
    </div>
</div>

<!-- Slider Ends -->