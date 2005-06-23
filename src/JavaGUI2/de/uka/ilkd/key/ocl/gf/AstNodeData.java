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

/**
 * @author hdaniels
 * An object of this type knows how it self should be rendered,
 * via Printname how its children should be rendered.
 * This means the tooltip information it got from there.
 */
interface AstNodeData {
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
}
