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
    if(valor<20){
        ayuda = window["data" + id].c20;
    } else if(valor >= 20 && valor < 40){
        ayuda = window["data" + id].c40;
    } else if(valor >= 40 && valor < 60){
        ayuda = window["data" + id].c60;
    } else if(valor >= 60 && valor < 80){
        ayuda = window["data" + id].c80;
    } else if(valor >= 80 ){
        ayuda = window["data" + id].c100;
    }

    dwr.util.setValue("ayuda" + id,  replaceAll(ayuda,    "\n", "<br>"), { escapeHtml:false });
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