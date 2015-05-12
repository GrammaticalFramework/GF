//
//  TranslationInputTableViewCell.h
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-27.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Translation;

@interface TranslationTextTableViewCell : UITableViewCell


- (void)setCellWithLanguage:(Translation *)translation fromLanguage:(BOOL)fromLanguage;

@end
