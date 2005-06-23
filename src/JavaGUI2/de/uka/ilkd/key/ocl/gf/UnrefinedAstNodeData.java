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
 * @author daniels
 *
 * represents an open, unrefined node in the AST.
 * It knows, how it is called and described (tooltip).
 */
public class UnrefinedAstNodeData implements AstNodeData {
        protected final GfAstNode node;
        protected final String paramTooltip;
        
        /**
         * For a child we have to know its name, its type and the tooltip
         * @param pTooltip
         * @param node The GfAstNode for the current AST node, for which
         * this AstNodeData is the data for.
         */
        public UnrefinedAstNodeData(String pTooltip, GfAstNode node) {
                this.node = node;
                this.paramTooltip = pTooltip;
        }
        /**
         * @return no refinement, no printname, thus null
         */
        public Printname getPrintname() {
                return null;
        }

        /**
         * @return the parameter tooltip that this node has as a child
         * of its parent (who gave it to it depending on its position)
         */
        public String getParamTooltip() {
                return this.paramTooltip;
        }
        
        public boolean isMeta() {
                return this.node.isMeta();
        }
        
        public String toString() {
                return this.node.toString();
        }

}
