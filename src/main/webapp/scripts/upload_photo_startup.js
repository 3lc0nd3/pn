/* Licence:
*   Use this however/wherever you like, just don't blame me if it breaks anything.
*
* Credit:
*   If you're nice, you'll leave this bit:
*
*   Class by Pierre-Alexandre Losson -- http://www.telio.be/blog
*   email : plosson@users.sourceforge.net
*/
function refreshProgressStartup()
{
    UploadMonitor.getUploadInfo(updateProgressStartup);
}


function updateProgressStartup(uploadInfo)
{
    if (uploadInfo.inProgress)
    {
        document.getElementById('uploadbutton').disabled = true;
//        document.getElementById('file1').disabled = true;
//        document.getElementById('file2').disabled = true;
//        document.getElementById('file3').disabled = true;
//        document.getElementById('file4').disabled = true;

        var fileIndex = uploadInfo.fileIndex;

        var progressPercent = Math.ceil((uploadInfo.bytesRead / uploadInfo.totalSize) * 100);

        document.getElementById('progressBarText_Startup').innerHTML = 'Progreso: ' + progressPercent + '%';

        document.getElementById('progressBarBoxContent_Startup').style.width = parseInt(progressPercent * 1.5) + 'px';

        window.setTimeout('refreshProgressStartup()', 1000);
    }
    else
    {
        /**
         * si ya acabo de subir el archivo...
         */
        //enciende el boton de subir
        document.getElementById('uploadbutton').disabled = false;
        // limpia el campo file
        document.getElementById('vinc_arch_Startup').value = '';
        // borra la barra de progreso
        dwr.util.byId('progressBar_Startup').style.display = 'none';
        document.getElementById('progressBarBoxContent_Startup').style.width = 0;
//        alrt(" = " + $('idNewsd'));
        window.setTimeout('muestraResultado_Startup()', 1000);
//        document.getElementById('file1').disabled = false;
//        document.getElementById('file2').disabled = false;
//        document.getElementById('file3').disabled = false;
//        document.getElementById('file4').disabled = false;
    }

    return true;
}

var ic = 1;

function muestraResultado_Startup(){
    putMsgElem("msg_Startup","Procesando ... <img alt='Cargando' width='16' height='16' title='Cargando' src='images/loading.gif' />");

    // AHORA SE PROCEDE A SACAR LOS DATOS


    if(!globalEstadoConversion){
        window.setTimeout('muestraResultado()', 1000);
    } else {
        // FILE UPLOAD COMPLETO
        putMsgElem("msg_Startup",archivoCargado);
//        alrt("listos sss");
//        tabMiIdea();
        var img = dwr.util.byId('imageStartup');
        img.src = "photo/" +archivoCargado;
        //cargo el menu de Archivos Lote
//        getArchivosMenu("archivosMenu");

        //muestro el contenido del archivo
//        getContentOfFile(archivoCargado);


//        alrt("idNews = " + idNews);
        // carga los archivos relacionados con la noticia
        /*if($('idNews') != null){
//            alrt("globalEstadoConversion = " + globalEstadoConversion);
            getFiles(idNews, 1);

        }*/

    }
}

function startProgressStartup(){
    // INICIALIZA EL FILE ULOAD

//    alrt("Otra");

    globalEstadoConversion =false;
    archivoCargado = 0;

    if (validaAdjunto("vinc_arch_Startup")) {
        document.getElementById('progressBar_Startup').style.display = 'block';
        document.getElementById('progressBarText_Startup').innerHTML = 'Progreso: 0%';
        document.getElementById('uploadbutton').disabled = true;

        // wait a little while to make sure the upload has started ..
        window.setTimeout("refreshProgressStartup()", 1500);
        return true;
    } else {
//        alrt("false = " + false);
        return false;
    }
}
