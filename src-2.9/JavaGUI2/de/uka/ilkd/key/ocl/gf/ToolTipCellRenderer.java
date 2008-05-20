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

import java.awt.Component;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.ListCellRenderer;

/**
 * A cell renderer, that returns JLables, that put everything after the first
 * '$' character into their tooltip
 * @author daniels
 */
public class ToolTipCellRenderer extends JLabel implements ListCellRenderer {
        
        /**
         * Returns a JLabel with a tooltip, which is given by the GFCommand
         * @param list Well, the list this cell belongs to
         * @param value value to display
         * @param index cell index
         * @param isSelected is the cell selected
         * @param cellHasFocus the list and the cell have the focus
         * @return a suiting JLabel
         */
        public Component getListCellRendererComponent(JList list, Object value, int index, boolean isSelected, boolean cellHasFocus) {
                if (isSelected) {
                        setBackground(list.getSelectionBackground());
                        setForeground(list.getSelectionForeground());
                }
                else {
                        setBackground(list.getBackground());
                        setForeground(list.getForeground());
                }
                setEnabled(list.isEnabled());
                setFont(list.getFont());
                setOpaque(true);

                
                if (value == null) {
                        setText("Null-Value!!! Something went terribly wrong here!");
                } else if (value instanceof GFCommand){
                        GFCommand gfc = (GFCommand)value;
                        String disText = gfc.getDisplayText();
                        if (gfc instanceof LinkCommand) {
                                //italic font could be an alternative
                                disText = "-> " + disText;
                        }
                        setText(disText);
                        setToolTipText(gfc.getTooltipText());
                } else {
                        setText(value.toString());
                        setToolTipText("Strange thing of class '" + value.getClass() + "'");
                }
                return this;
        }
        
}
