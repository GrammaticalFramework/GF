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
 * GF sends the new menu as XML.
 * After this has been parsed by GfCapsule, it is sent in this representation
 * to GFEditor2.
 * @author daniels
 *
 */
class NewCategoryMenuResult {
        /**
         * The actual entries of the newMenu
         */
        final String[] menuContent;
        /**
         * The languages, that GF sent
         */
        final String[] languages;
        /**
         * the constituents of the import path?
         */
        final String[] paths;
        /**
         * the name of the abstract grammar, also called topic
         */
        final String grammarName;

        /**
         * Just sets the attributes of this class
         * @param grammarName the name of the abstract grammar, also called topic
         * @param menuContent The actual entries of the newMenu
         * @param languages The languages, that GF sent
         * @param paths the constituents of the import path?
         */
        public NewCategoryMenuResult(String grammarName, String[] menuContent, String[] languages, String paths[]) {
                this.grammarName = grammarName;
                this.menuContent = menuContent;
                this.languages = languages;
                this.paths = paths;
        }
        
}
