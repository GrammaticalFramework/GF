/*
 * Created on 27.04.2005
 */
package de.uka.ilkd.key.ocl.gf;

/**
 * @author daniels
 * An object of this class represents a line in the GF abstract syntax tree
 * in the graphical form. Well, not really, but how this line appears there
 * and what its tooltip is is stored here.
 * RefinedAstNodeData has its tooltip from the function it represents, not
 * from its parent node.
 */
class RefinedAstNodeData implements AstNodeData {

        protected final Printname printname;
        protected final GfAstNode node;

        /**
         * all we have to know about an already refined node is its Printname
         * and the GF line representing it 
         * @param pname the suiting Printname, may be null if the line could 
         * not be parsed
         * @param node the GfAstNode for the current line
         */
        public RefinedAstNodeData(Printname pname, GfAstNode node) {
                this.printname = pname;
                this.node = node;
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
        
        public String toString() {
                return this.node.getLine();
        }

}
