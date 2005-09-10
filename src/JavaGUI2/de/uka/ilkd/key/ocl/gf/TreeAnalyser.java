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

import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.tree.DefaultMutableTreeNode;

/**
 * Goes through the AST and:
 *   Labels node according to the following:
 *     hidden, if they are a coerce without a constraint
 *     colored, if they are a coerce with a constraint
 *   Saves a reference to the currently selected node
 *   Finds out 
 *     if attributes of self should be given an easy access,
 *     if the refinement menu below a coerce should be reduces,
 *     if it should be probed, if self and result are superfluous
 *       in the refinement menu.
 *     if a coerce should be introduced automatically.
 * Takes a tree and hides the nodes labelled as hidden in another stage.
 * @author hdaniels
 */
class TreeAnalyser {
        /** 
         * debug stuff for the tree 
         */
        private static Logger treeLogger = Logger.getLogger(TreeAnalyser.class.getName());
        /** 
         * dealing with coerce, when it is inserted and so on 
         */
        private static Logger coerceLogger = Logger.getLogger(TreeAnalyser.class.getName() + ".coerce");

        /**
         * if coerce should get hidden, if all their arguments are refined
         */
        private boolean hideCoerce;
        /**
         * if coerce should always be hidden,
         */
        private boolean hideCoerceAggressive;
        /**
         *  if the refinement menu should get condensed at all
         */
        private boolean coerceReduceRM;
        /**
         * if coerce should get introduced automatically at all
         */
        private boolean autoCoerce;
        /**
         * if result and self should be shown always
         */
        private boolean showSelfResult;
        /**
         * if properties of self should be probed for
         */
        private boolean easyAttributes;
        /**
         * If coerces whith both Class arguments
         */
        private boolean highlightSubtypingErrors;
        
        /**
         * @param autoCoerce if coerce should get introduced automatically at all
         * @param coerceReduceRM if the refinement menu should get condensed at all
         * @param easyAttributes if properties of self should be probed for
         * @param hideCoerce if coerce should get hidden, if all their arguments are refined
         * @param hideCoerceAggressive if coerce should always be hidden, 
         * unless there is a GF constraint
         * @param highlightSubtypingErrors If coerces whith both Class arguments 
         * refined, but not with the Subtype argument should get marked
         * @param showSelfResult if result and self should be shown always
         */
        public TreeAnalyser(boolean autoCoerce, boolean coerceReduceRM, boolean easyAttributes, boolean hideCoerce, boolean hideCoerceAggressive, boolean highlightSubtypingErrors, boolean showSelfResult) {
                this.autoCoerce = autoCoerce;
                this.coerceReduceRM = coerceReduceRM;
                this.easyAttributes = easyAttributes;
                this.hideCoerce = hideCoerce;
                this.hideCoerceAggressive = hideCoerceAggressive;
                this.highlightSubtypingErrors = highlightSubtypingErrors;
                this.showSelfResult = showSelfResult;
        }

        
        /**
         * Takes the rootNode of the AST and does some small analysis on it:
         *   Check for missing Subtype witnesses, 
         *   check if the Instance menu of a Coerce can be reduced
         * @param topNode The root or top node of the AST
         * @return an object that contains the result of this analysis.
         * Currently this applies only to the selected node. 
         * @see TreeAnalysisResult 
         */
        TreeAnalysisResult analyseTree(DefaultMutableTreeNode topNode) {
                //just the initial values
                String resultCommand = null;
                int resultUndoSteps = -1;
                boolean resultReduceCoerce = false;
                boolean resultProbeSelfResult = false;
                boolean resultDeleteAlsoAbove = false;
                boolean resultEasyAttributes = false;
                TreeAnalysisResult tar = new TreeAnalysisResult(resultCommand, resultUndoSteps, resultReduceCoerce, resultProbeSelfResult, resultDeleteAlsoAbove, resultEasyAttributes, null, null);

                //doing it depth first, because we have to know the subtypingStatus
                //of the children of coerce before we analyze coerce itself
                for (Enumeration e = topNode.depthFirstEnumeration() ; e.hasMoreElements() ;) {
                        DefaultMutableTreeNode currNode = (DefaultMutableTreeNode)e.nextElement();
                        analyseTreeNode(currNode, tar);
                }
                AstNodeData and = (AstNodeData)tar.selectedNode.getUserObject();
                if ((and.showInstead != -1) && (tar.command == null)) {
                        //if the current node is hidden, move up in the tree,
                        //until a visible node is found
                        DefaultMutableTreeNode tn = (DefaultMutableTreeNode)tar.selectedNode.getParent();
                        AstNodeData dand = null;
                        while (tn != null) {
                                dand = (AstNodeData)tn.getUserObject();
                                if (dand.showInstead == -1) {
                                        //found a visible node
                                        break;
                                }
                                tn = (DefaultMutableTreeNode)tn.getParent();
                        }
                        if (dand != null) {
                                tar.command = "[tr] mp " + dand.position;
                                tar.undoSteps = 1;
                        } //otherwise give up, can only occur, if coerce is the top node.
                        //And for that, one would have to do a "n Instance" first,
                        //which GF does not even offer.
                }
                return tar;
        }
        
        /**
         * Takes the rootNode of the AST and does some small analysis on it:
         *   Check for missing Subtype witnesses, 
         *   check if the Instance menu of a Coerce can be reduced
         * @param nodeToCheck The node that is to be analysed
         * @param tar The result, that gets modified
         * @see TreeAnalysisResult
         */
        private void analyseTreeNode(DefaultMutableTreeNode nodeToCheck, TreeAnalysisResult tar) {
                AstNodeData and = (AstNodeData)nodeToCheck.getUserObject();
                DefaultMutableTreeNode parent = (DefaultMutableTreeNode)nodeToCheck.getParent();
                Printname parentPrintname = null;
                if ((parent != null) && (parent.getUserObject() != null) && (parent.getUserObject() instanceof AstNodeData)) {
                        AstNodeData parentAnd = (AstNodeData)parent.getUserObject();
                        parentPrintname = parentAnd.getPrintname();
                }

                if (and.selected) {
                        tar.selectedNode = nodeToCheck;
                        tar.currentNode = and.node;
                        //set the focusPosition to a preliminary value
                        tar.focusPosition = new LinPosition(and.position, true);
                        //rather check too much for null
                        if (this.autoCoerce
                                        && (and.node != null)
                                        && and.node.isMeta()
                                        && (parent != null)
                                        && (parent.getUserObject() != null)
                                        && (and.node.getType() != null)
                                        && (and.node.getType().startsWith("Instance"))) {
                                //check, if a coerce is needed                                
                                GfAstNode parentNode = ((AstNodeData)parent.getUserObject()).node;
                                if (parentPrintname.getParamAutoCoerce(parent.getIndex(nodeToCheck))) {
                                        coerceLogger.fine("Coerceable fun found: " + and.node + " + " + parentNode);
                                        //refine with coerce. Do not allow another GF run, so [r]
                                        tar.command = "[tr] r core.coerce ;; mp " + LinPosition.calculateChildPosition(and.position, 3);
                                        tar.undoSteps = 2; //move there is also sth. to be undone
                                } else if ((parentNode.getFun().indexOf("coerce") > -1)
                                                //to avoid getting stuck below a coerce with wrong type arguments
                                                //the coerce above is deleted and rerefined.
                                                
                                                //coerce below a coerce is never done automatically, so the else if is justified,
                                                //meaning, that introduced a coerce, we do not have to delete it right a away 
                                                && parent.getParent() != null 
                                                && (parent.getParent() instanceof DefaultMutableTreeNode)) {
                                        DefaultMutableTreeNode grandParent = (DefaultMutableTreeNode)parent.getParent();
                                                if (grandParent != null) {
                                                AstNodeData grandParentAnd = (AstNodeData)grandParent.getUserObject();
                                                Printname grandParentPrintname = grandParentAnd.getPrintname();
        
                                                if (grandParentPrintname.getParamAutoCoerce(grandParent.getIndex(parent))) {
                                                        coerceLogger.fine("Auto-Coerce to be un- and redone: " 
                                                                        + and.node + " + " + parentNode 
                                                                        + " -- " + tar.focusPosition.position);
                                                        tar.command = "[tr] mp " + tar.focusPosition.parentPosition() 
                                                                + " ;; d ;; mp " + tar.focusPosition.parentPosition() 
                                                                + " ;; r core.coerce ;; mp " + tar.focusPosition.position;
                                                        tar.undoSteps = 6;
                                                }
                                        }
                                }
                        }
                        
                        if (coerceReduceRM
                                        && (and.node != null)
                                        && (and.node.getType() != null)
                                        && (parent != null)
                                        && (parent.getUserObject() != null)
                                        && (((AstNodeData)parent.getUserObject()).getPrintname() != null)
                                        && (((AstNodeData)parent.getUserObject()).getPrintname().fun.endsWith("coerce"))
                                        && (and.node.getType().startsWith("Instance")) //if coerce, than we are the Instance argument
                                        && (((DefaultMutableTreeNode)(parent.getChildAt(2))).getUserObject() != null)
                                        && (parent.getChildAt(2) != null)
                                        && ((AstNodeData)((DefaultMutableTreeNode)(parent.getChildAt(2))).getUserObject()).node.isMeta()) {
                                AstNodeData superTypeAnd = ((AstNodeData)((DefaultMutableTreeNode)(parent.getChildAt(1))).getUserObject());
                                if (!superTypeAnd.node.isMeta() && (superTypeAnd.node.getFun().indexOf("OclAnyC") == -1)) {
                                        //in these cases, everything goes. No sense in dozends of expensive GF runs then.
                                        tar.reduceCoerce = true;
                                }
                                coerceLogger.fine("candidate for coerce reduction found: " + and.node + " + " + parent);
                        }
                        
                        if (showSelfResult
                                        && (and.node != null)
                                        && (and.node.getType() != null)
                                        && (and.node.getType().startsWith("Instance"))
                                        && (tar.reduceCoerce //not everything is allowed here
                                                      // if not below a coerce (covered above) and no constraints
                                                        || (and.node.getType().indexOf("{") == -1)) 
                                        ){
                                //if there are constraints present, there is no point in probing, since
                                //then either no or every instance is offered.
                                //We do not have to probe then.
                                tar.probeSelfResult = true;
                        }
                        
                        if (easyAttributes
                                        && (and.node != null)
                                        && (and.node.getType() != null)
                                        && (and.node.isMeta())
                                        && (and.node.getType().startsWith("Instance"))
                                ) {
                                //not much to check here
                                tar.easyAttributes = true;
                        }
                }
                
                //check for subtyping errors
                if (highlightSubtypingErrors
                                && (and.node != null)
                                && (and.node.getType() != null)
                                && (parent != null)
                                && (and.node.isMeta()) //otherwise GF would complain
                                && (and.node.getType().startsWith("Subtype")) //if coerce, than we are the Subtype argument
                                ) {
                        AstNodeData subtypeAnd = (AstNodeData)(((DefaultMutableTreeNode)(parent.getChildAt(0))).getUserObject());
                        AstNodeData supertypeAnd = (AstNodeData)(((DefaultMutableTreeNode)(parent.getChildAt(1))).getUserObject());
                        if ((subtypeAnd != null) && (supertypeAnd != null)) {
                                if (!supertypeAnd.node.isMeta() && !subtypeAnd.node.isMeta()) {
                                        //if one of them is meta, then the situation is not fixed yet,
                                        //so don't complain.
                                        and.subtypingStatus = false;
                                } 
                        }
                }
                //hide coerce if possible
                //if coere is completely filled in (all children not meta),
                //it will be replaced by child 3.
                if (hideCoerce
                                && (and.node != null)
                                && (and.node.getType() != null)
                                && (and.node.getFun().endsWith("coerce"))
                                ) {
                        /** 
                         * if true, then something is unfinished or constrained.
                         * So don't hide that node.
                         */
                        boolean metaChild = false;
                        //check if constraints hold for this node
                        if ((and.constraint != null) && (and.constraint.length() > 0)) {
                                //some constraint holds here. 
                                //We must not shroud a possible source for that.
                                metaChild = true;
                        }
                        //This search will only be run once for each coerce:
                        for (int i = 0; i < 3 && !metaChild; i++) {
                                //This is for the more complicated collection
                                //subtyping witnesses.
                                //we do a depthFirst search to find meta nodes.
                                //If they exist, we know that we shouldn't hide this node.
                                for (Enumeration e = ((DefaultMutableTreeNode)nodeToCheck.getChildAt(i)).depthFirstEnumeration() ; e.hasMoreElements() ;) {
                                        DefaultMutableTreeNode currNode = (DefaultMutableTreeNode)e.nextElement();
                                        AstNodeData dand = (AstNodeData)currNode.getUserObject();
                                        if (!dand.subtypingStatus
                                                        //hideCoerceAggressive means that just incomplete type arguments are no reason to not hide the node
                                                        //only subtypingStatus is one because then surely there is an error
                                                        || (!hideCoerceAggressive && dand.node.isMeta())) {
                                                metaChild = true;
                                                break; //no need to go further
                                        }
                                }
                                if (metaChild) {
                                        break;
                                }
                        }
                        //For the Instance argument, we do not have do to a deep search 
                        AstNodeData childAnd = (AstNodeData)(((DefaultMutableTreeNode)(nodeToCheck.getChildAt(3))).getUserObject());
                        if (!hideCoerceAggressive && childAnd.node.isMeta()) {
                                //see reasons for hideCoerceAggressive above
                                metaChild = true;
                        }

                        if (!metaChild) {
                                and.showInstead = 3;
                                //now label the type nodes as hidden
                                for (int i = 0; i < 3 && !metaChild; i++) {
                                        //This is for the more complicated collection
                                        //subtyping witnesses.
                                        for (Enumeration e = ((DefaultMutableTreeNode)nodeToCheck.getChildAt(i)).depthFirstEnumeration() ; e.hasMoreElements() ;) {
                                                DefaultMutableTreeNode currNode = (DefaultMutableTreeNode)e.nextElement();
                                                AstNodeData dand = (AstNodeData)currNode.getUserObject();
                                                dand.showInstead = -2; // tag for hidden without replacement
                                        }
                                }

                        }
                        
                        //if we are at a coerce above the selected Instance node,
                        //we want to mark that, so that the d command can be modified
                        if ((and.node != null)
                                        && (and.node.getFun().endsWith("coerce"))
                                        && (and.showInstead > -1) //only hidden coerce
                                        && (((AstNodeData)((DefaultMutableTreeNode)nodeToCheck.getChildAt(3)).getUserObject()).selected)
                                        ) {
                                tar.deleteAlsoAbove = true;
                        }
                }
        }
        /**
         * Removes nodes from the tree that has topNode as its root.
         * Affected are nodes in which the field showInstead in their
         * AstNodeData is greater than -1
         * @param topNode The root of the tree from which nodes should
         * be removed.
         * @return The root of the transformed tree. 
         * This might not be topNode, since that node might as well be 
         * removed. 
         */
        protected static DefaultMutableTreeNode transformTree(DefaultMutableTreeNode topNode) {
                DefaultMutableTreeNode nextNode = topNode;
                while (nextNode != null) {
                        AstNodeData and = (AstNodeData)nextNode.getUserObject();
                        if (and.showInstead > -1) {
                               DefaultMutableTreeNode parent = (DefaultMutableTreeNode)nextNode.getParent();
                               if (parent == null) {
                                       topNode = (DefaultMutableTreeNode)nextNode.getChildAt(and.showInstead);
                                       if (treeLogger.isLoggable(Level.FINE)) {
                                               //yeah, I know, variable naming is messed up here because of the assignment above
                                               treeLogger.fine("hiding topNode ###" + nextNode + "###, showing instead ###" + topNode + "###");
                                       }
                                       nextNode = topNode;
                               } else {
                                       final int index = parent.getIndex(nextNode);
                                       parent.remove(index);
                                       DefaultMutableTreeNode instead = (DefaultMutableTreeNode)nextNode.getChildAt(and.showInstead);
                                       parent.insert(instead, index);
                                       if (treeLogger.isLoggable(Level.FINE)) {
                                               treeLogger.fine("hiding node ###" + nextNode + "###, showing instead ###" + instead + "###");
                                       }
                                       nextNode = instead;
                               }
                        } else {
                                nextNode = nextNode.getNextNode();
                        }
                }
                return topNode;
        }

}
