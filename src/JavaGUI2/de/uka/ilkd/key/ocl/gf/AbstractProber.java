package de.uka.ilkd.key.ocl.gf;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;

import org.apache.log4j.Logger;

/**
 * A class that offers a basic readGfEdit method with a lot of
 * hot spots where subclasses can plug in 
 * @author daniels
 *
 */
abstract class AbstractProber {
        protected final BufferedReader fromProc;
        protected final BufferedWriter toProc;
        protected static Logger logger = Logger.getLogger(AbstractProber.class.getName());        
        
        /**
         * A constructor which sets some fields
         * @param fromGf the stdout from the GF process
         * @param toGf the stdin from the GF process
         */
        public AbstractProber(BufferedReader fromGf, BufferedWriter toGf) {
                this.fromProc = fromGf;
                this.toProc = toGf;
        }
        
        /**
         * reads the hmsg part
         * @param readresult the first line
         * @return the first line of the next XML child.
         * if no hmsg is present @see readresult is returned.
         */
        protected String readHmsg(String readresult) {
                if (readresult.equals("<hmsg>")) {
                        skipChild("<hmsg>");
                        try {
                                String next = fromProc.readLine();
                                if (logger.isDebugEnabled()) {
                                        logger.debug("2 " + next);
                                }
                                return next;
                        } catch (IOException e) {
                                System.err.println("Could not read from external process:\n" + e);
                                return "";
                        }
                } else {
                        return readresult;
                }
        }
        
        /**
         * reads the linearization subtree.
         * The first line should be already read
         * @param readresult the first line with the opening tag
         */
        protected void readLinearizations(String readresult) {
                skipChild("<linearizations>");
        }

        /** Reads the tree child of the XML from beginning to end */
        protected void readTree() {
                skipChild("<tree>");
        }

        /** Reads the message child of the XML from beginning to end */
        protected void readMessage() {
                skipChild("<message>");
        }
        
        /** Reads the menu child of the XML from beginning to end */
        protected void readMenu() {
                skipChild("<menu>");
        }
        
        /**
         * reads the output from GF starting with &gt;gfedit&lt; 
         * and last reads &gt;/gfedit&lt;. 
         */
        protected void readGfedit() {
                try {
                        String next = "";
                        //read <gfedit>
                        String readresult = fromProc.readLine();
                        if (logger.isDebugEnabled()) {
                                logger.debug("1 " + next);
                        }
                        //read either <hsmg> or <lineatization>
                        readresult = fromProc.readLine();
                        if (logger.isDebugEnabled()) {
                                logger.debug("1 " + next);
                        }
                        
                        next = readHmsg(readresult);
                        
                        //in case there comes sth. unexpected before <linearizations>
                        //usually the while body is never entered
                        // %%%
                        while ((next!=null)&&((next.length()==0)||(!next.trim().equals("<linearizations>")))) {
                                next = fromProc.readLine();
                                if (next!=null){
                                        if (logger.isDebugEnabled()) {
                                                logger.debug("1 " + next);
                                        }
                                } else {
                                        System.exit(0);
                                }
                        }
                        readLinearizations(next);
                        readTree();
                        readMessage();
                        readMenu();
                        
                        for (int i=0; i<3 && !next.equals(""); i++){ 
                                next = fromProc.readLine();
                                if (logger.isDebugEnabled()) {
                                        logger.debug("1 " + next);
                                }
                        }
                        
                } catch (IOException e) {
                        System.err.println("Could not read from external process:\n" + e);
                }
                
        }
        
        /**
         * Reads the output from GF until the ending tag corresponding to the
         * given opening tag is read. 
         * @param opening tag in the format of &gt;gfinit&lt;
         */
        protected void skipChild(String opening) {
                String closing = (new StringBuffer(opening)).insert(1, '/').toString();
                try {
                        String nextRead = fromProc.readLine();
                        if (logger.isDebugEnabled()) {
                                logger.debug("3 " + nextRead);
                        }
                        while (!nextRead.trim().equals(closing)) {
                                nextRead = fromProc.readLine();
                                if (logger.isDebugEnabled()) {
                                        logger.debug("3 " + nextRead);
                                }
                        }
                } catch (IOException e) {
                        System.err.println("Could not read from external process:\n" + e);
                }
                
                
        }
        
        /**
         * send a command to GF
         * @param text the command, exactly the string that is going to be sent
         */
        protected void send(String text) {
                if (logger.isDebugEnabled()) {
                        logger.debug("## send: '" + text + "'");
                }
                try {
                        toProc.write(text, 0, text.length());
                        toProc.newLine();
                        toProc.flush();
                } catch (IOException e) {
                        System.err.println("Could not write to external process " + e);
                }  
        }

        
}
