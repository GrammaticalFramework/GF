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

import java.util.Vector;
/**
 * Encapsulates the &lt;gfedit&gt; XML tree from GF.
 * @author hdaniels
 */
class GfeditResult {
        /**
         * The fully parsed  &lt;hmsg&gt; subtree
         */
        final Hmsg hmsg;
        /**
         * A Vector of StringTuple where first is the command for GF
         * and second is the show text
         */
        final Vector gfCommands;
        /**
         * The tree from GF isn't XML anyway, so here it is in all its raw glory
         */
        final String treeString;
        /**
         * if GF had something extra to tell, it can be found here
         */
        final String message;
        /**
         * The XML for the linearizations in all languages
         */
        final String linearizations;
        /**
         * A simple setter constructor
         * @param gfCommands A Vector of StringTuple where first is the command for GF
         * and second is the show text
         * @param hmsg The fully parsed  &lt;hmsg&gt; subtree
         * @param linearizations The XML for the linearizations in all languages
         * @param message the GF message
         * @param treeString The tree from GF
         */
        public GfeditResult(Vector gfCommands, Hmsg hmsg, String linearizations, String message, String treeString) {
                this.gfCommands = gfCommands;
                this.hmsg = hmsg;
                this.linearizations = linearizations;
                this.message = message;
                this.treeString = treeString;
        }
}
