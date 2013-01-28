function disableId(id){
    var bTmp = dwr.util.byId(id);
    bTmp.disabled = true;
}

function enableId(id){
    var bTmp = dwr.util.byId(id);
    bTmp.disabled = false;
}