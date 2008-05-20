package de.uka.ilkd.key.ocl.gf;

import java.util.logging.*;

/**
 * asks GF if the given commands leads to a situation, where
 * something could be filled in automatically.
 * This class is meant for self and result.
 * @author daniels
 */
class SelfResultProber extends AbstractProber {
        /**
         * This field is true in the beginning of each run, and 
         * set to false, if the focus position when checking is found
         * to be open.
         */
        protected boolean autocompleted = true;
       
        protected static Logger nogger = Logger.getLogger(SelfResultProber.class.getName());
        /**
         * A constructor which sets some fields
         * @param gfCapsule The encapsulation of the running GF process
         */
        public SelfResultProber(GfCapsule gfCapsule) {
                super(gfCapsule);
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
                readAndIgnore();
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
                String treeString = gfCapsule.readTree();
                String[] treeArray = treeString.split("\\n");
                for (int i = 0; i < treeArray.length; i++) {
                        String result = treeArray[i].trim();
                        if (result.startsWith("*")) {
                                result = result.substring(1).trim();
                                if (result.startsWith("?")) {
                                        //the normal case, focus position open
                                        this.autocompleted = false;
                                } else if ((i >= 6) //that we could be at the instance argument at all
                                                && (treeArray[i - 6].indexOf("coerce") > -1) //we are below a coerce
                                                && (treeArray[i - 3].trim().startsWith("?")) //the Subtype argument is not filled in
                                                // The super argument cannot be OclAnyC or even unrefined, because then this 
                                                // method wouldn't have been called. Thus, the Subtype argument is unique.
                                                ){
                                        //we are below a coerce, but self would have a non-suiting subtype
                                        this.autocompleted = false;
                                }
                        }

                }
        }
}
