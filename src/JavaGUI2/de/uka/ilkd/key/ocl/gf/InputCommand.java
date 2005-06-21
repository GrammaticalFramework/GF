package de.uka.ilkd.key.ocl.gf;

import org.apache.log4j.Logger;

/**
 * @author daniels
 *
 *	This class represents a fake command, i.e. nothing is send to GF here.
 *	Instead this class acts more like a placeholder for the input dialog.
 *	This dialog is handled in GFEditor2 when a InputCommand is executed.
 *  Reason: No GUI stuff in the command.
 */
class InputCommand extends GFCommand {
        protected final static Logger logger = Logger.getLogger(Printname.class.getName());
        public static InputCommand intInputCommand = new InputCommand("read in Integer", 
                        "opens a dialog window in which an Integer can be entered", 
                        int.class, 
                        "Please enter an Integer");
        public static InputCommand stringInputCommand = new InputCommand("read in String", 
                        "opens a dialog window in which a String can be entered", 
                        String.class, 
                        "Please enter a String");
        
        protected InputCommand(final String description, final String ttt, Class type, final String title) {
                this.type = type;
                this.tooltipText = ttt;
                this.displayText = description;
                this.titleText = title;
                this.command = type.getName();
        }
        
        protected Class type;

        /**the text that is to be displayed as the title in the input window */        
        protected final String titleText;
        /**the text that is to be displayed as the title in the input window */
        public String getTitleText() {
                return titleText;
        }
        
        
        /**the text that is to be displayed as the tooltip */        
        protected final String tooltipText;
        /**the text that is to be displayed as the tooltip */
        public String getTooltipText() {
                return tooltipText;
        }
        
        /** the text that is to be displayed in the refinement lists */
        protected final String displayText;
        /** the text that is to be displayed in the refinement lists */
        public String getDisplayText() {
                return displayText;
        }
        /** the subcategory of this command */
        public String getSubcat() {
                return null;
        }
        
        /**
         * Checks if the given String can be converted into
         * the Type of this InputCommand (int or String)
         * @param o The String the user has typed
         * @param reason If the entered String is not parseable as the expected
         * type, an error message is appended to this StringBuffer, so better
         * give an empty one.
         * @return an Object whose toString() should send the right
         * thing to GF. 
         * Maybe null, if this "conversion" failed.
         */
        protected Object validate(String o, StringBuffer reason) {
                Object result = null;
                if (type == int.class) {
                        int i;
                        try {
                              i = Integer.parseInt(o);
                              result = new Integer(i);
                        } catch (NumberFormatException e) {
                                reason.append("Input format error: '" + o + "' is no Integer");
                        }
                } else if (type == String.class) {
                        if (o != null) {
                                result = "\"" + o.toString() + "\"";
                        }
                }
                return result;
        }
        
        /**
         * selects the suiting InputCommand for the given full name of a type
         * @param typeName at the moment, either int.class.getName() or String.class.getName()
         * @return intInputCommand for int, stringInputCommand for String or null otherwise 
         */
        protected static InputCommand forTypeName(String typeName) {
                InputCommand ic = null;
                if (typeName.equals(int.class.getName())) {
                        ic = InputCommand.intInputCommand;
                } else if (typeName.equals(String.class.getName())) {
                        ic = InputCommand.stringInputCommand;
                }
                return ic;
        }
        
}
