var gf = new Object();

gf.translate = function (input,from,to,cat,callback) {
  gf.httpGetText("gf.fcgi/translate?input="+escape(input)+"&from="+escape(from)+"&to="+escape(to)+"&cat="+escape(cat), function (output) { callback(gf.readJSON(output)); });
};

gf.getLanguages = function (callback) {
    gf.httpGetText("gf.fcgi/languages", function (output) { callback(gf.readJSON(output)); });
};

gf.httpGetText = function (url, callback) { 
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
};

gf.readJSON = function (text) {
  return eval("("+text+")");
};
