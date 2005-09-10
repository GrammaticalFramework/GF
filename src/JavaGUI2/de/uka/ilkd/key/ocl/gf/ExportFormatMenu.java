// This file is part of KeY - Integrated Deductive Software Design
// Copyright (C) 2001-2005 Universitaet Karlsruhe, Germany
//                         Universitaet Koblenz-Landau, Germany
//                         Chalmers University of Technology, Sweden
//
// The KeY system is protected by the GNU General Public License. 
// See LICENSE.TXT for details.
//

package de.uka.ilkd.key.ocl.gf;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

/** Provide a choice of output formats: OCL or Natural Language. NL can be
  * formatted using either HTML or LaTeX.
  */
public class ExportFormatMenu extends JPanel
{
    public static int OCL = 0, HTML=1, LATEX=2;

    private static String[] menuStrings = { "OCL",
        "Natural Language/HTML (requires GF)",
        "Natural Language/LaTeX (requires GF)"
    };
    
    private JComboBox formatMenu;
    private int selection;
    
    private ActionListener al = new ActionListener() {
        public void actionPerformed(ActionEvent e) {
            JComboBox cb = (JComboBox) e.getSource();
            String s = (String) cb.getSelectedItem();
            if (s.equals("OCL")) {
                selection = OCL;
            } else if (s.equals("Natural Language/HTML (requires GF)")) {
                selection = HTML;
            } else if (s.equals("Natural Language/LaTeX (requires GF)")) {
                selection = LATEX;
            } else { // should never occur
                selection = OCL;
            };
        }
    };
    
    public ExportFormatMenu() 
    {
        super();
        this.setLayout(new BoxLayout(this,BoxLayout.Y_AXIS));
        formatMenu = new JComboBox(menuStrings);
        formatMenu.setSelectedIndex(0);
        formatMenu.addActionListener(al);
        this.add(Box.createVerticalGlue());
        JLabel text = new JLabel("Choose output format:");
        this.add(text);
        text.setAlignmentX(Component.CENTER_ALIGNMENT);
        this.add(formatMenu);
    }
    

    public int getSelection()
    {
        return selection;
    }
}

