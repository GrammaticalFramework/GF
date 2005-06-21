package de.uka.ilkd.key.ocl.gf;

/**
 * @author daniels
 *
 * An extender of MarkedArea that adds additional fields for the click-in 
 * functionality for HTML
 */
class HtmlMarkedArea extends MarkedArea {

        /** the start index in the HTML area */
        final public int htmlBegin;
        /** the end index in the HTML area */
        final public int htmlEnd;
        
        /**
         * A stand-alone constuctor which takes all values as arguments
         * @param b The starting position of the stored words
         * @param e The ending position of the stored words
         * @param p The position in the AST
         * @param w The actual text of this area
         * @param hb the start index in the HTML area
         * @param he the end index in the HTML area
         */
        public HtmlMarkedArea(int b, int e, LinPosition p, String w, int hb, int he) {
                super(b, e, p, w);
                this.htmlBegin = hb;
                this.htmlEnd = he;
        }
        
        /**
         * Creates a copy of orig, but with additional fields for the click-
         * in functionality for HTML
         * @param orig the original MarkedArea that should be extended
         * @param hb the start index in the HTML area
         * @param he the end index in the HTML area
         */
        HtmlMarkedArea(final MarkedArea orig, final int hb, final int he) {
                super(orig.begin, orig.end, orig.position, orig.words);
                this.htmlBegin = hb;
                this.htmlEnd = he;
        }
        
        public String toString() {
                return begin + " - " + end + " : " + position + " = '" + words + "' ; HTML: " + htmlBegin + " - " + htmlEnd;
        }
}
