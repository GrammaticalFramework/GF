//
//  TranslationTextViewController.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-27.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "TranslationTextViewController.h"
#import "TranslationTextTableViewCell.h"
#import "ArrowsButton.h"

@interface TranslationTextViewController ()

@property (nonatomic, strong) NSMutableArray *inputs;

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
    
    // Register cells
    UINib *nib = [UINib nibWithNibName:@"TranslationInputTableViewCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TranslationInput"];
    
    nib = [UINib nibWithNibName:@"TranslationOutputTableViewCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TranslationOutput"];
    
    // Setup title view button
    ArrowsButton *arrows = [[ArrowsButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    self.navigationItem.titleView = arrows;
    
    // Setup table view
    self.tableView.estimatedRowHeight = 89;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.inverted = NO;
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
    [self.inputs addObject:self.textView.text];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = indexPath.row % 2 == 0 ? @"TranslationInput" : @"TranslationOutput";
    
    TranslationTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.translationTextLabel.text = self.inputs[indexPath.row/2];
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
