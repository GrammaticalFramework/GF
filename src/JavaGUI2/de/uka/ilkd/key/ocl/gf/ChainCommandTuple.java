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
 * @author hdaniels
 * For chain commands, it is not just enough, to save the command sent to GF
 * and the respective show text.
 * Then it would be unclear, which fun should determine the used printname.
 * If none is given, the last one of a chain command is taken.
 * But if a solve for example is to follow, this does not work.
 * Thus, this class has some other fields to define the appearance of a 
 * chain command.
 */
class ChainCommandTuple extends StringTuple {
        /**
         * the fun, that selects the printname
         */
        final public String fun;
        /**
         * Here the subcat of fun can be overwritten.
         * Is used for the attributes of self.
         */
        final public String subcat;
        /**
         * normally, the ';;' are counted. But if we know, how many commands we
         * chain to each other, we can skip that step and use undoSteps instead
         */
        final public int undoSteps;
        
        /**
         * A simple setter constructor
         * @param command The command sent to GF
         * @param showtext The text, that GF would display if no matching 
         * printname is found.
         * @param fun The fun that selects the used printname
         * @param subcat the subcategory for the refinement menu, overwrites
         * the one defined in the printname
         * @param undoSteps how many undos are needed to undo this command
         */
        public ChainCommandTuple(String command, String showtext, String fun, String subcat, int undoSteps) {
                super(command, showtext);
                this.fun = fun;
                this.subcat = subcat;
                this.undoSteps = undoSteps;
        }

}
