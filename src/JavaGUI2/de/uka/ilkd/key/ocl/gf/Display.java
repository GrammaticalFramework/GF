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

import java.awt.Font;
import java.awt.Rectangle;
import java.util.Vector;
import javax.swing.JEditorPane;

/**
 * @author daniels
 * Takes care of collecting the linearized text and the length calculations
 */
class Display {
        private final boolean doText;
        private final boolean doHtml;
        /** 
         * collects the linearization after each append.
         * what's in here are Strings 
         */
        private Vector linStagesHtml = new Vector();
        /** 
         * collects the linearization after each append.
         * what's in here are Strings 
         */
        private Vector linStagesText = new Vector();
        /** 
         * Is used to calculate the length of a HTML snipplet.
         * This pane is not displayed in hope to avoid any actual renderings
         * which would just slow the length calculation down.
         * Perhaps that's an abuse ...
         * And perhaps this pane is not needed
         */
        private JEditorPane htmlLengthPane = new JEditorPane();
        
        /** initializes this object, nothing special 
         * @param dt 1 if only text is to be shown, 2 for only HTML, 3 for both.
         * Other values are forbidden.
         */
        public Display(int dt) {
                switch (dt) {
                        case 1: 
                                doText = true;
                        		doHtml = false;
                        		break;
                        case 2: 
                                doText = false;
                        		doHtml = true;
                        		break;
                        case 3: 
                                doText = true;
                				doHtml = true;
                				break;
                       	default: 
                       	        doText = true;
                       			doHtml = true;
                       			break;
                }
                this.htmlLengthPane.setContentType("text/html");
                this.htmlLengthPane.setEditable(false);
        }

        
        /**
         * @param font The Font, that is to be used. If null, the default of JTextPane is taken.
         * @return the collected HTML text, that has been added to this object.
         * &lt;html&gt; tags are wrapped around the result, if not already there.
         */
        protected String getHtml(Font font) {
                if (!doHtml) {
                        return "";
                }
                String result;
                if (this.linStagesHtml.size() > 0) {
                        String fontface;
                        if (font != null) {
                                //fontface = " style=\"font-size:" + font.getSize()+ "pt\""; 
                                fontface = " style=\"font: " + font.getSize()+ "pt " + font.getName() + "\"";
                        } else {
                                fontface = "";
                        }
                        result ="<html><body" + fontface + ">" + this.linStagesHtml.get(this.linStagesHtml.size() - 1).toString() + "</body></html>";
                } else {
                        result = "";
                }
                return result;
        }

        /**
         * @return The collected pure text, that has been added to this object.
         */
        protected String getText() {
                if (!doText) {
                        return "";
                }
                String result;
                if (this.linStagesText.size() > 0) {
                        result = this.linStagesText.lastElement().toString();
                } else {
                        result = "";
                }
                return result;
        }
        
        /**
         * Appends the given text to the respective fields from
         * where it can be displayed later
         * @param text The pure text that is to be appended.
         * @param html The HTML text that is to be appended. 
         * Most likely the same as text
         */
        protected void addToStages(final String text, final String html) {
                //add to HTML
                if (doHtml) {
		                final String newStageHtml;
		                if (this.linStagesHtml.size() > 0) {
		                        newStageHtml = this.linStagesHtml.get(this.linStagesHtml.size() - 1) + html;
		                } else {
		                        newStageHtml = html;
		                }
		                this.linStagesHtml.add(newStageHtml);
                }
                
                //add to Text
                if (doText) {
		                final String newStageText;
		                if (this.linStagesText.size() > 0) {
		                        newStageText = linStagesText.get(linStagesText.size() - 1) + text;
		                } else {
		                        newStageText = text;
		                }                                
		                this.linStagesText.add(newStageText);
                }
        }        
        
        /**
         * Adds toAdd to both the pure text as the HTML fields, they are inherently the same, 
         * since they are mapped to the same position in the AST.
         * On the way of adding, some length calculations are done, which are used to
         * create an HtmlMarkedArea object, which is ready to be used in GFEditor2.
         * @param toAdd The String that the to-be-produced MarkedArea should represent
         * @param position The position String in Haskell notation
         * @param language the language of the current linearization
         * @return the HtmlMarkedArea object that represents the given information
         * and knows about its beginning and end in the display areas.
         */
        protected HtmlMarkedArea addAsMarked(String toAdd, LinPosition position, String language) {
                /** the length of the displayed HTML before the current append */
                int oldLengthHtml = 0;
                if (doHtml) {
		                if (this.linStagesHtml.size() > 0) {
		                        // is still in there. Does not absolutely need to be
		                        // cached in a global variable
		                        oldLengthHtml = this.htmlLengthPane.getDocument().getLength();
		                } else {
		                        oldLengthHtml = 0;
		                }
                }
                /** the length of the text before the current append */
                int oldLengthText = 0;
                if (doText) {
		                if (this.linStagesText.size() > 0) {
		                        // is still in there. Does not absolutely need to be
		                        // cached in a global variable
		                        oldLengthText = this.linStagesText.lastElement().toString().length();
		                } else {
		                        oldLengthText = 0;
		                }
                }
                addToStages(toAdd, toAdd);
                //calculate beginning and end
                //for HTML
                int newLengthHtml = 0;
                if (doHtml) {
		                final String newStageHtml = this.linStagesHtml.lastElement().toString();
		                final String newHtml = Printname.htmlPrepend(newStageHtml, "");
		                //yeah, daniels admits, this IS probably expensive
		                this.htmlLengthPane.setText(newHtml);
		                newLengthHtml = htmlLengthPane.getDocument().getLength();
		                if (newLengthHtml < oldLengthHtml) {
		                        newLengthHtml = oldLengthHtml;
		                }
                }
                //for text
                int newLengthText = 0;
                if (doText) {
                        newLengthText = this.linStagesText.lastElement().toString().length();
                }
                final HtmlMarkedArea hma = new HtmlMarkedArea(oldLengthText, newLengthText, position, toAdd, oldLengthHtml, newLengthHtml, language);
                return hma;
        }
        /**
         * To store the scroll state of the pure text linearization area
         */
        Rectangle recText = new Rectangle();
        /**
         * To store the scroll state of the HTML linearization area
         */
        Rectangle recHtml = new Rectangle();
        
        
        public String toString() {
                return getText();
        }
}
