/* Abstract syntax trees */

function Fun(name) {
	this.name = name;
}
Fun.prototype.print = function () { return this.show(0); } ;
Fun.prototype.show = function (prec) {
	var s = this.name;
	var cs = this.getChildren();
	for (var i in cs) {
		s += " " + cs[i].show(1);
	}
	if (prec > 0 && cs.length > 0) {
		s = "(" + s + ")" ;
	}
	return s;
};
Fun.prototype.getChild = function (i) {
	return this['arg'+i];
};
Fun.prototype.setChild = function (i,c) {
	this['arg'+i] = c;
};
/* Gets an array containing all the children. Modifying the array does not
   change the tree, but modifying the elements of the array does. */
Fun.prototype.getChildren = function () {
	var a = new Array();
	for (var i = 0; ; i++) {
		var c = this.getChild(i);
		if (isUndefined(c)) { break; }
		a.push(c);
	}
	return a;
} ;

/* Hack to get around the fact that our SISR doesn't build real Fun objects. */
function copyTree(x) {
	if (typeof x == 'string' && x == '?') {
		return new Fun('?');
	} else {
		var t = new Fun(x.name);
		for (var i = 0; ; i++) {
			var c = x['arg' + i];
			if (isUndefined(c)) { break; }
			t.setChild(i, copyTree(c));
		}
		return t;
	}
}

function parseTree(str) { 
	return parseTree_(str.match(new RegExp("[\\w\\']+|\\(|\\)","g")), 0); 
}

function parseTree_(tokens, prec) {
	if (tokens.length == 0 || tokens[0] == ")") { return null; }
	var t = tokens.shift();
	if (t == "(") {
		var tree = parseTree_(tokens, 0);
		tokens.shift();
		return tree;
	} else {
		var tree = new Fun(t);
		if (prec == 0) {
			var c;
			var i;
			for (i = 0; (c = parseTree_(tokens, 1)) !== null; i++) {
				tree.setChild(i,c);
			}
		}
		return tree;
	}
}

/* Concrete syntax terms */

function Arr() { this.values = copy_arguments(arguments, 0); }
Arr.prototype.print = function() { return this.values[0].print(); };
Arr.prototype.sel = function(i) { return this.values[i.toIndex()]; };

function Seq() { this.values = copy_arguments(arguments, 0); }
Seq.prototype.print = function() { return join_print(this.values, " "); };

function Variants() { this.values = copy_arguments(arguments, 0); }
Variants.prototype.print = function() { return /*join_print(this.values, "/");*/ this.values[0].print(); };

function Rp(index,value) { this.index = index; this.value = value; }
Rp.prototype.print = function() { return this.index; };
Rp.prototype.toIndex = function() { return this.index.toIndex(); };

function Suffix(prefix,suffix) { this.prefix = prefix; this.suffix = suffix; };
Suffix.prototype.print = function() { return this.prefix + this.suffix.print(); };
Suffix.prototype.sel = function(i) { return new Suffix(this.prefix, this.suffix.sel(i)); };

function Meta() { }
Meta.prototype.print = function() { return "?"; };
Meta.prototype.toIndex = function() { return 0; };
Meta.prototype.sel = function(i) { return this; };

function Str(value) { this.value = value; }
Str.prototype.print = function() { return this.value; };

function Int(value) { this.value = value; }
Int.prototype.print = function() { return this.value; };
Int.prototype.toIndex = function() { return this.value; };

/* Linearization */

function Linearizer() {
	this.rules = new Array();
}
Linearizer.prototype.rule = function (name, cs) { return this.rules[name](cs); };
Linearizer.prototype.addRule = function (name, f) { this.rules[name] = f; };
Linearizer.prototype.linearize = function (tree) { return this.linearizeToTerm(tree).print(); };
Linearizer.prototype.linearizeToTerm = function (tree) {
	if (tree.name == '?') {
		return new Meta();
	} else {
		var cs = tree.getChildren();
		for (var i = 0; i < cs.length; i++) {
			cs[i] = this.linearizeToTerm(cs[i]);
		}
		return this.rule(tree.name, cs);
	}
};

/* Utilities */

/* from Remedial JavaScript by Douglas Crockford, http://javascript.crockford.com/remedial.html */
function isString(a) { return typeof a == 'string'; }
function isArray(a) { return a && typeof a == 'object' && a.constructor == Array; }
function isUndefined(a) { return typeof a == 'undefined'; }
function isBoolean(a) { return typeof a == 'boolean'; }
function isNumber(a) { return typeof a == 'number' && isFinite(a); }

function dumpObject (obj) {
	if (isUndefined(obj)) {
		return "undefined";
	} else if (isString(obj)) {
		return '"' + obj.toString() + '"'; // FIXME: escape
	} else if (isBoolean(obj) || isNumber(obj)) {
		return obj.toString();
	} else if (isArray(obj)) {
		var x = "[";
		for (var i = 0; i < obj.length; i++) {
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

function join_print(values, glue) {
	var str = "";
	for (var i = 0; i < values.length; i++) {
		var s = values[i].print();
		if (s.length > 0) {
			if (str.length > 0) { str += glue; }
			str += s;
		}
	}
	return str;
}

