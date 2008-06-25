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

/**
 * Stores a MarkedArea together with some status fields, which tell
 * how it should get highlighted.
 * No direct highlighting stuff in here, that's done in GFEditor2 
 * @author daniels
 */
class MarkedAreaHighlightingStatus {
        /**
         * The MarkedArea, which contains the highlighting information
         */
        final MarkedArea ma;
        /**
         * whether this MarkedArea is a subnode of the currently focused node
         */
        final boolean focused;
        /**
         * whether this MarkedArea has (inherited) a GF constraint
         */
        final boolean incorrect;
        /**
         * Initializes this immutable record class
         * @param focused whether this MarkedArea is a subnode of the currently focused node
         * @param incorrect whether this MarkedArea has (inherited) a GF constraint
         * @param ma The MarkedArea, which contains the highlighting information
         */
        public MarkedAreaHighlightingStatus(boolean focused, boolean incorrect, MarkedArea ma) {
                this.focused = focused;
                this.incorrect = incorrect;
                this.ma = ma;
        }
}
