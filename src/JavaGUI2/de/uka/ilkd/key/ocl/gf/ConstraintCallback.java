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

import java.util.logging.*;

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
