package de.uka.ilkd.key.ocl.gf;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;

import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTextField;

import java.util.logging.*;

/**
 * Takes care of reading in Strings that are to be parsed and terms.
 * @author daniels
 *
 */
class ReadDialog implements ActionListener{
        /** XML parsing debug messages  */
        protected static Logger xmlLogger = Logger.getLogger(GFEditor2.class.getName() + "_XML");
        /** The window to which this class belongs */
        protected final GFEditor2 owner;
        /** is the main thing of this class */
        protected final JDialog readDialog;
        /** main area of the Read dialog (content pane)*/
        private final JPanel inputPanel = new JPanel();
        /** OK, Cancel, Browse in the Read dialog */
        private final JPanel inputPanel2 = new JPanel();
        /** in the Read dialog the OK button */
        private final JButton ok = new JButton("OK");
        /** in the Read dialog the Cancel button */
        private final JButton cancel = new JButton("Cancel");
        /** in the Read dialog the Browse button */
        private final JButton browse = new JButton("Browse...");
        /** groups inputField and inputLabel */
        private final JPanel inputPanel3 = new JPanel();   
        /** for 'Read' to get the input */
        private final JTextField inputField = new JTextField();
        /** "Read: " */
        private final JLabel inputLabel = new JLabel("Read: ");
        /** the radio group in the Read dialog to select Term or String */
        private final ButtonGroup readGroup = new ButtonGroup();
        /** to select to input a Term in the Read dialog */
        private final JRadioButton termReadButton = new JRadioButton("Term");
        /** to select to input a String in the Read dialog */
        private final JRadioButton stringReadButton = new JRadioButton("String");
        /** used for new Topic, Import and Browse (readDialog) */
        protected final JFileChooser fc = new  JFileChooser("./");
        /**
         * if a user sends a custom command to GF, he might want to do this 
         * again with the same command.
         * Therefore it is saved.
         */
        private String parseInput = "";
        /**
         * if the user enters a term, he perhaps wants to input the same text again.
         * Therefore it is saved.
         */        
        private String termInput = "";
        
        /**
         * creates a modal dialog
         * @param owner The parent for which this dialog shall be modal.
         */
        protected ReadDialog(GFEditor2 owner) {
                this.owner = owner;
                readDialog= new JDialog(owner, "Input", true);
                readDialog.setLocationRelativeTo(owner);
                readDialog.getContentPane().add(inputPanel);
                readDialog.setSize(480,135);

                termReadButton.setActionCommand("term");
                stringReadButton.setSelected(true);  
                stringReadButton.setActionCommand("lin");
                // Group the radio buttons.
                readGroup.add(stringReadButton);
                readGroup.add(termReadButton);
                JPanel readButtonPanel = new JPanel();
                readButtonPanel.setLayout(new GridLayout(3,1));
                readButtonPanel.setPreferredSize(new Dimension(70, 70));
                readButtonPanel.add(new JLabel("Format:"));
                readButtonPanel.add(stringReadButton);
                readButtonPanel.add(termReadButton);
                inputPanel.setLayout(new BorderLayout(10,10));
                inputPanel3.setLayout(new GridLayout(2,1,5,5));
                inputPanel3.add(inputLabel);
                inputPanel3.add(inputField);
                ok.addActionListener(this);
                browse.addActionListener(this);
                cancel.addActionListener(this);
                inputField.setPreferredSize(new Dimension(300,23));
                inputPanel.add(inputPanel3, BorderLayout.CENTER);
                inputPanel.add(new JLabel(" "), BorderLayout.WEST);
                inputPanel.add(readButtonPanel, BorderLayout.EAST);
                inputPanel.add(inputPanel2, BorderLayout.SOUTH);
                inputPanel2.add(ok);
                inputPanel2.add(cancel);
                inputPanel2.add(browse);
        }
        
        /**
         * Shows this modal dialog.
         * The previous input text will be there again.
         *
         */
        protected void show() {
                if (stringReadButton.isSelected()) {
                        inputField.setText(this.parseInput);
                } else {
                        inputField.setText(this.termInput);        
                }
                this.readDialog.setVisible(true);
        }
        
        /**
         * Sets the font of all GUI elements to font
         * @param font
         */
        protected void setFont(Font font) {
                ok.setFont(font);  
                cancel.setFont(font);  
                inputLabel.setFont(font);  
                browse.setFont(font);  
                termReadButton.setFont(font);  
                stringReadButton.setFont(font);  
        }
        
        /**
         * the ActionListener method that does the user interaction
         */
        public void actionPerformed(ActionEvent ae) {  
                Object obj = ae.getSource();

                if ( obj == cancel ) {
                        readDialog.setVisible(false);
                }
                
                if ( obj == browse ) {
                        if (fc.getChoosableFileFilters().length<2)
                                fc.addChoosableFileFilter(new GrammarFilter()); 
                        int returnVal = fc.showOpenDialog(owner);
                        if (returnVal == JFileChooser.APPROVE_OPTION) {
                                File file = fc.getSelectedFile();
                                inputField.setText(file.getPath().replace('\\','/'));
                        }
                }
                
                if ( obj == ok ) {
                        owner.treeChanged = true; 
                        if (termReadButton.isSelected()) { 
                                termInput = inputField.getText();
                                if (termInput.indexOf(File.separatorChar)==-1){
                                        owner.send("g "+termInput); 
                                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("sending term  string");
                                }
                                else {
                                        owner.send("tfile "+termInput);                           
                                        if (xmlLogger.isLoggable(Level.FINER)) {
                                                xmlLogger.finer("sending file term: "+termInput);
                                        }
                                }
                        } else { //String selected
                                parseInput = inputField.getText();
                                if (parseInput.indexOf(File.separatorChar)==-1){
                                        owner.send("p "+parseInput);        
                                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("sending parse string: "+parseInput);
                                }   
                                else {
                                        owner.send("pfile "+parseInput);           
                                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("sending file parse string: "+parseInput);        
                                }
                        }
                        readDialog.setVisible(false);
                }

        }

}
