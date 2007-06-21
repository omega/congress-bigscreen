var hotkeys = true;

function keypresshandler(e) {

    if (!hotkeys)
        return;
    
    if (e.modifier().any == true) {
        logDebug("modifier pressed, ignoring");
        return;
    }
    var charCode = e.key().string;
    
    var al = document.getElementsByTagName('a');

    for (i=0; i<al.length; i++) {
        var a = al.item(i);
        var ak = a.attributes.getNamedItem('accesskey');
        if (ak && ak.nodeValue == charCode) {
            window.location.href = a.href;
            e.stop();
        }
    }
}


function disablehotkeys() {
    hotkeys = false;
}

function enablehotkeys() {
    hotkeys = true;
}


