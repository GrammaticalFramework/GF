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
 * asks GF to print all available printnames, parses that list and generates
 * the suiting Printname objects.
 */
public class PrintnameLoader extends AbstractProber {
        private final static Logger nogger = Logger.getLogger(Printname.class.getName());
        /**
         * The PrintnameManager on which the read Printnames
         * will be registered with their fun name.
         */
        private final PrintnameManager printnameManager;
        /**
         * Here, the funs with their types get stored
         */
        private final Hashtable funTypes = new Hashtable();
        /**
         * if the Printnames should have their type appended to their display names
         */
        private final boolean loadTypes;
        /**
         * an initializing constructor, does nothing except setting fields
         * @param gfCapsule the read/write encapsulation of GF
         * @param pm The PrintnameManager on which the read Printnames
         * will be registered with their fun name.
         * @param withTypes true iff the Printnames should have their type 
         * appended to their display names
         */
        public PrintnameLoader(GfCapsule gfCapsule, PrintnameManager pm, boolean withTypes) {
                super(gfCapsule);
                this.printnameManager = pm;
                this.loadTypes = withTypes;
        }
        
        /** 
         * Reads the tree child of the XML from beginning to end.
         * Sets autocompleted to false, if the focus position is open.
         */
        protected void readMessage() {
                try {
                        String result = gfCapsule.fromProc.readLine();
                        if (nogger.isLoggable(Level.FINER)) {
                                nogger.finer("1 " + result);
                        }
                        //first read line is <message>, but this one gets filtered out in the next line
                        while (result.indexOf("/message")==-1){       
                                result = result.trim();
                                if (result.startsWith("printname fun ")) {
                                        //unescape backslashes. Probably there are more
                                        result = Linearization.unescapeTextFromGF(result);
                                        this.printnameManager.addNewPrintnameLine(result, this.funTypes);
                                }
                                
                                result = gfCapsule.fromProc.readLine();
                                if (nogger.isLoggable(Level.FINER)) {
                                        nogger.finer("1 " + result);
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
         * @param lang The module for which the grammars should be printed. 
         * If lang is "" or null, the last read grammar module is used. 
         */
        protected void readPrintnames(String lang) {
                //before, we want the types to be read.
                if (this.loadTypes) {
		                TypesLoader tl = new TypesLoader(gfCapsule, this.funTypes);
		                tl.readTypes();
                }
                //prints the printnames of the last loaded grammar,
                String sendString = "gf pg -printer=printnames";
                if (lang != null && !("".equals(lang))) {
                        sendString = sendString + " -lang=" + lang;
                }
                nogger.fine("collecting printnames :" + sendString);
                send(sendString);
                readGfedit();
        }


}
