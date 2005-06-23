//Copyright (c) Janna Khegai 2004, Hans-Joachim Daniels 2005
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

