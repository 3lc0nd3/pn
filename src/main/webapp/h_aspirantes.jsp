<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    SimpleDateFormat dfDateTime = new SimpleDateFormat("yyyy/MM/dd hh:mm aaa");
    Texto texto = pnManager.getTexto(12);

    PnTipoPremio tipoPremio = (PnTipoPremio) session.getAttribute("tipoPremio");

    List<PnAspiranteEvaluador> aspirantes = pnManager.getHibernateTemplate().find(
            "from PnAspiranteEvaluador where tipoPremioById.id = ? order by personaByIdPersona.nombrePersona",
            tipoPremio.getId()
    );

%>

<div class="miembros">
    <h2>Aspirantes a Evaluador a <%=tipoPremio.getSigla()%>
    </h2>
    <br>

    <table cellpadding="0" cellspacing="0" border="0" class="display" id="miembros">
        <thead>
        <tr>
            <th> Premio </th>
            <th> Doc. </th>
            <th> Nombre </th>
            <th> Emails</th>
            <%--<th> Email Personal</th>--%>
            <th> Tel&eacute;fonos </th>
            <%--<th> Celular </th>--%>
            <th> Fecha Ingreso </th>
            <th> Estado </th>
            <%--<th width="28"> Editar </th>--%>
        </tr>
        </thead>
        <%
            String imageActive;
            String messaActive;
            for (PnAspiranteEvaluador aspiranteEvaluador: aspirantes){
                Persona persona = aspiranteEvaluador.getPersonaByIdPersona();
                if(persona.getEstado()){
                    imageActive = "img/positive.png";
                    messaActive = "Desactivar?";
                } else {
                    imageActive = "img/negative.png";
                    messaActive = "Activar?";
                }
        %>
        <tr>
            <td> <%=aspiranteEvaluador.getPnPremioByIdConvocatoria()==null?"":aspiranteEvaluador.getPnPremioByIdConvocatoria().getNombrePremio() %></td>
            <td> <%=persona.getDocumentoIdentidad() %></td>
            <td>
                <%=persona.getNombrePersona() %>
                <%=persona.getApellido() %>
            </td>
            <td>
                <%=persona.getEmailPersonal()!=null?persona.getEmailPersonal():"" %>
                <br>
                <%=persona.getEmailCorporativo() %>
            </td>
            <td>
                <%=persona.getCelular()!=null?persona.getCelular():""%>
                <br>
                <%=persona.getTelefonoFijo() %>
            </td>
            <td>
                <%=dfDateTime.format(persona.getFechaCreacion())%>
            </td>
            <td><img id="imgActivePersona<%=persona.getIdPersona()%>" width="28" onclick="activaDesactiva(<%=persona.getIdPersona()%>);" src="<%=imageActive%>" alt="<%=messaActive%>" title="<%=messaActive%>"></td>
            <%--<td>
                <img width="36" onclick="cargaPersona(<%=persona.getIdPersona()%>);" src="img/edit.png" alt="edita" title="edita">
            </td>--%>
            <%--<td> <%=persona.getLocCiudadByIdCiudad().getNombreCiudad() %></td>--%>
        </tr>
        <%
            }
        %>
    </table>
</div>

<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function activaDesactiva(id){
        $("#imgActivePersona"+id).attr("src","images/loading.gif");
        pnRemoto.activeDesactivePersona(id, function(data){
            if(data!=null){
                if(data){
                    $("#imgActivePersona"+id).attr("src","img/positive.png");
                    $("#imgActivePersona"+id).attr("title", "Desactivar?");
                    $("#imgActivePersona"+id).attr("alt",   "Desactivar?");
                } else {
                    $("#imgActivePersona"+id).attr("src","img/negative.png");
                    $("#imgActivePersona"+id).attr("title", "Activar?");
                    $("#imgActivePersona"+id).attr("alt",   "Activar?");
                }
            } else {
                alert("Problemas !");
            }
        });
    }

    function cargaPersona(id){
        pnRemoto.getPersona(id, function(data){
            dwr.util.setValues(data);
            dwr.util.setValue("departamento", data.locCiudadByIdCiudad.locEstadoByIdEstado.idEstado);
            dwr.engine.beginBatch();
            changeEstado();
            dwr.util.setValue("locCiudadPersona", data.locCiudadByIdCiudad.idCiudad);
            dwr.engine.endBatch();
            window.location = '#datosDePersona';
        });
    }

    function registarPersona(){
        var persona = {
            idPersona : null,
            nombrePersona : null,
            apellido : null,
            documentoIdentidad : null,
            emailPersonal : null,
            emailCorporativo : null,
            twitter : null,
            skype : null,
            telefonoFijo : null,
            celular : null,
            locCiudadPersona : null
        };
        dwr.util.getValues(persona);

        pnRemoto.savePersona(persona, function(data){
            if(data!= null){
                if(data == 1){
                    alert("Registro Correcto");
                    window.location = "miembros.htm";
                }
            }
        });
    }

    jQuery.validator.addMethod("fieldDiff", function(value, element, arg){
        return arg != value;
    }, jQuery.validator.messages.required);

    jQuery.validator.addMethod("selectNoZero", function(value, element, arg){
        return "0" != value;
    }, jQuery.validator.messages.required);

    jQuery(document).ready(function() {
        jQuery("#registroPersona").validate({
            rules: {
                locCiudadPersona:   "selectNoZero"
            }
        });
    });

    jQuery.validator.setDefaults({
        submitHandler: function() {
            registarPersona();
        }
    });

    function changeP(){
        var id = dwr.util.getValue("idPersona");
        var c1 = dwr.util.getValue("clave");
        var c2 = dwr.util.getValue("clave2");

        if(id==''){
            alert("Por favor seleccione una Persona primero");
        } else if(c1 == ''){
            alert("No puede ser vacio");
        } else if(c1 != c2){
            alert("Valores diferentes");
        } else {
            pnRemoto.cambiaP(id,c1, function(data){
                if(data==1){
                    alert("Cambio correcto");
                    dwr.util.setValue("clave", "");
                    dwr.util.setValue("clave2", "");
                } else {
                    alert("Problemas !");
                }
            });
        }

    }

    function changeEstado(){
        dwr.util.removeAllOptions("locCiudadPersona");
        var idEstado = dwr.util.getValue("departamento");
        pnRemoto.getLocCiudadesFromEstado(idEstado, function(data){
            dwr.util.addOptions("locCiudadPersona", data, "idCiudad", "nombreCiudad");
        });
    }

    $(document).ready(function() {
        $('#miembros').dataTable( {
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
</script>