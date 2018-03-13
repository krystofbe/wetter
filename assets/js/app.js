// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
var myIndex = 0;
var myIndex2 = 0;
var myIndex3 = 0;
var myIndex4 = 0;
var myIndex5 = 0;
var myIndex6 = 0;

carousel();

function uhrzeit(imgName) {
  var utcDate = berechneUhrzeit(imgName);

  if (utcDate > new Date()) {
    document.getElementById("uhrzeit").innerHTML =
      utcDate.toLocaleString() + " Prognose ";
  } else {
    document.getElementById("uhrzeit").innerHTML = utcDate.toLocaleString();
  }
}

function berechneUhrzeit(imgName) {
  // 20170101-1830
  var datumUngeparst = imgName.getAttribute("data-timestamp");

  var utcDate = new Date();
  utcDate.setUTCFullYear(datumUngeparst.substring(0, 4));
  utcDate.setUTCMonth(datumUngeparst.substring(4, 6) - 1);
  utcDate.setUTCDate(datumUngeparst.substring(6, 8));
  utcDate.setUTCHours(datumUngeparst.substring(9, 11));
  utcDate.setUTCMinutes(datumUngeparst.substring(11, 13));
  utcDate.setUTCSeconds(0);
  return utcDate;
}

function carousel() {
  var i;

  var x = document.getElementsByClassName("regen1");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  myIndex++;
  if (myIndex > x.length) {
    myIndex = 1;
  }
  x[myIndex - 1].style.display = "inline";

  var x = document.getElementsByClassName("regen2");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  myIndex2++;
  if (myIndex2 > x.length) {
    myIndex2 = 1;
  }
  x[myIndex2 - 1].style.display = "inline";
  uhrzeit(x[myIndex2 - 1]);

  var x = document.getElementsByClassName("regen3");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  myIndex3++;
  if (myIndex3 > x.length) {
    myIndex3 = 1;
  }
  x[myIndex3 - 1].style.display = "inline";

  var x = document.getElementsByClassName("regen4");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  myIndex4++;
  if (myIndex4 > x.length) {
    myIndex4 = 1;
  }
  x[myIndex4 - 1].style.display = "inline";

  var x = document.getElementsByClassName("regen5");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  myIndex5++;
  if (myIndex5 > x.length) {
    myIndex5 = 1;
  }
  x[myIndex5 - 1].style.display = "inline";

  var x = document.getElementsByClassName("regen6");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  myIndex6++;
  if (myIndex6 > x.length) {
    myIndex6 = 1;
  }
  x[myIndex6 - 1].style.display = "inline";

  setTimeout(carousel, 800); // Change image every 2 seconds
}
