function disableId(id){
    var bTmp = dwr.util.byId(id);
    if (bTmp!=null) {
        bTmp.disabled = true;
    }
}

function enableId(id){
    var bTmp = dwr.util.byId(id);
    if (bTmp!=null) {
        bTmp.disabled = false;
    }
}


function replaceAll( text, busca, reemplaza ){
  while (text.toString().indexOf(busca) != -1)
      text = text.toString().replace(busca,reemplaza);
  return text;
}


function poneSaltosDeLinea(txt){
    return replaceAll(txt, "<br>", "\n");
}


(function ($) {
    $.fn.rotateTableCellContent = function (options) {
        /*
         Version 1.0
         7/2011
         Written by David Votrubec (davidjs.com) and
         Michal Tehnik (@Mictech) for ST-Software.com
         */

        var cssClass = ((options) ? options.className : false) || "vertical";

        var cellsToRotate = $('.' + cssClass, this);

        var betterCells = [];
        cellsToRotate.each(function () {
            var cell = $(this)
                    , newText = cell.text()
                    , height = cell.height()
                    , width = cell.width()
                    , newDiv = $('<div>', { height: width, width: height })
                    , newInnerDiv = $('<div>', { text: newText, 'class': 'rotated' });

            newInnerDiv.css('-webkit-transform-origin', (width / 2) + 'px ' + (width / 2) + 'px');
            newInnerDiv.css('-moz-transform-origin', (width / 2) + 'px ' + (width / 2) + 'px');
            newDiv.append(newInnerDiv);

            betterCells.push(newDiv);
        });

        cellsToRotate.each(function (i) {
            $(this).html(betterCells[i]);
        });
    };
})(jQuery);

function contenidoAyuda(id){
    dwr.util.setValue("evalua" + id, replaceAll(window["data"+id].evalua, "\n", "<br>"), { escapeHtml:false });
    var valor = dwr.util.getValue("i"+id);
//        alert("valor = " + valor);
//        alert("Total = " + dwr.util.getValue('l' + id));
    var ayuda;
    if(valor<=20){
        ayuda = window["data" + id].c20;
    } else if(valor > 20 && valor <= 40){
        ayuda = window["data" + id].c40;
    } else if(valor > 40 && valor <= 60){
        ayuda = window["data" + id].c60;
    } else if(valor > 60 && valor <= 80){
        ayuda = window["data" + id].c80;
    } else if(valor > 80 ){
        ayuda = window["data" + id].c100;
    }

    dwr.util.setValue("ayuda" + id,  replaceAll(ayuda,    "\n", "<br>"), { escapeHtml:false });
}

function contenidoAyudaCriterio(id, idCapitulo){
    dwr.util.setValue(idCapitulo+"-evalua" + id, replaceAll(window["dataCrite"+id].evalua, "\n", "<br>"), { escapeHtml:false });
    var valor = dwr.util.getValue(idCapitulo+"-"+id);
//    alert("valor = " + valor);
//    alert("Total = " + dwr.util.getValue('l' + id));
    var ayuda;
    if (valor==50) {
        ayuda = window["dataCrite" + id].c50;
    } else if(valor<=20){
        ayuda = window["dataCrite" + id].c20;
    } else if(valor > 20 && valor <= 40){
        ayuda = window["dataCrite" + id].c40;
    } else if(valor > 40 && valor <= 60){
        ayuda = window["dataCrite" + id].c60;
    } else if(valor > 60 && valor <= 80){
        ayuda = window["dataCrite" + id].c80;
    } else if(valor > 80 ){
        ayuda = window["dataCrite" + id].c100;
    }

    dwr.util.setValue(idCapitulo+"-ayuda" + id,  replaceAll(ayuda,    "\n", "<br>"), { escapeHtml:false });
}

function muestraAyudaCualitativa(idCualitativa, idCapitulo){
    $("#"+idCualitativa+"-"+idCapitulo+"-contenido").toggle();
}

function muestraAyuda(id, palanca){
    if(palanca){
        $("#contenido" + id).toggle();
    }
    if (window["data"+id] == null) {
//            alert("es nula");
        pnRemoto.getPnSubCapitulo(id, function(data) {
            if (data != null) {
                window["data"+id] = data;
                contenidoAyuda(id);
            }
        });
    } else {
//            alert("window['data'"+id+"] = " + window["data"+id]);
        contenidoAyuda(id);
    }
}

function muestraAyudaCriterio(idCrite, idCapitulo, palanca){
    if(palanca){
        var contenidoTR = "#"+idCapitulo+"-contenido" + idCrite;
//        alert("contenidoTR = " + contenidoTR);
        $(contenidoTR).toggle();
    }
    if (window["dataCrite"+idCrite] == null) {
//        alert("es nula");
        pnRemoto.getPnCriterio(idCrite, function(data) {
            if (data != null) {
                window["dataCrite"+idCrite] = data;
//                alert("data.evalua = " + data.evalua);
//                alert("win.evalua = " + window["dataCrite"+idCrite].evalua);
//                alert(dwr.util.toDescriptiveString(data, 1));
                contenidoAyudaCriterio(idCrite, idCapitulo);
            }
        });
    } else {
//            alert("window['data'"+id+"] = " + window["data"+id]);
        contenidoAyudaCriterio(idCrite, idCapitulo);
    }
}

function scrollToAnchor(aid){
    var aTag = $("a[name='"+ aid +"']");
    $('html,body').animate({scrollTop: aTag.offset().top},'slow');
}


function cargaResultado(idEmpleado, page, nombre){
    pnRemoto.getIncludeResultadoInd(idEmpleado, page, nombre, function(data){
        if (data!=null) {
            dwr.util.setValue("resultado", data, { escapeHtml:false });
//            window.location.hash="aResultado";
            scrollToAnchor("aResultado");
        }
    });
}

function cargaResultadoConcenso(idParticipante, page, nombre){
    pnRemoto.getIncludeResultadoConsenso(idParticipante, page, nombre, function(data){
        if (data!=null) {
            dwr.util.setValue("resultado", data, { escapeHtml:false });
//            window.location.hash="aResultado";
            scrollToAnchor("aResultado");
        }
    });
}