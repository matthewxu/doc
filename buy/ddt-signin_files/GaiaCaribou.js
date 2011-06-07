//------------------------------------------------------------------------
// This file depends on: 
// http://gmail.google.com/gmail?view=page&name=browser
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// Some browser detection logic. 
// Once http://gmail.google.com/gmail?view=page&name=browser has these 
// variables as *global* these definitions can be deleted. 
//------------------------------------------------------------------------
var agt = navigator.userAgent.toLowerCase();
var is_op = (agt.indexOf("opera") != -1);
var is_ie = (agt.indexOf("msie") != -1) && document.all && !is_op;
var is_ie5 = (agt.indexOf("msie 5") != -1) && document.all && !is_op;

//------------------------------------------------------------------------
// Communication with server
//------------------------------------------------------------------------

function CreateXmlHttpReq(handler) {
  var xmlhttp = null;
  if (is_ie) {
    // Guaranteed to be ie5 or ie6
    var control = (is_ie5) ? "Microsoft.XMLHTTP" : "Msxml2.XMLHTTP";

    try {
      xmlhttp = new ActiveXObject(control);
      xmlhttp.onreadystatechange = handler;
    } catch (ex) {
      // TODO: better help message
      alert("You need to enable active scripting and activeX controls");  
    }

  } else {

    // Mozilla
    xmlhttp = new XMLHttpRequest();
    xmlhttp.onload = handler;
    xmlhttp.onerror = handler;

  }

  return xmlhttp;
}

// XMLHttp send POST request
function XmlHttpPOST(xmlhttp, url, data) {
  try {
    xmlhttp.open("POST", url, true);
    xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
    xmlhttp.send(data);

  } catch (ex) {
    // do nothing
  }
}

// XMLHttp send GEt request
function XmlHttpGET(xmlhttp, url) {
  try {
    xmlhttp.open("GET", url, true);	
    xmlhttp.send(null);

  } catch (ex) {
    // do nothing
  }
}
