//Copyright (c) Janna Khegai 2004, Hans-Joachim Daniels 2005
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

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.ProgressMonitor;

class GfCapsule {
        /** 
         * XML parsing debug messages  
         */
        private static Logger xmlLogger = Logger.getLogger(GfCapsule.class.getName() + ".xml");
        /** 
         * generic logging of this class  
         */
        private static Logger logger = Logger.getLogger(GfCapsule.class.getName());
        /** 
         * The output from GF is in here.
         * Only the read methods, initializeGF and the prober objects access this. 
         */
        BufferedReader fromProc;
        /** 
         * Used to leave messages for GF here. 
         * But <b>only</b> in send and special probers that clean up with undo
         * after them (or don't change the state like PrintnameLoader).
         */
        BufferedWriter toProc;

        /**
         * Starts GF with the given command gfcmd in another process.
         * Sets up the reader and writer to that process.
         * Does in it self not read anything from GF.
         * @param gfcmd The complete command to start GF, including 'gf' itself.
         */
        public GfCapsule(String gfcmd){
                try {
                        Process extProc = Runtime.getRuntime().exec(gfcmd); 
                        InputStreamReader isr = new InputStreamReader(
                                        extProc.getInputStream(),"UTF8");
                        this.fromProc = new BufferedReader (isr);
                        String defaultEncoding = isr.getEncoding();
                        if (logger.isLoggable(Level.FINER)) {
                                logger.finer("encoding "+defaultEncoding);
                        }
                        this.toProc = new BufferedWriter(new OutputStreamWriter(extProc.getOutputStream(),"UTF8"));
                } catch (IOException e) {
                        JOptionPane.showMessageDialog(new JFrame(), "Could not start " + gfcmd+
                                        "\nCheck your $PATH", "Error", 
                                        JOptionPane.ERROR_MESSAGE);
                        throw new RuntimeException("Could not start " + gfcmd+
                        "\nCheck your $PATH");
                }
        }

        
        /**
         * Does the actual writing of command to the GF process via STDIN
         * @param command exactly the string that is going to be sent
         */
        protected void realSend(String command) {
                try {
                        toProc.write(command, 0, command.length());
                        toProc.newLine();
                        toProc.flush();
                } catch (IOException e) {
                        System.err.println("Could not write to external process " + e);
                }  
                
        }
        
        /**
         * reads the part between &gt;gfinit&lt; and &gt;/gfinit&lt; 
         * @return the data for the new category menu
         */
        protected NewCategoryMenuResult readGfinit() {
                try {
                        //read <hmsg> or <newcat> or <topic> (in case of no grammar loaded)
                        String readresult = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("12 "+readresult);
                        //when old grammars are loaded, the first line looks like
                        //"reading grammar of old format letter.Abs.gfreading old file letter.Abs.gf<gfinit>"
                        if (readresult.indexOf("<gfinit>") > -1) {
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("12 "+readresult);
                        }
                        //no command appendix expected or applicable here, so appendix is discarded
                        Hmsg hmsg = readHmsg(readresult);
                        String next = hmsg.lastline;
                        //no hmsg supported here. Wouldn't be applicable.
                        //the reading above is to silently ignore it intead of failing.
                        //formHmsg(hmsg);

                        if ((next!=null) && ((next.indexOf("newcat") > -1) 
                                        || (next.indexOf("topic") > -1))) {
                                NewCategoryMenuResult ncmr = readNewMenu();
                                return ncmr;
                        }
                        
                } catch (IOException e) {
                        System.err.println("Could not read from external process:\n" + e);
                }
                return null;
        }

        /**
         * reads the greeting text from GF
         * @return S tuple with first = the last read GF line, 
         * which should be the first loading line
         * and second = The greetings string
         */
        protected StringTuple readGfGreetings() {
                try {
                        String readresult = "";
                        StringBuffer outputStringBuffer = new StringBuffer();
                        readresult = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("1 "+readresult);
                        while ((readresult.indexOf("gf")==-1) && (readresult.trim().indexOf("<") < 0)){                          
                                outputStringBuffer.append(readresult).append("\n");
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("1 "+readresult);
                        }
                        return new StringTuple(readresult, outputStringBuffer.toString());
                } catch (IOException e) {
                        System.err.println("Could not read from external process:\n" + e);
                        return new StringTuple("", e.getLocalizedMessage());
                }
                
        }

        /**
         * reads the loading and compiling messages from GF
         * @param readresult the first loading line
         * @param pm to monitor the loading progress. May be null
         * @return A tuple with first = the first line from &gt;gfinit&lt; or &gt;gfedit&lt;
         * and second = the loading message as pure text
         */
        protected StringTuple readGfLoading(String readresult, ProgressMonitor pm) {
                try {
                        // in case nothing has been loaded first, the that has to be done now
                        if (readresult == null) {
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("1 " + readresult);
                        }
                        StringBuffer textPure = new StringBuffer();
                        int progress = 5300;
                        while (!(readresult.indexOf("<gfinit>") > -1 || (readresult.indexOf("<gfmenu>") > -1))){
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("1 "+readresult);
                                textPure.append(readresult).append("\n");
                                progress += 12;
                                Utils.tickProgress(pm, progress, null);
                        }
                        //when old grammars are loaded, the first line looks like
                        //"reading grammar of old format letter.Abs.gfreading old file letter.Abs.gf<gfinit>"
                        //without newlines
                        final int beginInit = readresult.indexOf("<gfinit>"); 
                        if (beginInit > 0) {
                                textPure.append(readresult.substring(0, beginInit)).append("\n");
                                //that is the expected result
                                readresult = "<gfinit>";
                        }
                        return new StringTuple(readresult, textPure.toString());
                } catch (IOException e) {
                        System.err.println("Could not read from external process:\n" + e);
                        return new StringTuple("", e.getLocalizedMessage());
                }

        }

        
        /**
         * Reads the &lt;gfedit&gt; part from GF's XML output.
         * The different subtags are put into the result
         * @param newObj If a new object in the editor has been started.
         * If the to-be-read hmsg contains the newObject flag, 
         * that overwrites this parameter
         * @return the read tags, partially halfy parsed, partially raw.
         * The way the different form methods expect it.
         */
        protected GfeditResult readGfedit(boolean newObj) {
                try {
                        String next = "";
                        //read <gfedit>
                        String readresult = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("11 "+readresult);
                        //read either <hsmg> or <lineatization>
                        readresult = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("11 "+readresult);
                        
                        //hmsg stuff
                        final Hmsg hmsg = readHmsg(readresult);
                        next = hmsg.lastline;
                        
                        //reading <linearizations>
                        //seems to be the only line read here
                        //this is here to give as some sort of catch clause.
                        while ((next!=null)&&((next.length()==0)||(next.indexOf("<linearizations>")==-1))) {
                                next = fromProc.readLine();
                                if (next!=null){
                                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("10 "+next);
                                } else {
                                        System.exit(0);
                                }
                        }
                        readresult = next;
                        String lin = readLin();
                        final String treeString = readTree();
                        final String message = readMessage();
                        //read the menu stuff
                        Vector gfCommandVector;
                        if (newObj || hmsg.newObject) {
                                gfCommandVector = readRefinementMenu();
                        } else {
                                while(readresult.indexOf("</menu")==-1) {
                                        readresult = fromProc.readLine();
                                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("12 " + readresult);                    
                                }
                                gfCommandVector = null;
                        }
                        // "" should occur quite fast, but it has not already been read,
                        // since the last read line is "</menu>"
                        for (int i = 0; i < 3 && !readresult.equals(""); i++){ 
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("11 " + readresult);                    
                        }
                        //all well, return the read stuff
                        return new GfeditResult(gfCommandVector, hmsg, lin, message, treeString);
                        
                } catch (IOException e) {
                        System.err.println("Could not read from external process:\n" + e);
                }
                //nothing well, return bogus stuff
                return new GfeditResult(new Vector(), new Hmsg("", "", false, false, false, false, true), "", "", "");
                
        }        

        /**
         * reads the linearizations in all language.
         * seems to expect the first line of the XML structure 
         * (< lin) already to be read
         * Accumulates the GF-output between <linearization> </linearization>  tags
         */
        protected String readLin(){
                StringBuffer lins = new StringBuffer();
                try {
                        //read <linearizations>
                        String readresult = fromProc.readLine();             
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("7 " + readresult);
                        lins.append(readresult).append('\n');
                        readresult = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("6 " + readresult);
                        while ((readresult != null) && (readresult.indexOf("/linearization") == -1)){       
                                lins.append(readresult).append('\n');
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("6 " + readresult);                     
                        }
                } catch(IOException e){
                        System.err.println(e.getMessage());
                        e.printStackTrace();
                }
                return lins.toString();
        }
        
        /**
         * reads in the tree and calls formTree without start end end tag of tree
         * expects the first starting XML tag tree to be already read
         * @return the read tags for the tree or null if a read error occurs
         */
        protected String readTree(){
                String treeString = "";
                try {
                        //read <tree>
                        String readresult = fromProc.readLine();             
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("6 " + readresult);          
                        readresult = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("6 " + readresult);
                        while (readresult.indexOf("/tree") == -1){       
                                treeString += readresult + "\n";           
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("6 " + readresult);                     
                        }
                        return treeString;
                } catch(IOException e){
                        System.err.println(e.getMessage());
                        e.printStackTrace();
                        return null;
                }
        }
        
        /**
         * Parses the GF-output between <message> </message>  tags
         * and returns it.
         * @return The read message.
         */
        protected String readMessage(){
                String s ="";
                try {
                        // read <message>
                        String readresult = fromProc.readLine();             
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("6 " + readresult);          
                        readresult = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("7 " + readresult);
                        while (readresult.indexOf("/message") == -1){       
                                s += readresult + "\n";           
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("7 " + readresult);                     
                        }
                        return s;
                } catch(IOException e){
                        System.err.println(e.getLocalizedMessage());
                        e.printStackTrace();
                        return e.getLocalizedMessage();
                }
        }
 
        /**
         * reads the cat entries and puts them into result.menuContent, 
         * after that reads
         * the names of the languages and puts them into the result.languages
         * The loaded grammar files are put into result.paths,
         * a guessed grammar name into result.grammarName 
         * Parses the GF-output between <gfinit> tags
         */
        protected NewCategoryMenuResult readNewMenu () {
                //here the read stuff is sorted into
                String grammarName = "";
                final Vector languages = new Vector();
                final Vector menuContent = new Vector();
                final Vector paths = new Vector();
                
                boolean more = true;
                try {
                        //read first cat
                        String readresult = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) {
                                xmlLogger.finer("2 " + readresult);
                        }
                        if (readresult.indexOf("(none)") > -1) {
                                //no topics present
                                more = false;
                        }
                        
                        while (more){
                                //adds new cat s to the menu
                                if (readresult.indexOf("topic") == -1) {
                                        final String toAdd = readresult.substring(6);
                                        menuContent.add(toAdd);
                                } else { 
                                        more = false;
                                }
                                //read </newcat
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("2 " + readresult);
                                //read <newcat (normally)
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("3 " + readresult); 
                                if (readresult.indexOf("topic") != -1) {
                                        //no more categories
                                        more = false; 
                                }
                                //read next cat / topic
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("4 " + readresult);       
                        }
                        //set topic
                        grammarName = readresult.substring(4) + "          ";
                        //read </topic>
                        readresult = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("2 " + readresult);
                        //read <language>
                        readresult = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("3 " + readresult);
                        //read actual language
                        readresult = fromProc.readLine();             
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("4 " + readresult);       
                        
                        //read the languages and select the last non-abstract
                        more = true;
                        while (more){
                                if ((readresult.indexOf("/gfinit") == -1) 
                                                && (readresult.indexOf("lin") == -1)) {         
                                        //form lang and Menu menu:
                                        final String langName = readresult.substring(4);
                                        languages.add(langName);
                                } else { 
                                        more = false;
                                }
                                // read </language>
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("2 " + readresult); 
                                // read <language> or </gfinit...>
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("3 " + readresult); 
                                if ((readresult.indexOf("/gfinit") != -1) 
                                                || (readresult.indexOf("lin") != -1)) { 
                                        more = false; 
                                }
                                // registering the file name:
                                if (readresult.indexOf("language") != -1) {
                                        String path = readresult.substring(readresult.indexOf('=') + 1,
                                                        readresult.indexOf('>')); 
                                        path = path.substring(path.lastIndexOf(File.separatorChar) + 1);
                                        if (xmlLogger.isLoggable(Level.FINE)) xmlLogger.fine("language: " + path);
                                        paths.add(path);
                                }
                                // in case of finished, read the final "" after </gfinit>, 
                                // otherwise the name of the next language
                                readresult = fromProc.readLine();             
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("4 " + readresult);               
                        }
                } catch(IOException e){
                        xmlLogger.warning(e.getMessage());
                }
                String[] menuContentArray = Utils.vector2Array(menuContent);
                String[] languagesArray = Utils.vector2Array(languages);
                String[] pathsArray = Utils.vector2Array(paths);
                NewCategoryMenuResult result = new NewCategoryMenuResult(grammarName, menuContentArray, languagesArray, pathsArray);
                return result;
        }

        /**
         * Reads the hmsg part of the XML that is put out from GF.
         * Everything in [] given in front of a GF command will be rewritten here.
         * This method does nothing when no hmsg part is present.
         * 
         * If a '$' appears in this string, everything that comes after it
         * will be in result.second.
         * ;; and [] don't work in the [] for the hmsg, 
         * therfore the following replacements are done:
         *   %% for ;;
         *   (  for [
         *   )  for ]
         * 
         * If one of the characters c,t,n comes before, the following is done:
         *   c The output will be cleared before the linearization (TODO: done anyway?)
         *   t The treeChanged flag will be set to true
         *   n The newObject flag will be set to true
         *   p No other probing run should be done (avoid cycles)
         *   r To prevent the execution of automatically triggered commands to prevent recursion
         *  
         * @param prevreadresult The last line read from GF
         * @return first: the last line this method has read;
         * second: the string after $, null if that is not present
         */
        protected Hmsg readHmsg(String prevreadresult){
                if ((prevreadresult!=null)&&(prevreadresult.indexOf("<hmsg>") > -1)) {
                        StringBuffer s =new StringBuffer("");
                        String commandAppendix = null;
                        try {
                                boolean onceAgain = true;
                                boolean recurse = true;
                                boolean newObj = false;
                                boolean treeCh = false;
                                boolean clear = false;
                                String readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("7 "+readresult);
                                while (readresult.indexOf("/hmsg")==-1){       
                                        s.append(readresult).append('\n');           
                                        readresult = fromProc.readLine();
                                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("7 "+readresult);                     
                                }
                                int commandAppendixStart = s.indexOf("$"); 
                                if (commandAppendixStart > -1 && commandAppendixStart < s.length() - 1) { //present, but not the last character
                                        commandAppendix = s.substring(commandAppendixStart + 1, s.indexOf("\n")); //two \n trail the hmsg
                                        //;; and [] don't work in the [] for the hmsg
                                        commandAppendix = Utils.replaceAll(commandAppendix, "%%", ";;");
                                        commandAppendix = Utils.replaceAll(commandAppendix, "(", "[");
                                        commandAppendix = Utils.replaceAll(commandAppendix, ")", "]");
                                } else {
                                        commandAppendixStart = s.length();
                                }
                                if (s.indexOf("c") > -1 && s.indexOf("c") < commandAppendixStart) {
                                        //clear output before linearization
                                        clear = true;
                                }
                                if (s.indexOf("t") > -1 && s.indexOf("t") < commandAppendixStart) {
                                        //tree has changed
                                        treeCh = true;
                                }
                                if (s.indexOf("p") > -1 && s.indexOf("p") < commandAppendixStart) {
                                        //we must not probe again
                                        onceAgain = false;
                                }
                                if (s.indexOf("r") > -1 && s.indexOf("r") < commandAppendixStart) {
                                        //we must not probe again
                                        recurse = false;
                                }

                                if (s.indexOf("n") > -1 && s.indexOf("n") < commandAppendixStart) {
                                        //a new object has been created
                                        newObj = true;
                                }
                                if (logger.isLoggable(Level.FINE)) {
                                        if (commandAppendix != null) {
                                                logger.fine("command appendix read: '" + commandAppendix + "'");
                                        }
                                }
                                return new Hmsg(readresult, commandAppendix, onceAgain, recurse, newObj, treeCh, clear);
                        } catch(IOException e){
                                System.err.println(e.getMessage());
                                e.printStackTrace();
                                return new Hmsg("", null, false, true, false, true, false);
                        }
                } else {
                        return new Hmsg(prevreadresult, null, true, true, false, true, false);
                }
        }

        /**
         * Parses the GF-output between <menu> and </menu>  tags
         * and puts a StringTuple for each show/send pair into the
         * return vector.
         * @return A Vector of StringTuple as described above
         */
        protected Vector readRefinementMenu (){
                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("list model changing! ");      
                String s ="";
                Vector printnameVector = new Vector();
                Vector commandVector = new Vector();
                Vector gfCommandVector = new Vector();
                try {
                        //read <menu>
                        String readresult = fromProc.readLine();             
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("7 " + readresult);          
                        //read item
                        readresult = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("8 " + readresult);
                        while (readresult.indexOf("/menu")==-1){
                                //read show
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("8 " + readresult);
                                while (readresult.indexOf("/show") == -1){          
                                        readresult = fromProc.readLine();
                                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("9 " + readresult);
                                        if (readresult.indexOf("/show") == -1) {
                                                if (readresult.length()>8)
                                                        s += readresult.trim();
                                                else
                                                        s += readresult;    
                                        }
                                }            
                                //          if (s.charAt(0)!='d')
                                //            listModel.addElement("Refine " + s);
                                //          else 
                                String showText = s;
                                printnameVector.addElement(s);
                                s = "";
                                //read /show
                                //read send
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("8 " + readresult);
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("8 " + readresult);
                                String myCommand = readresult;
                                commandVector.add(readresult);
                                //read /send (discarded)
                                readresult = fromProc.readLine();             
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("8 " + readresult);          
                                
                                // read /item
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("8 " + readresult);
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("8 " + readresult);
                                
                                StringTuple st = new StringTuple(myCommand.trim(), showText);
                                gfCommandVector.addElement(st);
                        }
                } catch(IOException e){
                        System.err.println(e.getMessage());
                        e.printStackTrace();
                }
                return gfCommandVector;
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
                        if (logger.isLoggable(Level.FINER)) {
                                logger.finer("3 " + nextRead);
                        }
                        while (!nextRead.trim().equals(closing)) {
                                nextRead = fromProc.readLine();
                                if (logger.isLoggable(Level.FINER)) {
                                        logger.finer("3 " + nextRead);
                                }
                        }
                } catch (IOException e) {
                        System.err.println("Could not read from external process:\n" + e);
                }
        }
}
