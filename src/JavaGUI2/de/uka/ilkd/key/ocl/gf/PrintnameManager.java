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
import java.util.Hashtable;
import java.util.logging.*;

/**
 * @author daniels
 *
 * An object of this class manages a bunch of printlines which is comprised of 
 * storage and retrieval. Also giving the subcategory shortnames their long
 * counterpart is done here.
 */
class PrintnameManager {
        /**
        * This constructor is a bit of a hack.
        * It puts the \%SELF subcat into this.printnames.
        * This subcat does not appear in the grammars and thus is
        * introduced here. If it is defined there although, this
        * definition is used. So it does not hurt.
        */
        public PrintnameManager() {
                this.subcatNames.put(SELF_SUBCAT, "properties of self\\$shortcuts to the properties of self, that have a fitting type");
        }
        
        /**
         * The name of the subcat, that is used for the easy property access
         * of self. 
         */
        static final String SELF_SUBCAT = "\\%SELF";
        
        private static Logger logger = Logger.getLogger(Printname.class.getName());
        
        protected final static String frontMatter = "printname fun ";
        
        /**
         * The hashmap for the names of the sub categories, 
         * with the shortname starting with '%' as the key.
         * It is important that all Printnames of one session share the same
         * instance of Hashtable here. 
         * This field is not static because there can be several instances of
         * the editor that shouldn't interfere.
         */
        protected final Hashtable subcatNames = new Hashtable();
        
        /** 
         * contains all the Printnames with the fun names as keys 
         */
        protected final Hashtable printnames = new Hashtable();

        /**
         * processes a line from the "gf pg -printer=printnames" command
         * @param line the read line from GF
         * Should look like 
         * printname fun neq = "<>," ++ ("parametrized" ++ ("disequality$to" ++ ("compare" ++ ("two" ++ ("instances" ++ ("on" ++ ("a" ++ ("specific" ++ "type%COMP"))))))))
         * and needs to get like
         * printname fun neq = "<>, parametrized disequality$to compare two instances on a specific type%COMP"
         * @param funTypes contains funs, mapped to their types
         */
        public void addNewPrintnameLine(String line, Hashtable funTypes) {
                line = removePluses(line);
                
            	//remove "printname fun " (the frontMatter)
            	final int index = line.indexOf(frontMatter);
            	line = line.substring(index + frontMatter.length()).trim();

            	//extract fun name
            	final int endFun = line.indexOf(' ');
            	final String fun = line.substring(0, endFun);
            	final String type = (String)funTypes.get(fun);
            	//extract printname
            	String printname = line.substring(line.indexOf('"') + 1, line.lastIndexOf('"'));

            	addNewPrintname(fun, printname, type);
        }
        
        /**
         * The printname printer of pg spits out no String, but a wrapping of 
         * small Strings conjoined with ++ which includes lots of parantheses.
         * @param line The GF line from pg -printer=printnames
         * @return a String representing the actual printname without the clutter
         */
        protected static String removePluses(String line) {
                line = line.replaceAll("\"\\)*\\s*\\+\\+\\s*\\(*\""," ");
            	int index = line.lastIndexOf('"');
            	line = line.substring(0, index + 1);
            	return line;
        }
        
        
        /**
         * Constructs the actual printname and puts it into printnames
         * @param myFun the GF abstract fun name
         * @param myPrintname the printname given by GF
         */
        protected void addNewPrintname(String myFun, String myPrintname, String type) {
                if (logger.isLoggable(Level.FINER)) {
                        logger.finer("addNewPrintname, myFun = '" + myFun + "' , myPrintname = '" + myPrintname + "'");
                }
                Printname printname = new Printname(myFun, myPrintname, this.subcatNames, type);
                if (logger.isLoggable(Level.FINER)) {
                        logger.finer("printname = '" + printname + "'");
                }
                this.printnames.put(myFun, printname);
        }
        
        /**
         * looks for the Printname corresponding to the given fun.
         * If the fun is qualified with a module and no Printname
         * is found with module, another lookup without the module part
         * is made.
         * @param myFun the GF abstract fun name (with or without qualification)
         * @return the corresponding Printname iff that one exists, null otherwise
         */
        public Printname getPrintname(String myFun) {
                Printname result = null;
                if (this.printnames.containsKey(myFun)) {
                        result = (Printname)this.printnames.get(myFun);
                } else {
                        int index = myFun.indexOf('.');
                        if (index > -1) {
                                //a valid fun name must not be empty
                                String fun = myFun.substring(index + 1);
                                if (printnames.containsKey(fun)) {
                                        result =  (Printname)this.printnames.get(fun);
                                }
                        }
                }
                if (result == null) {
                        //?n indicates that myFun is a metavariable of GF, 
                        // which does not occur in the refinement menu.
                        // if that is not wanted, don't call this method!
                        if (!myFun.startsWith("?")) {
                                logger.fine("no printname for '" + myFun + "', pretend that it is a bound variable");
                                return new Printname(myFun);
                        }
                }
                return result;
        }
        
        /**
         * looks up the full name for the subcategory name shortname.
         * This is the %SOMETHING from the printname.
         * @param shortname The subcat name which should get expanded
         * @return the corresponding full name, maybe null!
         */
        public String getFullname(String shortname) {
                String result = (String)this.subcatNames.get(shortname);
                return result;
        }

        public static void main(String[] args) {
                String a = "printname fun stringLiteral = \"arbitrary\" ++ (\"String$click\" ++ (\"read\" ++ (\"and\" ++ (\"enter\" ++ (\"the\" ++ (\"String\" ++ (\"in\" ++ (\"the\" ++ (\"dialog\" ++ (\"TODO%STRING(String\" ++ \"operations)\"))))))))))";
                System.out.println(a);
                System.out.println(removePluses(a));
                a = "printname fun count = \"count\" ++ (\"the\" ++ (\"occurances\" ++ (\"of\" ++ (\"an\" ++ (\"object\" ++ (\"in\" ++ (\"the\" ++ \"collection.\")))))))++ (\"%COLL\" ++ (\"#collElemType\" ++ (\"The\" ++ (\"official\" ++ (\"element\" ++ (\"type\" ++ (\"of\" ++ (\"<i>coll</i>.<br>That\" ++ (\"is,\" ++ (\"the\" ++ (\"parameter\" ++ (\"type\" ++ (\"of\" ++ \"<i>coll</i>\")))))))))))++ (\"#set\" ++ (\"The\" ++ (\"Set\" ++ (\"in\" ++ (\"which\" ++ (\"occurances\" ++ (\"of\" ++ (\"<i>elem</i>\" ++ (\"are\" ++ (\"to\" ++ (\"be\" ++ \"counted.\")))))))))) ++ (\"#elem\" ++ (\"The\" ++ (\"instance\" ++ (\"of\" ++ (\"which\" ++ (\"the\" ++ (\"occurances\" ++ (\"in\" ++ (\"<i>coll</i>\" ++ (\"are\" ++ \"counted.\")))))))))))))";
                System.out.println(a);
                System.out.println(removePluses(a));
        }
        
}
