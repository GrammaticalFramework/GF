//
//  SentenceTranslationUITableViewCell.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-06-18.
//  Copyright © 2015 Grammatical Framework. All rights reserved.
//

#import "SentenceTranslationUITableViewCell.h"
#import "PhraseTranslation.h"

@interface SentenceTranslationUITableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *translationSentance;
@property (weak, nonatomic) IBOutlet UILabel *translationTree;

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSString *translationTreeText;

@end

@implementation SentenceTranslationUITableViewCell

- (void)configureCellWithSentenceInTableView:(UITableView *)tableView withTranslation:(NSString *)translation andTree:(NSString *)tree {
    self.tableView = tableView;
    self.translationSentance.text = translation;
    self.translationTreeText = tree;
    
    self.translationTree.text = @"";
}
- (IBAction)showTree:(id)sender {
    
    if ([self.translationTree.text isEqualToString:@""]) {
        self.translationTree.alpha = 0;
        
        [self.tableView beginUpdates];
        self.translationTree.text = self.translationTreeText;
        [self.tableView endUpdates];
        
        [UIView animateWithDuration:0.25 delay:0.15 options:0 animations:^{
            self.translationTree.alpha = 1;
        } completion:nil];
        
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.translationTree.alpha = 0;
        } completion:^(BOOL finished) {
            [self.tableView beginUpdates];
            self.translationTree.text = @"";
            [self.tableView endUpdates];
        }];
    }
    
}

@end
