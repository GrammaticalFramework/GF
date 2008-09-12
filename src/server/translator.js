function formatTranslation (outputs) {
  var dl1 = document.createElement("dl");
  for (var i in outputs) {
    var o = outputs[i];
    addDefinition(dl1, document.createTextNode(o.to), document.createTextNode(o.text));
  }

  return dl1;
}

function formatCompletions (compls) {
  var ul = document.createElement("ul");
  for (var i in compls) {
    var c = compls[i];
    addItem(ul, document.createTextNode(c.text));
  }
  return ul;
}

/* DOM utilities for specific tags */

function addDefinition (dl, t, d) {
    var dt = document.createElement("dt");
    dt.appendChild(t);
    dl.appendChild(dt);
    var dd = document.createElement("dd");
    dd.appendChild(d);
    dl.appendChild(dd);
}

function addItem (ul, i) {
    var li = document.createElement("li");
    li.appendChild(i);
    ul.appendChild(li);
}

function addOption (select, value, content) {
  var option = document.createElement("option");
  option.value = value;
  option.appendChild(document.createTextNode(content));
  select.appendChild(option);
}

/* General DOM utilities */

/* Removes all the children of a node */
function removeChildren(node) {
  while (node.hasChildNodes()) {
    node.removeChild(node.firstChild);
  }
}
