var gf = new Object();
var pgf_base_url = "pgf"

gf.translate = function (input,from,to,cat,callback) {
  var args = [];
  args["input"] = input;
  args["from"] = from;
  args["to"] = to;
  args["cat"] = cat;
  gf.callFunction("translate", args, callback);
};

gf.complete = function (input,from,cat,callback) {
  var args = [];
  args["input"] = input;
  args["from"] = from;
  args["cat"] = cat;
  gf.callFunction("complete", args, callback);
};

gf.grammar = function (callback) {
  gf.callFunction("grammar", [], callback);
};

gf.callFunction = function (fun, args, callback) {
  var query = "";
  for (var i in args) {
    query += (query == "") ? "?" : "&";
    query += i + "=" + escape(args[i]);
  }
  gf.httpGetText(pgf_base_url + "/" + fun + query, function (output) { callback(gf.readJSON(output)); });
}

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
