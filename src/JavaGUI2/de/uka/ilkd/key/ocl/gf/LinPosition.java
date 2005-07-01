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
class LinPosition {
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
        
        /**
         * Creates a position string in Haskell notation for the argument 
         * number nr of this node.
         * @param nr The number of the wanted argument
         * @return the position string for the nrth child
         */
        public String childPosition(int nr) {
                return this.position.substring(0, this.position.length() - 1) + "," + nr + "]";
        }

        /**
         * compares two position strings and returns true, if superPosition is
         * a prefix of subPosition, that is, if subPosition is in a subtree of
         * superPosition
         * @param superPosition the position String in Haskell notation 
         * ([0,1,0,4]) of the to-be super-branch of subPosition
         * @param subPosition the position String in Haskell notation 
         * ([0,1,0,4]) of the to-be (grand-)child-branch of superPosition
         * @return true iff superPosition denotes an ancestor of subPosition 
         */
        public static boolean isSubtreePosition(final LinPosition superPosition, final LinPosition subPosition) {
                if (superPosition == null || subPosition == null) {
                        return false;
                }
                String superPos = superPosition.position;
                String subPos = subPosition.position;
                if (superPos.length() < 2 || subPos.length() < 2 ) {
                        return false;
                }
                superPos = superPos.substring(1, superPos.length() - 1);
                subPos = subPos.substring(1, subPos.length() - 1);
                boolean result = subPos.startsWith(superPos);
                return result;
        }     
        
        /** 
         * Returns the biggest position of first and second.
         * Each word in the linearization area has the corresponding
         * position in the tree. The position-notion is taken from 
         * GF-Haskell, where empty position ("[]") 
         * represents tree-root, "[0]" represents  first child of the root,
         * "[0,0]" represents the first grandchild of the root etc.
         * So comparePositions("[0]","[0,0]")="[0]"
         */
        public static String maxPosition(String first, String second) {
                String common ="[]";
                int i = 1; 
                while ((i<Math.min(first.length()-1,second.length()-1))&&(first.substring(0,i+1).equals(second.substring(0,i+1)))) {
                        common=first.substring(0,i+1); 
                        i+=2;
                }
                if (common.charAt(common.length()-1)==']') {
                        return common;
                } else { 
                        return common+"]";
                }
        }
        
        public String toString() {
                return position + (correctPosition ? " correct" : " incorrect");
        }
}

