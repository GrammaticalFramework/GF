//package javaGUI;                                

import java.awt.*;
import java.beans.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.text.*;
import javax.swing.event.*;
import javax.swing.tree.*;
import java.io.*;
import java.util.*;
//import gfWindow.GrammarFilter;

public class GFEditor2 extends JFrame implements ActionListener, CaretListener,
    KeyListener, FocusListener {                        

    private int[] sizes = {14,18,22,26,30};
    private String[] envfonts;
    private Font font;  
    Font[] fontObjs;
    private static int DEFAULT_FONT_SIZE = 14;
    private JComboBox fontList;
    private JLabel fontLabel = new JLabel("   Font: ");
    private JComboBox sizeList;
    private JLabel sizeLabel = new JLabel("   Size: ");

    public JPopupMenu popup2 = new JPopupMenu();
    public JMenuItem menuItem2;
    public static JTextField field = new JTextField("textField!"); 
    public javax.swing.Timer timer2 = new javax.swing.Timer(500, this);
    public MouseEvent m2;
    public static String selectedText="";

    public static boolean debug = false;
    public static boolean debug3 = false;
    public static boolean debug2 = false;
    public static boolean selectionCheck = false;
    public static String focusPosition = "";
    public static String stringToAppend = "";
    public static Vector currentPosition = new Vector();
    public static int selStart = -1;
    public static int selEnd = -1;
    //public static int oldSelStart = 0;
    public static String restString = "";
    public static int currentLength = 0;
    public static int newLength = 0;
    public static int oldLength = 0;
    public static int addedLength = 0;

    public static boolean newObject = false;
    public static boolean finished = false;
    private String parseInput = "";
    private String alphaInput = "";
    private static String status = "status";
    private static String selectedMenuLanguage = "Abstract";
    private static String linearization = "";
    private String termInput = "";    
    private static String outputString = "";
    private static String treeString = "";
    private static String fileString = "";
    public static Vector commands = new Vector();
    public static Vector outputVector = new Vector();
    public static Hashtable nodeTable = new Hashtable();
    JFileChooser fc1 = new  JFileChooser("./");
    JFileChooser fc = new  JFileChooser("./");
    private String [] filterMenu = {"Filter", "identity", 
         "erase", "take100", "text", "code", "latexfile", 
                        "structured", "unstructured" };
    private String [] modifyMenu = {"Modify", "identity","transfer", 
         "compute", "paraphrase", "generate","typecheck", "solve", "context" };
//    private String [] modeMenu = {"Menus", "printname", 
//         "plain", "short", "long", "typed", "untyped" };
    private static String [] newMenu = {"New"};

    private static boolean firstLin = true;
    private static boolean waiting = false;
    public static boolean treeChanged = true;
    private static String result;
    private static BufferedReader fromProc;   
    private static BufferedWriter toProc;
    private static String commandPath = new String("GF");
    private static JTextArea output = new JTextArea();
    public static DefaultListModel listModel= new DefaultListModel();
    private JList list = new JList(listModel);
    private static DynamicTree2 tree = new DynamicTree2();
 
    private JLabel grammar = new JLabel("No topic          ");   
    private JButton save = new JButton("Save");   
    private JButton open = new JButton("Open");   
    private JButton newTopic = new JButton("New Topic");   
    private JButton gfCommand = new JButton("GF command");   
    
    private JButton leftMeta = new JButton("?<");   
    private JButton left = new JButton("<");   
    private JButton top = new JButton("Top");   
    private JButton right = new JButton(">");
    private JButton rightMeta = new JButton(">?");
    private JButton read = new JButton("Read");   
  //  private JButton parse = new JButton("Parse");   
  //  private JButton term = new JButton("Term");   
    private JButton alpha = new JButton("Alpha");   
    private JButton random = new JButton("Random");   
    private JButton undo = new JButton("Undo");   
    private JPanel coverPanel = new JPanel();   
    private JPanel inputPanel = new JPanel();   

    private JPanel inputPanel2 = new JPanel();   
    private JPanel inputPanel3 = new JPanel();   
    private JButton ok = new JButton("OK");   
    private JButton cancel = new JButton("Cancel");   
    private JTextField inputField = new JTextField();   
    private JLabel inputLabel = new JLabel("Read: ");   
    private JButton browse = new JButton("Browse...");
    private ButtonGroup readGroup = new ButtonGroup();
    private JRadioButton termReadButton = new JRadioButton("Term");
    private JRadioButton stringReadButton = new JRadioButton("String");

    private JDialog dialog;
   
    private static JComboBox menu = new JComboBox(newMenu);      
    private JComboBox filter = new JComboBox(filterMenu);   
    private JComboBox modify = new JComboBox(modifyMenu);   
  //  private JComboBox mode = new JComboBox(modeMenu);   

    private JPanel downPanel = new JPanel();
    private JSplitPane treePanel; 
    private JPanel upPanel = new JPanel();
    private JPanel middlePanel = new JPanel();
    private JPanel middlePanelUp = new JPanel();
    private JPanel middlePanelDown = new JPanel();
    private JSplitPane centerPanel;
    private static JFrame gui2 = new JFrame();
    private JPanel centerPanel2= new JPanel();
    private JPanel centerPanelDown = new JPanel();
    private JScrollPane outputPanelDown = new JScrollPane(list); 
    private JScrollPane outputPanelCenter = new JScrollPane(output);
    private JPanel outputPanelUp = new JPanel();
    private JPanel statusPanel = new JPanel();
    private static JLabel statusLabel = new JLabel(status);
    private    Container cp;

    private   static  JMenuBar menuBar= new JMenuBar();;
    private   static  ButtonGroup menuGroup = new ButtonGroup();
    private   JMenu viewMenu= new JMenu("View");
    private   JMenu submenu= new JMenu("language");
    private   JMenu modeMenu= new JMenu("Menus");
    private   static JMenu langMenu= new JMenu("Languages");
    private   static JMenu fileMenu= new JMenu("File");
    private JRadioButtonMenuItem rbMenuItem;
    private JRadioButtonMenuItem rbMenuItemLong;
   // private JRadioButtonMenuItem rbMenuItemAbs;
    private JRadioButtonMenuItem rbMenuItemUnTyped;
    private static JMenuItem fileMenuItem;
    private static JCheckBoxMenuItem cbMenuItem;
    private static JCheckBoxMenuItem treeCbMenuItem;
    private static RadioListener myListener ;     
    private static ButtonGroup group = new ButtonGroup();
    private static ButtonGroup languageGroup = new ButtonGroup();

    public GFEditor2()
    {
        this.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
              endProgram();
            }
        });


        //Add listener to components that can bring up popup menus.
        MouseListener popupListener2 = new PopupListener();
        output.addMouseListener(popupListener2);
        timer2.setRepeats(false);

        setJMenuBar(menuBar);
        setTitle("GF Syntax Editor");
        viewMenu.setToolTipText("View settings");        
        fileMenu.setToolTipText("Main operations");
        langMenu.setToolTipText("Language settings");
        menuBar.add(fileMenu);
        menuBar.add(langMenu);                        
        menuBar.add(viewMenu);
        menuBar.add(modeMenu);

        treeCbMenuItem = new JCheckBoxMenuItem("Tree");
        treeCbMenuItem.setActionCommand("showTree");
        myListener = new RadioListener();     
        treeCbMenuItem.addActionListener(myListener);
        treeCbMenuItem.setSelected(true);
        viewMenu.add(treeCbMenuItem);
        viewMenu.addSeparator();              

        fileMenuItem = new JMenuItem("Open...");
        fileMenuItem.setActionCommand("open");
        fileMenuItem.addActionListener(this);     
        fileMenu.add(fileMenuItem);
        fileMenuItem = new JMenuItem("New Topic...");
        fileMenuItem.setActionCommand("newTopic");
        fileMenuItem.addActionListener(this);     
        fileMenu.add(fileMenuItem);
        fileMenuItem = new JMenuItem("Reset");
        fileMenuItem.setActionCommand("reset");
        fileMenuItem.addActionListener(this);     
        fileMenu.add(fileMenuItem);
        fileMenuItem = new JMenuItem("Save As...");
        fileMenuItem.setActionCommand("save");
        fileMenuItem.addActionListener(this);     
        fileMenu.add(fileMenuItem);
        fileMenu.addSeparator();
        fileMenuItem = new JMenuItem("Exit");
        fileMenuItem.setActionCommand("quit");
        fileMenuItem.addActionListener(this);     
        fileMenu.add(fileMenuItem);

        rbMenuItem = new JRadioButtonMenuItem("One window");
        rbMenuItem.setActionCommand("combine");
        rbMenuItem.addActionListener(myListener);
        rbMenuItem.setSelected(true);
/*        rbMenuItem.setMnemonic(KeyEvent.VK_R);
        rbMenuItem.setAccelerator(KeyStroke.getKeyStroke(
                KeyEvent.VK_1, ActionEvent.ALT_MASK));
        rbMenuItem.getAccessibleContext().setAccessibleDescription(
                "This doesn't really do anything");
*/     
        menuGroup.add(rbMenuItem);
        viewMenu.add(rbMenuItem);

        rbMenuItem = new JRadioButtonMenuItem("Split windows");
        rbMenuItem.setMnemonic(KeyEvent.VK_O);
        rbMenuItem.setActionCommand("split");
        rbMenuItem.addActionListener(myListener);
        menuGroup.add(rbMenuItem);
        viewMenu.add(rbMenuItem);

        modeMenu.add(submenu);
        
       /* rbMenuItemAbs = new JRadioButtonMenuItem("Abstract");
        rbMenuItemAbs.setActionCommand("Abstract");
        rbMenuItemAbs.addActionListener(myListener);
        languageGroup.add(rbMenuItemAbs); 
       */

        modeMenu.addSeparator();              
        menuGroup = new ButtonGroup();
        rbMenuItemLong = new JRadioButtonMenuItem("long");
        rbMenuItemLong.setActionCommand("long");
        rbMenuItemLong.setSelected(true);
        rbMenuItemLong.addActionListener(myListener);
        menuGroup.add(rbMenuItemLong);
        modeMenu.add(rbMenuItemLong);
        rbMenuItem = new JRadioButtonMenuItem("short");
        rbMenuItem.setActionCommand("short");
        rbMenuItem.addActionListener(myListener);
        menuGroup.add(rbMenuItem);
        modeMenu.add(rbMenuItem);
        modeMenu.addSeparator();              
 
        menuGroup = new ButtonGroup();
        rbMenuItem = new JRadioButtonMenuItem("typed");
        rbMenuItem.setActionCommand("typed");
        rbMenuItem.addActionListener(myListener);
        rbMenuItem.setSelected(false);
        menuGroup.add(rbMenuItem);
        modeMenu.add(rbMenuItem);
        rbMenuItemUnTyped = new JRadioButtonMenuItem("untyped");
        rbMenuItemUnTyped.setSelected(true);
        rbMenuItemUnTyped.setActionCommand("untyped");
        rbMenuItemUnTyped.addActionListener(myListener);
        menuGroup.add(rbMenuItemUnTyped);
        modeMenu.add(rbMenuItemUnTyped);

        cp = getContentPane();
        JScrollPane cpPanelScroll = new JScrollPane(coverPanel); 
        cp.add(cpPanelScroll);
        coverPanel.setLayout(new BorderLayout());
        output.setToolTipText("Linearizations' display area");   
        output.addCaretListener(this);
        output.setEditable(false);
        output.setLineWrap(true);
        output.setWrapStyleWord(true);
        output.setSelectionColor(Color.green);
//        output.setSelectionColor(Color.white);
//        output.setFont(new Font("Arial Unicode MS", Font.PLAIN, 17));
        font = new Font(null, Font.PLAIN, DEFAULT_FONT_SIZE);
        output.setFont(font);
        field.setFont(font);
        field.setFocusable(true);
        field.addKeyListener(this);
        field.addFocusListener(this);
//        System.out.println(output.getFont().getFontName());
        gfCommand.setToolTipText("Sending a command to GF");
        read.setToolTipText("Refining with term or linearization from typed string or file");
        modify.setToolTipText("Choosing a linearization method");
        alpha.setToolTipText("Performing alpha-conversion");
        random.setToolTipText("Generating random refinement");
        undo.setToolTipText("Going back to the previous state");
        downPanel.add(gfCommand);
        //downPanel.add(parse);
        //downPanel.add(term);  
        downPanel.add(read);  
        downPanel.add(modify);   
        downPanel.add(alpha);     
        downPanel.add(random);
        downPanel.add(undo);

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
        middlePanelDown.add(new JLabel("Select Action on Subterm"));
        middlePanel.setLayout(new BorderLayout());
        middlePanel.add(middlePanelUp, BorderLayout.NORTH);
        middlePanel.add(middlePanelDown, BorderLayout.CENTER);

        menu.setToolTipText("The list of available categories to start editing");
        open.setToolTipText("Reading both a new environment and an editing object from file. Current editing will be discarded");
        save.setToolTipText("Writing the current editing object to file in the term or text format");
        grammar.setToolTipText("Current Topic");
        newTopic.setToolTipText("Reading a new environment from file. Current editing will be discarded.");
        upPanel.add(grammar);
        upPanel.add(menu);
        upPanel.add(open);
        upPanel.add(save);
        upPanel.add(newTopic);
        upPanel.add(filter);
        
        filter.setToolTipText("Choosing the linearization representation format");
        modeMenu.setToolTipText("Choosing the refinement options' representation");   
        statusLabel.setToolTipText("The current focus type");
        list.setToolTipText("The list of current refinment options");

        GraphicsEnvironment gEnv = GraphicsEnvironment.getLocalGraphicsEnvironment();
        envfonts = gEnv.getAvailableFontFamilyNames();
        fontObjs = new Font[envfonts.length];
	for (int fi = 0; fi < envfonts.length; fi++) {
	    fontObjs[fi] = new Font(envfonts[fi], Font.PLAIN, DEFAULT_FONT_SIZE);
        }
        fontList = new JComboBox(envfonts);
        fontList.addActionListener(this);
        fontList.setToolTipText("Changing font type");

        sizeList = new JComboBox();
        sizeList.setToolTipText("Changing font size");
        for (int i = 0; i<sizes.length; i++)
        {
          sizeList.addItem(new Integer(sizes[i]));    
        }
        sizeList.addActionListener(this);

        fontEveryWhere(font);
      
        upPanel.add(sizeLabel);
        upPanel.add(sizeList);
        upPanel.add(fontLabel);
        upPanel.add(fontList);

        tree.setToolTipText("The abstract syntax tree representation of the current editing object");
        populateTree(tree); 
        outputPanelUp.setLayout(new BorderLayout());
        outputPanelUp.add(outputPanelCenter, BorderLayout.CENTER);
        outputPanelUp.add(statusPanel, BorderLayout.SOUTH);
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
        centerPanelDown.add(middlePanel, BorderLayout.NORTH);
        centerPanelDown.add(outputPanelDown, BorderLayout.CENTER);
        coverPanel.add(centerPanel, BorderLayout.CENTER);
        coverPanel.add(upPanel, BorderLayout.NORTH);
        coverPanel.add(downPanel, BorderLayout.SOUTH);

        list.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);

        MouseListener mouseListener = new MouseAdapter() {
           public void mouseClicked(MouseEvent e) {
             if (e.getClickCount() == 2) {
               listAction(list.locationToIndex(e.getPoint()));
             }
           }
        };
        list.addMouseListener(mouseListener);
        list.addKeyListener(this);
        menu.addActionListener(this);
        save.addActionListener(this);     
        open.addActionListener(this);     
        newTopic.addActionListener(this);
        gfCommand.addActionListener(this);     
        
        filter.addActionListener(this);   
        filter.setMaximumRowCount(9);  
        leftMeta.addActionListener(this);     
        left.addActionListener(this);
     
        menu.setFocusable(false);
        save.setFocusable(false); 
        save.setActionCommand("save");
        open.setFocusable(false); 
        open.setActionCommand("open");
        newTopic.setFocusable(false);
        newTopic.setActionCommand("newTopic");
        gfCommand.setFocusable(false);
        
        filter.setFocusable(false);
        leftMeta.setFocusable(false);
        left.setFocusable(false);  
               
        top.addActionListener(this);     
        right.addActionListener(this);     
        rightMeta.addActionListener(this);     
        //parse.addActionListener(this);     
        //term.addActionListener(this);     
        read.addActionListener(this);     
        modify.addActionListener(this);     
        //mode.addActionListener(this);     
        alpha.addActionListener(this);     
        random.addActionListener(this);     
        undo.addActionListener(this);

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

        output.addKeyListener(tree);            
	setSize(800,600);
	outputPanelUp.setPreferredSize(new Dimension(400,230));
        treePanel.setDividerLocation(0.3);
        nodeTable.put(new TreePath(DynamicTree2.rootNode.getPath()), new Integer(0));
        setVisible(true);

        JRadioButton termButton = new JRadioButton("Term");
        termButton.setActionCommand("term");
        termButton.setSelected(true);  
        JRadioButton linButton = new JRadioButton("Text");
        linButton.setActionCommand("lin");
        // Group the radio buttons.
        group.add(linButton);
        group.add(termButton);
        JPanel buttonPanel = new JPanel();
        buttonPanel.setPreferredSize(new Dimension(70, 70));
        buttonPanel.add(new JLabel("Format:"));
        buttonPanel.add(linButton);
        buttonPanel.add(termButton);
        fc1.setAccessory(buttonPanel);

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
        dialog= new JDialog(this, "Input");
        dialog.setLocationRelativeTo(this);
        dialog.getContentPane().add(inputPanel);
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
        dialog.setSize(350,135);                                          


          try {
            result = fromProc.readLine();
            while(result != null)  {                  
              finished = false;
              if (debug) System.out.println("1 "+result);
              while (result.indexOf("gf")==-1){                          
                outputString +=result+"\n";
                result = fromProc.readLine();
                if (debug) System.out.println("1 "+result);
              }
              appendMarked(outputString, -1,-1);
              while ((result.indexOf("newcat")==-1)&&(result.indexOf("<lin ")==-1)){
                result = fromProc.readLine();
                if (debug) System.out.println("1 "+result);
              }
              if (result.indexOf("<lin ")==-1)
                formNewMenu();                   

              if (!finished) { 

                while ((result.length()==0)||(result.indexOf("<lin ")==-1)) {
                  result = fromProc.readLine();
                  if (result!=null){
                    if (debug) System.out.println("10 "+result);                    
                  }
                  else System.exit(0);
                }
                readLin();
                readTree();
                readMessage();
                if (newObject)
                  formSelectMenu();                 
                else {
                  while(result.indexOf("</menu")==-1) {
                    result = fromProc.readLine();
                     if (debug) System.out.println("12 "+result);                    
                  }
                }
                for (int i=0; i<3; i++){ 
                  result = fromProc.readLine();
                  if (debug) System.out.println("11 "+result);                    
                }                                   
              }
            }           
            appendMarked("*** NOTHING MORE TO READ FROM " + commandPath + "\n", -1,-1);
          } catch (IOException e) {
          System.out.println("Could not read from external process");
        }
   }

    public static void send(String text){
       try {
             output.setText("");
             outputString = ""; 
             if (debug) 
               System.out.println("output cleared\n\n\n");     
             outputVector = new Vector();             
             toProc.write(text, 0, text.length());
             toProc.newLine();
             toProc.flush();
       } catch (IOException e) {
          System.out.println("Could not write to external process");
       }  
    }            

    public void endProgram(){
          send("q");     
          System.exit(0);
    }
                        
    public static void main(String args[])
    { 
        Locale.setDefault(Locale.US);
        try {
            Process extProc = Runtime.getRuntime().exec(args[0]); 
            InputStreamReader isr = new InputStreamReader(
                           extProc.getInputStream(),"UTF8");
                       // extProc.getInputStream());

            fromProc = new BufferedReader (isr);
            String defaultEncoding = isr.getEncoding();
            if (debug) System.out.println("encoding "+defaultEncoding);
            toProc = new BufferedWriter(new OutputStreamWriter(extProc.getOutputStream(),"UTF8"));
            /*  try {
                  UIManager.setLookAndFeel(
                  //UIManager.getSystemLookAndFeelClassName() );         
                  "com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
                } catch (Exception e) { }
            */
            GFEditor2 gui = new GFEditor2();
            
        } catch (IOException e) {
            System.out.println("Could not start " + commandPath);
        }
    }

    public static void formSelectMenu (){
      if (debug) System.out.println("list model changing! ");      
      String s ="";
      try {
        //read item
        result = fromProc.readLine();
        if (debug) System.out.println("8 "+result);
        listModel.clear();
        commands.clear();
        while (result.indexOf("/menu")==-1){
          //read show
          result = fromProc.readLine();
          if (debug) System.out.println("8 "+result);
          while (result.indexOf("/show")==-1){          
            result = fromProc.readLine();
            if (debug) System.out.println("9 "+result);
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
          listModel.addElement(s);
          s="";
          //read /show
          //read send
          result = fromProc.readLine();
          if (debug) System.out.println("8 "+result);
          result = fromProc.readLine();
          if (debug) System.out.println("8 "+result);
          saveCommand();
          // read /item
          result = fromProc.readLine();
          if (debug) System.out.println("8 "+result);
          result = fromProc.readLine();
          if (debug) System.out.println("8 "+result);
        }
     } catch(IOException e){ }
   }

   public static void saveCommand(){
     if (newObject) commands.add(result);
     try {            
        result = fromProc.readLine();             
        if (debug) System.out.println("9 "+result);          
     } catch(IOException e){ }
   }


   public void readLin(){
      try {
        linearization="";  
        linearization += result+"\n";           
        result = fromProc.readLine();
        if (debug) System.out.println("6 "+result);
        while (result.indexOf("/linearization")==-1){       
          linearization += result+"\n";           
          result = fromProc.readLine();
          if (debug) System.out.println("6 "+result);                     
        }
        if (newObject) formLin();     
        result = fromProc.readLine();             
        if (debug) System.out.println("6 "+result);          
     } catch(IOException e){ }
   }

   public static void readTree(){
      try {
        result = fromProc.readLine();
        if (debug) System.out.println("6 "+result);
        while (result.indexOf("/tree")==-1){       
          treeString += result+"\n";           
          result = fromProc.readLine();
          if (debug) System.out.println("6 "+result);                     
        }
        if (treeChanged && (newObject)) {
          formTree(tree); 
          treeChanged = false;  
        } 
        treeString="";                     
        result = fromProc.readLine();             
        if (debug) System.out.println("6 "+result);          
     } catch(IOException e){ }
   }

   public static void readMessage(){
      String s ="";
      try {
        result = fromProc.readLine();
        if (debug) System.out.println("7 "+result);
        while (result.indexOf("/message")==-1){       
          s += result+"\n";           
          result = fromProc.readLine();
          if (debug) System.out.println("7 "+result);                     
        }
        if (s.length()>1)
          appendMarked("-------------"+'\n'+s,-1,-1);  
        result = fromProc.readLine();             
        if (debug) System.out.println("7 "+result);          
     } catch(IOException e){ }
   }
                       
  public void formNewMenu () {
    boolean more = true;
    try {
      result = fromProc.readLine();
      if (debug) System.out.println("2 "+result);

      while (more){
        if (result.indexOf("topic")==-1) {
          menu.addItem(result.substring(6));                       
        } 
        else 
          more = false;
        result = fromProc.readLine();
        if (debug) System.out.println("2 "+result); 
        result = fromProc.readLine();
        if (debug) System.out.println("3 "+result); 
        if (result.indexOf("topic")!=-1) 
          more = false; 
        result = fromProc.readLine();             
        if (debug) System.out.println("4 "+result);       
      }

      grammar.setText(result.substring(4)+"          ");

      result = fromProc.readLine();
      if (debug) System.out.println("2 "+result); 
      result = fromProc.readLine();
      if (debug) System.out.println("3 "+result); 
      result = fromProc.readLine();             
      if (debug) System.out.println("4 "+result);       
  
      more = true;
      while (more){
        if ((result.indexOf("/gfinit")==-1)&&(result.indexOf("lin")==-1)) {         
          //form lang and Menu menu: 
          cbMenuItem = new JCheckBoxMenuItem(result.substring(4));
          if (debug) System.out.println ("menu item: "+result.substring(4));   
          if ((result.substring(4)).equals("Abstract"))
            cbMenuItem.setSelected(false);
          else 
            cbMenuItem.setSelected(true);
          cbMenuItem.setActionCommand("lang");
          cbMenuItem.addActionListener(myListener);
          langMenu.add(cbMenuItem);
/*        
          {
             submenu.add(rbMenuItemAbs);
             if (selectedMenuLanguage.equals("Abstract"))
               rbMenuItemAbs.setSelected(true);
               languageGroup.add(rbMenuItemAbs); 
          }
          else
          {
*/
             rbMenuItem = new JRadioButtonMenuItem(result.substring(4));
             rbMenuItem.setActionCommand(result.substring(4));
             rbMenuItem.addActionListener(myListener);
             languageGroup.add(rbMenuItem);
             if ((result.substring(4)).equals(selectedMenuLanguage))
             {
                if (debug) System.out.println("Selecting "+selectedMenuLanguage);
                rbMenuItem.setSelected(true);
             }

             submenu.add(rbMenuItem);
// }
        } 
        else 
          more = false;
        // read </language>
        result = fromProc.readLine();
        if (debug) System.out.println("2 "+result); 
        // read <language> or </gfinit...>
        result = fromProc.readLine();
        if (debug) System.out.println("3 "+result); 
        if ((result.indexOf("/gfinit")!=-1)||(result.indexOf("lin")!=-1)) 
          more = false; 
        if (result.indexOf("/gfinit")!=-1)
          finished = true;
        // registering the file name:
        if (result.indexOf("language")!=-1) {
          String path = result.substring(result.indexOf('=')+1,
                                         result.indexOf('>')); 
          path =path.substring(path.lastIndexOf('/')+1);
          if (debug) System.out.println("name: "+path);
          fileString +="--" + path +"\n";
          if (path.lastIndexOf('.')!=path.indexOf('.'))
            grammar.setText(path.substring(0,
                 path.indexOf('.')).toUpperCase()+"          ");
        }
        result = fromProc.readLine();             
        if (debug) System.out.println("4 "+result);               
      }
      if (debug) 
        System.out.println("languageGroupElement formed"+ 
                            languageGroup.getButtonCount());                   
      langMenu.addSeparator();
      fileMenuItem = new JMenuItem("Add...");
      fileMenuItem.setActionCommand("import");
      fileMenuItem.addActionListener(this);     
      langMenu.add(fileMenuItem);
      // in order to get back in main in the beggining of while:
      result = fromProc.readLine();
    } catch(IOException e){ }
  }

  public void outputAppend(){
    int i, j, k, l, l2, selectionLength, m=0, n=0;
    if (debug2) 
                System.out.println("INPUT:"+result);
    l = result.indexOf("<focus");
    i=result.indexOf("type=",l);
    j=result.indexOf('>',i);
    l2 = result.indexOf("focus");    
    if (l2!=-1){
      // in case focus tag is cut into two lines:
      if (l==-1) l=l2-7;         
      m=result.indexOf("position",l);
      if (debug2) System.out.println("POSITION START: "+m); 
      n=result.indexOf("]",m);
      if (debug2) System.out.println("POSITION END: "+n); 
      if (debug)
        System.out.println("form Lin1: "+result);
      focusPosition = result.substring(m+9,n+1);
      statusLabel.setText(" "+result.substring(i+5,j));
      //cutting <focus>
      result= result.substring(0,l)+result.substring(j+2);
      i=result.indexOf("/focus",l);
      selectionLength = i-l-1;
      if (debug2) 
        System.out.println("selection length: "+selectionLength);
      j=result.indexOf('>',i);
      k=result.length()-j-1;
      if (debug) System.out.println("form Lin2: "+result);
      
      if (debug)
        System.out.println("char at the previous position"+result.charAt(i-1));
      //cutting </focus>    
      // in case focus tag is cut into two lines:
      if (result.charAt(i-1)!='<') 
        // check if punktualtion marks like . ! ? are at the end of a sentence:
        if (result.charAt(j+1)==' ')
          result= result.substring(0,i-8)+result.substring(j+2);
        else
          result= result.substring(0,i-9)+result.substring(j+1);
      else
        if (result.charAt(j+1)==' ')
          result= result.substring(0,i-1)+result.substring(j+2);
        else
          result= result.substring(0,i-2)+result.substring(j+1);
      j= result.indexOf("<focus");
      l2 = result.indexOf("focus");    
      // in case focus tag is cut into two lines:
      if ((l2!=-1)&&(j==-1)) j=l2-7;

      // appending the resulting string
      // only one focus 
      if (j==-1){
        if (debug2) 
                System.out.println("ONE FOCUS");
        // last space is not included!:
        appendMarked(result+'\n',l,l+selectionLength-2); 
      } 
      //several focuses
      else {
        if (debug2) 
                System.out.println("MANY FOCUSes");
        appendMarked(result.substring(0,j),l,l+selectionLength-2);           
        result = result.substring(j); 
        outputAppend();
      }
      if (debug) System.out.println("form Lin3: "+result);
    }   
    else //no focus at all (message?):
      appendMarked(result+'\n', -1,-1);          
    firstLin=false;
  }

  public void formLin(){
    boolean visible=true; 
    firstLin=true; 
    result = linearization.substring(0,linearization.indexOf('\n'));
    String lin = linearization.substring(linearization.indexOf('\n')+1);
    //extract the language from result
    int ind = result.indexOf('=');
    int ind2 = result.indexOf('>');
    String s = result.substring(ind+1,ind2);
    result = lin.substring(0,lin.indexOf("</lin>"));
    lin = lin.substring(lin.indexOf("</lin>"));
    while (lin.length()>1) {
      //check if the language is on     
      if (!visible) visible = true;       
      // in the list?
      for (int i=0; i<langMenu.getItemCount()-2;i++)        
        if (langMenu.getItem(i).getText().equals(s))
        {
          visible = false;
          break; 
        }
      if (!visible) visible = true;       
      else {
        //add item to the language list:
        cbMenuItem = new JCheckBoxMenuItem(s);
        if (debug) System.out.println ("menu item: "+s);   
        cbMenuItem.setSelected(true);
        cbMenuItem.setActionCommand("lang");
        cbMenuItem.addActionListener(myListener);
        if (langMenu.getItemCount()<2)
          langMenu.add(cbMenuItem, langMenu.getItemCount());  
        else
          langMenu.add(cbMenuItem, langMenu.getItemCount()-2);  

        rbMenuItem = new JRadioButtonMenuItem(s);
        rbMenuItem.setActionCommand(s);
        rbMenuItem.addActionListener(myListener);
        languageGroup.add(rbMenuItem);
        submenu.add(rbMenuItem);

      }
      // selected?
      for (int i=0; i<langMenu.getItemCount()-2;i++)
        if ((langMenu.getItem(i).getText().equals(s))&&
                    !(langMenu.getItem(i).isSelected()) ) {
          visible = false;
          break; 
        }
      if (visible) {   
        if (!firstLin)
          appendMarked("************"+'\n',-1,-1);  
        if (debug) System.out.println("linearization for the language: "+result);
        outputAppend();
      }
      // read </lin>
      lin = lin.substring(lin.indexOf('\n')+1);
      // read lin or 'end'
      if (lin.length()<1) break;
       
      result = lin.substring(0,lin.indexOf('\n'));
      lin = lin.substring(lin.indexOf('\n')+1);
      if (result.indexOf("<lin ")!=-1){
        //extract the language from result
        ind = result.indexOf('=');
        ind2 = result.indexOf('>');
        s = result.substring(ind+1,ind2);
        result = lin.substring(0,lin.indexOf("</lin>"));
        lin = lin.substring(lin.indexOf("</lin>"));
      }  
    }
  }

  public void fontEveryWhere(Font font)
  {                          
        output.setFont(font);  
        field.setFont(font);  
        tree.tree.setFont(font);  
        list.setFont(font);  
        sizeList.setFont(font);  
        popup2.setFont(font);  
        sizeLabel.setFont(font);  
        save.setFont(font);  
        fontList.setFont(font);  
        fontLabel.setFont(font);  
        grammar.setFont(font);  
        open.setFont(font);  
        newTopic.setFont(font);  
        gfCommand.setFont(font);  
        leftMeta.setFont(font);  
        left.setFont(font);  
        top.setFont(font);  
        right.setFont(font);  
        rightMeta.setFont(font);  
        read.setFont(font);  
        alpha.setFont(font);  
        random.setFont(font);  
        undo.setFont(font);  
        ok.setFont(font);  
        cancel.setFont(font);  
        inputLabel.setFont(font);  
        browse.setFont(font);  
        termReadButton.setFont(font);  
        stringReadButton.setFont(font);  
        filter.setFont(font);  
        modify.setFont(font);  
        statusLabel.setFont(font);  
        menuBar.setFont(font);
        menu.setFont(font);  
  
        submenu.setFont(font);  
        recursion(submenu, font);
        modeMenu.setFont(font);  
        recursion(modeMenu, font);
        langMenu.setFont(font);  
        recursion(langMenu, font);
        fileMenu.setFont(font);  
        recursion(fileMenu, font);
        viewMenu.setFont(font);  
        recursion(viewMenu, font);

}

  public void recursion(JMenu subMenu, Font font)
  {  
    for (int i = 0; i<subMenu.getItemCount(); i++)
      { 
        JMenuItem item = subMenu.getItem(i);
        if (item != null) 
        {
          item.setFont(font);
          String name = item.getClass().getName();
          if (debug) System.out.println(name);
        }
      }
  }

  public void actionPerformed(ActionEvent ae)
  {  
    boolean abs = true;
    Object obj = ae.getSource();

    if ( obj == fontList ) {
        font = new Font((String)fontList.getSelectedItem(), Font.PLAIN, ((Integer)sizeList.getSelectedItem()).intValue());
        //output.setFont(font);  
        fontEveryWhere(font);
        if (cbMenuItem!=null) cbMenuItem.setFont(font);  
        if (rbMenuItem!=null) rbMenuItem.setFont(font);  
        if (fileMenuItem!=null) fileMenuItem.setFont(font);  
    }

    if ( obj == sizeList ) {
        font = new Font((String)fontList.getSelectedItem(), Font.PLAIN, ((Integer)sizeList.getSelectedItem()).intValue());
        fontEveryWhere(font);
        if (cbMenuItem!=null) cbMenuItem.setFont(font);  
        if (rbMenuItem!=null) rbMenuItem.setFont(font);  
        if (fileMenuItem!=null) fileMenuItem.setFont(font);  
   }

    if ( obj == menu ) {
      if (!menu.getSelectedItem().equals("New"))           
      { 
        treeChanged = true; 
        send("n " + menu.getSelectedItem());
        newObject = true;
        menu.setSelectedIndex(0);
      }
    }
    if ( obj == filter ) {
      if (!filter.getSelectedItem().equals("Filter"))           
      { 
        send("f " + filter.getSelectedItem());
        filter.setSelectedIndex(0);
      }
    }
    if ( obj == modify ) {
      if (!modify.getSelectedItem().equals("Modify"))           
      { 
        treeChanged = true; 
        send("c " + modify.getSelectedItem());
        modify.setSelectedIndex(0);
      }
    }
    if (obj==timer2){
            if (debug3) System.out.println("changing pop-up menu2!");
            popup2.removeAll();
            for (int i = 0; i<listModel.size() ; i++) 
                addMenuItem(listModel.elementAt(i).toString());
            popup2.show(m2.getComponent(), m2.getX(), m2.getY());
    }

/*    if ( obj == mode ) {
      if (!mode.getSelectedItem().equals("Menus"))           
      {  
        send("o " + mode.getSelectedItem());
        mode.setSelectedIndex(0);              
      }               
    }
*/
    // buttons and menu items: 
    try {
      if (Class.forName("javax.swing.AbstractButton").isInstance(obj)) {
        String name =((AbstractButton)obj).getActionCommand();

        if (name.equals("popupMenuItem")){
           treeChanged = true; 
           send((String)commands.elementAt
               (popup2.getComponentIndex((JMenuItem)(ae.getSource()))));
        }                   

        if ( name.equals("quit")) {
          endProgram();
        }
              
        if ( name.equals("save") ) {
 
          if (fc1.getChoosableFileFilters().length<2)
            fc1.addChoosableFileFilter(new GrammarFilter()); 
          int returnVal = fc1.showSaveDialog(GFEditor2.this);
          if (returnVal == JFileChooser.APPROVE_OPTION) {
            File file = fc1.getSelectedFile();
            if (debug) System.out.println("saving ... ");

            // checking if the abstract syntax is on:
            for (int i=0; i<langMenu.getItemCount()-2;i++)
              if ((langMenu.getItem(i).getText().equals("Abstract"))&&
                 !(langMenu.getItem(i).isSelected()) ) {
                if (debug) System.out.println("No Abstract syntax !!!!");
                  abs = false;
                  break; 
                }

            String text = output.getText();
            int end = text.indexOf("******");

            // saving as a term:
            if (group.getSelection().getActionCommand().equals("term")) {
              if (end !=-1)
                if (abs) {
                 // writeOutput(fileString+text.substring(0, end), file.getPath());
                    writeOutput(text.substring(0, end), file.getPath());
                  abs=true;
                }
                else {
                  int i = linearization.indexOf('\n');
                  int j = linearization.indexOf("/lin");
                  //writeOutput(fileString+linearization.substring(i+1, j-1), file.getPath());
                    writeOutput(linearization.substring(i+1, j-1), file.getPath());
                } 
              else
                JOptionPane.showMessageDialog(this, "No term to save");   
            }  
            // saving as a linearization:
            else  
                // abstract syntax is shown:
                if (abs){
                  end =  text.indexOf('\n', end);
                  //writeOutput(fileString+text.substring(end), file.getPath());
                  writeOutput(text.substring(end), file.getPath());
                  abs = true;
                }
                else
                  //writeOutput(fileString+text, file.getPath());
                  writeOutput(text, file.getPath());
           }           
         }

         if ( name.equals("open") ) {
           if (fc1.getChoosableFileFilters().length<2)
             fc1.addChoosableFileFilter(new GrammarFilter()); 
           int returnVal = fc1.showOpenDialog(GFEditor2.this);
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
              while (1< menu.getItemCount())
              menu.removeItemAt(1);
             langMenu.removeAll();

             AbstractButton ab = null;

           while (languageGroup.getButtonCount()>0)
           {
             for (Enumeration e = languageGroup.getElements(); 
                                      e.hasMoreElements() ;) 
             {
               ab = (AbstractButton)e.nextElement();
               if (debug) System.out.println("more to remove ! "+ab.getText()); 
               languageGroup.remove(ab);
             }
             if (debug) System.out.println("languageGroupElement after import removal "+ 
                            languageGroup.getButtonCount());                   
           }
             submenu.removeAll();


             File file = fc1.getSelectedFile();
	     // opening the file for editing :
             if (debug) System.out.println("opening: "+ file.getPath().replace('\\','/'));
             if (group.getSelection().getActionCommand().equals("term")) {
               if (debug) System.out.println(" opening as a term ");
               send("open "+ file.getPath().replace('\\','/'));         
             }
             else {
               if (debug) System.out.println(" opening as a linearization ");
               send("openstring "+ file.getPath().replace('\\','/'));
             }

             fileString ="";
             grammar.setText("No Topic          ");
           }           
         }

         if ( name.equals("import") ) {
           if (fc.getChoosableFileFilters().length<2)
             fc.addChoosableFileFilter(new GrammarFilter()); 
           int returnVal = fc.showOpenDialog(GFEditor2.this);
           if (returnVal == JFileChooser.APPROVE_OPTION) {
             File file = fc.getSelectedFile();
	     // importing a new language :
             langMenu.removeAll();
             AbstractButton ab = null;
           while (languageGroup.getButtonCount()>0)
           {
             for (Enumeration e = languageGroup.getElements(); 
                                      e.hasMoreElements() ;) 
             {
               ab = (AbstractButton)e.nextElement();
               if (debug) System.out.println("more to remove ! "+ab.getText()); 
               languageGroup.remove(ab);
             }
             if (debug) System.out.println("languageGroupElement after import removal "+ 
                            languageGroup.getButtonCount());                   
           }

            submenu.removeAll();                         
            while (1< menu.getItemCount())
              menu.removeItemAt(1);
            if (debug) System.out.println("importing: "+ file.getPath().replace('\\','/'));

             fileString ="";
             send("i "+ file.getPath().replace('\\','/'));  

           }           
         }
         if ( name.equals("newTopic") ) {
           if (fc.getChoosableFileFilters().length<2)
             fc.addChoosableFileFilter(new GrammarFilter()); 
           int returnVal = fc.showOpenDialog(GFEditor2.this);
           if (returnVal == JFileChooser.APPROVE_OPTION) {
             int n = JOptionPane.showConfirmDialog(this,
               "This will dismiss the previous editing. Would you like to continue?",
                     "Starting a new topic", JOptionPane.YES_NO_OPTION);
             if (n == JOptionPane.YES_OPTION){
               File file = fc.getSelectedFile();
               // importing a new grammar :                
               newObject = false; 
               statusLabel.setText(status); 
               listModel.clear();
               tree.clear();
               populateTree(tree);
            while (1< menu.getItemCount())
              menu.removeItemAt(1);
               langMenu.removeAll();

             AbstractButton ab = null;

           while (languageGroup.getButtonCount()>0)
           {
             for (Enumeration e = languageGroup.getElements(); 
                                      e.hasMoreElements() ;) 
             {
               ab = (AbstractButton)e.nextElement();
               if (debug) System.out.println("more to remove ! "+ab.getText()); 
               languageGroup.remove(ab);
             }
             if (debug) System.out.println("languageGroupElement after import removal "+ 
                            languageGroup.getButtonCount());                   
           }

               selectedMenuLanguage = "Abstract";
               rbMenuItemLong.setSelected(true);
               rbMenuItemUnTyped.setSelected(true);
               submenu.removeAll();
 
               fileString="";
               grammar.setText("No Topic          ");
               send("e "+ file.getPath().replace('\\','/'));
             }
           }           
         }

         if ( obj == gfCommand ){
           String s = JOptionPane.showInputDialog("Command:", parseInput);
           if (s!=null) {
              parseInput = s;
              //s = "gf "+s; This is for debugging, otherwise shift the comment to the next line.
              treeChanged = true; 
            if (debug) System.out.println("sending: "+ s);
              send(s);
           }
        }

        if ( name.equals("reset") ) {
              newObject = false; 
              statusLabel.setText(status); 
              listModel.clear();
              tree.clear();
              populateTree(tree);
            while (1< menu.getItemCount())
              menu.removeItemAt(1);
              langMenu.removeAll();

             AbstractButton ab = null;

           while (languageGroup.getButtonCount()>0)
           {
             for (Enumeration e = languageGroup.getElements(); 
                                      e.hasMoreElements() ;) 
             {
               ab = (AbstractButton)e.nextElement();
               if (debug) System.out.println("more to remove ! "+ab.getText()); 
               languageGroup.remove(ab);
             }
             if (debug) System.out.println("languageGroupElement after import removal "+ 
                            languageGroup.getButtonCount());                   
           }

               selectedMenuLanguage = "Abstract";

               submenu.removeAll();
               rbMenuItemLong.setSelected(true);
               rbMenuItemUnTyped.setSelected(true);

              fileString="";
              grammar.setText("No Topic          ");
              send("e");
        }

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

        if ( obj == cancel ) {
          dialog.hide();
        }

        if ( obj == browse ) {
           if (fc.getChoosableFileFilters().length<2)
             fc.addChoosableFileFilter(new GrammarFilter()); 
           int returnVal = fc.showOpenDialog(GFEditor2.this);
           if (returnVal == JFileChooser.APPROVE_OPTION) {
               File file = fc.getSelectedFile();
               inputField.setText(file.getPath().replace('\\','/'));
           }
        }
     
        if ( obj == ok ) {
           treeChanged = true; 
           if (termReadButton.isSelected()) { 
             termInput = inputField.getText();
             if (termInput.indexOf('/')==-1){
               send("g "+termInput); 
               if (debug) System.out.println("sending term  string");
             }
             else {
               send("tfile "+termInput);                           
               System.out.println("sending file term: "+termInput);          
             }
           }   
           else {
             parseInput = inputField.getText();
             if (parseInput.indexOf('/')==-1){
               send("p "+parseInput);        
               if (debug) System.out.println("sending parse string: "+parseInput);
             }   
             else {
               send("pfile "+parseInput);           
               if (debug) System.out.println("sending file parse string: "+parseInput);        
             }
           }
           dialog.hide();
        }

        if ( obj == read ) {
          if (stringReadButton.isSelected())
            inputField.setText(parseInput);
          else
            inputField.setText(termInput);
          dialog.show();
        }   

/*        if ( obj == term ) {
          inputLabel.setText("Term:");
          inputField.setText(termInput);
          dialog.show();
        }
        if ( obj == parse ) {
          inputLabel.setText("Parse:");
          inputField.setText(parseInput);
          dialog.show();
        }
*/
        if ( obj == alpha){
           String s = JOptionPane.showInputDialog("Type string:", alphaInput);
           if (s!=null) {
               alphaInput = s;
               treeChanged = true; 
               send("x "+s);
           }      
        }
        if ( obj == random){
           treeChanged = true; 
           send("a");
        }
        if ( obj == undo){
           treeChanged = true; 
           send("u");
        }
      }
    } catch (Exception e){}
  }
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
    public static void populateTree(DynamicTree2 treePanel) {
        String p1Name = new String("Root");
        DefaultMutableTreeNode p1;
        p1 = treePanel.addObject(null, p1Name);
    }

    public static void formTree(DynamicTree2 treePanel) {
        Hashtable table = new Hashtable();
        TreePath path=null;
        boolean treeStarted = false, selected = false;  
        String s = treeString;
        String name ="";
        treePanel.clear();
        int j, shift=0, star=0, index = 0;
        DefaultMutableTreeNode p2=null, p1=null;
        if (debug) System.out.print("treeString: "+ s);
        if (s.indexOf('*')!=-1) star = 1; 
        while (s.length()>0) {
            while ((s.length()>0) && ((s.charAt(0)=='*')||(s.charAt(0)==' '))){      
               if (s.charAt(0) == '*') selected = true;
               s = s.substring(1);     
               shift++;  
            }             
            if (s.length()>0) {
               j = s.indexOf("\n");      
               name = s.substring(0, j);     
               index++;
               s = s.substring(j+1);    
               shift = (shift - star)/2;

               p1 = (DefaultMutableTreeNode)table.get(new Integer(shift));
               p2 = treePanel.addObject(p1, name);  
               table.put(new Integer(shift+1), p2);
               path = new TreePath(p2.getPath());
               nodeTable.put(path, new Integer(index));
               if (selected) {                        
                       treePanel.tree.setSelectionPath(path);              
                       treePanel.oldSelection = index;
                       if (debug) System.out.println("new selected index "+ index);
                       selected = false;
               }
               treeStarted=true;               
            }
            shift = 0;
        }
        if ((p2!=null)) {
           treePanel.tree.makeVisible(path); 
           gui2.toFront();
           index = 0;
        }
    }

    /** Listens to the radio buttons. */
    class RadioListener implements ActionListener { 
      public void actionPerformed(ActionEvent e) {
        String action = e.getActionCommand();
        if (action.equals("split") ) {
          coverPanel.remove(centerPanel);
          centerPanel2.add(middlePanelUp, BorderLayout.SOUTH);
          if (((JCheckBoxMenuItem)viewMenu.getItem(0)).isSelected()) {             
            centerPanel2.add(treePanel, BorderLayout.CENTER);
          }
          else {
            centerPanel2.add(outputPanelUp, BorderLayout.CENTER);
          } 
          coverPanel.add(centerPanel2, BorderLayout.CENTER);                 
          gui2.getContentPane().add(outputPanelDown);
          gui2.setVisible(true);
          pack();
          repaint();                                       
        }
        if (action.equals("combine") ) {
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
          centerPanelDown.add(outputPanelDown, BorderLayout.CENTER);
          pack();
          repaint();               
        }

        if (action.equals("showTree") ) {
          if (!((JCheckBoxMenuItem)e.getSource()).isSelected()){
            if (debug) System.out.println("was selected");
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
            if (debug) System.out.println("was not selected");
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
        if (action.equals("lang")) {
          if (newObject) {
            output.setText("");
            formLin();
          }
          if (debug) 
            System.out.println("language option has changed "+((JCheckBoxMenuItem)e.getSource()).getText());
          if (((JCheckBoxMenuItem)e.getSource()).isSelected()){
            if (debug) System.out.println("turning on");
            send("on "+((JCheckBoxMenuItem)e.getSource()).getText());
          }
          else{
            if (debug) System.out.println("turning off");
            send("off "+((JCheckBoxMenuItem)e.getSource()).getText());
          }
        }
        //modeMenus actions:
        else {
          if ((action.equals("long")) || (action.equals("short")))  
            {
                send("ms " + action);
            }
          else 
            if ((action.equals("typed")) || (action.equals("untyped")))  
              {
                send("mt " + action);
              }
            else 
              {
                selectedMenuLanguage = action;
                if (action.equals("Abstract"))
                {
                   send("ml Abs");
                }
                else 
                  if (!action.equals("split")&&!action.equals("combine")&&!action.equals("showTree"))
                  {
                  if (debug) System.out.println("sending "+action);
                  send("ml " + action);
                  }
              }
        }
      }
    }

    /** Handle the key pressed event. */
    public void keyPressed(KeyEvent e) {
        int keyCode = e.getKeyCode();   
        Object obj = e.getSource();
        if  ((keyCode == 10)&&(obj==list)) { 
            listAction(list.getSelectedIndex());
        }
        // Processing Enter:
        if  ((keyCode == 10)&&(obj==field)) { 
           getLayeredPane().remove(field); 
           treeChanged = true;
           send("p "+field.getText());        
           if (debug) System.out.println("sending parse string: "+field.getText());
           repaint();
        }
        // Processing Escape:
        if  ((keyCode == 27)&&(obj==field)) { 
           getLayeredPane().remove(field);   
           repaint();
        }

    }
    /** Handle the key typed event. */
    public void keyTyped(KeyEvent e) {
    }
    /** Handle the key released event. */
    public void keyReleased(KeyEvent e) {
    }

    public String comparePositions(String first, String second)
    {
      String common ="[]";
      int i = 1; 
      while ((i<Math.min(first.length()-1,second.length()-1))&&(first.substring(0,i+1).equals(second.substring(0,i+1))))
      {
        common=first.substring(0,i+1); 
        i+=2;
      }
      if (common.charAt(common.length()-1)==']') 
        return common;
      else 
        return common+"]";
    }
    public String findMax(int begin, int end)
    {
      String max = ((MarkedArea)outputVector.elementAt(begin)).position;
      for (int i = begin+1; i <= end; i++)
        max =  comparePositions(max,((MarkedArea)outputVector.elementAt(i)).position);
      return max;
    }
    public void caretUpdate(CaretEvent e)
    {
     String jPosition ="", iPosition="", position="";
     MarkedArea jElement = null;
     MarkedArea iElement = null;
     int j = 0;
     int i = outputVector.size()-1;
     int start = output.getSelectionStart();
     int end = output.getSelectionEnd();
     if (debug3) 
             System.out.println("SELECTION START POSITION: "+start);
     if (debug3) 
             System.out.println("SELECTION END POSITION: "+end);
     if (debug3) 
       System.out.println("CARET POSITION: "+output.getCaretPosition());
     if ((debug2)&&(end>0&&(end<output.getText().length()))) 
       System.out.println("CHAR: "+output.getText().charAt(end));
     // not null selection:
     if ((i>-1)&&(start<output.getText().length()-1)) 
     {
     if (debug2)
       for (int k=0; k<outputVector.size(); k++)
       { 
         System.out.print("element: "+k+" begin "+((MarkedArea)outputVector.elementAt(k)).begin+" ");
         System.out.print(" end: "+((MarkedArea)outputVector.elementAt(k)).end+" ");       
         System.out.print(" position: "+((MarkedArea)outputVector.elementAt(k)).position+" ");   
         System.out.println(" words: "+((MarkedArea)outputVector.elementAt(k)).words);   
       }
       // localizing end:
       while ((j< outputVector.size())&&(((MarkedArea)outputVector.elementAt(j)).end < end))
         j++;
       // localising start:
       while ((i>=0)&&(((MarkedArea)outputVector.elementAt(i)).begin > start))
         i--;
       if (debug2) 
         System.out.println("i: "+i+" j: "+j);
       if ((j<outputVector.size()))
       {
         jElement = (MarkedArea)outputVector.elementAt(j);
         jPosition = jElement.position;
         // less & before:
         if (i==-1)
         { // less:
           if (end>=jElement.begin)
           {
             iElement = (MarkedArea)outputVector.elementAt(0);
             iPosition = iElement.position;
             if (debug2) 
                System.out.println("Less: "+jPosition+" and "+iPosition);
             position = findMax(0,j);
             if (debug2) 
                System.out.println("SELECTEDTEXT: "+position+"\n");
             treeChanged = true; 
             send("mp "+position);
           }
           // before:
           else 
             if (debug2) 
                System.out.println("BEFORE vector of size: "+outputVector.size());
         }
         // just:
         else
         { 
           iElement = (MarkedArea)outputVector.elementAt(i);
           iPosition = iElement.position;
           if (debug2) 
                System.out.println("SELECTED TEXT Just: "+iPosition +" and "+jPosition+"\n");
           position = findMax(i,j);
           if (debug2) 
                System.out.println("SELECTEDTEXT: "+position+"\n");
           treeChanged = true; 
           send("mp "+position);
         }
       } 
       else 
         // more && after:
         if (i>=0)
         {
           iElement = (MarkedArea)outputVector.elementAt(i);
           iPosition = iElement.position;
           // more
           if (start<=iElement.end)
           { 
             jElement = (MarkedArea)outputVector.elementAt(outputVector.size()-1);
             jPosition = jElement.position;
             if (debug2) 
                System.out.println("MORE: "+iPosition+ " and "+jPosition);
             position = findMax(i,outputVector.size()-1);
             if (debug2) 
                System.out.println("SELECTEDTEXT: "+position+"\n");
             treeChanged = true; 
             send("mp "+position);
        }
           else
             // after:
             if (debug2) 
                System.out.println("AFTER vector of size: "+outputVector.size());
         } 
         else
         // bigger:
         {
           iElement = (MarkedArea)outputVector.elementAt(0);
           iPosition = iElement.position;
           jElement = (MarkedArea)outputVector.elementAt(outputVector.size()-1);
           jPosition = jElement.position;
           if (debug2) 
                System.out.println("BIGGER: "+iPosition +" and "+jPosition+"\n");         
           if (debug2) 
                System.out.println("SELECTEDTEXT: []\n");
           treeChanged = true; 
           send("mp []");
       }
     }//not null selection
    }

    public static void appendMarked(String s, int selectionStart, int selectionEnd)
    { if (s.length()>0)
    {
      if (debug2) 
        System.out.println("STRING: "+s);
      if (debug2) 
        System.out.println("where selection start is: "+selectionStart);
      if (debug2) 
        System.out.println("where selection end is: "+selectionEnd);
      currentLength = 0;
      newLength=0;
      oldLength = output.getText().length();               
      int j, l, l2, n, pos, selStartTotal, selEndTotal, selEndT;
      restString = s;
      int m2, m1;
      String position = "";
//      if ((selectionStart>-1)&&(selectionEnd>=selectionStart))
      if (selectionStart>-1)
      {
        selStart = selectionStart;
        selEnd = selectionEnd;                               
        if (debug2) 
                System.out.println("SELECTION: " + selStart + " "+selEnd+ "TOTAL: "+s.length());
        if (selEnd>selStart)
          selectionCheck = (s.substring(selStart, selEnd).indexOf("<")==-1);
        l = restString.indexOf("<subtree");
        l2 = restString.indexOf("</subtree");
        while ((l2>-1)||(l>-1))
        { 
          if ((l2==-1)||((l<l2)&&(l>-1)))
          {
            j = restString.indexOf(">",l);
            n = restString.indexOf("<",j);
            m1 =  restString.indexOf("[",l);
            m2 = restString.indexOf("]",l);
            //getting position:
            position = restString.substring(m1,m2+1);
            // something before the tag:
            if (l-currentLength>1)
            {
              if (debug2) 
                System.out.println("SOMETHING BEFORE THE TAG");
              if (currentPosition.size()>0)
                register(currentLength, l, (String)currentPosition.elementAt(currentPosition.size()-1));
              else
                register(currentLength, l, "[]");
            }
            // nothing before the tag:
            else 
            {
              if (debug2) 
                System.out.println("NOTHING BEFORE THE TAG");             
              if (n>0)
                register(j+2, n, position);
              else
                register(j+2, restString.length(), position);
              removeSubTreeTag(l,j+1);
            }
            currentLength += newLength ;
          } // l<l2
          else
          { 
            // something before the </subtree> tag:
            if (l2-currentLength>1)
            {
              if (debug2) 
                System.out.println("SOMETHING BEFORE THE </subtree> TAG");
              if (currentPosition.size()>0)
                register(currentLength, l2, (String)currentPosition.elementAt(currentPosition.size()-1));
              else
                register(currentLength, l2, "[]");
              currentLength += newLength ;
            }
            // nothing before the tag:
            else 
              // punctuation after the </subtree> tag:
              if (restString.substring(l2+10,l2+11).trim().length()>0)
              {
                if (debug2) 
                  System.out.println("PUNCTUATION AFTER THE </subtree> TAG");
                if (debug2) System.out.println("STRING: "+restString);
                //cutting the tag first!:
                if (l2>0)
                  removeSubTreeTag(l2-1,l2+9); 
                else
                  removeSubTreeTag(l2,l2+9);
                if (debug2) System.out.println("STRING after cutting the </subtree> tag: "+restString);
                // cutting the space in the last registered component:
                if (outputVector.size()>0)
                {
                   ((MarkedArea)outputVector.elementAt(outputVector.size()-1)).end -=1; 
                   if (currentLength>0) currentLength -=1; 
                }
               if (debug2) System.out.println("currentLength: "+currentLength +" old length " +oldLength);
                // register the punctuation:
                if (currentPosition.size()>0)
                  register(currentLength, currentLength+2, (String)currentPosition.elementAt(currentPosition.size()-1));
                else
                  register(currentLength, currentLength+2, "[]");
                currentLength += newLength ;
              }
              else
                // just cutting the </subtree> tag:
                removeSubTreeTag(l2,l2+10);
          }
          l2 = restString.indexOf("</subtree");
          l = restString.indexOf("<subtree");
//          if (debug2) 
//                System.out.println("/subtree index: "+l2 + "<subtree"+l);
          if (debug2) 
          { 
            //System.out.print("<-POSITION: "+l+" CURRLENGTH: "+currentLength);
            //System.out.println(" STRING: "+restString.substring(currentLength));
          }
        } //while
        if ((selEnd>=selStart)&&(outputVector.size()>0))
        {
          // exclamation sign etc.:
          if (currentLength>selEnd)
           selStartTotal = selStart+oldLength;
          else
           selStartTotal = currentLength+oldLength;
          selEndTotal = selEnd+oldLength;
          selEndT = selEndTotal+1;
          pos = ((MarkedArea)outputVector.elementAt(outputVector.size()-1)).end;
          if (debug2) 
                System.out.print("the last registered position: "+ pos);
          if (debug2) 
                System.out.println(" selStart: "+ selStartTotal+ " selEnd: "+selEndTotal);
          if (selEnd+oldLength>pos)
          {
            addedLength = selEndTotal-selStartTotal+2;
            outputVector.addElement(new MarkedArea(selStartTotal, selEndTotal+1, focusPosition,restString.substring(currentLength))); 
            if (debug2) 
                System.out.println("APPENDING Selection Last:"+restString.substring(currentLength)+
            "Length: "+addedLength+" POSITION: "+selStartTotal + " "+selEndT);
          }
        }
      } //if selectionStart>-1    
      else
      {
        if (debug2) System.out.println("NO SELECTION IN THE TEXT TO BE APPENDED!");
        //cutting tags from previous focuses if any:
        int r = restString.indexOf("</subtree>");
        while (r>-1)
        {
          // check if punktualtion marks like . ! ? are at the end of a sentence:
          if (restString.charAt(r+10)==' ')
            restString = restString.substring(0,r)+restString.substring(r+11);
          else
            restString = restString.substring(0,r)+restString.substring(r+10);
          r = restString.indexOf("</subtree>");
        }
        r = restString.indexOf("<subtree");
        while (r>-1)
        {
          int t = restString.indexOf(">",r);
          if (t<restString.length()-2)
            restString = restString.substring(0,r)+restString.substring(t+2);
          else 
            restString = restString.substring(0,r);
          r = restString.indexOf("<subtree");
        }
      }
      // appending:
      output.append(restString);
      if ((selectionEnd>=selectionStart)&&(selectionStart>-1))
      try {  
        output.getHighlighter().addHighlight(selStart+oldLength, selEnd+oldLength+1, new DefaultHighlighter.DefaultHighlightPainter(Color.green) );
        selectedText = output.getText().substring(selStart+oldLength, selEnd+oldLength+1);
//        output.getHighlighter().addHighlight(selStart+oldLength, selEnd+oldLength+1, new DefaultHighlighter.DefaultHighlightPainter(Color.white) );
      } catch (Exception e) {System.out.println("highlighting problem!");}
    }// s.length()>0
    }



    public static void register(int start, int end, String position)
    {
      oldLength = output.getText().length();
      addedLength = 0;
      int resultCurrent = 0;
      int resultNew = 0;
      newLength = end-start;
      // the tag has some words to register:
      if (newLength>0)
      {
        //focus has a separate position:
        if (selectionCheck&&(selEnd<end))
        { 
          selectionCheck=false;
          if (debug2) 
                System.out.println("SELECTION HAS A SEPARATE POSITION"); 
          // selection Second:
          if (end-selEnd<=3)
            if (selStart-start<=1)
            { // only selection is to register:              
              resultCurrent = currentLength + oldLength ;
              resultNew = newLength + resultCurrent - 1;
              outputVector.addElement(new MarkedArea(resultCurrent, resultNew, focusPosition,restString.substring(selStart,selEnd+2))); 
              if (debug2) 
                System.out.println("APPENDING SelectedZONE ONLy:"+restString.substring(selStart,selEnd+2)+
                "Length: "+newLength+" POSITION: "+resultCurrent + " "+resultNew);
            } 
            else
            {
              // register the rest:
              resultCurrent = currentLength+oldLength;
              resultNew = resultCurrent+ selStart-start -1;
              addedLength = selStart -start; 
              outputVector.addElement(new MarkedArea(resultCurrent, resultNew, position,restString.substring(start,start+addedLength))); 
              if (debug2) 
                System.out.println("APPENDING ZONE First:"+restString.substring(start,start+addedLength)+
              "Length: "+addedLength+" POSITION: "+resultCurrent + " "+resultNew);
              currentLength += addedLength;

              //selection second:
              newLength = selEnd - selStart+2;
              resultCurrent = currentLength+oldLength;
              resultNew = resultCurrent+ newLength -1;
              outputVector.addElement(new MarkedArea(resultCurrent, resultNew, focusPosition,restString.substring(selStart,selEnd+2))); 
              if (debug2) 
                System.out.println("APPENDING SelectedZONE Second:"+restString.substring(selStart,selEnd+2)+
                "Length: "+newLength+" POSITION: "+resultCurrent + " "+resultNew);            
            }
          else
          { // selection first:
            addedLength = selEnd - selStart +2; 
            resultCurrent = currentLength+oldLength;
            resultNew = resultCurrent + addedLength-1;
            outputVector.addElement(new MarkedArea(resultCurrent, resultNew, focusPosition,restString.substring(selStart,selEnd+2))); 
            if (debug2) 
              System.out.println("APPENDING SelectedZONE First:"+restString.substring(selStart,selEnd+2)+
              "Length: "+addedLength+" POSITION: "+resultCurrent + " "+resultNew);
            currentLength += addedLength;
      
            // register the rest:
            newLength = end-selEnd-2;
            resultCurrent = currentLength+oldLength;
            resultNew = resultCurrent + newLength -1;
            outputVector.addElement(new MarkedArea(resultCurrent, resultNew, position,restString.substring(selEnd+2,end))); 
            if (debug2) 
              System.out.println("APPENDING ZONE Second:"+restString.substring(selEnd+2,end)+
              "Length: "+newLength+" POSITION: "+resultCurrent + " "+resultNew);
          }
        }// focus has a separate position
        else 
        {
          resultCurrent = currentLength + oldLength ;
          resultNew = newLength + resultCurrent - 1;
          if (debug2) System.out.println("Start: "+ start + " end: "+end);
          if (debug2) System.out.println("STRING: "+ restString + " which length is: "+restString.length());
          stringToAppend = restString.substring(start,end);
          if (stringToAppend.trim().length()>0)
          {
            outputVector.addElement(new MarkedArea(resultCurrent, resultNew, position,stringToAppend)); 
            if (debug2) 
              System.out.println("APPENDING ZONE:"+stringToAppend+
            "Length: "+newLength+" POSITION: "+resultCurrent + " "+resultNew+" "+position);
          }
          else
            if (debug2) 
              System.out.println("whiteSpaces: "+newLength);         
        } 
      } //some words to register                     
    }

    //updating:
    public static void removeSubTreeTag (int start, int end)
    {
         if (debug2) 
           System.out.println("removing: "+ start +" to "+ end);
         int difference =end-start+1;
         int positionStart, positionEnd;
         if (difference>20)
         {
           positionStart = restString.indexOf("[", start);
           positionEnd = restString.indexOf("]", start);
           currentPosition.addElement(restString.substring(positionStart, positionEnd+1));
         }
         else
           if (currentPosition.size()>0)
             currentPosition.removeElementAt(currentPosition.size()-1);
         if (start>0)
           restString = restString.substring(0,start)+restString.substring(end+1);
         else
           restString = restString.substring(end+1);
         if (selStart > end)
         {  selStart -=difference;
            selEnd -=difference;            
         } 
         else 
           if (selEnd < start) ;
           else selEnd -=difference;            
    }

    public void listAction(int index) {
      if (index == -1) 
        {if (debug) System.out.println("no selection");}
      else {
        treeChanged = true; 
        send((String)commands.elementAt(list.getSelectedIndex()));
      }
    }

 // pop-up menu (adapted from DynamicTree2):
    class PopupListener extends MouseAdapter {
        public void mousePressed(MouseEvent e) {
//            int selStart = tree.getRowForLocation(e.getX(), e.getY());
//            output.setSelectionRow(selStart);
            if (debug3) 
       System.out.println("mouse pressed2: "+output.getSelectionStart()+" "+output.getSelectionEnd());
            //maybeShowPopup(e);
        }

        public void mouseReleased(MouseEvent e) {
            if (debug3) System.out.println("mouse released2!"+output.getSelectionStart()+" "+output.getSelectionEnd());
            maybeShowPopup(e);
        }
    }
    void maybeShowPopup(MouseEvent e) {
      int i=outputVector.size()-1;
      // right click:
      if (e.isPopupTrigger()) {
        m2 = e;
        timer2.start();
      } 
      // middle click    
      if (e.getButton() == MouseEvent.BUTTON2) 
      {
        // selection Exists:
        if (!selectedText.equals(""))
        {
          if (debug3) System.out.println(e.getX() + " " + e.getY());
          if (selectedText.length()<5)
            if (treeCbMenuItem.isSelected())
              field.setBounds(e.getX()+(int)Math.round(tree.getBounds().getWidth()), e.getY()+80, 400, 40);
            else
              field.setBounds(e.getX(), e.getY()+80, 400, 40); 
          else
            if (treeCbMenuItem.isSelected())
              field.setBounds(e.getX()+(int)Math.round(tree.getBounds().getWidth()), e.getY()+80, selectedText.length()*20, 40);
            else
              field.setBounds(e.getX(), e.getY()+80, selectedText.length()*20, 40);
          getLayeredPane().add(field, new Integer(1), 0);  
          field.setText(selectedText);
          field.requestFocusInWindow();
        }
      }
    }
    void addMenuItem(String name){
                menuItem2 = new JMenuItem(name);
                menuItem2.setFont(font);
                menuItem2.setActionCommand("popupMenuItem");
                menuItem2.addActionListener(this);
                popup2.add(menuItem2);

    }
    public void focusGained(FocusEvent e) 
    {
    }
    public void focusLost(FocusEvent e) 
    {
      getLayeredPane().remove(field);
      repaint();
    }
}
