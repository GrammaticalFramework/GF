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
 * This class represents a link to a subcategory submenu. 
 * When it is encountered as the executed command, the corresponding
 * menu gets opened.
 */
public class LinkCommand extends GFCommand {
        
        /**
         * Since LinkCommand is not a real command, that is sent to GF,
         * most fields are given dummy values here.
         * The subcat is assigned its full display name and tooltip
         * @param subcat The subcategory of the menu behind this command
         * @param manager The PrintnameManager, that can map subcat to its
         * full name
         */
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
        
        /**
         * the text that is to be displayed as the tooltip 
         */        
        protected final String tooltipText;
        /**
         * the text that is to be displayed as the tooltip 
         */
        public String getTooltipText() {
                return tooltipText;
        }
        
        /** 
         * the text that is to be displayed in the refinement lists 
         */
        protected final String displayText;
        /** 
         * the text that is to be displayed in the refinement lists 
         */
        public String getDisplayText() {
                return displayText;
        }
        /** 
         * the subcategory of this command 
         */
        public String getSubcat() {
                return this.command;
        }
        
}
