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
#import "ArrowsView.h"
#import "MenuView.h"

// Grammatical framework
#import "pgf/pgf.h"
#import "gu/mem.h"
#import "gu/exn.h"
#import "gu/file.h"

@interface TranslationTextViewController ()

@property (nonatomic) Translator *translator;
@property (nonatomic, strong) NSMutableArray *inputs;
@property (nonatomic) UIBarButtonItem *leftLanguageButton;
@property (nonatomic) UIBarButtonItem *rightLanguageButton;

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
    translator.from = [Grammar loadGrammarFromLanguage:fromLanguage withTranslator:translator];
    translator.to = [Grammar loadGrammarFromLanguage:toLanguage withTranslator:translator];
    
    self.translator = translator;
    
    // Register cells
    UINib *nib = [UINib nibWithNibName:@"TranslationInputTableViewCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TranslationInput"];
    
    nib = [UINib nibWithNibName:@"TranslationOutputTableViewCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TranslationOutput"];
    
    // Setup buttons
    
    MenuView *menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, 45, 20)];
    menuView.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:menuView];
    
    ArrowsView *arrows = [[ArrowsView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [arrows addTarget:self action:@selector(switchLanguage:) forControlEvents:UIControlEventTouchUpInside];
    arrows.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *arrowsButton = [[UIBarButtonItem alloc] initWithCustomView:arrows];
    
    self.leftLanguageButton = [[UIBarButtonItem alloc] initWithTitle:self.translator.from.language.name
                                                               style:(UIBarButtonItemStylePlain)
                                                              target:self
                                                              action:@selector(changeLanguage:)];
    self.rightLanguageButton = [[UIBarButtonItem alloc] initWithTitle:self.translator.to.language.name
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

- (void)changeLanguage:(id)sender {
    [self performSegueWithIdentifier:@"ChangeLanguage" sender:sender];
}

- (void)switchLanguage:(id)sender {
    Grammar *temp = self.translator.from;
    self.translator.from = self.translator.to;
    self.translator.to = temp;
    
    self.leftLanguageButton.title = self.translator.from.language.name;
    self.rightLanguageButton.title = self.translator.to.language.name;
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
