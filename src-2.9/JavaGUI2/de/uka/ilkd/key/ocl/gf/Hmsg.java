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
 * The parsed format of the hmsg, that GF sents, if a command in java mode
 * was prefixed with [something].
 * And that something gets parsed and stored in this representation.
 * @author daniels
  */
class Hmsg {
        /**
         * The last read line
         */
        String lastline = "";
        /**
         * the String that should be appended to all commands of the 
         * next refinement menu
         */
        String appendix = null;
        /**
         *  If the editor shall probe once again for missing subtyping witnesses.
         *  Unused.
         */
        boolean onceAgain = false;
        /**
         * If false, no commands are executed automatically
         * in the next GF reading run 
         */
        boolean recurse = false;
        /**
         * if the newObject flag should be set
         */
        boolean newObject = false;
        /**
         * if the command changed the tree, so that it has to be rebuilt
         */
        boolean treeChanged = false;
        /**
         * if the display should be cleared
         */
        boolean clear = false;
        /**
         * A simple setter constructor
         * @param lastRead The last read line
         * @param appendix the String that should be appended to all commands of the 
         * next refinement menu
         * @param onceAgain
         * @param recurse If false, no commands are executed automatically
         * in the next GF reading run 
         * @param newObject if the newObject flag should be set
         * @param treeChanged if the command changed the tree, so that it has to be rebuilt
         * @param clear if the display should get cleared
         */
        public Hmsg(String lastRead, String appendix, boolean onceAgain, boolean recurse, boolean newObject, boolean treeChanged, boolean clear) {
                this.lastline = lastRead;
                this.appendix = appendix;
                this.onceAgain = onceAgain;
                this.recurse = recurse;
                this.newObject = newObject;
                this.treeChanged = treeChanged;
                this.clear = clear;
        }
}
