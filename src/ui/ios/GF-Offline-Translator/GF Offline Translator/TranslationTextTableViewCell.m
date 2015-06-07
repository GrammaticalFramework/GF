//
//  TranslationInputTableViewCell.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-27.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "TranslationTextTableViewCell.h"
#import "PhraseTranslation.h"
#import "Language.h"
#import "UIColor+TranslationsResults.h"

@interface TranslationTextTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *translationTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@property (weak, nonatomic) IBOutlet UIView *decorationView;

@end

@implementation TranslationTextTableViewCell

- (void)awakeFromNib {
    self.decorationView.layer.cornerRadius = 5;
    self.decorationView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithLanguage:(PhraseTranslation *)translation fromLanguage:(BOOL)fromLanguage {
    
    Language *language = fromLanguage ? translation.fromLanguage : translation.toLanguage;
    NSString *text = fromLanguage ? translation.fromText : translation.toText;
    
    NSString *imageName = language.abbreviation;
    [self.flagImageView setImage:[UIImage imageNamed:imageName]];
    self.translationTextLabel.text = text;
    TranslationResult resultColor = fromLanguage ? InputSentence : translation.result;
    self.decorationView.backgroundColor = [UIColor colorForResult: resultColor];
}

@end
