package de.uka.ilkd.key.ocl.gf;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;

import org.apache.log4j.Logger;

/**
 * @author daniels
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class PrintnameLoader extends AbstractProber {
        protected final PrintnameManager printnameManager;
        protected static Logger nogger = Logger.getLogger(Printname.class.getName());
        /**
         * @param fromGf The GF process
         * @param toGf The GF process
         * @param pm The PrintnameManager on which the read Printnames
         * will be registered with their fun name.
         */
        public PrintnameLoader(BufferedReader fromGf, BufferedWriter toGf, PrintnameManager pm) {
                super(fromGf, toGf);
                this.printnameManager = pm;
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
                                        this.printnameManager.addNewPrintnameLine(result);
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
                //send("gf pg -lang=FromUMLTypesOCL -printer=printnames");
                //prints the printnames of the last loaded grammar,
                //which can be another one than FromUMLTypesOCL
                String sendString = "gf pg -printer=printnames";
                if (lang != null && !("".equals(lang))) {
                        sendString = sendString + " -lang=" + lang;
                }
                nogger.info("collecting printnames :" + sendString);
                send(sendString);
                readGfedit();
        }


}
