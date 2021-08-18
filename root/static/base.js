function crontab() {
    update();
}

function render_speaker(o) {
    if (o.nr) {
        return o.nr + " " + o.name + (o.district ? " (" + o.district + ")" : "");
    } else {
        return "";
    }
}
function render_agenda(o) {
    if (o.nr) {
        return o.nr + " " + o.subcase + " - " + o.title;
    } else {
        return "";
    }
}

var c = 0;

function reschedule() {
//    logDebug("rescheduling crontab");
    c = window.setTimeout(crontab, 5000);
}
function unschedule() {
//    logDebug("stopping crontab");
    window.clearTimeout(c);
    c = 0;
}
function update() {
    
var ok = function(res) {
        for (id in res) {
            var content;
            var o = res[id];
            if (id == 'speaker' || id == 'next_speaker') {
                content = render_speaker(o);
            } else if (id == 'agenda') {
                content = render_agenda(o);
            }
            
            var elem = getElement(id);

            if (elem.innerHTML == content) {
            } else {
                var addE = function(i, c) {
                    var el = getElement(i);
                    el.innerHTML = c;
                    appear(i);
                };
                
                fade(id, { afterFinish: partial(addE, id, content) });
            }
        }
        reschedule();
    };
    var fail = function(err) {
        logError(err);
        reschedule();
    };

    fetch('/ajax/update')
        .then(res => res.json())
        .then(ok);
}

function bootloader() {
    var body = document.getElementsByTagName('body')[0];
    if (body.id == 'frontend') {
        logDebug("We are the frontend!");
        var func = function(){ if (c) {
                unschedule();
            } else {
                reschedule();
            }
        };
        connect('logo', 'onclick', func);
        crontab();
    } else if (body.id == 'admin') {
        logDebug("We are the administration");
        
        connect(document, "onkeypress", keypresshandler);

        var il = document.getElementsByTagName('input');
        for (i=0; i<il.length; i++) {
            connect(il.item(i), "onblur", enablehotkeys);
            connect(il.item(i), "onfocus",disablehotkeys);
        }
        var il = document.getElementsByTagName('textarea');
        for (i=0; i<il.length; i++) {
            connect(il.item(i), "onblur", enablehotkeys);
            connect(il.item(i), "onfocus",disablehotkeys);
        }
    }
}

connect(window, "onload", bootloader);
