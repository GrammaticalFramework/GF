//Copyright (c) Hans-Joachim Daniels 2005
//
//This program is free software; you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation; either version 2 of the License, or
//(at your option) any later version.
//
//You can either finde the file LICENSE or LICENSE.TXT in the source 
//distribution or in the .jar file of this applicationpackage de.uka.ilkd.key.ocl.gf;

package de.uka.ilkd.key.ocl.gf;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * This class is an unclean hack.
 * The whole refinement menu architecture expected, that everything is probed,
 * when the refinement menu is getting created.
 * But for getting only subtype correct properties of self needs a number of
 * calls to GF, which could be deferred to not make things slower than they
 * already are.
 * This deferred probing is done in this class.
 * @author daniels
 *
 */
class SelfPropertiesCommand extends LinkCommand {
        private final static Logger logger = Logger.getLogger(SelfPropertiesCommand.class.getName());
        private final GfCapsule gfCapsule;
        private final LinPosition focusPos;
        private final String toAppend;
        private final boolean isAbstract;
        private final HashSet processedSubcats;
        private final PrintnameManager printnameManager;

        /**
         * A simple setter constructor, no calculation done here.
         * @param manager The printname manager, that knows, how the properties
         * of self should be listed in the refinement menu
         * @param gfCapsule The reader/writer abstraction from GF
         * @param focusPos The position of the GF focus
         * @param isAbstract if Abstract is the current menu language
         * @param toAppend If something should be appended to the command
         * @param processedSubcats Here, the subcat for self is put into
         */
        public SelfPropertiesCommand(final PrintnameManager manager, GfCapsule gfCapsule, LinPosition focusPos, boolean isAbstract, String toAppend, HashSet processedSubcats) {
                super(PrintnameManager.SELF_SUBCAT, manager);
                this.gfCapsule = gfCapsule;
                this.printnameManager = manager;
                this.focusPos = focusPos;
                this.processedSubcats = processedSubcats;
                this.toAppend = toAppend;
                this.isAbstract = isAbstract;
        }

        /**
         * @return a Vector of RealCommand containing the suitable properties
         * of self at the current focus position.
         * Subtyping is taken into account, so only properties with a subtype
         * of the supertype of the coerce above (at other places this method
         * is not applicable) show up in this menu.
         * The method used is similiar to the one for Instances below a coerce.
         */
        Vector produceSubmenu() {
                logger.fine("SelfPropertiesCommand asked to produce a menu");
                //HashSet to prevent duplicates
                final HashSet commands = new HashSet();
                RefinementMenuCollector rmc = new RefinementMenuCollector(gfCapsule);
                //move to the subtype witness argument
                final String collectSubtypesCommand = "mp " + LinPosition.calculateBrethrenPosition(focusPos.position, 2); 
                final Vector possibleSubtypes = rmc.readRefinementMenu(collectSubtypesCommand);
                String undoString = "";
                int undos = 0;
                //for the case, that there is only one possible refinement at all
                //which gets automatically filled in
                final StringBuffer singleReplacement = new StringBuffer();
                //loop through the offered Subtype refinements
                for (Iterator it = possibleSubtypes.iterator(); it.hasNext(); ) {
                        StringTuple nextCommand = (StringTuple)it.next();
                        if (!nextCommand.first.trim().startsWith("r")) {
                                //no ac, d, rc or whatever wanted here. Only refine.
                                continue;
                        }
                        final String commandPrefix = undoString + nextCommand.first + " ;; mp " + focusPos.position + " ;; ";
                        logger.finer("commandPrefix: " + commandPrefix);
                        Vector futureRefinements = new Vector();
                        undos = addSelfProperties(futureRefinements, commandPrefix, singleReplacement);
                        undos += 2; // to undo commandPrefix
                        undoString = "u " + undos + " ;; "; //for all following runs we want an undo before it
//                        Vector nextRefinements = rmc.readRefinementMenu(collectRefinementsCommand);
                        commands.addAll(futureRefinements);
                }
                final String cleanupCommand = "u " + (undos + 1); //undo the last command and also the first mp
                rmc.readRefinementMenu(cleanupCommand); //no harm done here, collector won't get reused
                Vector result = new Vector();
                for (Iterator it = commands.iterator(); it.hasNext();) {
                        StringTuple st = (StringTuple)it.next();
                        if ((commands.size() == 1) && (st instanceof ChainCommandTuple)) {
                                //the case when only one property is available at all.
                                //Then this will automatically be selected
                                //To compensate for that, singleRefinement is used.
                                //This will be just one refinement, otherwise, we
                                //wouldn't be in this branch.
                                //This refinement does not contain the actual r 
                                //command and therefore needs one undo step less
                                ChainCommandTuple cct = (ChainCommandTuple)st;
                                st = new ChainCommandTuple(singleReplacement.toString(), cct.second, cct.fun, cct.subcat, cct.undoSteps - 1);
                        }
                        GFCommand gfcommand;
                        if (st instanceof ChainCommandTuple) {
                                ChainCommandTuple cct = (ChainCommandTuple)st;
                                gfcommand = new RealCommand(st.first, processedSubcats, printnameManager, st.second, isAbstract, toAppend, cct.undoSteps, cct.fun, cct.subcat);
                        } else {
                                gfcommand = new RealCommand(st.first, processedSubcats, printnameManager, st.second, isAbstract, toAppend);
                        }
                        result.add(gfcommand);
                }
                Collections.sort(result);
                return result;
        }
        
        /**
         * Probes for the properties of self, that could be filled in at
         * the current focus position.
         * If it finds any, these are added to result.
         * @param result The Vector, that will get filled with the collected 
         * chain commands
         * @param commandPrefix The prefix, that is to be prepended to the 
         * probing command. Used for refining with a Subtype witness and a
         * mp to the Instance position, where this method expects to start.
         * @param singleReplacement This is a hack for cases, when GF refines
         * an refinement automatically. If that happens only for one subtype,
         * then GF would fill that in automatically even when the supertype is
         * open. Therefore, it must be omitted in the actual command.
         * But this situation can only be checked after all subtypes have been
         * probed.
         * @return the number of undo steps needed to undo the probing command
         * (without prefix, that is handled by the caller)
         */
        private int addSelfProperties(final Vector result, final String commandPrefix, final StringBuffer singleReplacement) {
                //solve in between to avoid some typing errors by closing some type arguments
                final String probeCommand = "r core.implPropCall ;; mp " + focusPos.childPosition(2) + " ;; r core.self ;; solve ;; mp " + focusPos.childPosition(3);
                final String deleteAppendix = " ;; d";
                final RefinementMenuCollector rmc = new RefinementMenuCollector(gfCapsule);
                final String actualProbeCommand = commandPrefix + probeCommand + deleteAppendix;
                logger.finer("&&& actual probe command:: " + actualProbeCommand);
                Vector futureRefinements = rmc.readRefinementMenu(actualProbeCommand);
                final int undos = 5;
                for (Iterator it = futureRefinements.iterator(); it.hasNext();) {
                        StringTuple st = (StringTuple)it.next();
                        if (st.first.startsWith("r")) { //is a refinement, no ac or d
                                String newCommand;
                                //add the command that came before
                                final int cmdUndos;
                                if (futureRefinements.size() == 1) {
                                        //the case, when only one property is defined in the grammar:
                                        singleReplacement.append(probeCommand + " ;; c solve");
                                }
                                newCommand = probeCommand + " ;; " + st.first + " ;; c solve";
                                cmdUndos = 6;
                                // now extract the fun of the property
                                String fun = st.first.substring(1).trim();
                                ChainCommandTuple cct = new ChainCommandTuple(newCommand, st.second, fun, PrintnameManager.SELF_SUBCAT, cmdUndos);
                                if (logger.isLoggable(Level.FINE)) {
                                        logger.finer("added " + cct);
                                }
                                result.add(cct);
                        }
                }
                return undos;
        }
}
