
function GFGrammar(abstract, concretes) {
	this.abstract = abstract;
	this.concretes = concretes;
}

/* ------------------------------------------------------------------------- */
/* ----------------------------- LINEARIZATION ----------------------------- */
/* ------------------------------------------------------------------------- */

/* Extension to the String object */

String.prototype.tag = "";
String.prototype.setTag = function (tag) { this.tag = tag; };

/* Abstract syntax trees */
function Fun(name) {
	this.name = name;
	this.args = copy_arguments(arguments, 1);
}
Fun.prototype.print = function () { return this.show(0); } ;
Fun.prototype.show = function (prec) {
	if (this.isMeta()) {
		if (isUndefined(this.type)) {
			return '?';
		} else {
			var s = '?:' + this.type;
			if (prec > 0) {
				s = "(" + s + ")" ;
			}
			return s;
		}
	} else {
		var s = this.name;
		var cs = this.args;
		for (var i in cs) {
		        s += " " + (isUndefined(cs[i]) ? "undefined" : cs[i].show(1));
		}
		if (prec > 0 && cs.length > 0) {
			s = "(" + s + ")" ;
		}
		return s;
	}
};
Fun.prototype.getArg = function (i) {
	return this.args[i];
};
Fun.prototype.setArg = function (i,c) {
	this.args[i] = c;
};
Fun.prototype.isMeta = function() {
	return this.name == '?';
} ;
Fun.prototype.isComplete = function() {
	if (this.isMeta()) {
		return false;
	} else {
		for (var i in this.args) {
			if (!this.args[i].isComplete()) {
				return false;
			}
		}
		return true;
	}
} ;

/* Concrete syntax terms */

function Arr() { this.arr = copy_arguments(arguments, 0); }
Arr.prototype.tokens = function() { return this.arr[0].tokens(); };
Arr.prototype.sel = function(i) { return this.arr[i.toIndex()]; };
Arr.prototype.setTag = function(tag) {
	for (var i = 0, j = this.arr.length; i < j; i++) {
		this.arr[i].setTag(tag);
	}
};

function Seq() { this.seq = copy_arguments(arguments, 0); }
Seq.prototype.tokens = function() { 
	var xs = new Array();
	for (var i in this.seq) {
		var ys = this.seq[i].tokens();
		for (var j in ys) {
			xs.push(ys[j]);
		}		
	}
	return xs; 
};
Seq.prototype.setTag = function(tag) {
	for (var i = 0, j = this.seq.length; i < j; i++) {
		this.seq[i].setTag(tag);
	}
};

function Variants() { this.variants = copy_arguments(arguments, 0); }
Variants.prototype.tokens = function() { return this.variants[0].tokens(); };
Variants.prototype.sel = function(i) { return this.variants[0].sel(i); };
Variants.prototype.toIndex = function() { return this.variants[0].toIndex(); };
Variants.prototype.setTag = function(tag) {
	for (var i = 0, j = this.variants.length; i < j; i++) {
		this.variants[i].setTag(tag);
	}
};

function Rp(index,value) { this.index = index; this.value = value; }
Rp.prototype.tokens = function() { return new Array(this.index.tokens()); };
Rp.prototype.sel = function(i) { return this.value.arr[i.toIndex()]; };
Rp.prototype.toIndex = function() { return this.index.toIndex(); };
Rp.prototype.setTag = function(tag) { this.index.setTag(tag) };

function Suffix(prefix,suffix) {
	this.prefix = new String(prefix);
	if (prefix.tag) { this.prefix.tag = prefix.tag; }
	this.suffix = suffix;
};
Suffix.prototype.tokens = function() {
	var xs = this.suffix.tokens();
	for (var i in xs) {
		xs[i] = new String(this.prefix + xs[i]);
		xs[i].setTag(this.prefix.tag);
	}
	return xs;
};
Suffix.prototype.sel = function(i) { return new Suffix(this.prefix, this.suffix.sel(i)); };
Suffix.prototype.setTag = function(tag) { if (!this.prefix.tag) { this.prefix.setTag(tag); } };

function Meta() { }
Meta.prototype.tokens = function() { 
	var newString = new String("?");
	newString.setTag(this.tag);
	return new Array(newString);
};
Meta.prototype.toIndex = function() { return 0; };
Meta.prototype.sel = function(i) { return this; };
Meta.prototype.setTag = function(tag) { if (!this.tag) { this.tag = tag; } };

function Str(value) { this.value = value; }
Str.prototype.tokens = function() {
	var newString = new String(this.value);	
	newString.setTag(this.tag);
	return new Array(newString);
};
Str.prototype.setTag = function(tag) { if (!this.tag) { this.tag = tag; } };

function Int(value) { this.value = value; }
Int.prototype.tokens = function() {
	var newString = new String(this.value.toString());
	newString.setTag(this.tag);
	return new Array(newString);
};
Int.prototype.toIndex = function() { return this.value; };
Int.prototype.setTag = function(tag) { if (!this.tag) { this.tag = tag; } };

/* Type annotation */

/*
function Abstract(startcat) {
	this.types = new Array();
	this.startcat = startcat;
}
*/
function GFAbstract(startcat, types) {
	this.startcat = startcat;
	this.types = types;
}
GFAbstract.prototype.addType = function(fun, args, cat) {
	this.types[fun] = new Type(args, cat);
} ;
GFAbstract.prototype.getArgs = function(fun) {
	return this.types[fun].args;
}
GFAbstract.prototype.getCat = function(fun) {
	return this.types[fun].cat;
};
GFAbstract.prototype.annotate = function(tree, type) {
	if (tree.name == '?') {
		tree.type = type;
	} else {
		var typ = this.types[tree.name];
		for (var i in tree.args) {
			this.annotate(tree.args[i], typ.args[i]);
		}
	}
	return tree;
} ;
GFAbstract.prototype.handleLiterals = function(tree, type) {
	if (tree.name != '?') {
		if (type == "String" || type == "Int" || type == "Float") {
			tree.name = type + "_Literal_" + tree.name;
		} else {
			var typ = this.types[tree.name];
			for (var i in tree.args) {
				this.handleLiterals(tree.args[i], typ.args[i]);
			}
		}
	}
	return tree;
} ;
/* Hack to get around the fact that our SISR doesn't build real Fun objects. */
GFAbstract.prototype.copyTree = function(x) {
	var t = new Fun(x.name);
	if (!isUndefined(x.type)) {
	  t.type = x.type;
	}
	var cs = x.args;
	if (!isUndefined(cs)) {
	  for (var i in cs) {
	    t.setArg(i, this.copyTree(cs[i]));
	  }
	}
	return t;
} ;
GFAbstract.prototype.parseTree = function(str, type) { 
	return this.annotate(this.parseTree_(str.match(/[\w\'\.\"]+|\(|\)|\?|\:/g), 0), type); 
} ;
GFAbstract.prototype.parseTree_ = function(tokens, prec) {
	if (tokens.length == 0 || tokens[0] == ")") { return null; }
	var t = tokens.shift();
	if (t == "(") {
		var tree = this.parseTree_(tokens, 0);
		tokens.shift();
		return tree;
	} else if (t == '?') {
		var tree = this.parseTree_(tokens, 0);
		return new Fun('?');
	} else {
		var tree = new Fun(t);
		if (prec == 0) {
			var c, i;
			for (i = 0; (c = this.parseTree_(tokens, 1)) !== null; i++) {
				tree.setArg(i,c);
			}
		}
		return tree;
	}
} ;

function Type(args, cat) {
	this.args = args;
	this.cat = cat;
}

/* Linearization */
/*
function Concrete(abstr) {
	this.abstr = abstr;
	this.rules = new Array();
	this.parser = undefined;
}
*/
function GFConcrete(rules, parser) {
	this.rules = rules;
	if (parser) {
		this.parser = parser;
	} else {
		this.parser = undefined;
	}
}
GFConcrete.prototype.rule = function (name, cs) { return this.rules[name](cs); };
GFConcrete.prototype.addRule = function (name, f) { this.rules[name] = f; };
GFConcrete.prototype.lindef = function (cat, v) {	return this.rules[cat]([new Str(v)]); } ;
GFConcrete.prototype.linearize = function (tree) { 
	return this.unlex(this.linearizeToTerm(tree).tokens());
};
GFConcrete.prototype.linearizeToTerm = function (tree) {
	if (tree.isMeta()) {
		if (isUndefined(tree.type)) {
			return new Meta();
		} else {
			return this.lindef(tree.type, tree.name);
		}
	} else {
	    var cs = new Array();
		for (var i in tree.args) {
		  cs.push(this.linearizeToTerm(tree.args[i]));
		}
		var newTerm = this.rule(tree.name, cs);
		return newTerm;
	}
};
GFConcrete.prototype.unlex = function (ts) {
	if (ts.length == 0) {
		return "";
	}

	var noSpaceAfter = /^[\(\-\[]/;
	var noSpaceBefore = /^[\.\,\?\!\)\:\;\-\]]/;

	var s = "";
	for (var i = 0; i < ts.length; i++) {
		var t = ts[i];
		var after = i < ts.length-1 ? ts[i+1] : null;
		s += t;
		if (after != null && !t.match(noSpaceAfter) 
				  && !after.match(noSpaceBefore)) {
			s += " ";
		}
	}
	return s;
};
GFConcrete.prototype.tagAndLinearize = function (tree) {
	return this.tagAndLinearizeToTerm(tree, "0").tokens();
};
GFConcrete.prototype.tagAndLinearizeToTerm = function (tree, route) {
	if (tree.isMeta()) {
		if (isUndefined(tree.type)) {
			var newMeta = new Meta();
			newMeta.setTag(route);
			return newMeta;
		} else {
			var newTerm = this.lindef(tree.type, tree.name);
			newTerm.setTag(route);
			return newTerm;
		}
	} else {
	    var cs = new Array();
		for (var i in tree.args) {
		  cs.push(this.tagAndLinearizeToTerm(tree.args[i], route + "-" + i));
		}
		var newTerm = this.rule(tree.name, cs);
		newTerm.setTag(route);
		return newTerm;
	}
};

/* Utilities */

/* from Remedial JavaScript by Douglas Crockford, http://javascript.crockford.com/remedial.html */
function isString(a) { return typeof a == 'string'; }
function isArray(a) { return a && typeof a == 'object' && a.constructor == Array; }
function isUndefined(a) { return typeof a == 'undefined'; }
function isBoolean(a) { return typeof a == 'boolean'; }
function isNumber(a) { return typeof a == 'number' && isFinite(a); }
function isFunction(a) { return typeof a == 'function'; }

function dumpObject (obj) {
	if (isUndefined(obj)) {
		return "undefined";
	} else if (isString(obj)) {
		return '"' + obj.toString() + '"'; // FIXME: escape
	} else if (isBoolean(obj) || isNumber(obj)) {
		return obj.toString();
	} else if (isArray(obj)) {
		var x = "[";
		for (var i in obj) {
			x += dumpObject(obj[i]);
			if (i < obj.length-1) {
				x += ",";
			}
		}
		return x + "]";		
	} else {
		var x = "{";
		for (var y in obj) {
			x += y + "=" + dumpObject(obj[y]) + ";" ;
		}
		return x + "}";
	}
}


function copy_arguments(args, start) {
	var arr = new Array();
	for (var i = 0; i < args.length - start; i++) {
		arr[i] = args[i + start];
	}
	return arr;
}

/* ------------------------------------------------------------------------- */
/* -------------------------------- PARSING -------------------------------- */
/* ------------------------------------------------------------------------- */


// Parser Object Definition
/*
function Parser(startcat) {
	this.startcat = startcat;
	this.rules = new Array();
	this.cats = new Array();
}
*/
function Parser(startcat, rules, cats) {
	this.startcat = startcat;
	this.rules = rules;
	this.cats = cats;
}
/*
Parser.prototype.addRule = function (rule) {
	this.rules.push(rule);
};
Parser.prototype.addCat = function (name, refs) {
	this.cats[name] = refs.slice(0);
};
*/
Parser.prototype.showRules = function () {
    var ruleStr = new Array();
	ruleStr.push("");
	for (i = 0, j = this.rules.length; i < j; i++) {
		ruleStr.push(this.rules[i].show());
	}
	return ruleStr.join("");
};
Parser.prototype.parseString = function (string, cat) {
	var tokens = string.split(" ");
	chart = new Chart(true);
	predict(this.rules, tokens);
	while (chart.updated) {
		chart.updated = false;
		completeAndConvert();
		scan();
		combine();
	}
	var catToParse = this.startcat;
	if (cat) { catToParse = cat; } 
	var goalRange = new Range(0, tokens.length);
	if (tokens.length == 1 && tokens[0] == "") { goalRange = new EmptyRange(); }
	var activeEdges = filterActiveEdges();
	var trees = new Array();
	for (var i = 0, j = this.cats[catToParse].length; i < j; i++) {
		if (foundTarget(this.cats[catToParse][i], new Array(new Array(goalRange)))) {
			trees = trees.concat(extractTrees(this.cats[catToParse][i], new Array(new Array(goalRange)), activeEdges, ""));
		}
	}
	for (var i = trees.length - 1; i >= 0; i--) {
		if (trees[i] == undefined) { trees.splice(i, 1); }
	}
	return trees;
};

// Rule Object Definition

function Rule(cat, profile, args, linRec) {
	this.cat = cat;
	this.profile = profile;
	this.args = args;
	this.linRec = linRec;
}
Rule.prototype.show = function () {
	var recStr = new Array();
	recStr.push(this.cat, " -> ", this.profile.show(), " [", this.args, "] = ", showLinRec(this.linRec, ""));
	return recStr.join("");
};

// Profile definitions

// Function application
// The function (name) is applied to its arguments (args)
function FunApp(name, args) {
	this.id = "FunApp";
	this.name = name;
	this.args = args.slice(0);
}
FunApp.prototype.show = function () {
	var funAppStr = new Array();
	funAppStr.push("(", this.name);
	for (var i = 0, j = this.args.length; i < j; i++) {
		funAppStr.push(this.args[i].show());
	}
	funAppStr.push(")");
	return funAppStr.join(" ");
};

// Literal
function Lit(name) {
	this.id = "Lit";
	this.name = name;
}
Lit.prototype.show = function () { return this.name; };

// Metavariable
function MetaVar() { this.id = "MetaVar"; }
MetaVar.prototype.show = function () { return "?"; };

// Argument
function Arg(i) {
	this.id = "Arg";
	this.name = "_";
	this.i = i;
}
Arg.prototype.show = function () {
	var argStr = new Array();
	argStr.push(this.id, "(", this.i, ")");
	return argStr.join("");
};

// Unification
// The arguments (args) must be unified
function Unify(args){
	this.id = "Unify";
	this.args = args.slice(0);
}
Unify.prototype.show = function () {
	var unifyStr = new Array();
	unifyStr.push("(", this.id);
	for (var i = 0, j = this.args.length; i < j; i++) {
		unifyStr.push(this.args[i].show());
	}
	unifyStr.push(")");
	return unifyStr.join(" ");
};

// Definition of symbols present in linearization records

// Object to represent argument projections in grammar rules
function ArgProj(i, label) {
	this.id = "argProj";
	this.i = i;
	this.label = label;
}
ArgProj.prototype.getId = function () { return this.id; };
ArgProj.prototype.getArgNum = function () { return this.i };
ArgProj.prototype.show = function () {
	var argStr = new Array();
	argStr.push(this.i, this.label);
	return argStr.join(".");
};
ArgProj.prototype.isEqual = function (obj) {
	return (this.id == obj.id && this.i == obj.i && this.label == obj.label);
}

// Object to represent terminals in grammar rules
function Terminal (str) {
	this.id = "terminal";
	this.str = str;
}
Terminal.prototype.getId = function () { return this.id; };
Terminal.prototype.show = function () {
	var terminalStr = new Array();
	terminalStr.push('"', this.str, '"');
	return terminalStr.join("");
};
Terminal.prototype.isEqual = function (obj) {
	return (this.id == obj.id && this.str == obj.str);
}

// Object to represent ranges in grammar rules
function Range (i, j) {
	this.id = "range";
	this.i = i;
	this.j = j;
}
Range.prototype.getId = function () { return this.id; };
Range.prototype.show = function () {
	var terminalStr = new Array();
	terminalStr.push("(", this.i, ",", this.j, ")");
	return terminalStr.join("");
};
Range.prototype.isEqual = function (obj) {
	return (this.id == obj.id && this.i == obj.i && this.j == obj.j);
}

// Object to represent the empty range in grammar rules
function EmptyRange () {
	this.id = "emptyRange";
}
EmptyRange.prototype.getId = function () { return this.id; };
EmptyRange.prototype.show = function () { return "emptyRange" };
EmptyRange.prototype.isEqual = function (obj) {
	return (this.id == obj.id);
}

// Chart Object Definition
function Chart(updated) {
	this.passive = new Array();
	this.active  = new Array();
	this.updated = updated;
}
Chart.prototype.show = function () {
	var chartStr = new Array();
	chartStr.push("(", this.showPassive(), ", ", this.showActive(), ")");
	return chartStr.join("");
};
Chart.prototype.addPassiveEdge = function (cat, linRec) {
	if (!this.passive[cat] || !this.passive[cat].length) {
		this.passive[cat] = new Array();
	}
	this.passive[cat].push(linRec);
};
Chart.prototype.isPassiveElem = function (cat, linRec) {
	if (this.passive[cat]) {
		for (var i = 0, j = this.passive[cat].length; i < j; i++) {
			if (linRecsAreEqual(this.passive[cat][i], linRec)) {
				return true;
			}
		}
	}
	return false;
};
Chart.prototype.showPassive = function () {
	var edgesStr = new Array();
	edgesStr.push("[ ");
	for (var cat in this.passive) {
		for (var i = 0, j = this.passive[cat].length; i < j; i++) {
			edgesStr.push("( ", cat, ", ", showLinRec(this.passive[cat][i], ""), ")");
			if (i != j - 1) { edgesStr.push(", "); };
		}
		edgesStr.push(", ");
	}
	edgesStr.push(" ]");
	return edgesStr.join("");
	return edgesStr.join("") + "<br />";
};
Chart.prototype.addActiveEdge = function (cat, edge) {
	if (!this.active[cat] || !this.active[cat].length) {
		this.active[cat] = new Array();
	}
	this.active[cat].push(edge);
};
Chart.prototype.isActiveElem = function (cat, edge) {
	if (this.active[cat]) {
		for (var i = 0, j = this.active[cat].length; i < j; i++) {
			var currentEdge = this.active[cat][i];
			if (currentEdge.name == edge.name && (areArgsEqual(currentEdge.args, edge.args)) &&
				currentEdge.currLabel == edge.currLabel && currentEdge.currLin.isEqual(edge.currLin) &&
				linRecsAreEqual(currentEdge.linFound, edge.linFound) && linRowsAreEqual(currentEdge.remLin, edge.remLin) &&
				linRecsAreEqual(currentEdge.remLinRows, edge.remLinRows) &&
				arraysOfLinRecsAreEqual(currentEdge.children, edge.children)) {
				return true;
			}
		}
	}
	return false;
};
Chart.prototype.showActive = function () {
	var edgesStr = new Array()
	edgesStr.push("[ ");
	for (var cat in this.active) {
		for (var i = 0, j = this.active[cat].length; i < j; i++) {
			edgesStr.push("( ", this.active[cat][i].show(), " )");
			if (i != j - 1) { edgesStr.push(", "); };
		}
		edgesStr.push(", ");
	}
	edgesStr.push(" ]");
	return edgesStr.join("");
};

// Object to represent the active edges in a chart
function ActiveEdge(profile, cat, name, args, linFound, currLabel, currLin, remLin, remLinRows, children) {
	this.profile = profile;
	this.cat = cat;
	this.name = name;
	this.args = args;
	this.linFound = linFound;
	this.currLabel = currLabel;
	this.currLin = currLin;
	this.remLin = remLin;
	this.remLinRows = remLinRows;
	this.children = children.slice(0);
}
ActiveEdge.prototype.show = function () {
	var linRecStr = new Array();
	linRecStr.push(this.profile.show(), ", ", this.cat, ", ", this.name, ", [ ", this.args, " ], ", showLinRec(this.linFound, ""),
					", ", this.currLabel, ", ", this.currLin.show(), ", ", showLinRow(this.remLin, " ++ "),
					", ", showLinRec(this.remLinRows, ""), ", [ ");
	for (var i = 0, j = this.children.length; i < j; i++) {
		linRecStr.push(showLinRec(this.children[i], ""));
		if (i != j - 1) { linRecStr.push(", "); };
	}
	linRecStr.push(" ]");
	return linRecStr.join("");
};

function areArgsEqual(args1, args2) {
	if (args1.length == args1.length && args1.join() == args2.join()) {
		return true
	}
	return false;
}

// Functions to manipulate linearization records

// Returns a string representation of a linearization row
function showLinRow(linRow, separator) {
	var linRowStr = new Array();
	linRowStr.push(" [ ");
	for (var i = 0, j = linRow.length; i < j; i ++) {
		linRowStr.push(linRow[i].show());
		if (i != j - 1) { linRowStr.push(separator) };
	}
	linRowStr.push(" ] ");
	return linRowStr.join("");
}

// Returns a string representation of a linearization record
function showLinRec(linRec, separator) {
	var linRecStr = new Array();
	linRecStr.push(" [ ");
	for (var i = 0, j = linRec.length; i < j; i ++) {
		linRecStr.push(showLinRow(linRec[i], " ++ "));
		if (i != j - 1) { linRecStr.push(separator); };
	}
	linRecStr.push(" ] ");
	return linRecStr.join("");
}

// Checks if two linearization rows are equal
function linRowsAreEqual(linRow1, linRow2) {
	if (linRow1.length == linRow2.length) {
		for (var i = 0, j = linRow1.length; i < j; i++) {
			if (linRow1[i].id && linRow2[i].id && !linRow1[i].isEqual(linRow2[i])) {
				return false;
			}
		}
		return true;
	}
	return false;
}

// Checks if two linearization records are equal
function linRecsAreEqual(linRec1, linRec2) {
	if (linRec1.length == linRec2.length) {
		for (var i = 0, j = linRec1.length; i < j; i++) {
			if (!linRowsAreEqual(linRec1[i], linRec2[i])) { return false; }
		}
		return true;
	}
	return false;
}

// Checks if two arrays of linearization records are equal
function arraysOfLinRecsAreEqual(array1, array2) {
	if (array1.length == array2.length) {
		for (var i = 0, j = array1.length; i < j; i++) {
			if (!linRecsAreEqual(array1[i], array2[i])) { return false; }
		}
		return true;
	}
	return false;
}

// Functions to manipulate ranges (restriction and concatenation)

// Concatenates two ranges
function rangeConcatLin (lin1, lin2) {
	if (lin1.id == "range" && lin2.id == "range") {
		if (lin1.j == lin2.i) { return (new Range(lin1.i, lin2.j)) }
	} else if (lin1.id == "range" && lin2.id == "emptyRange") { return lin1; }
		   else if (lin1.id == "emptyRange" && lin2.id == "range") { return lin2; }
		   		else if (lin1.id == "emptyRange" && lin2.id == "emptyRange") { return lin1; }
	return undefined;
}

// Performs range concatenation on a linarization row
function rangeConcatLins (lins) {
	var newLins = new Array();
	newLins.push(lins.shift());
	while (lins.length > 0) {
		if (!newLins[newLins.length - 1]) { return new Array(); }
		if (newLins[newLins.length - 1].id == "range" && lins[0].id == "range") {
			var rangeConcat = rangeConcatLin(newLins.pop(), lins[0]);
			if (typeof rangeConcat == 'undefined') { return new Array(); }
			newLins.push(rangeConcat);
			lins.shift();
		} else {
			newLins.push(lins.shift());
		}
	}
	return newLins;
}

// Performs range restriction on an element of a linarization row
// while keeping track of the tokens that have been used
function rangeRestLinTerm(tokens, lin, rangesNotConsumed) {
	if (lin.id == "argProj") { return new Array(lin); }
	else if (lin.id == "terminal") {
		var ranges = new Array();
		for (var i = 0, j = tokens.length; i < j; i++) {
			if (tokens[i] == lin.str) {
				ranges.push(new Range(i, i + 1));
				rangesNotConsumed[i] = undefined;
			}			
		}
		if (ranges.length == 0) {
			return undefined;
		} else {
			return ranges;
		}
	}
	else { return new Array(); }
}

// Performs range restriction on a linearization record
// while keeping track of the tokens that have been used
function rangeRestRecTerm(linRec, tokens, rangesNotConsumed) {
	var ranges = new Array();
	for (var i = 0, j = linRec.length; i < j; i++) {
		var rangeRestLins = new Array();
			for (var k = 0, l = linRec[i].length; k < l; k++) {
					rangeRestLins.push(rangeRestLinTerm(tokens, linRec[i][k], rangesNotConsumed));
			}
		var combinedLins = combineLins(rangeRestLins);
		if (typeof combinedLins != 'undefined') {
			var filteredLins = new Array();
			if (combinedLins.length == 0) {
				filteredLins.push(new Array());
			} else {
				for (var m = 0, n = combinedLins.length; m < n; m++) {
					var temp = rangeConcatLins(combinedLins[m]);
					if (temp.length != 0) {
						filteredLins.push(temp);
					}
				}
			}
			ranges.push(filteredLins);
		} else { ranges.push(undefined); }
	}
	for (var k = 0, l = ranges.length; k < l; k++) {
		if (ranges[k] == undefined) { return undefined; }
	}
	return combineLins(ranges);
}

// Returns the combinations of the elements of an array of arrays
function combineLins(linss) {
	if (linss.length > 0) {
		var combinedLins = new Array();
		var lins = linss.shift();
		if (lins) {
			if (lins.length != 0) {
				var tail = combineLins(linss);
				if (typeof tail == 'undefined') { return undefined; }
				for (var i = 0, j = lins.length; i < j; i++) {
					var head = new Array();
					head.push(lins[i]);
					if (tail.length == 0) { combinedLins.push(head); }
					else {
						for (var k = 0, l = tail.length; k < l; k++) {
							combinedLins.push(head.concat(tail[k]));
						}
					}
				}
			} else { return new Array(); }
		} else { return undefined; }
		return combinedLins;
	} else { return new Array(); }
}

// Inference Rules

function predict(rules, tokens) {
	var rangesNotConsumed = genRanges(tokens.length);
	for (var i = 0, j = rules.length; i < j; i++) {
		var currentRule = rules[i];
		var linRec = rangeRestRecTerm(currentRule.linRec, tokens, rangesNotConsumed);
		if (linRec) {
			for (var k = 0, l = linRec.length; k < l; k++) {
				var currentRow = linRec[k].shift();
				var remlinRows = linRec[k];
				var children = new Array();
				for (var m = 0, n = currentRule.args.length; m < n; m++) {
					children.push(new Array());
				}
				var newActive = new ActiveEdge(currentRule.profile, currentRule.cat, currentRule.profile.name, currentRule.args, new Array(), 0, new EmptyRange(), currentRow, remlinRows, children);
				if (!chart.isActiveElem(currentRule.cat, newActive)) {
					chart.addActiveEdge(currentRule.cat, newActive);
					chart.updated = true;
				}
			}
		}
	}
	for (var i = 0, j = rangesNotConsumed.length; i < j; i++) {
		if (rangesNotConsumed[i] != undefined) {
			var cat = undefined;
			if (isNaN(tokens[i])) {
				cat = "-1";
			} else if (tokens[i].lastIndexOf(".") == -1) {
				cat = "-2";
			} else {
				cat = "-3";
			}
			var lit = undefined;
			if (cat == "-1") {
				lit = "\"" + tokens[i] + "\"";
			} else {
				lit = tokens[i];
			}
			var newActive = new ActiveEdge(new Lit(lit), cat, tokens[i], new Array(), new Array(), 0, new Range(i, i + 1), new Array(), new Array(), new Array());
			if (!chart.isActiveElem(cat, newActive)) {
				chart.addActiveEdge(cat, newActive);
				chart.updated = true;
			}
		}
	}
}

function genRanges(inputLength) {
	var ranges = new Array();
	for (var i = 0; i < inputLength; i++) {
		ranges.push(i);
	}
	return ranges;
}

function completeAndConvert() {
	for (var cat in chart.active) {
		var currentEdge = chart.active[cat];
		for (var i = 0, j = currentEdge.length; i < j; i++) {
			if (currentEdge[i].remLin.length == 0) {
				if (currentEdge[i].remLinRows.length == 0) {
					var linFound = currentEdge[i].linFound.slice(0);
					linFound.push(new Array(currentEdge[i].currLin));
					if (!chart.isPassiveElem(cat, linFound)) {
						chart.addPassiveEdge(cat, linFound);
						chart.updated = true;
					}
				} else {
					var linFound = currentEdge[i].linFound.slice(0);
					linFound.push(new Array(currentEdge[i].currLin));
					var remLinRows = currentEdge[i].remLinRows.slice(0);
					var currentRow = remLinRows.shift();
					var newActive = new ActiveEdge(currentEdge[i].profile, cat, currentEdge[i].name, currentEdge[i].args, linFound, linFound.length, new EmptyRange(), currentRow, remLinRows, currentEdge[i].children);
					if (!chart.isActiveElem(cat, newActive)) {
						chart.active[cat].push(newActive);
						chart.updated = true;
					}
				}
			}
		}
	}
}

function scan() {
	for (var cat in chart.active) {
		var currentEdge = chart.active[cat];
		for (var i = 0, j = currentEdge.length; i < j; i++) {
			if (currentEdge[i].remLin.length > 0 && currentEdge[i].remLin[0].id == "range") {
				var newRange = rangeConcatLin(currentEdge[i].currLin, currentEdge[i].remLin[0]);
				if (typeof newRange != 'undefined') {
					var remLin = currentEdge[i].remLin.slice(0);
					remLin.shift();
					var newActive = new ActiveEdge(currentEdge[i].profile, cat, currentEdge[i].name, currentEdge[i].args, currentEdge[i].linFound, currentEdge[i].currLabel, newRange, remLin, currentEdge[i].remLinRows, currentEdge[i].children);
					if (!chart.isActiveElem(cat, newActive)) {
						chart.active[cat].push(newActive);
						chart.updated = true;
					}
				}
			}
		}
	}
}

function combine() {
	for (var cat in chart.active) {
		for (var i = 0; i < chart.active[cat].length; i++) {
			var currentEdge = chart.active[cat][i];
			if (currentEdge.remLin.length && currentEdge.remLin[0].id == "argProj") {
				var argNumber = currentEdge.remLin[0].i;
				var catToCombine = currentEdge.args[argNumber];
				if (chart.passive[catToCombine]) {
					for (var k = 0, l = chart.passive[catToCombine].length; k < l; k++) {
						var currentPassive = chart.passive[catToCombine][k];
						var remLin = currentEdge.remLin.slice(0);
						var linRow = currentPassive[remLin[0].label];
						if (typeof linRow != 'undefined') {
							var newLinRow = linRow.slice(0); 
							if (currentEdge.children[argNumber].length == 0) {
								var newRange = rangeConcatLin(currentEdge.currLin, newLinRow.shift());
								if (typeof newRange != 'undefined') {
									remLin.shift();
									var children = currentEdge.children.slice(0);
									children[argNumber] = currentPassive.slice(0);
									var newActive = new ActiveEdge(currentEdge.profile, currentEdge.cat, currentEdge.name, currentEdge.args, currentEdge.linFound, currentEdge.currLabel, newRange, remLin, currentEdge.remLinRows, children);
									if (!chart.isActiveElem(cat, newActive)) {
										chart.active[cat].push(newActive);
										chart.updated = true;
									}
								}
							} else {
								var child = currentEdge.children[argNumber];
								if (linRecsAreEqual(currentPassive, child)) {
									var newRange = rangeConcatLin(currentEdge.currLin, newLinRow.shift());
									if (typeof newRange != 'undefined') {
										remLin.shift();
										var children = currentEdge.children.slice(0);
										children[argNumber] = currentPassive.slice(0);
										var newActive = new ActiveEdge(currentEdge.profile, currentEdge.cat, currentEdge.name, currentEdge.args, currentEdge.linFound, currentEdge.currLabel, newRange, remLin, currentEdge.remLinRows, children);
										if (!chart.isActiveElem(cat, newActive)) {
											chart.active[cat].push(newActive);
											chart.updated = true;
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}

// Checks if the parsing goal is in the chart
function foundTarget(cat, linRec) {
	if (chart.passive[cat]) {
		for (var i = 0, j = chart.passive[cat].length; i < j; i++) {
			if (linRecsAreEqual(linRec, chart.passive[cat][i])) {
				return true;
			}
		}
	}
	return false;
}

// Filters the active edges that are relevant for tree extraction
function filterActiveEdges() {
	var activeEdges = new Array();
	for (var cat in chart.active) {
		activeEdges[cat] = new Array();
		for (var i = 0, j = chart.active[cat].length; i < j; i++) {
			var currentEdge = chart.active[cat][i];
			if (currentEdge.remLin.length == 0 && currentEdge.remLinRows.length == 0) {
				var linFound = currentEdge.linFound.slice(0);
				linFound.push(new Array(currentEdge.currLin));
				var newActive = new ActiveEdge(currentEdge.profile, currentEdge.cat, currentEdge.name, currentEdge.args, linFound, "", "", "", "", currentEdge.children);
				activeEdges[cat].push(newActive);
			}
		}
	}
	return activeEdges;
}

// Extracts the parse trees from the chart
function extractTrees(cat, linRec, activeEdges, currentTree) {
	var trees = new Array();
	for (var i = 0, j = activeEdges[cat].length; i < j; i++) {
		var currentEdge = activeEdges[cat][i];
		var currentNode = "(" + cat + "-" + i + ")";
		if (currentTree.indexOf(currentNode) == -1 && cat == currentEdge.cat && linRecsAreEqual(linRec, currentEdge.linFound)) {
			var subTrees = new Array();
			for (var k = 0, l = currentEdge.children.length; k < l; k++) {
				subTrees.push(extractTrees(currentEdge.args[k], currentEdge.children[k].slice(0), activeEdges, currentTree + currentNode));
			}
			var combinedSubTrees = combineLins(subTrees);
			if (combinedSubTrees) {
				if (currentEdge.children.length == 0) { combinedSubTrees.push(new Array()); }
				for (var m = 0, n = combinedSubTrees.length; m < n; m++) {
					var tree = buildTree(currentEdge.profile, combinedSubTrees[m]);
					if (tree) {
						trees.push(tree);
					}
				}
			}
		}
	}
	if (trees.length == 0) {
		return undefined;
	} else {
		return trees;
	}
}

// Builds a tree according to the profile
function buildTree(profile, args) {
	switch(profile.id)
	{
		case "FunApp":
			var tree = new Fun(profile.name);
			for (var i = 0, j = profile.args.length; i < j; i++) {
				var subTree = buildTree(profile.args[i], args);
				if (subTree) {
					tree.setArg(i, subTree);
				} else {
					return undefined;
				}
			}
			return tree;
		case "Lit":
			return new Fun(profile.name);
		case "MetaVar":
			return new Fun("?");
		case "Arg":
			return args[profile.i];
		case "Unify":
			var subTrees = new Array();
			for (var i = 0, j = profile.args.length; i < j; i++) {
				subTrees.push(buildTree(profile.args[i], args))
			}
			return unifySubTrees(subTrees);
	}
}

// Tree unification functions
function unifySubTrees(subTrees) {
	var t = subTrees[0];
	for (var i = 1, j = subTrees.length; i < j; i++) {
		t = unify(t, subTrees[i]);
		if (!t) { return undefined; }
	}
	return t;
}

function unify(a, b) {
	if (a.isMeta()) { return b };
	if (b.isMeta()) { return a };
	if (a.name == b.name && a.args.length == b.args.length) {
		for (var i = 0, j = a.args.length; i < j; i++) {
			if (!unify(a.args[i], b.args[i])) { return undefined; }
		}
		return a
	};
	return undefined;
}
