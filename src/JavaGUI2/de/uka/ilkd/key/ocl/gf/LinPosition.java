package de.uka.ilkd.key.ocl.gf;

/**
 * represents a position in the AST in Haskell notation together
 * with a flag that indicates whether at least one constraint does not hold or
 * if all hold (correct/incorrect). 
 * Class is immutable.
 */
public class LinPosition {
        /**
         * a position in the AST in Haskell notation
         */
        final public String position;

        /**
         * true means green, false means red (janna guesses)
         */
        final public boolean correctPosition;
        
        /**
         * creates a LinPosition 
         * @param p the position in the AST in Haskell notation like [0,1,2]
         * @param cor false iff there are violated constraints
         */
        LinPosition(String p, boolean cor) {
                position = p;
                correctPosition = cor;
        }
        
        public String toString() {
                return position + (correctPosition ? " correct" : " incorrect");
        }
}

