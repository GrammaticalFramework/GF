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
    [self.tableView beginUpdates];
    if ([self.translationTree.text isEqualToString:@""]) {
        self.translationTree.text = self.translationTreeText;
    } else {
        self.translationTree.text = @"";
    }
    [self.tableView endUpdates];
}

@end
