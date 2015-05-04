//
//  TranslationInputTableViewCell.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-27.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "TranslationTextTableViewCell.h"


@implementation TranslationTextTableViewCell

- (void)awakeFromNib {
    self.translationTextLabel.layer.cornerRadius = 3;
    self.translationTextLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
