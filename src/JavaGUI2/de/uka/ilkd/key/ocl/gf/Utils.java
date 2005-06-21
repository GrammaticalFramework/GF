// This file is part of KeY - Integrated Deductive Software Design
// Copyright (C) 2001-2005 Universitaet Karlsruhe, Germany
//                         Universitaet Koblenz-Landau, Germany
//                         Chalmers University of Technology, Sweden
//
// The KeY system is protected by the GNU General Public License. 
// See LICENSE.TXT for details.
//
//
package de.uka.ilkd.key.ocl.gf;


import java.io.File;

import javax.swing.ProgressMonitor;

import org.apache.log4j.Logger;

public class Utils {
        protected static Logger timeLogger = Logger.getLogger("de.uka.ilkd.key.ocl.gf.utils.timer");
        protected static Logger deleteLogger = Logger.getLogger("de.uka.ilkd.key.ocl.gf.utils.delete");
        
        private Utils() {
                //non-instantiability enforced
        }
        
        public static final String gf = "gf";
        public static final String gfm = "gfm";
        
        /*
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
                        if (timeLogger.isDebugEnabled()) {
                                timeLogger.debug(System.currentTimeMillis() + " : " + note);
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
                        if (deleteLogger.isDebugEnabled()) {
                                deleteLogger.debug("scheduled for deletion: " + filename);
                        }
                }
                File file = new File(grammarsDir);
                file.deleteOnExit();
                file = file.getParentFile();
                file.deleteOnExit();
        }
        
        /** 
         * shamelessly copied from de.uka.ilkd.key.gui.Main
         * With that, the editor is compilable without changes.
         */
        private static final String LOGGER_CONFIGURATION = 
            	System.getProperty("user.home")+
            	 File.separator+".key"+File.separator+"logger.props";

        /** 
         * shamelessly copied from de.uka.ilkd.key.gui.Main
         * With that, the editor is compilable without changes.
         * Only gets called in stand-alone mode, not when run with KeY.
         */
        public static void configureLogger() {
                if ((new File(LOGGER_CONFIGURATION)).exists())
                        org.apache.log4j.PropertyConfigurator.configureAndWatch(
                                        LOGGER_CONFIGURATION, 1500);
                else {
                        org.apache.log4j.BasicConfigurator.configure();
                        Logger.getRootLogger().setLevel(org.apache.log4j.Level.ERROR);
                }
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
                for (int i = sb.indexOf(toReplace); i >= 0; i = sb.indexOf(toReplace)) {
                        sb.replace(i, i + toReplace.length(), replacement);
                }
                return sb.toString();
        }
}
