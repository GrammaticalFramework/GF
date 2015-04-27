//
//   Copyright 2014 Slack Technologies, Inc.
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//

#import "SLKTextViewController.h"
#import "SLKInputAccessoryView.h"
#import "SLKUIConstants.h"

NSString * const SLKKeyboardWillShowNotification =  @"SLKKeyboardWillShowNotification";
NSString * const SLKKeyboardDidShowNotification =   @"SLKKeyboardDidShowNotification";
NSString * const SLKKeyboardWillHideNotification =  @"SLKKeyboardWillHideNotification";
NSString * const SLKKeyboardDidHideNotification =   @"SLKKeyboardDidHideNotification";

@interface SLKTextViewController ()
{
    CGPoint _scrollViewOffsetBeforeDragging;
    CGFloat _keyboardHeightBeforeDragging;
}

// The shared scrollView pointer, either a tableView or collectionView
@property (nonatomic, weak) UIScrollView *scrollViewProxy;

// Auto-Layout height constraints used for updating their constants
@property (nonatomic, strong) NSLayoutConstraint *scrollViewHC;
@property (nonatomic, strong) NSLayoutConstraint *textInputbarHC;
@property (nonatomic, strong) NSLayoutConstraint *typingIndicatorViewHC;
@property (nonatomic, strong) NSLayoutConstraint *autoCompletionViewHC;
@property (nonatomic, strong) NSLayoutConstraint *keyboardHC;

// The keyboard commands available for external keyboards
@property (nonatomic, strong) NSArray *keyboardCommands;

// YES if the user is moving the keyboard with a gesture
@property (nonatomic, assign, getter = isMovingKeyboard) BOOL movingKeyboard;

// The setter of isExternalKeyboardDetected, for private use.
@property (nonatomic, assign) BOOL externalKeyboardDetected;

// The current keyboard status (hidden, showing, etc.)
@property (nonatomic) SLKKeyboardStatus keyboardStatus;

// YES if a new word has been typed recently
@property (nonatomic) BOOL newWordInserted;

// YES if the view controller did appear and everything is finished configurating. This allows blocking some layout animations among other things.
@property (nonatomic) BOOL isViewVisible;

// The setter of isExternalKeyboardDetected, for private use.
@property (nonatomic, getter = isRotating) BOOL rotating;

// The subclass of SLKTextView class to use
@property (nonatomic, strong) Class textViewClass;

@end

@implementation SLKTextViewController
@synthesize tableView = _tableView;
@synthesize collectionView = _collectionView;
@synthesize scrollView = _scrollView;
@synthesize typingIndicatorView = _typingIndicatorView;
@synthesize textInputbar = _textInputbar;
@synthesize autoCompletionView = _autoCompletionView;
@synthesize autoCompleting = _autoCompleting;
@synthesize scrollViewProxy = _scrollViewProxy;
@synthesize presentedInPopover = _presentedInPopover;

#pragma mark - Initializer

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithTableViewStyle:UITableViewStylePlain];
}

- (instancetype)init
{
    return [self initWithTableViewStyle:UITableViewStylePlain];
}

- (instancetype)initWithTableViewStyle:(UITableViewStyle)style
{
    NSAssert([self class] != [SLKTextViewController class], @"Oops! You must subclass SLKTextViewController.");
    
    if (self = [super initWithNibName:nil bundle:nil])
    {
        self.scrollViewProxy = [self tableViewWithStyle:style];
        [self slk_commonInit];
    }
    return self;
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    NSAssert([self class] != [SLKTextViewController class], @"Oops! You must subclass SLKTextViewController.");
    
    if (self = [super initWithNibName:nil bundle:nil])
    {
        self.scrollViewProxy = [self collectionViewWithLayout:layout];
        [self slk_commonInit];
    }
    return self;
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    NSAssert([self class] != [SLKTextViewController class], @"Oops! You must subclass SLKTextViewController.");

    if (self = [super initWithNibName:nil bundle:nil])
    {
        _scrollView = scrollView;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO; // Makes sure the scrollView plays nice with auto-layout

        self.scrollViewProxy = _scrollView;
        [self slk_commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    NSAssert([self class] != [SLKTextViewController class], @"Oops! You must subclass SLKTextViewController.");
    
    if (self = [super initWithCoder:decoder])
    {
        UITableViewStyle tableViewStyle = [[self class] tableViewStyleForCoder:decoder];
        UICollectionViewLayout *collectionViewLayout = [[self class] collectionViewLayoutForCoder:decoder];
        
        if ([collectionViewLayout isKindOfClass:[UICollectionViewLayout class]]) {
            self.scrollViewProxy = [self collectionViewWithLayout:collectionViewLayout];
        }
        else {
            self.scrollViewProxy = [self tableViewWithStyle:tableViewStyle];
        }
        
        [self slk_commonInit];
    }
    return self;
}

- (void)slk_commonInit
{
    [self slk_registerNotifications];
    
    self.bounces = YES;
    self.inverted = YES;
    self.shakeToClearEnabled = NO;
    self.keyboardPanningEnabled = YES;
    self.shouldClearTextAtRightButtonPress = YES;
    self.shouldForceTextInputbarAdjustment = NO;
    self.shouldScrollToBottomAfterKeyboardShows = NO;
}


#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
        
    [self.view addSubview:self.scrollViewProxy];
    [self.view addSubview:self.autoCompletionView];
    [self.view addSubview:self.typingIndicatorView];
    [self.view addSubview:self.textInputbar];
    
    [self slk_setupViewConstraints];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Invalidates this flag when the view appears
    self.textView.didNotResignFirstResponder = NO;
    
    [UIView performWithoutAnimation:^{
        // Reloads any cached text
        [self slk_reloadTextView];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.scrollViewProxy flashScrollIndicators];
    
    self.isViewVisible = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Stops the keyboard from being dismissed during the navigation controller's "swipe-to-pop"
    self.textView.didNotResignFirstResponder = self.isMovingFromParentViewController;
    
    self.isViewVisible = NO;
    
    // Caches the text before it's too late!
    [self slk_cacheTextView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self slk_adjustContentConfigurationIfNeeded];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}


#pragma mark - Getters

+ (UITableViewStyle)tableViewStyleForCoder:(NSCoder *)decoder
{
    return UITableViewStylePlain;
}

+ (UICollectionViewLayout *)collectionViewLayoutForCoder:(NSCoder *)decoder
{
    return nil;
}

- (UITableView *)tableViewWithStyle:(UITableViewStyle)style
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.scrollsToTop = YES;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UICollectionView *)collectionViewWithLayout:(UICollectionViewLayout *)layout
{
    if (!_collectionView)
    {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollsToTop = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (UITableView *)autoCompletionView
{
    if (!_autoCompletionView)
    {
        _autoCompletionView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _autoCompletionView.translatesAutoresizingMaskIntoConstraints = NO;
        _autoCompletionView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
        _autoCompletionView.scrollsToTop = NO;
        _autoCompletionView.dataSource = self;
        _autoCompletionView.delegate = self;
    }
    return _autoCompletionView;
}

- (SLKTextInputbar *)textInputbar
{
    if (!_textInputbar)
    {        
        _textInputbar = [[SLKTextInputbar alloc] initWithTextViewClass:self.textViewClass];
        _textInputbar.translatesAutoresizingMaskIntoConstraints = NO;
        _textInputbar.controller = self;
        
        [_textInputbar.leftButton addTarget:self action:@selector(didPressLeftButton:) forControlEvents:UIControlEventTouchUpInside];
        [_textInputbar.rightButton addTarget:self action:@selector(didPressRightButton:) forControlEvents:UIControlEventTouchUpInside];
        [_textInputbar.editortLeftButton addTarget:self action:@selector(didCancelTextEditing:) forControlEvents:UIControlEventTouchUpInside];
        [_textInputbar.editortRightButton addTarget:self action:@selector(didCommitTextEditing:) forControlEvents:UIControlEventTouchUpInside];
        
        _textInputbar.textView.delegate = self;
        
        _verticalPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slk_didPanTextView:)];
        _verticalPanGesture.delegate = self;
        
        [_textInputbar.textView addGestureRecognizer:self.verticalPanGesture];
    }
    return _textInputbar;
}

- (SLKTypingIndicatorView *)typingIndicatorView
{
    if (!_typingIndicatorView)
    {
        _typingIndicatorView = [SLKTypingIndicatorView new];
        _typingIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        _typingIndicatorView.canResignByTouch = NO;
    }
    return _typingIndicatorView;
}

- (BOOL)isEditing
{
    if (_tableView.isEditing) {
        return YES;
    }
    
    if (self.textInputbar.isEditing) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isExternalKeyboardDetected
{
    return _externalKeyboardDetected;
}

- (BOOL)isPresentedInPopover
{
    return _presentedInPopover && SLK_IS_IPAD;
}

- (SLKTextView *)textView
{
    return self.textInputbar.textView;
}

- (UIButton *)leftButton
{
    return self.textInputbar.leftButton;
}

- (UIButton *)rightButton
{
    return self.textInputbar.rightButton;
}

- (SLKInputAccessoryView *)emptyInputAccessoryView
{
    if (!self.isKeyboardPanningEnabled) {
        return nil;
    }
    
    SLKInputAccessoryView *view = [[SLKInputAccessoryView alloc] initWithFrame:self.textInputbar.bounds];
    view.backgroundColor = [UIColor clearColor];
    view.userInteractionEnabled = NO;
    
#if SLK_INPUT_ACCESSORY_DEBUG
    view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
#endif
    
    return view;
}

- (UIModalPresentationStyle)modalPresentationStyle
{
    if (self.navigationController) {
        return self.navigationController.modalPresentationStyle;
    }
    return [super modalPresentationStyle];
}

- (CGFloat)slk_deltaInputbarHeight
{
    return self.textView.intrinsicContentSize.height-self.textView.font.lineHeight;
}

- (CGFloat)slk_minimumInputbarHeight
{
    return self.textInputbar.intrinsicContentSize.height;
}

- (CGFloat)slk_inputBarHeightForLines:(NSUInteger)numberOfLines
{
    CGFloat height = [self slk_deltaInputbarHeight];
    
    height += roundf(self.textView.font.lineHeight*numberOfLines);
    height += self.textInputbar.contentInset.top+self.textInputbar.contentInset.bottom;
    
    return height;
}

- (CGFloat)slk_appropriateInputbarHeight
{
    CGFloat height = 0.0;
    CGFloat minimumHeight = [self slk_minimumInputbarHeight];
    
    if (self.textView.numberOfLines == 1) {
        height = minimumHeight;
    }
    else if (self.textView.numberOfLines < self.textView.maxNumberOfLines) {
        height = [self slk_inputBarHeightForLines:self.textView.numberOfLines];
    }
    else {
        height = [self slk_inputBarHeightForLines:self.textView.maxNumberOfLines];
    }
    
    if (height < minimumHeight) {
        height = minimumHeight;
    }
    
    if (self.isEditing) {
        height += self.textInputbar.editorContentViewHeight;
    }
    
    return roundf(height);
}

- (CGFloat)slk_appropriateKeyboardHeight:(NSNotification *)notification
{
    CGFloat keyboardHeight = 0.0;

    CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.externalKeyboardDetected = [self slk_detectExternalKeyboardInNotification:notification];
    
    // Always return 0 if an external keyboard has been detected
    if (self.externalKeyboardDetected) {
        return keyboardHeight;
    }
    
    // Convert the main screen bounds into the correct coordinate space but ignore the origin
    CGRect bounds = [self.view convertRect:[UIScreen mainScreen].bounds fromView:nil];
    bounds = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    
    // Need to correctly convert the endframe kicked out for iOS 7
    CGRect endFrameConverted;
    
    if(!SLK_IS_IOS8_AND_HIGHER &&
       (endFrame.size.width == bounds.size.height || endFrame.size.height == bounds.size.width)) {
        endFrameConverted = SLKRectInvert(endFrame);
    }
    else {
        endFrameConverted = endFrame;
    }
    
    // Sets the minimum height of the keyboard
    if (self.isMovingKeyboard) {
        keyboardHeight = bounds.size.height;
        keyboardHeight -= endFrameConverted.origin.y;
    }
    else {
        if ([notification.name isEqualToString:UIKeyboardWillShowNotification] || [notification.name isEqualToString:UIKeyboardDidShowNotification]) {
            keyboardHeight = endFrameConverted.size.height;
        }
        else {
            keyboardHeight = 0.0;
        }
    }
    
    keyboardHeight -= [self slk_appropriateBottomMarginToWindow];
    keyboardHeight -= CGRectGetHeight(self.textView.inputAccessoryView.bounds);
    
    if (keyboardHeight < 0) {
        keyboardHeight = 0.0;
    }
    
    return keyboardHeight;
}

- (CGFloat)slk_appropriateScrollViewHeight
{
    CGFloat height = self.view.bounds.size.height;
    
    height -= self.keyboardHC.constant;
    height -= self.textInputbarHC.constant;
    height -= self.autoCompletionViewHC.constant;
    height -= self.typingIndicatorViewHC.constant;
    
    if (height < 0) return 0;
    else return roundf(height);
}

- (CGFloat)slk_topBarsHeight
{
    // No need to adjust if the edge isn't available
    if ((self.edgesForExtendedLayout & UIRectEdgeTop) == 0) {
        return 0.0;
    }
    
    CGFloat height = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    if (SLK_IS_IPHONE && SLK_IS_LANDSCAPE && SLK_IS_IOS8_AND_HIGHER) {
        return height;
    }
    if (SLK_IS_IPAD && self.modalPresentationStyle == UIModalPresentationFormSheet) {
        return height;
    }
    if (self.isPresentedInPopover) {
        return height;
    }
    
    height += CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    return height;
}

- (CGFloat)slk_appropriateBottomMarginToWindow
{
    // Converts the main screen bounds into the correct coordinate space, but ignore origin
    CGRect bounds = [self.view convertRect:[UIScreen mainScreen].bounds fromView:nil];
    bounds = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    
    CGRect viewRect = self.view.frame;
    
    CGFloat bottomWindow = CGRectGetMaxY(bounds);
    CGFloat bottomView = CGRectGetMaxY(viewRect);
    
    CGFloat bottomMargin = bottomWindow - bottomView;
    
    if (SLK_IS_IPAD && self.modalPresentationStyle == UIModalPresentationFormSheet) {

        // Needs to convert the status bar's frame to the correct coordinate space
        CGFloat statusBarHeight = CGRectGetHeight([self.view convertRect:[UIApplication sharedApplication].statusBarFrame fromView:nil]);
        bottomMargin -= statusBarHeight;
        
        bottomMargin /= 2.0;
        
        if (SLK_IS_LANDSCAPE) {
            bottomMargin += bottomMargin;
        }
        else if (SLK_IS_IOS8_AND_HIGHER) {
            // For some reason in iOS 8 portrait only, we lose 10 pts somewhere
            // haven't worked out why yet. Perhaps a bug?
            bottomMargin += 10;
        }
    }

    // Do NOT consider a status bar height gap
    return (bottomMargin > 20.0) ? bottomMargin : 0.0;
}

- (NSString *)slk_appropriateKeyboardNotificationName:(NSNotification *)notification
{
    NSString *name = notification.name;
    
    if ([name isEqualToString:UIKeyboardWillShowNotification]) {
        return SLKKeyboardWillShowNotification;
    }
    if ([name isEqualToString:UIKeyboardWillHideNotification]) {
        return SLKKeyboardWillHideNotification;
    }
    if ([name isEqualToString:UIKeyboardDidShowNotification]) {
        return SLKKeyboardDidShowNotification;
    }
    if ([name isEqualToString:UIKeyboardDidHideNotification]) {
        return SLKKeyboardDidHideNotification;
    }
    return nil;
}

- (SLKKeyboardStatus)slk_keyboardStatusForNotification:(NSNotification *)notification
{
    NSString *name = notification.name;

    if ([name isEqualToString:UIKeyboardWillShowNotification]) {
        return SLKKeyboardStatusWillShow;
    }
    if ([name isEqualToString:UIKeyboardDidShowNotification]) {
        return SLKKeyboardStatusDidShow;
    }
    if ([name isEqualToString:UIKeyboardWillHideNotification]) {
        return SLKKeyboardStatusWillHide;
    }
    if ([name isEqualToString:UIKeyboardDidHideNotification]) {
        return SLKKeyboardStatusDidHide;
    }
    return -1;
}

- (BOOL)slk_isIllogicalKeyboardStatus:(SLKKeyboardStatus)status
{
    if ((self.keyboardStatus == 0 && status == 1) ||
        (self.keyboardStatus == 1 && status == 2) ||
        (self.keyboardStatus == 2 && status == 3) ||
        (self.keyboardStatus == 3 && status == 0)) {
        return NO;
    }
    return YES;
}


#pragma mark - Setters

- (void)setScrollViewProxy:(UIScrollView *)scrollView
{
    if ([_scrollViewProxy isEqual:scrollView]) {
        return;
    }
    
    _singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(slk_didTapScrollView:)];
    _singleTapGesture.delegate = self;
    [_singleTapGesture requireGestureRecognizerToFail:scrollView.panGestureRecognizer];
    
    [scrollView addGestureRecognizer:self.singleTapGesture];
    
    _scrollViewProxy = scrollView;
}

- (void)setAutoCompleting:(BOOL)autoCompleting
{
    if (_autoCompleting == autoCompleting) {
        return;
    }
    
    _autoCompleting = autoCompleting;
    
    self.scrollViewProxy.scrollEnabled = !autoCompleting;
}

- (void)setInverted:(BOOL)inverted
{
    if (_inverted == inverted) {
        return;
    }
    
    _inverted = inverted;

    self.scrollViewProxy.transform = inverted ? CGAffineTransformMake(1, 0, 0, -1, 0, 0) : CGAffineTransformIdentity;
    self.automaticallyAdjustsScrollViewInsets = inverted ? NO : YES;
}

- (void)setKeyboardPanningEnabled:(BOOL)enabled
{
    if (_keyboardPanningEnabled == enabled) {
        return;
    }
    
    _keyboardPanningEnabled = enabled;
    
    self.scrollViewProxy.keyboardDismissMode = enabled ? UIScrollViewKeyboardDismissModeInteractive : UIScrollViewKeyboardDismissModeNone;
}

- (BOOL)slk_updateKeyboardStatus:(SLKKeyboardStatus)status
{
    // Skips if trying to update the same status
    if (_keyboardStatus == status) {
        return NO;
    }
    
    // Skips illogical conditions
    if ([self slk_isIllogicalKeyboardStatus:status]) {
        return NO;
    }
    
    _keyboardStatus = status;
    
    [self didChangeKeyboardStatus:status];
    
    return YES;
}


#pragma mark - Public & Subclassable Methods

- (void)presentKeyboard:(BOOL)animated
{
    // Skips if already first responder
    if ([self.textView isFirstResponder]) {
        return;
    }
    
    if (!animated) {
        [UIView performWithoutAnimation:^{
            [self.textView becomeFirstResponder];
        }];
    }
    else {
        [self.textView becomeFirstResponder];
    }
}

- (void)dismissKeyboard:(BOOL)animated
{
    if (![self.textView isFirstResponder]) {
        
        // Dismisses the keyboard from any first responder in the window.
        if (self.keyboardHC.constant > 0) {
            [self.view.window endEditing:NO];
        }
        return;
    }
    
    if (!animated)
    {
        [UIView performWithoutAnimation:^{
            [self.textView resignFirstResponder];
        }];
    }
    else {
        [self.textView resignFirstResponder];
    }
}

- (void)didChangeKeyboardStatus:(SLKKeyboardStatus)status
{
    // No implementation here. Meant to be overriden in subclass.
}

- (void)textWillUpdate
{
    // No implementation here. Meant to be overriden in subclass.
}

- (void)textDidUpdate:(BOOL)animated
{
    self.textInputbar.rightButton.enabled = [self canPressRightButton];
    self.textInputbar.editortRightButton.enabled = [self canPressRightButton];
    
    CGFloat inputbarHeight = [self slk_appropriateInputbarHeight];
    
    if (inputbarHeight != self.textInputbarHC.constant)
    {
        self.textInputbarHC.constant = inputbarHeight;
        self.scrollViewHC.constant = [self slk_appropriateScrollViewHeight];
        
        if (animated) {
            
            BOOL bounces = self.bounces && [self.textView isFirstResponder];
            
            [self.view slk_animateLayoutIfNeededWithBounce:bounces
                                                   options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionLayoutSubviews|UIViewAnimationOptionBeginFromCurrentState
                                                animations:^{
                                                    if (self.isEditing) {
                                                        [self.textView slk_scrollToCaretPositonAnimated:NO];
                                                    }
                                                }];
        }
        else {
            [self.view layoutIfNeeded];
        }
    }
    
    // Only updates the input view if the number of line changed
    [self slk_reloadInputAccessoryViewIfNeeded];
    
    // Toggles auto-correction if requiered
    [self slk_enableTypingSuggestionIfNeeded];
}

- (BOOL)canPressRightButton
{
    NSString *text = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (text.length > 0 && ![self.textInputbar limitExceeded]) {
        return YES;
    }
    
    return NO;
}

- (void)didPressLeftButton:(id)sender
{
    // No implementation here. Meant to be overriden in subclass.
}

- (void)didPressRightButton:(id)sender
{
    if (self.shouldClearTextAtRightButtonPress) {
        [self.textView setText:nil];
    }
    
    // Clears cache
    [self clearCachedText];
    
    // Clears the undo manager
    if (self.textView.undoManagerEnabled) {
        [self.textView.undoManager removeAllActions];
    }
}

- (void)editText:(NSString *)text
{
    if (![self.textInputbar canEditText:text]) {
        return;
    }
    
    // Caches the current text, in case the user cancels the edition
    [self slk_cacheTextToDisk:self.textView.text];
    
    if (!SLK_IS_LANDSCAPE) {
        [self.textView setText:text];
    }
    
    [self.textInputbar beginTextEditing];
    
    // Setting the text after calling -beginTextEditing is safer when in landscape orientation
    if (SLK_IS_LANDSCAPE) {
        [self.textView setText:text];
    }
    
    [self.textView slk_scrollToCaretPositonAnimated:YES];
    
    // Brings up the keyboard if needed
    [self presentKeyboard:YES];
}

- (void)didCommitTextEditing:(id)sender
{
    if (!self.isEditing) {
        return;
    }
    
    [self.textInputbar endTextEdition];
    [self.textView setText:nil];
}

- (void)didCancelTextEditing:(id)sender
{
    if (!self.isEditing) {
        return;
    }
    
    [self.textInputbar endTextEdition];
    [self.textView setText:nil];
    
    // Restores any previous cached text before entering in editing mode
    [self slk_reloadTextView];
}

- (BOOL)canShowTypeIndicator
{
    // Don't show if the text is being edited or auto-completed.
    if (self.isEditing || self.isAutoCompleting) {
        return NO;
    }
    
    // Don't show if the content offset is not at top (when inverted) or at bottom (when not inverted)
    if ((self.isInverted && ![self.scrollViewProxy slk_isAtTop]) || (!self.isInverted && ![self.scrollViewProxy slk_isAtBottom])) {
        return NO;
    }
    
    return YES;
}

- (BOOL)canShowAutoCompletion
{
    return NO;
}

- (CGFloat)heightForAutoCompletionView
{
    return 0.0;
}

- (CGFloat)maximumHeightForAutoCompletionView
{
    return 140.0;
}

- (void)didPasteMediaContent:(NSDictionary *)userInfo
{
    // No implementation here. Meant to be overriden in subclass.
}

- (void)willRequestUndo
{
    UIAlertView *alert = [UIAlertView new];
    [alert setTitle:NSLocalizedString(@"Undo Typing", nil)];
    [alert addButtonWithTitle:NSLocalizedString(@"Undo", nil)];
    [alert addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
    [alert setCancelButtonIndex:1];
    [alert setDelegate:self];
    [alert show];
}


#pragma mark - Private Methods

- (void)slk_didTapScrollView:(UIGestureRecognizer *)gesture
{
    if (!self.isPresentedInPopover && !self.isExternalKeyboardDetected) {
        [self dismissKeyboard:YES];
    }
}

- (void)slk_didPanTextView:(UIGestureRecognizer *)gesture
{
    [self presentKeyboard:YES];
}

- (void)slk_performRightAction
{
    NSArray *actions = [self.rightButton actionsForTarget:self forControlEvent:UIControlEventTouchUpInside];
    
    if (actions.count > 0 && [self canPressRightButton]) {
        [self.rightButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)slk_postKeyboarStatusNotification:(NSNotification *)notification
{
    if (self.isExternalKeyboardDetected || self.isRotating) {
        return;
    }
    
    NSMutableDictionary *userInfo = [notification.userInfo mutableCopy];
    
    CGRect beginFrame = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // Fixes iOS7 oddness with inverted values on landscape orientation
    if (!SLK_IS_IOS8_AND_HIGHER && SLK_IS_LANDSCAPE) {
        beginFrame = SLKRectInvert(beginFrame);
        endFrame = SLKRectInvert(endFrame);
    }
    
    CGFloat keyboardHeight = CGRectGetHeight(endFrame)-CGRectGetHeight(self.textView.inputAccessoryView.bounds);
    
    beginFrame.size.height = keyboardHeight;
    endFrame.size.height = keyboardHeight;
    
    [userInfo setObject:[NSValue valueWithCGRect:beginFrame] forKey:UIKeyboardFrameBeginUserInfoKey];
    [userInfo setObject:[NSValue valueWithCGRect:endFrame] forKey:UIKeyboardFrameEndUserInfoKey];
    
    NSString *name = [self slk_appropriateKeyboardNotificationName:notification];
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:self.textView userInfo:userInfo];
}

- (BOOL)slk_scrollToTopIfNeeded
{
    if (!self.scrollViewProxy.scrollsToTop || self.keyboardStatus == SLKKeyboardStatusWillShow) {
        return NO;
    }
    
    if (self.isInverted) {
        [self.scrollViewProxy slk_scrollToTopAnimated:YES];
        return NO;
    }
    else {
        return YES;
    }
}

- (BOOL)slk_scrollToBottomIfNeeded
{
    // Scrolls to bottom only if the keyboard is about to show.
    if (!self.shouldScrollToBottomAfterKeyboardShows || self.keyboardStatus != SLKKeyboardStatusWillShow) {
        return NO;
    }

    if (self.isInverted) {
        [self.scrollViewProxy slk_scrollToTopAnimated:YES];
    }
    else {
        [self.scrollViewProxy slk_scrollToBottomAnimated:YES];
    }
    
    return YES;
}

- (void)slk_enableTypingSuggestionIfNeeded
{
    if (![self.textView isFirstResponder]) {
        return;
    }
    
    BOOL enable = !self.isAutoCompleting;
    
    // During text autocompletion, the iOS 8 QuickType bar is hidden and auto-correction and spell checking are disabled.
    [self.textView setTypingSuggestionEnabled:enable];
}

- (void)slk_dismissTextInputbarIfNeeded
{
    if (self.keyboardHC.constant == 0) {
        return;
    }
    
    self.keyboardHC.constant = 0.0;
    self.scrollViewHC.constant = [self slk_appropriateScrollViewHeight];
    
    [self slk_hideAutoCompletionViewIfNeeded];
    
    // Forces the keyboard status change
    [self slk_updateKeyboardStatus:SLKKeyboardStatusDidHide];
    
    [self.view layoutIfNeeded];
}

- (BOOL)slk_detectExternalKeyboardInNotification:(NSNotification *)notification
{
    if (!self.isMovingKeyboard) {
        // Based on http://stackoverflow.com/a/5760910/287403
        // Ee can determine if the external keyboard is showing by adding the origin.y of the target finish rect
        // (end when showing, begin when hiding) to the inputAccessoryHeight
        // If it's greater(or equal) the window height, it's an external keyboard
        CGFloat inputAccessoryHeight = self.textView.inputAccessoryView.frame.size.height;
        CGRect beginRect = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        CGRect endRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        // Grab the base view for conversions as we don't want window coordinates in < iOS 8
        // iOS 8 fixes the whole coordinate system issue for us, but iOS 7 doesn't rotate the app window coordinate space
        UIView *baseView = ((UIWindow *)self.view.window).rootViewController.view;

        // Convert the main screen bounds into the correct coordinate space but ignore the origin
        CGRect bounds = [self.view convertRect:[UIScreen mainScreen].bounds fromView:nil];
        bounds = CGRectMake(0, 0, bounds.size.width, bounds.size.height);

        // We want these rects in the correct coordinate space as well
        CGRect convertBegin = [baseView convertRect:beginRect fromView:nil];
        CGRect convertEnd = [baseView convertRect:endRect fromView:nil];
        
        if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
            if (convertEnd.origin.y + inputAccessoryHeight >= bounds.size.height) {
                return YES;
            }
        }
        else if ([notification.name isEqualToString:UIKeyboardWillHideNotification]) {
            // The additional logic check here (== to width) accounts for a glitch (iOS 8 only?) where the window has rotated it's coordinates
            // but the beginRect doesn't yet reflect that. It should never cause a false positive
            if (convertBegin.origin.y + inputAccessoryHeight >= bounds.size.height ||
                convertBegin.origin.y + inputAccessoryHeight == bounds.size.width) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)slk_reloadInputAccessoryViewIfNeeded
{
    // Reload only if the input views if the text view is first responder
    if (!self.isKeyboardPanningEnabled || ![self.textView isFirstResponder]) {
        
        // Disables the input accessory when not first responder so when showing the keyboard back, there is no delay in the animation
        if (self.textView.inputAccessoryView) {
            self.textView.inputAccessoryView = nil;
            [self.textView refreshInputViews];
        }
    }
    // Reload only if the input views if the frame doesn't match the text input bar's
    else if (CGRectGetHeight(self.textView.inputAccessoryView.frame) != CGRectGetHeight(self.textInputbar.bounds)) {
        self.textView.inputAccessoryView = [self emptyInputAccessoryView];
        [self.textView refreshInputViews];
    }
}

- (void)slk_adjustContentConfigurationIfNeeded
{
    // When inverted, we need to substract the top bars height (generally status bar + navigation bar's) to align the top of the
    // scrollview correctly to its top edge.
    if (self.inverted) {
        UIEdgeInsets contentInset = self.scrollViewProxy.contentInset;
        contentInset.bottom = [self slk_topBarsHeight];
        
        self.scrollViewProxy.contentInset = contentInset;
        self.scrollViewProxy.scrollIndicatorInsets = contentInset;
    }
    
    // Substracts the bottom edge rect if present. This fixes the text input layout when using inside of a view controller container
    // such as a UITabBarController or a custom container
    if (((self.edgesForExtendedLayout & UIRectEdgeBottom) > 0)) {
        self.edgesForExtendedLayout = self.edgesForExtendedLayout & ~UIRectEdgeBottom;
    }
}

- (void)slk_prepareForInterfaceRotation
{
    [self.view layoutIfNeeded];
    
    if ([self.textView isFirstResponder]) {
        [self.textView slk_scrollToCaretPositonAnimated:NO];
    }
    else {
        [self.textView slk_scrollToBottomAnimated:NO];
    }
}


#pragma mark - Keyboard Events

- (void)didPressReturnKey:(id)sender
{
    if (self.isEditing) {
        [self didCommitTextEditing:sender];
        return;
    }
    
    [self slk_performRightAction];
}

- (void)didPressEscapeKey:(id)sender
{
    if (self.isAutoCompleting) {
        [self cancelAutoCompletion];
    }
    else if (self.isEditing) {
        [self didCancelTextEditing:sender];
    }
    
    if (self.isExternalKeyboardDetected || ([self.textView isFirstResponder] && self.keyboardHC.constant == 0)) {
        return;
    }
    
    [self dismissKeyboard:YES];
}

- (void)didPressArrowKey:(id)sender
{
    [self.textView didPressAnyArrowKey:sender];
}


#pragma mark - Notification Events

- (void)slk_willShowOrHideKeyboard:(NSNotification *)notification
{
    // Skips if the view isn't visible
    if (!self.view.window) {
        return;
    }

    // Skips if it is presented inside of a popover
    if (self.isPresentedInPopover) {
        return;
    }

    // Skips if textview did refresh only
    if (self.textView.didNotResignFirstResponder) {
        return;
    }
    
    // Skips this it's not the expected textView and shouldn't force adjustment of the text input bar.
    // This will also dismiss the text input bar if it's visible, and exit auto-completion mode if enabled.
    if (![self.textView isFirstResponder] && !self.shouldForceTextInputbarAdjustment) {
        return [self slk_dismissTextInputbarIfNeeded];
    }
    
    NSInteger curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    SLKKeyboardStatus status = [self slk_keyboardStatusForNotification:notification];

    // Programatically stops scrolling before updating the view constraints (to avoid scrolling glitch)
    if (status == SLKKeyboardStatusWillShow) {
        [self.scrollViewProxy slk_stopScrolling];
    }
    
    // Hides the auto-completion view if the keyboard is being dismissed
    if (![self.textView isFirstResponder] || status == SLKKeyboardStatusWillHide) {
        [self slk_hideAutoCompletionViewIfNeeded];
    }
    
    // Updates the height constraints' constants
    self.keyboardHC.constant = [self slk_appropriateKeyboardHeight:notification];
    self.scrollViewHC.constant = [self slk_appropriateScrollViewHeight];
    
    // Updates and notifies about the keyboard status update
    if ([self slk_updateKeyboardStatus:status]) {
        // Posts custom keyboard notification, if logical conditions apply
        [self slk_postKeyboarStatusNotification:notification];
    }
    
    // Only for this animation, we set bo to bounce since we want to give the impression that the text input is glued to the keyboard.
    [self.view slk_animateLayoutIfNeededWithDuration:duration
                                              bounce:NO
                                             options:(curve<<16)|UIViewAnimationOptionLayoutSubviews|UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              [self slk_scrollToBottomIfNeeded];
                                          }];
}

- (void)slk_didShowOrHideKeyboard:(NSNotification *)notification
{
    // Skips if the view isn't visible
    if (!self.view.window) {
        return;
    }
    
    // Skips if it is presented inside of a popover
    if (self.isPresentedInPopover) {
        return;
    }
    
    // Skips if textview did refresh only
    if (self.textView.didNotResignFirstResponder) {
        return;
    }
    
    SLKKeyboardStatus status = [self slk_keyboardStatusForNotification:notification];

    // Skips if it's the current status
    if (self.keyboardStatus == status) {
        return;
    }
    
    // After showing keyboard, check if the current cursor position could diplay autocompletion
    if ([self.textView isFirstResponder] && status == SLKKeyboardStatusDidShow && !self.isAutoCompleting) {
        [self slk_processTextForAutoCompletion];
    }
    
    // Updates and notifies about the keyboard status update
    if ([self slk_updateKeyboardStatus:status]) {
        // Posts custom keyboard notification, if logical conditions apply
        [self slk_postKeyboarStatusNotification:notification];
    }
    
    // Updates the dismiss mode and input accessory view, if needed.
    [self slk_reloadInputAccessoryViewIfNeeded];

    // Very important to invalidate this flag after the keyboard is dismissed or presented
    self.movingKeyboard = NO;
}

- (void)slk_didChangeKeyboardFrame:(NSNotification *)notification
{
    // Skips if the view isn't visible
    if (!self.view.window) {
        return;
    }
    
    // Skips if it is presented inside of a popover
    if (self.isPresentedInPopover) {
        return;
    }
    
    // Skips this if it's not the expected textView.
    // Checking the keyboard height constant helps to disable the view constraints update on iPad when the keyboard is undocked.
    // Checking the keyboard status allows to keep the inputAccessoryView valid when still reacing the bottom of the screen.
    if (![self.textView isFirstResponder] || (self.keyboardHC.constant == 0 && self.keyboardStatus == SLKKeyboardStatusDidHide)) {
        return;
    }
    
    if (self.scrollViewProxy.isDragging) {
        self.movingKeyboard = YES;
    }

    if (self.isMovingKeyboard == NO) {
        return;
    }
    
    self.keyboardHC.constant = [self slk_appropriateKeyboardHeight:notification];
    self.scrollViewHC.constant = [self slk_appropriateScrollViewHeight];
    
    // layoutIfNeeded must be called before any further scrollView internal adjustments (content offset and size)
    [self.view layoutIfNeeded];
    
    // Overrides the scrollView's contentOffset to allow following the same position when dragging the keyboard
    CGPoint offset = _scrollViewOffsetBeforeDragging;
    
    if (self.isInverted) {
        if (!self.scrollViewProxy.isDecelerating && self.scrollViewProxy.isTracking) {
            self.scrollViewProxy.contentOffset = _scrollViewOffsetBeforeDragging;
        }
    }
    else {
        CGFloat keyboardHeightDelta = _keyboardHeightBeforeDragging-self.keyboardHC.constant;
        offset.y -= keyboardHeightDelta;
        
        self.scrollViewProxy.contentOffset = offset;
    }
}

- (void)slk_didPostSLKKeyboardNotification:(NSNotification *)notification
{
    if (![notification.object isEqual:self.textView]) {
        return;
    }
    
    // Used for debug only
    NSLog(@"%@ %s: %@", NSStringFromClass([self class]), __FUNCTION__, notification);
}

- (void)slk_willChangeTextViewText:(NSNotification *)notification
{
    // Skips this it's not the expected textView.
    if (![notification.object isEqual:self.textView]) {
        return;
    }
    
    [self textWillUpdate];
}

- (void)slk_didChangeTextViewText:(NSNotification *)notification
{
    // Skips this it's not the expected textView.
    if (![notification.object isEqual:self.textView]) {
        return;
    }
    
    // Animated only if the view already appeared.
    [self textDidUpdate:self.isViewVisible];
}

- (void)slk_didChangeTextViewContentSize:(NSNotification *)notification
{
    // Skips this it's not the expected textView.
    if (![notification.object isEqual:self.textView]) {
        return;
    }
    
    // Animated only if the view already appeared.
    [self textDidUpdate:self.isViewVisible];
}

- (void)slk_didChangeTextViewPasteboard:(NSNotification *)notification
{
    // Skips this if it's not the expected textView.
    if (![self.textView isFirstResponder]) {
        return;
    }
    
    // Notifies only if the pasted item is nested in a dictionary.
    if ([notification.userInfo isKindOfClass:[NSDictionary class]]) {
        [self didPasteMediaContent:notification.userInfo];
    }
}

- (void)slk_didShakeTextView:(NSNotification *)notification
{
    // Skips this if it's not the expected textView.
    if (![self.textView isFirstResponder]) {
        return;
    }
    
    // Notifies of the shake gesture if undo mode is on and the text view is not empty
    if (self.shakeToClearEnabled && self.textView.text.length > 0) {
        [self willRequestUndo];
    }
}

- (void)slk_willShowOrHideTypeIndicatorView:(NSNotification *)notification
{
    SLKTypingIndicatorView *indicatorView = (SLKTypingIndicatorView *)notification.object;
    
    // Skips if it's not the expected typing indicator view.
    if (![indicatorView isEqual:self.typingIndicatorView]) {
        return;
    }
    
    // Skips if the typing indicator should not show. Ignores the checking if it's trying to hide.
    if (![self canShowTypeIndicator] && !self.typingIndicatorView.isVisible) {
        return;
    }
    
    self.typingIndicatorViewHC.constant = indicatorView.isVisible ?  0.0 : indicatorView.intrinsicContentSize.height;
    self.scrollViewHC.constant -= self.typingIndicatorViewHC.constant;
    
    [self.view slk_animateLayoutIfNeededWithBounce:self.bounces
                                           options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionLayoutSubviews|UIViewAnimationOptionBeginFromCurrentState
                                        animations:NULL];
}

- (void)slk_willTerminateApplication:(NSNotification *)notification
{
    // Caches the text before it's too late!
    [self slk_cacheTextView];
}


#pragma mark - Auto-Completion Text Processing

- (void)registerPrefixesForAutoCompletion:(NSArray *)prefixes
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.registeredPrefixes];
    
    for (NSString *prefix in prefixes) {
        // Skips if the prefix is not a valid string
        if (![prefix isKindOfClass:[NSString class]] || prefix.length == 0) {
            continue;
        }
        
        // Adds the prefix if not contained already
        if (![array containsObject:prefix]) {
            [array addObject:prefix];
        }
    }
    
    if (_registeredPrefixes) {
        _registeredPrefixes = nil;
    }
    
    _registeredPrefixes = [[NSArray alloc] initWithArray:array];
}

- (void)slk_processTextForAutoCompletion
{
    if (self.isRotating) {
        return;
    }
    
    // Avoids text processing for auto-completion if the registered prefix list is empty.
    if (self.registeredPrefixes.count == 0) {
        return;
    }
    
    NSString *text = self.textView.text;
    
    // Skip, when o text to process
    if (text.length == 0) {
        return [self cancelAutoCompletion];
    }
    
    NSRange range;
    NSString *word = [self.textView slk_wordAtCaretRange:&range];
    
    [self slk_invalidateAutoCompletion];
    
    for (NSString *prefix in self.registeredPrefixes) {
        
        NSRange keyRange = [word rangeOfString:prefix];
        
        if (keyRange.location == 0 || (keyRange.length >= 1)) {
            
            // Captures the detected symbol prefix
            _foundPrefix = prefix;
            
            // Used later for replacing the detected range with a new string alias returned in -acceptAutoCompletionWithString:
            _foundPrefixRange = NSMakeRange(range.location, prefix.length);
        }
    }
    
    // Forward to the main queue, to be sure it goes into the next run loop
    dispatch_async(dispatch_get_main_queue(), ^{
        [self slk_handleProcessedWord:word range:range];
    });
}

- (void)slk_handleProcessedWord:(NSString *)word range:(NSRange)range
{
    // Cancel auto-completion if the cursor is placed before the prefix
    if (self.textView.selectedRange.location <= self.foundPrefixRange.location) {
        return [self cancelAutoCompletion];
    }
    
    if (self.foundPrefix.length > 0) {
        if (range.length == 0 || range.length != word.length) {
            return [self cancelAutoCompletion];
        }
        
        if (word.length > 0) {
            // Removes the found prefix
            _foundWord = [word substringFromIndex:self.foundPrefix.length];
            
            // If the prefix is still contained in the word, cancels
            if ([self.foundWord rangeOfString:self.foundPrefix].location != NSNotFound) {
                return [self cancelAutoCompletion];
            }
        }
        else {
            return [self cancelAutoCompletion];
        }
    }
    else {
        return [self cancelAutoCompletion];
    }
    
    [self slk_showAutoCompletionView:[self canShowAutoCompletion]];
}

- (void)cancelAutoCompletion
{
    [self slk_invalidateAutoCompletion];
    
    [self slk_hideAutoCompletionViewIfNeeded];
}

- (void)slk_invalidateAutoCompletion
{
    _foundPrefix = nil;
    _foundWord = nil;
    _foundPrefixRange = NSMakeRange(0, 0);
    
    [self.autoCompletionView setContentOffset:CGPointZero];
}

- (void)acceptAutoCompletionWithString:(NSString *)string
{
    [self acceptAutoCompletionWithString:string keepPrefix:YES];
}

- (void)acceptAutoCompletionWithString:(NSString *)string keepPrefix:(BOOL)keepPrefix
{
    if (string.length == 0) {
        return;
    }
    
    SLKTextView *textView = self.textView;
    
    NSUInteger location = self.foundPrefixRange.location;
    if (keepPrefix) {
        location += self.foundPrefixRange.length;
    }
    
    NSUInteger length = self.foundWord.length;
    if (!keepPrefix) {
        length += self.foundPrefixRange.length;
    }
    
    NSRange range = NSMakeRange(location, length);
    NSRange insertionRange = [textView slk_insertText:string inRange:range];
    
    textView.selectedRange = NSMakeRange(insertionRange.location, 0);
    
    [self cancelAutoCompletion];
    
    [textView slk_scrollToCaretPositonAnimated:NO];
}

- (void)slk_hideAutoCompletionViewIfNeeded
{
    if (self.isAutoCompleting) {
        [self slk_showAutoCompletionView:NO];
    }
}

- (void)slk_showAutoCompletionView:(BOOL)show
{
    // Skips if rotating
    if (self.isRotating) {
        return;
    }
    
    CGFloat viewHeight = show ? [self heightForAutoCompletionView] : 0.0;
    
    if (self.autoCompletionViewHC.constant == viewHeight) {
        return;
    }
    
    if (show) {
        // Reload the tableview before showing it
        [self.autoCompletionView reloadData];
    }
    
    // If the auto-completion view height is bigger than the maximum height allows, it is reduce to that size. Default 140 pts.
    if (viewHeight > [self maximumHeightForAutoCompletionView]) {
        viewHeight = [self maximumHeightForAutoCompletionView];
    }
    
    CGFloat tableHeight = self.scrollViewHC.constant + self.autoCompletionViewHC.constant;
    
    // On iPhone, the auto-completion view can't extend beyond the table view height
    if (SLK_IS_IPHONE && viewHeight > tableHeight) {
        viewHeight = tableHeight;
    }
    
    self.autoCompletionViewHC.constant = viewHeight;
    self.autoCompleting = show;
    
    // Toggles auto-correction if requiered
    [self slk_enableTypingSuggestionIfNeeded];
    
	[self.view slk_animateLayoutIfNeededWithBounce:self.bounces
										   options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionLayoutSubviews|UIViewAnimationOptionBeginFromCurrentState
										animations:NULL];
}


#pragma mark - Text Caching

- (NSString *)keyForTextCaching
{
    // No implementation here. Meant to be overriden in subclass.
    return nil;
}

- (NSString *)slk_keyForPersistency
{
    NSString *keyForTextCaching = [self keyForTextCaching];
    NSString *previousCachedText = [[NSUserDefaults standardUserDefaults] objectForKey:keyForTextCaching];
    
    if ([previousCachedText isKindOfClass:[NSString class]]) {
        return keyForTextCaching;
    }
    else {
        return [NSString stringWithFormat:@"%@.%@", SLKTextViewControllerDomain, [self keyForTextCaching]];
    }
}

- (void)slk_reloadTextView
{
    if (self.textView.text.length > 0 || !self.slk_isCachingEnabled) {
        return;
    }

    self.textView.text = [self slk_cachedText];
}

- (void)slk_cacheTextView
{
    [self slk_cacheTextToDisk:self.textView.text];
}

- (void)clearCachedText
{
    [self slk_cacheTextToDisk:nil];
}

+ (void)clearAllCachedText
{
    NSMutableArray *cachedKeys = [NSMutableArray new];
    
    for (NSString *key in [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys]) {
        if ([key rangeOfString:SLKTextViewControllerDomain].location != NSNotFound) {
            [cachedKeys addObject:key];
        }
    }
    
    if (cachedKeys.count == 0) {
        return;
    }
    
    for (NSString *cachedKey in cachedKeys) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:cachedKey];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)slk_isCachingEnabled
{
    return ([self keyForTextCaching] != nil);
}

- (NSString *)slk_cachedText
{
    if (!self.slk_isCachingEnabled) {
        return nil;
    }
    
    NSString *key = [self slk_keyForPersistency];
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (void)slk_cacheTextToDisk:(NSString *)text
{
    if (!self.slk_isCachingEnabled) {
        return;
    }
    
    NSString *cachedText = [self slk_cachedText];
    NSString *key = [self slk_keyForPersistency];

    // Caches text only if its a valid string and not already cached
    if (text.length > 0 && ![text isEqualToString:cachedText]) {
        [[NSUserDefaults standardUserDefaults] setObject:text forKey:key];
    }
    // Clears cache only if it exists
    else if (text.length == 0 && cachedText.length > 0) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    else {
        // Skips so it doesn't hit 'synchronize' unnecessarily
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - Customization

- (void)registerClassForTextView:(Class)textViewClass
{
    if (textViewClass == nil) {
        return;
    }
    
    NSAssert([textViewClass isSubclassOfClass:[SLKTextView class]], @"The registered class is invalid, it must be a subclass of SLKTextView.");
    self.textViewClass = textViewClass;
}


#pragma mark - UITextViewDelegate Methods

- (BOOL)textView:(SLKTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    self.newWordInserted = ([text rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].location != NSNotFound);
    
    // Records text for undo for every new word
    if (self.newWordInserted) {
        [self.textView slk_prepareForUndo:@"Word Change"];
    }
    
    if ([text isEqualToString:@"\n"]) {
        //Detected break. Should insert new line break manually.
        [textView slk_insertNewLineBreak];
        
        return NO;
    }
    else {
        NSDictionary *userInfo = @{@"text": text, @"range": [NSValue valueWithRange:range]};
        [[NSNotificationCenter defaultCenter] postNotificationName:SLKTextViewTextWillChangeNotification object:self.textView userInfo:userInfo];
        
        return YES;
    }
}

- (void)textViewDidChangeSelection:(SLKTextView *)textView
{
    // The text view must be first responder
    if (![self.textView isFirstResponder]) {
        return;
    }
    
    // Skips if the loupe is visible or if there is a real text selection
    if (textView.isLoupeVisible || self.textView.selectedRange.length > 0) {
        return;
    }
    
    // Process the text at every caret movement
    [self slk_processTextForAutoCompletion];
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


#pragma mark - UIScrollViewDelegate Methods

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return [self slk_scrollToTopIfNeeded];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.movingKeyboard = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.movingKeyboard = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.isMovingKeyboard) {
        _scrollViewOffsetBeforeDragging = scrollView.contentOffset;
        _keyboardHeightBeforeDragging = self.keyboardHC.constant;
    }
}


#pragma mark - UIGestureRecognizerDelegate Methods

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture
{
    if ([gesture isEqual:self.singleTapGesture]) {
        return [self.textView isFirstResponder] && !self.isExternalKeyboardDetected;
    }
    else if ([gesture isEqual:self.verticalPanGesture]) {
        
        if ([self.textView isFirstResponder]) {
            return NO;
        }
        
        CGPoint velocity = [self.verticalPanGesture velocityInView:self.view];
        
        // Vertical panning, from bottom to top only
        if (velocity.y < 0 && ABS(velocity.y) > ABS(velocity.x) && ![self.textInputbar.textView isFirstResponder]) {
            return YES;
        }
    }
    
    return NO;
}


#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex] ) {
        [self.textView setText:nil];
    }
}


#pragma mark - View Auto-Layout

- (void)slk_setupViewConstraints
{
    NSDictionary *views = @{@"scrollView": self.scrollViewProxy,
                            @"autoCompletionView": self.autoCompletionView,
                            @"typingIndicatorView": self.typingIndicatorView,
                            @"textInputbar": self.textInputbar,
                            };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView(0@750)][autoCompletionView(0@750)][typingIndicatorView(0)]-0@999-[textInputbar(>=0)]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[autoCompletionView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[typingIndicatorView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textInputbar]|" options:0 metrics:nil views:views]];
    
    self.scrollViewHC = [self.view slk_constraintForAttribute:NSLayoutAttributeHeight firstItem:self.scrollViewProxy secondItem:nil];
    self.autoCompletionViewHC = [self.view slk_constraintForAttribute:NSLayoutAttributeHeight firstItem:self.autoCompletionView secondItem:nil];
    self.typingIndicatorViewHC = [self.view slk_constraintForAttribute:NSLayoutAttributeHeight firstItem:self.typingIndicatorView secondItem:nil];
    self.textInputbarHC = [self.view slk_constraintForAttribute:NSLayoutAttributeHeight firstItem:self.textInputbar secondItem:nil];
    self.keyboardHC = [self.view slk_constraintForAttribute:NSLayoutAttributeBottom firstItem:self.view secondItem:self.textInputbar];
    
    self.textInputbarHC.constant = [self slk_minimumInputbarHeight];
    self.scrollViewHC.constant = [self slk_appropriateScrollViewHeight];

    if (self.isEditing) {
        self.textInputbarHC.constant += self.textInputbar.editorContentViewHeight;
    }
}


#pragma mark - External Keyboard Support

- (NSArray *)keyCommands
{
    if (_keyboardCommands) {
        return _keyboardCommands;
    }
    
    _keyboardCommands = @[
          // Pressing Return key
          [UIKeyCommand keyCommandWithInput:@"\r" modifierFlags:0 action:@selector(didPressReturnKey:)],
          // Pressing Esc key
          [UIKeyCommand keyCommandWithInput:UIKeyInputEscape modifierFlags:0 action:@selector(didPressEscapeKey:)],
          
          // Arrow keys
          [UIKeyCommand keyCommandWithInput:UIKeyInputUpArrow modifierFlags:0 action:@selector(didPressArrowKey:)],
          [UIKeyCommand keyCommandWithInput:UIKeyInputDownArrow modifierFlags:0 action:@selector(didPressArrowKey:)],
          ];
    
    return _keyboardCommands;
}


#pragma mark - NSNotificationCenter register/unregister

- (void)slk_registerNotifications
{
    // Keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_willShowOrHideKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_willShowOrHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_didShowOrHideKeyboard:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_didShowOrHideKeyboard:) name:UIKeyboardDidHideNotification object:nil];
    
#if SLK_KEYBOARD_NOTIFICATION_DEBUG
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_didPostSLKKeyboardNotification:) name:SLKKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_didPostSLKKeyboardNotification:) name:SLKKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_didPostSLKKeyboardNotification:) name:SLKKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_didPostSLKKeyboardNotification:) name:SLKKeyboardDidHideNotification object:nil];
#endif
    
    // Keyboard Accessory View notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_didChangeKeyboardFrame:) name:SLKInputAccessoryViewKeyboardFrameDidChangeNotification object:nil];

    // TextView notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_willChangeTextViewText:) name:SLKTextViewTextWillChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_didChangeTextViewText:) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_didChangeTextViewContentSize:) name:SLKTextViewContentSizeDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_didChangeTextViewPasteboard:) name:SLKTextViewDidPasteItemNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_didShakeTextView:) name:SLKTextViewDidShakeNotification object:nil];

    // TypeIndicator notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_willShowOrHideTypeIndicatorView:) name:SLKTypingIndicatorViewWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_willShowOrHideTypeIndicatorView:) name:SLKTypingIndicatorViewWillHideNotification object:nil];
    
    // Application notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_willTerminateApplication:) name:UIApplicationWillTerminateNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slk_willTerminateApplication:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (void)slk_unregisterNotifications
{
    // Keyboard notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
#if SLK_KEYBOARD_NOTIFICATION_DEBUG
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SLKKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SLKKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SLKKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SLKKeyboardDidHideNotification object:nil];
#endif
    
    // TextView notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SLKInputAccessoryViewKeyboardFrameDidChangeNotification object:nil];
    
    // TextView notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SLKTextViewTextWillChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SLKTextViewContentSizeDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SLKTextViewDidPasteItemNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SLKTextViewDidShakeNotification object:nil];

    // TypeIndicator notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SLKTypingIndicatorViewWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SLKTypingIndicatorViewWillHideNotification object:nil];
    
    // Application notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}


#pragma mark - View Auto-Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    self.rotating = YES;
    
    [self slk_prepareForInterfaceRotation];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // Delays the rotation flag
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.rotating = NO;
    });
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}


#pragma mark - View lifeterm

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    _tableView = nil;
    
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    _collectionView = nil;

    _scrollView = nil;
    
    _autoCompletionView.delegate = nil;
    _autoCompletionView.dataSource = nil;
    _autoCompletionView = nil;
    
    _textInputbar.textView.delegate = nil;
    _textInputbar = nil;
    _typingIndicatorView = nil;
    
    _registeredPrefixes = nil;
    _keyboardCommands = nil;

    _singleTapGesture.delegate = nil;
    _singleTapGesture = nil;
    _verticalPanGesture.delegate = nil;
    _verticalPanGesture = nil;
    _scrollViewHC = nil;
    _textInputbarHC = nil;
    _textInputbarHC = nil;
    _typingIndicatorViewHC = nil;
    _autoCompletionViewHC = nil;
    _keyboardHC = nil;
    
    [self slk_unregisterNotifications];
}

@end
