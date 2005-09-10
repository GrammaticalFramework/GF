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

import java.util.HashSet;
import java.util.HashMap;
import java.util.logging.*;

/**
 * @author daniels
 * This class represents a command, that is sent to GF.
 * TODO Refactor the chain command stuff out of this class and make it a subclass
 */
class RealCommand extends GFCommand {
        
        /**
         * maps shorthands to fullnames
         */
        private final static HashMap fullnames = new HashMap();

        private final static Logger logger = Logger.getLogger(Printname.class.getName());
        
        /**
         * The number of undo steps that is needed to undo this fun call
         */
        public final int undoSteps;

        /**
         * The text that GF sent to describe the command
         */
        protected final String showText;
        
        protected final String subcat;
        
        /**
         * Creates a Command that stands for a GF command, no link command
         * sets all the attributes of this semi-immutable class.
         * @param myCommand the actual GF command
         * @param processedSubcats
         * @param manager maps funs to previously read Printnames. 
         * Thus needs to be the same object.
         * @param myShowText The text GF prints in the show part of the XML
         * which should be the command followed by the printname
         * @param mlAbstract is true, iff the menu language is set to Abstract
         * Then no preloaded printnames are used.
         * @param toAppend will be appended to the command, that is sent to GF.
         * Normally, toAppend will be the empty String "". 
         * But it can be a chain command's second part. 
         * It will not be shown to the user.
         */
        public RealCommand(final String myCommand, final HashSet processedSubcats, final PrintnameManager manager, final String myShowText, final boolean mlAbstract, final String toAppend) {
                this(myCommand, processedSubcats, manager, myShowText, mlAbstract, toAppend, 1, null, null);
        }
        
        /**
         * Creates a Command that stands for a GF command, no link command
         * sets all the attributes of this semi-immutable class.
         * @param myCommand the actual GF command
         * @param processedSubcats
         * @param manager maps funs to previously read Printnames. 
         * Thus needs to be the same object.
         * @param myShowText The text GF prints in the show part of the XML
         * which should be the command followed by the printname
         * @param mlAbstract is true, iff the menu language is set to Abstract
         * Then no preloaded printnames are used.
         * @param toAppend will be appended to the command, that is sent to GF.
    	 * Normally, toAppend will be the empty String "". 
    	 * But it can be a chain command's second part. 
    	 * It will not be shown to the user.
         * @param undoSteps The number of undo steps that is needed to undo this fun call
         * @param printnameFun If the fun, that selects the printname, should not be read from
         * myCommand. For single commands, this is the only fun. For chain command, the last is
         * taken. With this parameter, this behaviour can be overwritten
         * @param subcat Normally, every fun has its own Printname, which has a fixed
         * category. Sometimes, for the properies of self for example, 
         * this should be overwritten. If null, the subcat from the printname is used.
         */
        public RealCommand(final String myCommand, final HashSet processedSubcats, final PrintnameManager manager, final String myShowText, final boolean mlAbstract, String toAppend, int undoSteps, String printnameFun, String subcat) {
                if (fullnames.isEmpty()) {
                        fullnames.put("w", "wrap");
                        fullnames.put("r", "refine");
                        fullnames.put("ch", "change head");
                        fullnames.put("rc", "refine from history:");
                        fullnames.put("ph", "peel head");
                }
                if (logger.isLoggable(Level.FINEST)) {
                        logger.finest("new RealCommand: " + myCommand);                        
                }
                //if we have a ChainCommand, but undoSteps is just 1, count the undoSteps. 
                if ((undoSteps == 1) && (myCommand.indexOf(";;") > -1)) {
                        int occ = Utils.countOccurances(Utils.removeQuotations(myCommand), ";;") + 1;
                        this.undoSteps = occ;
                } else {
                        this.undoSteps = undoSteps;
                }
                this.command = myCommand.trim();
                this.showText = myShowText;
                this.subcat = subcat;

                //handle chain commands. 
                //Only the last command counts for the printname selection
                final String lastCommand;
                if (this.undoSteps > 1) {
                        //TODO: sth. like refine " f ;;d" ;; mp [2] will break here.
                        final int chainIndex = this.command.lastIndexOf(";;");
                        lastCommand = this.command.substring(chainIndex + 2).trim();
                } else {
                        lastCommand = this.command;
                }
                
                //extract command type
                int ind = lastCommand.indexOf(' ');
                if (ind > -1) {
                        this.commandType = lastCommand.substring(0, ind);
                } else {
                        this.commandType = lastCommand;
                }
                
                //extract the argument position for wrapping commands and cut that part
                if (this.commandType.equals("w") || this.commandType.equals("ph")) {
                        int beforeNumber = lastCommand.lastIndexOf(' ');
                        int protoarg;
                        try {
                                String argumentAsString = lastCommand.substring(beforeNumber + 1);
                                protoarg = Integer.parseInt(argumentAsString);
                        } catch (Exception e) {
                                protoarg = -1;
                        }
                        this.argument = protoarg;
                } else {
                        this.argument = -1;
                }
                
                //extract the fun of the GF command
                if (this.commandType.equals("w")) {
                        int beforePos = lastCommand.indexOf(' ');
                        int afterPos = lastCommand.lastIndexOf(' ');
                        if (beforePos > -1 && afterPos > beforePos) {
                                this.funName = lastCommand.substring(beforePos + 1, afterPos);
                        } else {
                                this.funName = null;
                        }
                } else {
                        int beforePos = lastCommand.indexOf(' ');
                        if (beforePos > -1) {
                                this.funName = lastCommand.substring(beforePos + 1);
                        } else {
                                this.funName = null;
                        }
                }
                
                //get corresponding Printname
                if (this.commandType.equals("d")) {
                        this.printname = Printname.delete;
                } else if (this.commandType.equals("ac")) {
                        this.printname = Printname.addclip;
                } else if (this.commandType.equals("rc")) {
                        String subtree = this.showText.substring(3);
                        this.printname = new Printname(this.getCommand(), subtree + "\\$paste the previously copied subtree here<br>" + subtree, false);
                } else if  (this.commandType.equals("ph")) {
                        this.printname = Printname.peelHead(this.argument);
                } else if (mlAbstract) {
                        //create a new Printname
                        this.printname = new Printname(funName, myShowText, null, null);
                } else { //standard case
                        if (printnameFun == null) {
                                this.printname = manager.getPrintname(funName);
                        } else {
                                //overwrite mode. Until now, only for properties of self.
                                this.printname = manager.getPrintname(printnameFun);
                        }
                }
                
                if (this.getSubcat() != null) {
                        if (processedSubcats.contains(this.getSubcat())) {
                                newSubcat = false;
                        } else {
                                newSubcat = true;
                                processedSubcats.add(this.getSubcat());
                        }
                } else {
                        newSubcat = false;
                }
                
                //now append toAppend before it is too late.
                //Only now, since it must not interfere with the things above.
                if (toAppend != null) {
                        this.command += toAppend;
                }
        }

        /** 
         * the text that is to be displayed in the refinement lists 
         */
        public String getDisplayText() {
                String result = "";
                if (this.printname.funPresent) {
                        result = this.printname.getDisplayText();
                } else {
		                if (fullnames.containsKey(this.commandType)) {
		                        result = fullnames.get(this.commandType) + " '";
		                }
		                result = result + this.printname.getDisplayText();
		                if (fullnames.containsKey(this.commandType)) {
		                        result = result + "'";
		                }
                }
                if (this.commandType.equals("w")) {
                        String insertion = " as argument " + (this.argument + 1);
                        result = result + insertion;
                }
                if (this.printname.type != null) {
                        result = result + " : " + this.printname.type;
                }
                return result;
        }

        /**
         * the text that is to be displayed as the tooltip 
         */
        public String getTooltipText() {
                String result;
                result = this.printname.getTooltipText();
                if (this.commandType.equals("w")) {
                        String insertion = "<br>The selected sub-tree will be the " + (this.argument + 1) + ". argument of this refinement.";
                        result = Printname.htmlAppend(result, insertion);
                }
                return result;
        }

        /**
         * returns the subcat of this command
         */
        public String getSubcat() {
                if (this.subcat == null) {
                        return this.printname.getSubcat();
                } else {
                        //special case, only for properties of self so far
                        return this.subcat;
                }
        }
}
