<%@ page import="co.com.elramireza.pn.model.Texto" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    PnTipoPremio tipoPremio = (PnTipoPremio) session.getAttribute("tipoPremio");
    Texto texto = pnManager.getTexto(1);
    Texto textoRegistro = pnManager.getTexto(10);
%>


<premios>
    <div class="register">
        <div class="row">
            <div class="span6">
                <div class="formy">
                    <a name="formPremio"></a>
                    <h5>Tipos de Premios</h5>
                    <div class="form">
                        <!-- Login form (not working)-->
                        <form id="formPremiof" class="form-inline">

                            <input id="id" type="hidden" >

                            <!-- Username -->
                            <div class="control-group">
                                <label class="control-label" for="nombreTipoPremio">Nombre</label>
                                <div class="controls">
                                    <input type="text" class="input-large required" name="nombreTipoPremio" id="nombreTipoPremio">
                                </div>
                            </div>
                            <!-- Username -->
                            <div class="control-group">
                                <label class="control-label" for="frase">Frase</label>
                                <div class="controls">
                                    <input type="text" class="input-large required" name="frase" id="frase">
                                </div>
                            </div>
                            <!-- fecha desde -->
                            <div class="control-group">
                                <label class="control-label" for="sigla">Sigla</label>
                                <div class="controls">
                                    <input type="text" class="input-large required" name="sigla" id="sigla">
                                </div>
                            </div>
                            <!-- color -->
                            <div class="control-group">
                                <label class="control-label" for="color">Color</label>
                                <div class="controls">
                                    <select name="color" id="color">
                                        <option value="blue">Azul</option>
                                        <option value="green">Verde</option>
                                        <option value="orange">Naranja</option>
                                        <option value="purple">Morado</option>
                                    </select>
                                </div>
                            </div>
                            <!-- Desc-->
                            <div class="control-group">
                                <label class="control-label" for="descripcion">Descripci&oacute;n</label>
                                <div class="controls">
                                    <%--<input type="text" class="input-large required" name="descripcion" id="descripcion">--%>
                                    <textarea  name="descripcion" id="descripcion"></textarea>
                                </div>
                            </div>
                            <!-- postulese -->
                            <div class="control-group">
                                <label class="control-label" for="postulese">Post&uacute;lese</label>
                                <div class="controls">
                                    <%--<input type="text" class="input-large required" name="postulese" id="postulese">--%>
                                    <textarea  name="postulese" id="postulese"></textarea>
                                </div>
                            </div>
                            <!-- registroEvaluador -->
                            <div class="control-group">
                                <label class="control-label" for="registroEvaluador">Registro Evaluador</label>
                                <div class="controls">
                                    <%--<input type="text" class="input-large required" name="registroEvaluador" id="registroEvaluador">--%>
                                    <textarea  name="registroEvaluador" id="registroEvaluador"></textarea>
                                </div>
                            </div>
                            <!-- Buttons -->
                            <div class="form-actions">
                                <!-- Buttons -->
                                <button type="submit" class="btn">Crear</button>
                                <button type="submit" class="btn">Modificar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="span6">

                <%--<%=tipoPremio.getDescripcion()%>--%>
                <%--<h2><%=texto.getTexto1()%></h2>--%>
                <%--<p class="big grey">
                    <%=texto.getTexto2()%>
                </p>
                <p style="text-align:justify;">
                    <%=texto.getTexto3()%>
                </p>--%>

            </div>
        </div>
    </div>
</premios>

<div class="row-fluid">
    <br>
    <table cellpadding="0" cellspacing="0" border="0" class="display" id="premiosT">
        <thead>
        <tr>
            <th>Id</th>
            <th>Sigla</th>
            <th>Nombre</th>
            <th>Color</th>
            <th>Fecha</th>
            <th>Estado</th>
            <th>Editar</th>
        </tr>
        </thead>
        <%
            SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");

            List<PnTipoPremio> list = pnManager.getHibernateTemplate().find("from PnTipoPremio order by nombreTipoPremio");

            String imageActive;
            String messaActive;
            for (PnTipoPremio pnTipoPremio : list){
                if(pnTipoPremio.isActivo()){
                    imageActive = "img/positive.png";
                    messaActive = "Desactivar?";
                } else {
                    imageActive = "img/negative.png";
                    messaActive = "Activar?";
                }
        %>
        <tr>
            <td><%=pnTipoPremio.getId()%></td>
            <td><%=pnTipoPremio.getSigla()%></td>
            <td><%=pnTipoPremio.getNombreTipoPremio()%></td>
            <td><%=pnTipoPremio.getColor()%></td>
            <td><%=df.format(pnTipoPremio.getFechaCreacion())%></td>
            <td>
                <img id="imgActiveInscripcion<%=pnTipoPremio.getId()%>" width="28" onclick="activaDesactiva(<%=pnTipoPremio.getId()%>);" src="<%=imageActive%>" alt="<%=messaActive%>" title="<%=messaActive%>">
            </td>
            <td>
                <img width="36" onclick="editaPremio(<%=pnTipoPremio.getId()%>);" src="img/edit.png" alt="edita" title="edita">
                <img width="36" onclick="revisaTipoPremio(<%=pnTipoPremio.getId()%>);" src="img/view.png" alt="ver" title="ver">
            </td>
        </tr>
        <%
            }
        %>
    </table>
</div>

<br>
<br>
<div class="border"></div>
<div id="labelExpor">
    <h3 class="color">Detalle de Calificaci&oacute;n</h3>
    <a name="detalleEmpresa"></a>
</div>
<span id="empresaDiv"></span>
<br>
<br>
<div class="border"></div>
<jsp:include page="c_footer_r.jsp"/>

<script src="scripts/interpretadorAjax.js"></script>

<script src="//tinymce.cachefly.net/4.1/tinymce.min.js"></script>

<script type="text/javascript">

    function activaDesactiva(id){
        if (id == 1) {
            alert("Para uso interno, no lo puedes activar.");
        } else {
            $("#imgActiveInscripcion" + id).attr("src", "images/loading.gif");
            pnRemoto.activeDesactiveTipoPremioN(id,function(data) {
                if (data == 3) {
                    alert("Problemas !");
                } else if (data == 2) {
                    alert("No puede haber mas de un Premio Activo");
                    $("#imgActiveInscripcion" + id).attr("src", "img/negative.png");
                    $("#imgActiveInscripcion" + id).attr("title", "Activar?");
                    $("#imgActiveInscripcion" + id).attr("alt", "Activar?");
                } else {
                    if (data == 1) {
                        $("#imgActiveInscripcion" + id).attr("src", "img/positive.png");
                        $("#imgActiveInscripcion" + id).attr("title", "Desactivar?");
                        $("#imgActiveInscripcion" + id).attr("alt", "Desactivar?");
                    } else {
                        $("#imgActiveInscripcion" + id).attr("src", "img/negative.png");
                        $("#imgActiveInscripcion" + id).attr("title", "Activar?");
                        $("#imgActiveInscripcion" + id).attr("alt", "Activar?");
                    }
                }
            });
        }
    }

    function editaPremio(id){
        pnRemoto.getPnTipoPremio(id, function(data){
            if(data!=null){
//                alert("Guardado");
                dwr.util.setValues(data);
//                alrt(data.descripcion);
                tinyMCE.get('descripcion').setContent(data.descripcion);
                tinyMCE.get('postulese').setContent(data.postulese);
                tinyMCE.get('registroEvaluador').setContent(data.registroEvaluador);
                window.location = '#formPremio';
            } else {
//                alert("Problema!");
            }
        });

    }

    function resetFormPremio(){
        dwr.util.byId('formPremiof').reset();
        dwr.util.setValue('id', 0);
    }

    function guardaPremio(){
        var premio = {
            id : null,
            nombreTipoPremio : null,
            frase : null,
            sigla : null,
            color : null,
            descripcion : null,
            postulese : null,
            registroEvaluador : null
        };

        dwr.util.getValues(premio);

        tinyMCE.triggerSave();
        premio.descripcion= $('#descripcion').val();
        premio.postulese= $('#postulese').val();
        premio.registroEvaluador= $('#registroEvaluador').val();

//        alert("premio.color = " + premio.color);

        pnRemoto.savePnTipoPremio(premio, function(data){
            if(data==1){
                alert('Guardado');
                window.location = "tipoPremio.htm";
            } else {
                alert('Problemas!');
            }
        });

    }

    jQuery(document).ready(function() {
        jQuery("#formPremiof").validate();
    });



    jQuery.validator.setDefaults({
        submitHandler: function() {
            guardaPremio();
        }
    });

    $(document).ready(function() {
        $('#premiosT').dataTable( {
            "aaSorting": [[ 1, "asc" ]],
            "sPaginationType": "full_numbers",
            "oLanguage": {
//                "sLengthMenu": "Mostrar _MENU_ registros",
                "sZeroRecords": "Sin resultados",
                "sInfo": "Mostrando _START_ a _END_ de _TOTAL_ registros",
                "sInfoEmpty": "Mostrando 0 a 0 de 0 registros",
                "sInfoFiltered": "(Filtrado de _MAX_ registros en total)",
                "sSearch": "Buscar en la tabla:",
                "oPaginate": {
                    "sPrevious": "Anterior",
                    "sNext": "Siguiente",
                    "sFirst": "Primera",
                    "sLast": "&Uacute;ltima"
                },
                "sLengthMenu": 'Mostrar <select>'+
                '<option value="5">5</option>'+
                '<option value="10">10</option>'+
                '<option value="20">20</option>'+
                '<option value="30">30</option>'+
                '<option value="40">40</option>'+
                '<option value="50">50</option>'+
                '<option value="-1">All</option>'+
                '</select> registros'
            }
        } );
    } );

    function revisaTipoPremio(id){

//        dwr.util.setValue("empresaExportDiv", '<a href="h_informeRetroW.jsp?k='+id+'">Exportar <img src="img/word.png" alt="Word" title="Word" width="36"></a>', { escapeHtml:false });

        frontController.getIncludeTipoPremioAdmon(id, function(data){
//            alert("data = " + data);
            dwr.util.setValue("empresaDiv", data, { escapeHtml:false });
            window.location = '#detalleEmpresa';
            var scsPopular = data.extractScript();
//            alert("scsPopular = " + scsPopular);
            scsPopular.evalScript();
        });

    }

    tinymce.init({
        selector: "textarea",
        height: 125,
        doctype: '',
        convert_urls: false,
        plugins: [
            "advlist autolink autosave link image lists charmap print preview hr anchor pagebreak spellchecker",
            "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
            "table contextmenu directionality emoticons template textcolor paste textcolor colorpicker textpattern code"
        ],

        toolbar1: "bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | styleselect formatselect fontselect fontsizeselect",
        toolbar2: "cut copy paste | searchreplace | bullist numlist | outdent indent blockquote | undo redo | link unlink | insertdatetime preview ",
        toolbar3: "forecolor backcolor | hr removeformat | subscript superscript | charmap emoticons | fullscreen ",

        menubar: false,
        toolbar_items_size: 'small',

        style_formats: [
            {title: 'Bold text', inline: 'b'},
            {title: 'Red text', inline: 'span', styles: {color: '#ff0000'}},
            {title: 'Red header', block: 'h1', styles: {color: '#ff0000'}},
            {title: 'Example 1', inline: 'span', classes: 'example1'},
            {title: 'Example 2', inline: 'span', classes: 'example2'},
            {title: 'Table styles'},
            {title: 'Table row 1', selector: 'tr', classes: 'tablerow1'}
        ],

        templates: [
            {title: 'Test template 1', content: 'Test 1'},
            {title: 'Test template 2', content: 'Test 2'}
        ]
    });


</script>