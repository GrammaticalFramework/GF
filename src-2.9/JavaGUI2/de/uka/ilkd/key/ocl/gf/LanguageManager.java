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
 * Sadly, this class is a hack.
 * It serves as the pointer type to an inner class of GFEditor2.
 * Two of its methods are needed outside after refactoring.
 * @author daniels
 *
 */
interface LanguageManager {
        /**
         * @param myLang The language in question
         * @return true iff the language is present and set to active,
         * false otherwise.
         */        
        public boolean isLangActive(String myLang);
        /**
         * Checks if myLang is already present, and if not,
         * adds it. In that case, myActive is ignored.
         * @param myLang The name of the language
         * @param myActive whether the language is displayed or not
         */
        public void add(String myLang, boolean myActive);
}
