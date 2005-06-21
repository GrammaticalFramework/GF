/*
 * Created on 21.04.2005
 */
package de.uka.ilkd.key.ocl.gf;

/**
 * @author daniels
 * This class represents a link to a subcategory submenu. 
 * When it is encountered as the executed command, the corresponding
 * menu gets opened.
 */
public class LinkCommand extends GFCommand {
        
        public LinkCommand(final String subcat, final PrintnameManager manager) {
                this.command = subcat;
                this.newSubcat = false;
                this.commandType = Printname.SUBCAT;
                this.argument = -1;
                this.funName = null;
                this.printname = null;
                
                String dtext;
                String ttext;
                String fullname = manager.getFullname(subcat);
                if (fullname == null) {
                        dtext = getSubcat();
                        ttext = "open submenu " + getSubcat();
                } else {
                        ttext = Printname.htmlPrepend(Printname.extractTooltipText(fullname), "<i>open submenu</i> <br> ");
                        dtext = Printname.extractDisplayText(fullname);
                }
                this.tooltipText = ttext;
                this.displayText = dtext;
                
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
                return this.command;
        }
        
}
