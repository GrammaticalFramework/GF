//Copyright (c) Hans-Joachim Daniels 2005
//
//This program is free software; you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation; either version 2 of the License, or
//(at your option) any later version.
//
//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.
//
//You can either finde the file LICENSE or LICENSE.TXT in the source 
//distribution or in the .jar file of this application

package de.uka.ilkd.key.ocl.gf;

import java.util.logging.*;

/**
 * @author hdaniels
 * An object of this type knows how it self should be rendered,
 * via Printname how its children should be rendered.
 * This means the tooltip information it got from there.
 * Knows nothing directly of the type of the node, which an object of this class
 * represents. That's whats GfAstNode is for.
 */
abstract class AstNodeData {
        protected static Logger logger = Logger.getLogger(DynamicTree2.class.getName());
        /**
         * @return the printname associated with this object
         */
        public abstract Printname getPrintname();

        /**
         * @return the parameter tooltip that this node has as a child
         * of its parent (who gave it to it depending on its position)
         */
        public abstract String getParamTooltip();

        /**
         * keeps track of the number of children of this node.
         * It has to be increased whenever a new child of this node is
         * added.
         */
        public int childNum = 0;
        /**
         * The position String in the GF AST for this node
         * in Haskell notation.
         */
        public final String position;
        /**
         * the GF node connected to this NodeData, not the JTree node
         */
        public final GfAstNode node;
        
        /**
         * If a subtyping witness is missing, then this flag is false
         */
        public boolean subtypingStatus = true;
        
        /**
         * if this is the active, selected, focused node
         */
        public final boolean selected;
        
        /**
         * The constraint, that is valid on this node.
         * If this node introduced a node itself and did not just inherit
         * one, they are just concatenated.
         * Until now, only the presence of a non-empty string here is used,
         * so that is not important yet.
         */
        public final String constraint;

        /**
         * some nodes like coerce should, if possible, be covered from the
         * users eyes. If this variable is greater than -1, the child
         * with that number is shown instead of this node.
         * This node will not appear in the tree.
         */
        public int showInstead = -1;
        
        /**
         * A simple setter constructor, that sets the fields of this class (except showInstead)
         * @param node the GF node connected to this NodeData, not the JTree node
         * @param pos The position String in the GF AST for this node
         * in Haskell notation.
         * @param selected if this is the active, selected, focused node
         * @param constraint The GF constraint introduced in this node
         */
        protected AstNodeData(GfAstNode node, String pos, boolean selected, String constraint) {
                this.node = node;
                this.position = pos;
                this.selected = selected;
                // I have no better idea, how to clutch them together, since
                // I don't need the content of this field right now.
                this.constraint = node.constraint + constraint; 
        }
        
        public String toString() {
                return this.node.getLine();
        }

}
