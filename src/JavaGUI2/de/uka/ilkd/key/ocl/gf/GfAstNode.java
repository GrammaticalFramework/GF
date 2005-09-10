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

/**
 * @author daniels
 * This Class represents a parsed node in the GF AST.
 * It knows about types, bound variables, funs.
 * But nothing about printnames. That's what AstNodeData is for.
 */
class GfAstNode {
        /**
         * contains the types of the bound variables in the order of their occurence
         */
        protected final String[] boundTypes;
        /**
         * contains the names of the bound variables in the order of their occurence
         */
        protected final String[] boundNames;
        /** 
         * The type of this AST node 
         */
        private final String type;
        /**
         * @return The type of this AST node
         */
        protected String getType() {
                return type;
        }
        /** 
         * the fun represented in this AST node 
         */
        private final String fun;

        /**
         * @return the fun represented in this AST node.
         * Can be a metavariable like "?1"
         */
        protected String getFun() {
                return fun;
        }
        
        /**
         * @return true iff the node is a metavariable, i.e. open and not
         * yet refined.
         */
        protected boolean isMeta() {
                return fun.startsWith("?");
        }
        /** 
         * the line that was used to build this node 
         */
        private final String line;
        /**
         * @return the line that was used to build this node
         */
        protected String getLine() {
                return line;
        }
        
        /**
         * The constraint attached to this node
         */
        public final String constraint;

        /**
         * feed this constructor the line that appears in the GF AST and
         * it will get chopped at the right points.
         * @param line The line from GF without the * in the beginning.
         */
        protected GfAstNode(final String line) {
                this.line = line.trim();
                final int index = this.line.lastIndexOf(" : ");
                String typeString = this.line.substring(index + 3);
                final int constraintIndex = typeString.indexOf(" {");
                if (constraintIndex > -1) {
                        this.constraint = typeString.substring(constraintIndex + 1).trim();
                        this.type = typeString.substring(0, constraintIndex).trim();
                } else {
                        this.constraint = "";
                        this.type = typeString;
                }
                String myFun = this.line.substring(0, index);
                if (myFun.startsWith("\\(")) {
                        final int end = myFun.lastIndexOf(") -> ");
                        String boundPart = myFun.substring(2, end);
                        String[] bounds = boundPart.split("\\)\\s*\\,\\s*\\(");
                        this.boundNames = new String[bounds.length];
                        this.boundTypes = new String[bounds.length];
                        for (int i = 0; i < bounds.length;i++) {
                                //System.out.print("+" + bounds[i] + "-");
                                int colon = bounds[i].indexOf(" : ");
                                this.boundNames[i] = bounds[i].substring(0, colon);
                                this.boundTypes[i] = bounds[i].substring(colon + 3);
                                //System.out.println(boundNames[i] + " ;; " + boundTypes[i]);
                        }
                        myFun = myFun.substring(end + 5);
                } else {
                        this.boundNames = new String[0];
                        this.boundTypes = new String[0];
                }
                this.fun = myFun;
        }
        
        public String toString() {
                return this.line;
        }
}
