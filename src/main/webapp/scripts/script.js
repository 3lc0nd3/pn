
dwr.engine.setErrorHandler(errp4s);

var muestraExec = false;
var cuantosExec = 3;

function alrt(msg){
    jQuery.noticeAdd({
        text: msg,
        stay: false,
        type: 'notice-success'
    });
}
function alrtError(msg){
    jQuery.noticeAdd({
        text: msg,
        stay: true,
        type: 'notice-error'
    });
}

function votarEnCertamen(idCertamen){
    var votoS = dwr.util.getValue("votoS");
//    alert("votoS = " + votoS);
    if(votoS == ''){
        alrtError("Por favor <br>Seleccione los Proyectos por los que desea Votar");
    } else {
//        alert("votoS.size = " + votoS.length);
        if(votoS.length != 3 ){
            alrtError("Tienes que votar por (3) Proyectos <br> Tienes marcados: " + votoS.length);
        } else {
            swRemoto.saveVotosStartupCertamen(idCertamen, votoS, function(data){
                if(data == 1){
                    alert("Se ha registrado tus Votos !!!");
                    document.location.reload();
                } else if(data == 2){
                    alrtError("No puedes votar por tu propio Proyecto");
                } else {
                    alrtError("No se registro tus Votos");
                }
            });
        }
    }
}

function eliminaComentarioStartup(idComentarioStartup, idStartup){
    swRemoto.borraComentarioStartup(idComentarioStartup, function(data){
        recargaComentariosStartup(idStartup);
    });
}

function enviaMensajeStartup(idStartup){
    var comentarioStartup = {
        tipoComentarioStartup : null,
        tituloComentario : null,
        textoComentario : null,
        linkComentario : null,
        idStartup: idStartup
    };
    dwr.util.getValues(comentarioStartup);

    swRemoto.saveComentarioStartup(comentarioStartup, function(data){
        if(data != null){
//            alrt("data = " + data);
            recargaComentariosStartup(idStartup);
            var formCS = dwr.util.byId("formComentario");
            formCS.reset();
        }
    });
    
}

function recargaComentariosStartup(idStartup){
    swRemoto.pageComentarioStartup(idStartup, function(pageCS){
        dwr.util.setValue("comentariosStDiv", pageCS, { escapeHtml:false });
    });
}

function registroParticipante() {
    var participante = {
        nombreParticipante : null,
        emailParticipante : null,
        emailR : null,
        idEspecialidad : null
    };
    dwr.util.getValues(participante);

    participante.emailParticipante = participante.emailR;

    var b = dwr.util.byId("creaPR");
    var vOld = b.value;
//    alrt("vOld = " + vOld);
    b.value = "Procesando";
    b.disabled = true;

    if (participante.nombreParticipante == '') {
        alrtError('Nombre Vacio!');
        b.disabled = false;
            b.value = vOld;
    } else if (participante.emailParticipante == '') {
        alrt('Email Vacio!');
        b.disabled = false;
            b.value = vOld;
        
    } else {
        swRemoto.creaNuevoUsuarioRegistro(participante, function(data) {
            if (data == 1) {
                alrt("Se le ha enviado un email con datos de ingreso");
            } else if(data == 2) {
                alrt("error en el Email");
            } else if(data == 3){
                alrt("Email "+ participante.emailParticipante+" ya ha sido registrado en p4s");
            }
            b.disabled = false;
            b.value = vOld;
//            b.value = "ggg";
        });
    }
}

function votoLikeStartup(idStartup){
    swRemoto.saveVotoLikeStartup(idStartup, function(data){
        if(data==1){
            recargaVotosStartup(idStartup);
        }
    });
}

function votoUnlikeStartup(idStartup){
    swRemoto.saveVotoUnLikeStartup(idStartup, function(data){
        if(data==1){
            recargaVotosStartup(idStartup);
        }
    });
}

function recargaVotosStartup(idStartup){
    swRemoto.popularidadStartup(idStartup, function(data2){
        dwr.util.setValue("popularStartupHome"+idStartup, data2, { escapeHtml:false });
    });
    swRemoto.cuantosVotosLikeStartup(idStartup, function(data2){
        dwr.util.setValue("cuantosVotosLikeStartup"+idStartup, data2, { escapeHtml:false });
    });
    swRemoto.cuantosVotosUnlikeStartup(idStartup, function(data2){
        dwr.util.setValue("cuantosVotosUnlikeStartup"+idStartup, data2, { escapeHtml:false });
    });
}

function openDialogDesk(idStartup, name){
    botonEnProceso('vmSt'+idStartup);
    var d = dwr.util.byId("newDialogDeskDiv"+idStartup);
//    alrt("d = " + d);
    if (d==null) {
        jQuery('#dialogos').append(jQuery('<div id="newDialogDeskDiv'+idStartup+'"></div>'));
    }
    swRemoto.verMasStartupDesk(idStartup, function(data){
        dwr.util.setValue("newDialogDeskDiv"+idStartup, data, { escapeHtml:false });
        var scsPopular = data.extractScript();
        scsPopular.evalScript();

        var dialogoActualDesktop = window["newDialogDesk"+idStartup];
        if(dialogoActualDesktop == null){
            window["newDialogDesk"+idStartup] =
            jQuery( "#newDialogDeskDiv"+idStartup).dialog({
                title: name,
                autoOpen: false,
                height: 520,
                width: 620,
                modal: false,
                close: function(event, ui)
                {
//                    jQuery(this).destroy().remove();
//                    dialogoActualDesktop.destroy().remove();
                    jQuery('#comentariosStDiv').remove();
                    jQuery('#formComentario').remove();
                }

            });
            dialogoActualDesktop = window["newDialogDesk"+idStartup];
        }
        dialogoActualDesktop.dialog('open');
        botonOperativo();
    });
}

function openDialogMobile(idStartup){
    botonEnProceso('vmSM'+idStartup);
    var d = dwr.util.byId("newDialogDeskDiv"+idStartup);
    if (d==null) {
        jQuery('#dialogos').append(jQuery('<div id="newDialogDeskDiv'+idStartup+'">HOLA</div>'));
    }
    swRemoto.verMasStartupMobile(idStartup, function(data){
        dwr.util.setValue("newDialogDeskDiv"+idStartup, data, { escapeHtml:false });
        var scsPopular = data.extractScript();
        scsPopular.evalScript();

        var dialogoActualDesktop = window["newDialogDesk"+idStartup];
        if(dialogoActualDesktop == null){
            window["newDialogDesk"+idStartup] =
            jQuery( "#newDialogDeskDiv"+idStartup).dialog({
                autoOpen: false,
                modal: false
            });
            dialogoActualDesktop = window["newDialogDesk"+idStartup];
        }
        dialogoActualDesktop.dialog('open');
        botonOperativo();
    });
}


function barraSup(){
//    alrt("true = " + true);
//    window.location = "?h="+new Date().getTime();
    jQuery('#notifyDiv').empty();
    jQuery('#howdydo-stretch').remove();

    frontController.getInclude("private/component/notify", function(data){
        if(data != null){
            data = data.trim();
//            alrt("data |" + data.indexOf('panel')+"|");
            if (data != '' && data.indexOf('panel')>=0) {
//                jQuery('#notifyDiv').remove();
                dwr.util.setValue("notifyDiv", data, { escapeHtml:false });
                jQuery(document).ready(function() {
                    jQuery('#notifyDiv').howdyDo({
                        action        : 'push',
                        easing        : 'easeInOutExpo',
                        duration    : 500,
                        autoStart	: false,
                        openAnchor    : 'Novedades <img src="images/notification.png" border=0 />',
                        closeAnchor    : '<br><img src="scripts/jquery/jquery.howdydo-bar/images/close-16x16.png" border=0 />'
                    });
                });
            } else {
//                alert("No hay notificaciones");
                jQuery('#howdydo-stretch').remove();
                jQuery('#notifyDiv').remove();
            }
        }
    });

}

/**
 * para activar o inactivar el miembro de equipo
 * @param idParticipanteStartup
 * TODO
 */
function cambiaEstadoParticipanteEquipo(idParticipanteStartup){

}

function aceptarMiembroEnEquipo(nombreUsuario, idSolicitudIngreso, idProyecto, parametro){
//    if(confirm("Desea aceptar a " + nombreUsuario + " en su equipo?")){
        swRemoto.apruebaSolicitudIngreso(idSolicitudIngreso,
                function(data){
                    if(data == 1){
                        alrt(nombreUsuario + " ahora es miembro de su equipo");
//                        window.location = "admonProyecto.htm?"+parametro+"="+idProyecto;
//                        esconde('panel'+idSolicitudIngreso);
                        barraSup();
                    }
                });
//    }
}

function rechazarMiembroEnEquipo(nombreUsuario, idSolicitudIngreso, idProyecto, parametro){
//    if(confirm("En verdad Rechaza a " + nombreUsuario + "?")){
        swRemoto.rechazaSolicitudIngreso(idSolicitudIngreso,
                function(data){
                    if(data == 1){
                        alrt(nombreUsuario + " ha sido rechazado de su equipo");
//                        window.location = "admonProyecto.htm?"+parametro+"="+idProyecto;
//                        esconde('panel'+idSolicitudIngreso);
                        barraSup();
                    }
                });
//    }
}

function aceptarMiembroEnCertamen(nombreUsuario, idSolicitudIngreso, idCertamen){
//    if(confirm("Desea aceptar a " + nombreUsuario + " en su Certamen?")){
        swRemoto.apruebaSolicitudIngreso(idSolicitudIngreso,
                function(data){
                    if(data == 1){
                        alrt(nombreUsuario + " ahora es miembro de su Evento");
//                        window.location = "admonCertamen.htm?idCertamen="+idCertamen;
                        barraSup();
                    }
                });
//    }
}

function rechazarMiembroEnCertamen(nombreUsuario, idSolicitudIngreso, idCertamen){
    if(confirm("En verdad Rechaza a " + nombreUsuario + "?")){
        swRemoto.rechazaSolicitudIngreso(idSolicitudIngreso,
                function(data){
                    if(data == 1){
                        alrt(nombreUsuario + " ha sido rechazado de su Evento");
//                        window.location = "admonCertamen.htm?idCertamen="+idCertamen;
                        barraSup();
                    }
                });
    }
}

function volverASolicitarIngresoAStartup(idSolicitudIngreso, nombreStartup, idCertamen){
    if (confirm("Solicitar de nuevo a "+nombreStartup+"?")) {
        swRemoto.activaSolicitudIngreso(idSolicitudIngreso,
                function(data){
                    if(data == 1){
                        alrt("Solicitud Enviada de Nuevo");
                        window.location = "proyectos.htm?idCertamen="+idCertamen+"&r="+new Date().getTime();
                    }
                });
    }
}

function volverASolicitarIngresoACertamen(idSolicitudIngreso, nombreCertamen){
    if(confirm("Solicitar de nuevo a "+nombreCertamen+"?")){
        swRemoto.activaSolicitudIngreso(idSolicitudIngreso,
                function(data){
                    if(data == 1){
                        alrt("Solicitud Enviada de Nuevo");
                        window.location = "eventos.htm?r="+new Date().getTime();
                    }
                });
    }
}

function solicitaIngresarAStartup(idParticipante, idStartup, nombreStartup, idCertamen){
    if (confirm("Desea Ingresar al grupo de "+nombreStartup+"?")) {
        swRemoto.creaSolicitudIngresoStartup(idParticipante, idStartup,
                function(data){
                    if(data == 1){
                        alrt("Solicitud Enviada");
//                        window.location = "proyectos.htm?idCertamen="+idCertamen;

                        dwr.util.setValue("solicitudDiv"+idStartup, 
                                '<div class="alert-box success">Ingreso en Proceso<a href="" class="close">&times;</a></div>'
                                , { escapeHtml:false });

                        $(".alert-box").delegate("a.close", "click", function(event) {
                            event.preventDefault();
                            $(this).closest(".alert-box").fadeOut(function(event){
                                $(this).remove();
                            });
                        });

                    } // END IF
                });
    }
}

function vinculaProyectoEvento(idProyecto, idVinculo){
    var idEvento = dwr.util.getValue("widCertamen");
    swRemoto.vinculaStartupConCertamen(idProyecto, idEvento, function(data){
        if(data==1){
            window.location = "admonProyecto.htm?idProyecto="+idVinculo;
        }
    });
}

function desvinculaProyectoEvento(idVinculoProyecto, idVinculo){
    swRemoto.desvincularStartupConCertamen(idVinculo, function(data){
        if(data == 1){
            window.location = "admonProyecto.htm?idProyecto="+idVinculoProyecto;
        }
    });
}

function admonProyecto(idProyecto){
    window.location = "admonProyecto.htm?idProyecto="+idProyecto;
}

function admonCertamen(idProyecto){
    window.location = "admonCertamen.htm?idCertamen="+idProyecto;
}

function verStartupsFromCertamen(page, idCertamen){
    window.location = page+"?idCertamen="+dwr.util.getValue(idCertamen);
}

function abandonaACertamen(idParticipanteCertamen, nombreEvento){
    if (confirm("Desea Abandonar el Evento '" + nombreEvento + "'")) {
        swRemoto.participanteAbandonaCertamen(idParticipanteCertamen, function(data) {
            if (data == 1) {
                window.location = "eventos.htm?r=" + new Date().getTime();
            }
        });
    }
}
function ingresarACertamen(idCertamen){
    swRemoto.participanteIngresaACertamen(idCertamen, function(data){
        if(data == 1){
            window.location = "eventos.htm?r="+new Date().getTime();
        }
    });
}

function changeEstadoPais(){
    swRemoto.getCiudad(dwr.util.getValue("idCiudad"), function(data){
        if(data != null){
            dwr.util.setValue("estadoPais", data.nombreEstado + ' - ' + data.locEstadoByIdEstado.locPaisByIdPais.nombrePais);
        }
    });
}

function guardaCertamenNew(page, idCertamen){
    alrt("Coming soon, contacta con @elramireza");
}

function botonEnProceso(idBoton){
    var bTmp = dwr.util.byId(idBoton);
    window["botonEnProcesoId"] = idBoton;
    window["botonEnProcesoValueOld"] = bTmp.value;
    bTmp.value = "Procesando";
    bTmp.disabled = true;
}

function botonOperativo(){
    var bTmp = dwr.util.byId(window["botonEnProcesoId"]);
//    alrt("bTmp = " + bTmp);
    bTmp.value = window["botonEnProcesoValueOld"];
    bTmp.disabled = false;
}

function guardaCertamen(page, idCertamen){

    botonEnProceso('saveEb');

    var currentDate = (new Date()).getTime();
    var certamen = {
        idCertamen : null,
        idGrupo: null,
        nombreCertamen: null,
        textoCertamen: null,
        fechaDesde: null,
        fechaHasta: null,
        idCiudad: null,
        cupoCertamen: null,
        privadoCertamen: null,
        direccionCertamen: null
    };

    
    dwr.util.getValues(certamen);
    certamen.cupoCertamen.trim();
    if(certamen.cupoCertamen == ''){
        certamen.cupoCertamen = 0;
    }
//    alrt("certamen.cupoCertamen = " + certamen.cupoCertamen);
//    alrt("certamen.privadoCertamen = " + certamen.privadoCertamen);
    swRemoto.saveCertamen(certamen, function(data){
        if(data != null){
            alert('Se guardo el Evento');
            botonOperativo();
            window.location = page+".htm?r="+currentDate+"&idCertamen="+idCertamen;
        }
    });
}

function eliminaCertamen(idCertamen){
    swRemoto.deleteCertamen(idCertamen, function(data){

    });
}

function errp4s(msg, exc){
//    alrt(dwr.util.toDescriptiveString(exc, 2));
//    alrt(exc.stackTrace[0].className);
    if(muestraExec){
//        msg += "<br>" + dwr.util.toDescriptiveString(exc, 3);
        for (var i = 0; i<cuantosExec; i++) {
            msg += "<br>" + exc.stackTrace[i].className;
            msg += "<br>" + exc.stackTrace[i].methodName;
            msg += "<br>" + exc.stackTrace[i].lineNumber;
        }
    }
    alrtError(msg);

//    alrt(msg + ' ' + exc);
    botonOperativo();
}

function errh(msg, exc) {
    jQuery("<span> <table> <tr> <td> <img height='80' width='80'  src='img/stop.png' /> </td><td>"+msg +
//           "<br>" + dwr.util.toDescriptiveString(exc, 4) +
           "   </td></tr></table></span>").dialog({
        modal: true,
        width: 600,
        buttons: {
            OK: function() {
                $( this ).dialog( "close" );
            }
        }
    });
}

//dwr.engine.setErrorHandler(errh);

function recuperaPass(){
    botonEnProceso('recuperaPa');
    var email = dwr.util.getValue("email");
    swRemoto.restablecePass(email, function(data){
        botonOperativo();
    });
}


var tablaParticipantesOrgNueva = true;

/**
 * ORG
 */
function limpiaStartupORG(){
    dwr.util.setValue('idStartup', 0);
    dwr.util.byId("formStartupsOrg").reset();
}

function cPss(){
    var old = dwr.util.getValue('old');
    var new1 = dwr.util.getValue('new1');
    var new2 = dwr.util.getValue('new2');
    swRemoto.changeP(old, new1, new2, function(d){
        if(d==1){
            dwr.util.setValue('old','');
            dwr.util.setValue('new1','');
            dwr.util.setValue('new2','');
            alrt('Password actualizado');
        }
    });
}

function restablecePassParticipantes(){
//    alrt("dwr.util.getValue('idParticipante') = " + dwr.util.getValue('idParticipante'));
    if(dwr.util.getValue('idParticipante') == 0){
        alrt('cargue un Participante');
    } else if(confirm('Desea restablecer Password')){
        swRemoto.restablecePass(dwr.util.getValue('idParticipante'), function(data){
            alrt('Password restablecido');
        });

    }
}

function guardaDatosPersonales(page){
    botonEnProceso('miPerfilDP');
    var participante ={
        nombreParticipante : null,
        emailParticipante : null,
        twitterParticipante : null,
        facebookParticipante : null,
        linkedinParticipante : null,
        skypeParticipante : null,
        celularParticipante : null,
        idEspecialidad : null,
        bioParticipante : null
    };

    dwr.util.getValues(participante);

//    alrt("participante.bioParticipante = " + participante.bioParticipante);

    if (dwr.util.getValue('nombreParticipante') == '' ) {
        alrt('nombre vacio');
        botonOperativo();
    } else if (dwr.util.getValue('emailParticipante') == '' ) {
        alrt('email vacio');
        botonOperativo();
    } else {                
        swRemoto.updateDatosPersonales(participante, function(data){
            if (data != null) {
                alrt('Datos Actualizados');
                botonOperativo();
//                window.location = page;
            } else {
                alrt('Error al guardar Datos');
            }
        });
    }
}

function tabDatosPersonales(){
    swRemoto.getDatosPersonales(function(data){
        dwr.util.setValues(data);
        if(data.urlImagenParticipante != null &&
           data.urlImagenParticipante != ''){
            var img = dwr.util.byId('imageParticipante');
            img.src = 'photo/'+data.urlImagenParticipante;
//            alrt("data.urlImagenParticipante = " + data.urlImagenParticipante);
//                    alrt("img = " + img);
        } else {
            var img = dwr.util.byId('imageParticipante');
            img.src = "img/no_user.png";
        }
    });
}

function tabParticipantesSW(){
    dwr.util.setValue("divParticipantesSW", "");
    frontController.getInclude("hoja_participantes", function(data){
//        alrt("data = " + data);
        dwr.util.setValue("divParticipantesSW", data, { escapeHtml:false });
//        menusAdminUsers();
    });
}

function tabMiEquipo(){
    // llenar el menu de Startups
//    "miEquipo";

    swRemoto.getStartupsAprobadasForMenu(function(data){
        dwr.util.removeAllOptions("miEquipo");
        dwr.util.addOptions("miEquipo", data, "idStartup", "nombreStartup");

        // poner el valor

        swRemoto.getDatosPersonales(function(data){
            if(data.startupByIdStartup != null){
                dwr.util.setValue("miEquipo", data.startupByIdStartup.idStartup);
                dwr.util.setValue("nombreEquipo", data.startupByIdStartup.nombreStartup);

            } else {
//                alrt('No tiene equipo');
            }
        });

        // cargo la tabla
        dwr.util.setValue("divMiembrosEquipo", "");
        frontController.getInclude("hoja_miembrosEquipo", function(data){
//        alrt("data = " + data);
        dwr.util.setValue("divMiembrosEquipo", data, { escapeHtml:false });
//        menusAdminUsers();
    });

    });
}

function ingresarEquipo(){

    var idStartup = dwr.util.getValue('miEquipo');

    if(idStartup == 0){
        alrt('Seleccione un Equipo primero');
    } else if(confirm("Desea ingresar a este equipo?")){
        swRemoto.ingresaAEquipo(idStartup, function(data){
            if(data != null){
                tabMiEquipo();
                alrt('Ingreso al equipo: ' + data.nombreStartup);
            } else {
                alrt("problema al ingresar");
            }
        });
    }
}


function tabAdmonCertamen(){
//    alrt("tabAdmonCertamen");
    dwr.util.setValue("divAdmonCertamen", "");
    frontController.getInclude("hoja_admonCertamen", function(data){
//        alrt("data = " + data);
        dwr.util.setValue("divAdmonCertamen", data, { escapeHtml:false });


//        jQuery("#idGanador1Certamen").msDropDown({visibleRows:5, rowHeight:100, mainCSS:'dd2'}).data("dd");
//        jQuery("#idGanador2Certamen").msDropDown({visibleRows:5, rowHeight:100, mainCSS:'dd2'}).data("dd");
//        jQuery("#idGanador3Certamen").msDropDown({visibleRows:5, rowHeight:100, mainCSS:'dd2'}).data("dd");

//        menusAdminUsers();
    });
} // fin tabAdmonCertamen


function restableceGanadores(){
    if(confirm("Se borran los Ganadores. Continuar?")){
        swRemoto.reestablecerGanadores(function(data){
            tabAdmonCertamen();
        });
    }
}

/**
 * guarda los ganadores del certamen en SESSION
 */
function guardaGanadores(){
    var startup = {
         idGanador1Certamen : null,
         idGanador2Certamen : null,
         idGanador3Certamen : null
    };

    dwr.util.getValues(startup);

    if (startup.idGanador1Certamen == '0' ) {
        alrt('Seleccione Startup 1');
    } else if (startup.idGanador2Certamen == '0' ) {
        alrt('Seleccione Startup 2');
    } else if (startup.idGanador3Certamen == '0' ) {
        alrt('Seleccione Startup 3');
    } else if(
            startup.idGanador1Certamen == startup.idGanador2Certamen ||
            startup.idGanador3Certamen == startup.idGanador2Certamen ||
            startup.idGanador1Certamen == startup.idGanador3Certamen ){
        alrt('No pueden ir valores Repetidos');
    } else {
        swRemoto.saveGanadoresCertamen(startup, function(data){
            dwr.util.setValues(data);
            alrt('Startups Ganadores Guardados');
        });
    }

} // FIN GUARDA GANADORES

/**
 * 1 o 0 en poder votar SW en certamen
 */
function apruebaDesapruebaVotacionSW(){
    swRemoto.approvalDisapprovalVotacionSW(function(){
        tabAdmonCertamen();
    });
}


/**
 * 1 o 0 en poder votar Popular en certamen
 */
function apruebaDesapruebaVotacionPopular(){
    swRemoto.approvalDisapprovalVotacionPopular(function(){
        tabAdmonCertamen();
    });
}

/*  Startups  */

/**
 * Para el ORG agiliza el evento el Viernes
 */
function guardaIdeaORG(){
    var startup = {
        idStartup: null,
        nombreStartup: null,
        logoStartup: null,
        urlWebStartup: null,
        emailContactoStartup: null,
        twitterStartup: null,
        facebookStartup: null,
        bioStartup: null
    };

    var idParticipante = dwr.util.getValue("idParticipanteStartup");

    dwr.util.getValues(startup);

    if (dwr.util.getValue('nombreStartup') == '' ) {
        alrt('nombre vacio');
    } else if(dwr.util.getValue('bioStartup') == '' ) {
        alrt('detalle vacio');
    } else {
        swRemoto.saveStartupORG(idParticipante, startup, function(data) {
            getTablaStartupsOrg();
            limpiaStartupORG();
            alrt("Se guardo la startup " + data.nombreStartup);
        });
    }
}

/**
 * para participante y 
 */
function guardaIdea(retorno){
    var startup = {
        idStartup: null,
        nombreStartup: null,
        logoStartup: null,
        urlWebStartup: null,
        emailContactoStartup: null,
        twitterStartup: null,
        facebookStartup: null,
        bioStartup: null
    };

    dwr.util.getValues(startup);

//    alrt("dwr.util.getValue('twitterStartup') = " + dwr.util.getValue('twitterStartup'));
//
//    alrt("startup.nombreStartup = " + startup.nombreStartup);
//    alrt("startup.twitterStartup = " + startup.twitterStartup);
//    alrt("startup.facebookStartup = " + startup.facebookStartup);
//    alrt("startup.bioStartup = " + startup.bioStartup);

    if (dwr.util.getValue('nombreStartup') == '' ) {
        alrt('propuesta vacia');
    } else if(dwr.util.getValue('bioStartup') == '' ) {
        alrt('detalle vacio');
    } else {
        swRemoto.saveStartupParticipante(startup, function(data) {
            alrt("Se guardo el proyecto " + data.nombreStartup);
//            tabMiIdea();
            setTimeout('location.reload(true);',3000);
//            window.location = retorno+"&r="+new Date().getTime();
        });
    }
}




/**
 * Votar Ideas SW para convertir a Startup
 */


/**
 * guarda la votacion de otra ideas
 */
function guardaVotacionOtrasIdeas_new(){
    var participante = {
         idStartupVoto1 : null,
         idStartupVoto2 : null,
         idStartupVoto3 : null
    };

    dwr.util.getValues(participante);

    alrt("participante.idStartupVoto1 = " + participante.idStartupVoto1+
          "\nparticipante.idStartupVoto2 = " + participante.idStartupVoto2+
          "\nparticipante.idStartupVoto3 = " + participante.idStartupVoto3);
}
function guardaVotacionOtrasIdeas(){
    var participante = {
         idStartupVoto1 : null,
         idStartupVoto2 : null,
         idStartupVoto3 : null
    };

    dwr.util.getValues(participante);

    if (participante.idStartupVoto1 == '0' ) {
        alrt('Seleccione Voto 1');
    } else if (participante.idStartupVoto2 == '0' ) {
        alrt('Seleccione Voto 2');
    } else if (participante.idStartupVoto3 == '0' ) {
        alrt('Seleccione Voto 3');
    } else if(
            participante.idStartupVoto1 == participante.idStartupVoto2 ||
            participante.idStartupVoto3 == participante.idStartupVoto2 ||
            participante.idStartupVoto1 == participante.idStartupVoto3 ){
        alrt('No pueden ir valores Repetidos');
    } else {
        swRemoto.saveVotoIdeaParticipante(participante, function(data){
            dwr.util.setValues(data);
            alrt('Voto Realizado');
        });
    }
}

var tablaStartupsOrgNueva = true;

/**
 * tabla Startups para el ORG
 */
function getTablaStartupsOrg(){
    var cellFuncs = [
        function(data) { return data.idStartup;   },
        function(data) { return data.nombreStartup; },
        function(data) { return data.participanteByIdParticipanteCreador.nombreParticipante;   },
        function(data) {
            if (data.activaStartup == 0) {
                return 'Idea';
            } else {
                return '<Strong>Startup</Strong>';
            }
        },
        function(data) {return data.votosStartup},
        function(data){
            if (data.activaStartup) {
                return "<a onclick='rechazarStartup(" + data.idStartup + ")'><img class='iconHand' alt='Rechazar "+data.idStartup+" ?' title='Rechazar "+data.idStartup+" ?' src='img/positive.png'/></a>";
            } else {
                return "<a onclick='aprobarStartup(" + data.idStartup + ")'><img class='iconHand' alt='Aprobar " + data.idStartup + " ?' title='Aprobar " + data.idStartup + " ?' src='img/negative.png'/></a>";
            }

        },
        function(data){
            return "<a onclick='cargarStartupORG(" + data.idStartup + ")'><img class='iconHand' alt='Cargar "+data.idStartup+"' title='Cargar "+data.idStartup+"' src='images/edit.png'/></a>";
        }

    ];

    dwr.util.removeAllRows("startupsTbody");

    swRemoto.getStartupsFromCertamen(function (data){
        dwr.util.addRows("startupsTbody", data, cellFuncs, {
            rowCreator:function(options) {
                var row = document.createElement("tr");
                if (options.rowIndex % 2) {
                    row.className = 'tablaZebra1';
//                    row.style.backgroundColor = "#c0ff99";
//                    row.style.color = "rgb(255,255,255)";
                }   else {
                    row.className = 'tablaZebra2';
                }
                return row;
            },
            cellCreator:function(options){
                var cell = document.createElement("td");
                cell.className = 'cellBorder';
                return cell;
            },
            escapeHtml:false
        });

//        alrt("nuevo = " + nuevo);
        if (tablaStartupsOrgNueva) {
            tablaStartupsOrgNueva = false;
            jQuery("#tablaStartupsOrg").tablesorter();
        } else {
            jQuery("#tablaStartupsOrg").trigger("update");
        }

    });
}

/**
 * para que el ORG edite una startup  
 * @param idStartup
 */
function cargarStartupORG(idStartup){
    swRemoto.getStartup(idStartup, function(data){
        dwr.util.setValues(data);
        dwr.util.setValue("idParticipanteStartup", data.participanteByIdParticipanteCreador.idParticipante); 
    });
}

function aprobarStartup(idStartup){
    if(confirm("Desea Aprobar la Idea: " + idStartup)){
        swRemoto.aprovalStartup(idStartup, function(data){
            if(data != null){
                getTablaStartupsOrg();
                alrt("Aprobada la Startup [" + idStartup + "] " + data.nombreStartup);
            }
        });
    }
}

function rechazarStartup(idStartup){
    if(confirm("Desea Rechazar la Startup: " + idStartup)){
        swRemoto.disapprovalStartup(idStartup, function(data){
            if(data != null){
                getTablaStartupsOrg();
                alrt("Rechazada la Startup [" + idStartup + "] " + data.nombreStartup);
            }
        });
    }
}

function tabIniciativas(){
    dwr.util.setValue("divIniciativasHome", "");
    frontController.getInclude("hoja_iniciativas", function(data){
//        alrt("data = " + data);
        dwr.util.setValue("divIniciativasHome", data, { escapeHtml:false });
//        menusAdminUsers();
    });
}

/**
 * las del Home
 * Ejemplo de scripts despues de ajax
 */
function tabStartups(){
    dwr.util.setValue("divStartupsHome", "");
    frontController.getInclude("hoja_startups", function(data){
        esconde("divStartupsHome");
//        alrt("data = " + data);
        dwr.util.setValue("divStartupsHome", data, { escapeHtml:false });
        var scs = data.extractScript();
        scs.evalScript();
        muestra("divStartupsHome");
    });
}

/**
 * con votaciones las del Home
 */
function tabStartupsConVotaciones(){
    dwr.util.setValue("divStartupsConVotacionesHome", "");
    frontController.getInclude("hoja_iniciativas_con_votos", function(data){
//        alrt("data = " + data);
        dwr.util.setValue("divStartupsConVotacionesHome", data, { escapeHtml:false });
//        menusAdminUsers();
    });
}



/* PROMEDIO */

function promedioMetas(){
    var startup = {
        metaValor1 : null,
        metaValor2 : null,
        metaValor3 : null,
        metaValor4 : null,
        metaValor5 : null,
        metaValor6 : null,
        metaValor7 : null
    };
//    alrt("startup.length = " + startup.size);
    dwr.util.getValues(startup);

    var total = 0;
    total += eval(startup.metaValor1);
    total += eval(startup.metaValor2);
    total += eval(startup.metaValor3);
    total += eval(startup.metaValor4);
    total += eval(startup.metaValor5);
    total += eval(startup.metaValor6);
    total += eval(startup.metaValor7);
    total /= 7;

    dwr.util.setValue("promedioStartup", parseInt(total)+"%");

}

function guardaMetas(){
    var startup = {
          idStartup : null,  
        metaNombre1 : null,
         metaValor1 : null,
        metaNombre2 : null,
         metaValor2 : null,
        metaNombre3 : null,
         metaValor3 : null,
        metaNombre4 : null,
         metaValor4 : null,
        metaNombre5 : null,
         metaValor5 : null,
        metaNombre6 : null,
         metaValor6 : null,
        metaNombre7 : null,
         metaValor7 : null
    };

    dwr.util.getValues(startup);

    swRemoto.saveMetasFromStartup(startup, function(data){
        alrt("Se guardaron las Metas y sus Valores para " + data.nombreStartup);
    });
    
}

/* FIN PROMEDIO */






/**********************************************************************/




function cuentaLetras(){
    var mess = dwr.util.getValue('mensaje');
    dwr.util.setValue("largo", mess.length);
    if(mess.length>140){
        dwr.util.byId('largo').style.color = 'red';
        dwr.util.byId('sendSimple').disabled = true;
    } else {
        $('largo').style.color = 'black';
        $('sendSimple').disabled = false;
    }
}


function validaAdjunto(elem){

//    return true;
    var vinc_arch = dwr.util.getValue(elem);
    if(vinc_arch == '' || vinc_arch.value == ''){
        alrt("Por favor seleccione un archivo primero");
        return false;
    } else {
        return true;
    }

}




function putMsg(msg){
//    $("msg").innerHTML = msg;
    dwr.util.setValue("msg", msg, { escapeHtml:false });
}

function putMsgElem(elem, msg){
//    $("msg").innerHTML = msg;
    dwr.util.setValue(elem, msg, { escapeHtml:false });
}

function puterror(msg){
//    $("error").innerHTML = msg;
    dwr.util.setValue("error", msg, { escapeHtml:false });
}

function cleanerror(){
    $("error").innerHTML = "";
}



/**
 * style none
 *
 * @param id
 */
function esconde(id){
    dwr.util.byId(id).style.display = "none";
}

/**
 * style block
 * @param id
 */
function muestra(id){
//    $(id).style.display = "block";
}


setValues2 = function(data, options) {

    var prefix = "";
    if (options && options.prefix) prefix = options.prefix;
    if (options && options.idPrefix) prefix = options.idPrefix;

    setValuesRecursive2(data, prefix);
};

setValuesRecursive2 = function(data) {
    var cita = 'cita';
    var tmp;
    var aux;
    var i = 1;
    for(i=1; i<=30; i++){
        tmp = cita+i;
        aux = data[tmp];
        //alrt(tmp+i +"," + aux);
        if(aux!=undefined){
            //            alrt("si");
            dwr.util.setValue(tmp, aux, { escapeHtml:false });
        } else {
            //            alrt("no");
            dwr.util.setValue(tmp,"");
        }
    }
};







//-->


