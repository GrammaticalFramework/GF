/*
 * Created on 27.04.2005
 *
 */
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
