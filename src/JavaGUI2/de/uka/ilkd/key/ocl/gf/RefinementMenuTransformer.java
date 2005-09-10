//Copyright (c) Hans-Joachim Daniels 2005
//
//This program is free software; you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation; either version 2 of the License, or
//(at your option) any later version.
//
//You can either finde the file LICENSE or LICENSE.TXT in the source 
//distribution or in the .jar file of this application

package de.uka.ilkd.key.ocl.gf;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * This class is completely static and cannot be instantiated. 
 * @see #transformRefinementMenu(de.uka.ilkd.key.ocl.gf.TreeAnalysisResult, java.util.Vector, de.uka.ilkd.key.ocl.gf.GfCapsule)
 * @author hdaniels
 */
class RefinementMenuTransformer {
        /**
         * if things are added to or removed from the refinement menu 
         */
        protected static Logger logger = Logger.getLogger(RefinementMenuTransformer.class.getName()); 
        
        private RefinementMenuTransformer() {
                //A private constructor enforces the noninstantiability 
                //of "RefinementMenuTransformer". 
                //(See item 3 of "Effective Java".)
        }
        
        /**
         * Depending on tar, the refinement menu given in raw form in oldMenu
         * is transformed.
         * That includes:
         *  - adding properties of self
         *  - producing a reduced version for subtyping below a coerce 
         *    where only Instances of subtypes are listed
         *  - probes, if self and result are really applicable
         *  - changes the delete command, when an unrefined Instance
         *    argument of coerce is clicked on, to first delete the
         *    whole coerce to avoid sticking with wrong type arguments.
         * @param tar TreeAnalyser has decided what to do here. That is followed.
         * @param oldMenu The original content of the refinement menu.
         * Is a Vector of StringTuple
         * @param gfCapsule The encapsulation of GF regarding read/write access
         * @return The refinement menu in its new form
         */
        protected static Vector transformRefinementMenu(TreeAnalysisResult tar, Vector oldMenu, GfCapsule gfCapsule) {
                //now do fill (or partially empty) the offered commands list
                final Vector usedCommandVector;
                if (tar.reduceCoerce) {
                        //is only true if switched on globally.
                        //And if conditions are right.
                        usedCommandVector = produceReducedCoerceRefinementMenu(tar.focusPosition.position, gfCapsule);
                } else {
                        usedCommandVector = oldMenu;
                }
                if (tar.deleteAlsoAbove) {
                        String newPos = tar.focusPosition.parentPosition();
                        StringTuple newDelete = new StringTuple("mp " + newPos + " ;; d", "delete current subtree\\$also delete the encompassing coercion ");
                        exchangeCommand(usedCommandVector, "d", newDelete);
                }
                if (tar.probeSelfResult) {
                        probeCompletability(usedCommandVector, tar.focusPosition, gfCapsule);
                }
                if (tar.easyAttributes && !tar.reduceCoerce) {
                        addSelfProperties(usedCommandVector, tar.focusPosition, gfCapsule);
                }                
                return usedCommandVector;
        }
        
        /**
         * Looks at the subtyping witness of the same coerce as currentPos
         * and collects the possible refinements for all offered subtypes.
         * It assumes that argument 0 of coerce is automatically filled in.
         * 
         * This method is surely <b>slow</b> since a lot of calls to GF is made
         * here.
         * @param currentPos musst point to a child of a coerce.
         * @param gfCapsule The encapsulation of GF regarding read/write access
         * @return a Vector of StringTuple as readRefinementMenu does.
         * This Vector can be fed into formRefinementMenu.
         */
        private static Vector produceReducedCoerceRefinementMenu(String currentPos, GfCapsule gfCapsule) {
                final HashSet commands = new HashSet();
                RefinementMenuCollector rmc = new RefinementMenuCollector(gfCapsule);
                //move to the subtype witness argument
                final String collectSubtypesCommand = "mp " + LinPosition.calculateBrethrenPosition(currentPos, 2); 
                Vector possibleSubtypes = rmc.readRefinementMenu(collectSubtypesCommand);
                String undoString = "";
                final String undoTemplate = "u 2 ;; ";
                for (Iterator it = possibleSubtypes.iterator(); it.hasNext(); ) {
                        StringTuple nextCommand = (StringTuple)it.next();
//                        if (!nextCommand.first.trim().startsWith("r")) {
//                                //no ac, d, rc or whatever wanted here. Only refine.
//                                continue;
//                        }
                        final String collectRefinementsCommand = undoString  + nextCommand.first + " ;; mp " + currentPos;
                        undoString = undoTemplate; //for all following runs we want an undo before it
                        Vector nextRefinements = rmc.readRefinementMenu(collectRefinementsCommand);
                        commands.addAll(nextRefinements);
                }
                final String cleanupCommand = "u 3"; //undo the last command and also the first mp
                rmc.readRefinementMenu(cleanupCommand); //no harm done here, collector won't get reused
                Vector result = new Vector(commands);
                return result;
        }
        
        /**
         * checks if result and self make sense in the current context.
         * if not, they are removed from oldMenu
         * @param oldMenu A Vector of StringTuple that represents the 
         * commands for the refinement menu
         * @param focusPos The current position in the AST
         * @param gfCapsule The encapsulation of GF regarding read/write access
         */
        private static void probeCompletability(Vector oldMenu, LinPosition focusPos, GfCapsule gfCapsule) {
                /**
                 * self and result both take two arguments.
                 * The first is the type, which is fixed
                 * if the second argument is refineable.
                 * Important is the second. 
                 * This only is refineable for the real type of self/result 
                 */
                if (focusPos == null) {
                        //sadly, we can't do much
                        return;
                }
                final String childPos = focusPos.childPosition(1);
                final SelfResultProber cp = new SelfResultProber(gfCapsule);
                for (int i = 0; i < oldMenu.size(); i++) {
                        String cmd = ((StringTuple)oldMenu.elementAt(i)).first;
                        if ((cmd != null) && ((cmd.indexOf("r core.self") > -1) || (cmd.indexOf("r core.result") > -1))) {
                                //the first mp is necessary for the second of self/result.
                                //without, GF will jump to a stupid position
                                String newCommand = "mp " + focusPos.position + " ;; " + cmd + " ;; mp " + childPos;
                                if (!cp.isAutoCompletable(newCommand, 3)) {
                                        oldMenu.remove(i);
                                        i -=1;
                                }
                        }
                }
        }

        /**
         * Probes for the properties of self, that could be filled in at
         * the current focus position.
         * If it finds any, these are added to oldMenu
         * This method will add all offered commands to the refinement menu,
         * not only for suiting subtypes due to speed reasons.
         * @param oldMenu A Vector of StringTuple. The menu with the commands
         * and show texts as given by GF. Gets modified.
         * @param focusPos The position of the GF focus in the AST
         * @param gfCapsule The encapsulation of GF regarding read/write access
         */
        private static void addSelfProperties(Vector oldMenu, LinPosition focusPos, GfCapsule gfCapsule) {
                //solve in between to avoid some typing errors by closing some type arguments
                final String probeCommand = "r core.implPropCall ;; mp " + focusPos.childPosition(2) + " ;; r core.self ;; solve ;; mp " + focusPos.childPosition(3);
                final String deleteAppendix = " ;; d";
                final RefinementMenuCollector rmc = new RefinementMenuCollector(gfCapsule);
                Vector futureRefinements = rmc.readRefinementMenu(probeCommand + deleteAppendix);
                final int undos = 5;
                final boolean singleRefinement;
                if (futureRefinements.size() == 1) {
                        singleRefinement = true;
                } else {
                        singleRefinement = false;
                }
                final String cleanupCommand = "u " + undos;
                rmc.readRefinementMenu(cleanupCommand); //no harm done here
                for (Iterator it = futureRefinements.iterator(); it.hasNext();) {
                        StringTuple st = (StringTuple)it.next();
                        if (st.first.startsWith("r")) { //is a refinement, no ac or d
                                String newCommand;
                                //add the command that came before
                                final int cmdUndos;
                                if (singleRefinement) {
                                        //that is an exceptional case, but might happen.
                                        //Here we don't have to refine the final property
                                        //at all, since GF does that automatically
                                        newCommand = probeCommand + " ;; c solve";
                                        cmdUndos = 5;
                                } else {
                                        //here the 'd' is not needed, since we know,
                                        //that nothing is refined automatically
                                        newCommand = probeCommand + " ;; " + st.first + " ;; c solve";
                                        cmdUndos = 6;
                                }
                                // now extract the fun of the property
                                String fun = st.first.substring(1).trim();
                                ChainCommandTuple cct = new ChainCommandTuple(newCommand, st.second, fun, PrintnameManager.SELF_SUBCAT, cmdUndos);
                                if (logger.isLoggable(Level.FINER)) {
                                        logger.finer("added " + cct);
                                }
                                oldMenu.add(cct);
                        }
                }
        }        
        
        /**
         * Goes through oldMenu and if it finds a command in there, where
         * first.equals(oldCommand), this command is replaced by newCommand.
         * oldMenu's content thus gets modified.
         * @param oldMenu a Vector of StringTuple
         * @param oldCommand a GF command string (what is sent, not the show text)
         * @param newCommand a StringTuple representing what could be a pait from GF
         */
        private static void exchangeCommand(Vector oldMenu, String oldCommand, StringTuple newCommand) {
                for (int i = 0; i < oldMenu.size(); i++) {
                        StringTuple next = (StringTuple)oldMenu.get(i);
                        if (next.first.equals(oldCommand)) {
                                oldMenu.remove(i);
                                oldMenu.insertElementAt(newCommand, i);
                        }
                }
        }
        
}
