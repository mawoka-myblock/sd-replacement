function onDeviceReady() {
    // Cordova is now initialized. Have fun!
    if (localStorage.getItem("analytics") == "all") {
        var Sentry = cordova.require("sentry-cordova.Sentry");
        Sentry.init({ dsn: 'https://790b7fe9e12c41f0b9778bd467b30463@o661934.ingest.sentry.io/5802311' });
    } else if (localStorage.getItem("analytics") == "sentry") {
        var Sentry = cordova.require("sentry-cordova.Sentry");
        Sentry.init({ dsn: 'https://790b7fe9e12c41f0b9778bd467b30463@o661934.ingest.sentry.io/5802311' });
    } else if (localStorage.getItem("analytics") == "nothing") {
    } else {
        var Sentry = cordova.require("sentry-cordova.Sentry");
        Sentry.init({ dsn: 'https://790b7fe9e12c41f0b9778bd467b30463@o661934.ingest.sentry.io/5802311' });
    }
}


document.addEventListener("keypress", (e) => {
    buttonPressed((e.code).replace("Key", "").toLowerCase())
})

function buttonPressed(btn) {
    var xhr = new XMLHttpRequest()
    xhr.open("GET", `${localStorage.getItem("host")}/button_pressed?key=${btn}&token=${localStorage.getItem("pin")}`)
    xhr.send()
    xhr.onerror = function() {
        M.toast({text: "There was an error sending the request!"})
    }
}