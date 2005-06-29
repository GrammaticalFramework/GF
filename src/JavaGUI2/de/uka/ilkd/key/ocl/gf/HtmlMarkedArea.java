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
 *
 * An extender of MarkedArea that adds additional fields for the click-in 
 * functionality for HTML
 */
class HtmlMarkedArea extends MarkedArea {

        /** the start index in the HTML area */
        final public int htmlBegin;
        /** the end index in the HTML area */
        final public int htmlEnd;
        
        /**
         * A stand-alone constuctor which takes all values as arguments
         * @param b The starting position of the stored words
         * @param e The ending position of the stored words
         * @param p The position in the AST
         * @param w The actual text of this area
         * @param hb the start index in the HTML area
         * @param he the end index in the HTML area
         * @param lang the language of the current linearization
         */
        public HtmlMarkedArea(int b, int e, LinPosition p, String w, int hb, int he, String lang) {
                super(b, e, p, w, lang);
                this.htmlBegin = hb;
                this.htmlEnd = he;
        }
        
        /**
         * Creates a copy of orig, but with additional fields for the click-
         * in functionality for HTML
         * @param orig the original MarkedArea that should be extended
         * @param hb the start index in the HTML area
         * @param he the end index in the HTML area
         */
        HtmlMarkedArea(final MarkedArea orig, final int hb, final int he) {
                super(orig.begin, orig.end, orig.position, orig.words, orig.language);
                this.htmlBegin = hb;
                this.htmlEnd = he;
        }
        
        public String toString() {
                return begin + " - " + end + " : " + position + " = '" + words + "' ; HTML: " + htmlBegin + " - " + htmlEnd;
        }
}
