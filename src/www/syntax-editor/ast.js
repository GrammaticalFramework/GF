/* --- ID for a node in a tree ---------------------------------------------- */
function NodeID(x) {
    this.id = new Array();
    this.id.push(0);

    // Initialize from input
    if (x) {
        var type = Object.prototype.toString.call(x);
        switch (type) {
        case "[object Number]": this.id = [x]; break;
        case "[object String]": this.id = map(function(s){return parseInt(s)}, x.split(",")); break;
        case "[object Array]" : this.id = Array.clone(x); break;
        case "[object Object]": this.id = Array.clone(x.get()); break; // another NodeID
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

    // clone
    this.clone = function() {
        return new NodeID( this );
    }

    // Return NodeID as string
    this.toString = function() {
        return this.id.toString();
    }
}

/* --- Abstract Syntax Tree (with state)------------------------------------- */

function ASTNode(data) {
    for (var d in data) this[d]=data[d];
    this.children = [];
    if (data) for (var c in data.children) {
        this.children.push( new ASTNode(data.children[c]) );
    }
    this.hasChildren = function(){
        return this.children.length > 0;
    }

    // generic HOF for traversing tree
    this.traverse = function(f) {
        function visit(node) {
            f(node);
            for (var i in node.children) {
                visit(node.children[i]);
            }
        }
        visit(this);
    }
    
}

function AST(fun, cat) {

    // local helper function for building ASTNodes
    var newNode = function(fun, cat) {
        return new ASTNode({
            "fun": fun,
            "cat": cat,
            "string": "", // for String literals
            "deps": {}, // dependent types
            "children": []
        });
    }

    this.root = newNode(fun, cat);
    
    this.currentID = new NodeID(); // current id in tree
    this.currentNode = this.root; // current node in tree

    this.getCurrentNode = function() {
        return this.currentNode;
    }
    this.getCurrentID = function() {
        return this.currentID;
    }
    this.setCurrentID = function(id) {
        this.currentID = id; // new new NodeID(id);
        this.currentNode = this.find(this.currentID);
    }

    this.hasParent = function() {
        return this.currentID.get().length > 1;
        // return !this.atRoot();
    }
    this.atRoot = function() {
        return this.currentNode == this.root;
        // return !this.hasParent();
    }

    this.getRoot = function() {
        return this.root;
    }
    this.getFun = function() {
        return this.currentNode.fun;
    }
    this.setFun = function(f) {
        this.currentNode.fun = f;
    }
    this.getCat = function() {
        return this.currentNode.cat;
    }
    this.setCat = function(c) {
        this.currentNode.cat = c;
    }

    // Add a single type dependency at current node
    this.addDep = function(k, type) {
        // Add unassigned type variable to current
        this.currentNode.deps[k] = null;

        // Add actual type dep node
        var node = newNode(k, type);
        node.depid = k; // links to dep in parent
        this._add(this.currentID, node);
        return node;
    }

    // Add a node as child of current node
    this.add = function(fun, cat) {
        var node = newNode(fun,cat);
        this._add(this.currentID, node);
        return node;
    }

    // add node as child of id
    this._add = function(id, node) {
        var x = this.find(id);
        x.children.push(node);
    }

    // Wrap the current node inside another node
    // Doesn't check whether child_ix is within in range
    this.wrap = function(typeobj, child_ix) {
        var subtree = new ASTNode(this.currentNode);
        this.currentNode.fun = typeobj.name;
        this.currentNode.cat = typeobj.ret;
        this.currentNode.children = [];
        for (var i in typeobj.args) {
            this.add(null, typeobj.args[i]);
        }
        this.currentNode.children[child_ix] = subtree;
        return subtree;
    }

    // Wrap the current node inside another node
    // Doesn't check whether child_ix is within in range
    this.unwrap = function() {
        var parent_id = this.currentID.clone();
        parent_id.get().pop();
        if (parent_id.get().length==1) {
            this.root = this.currentNode;
            this.currentID = new NodeID();
        } else {
            var gparent_id = parent_id.clone();
            gparent_id.get().pop();
            var gparent = this.find(gparent_id);
            child_ix = parent_id.clone().get().pop();
            gparent.children[child_ix] = this.currentNode;
            this.currentID = parent_id;
        }
    }

    // Determine if current node is writable (empty/no children)
    this.is_writable=function() {
        var cn = this.currentNode;
        var blank = cn.fun == null || cn.children.length == 0;
        return blank;
    }

    // Determine if a fun would fit in a current hole
    this.fits_in_place=function(typeobj) {
        var cn = this.currentNode;

        var inplace = false;
        if (typeobj.args.length == cn.children.length) {
            var matches = 0;
            for (var i in typeobj.args) {
                if (typeobj.args[i] == cn.children[i].cat)
                    matches++;
            }
            inplace = matches == cn.children.length;
        }
        return inplace;
    }

    // Set entire subtree at current node
    this.setSubtree = function(node) {
        this._setSubtree(this.currentID, node);
    }
    
    // set tree at given id
    this._setSubtree = function(id, subtree) {
        var lid = Array.clone(id.get()); // clone NodeID array
        var node = this.root;

        if (lid.length==1) {
            // Insert at root
            this.currentNode = this.root = new ASTNode(subtree);
        }
        else {
            lid.shift(); // throw away root
            while (lid.length>1 && node.hasChildren()) {
                node = node.children[lid.shift()];
            }
            this.currentNode = node.children[lid.shift()] = new ASTNode(subtree);
        }
    }

    // Find a node in the tree from its ID
    this.find = function(id) {
        var lid = undefined
        if (Object.prototype.toString.call(id) == "[object Object]") {
            lid = Array.clone( id.get() );
        } else {
            alert("non-NodeID passed to AST.find()");
        }
        var node = this.root;
        if (lid[0] == 0) lid.shift();
        while (lid.length>0 && node.children.length>0) {
            node = node.children[lid.shift()];
        }
        if (lid.length>0)
            return undefined;
        return node;
    }
    
    // Clear children of current node
    this.removeChildren = function() {
        this.currentNode.children = [];
    }

    // Move current ID to next hole
    this.toNextHole = function() {
        var id = new NodeID(this.currentID);
        
        // loop until we're at top
        while (id.get().length > 0) {
            var node = this.find(id);

            // first check children
            for (var i in node.children) {
                var child = node.children[i];
                if (!child.fun) {
                    var newid = new NodeID(id);
                    newid.add(i);
                    this.setCurrentID(newid);
                    return;
                }
            }

            // otherwise go up to parent
            id.get().pop();
        }
    }

    // Return parent of current node
    this.getParent = function() {
        var parent_id = this.currentID.clone();
        parent_id.get().pop();
        return this.find(parent_id);
    }

    // Move current id to child number i
    this.toChild = function(i) {
        if (i < this.currentNode.children.length) {
            this.currentID.add(i);
            this.currentNode = this.currentNode.children[i];
        }
    }

    // generic HOF for traversing tree
    // this.traverse = function(f) {
    //     this.root.traverse(f);
    // }
    this.traverse = function(f) {
        function visit(id, node) {
            f(node);
            for (var i in node.children) {
                var newid = new NodeID(id);
                newid.add(parseInt(i));
                visit(newid, node.children[i]);
            }
        }
        visit(new NodeID(), this.root);
    }

    // Return tree as string
    this.toString = function() {
        var s = "";
        function visit(node) {
            if (node.cat == "String")
                s += '"' + ((node.string) ? node.string : "") + '"';
            else
                s += node.fun ? node.fun : "?" ;
            if (!node.hasChildren())
//            if (node.children.length == 0)
                return;
            for (var i in node.children) {
                s += " (";
                visit(node.children[i]);
                s += ")";
            }
        }
        visit(this.root);
        return s;
    }

}
    
// Parse type signature into a JSON object
// (This probably needs a better home)
AST.parse_type_signature = function(str) {
    var obj = {
        signature: str,
        type: undefined,
        name: undefined,
        deps: [],
        args: [],
        ret: undefined
    };
    var ix = str.indexOf(":");
    
    // judgement type
    var bits = str.substr(0, ix).trim().split(" ");
    obj.type = bits[0];

    // name (possibly with constructors)
    obj.name = bits.slice(1).join(" ");
    
    // function args (possibly with type dependency)
    var regex_dep = new RegExp(/\(\s*(.+?)\s*:\s*(.+?)\s*\)/);
    var bits = map(function(s){return s.trim()}, str.substr(ix+1).split("->"));
    for (var i=0 ; i<bits.length-1; i++) {
        var bit = bits[i];
        var m = regex_dep.exec(bit);
        if (m == null) {
            obj.args.push(bit);
        } else {
            // We have a type dependency
            obj.deps.push({ "id": m[1], "type": m[2] });
        }
    }

    //return type
    obj.ret = bits[bits.length-1];

    return obj;
}

