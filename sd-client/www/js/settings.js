var hueb = undefined


var elems = document.querySelectorAll('.color-input');
var hueb = new Array()
for ( var i=0; i < elems.length; i++ ) {
  
  var elem = elems[i];
  console.log(elems[i], i)
  hueb.push(new Huebee( elem, {
    setText: false,
    staticOpen: false,
    notation: 'hex',
    saturations: 1,
  }));
}


function saveSettings(ButtonNumber) {
  
  if (hueb[ButtonNumber-1].color != undefined) {
    localStorage.setItem(`btn-color-${ButtonNumber}`, hueb[ButtonNumber-1].color)
  }

  if (document.getElementById(`buttonName${ButtonNumber}`).value != "") {
    localStorage.setItem(`btn-text-${ButtonNumber}`, document.getElementById(`buttonName${ButtonNumber}`).value)
  }
  window.location.reload()
}



document.addEventListener('deviceready', onDeviceReady, false);
function onDeviceReady() {
  for (let i=1; i <= 12; i++ ) {
    if (localStorage.getItem(`btn-text-${i}`) != null) {
      document.getElementById(`b${i}`).innerHTML = localStorage.getItem(`btn-text-${i}`)
    }
  }
  for (let i=1; i <= 12; i++ ) {
    if (localStorage.getItem(`btn-color-${i}`) != null) {
      console.log(`btn-color-${i}`)
      document.getElementById(`b${i}`).style.backgroundColor = localStorage.getItem(`btn-color-${i}`)
    }
  }

}