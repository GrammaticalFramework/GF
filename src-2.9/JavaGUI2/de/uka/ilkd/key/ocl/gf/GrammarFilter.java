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

import java.io.File;
import javax.swing.filechooser.*;

public class GrammarFilter extends FileFilter {
        
        // Accept all directories and all gf, gfcm files.
        public boolean accept(File f) {
                if (f.isDirectory()) {
                        return true;
                }
                
                String extension = Utils.getExtension(f);
                if (extension != null) {
                        if (extension.equals(Utils.gf) ||
                                        extension.equals(Utils.gfcm)) {
                                return true;
                        } else {
                                return false;
                        }
                }
                
                return false;
        }
        
        // The description of this filter
        public String getDescription() {
                return "Just Grammars (*.gf, *.gfcm)";
        }
}
