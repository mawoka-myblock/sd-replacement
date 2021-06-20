/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

// Wait for the deviceready event before using any of Cordova's device APIs.
// See https://cordova.apache.org/docs/en/latest/cordova/events/events.html#deviceready
document.addEventListener('deviceready', onDeviceReady, false);



function onDeviceReady() {
    if (localStorage.getItem("analytics") == "all") {
        var Sentry = cordova.require("sentry-cordova.Sentry");
        Sentry.init({ dsn: 'https://790b7fe9e12c41f0b9778bd467b30463@o661934.ingest.sentry.io/5802311' });
    } else if (localStorage.getItem("analytics") == "nothing") {
    }
    



    if (localStorage.getItem("analytics") != true) {
        var elems = document.querySelectorAll('.modal');
        //var instances = M.Modal.init(elems, {})
        var instance = M.Modal.init(document.getElementById("modal1"), {dismissible: false, startingTop: "10%", endingTop: "10%"})
        instance.open();
    }
}




function testConnection() {
    navigator.vibrate(3000)
    try {
        document.getElementById("submit_btn").classList.add("disabled");
        document.getElementById("loader_submit").style.visibility = "visible";
        var xhr = new XMLHttpRequest()
        xhr.open("GET", `${document.getElementById("host").value}/test-token?token=${document.getElementById("pin").value}`, true);
        xhr.send();
        xhr.onerror = function() {
            M.toast({text: "Error in the request!"})
            document.getElementById("loader_submit").style.visibility = "hidden";
            document.getElementById("submit_btn").classList.remove("disabled");
        }
        console.log(xhr.status)
        xhr.onload = function () {
            if (xhr.status == 200) {
                M.toast({text: "Success!"})
                localStorage.setItem("pin", document.getElementById("pin").value)
                localStorage.setItem("host", document.getElementById("host").value)
                window.location.href = "app.html"

            } else if (xhr.status != 200) {
                M.toast({text: "The pin is wrong (very likely)"})
                document.getElementById("submit_btn").classList.remove("disabled");
                document.getElementById("loader_submit").style.visibility = "hidden";

            } else {
                document.getElementById("loader_submit").style.visibility = "hidden";
            }
        }
    } catch {
        document.getElementById("loader_submit").style.visibility = "hidden";
        document.getElementById("submit_btn").classList.remove("disabled");
        M.toast({text: "Couldn't connect!"})
    }

    


}



window.onload = function () {
    if (localStorage.getItem("pin") != null) {
        window.location.href = "app.html"
    }
}