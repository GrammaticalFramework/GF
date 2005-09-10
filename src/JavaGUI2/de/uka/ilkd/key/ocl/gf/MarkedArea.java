//Copyright (c) Janna Khegai 2004, Hans-Joachim Daniels 2005
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
 * Stores quasi a piece of the linearization area, that has a word, a beginning
 * and an end in the linearization area and a position in the AST. It is used
 * for clicking in the text
 * 
 * @author janna, daniels
 */
class MarkedArea {
        /** 
         * The starting position of the stored words 
         */
        final public int begin;
        /** 
         * The ending position of the stored words. 
         * Not final because of some punctuation issue daniels 
         * does not understand
         */
        public int end;
        /** 
         * The position in the AST 
         */
        final public LinPosition position;
        /** 
         * The actual text of this area 
         */
        final public String words;
        /** 
         * the concrete grammar (or better, its linearization) 
         * this MarkedArea belongs to
         */
        final public String language;
        
        /** 
         * the start index in the HTML area 
         */
        final public int htmlBegin;
        /** 
         * the end index in the HTML area 
         */
        final public int htmlEnd;
        
        /**
         * A stand-alone constuctor which takes all values as arguments
         * @param begin The starting position of the stored words
         * @param end The ending position of the stored words
         * @param position The position in the AST
         * @param words The actual text of this area
         * @param htmlBegin the start index in the HTML area
         * @param htmlEnd the end index in the HTML area
         * @param language the language of the current linearization
         */
        public MarkedArea(int begin, int end, LinPosition position, String words, int htmlBegin, int htmlEnd, String language) {
                this.begin = begin;
                this.end = end;
                this.position = position;
                this.words = words;
                this.language = language;
                this.htmlBegin = htmlBegin;
                this.htmlEnd = htmlEnd;
        }
        
        
        public String toString() {
                return begin + " - " + end + " : " + position + " = '" + words + "' ; HTML: " + htmlBegin + " - " + htmlEnd;
        }
}

