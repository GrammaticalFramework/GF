var currentOrder = new Fun("?");
var talkText;


function say(text) {
	talkText = text;
	activateForm("talker");
}

function newOrder() {
	currentOrder = new Fun("?");

	document.getElementById("top_abs").value = "";
	document.getElementById("top_img").value = "";

	document.getElementById("ordertext").value = "";

	return getOrder();
}

function getOrder() {
	activateForm("getorder");
	return true;
}


function done(input) {
	currentOrder = Pizza.copyTree(input, "Order");
	document.getElementById("top_abs").value = currentOrder.print();

	sayOrder();
}

function sayOrder() {
	var eng = PizzaEng.linearize(currentOrder);
	document.getElementById("ordertext").value = eng;
	say("You have ordered " + eng);	
}



/* XHTML+Voice Utilities */

function activateForm(formid) {
	var form = document.getElementById(formid);
	var e = document.createEvent("UIEvents");
	e.initEvent("DOMActivate","true","true");
	form.dispatchEvent(e); 
}
