const _URL = "https://JayBaitCar/";

const CAR_KEY = document.getElementById("car-key");
const ICON_LOCK = document.getElementById("key-icon-lock");
const ICON_UNLOCK = document.getElementById("key-icon-unlock");
const ICON_ENGINE_ON = document.getElementById("key-icon-engine-on");
const ICON_ENGINE_OFF = document.getElementById("key-icon-engine-off");
const ICON_EBRAKE_ON = document.getElementById("key-icon-ebrake-on");
const ICON_EBRAKE_OFF = document.getElementById("key-icon-ebrake-off");
const ICON_ALARM = document.getElementById("key-icon-alarm");


/**
 * Hide the remote on ESC click
 */
document.addEventListener("keyup", (event) => {
    if (event.key === "Escape") {
        toggleRemoteVisibility();

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
                toggleRemoteVisibility();
            break;
            
        case "JayBaitCar-closeRemote":
            toggleRemoteVisibility();

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
    ICON_ENGINE_ON.style.visibility = "hidden";
    ICON_ENGINE_OFF.style.visibility = "visible";
}

ICON_ENGINE_OFF.onclick = function() { 
    $.post( _URL + "remoteButton_engineOff", JSON.stringify({}) );
    ICON_ENGINE_ON.style.visibility = "visible";
    ICON_ENGINE_OFF.style.visibility = "hidden";
}

ICON_EBRAKE_ON.onclick = function() { 
    $.post( _URL + "remoteButton_ebrakeOn", JSON.stringify({}) );
    ICON_EBRAKE_ON.style.visibility = "hidden";
    ICON_EBRAKE_OFF.style.visibility = "visible";
}

ICON_EBRAKE_OFF.onclick = function() { 
    $.post( _URL + "remoteButton_ebrakeOff", JSON.stringify({}) );
    ICON_EBRAKE_ON.style.visibility = "visible";
    ICON_EBRAKE_OFF.style.visibility = "hidden";
}


function toggleRemoteVisibility() {
    if (CAR_KEY.style.visibility == "hidden") CAR_KEY.style.visibility = "visible"
    else  CAR_KEY.style.visibility = "hidden";
}