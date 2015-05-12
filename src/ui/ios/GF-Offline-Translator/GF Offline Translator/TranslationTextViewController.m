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
#import "TranslationOptionsViewController.h"

@interface TranslationTextViewController ()

@property (nonatomic) Translator *translator;
@property (nonatomic, strong) NSMutableArray *inputs;
@property (nonatomic) BOOL isLoadingGrammar;
@property (nonatomic) UIBarButtonItem *leftLanguageButton;
@property (nonatomic) UIBarButtonItem *rightLanguageButton;
@property (nonatomic) dispatch_queue_t grammarQueue;

@end

@implementation TranslationTextViewController

#pragma mark - Getters & setters

- (NSMutableArray *)inputs {
    if (!_inputs) {
        _inputs = [NSMutableArray new];
    }
    return _inputs;
}

- (void)setIsLoadingGrammar:(BOOL)isLoadingGrammar {
    _isLoadingGrammar = isLoadingGrammar;
    
    self.leftLanguageButton.enabled = !isLoadingGrammar;
    self.rightLanguageButton.enabled = !isLoadingGrammar;
}

#pragma mark - Initializer

+ (UITableViewStyle)tableViewStyleForCoder:(NSCoder *)decoder {
    return (UITableViewStyleGrouped);
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cells
    UINib *nib = [UINib nibWithNibName:@"TranslationInputTableViewCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TranslationInput"];
    
    nib = [UINib nibWithNibName:@"TranslationOutputTableViewCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TranslationOutput"];
    
    // Setup table view
    self.tableView.estimatedRowHeight = 89;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = YES;
    self.inverted = NO;
    
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
    
    // Setup translator
    Language *fromLanguage = [[Language alloc] initWithName:@"Swedish" abbreviation:@"Swe" bcp:@"sv-SE"];
    Language *toLanguage = [[Language alloc] initWithName:@"English" abbreviation:@"Eng" bcp:@"en-GB"];
    Translator *translator = [[Translator alloc] init];
    
    // Load grammars
    self.grammarQueue = dispatch_queue_create("Load grammars",NULL);
    
    self.isLoadingGrammar = YES;
    
    dispatch_async(self.grammarQueue, ^{
        translator.from = [Grammar loadGrammarFromLanguage:fromLanguage withTranslator:translator];
        translator.to = [Grammar loadGrammarFromLanguage:toLanguage withTranslator:translator];
        self.translator = translator;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.isLoadingGrammar = NO;
            [self updateButtonTitles];
            [self textDidUpdate:YES];
        });
    });
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
    } else if ([segue.identifier isEqualToString:@"TranslationOptions"]) {
        TranslationOptionsViewController *destinattionController = segue.destinationViewController;
        destinattionController.translation = sender;
    }
}

- (void)updateButtonTitles {
    self.leftLanguageButton.title = self.translator.from.language.name;
    self.rightLanguageButton.title = self.translator.to.language.name;
}

#pragma mark - TranslationTextViewControllerDelegate

- (void)changeFromLanguageToLanguage:(Language *)laguange {
    self.leftLanguageButton.title = @"loading";
    [self changeLanguage:laguange withSetGrammarBlock:^(Grammar *grammar) {
        self.translator.from = grammar;
    } getGrammarBlock:^Grammar*{
        return self.translator.from;
    }];
}

- (void)changeToLanguageToLanguage:(Language *)laguange {
    self.rightLanguageButton.title = @"loading";
    [self changeLanguage:laguange withSetGrammarBlock:^(Grammar *grammar) {
        self.translator.to = grammar;
    } getGrammarBlock:^Grammar*{
        return self.translator.to;
    }];
}

- (void)changeLanguage:(Language *)laguange withSetGrammarBlock:(void (^)(Grammar *grammar))setGrammarblock getGrammarBlock:(Grammar*(^)(void))getGrammarBlock {

    self.isLoadingGrammar = YES;
    [self textDidUpdate:YES];
    
    dispatch_async(self.grammarQueue, ^{
        if ([self.translator.previous.language isEqualToLanguage:laguange]) {
            Grammar *temp = self.translator.from;
            setGrammarblock(self.translator.previous);
            self.translator.previous = temp;
        } else {
            self.translator.previous = getGrammarBlock();
            self.translator.from = [Grammar loadGrammarFromLanguage:laguange withTranslator:self.translator];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateButtonTitles];
            [self textDidUpdate:YES];
            self.isLoadingGrammar = NO;
        });
    });
}

#pragma mark - SLKTextViewController Events


- (BOOL)canPressRightButton {
    // Asks if the right button can be pressed
    if (self.isLoadingGrammar) {
        return NO;
    }
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
    
    NSIndexPath *bottomIndexPath = [NSIndexPath indexPathForRow:(self.inputs.count*2)-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:bottomIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

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


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.inputs.count*2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BOOL isFrom = indexPath.row % 2 == 0;
    NSString *identifier = isFrom ? @"TranslationInput" : @"TranslationOutput";
    
    TranslationTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    Translation *translation = self.inputs[indexPath.row/2];
    [cell setCellWithLanguage:translation fromLanguage:isFrom];
    if (!isFrom && translation.toTexts.count) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma mark - <UITableViewDelegate>


// Uncomment this method to handle the cell selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableView] && indexPath.row % 2 == 1) {
        Translation *translation = self.inputs[indexPath.row/2];
        [self performSegueWithIdentifier:@"TranslationOptions" sender:translation];
    }
    if ([tableView isEqual:self.tableView] && indexPath.row % 2 == 0) {
        Translation *translation = self.inputs[indexPath.row/2];
        self.textInputbar.textView.text = translation.fromText;
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
