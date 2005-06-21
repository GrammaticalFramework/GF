/*
 * Created on 27.04.2005
 *
 */
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
