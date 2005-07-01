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
         * 
         * @return true iff this node represents an open leaf
         */
        public abstract boolean isMeta();
        /**
         * keeps track of the number of children of this node.
         * It has to be increased whenever a new child of this node is
         * added.
         */
        public int childNum = 0;
        /**
         * @return The position String in the GF AST for this node
         * in Haskell notation.
         */
        public abstract String getPosition();
}
