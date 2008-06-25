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

import java.io.IOException;
import java.util.Hashtable;
import java.util.logging.*;

/**
 * @author daniels
 * If the entries of the refinement menu should have to appear there with
 * type information appended to them, then the printnames have to get this
 * knowledge at the time of their creation.
 * When the entries are displayed, the display text line of GF is *not* looked
 * at. And even if it would be, it would mess up the architecture, that the 
 * printnames, and only they, are responsible for their linearization.
 * Appending their type later on would break that architecture.
 * So they have to be prepared.
 */
public class TypesLoader extends AbstractProber {
        /**
         * The hash in which the funs as keys and 
         * types as values get saved. Both are Strings.
         */
        protected final Hashtable hashtable;
        private static Logger nogger = Logger.getLogger(TypesLoader.class.getName());
        /**
         * @param gfCapsule the read/write encapsulation of the running GF
         * @param myHashMap The hash in which the funs as keys and 
         * types as values get saved. Both are Strings.
         */
        public TypesLoader(GfCapsule gfCapsule, Hashtable myHashMap) {
                super(gfCapsule);
                this.hashtable = myHashMap;
        }
        
        /** 
         * Reads the tree child of the XML from beginning to end.
         * Sets autocompleted to false, if the focus position is open.
         */
        protected void readMessage() {
                try {
                        String result = gfCapsule.fromProc.readLine();
                        if (nogger.isLoggable(Level.FINER)) {
                                nogger.finer("7 " + result);
                        }
                        //first read line is <message>, but this one gets filtered out in the next line
                        while (result.indexOf("/message")==-1){       
                                result = result.trim();
                                if (result.startsWith("fun ")) {
                                        //unescape backslashes. Probably there are more
                                        readType(result);
                                }
                                
                                result = gfCapsule.fromProc.readLine();
                                if (nogger.isLoggable(Level.FINER)) {
                                        nogger.finer("7 " + result);
                                }
                        }
                        if (nogger.isLoggable(Level.FINER)) {
                                nogger.finer("finished loading printnames");
                        }
                } catch(IOException e){
                        System.err.println(e.getMessage());
                        e.printStackTrace();
                }

        }
        
        /**
         * asks GF to print a list of all available printnames and 
         * calls the registered PrintnameManager to register those.
         */
        public void readTypes() {
                //prints the last loaded grammar,
                String sendString = "gf pg";
                if (nogger.isLoggable(Level.FINE)) {
                        nogger.fine("collecting types :" + sendString);
                }
                send(sendString);
                readGfedit();
        }

        /**
         * Reads a fun line from pg and puts it into hashMap with the fun
         * as the key and the type as the value
         * @param line One line which describes the signature of a fun
         */
        private void readType(String line) {
                final int funStartIndex = 4; //length of "fun "
                final String fun = line.substring(funStartIndex, line.indexOf(" : "));
                final int typeStartIndex = line.indexOf(" : ") + 3;
                final int typeEndIndex = line.lastIndexOf(" = ");
                try {
		                final String type = line.substring(typeStartIndex, typeEndIndex);
		                this.hashtable.put(fun, type);
                } catch (StringIndexOutOfBoundsException e) {
                        System.err.println("line: '" + line + "'");
                        System.err.println("fun: '" + fun + "'");                        
                        System.err.println("typeStartIndex: " + typeStartIndex);
                        System.err.println("typeEndIndex: " + typeEndIndex);
                        
                        System.err.println(e.getLocalizedMessage());
                }
        }

}
