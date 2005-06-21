// This file is part of KeY - Integrated Deductive Software Design
// Copyright (C) 2001-2005 Universitaet Karlsruhe, Germany
//                         Universitaet Koblenz-Landau, Germany
//                         Chalmers University of Technology, Sweden
//
// The KeY system is protected by the GNU General Public License. 
// See LICENSE.TXT for details.
//
//
package de.uka.ilkd.key.ocl.gf;

import java.io.File;
import javax.swing.filechooser.*;

public class GrammarFilter extends FileFilter {
        
        // Accept all directories and all gf, gfm files.
        public boolean accept(File f) {
                if (f.isDirectory()) {
                        return true;
                }
                
                String extension = Utils.getExtension(f);
                if (extension != null) {
                        if (extension.equals(Utils.gf) ||
                                        extension.equals(Utils.gfm)) {
                                return true;
                        } else {
                                return false;
                        }
                }
                
                return false;
        }
        
        // The description of this filter
        public String getDescription() {
                return "Just Grammars (*.gf, *.gfm)";
        }
}
