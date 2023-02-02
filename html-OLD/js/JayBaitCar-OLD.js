const _URL = "https://JayBaitCar/";

var CAR_KEY = document.getElementById("car-key");
var ICON_LOCK = document.getElementById("key-icon-lock");
var ICON_UNLOCK = document.getElementById("key-icon-unlock");
var ICON_ENGINE_ON = document.getElementById("key-icon-engine-on");
var ICON_ENGINE_OFF = document.getElementById("key-icon-engine-off");
var ICON_EBRAKE_ON = document.getElementById("key-icon-ebrake-on");
var ICON_EBRAKE_OFF = document.getElementById("key-icon-ebrake-off");
var ICON_ALARM = document.getElementById("key-icon-alarm");

var remoteStatus = {
    visible: false,
    engineOn: true,
    eBrakeOn: false
}


updateRemote(77);

document.onload = function() {
    console.log("Document loaded")
}

window.onload = function() {
    console.log("Window loaded")
}


/**
 * Hide the remote on ESC click
 */
document.addEventListener("keyup", (event) => {
    if (event.key === "Escape") {
        remoteStatus.visible = false;
        updateRemote();

        $.post( _URL + "remoteHidden", JSON.stringify({}) );
    }
});


/**
 * NUI Message Example
 * SendNUIMessage({ module = "JayBaitCar-openRemote" })
 */
window.addEventListener("message", function (event) {
    switch (event.data.module) {
        case "JayBaitCar-openRemote":
            remoteStatus.visible = true;
            updateRemote();
            break;
            
        case "JayBaitCar-closeRemote":
            remoteStatus.visible = false;
            updateRemote();

            $.post( _URL + "remoteHidden", JSON.stringify({}) );
            break;

        default:
            break;
    }
});


ICON_ALARM.onclick = function() { $.post( _URL + "remoteButton_alarm", JSON.stringify({}) ); }

ICON_LOCK.onclick = function() { $.post( _URL + "remoteButton_lock", JSON.stringify({}) ); }

ICON_UNLOCK.onclick = function() { $.post( _URL + "remoteButton_unlock", JSON.stringify({}) ); }

ICON_ENGINE_ON.onclick = function() { 
    $.post( _URL + "remoteButton_engineOn", JSON.stringify({}) );
    console.log(1, remoteStatus.visible, remoteStatus.engineOn, remoteStatus.eBrakeOn)
    remoteStatus.engineOn = false;
    console.log(2, remoteStatus.visible, remoteStatus.engineOn, remoteStatus.eBrakeOn)
    updateRemote();
    console.log(3, remoteStatus.visible, remoteStatus.engineOn, remoteStatus.eBrakeOn)
}

ICON_ENGINE_OFF.onclick = function() { 
    $.post( _URL + "remoteButton_engineOff", JSON.stringify({}) );
    remoteStatus.engineOn = true;
    updateRemote();
}

ICON_EBRAKE_ON.onclick = function() { 
    $.post( _URL + "remoteButton_ebrakeOn", JSON.stringify({}) );
    remoteStatus.eBrakeOn = false;
    updateRemote();
}

ICON_EBRAKE_OFF.onclick = function() { 
    $.post( _URL + "remoteButton_ebrakeOff", JSON.stringify({}) );
    remoteStatus.eBrakeOn = true;
    updateRemote();
}

function updateRemote(x) {
    console.log("Updating Remote Status: ", x, remoteStatus.visible, remoteStatus.engineOn, remoteStatus.eBrakeOn)
    if (remoteStatus.visible == false) {
        console.log(100)
        ICON_EBRAKE_ON.style.visibility = "hidden";
        ICON_EBRAKE_OFF.style.visibility = "hidden";
        ICON_ENGINE_ON.style.visibility = "hidden";
        ICON_ENGINE_OFF.style.visibility = "hidden";
        ICON_ALARM.style.visibility = "hidden";
        ICON_UNLOCK.style.visibility = "hidden";
        ICON_LOCK.style.visibility = "hidden";
        CAR_KEY.style.visibility = "hidden";
    } else {
        console.log(101)
        ICON_ALARM.style.visibility = "visible";
        ICON_UNLOCK.style.visibility = "visible";
        ICON_LOCK.style.visibility = "visible";
        CAR_KEY.style.visibility = "visible";

        if (remoteStatus.engineOn) {
            ICON_ENGINE_ON.style.visibility = "visible";
            ICON_ENGINE_OFF.style.visibility = "hidden";
        } else {
            ICON_ENGINE_ON.style.visibility = "hidden";
            ICON_ENGINE_OFF.style.visibility = "visible";
        }

        if (remoteStatus.eBrakeOn) {
            ICON_EBRAKE_ON.style.visibility = "visible";
            ICON_EBRAKE_OFF.style.visibility = "hidden";
        } else {
            ICON_EBRAKE_ON.style.visibility = "hidden";
            ICON_EBRAKE_OFF.style.visibility = "visible";
        }
    }
    console.log(103)
}