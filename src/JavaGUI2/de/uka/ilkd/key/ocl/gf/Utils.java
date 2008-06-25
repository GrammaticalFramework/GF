//Copyright (c) Kristofer Johanisson 2005, Hans-Joachim Daniels 2005
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


import java.io.File;
import java.util.logging.*;
import javax.swing.ProgressMonitor;
import java.util.Vector;

/**
 * consists of a bunch of static methods, mostly for String
 * @author daniels
 *
 */
public class Utils {
        private static Logger timeLogger = Logger.getLogger(Utils.class.getName() + ".timer");
        private static Logger deleteLogger = Logger.getLogger(Utils.class.getName() + ".delete");
        private static Logger stringLogger = Logger.getLogger(Utils.class.getName() + ".string");
        
        private Utils() {
                //non-instantiability enforced
        }
        
        public static final String gf = "gf";
        public static final String gfcm = "gfcm";
        
        /**
         * Get the extension of a file.
         */
        public static String getExtension(File f) {
                String ext = null;
                String s = f.getName();
                int i = s.lastIndexOf('.');
                
                if (i > 0 &&  i < s.length() - 1) {
                        ext = s.substring(i+1).toLowerCase();
                }
                return ext;
        }
        /**
         * Sets the progress on the given ProgressMonitor and logs the current time.
         * @param pm the monitor which is to be updated. If null, only logging is done
         * @param progress The progress in absolute ticks
         * @param note The note that is to be displayed above the progress monitor
         */
        public static void tickProgress(ProgressMonitor pm, int progress, String note) {
                if (note != null) {
                        if (timeLogger.isLoggable(Level.FINER)) {
                                timeLogger.finer(System.currentTimeMillis() + " : " + note);
                        }
                }
                if (pm == null) {
                        return;
                }
                pm.setProgress(progress);
                if (note != null) {
                        pm.setNote(note);
                }
        }
        
        /**
         * schedules all Eng, OCL and Ger grammar files for deletion.
         * @param grammarsDir The directory where those files are
         */
        public static void cleanupFromUMLTypes(String grammarsDir) {
                String[] endings = {"Eng.gf", "Eng.gfc", "Ger.gf", "Ger.gfc", "OCL.gf", "OCL.gfc", ".gf", ".gfc"};
                for (int i = 0; i < endings.length; i++) {
                        String filename = grammarsDir + File.separator + GFEditor2.modelModulName + endings[i];
                        File file = new File(filename);
                        file.deleteOnExit();
                        if (deleteLogger.isLoggable(Level.FINER)) {
                                deleteLogger.fine("scheduled for deletion: " + filename);
                        }
                }
                File file = new File(grammarsDir);
                file.deleteOnExit();
                file = file.getParentFile();
                file.deleteOnExit();
        }
        
        /**
         * Searches for the first occurace not escaped with '\' of toBeFound in s.
         * Works like String::indexOf otherwise
         * @param s the String to search in
         * @param toBeFound the String to search for
         * @return the index of toBeFound, -1 if not found (or only escaped)
         */
        public static int indexOfNotEscaped(String s, String toBeFound) {
                return indexOfNotEscaped(s, toBeFound, 0);
        }
        
        /**
         * Searches for the first occurace not escaped with '\' of toBeFound in s.
         * Works like String::indexOf otherwise
         * @param s the String to search in
         * @param toBeFound the String to search for
         * @param startIndex the index in s, from which the search starts
         * @return the index of toBeFound, -1 if not found (or only escaped)
         */
        public static int indexOfNotEscaped(String s, String toBeFound, int startIndex) {
                for (int from = startIndex; from < s.length();) {
                        int i = s.indexOf(toBeFound, from);
                        if (i <= 0) {
                                //-1 is not found at all, 0 can't have a '\' before
                                return i;
                        } else if (s.charAt(i-1) != '\\') {
                                return i;
                        } else {
                                from = i + 1;
                        }
                }
                return -1;
        }
        
        /**
         * a simple replaceAll replacement, that uses NO regexps 
         * and thus needs no freaking amount of backslashes
         * @param original The String in which the replacements should take place
         * @param toReplace the String literal that is to be replaced
         * @param replacement the replacement string
         * @return original, but with replacements
         */
        public static String replaceAll(String original, String toReplace, String replacement) {
                StringBuffer sb = new StringBuffer(original);
                for (int i = sb.indexOf(toReplace); i >= 0; i = sb.indexOf(toReplace, i + replacement.length())) {
                        sb.replace(i, i + toReplace.length(), replacement);
                }
                return sb.toString();
        }
        
        /**
         * Removes all parts, that are inside "quotation marks" from s.
         * Assumes no nesting of those, like in Java.
         * " escaped with \ like \" do not count as quotation marks
         * @param s The String, that possibly contains quotations
         * @return a String described above, s without quotations.
         */
        public static String removeQuotations(String s) {
                if (s.indexOf('"') == -1) {
                        return s;
                }
                for (int begin = indexOfNotEscaped(s, "\""); begin > -1 ;  begin = indexOfNotEscaped(s, "\"", begin)) {//yes, I want an unescaped '"'!
                        int end = indexOfNotEscaped(s, "\"", begin + 1);
                        if (end > -1) {
                                s = s.substring(0, begin) + s.substring(end + 1);
                        } else {
                                stringLogger.info("Strange String given: '" + s + "'");
                                s = s.substring(0, begin);
                        }
                }
                return s;
        }
        
        /**
         * counts the occurances of toSearch in s
         * @param s The String in which the search shall take place
         * @param toSearch The String that should be counted
         * @return the number of occurances, 0 if s is null
         */
        public static int countOccurances(String s, String toSearch) {
                if (s == null) {
                        return 0;
                }
                int result = 0;
                for (int i = s.indexOf(toSearch); i > -1; i = s.indexOf(toSearch, i)) {
                        result++;
                        i += toSearch.length();
                }
                return result;
        }
        
        /**
         * Takes an arbitrary Vector and executes toString on each element and
         * puts these into a String[] of the same size as the Vector
         * @param strings A Vector of Object, preferably String
         * @return The Vector as a String[]
         */
        public static String[] vector2Array(Vector strings) {
                String[] result = new String[strings.size()];
                for (int i = 0; i < strings.size(); i++) {
                        result[i] = strings.get(i).toString();
                }
                return result;
        }
        /**
         * just replace sequences of spaces with one space
         * @param s The string to be compacted
         * @return the compacted result
         */
        static String compactSpaces(String s) {
                String localResult = new String();
                boolean spaceIncluded = false;
                
                for (int i = 0; i < s.length(); i++) {
                        char c = s.charAt(i);
                        if (c != ' ') { // include all non-spaces
                                localResult += String.valueOf(c);
                                spaceIncluded = false;
                        } else {// we have a space
                                if (!spaceIncluded) {
                                        localResult += " ";
                                        spaceIncluded = true;
                                } // else just skip
                        }
                }
                return localResult;
        }
        /**
         * Replaces all occurances of toBeReplaced, that are not escaped by '\'
         * with replacement
         * @param working the String in which substrings should be replaced
         * @param toBeReplaced The substring, that should be replaced by replacement
         * @param replacement well, the replacement string
         * @return The String with the replaced parts
         */
        public static String replaceNotEscaped(String working, String toBeReplaced, String replacement) {
        		StringBuffer w = new StringBuffer(working);
                        for (int i = w.indexOf(toBeReplaced); i > -1 && i < w.length(); i = w.indexOf(toBeReplaced, i)) {
                                if (i == 0 || w.charAt(i - 1) != '\\') {
        				w.replace(i, i + toBeReplaced.length(), replacement);
        				i += replacement.length();
        			} else {
        				i += 1;
        			}
                        }
        		return w.toString();
        }
}
