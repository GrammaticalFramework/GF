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

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Encapsulates everything that has to do with the linearization.
 * It is parsed here, and also the indices for click-in for pure text and HTML
 * are managed here. They get calculated in GfCapsule.
 * The result can be directly displayed, and this class has methods to translate
 * the indices back to the respective tree positions.
 * @author daniels
  */
class Linearization {
        /** 
         * linearization marking debug messages 
         */
        protected static Logger logger = Logger.getLogger(Linearization.class.getName());

        /**
         * contains all the linearization pieces as HtmlMarkedArea
         * Needed to know to which node in the AST a word in the linHtmlPane 
         * area belongs.
         */
        private Vector htmlOutputVector = new Vector();
        /**
         * the GF-output between <linearization> </linearization>  tags is stored here.
         * Must be saved in case the displayed languages are changed.
         * Only written in readLin
         */
        private String linearization = "";
        /** 
         * stack for storing the current position:
         * When displaying, we start with the root of the AST.
         * Whenever we start to display a node, it is pushed, and when it is completely displayed, we pop it.
         * Only LinPositions are stored in here
         * local in formLin?
         * */
        private Vector currentPosition = new Vector();

        /**
         * Must be the same Display as GFEditor2 uses
         */
        private Display display;
        /**
         *  to collect the linearization strings 
         */
        private HashMap linearizations = new HashMap();

        
        
        /**
         * Initializes this object and binds it to the given Display
         * @param display The display, that the editor uses
         */
        public Linearization(Display display) {
                this.display = display;
        }
        
        /**
         * @return Returns the linearizations.
         */
        HashMap getLinearizations() {
                return linearizations;
        }
        
        /**
         * @param linearization The linearization to set.
         */
        void setLinearization(String linearization) {
                this.linearization = linearization;
        }

        /**
         * resets the output mechanism.
         */
        void reset() {
                htmlOutputVector = new Vector();
        }

        /**
         * Returns the widest position (see comments to comparePositions) 
         * covered in the string from begin to end in the 
         * linearization area.
         * @param begin The index in htmlOutputVector of the first MarkedArea, that is possibly the max
         * @param end The index in htmlOutputVector of the last MarkedArea, that is possibly the max
         * @return the position in GF Haskell notation (hdaniels guesses)
         */
        private String findMax(int begin, int end) {
                String max = (((MarkedArea)this.htmlOutputVector.elementAt(begin)).position).position;
                for (int i = begin+1; i <= end; i++)
                        max = LinPosition.maxPosition(max,(((MarkedArea)this.htmlOutputVector.elementAt(i)).position).position);
                return max;
        }
        
        /**
         * Appends the string restString to display.
         * It parses the subtree tags and registers them.
         * The focus tag is expected to be replaced by subtree.
         * @param restString string to append, with tags in it.
         * @param clickable if true, the text is appended and the subtree tags are
         * parsed. If false, the text is appended, but the subtree tags are ignored. 
         * @param doDisplay true iff the output is to be displayed. 
         * Implies, if false, that clickable is treated as false.
         * @param language the current linearization language
         */
        private String appendMarked(String restString, final boolean clickable, boolean doDisplay, String language) {
                String appendedPureText = "";
                if (restString.length()>0) {
                        /** 
                         * the length of what is already displayed of the linearization.
                         * Alternatively: What has been processed in restString since
                         * subtreeBegin
                         */
                        int currentLength = 0;
                        /** position of &lt;subtree */
                        int subtreeBegin;
                        /** position of &lt;/subtree */
                        int subtreeEnd;
                        
                        if (clickable && doDisplay) {
                                subtreeBegin = Utils.indexOfNotEscaped(restString, "<subtree");
                                subtreeEnd = Utils.indexOfNotEscaped(restString, "</subtree");
                                // cutting subtree-tags:
                                while ((subtreeEnd>-1)||(subtreeBegin>-1)) {
                                        /** 
                                         * length of the portion that is to be displayed
                                         * in the current run of appendMarked.
                                         * For HTML this would have to be calculated
                                         * in another way.
                                         */
                                        final int newLength;

                                        if ((subtreeEnd==-1)||((subtreeBegin<subtreeEnd)&&(subtreeBegin>-1))) {
                                                final int subtreeTagEnd = Utils.indexOfNotEscaped(restString, ">",subtreeBegin);                                      
                                                final int nextOpeningTagBegin = Utils.indexOfNotEscaped(restString, "<", subtreeTagEnd);
                                                
                                                //getting position:
                                                final int posStringBegin = Utils.indexOfNotEscaped(restString, "[",subtreeBegin);
                                                final int posStringEnd = Utils.indexOfNotEscaped(restString, "]",subtreeBegin);
                                                final LinPosition position = new LinPosition(restString.substring(posStringBegin,posStringEnd+1),
                                                                restString.substring(subtreeBegin,subtreeTagEnd).indexOf("incorrect")==-1);
                                                
                                                // is something before the tag?
                                                // is the case in the first run
                                                if (subtreeBegin-currentLength>1) {
                                                        if (logger.isLoggable(Level.FINER)) {
                                                                logger.finer("SOMETHING BEFORE THE TAG");
                                                        }
                                                        if (this.currentPosition.size()>0)
                                                                newLength = register(currentLength, subtreeBegin, (LinPosition)this.currentPosition.elementAt(this.currentPosition.size()-1), restString, language);
                                                        else
                                                                newLength = register(currentLength, subtreeBegin, new LinPosition("[]",
                                                                                restString.substring(subtreeBegin,subtreeTagEnd).indexOf("incorrect")==-1), restString, language);
                                                } else {       // nothing before the tag:
                                                        //the case in the beginning
                                                        if (logger.isLoggable(Level.FINER)) {
                                                                logger.finer("NOTHING BEFORE THE TAG");             
                                                        }
                                                        if (nextOpeningTagBegin>0) {
                                                                newLength = register(subtreeTagEnd+2, nextOpeningTagBegin, position, restString, language);
                                                        } else {
                                                                newLength = register(subtreeTagEnd+2, restString.length(), position, restString, language);
                                                        }
                                                        restString = removeSubTreeTag(restString,subtreeBegin, subtreeTagEnd+1);
                                                }
                                                currentLength += newLength ;
                                        } else {
                                                // something before the </subtree> tag:
                                                if (subtreeEnd-currentLength>1) {
                                                        if (logger.isLoggable(Level.FINER)) {
                                                                logger.finer("SOMETHING BEFORE THE </subtree> TAG");
                                                        }
                                                        if (this.currentPosition.size()>0)
                                                                newLength = register(currentLength, subtreeEnd, (LinPosition)this.currentPosition.elementAt(this.currentPosition.size()-1), restString, language);
                                                        else
                                                                newLength = register(currentLength, subtreeEnd, new LinPosition("[]",
                                                                                restString.substring(subtreeBegin,subtreeEnd).indexOf("incorrect")==-1), restString, language);
                                                        currentLength += newLength ;
                                                }
                                                // nothing before the tag:
                                                else 
                                                        // punctuation after the </subtree> tag:
                                                        if (restString.substring(subtreeEnd+10,subtreeEnd+11).trim().length()>0)
                                                        {
                                                                if (logger.isLoggable(Level.FINER)) {
                                                                        logger.finer("PUNCTUATION AFTER THE </subtree> TAG"
                                                                                        + "/n" + "STRING: " + restString);
                                                                }
                                                                //cutting the tag first!:
                                                                if (subtreeEnd>0) {
                                                                        restString =  removeSubTreeTag(restString,subtreeEnd-1, subtreeEnd+9); 
                                                                } else {
                                                                        restString = removeSubTreeTag(restString,subtreeEnd, subtreeEnd+9);
                                                                }
                                                                if (logger.isLoggable(Level.FINER)) {
                                                                        logger.finer("STRING after cutting the </subtree> tag: "+restString);
                                                                }
                                                                // cutting the space in the last registered component:
                                                                if (this.htmlOutputVector.size()>0) {
                                                                        ((MarkedArea)this.htmlOutputVector.elementAt(this.htmlOutputVector.size()-1)).end -=1; 
                                                                        if (currentLength>0) {
                                                                                currentLength -=1; 
                                                                        }
                                                                }
                                                                if (logger.isLoggable(Level.FINER)) {
                                                                        logger.finer("currentLength: " + currentLength);
                                                                }
                                                                // register the punctuation:
                                                                if (this.currentPosition.size()>0) {
                                                                        newLength = register(currentLength, currentLength+2, (LinPosition)this.currentPosition.elementAt(this.currentPosition.size()-1), restString, language);
                                                                } else {
                                                                        newLength = register(currentLength, currentLength+2, new LinPosition("[]",
                                                                                        true), restString, language);
                                                                }
                                                                currentLength += newLength ;
                                                        } else {
                                                                // just cutting the </subtree> tag:
                                                                restString = removeSubTreeTag(restString,subtreeEnd, subtreeEnd+10);
                                                        }
                                        }
                                        subtreeEnd = Utils.indexOfNotEscaped(restString, "</subtree");
                                        subtreeBegin = Utils.indexOfNotEscaped(restString, "<subtree");
                                        //          if (debug2) 
                                        //                System.out.println("/subtree index: "+l2 + "<subtree"+l);
                                        if (logger.isLoggable(Level.FINER)) { 
                                                logger.finer("<-POSITION: "+subtreeBegin+" CURRLENGTH: "+currentLength
                                                                + "\n STRING: "+restString.substring(currentLength));
                                        }
                                } //while
                        } else { //no focus, no selection enabled (why ever)
                                //that means, that all subtree tags are removed here.
                                if (logger.isLoggable(Level.FINER)) {
                                        logger.finer("NO SELECTION IN THE TEXT TO BE APPENDED!");
                                }
                                //cutting tags from previous focuses if any:
                                int r = Utils.indexOfNotEscaped(restString, "</subtree>");
                                while (r>-1) {
                                        // check if punktualtion marks like . ! ? are at the end of a sentence:
                                        if (restString.charAt(r+10)==' ')
                                                restString = restString.substring(0,r)+restString.substring(r+11);
                                        else
                                                restString = restString.substring(0,r)+restString.substring(r+10);
                                        r = Utils.indexOfNotEscaped(restString, "</subtree>");
                                }
                                r = Utils.indexOfNotEscaped(restString, "<subtree");
                                while (r>-1) {
                                        int t = Utils.indexOfNotEscaped(restString, ">", r);
                                        if (t<restString.length()-2)
                                                restString = restString.substring(0,r)+restString.substring(t+2);
                                        else 
                                                restString = restString.substring(0,r);
                                        r = Utils.indexOfNotEscaped(restString, "<subtree");
                                }
                        }
                        // appending:
                        restString = unescapeTextFromGF(restString);
                        if (logger.isLoggable(Level.FINER)) {
                                logger.finer(restString);
                        }
                        appendedPureText = restString.replaceAll("&-","\n ");
                        //display the text if not already done in case of clickable
                        if (!clickable && doDisplay) {
                                // the text has only been pruned from markup, but still needs
                                // to be displayed
                                this.display.addToStages(appendedPureText, appendedPureText);
                        }
                } // else: nothing to append
                return appendedPureText;
        }
        
        /**
         * Replaces a number of escaped characters by an unescaped version
         * of the same length
         * @param string The String with '\' as the escape character
         * @return the same String, but with escaped characters removed
         * 
         */
        static String unescapeTextFromGF(String string) {
                final String more = "\\"+">";
                final String less = "\\"+"<";
                //%% by daniels, linearization output will be changed drastically 
                //(or probably will), so for now some hacks for -> and >=
                string = Utils.replaceAll(string, "-" + more, "-> ");
                string = Utils.replaceAll(string, "-" + more,"-> ");
                string = Utils.replaceAll(string, more," >");
                string = Utils.replaceAll(string, less," <");
                //an escaped \ becomes a single \
                string = Utils.replaceAll(string, "\\\\"," \\");
                return string;
        }
        


        /**
         * The substring from start to end in workingString, together with
         * position is saved as a MarkedArea in this.htmlOutputVector.
         * The information from where to where the to be created MarkedArea
         * extends, is calculated in this method.
         * @param start The position of the first character in workingString
         * of the part, that is to be registered.
         * @param end The position of the last character in workingString
         * of the part, that is to be registered.
         * @param position the position in the tree that corresponds to
         * the to be registered text
         * @param workingString the String from which the displayed
         * characters are taken from
         * @param language the current linearization language
         * @return newLength, the difference between end and start
         */
        private int register(int start, int end, LinPosition position, String workingString, String language) {
                /**
                 * the length of the piece of text that is to be appended now
                 */
                final int newLength = end-start;
                // the tag has some words to register:
                if (newLength>0) {
                        final String stringToAppend = workingString.substring(start,end);
                        //if (stringToAppend.trim().length()>0) {

                        //get oldLength and add the new text
                        String toAdd = unescapeTextFromGF(stringToAppend);
                        final MarkedArea hma = this.display.addAsMarked(toAdd, position, language);
                        this.htmlOutputVector.add(hma);
                        if (logger.isLoggable(Level.FINER)) {
                                logger.finer("HTML added  :      " + hma);
                        }
                } //some words to register
                return newLength;
        }
        
        /**
         * removing subtree-tag in the interval start-end 
         * and updating the coordinates after that
         * basically part of appendMarked
         * No subtree is removed, just the tag. 
         * @param s The String in which the subtree tag should be removed
         * @param start position in restString
         * @param end position in restString
         * @return the String without the subtree-tags in the given interval
         */
        private String removeSubTreeTag (final String s, final int start, final int end) {
                String restString = s;
                if (logger.isLoggable(Level.FINER)) { 
                        logger.finer("removing: "+ start +" to "+ end);
                }
                int difference =end-start+1;
                int positionStart, positionEnd;
                if (difference>20) {
                        positionStart = Utils.indexOfNotEscaped(restString, "[", start);
                        positionEnd = Utils.indexOfNotEscaped(restString, "]", start);
                        
                        currentPosition.addElement(new LinPosition(
                                        restString.substring(positionStart, positionEnd+1),
                                        restString.substring(start,end).indexOf("incorrect")==-1));
                } else if (currentPosition.size()>0) {
                                currentPosition.removeElementAt(currentPosition.size()-1);
                }
                if (start>0) {
                        restString = restString.substring(0,start)+restString.substring(end+1);
                } else{
                        restString = restString.substring(end+1);
                }
                return restString;
        }
        
        /**
         * Goes through the list of MarkedAreas and creates MarkedAreaHighlightingStatus
         * objects for them, which contain fields for incorrect constraints
         * and if they belong to the selected subtree.
         * @param focusPosition The AST position of the selected node
         * @return a Vector of MarkedAreaHighlightingStatus
         */
        Vector calculateHighlights(LinPosition focusPosition) {
                Vector result = new Vector();
                final HashSet incorrectMA = new HashSet();
                for (int i = 0; i<htmlOutputVector.size(); i++)  {
                        final MarkedArea ma = (MarkedArea)this.htmlOutputVector.elementAt(i);
                        //check, if and how ma should be highlighted
                        boolean incorrect = false;
                        boolean focused = false;
                        if (logger.isLoggable(Level.FINER)) {
                                logger.finer("Highlighting: " + ma);
                        }
                        if (!ma.position.correctPosition) {
                                incorrectMA.add(ma);
                                incorrect = true;
                        } else {
                                //This could be quadratic, but normally on very
                                //few nodes constraints are introduced, so
                                //incorrectMA should not contain many elements.
                                MarkedArea incMA;
                                for (Iterator it = incorrectMA.iterator(); !incorrect && it.hasNext();) {
                                        incMA = (MarkedArea)it.next();
                                        if (LinPosition.isSubtreePosition(incMA.position, ma.position)) {
                                                incorrect = true;
                                        }
                                }
                        }
                        if (LinPosition.isSubtreePosition(focusPosition, ma.position)) {
                                focused = true;
                        }
                        MarkedAreaHighlightingStatus mahs = new MarkedAreaHighlightingStatus(focused, incorrect, ma);
                        result.add(mahs);
                }
                return result;
        }

        /**
         * Parses the linearization XML and calls outputAppend
         * @param langMan The LangMenuModel, but that is an inner class and only
         * the methods in the Interface LanguageManager are used here.
         */
        void parseLin(LanguageManager langMan) {
                linearizations.clear();
                boolean firstLin=true; 
                //read first line like '    <lin lang=Abstract>'
                String readResult = linearization.substring(0,linearization.indexOf('\n'));
                //the rest of the linearizations
                String lin = linearization.substring(linearization.indexOf('\n')+1);
                //extract the language from readResult
                int ind = Utils.indexOfNotEscaped(readResult, "=");
                int ind2 = Utils.indexOfNotEscaped(readResult, ">");
                /** The language of the linearization */
                String language = readResult.substring(ind+1,ind2);
                //the first direct linearization
                readResult = lin.substring(0,lin.indexOf("</lin>"));
                //the rest
                lin = lin.substring(lin.indexOf("</lin>"));
                while (readResult.length()>1) {
                        langMan.add(language,true);
                        // selected?
                        boolean visible = langMan.isLangActive(language);
                        if (visible && !firstLin) {   
                                // appending sth. linearizationArea
                                this.display.addToStages("\n************\n", "<br><hr><br>");
                        }
                        if (logger.isLoggable(Level.FINER)) {
                                logger.finer("linearization for the language: "+readResult);
                        }

                        // change the focus tag into a subtree tag.
                        // focus handling now happens in GFEditor2::formTree
                        String readLin = readResult;
                        readLin = Utils.replaceNotEscaped(readLin, "<focus", "<subtree");
                        readLin = Utils.replaceNotEscaped(readLin, "</focus", "</subtree");
                        
                        final boolean isAbstract = "Abstract".equals(language);                        
                        // now do appending and registering
                        String linResult = appendMarked(readLin + '\n', !isAbstract, visible, language);

                        if (visible) {
                                firstLin = false;
                        }
                        linearizations.put(language, linResult);
                        // read </lin>
                        lin = lin.substring(lin.indexOf('\n')+1);
                        // read lin or 'end'
                        if (lin.length()<1) {
                                break;
                        }
                        
                        readResult = lin.substring(0,lin.indexOf('\n'));
                        lin = lin.substring(lin.indexOf('\n')+1);
                        if (readResult.indexOf("<lin ")!=-1){
                                //extract the language from readResult
                                ind = readResult.indexOf('=');
                                ind2 = readResult.indexOf('>');
                                language = readResult.substring(ind+1,ind2);
                                readResult = lin.substring(0,lin.indexOf("</lin>"));
                                lin = lin.substring(lin.indexOf("</lin>"));
                        }  
                }
        }

        /**
         * 
         * @param language The concrete language of choice
         * @return The linearization of the subtree starting with the currently
         * selected node in the given language.
         */
        String getSelectedLinearization(final String language, final LinPosition focusPosition) {
                StringBuffer sel = new StringBuffer();
                for (int i = 0; i<htmlOutputVector.size(); i++)  {
                        final MarkedArea ma = (MarkedArea)htmlOutputVector.elementAt(i);
                        if (language.equals(ma.language) && LinPosition.isSubtreePosition(focusPosition, ma.position)) {
                                sel.append(ma.words);
                        }
                }
                return sel.toString();
        }

        /**
         * Takes the index of a caret position in the linearization area
         * and returns the language of the clicked linearization.
         * GF lists the different concrete languages one after the other,
         * and this method looks at the linearization snipplets to get
         * the language.
         * If somehow no language can be found out, 'Abstract' is returned
         * @param pos The index of the caret position
         * @param htmlClicked If the HTML JTextPane has been clicked,
         * false for the JTextArea
         * @return the name of the concrete grammar (language) or Abstract
         * (see above).
         */
        String getLanguageForPos(int pos, final boolean htmlClicked) {
                final String language;
                MarkedArea ma = null;
                if (htmlClicked) {
                        //HTML
                        for (int i = 0; i < htmlOutputVector.size(); i++) {
                                if ((pos >= ((MarkedArea)htmlOutputVector.get(i)).htmlBegin) && (pos <= ((MarkedArea)htmlOutputVector.get(i)).htmlEnd)) {
                                        ma = (MarkedArea)htmlOutputVector.get(i);
                                        break;
                                }
                        }
                } else {
                        //assumably pure text
                        for (int i = 0; i < htmlOutputVector.size(); i++) {
                                if ((pos >= ((MarkedArea)htmlOutputVector.get(i)).begin) && (pos <= ((MarkedArea)htmlOutputVector.get(i)).end)) {
                                        ma = (MarkedArea)htmlOutputVector.get(i);
                                        break;
                                }
                        }
                        
                }
                if (ma != null && ma.language != null) {
                        language = ma.language;
                } else {
                        language = "Abstract";
                }
                return language;
        }

        /**
         * The user has either just clicked in the linearization area,
         * which means start == end, or he has selected a text, so that 
         * start < end.
         * This method figures out the smallest subtree whose linearization
         * completely encompasses the area from start to end.
         * This method is for the HTML linearization area.
         * @param start The index of the caret position at the begin of the selection
         * @param end The index of the caret position at the end of the selection
         * @return The 'root' of the subtree described above
         */
        String markedAreaForPosHtml(int start, int end) {
                if (htmlOutputVector.isEmpty()) {
                        return null;
                }
                String position = null; //the result
                String jPosition ="", iPosition="";
                MarkedArea jElement = null;
                MarkedArea iElement = null;
                int j = 0;
                int i = htmlOutputVector.size()-1;

                if (logger.isLoggable(Level.FINER))
                        for (int k=0; k < htmlOutputVector.size(); k++) { 
                                logger.finer("element: "+k+" begin "+((MarkedArea)htmlOutputVector.elementAt(k)).htmlBegin+" "
                                                + "\n-> end: "+((MarkedArea)htmlOutputVector.elementAt(k)).htmlEnd+" "       
                                                + "\n-> position: "+(((MarkedArea)htmlOutputVector.elementAt(k)).position).position+" "   
                                                + "\n-> words: "+((MarkedArea)htmlOutputVector.elementAt(k)).words);   
                        }
                // localizing end:
                while ((j < htmlOutputVector.size()) && (((MarkedArea)htmlOutputVector.elementAt(j)).htmlEnd < end)) {
                        j++;
                }
                // localising start:
                while ((i >= 0) && (((MarkedArea)htmlOutputVector.elementAt(i)).htmlBegin > start)) {
                        i--;
                }
                if (logger.isLoggable(Level.FINER)) { 
                        logger.finer("i: "+i+" j: "+j);
                }
                if ((j < htmlOutputVector.size())) {
                        jElement = (MarkedArea)htmlOutputVector.elementAt(j);
                        jPosition = jElement.position.position;
                        // less & before:
                        if (i == -1) { // less:
                                if (end>=jElement.htmlBegin) {
                                        iElement = (MarkedArea)htmlOutputVector.elementAt(0);
                                        iPosition = iElement.position.position;
                                        if (logger.isLoggable(Level.FINER)) { 
                                                logger.finer("Less: "+jPosition+" and "+iPosition);
                                        }
                                        position = findMax(0,j);
                                        if (logger.isLoggable(Level.FINER)) { 
                                                logger.finer("SELECTEDTEXT: "+position+"\n");
                                        }
                                } else { // before: 
                                        if (logger.isLoggable(Level.FINER)) { 
                                                logger.finer("BEFORE vector of size: "+htmlOutputVector.size());
                                        }
                                }
                        } else { // just: 
                                iElement = (MarkedArea)htmlOutputVector.elementAt(i);
                                iPosition = iElement.position.position;
                                if (logger.isLoggable(Level.FINER)) { 
                                        logger.finer("SELECTED TEXT Just: "+iPosition +" and "+jPosition+"\n");
                                }
                                position = findMax(i,j);
                                if (logger.isLoggable(Level.FINER)) { 
                                        logger.finer("SELECTEDTEXT: "+position+"\n");
                                }
                        }
                }  else if (i>=0) { // more && after:
                        iElement = (MarkedArea)htmlOutputVector.elementAt(i);
                        iPosition = iElement.position.position;
                        // more
                        if (start<=iElement.htmlEnd) { 
                                jElement = (MarkedArea)htmlOutputVector.elementAt(htmlOutputVector.size()-1);
                                jPosition = jElement.position.position;
                                if (logger.isLoggable(Level.FINER)) { 
                                        logger.finer("MORE: "+iPosition+ " and "+jPosition);
                                }
                                position = findMax(i,htmlOutputVector.size()-1);
                                if (logger.isLoggable(Level.FINER)) { 
                                        logger.finer("SELECTEDTEXT: "+position+"\n");
                                }
                                // after:
                        } else if (logger.isLoggable(Level.FINER)) { 
                                logger.finer("AFTER vector of size: "+htmlOutputVector.size());
                        }
                } else { // bigger:
                        iElement = (MarkedArea)htmlOutputVector.elementAt(0);
                        iPosition = iElement.position.position;
                        jElement = (MarkedArea)htmlOutputVector.elementAt(htmlOutputVector.size()-1);
                        jPosition = jElement.position.position;
                        if (logger.isLoggable(Level.FINER)) { 
                                logger.finer("BIGGER: "+iPosition +" and "+jPosition+"\n"         
                                                + "\n-> SELECTEDTEXT: []\n");
                        }
                        position = "[]";
                }
                return position;
        }

        /**
         * The user has either just clicked in the linearization area,
         * which means start == end, or he has selected a text, so that 
         * start < end.
         * This method figures out the smallest subtree whose linearization
         * completely encompasses the area from start to end.
         * This method is for the pure text linearization area.
         * @param start The index of the caret position at the begin of the selection
         * @param end The index of the caret position at the end of the selection
         * @return The 'root' of the subtree described above
         */
        String markedAreaForPosPureText(int start, int end) {
                if (htmlOutputVector.isEmpty()) {
                        return null;
                }
                //the result
                String position = null;
                //variables for confining the searched MarkedArea from 
                //start and end (somehow ...)
                int j = 0;
                int i = htmlOutputVector.size() - 1;
                String jPosition ="", iPosition="";
                MarkedArea jElement = null;
                MarkedArea iElement = null;
                
                if (logger.isLoggable(Level.FINER))
                        for (int k = 0; k < htmlOutputVector.size(); k++) { 
                                logger.finer("element: " + k + " begin " + ((MarkedArea)htmlOutputVector.elementAt(k)).begin + " "
                                + "\n-> end: " + ((MarkedArea)htmlOutputVector.elementAt(k)).end+" "       
                                + "\n-> position: " + (((MarkedArea)htmlOutputVector.elementAt(k)).position).position+" "   
                                + "\n-> words: " + ((MarkedArea)htmlOutputVector.elementAt(k)).words);   
                        }
                // localizing end:
                while ((j < htmlOutputVector.size()) && (((MarkedArea)htmlOutputVector.elementAt(j)).end < end)) {
                        j++;
                }
                // localising start:
                while ((i >= 0) && (((MarkedArea)htmlOutputVector.elementAt(i)).begin > start))
                        i--;
                if (logger.isLoggable(Level.FINER)) { 
                        logger.finer("i: " + i + " j: " + j);
                }
                if ((j < htmlOutputVector.size())) {
                        jElement = (MarkedArea)htmlOutputVector.elementAt(j);
                        jPosition = jElement.position.position;
                        // less & before:
                        if (i==-1) { // less:
                                if (end>=jElement.begin) {
                                        iElement = (MarkedArea)htmlOutputVector.elementAt(0);
                                        iPosition = iElement.position.position;
                                        if (logger.isLoggable(Level.FINER)) { 
                                                logger.finer("Less: "+jPosition+" and "+iPosition);
                                        }
                                        position = findMax(0,j);
                                        if (logger.isLoggable(Level.FINER)) { 
                                                logger.finer("SELECTEDTEXT: "+position+"\n");
                                        }
                                } else  if (logger.isLoggable(Level.FINER)) { // before: 
                                                logger.finer("BEFORE vector of size: " + htmlOutputVector.size());
                                        }
                        } else { // just: 
                                iElement = (MarkedArea)htmlOutputVector.elementAt(i);
                                iPosition = iElement.position.position;
                                if (logger.isLoggable(Level.FINER)) { 
                                        logger.finer("SELECTED TEXT Just: "+iPosition +" and "+jPosition+"\n");
                                }
                                position = findMax(i,j);
                                if (logger.isLoggable(Level.FINER)) { 
                                        logger.finer("SELECTEDTEXT: "+position+"\n");
                                }
                        }
                } else if (i>=0) { // more && after:
                                iElement = (MarkedArea)htmlOutputVector.elementAt(i);
                                iPosition = iElement.position.position;
                                // more
                                if (start<=iElement.end) { 
                                        jElement = (MarkedArea)htmlOutputVector.elementAt(htmlOutputVector.size() - 1);
                                        jPosition = jElement.position.position;
                                        if (logger.isLoggable(Level.FINER)) { 
                                                logger.finer("MORE: "+iPosition+ " and "+jPosition);
                                        }
                                        position = findMax(i, htmlOutputVector.size()-1);
                                        if (logger.isLoggable(Level.FINER)) { 
                                                logger.finer("SELECTEDTEXT: "+position+"\n");
                                        }
                                } else if (logger.isLoggable(Level.FINER)) { // after: 
                                        logger.finer("AFTER vector of size: " + htmlOutputVector.size());
                                }
                        } else {
                                // bigger:
                                iElement = (MarkedArea)htmlOutputVector.elementAt(0);
                                iPosition = iElement.position.position;
                                jElement = (MarkedArea)htmlOutputVector.elementAt(htmlOutputVector.size()-1);
                                jPosition = jElement.position.position;
                                if (logger.isLoggable(Level.FINER)) { 
                                        logger.finer("BIGGER: "+iPosition +" and "+jPosition+"\n"         
                                                        + "\n-> SELECTEDTEXT: []\n");
                                }
                                position = "[]";
                        }
                return position;
        }
        
}
