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
 * @author daniels
 * A class that represents a GF command together with its printname.
 * It also gives easy access to all the abuses of the printname like
 * the subcategory, the tooltip, it knows about wrapping and so on.
 * 
 * The static stuff could produce problems if the editor is started
 * several times without closing it first. It probably should be moved
 * into a manager class.
 * Or the instances that get generated during one run all share the same
 * "pseudo-static" Hashtables. This is probably better.
 *
 */
abstract class GFCommand implements Comparable{
        
        /** 
         * the subcategory of this command
         */
        public abstract String getSubcat();
        /** 
         * the type of the command, r,w,ch,d,ac,... 
         */
        protected String commandType;
        /** 
         * the type of the command, r,w,ch,d,ac,... 
         */
        public String getCommandType(){
                return commandType;
        }
        /** 
         * for wrap, the number of the argument the current node should become 
         */
        protected int argument;
        
        /**
         * the actual command that this object should represent 
         */
        protected String command;
        /**
         * the actual command that this object should represent 
         */
        public String getCommand() {
                return command;
        }
        
        /**
         * the Printname corresponding to the GF fun of this command
         */
        protected Printname printname;
        /**
         * the Printname corresponding to the GF fun of this command
         */
        public Printname getPrintname(){
                return printname;
        }
        
        /**
         * the text that is to be displayed as the tooltip 
         */
        public abstract String getTooltipText();
        
        /**
         * the text that is to be displayed in the refinement lists 
         */
        public abstract String getDisplayText();
        
        /** 
         * the name of the fun that is used in this command 
         */
        protected String funName;
        
        /** 
         * if this is the first occurence of the current subcat 
         */
        protected boolean newSubcat;
        
        /** 
         * if this is the first occurence of the current subcat 
         */
        public boolean isNewSubcat() {
                return newSubcat;
        }
        
        /**
         * Compares two GFCommands.
         * LinkCommands are the least. Then the InputCommand (more than one
         * does not happen). If that does not decide, the display name as a String does.
         * @param o the other command.
         * @return see above.
         */
        public int compareTo(Object o) {
                if (this.equals(o)) {
                        return 0;
                }
                if (this instanceof LinkCommand && !(o instanceof LinkCommand)) {
                        return -1;
                }
                if (!(this instanceof LinkCommand) && (o instanceof LinkCommand)) {
                        return 1;
                }
                //LinkCommands are dealt with, so from now on, they don't occur
                if (this instanceof InputCommand && !(o instanceof InputCommand)) {
                        return -1;
                }
                if (!(this instanceof InputCommand) && (o instanceof InputCommand)) {
                        return 1;
                }
                if (! (o instanceof GFCommand)) {
                        //This should never occur!
                        return -1;
                } else {
                        GFCommand ocmd = (GFCommand)o;
                        return this.getDisplayText().compareTo(ocmd.getDisplayText());
                }
        }
        
        public String toString() {
                return getDisplayText() + " \n " + getTooltipText();
        }
        
}
