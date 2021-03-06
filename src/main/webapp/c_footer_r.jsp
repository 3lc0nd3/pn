
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%@ page import="co.com.elramireza.pn.model.Texto" %>
<%@ page import="co.com.elramireza.pn.model.PnTipoPremio" %>
<%
    PnTipoPremio tipoPremio = (PnTipoPremio) session.getAttribute("tipoPremio");
%>
<hr/>
<div class="border"></div>
</div>   <%-- END CONTAINER --%>
</div> <%-- END CONTENT --%>

<!-- Social -->

<div class="social-links">
    <div class="container">
        <div class="row">
            <div class="span12">
                <p class="big">
                    <span>
                        <%
                            Texto titulo9 = pnManager.getTexto(9);
                        %>
                        <%=titulo9.getTexto1()%>
                    </span> <a href="#">
                    <%--<i class="icon-asterisk"></i>Asterisk</a> <a href="#">--%>
                    <i class="icon-facebook"></i>Facebook</a> <a href="#">
                    <i class="icon-twitter"></i>Twitter</a> <a href="#">
                    <i class="icon-google-plus"></i>Google Plus</a> <a href="#">
                    <i class="icon-linkedin"></i>LinkedIn</a>
                </p>
            </div>
        </div>
    </div>
</div>


<!-- Footer -->
<footer>
    <div class="container">
        <div class="row">

            <div class="widgets">
                <div class="span4">
                    <div class="fwidget">
                        <%--<h5>Downlaods</h5>
                        <ul>
                            <li><a href="#">Condimentum</a></li>
                            <li><a href="#">Etiam at</a></li>
                            <li><a href="#">Fusce vel</a></li>
                            <li><a href="#">Vivamus</a></li>
                            <li><a href="#">Pellentesque</a></li>
                        </ul>--%>
                    </div>
                </div>

                <div class="span4">
                    <div class="fwidget">
                        <%--<h5>Support</h5>
                        <ul>
                            <li><a href="#">Condimentum</a></li>
                            <li><a href="#">Etiam at</a></li>
                            <li><a href="#">Fusce vel</a></li>
                            <li><a href="#">Vivamus</a></li>
                            <li><a href="#">Pellentesque</a></li>
                        </ul>--%>
                    </div>
                </div>

                <div class="span4">
                    <div class="fwidget">
                        <%--<h5>Recent Posts</h5>
                        <ul>
                            <li><a href="#">Sed eu leo orci, condimentum gravida metus</a></li>
                            <li><a href="#">Etiam at nulla ipsum, in rhoncus purus</a></li>
                            <li><a href="#">Fusce vel magna faucibus felis dapibus facilisis</a></li>
                            <li><a href="#">Vivamus scelerisque dui in massa</a></li>
                            <li><a href="#">Pellentesque eget adipiscing dui semper</a></li>
                        </ul>--%>
                    </div>
                </div>
            </div>

            <div class="span12">
                <div class="copy">
                    <h5>
                        <%
                            Texto titulo = pnManager.getTexto(2);
                            Texto titulo1 = pnManager.getTexto(1);
                        %>
                        <%=titulo.getTexto1()%>
                        <span class="color">
                            <%=titulo.getTexto2()%>
                        </span>
                        <%
                            if(tipoPremio!=null){
                        %>
                        - <%=tipoPremio.getNombreTipoPremio()%>
                        <%
                            }
                        %>
                    </h5>
                    <p>Copyright &copy;
                        <a href="http://www.ccalidad.org" target="cc">www.ccalidad.org</a> </p>
                    -
                    <a href="http://www.premionacionalexcelencia.org" target="pnn">www.premionacionalexcelencia.org</a> </p>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
</footer>

<!-- DATE -->
<script src="js/date.js"></script>

<!-- JS -->
<script src="js/jquery.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/jquery.isotope.js"></script>
<script src="js/jquery.prettyPhoto.js"></script>
<script src="js/jquery.cslider.js"></script>
<script src="js/modernizr.custom.28468.js"></script>
<script src="js/filter.js"></script>
<script src="js/cycle.js"></script>
<script src="js/custom.js"></script>


    <script type="text/javascript">
//        jQuery.metadata.setType("attr", "validate");
    </script>

<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='dwr/interface/pnRemoto.js'></script>
<script type='text/javascript' src='dwr/interface/frontController.js'></script>
<script type='text/javascript' src='dwr/util.js'></script>

<link href="scripts/jquery/jquery-notice/jquery.notice.css" rel="stylesheet">
<script src="scripts/jquery/jquery-notice/jquery.notice.js"></script>

<script src="js/myScript.js"></script>

<script src="js/jquery-validate/jquery.validate.min.js"></script>
<script src="js/jquery-validate/messages_es.js"></script>
<script src="js/jquery-validate/additional-methods.min.js"></script>

<script src="js/jquery.formatCurrency-1.4.0.min.js"></script>

<script src="js/datePicker/bootstrap-datepicker.js"></script>
<script src="js/datePicker/locales/bootstrap-datepicker.es.js"></script>

<script src="js/jquery.jeditable.js"></script>
<%--<script src="js/jquery.jeditable.tinymce.js"></script>--%>


    <%-- Data Table--%>

<script src="js/datatable/js/jquery.dataTables.min.js"></script>
<script src="js/datatable/js/shCore.js"></script>

<%--  LOS SCRIPTS--%>

<script src="js/pn.js"></script>

</body>
</html>

<script type="text/javascript">
    $(document).ready(function(){
        $('.currency').blur(function(){
            $('.currency').formatCurrency({
                roundToDecimalPlace : 0,
                colorize:true
            });
        });
    });


</script>

<script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-62810432-1', 'auto');
    ga('send', 'pageview');

</script>