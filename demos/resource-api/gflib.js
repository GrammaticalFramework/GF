
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
			s += " " + cs[i].show(1);
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

function Abstract(startcat) {
	this.types = new Array();
	this.startcat = startcat;
}
Abstract.prototype.addType = function(fun, args, cat) {
	this.types[fun] = new Type(args, cat);
} ;
Abstract.prototype.getArgs = function(fun) {
	return this.types[fun].args;
}
Abstract.prototype.getCat = function(fun) {
	return this.types[fun].cat;
};
Abstract.prototype.annotate = function(tree, type) {
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
/* Hack to get around the fact that our SISR doesn't build real Fun objects. */
Abstract.prototype.copyTree = function(x) {
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
Abstract.prototype.parseTree = function(str, type) { 
	return this.annotate(this.parseTree_(str.match(/[\w\']+|\(|\)|\?|\:/g), 0), type); 
} ;
Abstract.prototype.parseTree_ = function(tokens, prec) {
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

function Concrete(abstr) {
	this.abstr = abstr;
	this.rules = new Array();
}
Concrete.prototype.rule = function (name, cs) { return this.rules[name](cs); };
Concrete.prototype.addRule = function (name, f) { this.rules[name] = f; };
Concrete.prototype.lindef = function (cat, v) {	return this.rules[cat]([new Str(v)]); } ;
Concrete.prototype.linearize = function (tree) { 
	return this.unlex(this.linearizeToTerm(tree).tokens());
};
Concrete.prototype.linearizeToTerm = function (tree) {
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
Concrete.prototype.unlex = function (ts) {
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
Concrete.prototype.tagAndLinearize = function (tree) {
//	return this.tagAndLinearizeToTerm(tree, "0").tokens();
	var treeTerms = this.tagAndLinearizeToTerm(tree, "0");
	var treeTokens = treeTerms.tokens();	
	return treeTokens;
};
Concrete.prototype.tagAndLinearizeToTerm = function (tree, route) {
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
