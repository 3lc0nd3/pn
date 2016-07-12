
<div class="register">
    <div class="row">
        <div class="span10">
            <div class="formy">
                <a name=""></a>
                <h5>
                    Cambio de Contrase&ntilde;a
                    <img width="30"  src="img/key.png">
                </h5>
                <div class="form">
                    <!-- Login form (not working)-->
                    <form id="cambioPass" class="form-horizontal" autocomplete="off">
                        <!-- clave -->
                        <div class="control-group">
                            <label class="control-label" for="clave">Contrase&ntilde;a</label>
                            <div class="controls">
                                <input type="password" maxlength="40" class="input-large required" id="clave">
                            </div>
                        </div>
                        <!-- clave2 -->
                        <div class="control-group">
                            <label class="control-label" for="clave">Repita</label>
                            <div class="controls">
                                <input type="password" maxlength="40" class="input-large required" id="clave2">
                            </div>
                        </div>
                        <!-- Buttons -->
                        <div class="form-actions">
                            <!-- Buttons -->
                            <button type="button" onclick="changeP();" class="btn">Modificar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
        <jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">


    function changeP(){
        var id = 0;
        var c1 = dwr.util.getValue("clave");
        var c2 = dwr.util.getValue("clave2");

        if(c1 == ''){
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
</script>