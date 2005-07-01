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
 * @author daniels
 * An object of this class represents a line in the GF abstract syntax tree
 * in the graphical form. Well, not really, but how this line appears there
 * and what its tooltip is is stored here.
 * RefinedAstNodeData has its tooltip from the function it represents, not
 * from its parent node.
 */
class RefinedAstNodeData extends AstNodeData {

        protected final Printname printname;
        protected final GfAstNode node;
        protected final String position;

        /**
         * all we have to know about an already refined node is its Printname
         * and the GF line representing it 
         * @param pname the suiting Printname, may be null if the line could 
         * not be parsed
         * @param node the GfAstNode for the current line
         * @param pos The position in the GF AST of this node in Haskell notation
         */
        public RefinedAstNodeData(Printname pname, GfAstNode node, String pos) {
                this.printname = pname;
                this.node = node;
                this.position = pos;
                if (logger.isLoggable(Level.FINEST)) {
                        logger.finest(this.toString() + " - " + getPosition());
                }
        }
        
        /**
         * @return the printname associated with this object
         */
        public Printname getPrintname() {
                return this.printname;
        }

        /**
         * @return displays the tooltip of the registered Printname,
         * which may be null
         */
        public String getParamTooltip() {
                if (getPrintname() != null) {
                        return getPrintname().getTooltipText();
                } else {
                        return null;
                }
        }
        
        public boolean isMeta() {
                return this.node.isMeta();
        }
        
        public String getPosition() {
                return this.position;
        }

        
        public String toString() {
                return this.node.getLine();
        }

}
