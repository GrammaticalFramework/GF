function translate (input,from,to,cat) {
  httpGetText("gf.fcgi/translate?input="+escape(input)+"&from="+escape(from)+"&to="+escape(to)+"&cat="+escape(cat), function (output) { alert(output); });
}

function httpGetText(url, callback) { 
  var XMLHttpRequestObject = false; 

  if (window.XMLHttpRequest) {
    XMLHttpRequestObject = new XMLHttpRequest();
  } else if (window.ActiveXObject) {
    XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");
  }

  if (XMLHttpRequestObject) {
    XMLHttpRequestObject.open("GET", url); 

    XMLHttpRequestObject.onreadystatechange = function () { 
      if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) { 
          callback(XMLHttpRequestObject.responseText); 
          delete XMLHttpRequestObject;
          XMLHttpRequestObject = null;
      } 
    } 

    XMLHttpRequestObject.send(null); 

  }

}
