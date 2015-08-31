
dwr.engine.setErrorHandler(errp4s);

var muestraExec = false;
var cuantosExec = 3;

function errp4s(msg, exc){
    if(muestraExec){
        alrtError(dwr.util.toDescriptiveString(exc, 2));
        alrtError(exc.stackTrace[0].className);
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

function utf8_encode (argString) {
    if (argString === null || typeof argString === "undefined") {
        return "";
    }

    var string = (argString + ''); // .replace(/\r\n/g, "\n").replace(/\r/g, "\n");
    var utftext = '',
            start, end, stringl = 0;

    start = end = 0;
    stringl = string.length;
    for (var n = 0; n < stringl; n++) {
        var c1 = string.charCodeAt(n);
        var enc = null;

        if (c1 < 128) {
            end++;
        } else if (c1 > 127 && c1 < 2048) {
            enc = String.fromCharCode((c1 >> 6) | 192, (c1 & 63) | 128);
        } else {
            enc = String.fromCharCode((c1 >> 12) | 224, ((c1 >> 6) & 63) | 128, (c1 & 63) | 128);
        }
        if (enc !== null) {
            if (end > start) {
                utftext += string.slice(start, end);
            }
            utftext += enc;
            start = end = n + 1;
        }
    }

    if (end > start) {
        utftext += string.slice(start, stringl);
    }

    return utftext;
}


function utf8_decode (str_data) {
    var tmp_arr = [],
            i = 0,
            ac = 0,
            c1 = 0,
            c2 = 0,
            c3 = 0;

    str_data += '';

    while (i < str_data.length) {
        c1 = str_data.charCodeAt(i);
        if (c1 < 128) {
            tmp_arr[ac++] = String.fromCharCode(c1);
            i++;
        } else if (c1 > 191 && c1 < 224) {
            c2 = str_data.charCodeAt(i + 1);
            tmp_arr[ac++] = String.fromCharCode(((c1 & 31) << 6) | (c2 & 63));
            i += 2;
        } else {
            c2 = str_data.charCodeAt(i + 1);
            c3 = str_data.charCodeAt(i + 2);
            tmp_arr[ac++] = String.fromCharCode(((c1 & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
            i += 3;
        }
    }

    return tmp_arr.join('');
}

/**
 * hace que el boton se ponga en modo espera
 * @param idBoton
 */
function botonEnProceso(idBoton){
    var bTmp = dwr.util.byId(idBoton);
    window["botonEnProcesoId"] = idBoton;
    window["botonEnProcesoValueOld"] = bTmp.value;
    bTmp.value = "Procesando";
    bTmp.disabled = true;
}
/**
 * retorna a la normalidad
 */
function botonOperativo(){
    var bTmp = dwr.util.byId(window["botonEnProcesoId"]);
//    alrt("bTmp = " + bTmp);
    bTmp.value = window["botonEnProcesoValueOld"];
    bTmp.disabled = false;
}
