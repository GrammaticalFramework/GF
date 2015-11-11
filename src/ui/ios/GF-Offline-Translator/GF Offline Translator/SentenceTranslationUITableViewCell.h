//
//  SentenceTranslationUITableViewCell.h
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-06-18.
//  Copyright © 2015 Grammatical Framework. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SentenceTranslationUITableViewCell : UITableViewCell

- (void)configureCellWithSentenceInTableView:(UITableView *)tableView withTranslation:(NSString *)translation andTree:(NSString *)tree;
@end
