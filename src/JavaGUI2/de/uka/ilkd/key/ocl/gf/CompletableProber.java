package de.uka.ilkd.key.ocl.gf;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.util.logging.*;

/**
 * asks GF if the given commands leads to a situation, where
 * something could be filled in automatically.
 * This class is meant for self and result.
 * @author daniels
 */
class AutoCompletableProber extends AbstractProber {
        /**
         * This field is true in the beginning of each run, and 
         * set to false, if the focus position when checking is found
         * to be open.
         */
        protected boolean autocompleted = true;
        
        protected static Logger nogger = Logger.getLogger(AutoCompletableProber.class.getName());
        /**
         * A constructor which sets some fields
         * @param fromGf the stdout from the GF process
         * @param toGf the stdin from the GF process
         */
        public AutoCompletableProber(BufferedReader fromGf, BufferedWriter toGf) {
                super(fromGf, toGf);
        }
        
        /**
         * asks GF if the given commands leads to a situation, where
         * something could be filled in automatically.
         * This function is meant for self and result.
         * IMPORTANT: Must be called <b>after</b> &lt;/gfedit&gt; 
         * when no other method reads sth. from GF. 
         * It uses the same GF as everything else, since it tests if
         * sth. is possible there. 
         * @param gfCommand the command to be tested.
         * One has to chain a mp command to make GF go to the right place afterwards
         * @param chainCount The number of chained commands in gfCommand.
         * So many undos are done to clean up afterwards. 
         * @return true iff sth. could be filled in automatically
         */
        public boolean isAutoCompletable(String gfCommand, int chainCount) {
                this.autocompleted = true;
                send(gfCommand);
                readGfedit();
                final boolean result = this.autocompleted;
                this.autocompleted = true;
                //clean up and undo
                send("u " + chainCount);
                readAndIgnore(fromProc);
                if (nogger.isLoggable(Level.FINE)) {
                        nogger.fine(result + " is the result for: '" + gfCommand +"'");
                }
                return result;
        }
        
        /** 
         * Reads the tree child of the XML from beginning to end.
         * Sets autocompleted to false, if the focus position is open.
         */
        protected void readTree() {
                try {
                        String result = fromProc.readLine();
                        if (nogger.isLoggable(Level.FINER)) {
                                nogger.finer("14 " + result);
                        }
                        while (result.indexOf("/tree")==-1){       
                                result = result.trim();
                                if (result.startsWith("*")) {
                                        result = result.substring(1).trim();
                                        if (result.startsWith("?")) {
                                                this.autocompleted = false;
                                        }
                                }
                                
                                result = fromProc.readLine();
                                if (nogger.isLoggable(Level.FINER)) {
                                        nogger.finer("14 " + result);
                                }
                        }
                } catch(IOException e){
                        System.err.println(e.getMessage());
                        e.printStackTrace();
                }

        }

        
}
