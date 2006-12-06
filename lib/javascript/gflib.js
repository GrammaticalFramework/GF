/* Abstract syntax trees */

function Fun(name) {
	this.name = name;
	this.children = copy_arguments(arguments, 1);
}
Fun.prototype.toString = function () { return this.show(0); } ;
Fun.prototype.show = function (prec) {
	var s = this.name;
	for (var i = 0; i < this.children.length; i++) {
		s += " " + this.children[i].show(1);
	}
	if (prec > 0 && this.children.length > 0) {
		s = "(" + s + ")" ;
	}
	return s;
} ;

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
			while ((c = parseTree_(tokens, 1)) !== null) { 
				tree.children.push(c); 
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

function Glue() { this.values = copy_arguments(arguments, 0); }
Glue.prototype.print = function() { return join_print(this.values, ""); };

function Rp(index,value) { this.index = index; this.value = value; }
Rp.prototype.print = function() { return this.index; };
Rp.prototype.toIndex = function() { return this.index.toIndex(); };

function Suffix(prefix,suffix) { this.prefix = prefix; this.suffix = suffix; };
Suffix.prototype.print = function() { return this.prefix.print() + this.suffix.print(); };
Suffix.prototype.sel = function(i) { new Glue(this.prefix, this.suffix.sel(i)); };

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
	var cs = new Array();
	for (var i = 0; i < tree.children.length; i++) {
		cs[i] = this.linearizeToTerm(tree.children[i]);
	}
	return this.rule(tree.name, cs);
};

/* Utilities */

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

