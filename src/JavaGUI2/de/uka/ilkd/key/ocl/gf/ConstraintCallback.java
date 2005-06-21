package de.uka.ilkd.key.ocl.gf;

import org.apache.log4j.Logger;

/**
 * @author daniels
 * Offers the interface that GFEditor2 uses to send back the constraint after editing.
 * Has no dependancies on KeY or TogetherCC.
 *
 */
abstract class ConstraintCallback {

        /**
         * Does the logging. What else should it do? 
         */
        protected static Logger logger = Logger.getLogger(ConstraintCallback.class.getName());

        String grammarsDir;
        /**
         * sets the directory where the grammars reside
         * @param grammarsDir
         */
        void setGrammarsDir(final String grammarsDir)  {
                this.grammarsDir = grammarsDir;
        }
        /**
         * gets the directory where the grammars reside
         */
        String getGrammarsDir()  {
                return this.grammarsDir;
        }
        
        /**
         * Sends the finished OCL constraint back to Together to save it 
         * as a JavaDoc comment.
         * @param constraint The OCL constraint in question.
         */
        abstract void sendConstraint(String constraint);

}
