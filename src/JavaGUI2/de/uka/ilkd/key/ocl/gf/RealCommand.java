package de.uka.ilkd.key.ocl.gf;

import java.util.HashSet;
import java.util.HashMap;
import java.util.logging.*;

/**
 * @author daniels
 * This class represents a command, that is sent to GF
 */
class RealCommand extends GFCommand {
        
        private final static HashMap fullnames = new HashMap();

        protected final static Logger logger = Logger.getLogger(Printname.class.getName());
        
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
         */
        public RealCommand(final String myCommand, final HashSet processedSubcats, final PrintnameManager manager, final String myShowText, final boolean mlAbstract) {
                if (fullnames.isEmpty()) {
                        fullnames.put("w", "wrap");
                        fullnames.put("ch", "change head");
                        fullnames.put("rc", "refine from history:");
                }
                if (logger.isLoggable(Level.FINEST)) {
                        logger.finest("new RealCommand: " + myCommand);                        
                }
                this.command = myCommand.trim();
                this.showText = myShowText;
                //extract command type
                int ind = this.command.indexOf(' ');
                if (ind > -1) {
                        this.commandType = this.command.substring(0, ind);
                } else {
                        this.commandType = this.command;
                }
                
                //extract the argument position for wrapping commands and cut that part
                if (this.commandType.equals("w")) {
                        int beforeNumber = this.command.lastIndexOf(' ');
                        int protoarg;
                        try {
                                String argumentAsString = this.command.substring(beforeNumber + 1);
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
                        int beforePos = this.command.indexOf(' ');
                        int afterPos = this.command.lastIndexOf(' ');
                        if (beforePos > -1 && afterPos > beforePos) {
                                this.funName = this.command.substring(beforePos + 1, afterPos);
                        } else {
                                this.funName = null;
                        }
                } else {
                        int beforePos = this.command.indexOf(' ');
                        if (beforePos > -1) {
                                this.funName = this.command.substring(beforePos + 1);
                        } else {
                                this.funName = null;
                        }
                }
                
                //get corresponding Printname
                if (this.commandType.equals("d")) {
                        this.printname = Printname.delete;
                } else if (this.commandType.equals("ac")) {
                        this.printname = Printname.addclip;
                } else if (this.commandType.equals("ph")) {
                        this.printname = Printname.printhistory;
                } else if (this.commandType.equals("rc")) {
                        String subtree = this.showText.substring(3);
                        this.printname = new Printname(this.getCommand(), subtree + "\\$paste the previously copied subtree here<br>" + subtree);
                } else if (mlAbstract) {
                        //create a new Printname
                        this.printname = new Printname(funName, myShowText, null, null);
                } else {
                        this.printname = manager.getPrintname(funName);
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
        }

        /** the text that is to be displayed in the refinement lists */
        public String getDisplayText() {
                String result = "";
                if (fullnames.containsKey(this.commandType)) {
                        result = fullnames.get(this.commandType) + " '";
                }
                result = result + this.printname.getDisplayText();
                if (fullnames.containsKey(this.commandType)) {
                        result = result + "'";
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

        /**the text that is to be displayed as the tooltip */
        public String getTooltipText() {
                String result;
                result = this.printname.getTooltipText();
                if (this.commandType.equals("w")) {
                        String insertion = "<br>The selected sub-tree will be the " + (this.argument + 1) + ". argument of this refinement.";
                        result = Printname.htmlAppend(result, insertion);
                }
                return result;
        }

        public String getSubcat() {
                return this.printname.getSubcat();
        }
        
        protected final String showText;
}
