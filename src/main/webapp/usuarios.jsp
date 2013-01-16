<form id="usuariosForm">
    <table border="0">
        <tr>
            <td>Nombre:</td>
            <td>
                <%--<input id="idUsuario" type="text">--%>
                <input id="idUsuario" type="hidden">
                <input id="nombreUsuario" class="required" maxlength="20">
            </td>
        </tr>
        <tr>
            <td>Email:</td>
            <td>
                <input id="mailUsuario" class="required validate-email" maxlength="20">
            </td>
        </tr>
        <tr>
            <td>Password</td>
            <td><input id="ctrsnUsuario1" type="password"></td>
        </tr>
        <tr>
            <td>Password</td>
            <td><input id="ctrsnUsuario2" type="password"></td>
        </tr>
        <tr>
            <td>Rol:</td>
            <td>
                <select id="idRolUser"></select>
            </td>
        </tr>
        <tr>
            <td>Estado:</td>
            <td>
                <select id="estadoUsuario">
                    <option title="esoja este" value="1">Activo</option>
                    <option title="" value="0">Inactivo</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>M&aacute;quina</td>
            <td>
                <select id="idMaquinaUserI"></select>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input id="bNuevoUsuario" type="button" value="Nuevo" onclick="limpiarUsuario();">
                <input id="bGuardarUsuario" type="button" value="Guardar" onclick="guardarUsuario();">
                <img id="cargaUsuarioImg" src="images/spacer.gif" width="1" height="1" alt="Cargando">
            </td>
        </tr>
    </table>
</form>

<table width="90%">
    <thead>
    <tr>
        <th class="myTh">Id</th>
        <th class="myTh">Nombre</th>
        <th class="myTh">Email</th>
        <th class="myTh">Rol</th>
        <th class="myTh">Estado</th>
        <th class="myTh">M&aacute;quina</th>
        <th class="myTh">Funciones</th>
    </tr>
    </thead>
    <tbody id="usuariosTBody"></tbody>
</table>