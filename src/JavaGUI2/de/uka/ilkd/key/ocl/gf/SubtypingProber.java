package de.uka.ilkd.key.ocl.gf;

import java.util.logging.Logger;
import java.util.*;

/**
 * This class goes through the tree and tries to close all open Subtype lines.
 *
 * Makes heavy use of instance fields instead of parameters and return values.
 * I justify that with the rather small size of this class.
 * Because of this this class has to be reinitialized for each run. 
 * @author daniels
 */
class SubtypingProber extends RefinementMenuCollector {
        private static Logger nogger = Logger.getLogger(SubtypingProber.class.getName());
        /**
         * how many undos are needed to clean up behind this probing
         */
        protected int undoSteps = 0;
        /**
         * the GF AST line by line
         */
        protected String[] treeArray = new String[0];
        /**
         * the pointer to the line, that has been read last
         */
        protected int currentLine;

        /**
         * Standard fill-in-the-parameters constructor
         * @param gfCapsule The encapsulation of GF
         */
        public SubtypingProber(GfCapsule gfCapsule) {
                super(gfCapsule);
                this.currentLine = 0;
        }

        /**
         * stores the read GF AST in treeArray
         */
        protected void readTree() {
                String treeString = gfCapsule.readTree();
                this.treeArray = treeString.split("\\n");
        }
        
        /**
         * looks at the refinement menu for node number lineNumber in the AST
         * and if there is only one refinement command offered, does
         * execute this.
         * @param lineNumber
         */
        protected void checkLine(int lineNumber) {
                String command = "mp [] ;; > " + lineNumber;
                this.undoSteps += 2;
                send(command);
                readGfedit();
                Vector commands = new Vector();
                for (Iterator it = this.refinementMenuContent.iterator(); it.hasNext(); ) {
                        StringTuple next = (StringTuple)it.next();
                        if (next.first.startsWith("r")) {
                                commands.add(next);
                        }
                }
                if (commands.size() == 0) {
                        //nothing can be done
                        nogger.fine("no refinement for '" + this.treeArray[lineNumber] + "'");
                } else if (commands.size() == 1) {
                        StringTuple nextCommand = (StringTuple)commands.lastElement();
                        nogger.fine("one refinement for '" + this.treeArray[lineNumber] + "'");
                        send(nextCommand.first);
                        this.undoSteps += 1;
                        // now new things are in the state, 
                        // but since we assume that nothing above lineNumber changes,
                        // that is wanted.
                        readGfedit();
                } else {
                        nogger.fine(commands.size() + " refinements for '" + this.treeArray[lineNumber] + "'");
                }
        }
        
        /**
         * Asks GF for the AST and tries to hunt down all unrefined 
         * Subtype witnesses.
         * @return the number of undo steps this run needed
         */
        public int checkSubtyping() {
                //solve to try to eliminate many unrefined places
                send("c solve ;; mp []"); //focus at the top where '*' does not disturb
                readGfedit();
                this.undoSteps += 2;
                for (int i = 3; i < this.treeArray.length; i++) { 
                        //the condition gets rechecked every run, and length will only grow
                        //We start at 3 since the witness is the third argument of coerce,
                        //before nothing can happen 
                        //(sth. like "n core.Subtype" does not count! 
                        //(starting with new category Subtype) )
                        if (this.treeArray[i].indexOf(": Subtype") > -1) {
                                if (!this.treeArray[i - 2].startsWith("?") //both Class arguments refined
                                                && !this.treeArray[i - 1].startsWith("?")) {
                                        checkLine(i);
                                }
                        }
                }
                nogger.fine(this.undoSteps + " individual commands sent");
                return this.undoSteps;
        }
}
