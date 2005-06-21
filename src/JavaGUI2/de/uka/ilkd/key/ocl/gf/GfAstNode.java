/*
 * Created on 06.05.2005
 *
 */
package de.uka.ilkd.key.ocl.gf;

/**
 * @author daniels
 * This Class represents a parsed node in the GF AST.
 */
class GfAstNode {
        protected final String[] boundTypes;
        protected final String[] boundNames;
        /** The type of this AST node */
        private final String type;
        /**
         * @return The type of this AST node
         */
        protected String getType() {
                return type;
        }
        /** the fun represented in this AST node */
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
        /** the line that was used to build this node */
        private final String line;
        /**
         * @return the line that was used to build this node
         */
        protected String getLine() {
                return line;
        }

        /**
         * feed this constructor the line that appears in the GF AST and
         * it will get chopped at the right points.
         * @param line The line from GF without the * in the beginning.
         */
        protected GfAstNode(final String line) {
                this.line = line.trim();
                final int index = this.line.lastIndexOf(" : ");
                this.type = this.line.substring(index + 3);
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
        
        public static void main(String[] args) {
               String[] lines = {"?1 : Sent",
                               "Two : Instance Integer",
                               "?3 : Instance (Collection (?{this:=this{-0-}}))",
                               "NOPACKAGEP_StartC_Constr : Constraint {Constraint<>NOPACKAGEP_StartC_Constr (\\this -> invCt ?)}",
                               "\\(this : VarSelf NOPACKAGEP_StartC) -> invCt : ClassConstraintBody",
                               "\\(x_0 : Instance Integer) -> ?6 : Sent",
                               "\\(selfGF : VarSelf NOPACKAGEP_PayCardC),(amount : Instance Integer) -> preC : OperConstraintBody",
               				   "\\(selfGF : VarSelf NOPACKAGEP_PayCardC),(amount : Instance Integer) -> ?0 : OperConstraintBody"
                               };
               String[] funs = {"?1",
                               	"Two",
                               	"?3",
                               	"NOPACKAGEP_StartC_Constr",
                               	"invCt",
                               	"?6",
                               	"preC",
                               	"?0" 
                               	};
               String[] types = {"Sent",
                               "Instance Integer",
                               "Instance (Collection (?{this:=this{-0-}}))",
                               "Constraint {Constraint<>NOPACKAGEP_StartC_Constr (\\this -> invCt ?)}",
                               "ClassConstraintBody",
                               "Sent",
                               "OperConstraintBody",
                               "OperConstraintBody" 
                               };
               
               for (int i = 0; i < lines.length; i++) {
                       System.out.println("* " + lines[i]);
                       GfAstNode gfa = new GfAstNode(lines[i]);
                       if (!gfa.getFun().equals(funs[i])) {
                               System.out.println("  fun mismatch: expected '" + funs[i] + "', got '" + gfa.getFun() + "'");
                       }
                       if (!gfa.getType().equals(types[i])) {
                               System.out.println("  type mismatch: expected '" + types[i] + "', got '" + gfa.getType() + "'");
                       }

               }
        }
}
