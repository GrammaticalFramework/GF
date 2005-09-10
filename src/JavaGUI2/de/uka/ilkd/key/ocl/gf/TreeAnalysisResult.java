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

import javax.swing.tree.DefaultMutableTreeNode;

/**
 * A class to store the result of the tree analysis done in formTree
 * @author daniels
 */
class TreeAnalysisResult {
        /**
         * The command, that is to be executed next automatically
         */
        String command;
        /**
         * the number of undo steps needed to undo command
         */
        int undoSteps;
        /**
         * reduceCoerce Whether the mechanism to produce a reduced
         * refinement menu for coerce's 4th argument should kick in or not.
         */
        boolean reduceCoerce;
        /**
         * If the editor should ask GF if self an result are applicable here or not
         */
        boolean probeSelfResult;
        /**
         * If we at the the Instance Argument of a hidden
         * coerce, we mark that (to change the d command)
         */
        boolean deleteAlsoAbove;
        /**
         * if the attributes of self should be added to the refinement menu.
         */
        boolean easyAttributes;
        DefaultMutableTreeNode selectedNode = null;
        /**
         * The currently selected node
         */
        GfAstNode currentNode;
        /**
         * Where the cursor in GF is. 
         * Correct is not yet known and thus always true.
         */
        LinPosition focusPosition;
        
        /**
         * Just sets both values. 
         * @param command The command, that is to be executed next automatically
         * @param undoSteps the number of undo steps needed to undo command 
         * @param reduceCoerce Whether the mechanism to produce a reduced
         * refinement menu for coerce's 4th argument should kick in or not.
         * @param probeSelfResult If the editor should ask GF if self an result
         * are applicable here or not
         * @param deleteAlsoAbove If we at the the Instance Argument of a hidden
         * coerce, we mark that (to change the d command)
         * @param easyAttributes if the attributes of self should be added to the
         * refinement menu.
         * @param currentNode The currently selected node
         * @param focusPosition Where the cursor in GF is. 
         * Correct is not yet known and thus always true.
         */
        public TreeAnalysisResult(String command, int undoSteps, boolean reduceCoerce, boolean probeSelfResult, boolean deleteAlsoAbove, boolean easyAttributes, GfAstNode currentNode, LinPosition focusPosition) {
                this.command = command;
                this.undoSteps = undoSteps;
                this.reduceCoerce = reduceCoerce;
                this.probeSelfResult = probeSelfResult;
                this.deleteAlsoAbove = deleteAlsoAbove;
                this.currentNode = currentNode;
                this.easyAttributes = easyAttributes;
                this.focusPosition = focusPosition;
        }
        
        public String toString() {
                return this.command + "|" + this.reduceCoerce + "|" + this.undoSteps + "|" + this.probeSelfResult;
        }
}
