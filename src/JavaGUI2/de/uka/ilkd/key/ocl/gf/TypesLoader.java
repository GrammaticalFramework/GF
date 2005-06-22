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
public class TypesLoader extends AbstractProber {
        protected final Hashtable hashtable;
        protected static Logger nogger = Logger.getLogger(Printname.class.getName());
        /**
         * @param fromGf The GF process
         * @param toGf The GF process
         * @param myHashMap The hash in which the funs as keys and 
         * types as values get saved. Both are Strings.
         */
        public TypesLoader(BufferedReader fromGf, BufferedWriter toGf, Hashtable myHashMap) {
                super(fromGf, toGf);
                this.hashtable = myHashMap;
        }
        
        /** 
         * Reads the tree child of the XML from beginning to end.
         * Sets autocompleted to false, if the focus position is open.
         */
        protected void readMessage() {
                try {
                        String result = this.fromProc.readLine();
                        if (nogger.isDebugEnabled()) {
                                nogger.debug("7 " + result);
                        }
                        //first read line is <message>, but this one gets filtered out in the next line
                        while (result.indexOf("/message")==-1){       
                                result = result.trim();
                                if (result.startsWith("fun ")) {
                                        //unescape backslashes. Probably there are more
                                        readType(result);
                                }
                                
                                result = this.fromProc.readLine();
                                if (nogger.isDebugEnabled()) {
                                        nogger.debug("7 " + result);
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
         */
        public void readTypes() {
                //prints the last loaded grammar,
                String sendString = "gf pg";
                nogger.info("collecting types :" + sendString);
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
