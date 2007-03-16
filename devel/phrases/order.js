var svgNS = "http://www.w3.org/2000/svg";

var currentOrder = new Fun("?");

var talkText;

function say(text) {
	talkText = text;
	activateForm("talker");
}

function newOrder() {
	currentOrder = new Fun("?");

	document.getElementById("in_abs").value = "";

	setText(document.getElementById("ordertext"), "");
	setText(document.getElementById("ordertextf"), "");
	setText(document.getElementById("ordertextt"), "");

	return getOrder();
}

function getOrder() {
	activateForm("getorder");
	return true;
}

function done(input) {
	currentOrder = Travel.copyTree(input);
	document.getElementById("in_abs").value = currentOrder.print();
	
	sayOrder();
}

function sayOrder() {
	var output = currentOrder;
        var eng = TravelEng.linearize(output);
	setText(document.getElementById("ordertext"), eng);
	
        var fin = TravelTha.linearize(output).replace(/ /g,"");
	setText(document.getElementById("ordertextf"), fin);	
        var tha = TravelThaiP.linearize(output);
	setText(document.getElementById("ordertextt"), tha);
	say(tha);	
}



/* XHTML+Voice Utilities */

function activateForm(formid) {
	var form = document.getElementById(formid);
	var e = document.createEvent("UIEvents");
	e.initEvent("DOMActivate","true","true");
	form.dispatchEvent(e); 
}

/* DOM utilities */

function removeChildren(node) {
	while (node.hasChildNodes()) {
		node.removeChild(node.firstChild);
	}
  }

function setText(node, text) {
	removeChildren(node);
	node.appendChild(document.createTextNode(text));
}
