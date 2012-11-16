/* --- Tree representation -------------------------------------------------- */
function Node(value, children) {
    this.value = value;
    this.children = [];
    if (children != undefined)
        for (c in children)
            this.children.push( new Node(children[c],[]) );
    this.hasChildren = function(){
        return this.children.length > 0;
    }

    // generic HOF for traversing tree
    this.traverse = function(f) {
        function visit(node) {
            f(node);
            for (i in node.children) {
                visit(node.children[i]);
            }
        }
        visit(this);
    }
}

function Tree(value) {
    this.root = new Node(value, []);

    // add value as child of id
    this.add = function(id, value, children) {
        var x = this.find(id);
        x.children.push( new Node(value, children) );
    }

    // set tree at given id to 
    this.setSubtree = function(id, node) {
        var x = this.find(id);
        x.value = node.value;
        x.children = node.children;
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

    // generic HOF for traversing tree
    this.traverse = function(f) {
        function visit(id, node) {
            f(node);
            for (i in node.children) {
                var newid = new NodeID(id);
                newid.add(parseInt(i));
                visit(newid, node.children[i]);
            }
        }
        visit(new NodeID(), this.root);
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

    function ASTNode(fun, cat) {
        this.fun = fun;
        this.cat = cat;
    }

    this.tree = new Tree(new ASTNode(fun, cat));
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

    // Add a single fun at current node
    this.add = function(fun, cat) {
        this.tree.add(this.current, new ASTNode(fun,cat));
    }
    
    // Set entire subtree at current node
    this.setSubtree = function(node) {
        this.tree.setSubtree(this.current, node);
    }
    
    // Clear children of current node
    this.removeChildren = function() {
        this.tree.find(this.current).children = [];
    }

    // Move current ID to next hole
    this.toNextHole = function() {
        var id = new NodeID(this.current);
        
        // loop until we're at top
        while (id.get().length > 0) {
            var node = this.tree.find(id);

            // first check children
            for (i in node.children) {
                var child = node.children[i];
                if (!child.value.fun) {
                    var newid = new NodeID(id);
                    newid.add(i);
                    this.current = newid;
                    return;
                }
            }

            // otherwise go up to parent
            id.get().pop();
        }
    }

    // Move current id to child number i
    this.toChild = function(i) {
        this.current.add(i);
    }

    // 
    this.traverse = function(f) {
        this.tree.traverse(f);
    }

    // Return tree as string
    this.toString = function() {
        var s = "";
        function visit(node) {
            s += node.value.fun ? node.value.fun : "?" ;
            if (node.children.length == 0)
                return;
            for (i in node.children) {
                s += " (";
                visit(node.children[i]);
                s += ")";
            }
        }
        visit(this.tree.root);
        return s;
    }

    // Parse AST string into node tree
    this.parseTree = function(str) {

        function trim(str) {
            return str.trim().replace(/^\(\s*(.*)\s*\)$/, "$1");
        }

        function visit(node, str) {
            var parts = [];
            var ix_last = 0;
            var par_cnt = 0;
            for (i in str) {
                if (str[i] == " ") {
                    if (par_cnt == 0) {
                        parts.push(trim(str.substring(ix_last, i)));
                        ix_last = i;
                    }
                }
                else if (str[i] == "(")
                    par_cnt++;
                else if (str[i] == ")")
                    par_cnt--;
            }
            parts.push(trim(str.substring(ix_last)));

            var fun = parts.shift();
            var cat = null; // will be filled later

            node.value = new ASTNode(fun, cat);
            for (i in parts) {
                node.children.push(new Node());
                visit(node.children[i], parts[i]);
            }
        }
        var tree = new Node();
        visit(tree, str);
        return tree;
    }
}

