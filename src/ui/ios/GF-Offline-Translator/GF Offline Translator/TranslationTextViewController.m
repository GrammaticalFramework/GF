//
//  TranslationTextViewController.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-27.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "TranslationTextViewController.h"

// Models
#import "Translator.h"
#import "Grammar.h"
#import "Language.h"
#import "Translation.h"

// Views
#import "TranslationTextTableViewCell.h"
#import "ArrowsButton.h"
#import "MenuView.h"
#import "SLKTextView+TextInputMode.h"

// Grammatical framework
#import "pgf/pgf.h"
#import "gu/mem.h"
#import "gu/exn.h"
#import "gu/file.h"

// View controllers
#import "LanguagesViewController.h"

@interface TranslationTextViewController ()

@property (nonatomic) Translator *translator;
@property (nonatomic, strong) NSMutableArray *inputs;
@property (nonatomic) BOOL isLoadingGrammar;
@property (nonatomic) UIBarButtonItem *leftLanguageButton;
@property (nonatomic) UIBarButtonItem *rightLanguageButton;
@property (nonatomic) dispatch_queue_t grammarQueue;

@end

@implementation TranslationTextViewController

#pragma mark - Getters

- (NSMutableArray *)inputs {
    if (!_inputs) {
        _inputs = [NSMutableArray new];
    }
    return _inputs;
}

#pragma mark - Initializer

+ (UITableViewStyle)tableViewStyleForCoder:(NSCoder *)decoder {
    return (UITableViewStyleGrouped);
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup translator
    Language *fromLanguage = [[Language alloc] initWithName:@"Swedish" abbreviation:@"Swe" andBcp:@"sv-SE"];
    Language *toLanguage = [[Language alloc] initWithName:@"English" abbreviation:@"Eng" andBcp:@"en-GB"];
    Translator *translator = [[Translator alloc] init];
    
    // Load grammars
    self.grammarQueue = dispatch_queue_create("Load grammars",NULL);
    self.isLoadingGrammar = YES;
    dispatch_async(self.grammarQueue, ^{
        translator.from = [Grammar loadGrammarFromLanguage:fromLanguage withTranslator:translator];
        translator.to = [Grammar loadGrammarFromLanguage:toLanguage withTranslator:translator];
        self.translator = translator;
        
        self.isLoadingGrammar = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateButtonTitles];
        });
    });
    
    // Register cells
    UINib *nib = [UINib nibWithNibName:@"TranslationInputTableViewCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TranslationInput"];
    
    nib = [UINib nibWithNibName:@"TranslationOutputTableViewCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TranslationOutput"];
    
    // Setup buttons
    
    MenuView *menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, 45, 20)];
    menuView.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:menuView];
    
    ArrowsButton *arrows = [[ArrowsButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [arrows addTarget:self action:@selector(switchLanguage:) forControlEvents:UIControlEventTouchUpInside];
    arrows.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *arrowsButton = [[UIBarButtonItem alloc] initWithCustomView:arrows];
    
    self.leftLanguageButton = [[UIBarButtonItem alloc] initWithTitle:@"Loading"
                                                               style:(UIBarButtonItemStylePlain)
                                                              target:self
                                                              action:@selector(changeLanguage:)];
    self.rightLanguageButton = [[UIBarButtonItem alloc] initWithTitle:@"Loading"
                                                               style:(UIBarButtonItemStylePlain)
                                                              target:self
                                                              action:@selector(changeLanguage:)];
    
    
    self.navigationItem.leftBarButtonItems = @[self.leftLanguageButton, arrowsButton, self.rightLanguageButton];
    self.navigationItem.rightBarButtonItem = menuButton;
    
    // Setup table view
    self.tableView.estimatedRowHeight = 89;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.inverted = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.textView.userDefinedKeyboardLanguage = self.translator.from.language.bcp;
}

- (void)changeLanguage:(id)sender {
    [self performSegueWithIdentifier:@"ChangeLanguage" sender:sender];
}

- (void)switchLanguage:(id)sender {
    Grammar *temp = self.translator.from;
    self.translator.from = self.translator.to;
    self.translator.to = temp;
    
    self.leftLanguageButton.title = self.translator.from.language.name;
    self.rightLanguageButton.title = self.translator.to.language.name;
    
    self.textView.userDefinedKeyboardLanguage = self.translator.from.language.bcp;
    [self.textView reloadInputViews];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"ChangeLanguage"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        
        LanguagesViewController *destinattionController = (LanguagesViewController *)navigationController.topViewController;
        BOOL fromLanguage = sender == self.leftLanguageButton;
        
        destinattionController.senderLanguage = fromLanguage ? self.translator.from.language : self.translator.to.language;
        destinattionController.fromLanguage = fromLanguage;
        destinattionController.delegate = self;
    }
}

- (void)updateButtonTitles {
    self.leftLanguageButton.title = self.translator.from.language.name;
    self.rightLanguageButton.title = self.translator.to.language.name;
}

#pragma mark - TranslationTextViewControllerDelegate

- (void)changeFromLanguageToLanguage:(Language *)laguange {
    [self changeLanguage:laguange withSetGrammarBlock:^(Grammar *grammar) {
        self.translator.from = grammar;
    } getGrammarBlock:^Grammar*{
        return self.translator.from;
    }];
}

- (void)changeToLanguageToLanguage:(Language *)laguange {
    [self changeLanguage:laguange withSetGrammarBlock:^(Grammar *grammar) {
        self.translator.to = grammar;
    } getGrammarBlock:^Grammar*{
        return self.translator.to;
    }];
}

- (void)changeLanguage:(Language *)laguange withSetGrammarBlock:(void (^)(Grammar *grammar))setGrammarblock getGrammarBlock:(Grammar*(^)(void))getGrammarBlock {
    self.isLoadingGrammar = YES;
    
    self.leftLanguageButton.title = @"loading";
    self.rightLanguageButton.title = @"loading";
    
    dispatch_async(self.grammarQueue, ^{
        if ([self.translator.previous.language isEqualToLanguage:laguange]) {
            Grammar *temp = self.translator.from;
            setGrammarblock(self.translator.previous);
            self.translator.previous = temp;
        } else {
            self.translator.previous = getGrammarBlock();
            self.translator.from = [Grammar loadGrammarFromLanguage:laguange withTranslator:self.translator];
        }
        self.isLoadingGrammar = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateButtonTitles];
        });
    });
}


#pragma mark - SLKTextViewController Events

- (void)didChangeKeyboardStatus:(SLKKeyboardStatus)status {
    // Notifies the view controller that the keyboard changed status.
    // Calling super does nothing
}

- (void)textWillUpdate {
    // Notifies the view controller that the text will update.
    // Calling super does nothing
    
    [super textWillUpdate];
}

- (void)textDidUpdate:(BOOL)animated {
    // Notifies the view controller that the text did update.
    // Must call super
    
    [super textDidUpdate:animated];
}

- (BOOL)canPressRightButton {
    // Asks if the right button can be pressed
    
    return [super canPressRightButton];
}

- (void)didPressRightButton:(id)sender {
    // Notifies the view controller when the right button's action has been triggered, manually or by using the keyboard return key.
    // Must call super
    Translation *newTranslation = [self.translator translatePhrase:self.textView.text.lowercaseString];
    [self.inputs addObject:newTranslation];
    [self.tableView reloadData];
    
    // This little trick validates any pending auto-correction or auto-spelling just after hitting the 'Send' button
    [self.textView refreshFirstResponder];
    
    [super didPressRightButton:sender];
}



/*
// Uncomment these methods for aditional events
- (void)didPressLeftButton:(id)sender
{
    // Notifies the view controller when the left button's action has been triggered, manually.
 
    [super didPressLeftButton:sender];
}
 
- (void)willRequestUndo
{
    // Notification about when a user did shake the device to undo the typed text
 
    [super willRequestUndo];
}
*/

#pragma mark - SLKTextViewController Edition

/*
// Uncomment these methods to enable edit mode
- (void)didCommitTextEditing:(id)sender
{
    // Notifies the view controller when tapped on the right "Accept" button for commiting the edited text
 
    [super didCommitTextEditing:sender];
}

- (void)didCancelTextEditing:(id)sender
{
    // Notifies the view controller when tapped on the left "Cancel" button
 
    [super didCancelTextEditing:sender];
}
*/

#pragma mark - SLKTextViewController Autocompletion

/*
// Uncomment these methods to enable autocompletion mode
- (BOOL)canShowAutoCompletion
{
    // Asks of the autocompletion view should be shown
 
    return NO;
}

- (CGFloat)heightForAutoCompletionView
{
    // Asks for the height of the autocompletion view
 
    return 0.0;
}
*/


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.inputs.count*2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isFromText = indexPath.row % 2 == 0;
    NSString *identifier = isFromText ? @"TranslationInput" : @"TranslationOutput";
    
    TranslationTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    Translation *translation = self.inputs[indexPath.row/2];
    
    cell.translationTextLabel.text = isFromText ? translation.fromText : translation.toText;
    UIColor *lightBlueColor = [UIColor colorWithRed:0.373 green:0.836 blue:1.000 alpha:1.000];
    cell.translationTextLabel.backgroundColor = isFromText ? lightBlueColor : translation.color;
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

/*
// Uncomment this method to handle the cell selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {

    }
    if ([tableView isEqual:self.autoCompletionView]) {

        [self acceptAutoCompletionWithString:<#@"any_string"#>];
    }
}
*/

@end
