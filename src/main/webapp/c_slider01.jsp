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
                <a href="#" class="da-link">Read more</a>
                <div class="da-img"><img src="<%=texto.getImage()%>" alt="image01" /></div>
            </div>
            <%
                }
            %>
           <%--
            <div class="da-slide">
                <div class="da-blue">
                    <h2><span><%=titulo3.getTexto1()%></span></h2>
                    <p><%=titulo3.getTexto2()%></p>
                    <a href="#" class="da-link">Read more</a>
                    <div class="da-img"><img src="img/parallax/1.png" alt="image01" /></div>
                </div>
            </div>
            <div class="da-slide">
                <div class="da-green">
                    <h2><span>Easy management</span></h2>
                    <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.</p>
                    <a href="#" class="da-link">Read more</a>
                    <div class="da-img"><img src="img/parallax/2.png" alt="image01" /></div>
                </div>
            </div>
            <div class="da-slide">
                <h2><span>Revolution</span></h2>
                <p>A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.</p>
                <a href="#" class="da-link">Read more</a>
                <div class="da-img"><img src="img/parallax/3.png" alt="image01" /></div>
            </div>
            <div class="da-slide">
                <h2><span>Quality Control</span></h2>
                <p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.</p>
                <a href="#" class="da-link">Read more</a>
                <div class="da-img"><img src="img/parallax/4.png" alt="image01" /></div>
            </div>
        --%>
            <nav class="da-arrows">
                <span class="da-arrows-prev"></span>
                <span class="da-arrows-next"></span>
            </nav>
        </div>
    </div>
</div>

<!-- Slider Ends -->