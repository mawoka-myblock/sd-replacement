document.addEventListener('deviceready', onDeviceReady, false);

var do_req = true
var active_btn = null
var buttonsAvailable = ["b1", "b2", "b3", "b4", "b5", "b6", "b7", "b8", "b9", "b10", "b11", "b12"]

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





document.addEventListener("long-press", function(e){ 
    console.log("L67")
    
    do_req = false
    var elems = document.querySelectorAll('.modal');
    var elem = document.getElementById("settings")
    var instances = M.Modal.init(elems, {dismissable: false, startingTop: "10%", endingTop: "10%"})
    var instance = M.Modal.getInstance(elem);
    instance.open()
    active_btn = e.target.id
    console.log(active_btn)
    console.log("L76")
    
    if (e.target.id == "b1") {
        console.log("L79")
        var hueb = new Huebee( ".color-input", {
            setText: false,
            staticOpen: true,
            notation: 'hex',
            saturations: 2,
        } )
        
    }
    do_req = true
})



document.addEventListener("keypress", (e) => {
    if (do_req == true) {
        buttonPressed((e.code).replace("Key", "").toLowerCase())
        
    }

})