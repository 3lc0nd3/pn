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

    List<PnCategoriaCriterio> categoriasCriterios = pnManager.getHibernateTemplate().find(
            "from PnCategoriaCriterio where pnTipoPremioById.id = ? order by id",
            tipoPremio.getId()
    );

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
%>
<h2><%=tipoPremio.getSigla()%> - <%=tipoPremio.getNombreTipoPremio()%></h2>
<h4>Cualitativa</h4>
<table class="table-bordered table">
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
        }
    %>
</table>
<%--  END CUALITATIVA  --%>
<h4>Criterios</h4>
<table class="table-bordered table">
    <%
        for(PnCategoriaCriterio categoriaCriterio: categoriasCriterios){
    %>
    <tr>
        <td bgcolor="#f0f8ff"><p><%=categoriaCriterio.getCategoriaCriterio()%></p></td>
    </tr>
    <tr>
        <td>
            <table class="table-bordered table" style="width: 100%">
                <%
                    List<PnCriterio> criterios = pnManager.getPnCriteriosFromCategoria(categoriaCriterio.getId());
                    for (PnCriterio criterio: criterios){
                %>
                <tr>
                    <th>Criterio</th>
                    <th>Evalua</th>
                </tr>
                <tr>
                    <td><p><%=criterio.getCriterio()%></p></td>
                    <td><p><%=criterio.getEvalua()%></p></td>
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

<script src="js/jquery.js"></script>
<script src="js/jquery.jeditable.js"></script>
<script type="text/javascript">
//    alert("hola");
    $(".editable_textarea").editable(
            function(value, settings){
                var principioParams = this.id.split("_");
//                alert("principioParams = " + principioParams[2]); // 0 t,1 f,2 id
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
</script>