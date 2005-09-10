package de.uka.ilkd.key.ocl.gf;

import java.util.Vector;

/**
 * Asks GF the Vector of RefinementMenu entries.
 * 
 * This class can be reused.
 * @author daniels
 */
class RefinementMenuCollector extends AbstractProber {
        /**
         * here the result of this run is saved
         */
        Vector refinementMenuContent = null;
        /**
         * Standard fill-in-the-parameters constructor
         * @param gfCapsule The reader/writer to GF
         */
        public RefinementMenuCollector(GfCapsule gfCapsule) {
                super(gfCapsule);
        }
        
        /**
         * Asks GF (the same GF as the one editor has) to execute a command
         * and returns the read refinement menu that is offered then.
         * Uses the readRefinementMenu method from GFEditor2 which does not
         * change any global variable besides GF itself. So that is safe.
         * 
         * Note: This method does not do undo automatically, since it is 
         * intended to run several times in a row, so the u should be part of
         * next command.
         * @param command The command that is sent to GF. Should contain a mp
         * to make sure that the command at the right position in the AST
         * is read
         * @return a Vector of StringTuple like readRefinementMenu does it.
         */
        public Vector readRefinementMenu(String command) {
                send(command);
                readGfedit();
                return this.refinementMenuContent;
        }
        
        /**
         * parses the refinement menu part and stores it in this.refinementMenuContent
         */
        protected void readMenu() {
                this.refinementMenuContent = gfCapsule.readRefinementMenu();
        }
        
}
