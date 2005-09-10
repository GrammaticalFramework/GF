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
 * Small tuple class for two Strings.
 * The main use is grouping command and showname for GF commands before 
 * they are processed.
 * This class is mutable.
 * Equality is bound to the first argument.
 * @author daniels
 */
class StringTuple {
        String first;
        String second;

        /**
         * Just sets both values. 
         * @param f Well, the first String
         * @param s Well, the second String 
         * (if it is used at all)
         */
        public StringTuple(String f, String s) {
                this.first = f;
                this.second = s;
        }
        
        public int hashCode() {
                return this.first.hashCode();
        }
        public boolean equals(Object o) {
                if (o instanceof StringTuple) {
                        return this.first.equals(((StringTuple)o).first);
                } else {
                        return false;
                }
        }
        public String toString() {
                return this.first;
        }
}
