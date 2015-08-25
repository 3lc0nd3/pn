<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %><%

    PnTipoPremio tipoPremio = (PnTipoPremio) request.getAttribute("tipoPremio");

    List<PnPrincipioCualitativo> cualitativos;
    cualitativos = pnManager.getHibernateTemplate().find(
            "from PnPrincipioCualitativo where pnTipoPremioById.id = ? order by id",
            tipoPremio.getId()
    );

    if(cualitativos.size()==0){
        List<PnModeloCualitativa> modeloCualitativas = pnManager.getHibernateTemplate().find(
                "from PnModeloCualitativa order by id"
        );
        for(PnModeloCualitativa modeloCualitativa : modeloCualitativas){
            PnPrincipioCualitativo principioCualitativo = new PnPrincipioCualitativo();
            principioCualitativo.setPnTipoPremioById(tipoPremio);
            principioCualitativo.setCampo(modeloCualitativa.getCampoCualitativa());
            principioCualitativo.setNombreCualitativa(modeloCualitativa.getNombreCualitativa());
            principioCualitativo.setTextoCualitativa(modeloCualitativa.getTextoCualitativa());
            pnManager.getHibernateTemplate().save(principioCualitativo);
        }
        cualitativos = pnManager.getHibernateTemplate().find(
                "from PnPrincipioCualitativo where pnTipoPremioById.id = ? order by id",
                tipoPremio.getId()
        );
    }

    List<PnCategoriaCriterio> categoriasCriterios = pnManager.getCategoriasCriterio(
            tipoPremio.getId());

    if(categoriasCriterios.size() == 0){
        List<PnModeloCategoriaCriterio> modeloCategoriaCriterios = pnManager.getHibernateTemplate().find(
                "from PnModeloCategoriaCriterio order by id"
        );
        for (PnModeloCategoriaCriterio modeloCategoriaCriterio: modeloCategoriaCriterios){
            PnCategoriaCriterio categoriaCriterio = new PnCategoriaCriterio();
            categoriaCriterio.setPnTipoPremioById(tipoPremio);
            categoriaCriterio.setCategoriaCriterio(modeloCategoriaCriterio.getCategoriaCriterio());

            Integer id = (Integer) pnManager.getHibernateTemplate().save(categoriaCriterio);
            categoriaCriterio.setId(id);

            //  TRAIGO TODOS LOS MODELOS DE CRITERIO, SEGUN EL MODELO DE CATEGORIA
            List<PnModeloCriterio> modelosCriterios = pnManager.getHibernateTemplate().find(
                    "from PnModeloCriterio where modeloCategoriaCriterioById.id=? order by id",
                    modeloCategoriaCriterio.getId()
            );
            for(PnModeloCriterio modeloCriterio: modelosCriterios){
                PnCriterio pnCriterio = new PnCriterio();
                pnCriterio.setPnCategoriaCriterioByIdCategoriaCriterio(categoriaCriterio);
                pnCriterio.setCriterio(modeloCriterio.getCriterio());
                pnCriterio.setEvalua(modeloCriterio.getEvalua());
                pnCriterio.setC20(modeloCriterio.getC20());
                pnCriterio.setC40(modeloCriterio.getC40());
                pnCriterio.setC50(modeloCriterio.getC50());
                pnCriterio.setC60(modeloCriterio.getC60());
                pnCriterio.setC80(modeloCriterio.getC80());
                pnCriterio.setC100(modeloCriterio.getC100());
                pnManager.getHibernateTemplate().save(pnCriterio);
            }  //  END FOR MODELOS DE CRITERIO
        }  //  END FOR MODELOS DE CATEGORIA DE CRITERIOS

        categoriasCriterios = pnManager.getCategoriasCriterio(tipoPremio.getId());
    }

    List<PnCapitulo> capitulos = pnManager.getPnCapitulos(tipoPremio.getId());

    if(capitulos.size()==0){
        List<PnModeloCapitulo> modeloCapitulos = pnManager.getHibernateTemplate().find(
                "from PnModeloCapitulo order by numeroCapitulo"
        );
        for(PnModeloCapitulo modeloCapitulo: modeloCapitulos){
            PnCapitulo capitulo = new PnCapitulo();
            capitulo.setPnTipoPremioById(tipoPremio);
            capitulo.setNumeroCapitulo(modeloCapitulo.getNumeroCapitulo());
            capitulo.setEvaluaCapitulo(modeloCapitulo.getEvaluaCapitulo());
            capitulo.setNombreCapitulo(modeloCapitulo.getCriterio());
            capitulo.setMaximo(modeloCapitulo.getMaximo());

            Integer id = (Integer) pnManager.getHibernateTemplate().save(capitulo);
            capitulo.setId(id);

            //  TRAIGO TODOS LOS MODELOS DE SUB_CAPITULO, SEGUN EL MODELO DE CAPITULO
            List<PnModeloSubCapitulo> modeloSubCapitulos = pnManager.getHibernateTemplate().find(
                    "from PnModeloSubCapitulo where modeloCapitulo.id =? order by codigoItem",
                    modeloCapitulo.getId()
            );
            for(PnModeloSubCapitulo modeloSubCapitulo: modeloSubCapitulos){
                PnSubCapitulo subCapitulo = new PnSubCapitulo();
                subCapitulo.setPnCapituloByIdCapitulo(capitulo);
                subCapitulo.setPonderacion(modeloSubCapitulo.getPonderacion());
                subCapitulo.setCodigoItem(modeloSubCapitulo.getCodigoItem());
                subCapitulo.setSubCapitulo(modeloSubCapitulo.getSubCapitulo());
                subCapitulo.setEvalua(modeloSubCapitulo.getEvaluaItem());
                subCapitulo.setC20(modeloSubCapitulo.getC20());
                subCapitulo.setC40(modeloSubCapitulo.getC40());
                subCapitulo.setC60(modeloSubCapitulo.getC60());
                subCapitulo.setC80(modeloSubCapitulo.getC80());
                subCapitulo.setC100(modeloSubCapitulo.getC100());
                pnManager.getHibernateTemplate().save(subCapitulo);
            }  //  END FOR MODELOS DE SUB_CAPITULO
        }  //  END FOR MODELOS DE CAPITULO

        capitulos = pnManager.getPnCapitulos(tipoPremio.getId());
    }
%>
<h2><%=tipoPremio.getSigla()%> - <%=tipoPremio.getNombreTipoPremio()%></h2>
<h4>
    <img src="images/help.png" onclick="muestraSeccion('cualitativaT');" width="24" alt="Cualitativa" title="Cualitativa">
    Cualitativa</h4>
<table id="cualitativaT" class="table-bordered table" style="display:none;">
    <tr>
        <th>Nombre</th>
        <th>Texto</th>
    </tr>
    <%
        for (PnPrincipioCualitativo cualitativo: cualitativos){
    %>
    <tr>
        <td>
            <p class="editable_textarea" id="PnPrincipioCualitativo_nombreCualitativa_<%=cualitativo.getId()%>"><%=cualitativo.getNombreCualitativa()%></p>
        </td>
        <td>
            <p class="editable_textarea" id="PnPrincipioCualitativo_textoCualitativa_<%=cualitativo.getId()%>"><%=cualitativo.getTextoCualitativa()%></p>
        </td>
    </tr>
    <%
        }  //  END FOR CUALITATIVOS
    %>
</table>
<%--  END CUALITATIVA  --%>

<%--  CRITERIOS  --%>
<h4>
    <img src="images/help.png" onclick="muestraSeccion('criteriosT');" width="24" alt="Criterios" title="Criterios">
    Criterios</h4>
<table id="criteriosT" style="display:none;" class="table-bordered table">
    <%
        for(PnCategoriaCriterio categoriaCriterio: categoriasCriterios){
    %>
    <tr>
        <td bgcolor="#f0f8ff">
            <img src="images/help.png" onclick="muestraCriterios('<%=categoriaCriterio.getId()%>');" width="24" alt="Contenido" title="Contenido">
        </td>
        <td bgcolor="#f0f8ff">
            <p class="editable_textarea" id="PnCategoriaCriterio_categoriaCriterio_<%=categoriaCriterio.getId()%>" style="font-weight: bolder;"><%=categoriaCriterio.getCategoriaCriterio()%></p>
        </td>
        <td>
            <span onclick="addCriterio('<%=categoriaCriterio.getId()%>');"><img src="img/edit.png" width="24" alt="Nuevo Criterio" title="Nuevo Criterio">
            Nuevo Criterio</span>
        </td>
    </tr>
    <tr id="categoria<%=categoriaCriterio.getId()%>" style="display:none;">
        <td colspan="3">
            <table class="table-bordered table" style="width: 100%">
                <%
                    List<PnCriterio> criterios = pnManager.getPnCriteriosFromCategoria(categoriaCriterio.getId());
                    for (PnCriterio criterio: criterios){
                %>
                <tr>
                    <th><img src="images/help.png" onclick="muestraValoresCriterios('<%=criterio.getId()%>');" width="24" alt="Contenido" title="Contenido"></th>
                    <td><p class="editable_textarea" id="PnCriterio_criterio_<%=criterio.getId()%>"><%=criterio.getCriterio()%></p></td>
                    <td><span onclick="deleteCriterio('<%=criterio.getId()%>');"><img src="images/drop.png" width="24" alt="Borrar este Criterio" title="Borrar este Criterio">
                        Borrar este Criterio</span>
                    </td>
                </tr>
                <tr id="criterio<%=criterio.getId()%>" style="display:none;">
                    <td colspan="3">
                        <table style="width: 100%">
                            <tr>
                                <th>Evalua</th>
                                <td><p class="editable_textarea" id="PnCriterio_evalua_<%=criterio.getId()%>"><%=criterio.getEvalua()%></p></td>
                            </tr>
                            <tr>
                                <th>0..20</th>
                                <td><p class="editable_textarea" id="PnCriterio_c20_<%=criterio.getId()%>"><%=criterio.getC20()%></p></td>
                            </tr>
                            <tr>
                                <th>21..40</th>
                                <td><p class="editable_textarea" id="PnCriterio_c40_<%=criterio.getId()%>"><%=criterio.getC40()%></p></td>
                            </tr>
                            <tr>
                                <th>50</th>
                                <td><p class="editable_textarea" id="PnCriterio_c50_<%=criterio.getId()%>"><%=criterio.getC50()%></p></td>
                            </tr>
                            <tr>
                                <th>41..60</th>
                                <td><p class="editable_textarea" id="PnCriterio_c60_<%=criterio.getId()%>"><%=criterio.getC60()%></p></td>
                            </tr>
                            <tr>
                                <th>61..80</th>
                                <td><p class="editable_textarea" id="PnCriterio_c80_<%=criterio.getId()%>"><%=criterio.getC80()%></p></td>
                            </tr>
                            <tr>
                                <th>81..100</th>
                                <td><p class="editable_textarea" id="PnCriterio_c100_<%=criterio.getId()%>"><%=criterio.getC100()%></p></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <%
                    }  //  END FOR CRITERIO SEGUN CATEGORIA
                %>
            </table>
        </td>
    </tr>
    <%
        }  //  END FOR CATEGORIAS DE CRITERIO
    %>

</table>
<%--  END CRITERIOS  --%>

<%--  ITEMS Cuantitativa  --%>
<h4>
    <img src="images/help.png" onclick="muestraSeccion('cuantitativaT');" width="24" alt="Cuantitativa" title="Cuantitativa">
    Cuantitativa</h4>
<table id="cuantitativaT" style="display:none;" class="table-bordered table">
    <%
        for(PnCapitulo capitulo: capitulos){
    %>
    <tr>
        <td bgcolor="#f0f8ff">
            <img src="images/help.png" onclick="muestraCosas('capitulo','<%=capitulo.getId()%>');" width="24" alt="Contenido" title="Contenido">
        </td>
        <td>
            <p class="editable_textarea" id="PnCapitulo_numeroCapitulo_<%=capitulo.getId()%>" ><%=capitulo.getNumeroCapitulo()%></p>
        </td>
        <td bgcolor="#f0f8ff">
            <p class="editable_textarea" id="PnCapitulo_nombreCapitulo_<%=capitulo.getId()%>" style="font-weight: bolder;"><%=capitulo.getNombreCapitulo()%></p>
        </td>
    </tr>
    <tr id="capitulo<%=capitulo.getId()%>" style="display:none;">
        <td colspan="3">
            <table class="table-bordered table" style="width: 100%">
                <%
                    List<PnSubCapitulo> pnSubCapitulos = pnManager.getHibernateTemplate().find(
                            "from PnSubCapitulo where pnCapituloByIdCapitulo.id =? order by codigoItem",
                            capitulo.getId()
                    );
                    for (PnSubCapitulo subCapitulo: pnSubCapitulos){
                %>
                <tr>
                    <th>
                        <img src="images/help.png" onclick="muestraCosas('subCapitulo','<%=subCapitulo.getId()%>');" width="24" alt="Contenido" title="Contenido">
                    </th>
                    <td>
                        <p class="editable_textarea" id="PnSubCapitulo_codigoItem_<%=subCapitulo.getId()%>" ><%=subCapitulo.getCodigoItem()%></p>
                    </td>
                    <td><p class="editable_textarea" id="PnSubCapitulo_subCapitulo_<%=subCapitulo.getId()%>"><%=subCapitulo.getSubCapitulo()%></p></td>
                </tr>
                <tr id="subCapitulo<%=subCapitulo.getId()%>" style="display:none;">
                    <td colspan="3">
                        <table>
                            <tr>
                                <th>Evalua</th>
                                <td><p class="editable_textarea" id="PnSubCapitulo_evalua_<%=subCapitulo.getId()%>"><%=subCapitulo.getEvalua()%></p></td>
                            </tr>
                            <tr>
                                <th>Puntaje</th>
                                <td><p class="editable_textarea" id="PnSubCapitulo_ponderacion_<%=subCapitulo.getId()%>"><%=subCapitulo.getPonderacion()%></p></td>
                            </tr>
                            <tr>
                                <th>0..20</th>
                                <td><p class="editable_textarea" id="PnSubCapitulo_c20_<%=subCapitulo.getId()%>"><%=subCapitulo.getC20()%></p></td>
                            </tr>
                            <tr>
                                <th>21..40</th>
                                <td><p class="editable_textarea" id="PnSubCapitulo_c40_<%=subCapitulo.getId()%>"><%=subCapitulo.getC40()%></p></td>
                            </tr>
                            <tr>
                                <th>41..60</th>
                                <td><p class="editable_textarea" id="PnSubCapitulo_c60_<%=subCapitulo.getId()%>"><%=subCapitulo.getC60()%></p></td>
                            </tr>
                            <tr>
                                <th>61..80</th>
                                <td><p class="editable_textarea" id="PnSubCapitulo_c80_<%=subCapitulo.getId()%>"><%=subCapitulo.getC80()%></p></td>
                            </tr>
                            <tr>
                                <th>81..100</th>
                                <td><p class="editable_textarea" id="PnSubCapitulo_c100_<%=subCapitulo.getId()%>"><%=subCapitulo.getC100()%></p></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
        </td>
    </tr>
    <%
        }  //  END FOR CAPITULOS
    %>
</table>
<%--  END ITEMS Cuantitativa  --%>

<script src="js/jquery.js"></script>
<script src="js/jquery.jeditable.js"></script>
<script type="text/javascript">
//    alert("hola");
    $(".editable_textarea").editable(
            function(value, settings){
                var principioParams = this.id.split("_");
//                alert("principioParams = " + principioParams[2]); // 0 t,1 f,2 id
//                alert("principioParams = " + principioParams); // 0 t,1 f,2 id
                pnRemoto.actualizaPrincipioCalificacion(
                        <%=tipoPremio.getId()%>,
                        principioParams[2],
                        value,
                        principioParams[0],
                        principioParams[1],
                        function(data){
                            if(data==1){
                                alrt("Guardado");
                            }
                });
                return(value);
            }, {
                indicator : "<img src='img/indicator.gif'>",
                type   : 'textarea',
                tooltip   : 'Click para editar...',
                submit : 'OK',
                cancel : 'Cancelar',
                cssclass : "editable"
            }
    );

    function muestraCriterios(idCategoria){
        var contenidoTR = "#categoria" + idCategoria;
//        alert("contenidoTR = " + contenidoTR);
        $(contenidoTR).toggle();
    }

    function muestraValoresCriterios(idCriterio){
        var contenidoTR = "#criterio" + idCriterio;
//        alert("contenidoTR = " + contenidoTR);
        $(contenidoTR).toggle();
    }

    function muestraCosas(name, id){
        var contenidoTR = "#"+name + id;
//        alert("contenidoTR = " + contenidoTR);
        $(contenidoTR).toggle();
    }

    function muestraSeccion(seccion){
        var contenidoTR = "#"+seccion;
//        alert("contenidoTR = " + contenidoTR);
        $(contenidoTR).toggle();
    }

    function addCriterio(idCategoriaCriterio){
        pnRemoto.addCriterioAdmin(idCategoriaCriterio, function(data){
            if(data==0){
                alrtError("Problemas");
            } else {
                alrt("Creado");
                revisaTipoPremio(<%=tipoPremio.getId()%>);
            }
        });
    }

    function deleteCriterio(idCriterio){
        pnRemoto.deleteCriterioAdmin(idCriterio, function(data){
            if(data==0){
                alrtError("Problemas");
            } else {
                alrtError("Eliminado");
                revisaTipoPremio(<%=tipoPremio.getId()%>);
            }
        });
    }

</script>