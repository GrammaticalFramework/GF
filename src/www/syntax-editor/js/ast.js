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

function ASTNode(data) {
    for(var d in data) this[d]=data[d];
    this.children = [];
    // if (children != undefined)
    //     for (c in children) {
    //         this.children.push( new ASTNode(children[c]) );
    //     }
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

function AST(fun, cat) {

    // local helper function for building ASTNodes
    newNode = function(fun, cat) {
        return new ASTNode({
            "fun": fun,
            "cat": cat,
            "children": []
        });
    }

    this.root = newNode(fun, cat);
    
    this.current = new NodeID(); // current id in tree

    this.getFun = function() {
        return this.find(this.current).fun;
    }
    this.setFun = function(f) {
        this.find(this.current).fun = f;
    }
    this.getCat = function() {
        return this.find(this.current).cat;
    }
    this.setCat = function(c) {
        this.find(this.current).cat = c;
    }


    // Add a single fun at current node
    this.add = function(fun, cat) {
        this._add(this.current, newNode(fun,cat));
    }

    // add node as child of id
    this._add = function(id, node) {
        var x = this.find(id);
        x.children.push(node);
    }

    // Set entire subtree at current node
    this.setSubtree = function(node) {
        this._setSubtree(this.current, node);
    }
    
    // set tree at given id to 
    this._setSubtree = function(id, node) {
        var x = this.find(id);
        for (var n in node) x[n] = node[n];

        x.traverse(function(node){
            if (!node.children) node.children=[];
            // TODO: this doesn't work!
            //node = new ASTNode(node);
        })
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
    
    // Clear children of current node
    this.removeChildren = function() {
        this.find(this.current).children = [];
    }

    // Move current ID to next hole
    this.toNextHole = function() {
        var id = new NodeID(this.current);
        
        // loop until we're at top
        while (id.get().length > 0) {
            var node = this.find(id);

            // first check children
            for (i in node.children) {
                var child = node.children[i];
                if (!child.fun) {
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

    // generic HOF for traversing tree
    // this.traverse = function(f) {
    //     this.root.traverse(f);
    // }
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

    // Return tree as string
    this.toString = function() {
        var s = "";
        function visit(node) {
            s += node.fun ? node.fun : "?" ;
//            if (!node.hasChildren())
            if (node.children.length == 0)
                return;
            for (i in node.children) {
                s += " (";
                visit(node.children[i]);
                s += ")";
            }
        }
        visit(this.root);
        return s;
    }

}

