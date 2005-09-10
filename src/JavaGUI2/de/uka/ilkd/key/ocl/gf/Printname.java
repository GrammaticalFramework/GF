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

import java.util.Hashtable;
import java.util.Vector;
import java.util.logging.*;

/**
 * @author daniels
 *
 * A Printname allows easy access for all the information that is crammed
 * into a printname in the GF grammars.
 * This information consists of (in this order!)
 *   The tooltip text which is started with \\$
 * 	 The subcategory which is started with \\%
 *   The longer explanation for the subcategory which directly follows the
 *     subcategory and is put into parantheses
 *   The parameter descriptions, which start with \\#name and is followed
 *     by their actual description.
 * HTML can be used inside the descriptions and the tooltip text 
 */
class Printname {
        private static Logger subcatLogger = Logger.getLogger(Printname.class.getName());
        
        /**
         * delete is always the same and only consists of one letter, therefore static.
         */
        public static final Printname delete = new Printname("d", "delete current sub-tree", false);
        /**
         * The ac command i always the same, therefore static
         */
        public static final Printname addclip = new Printname("ac", "add to clipboard\\$<html>adds the current subtree to the clipboard.<br>It is offered in the refinement menu if the expected type fits to the one of the current sub-tree.</html>", false);

        /**
         * @param arg The number of the argument, 
         * that will take the place of the selected fun
         * @return a Printname for the 'ph arg' command
         */
        public static Printname peelHead(int arg) {
                final String cmd = "ph " + arg;
                final String show = "peel head " + arg + "\\$removes this fun and moves its " + (arg + 1) + ". argument at its place instead";
                return new Printname(cmd, show, true);
        }
        
        /**
         * the type of the fun behind that printname (if applicable)
         */
        protected final String type;

        /** 
         * If  the command type will already
         * be present in the display name and does not need to be added. 
         */
        protected final boolean funPresent;
        /** 
         * The character that is the borderline between the text that
         * is to be displayed in the JList and the ToolTip text
         */
        public final static String TT_START = "\\$";
        /** 
         * the string that is followed by the sub-category shorthand
         * in the refinement menu
         */ 
        public final static String SUBCAT = "\\%";
        /**
         * The string that is followed by a new parameter to the GF function
         */
        public final static String PARAM = "\\#";
        /**
         * If that follows "\#" in the parameter descriptions, then do an
         * auto-coerce when this param is meta and selected 
         */
        public final static String AUTO_COERCE = "!";
        
        /** 
         * the name of the fun that is used in this command 
         */
        protected final String fun;

        /** 
         * the printname of this function 
         */
        protected final String printname;
        
        /** 
         * to cache the printname, once it is constructed 
         */
        protected String displayedPrintname = null;
        /** 
         * the name of the module the fun belongs to
         * null means that the function is saved without module information,
         * "" means that a GF command is represented
         */
        protected final String module;
        /** 
         * the name of the module the fun belongs to
         * null means that the function is saved without module information,
         * "" means that a GF command is represented
         */
        public String getModule() {
                return module;
        }
        
        
        /** the qualified function name, not needed yet */
        /*
        public String getFunQualified() {
                if (module != null && !module.equals("")) {
                        return module + "." + fun;
                } else {
                        return fun;
                }
        }
        */
        
        /** 
         * the subcategory of this command 
         */
        protected final String subcat;
        /** 
         * the subcategory of this command 
         */
        public String getSubcat() {
                return subcat;
        }

        /**
         * The hashmap for the names of the sub categories, 
         * with the shortname starting with '%' as the key.
         * It is important that all Printnames of one session share the same
         * instance of Hashtable here. 
         * This field is not static because there can be several instances of
         * the editor that shouldn't interfere.
         */
        protected final Hashtable subcatNameHashtable;

        /**
         * contains the names of the paramters of this function (String).
         * Parallel with paramTexts
         */
        protected final Vector paramNames = new Vector();
        
        /**
         * fetches the name of the nth parameter
         * @param n the number of the wanted paramter
         * @return the corresponding name, null if not found
         */
        public String getParamName(int n) {
                String name = null;
                try {
                        name = (String)this.paramNames.get(n);
                } catch (ArrayIndexOutOfBoundsException e) {
                        subcatLogger.fine(e.getLocalizedMessage());
                }
                return name;
        }
        /**
         * contains the descriptions of the paramters of this function (String).
         * Parallel with paramNames
         */
        protected final Vector paramTexts = new Vector();

        /**
         * tells, whether the nth parameter should be auto-coerced
         * @param n the number of the parameter in question
         * @return whether the nth parameter should be auto-coerced
         */
        public boolean getParamAutoCoerce(int n) {
                boolean result = false;
                try {
                        result = ((Boolean)this.paramAutoCoerce.get(n)).booleanValue();
                } catch (ArrayIndexOutOfBoundsException e) {
                        subcatLogger.fine(e.getLocalizedMessage());
                }
                return result;
        }
        
        /**
         * stores for the parameters whether they should be auto-coerced or not.
         * parallel with paramNames
         */
        protected final Vector paramAutoCoerce = new Vector();
        
        /**
         * Creates a Printname for a normal GF function
         * @param myFun the function name
         * @param myPrintname the printname given for this function
         * @param myFullnames the Hashtable for the full names for the category
         * names for the shortnames like \\%PREDEF
         * @param type The type of this fun. 
         * If null, it won't be displayed in the refinement menu.
         */
        public Printname(String myFun, String myPrintname, Hashtable myFullnames, String type) {
                myFun = myFun.trim();
                myPrintname = myPrintname.trim();
                this.printname = myPrintname;
                this.subcatNameHashtable = myFullnames;
                this.type = type;
                if (myFullnames == null) {
                        //if the menu language is abstract, no fullnames are loaded
                        //and the fun will be in the used showname
                        this.funPresent = true;
                } else {
                        this.funPresent = false;
                }
                
                //parse the fun name
                {
                        int index = myFun.indexOf('.');
                        if (index > -1) {
                                //a valid fun name must not be empty
                                this.fun = myFun.substring(index + 1);
                                this.module = myFun.substring(0, index);
                        } else {
                                this.fun = myFun;
                                this.module = null;
                        }
                }
                
                //parse the parameters and cut that part
                {
                        int index = Utils.indexOfNotEscaped(myPrintname, PARAM);
                        if (index > -1) {
                                String paramPart = myPrintname.substring(index);
                                String splitString;
                                //split takes a regexp as an argument. So we have to escape the '\' again.
                                if (PARAM.startsWith("\\")) {
                                        splitString = "\\" + PARAM;
                                } else {
                                        splitString = PARAM;
                                }
                                String[] params = paramPart.split(splitString);
                                //don't use the first split part, since it's empty
                                for (int i = 1; i < params.length; i++) {
                                        String current = params[i];
                                        boolean autocoerce = false;
                                        if (AUTO_COERCE.equals(current.substring(0,1))) {
                                                autocoerce = true;
                                                //cut the !
                                                current = current.substring(1);
                                        }
                                        int nameEnd = current.indexOf(' ');
                                        int nameEnd2 = Utils.indexOfNotEscaped(current, PARAM);
                                        if (nameEnd == -1) {
                                                nameEnd = current.length();
                                        }
                                        String name = current.substring(0, nameEnd);
                                        String description;
                                        if (nameEnd < current.length() - 1) {
                                                description = current.substring(nameEnd + 1).trim();
                                        } else {
                                                description = "";
                                        }
                                        this.paramNames.addElement(name);
                                        this.paramTexts.addElement(description);
                                        this.paramAutoCoerce.addElement(new Boolean(autocoerce));
                                }
                                myPrintname = myPrintname.substring(0, index);
                        }
                }
                
                
                //extract the subcategory part and cut that part
                {
                        int index = Utils.indexOfNotEscaped(myPrintname, SUBCAT);
                        if (index > -1) {
                                String subcatPart = myPrintname.substring(index);
                                myPrintname = myPrintname.substring(0, index);
                                int indFull = subcatPart.indexOf('{');
                                if (indFull > -1) {
                                        int indFullEnd = subcatPart.indexOf('}', indFull + 1);
                                        if (indFullEnd == -1) {
                                                indFullEnd = subcatPart.length();
                                        }
                                        String fullName = subcatPart.substring(indFull + 1, indFullEnd);
                                        this.subcat = subcatPart.substring(0, indFull).trim();
                                        this.subcatNameHashtable.put(this.subcat, fullName);
                                        if (subcatLogger.isLoggable(Level.FINER)) {
                                                subcatLogger.finer("new fullname '" + fullName + "' for category (shortname) '" + this.subcat + "'");
                                        }
                                } else {
                                        subcat = subcatPart.trim();
                                }
                                
                        } else {
                                this.subcat = null; 
                        }
                }
        }

        /**
         * a constructor for GF command that don't represent functions,
         * like d, ph, ac
         * @param command the GF command
         * @param explanation an explanatory text what this command does
         * @param funPresent If explanation already contains the fun.
         * If true, the fun won't be printed in the refinement menu.
         */
        protected Printname(String command, String explanation, boolean funPresent) {
                this.fun = command;
                this.subcatNameHashtable = null;
                this.subcat = null;
                this.module = "";
                this.printname = explanation;
                this.type = null;
                this.funPresent = funPresent;
        }
        
        /**
         * Special constructor for bound variables.
         * These printnames don't get saved since they don't always exist and
         * also consist of quite few information.
         * @param bound The name of the bound variable
         */
        public Printname(String bound) {
                this.fun = bound;
                this.subcatNameHashtable =  null;
                this.subcat = null;
                this.module = null;
                this.printname = bound;
                this.type = null;
                this.funPresent = false;
        }
        
        /** 
         * the text that is to be displayed in the refinement lists 
         */
        public String getDisplayText() {
                String result;
                result = extractDisplayText(this.printname);
                return result;
        }

        /**
         * the text that is to be displayed as the tooltip.
         * Will always be enclosed in &lt;html&gt; &lt;/html&gt; tags.
         */
        public String getTooltipText() {
                if (this.displayedPrintname != null) {
                        return this.displayedPrintname;
                } else {
	                String result;
	                result = extractTooltipText(this.printname);
	                if (this.paramNames.size() > 0) {
	                        String params = htmlifyParams();
	                        //will result in <html> wrapping
	                        result = htmlAppend(result, params);
	                } else {
	                        //wrap in <html> by force
	                        result = htmlAppend(result, "");
	                }
	                this.displayedPrintname = result;
	                return result;
                }
        }

        /**
         * extracts the part of the body of the printname that is the tooltip
         * @param myPrintname the body of the printname
         * @return the tooltip
         */
        public static String extractTooltipText(String myPrintname) {
                //if the description part of the fun has no \\$ to denote a tooltip,
                //but the subcat description has one, than we must take extra
                //caution
                final int indTT = Utils.indexOfNotEscaped(myPrintname, TT_START);
                final int indSC = Utils.indexOfNotEscaped(myPrintname, SUBCAT);
                int ind;
                if ((indSC > -1) && (indSC < indTT)) {
                        ind = -1;
                } else {
                        ind = indTT;
                }
                String result;
                if (ind > -1) {
                        result = myPrintname.substring(ind + TT_START.length());
                } else {
    	                result = myPrintname;
                }
                ind = Utils.indexOfNotEscaped(result, SUBCAT);
                if (ind > -1) {
	                result = result.substring(0, ind);
                }
                ind = Utils.indexOfNotEscaped(result, PARAM);
                if (ind > -1) {
	                result = result.substring(0, ind);
                }
                return result;                
        }
        
        /**
         * extracts the part of the body of the printname that is the 
         * text entry for the JList
         * @param myPrintname the body of the printname
         * @return the one-line description of this Printname's fun
         */
        public static String extractDisplayText(String myPrintname) {
                String result;
                int ind = Utils.indexOfNotEscaped(myPrintname, TT_START);
                if (ind > -1) {
                        result = myPrintname.substring(0, ind);
                } else {
    	                result = myPrintname;
                }
                ind = Utils.indexOfNotEscaped(result, SUBCAT);
                if (ind > -1) {
	                result = result.substring(0, ind);
                }
                ind = Utils.indexOfNotEscaped(result, PARAM);
                if (ind > -1) {
	                result = result.substring(0, ind);
                }
                
                return result;                
        }
        
        /**
         * Appends the given string insertion to original and 
         * returns the result. If original is already HTML, the appended
         * text will get right before the &lt;/html&gt; tag.
         * If original is no HTML, it will be enclosed in &lt;html&gt;
         * @param original The String that is to come before insertion
         * @param insertion the String to be appended
         * @return the aforementioned result.
         */
        public static String htmlAppend(String original, String insertion) {
                StringBuffer result;
                if (original != null) {
                        result = new StringBuffer(original);
                } else {
                        result = new StringBuffer();
                }
                int htmlindex = result.indexOf("</html>");
                
                if (htmlindex > -1) {
                        result.insert(htmlindex, insertion);
                } else {
                        result.insert(0,"<html>").append(insertion).append("</html>");
                }
                return result.toString();
                
        }

        /**
         * Prepends the given string insertion to original and 
         * returns the result. If original is already HTML, the appended
         * text will get right after the &lt;html&gt; tag.
         * If original is no HTML, it will be enclosed in &lt;html&gt;
         * @param original The String that is to come after insertion
         * @param insertion the String to be appended
         * @return the aforementioned result.
         */
        public static String htmlPrepend(String original, String insertion) {
                StringBuffer result = new StringBuffer(original);
                int htmlindex = result.indexOf("<html>");
                
                if (htmlindex > -1) {
                        result.insert(htmlindex, insertion);
                } else {
                        result.insert(0,insertion).insert(0,"<html>").append("</html>");
                }
                return result.toString();
                
        }

        /**
         * wraps a single parameter with explanatory text
         * into &lt;dt&gt; and &lt;dd&gt; tags
         * @param which the number of the parameter
         * @return the resulting String, "" if the wanted parameter
         * is not stored (illegal index)
         */
        protected String htmlifyParam(int which) {
                try {
                        String result = "<dt>" + this.paramNames.get(which) + "</dt>"
                        + "<dd>" + this.paramTexts.get(which) + "</dd>";
                        return result;
                } catch (ArrayIndexOutOfBoundsException e) {
                        subcatLogger.fine(e.getLocalizedMessage());
                        return "";
                }
                
        }
        
        /**
         * wraps a single parameter together with its explanatory text into
         * a HTML definition list (&lt;dl&gt; tags).
         * Also the result is wrapped in &lt;html&gt; tags.
         * @param which the number of the parameter
         * @return the resulting definition list, null if the param is not found.
         */
        public String htmlifySingleParam(int which) {
                String text = htmlifyParam(which);
                if (text.equals("")) {
                        return null;
                }
                String result = "<html><dl>" + text + "</dl></html>";
                return result;
        }
        /**
         * looks up the description for parameter number 'which' and returns it. 
         * Returns null, if no parameter description is present.
         * @param which The number of the parameter
         * @return s.a.
         */
        public String getParamDescription(int which) {
                 return (String)paramTexts.get(which);
        }
        
        /**
         * wraps all parameters together with their explanatory text into
         * a HTML definition list (&lt;dl&gt; tags).
         * No &lt;html&gt; tags are wrapped around here, that is sth. the caller
         * has to do!
         * @return the resulting definition list, "" if which is larger than
         * the amount of stored params
         */
        public String htmlifyParams() {
                if (this.paramNames.size() == 0) {
                        return "";
                }
                StringBuffer result = new StringBuffer("<h4>Parameters:</h4><dl>");
                for (int i = 0; i < this.paramNames.size(); i++) {
                        result.append(htmlifyParam(i));
                }
                result.append("</dl>");
                return result.toString();
        }
        
        /**
         * a testing method that is not called from KeY.
         * Probably things like this should be automated via JUnit ...
         * @param args not used
         */
        public static void main(String[] args) {
                String SandS = "boolean 'and' for sentences$true iff both of the two given sentences is equivalent to true%BOOL#alpha the first of the two and-conjoined sentences#beta the second of the and-conjoined sentences";
                String FandS = "andS";
                Hashtable ht = new Hashtable();
                Printname pn = new Printname(FandS, SandS, ht, null);
                System.out.println(pn);
                for (int i = 0; i < pn.paramNames.size(); i++) {
                        System.out.println(pn.htmlifySingleParam(i));
                }
                System.out.println(pn.getTooltipText());
                SandS = "boolean 'and' for sentences$true iff both of the two given sentences is equivalent to true%BOOL";
                FandS = "andS";
                pn = new Printname(FandS, SandS, ht, null);
                System.out.println("*" + pn.getTooltipText());
        }
        
        public String toString() {
                return getDisplayText() + "  \n  " + getTooltipText() + " (" + this.paramNames.size() + ")";
        }

}
