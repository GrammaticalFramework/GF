
//Variable and Constant definitions

var expColImg = new Array(2);
expColImg[0]     = new Image(12,12);
expColImg[0].src = "minus.png";
expColImg[1]     = new Image(12,12);
expColImg[1].src = "plus.png";

var selectedNode = "";
var collapseBuffer = new Array();
var abstractTree = new Fun ("?");

var navigationControlString = new Array();
var undoArray = new Array();
var redoArray = new Array();
var clipBoard;
var refPageCounter = 0;

var stringAbstractTree = undefined;

var myTree = treeFromAbstract(myAbstract.annotate(abstractTree, myAbstract.startcat), "0");

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
keys ["N"] = function() { clickRandomNode('actRandomNode'); };
keys ["T"] = function() { clickRandomTree('actRandomTree'); };
keys ["%"] = function() { leftArrowKey(); };
keys ["&"] = function() { upDownArrowKey(-1); };
keys ["'"] = function() { rightArrowKey(); };
keys ["("] = function() { upDownArrowKey( 1); };
keys ["27"] = function() { clickEsc(); };

function state(selectedNode, tree, collapseBuffer) {
	this.selectedNode = selectedNode;
	this.tree = myAbstract.copyTree(tree);
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

// Generates a tree from the abstract tree contained in the element "stringTree"
function parseStringTree(elementToParse) {
	stringAbstractTree = elementToParse;
	abstractTree = myAbstract.parseTree(document.getElementById(elementToParse).value, myAbstract.startcat);
	myTree = treeFromAbstract(myAbstract.annotate(abstractTree, myAbstract.startcat), "0");
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
	var htmlTree = "";
	htmlTree += "<li>";
	if (tree.hasChildren()) {	
		htmlTree +=	"<img class='tree-menu'";
		if (tree.collapsed) {
			htmlTree += " src='plus.png'";
		}
		else { htmlTree += " src='minus.png'"; }
		htmlTree += " onclick='signClick(\"" + tree.name + "\", \"" + tree.caption + "\")' />";
	}
	else {
		htmlTree +=	"<img class='tree-menu' src='empty.png' />";
	}
	htmlTree += "<a id='link" + tree.name + "'";
	if (document.getElementById("actRefine").className == "selected" ||
		document.getElementById("actReplace").className == "selected" ||
		document.getElementById("actWrap").className == "selected") {
		htmlTree += "class='treeGray' "; }
	else if (selectedNode == tree.name) { htmlTree += "class='treeSelected' "; }
	else { htmlTree += "class='tree' "; }
	htmlTree += "href='' onclick='nodeClick(\"" + tree.name + "\"); return false'>" + overl(tree.caption) +
				"&nbsp;:&nbsp;" + tree.cat + "</a></li><ul>";
	if (tree.hasChildren() && !tree.collapsed) {
		for (var i = 0, j = tree.children.length; i < j; i++) {
			htmlTree += getTree(tree.children[i], level + 1);
		}
	}
	htmlTree += "</ul>";
	return htmlTree;
}

// Linearizes and displays the abstract tree
function drawLinearizedFrame() {
	var frame = document.getElementById("conFrame");
	frame.innerHTML = getLinearizedFrame();
}

// Linearizes the abstract tree and returns it in HTML form
function getLinearizedFrame() {
	var linearizedFrame = "";
	for (var i = 0; i < myConcrete.length; i++) {	
	  //		linearizedFrame += "<h4>" + myConcrete[i].concreteSyntaxName + "</h4>";
		linearizedFrame += "<p id='line" + myConcrete[i].concreteSyntaxName +"'>";
		var tokens = myConcrete[i].concreteSyntax.tagAndLinearize(abstractTree);
		for (var j = 0, k = tokens.length; j < k; j++) {
			linearizedFrame += createLinearized(tokens[j]);
		}
		linearizedFrame += "</p>";
	}
	linearizedFrame += abstractTree.printOverl();

	return linearizedFrame;
}

// Creates an HTML representation of a linearization of an abstract tree
function createLinearized(token) {
	var node = getNode(token.tag, myTree);
	var linearized = "<span id='" + token.tag + "' class=";
	if (node.name.substr(0, selectedNode.length) == selectedNode) {
		linearized += "'selected'";
	}
	else {
		linearized += "'normal'";
	}
	if (token == "&-") { linearized += "<br />"; }
	else { linearized += " onclick='nodeClick(\"" + node.name + "\");'>&nbsp;" + token + " </span>"; }
	return linearized;
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
		(document.getElementById("actWrap") && document.getElementById("actWrap").className == "selected")) {
		return; }
	selectedNode = name;
	if (stringAbstractTree) {
		document.getElementById(stringAbstractTree).value = abstractTree.show();
	}
	document.getElementById("actFrame").innerHTML = showActions();
	document.getElementById("refFrame").innerHTML = "";
	drawTree();
	drawLinearizedFrame();
}

// Shows the available actions for a node
function showActions(caption) {
	var node = getNode(selectedNode, myTree);
	var abstractNode = getNodeFromAbstract(abstractTree, node.name, "0");
	var actions = "<table class='action'>";
	if (undoArray.length) {
		actions += createAction("Undo", "action", "Undo", "Z"); }
	else { actions += createAction("Undo", "unavailable", "Undo", "Z"); };
	if (redoArray.length) {
		actions += createAction("Redo", "action", "Redo", "Y"); }
	else { actions += createAction("Redo", "unavailable", "Redo", "Y"); }
	if (node.caption == "?") {	
		actions += createAction("Cut", "unavailable", "Cut", "X");
		actions += createAction("Copy", "unavailable", "Copy", "C");
		var AbsNodeType = abstractNode.type;
		if (clipBoard && (AbsNodeType == myAbstract.getCat(clipBoard.name))) {
			actions += createAction("Paste", "action", "Paste", "V");
		}
		else { actions += createAction("Paste", "unavailable", "Paste", "V"); }
		actions += createAction("Delete", "unavailable", "Delete", "D");
		actions += createAction("Refine", "action", "Refine", "R");
		actions += createAction("Replace", "unavailable", "Replace", "E");
		actions += createAction("Wrap", "unavailable", "Wrap", "W")
	}
	else if (node.caption) {	
		actions += createAction("Cut", "action", "Cut", "X");
		actions += createAction("Copy", "action", "Copy", "C");
		actions += createAction("Paste", "unavailable", "Paste", "V");
		actions += createAction("Delete", "action", "Delete", "D");
		actions += createAction("Refine", "unavailable", "Refine", "R");
		actions += createAction("Replace", "action", "Replace", "E");
		actions += createAction("Wrap", "action", "Wrap", "W")
	}
	if (node && !abstractNode.isComplete()) {	
		actions += createAction("RandomNode", "action", "Fill out the node at random", "N");
	}
	else {
		actions += createAction("RandomNode", "unavailable", "Fill out the node at random", "N");
	}
	if (!abstractTree.isComplete()) {
		actions += createAction("RandomTree", "action", "Fill out the tree at random", "T");
	}
	else {
		actions += createAction("RandomTree", "unavailable", "Fill out the tree at random", "T");
	}
	actions += "</table>";
	return actions;
}

// Gets a node from the abstract tree
function getNodeFromAbstract(absNode, route, currRoute) {
	if (route == currRoute) {
		return absNode;
	}
	else {
		for (var i = 0, j = absNode.args.length; i < j; i++) {
			var found = getNodeFromAbstract(absNode.args[i], route, currRoute + "-" + i);
			if (found) { return found }
		}
	}
}

// Creates an action
function createAction(actionName, className, caption, hotKey) {
	return "<tr id='act" + actionName + "' class='" + className +"' onclick='click" +
			actionName + "(\"act" + actionName + "\")'><td class='action'>" + caption + 
			"</td><td class='hotKey'>(" + hotKey + ")</td></tr>";
}

// When the "Refine" action is selected, gets the appropriate refinements for a node
function clickRefine(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		pushUndoClearRedo();
		if (selectedNode) {
			refPageCounter = 0;
			var node = getNodeFromAbstract(abstractTree, selectedNode, "0");
			if (node.type == "String") {
				var newType = prompt('Enter a String','String');
				if (!newType) { newType = "AutoString" }
				myAbstract.addType(newType,[], "String");
				for (var i = 0, j = myConcrete.length; i < j; i++) {
					myConcrete[i].concreteSyntax.addRule(newType, function(cs){ return new Arr(new Str(newType));});
				}
				node.name = newType;
				abstractTree = insertNode(abstractTree, selectedNode, "0", node);
				document.getElementById("actFrame").innerHTML = showActions();
				document.getElementById("refFrame").innerHTML = "";
				clearHotKeys();
				concludeAction();
			}
			else {
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
	var refs = getAvailableRefinements(nodeName);
	var pages = 0;
	if (refs.length > 9) { pages = Math.floor(refs.length / 9); }
	var upperLimit;
	if (pages != refPageCounter) { upperLimit = (9 * refPageCounter) + 9; }
	else { upperLimit = refs.length; }
	var refinements = "<table class='refinement'>";
	var keyPos = 0;
	refinements += ref_wrapToHtml("ref", "genRefRandom", "refinement", "", keyPos, "Choose at random");
	keys["" + keyPos] = mkRefHotKey("genRefRandom");
	keyPos++;
	for (var i = (9 * refPageCounter), j = upperLimit; i < j; i++) {	
		refinements += ref_wrapToHtml("ref", refs[i], "refinement", "", keyPos, "");
		keys["" + keyPos] = mkRefHotKey(refs[i]);
		keyPos++;
	}
	if (pages > refPageCounter) {
		refinements += ref_wrapNextRefsToHtml("nextRefs", "Next", "refinement", "+", "Next Refinements");
		keys["107"] = mkRefNextRefsHotKey("Next");
	}
	if (0 < refPageCounter) {
		refinements += ref_wrapNextRefsToHtml("nextRefs", "Previous", "refinement", "-", "Previous Refinements");
		keys["109"] = mkRefNextRefsHotKey("Previous");
	}
	refinements += "</table>";
	return refinements;
}

// Gets the available refinements for a node
function getAvailableRefinements(nodeName) {
	var node = getNodeFromAbstract(abstractTree, nodeName, "0");
	var metaType = node.type;
	var refinements = new Array();
	for (var fun in myAbstract.types) {
		if (myAbstract.types[fun].cat == metaType) {
			refinements[refinements.length] = fun;
		}
	}
	return refinements;
}

// Creates an HTML representation of a Refinement/Wrap
function ref_wrapToHtml(funct, name, className, arg, hotKeyPos, caption) {
	var ref_wrapHtml = "<tr id='" + funct + name + "' class=" + className + " onclick='" + funct +
						"Click(\"" + name + "\"" + arg + ")'><td class='" + className + "'>";
	if (caption) { ref_wrapHtml += caption; }
	else { ref_wrapHtml += overl(name) + "&nbsp;:&nbsp;" + refArgsToHtml(name) + myAbstract.getCat(name); }
	ref_wrapHtml += "</td><td class='hotKey'>(" + hotKeyPos + ")</td></tr>";
	return ref_wrapHtml
}


// Creates the function to be used by a "numeric" hot key
function mkRefHotKey(refName) {
	return function() { if (document.getElementById("ref" + refName)) { refClick(refName); } }
}

// Creates an HTML representation of a Refinement/Wrap
function ref_wrapNextRefsToHtml(funct, name, className, hotKeyPos, caption) {
	var ref_wrapHtml = "<tr id='" + funct + name + "' class=" + className + " onclick='" + funct +
						"Click(\"" + name + "\")'><td class='" + className + "'>";
	ref_wrapHtml += caption;
	ref_wrapHtml += "</td><td class='hotKey'>(" + hotKeyPos + ")</td></tr>";
	return ref_wrapHtml
}

// Creates the function to be used by a "+" hot key
function mkRefNextRefsHotKey(refName) {
	return function() { if (document.getElementById("nextRefs" + refName)) { nextRefsClick(refName); } }
}

// Creates a string representation of the arguments of a refinement
function refArgsToHtml(fun) {
	var args = "";
	for (var i = 0, j = myAbstract.types[fun].args.length; i < j; i++) {
		args += myAbstract.types[fun].args[i] + "&nbsp;->&nbsp;";
	}
	return args;
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
		abstractTree = myAbstract.copyTree(prevState.tree);
		collapseBuffer = prevState.collapseBuffer;
		if (abstractTree.isComplete()) { selectedNode = "0"; }		
		abstractTree = myAbstract.annotate(abstractTree, myAbstract.startcat);
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
		abstractTree = myAbstract.copyTree(nextState.tree);
		collapseBuffer = nextState.collapseBuffer;
		abstractTree = myAbstract.annotate(abstractTree, myAbstract.startcat);
		myTree = treeFromAbstract(abstractTree, "0");
		nodeClick(selectedNode);
	}
}

// When the "Copy" action is selected, copies the selected node to the clipboard
function clickCopy(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		if (selectedNode) {	
			clipBoard = myAbstract.copyTree(getNodeFromAbstract(abstractTree, selectedNode, "0"));
			document.getElementById("clipboardFrame").innerHTML = clipBoard.name + "&nbsp;:&nbsp;" +
																	myAbstract.getCat(clipBoard.name);
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
			clipBoard = myAbstract.copyTree(getNodeFromAbstract(abstractTree, selectedNode, "0"));
			document.getElementById("clipboardFrame").innerHTML = clipBoard.name + "&nbsp;:&nbsp;" +
																	myAbstract.getCat(clipBoard.name);
			abstractTree = deleteNode(abstractTree, selectedNode, "0");
			concludeAction();
		}
	}
}

// Annotates the abstract tree, creates a tree from the abstract tree and selects the next meta variable
function concludeAction() {
	abstractTree = myAbstract.annotate(abstractTree, myAbstract.startcat);
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

// Gets the first meta variable from an abstract tree
function getNextMetaFromAbstract(node, route) {
	if (node.isMeta()) { return route; }
	for (var i = 0, j = node.args.length; i < j; i++) {
		var found = getNextMetaFromAbstract(node.args[i], route + "-" + i);
		if (found) { return found; }
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
			abstractTree = insertNode(abstractTree, selectedNode, "0", myAbstract.copyTree(clipBoard));
			concludeAction();
		}
	}
}

// Inserts a node into a tree
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

// When the "Delete" action is selected, deletes the selected node
function clickDelete(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		pushUndoClearRedo();
		if (selectedNode) {	
			abstractTree = deleteNode(abstractTree, selectedNode, "0");
			abstractTree = myAbstract.annotate(abstractTree, myAbstract.startcat);
			myTree = treeFromAbstract(abstractTree, "0");
			nodeClick(selectedNode);
		}
	}
}

// Deletes a node from a tree
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

// When the "Replace" action is selected, replaces the selected node with another refinement
function clickReplace(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		pushUndoClearRedo();
		if (selectedNode) {
			abstractTree = deleteNode(abstractTree, selectedNode, "0");
			abstractTree = myAbstract.annotate(abstractTree, myAbstract.startcat);
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
			var wrappers = getWrappers(node.caption);
			document.getElementById("refFrame").innerHTML = wrappers;
			if (wrappers.length <= 31) {
				alert("No wrappers available");
				document.getElementById("actFrame").innerHTML = showActions();
				nodeClick(selectedNode);
			}
		}
	}
}

// Gets the wrappers to display
function getWrappers(nodeCaption) {
	var nodeType = myAbstract.types[nodeCaption].cat;
	var availWrappers = getAvailableWrappers(nodeType);
	var pages = Math.floor(availWrappers.length / 9);
	var upperLimit;
	if (pages != refPageCounter) { upperLimit = (9 * refPageCounter) + 9; }
	else { upperLimit = availWrappers.length - (9 * refPageCounter); }
	var wrappers = "<table class='wrapper'>";
	var keyPos = 0;
	for (var i = (9 * refPageCounter), j = (9 * refPageCounter) + upperLimit; i < j; i++) {	
		wrappers += ref_wrapToHtml("wrap", availWrappers[i][0], "wrapper", ", " + availWrappers[i][1], keyPos, "");
		keys["" + keyPos] = mkWrapHotKey(availWrappers[i][0], availWrappers[i][1]);
		keyPos++;
	}
	if (pages > (9 * refPageCounter)) {
		refinements += ref_wrapNextRefsToHtml("nextWraps", "Next", "wrapper", "+", "Next Wrappers");
		keys["107"] = mkWrapNextRefsHotKey("Next");
	}
	if (0 < (9 * refPageCounter)) {
		refinements += ref_wrapNextRefsToHtml("nextWraps", "Previous", "wrapper", "-", "Previous Wrappers");
		keys["109"] = mkWrapNextRefsHotKey("Previous");
	}
	wrappers += "</table>";
	return wrappers;
}

// Gets the available wrappers for a node
function getAvailableWrappers(nodeType) {
	var wrappers = new Array();
	for (var fun in myAbstract.types) {
		for (var i = 0, j = myAbstract.types[fun].args.length; i < j; i++) {
			if (myAbstract.types[fun].args[i] == nodeType && myAbstract.types[fun].cat == nodeType) {
				wrappers[wrappers.length] = new Array(fun, i);
				break;
			}
		}
	}
	return wrappers;
}

// Creates the function to be used by a "numeric" hot key
function mkWrapHotKey(refName, argPos) {
	return function() { if (document.getElementById("wrap" + refName)) { wrapClick(refName, argPos); } }
}

// Creates the function to be used by a "-" hot key
function mkWrapNextRefsHotKey(refName) {
	return function() { if (document.getElementById("nextWraps" + refName)) { nextRefsClick(refName); } }
}

// When the "RandomNode" action is selected, refines the node at random
function clickRandomNode(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		pushUndoClearRedo();
		if (selectedNode) {
			var tempTree = myAbstract.copyTree(abstractTree);
			abstractTree = myAbstract.copyTree(getNodeFromAbstract(abstractTree, selectedNode, "0"));
			fillSubTree()
			abstractTree = insertNode(tempTree, selectedNode, "0", myAbstract.copyTree(abstractTree));
			concludeAction();
		}
	}
}

// Refines the sub tree
function fillSubTree() {
	while (!abstractTree.isComplete()) {
		var nodeToRefine = getNextMetaFromAbstract(abstractTree, "0");
		if (nodeToRefine) {
			var refs = getAvailableRefinements(nodeToRefine);
// FIX THIS ASAP!!!!
			if (refs.length == 0) {
				var node = getNodeFromAbstract(abstractTree, nodeToRefine, "0");
				if (node.type == "String") {
					var newType = "AutoString";
					myAbstract.addType(newType,[], "String");
					for (var i = 0, j = myConcrete.length; i < j; i++) {
						myConcrete[i].concreteSyntax.addRule(newType, function(cs){ return new Arr(new Str(newType));});
					}
					node.name = newType;
					abstractTree = insertNode(abstractTree, nodeToRefine, "0", node);
					abstractTree = myAbstract.annotate(abstractTree, myAbstract.startcat);
				}
			}
			else {
				var selectedRef = refs[Math.floor(refs.length * Math.random())];
				abstractTree = refineAbstractTree(abstractTree, nodeToRefine, "0", selectedRef);
				abstractTree = myAbstract.annotate(abstractTree, myAbstract.startcat);
			}
/*
			var selectedRef = refs[Math.floor(refs.length * Math.random())];
			abstractTree = refineAbstractTree(abstractTree, nodeToRefine, "0", selectedRef);
			abstractTree = myAbstract.annotate(abstractTree, myAbstract.startcat);
*/
		}
	}
}

// When the "RandomTree" action is selected, refines the tree at random
function clickRandomTree(actName) {
	if (document.getElementById(actName).className == "action") {
		highlightSelectedAction(actName);
		pushUndoClearRedo();
		fillSubTree();
		concludeAction();
	}
}

// If a node is selected and is of type meta, it refines the node with a type refName
function refClick(refName) {
	if (selectedNode) {
		if (refName == "genRefRandom") {
			var refs = getAvailableRefinements(selectedNode);
			refName = refs[Math.floor(refs.length * Math.random())];
		}
		abstractTree = refineAbstractTree(abstractTree, selectedNode, "0", refName);
		document.getElementById("actFrame").innerHTML = showActions();
		document.getElementById("refFrame").innerHTML = "";
		clearHotKeys();
		concludeAction();
	}
}

// If a refinement is selected, a node has the property "selected" set and the node is a meta variable,
// it refines node. Returns the refined abstract tree
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

// Creates a Fun of type refName object with the appropriate number of meta arguments
function createRefinement(refName) {
	var newRef = new Fun(refName);
	for (var i = 0, j = myAbstract.types[refName].args.length; i < j; i++) {
		newRef.setArg(i, new Fun("?"));
	}
	return newRef;
}

// Creates a tree from an abstract tree
function treeFromAbstract(abstractNode, name) {
  var node = new treeNode(name, abstractNode.name);
	if (node.caption == "?") {
		node.cat = abstractNode.type; }
	else { node.cat = myAbstract.getCat(node.caption); }
	if (wasCollapsed(node.name)) { node.collapsed = true; }
	for (var i = 0, j = abstractNode.args.length; i < j; i++) {
		node.addChild(i, treeFromAbstract(abstractNode.args[i], name + "-" + i));
	}
	return node
}

// Wraps a refinement around a node
function wrapClick(refName, argPos) {
	if (selectedNode) {
		var tempNode = createRefinement(refName);
		tempNode.setArg(argPos, myAbstract.copyTree(getNodeFromAbstract(abstractTree, selectedNode, "0")));
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
		document.getElementById("actWrap").className == "selected") && undoArray.length) {
		var prevState = undoArray.pop();
		selectedNode = prevState.selectedNode;
		abstractTree = myAbstract.copyTree(prevState.tree);
		collapseBuffer = prevState.collapseBuffer;
		abstractTree = myAbstract.annotate(abstractTree, myAbstract.startcat);
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


// show overloaded name: ignore prefix ovr*_
function overl(name){
  var nam = "";
  if (name[0] + name[1] + name[2]=="ovr") {
    i = 5 ; 
    while (name[i] != '_') {++i}
    for (j = i+1 ; j != name.length ; ++j){ nam += name[j] ;}
  }
  else nam = name ;
  return nam;
}

Fun.prototype.printOverl = function () { return this.showOverl(0); } ;
Fun.prototype.showOverl = function (prec) {
	if (this.isMeta()) {
			return '?';
		
	} else {
	  var s = overl(this.name);
		var cs = this.args;
		for (var i in cs) {
			s += " " + cs[i].showOverl(1);
		}
		if (prec > 0 && cs.length > 0) {
			s = "(" + s + ")" ;
		}
		return s;
	}
};
