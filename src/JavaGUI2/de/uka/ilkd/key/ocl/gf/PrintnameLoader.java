package de.uka.ilkd.key.ocl.gf;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.util.Hashtable;
import org.apache.log4j.Logger;

/**
 * @author daniels
 * asks GF to print all available printnames, parses that list and generates
 * the suiting Printname objects.
 */
public class PrintnameLoader extends AbstractProber {
        protected final PrintnameManager printnameManager;
        protected final static Logger nogger = Logger.getLogger(Printname.class.getName());
        protected final Hashtable funTypes = new Hashtable();
        protected final boolean loadTypes;
        /**
         * @param fromGf The GF process
         * @param toGf The GF process
         * @param pm The PrintnameManager on which the read Printnames
         * will be registered with their fun name.
         * @param withTypes true iff the Printnames should have their type 
         * appended to their display names
         */
        public PrintnameLoader(BufferedReader fromGf, BufferedWriter toGf, PrintnameManager pm, boolean withTypes) {
                super(fromGf, toGf);
                this.printnameManager = pm;
                this.loadTypes = withTypes;
        }
        
        /** 
         * Reads the tree child of the XML from beginning to end.
         * Sets autocompleted to false, if the focus position is open.
         */
        protected void readMessage() {
                try {
                        String result = this.fromProc.readLine();
                        if (nogger.isDebugEnabled()) {
                                nogger.debug("1 " + result);
                        }
                        //first read line is <message>, but this one gets filtered out in the next line
                        while (result.indexOf("/message")==-1){       
                                result = result.trim();
                                if (result.startsWith("printname fun ")) {
                                        //unescape backslashes. Probably there are more
                                        result = GFEditor2.unescapeTextFromGF(result);
                                        this.printnameManager.addNewPrintnameLine(result, this.funTypes);
                                }
                                
                                result = this.fromProc.readLine();
                                if (nogger.isDebugEnabled()) {
                                        nogger.debug("1 " + result);
                                }
                        }
                        if (nogger.isDebugEnabled()) {
                                nogger.debug("finished loading printnames");
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
        public void readPrintnames(String lang) {
                //before, we want the types to be read.
                if (this.loadTypes) {
		                TypesLoader tl = new TypesLoader(fromProc, toProc, this.funTypes);
		                tl.readTypes();
                }
                //prints the printnames of the last loaded grammar,
                String sendString = "gf pg -printer=printnames";
                if (lang != null && !("".equals(lang))) {
                        sendString = sendString + " -lang=" + lang;
                }
                nogger.info("collecting printnames :" + sendString);
                send(sendString);
                readGfedit();
        }


}
