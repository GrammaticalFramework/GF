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
		for (var i in tree.args) {
			if (!tree.args[i].isComplete()) {
				return false;
			}
		}
		return true;
	}
} ;

/* Concrete syntax terms */

function Arr() { this.arr = copy_arguments(arguments, 0); }
Arr.prototype.print = function() { return this.arr[0].print(); };
Arr.prototype.sel = function(i) { return this.arr[i.toIndex()]; };

function Seq() { this.seq = copy_arguments(arguments, 0); }
Seq.prototype.print = function() { return join_print(this.seq, " "); };

function Variants() { this.variants = copy_arguments(arguments, 0); }
Variants.prototype.print = function() { return this.variants[0].print(); };

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
Int.prototype.print = function() { return this.value.toString(); };
Int.prototype.toIndex = function() { return this.value; };

/* Type annotation */

function Abstract() {
	this.types = new Array();
}
Abstract.prototype.addType = function(fun, args, cat) {
	this.types[fun] = new Type(args, cat);
} ;
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
	return this.annotate(this.parseTree_(str.match(/[\w\']+|\(|\)|\?/g), 0), type); 
} ;
Abstract.prototype.parseTree_ = function(tokens, prec) {
	if (tokens.length == 0 || tokens[0] == ")") { return null; }
	var t = tokens.shift();
	if (t == "(") {
		var tree = this.parseTree_(tokens, 0);
		tokens.shift();
		return tree;
	} else if (t == '?') {
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
Concrete.prototype.lindef = function (cat, v) { return this.rules["_d"+cat]([new Str(v)]); } ;
Concrete.prototype.linearize = function (tree) { return this.linearizeToTerm(tree).print(); };
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

function join_print(values, glue) {
	var str = "";
	for (var i in values) {
		var s = values[i].print();
		if (s.length > 0) {
			if (str.length > 0) { str += glue; }
			str += s;
		}
	}
	return str;
}

