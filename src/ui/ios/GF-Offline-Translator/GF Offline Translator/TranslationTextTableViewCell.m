//
//  TranslationInputTableViewCell.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-27.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "TranslationTextTableViewCell.h"
#import "Translation.h"
#import "Language.h"
#import "UIColor+TranslationsResults.h"

@implementation TranslationTextTableViewCell

- (void)awakeFromNib {
    self.translationTextLabel.layer.cornerRadius = 3;
    self.translationTextLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithLanguage:(Translation *)translation fromLanguage:(BOOL)fromLanguage {
    
    Language *language = fromLanguage ? translation.fromLanguage : translation.toLanguage;
    NSString *text = fromLanguage ? translation.fromText : translation.toText;
    
    NSString *imageName = language.abbreviation;
    [self.flagImageView setImage:[UIImage imageNamed:imageName]];
    self.translationTextLabel.text = text;
    UIColor *lightBlueColor = [UIColor colorWithRed:0.373 green:0.836 blue:1.000 alpha:1.000];
    self.translationTextLabel.backgroundColor = fromLanguage ? lightBlueColor : [UIColor colorForResult:translation.result];
}

@end
