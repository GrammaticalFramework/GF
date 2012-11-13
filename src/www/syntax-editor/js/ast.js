/* --- Tree representation -------------------------------------------------- */
function Tree(value) {

    // Create node as JS object
    var createNode = function(value, children) {
        var node = {
            value: value,
            children: []
        };
        if (children != undefined)
            for (c in children)
                node.children.push( createNode(children[c],[]) );
        return node;
    }

    this.root = createNode(value, []);

    // add value as child of id
    this.add = function(id, value, children) {
        var x = this.find(id);
        x.children.push( createNode(value, children) );
    }

    // id should be a list of child indices [0,1,0]
    // or a string separated by commas "0,1,0"
    this.find = function(_id) {
        var id = undefined
        switch (typeof _id) {
        case "number": id = [_id]; break;
        case "string": id = _id.split(","); break;
        case "object": id = _id.get().slice(); break; // clone NodeID array
        }
        var node = this.root;
        if (id[0] == 0) id.shift();
        while (id.length>0 && node.children.length>0) {
            node = node.children[id.shift()];
        }
        if (id.length>0)
            return undefined;
        return node;
    }
}

/* --- ID for a node in a tree ---------------------------------------------- */
function NodeID(x) {
    this.id = new Array();
    this.id.push(0);

    // Initialize from input
    if (x) {
        switch (typeof x) {
        case "number": this.id = [x]; break;
        case "string": this.id = map(function(s){return parseInt(s)}, x.split(",")); break;
        case "object": this.id = x.get().slice(); break; // another NodeID
        }
    }

    // get id
    this.get = function() {
        return this.id;
    }
    
    // Add child node to id
    this.add = function(x) {
        this.id.push(parseInt(x));
        return this.id;
    }

    // compare with other id
    this.equals = function(other) {
        return JSON.stringify(this.id)==JSON.stringify(other.id);
    }

}

/* --- Abstract Syntax Tree (with state)------------------------------------- */
function AST(fun, cat) {

    function Node(fun, cat) {
        this.fun = fun;
        this.cat = cat;
    }

    this.tree = new Tree(new Node(fun, cat));
    this.current = new NodeID(); // current id in tree

    this.getFun = function() {
        return this.tree.find(this.current).value.fun;
    }
    this.setFun = function(f) {
        this.tree.find(this.current).value.fun = f;
    }
    this.getCat = function() {
        return this.tree.find(this.current).value.cat;
    }
    this.setCat = function(c) {
        this.tree.find(this.current).value.cat = c;
    }

    this.add = function(fun, cat) {
        this.tree.add(this.current, new Node(fun,cat));
    }
    
    // Clear children of current node
    this.removeChildren = function() {
        this.tree.find(this.current).children = [];
    }

    // Move current id to child number i
    this.toChild = function(i) {
        this.current.add(i);
    }

    // Return tree as string
    this.toString = function() {
        var s = "";
        function visit(node) {
            s += node.value.fun ? node.value.fun : "?" ;
            if (node.children.length == 0)
                return;
            for (i in node.children) {
            s += "(";
                visit(node.children[i]);
            s += ")";
            }
        }
        visit(this.tree.root);
        return s;
    }
}

