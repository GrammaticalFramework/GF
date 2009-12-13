/* Output */

function sayText(text) {
  document.voice_output_text = text;
  activateForm("voice_output");
}

/* XHTML+Voice Utilities */

function activateForm(formid) {
  var form = document.getElementById(formid);
  var e = document.createEvent("UIEvents");
  e.initEvent("DOMActivate","true","true");
  form.dispatchEvent(e); 
}


/* DOM utilities */

/* Gets the head element of the document. */
function getHeadElement() {
  var hs = document.getElementsByTagName("head");
  if (hs.length == 0) {
    var head = document.createElement("head");
    document.documentElement.insertBefore(head, document.documentElement.firstChild);
    return head;
  } else {
    return hs[0];
  }
}

/* Gets the body element of the document. */
function getBodyElement() {
  var bs = document.getElementsByTagName("body");
  if (bs.length == 0) {
    var body = document.createElement("body");
    document.documentElement.appendChild(body);
    return body;
  } else {
    return bs[0];
  }
}

/* Removes all the children of a node */
function removeChildren(node) {
  while (node.hasChildNodes()) {
    node.removeChild(node.firstChild);
  }
}

function setText(node, text) {
  removeChildren(node);
  node.appendChild(document.createTextNode(text));
}
