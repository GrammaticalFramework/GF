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
import java.util.logging.*;

/**
 * A class that offers a basic readGfEdit method with a lot of
 * hot spots where subclasses can plug in 
 * @author daniels
 *
 */
abstract class AbstractProber {
        /**
         * reference to the editor whose readRefinementMenu method is used
         */
        protected final GfCapsule gfCapsule;
        protected static Logger logger = Logger.getLogger(AbstractProber.class.getName());        
        
        /**
         * A constructor which sets some fields
         * @param gfCapsule The encapsulation of GF
         */
        public AbstractProber(GfCapsule gfCapsule) {
                this.gfCapsule = gfCapsule;
        }
        
        /**
         * reads the hmsg part
         * @param readresult the first line
         * @return the first line of the next XML child.
         * if no hmsg is present @see readresult is returned.
         */
        protected String readHmsg(String readresult) {
                if (readresult.equals("<hmsg>")) {
                        gfCapsule.skipChild("<hmsg>");
                        try {
                                String next = gfCapsule.fromProc.readLine();
                                if (logger.isLoggable(Level.FINER)) {
                                        logger.finer("2 " + next);
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
                gfCapsule.skipChild("<linearizations>");
        }

        /** 
         * Reads the tree child of the XML from beginning to end 
         */
        protected void readTree() {
                gfCapsule.skipChild("<tree>");
        }

        /** 
         * Reads the message child of the XML from beginning to end 
         */
        protected void readMessage() {
                gfCapsule.skipChild("<message>");
        }
        
        /** 
         * Reads the menu child of the XML from beginning to end 
         */
        protected void readMenu() {
                gfCapsule.skipChild("<menu>");
        }
        
        /**
         * reads the output from GF starting with &gt;gfedit&lt; 
         * and last reads &gt;/gfedit&lt;. 
         */
        protected void readGfedit() {
                try {
                        String next = "";
                        //read <gfedit>
                        String readresult = gfCapsule.fromProc.readLine();
                        if (logger.isLoggable(Level.FINER)) {
                                logger.finer("1 " + next);
                        }
                        //read either <hsmg> or <lineatization>
                        readresult = gfCapsule.fromProc.readLine();
                        if (logger.isLoggable(Level.FINER)) {
                                logger.finer("1 " + next);
                        }
                        
                        Hmsg hmsg = gfCapsule.readHmsg(readresult); 
                        next = hmsg.lastline;
                        
                        //in case there comes sth. unexpected before <linearizations>
                        //usually the while body is never entered
                        // %%%
                        while ((next!=null)&&((next.length()==0)||(!next.trim().equals("<linearizations>")))) {
                                next = gfCapsule.fromProc.readLine();
                                if (next!=null){
                                        if (logger.isLoggable(Level.FINER)) {
                                                logger.finer("1 " + next);
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
                                next = gfCapsule.fromProc.readLine();
                                if (logger.isLoggable(Level.FINER)) {
                                        logger.finer("1 " + next);
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
                if (logger.isLoggable(Level.FINE)) {
                        logger.fine("## send: '" + text + "'");
                }
                gfCapsule.realSend(text);
        }

        /**
         * Just reads the complete output of a GF run and ignores it.	 
         */	 
        protected void readAndIgnore() {	 
                try {
                        StringBuffer debugCollector = new StringBuffer();
                        String readresult = gfCapsule.fromProc.readLine();
                        debugCollector.append(readresult).append('\n');
                        if (logger.isLoggable(Level.FINER)) logger.finer("14 "+readresult);
                        while (readresult.indexOf("</gfedit>") == -1) {
                                readresult = gfCapsule.fromProc.readLine();
                                debugCollector.append(readresult).append('\n');
                                if (logger.isLoggable(Level.FINER)) logger.finer("14 "+readresult);	 
                        }
                        //read trailing newline:	 
                        readresult = gfCapsule.fromProc.readLine();
                        debugCollector.append(readresult).append('\n');
                        if (logger.isLoggable(Level.FINER)) logger.finer("14 "+readresult);
                        
                } catch (IOException e) {	 
                        System.err.println("Could not read from external process:\n" + e);	 
                }	 
        }
}
