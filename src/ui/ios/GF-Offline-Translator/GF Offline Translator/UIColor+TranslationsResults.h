//
//  UIColor+TranslationsResults.h
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-05-04.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhraseTranslation.h"

@interface UIColor (TranslationsResults)

+ (UIColor *)colorForResult:(TranslationResult)result;

@end
