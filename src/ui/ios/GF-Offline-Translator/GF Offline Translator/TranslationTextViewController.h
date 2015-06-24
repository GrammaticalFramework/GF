//
//  TranslationTextViewController.h
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-27.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "SLKTextViewController.h"
@class Language;

@protocol TranslationTextViewControllerDelegate <NSObject>

- (void)changeLanguageToLanguage:(Language *)laguange isFrom:(BOOL)isFrom;

@end

@interface TranslationTextViewController : SLKTextViewController <TranslationTextViewControllerDelegate>

@end
