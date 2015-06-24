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
#import "PhraseTranslation.h"
#import "MorphAnalyser.h"
#import "TranslatorStore.h"

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
#import "WebViewController.h"

@interface TranslationTextViewController ()

@property (nonatomic) Translator *translator;
@property (nonatomic, strong) NSMutableArray *inputs;
@property (nonatomic) BOOL isLoadingGrammar;
@property (nonatomic) UIBarButtonItem *leftLanguageButton;
@property (nonatomic) UIBarButtonItem *rightLanguageButton;

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
    
    // Setup keyboard
    self.textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.textInputbar.rightButton setTitle:@"Translate" forState:UIControlStateNormal];
    [self.singleTapGesture addTarget:self action:@selector(didTapTableView:)];
    
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
    ArrowsButton *arrows = [[ArrowsButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
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
    
    // Load grammars
    self.isLoadingGrammar = YES;
    
    [TranslatorStore loadTranslatorWithCompletion:^(Translator *translator) {
        self.translator = translator;
        
        self.isLoadingGrammar = NO;
        [self updateButtonTitles];
        [self textDidUpdate:YES];
        self.textView.userDefinedKeyboardLanguage = self.translator.from.language.bcp;
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.textView.userDefinedKeyboardLanguage = self.translator.from.language.bcp;
}

- (void)goToHelp:(id)sender {
    [self performSegueWithIdentifier:@"helpView" sender:nil];
}

- (void)changeLanguage:(id)sender {
    [self performSegueWithIdentifier:@"ChangeLanguage" sender:sender];
}

- (void)switchLanguage:(id)sender {
    [TranslatorStore switchLanguage:self.translator];
    
    [self updateButtonTitles];
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
        destinattionController.title = ((Translation *)sender).fromText;
        destinattionController.translation = sender;
    } else if ([segue.identifier isEqualToString:@"Info"]) {
        WebViewController *destinationController = (WebViewController *)segue.destinationViewController;
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"help_content" ofType:@"html"];
        NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
        
        destinationController.htmlToRender = htmlString;
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
    
    dispatch_async(dispatch_queue_create("Load grammars",NULL), ^{
        if ([self.translator.previous.language isEqualToLanguage:laguange]) {
            Grammar *temp = getGrammarBlock();
            setGrammarblock(self.translator.previous);
            self.translator.previous = temp;
        } else {
            self.translator.previous = getGrammarBlock();
            setGrammarblock([Grammar loadGrammarFromLanguage:laguange withTranslator:self.translator]);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateButtonTitles];
            self.isLoadingGrammar = NO;
            [self textDidUpdate:YES];
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
    
    NSString *input = self.textView.text;
    NSInteger wordsCount = [input componentsSeparatedByString:@" "].count;
    Translation *newTranslation = (wordsCount == 1 ? (Translation *)[self.translator analysWord:input] : (Translation *)[self.translator translatePhrase:input]);
    
    [self.inputs addObject:newTranslation];
    [self.tableView reloadData];
    
    [newTranslation speak];
    
    // This little trick validates any pending auto-correction or auto-spelling just after hitting the 'Send' button
    [self.textView refreshFirstResponder];
    [super didPressRightButton:sender];
    
    NSIndexPath *bottomIndexPath = [NSIndexPath indexPathForRow:(self.inputs.count*2)-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:bottomIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.inputs.count*2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BOOL isFrom = indexPath.row % 2 == 0;
    NSString *identifier = isFrom ? @"TranslationInput" : @"TranslationOutput";
    
    TranslationTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    PhraseTranslation *translation = self.inputs[indexPath.row/2];
    [cell setCellWithLanguage:translation fromLanguage:isFrom];
    if (!isFrom && translation.toTexts.count) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

#pragma mark - <UITableViewDelegate>


// Uncomment this method to handle the cell selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableView] && indexPath.row % 2 == 1) {
        PhraseTranslation *translation = self.inputs[indexPath.row/2];
        if (translation.toTexts.count > 0) {
            [self performSegueWithIdentifier:@"TranslationOptions" sender:translation];
        }
    }
    if ([tableView isEqual:self.tableView] && indexPath.row % 2 == 0) {
        PhraseTranslation *translation = self.inputs[indexPath.row/2];
        self.textInputbar.textView.text = translation.fromText;
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Gesture method

- (void)didTapTableView:(UIGestureRecognizer *)gesture {
    if (![self.textView isFirstResponder]) {
        CGPoint touchLoaction = [gesture locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchLoaction];
        [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
