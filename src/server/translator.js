function formatTranslation (outputs) {
  var dl1 = document.createElement("dl");
  dl1.className = "fromLang";
  for (var fromLang in outputs) {
    var ul = document.createElement("ul");
    addDefinition(dl1, document.createTextNode(fromLang), ul);
    for (var i in outputs[fromLang]) {
      var dl2 = document.createElement("dl");
      dl2.className = "toLang";
      for (var toLang in outputs[fromLang][i]) {
	addDefinition(dl2, document.createTextNode(toLang), document.createTextNode(outputs[fromLang][i][toLang]));
      }
      addItem(ul, dl2);
    }
  }

  return dl1;
}

function formatCompletions (compls) {
  var dl = document.createElement("dl");
  for (var fromLang in compls) {
    var ul = document.createElement("ul");
    for (var i in compls[fromLang]) {
      addItem(ul, document.createTextNode(compls[fromLang][i]));
    }
    addDefinition(dl, document.createTextNode(fromLang), ul);
  }
  return dl;
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
