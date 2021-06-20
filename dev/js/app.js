document.addEventListener('deviceready', onDeviceReady, false);

var do_req = true
var active_btn = null
var buttonsAvailable = ["b1", "b2", "b3", "b4", "b5", "b6", "b7", "b8", "b9", "b10", "b11", "b12"]

function onDeviceReady() {


    if (localStorage.getItem("analytics") == "all") {
        var Sentry = cordova.require("sentry-cordova.Sentry");
        Sentry.init({ dsn: 'https://790b7fe9e12c41f0b9778bd467b30463@o661934.ingest.sentry.io/5802311' });
    } else if (localStorage.getItem("analytics") == "nothing") {
    }
    console.log("Let's go!")

    for (let i=1; i <= 12; i++ ) {   
        if (localStorage.getItem(`btn-text-${i}`) != null) {
            for (let j=0; j <= document.getElementsByClassName(`b${i}`).length-1; j++) {
                console.log(localStorage.getItem(`btn-text-${i}`), i)
                document.getElementsByClassName(`b${i}`)[j].innerHTML = localStorage.getItem(`btn-text-${i}`)
            }
        }
    }
    for (let i=1; i <= 12; i++ ) {
        if (localStorage.getItem(`btn-color-${i}`) != null) {
            for (let j=0; j <= document.getElementsByClassName(`b${i}`).length-1; j++) {
                console.log(j)
                document.getElementsByClassName(`b${i}`)[j].style.backgroundColor = localStorage.getItem(`btn-color-${i}`)
            }
        }
    }


}

document.addEventListener("long-press", function(e) {
    window.location.replace("settings.html")
})










function save_settings() {
    console.log("Here i am")
    localStorage.setItem(`btn-text-${active_btn}`, document.getElementById("btn_label").value)
}

function buttonPressed(btn) {
    navigator.vibrate(300)
    var xhr = new XMLHttpRequest()
    xhr.open("GET", `${localStorage.getItem("host")}/button_pressed?key=${btn}&token=${localStorage.getItem("pin")}`)
    xhr.send()
    xhr.onerror = function() {
        M.toast({text: "There was an error sending the request!"})
    }
}





document.addEventListener("keypress", (e) => {
    if (do_req == true) {
        buttonPressed((e.code).replace("Key", "").toLowerCase())
        
    }

})