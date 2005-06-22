package de.uka.ilkd.key.ocl.gf;                       

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.text.*;
import javax.swing.event.*;
import javax.swing.tree.*;
import java.io.*;
import java.util.*;
import java.net.URL;
import javax.swing.text.html.HTMLDocument;
import java.net.MalformedURLException;
import java.util.logging.*;
import jargs.gnu.CmdLineParser;

public class GFEditor2 extends JFrame implements ActionListener, CaretListener,
KeyListener, FocusListener {
        
        /** the main logger for this class */
        protected static Logger logger = Logger.getLogger(GFEditor2.class.getName());
        /** 
         * logs the time at several stages when starting the editor. 
         * For calibrating the ProgressMonitor
         */
        protected static Logger timeLogger = Logger.getLogger("de.uka.ilkd.key.ocl.gf.Timer");
        /** print MarkedAreas */
        protected static Logger markedAreaLogger = Logger.getLogger(GFEditor2.class.getName() + "_MarkedArea");
        /** print MarkedAreas */
        protected static Logger htmlLogger = Logger.getLogger(GFEditor2.class.getName() + "_HTML");
        /** debug stuff for the tree */
        public static Logger treeLogger = Logger.getLogger(GFEditor2.class.getName() + "_Tree");
        /** red mark-up && html debug messages */
        protected static Logger redLogger = Logger.getLogger(GFEditor2.class.getName() + "_Red");
        /** pop-up/mouse handling debug messages */
        protected static Logger popUpLogger = Logger.getLogger(GFEditor2.class.getName() + "_PopUp");
        /** linearization marking debug messages */
        protected static Logger linMarkingLogger = Logger.getLogger(GFEditor2.class.getName() + "_LinMarking");
        /** XML parsing debug messages  */
        protected static Logger xmlLogger = Logger.getLogger(GFEditor2.class.getName() + "_XML");
        /** keyPressedEvents & Co. */
        protected static Logger keyLogger = Logger.getLogger(GFEditor2.class.getName() + "_key");
        /** keyPressedEvents & Co. */
        protected static Logger sendLogger = Logger.getLogger(GFEditor2.class.getName() + ".send");

        public final static String modelModulName = "FromUMLTypes";
        /** 
         * Does the saving of constraints in Together.
         * Or to be more precise, itself knows nothing about Together.
         * Only its subclasses. That way it can be compiled without KeY. 
         */
        final private ConstraintCallback callback;
        
        /** to collect the linearization strings */
        private HashMap linearizations = new HashMap();
        /** current Font */
        private Font font;
        /** contains the offered fonts by name */
        private JMenu fontMenu;
        /** offers a list of font sizes */
        private JMenu sizeMenu;
        
        public JPopupMenu popup2 = new JPopupMenu();
        /**
         * what is written here is parsed and the result inserted instead of tbe selection.
         * No idea how this element is displayed
         */
        public JTextField parseField = new JTextField("textField!"); 

        /**
         * to save the old selection before editing i field
         * or the new selection?
         */
        public String selectedText="";
        
        /**
         * The position of the focus, that is, the currently selected node in the AST
         */
        public LinPosition focusPosition ;
        /** 
         * stack for storing the current position:
         * When displaying, we start with the root of the AST.
         * Whenever we start to display a node, it is pushed, and when it is completely displayed, we pop it.
         * Only LinPositions are stored in here
         * local in formLin?
         * */
        public Vector currentPosition = new Vector();
 
        /**
         * When a new category is chosen, it is set to true. 
         * In the reset or a completely new state it is falsed.
         * The structure of the GF output is different then and this must be taken
         * care of.
         */
        public boolean newObject = false;
        /**
         * the opposite of newObject
         * is only true, when we don't have a chosen category.
         * false: reading lins and tree
         * true: reading categories from GF
         */
        public boolean finished = false;
        /**
         * if the user enters text for the alpha conversion, he perhaps wants to input the same text again.
         * Therefore it is saved.
         */
        private String alphaInput = "";
        /**
         * if a user sends a custom command to GF, he might want to do this 
         * again with the same command.
         * Therefore it is saved.
         */
        private String commandInput = "";
        
        /**
         * default status text, just status
         */
        private final static String status = "status";
        /**
         * the language the possible actions are displayed 
         */
        protected String selectedMenuLanguage = "Abstract";
        /**
         * the GF-output between <linearization> </linearization>  tags is stored here.
         * must be saved in case the displayed languages are changed.
         * Only written in readLin
         */
        private String linearization = "";
        /**
         * write-only variable, stores the current import paths
         * reset after each reset.
         */
        private String fileString = "";
        /**
         * In GF the nodes in the AST are numbered in a linear fashion.
         * When reading a from GF, we assign each tree node in the Java AST
         * the position in the 'flattened' GF tree.
         * The mapping between Java tree pathes and GF node numbering is stored 
         * here.
         */
        public Hashtable nodeTable = new Hashtable();
        /**this FileChooser gets enriched with the Term/Text option */
        JFileChooser saveFc = new  JFileChooser("./");
        /** used for new Topic, Import and Browse (readDialog) */
        JFileChooser fc = new  JFileChooser("./");
        private final static String [] modifyMenu = {"Modify", "identity","transfer", 
                        "compute", "paraphrase", "generate","typecheck", "solve", "context" };
        private static final String [] newMenu = {"New"};
        
        /**
         * if treeChanged is false, we don't have to rebuild it.
         * Avoids a time-consuming reconstruction and flickering.
         */
        public boolean treeChanged = true;
        /** the most common use is to store here what is read from GF */
        private String result;
        /** The output from GF is in here */
        private BufferedReader fromProc;
        /** leave messages for GF here. */
        private BufferedWriter toProc;
        /** used to print error messages */
        private final String commandPath;
        /** Linearizations' display area */
        private JTextArea linearizationArea = new JTextArea();
        /** the content of the refinementMenu */
        public DefaultListModel listModel= new DefaultListModel();
        /** The list of current refinement options */       
        private JList refinementList = new JList(this.listModel);
        /**
         * The abstract syntax tree representation of the current editing object
         */
        private DynamicTree2 tree = new DynamicTree2(this);
        
        /** Current Topic */
        private JLabel grammar = new JLabel("No topic          ");
        /**
         * Writing the current editing object to file in the term or text 
         * format
         */
        private JButton save = new JButton("Save");
        /**
         * Reading both a new environment and an editing object from file.
         * Current editing will be discarded
         */
        private JButton open = new JButton("Open");
        /**
         * Reading a new environment from file. Current editing will be 
         * discarded.
         */
        private JButton newTopic;
        /** Sending a command to GF */
        private JButton gfCommand;   
        
        /** Moving the focus to the previous metavariable */
        private JButton leftMeta = new JButton("?<");
        /** Moving the focus to the previous term */
        private JButton left = new JButton("<");
        /** Moving the focus to the top term */
        private JButton top = new JButton("Top");
        /** Moving the focus to the next term */
        private JButton right = new JButton(">");
        /** Moving the focus to the next metavariable */
        private JButton rightMeta = new JButton(">?");
        private JLabel actionOnSubterm = new JLabel("Select Action on Subterm");
        /** Refining with term or linearization from typed string or file */
        private JButton read = new JButton("Read");   
        //  private JButton parse = new JButton("Parse");   
        //  private JButton term = new JButton("Term");
        /** Performing alpha-conversion of bound variables */
        private JButton alpha;
        /** Generating random refinement */
        private JButton random;
        /** Going back to the previous state */
        private JButton undo;
        /** The main panel on which the others are put */
        private JPanel coverPanel = new JPanel();
        /** the dialog to read in Strings or Terms */
        private ReadDialog readDialog;

        /** The list of available categories to start editing */
        private JComboBox newCategoryMenu = new JComboBox(newMenu);
        /** Choosing a linearization method */
        private JComboBox modify = new JComboBox(modifyMenu);   
        //  private JComboBox mode = new JComboBox(modeMenu);   
        /** the panel with the more general command buttons */
        private JPanel downPanel = new JPanel();
        /** the splitpane containing tree on the left and linearization area on the right*/
        private JSplitPane treePanel;
        /** the upper button bar for New, Save */
        private JPanel upPanel = new JPanel();
        /** the panel that contains the navigation buttons and some explanatory text */
        private JPanel middlePanel = new JPanel();
        /** the panel that contains only the navigation buttons */
        private JPanel middlePanelUp = new JPanel();
        /** the panel that vontains the the explanatory text for the refinement menu */
        private JPanel middlePanelDown = new JPanel();
        /** splits between tree and lin above and nav buttons and refinements below */
        private JSplitPane centerPanel;
        /** the window that contains the refinements when in split mode */
        private JFrame gui2 = new JFrame();
        /** the main window with tree, lin and buttons when in split mode */
        private JPanel centerPanel2= new JPanel();
        /** contains refinment list and navigation buttons */
        private JPanel centerPanelDown = new JPanel();
        /** the scrollpane containing the refinements */
        private JScrollPane refinementPanel = new JScrollPane(this.refinementList);
        /** only contains the linearization area */
        private JScrollPane outputPanelText = new JScrollPane(this.linearizationArea);
        /** HTML Linearizations' display area */
        private JTextPane htmlLinPane = new JTextPane();
        /** only contains the HTML linearization area */
        private JScrollPane outputPanelHtml = new JScrollPane(this.htmlLinPane);
        /** contains both pure text and HTML areas */
        private JSplitPane linSplitPane;
        /** contains the linSplitPane and the status field below it */
        private JPanel outputPanelUp = new JPanel(new BorderLayout());
        /** contains statusLabel */
        private JPanel statusPanel = new JPanel();
        /** The type the currently focused term has */
        private JLabel statusLabel = new JLabel(status);
        /** the main menu in the top */
        private JMenuBar menuBar= new JMenuBar();
        //private ButtonGroup menuGroup = new ButtonGroup();
        /** View settings */
        private JMenu viewMenu= new JMenu("View");
        /**
         * stores a list of all languages + abstract to select the language, 
         * in which the selectMenu will be filled.
         */
        private JMenu mlMenu= new JMenu("language");
        /** Choosing the refinement options' representation */
        private JMenu modeMenu= new JMenu("Menus");
        /** Language settings */
        private JMenu langMenu= new JMenu("Languages");
        /** Main operations */
        private JMenu fileMenu= new JMenu("File");
        /** stores whether the refinement list should be in 'long' format */
        private JRadioButtonMenuItem rbMenuItemLong;
        /** stores whether the refinement list should be in 'short' format */
        private JRadioButtonMenuItem rbMenuItemShort;
        // private JRadioButtonMenuItem rbMenuItemAbs;
        /** stores whether the refinement list should be in 'untyped' format */
        private JRadioButtonMenuItem rbMenuItemUnTyped;
        /** 
         * linked to rbMenuItemUnTyped. 
         * Is true if type information should be appended in the refinement menu
         */
        private boolean typedMenuItems = false;
        /** stores whether the AST is visible or not */
        private JCheckBoxMenuItem treeCbMenuItem;
        /** in the save dialog whether to save as a Term or as linearized Text */
        private ButtonGroup saveTypeGroup = new ButtonGroup();
        /** the entries of the filter menu */
        private final static String [] filterMenuContents = {"identity", 
                        "erase", "take100", "text", "code", "latexfile", 
                        "structured", "unstructured" };
        /** Choosing the linearization representation format */
        private JMenu filterMenu = new JMenu("Filter");
        /** for managing the filter menu entries*/
        private ButtonGroup filterButtonGroup = new ButtonGroup();
        //now for stuff that is more or less OCL specific
        
        /** Some usability things can be switched off here for testing */
        private JMenu usabilityMenu= new JMenu("Usability");
        /** 
         * stores whether self and result should only be made visible 
         * if applicable 
         */
        private JCheckBoxMenuItem selfresultCbMenuItem;
        /** to switch grouping of entries in the refinement menu on and off */
        private JCheckBoxMenuItem subcatCbMenuItem;
        /** to switch sorting of entries in the refinement menu on and off */
        private JCheckBoxMenuItem sortCbMenuItem;
        
        /** 
         * if true, self and result are only shown if applicable, 
         * tied to @see selfresultCbMenuItem
         */  
        private boolean showSelfResult = true;
        /** 
         * if true, refinements are grouped by subcat 
         * tied to @see subcatCbMenuItem
         */  
        private boolean groupSubcat = true;
        /** 
         * if true, refinements are grouped by subcat 
         * tied to @see subcatCbMenuItem
         */  
        private boolean sortRefinements = true;
        /**
         * to store the Vectors which contain the display names for the
         * ListModel for refinementSubcatList for the different 
         * subcategory menus.
         * The key is the shortname String, the value the Vector with the
         * display Strings
         */
        private Hashtable subcatListModelHashtable = new Hashtable(); 
        /** 
         * this ListModel gets refilled every time a %WHATEVER command, 
         * which stands for a shortname for a subcategory of commands
         * in the ListModel of refinementList, is selected there
         */
        private DefaultListModel refinementSubcatListModel = new DefaultListModel();
        /** The list of current refinement options in the subcategory menu*/       
        private JList refinementSubcatList = new JList(this.refinementSubcatListModel);
        /** the scrollpane containing the refinement subcategory*/
        private JScrollPane refinementSubcatPanel = new JScrollPane(this.refinementSubcatList);
        /** store what the shorthand name for the current subcat is */
        private String whichSubcat;
        /** stores the two refinement JLists */
        private JSplitPane refinementListsContainer;
        
        /** here the GFCommand objects are stored*/
        private Vector gfcommands = new Vector();
        
        /** handles all the Printname naming a.s.o */
        private PrintnameManager printnameManager;
        
        /** 
         * stores the current type. Since the parsing often fails, this is
         * most often null, except for Int and String, which can be parsed.
         */
        private GfAstNode currentNode = null;
        /**
         * Here the node is stored that introduces the bound variables
         * self and possibly result.
         * This knowledge is read in formTree and used in probeProbability,
         * which is called by readAndDisplay which again is called by a 
         * number of functions. Thus a 'global' variable.
         */
        private GfAstNode constraintNode = null;
        /** stores the displayed parts of the linearization */
        private Display display = new Display(3);

        /**
         * contains all the linearization pieces as HtmlMarkedArea
         * Needed to know to which node in the AST a word in the linHtmlPane 
         * area belongs.
         */
        public Vector htmlOutputVector = new Vector();
        /**
         * contains all the linearization pieces as MarkedArea
         * Needed to know to which node in the AST a word in the linearization 
         * area belongs.
         * At the moment, this is double effort, but the old way of generating
         * MarkedAreas should go away.
         */
        public Vector textOutputVector = new Vector();

        /** takes care of the menus that display the available languages */
        private LangMenuModel langMenuModel = new LangMenuModel();
        
        //Now the stuff for choosing the wanted output type (pure text or HTML)
        /**
         * 1 for text, 2 for HTML, 3 for both 
         */
        private int displayType = 1;
        private ButtonGroup bgDisplayType = new ButtonGroup();
        private JRadioButtonMenuItem rbText = new JRadioButtonMenuItem(new AbstractAction("pure text") {
                public void actionPerformed(ActionEvent ae) {
                        int oldDisplayType = displayType;
                        displayType = 1;
                        outputPanelUp.removeAll();
                        outputPanelUp.add(outputPanelText, BorderLayout.CENTER);
                        outputPanelUp.add(statusPanel, BorderLayout.SOUTH);
                        if (ae != null && oldDisplayType == 2) { //not manually called in the beginning and only HTML
                                formLin();
                        }
                        outputPanelUp.validate();
                }
        });
        private JRadioButtonMenuItem rbHtml = new JRadioButtonMenuItem(new AbstractAction("HTML") {
                public void actionPerformed(ActionEvent ae) {
                        int oldDisplayType = displayType;
                        displayType = 2;
                        outputPanelUp.removeAll();
                        outputPanelUp.add(outputPanelHtml, BorderLayout.CENTER);
                        outputPanelUp.add(statusPanel, BorderLayout.SOUTH);
                        if (ae != null && oldDisplayType == 1) { //not manually called in the beginning and only text
                                formLin();
                        }
                        outputPanelUp.validate();
                }
        });
        private JRadioButtonMenuItem rbTextHtml = new JRadioButtonMenuItem(new AbstractAction("text and HTML") {
                public void actionPerformed(ActionEvent ae) {
                        int oldDisplayType = displayType;
                        displayType = 3;
                        linSplitPane.setLeftComponent(outputPanelText);
                        linSplitPane.setRightComponent(outputPanelHtml);
                        outputPanelUp.removeAll();
                        outputPanelUp.add(linSplitPane, BorderLayout.CENTER);
                        outputPanelUp.add(statusPanel, BorderLayout.SOUTH);
                        if (ae != null && oldDisplayType != 3) { //not manually called in the beginning and not both (the latter should always be true)
                                formLin();
                        }
                        outputPanelUp.validate();
                }
        });
        
        
        /**
         * Initializes GF with the given command, sets up the GUI
         * and reads the first GF output
         * @param gfcmd The command with all parameters, including -java
         * that is to be executed. Will set up the GF side of this session.
         * @param isHtml true iff the editor should start in HTML mode.
         * @param baseURL the URL that is the base for all relative links in HTML
         */
        public GFEditor2(String gfcmd, boolean isHtml, URL baseURL) {
                this.callback = null;
                this.commandPath = gfcmd;
                initializeGUI(baseURL, isHtml);
                initializeGF(gfcmd, null);                
                //readAndDisplay();
        }
        
        /**
         * a specialized constructor for OCL comstraints
         * Starts with a new Constraint and an initial syntax tree
         * @param gfcmd The command with all parameters, including -java
         * that is to be executed. Will set up the GF side of this session.
         * @param callback The class responsible for saving the OCL constraint
         * as a JavaDoc comment 
         * @param initAbs the initial abstract syntax tree
         * @param pm to monitor the loading progress. May be null
         */
        public GFEditor2(String gfcmd, ConstraintCallback callback, String initAbs, ProgressMonitor pm) {
                this.callback = callback;
                this.commandPath = gfcmd;
                
                Utils.tickProgress(pm, 5220, "Loading grammars");
                initializeGF(gfcmd, pm);
                Utils.tickProgress(pm, 9350, "Initializing GUI");
                initializeGUI(null, true);
                
                // send correct term (syntax tree)
                //The initial GF constraint has until now always been 
                //automatically solvable. So don't startle the user
                //with painting everything red.
                send(initAbs + " ;; c solve ", false);
                readAndDisplay();
                Utils.tickProgress(pm, 9700, "Loading finished");
                pm.close();
                logger.finer("GFEditor2 constructor finished");
        }

        /**
         * Starts GF and sets up the reading facilities.
         * Shouldn't be called twice.
         * @param gfcmd The command for GF to be executed.
         * expects the -java parameters and all grammar modules
         * to be specified. Simply executes this command without any
         * modifications.
         * @param pm to monitor the loading progress. May be null
         */
        private void initializeGF(String gfcmd, ProgressMonitor pm){
                try {
                        Utils.tickProgress(pm, 5250, "Starting GF");
                        logger.fine("Trying: "+gfcmd);
                        Process extProc = Runtime.getRuntime().exec(gfcmd); 
                        InputStreamReader isr = new InputStreamReader(
                                        extProc.getInputStream(),"UTF8");
                        this.fromProc = new BufferedReader (isr);
                        String defaultEncoding = isr.getEncoding();
                        if (logger.isLoggable(Level.FINER)) {
                                logger.finer("encoding "+defaultEncoding);
                        }
                        this.toProc = new BufferedWriter(new OutputStreamWriter(extProc.getOutputStream(),"UTF8"));
                        
                        readInit(pm, true);
                        resetPrintnames(false);
                } catch (IOException e) {
                        JOptionPane.showMessageDialog(new JFrame(), "Could not start " + gfcmd+
                                        "\nCheck your $PATH", "Error", 
                                        JOptionPane.ERROR_MESSAGE);
                        throw new RuntimeException("Could not start " + gfcmd+
                        "\nCheck your $PATH");
                }

        }
        
        /**
         * (re-)initializes this.printnameManager and loads the printnames from
         * GF.
         * @param replayState If GF should be called to give the same state as before,
         * but without the message. Is needed, when this function is started by the user.
         * If sth. else is sent to GF automatically, this is not needed.
         *
         */
        private void resetPrintnames(boolean replayState) {
                this.printnameManager = new PrintnameManager();
                PrintnameLoader pl = new PrintnameLoader(this.fromProc, this.toProc, this.printnameManager, this.typedMenuItems);
                if (!selectedMenuLanguage.equals("Abstract")) {
                        String sendString = selectedMenuLanguage;
                        pl.readPrintnames(sendString);
                        //empty GF command, clears the message, so that the printnames
                        //are not printed again when for example a 'ml' command comes
                        //next
                        if (replayState) {
                                send("gf ");
                        }
                }
        }
        /**
         * reliefs the constructor from setting up the GUI stuff
         * @param baseURL the base URL for relative links in the HTML view
         * @param showHtml TODO
         */
        private void initializeGUI(URL baseURL, boolean showHtml) {
                this.setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
                this.addWindowListener(new WindowAdapter() {
                        public void windowClosing(WindowEvent e) {
                                endProgram();
                        }
                });
                
                this.readDialog = new ReadDialog(this);
                
                //Add listener to components that can bring up popup menus.
                MouseListener popupListener2 = new PopupListener();
                linearizationArea.addMouseListener(popupListener2);
                
                //now for the menus
                
                setJMenuBar(menuBar);
                setTitle("GF Syntax Editor");
                viewMenu.setToolTipText("View settings");        
                fileMenu.setToolTipText("Main operations");
                langMenu.setToolTipText("Language settings");
                usabilityMenu.setToolTipText("Usability settings");
                menuBar.add(fileMenu);
                menuBar.add(langMenu);                        
                menuBar.add(viewMenu);
                menuBar.add(modeMenu);
                menuBar.add(usabilityMenu);
                modeMenu.setToolTipText("Choosing the refinement options' representation");
                
                /**
                 * listens to the showTree JCheckBoxMenuItem and
                 * switches displaying the AST on or off
                 */
                final ActionListener showTreeListener = new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                if (!((JCheckBoxMenuItem)e.getSource()).isSelected()){
                                        if (logger.isLoggable(Level.FINER)) logger.finer("showTree was selected");
                                        treeCbMenuItem.setSelected(false);
                                        if (((JRadioButtonMenuItem)viewMenu.getItem(2)).isSelected()) {      
                                                centerPanel.remove(treePanel);
                                                centerPanel.setLeftComponent(outputPanelUp); 
                                        }
                                        else {
                                                centerPanel2.remove(treePanel);
                                                centerPanel2.add(outputPanelUp, BorderLayout.CENTER); 
                                        }
                                }
                                else { 
                                        if (logger.isLoggable(Level.FINER)) logger.finer("showTree was not selected");
                                        treeCbMenuItem.setSelected(true);
                                        if (((JRadioButtonMenuItem)viewMenu.getItem(2)).isSelected()) {      
                                                centerPanel.remove(outputPanelUp);
                                                treePanel.setRightComponent(outputPanelUp);
                                                centerPanel.setLeftComponent(treePanel);
                                        }
                                        else {
                                                centerPanel2.remove(outputPanelUp);
                                                treePanel.setRightComponent(outputPanelUp);
                                                centerPanel2.add(treePanel, BorderLayout.CENTER);
                                        }                    
                                }
                                pack();
                                repaint();
                        }
                        
                };
                
                treeCbMenuItem = new JCheckBoxMenuItem("Tree");
                treeCbMenuItem.setActionCommand("showTree");
                treeCbMenuItem.addActionListener(showTreeListener);
                treeCbMenuItem.setSelected(true);
                
                viewMenu.add(treeCbMenuItem);
                viewMenu.addSeparator();

                final Action saveAction = new SaveAction();
                final Action openAction = new OpenAction();
                final Action newTopicAction = new NewTopicAction();
                final Action resetAction = new ResetAction();
                final Action quitAction = new QuitAction();
                final Action undoAction = new UndoAction();
                final Action randomAction = new RandomAction();
                final Action alphaAction = new AlphaAction();
                final Action gfCommandAction = new GfCommandAction();
                final Action readAction = new ReadAction();
                final Action splitAction = new SplitAction();
                final Action combineAction = new CombineAction();
                                
                JMenuItem fileMenuItem = new JMenuItem(openAction);
                fileMenu.add(fileMenuItem);
                fileMenuItem = new JMenuItem(newTopicAction);
                fileMenu.add(fileMenuItem);
                fileMenuItem = new JMenuItem(resetAction);
                fileMenu.add(fileMenuItem);
                fileMenuItem = new JMenuItem(saveAction);
                fileMenu.add(fileMenuItem);
                fileMenu.addSeparator();
                fileMenuItem = new JMenuItem(quitAction);
                fileMenu.add(fileMenuItem);
                
                JRadioButtonMenuItem rbMenuItem = new JRadioButtonMenuItem(combineAction);
                rbMenuItem.setSelected(true);
                /*        rbMenuItem.setMnemonic(KeyEvent.VK_R);
                 rbMenuItem.setAccelerator(KeyStroke.getKeyStroke(
                 KeyEvent.VK_1, ActionEvent.ALT_MASK));
                 rbMenuItem.getAccessibleContext().setAccessibleDescription(
                 "This doesn't really do anything");
                 */
                ButtonGroup menuGroup = new ButtonGroup();
                menuGroup.add(rbMenuItem);
                viewMenu.add(rbMenuItem);
                
                rbMenuItem = new JRadioButtonMenuItem(splitAction);
                menuGroup.add(rbMenuItem);
                viewMenu.add(rbMenuItem);
                
                //Font stuff
                final int DEFAULT_FONT_SIZE = 14;
                GraphicsEnvironment gEnv = GraphicsEnvironment.getLocalGraphicsEnvironment();
                /** The list of font names our environment offers us */
                String[] envfonts = gEnv.getAvailableFontFamilyNames();
 
                /** the list of fonts the environment offers us */
                Font[] fontObjs = new Font[envfonts.length];
                for (int fi = 0; fi < envfonts.length; fi++) {
                        fontObjs[fi] = new Font(envfonts[fi], Font.PLAIN,
                                        DEFAULT_FONT_SIZE);
                }
                font = new Font(null, Font.PLAIN, DEFAULT_FONT_SIZE);
                //font menus
                viewMenu.addSeparator();
                fontMenu = new JMenu("Font");
                fontMenu.setToolTipText("Change font");
                sizeMenu = new JMenu("Font Size");
                sizeMenu.setToolTipText("Change font size");
                viewMenu.add(sizeMenu);
                viewMenu.add(fontMenu);

               {
                        JMenuItem fontItem;
                        ActionListener fontListener = new ActionListener(){
                                public void actionPerformed(ActionEvent ae) {
                                        try {
                                                JMenuItem source = (JMenuItem)ae.getSource();
                                                font = new Font(source.getText(), Font.PLAIN, font.getSize());
                                                fontEveryWhere(font);
                                        } catch (ClassCastException e) {
                                                logger.warning("Font change started on strange object\n" + e.getLocalizedMessage());
                                        }
                                }
                        };                        
                        for (int i = 0; i < envfonts.length; i++) {
                                fontItem = new JMenuItem(envfonts[i]);
                                fontItem.addActionListener(fontListener);
                                fontItem.setFont(new Font(envfonts[i], Font.PLAIN, font.getSize()));
                                fontMenu.add(fontItem);
                        }
                }
                {
                        JMenuItem sizeItem;
                        ActionListener sizeListener = new ActionListener(){
                                public void actionPerformed(ActionEvent ae) {
                                        try {
                                                JMenuItem source = (JMenuItem)ae.getSource();
                                                font = new Font(font.getFontName(), Font.PLAIN, Integer.parseInt(source.getText()));
                                                fontEveryWhere(font);
                                        } catch (ClassCastException e) {
                                                logger.warning("Font change started on strange object\n" + e.getLocalizedMessage());
                                        } catch (NumberFormatException e) {
                                                logger.warning("strange size entry\n" + e.getLocalizedMessage());
                                        }
                                }
                        };
                        /** The list of offered font sizes */
                        int[] sizes = {14,18,22,26,30};
                        for (int i = 0; i < sizes.length; i++) {
                                sizeItem = new JMenuItem("" + sizes[i]);
                                sizeItem.addActionListener(sizeListener);
                                sizeMenu.add(sizeItem);
                        }
                }
                //font stuff over

                filterMenu.setToolTipText("Choosing the linearization representation format");
                {
		                ActionListener filterActionListener = new ActionListener() {
		                        public void actionPerformed(ActionEvent ae) {
		                                JMenuItem jmi = (JMenuItem)ae.getSource();
		                                final String sendString = "f " + jmi.getActionCommand(); 
		                                send(sendString);
		                        }
		                };
		                JRadioButtonMenuItem jrbmi;
		                for (int i = 0; i < filterMenuContents.length; i++) {
		                        jrbmi = new JRadioButtonMenuItem(filterMenuContents[i]);
		                        jrbmi.setActionCommand(filterMenuContents[i]);
		                        jrbmi.addActionListener(filterActionListener);
		                        filterButtonGroup.add(jrbmi);
		                        filterMenu.add(jrbmi);
		                }
                }
                viewMenu.addSeparator();
                viewMenu.add(filterMenu);
                
                modeMenu.add(mlMenu);
                /**
                 * switches GF to either display the refinement menu commands
                 * either in long or short format
                 */
                final ActionListener longShortListener = new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                String action = e.getActionCommand();
                                if ((action.equals("long")) || (action.equals("short"))) {
                                        send("ms " + action);
                                        return;
                                } else {
                                        logger.warning("RadioListener on wrong object: " + action + "should either be 'typed' or 'untyped'");
                                }
                        }
                };

                modeMenu.addSeparator();              
                menuGroup = new ButtonGroup();
                rbMenuItemLong = new JRadioButtonMenuItem("long");
                rbMenuItemLong.setActionCommand("long");
                rbMenuItemLong.addActionListener(longShortListener);
                menuGroup.add(rbMenuItemLong);
                modeMenu.add(rbMenuItemLong);
                rbMenuItemShort = new JRadioButtonMenuItem("short");
                rbMenuItemShort.setActionCommand("short");
                rbMenuItemShort.setSelected(true);
                rbMenuItemShort.addActionListener(longShortListener);
                menuGroup.add(rbMenuItemShort);
                modeMenu.add(rbMenuItemShort);
                modeMenu.addSeparator();
                
                /**
                 * switches GF to either display the refinement menu with or 
                 * without type annotation ala " : Type"
                 */
                final ActionListener unTypedListener = new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                String action = e.getActionCommand();
                                if ((action.equals("typed")) || (action.equals("untyped"))) {
                                        send("mt " + action);
                                        if ((action.equals("typed"))) {
                                                typedMenuItems = true;
                                        } else {
                                                typedMenuItems = false;
                                        }
                                        resetPrintnames(true);
                                        return;
                                } else {
                                        logger.warning("RadioListener on wrong object: " + action + "should either be 'typed' or 'untyped'");
                                }
                        }
                };
                menuGroup = new ButtonGroup();
                rbMenuItem = new JRadioButtonMenuItem("typed");
                rbMenuItem.setActionCommand("typed");
                rbMenuItem.addActionListener(unTypedListener);
                rbMenuItem.setSelected(false);
                menuGroup.add(rbMenuItem);
                modeMenu.add(rbMenuItem);
                rbMenuItemUnTyped = new JRadioButtonMenuItem("untyped");
                rbMenuItemUnTyped.setSelected(true);
                rbMenuItemUnTyped.setActionCommand("untyped");
                rbMenuItemUnTyped.addActionListener(unTypedListener);
                menuGroup.add(rbMenuItemUnTyped);
                modeMenu.add(rbMenuItemUnTyped);
                
                //OCL specific stuff
                selfresultCbMenuItem = new JCheckBoxMenuItem("skip self&result if possible");
                selfresultCbMenuItem.setActionCommand("selfresult");
                selfresultCbMenuItem.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                showSelfResult = selfresultCbMenuItem.isSelected();
                                send("gf");
                        }
                });
                selfresultCbMenuItem.setSelected(showSelfResult);
                if (this.callback != null || this.linearizations.containsKey("FromUMLTypesOCL")) {
                        // only visible, if we really do OCL constraints
                        usabilityMenu.add(selfresultCbMenuItem);
                }
                
                subcatCbMenuItem = new JCheckBoxMenuItem("group possible refinements");
                subcatCbMenuItem.setActionCommand("subcat");
                subcatCbMenuItem.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                groupSubcat = subcatCbMenuItem.isSelected();
                                send("gf");
                        }
                });
                subcatCbMenuItem.setSelected(groupSubcat);
                usabilityMenu.add(subcatCbMenuItem);                
                
                sortCbMenuItem = new JCheckBoxMenuItem("sort refinements");
                sortCbMenuItem.setActionCommand("sortRefinements");
                sortCbMenuItem.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                sortRefinements = sortCbMenuItem.isSelected();
                                send("gf");
                        }
                });
                sortCbMenuItem.setSelected(sortRefinements);
                usabilityMenu.add(sortCbMenuItem);

                
                //now for the other elements
                
                //HTML components

                
                this.htmlLinPane.setContentType("text/html");
                this.htmlLinPane.setEditable(false);
                if (this.htmlLinPane.getStyledDocument() instanceof HTMLDocument) {
                        try {
                                URL base;
                                if (baseURL == null) {
                                        base = (new File("./")).toURL();
                                } else {
                                        base = baseURL;
                                }
                                if (logger.isLoggable(Level.FINER)) {
                                        logger.finer("base for HTML: " + base);
                                }
                                ((HTMLDocument)this.htmlLinPane.getDocument()).setBase(base);
                        } catch (MalformedURLException me) {
                                logger.severe(me.getLocalizedMessage());
                        }
	            } else {
	                    logger.warning("No HTMLDocument: " + this.htmlLinPane.getDocument().getClass().getName());
	            }
                this.htmlLinPane.addCaretListener(new CaretListener() {
                        /**
                         * One can either click on a leaf in the lin area, or select a larger subtree.
                         * The corresponding tree node is selected.
                         */
                        public void caretUpdate(CaretEvent e) {
                                String jPosition ="", iPosition="", position="";
                                HtmlMarkedArea jElement = null;
                                HtmlMarkedArea iElement = null;
                                int j = 0;
                                int i = htmlOutputVector.size()-1;
                                int start = htmlLinPane.getSelectionStart(); 
                                int end   = htmlLinPane.getSelectionEnd();
                                if (popUpLogger.isLoggable(Level.FINER)) {
                                        popUpLogger.finer("CARET POSITION: " + htmlLinPane.getCaretPosition()
                                                        + "\n-> SELECTION START POSITION: "+start
                                                        + "\n-> SELECTION END POSITION: "+end);
                                }
                                if (linMarkingLogger.isLoggable(Level.FINER)) {
                                        if (end > 0 && (end < htmlLinPane.getDocument().getLength())) {
                                                try {
                                                        linMarkingLogger.finer("CHAR: " + htmlLinPane.getDocument().getText(end, 1));
                                                } catch (BadLocationException ble) {
                                                        linMarkingLogger.warning(ble.getLocalizedMessage());
                                                }
                                        }
                                }
                                // not null selection:
                                if ((i > -1) && (start < htmlLinPane.getDocument().getLength())) {
                                        if (linMarkingLogger.isLoggable(Level.FINER))
                                                for (int k=0; k < htmlOutputVector.size(); k++) { 
                                                        linMarkingLogger.finer("element: "+k+" begin "+((HtmlMarkedArea)htmlOutputVector.elementAt(k)).htmlBegin+" "
                                                                        + "\n-> end: "+((HtmlMarkedArea)htmlOutputVector.elementAt(k)).htmlEnd+" "       
                                                                        + "\n-> position: "+(((HtmlMarkedArea)htmlOutputVector.elementAt(k)).position).position+" "   
                                                                        + "\n-> words: "+((HtmlMarkedArea)htmlOutputVector.elementAt(k)).words);   
                                                }
                                        // localizing end:
                                        while ((j < htmlOutputVector.size()) && (((HtmlMarkedArea)htmlOutputVector.elementAt(j)).htmlEnd < end)) {
                                                j++;
                                        }
                                        // localising start:
                                        while ((i >= 0) && (((HtmlMarkedArea)htmlOutputVector.elementAt(i)).htmlBegin > start)) {
                                                i--;
                                        }
                                        if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                linMarkingLogger.finer("i: "+i+" j: "+j);
                                        }
                                        if ((j < htmlOutputVector.size())) {
                                                jElement = (HtmlMarkedArea)htmlOutputVector.elementAt(j);
                                                jPosition = jElement.position.position;
                                                // less & before:
                                                if (i == -1) { // less:
                                                        if (end>=jElement.htmlBegin) {
                                                                iElement = (HtmlMarkedArea)htmlOutputVector.elementAt(0);
                                                                iPosition = iElement.position.position;
                                                                if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                                        linMarkingLogger.finer("Less: "+jPosition+" and "+iPosition);
                                                                }
                                                                position = findMaxHtml(0,j);
                                                                if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                                        linMarkingLogger.finer("SELECTEDTEXT: "+position+"\n");
                                                                }
                                                                treeChanged = true; 
                                                                send("mp "+position);
                                                        } else { // before: 
                                                                if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                                        linMarkingLogger.finer("BEFORE vector of size: "+htmlOutputVector.size());
                                                                }
                                                        }
                                                } else { // just: 
                                                        iElement = (HtmlMarkedArea)htmlOutputVector.elementAt(i);
                                                        iPosition = iElement.position.position;
                                                        if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                                linMarkingLogger.finer("SELECTED TEXT Just: "+iPosition +" and "+jPosition+"\n");
                                                        }
                                                        position = findMax(i,j);
                                                        if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                                linMarkingLogger.finer("SELECTEDTEXT: "+position+"\n");
                                                        }
                                                        treeChanged = true; 
                                                        send("mp "+position);
                                                }
                                        }  else if (i>=0) { // more && after:
                                                iElement = (HtmlMarkedArea)htmlOutputVector.elementAt(i);
                                                iPosition = iElement.position.position;
                                                // more
                                                if (start<=iElement.htmlEnd) { 
                                                        jElement = (HtmlMarkedArea)htmlOutputVector.elementAt(htmlOutputVector.size()-1);
                                                        jPosition = jElement.position.position;
                                                        if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                                linMarkingLogger.finer("MORE: "+iPosition+ " and "+jPosition);
                                                        }
                                                        position = findMax(i,htmlOutputVector.size()-1);
                                                        if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                                linMarkingLogger.finer("SELECTEDTEXT: "+position+"\n");
                                                        }
                                                        treeChanged = true; 
                                                        send("mp "+position);
                                                        // after:
                                                } else if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                        linMarkingLogger.finer("AFTER vector of size: "+htmlOutputVector.size());
                                                }
                                        } else { // bigger:
                                                iElement = (HtmlMarkedArea)htmlOutputVector.elementAt(0);
                                                iPosition = iElement.position.position;
                                                jElement = (HtmlMarkedArea)htmlOutputVector.elementAt(htmlOutputVector.size()-1);
                                                jPosition = jElement.position.position;
                                                if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                        linMarkingLogger.finer("BIGGER: "+iPosition +" and "+jPosition+"\n"         
                                                                        + "\n-> SELECTEDTEXT: []\n");
                                                }
                                                treeChanged = true; 
                                                send("mp []");
                                        }
                                }//not null selection
                        }
                });
                this.linSplitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT,
                                this.outputPanelText, outputPanelHtml);
                
                //cp = getContentPane();
                JScrollPane cpPanelScroll = new JScrollPane(coverPanel); 
                this.getContentPane().add(cpPanelScroll);
                coverPanel.setLayout(new BorderLayout());
                linearizationArea.setToolTipText("Linearizations' display area");   
                linearizationArea.addCaretListener(this);
                linearizationArea.setEditable(false);
                linearizationArea.setLineWrap(true);
                linearizationArea.setWrapStyleWord(true);
                //linearizationArea.setSelectionColor(Color.green);

                parseField.setFocusable(true);
                parseField.addKeyListener(this);
                parseField.addFocusListener(this);
                //                System.out.println(output.getFont().getFontName());
                
                //Now for the command buttons in the lower part
                gfCommand = new JButton(gfCommandAction);
                read = new JButton(readAction);
                modify.setToolTipText("Choosing a linearization method");
                alpha = new JButton(alphaAction);
                random = new JButton(randomAction);
                undo = new JButton(undoAction);
                downPanel.add(gfCommand);
                downPanel.add(read);  
                downPanel.add(modify);   
                downPanel.add(alpha);     
                downPanel.add(random);
                downPanel.add(undo);
                //downPanel.add(parse);
                //downPanel.add(term);
                
                //now for the navigation buttons
                leftMeta.setToolTipText("Moving the focus to the previous metavariable");
                rightMeta.setToolTipText("Moving the focus to the next metavariable");
                left.setToolTipText("Moving the focus to the previous term");
                right.setToolTipText("Moving the focus to the next term");
                top.setToolTipText("Moving the focus to the top term");       
                middlePanelUp.add(leftMeta);
                middlePanelUp.add(left);
                middlePanelUp.add(top);
                middlePanelUp.add(right);
                middlePanelUp.add(rightMeta);
                middlePanelDown.add(actionOnSubterm);
                middlePanel.setLayout(new BorderLayout());
                middlePanel.add(middlePanelUp, BorderLayout.NORTH);
                middlePanel.add(middlePanelDown, BorderLayout.CENTER);
                
                //now for the upper button bar
                newTopic = new JButton(newTopicAction);
                newCategoryMenu.setToolTipText("The list of available categories to start editing");
                open.setToolTipText("Reading both a new environment and an editing object from file. Current editing will be discarded");
                save.setToolTipText("Writing the current editing object to file in the term or text format");
                grammar.setToolTipText("Current Topic");
                newTopic.setToolTipText("Reading a new environment from file. Current editing will be discarded.");
                upPanel.add(grammar);
                upPanel.add(newCategoryMenu);
                upPanel.add(open);
                upPanel.add(save);
                upPanel.add(newTopic);
                
                statusLabel.setToolTipText("The current focus type");
                refinementList.setToolTipText("The list of current refinement options");
                refinementList.setCellRenderer(new ToolTipCellRenderer());
                refinementSubcatList.setToolTipText("The list of current refinement options");
                refinementSubcatList.setCellRenderer(new ToolTipCellRenderer());
                
                tree.setToolTipText("The abstract syntax tree representation of the current editing object");
                resetTree(tree); 

                bgDisplayType.add(rbText);
                bgDisplayType.add(rbHtml);
                bgDisplayType.add(rbTextHtml);
                if (showHtml) {
                        rbHtml.setSelected(true);
                        rbHtml.getAction().actionPerformed(null);
                } else {
                        rbText.setSelected(true);
                        rbText.getAction().actionPerformed(null);
                }
                
                viewMenu.addSeparator();
                viewMenu.add(rbText);
                viewMenu.add(rbHtml);
                viewMenu.add(rbTextHtml);
                display = new Display(displayType);
                
                statusPanel.setLayout(new GridLayout(1,1));
                statusPanel.add(statusLabel);
                treePanel = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT,
                                tree, outputPanelUp);
                treePanel.setDividerSize(5);
                treePanel.setDividerLocation(100);
                centerPanel2.setLayout(new BorderLayout());
                gui2.setSize(350,100);
                gui2.setTitle("Select Action on Subterm");
                gui2.setLocationRelativeTo(treePanel);
                centerPanelDown.setLayout(new BorderLayout());
                centerPanel = new JSplitPane(JSplitPane.VERTICAL_SPLIT,
                                treePanel, centerPanelDown);
                centerPanel.setDividerSize(5);
                centerPanel.setDividerLocation(250);
                centerPanel.addKeyListener(tree);      
                centerPanel.setOneTouchExpandable(true);
                
                refinementListsContainer = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT,refinementPanel, refinementSubcatPanel);
                
                centerPanelDown.add(middlePanel, BorderLayout.NORTH);
                centerPanelDown.add(refinementListsContainer, BorderLayout.CENTER);
                //centerPanelDown.add(refinementSubcatPanel, BorderLayout.EAST);
                coverPanel.add(centerPanel, BorderLayout.CENTER);
                coverPanel.add(upPanel, BorderLayout.NORTH);
                coverPanel.add(downPanel, BorderLayout.SOUTH);
                
                refinementList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
                
                final MouseListener mlRefinementList = new MouseAdapter() {
                        public void mouseClicked(MouseEvent e) {
                                refinementList.setSelectionBackground(refinementSubcatList.getSelectionBackground());
                                boolean doubleClick = (e.getClickCount() == 2); 
                                listAction(refinementList, refinementList.locationToIndex(e.getPoint()), doubleClick);
                        }
                };
                refinementList.addMouseListener(mlRefinementList);
                refinementList.addKeyListener(this);

                refinementSubcatList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
                
                final MouseListener mlRefinementSubcatList = new MouseAdapter() {
                        public void mouseClicked(MouseEvent e) {
                                boolean doubleClick = (e.getClickCount() == 2);
                                listAction(refinementSubcatList, refinementSubcatList.locationToIndex(e.getPoint()), doubleClick);
                                refinementList.setSelectionBackground(Color.GRAY);
                        }
                };
                refinementSubcatList.addMouseListener(mlRefinementSubcatList);
                refinementSubcatList.addKeyListener(this);
                
                
                newCategoryMenu.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent ae) {
                                if (!newCategoryMenu.getSelectedItem().equals("New")) { 
                                        treeChanged = true;
                                        newObject = true;
                                        send("n " + newCategoryMenu.getSelectedItem());
                                        newCategoryMenu.setSelectedIndex(0);
                                }
                        }
                        
                });
                save.setAction(saveAction);
                open.setAction(openAction);     
                gfCommand.addActionListener(this);     
                
                newCategoryMenu.setFocusable(false);
                save.setFocusable(false); 
                open.setFocusable(false); 
                newTopic.setFocusable(false);
                gfCommand.setFocusable(false);
                
                leftMeta.setFocusable(false);
                left.setFocusable(false);  
                
                /** handles the clicking of the navigation buttons */
                ActionListener naviActionListener = new ActionListener() {
                        /**
                         * convenience method instead of 5 single ones
                         */
                        public void actionPerformed(ActionEvent ae) {  
                                Object obj = ae.getSource();
                                if ( obj == leftMeta ) {
                                        treeChanged = true; 
                                        send("<<");
                                }
                                if ( obj == left ) {
                                        treeChanged = true; 
                                        send("<");
                                }
                                if ( obj == top ) {
                                        treeChanged = true; 
                                        send("'");
                                }
                                if ( obj == right ) {
                                        treeChanged = true; 
                                        send(">");
                                }
                                if ( obj == rightMeta ) {
                                        treeChanged = true; 
                                        send(">>");
                                }
                        }
                };
                
                top.addActionListener(naviActionListener);
                right.addActionListener(naviActionListener);
                rightMeta.addActionListener(naviActionListener);     
                leftMeta.addActionListener(naviActionListener);     
                left.addActionListener(naviActionListener);
                read.addActionListener(this);     
                modify.addActionListener(new ActionListener() {
                        public void actionPerformed(ActionEvent ae) {
                        if (!modify.getSelectedItem().equals("Modify")) { 
                                treeChanged = true; 
                                send("c " + modify.getSelectedItem());
                                modify.setSelectedIndex(0);
                        }
                }

                }); 
                //mode.addActionListener(this);     
                alpha.addActionListener(this);     
                random.addActionListener(this);     
                
                top.setFocusable(false);  
                right.setFocusable(false);  
                rightMeta.setFocusable(false);  
                //parse.setFocusable(false);  
                //term.setFocusable(false);  
                read.setFocusable(false);  
                modify.setFocusable(false);  
                //mode.setFocusable(false);  
                alpha.setFocusable(false);  
                random.setFocusable(false);  
                undo.setFocusable(false);  
                
                linearizationArea.addKeyListener(tree);            
                this.setSize(800,600);
                outputPanelUp.setPreferredSize(new Dimension(400,230));
                treePanel.setDividerLocation(0.3);
                nodeTable.put(new TreePath(tree.rootNode.getPath()), new Integer(0));
                
                JRadioButton termButton = new JRadioButton("Term");
                termButton.setActionCommand("term");
                termButton.setSelected(true);  
                JRadioButton linButton = new JRadioButton("Text");
                linButton.setActionCommand("lin");
                // Group the radio buttons.
                saveTypeGroup.add(linButton);
                saveTypeGroup.add(termButton);
                JPanel buttonPanel = new JPanel();
                buttonPanel.setPreferredSize(new Dimension(70, 70));
                buttonPanel.add(new JLabel("Format:"));
                buttonPanel.add(linButton);
                buttonPanel.add(termButton);
                saveFc.setAccessory(buttonPanel);

                fontEveryWhere(font);
                this.setVisible(true);
                
        }
        
        /**
         * send a command to GF and reads the returned XML
         * @param text the command, exacltly the string that is going to be sent
         */
        protected void send(String text){
                send(text, true);
        }
        
        /**
         * send a command to GF.
         * @param text the command, exacltly the string that is going to be sent
         * @param andRead if true, the returned XML will be read an displayed accordingly
         */
        protected void send(String text, boolean andRead) {
                if (sendLogger.isLoggable(Level.FINER)) {
                        sendLogger.finer("## send: '" + text + "'");
                }
                try {
                        this.display = new Display(displayType);
                        display(true, false);
                        if (xmlLogger.isLoggable(Level.FINER)) {
                                xmlLogger.finer("output cleared\n\n\n");
                        }
                        this.htmlOutputVector = new Vector();
                        this.textOutputVector = new Vector();
                        toProc.write(text, 0, text.length());
                        toProc.newLine();
                        toProc.flush();
                        //run();
                        if (andRead) {
                                readAndDisplay();
                        }
                } catch (IOException e) {
                        System.err.println("Could not write to external process " + e);
                }  
        }
        
        /**
         * a simple wrapper around readGfedit that also probes
         * for unneccessary commands
         */
        protected void readAndDisplay() {
                readGfedit();
                probeCompletability();
                refinementList.requestFocusInWindow();
        }

        /**
         * reads the front matter that GF returns when freshly started and loading a grammar.
         * When &lt;gfinit&gt; is read, the function returns.  
         * @param pm to monitor the loading progress. May be null
         * @param greetingsToo if the greeting text from GF is expected
         */
        protected void readInit(ProgressMonitor pm, boolean greetingsToo) {
                String next = "";
                if (greetingsToo) {
                        next = readGfGreetings();
                } else {
                        try {
	                        next = fromProc.readLine();
	                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("1 " + next);
                        } catch (IOException e) {
                                System.err.println("Could not read from external process:\n" + e);
                        }
                }
                Utils.tickProgress(pm, 5300, null);
                next = readGfLoading(next, pm);
                if (next.equals("<gfinit>")) {
                        readGfinit();
                }
        }
        
        
        /**
         * reads the greeting text from GF
         * @return the last read GF line, which should be the first loading line
         */
        protected String readGfGreetings() {
                try {
                        String readresult = "";
                        StringBuffer outputStringBuffer = new StringBuffer();
                        readresult = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("1 "+readresult);
                        while ((readresult.indexOf("gf")==-1) && (readresult.trim().indexOf("<") < 0)){                          
                                outputStringBuffer.append(readresult).append("\n");
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("1 "+readresult);
                        }
                        this.display.addToStages(outputStringBuffer.toString(), outputStringBuffer.toString().replaceAll("\\n", "<br>"));
                        display(true, false);
                        return readresult;
                } catch (IOException e) {
                        System.err.println("Could not read from external process:\n" + e);
                        return "";
                }
                
        }

        /**
         * reads the loading and compiling messages from GF
         * @param readresult the first loading line
         * @param pm to monitor the loading progress. May be null
         * @return the first line from &gt;gfinit&lt; or &gt;gfedit&lt;
         */
        protected String readGfLoading(String readresult, ProgressMonitor pm) {
                try {
                        StringBuffer textPure = new StringBuffer();
                        StringBuffer textHtml = new StringBuffer();
                        int progress = 5300;
                        while (!(readresult.indexOf("<gfinit>") > -1 || (readresult.indexOf("<gfmenu>") > -1))){
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("1 "+readresult);
                                textPure.append(readresult).append("\n");
                                textHtml.append(readresult).append("<br>\n");
                                progress += 12;
                                Utils.tickProgress(pm, progress, null);
                        }
                        //when old grammars are loaded, the first line looks like
                        //"reading grammar of old format letter.Abs.gfreading old file letter.Abs.gf<gfinit>"
                        //without newlines
                        final int beginInit = readresult.indexOf("<gfinit>"); 
                        if (beginInit > 0) {
                                textPure.append(readresult.substring(0, beginInit)).append("\n");
                                textPure.append(readresult.substring(0, beginInit)).append("<br>\n");
                                //that is the expected result
                                readresult = "<gfinit>";
                        }
                        this.display.addToStages(textPure.toString(), textHtml.toString());
                        display(true, false);
                        return readresult;
                } catch (IOException e) {
                        System.err.println("Could not read from external process:\n" + e);
                        return "";
                }

        }

        /**
         * reads the part between &gt;gfinit&lt; and &gt;/gfinit&lt; 
         * and feeds the editor with what was read
         */
        protected void readGfinit() {
                try {
                        //read <hmsg> or <newcat> or <topic> (in case of no grammar loaded)
                        String readresult = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("12 "+readresult);
                        //when old grammars are loaded, the first line looks like
                        //"reading grammar of old format letter.Abs.gfreading old file letter.Abs.gf<gfinit>"
                        if (readresult.indexOf("<gfinit>") > -1) {
                                readresult = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("12 "+readresult);
                        }
                        String next = readHmsg(readresult);

                        if ((next!=null) && ((next.indexOf("newcat") > -1) || (next.indexOf("topic") > -1))) {
                                formNewMenu();
                        }
                        
                } catch (IOException e) {
                        System.err.println("Could not read from external process:\n" + e);
                }
                
        }

        /**
         * reads the output from GF starting with &gt;gfedit&lt; and last reads &gt;/gfedit&lt;. 
         * Feeds the editor with what was read.
         * @return the last read line, should be ""
         */
        protected String readGfedit() {
                try {
                        String next = "";
                        //read <gfedit>
                        String readresult = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("11 "+readresult);
                        //read either <hsmg> or <lineatization>
                        readresult = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("11 "+readresult);
                        
                        //hmsg stuff
                        next = readHmsg(readresult);
                        
                        //reading <linearizations>
                        //seems to be the only line read here
                        while ((next!=null)&&((next.length()==0)||(next.indexOf("<lin ")==-1))) {
                                next = fromProc.readLine();
                                if (next!=null){
                                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("10 "+next);
                                } else {
                                        System.exit(0);
                                }
                        }
                        result = next;
                        readLin();
                        readTree();
                        readMessage();
                        //read the menu stuff
                        if (newObject) {
                                readRefinementMenu();
                        } else {
                                while(result.indexOf("</menu")==-1) {
                                        result = fromProc.readLine();
                                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("12 "+result);                    
                                }
                        }
                        for (int i=0; i<3 && !result.equals(""); i++){ 
                                result = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("11 "+result);                    
                        }
                        return result;
                        
                } catch (IOException e) {
                        System.err.println("Could not read from external process:\n" + e);
                        return result;
                }
                
        }        
        
        /**
         * checks if result and self make sense in the current context.
         * if not, they are removed from the list
         *
         */
        protected void probeCompletability() {
                if (!showSelfResult) {
                        return;
                }
                final String varself = "VarSelf";
                final String varresult = "VarResult";
                for (int i = 0; i < listModel.size(); i++) {
                        String cmd = ((GFCommand)listModel.elementAt(i)).getCommand();
                        //can we check the types at all?
                        if ((cmd != null) && (this.currentNode != null) && (this.constraintNode != null)) {
                                if ((cmd.indexOf("r core.self") > -1)) {
                                        if (checkTypeSelfResult(i, varself) ){
                                                i -=1;
                                        }
                                }
                                if ((cmd.indexOf("r core.result") > -1)) {
                                        if (checkTypeSelfResult(i, varresult)) {
                                                i -= 1;
                                        }
                                }
                        }

                        //(cmd.indexOf("r core.result") > -1)
                }
                
        }
        
        /**
         * Compares the type of the currently offered self or result and 
         * removes this command from the list, if it doesn't match
         * the type of the on the top level introduced bound variable
         * for self resp. result
         * @param i The number of the current cmd in this.listModel
         * @param boundVar indicates whether self or result is to be
         * checked. 
         * if boundVar is "VarResult", result is checked, if boundVar is
         * "VarSelf", self.
         * Use nothing else!
         * @return true iff a command was removed from listModel  
         */
        private boolean checkTypeSelfResult(int i, String boundVar) {
                //assert "VarSelf".equals(boundVar) || "VarResult".equals(boundVar);
                final String instance = "Instance";
                
                String selfType = null;
                //find the bound VarSelf variable
                for (int j = 0; j < this.constraintNode.boundNames.length; j++) {
                        if (this.constraintNode.boundTypes[j].startsWith(boundVar)) {
                                selfType = this.constraintNode.boundTypes[j].substring(boundVar.length()).trim();
                        }
                }
                // check if the current node can be refined with sth
                // of type Instance WhatEverClassSelfHas
                if ((selfType == null) || (!(instance + " " + selfType).equals(this.currentNode.getType()))) {
                        //remove it from the list of offered commands
                        listModel.remove(i);
                        return true;
                } else {
                        return false;
                }
        }
        
        /**
         * prints the available command line options
         */
        private static void printUsage() {                                          
                System.err.println("Usage: java -jar [-h/--html] [-b/--base baseURL] [grammarfile(s)]");
                System.err.println("where -h activates the HTML mode");
                System.err.println("and -b sets the base location to which links in HTML are relative to. "
                                + "Default is the current directory.");
        }
        
        /**
         * starts the editor
         * @param args only the first parameter is used, it has to be a complete GF command,
         * which is executed and thus should load the needed grammars
         */
        public static void main(String args[]) {
                Utils.configureLogger();
                //command line parsing
                CmdLineParser parser = new CmdLineParser();                             
                CmdLineParser.Option optHtml = parser.addBooleanOption('h', "html");
                CmdLineParser.Option optBase = parser.addStringOption('b', "base");
                CmdLineParser.Option gfBin = parser.addStringOption('g', "gfbin");
                // Parse the command line options.                                      
                
                try {                                                                   
                        parser.parse(args);                                                 
                }                                                                       
                catch (CmdLineParser.OptionException e) {                               
                        System.err.println(e.getMessage());                                 
                        printUsage();                                                       
                        System.exit(2);                                                     
                }
                Boolean isHtml = (Boolean)parser.getOptionValue(optHtml, Boolean.FALSE);
                String baseString = (String)parser.getOptionValue(optBase, null);
                String gfBinString = (String)parser.getOptionValue(gfBin, null);
                String[] otherArgs = parser.getRemainingArgs();
                
                URL myBaseURL;
                if (baseString != null) {
		                try {
		                        myBaseURL = new URL(baseString);
		                } catch (MalformedURLException me) {
		                        logger.warning(me.getLocalizedMessage());
		                        me.printStackTrace();
		                        myBaseURL = null;
		                }
                } else {
                        myBaseURL = null;
                }
                
//                if (logger.isLoggable(Level.FINER)) {
//                        logger.finer(isHtml + " : " + baseString + " : " + otherArgs);
//                }
                //construct the call to GF
                String gfCall = ((gfBinString != null && !gfBinString.equals(""))? gfBinString : "gf");
                gfCall += " -java";
                for (int i = 0; i < otherArgs.length; i++) {
                        gfCall = gfCall + " " + otherArgs[i];
                }
                Locale.setDefault(Locale.US);
                logger.info("call to GF: " + gfCall);
                GFEditor2 gui = new GFEditor2(gfCall, isHtml.booleanValue(), myBaseURL);
                if (logger.isLoggable(Level.FINER)) {
                        logger.finer("main finished");
                }
        }

        /**
         * Calls the Java GF GUI to edit an OCL constraint. To be called by GFinterface
         * @param gfCmd the command to start the GF, must include the -java and all modules
         * @param callback the callback class that knows how to store the constraints
         * @param initAbs the initial abstract syntax tree (not OCL)
         * @param initDefault if initAbs is empty, then initDefault is used
         * @param pm to monitor the loading progress. May be null
         */
        static void mainConstraint(String gfCmd, ConstraintCallback callback, String initAbs, String initDefault, ProgressMonitor pm) {
                Locale.setDefault(Locale.US);
                GFEditor2 gui;
                if (initAbs.equals("")) {
                        gui = new GFEditor2(gfCmd, callback, "[ctn] g " + initDefault, pm);
                } else {
                        gui = new GFEditor2(gfCmd, callback, "[ctn] g " + initAbs, pm);
                }
                        
        }
        
        
        /** 
         * we should not end the program, just close the GF editor
         * possibly sending something back to KeY 
         */
        protected void endProgram(){
                String saveQuestion;
                if (this.callback == null) {
                        saveQuestion = "Save text before exiting?";
                } else {
                        saveQuestion = "Save constraint before exiting?";
                }
                int returnStatus;
                if (this.newObject) {
                        returnStatus = JOptionPane.showConfirmDialog(this, saveQuestion, "Save before quitting?", JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.QUESTION_MESSAGE  );
                } else {
                        returnStatus = JOptionPane.NO_OPTION;
                }
                if (returnStatus == JOptionPane.CANCEL_OPTION) {
                        return;
                } else if (returnStatus == JOptionPane.NO_OPTION) {
                        shutDown();
                        return;
                } 
                if (this.callback != null) {
                        try {  
                                // quit should always work even if we cannot send something proper
                                // back to Together/KeY.
                                // Hence this try-catch
                                if (returnStatus == JOptionPane.YES_OPTION) {
                                        String ocl = (String)linearizations.get(modelModulName + "OCL");
                                        if (ocl == null) {
                                                //OCL not present, so switch it on
                                                langMenuModel.setActive(modelModulName + "OCL", true);
                                                send("on " + modelModulName + "OCL");
                                                ocl = (String)linearizations.get(modelModulName + "OCL");
                                        } 
                                        ocl = compactSpaces(ocl.trim()).trim();
                                        
                                        this.callback.sendConstraint(ocl);
                                        
                                }
                        } catch (Exception e) { // just print information about the exception
                                System.err.println("GFEditor2.endProgram() Caught an Exception.");
                                System.err.println("e.getLocalizedMessage(): " + e.getLocalizedMessage());
                                System.err.println("e.toString(): " + e);
                                System.err.println("e.printStackTrace():");
                                e.printStackTrace(System.err);
                        } finally {
                                if (this.callback != null) { // send linearization as a class invariant
                                        Utils.cleanupFromUMLTypes(callback.getGrammarsDir());
                                }
                                shutDown();
                        }
                } else if (returnStatus == JOptionPane.YES_OPTION) {
                        final Action saveAction = new SaveAction();
                        saveAction.actionPerformed(null);
                        shutDown();
                }
        }

        
        /**
         * Shuts down GF and terminates the edior
         */
        private void shutDown() {
                try {
                        send("q", false); // tell external GF process to quit
                } finally {
		                removeAll();
		                dispose();
                }
        }

        /**
         * just replace sequences of spaces with one space
         * @param s The string to be compacted
         * @return the compacted result
         */
        static String compactSpaces(String s) {
                String localResult = new String();
                boolean spaceIncluded = false;
                
                for (int i = 0; i < s.length(); i++) {
                        char c = s.charAt(i);
                        if (c != ' ') { // include all non-spaces
                                localResult += String.valueOf(c);
                                spaceIncluded = false;
                        } else {// we have a space
                                if (!spaceIncluded) {
                                        localResult += " ";
                                        spaceIncluded = true;
                                } // else just skip
                        }
                }
                return localResult;
        }	
        
        /**
         * fills the menu with the possible actions like refinements
         * with the available ones.
         * Parses the GF-output between <menu> and </menu>  tags
         * and fills the corrsponding GUI list -"Select Action".
         * seems to expect the starting menu tag to be already read
         */
    	protected void readRefinementMenu (){
                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("list model changing! ");      
                String s ="";
                Vector printnameVector = new Vector();
                Vector commandVector = new Vector();
                Vector gfCommandVector = new Vector();
                HashSet processedSubcats = new HashSet();
                try {
                        //read item
                        result = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("8 "+result);
                        while (result.indexOf("/menu")==-1){
                                //read show
                                result = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("8 "+result);
                                while (result.indexOf("/show")==-1){          
                                        result = fromProc.readLine();
                                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("9 "+result);
                                        if (result.indexOf("/show")==-1) 
                                        {
                                                if (result.length()>8)
                                                        s+=result.trim();
                                                else
                                                        s+=result;    
                                        }
                                }            
                                //          if (s.charAt(0)!='d')
                                //            listModel.addElement("Refine " + s);
                                //          else 
                                String showText = s;
                                printnameVector.addElement(s);
                                s="";
                                //read /show
                                //read send
                                result = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("8 "+result);
                                result = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("8 "+result);
                                String myCommand = result;
                                commandVector.add(this.result);
                                //read /send (discarded)
                                result = fromProc.readLine();             
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("8 "+result);          
                                
                                // read /item
                                result = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("8 "+result);
                                result = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("8 "+result);
                                
                                final boolean isAbstract = "Abstract".equals(this.selectedMenuLanguage);
                                RealCommand gfc = new RealCommand(myCommand, processedSubcats, this.printnameManager, showText, isAbstract);
                                gfCommandVector.addElement(gfc);
                        }
                } catch(IOException e){
                        System.err.println(e.getMessage());
                        e.printStackTrace();
                }
                formRefinementMenu(gfCommandVector);
        }
    	
    	/**
    	 * Goes through the list of possible refinements and groups them
    	 * according to their subcategory tag (which starts with %)
    	 * If there is a "(" afterwards, everything until the before last
    	 * character in the printname will be used as the display name
    	 * for this subcategory. If this displayname is defined a second time,
    	 * it will get overwritten.
    	 * @param gfCommandVector contains all RealCommands, that are available
    	 * at the moment
    	 */
    	protected void formRefinementMenu(Vector gfCommandVector) {
                this.listModel.clear();
                this.refinementSubcatListModel.clear();
                this.gfcommands.clear();
                this.subcatListModelHashtable.clear();
                this.whichSubcat = null;
                this.popup2.removeAll();
                Vector prelListModel = new Vector();
                
                //at the moment, we don't know yet, which subcats are
                //nearly empty
                for (Iterator it = gfCommandVector.iterator(); it.hasNext();) {
                        GFCommand gfcommand = (GFCommand)it.next();
                        if ((!this.groupSubcat) || (gfcommand.getSubcat() == null)) {
                                prelListModel.addElement(gfcommand);
                        } else {
                                //put stuff in the correct Vector for the refinementSubcatListModel
                                Vector lm;
                                if (subcatListModelHashtable.containsKey(gfcommand.getSubcat())) {
                                        lm = (Vector)this.subcatListModelHashtable.get(gfcommand.getSubcat());
                                } else {
                                        lm = new Vector();
                                        this.subcatListModelHashtable.put(gfcommand.getSubcat(), lm);
                                }
                                lm.addElement(gfcommand);
                                if (gfcommand.isNewSubcat()) {
		                                GFCommand linkCmd = new LinkCommand(gfcommand.getSubcat(), this.printnameManager);
		                                prelListModel.addElement(linkCmd);
                                }
                        }
                }
                
                //so we remove empty subcats now and replace them by their RealCommand
                for (int i = 0; i < prelListModel.size(); i++) {
                        if (prelListModel.get(i) instanceof LinkCommand) {
                                LinkCommand lc = (LinkCommand) prelListModel.get(i);
                                Vector subcatMenu = (Vector)this.subcatListModelHashtable.get(lc.getSubcat());
                                if (subcatMenu.size() == 1) {
                                        RealCommand rc = (RealCommand)subcatMenu.get(0);
                                        prelListModel.set(i, rc);
                                }
                        }
                }
                
                
                // Some types invite special treatment, like Int and String 
                // which can be read from the user.
                if (this.currentNode.isMeta()) {
	                if (this.currentNode.getType().equals("Int")) {
	                        prelListModel.addElement(InputCommand.intInputCommand);
	                } if (this.currentNode.getType().equals("String")) {
	                        prelListModel.addElement(InputCommand.stringInputCommand);
	                }
                }
                
                //now sort the preliminary listmodel
                if (sortRefinements) {
                        Collections.sort(prelListModel);
                }
                //now fill this.listModel
                for (Iterator it = prelListModel.iterator(); it.hasNext();) {
                        Object next = it.next();
                        this.listModel.addElement(next);
                }
    	}
        
    	/**
    	 * Reads the hmsg part of the XML that is put out from GF.
    	 * Everything in [] given in front of a GF command will be rewritten here.
    	 * This method does nothing when no hmsg part is present.
    	 * @param prevreadresult The last line read from GF
    	 * @return the last line this method has read
    	 */
        protected String readHmsg(String prevreadresult){
    	        if ((prevreadresult!=null)&&(prevreadresult.indexOf("<hmsg>") > -1)) {
    	                StringBuffer s =new StringBuffer("");
    	                try {
    	                        String readresult = fromProc.readLine();
    	                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("7 "+readresult);
    	                        while (readresult.indexOf("/hmsg")==-1){       
    	                                s.append(readresult).append('\n');           
    	                                readresult = fromProc.readLine();
    	                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("7 "+readresult);                     
    	                        }
    	                        if (s.indexOf("c") > -1) {
    	                                //clear output before linearization
    	                                this.display = new Display(displayType);
    	                                display(false, false);
    	                                this.htmlOutputVector = new Vector();
    	                                this.textOutputVector = new Vector();
    	                        }
    	                        if (s.indexOf("t") > -1) {
    	                                //tree has changed
    	                                this.treeChanged = true;
    	                        }
    	                        if (s.indexOf("n") > -1) {
    	                                //a new object has been created
    	                                this.newObject = true;
    	                        }
    	                        result = fromProc.readLine();             
    	                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("7 "+result);
    	                        return result;
    	                } catch(IOException e){
    	                        System.err.println(e.getMessage());
    	                        e.printStackTrace();
    	                        return "";
    	                }
    	        } else {
    	                return prevreadresult;
    	        }
        }

        
        /**
         * reads the linearizations in all language.
         * seems to expect the first line of the XML structure 
         * (< lin) already to be read
         * Accumulates the GF-output between <linearization> </linearization>  tags
         */
        protected void readLin(){
                try {
                        linearization="";  
                        linearization += result+"\n";           
                        result = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("6 "+result);
                        while ((result!=null)&&(result.indexOf("/linearization")==-1)){       
                                linearization += result+"\n";           
                                result = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("6 "+result);                     
                        }
                        if (newObject) formLin();     
                        result = fromProc.readLine();             
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("6 "+result);          
                } catch(IOException e){
                        System.err.println(e.getMessage());
                        e.printStackTrace();
                }
        }
        
        /**
         * reads in the tree and calls formTree without start end end tag of tree
         * expects the first starting XML tag tree to be already read
         */
        protected void readTree(){
                String treeString = "";
                try {
                        result = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("6 "+result);
                        while (result.indexOf("/tree")==-1){       
                                treeString += result+"\n";           
                                result = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("6 "+result);                     
                        }
                        if (treeChanged && (newObject)) {
                                formTree(tree, treeString); 
                                treeChanged = false;  
                        } 
                        treeString="";                     
                        result = fromProc.readLine();             
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("6 "+result);          
                } catch(IOException e){
                        System.err.println(e.getMessage());
                        e.printStackTrace();
                }
        }
        
        /**
         * Parses the GF-output between <message> </message>  tags
         * and puts it in the linearization area.
         * seems to expect the opening message tag to be already read
         */
        protected void readMessage(){
                String s ="";
                try {
                        result = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("7 "+result);
                        while (result.indexOf("/message")==-1){       
                                s += result+"\n";           
                                result = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("7 "+result);                     
                        }
                        if (s.length()>1) {
                                this.display.addToStages("-------------\n" + s, "<hr>" + s);
                                //in case no language is displayed
                                display(false, false);
                        }
                        result = fromProc.readLine();             
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("7 "+result);          
                } catch(IOException e){
                        System.err.println(e.getMessage());
                        e.printStackTrace();
                }
        }
 
        /**
         * reads the cat entries and puts them into menu, and after that reads
         * the names of the languages and puts them into the language menu
         * Parses the GF-output between <gfinit> tags
         * and fill the New combobox in the GUI.
         */
        protected void formNewMenu () {
                boolean more = true;
                try {
                        //read first cat
                        result = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) {
                                xmlLogger.finer("2 "+result);
                        }
                        if (result.indexOf("(none)") > -1) {
                                //no topics present
                                more = false;
                        }
                        
                        while (more){
                                //adds new cat s to the menu
                                if (result.indexOf("topic")==-1) {
                                        newCategoryMenu.addItem(result.substring(6));                       
                                } 
                                else 
                                        more = false;
                                //read </newcat
                                result = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("2 "+result);
                                //read <newcat (normally)
                                result = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("3 "+result); 
                                if (result.indexOf("topic")!=-1) {
                                        //no more categories
                                        more = false; 
                                }
                                //read next cat / topic
                                result = fromProc.readLine();             
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("4 "+result);       
                        }
                        //set topic
                        grammar.setText(result.substring(4)+"          ");
                        //read </topic>
                        result = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("2 "+result);
                        //read <language>
                        result = fromProc.readLine();
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("3 "+result);
                        //read actual language
                        result = fromProc.readLine();             
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("4 "+result);       
                        
                        //read the languages and select the last non-abstract
                        more = true;
                        while (more){
                                if ((result.indexOf("/gfinit")==-1)&&(result.indexOf("lin")==-1)) {         
                                        //form lang and Menu menu:
                                        final String langName = result.substring(4);
                                        final boolean active;
                                        if (langName.equals("Abstract")) {
                                                active = false;
                                        } else { 
                                                active = true;
                                        }
                                        this.langMenuModel.add(langName, active);

                                        //select FromUMLTypesOCL by default
                                        if (langName.equals(modelModulName + "OCL")) {
                                                this.selectedMenuLanguage = modelModulName + "OCL"; 
                                        }
                                        //'register' the presence of this language.
                                        this.linearizations.put(langName, null);
                                } else { 
                                        more = false;
                                }
                                // read </language>
                                result = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("2 "+result); 
                                // read <language> or </gfinit...>
                                result = fromProc.readLine();
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("3 "+result); 
                                if ((result.indexOf("/gfinit")!=-1)||(result.indexOf("lin")!=-1)) 
                                        more = false; 
                                if (result.indexOf("/gfinit")!=-1)
                                        finished = true;
                                // registering the file name:
                                if (result.indexOf("language")!=-1) {
                                        String path = result.substring(result.indexOf('=')+1,
                                                        result.indexOf('>')); 
                                        path =path.substring(path.lastIndexOf('/')+1);
                                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("name: "+path);
                                        fileString +="--" + path +"\n";
                                        if (path.lastIndexOf('.')!=path.indexOf('.'))
                                                grammar.setText(path.substring(0,
                                                                path.indexOf('.')).toUpperCase()+"          ");
                                }
                                //TODO in case of finished, read "", otherwise ...
                                result = fromProc.readLine();             
                                if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("4 "+result);               
                        }
                } catch(IOException e){
                        logger.warning(e.getMessage());
                }
        }
        
        /**
         * Parses the GF-output between &lt;lin&gt; &lt;/lin&gt;  tags.
         * Sets the current focusPosition, then changes all &lt;focus&gt; tags
         * into regular &lt;subtree&gt; tags.
         * 
         * Expects its argument in this.result
         * 
         * Then control is given to appendMarked, which does the display
         * @param clickable true iff the correspondent display area should be clickable
         * @param doDisplay true iff the linearization should be displayed.
         */
        protected StringBuffer outputAppend(boolean clickable, boolean doDisplay){
                final StringBuffer linCollector = new StringBuffer();
                //result=result.replace('\n',' ');
                if (linMarkingLogger.isLoggable(Level.FINER)) { 
                        linMarkingLogger.finer("INPUT:"+result);
                }
                int focusTagBegin = this.result.indexOf("<focus");
                int typeBegin=this.result.indexOf("type=",focusTagBegin);
                int focusTagEnd = this.result.indexOf('>',typeBegin);
                // status incorrect ?:
                final int typeEnd;
                if ((typeBegin > -1) && (this.result.substring(typeBegin,focusTagEnd).indexOf("incorrect")!=-1)) {  
                        typeEnd = result.indexOf("status");
                } else {
                        typeEnd = focusTagEnd;
                }
                int focusTextBegin = this.result.indexOf("focus");    
                if (focusTagBegin!=-1){
                        // in case focus tag is cut into two lines:
                        if (focusTagBegin==-1){
                                focusTagBegin = focusTextBegin - 7;         
                        }
                        final int positionBegin=this.result.indexOf("position",focusTagBegin);
                        final int positionEnd=this.result.indexOf("]",positionBegin);
                        if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                linMarkingLogger.finer("POSITION START: "+positionBegin 
                                                + "\n-> POSITION END: "+positionEnd);
                        }
                        if (xmlLogger.isLoggable(Level.FINER)) {
                                xmlLogger.finer("form Lin1: "+this.result);
                        }
                        this.focusPosition = new LinPosition(result.substring(positionBegin+9,positionEnd+1),
                                        this.result.substring(positionBegin,focusTagEnd).indexOf("incorrect")==-1);
                        statusLabel.setText(" "+result.substring(typeBegin+5,typeEnd));
                        //changing <focus> to <subtree>
                        this.result = replaceNotEscaped(this.result, "<focus", "<subtree");
                        this.result = replaceNotEscaped(this.result, "</focus", "</subtree");
                        
                        String appended = appendMarked(this.result + '\n', clickable, doDisplay);
                        linCollector.append(appended);
                } else {//no focus at all (message?):
                        this.focusPosition = null;
//                      beware the side-effects! They are, what counts
                        linCollector.append(appendMarked(this.result + '\n', clickable, doDisplay));
                }
//                if (logger.isLoggable(Level.FINER)) {
//                        logger.finer("collected appended linearizations:\n" + linCollector.toString());
//                }
                return linCollector;
        }

    	/**
    	 * Replaces all occurances of toBeReplaced, that are not escaped by '\'
    	 * with replacement
    	 * @param working the String in which substrings should be replaced
    	 * @param toBeReplaced The substring, that should be replaced by replacement
    	 * @param replacement well, the replacement string
    	 * @return The String with the replaced parts
    	 */
        private static String replaceNotEscaped(String working, String toBeReplaced, String replacement) {
    			StringBuffer w = new StringBuffer(working);
    	                for (int i = w.indexOf(toBeReplaced); i > -1 && i < w.length(); i = w.indexOf(toBeReplaced, i)) {
    	                        if (i == 0 || w.charAt(i - 1) != '\\') {
    					w.replace(i, i + toBeReplaced.length(), replacement);
    					i += replacement.length();
    				} else {
    					i += 1;
    				}
    	                }
    			return w.toString();
    	}
        
        
        /**
         * Parses the GF-output between <linearization> </linearization>  tags
         * 
         * pseudo-parses the XML lins and fills the output text area
         * with the lin in all enabled languages
         */
        protected void formLin(){
                //reset previous output
                this.display = new Display(displayType);
                this.linearizations.clear();
                
                boolean firstLin=true; 
                //read first line like '    <lin lang=Abstract>'
                result = linearization.substring(0,linearization.indexOf('\n'));
                //the rest of the linearizations
                String lin = linearization.substring(linearization.indexOf('\n')+1);
                //extract the language from result
                int ind = Utils.indexOfNotEscaped(result, "=");
                int ind2 = Utils.indexOfNotEscaped(result, ">");
                /** The language of the linearization */
                String language = result.substring(ind+1,ind2);
                //the first direct linearization
                result = lin.substring(0,lin.indexOf("</lin>"));
                //the rest
                lin = lin.substring(lin.indexOf("</lin>"));
                while (result.length()>1) {
                        this.langMenuModel.add(language,true);
                        // selected?
                        boolean visible = this.langMenuModel.isLangActive(language);
                        if (visible && !firstLin) {   
								// appending sth. linearizationArea
								this.display.addToStages("\n************\n", "<br><hr><br>");
                        }
                        if (xmlLogger.isLoggable(Level.FINER)) {
                                xmlLogger.finer("linearization for the language: "+result);
                        }
                        // we want the side-effects of outputAppend
                        final boolean isAbstract = "Abstract".equals(language);
                        String linResult = outputAppend(!isAbstract, visible).toString();
                        if (visible) {
                                firstLin = false;
                        }
                        linearizations.put(language, linResult);
                        // read </lin>
                        lin = lin.substring(lin.indexOf('\n')+1);
                        // read lin or 'end'
                        if (lin.length()<1) {
                                break;
                        }
                        
                        result = lin.substring(0,lin.indexOf('\n'));
                        lin = lin.substring(lin.indexOf('\n')+1);
                        if (result.indexOf("<lin ")!=-1){
                                //extract the language from result
                                ind = result.indexOf('=');
                                ind2 = result.indexOf('>');
                                language = result.substring(ind+1,ind2);
                                result = lin.substring(0,lin.indexOf("</lin>"));
                                lin = lin.substring(lin.indexOf("</lin>"));
                        }  
                }
                display(true, true);

                //do highlighting
                this.linearizationArea.getHighlighter().removeAllHighlights();
                this.htmlLinPane.getHighlighter().removeAllHighlights();
                final HashSet incorrectMA = new HashSet();
                for (int i = 0; i<htmlOutputVector.size(); i++)  {
                        final HtmlMarkedArea ma = (HtmlMarkedArea)this.htmlOutputVector.elementAt(i);
                        //check, if and how ma should be highlighted
                        boolean incorrect = false;
                        boolean focused = false;
                        if (redLogger.isLoggable(Level.FINER)) {
                                redLogger.finer("Highlighting: " + ma);
                        }
                        if (!ma.position.correctPosition) {
                                incorrectMA.add(ma);
                                incorrect = true;
                        } else {
                                //This could be quadratic, but normally on very
                                //few nodes constraints are introduced, so
                                //incorrectMA should not contain many elements.
                                HtmlMarkedArea incMA;
                                for (Iterator it = incorrectMA.iterator(); !incorrect && it.hasNext();) {
                                        incMA = (HtmlMarkedArea)it.next();
                                        if (isSubtreePosition(incMA.position, ma.position)) {
                                                incorrect = true;
                                        }
                                }
                        }
                        if (isSubtreePosition(this.focusPosition, ma.position)) {
                                focused = true;
                        }

                        //now highlight
                        if (focused && incorrect) {
                                highlight(ma, Color.ORANGE);
                                highlightHtml(ma, Color.ORANGE);
                        } else if (focused) {
                                highlight(ma, linearizationArea.getSelectionColor());
                                highlightHtml(ma, linearizationArea.getSelectionColor());
                        } else if (incorrect) {
                                highlight(ma, Color.RED);
                                highlightHtml(ma, Color.RED);
                        }
                }
                
//                if (logger.isLoggable(Level.FINER)) {
//                        logger.finer("completeLin: \n" + completeLin);
//                }
        }
        

        
        /**
         * Small method that takes this.display and displays its content 
         * accordingly to what it is (pure text/HTML)
         * @param saveScroll if the old scroll state should be saved
         * @param restoreScroll if the old scroll state should be restored
         */
        private void display(boolean saveScroll, boolean restoreScroll) {
                //Display the pure text
                final String text = this.display.getText();
                this.linearizationArea.setText(text);
                if (restoreScroll) {
                        this.linearizationArea.scrollRectToVisible(this.display.recText);
                }
                if (saveScroll) {
                        this.display.recText = this.linearizationArea.getVisibleRect();
                }
                
                //Display the HTML
                final String html = this.display.getHtml(this.font);
                this.htmlLinPane.setText(html);
                if (restoreScroll) {
                        this.htmlLinPane.scrollRectToVisible(this.display.recHtml);
                }
                if (saveScroll) {
                        this.display.recHtml = this.htmlLinPane.getVisibleRect();
                }
        }

        /**
         * Highlights the given MarkedArea in htmlLinPane
         * @param ma the MarkedArea
         * @param color the color the highlight should get
         */
        private void highlightHtml(final HtmlMarkedArea ma, Color color) {
                try {
                        int begin = ma.htmlBegin;
                        int end = ma.htmlEnd;
                        //When creating the HtmlMarkedArea, we don't know, if
                        //it is going to be the last or not.
                        if (end > this.htmlLinPane.getDocument().getLength()) {
                                end = this.htmlLinPane.getDocument().getLength();
                        }
                        this.htmlLinPane.getHighlighter().addHighlight(begin, end, new DefaultHighlighter.DefaultHighlightPainter(color));
                        if (redLogger.isLoggable(Level.FINER)) {
                                redLogger.finer("HTML HIGHLIGHT: " + this.htmlLinPane.getDocument().getText(begin, end - begin) + "; Color:" + color);
                        }
                } catch (BadLocationException e) {
                        redLogger.warning("HTML highlighting problem!\n" + e.getLocalizedMessage() + " : " + e.offsetRequested() + "\nHtmlMarkedArea: " + ma + "\nhtmlLinPane length: " + this.htmlLinPane.getDocument().getLength());
                }
        }

        /**
         * Highlights the given MarkedArea in linearizationArea
         * @param ma the MarkedArea
         * @param color the color the highlight should get
         */
        private void highlight(final MarkedArea ma, Color color) {
                try {
                        int begin = ma.begin;
                        int end = ma.end ;
                        //When creating the HtmlMarkedArea, we don't know, if
                        //it is going to be the last or not.
                        if (end > this.linearizationArea.getText().length()) {
                                end = this.linearizationArea.getText().length() + 1;
                        }
                        this.linearizationArea.getHighlighter().addHighlight(begin, end, new DefaultHighlighter.DefaultHighlightPainter(color));
                        if (redLogger.isLoggable(Level.FINER)) {
                                redLogger.finer("HIGHLIGHT: " + this.linearizationArea.getText(begin, end - begin) + "; Color:" + color);
                        }
                } catch (BadLocationException e) {
                        redLogger.warning("highlighting problem!\n" + e.getLocalizedMessage() + " : " + e.offsetRequested() + "\nMarkedArea: " + ma + "\nlinearizationArea length: " + this.linearizationArea.getText().length());
                }
        }
        
        
        /**
         * compares two position strings and returns true, if superPosition is
         * a prefix of subPosition, that is, if subPosition is in a subtree of
         * superPosition
         * @param superPosition the position String in Haskell notation 
         * ([0,1,0,4]) of the to-be super-branch of subPosition
         * @param subPosition the position String in Haskell notation 
         * ([0,1,0,4]) of the to-be (grand-)child-branch of superPosition
         * @return true iff superPosition denotes an ancestor of subPosition 
         */
        private static boolean isSubtreePosition(final LinPosition superPosition, final LinPosition subPosition) {
                if (superPosition == null || subPosition == null) {
                        return false;
                }
                String superPos = superPosition.position;
                String subPos = subPosition.position;
                if (superPos.length() < 2 || subPos.length() < 2 ) {
                        return false;
                }
                superPos = superPos.substring(1, superPos.length() - 1);
                subPos = subPos.substring(1, subPos.length() - 1);
                boolean result = subPos.startsWith(superPos);
                return result;
        }
        
        /**
         * Sets the font on all the GUI-elements to font.
         * @param newFont the font everything should have afterwards
         */
        protected void fontEveryWhere(Font newFont) {                          
                linearizationArea.setFont(newFont);
                htmlLinPane.setFont(newFont);
                parseField.setFont(newFont);  
                tree.tree.setFont(newFont);  
                refinementList.setFont(newFont);
                refinementSubcatList.setFont(newFont);
                popup2.setFont(newFont);  
                save.setFont(newFont);  
                grammar.setFont(newFont);  
                open.setFont(newFont);  
                newTopic.setFont(newFont);  
                gfCommand.setFont(newFont);  
                leftMeta.setFont(newFont);  
                left.setFont(newFont);  
                top.setFont(newFont);  
                right.setFont(newFont);  
                rightMeta.setFont(newFont);
                actionOnSubterm.setFont(newFont);
                read.setFont(newFont);
                alpha.setFont(newFont);  
                random.setFont(newFont);  
                undo.setFont(newFont);  
                filterMenu.setFont(newFont);
                setFontRecursive(filterMenu, newFont, false);
                modify.setFont(newFont);  
                statusLabel.setFont(newFont);  
                menuBar.setFont(newFont);
                newCategoryMenu.setFont(newFont);
                readDialog.setFont(newFont);
                mlMenu.setFont(newFont);  
                setFontRecursive(mlMenu, newFont, false);
                modeMenu.setFont(newFont);  
                setFontRecursive(modeMenu, newFont, false);
                langMenu.setFont(newFont);
                setFontRecursive(langMenu, newFont, false);
                fileMenu.setFont(newFont);
                setFontRecursive(fileMenu, newFont, false);
                usabilityMenu.setFont(newFont);
                setFontRecursive(usabilityMenu, newFont, false);
                viewMenu.setFont(newFont);  
                setFontRecursive(viewMenu, newFont, false);
                setFontRecursive(sizeMenu, newFont, false);
                setFontRecursive(fontMenu, newFont, true);
                //update also the HTML with the new size
                display(false, true);
        }
        
        /**
         * Set the font in the submenus of menu.
         * Recursion depth is 1, so subsubmenus don't get fontified.
         * @param subMenu The menu whose submenus should get fontified
         * @param font the chosen font
         * @param onlySize If only the font size or the whole font should
         * be changed
         */
        private void setFontRecursive(JMenu subMenu, Font font, boolean onlySize)
        {  
                for (int i = 0; i<subMenu.getItemCount(); i++)
                { 
                        JMenuItem item = subMenu.getItem(i);
                        if (item != null) {
                                //due to a bug in the jvm (already reported) deactivated
                                if (false && onlySize) {
                                        Font newFont = new Font(item.getFont().getName(), Font.PLAIN, font.getSize());
                                        item.setFont(newFont);
                                } else {
                                        item.setFont(font);
                                }
                                //String name = item.getClass().getName();
                                //if (logger.isLoggable(Level.FINER)) logger.finer(name);
                        }
                }
        }
        
        /**
         * the big ActionListener method that does nearly all user interaction
         */
        public void actionPerformed(ActionEvent ae) {
                //all gone into smaller inner classes
        }
        
        
        /**
         * Writes the given String to the given Filename
         * @param str the text to be written
         * @param fileName the name of the file that is to be filled
         */
        static void writeOutput(String str, String fileName) {
                
                try {
                        FileOutputStream fos = new FileOutputStream(fileName);
                        Writer out = new OutputStreamWriter(fos, "UTF8");
                        out.write(str);
                        out.close();
                } catch (IOException e) {
                        JOptionPane.showMessageDialog(null, 
                                        "Document is empty!","Error", JOptionPane.ERROR_MESSAGE);
                }
        }
        
        /**
         * Remove all nodes in the tree and
         * form a dummy tree in treePanel
         * @param myTreePanel the aforementioned treePanel
         */
        protected void resetTree(DynamicTree2 myTreePanel) {
                tree.clear();
                String p1Name = new String("Root");
                myTreePanel.addObject(null, p1Name);
        }
        
        /**
         * Parses the GF-output between <tree> </tree>  tags
         * and build the corresponding tree.
         * 
         * parses the already read XML for the tree and stores the tree nodes
         * in nodeTable with their numbers as keys
         * @param myTreePanel the panel of GFEditor2
         * @param treeString the string representation for the XML tree
         */
        protected void formTree(DynamicTree2 myTreePanel, String treeString) {
                if (treeLogger.isLoggable(Level.FINER)) {
                        treeLogger.finer("treeString: "+ treeString);
                }
                
                /** 
                 * stores the nodes and the indention of their children.
                 * Works stack like, so when all children of a node are read,
                 * the next brethren / uncle node 'registers' with the same
                 * indention depth to show that the next children are his.
                 */
                Hashtable parentNodes = new Hashtable();
                /** 
                 * the path in the JTree (not in GF repesentation!) to the
                 * current new node.
                 */ 
                TreePath path=null;
                String s = treeString;
                myTreePanel.clear();
                /** consecutive node numbering */
                int index = 0;
                /** the node that gets created from the current line */
                DefaultMutableTreeNode newChildNode=null;
                /** is a star somewhere in treestring? 1 if so, 0 otherwise */
                int star = 0;
                if (s.indexOf('*')!=-1) {
                        star = 1;
                }
                /** 
                 * only the first node in the AST that introduces an oper
                 * constraint brings with it the bound variables for self 
                 * and result.
                 * At least for single context constraints, but that is exactly 
                 * that what the editor is for.
                 */
                boolean boundVarsEncountered = false;
                while (s.length()>0) {
                        /** 
                         * every two ' ' indicate one tree depth level
                         * shift first gets assigned the indention depth in 
                         * characters, later the tree depth
                         */
                        int shift = 0;
                        boolean selected = false;
                        while ((s.length()>0) && ((s.charAt(0)=='*')||(s.charAt(0)==' '))){      
                                if (s.charAt(0) == '*') {
                                        selected = true;
                                }
                                s = s.substring(1);     
                                shift++;  
                        }             
                        if (s.length()>0) {
                                                               
                                int j = s.indexOf("\n");
                                //is sth like "andS : Sent ", i.e. "fun : type " before trimming  
                                String gfline = s.substring(0, j).trim();
                                GfAstNode node = new GfAstNode(gfline);
                                if (selected) {
                                        this.currentNode = node;
                                }
                                //get the node that introduces self and result
                                if ((!boundVarsEncountered) && ("OperConstraintBody".equals(node.getType()) || "ClassConstraintBody".equals(node.getType()))) {
                                        this.constraintNode = node;
                                        boundVarsEncountered = true;
                                }
                                
                                index++;
                                s = s.substring(j+1);    
                                shift = (shift - star)/2;
                                
                                /*
                                 * we know the parent, so we can ask it for the param information
                                 * for the next child (the parent knows how many it has already)
                                 * and save it in an AstNodeData
                                 */
                                
                                DefaultMutableTreeNode parent = (DefaultMutableTreeNode)parentNodes.get(new Integer(shift));
                                //default case, if we can get more information, this is overwritten
                                AstNodeData and;
                                Printname childPrintname = null;
                                if (!node.isMeta()) {
                                        childPrintname = this.printnameManager.getPrintname(node.getFun());
                                }
                                if (childPrintname != null) {
                                        //we know this one
                                        and = new RefinedAstNodeData(childPrintname, node);
                                } else if (parent != null && node.isMeta()) {
                                        //new child without refinement
                                        AstNodeData parentAnd = (AstNodeData)parent.getUserObject();
                                        Printname parentPrintname = null;
                                        if (parentAnd != null) {
                                                parentPrintname = parentAnd.getPrintname();
                                        }
                                        if (parentPrintname != null) {
                                                int paramPosition = parent.getChildCount();
                                                String paramName = parentPrintname.getParamName(paramPosition);
                                                if (paramName == null) {
                                                        paramName = node.getFun();
                                                }
                                                //if tooltip turns out to be null that's OK 
                                                String paramTooltip = parentPrintname.htmlifySingleParam(paramPosition);
//                                                if (logger.isLoggable(Level.FINER)) {
//                                                        logger.finer("new node-parsing: '" + name + "', fun: '" + fun + "', type: '" + paramType + "'");
//                                                }
                                                and = new UnrefinedAstNodeData(paramTooltip, node);

                                        } else {
                                                and = new RefinedAstNodeData(null, node);
                                        }
                                } else {
                                        //something unparsable, bad luck
                                        //or refined and not described
                                        and = new RefinedAstNodeData(null, node);
                                }

                                

                                
                                newChildNode = myTreePanel.addObject(parent, and);  
                                parentNodes.put(new Integer(shift+1), newChildNode);
                                path = new TreePath(newChildNode.getPath());
                                nodeTable.put(path, new Integer(index));

                                if (selected) {                        
                                        //show the selected as the 'selected' one in the JTree
                                        myTreePanel.tree.setSelectionPath(path);              
                                        myTreePanel.oldSelection = index;
                                        if (treeLogger.isLoggable(Level.FINER)) {
                                                treeLogger.finer("new selected index "+ index);
                                        }
                                }
                        }
                }
                if ((newChildNode!=null)) {
                        myTreePanel.tree.makeVisible(path); 
                        gui2.toFront();
                        index = 0;
                }
        }
        
        
        /** Handle the key pressed event. */
        public void keyPressed(KeyEvent e) {
                int keyCode = e.getKeyCode();   
                Object obj = e.getSource();
                if (keyLogger.isLoggable(Level.FINER)) {
                        keyLogger.finer("Key pressed: " + e.toString());
                }

                if  (obj==refinementSubcatList) {
                        if (keyCode == KeyEvent.VK_ENTER) {
                                listAction(refinementSubcatList, refinementSubcatList.getSelectedIndex(), true);
                        } else if (keyCode == KeyEvent.VK_LEFT) {
                                refinementList.requestFocusInWindow();
                                refinementSubcatList.clearSelection();
                                refinementList.setSelectionBackground(refinementSubcatList.getSelectionBackground());
                        }
                } else if (obj == refinementList) {
                        int index = refinementList.getSelectedIndex();                        
                        if (index == -1) {
                                //nothing selected, so nothing to be seen here, please move along
                        } else if (keyCode == KeyEvent.VK_ENTER) { 
                                listAction(refinementList, refinementList.getSelectedIndex(), true);
                        } else if (keyCode == KeyEvent.VK_DOWN && index < listModel.getSize() - 1) {
                                listAction(refinementList, index + 1, false);
                        } else if (keyCode == KeyEvent.VK_UP && index > 0) {
                                listAction(refinementList, index - 1, false);
                        } else if (keyCode == KeyEvent.VK_RIGHT) {
                                if (refinementSubcatList.getModel().getSize() > 0) {
                                        refinementSubcatList.requestFocusInWindow();
                                        refinementSubcatList.setSelectedIndex(0);
                                        refinementList.setSelectionBackground(Color.GRAY);
                                }
                        }
                } else if (obj==parseField) {                
		                if  (keyCode == KeyEvent.VK_ENTER) { 
		                        getLayeredPane().remove(parseField); 
		                        treeChanged = true;
		                        send("p "+parseField.getText());        
		                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("sending parse string: "+parseField.getText());
		                        repaint();
		                } else if  (keyCode == KeyEvent.VK_ESCAPE) { 
		                        getLayeredPane().remove(parseField);   
		                        repaint();
		                }
                }
        }

        /** 
         * Handle the key typed event.
         * We are not really interested in typed characters, thus empty
         */
        public void keyTyped(KeyEvent e) {
                //needed for KeyListener, but not used                
        }

        /** Handle the key released event. */
        public void keyReleased(KeyEvent e) {
                //needed for KeyListener, but not used
        }
        
        /** 
         * Returns the biggest position of first and second.
         * Each word in the linearization area has the corresponding
         * position in the tree. The position-notion is taken from 
         * GF-Haskell, where empty position ("[]") 
         * represents tree-root, "[0]" represents  first child of the root,
         * "[0,0]" represents the first grandchild of the root etc.
         * So comparePositions("[0]","[0,0]")="[0]"
         */
        private  String comparePositions(String first, String second) {
                String common ="[]";
                int i = 1; 
                while ((i<Math.min(first.length()-1,second.length()-1))&&(first.substring(0,i+1).equals(second.substring(0,i+1))))
                {
                        common=first.substring(0,i+1); 
                        i+=2;
                }
                if (common.charAt(common.length()-1)==']') {
                        return common;
                } else { 
                        return common+"]";
                }
        }
        
        /**
         * Returns the widest position (see comments to comparePositions) 
         * covered in the string from begin to end in the 
         * linearization area
         * @param begin
         * @param end
         * @return the position in GF Haskell notation (hdaniels guesses)
         */
        private String findMax(int begin, int end) {
                String max = (((MarkedArea)this.htmlOutputVector.elementAt(begin)).position).position;
                for (int i = begin+1; i <= end; i++)
                        max =  comparePositions(max,(((MarkedArea)this.htmlOutputVector.elementAt(i)).position).position);
                return max;
        }
        
        /**
         * Returns the widest position (see comments to comparePositions) 
         * covered in the string from begin to end in htmlLinPane 
         * @param begin
         * @param end
         * @return the position in GF Haskell notation (hdaniels guesses)
         */
        private String findMaxHtml(int begin, int end) {
                String max = (((HtmlMarkedArea)this.htmlOutputVector.elementAt(begin)).position).position;
                for (int i = begin+1; i <= end; i++)
                        max =  comparePositions(max,(((MarkedArea)htmlOutputVector.elementAt(i)).position).position);
                return max;
        }
        
        /**
         * One can either click on a leaf in the lin area, or select a larger subtree.
         * The corresponding tree node is selected.
         */
        public void caretUpdate(CaretEvent e)
        {
                String jPosition ="", iPosition="", position="";
                MarkedArea jElement = null;
                MarkedArea iElement = null;
                int j = 0;
                int i = this.htmlOutputVector.size()-1;
                int start = linearizationArea.getSelectionStart();
                int end = linearizationArea.getSelectionEnd();
                if (popUpLogger.isLoggable(Level.FINER)) {
                        popUpLogger.finer("CARET POSITION: "+linearizationArea.getCaretPosition()
                                        + "\n-> SELECTION START POSITION: "+start
                                        + "\n-> SELECTION END POSITION: "+end);
                }
                if (linMarkingLogger.isLoggable(Level.FINER)) {
                        if (end>0&&(end<linearizationArea.getText().length())) { 
                                linMarkingLogger.finer("CHAR: "+linearizationArea.getText().charAt(end));
                        }
                }
                // not null selection:
                if ((i>-1)&&(start<linearizationArea.getText().length()-1)) 
                {
                        if (linMarkingLogger.isLoggable(Level.FINER))
                                for (int k=0; k<this.htmlOutputVector.size(); k++) { 
                                        linMarkingLogger.finer("element: "+k+" begin "+((MarkedArea)this.htmlOutputVector.elementAt(k)).begin+" "
                                        + "\n-> end: "+((MarkedArea)this.htmlOutputVector.elementAt(k)).end+" "       
                                        + "\n-> position: "+(((MarkedArea)this.htmlOutputVector.elementAt(k)).position).position+" "   
                                        + "\n-> words: "+((MarkedArea)this.htmlOutputVector.elementAt(k)).words);   
                                }
                        // localizing end:
                        while ((j< this.htmlOutputVector.size())&&(((MarkedArea)this.htmlOutputVector.elementAt(j)).end < end))
                                j++;
                        // localising start:
                        while ((i>=0)&&(((MarkedArea)this.htmlOutputVector.elementAt(i)).begin > start))
                                i--;
                        if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                linMarkingLogger.finer("i: "+i+" j: "+j);
                        }
                        if ((j<this.htmlOutputVector.size()))
                        {
                                jElement = (MarkedArea)this.htmlOutputVector.elementAt(j);
                                jPosition = jElement.position.position;
                                // less & before:
                                if (i==-1)
                                { // less:
                                        if (end>=jElement.begin)
                                        {
                                                iElement = (MarkedArea)this.htmlOutputVector.elementAt(0);
                                                iPosition = iElement.position.position;
                                                if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                        linMarkingLogger.finer("Less: "+jPosition+" and "+iPosition);
                                                }
                                                position = findMax(0,j);
                                                if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                        linMarkingLogger.finer("SELECTEDTEXT: "+position+"\n");
                                                }
                                                treeChanged = true; 
                                                send("mp "+position);
                                        }
                                        // before:
                                        else 
                                                if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                        linMarkingLogger.finer("BEFORE vector of size: "+this.htmlOutputVector.size());
                                                }
                                }
                                // just:
                                else
                                { 
                                        iElement = (MarkedArea)this.htmlOutputVector.elementAt(i);
                                        iPosition = iElement.position.position;
                                        if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                linMarkingLogger.finer("SELECTED TEXT Just: "+iPosition +" and "+jPosition+"\n");
                                        }
                                        position = findMax(i,j);
                                        if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                linMarkingLogger.finer("SELECTEDTEXT: "+position+"\n");
                                        }
                                        treeChanged = true; 
                                        send("mp "+position);
                                }
                        } 
                        else 
                                // more && after:
                                if (i>=0)
                                {
                                        iElement = (MarkedArea)this.htmlOutputVector.elementAt(i);
                                        iPosition = iElement.position.position;
                                        // more
                                        if (start<=iElement.end)
                                        { 
                                                jElement = (MarkedArea)this.htmlOutputVector.elementAt(this.htmlOutputVector.size()-1);
                                                jPosition = jElement.position.position;
                                                if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                        linMarkingLogger.finer("MORE: "+iPosition+ " and "+jPosition);
                                                }
                                                position = findMax(i,this.htmlOutputVector.size()-1);
                                                if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                        linMarkingLogger.finer("SELECTEDTEXT: "+position+"\n");
                                                }
                                                treeChanged = true; 
                                                send("mp "+position);
                                        }
                                        else
                                                // after:
                                                if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                        linMarkingLogger.finer("AFTER vector of size: "+this.htmlOutputVector.size());
                                                }
                                } 
                                else
                                        // bigger:
                                {
                                        iElement = (MarkedArea)this.htmlOutputVector.elementAt(0);
                                        iPosition = iElement.position.position;
                                        jElement = (MarkedArea)this.htmlOutputVector.elementAt(this.htmlOutputVector.size()-1);
                                        jPosition = jElement.position.position;
                                        if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                linMarkingLogger.finer("BIGGER: "+iPosition +" and "+jPosition+"\n"         
                                                                + "\n-> SELECTEDTEXT: []\n");
                                        }
                                        treeChanged = true; 
                                        send("mp []");
                                }
                }//not null selection
        }
        
        /**
         * Appends the string s to the text in the linearization area
         * on the screen. It parses the subtree tags and registers them.
         * The focus tag is expected to be replaced by subtree.
         * @param restString string to append, with tags in it.
         * @param clickable if true, the text is appended and the subtree tags are
         * parsed. If false, the text is appended, but the subtree tags are ignored. 
         * @param doDisplay true iff the output is to be displayed. 
         * Implies, if false, that clickable is treated as false.
         */
        protected String appendMarked(String restString, final boolean clickable, boolean doDisplay) {
                String appendedPureText = "";
                if (restString.length()>0) {
                        /** 
                         * the length of what is already displayed of the linearization.
                         * Alternatively: What has been processed in restString since
                         * subtreeBegin
                         */
                        int currentLength = 0;
                        /** position of &lt;subtree */
                        int subtreeBegin;
                        /** position of &lt;/subtree */
                        int subtreeEnd;
                        
                        if (clickable && doDisplay) {
                                subtreeBegin = Utils.indexOfNotEscaped(restString, "<subtree");
                                subtreeEnd = Utils.indexOfNotEscaped(restString, "</subtree");
                                // cutting subtree-tags:
                                while ((subtreeEnd>-1)||(subtreeBegin>-1)) {
                                        /** 
                                         * length of the portion that is to be displayed
                                         * in the current run of appendMarked.
                                         * For HTML this would have to be calculated
                                         * in another way.
                                         */
                                        final int newLength;

                                        if ((subtreeEnd==-1)||((subtreeBegin<subtreeEnd)&&(subtreeBegin>-1))) {
                                                final int subtreeTagEnd = Utils.indexOfNotEscaped(restString, ">",subtreeBegin);                                      
                                                final int nextOpeningTagBegin = Utils.indexOfNotEscaped(restString, "<", subtreeTagEnd);
                                                
                                                //getting position:
                                                final int posStringBegin = Utils.indexOfNotEscaped(restString, "[",subtreeBegin);
                                                final int posStringEnd = Utils.indexOfNotEscaped(restString, "]",subtreeBegin);
                                                final LinPosition position = new LinPosition(restString.substring(posStringBegin,posStringEnd+1),
                                                                restString.substring(subtreeBegin,subtreeTagEnd).indexOf("incorrect")==-1);
                                                
                                                // is something before the tag?
                                                // is the case in the first run
                                                if (subtreeBegin-currentLength>1) {
                                                        if (linMarkingLogger.isLoggable(Level.FINER)) {
                                                                linMarkingLogger.finer("SOMETHING BEFORE THE TAG");
                                                        }
                                                        if (this.currentPosition.size()>0)
                                                                newLength = register(currentLength, subtreeBegin, (LinPosition)this.currentPosition.elementAt(this.currentPosition.size()-1), restString);
                                                        else
                                                                newLength = register(currentLength, subtreeBegin, new LinPosition("[]",
                                                                                restString.substring(subtreeBegin,subtreeTagEnd).indexOf("incorrect")==-1), restString);
                                                } else {       // nothing before the tag:
                                                        //the case in the beginning
                                                        if (linMarkingLogger.isLoggable(Level.FINER)) {
                                                                linMarkingLogger.finer("NOTHING BEFORE THE TAG");             
                                                        }
                                                        if (nextOpeningTagBegin>0) {
                                                                newLength = register(subtreeTagEnd+2, nextOpeningTagBegin, position, restString);
                                                        } else {
                                                                newLength = register(subtreeTagEnd+2, restString.length(), position, restString);
                                                        }
                                                        restString = removeSubTreeTag(restString,subtreeBegin, subtreeTagEnd+1);
                                                }
                                                currentLength += newLength ;
                                        } else {// l<l2
                                                // something before the </subtree> tag:
                                                if (subtreeEnd-currentLength>1) {
                                                        if (linMarkingLogger.isLoggable(Level.FINER)) {
                                                                linMarkingLogger.finer("SOMETHING BEFORE THE </subtree> TAG");
                                                        }
                                                        if (this.currentPosition.size()>0)
                                                                newLength = register(currentLength, subtreeEnd, (LinPosition)this.currentPosition.elementAt(this.currentPosition.size()-1), restString);
                                                        else
                                                                newLength = register(currentLength, subtreeEnd, new LinPosition("[]",
                                                                                restString.substring(subtreeBegin,subtreeEnd).indexOf("incorrect")==-1), restString);
                                                        currentLength += newLength ;
                                                }
                                                // nothing before the tag:
                                                else 
                                                        // punctuation after the </subtree> tag:
                                                        if (restString.substring(subtreeEnd+10,subtreeEnd+11).trim().length()>0)
                                                        {
                                                                if (linMarkingLogger.isLoggable(Level.FINER)) {
                                                                        linMarkingLogger.finer("PUNCTUATION AFTER THE </subtree> TAG"
                                                                                        + "/n" + "STRING: " + restString);
                                                                }
                                                                //cutting the tag first!:
                                                                if (subtreeEnd>0) {
                                                                        restString =  removeSubTreeTag(restString,subtreeEnd-1, subtreeEnd+9); 
                                                                } else {
                                                                        restString = removeSubTreeTag(restString,subtreeEnd, subtreeEnd+9);
                                                                }
                                                                if (linMarkingLogger.isLoggable(Level.FINER)) {
                                                                        linMarkingLogger.finer("STRING after cutting the </subtree> tag: "+restString);
                                                                }
                                                                // cutting the space in the last registered component:
                                                                if (this.htmlOutputVector.size()>0) {
                                                                        ((MarkedArea)this.htmlOutputVector.elementAt(this.htmlOutputVector.size()-1)).end -=1; 
                                                                        if (currentLength>0) {
                                                                                currentLength -=1; 
                                                                        }
                                                                }
                                                                if (linMarkingLogger.isLoggable(Level.FINER)) {
                                                                        linMarkingLogger.finer("currentLength: " + currentLength);
                                                                }
                                                                // register the punctuation:
                                                                if (this.currentPosition.size()>0) {
                                                                        newLength = register(currentLength, currentLength+2, (LinPosition)this.currentPosition.elementAt(this.currentPosition.size()-1), restString);
                                                                } else {
                                                                        newLength = register(currentLength, currentLength+2, new LinPosition("[]",
                                                                                        true), restString);
                                                                }
                                                                currentLength += newLength ;
                                                        } else {
                                                                // just cutting the </subtree> tag:
                                                                restString = removeSubTreeTag(restString,subtreeEnd, subtreeEnd+10);
                                                        }
                                        }
                                        subtreeEnd = Utils.indexOfNotEscaped(restString, "</subtree");
                                        subtreeBegin = Utils.indexOfNotEscaped(restString, "<subtree");
                                        //          if (debug2) 
                                        //                System.out.println("/subtree index: "+l2 + "<subtree"+l);
                                        if (linMarkingLogger.isLoggable(Level.FINER)) { 
                                                linMarkingLogger.finer("<-POSITION: "+subtreeBegin+" CURRLENGTH: "+currentLength
                                                                + "\n STRING: "+restString.substring(currentLength));
                                        }
                                } //while
                        } else { //no focus, no selection enabled (why ever)
                                //that means, that all subtree tags are removed here.
                                if (linMarkingLogger.isLoggable(Level.FINER)) {
                                        linMarkingLogger.finer("NO SELECTION IN THE TEXT TO BE APPENDED!");
                                }
                                //cutting tags from previous focuses if any:
                                int r = Utils.indexOfNotEscaped(restString, "</subtree>");
                                while (r>-1) {
                                        // check if punktualtion marks like . ! ? are at the end of a sentence:
                                        if (restString.charAt(r+10)==' ')
                                                restString = restString.substring(0,r)+restString.substring(r+11);
                                        else
                                                restString = restString.substring(0,r)+restString.substring(r+10);
                                        r = Utils.indexOfNotEscaped(restString, "</subtree>");
                                }
                                r = Utils.indexOfNotEscaped(restString, "<subtree");
                                while (r>-1) {
                                        int t = Utils.indexOfNotEscaped(restString, ">", r);
                                        if (t<restString.length()-2)
                                                restString = restString.substring(0,r)+restString.substring(t+2);
                                        else 
                                                restString = restString.substring(0,r);
                                        r = Utils.indexOfNotEscaped(restString, "<subtree");
                                }
                        }
                        // appending:
                        restString = unescapeTextFromGF(restString);
                        if (redLogger.isLoggable(Level.FINER)) {
                                redLogger.finer(restString);
                        }
                        appendedPureText = restString.replaceAll("&-","\n ");
                        //display the text if not already done in case of clickable
                        if (!clickable && doDisplay) {
                                // the text has only been pruned from markup, but still needs
                                // to be displayed
                                this.display.addToStages(appendedPureText, appendedPureText);
                        }
                } // else: nothing to append
                return appendedPureText;
        }
        
        /**
         * Replaces a number of escaped characters by an unescaped version
         * of the same length
         * @param string The String with '\' as the escape character
         * @return the same String, but with escaped characters removed
         * 
         */
        static String unescapeTextFromGF(String string) {
                final String more = "\\"+">";
                final String less = "\\"+"<";
                //%% by daniels, linearization output will be changed drastically 
                //(or probably will), so for now some hacks for -> and >=
                string = Utils.replaceAll(string, "-" + more, "-> ");
                string = Utils.replaceAll(string, "-" + more,"-> ");
                string = Utils.replaceAll(string, more," >");
                string = Utils.replaceAll(string, less," <");
                //an escaped \ becomes a single \
                string = Utils.replaceAll(string, "\\\\"," \\");
                return string;
        }
        


        /**
         * Finding position of the searchString not starting with escape symbol (\\) 
         * in the string s from position. 
         * @param s the String that is to be checked.
         * @param searchString
         * @param position
         * @return the position of the first such a char after position
         */
        private int getCharacter(String s, String searchString, int position) {
                int t = s.indexOf(searchString, position);
                int i = t-1;
                int k = 0;
                while ((i>-1)&&(s.charAt(i)=='\\')) {
                        k++;
                        i--;
                }
                if (k % 2 == 0) {
                        return t;
                } else {
                        return getCharacter(s, searchString, t+1);
                }
        }
        
        /**
         * The substring from start to end in workingString, together with
         * position is saved as a MarkedArea in this.htmlOutputVector.
         * The information from where to where the to be created MarkedArea
         * extends, is calculated in this method.
         * @param start The position of the first character in workingString
         * of the part, that is to be registered.
         * @param end The position of the last character in workingString
         * of the part, that is to be registered.
         * @param position the position in the tree that corresponds to
         * the to be registered text
         * @param workingString the String from which the displayed
         * characters are taken from
         * @return newLength, the difference between end and start
         */
        private int register(int start, int end, LinPosition position, String workingString) {
                /**
                 * the length of the piece of text that is to be appended now
                 */
                final int newLength = end-start;
                // the tag has some words to register:
                if (newLength>0) {
                        final String stringToAppend = workingString.substring(start,end);
                        //if (stringToAppend.trim().length()>0) {

                        //get oldLength and add the new text
                        String toAdd = unescapeTextFromGF(stringToAppend);
                        final HtmlMarkedArea hma = this.display.addAsMarked(toAdd, position);
                        this.htmlOutputVector.add(hma);
                        if (htmlLogger.isLoggable(Level.FINER)) {
                                htmlLogger.finer("HTML added  :      " + hma);
                        }                        //} else if (linMarkingLogger.isLoggable(Level.FINER)) {
                        //        linMarkingLogger.finer("whiteSpaces: " + newLength);
                        //}
                } //some words to register
                return newLength;
        }
        
        /**
         * removing subtree-tag in the interval start-end 
         * and updating the coordinates after that
         * basically part of appendMarked
         * No subtree is removed, just the tag. 
         * @param s The String in which the subtree tag should be removed
         * @param start position in restString
         * @param end position in restString
         * @return the String without the subtree-tags in the given interval
         */
        private String removeSubTreeTag (final String s, final int start, final int end) {
                String restString = s;
                if (linMarkingLogger.isLoggable(Level.FINER)) { 
                        linMarkingLogger.finer("removing: "+ start +" to "+ end);
                }
                int difference =end-start+1;
                int positionStart, positionEnd;
                if (difference>20) {
                        positionStart = Utils.indexOfNotEscaped(restString, "[", start);
                        positionEnd = Utils.indexOfNotEscaped(restString, "]", start);
                        
                        currentPosition.addElement(new LinPosition(
                                        restString.substring(positionStart, positionEnd+1),
                                        restString.substring(start,end).indexOf("incorrect")==-1));
                } else if (currentPosition.size()>0) {
                                currentPosition.removeElementAt(currentPosition.size()-1);
                }
                if (start>0) {
                        restString = restString.substring(0,start)+restString.substring(end+1);
                } else{
                        restString = restString.substring(end+1);
                }
                return restString;
        }
        
        /**
         * handling the event of choosing the action at index from the list.
         * That is either giving commands to GF or displaying the subcat menus
         * @param list The list that generated this action
         * @param index the index of the selected element in list
         * @param doubleClick true iff a command should be sent to GF, 
         * false if only a new subcat menu should be opened. 
         */
        protected void listAction(JList list, int index, boolean doubleClick) {
                if (index == -1) {
                        if (xmlLogger.isLoggable(Level.FINER)) xmlLogger.finer("no selection");
                } else {
                        GFCommand command;
                        if (list == refinementList) {
                                command = (GFCommand)listModel.elementAt(index); 
                        } else {
                                Vector cmdvector = (Vector)this.subcatListModelHashtable.get(this.whichSubcat);
                                command = (GFCommand)(cmdvector.get(index));
                        }
                        if (command instanceof LinkCommand) {
                                this.whichSubcat = command.getSubcat();
                                refinementSubcatListModel.clear();
                                Vector currentCommands = (Vector)this.subcatListModelHashtable.get(this.whichSubcat);
                                for (Iterator it = currentCommands.iterator(); it.hasNext();) {
                                        this.refinementSubcatListModel.addElement(it.next());
                                }
                        } else if (doubleClick && command instanceof InputCommand) {
                                InputCommand ic = (InputCommand)command;
                                executeInputCommand(ic);
                                
                        } else if (doubleClick){
                                refinementSubcatListModel.clear();
                                treeChanged = true; 
                                send(command.getCommand());
                        } else if (list == refinementList){
                                refinementSubcatListModel.clear();
                        }
                }
        }
        
        /**
         * Pops up a window for input of the wanted data and asks ic
         * afterwards, if the data has the right format.
         * Then gives that to GF
         * @param ic the InputCommand that specifies the wanted format/type
         */
        private void executeInputCommand(InputCommand ic) {
                String s = (String)JOptionPane.showInputDialog(
                                this,
                                ic.getTitleText(),
                                ic.getTitleText(),
                                JOptionPane.QUESTION_MESSAGE,
                                null,
                                null,
                                "");
                StringBuffer reason = new StringBuffer();
                Object value = ic.validate(s, reason);
                if (value != null) {
                        treeChanged = true;
                        send("g "+value); 
                        if (logger.isLoggable(Level.FINER)) {
                                logger.finer("sending string " + value);
                        }
                } else {
                        this.display.addToStages("\n" + reason.toString(), "<p>" + reason.toString() + "</p>");
                        display(false, false);
                }
        }

        
        /**
         * Produces the popup menu that represents the current refinements.
         * An alternative to the refinement list.
         * @return s.a.
         */
        JPopupMenu producePopup() {
                if (popup2.getComponentCount() > 0) {
                        return popup2;
                }
                for (int i = 0; i < this.listModel.size(); i++) {
                        GFCommand gfcmd = (GFCommand)this.listModel.get(i);
                        if (gfcmd instanceof LinkCommand) {
                                LinkCommand lc = (LinkCommand)gfcmd;
                                Vector subcatMenu = (Vector)this.subcatListModelHashtable.get(lc.getSubcat());
                                JMenu tempMenu = new JMenu(lc.getDisplayText());
                                tempMenu.setToolTipText(lc.getTooltipText());
                                tempMenu.setFont(font);
                                JMenuItem tempMenuItem;
                                for (Iterator it = subcatMenu.iterator(); it.hasNext();) {
                                        GFCommand subgfcmd = (GFCommand)it.next();
                                        tempMenuItem = menuForCommand(subgfcmd);
                                        if (tempMenuItem != null) {
                                                tempMenu.add(tempMenuItem);
                                        }
                                }
                                popup2.add(tempMenu);
                        } else { 
                                JMenuItem tempMenu = menuForCommand(gfcmd);
                                if (tempMenu != null) {
                                        popup2.add(tempMenu);
                                }
                        }
                }
                return popup2;
        }
        
        /**
         * takes a GFCommand and "transforms" it in a JMenuItem.
         * These JMenuItems have their own listeners that take care of
         * doing what is right ...
         * @param gfcmd a RealCommand or an InputCommand
         * (LinkCommand is ignored and produces null as the result)
         * @return either the correspondend JMenuItem or null.
         */
        private JMenuItem menuForCommand(GFCommand gfcmd) {
                JMenuItem tempMenu = null;
                if (gfcmd instanceof RealCommand){
                        tempMenu = new JMenuItem(gfcmd.getDisplayText());
                        tempMenu.setFont(font);
                        tempMenu.setActionCommand(gfcmd.getCommand());
                        tempMenu.setToolTipText(gfcmd.getTooltipText());
                        tempMenu.addActionListener(new ActionListener() {
                                public void actionPerformed(ActionEvent ae) {
                                        JMenuItem mi = (JMenuItem)ae.getSource();
                                        refinementSubcatListModel.clear();
                                        treeChanged = true;
                                        String command = mi.getActionCommand();
                                        send(command);
                                }
                        });
                } else if (gfcmd instanceof InputCommand) {
                        tempMenu = new JMenuItem(gfcmd.getDisplayText());
                        tempMenu.setFont(font);
                        tempMenu.setActionCommand(gfcmd.getCommand());
                        tempMenu.setToolTipText(gfcmd.getTooltipText());
                        tempMenu.addActionListener(new ActionListener() {
                                public void actionPerformed(ActionEvent ae) {
                                        JMenuItem mi = (JMenuItem)ae.getSource();
                                        String command = mi.getActionCommand();
                                        InputCommand ic = InputCommand.forTypeName(command);
                                        if (ic != null) {
                                                executeInputCommand(ic);
                                        }
                                }
                        });
                        
                }
                return tempMenu;
        }
        
        public void focusGained(FocusEvent e) {
                //do nothing
        }
        public void focusLost(FocusEvent e) {
                getLayeredPane().remove(parseField);
                repaint();
        }
        
        /**
         * 
         */
        private void resetNewCategoryMenu() {
                //remove everything except "New"
                while (1< newCategoryMenu.getItemCount())
                        newCategoryMenu.removeItemAt(1);
        }

        /**
         * pop-up menu (adapted from DynamicTree2):
         * @author janna
         *
         */ 
        class PopupListener extends MouseAdapter {
                public void mousePressed(MouseEvent e) {
                        //            int selStart = tree.getRowForLocation(e.getX(), e.getY());
                        //            output.setSelectionRow(selStart);
                        if (popUpLogger.isLoggable(Level.FINER)) {
                                popUpLogger.finer("mouse pressed2: "+linearizationArea.getSelectionStart()+" "+linearizationArea.getSelectionEnd());
                        }
                        maybeShowPopup(e);
                }
                
                public void mouseReleased(MouseEvent e) {
                        //nothing to be done here
                }
                protected void maybeShowPopup(MouseEvent e) {
                        //int i=outputVector.size()-1;
                        // right click:
                        if (e.isPopupTrigger()) {
                                if (popUpLogger.isLoggable(Level.FINER)) {
                                        popUpLogger.finer("changing pop-up menu2!");
                                }
                                popup2 = producePopup();
                                popup2.show(e.getComponent(), e.getX(), e.getY());
                        } 
                        // middle click
                        //TODO strange code here, that doesn't work
                        if (e.getButton() == MouseEvent.BUTTON2) 
                        {
                                // selection Exists:
                                if (!selectedText.equals(""))
                                {
                                        if (popUpLogger.isLoggable(Level.FINER)) {
                                                popUpLogger.finer(e.getX() + " " + e.getY());
                                        }
                                        if (selectedText.length()<5)
                                                if (treeCbMenuItem.isSelected())
                                                        parseField.setBounds(e.getX()+(int)Math.round(tree.getBounds().getWidth()), e.getY()+80, 400, 40);
                                                else
                                                        parseField.setBounds(e.getX(), e.getY()+80, 400, 40); 
                                        else
                                                if (treeCbMenuItem.isSelected())
                                                        parseField.setBounds(e.getX()+(int)Math.round(tree.getBounds().getWidth()), e.getY()+80, selectedText.length()*20, 40);
                                                else
                                                        parseField.setBounds(e.getX(), e.getY()+80, selectedText.length()*20, 40);
                                        getLayeredPane().add(parseField, new Integer(1), 0);  
                                        parseField.setText(selectedText);
                                        parseField.requestFocusInWindow();
                                }
                        }
                }

        }

        /**
         * Encapsulates the opening of terms or linearizations to a file.
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever.
         * @author daniels
         */
        class OpenAction extends AbstractAction {
                public OpenAction() {
                        super("Open", null);
                        putValue(SHORT_DESCRIPTION, "Opens abstract syntax trees or linearizations");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_O));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_O, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        if (saveFc.getChoosableFileFilters().length<2)
                                saveFc.addChoosableFileFilter(new GrammarFilter()); 
                        int returnVal = saveFc.showOpenDialog(GFEditor2.this);
                        if (returnVal == JFileChooser.APPROVE_OPTION) {
                                
                                /* "sending" should be fixed on the GF side:
                                 rbMenuItemLong.setSelected(true);
                                 send("ms long");
                                 rbMenuItemUnTyped.setSelected(true);
                                 send("mt untyped");
                                 selectedMenuLanguage = "Abstract";
                                 rbMenuItemAbs.setSelected(true);
                                 send("ml Abs");
                                 */
                                
                                treeChanged = true; 
                                newObject = true;

                                resetNewCategoryMenu();
                                langMenuModel.resetLanguages();
                                
                                File file = saveFc.getSelectedFile();
                                // opening the file for editing :
                                if (logger.isLoggable(Level.FINER)) logger.finer("opening: "+ file.getPath().replace('\\', File.separatorChar));
                                if (saveTypeGroup.getSelection().getActionCommand().equals("term")) {
                                        if (logger.isLoggable(Level.FINER)) logger.finer(" opening as a term ");
                                        send("open "+ file.getPath().replace('\\', File.separatorChar));         
                                }
                                else {
                                        if (logger.isLoggable(Level.FINER)) logger.finer(" opening as a linearization ");
                                        send("openstring "+ file.getPath().replace('\\', File.separatorChar));
                                }
                                
                                fileString ="";
                                grammar.setText("No Topic          ");
                        }           
                }
        }

        /**
         * Encapsulates the saving of terms or linearizations to a file.
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class SaveAction extends AbstractAction {
                public SaveAction() {
                        super("Save As", null);
                        putValue(SHORT_DESCRIPTION, "Saves either the current linearizations or the AST");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_S));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_S, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        if (saveFc.getChoosableFileFilters().length<2)
                                saveFc.addChoosableFileFilter(new GrammarFilter()); 
                        int returnVal = saveFc.showSaveDialog(GFEditor2.this);
                        if (returnVal == JFileChooser.APPROVE_OPTION) {
                                File file = saveFc.getSelectedFile();
                                if (logger.isLoggable(Level.FINER)) logger.finer("saving as " + file);
                                final String abstractLin = linearizations.get("Abstract").toString();

                                if (saveTypeGroup.getSelection().getActionCommand().equals("term")) {
                                        // saving as a term                                        
                                        writeOutput(abstractLin, file.getPath());
                                } else {
                                        // saving as a linearization:
                                        /** collects the show linearizations */
                                        StringBuffer text = new StringBuffer();
                                        /** if sth. at all is shown already*/
                                        boolean sthAtAll = false;
                                        for (Iterator it = linearizations.keySet().iterator(); it.hasNext();) {
                                                Object key = it.next();
                                                if (!key.equals("Abstract")) {
                                                        if (sthAtAll) {
                                                                text.append("\n\n");
                                                        }
                                                        text.append(linearizations.get(key));
                                                        sthAtAll = true;
                                                }
                                        }
                                        if (sthAtAll) {
                                                writeOutput(text.toString(), file.getPath());
                                                if (logger.isLoggable(Level.FINER)) logger.finer(file + " saved.");
                                        } else {
                                                if (logger.isLoggable(Level.FINER)) logger.warning("no concrete language shown, saving abstract");
                                                writeOutput(abstractLin, file.getPath());
                                                if (logger.isLoggable(Level.FINER)) logger.finer(file + " saved.");
                                        }
                                }
                        }           
                        
                }
        }

        /**
         * Encapsulates adding new languages for the current abstract grammar.
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class ImportAction extends AbstractAction {
                public ImportAction() {
                        super("Add", null);
                        putValue(SHORT_DESCRIPTION, "add another concrete language for the current abstract grammar");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_A));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_A, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        //add another language (Add...)
                                if (fc.getChoosableFileFilters().length<2)
                                        fc.addChoosableFileFilter(new GrammarFilter()); 
                                int returnVal = fc.showOpenDialog(GFEditor2.this);
                                if (returnVal == JFileChooser.APPROVE_OPTION) {
                                        File file = fc.getSelectedFile();

                                        resetNewCategoryMenu();
                                        langMenuModel.resetLanguages();
                                        // importing a new language :
                                        if (logger.isLoggable(Level.FINER)) logger.finer("importing: "+ file.getPath().replace('\\','/'));
                                        fileString ="";
                                        send("i "+ file.getPath().replace('\\',File.separatorChar), false);
                                        readGfinit();
                                        readAndDisplay();
                                }           
                        }
                        
        }

        /**
         * Encapsulates starting over with a new grammar.
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class NewTopicAction extends AbstractAction {
                public NewTopicAction() {
                        super("New Topic", null);
                        putValue(SHORT_DESCRIPTION, "dismiss current editing and load a new grammar");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_T));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_T, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        if (fc.getChoosableFileFilters().length<2)
                                fc.addChoosableFileFilter(new GrammarFilter()); 
                        int returnVal = fc.showOpenDialog(GFEditor2.this);
                        if (returnVal == JFileChooser.APPROVE_OPTION) {
                                int n = JOptionPane.showConfirmDialog(GFEditor2.this,
                                                "This will dismiss the previous editing. Would you like to continue?",
                                                "Starting a new topic", JOptionPane.YES_NO_OPTION);
                                if (n == JOptionPane.YES_OPTION){
                                        File file = fc.getSelectedFile();
                                        // importing a new grammar :                
                                        newObject = false; 
                                        statusLabel.setText(status); 
                                        listModel.clear();
                                        resetTree(tree);
                                        resetNewCategoryMenu();                                        
                                        langMenuModel.resetLanguages();
                                        selectedMenuLanguage = "Abstract";
                                        rbMenuItemShort.setSelected(true);
                                        rbMenuItemUnTyped.setSelected(true);
                                        typedMenuItems = false;
                                        
                                        fileString="";
                                        grammar.setText("No Topic          ");
                                        display = new Display(displayType);
                                        display(true, false);
                                        send(" e "+ file.getPath().replace('\\',File.separatorChar), false);
                                        readInit(null, false);
                                        readAndDisplay();
                                        resetPrintnames(true);
                                }
                        }           
                }
                        
        }

        /**
         * Encapsulates starting over without loading new grammars
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class ResetAction extends AbstractAction {
                public ResetAction() {
                        super("Reset", null);
                        putValue(SHORT_DESCRIPTION, "discard everything including the loaded grammars");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_R));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_R, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                                newObject = false; 
                                statusLabel.setText(status); 
                                listModel.clear();
                                resetTree(tree);
                                langMenuModel.resetLanguages();
                                resetNewCategoryMenu();
                                selectedMenuLanguage = "Abstract";
                                
                                rbMenuItemShort.setSelected(true);
                                rbMenuItemUnTyped.setSelected(true);
                                typedMenuItems = false;
                                
                                fileString="";
                                grammar.setText("No Topic          ");
                                send("e", false);
                                readGfinit();
                }
                        
        }

        /**
         * Encapsulates exiting the program
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class QuitAction extends AbstractAction {
                public QuitAction() {
                        super("Quit", null);
                        putValue(SHORT_DESCRIPTION, "exit the editor");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_Q));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_Q, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        endProgram();
                }
                        
        }

        /**
         * Encapsulates the random command for GF
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class RandomAction extends AbstractAction {
                public RandomAction() {
                        super("Random", null);
                        putValue(SHORT_DESCRIPTION, "build a random AST from the current cursor position");
                        //putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_M));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_M, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        treeChanged = true;
                        send("a");
                }
                        
        }
        
        /**
         * Encapsulates the undo command for GF
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class UndoAction extends AbstractAction {
                public UndoAction() {
                        super("Undo", null);
                        putValue(SHORT_DESCRIPTION, "undo the last command");
                        //putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_U));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_U, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        treeChanged = true;
                        send("u");
                }
        }       

        /**
         * Encapsulates alpha command for GF
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class AlphaAction extends AbstractAction {
                public AlphaAction() {
                        super("Alpha", null);
                        putValue(SHORT_DESCRIPTION, "Performing alpha-conversion, rename bound variables");
                        //putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_P));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_P, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        String s = JOptionPane.showInputDialog("Type string:", alphaInput);
                        if (s!=null) {
                                alphaInput = s;
                                treeChanged = true; 
                                send("x "+s);
                        }      
                }
                        
        }
        
        /**
         * Encapsulates the input dialog and sending of arbitrary commands to GF
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class GfCommandAction extends AbstractAction {
                public GfCommandAction() {
                        super("GF command", null);
                        putValue(SHORT_DESCRIPTION, "send a command to GF");
                        //putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_G));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_G, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        String s = JOptionPane.showInputDialog("Command:", commandInput);
                        if (s!=null) {
                                commandInput = s;
                                //s = "gf "+s; This is for debugging, otherwise shift the comment to the next line.
                                treeChanged = true; 
                                if (logger.isLoggable(Level.FINER)) logger.finer("sending: "+ s);
                                send(s);
                        }                }
                        
        }     
        
        /**
         * Encapsulates the showing of the read dialog
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class ReadAction extends AbstractAction {
                public ReadAction() {
                        super("Read", null);
                        putValue(SHORT_DESCRIPTION, "Refining with term or linearization from typed string or file");
                        //putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_E));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_E, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        readDialog.show();
                }
                        
        }
        
        /**
         * Encapsulates the splitting of the main window
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class SplitAction extends AbstractAction {
                public SplitAction() {
                        super("Split Windows", null);
                        putValue(SHORT_DESCRIPTION, "Splits the refinement menu into its own window");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_L));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_L, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        coverPanel.remove(centerPanel);
                        centerPanel2.add(middlePanelUp, BorderLayout.SOUTH);
                        if (((JCheckBoxMenuItem)viewMenu.getItem(0)).isSelected()) {             
                                centerPanel2.add(treePanel, BorderLayout.CENTER);
                        }
                        else {
                                centerPanel2.add(outputPanelUp, BorderLayout.CENTER);
                        } 
                        coverPanel.add(centerPanel2, BorderLayout.CENTER);                 
                        gui2.getContentPane().add(refinementListsContainer);
                        gui2.setVisible(true);
                        pack();
                        repaint();
                }
                        
        }

        /**
         * Encapsulates the combining of the main window
         * Is not local in initializeGUI because jswat cannot have active breakpoints in such a class, whyever. 
         * @author daniels
         */
        class CombineAction extends AbstractAction {
                public CombineAction() {
                        super("One Window", null);
                        putValue(SHORT_DESCRIPTION, "Refinement menu and linearization areas in one window");
                        putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_W));
                        putValue(ACCELERATOR_KEY, KeyStroke.getKeyStroke(KeyEvent.VK_W, ActionEvent.CTRL_MASK));
                }
                
                public void actionPerformed(ActionEvent e) {
                        coverPanel.remove(centerPanel2);  
                        middlePanel.add(middlePanelUp, BorderLayout.NORTH);
                        if (((JCheckBoxMenuItem)viewMenu.getItem(0)).isSelected()) {                         gui2.setVisible(false);
                        centerPanel.setLeftComponent(treePanel);
                        }
                        else {
                                centerPanel.setLeftComponent(outputPanelUp);
                                gui2.setVisible(false);
                        } 
                        coverPanel.add(centerPanel, BorderLayout.CENTER);
                        centerPanelDown.add(refinementListsContainer, BorderLayout.CENTER);
                        centerPanelDown.add(refinementSubcatPanel, BorderLayout.EAST);
                        pack();
                        repaint();
                }
                        
        }

        
        /**
         * Takes care, which classes are present and which states they have.
         * @author daniels
         */
        class LangMenuModel {
                Logger menuLogger = Logger.getLogger("de.uka.ilkd.key.ocl.gf.GFEditor2.MenuModel");
                /**
                 * Just a mutable tuple of language name and whether this language
                 * is displayed or not. 
                 */
                class LangActiveTuple {
                        String lang;
                        boolean active;
                        public LangActiveTuple(String lang, boolean active) {
                                this.lang = lang;
                                this.active = active;
                        }
                        public String toString() {
                                return lang + " : " + active;
                        }
                }
                
                private Vector languages = new Vector();
                /** the group containing RadioButtons for the language the menus 
                 * should have 
                 */
                private ButtonGroup languageGroup = new ButtonGroup();
                
                void updateMenus() {
                        for (Iterator it = this.languages.iterator(); it.hasNext(); ) {
                                LangActiveTuple lat = (LangActiveTuple)it.next();
                                boolean alreadyPresent = false;       
                                // language already in the list of available languages?
                                for (int i=0; i<langMenu.getItemCount()-2;i++)        
                                        if ((langMenu.getItem(i) != null) && langMenu.getItem(i).getText().equals(lat.lang)) {
                                                alreadyPresent = true;
                                                break; 
                                        }
                                if (!alreadyPresent) {
                                        //add item to the language list:
                                        JCheckBoxMenuItem cbMenuItem = new JCheckBoxMenuItem(lat.lang);
                                        if (menuLogger.isLoggable(Level.FINER)) menuLogger.finer("menu item: " + lat.lang);   
                                        cbMenuItem.setSelected(lat.active);
                                        cbMenuItem.setActionCommand("lang");
                                        cbMenuItem.addActionListener(this.langDisplayListener);
                                        langMenu.insert(cbMenuItem, langMenu.getItemCount()-2);
                                        
                                        JRadioButtonMenuItem rbMenuItem = new JRadioButtonMenuItem(lat.lang);
                                        rbMenuItem.setActionCommand(lat.lang);
                                        rbMenuItem.addActionListener(this.menuLanguageListener);
                                        languageGroup.add(rbMenuItem);
                                        if (lat.lang.equals(selectedMenuLanguage)) {
                                                if (menuLogger.isLoggable(Level.FINER)) {
                                                        menuLogger.finer("Selecting " + selectedMenuLanguage);
                                                }
                                                rbMenuItem.setSelected(true);
                                        }
                                        mlMenu.add(rbMenuItem);
                                        
                                }
                        }
                        //stolen from fontEverywhere
                        setFontRecursive(langMenu, font, false);
                        setFontRecursive(mlMenu, font, false);
                }
                
                /**
                 * Sets language myLang to myActive.
                 * Does nothing, if myLang is not already there.
                 * @param myLang The name of the language
                 * @param myActive whether the language is displayed or not
                 */
                void setActive(String myLang, boolean myActive) {
                        boolean alreadyThere = false;
                        for (Iterator it = this.languages.iterator(); it.hasNext(); ) {
                                LangActiveTuple current = (LangActiveTuple)it.next();
                                if (current.lang.equals(myLang)) {
                                        current.active = myActive;
                                        alreadyThere = true;
                                }
                        }
                        if (!alreadyThere) {
                                menuLogger.warning(myLang + " not yet known");
                        }
                }
                
                /**
                 * Checks if myLang is already present, and if not,
                 * adds it. In that case, myActive is ignored.
                 * @param myLang The name of the language
                 * @param myActive whether the language is displayed or not
                 */
                void add(String myLang, boolean myActive) {
                        boolean alreadyThere = false;
                        for (Iterator it = this.languages.iterator(); it.hasNext(); ) {
                                LangActiveTuple current = (LangActiveTuple)it.next();
                                if (current.lang.equals(myLang)) {
                                        alreadyThere = true;
                                }
                        }
                        if (!alreadyThere) {
                                if (menuLogger.isLoggable(Level.FINER)) {
                                        menuLogger.finer(myLang + " added");
                                }
                                LangActiveTuple lat = new LangActiveTuple(myLang, myActive);
                                this.languages.add(lat);
                        }
                        updateMenus();
                }
                
                /**
                 * @param myLang The language in question
                 * @return true iff the language is present and set to active,
                 * false otherwise.
                 */
                boolean isLangActive(String myLang) {
                        for (Iterator it = this.languages.iterator(); it.hasNext(); ) {
                                LangActiveTuple current = (LangActiveTuple)it.next();
                                if (current.lang.equals(myLang)) {
                                        return current.active;
                                }
                        }
                        return false;
                }

                /**
                 * initializes a virgin languages menu
                 */
                public LangMenuModel() {
                        resetLanguages();
                }
                
                
                /**
                 * Resets the Languages menu so that it only contains a seperator and the Add button.
                 * Resets the shown menu languages.
                 * Resets the CheckBoxes that display the available languages.
                 */
                void resetLanguages() {
                        langMenu.removeAll();
                        langMenu.addSeparator();
                        JMenuItem fileMenuItem = new JMenuItem(new ImportAction());
                        langMenu.add(fileMenuItem);
                        
                        mlMenu.removeAll();
                        this.languageGroup = new ButtonGroup();
                        this.languages = new Vector();
                        updateMenus();
                }
                
                
                /**
                 * Listens to the language menu RadioButtons and sends the 
                 * menu language changing commands suiting to the respective
                 * button to GF.
                 * Operates on selectedMenuLanguage from GFEditor2.
                 */
                private ActionListener menuLanguageListener = new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                final String action = e.getActionCommand();
                                // must be a menu language
                                selectedMenuLanguage = action;
                                final String sendLang;
                                if (action.equals("Abstract")) {
                                        sendLang = "Abs";
                                } else {
                                        sendLang = action;
                                }
                                if (xmlLogger.isLoggable(Level.FINER)){
                                        xmlLogger.finer("sending "+sendLang);
                                }
                                send("ml " + sendLang);
                                resetPrintnames(true);

                                return;

                        }
                };
                
                /**
                 * listens to the CheckBoxes in the Language menu and switches the 
                 * correspondend languages on or off when the user clicks on them
                 */
                private ActionListener langDisplayListener = new ActionListener() {
                        public void actionPerformed(ActionEvent e) {
                                if (newObject) {
                                        //clear display of text and HTML
                                        display = new Display(displayType);
                                        display(true, true);
                                        formLin();
                                }
                                final String lang = ((JCheckBoxMenuItem)e.getSource()).getText();
                                if (((JCheckBoxMenuItem)e.getSource()).isSelected()){
                                        if (menuLogger.isLoggable(Level.FINER)) {
                                                menuLogger.finer("turning on language '" + lang + "'");
                                        }
                                        setActive(lang, true);
                                        send("on " + lang);
                                }
                                else{
                                        if (menuLogger.isLoggable(Level.FINER)) {
                                                menuLogger.finer("turning off language '" + lang + "'");
                                        }
                                        setActive(lang, false);
                                        send("off " + lang);
                                }
                                return;
                        }
                };
                
                
                
        }

}




