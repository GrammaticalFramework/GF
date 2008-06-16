
//Variable and Constant definitions

var expColImg = new Array(2);
expColImg[0]     = new Image(12,12);
expColImg[0].src = "minus.png";
expColImg[1]     = new Image(12,12);
expColImg[1].src = "plus.png";

// Grammars
var grammar = undefined;
var editorGrammar = Editor;

var selectedLanguage = "EditorEng";
var selectedNode = "";
var collapseBuffer = new Array();
var abstractTree = new Fun ("?");

var navigationControlString = new Array();
var undoArray = new Array();
var redoArray = new Array();
var clipBoard;
var refPageCounter = 0;

var stringAbstractTree = undefined;
var myTree = undefined;
var parseTrees = undefined;

var keys = new Array();
keys ["Z"] = function() { clickUndo('actUndo'); }
keys ["Y"] = function() { clickRedo('actRedo'); }
keys ["R"] = function() { clickRefine('actRefine'); };
keys ["V"] = function() { clickPaste('actPaste'); };
keys ["X"] = function() { clickCut('actCut'); };
keys ["C"] = function() { clickCopy('actCopy'); };
keys ["D"] = function() { clickDelete('actDelete'); };
keys ["E"] = function() { clickReplace('actReplace'); };
keys ["W"] = function() { clickWrap('actWrap'); };
keys ["P"] = function() { clickParse('actParse'); };
keys ["N"] = function() { clickRandomNode('actRandomNode'); };
keys ["T"] = function() { clickRandomTree('actRandomTree'); };
keys ["%"] = function() { leftArrowKey(); };
keys ["&"] = function() { upDownArrowKey(-1); };
keys ["'"] = function() { rightArrowKey(); };
keys ["("] = function() { upDownArrowKey( 1); };
keys ["27"] = function() { clickEsc(); };

function state(selectedNode, tree, collapseBuffer) {
	this.selectedNode = selectedNode;
//	this.tree = myAbstract.copyTree(tree);
	this.tree = grammar.abstract.copyTree(tree);
	this.collapseBuffer = collapseBuffer;
	return this;
}

function treeNode(name, caption) {
	this.name = name;
	this.caption = caption;
	this.cat = ""; 
	this.children = new Array();
	this.collapsed = false;
	return this;
}

treeNode.prototype.addChild = function (i, c) {
	this.children[i] = c;
}

treeNode.prototype.hasChildren = function() {
	return this.children.length;	
}

// Creates an instance of the editor and stores it in the given HTML container.
// Previous content is destroyed.
function mkEditor(container, myGrammar) {
	grammar = myGrammar;
	myTree = treeFromAbstract(grammar.abstract.annotate(abstractTree, grammar.abstract.startcat), "0");
	var holder = document.getElementById(container);
	holder.innerHTML = "<div id='wrapper'><div id='absFrame'></div><div id='conFrame'></div><div id='actFrame'></div><div id='refFrame'></div><div id='messageFrame'></div><div id='clipboardFrame'></div></div>";
	nodeClick('0', '?');
}

// Generates a tree from the string representation of an abstract tree contained in the element elementToParse
function parseStringTree(elementToParse) {
	stringAbstractTree = elementToParse;
	abstractTree = grammar.abstract.handleLiterals(grammar.abstract.parseTree(document.getElementById(elementToParse).value, grammar.abstract.startcat));
	myTree = treeFromAbstract(abstractTree, "0");
	nodeClick("0");
}

// If a key is pressed and a function assigned to that key, calls the function
function hotKeys(event) {
	event = (event) ? event : ((window.event) ? event : null);
	if (event) {
		var charCode = (event.charCode) ? event.charCode : ((event.which) ? event.which : event.keyCode);
		if (keys[String.fromCharCode(charCode).toUpperCase()] &&
			!event.ctrlKey && !event.altKey && !event.shiftKey && !event.metaKey) {
		    	keys[String.fromCharCode(charCode).toUpperCase()]();
		}
		else if (keys["" + charCode] &&
			!event.ctrlKey && !event.altKey && !event.shiftKey && !event.metaKey) {
				keys["" + charCode]();
		}
		else if (charCode >= "96" && charCode <= "105" &&
			!event.ctrlKey && !event.altKey && !event.shiftKey && !event.metaKey) {
				keys["" + (charCode - 96)]();
		}
	}
}

// Clears "numeric" hotkeys
function clearHotKeys() {
	for (var key in keys) {
		if ((parseInt(key) + 1) && (key != "27")) { keys[key] = function() { }; }
	}
}

// Action to be performed when the up/down arrow key is pressed
function upDownArrowKey(pos) {
	var nodePos = getNavPos(selectedNode);
	if ((nodePos > 0 && pos < 0) || (nodePos < navigationControlString.length - 1 && pos > 0)) { 
		nodeClick(navigationControlString[nodePos + pos]);
	}
}

// Gets the position of a given node in the navigationControlString
function getNavPos(nodeName) {
	for (var i = 0, j = navigationControlString.length; i < j; i++) {
		if (navigationControlString[i] == nodeName) { return i; };
	}
	return undefined;
}

// Given a name and a tree, gets the node in the tree with that name
function getNode(nodeName, node) {
	if (nodeName == node.name) {
		return node;
	}
	else {	
		for (var i = 0, j = node.children.length; i < j; i++) {
			var found = getNode(nodeName, node.children[i]);
			if (found) { return found; }
		}
	}
}

// Action to be performed when the left arrow key is pressed
function leftArrowKey() {
	var node = getNode(selectedNode, myTree);
	if (!node.collapsed && node.hasChildren()) {
		signClick(node.name, node.caption);
	}
	else {
		var parentNode = getParent(node.name, myTree);
		if (parentNode) { nodeClick(parentNode.name); }
	}
}

// Gets the parent of the selected node
function getParent(nodeName, node) {
	if (node.name == nodeName) {	
		return undefined;
	}
	else {
		for (var i = 0, j = node.children.length; i < j; i++) {
			if (node.children[i].name == nodeName) { return node; }
		}
		for (var i = 0, j = node.children.length; i < j; i++) {
			var found = getParent(nodeName, node.children[i]);
			if (found) { return found; }
		}
	}
}

// Action to be performed when the right arrow key is pressed
function rightArrowKey() {
	var node = getNode(selectedNode, myTree);
	if (node.collapsed) {
		signClick(node.name, node.caption);
	}
	else {
		var firstDescendant = getfirstDescendant(node);
		if (firstDescendant) {
			nodeClick(firstDescendant.name);
		}
	}
}

// Gets the first descendant child of a node
function getfirstDescendant(node) {
	if (node.hasChildren() && !node.collapsed) { return node.children[0]; }
	return undefined;
}

// Produces and displays an HTML representation of the tree
function drawTree() {
	var frame = document.getElementById("absFrame");
	navigationControlString = new Array();
	frame.innerHTML = "<ul id='tree'>" + getTree(myTree, 0) + "</ul>";
	document.getElementById("link" + selectedNode).scrollIntoView(false);
}

// Produces an HTML representation of the tree
function getTree(tree, level) {
	navigationControlString[navigationControlString.length] = tree.name;
	var htmlTree = new Array();
	htmlTree.push("<li>");
	if (tree.hasChildren()) {	
		htmlTree.push("<img class='tree-menu'");
		if (tree.collapsed) {
			htmlTree.push(" src='plus.png'");
		}
		else { htmlTree.push(" src='minus.png'"); }
		htmlTree.push(" onclick='signClick(\"", tree.name, "\", \"", tree.caption, "\")' />");
	}
	else {
		htmlTree.push("<img class='tree-menu' src='empty.png' />");
	}
	htmlTree.push("<a id='link", tree.name, "'");
	if (document.getElementById("actRefine").className == "selected" ||
		document.getElementById("actReplace").className == "selected" ||
		document.getElementById("actWrap").className == "selected" ||
		document.getElementById("actParse").className == "selected") {
		htmlTree.push("class='treeGray' "); }
	else if (selectedNode == tree.name) { htmlTree.push("class='treeSelected' "); }
	else { htmlTree.push("class='tree' "); }
	htmlTree.push("href='' onclick='nodeClick(\"", tree.name, "\"); return false'>");
	if (tree.cat == "String" || tree.cat == "Int" || tree.cat == "Float") {
		htmlTree.push(tree.caption.substring(tree.caption.lastIndexOf("_") + 1));
	} else {
		htmlTree.push(tree.caption);
	}
	htmlTree.push("&nbsp;:&nbsp;", tree.cat, "</a></li><ul>");
	if (tree.hasChildren() && !tree.collapsed) {
		for (var i = 0, j = tree.children.length; i < j; i++) {
			htmlTree.push(getTree(tree.children[i], level + 1));
		}
	}
	htmlTree.push("</ul>");
	return htmlTree.join("");
}

// Linearizes and displays the abstract tree
function drawLinearizedFrame() {
	var frame = document.getElementById("conFrame");
	frame.innerHTML = getLinearizedFrame();
}

// Linearizes the abstract tree and returns it in HTML form
function getLinearizedFrame() {
	var linearizedFrame = new Array();
	for (var i in grammar.concretes) {	
		linearizedFrame.push("<h4>", i, "</h4>");
		linearizedFrame.push("<p id='line", i, "'>");
		var tokens = grammar.concretes[i].tagAndLinearize(abstractTree);
		for (var j = 0, k = tokens.length; j < k; j++) {
			linearizedFrame.push(createLinearized(tokens[j]));
		}
		linearizedFrame.push("</p>");
	}
	linearizedFrame.push("<h4>Abstract</h4>");
	linearizedFrame.push("<p id='lineAbstract'>", createLinearizedFromAbstract(myTree, "0"), "</p>");
	return linearizedFrame.join("");
}

// Creates an HTML representation of a linearization of an abstract tree
function createLinearized(token) {
	var node = getNode(token.tag, myTree);
	var linearized = new Array()
	linearized.push("<span id='", token.tag, "' class=");
	if (node.name.substr(0, selectedNode.length) == selectedNode) {
		linearized.push("'selected'");
	}
	else {
		linearized.push("'normal'");
	}
	if (token == "&-") { linearized.push("<br />"); }
	else { linearized.push(" onclick='nodeClick(\"", node.name, "\");'>&nbsp;", token, " </span>"); }
	return linearized.join("");
}

// Creates an HTML representation of the abstract tree
function createLinearizedFromAbstract(node, path, prec) {
	var linearized = new Array();
	linearized.push("<span id='", path, "' class=");
	if (node.name.substr(0, selectedNode.length) == selectedNode) {
		linearized.push("'selected'");
	}
	else {
		linearized.push("'normal'");
	}
	linearized.push(" onclick='nodeClick(\"", node.name, "\");'>");
	if (node.children.length) { linearized.push(" ("); }
	if (node.cat == "String" || node.cat == "Int" || node.cat == "Float") {
		linearized.push("&nbsp;", node.caption.substring(node.caption.lastIndexOf("_") + 1), "&nbsp;");
	} else {
		linearized.push("&nbsp;", node.caption, "&nbsp;");
	}
	for (var i = 0, j = node.children.length; i < j; i++) {
		linearized.push(createLinearizedFromAbstract(node.children[i], path + "-" + i, 1));
	}
	if (node.children.length) { linearized.push(") "); }
	linearized.push("</span>");
	return linearized.join("");
}

// Expands/Collapses node
function signClick(name, caption) {
	myTree = expandCollapse(myTree, name);
	nodeClick(name);
}

// Sets the "collapsed" property of a given node
function expandCollapse(node, name) {
	if (node.name == name) {
		if (wasCollapsed(node.name)) { removeFromCollapseBuffer(node.name); }
		else { collapseBuffer[collapseBuffer.length] = node.name; }
		node.collapsed ^= true;
	}
	else {
		for (var i = 0, j = node.children.length; i < j; i++) {
			expandCollapse(node.children[i], name);
		}
	}
	return node;
}

// Checks if a node was collapsed on the previous cycle
function wasCollapsed(nodeName) {
	for (var i = 0, j = collapseBuffer.length; i < j; i++) {
		if (nodeName == collapseBuffer[i]) {
			return true;
		}
	}
	return false;
}

// Removes a node from the collapseBuffer array
function removeFromCollapseBuffer(nodeName) {
	var newBuffer = new Array();
	for (var i = 0, j = collapseBuffer.length; i < j; i++) {
		if (nodeName != collapseBuffer[i]) {
			newBuffer[newBuffer.length] = collapseBuffer[i];
		}
	}
	collapseBuffer = newBuffer;
}

// Selects a node
function nodeClick(name) {	
	if ((document.getElementById("actRefine") && document.getElementById("actRefine").className == "selected") ||
		(document.getElementById("actReplace") && document.getElementById("actReplace").className == "selected") ||
		(document.getElementById("actWrap") && document.getElementById("actWrap").className == "selected") ||
		(document.getElementById("actTree") && document.getElementById("actTree").className == "selected")) {
		return; }
	selectedNode = name;
	if (stringAbstractTree) {
		document.getElementById(stringAbstractTree).value = abstractTree.show();
	}
	document.getElementById("actFrame").innerHTML = showActions();
	document.getElementById("refFrame").innerHTML = "";
	document.getElementById("messageFrame").innerHTML = showLanguages();
	document.getElementById(selectedLanguage).className = "selected";
	applyLanguage();
	drawTree();
	drawLinearizedFrame();
}

// Shows the available languages for the editor
function showLanguages() {
	var languages = new Array();
	languages.push("<table class='language' id='languagesTable'>",
					"<tr id='langs' class='language'>",
					"<td class='language' id='EditorDan' title='Label Bulgarian' onclick='clickLanguage(\"\")'>Bulgarian</td>",
					"<td class='language' id='EditorDan' title='Label Danish' onclick='clickLanguage(\"\")'>Danish</td>",
					"<td class='language' id='EditorEng' title='Label English' onclick='clickLanguage(\"EditorEng\")'>English</td>",
					"<td class='language' id='EditorFin' title='Label Finnish' onclick='clickLanguage(\"\")'>Finnish</td>",
					"<td class='language' id='EditorFre' title='Label French' onclick='clickLanguage(\"\")'>French</td>",
					"<td class='language' id='EditorGer' title='Label German' onclick='clickLanguage(\"\")'>German</td>",
					"<td class='language' id='EditorIta' title='Label Italian' onclick='clickLanguage(\"\")'>Italian</td>",
					"<td class='language' id='EditorNor' title='Label Norwegian' onclick='clickLanguage(\"\")'>Norwegian</td>",
					"<td class='language' id='EditorRus' title='Label Russian' onclick='clickLanguage(\"\")'>Russian</td>",
//					"<td class='language' id='EditorSpa' title='Label Spanish' onclick='clickLanguage(\"EditorSpa\")'>Spanish</td>",
					"<td class='language' id='EditorSpa' title='Label Spanish' onclick='clickLanguage(\"\")'>Spanish</td>",
					"<td class='language' id='EditorSwe' title='Label Swedish' onclick='clickLanguage(\"EditorSwe\")'>Swedish</td></tr>",
					"</table>");
	return languages.join("");
}

// Selects the language to use in the editor
function clickLanguage(lang) {
	if (lang) {
		var tdsToClear = document.getElementById("languagesTable").getElementsByTagName("td");
		for (var i = 0, j = tdsToClear.length; i < j; i++) {
			if (tdsToClear[i].className == "selected") { tdsToClear[i].className = "language"; }
		}
		document.getElementById(lang).className = "selected";
		selectedLanguage = lang;
		applyLanguage();
	}
}

// Applies a language to the editor
function applyLanguage() {
	var langsToLinearize = document.getElementById("languagesTable").getElementsByTagName("td");
	for (var i = 0, j = langsToLinearize.length; i < j; i++) {
		var absStr = langsToLinearize[i].getAttribute("title");
		var lin = editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree(absStr, editorGrammar.abstract.startcat));
		if (!langsToLinearize[i].firstChild) {
			var txt = document.createTextNode(lin);
			langsToLinearize[i].appendChild(txt);
		}
		else {
			langsToLinearize[i].firstChild.nodeValue = lin;
		}
	}
	var actionsToLinearize = document.getElementById("actionsTable").getElementsByTagName("td");
	for (var i = 0, j = actionsToLinearize.length; i < j; i++) {
		if (actionsToLinearize[i].getAttribute("class") == "action") {
			var absStr = actionsToLinearize[i].getAttribute("title");
			var lin = editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree(absStr, editorGrammar.abstract.startcat));
			if (!actionsToLinearize[i].firstChild) {
				var txt = document.createTextNode(lin);
				actionsToLinearize[i].appendChild(txt);
			}
			else {
				actionsToLinearize[i].firstChild.nodeValue = lin;
			}
		}
	}
	var messageToLinearize = document.getElementById("refgenRefRandom");
	if (messageToLinearize) {
		messageToLinearize.firstChild.firstChild.nodeValue = editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("RandomlyCommand Select IndefSgDet Refinement", editorGrammar.abstract.startcat));
	}
	var messageToLinearize = document.getElementById("nextRefsNext");
	if (messageToLinearize) {
		messageToLinearize.firstChild.firstChild.nodeValue = editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("CommandAdj Show DefSgDet Next Page", editorGrammar.abstract.startcat));
	}
	messageToLinearize = document.getElementById("nextRefsPrevious");
	if (messageToLinearize) {
		messageToLinearize.firstChild.firstChild.nodeValue = editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("CommandAdj Show DefSgDet Previous Page", editorGrammar.abstract.startcat));
	}
	var messageToLinearize = document.getElementById("nextWrapsNext");
	if (messageToLinearize) {
		messageToLinearize.firstChild.firstChild.nodeValue = editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("CommandAdj Show DefSgDet Next Page", editorGrammar.abstract.startcat));
	}
	messageToLinearize = document.getElementById("nextWrapsPrevious");
	if (messageToLinearize) {
		messageToLinearize.firstChild.firstChild.nodeValue = editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("CommandAdj Show DefSgDet Previous Page", editorGrammar.abstract.startcat));
	}
}

// Shows the available actions for a node
function showActions(caption) {
	var node = getNode(selectedNode, myTree);
	var abstractNode = getNodeFromAbstract(abstractTree, node.name, "0");
	var actions = new Array();
	actions.push("<table class='action' id='actionsTable'>");
	if (undoArray.length) {
		actions.push(createAction("Undo", "action", "SingleWordCommand Undo", "Z")); }
	else { actions.push(createAction("Undo", "unavailable", "SingleWordCommand Undo", "Z")); };
	if (redoArray.length) {
		actions.push(createAction("Redo", "action", "SingleWordCommand Redo", "Y")); }
	else { actions.push(createAction("Redo", "unavailable", "SingleWordCommand Redo", "Y")); }
	if (node.caption == "?") {	
		actions.push(createAction("Cut", "unavailable", "SingleWordCommand Cut", "X"));
		actions.push(createAction("Copy", "unavailable", "SingleWordCommand Copy", "C"));
		var AbsNodeType = abstractNode.type;
		if (clipBoard && (AbsNodeType == grammar.abstract.getCat(clipBoard.name))) {
			actions.push(createAction("Paste", "action", "SingleWordCommand Paste", "V"));
		}
		else { actions.push(createAction("Paste", "unavailable", "SingleWordCommand Paste", "V")); }
		actions.push(createAction("Delete", "unavailable", "SingleWordCommand Delete", "D"));
		actions.push(createAction("Refine", "action", "SingleWordCommand Refine", "R"));
		actions.push(createAction("Replace", "unavailable", "SingleWordCommand Replace", "E"));
		actions.push(createAction("Wrap", "unavailable", "SingleWordCommand Wrap", "W"));
		for (var i in grammar.concretes) {
			if (grammar.concretes[i].parser) {
				actions.push(createAction("Parse", "action", "Command Parse IndefSgDet String_N", "P"));
			} else { actions.push(createAction("Parse", "unavailable", "Command Parse IndefSgDet String_N", "P")); }
			break;
		}
	}
	else if (node.caption) {	
		actions.push(createAction("Cut", "action", "SingleWordCommand Cut", "X"));
		actions.push(createAction("Copy", "action", "SingleWordCommand Copy", "C"));
		actions.push(createAction("Paste", "unavailable", "SingleWordCommand Paste", "V"));
		actions.push(createAction("Delete", "action", "SingleWordCommand Delete", "D"));
		actions.push(createAction("Refine", "unavailable", "SingleWordCommand Refine", "R"));
		actions.push(createAction("Replace", "action", "SingleWordCommand Replace", "E"));
		actions.push(createAction("Wrap", "action", "SingleWordCommand Wrap", "W"));
		actions.push(createAction("Parse", "unavailable", "Command Parse IndefSgDet String_N", "P"));
	}
	if (node && !abstractNode.isComplete()) {	
		actions.push(createAction("RandomNode", "action", "RandomlyCommand Refine DefSgDet Node", "N"));
	}
	else {
		actions.push(createAction("RandomNode", "unavailable", "RandomlyCommand Refine DefSgDet Node", "N"));
	}
	if (!abstractTree.isComplete()) {
		actions.push(createAction("RandomTree", "action", "RandomlyCommand Refine DefSgDet Tree", "T"));
	}
	else {
		actions.push(createAction("RandomTree", "unavailable", "RandomlyCommand Refine DefSgDet Tree", "T"));
	}
	actions.push("</table>");
	return actions.join("");

}

// Creates an action
function createAction(actionName, className, caption, hotKey) {
	return "<tr id='act" + actionName + "' class='" + className +"' onclick='click" +
			actionName + "(\"act" + actionName + "\")'><td class='action' title='" +
			caption + "'>" + caption + "</td><td class='hotKey'>(" + hotKey + ")</td></tr>";
}

// When the "Refine" action is selected, gets the appropriate refinements for a node
function clickRefine(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		pushUndoClearRedo();
		if (selectedNode) {
			refPageCounter = 0;
			var node = getNodeFromAbstract(abstractTree, selectedNode, "0");
			if (node.type == "String" || node.type == "Int" || node.type == "Float") {
				var newType = undefined;
				var newTypeCat = node.type + "_Literal_";
				switch(node.type)
				{
					case "String":
						newType = prompt(editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("Command Enter IndefSgDet String_N", editorGrammar.abstract.startcat)),'String');
						if (!newType) { newType = "AutoString"; }
						break;
					case "Int":
						while (isNaN(newType) || (newType && newType.indexOf(".") != -1)) {
							newType = prompt(editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("Command Enter IndefSgDet Integer_N", editorGrammar.abstract.startcat)),'Int');
						}
						if (!newType) { newType = "8"; }
						break;
					case "Float":
						while (isNaN(newType)) {
							newType = prompt(editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("Command Enter IndefSgDet Float_N", editorGrammar.abstract.startcat)),'Float');
						}
						if (!newType) { newType = "8.0"; }
						if (newType.indexOf(".") == -1) { newType += ".0"; }
						break;
				}
				if (node.type == "String") {
					newTypeCat += "\"" + newType + "\"";
				} else {
					newTypeCat += newType;
				}
				if (!grammar.abstract.types[newTypeCat]) {
					grammar.abstract.addType(newTypeCat, [], node.type);
					for (var i in grammar.concretes) {
						grammar.concretes[i].addRule(newTypeCat, function(cs){ return new Arr(new Str(newType));});
					}
				}
				node.name = newTypeCat;
				abstractTree = insertNode(abstractTree, selectedNode, "0", node);
				document.getElementById("actFrame").innerHTML = showActions();
				document.getElementById("refFrame").innerHTML = "";
				clearHotKeys();
				concludeAction();
			} else {
				document.getElementById("refFrame").innerHTML = showRefinements(selectedNode);
			}
		}
	}
}

// Sets the className of actName to "selected" and grays out the other selections
function highlightSelectedAction(actName) {
	graySelections(actName);
	document.getElementById(actName).className = "selected";
	drawTree();
}

// Grays out all actions except one
function graySelections(except) {
	var refs = document.getElementById("actFrame").getElementsByTagName("tr");
	for (var i = 0, j = refs.length; i < j; i++) {
		if (refs[i].id != except) { refs[i].className = "closed"; }
	}	
}

// Pushes the abstract tree into the undo array and clears the redo array
function pushUndoClearRedo() {
	undoArray.push(new state(selectedNode, abstractTree, collapseBuffer));
	redoArray.length = 0;
}

// Gets the refinements to display
function showRefinements(nodeName) {
//	var refs = getAvailableRefinements(nodeName);
	var refs = getAvailableRefinements(nodeName, abstractTree, grammar);
	var rowsPerPage = 9;
	var pages = Math.floor(refs.length / rowsPerPage);
	var upperLimit;
	if (pages != refPageCounter) { upperLimit = (rowsPerPage * refPageCounter) + rowsPerPage; }
	else { upperLimit = refs.length; }
	var refinements = new Array();
	refinements.push("<table class='refinement'>");
	var keyPos = 0;
	refinements.push(ref_wrapToHtml("ref", "genRefRandom", "refinement", "", keyPos, "RandomlyCommand Select IndefSgDet Refinement"));
	keys["" + keyPos] = mkRefHotKey("genRefRandom");
	keyPos++;
	for (var i = (rowsPerPage * refPageCounter), j = upperLimit; i < j; i++) {	
		refinements.push(ref_wrapToHtml("ref", refs[i], "refinement", "", keyPos, ""));
		keys["" + keyPos] = mkRefHotKey(refs[i]);
		keyPos++;
	}
	if (((refs.length % rowsPerPage == 0) && (pages - 1) > refPageCounter) ||
		((refs.length % rowsPerPage != 0) && pages > refPageCounter) ) {
		refinements.push(ref_wrapNextRefsToHtml("nextRefs", "Next", "refinement", "+", editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("CommandAdj Show DefSgDet Next Page", editorGrammar.abstract.startcat))));
		keys["107"] = mkRefNextRefsHotKey("Next");
	}
	if (0 < refPageCounter) {
		refinements.push(ref_wrapNextRefsToHtml("nextRefs", "Previous", "refinement", "-", editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("CommandAdj Show DefSgDet Previous Page", editorGrammar.abstract.startcat))));
		keys["109"] = mkRefNextRefsHotKey("Previous");
	}
	refinements.push("</table>");
	return refinements.join("");
}

// Creates an HTML representation of a Refinement/Wrap
function ref_wrapToHtml(funct, name, className, arg, hotKeyPos, caption) {
	var ref_wrapHtml = new Array();
	ref_wrapHtml.push("<tr id='", funct, name, "' class=", className, " onclick='", funct, "Click(\"", name, "\"", arg, ")'><td class='", className, "'>");
	if (caption) { ref_wrapHtml.push(editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree(caption, editorGrammar.abstract.startcat))); }
	else { ref_wrapHtml.push(name, "&nbsp;:&nbsp;", refArgsToHtml(name), grammar.abstract.getCat(name)); }
	ref_wrapHtml.push("</td><td class='hotKey'>(", hotKeyPos, ")</td></tr>");
	return ref_wrapHtml.join("");
}

// Creates the function to be used by a "numeric" hot key
function mkRefHotKey(refName) {
	return function() { if (document.getElementById("ref" + refName)) { refClick(refName); } }
}

// Creates an HTML representation of the Next/Previous Refinement/Wrap page
function ref_wrapNextRefsToHtml(funct, name, className, hotKeyPos, caption) {
	var ref_wrapHtml = new Array();
	ref_wrapHtml.push("<tr id='", funct, name, "' class=", className, " onclick='", funct, "Click(\"", name, "\")'><td class='", className, "'>");
	ref_wrapHtml.push(caption);
	ref_wrapHtml.push("</td><td class='hotKey'>(", hotKeyPos, ")</td></tr>");
	return ref_wrapHtml.join("");
}

// Creates the function to be used by a "+"/"-" hot key
function mkRefNextRefsHotKey(refName) {
	return function() { if (document.getElementById("nextRefs" + refName)) { nextRefsClick(refName); } }
}

// Creates a string representation of the arguments of a refinement
function refArgsToHtml(fun) {
	var args = new Array();
	for (var i = 0, j = grammar.abstract.types[fun].args.length; i < j; i++) {
		args.push(grammar.abstract.types[fun].args[i], "&nbsp;->&nbsp;");
	}
	return args.join("");
}

// Gets the type of a meta variable
function getMetaType(absNode, route, currRoute) {
	if (route == currRoute && absNode.isMeta()) {
		return absNode.type;
	}
	else {
		for (var i = 0, j = absNode.args.length; i < j; i++) {
			var found = getMetaType(absNode.args[i], route, currRoute + "-" + i);
			if (found) { return found };
		}
	}
}

// When the "Undo" action is selected, undoes the last action
function clickUndo(actName) {
	if (document.getElementById(actName).className == "action" && undoArray.length) {
		highlightSelectedAction(actName);
		redoArray.push(new state(selectedNode, abstractTree, collapseBuffer));
		var prevState = undoArray.pop();
		selectedNode = prevState.selectedNode;
		abstractTree = grammar.abstract.copyTree(prevState.tree);
		collapseBuffer = prevState.collapseBuffer;
		if (abstractTree.isComplete()) { selectedNode = "0"; }		
		abstractTree = grammar.abstract.annotate(abstractTree, grammar.abstract.startcat);
		myTree = treeFromAbstract(abstractTree, "0");
		nodeClick(selectedNode);
	}
}

// When the "Redo" action is selected, redoes the last action
function clickRedo(actName) {
	if (document.getElementById(actName).className == "action" && redoArray.length) {
		highlightSelectedAction(actName);
		undoArray.push(new state(selectedNode, abstractTree, collapseBuffer));
		var nextState = redoArray.pop();
		selectedNode = nextState.selectedNode;
		abstractTree = grammar.abstract.copyTree(nextState.tree);
		collapseBuffer = nextState.collapseBuffer;
		abstractTree = grammar.abstract.annotate(abstractTree, grammar.abstract.startcat);
		myTree = treeFromAbstract(abstractTree, "0");
		nodeClick(selectedNode);
	}
}

// When the "Copy" action is selected, copies the selected node to the clipboard
function clickCopy(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		if (selectedNode) {	
			clipBoard = grammar.abstract.copyTree(getNodeFromAbstract(abstractTree, selectedNode, "0"));
			document.getElementById("clipboardFrame").innerHTML = clipBoard.name + "&nbsp;:&nbsp;" + grammar.abstract.getCat(clipBoard.name);
			nodeClick(selectedNode);
		}
	}
}

// When the "Cut" action is selected, deletes the selected node and copies it to the clipboard
function clickCut(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		pushUndoClearRedo();
		if (selectedNode) {
			clipBoard = grammar.abstract.copyTree(getNodeFromAbstract(abstractTree, selectedNode, "0"));
			document.getElementById("clipboardFrame").innerHTML = clipBoard.name + "&nbsp;:&nbsp;" + grammar.abstract.getCat(clipBoard.name);
			abstractTree = deleteNode(abstractTree, selectedNode, "0");
			concludeAction();
		}
	}
}

// Annotates the abstract tree, creates a tree from the abstract tree and selects the next meta variable
function concludeAction() {
	abstractTree = grammar.abstract.annotate(abstractTree, grammar.abstract.startcat);
	myTree = treeFromAbstract(abstractTree, "0");
	selectNextMeta();
}

// Selects the next meta variable available
function selectNextMeta() {
	nodeClick(selectedNode);
	if (!abstractTree.isComplete()) {
		var pathToNextMeta = "";
		var nodePos = getNavPos(selectedNode);
		while (1) {
			if (nodePos == navigationControlString.length) { nodePos = 0; }
			var node = getNode(navigationControlString[nodePos], myTree);
			if (node.caption == "?") { pathToNextMeta = node.name; break; }
			nodePos++;
		}
		expandAscendants(pathToNextMeta);
		nodeClick(pathToNextMeta);
	}
}

// Expands the ascendants of a given node
function expandAscendants(nodeName) {
	var nodePath = nodeName.split("-");
	var currAscendant = nodePath.shift();
	while (nodePath.length > 0) {
		var node = getNode(currAscendant, myTree);
		if (node.collapsed) {
			myTree = expandCollapse(myTree, currAscendant);
		}
		currAscendant += "-" + nodePath.shift();
	}
}

// When the "Paste" action is selected, pastes the contents of the clipboard into the selected node
function clickPaste(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		pushUndoClearRedo();
		if (selectedNode) {
			abstractTree = insertNode(abstractTree, selectedNode, "0", grammar.abstract.copyTree(clipBoard));
			concludeAction();
		}
	}
}

// When the "Delete" action is selected, deletes the selected node
function clickDelete(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		pushUndoClearRedo();
		if (selectedNode) {	
			abstractTree = deleteNode(abstractTree, selectedNode, "0");
			abstractTree = grammar.abstract.annotate(abstractTree, grammar.abstract.startcat);
			myTree = treeFromAbstract(abstractTree, "0");
			nodeClick(selectedNode);
		}
	}
}

// When the "Replace" action is selected, replaces the selected node with another refinement
function clickReplace(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		pushUndoClearRedo();
		if (selectedNode) {
			refPageCounter = 0;
			abstractTree = deleteNode(abstractTree, selectedNode, "0");
			abstractTree = grammar.abstract.annotate(abstractTree, grammar.abstract.startcat);
			myTree = treeFromAbstract(abstractTree, "0");
			drawTree();
			document.getElementById("refFrame").innerHTML = showRefinements(selectedNode);
		}
	}
}

// When the "Wrap" action is selected, wraps around the selected node with another refinement
function clickWrap(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		pushUndoClearRedo();
		var node = getNode(selectedNode, myTree);
		if (selectedNode) {
			refPageCounter = 0;
			var wrappers = showWrappers(node.caption);
			document.getElementById("refFrame").innerHTML = wrappers;
			if (wrappers.length <= 31) {
				alert(editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("ErrorMessage Available Wrapper", editorGrammar.abstract.startcat)));
				document.getElementById("actFrame").innerHTML = showActions();
				nodeClick(selectedNode);
			}
		}
	}
}

// Gets the wrappers to display
function showWrappers(nodeCaption) {
	var nodeType = grammar.abstract.types[nodeCaption].cat;
	var rowsPerPage = 10;
//	var availWrappers = getAvailableWrappers(nodeType);
	var availWrappers = getAvailableWrappers(nodeType, grammar, selectedNode);
	var pages = Math.floor(availWrappers.length / rowsPerPage);
	var upperLimit;
	if (pages != refPageCounter) { upperLimit = (rowsPerPage * refPageCounter) + rowsPerPage; }
	else { upperLimit = availWrappers.length; }
	var wrappers = new Array();
	wrappers.push("<table class='wrapper'>");
	var keyPos = 0;
	for (var i = (rowsPerPage * refPageCounter), j = upperLimit; i < j; i++) {	
		wrappers.push(ref_wrapToHtml("wrap", availWrappers[i][0], "wrapper", ", " + availWrappers[i][1], keyPos, ""));
		keys["" + keyPos] = mkWrapHotKey(availWrappers[i][0], availWrappers[i][1]);
		keyPos++;
	}
	if (((availWrappers.length % rowsPerPage == 0) && (pages - 1) > refPageCounter) ||
		((availWrappers.length % rowsPerPage != 0) && pages > refPageCounter) ) {
		wrappers.push(ref_wrapNextRefsToHtml("nextWraps", "Next", "wrapper", "+", editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("CommandAdj Show DefSgDet Next Page", editorGrammar.abstract.startcat))));
		keys["107"] = mkWrapNextRefsHotKey("Next");
	}
	if (0 < refPageCounter) {
		wrappers.push(ref_wrapNextRefsToHtml("nextWraps", "Previous", "wrapper", "-", editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("CommandAdj Show DefSgDet Previous Page", editorGrammar.abstract.startcat))));
		keys["109"] = mkWrapNextRefsHotKey("Previous");
	}
	wrappers.push("</table>");
	return wrappers.join("");
}

// Creates the function to be used by a "numeric" hot key
function mkWrapHotKey(wrapName, argPos) {
	return function() { if (document.getElementById("wrap" + wrapName)) { wrapClick(wrapName, argPos); } }
}

// Creates the function to be used by a "+"/"-" hot key
function mkWrapNextRefsHotKey(wrapName) {
	return function() { if (document.getElementById("nextWraps" + wrapName)) { nextWrapsClick(wrapName); } }
}

// When the "Parse" action is selected, asks the user for a string and parses it
// to generate the subnode
function clickParse(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		var node = getNode(selectedNode, myTree);
		if (selectedNode) {
			refPageCounter = 0;
			parseTrees = undefined;
			var string = prompt(editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("Command Enter IndefSgDet String_N", editorGrammar.abstract.startcat)),'String');
			if (string || string == "") {
				for (var i in grammar.concretes) {	
					parseTrees = grammar.concretes[i].parser.parseString(string, node.cat);
					if (parseTrees.length == 1) {
						pushUndoClearRedo();
						abstractTree = insertNode(abstractTree, selectedNode, "0", grammar.abstract.copyTree(grammar.abstract.handleLiterals(parseTrees[0], node.cat)));
						document.getElementById("actFrame").innerHTML = showActions();
						document.getElementById("refFrame").innerHTML = "";
						clearHotKeys();
						concludeAction();
						return false;
					} else if (parseTrees.length > 1) {
						document.getElementById("refFrame").innerHTML = showTrees();
						return false;
					}
				}
			} else { nodeClick(selectedNode); return false; }
			alert(editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("ErrorMessage Available Tree", editorGrammar.abstract.startcat)));
		}
		nodeClick(selectedNode);
	}
}

// Displays the parse trees in the refinements panel
function showTrees() {
	var rowsPerPage = 10;
	var pages = Math.floor(parseTrees.length / rowsPerPage);
	var upperLimit;
	if (pages != refPageCounter) { upperLimit = (rowsPerPage * refPageCounter) + rowsPerPage; }
	else { upperLimit = parseTrees.length; }
	var htmlTrees = new Array();
	htmlTrees.push("<table class='tree'>");
	var keyPos = 0;
	for (var i = (rowsPerPage * refPageCounter), j = upperLimit; i < j; i++) {	
		htmlTrees.push(treeToHtml(i, keyPos, ""));
		keys["" + keyPos] = mkTreeHotKey(i, keyPos);
		keyPos++;
	}
	if (((parseTrees.length % rowsPerPage == 0) && (pages - 1) > refPageCounter) ||
		((parseTrees.length % rowsPerPage != 0) && pages > refPageCounter) ) {
		htmlTrees.push(ref_wrapNextRefsToHtml("nextTrees", "Next", "tree", "+", editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("CommandAdj Show DefSgDet Next Page", editorGrammar.abstract.startcat))));
		keys["107"] = mkTreeNextRefsHotKey("Next");
	}
	if (refPageCounter > 0) {
		htmlTrees.push(ref_wrapNextRefsToHtml("nextTrees", "Previous", "tree", "-", editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree("CommandAdj Show DefSgDet Previous Page", editorGrammar.abstract.startcat))));
		keys["109"] = mkTreeNextRefsHotKey("Previous");
	}
	htmlTrees.push("</table>");
	return htmlTrees.join("");
}

// Creates an HTML representation of a parse Tree to be shown in the refinements panel
function treeToHtml(i, hotKeyPos, caption) {
	var htmlTree = new Array();
	htmlTree.push("<tr id='tree", hotKeyPos, "' class='tree' onclick='treeClick(", i, ")'><td class='tree'>");
	if (caption) { htmlTree.push(editorGrammar.concretes[selectedLanguage].linearize(editorGrammar.abstract.parseTree(caption, editorGrammar.abstract.startcat))); }
	else { htmlTree.push(parseTrees[i].show()); }
	htmlTree.push("</td><td class='hotKey'>(", hotKeyPos, ")</td></tr>");
	return htmlTree.join("");
}

// Creates the function to be used by a "numeric" hot key
function mkTreeHotKey(i, keyPos) {
	return function() { if (document.getElementById("tree" + keyPos)) { treeClick(i); } }
}

// Creates the function to be used by a "+"/"-" hot key
function mkTreeNextRefsHotKey(treeName) {
	return function() { if (document.getElementById("nextTrees" + treeName)) { nextTreesClick(treeName); } }
}


// When the "RandomNode" action is selected, refines the node at random
function clickRandomNode(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		pushUndoClearRedo();
		if (selectedNode) {
			var tempTree = grammar.abstract.copyTree(abstractTree);
			abstractTree = insertNode(tempTree, selectedNode, "0", grammar.abstract.copyTree(fillSubTree(grammar.abstract.copyTree(getNodeFromAbstract(abstractTree, selectedNode, "0")), grammar)));
			concludeAction();
		}
	}
}

// When the "RandomTree" action is selected, refines the tree at random
function clickRandomTree(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		pushUndoClearRedo();
		abstractTree = grammar.abstract.copyTree(fillSubTree(abstractTree, grammar));
		concludeAction();
	}
}

// If a node is selected and is of type meta, it refines the node with a type refName
function refClick(refName) {
	if (selectedNode) {
		if (refName == "genRefRandom") {
//			var refs = getAvailableRefinements(selectedNode);
			var refs = getAvailableRefinements(selectedNode, abstractTree, grammar);
			refName = refs[Math.floor(refs.length * Math.random())];
		}
		abstractTree = refineAbstractTree(abstractTree, selectedNode, "0", refName);
		document.getElementById("actFrame").innerHTML = showActions();
		document.getElementById("refFrame").innerHTML = "";
		clearHotKeys();
		concludeAction();
	}
}

// Creates a tree from an abstract tree
function treeFromAbstract(abstractNode, name) {
	var node = new treeNode(name, abstractNode.name);
	if (node.caption == "?") {
		node.cat = abstractNode.type; }
	else {
		if (grammar.abstract.types[node.caption]) {
			node.cat = grammar.abstract.getCat(node.caption);
		} else {
			node.cat = node.caption.substring(0, node.caption.indexOf("_"));
			grammar.abstract.addType(node.caption, [], node.cat);
			var linStr = undefined;
			if (node.cat == "String") {
				linStr = node.caption.substring(node.caption.indexOf("\"") + 1, node.caption.length - 1);
			} else {
				linStr = node.caption.substring(node.caption.lastIndexOf("_") + 1)				
			}
			for (var i in grammar.concretes) {
				grammar.concretes[i].addRule(node.caption, function(cs){ return new Arr(new Str(linStr));});
			}
		}
	}
	if (wasCollapsed(node.name)) { node.collapsed = true; }
	for (var i = 0, j = abstractNode.args.length; i < j; i++) {
		node.addChild(i, treeFromAbstract(abstractNode.args[i], name + "-" + i));
	}
	return node
}

// Wraps a refinement around a node
function wrapClick(wrapName, argPos) {
	if (selectedNode) {
		var tempNode = createRefinement(wrapName);
		tempNode.setArg(argPos, grammar.abstract.copyTree(getNodeFromAbstract(abstractTree, selectedNode, "0")));
		abstractTree = insertNode(abstractTree, selectedNode, "0", tempNode);
		var cat = grammar.abstract.getCat(tempNode.name);
		if (selectedNode == "0" && cat != grammar.abstract.startcat) {
			grammar.abstract.startcat = cat;
		}
		document.getElementById("actFrame").innerHTML = showActions();
		document.getElementById("refFrame").innerHTML = "";
		clearHotKeys();
		concludeAction();
	}
}

// Wraps a refinement around a node
function treeClick(i) {
	if (selectedNode) {
		pushUndoClearRedo();
		var node = getNode(selectedNode, myTree);
		var tempNode = grammar.abstract.copyTree(grammar.abstract.handleLiterals(parseTrees[i], node.cat));
		abstractTree = insertNode(abstractTree, selectedNode, "0", tempNode);
		document.getElementById("actFrame").innerHTML = showActions();
		document.getElementById("refFrame").innerHTML = "";
		clearHotKeys();
		concludeAction();
	}
}

// Handler for the escape key
function clickEsc() {
	if ((document.getElementById("actRefine").className == "selected" ||
		document.getElementById("actReplace").className == "selected" ||
		document.getElementById("actWrap").className == "selected" ||
		document.getElementById("actParse").className == "selected") && undoArray.length) {
		var prevState = undoArray.pop();
		selectedNode = prevState.selectedNode;
		abstractTree = grammar.abstract.copyTree(prevState.tree);
		collapseBuffer = prevState.collapseBuffer;
		abstractTree = grammar.abstract.annotate(abstractTree, grammar.abstract.startcat);
		myTree = treeFromAbstract(abstractTree, "0");
		document.getElementById("actFrame").innerHTML = showActions();
		if (selectedNode) { nodeClick(selectedNode) }
	}
}

// If there are over ten refinements available shows only the selected nine
function nextRefsClick(refName) {
	if (refName == "Next") { refPageCounter++; } else { refPageCounter--; }
	clearHotKeys();
	document.getElementById("refFrame").innerHTML = showRefinements(selectedNode);
}

// If there are over ten wrappers available shows only the selected nine
function nextWrapsClick(wrapName) {
	if (wrapName == "Next") { refPageCounter++; } else { refPageCounter--; }
	clearHotKeys();
	var node = getNode(selectedNode, myTree);
	document.getElementById("refFrame").innerHTML = showWrappers(node.caption);
}

// If there are over ten parse trees available shows only the selected nine
function nextTreesClick(treeName) {
	if (treeName == "Next") { refPageCounter++; } else { refPageCounter--; }
	clearHotKeys();
	document.getElementById("refFrame").innerHTML = showTrees();
}

/* -------------------------------------------------------------------------- */
/* ----------  GUI independent functions to handle syntax editing ----------  */
/* -------------------------------------------------------------------------- */

// Gets the node rooted at the indicated path (route) in the tree absNode
function getNodeFromAbstract(absNode, route, currRoute) {
	if (route == currRoute) {
		return absNode;
	}
	else {
		for (var i = 0, j = absNode.args.length; i < j; i++) {
			var found = getNodeFromAbstract(absNode.args[i], route, currRoute + "-" + i);
			if (found) { return found; }
		}
	}
}

// Gets the first metavariable from the abstract tree rooted at the path route
function getNextMetaFromAbstract(node, route) {
	if (node.isMeta()) { return route; }
	for (var i = 0, j = node.args.length; i < j; i++) {
		var found = getNextMetaFromAbstract(node.args[i], route + "-" + i);
		if (found) { return found; }
	}
}

// Inserts the node into the abstract tree absNode at the path route
function insertNode(absNode, route, currRoute, node) {
	if (route == currRoute) {
		return node;
	}
	else {
		for (var i = 0, j = absNode.args.length; i < j; i++) {
			absNode.setArg(i, insertNode(absNode.args[i], route, currRoute + "-" + i, node));
		}
		return absNode;
	}
}

// Deletes the node rooted at the path route from the abstract tree absNode
function deleteNode(absNode, route, currRoute) {
	if (route == currRoute) {
		return new Fun("?");
	}
	else {
		for (var i = 0, j = absNode.args.length; i < j; i++) {
			absNode.setArg(i, deleteNode(absNode.args[i], route, currRoute + "-" + i));
		}
		return absNode;
	}
}

// Gets the available refinements for the node nodeName, which is in the tree
// abstractTree, from those found in the grammar.
function getAvailableRefinements(nodeName, abstractTree, grammar) {
	var node = getNodeFromAbstract(abstractTree, nodeName, "0");
	var metaType = node.type;
	var refinements = new Array();
	for (var fun in grammar.abstract.types) {
		if (grammar.abstract.types[fun].cat == metaType) {
			refinements[refinements.length] = fun;
		}
	}
	return refinements;
}

// It refines the node rooted at the path route in the abstract tree absNode
// with the refinement refName. Returns the refined abstract tree.
function refineAbstractTree(absNode, route, currRoute, refName) {
	if (route == currRoute && absNode.isMeta()) {
		return createRefinement(refName);
	}
	else {
		for (var i = 0, j = absNode.args.length; i < j; i++) {
			absNode.setArg(i, refineAbstractTree(absNode.args[i], route, currRoute + "-" + i, refName));
		}
		return absNode;
	}
}

// Creates a node of type refName object with the appropriate number of arguments
function createRefinement(refName) {
	var newRef = new Fun(refName);
	for (var i = 0, j = grammar.abstract.types[refName].args.length; i < j; i++) {
		newRef.setArg(i, new Fun("?"));
	}
	return newRef;
}

// Gets the available wrappers for a node of type nodeType found in the grammar
function getAvailableWrappers(nodeType, grammar, top) {
	var wrappers = new Array();
	for (var fun in grammar.abstract.types) {
		for (var i = 0, j = grammar.abstract.types[fun].args.length; i < j; i++) {
			if (top != "0") {
				if (grammar.abstract.types[fun].args[i] == nodeType && grammar.abstract.types[fun].cat == nodeType) {
					wrappers[wrappers.length] = new Array(fun, i);
					break;
				}
			} else {
				if (grammar.abstract.types[fun].args[i] == nodeType) {
					wrappers[wrappers.length] = new Array(fun, i);
					break;
				}
			}
		}
	}
	return wrappers;
}

// Instantiates metavariables found in the tree abstractTree with refinements
// selected at random from those found in the grammar
function fillSubTree(abstractTree, grammar) {
	while (!abstractTree.isComplete()) {
		var nodeToRefine = getNextMetaFromAbstract(abstractTree, "0");
		if (nodeToRefine) {
			var refs = getAvailableRefinements(nodeToRefine, abstractTree, grammar);
			if (refs.length == 0) {
				var node = getNodeFromAbstract(abstractTree, nodeToRefine, "0");
				if (node.type == "String" || node.type == "Int" || node.type == "Float") {
					var newType = undefined;
					var newTypeCat = node.type + "_Literal_";
					switch(node.type)
					{
						case "String":
							newType = "AutoString";
							break;
						case "Int":
							newType = "8";
							break;
						case "Float":
							newType = "8.0";
							break;
					}
					if (node.type == "String") {
						newTypeCat += "\"" + newType + "\"";
					} else {
						newTypeCat += newType;
					}
					if (!grammar.abstract.types[newTypeCat]) {
						grammar.abstract.addType(newTypeCat, [], node.type);
						for (var i in grammar.concretes) {
							grammar.concretes[i].addRule(newTypeCat, function(cs){ return new Arr(new Str(newType));});
						}
					}
					node.name = newTypeCat;
					abstractTree = insertNode(abstractTree, nodeToRefine, "0", node);
					abstractTree = grammar.abstract.annotate(abstractTree, grammar.abstract.startcat);
				}
			}
			else {
				var selectedRef = refs[Math.floor(refs.length * Math.random())];
				abstractTree = refineAbstractTree(abstractTree, nodeToRefine, "0", selectedRef);
				abstractTree = grammar.abstract.annotate(abstractTree, grammar.abstract.startcat);
			}
		}
	}
	return abstractTree;
}
