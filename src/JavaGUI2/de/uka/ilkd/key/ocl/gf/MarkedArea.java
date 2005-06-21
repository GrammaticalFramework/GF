package de.uka.ilkd.key.ocl.gf;

/**
 * Stores quasi a piece of the linearization area, that has a word, a beginning
 * and an end in the linearization area and a position in the AST. It is used
 * for clicking in the text
 * 
 * @author janna
 */
class MarkedArea {
        /** The starting position of the stored words */
        final public int begin;
        /** The ending position of the stored words. 
         * Not final because of some punctuation issue daniels 
         * does not understand
         */
        public int end;
        /** The position in the AST */
        final public LinPosition position;
        /** The actual text of this area */
        final public String words;
        /**
         * Creates a new MarkedArea and initializes the fields with the parameters
         * @param b The starting position of the stored words
         * @param e The ending position of the stored words
         * @param p The position in the AST
         * @param w The actual text of this area
         */
        MarkedArea(int b, int e, LinPosition p, String w) {
                begin = b;
                end = e;
                position = p;
                words = w;
        }
        
        public String toString() {
                return begin + " - " + end + " : " + position + " = '" + words + "'";
        }
}

