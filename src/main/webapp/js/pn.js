function disableId(id){
    var bTmp = dwr.util.byId(id);
    bTmp.disabled = true;
}

function enableId(id){
    var bTmp = dwr.util.byId(id);
    bTmp.disabled = false;
}


function replaceAll( text, busca, reemplaza ){
  while (text.toString().indexOf(busca) != -1)
      text = text.toString().replace(busca,reemplaza);
  return text;
}


function poneSaltosDeLinea(txt){
    return replaceAll(txt, "<br>", "\n");
}