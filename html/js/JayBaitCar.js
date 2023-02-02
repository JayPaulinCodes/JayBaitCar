const _URL = "https://JayBaitCar/";

const elements = {
    carKey: $("#car-key"),
    
    icons: {
        lock: $("#key-icon-lock"),
        unlock: $("#key-icon-unlock"),
        engine: $("#key-icon-engine"),
        eBrake: $("#key-icon-ebrake"),
        alarm: $("#key-icon-alarm")
    }
}

// Hide elements
elements.carKey.hide();
elements.icons.lock.hide();
elements.icons.unlock.hide();
elements.icons.engine.hide();
elements.icons.eBrake.hide();
elements.icons.alarm.hide();

// Element Clicks
elements.icons.lock.click(function() {
    sendData("remoteButton_lock", {});
});

elements.icons.unlock.click(function() {
    sendData("remoteButton_unlock", {});
});

elements.icons.engine.click(function() {
    let currentState = (elements.icons.engine.attr("data-value") === 'true');
    let newState = !currentState;

    if (newState == true) {
        setElementSource(elements.icons.engine, "imgs/Engine_On.png");
    } else {
        setElementSource(elements.icons.engine, "imgs/Engine_Off.png");
    }

    elements.icons.engine.attr({"data-value": newState});

    sendData("remoteButton_engine", { state: newState });
});

elements.icons.eBrake.click(function() {
    let currentState = (elements.icons.eBrake.attr("data-value") === "true");
    let newState = !currentState;

    if (newState == true) {
        setElementSource(elements.icons.eBrake, "imgs/E-Brake_On.png");
    } else {
        setElementSource(elements.icons.eBrake, "imgs/E-Brake_Off.png");
    }

    elements.icons.eBrake.attr({"data-value": newState});

    sendData("remoteButton_ebrake", { state: newState });
});

elements.icons.alarm.click(function() {
    sendData("remoteButton_alarm", {});
});


$(document).keyup( function(event) {
	if (event.keyCode == 27) {
		closeRemote();
	}
});

$(document).contextmenu(function() {
	closeRemote(); 
});



//
//  Functions
// 

function setElementVisible(element, state) { 
    console.log(`Setting element visible for ${element.attr("id")} to ${state}`);
    state ? element.show() : element.hide(); 
}

function setElementSource(element, url) { 
    console.log(`Setting element source for ${element.attr("id")} to ${url}`);
    element.attr({"src": url});
}

function sendData(name, data) {
    $.post(_URL + name, JSON.stringify(data), function(result) {
        if (result != ok) console.log(result);
    });
}

function openRemote() {
    console.log("Open Func");
    elements.carKey.show();
    elements.icons.lock.show();
    elements.icons.unlock.show();
    elements.icons.engine.show();
    elements.icons.eBrake.show();
    elements.icons.alarm.show();
}

function closeRemote() {
    console.log("Close Func");
    elements.carKey.hide();
    elements.icons.lock.hide();
    elements.icons.unlock.hide();
    elements.icons.engine.hide();
    elements.icons.eBrake.hide();
    elements.icons.alarm.hide();

    sendData("remoteHidden", {});
}


//
// Event Listener
//
window.addEventListener("message", function(event) {
    var _module = event.data.module;
    var item = event.data;

    switch (_module) {
        case "openRemote":
            openRemote();
            break;
        case "closeRemote":
            closeRemote();
            break;
    
        default:
            break;
    }

});