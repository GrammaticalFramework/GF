//
//  Translation.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-05-04.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Translation.h"
#import "UIColor+TranslationsResults.h"

@implementation Translation

+ (Translation *)translationWithText:(NSString *)fromText
                              toText:(NSString *)toText
                        fromLanguage:(Language *)fromLanguage
                          toLanguage:(Language *)toLanguage {
    Translation *translation = [Translation new];
    
    translation.color = [Translation colorForText:toText];
    
    translation.toText = [Translation formatTranslation:toText];
    translation.fromText = fromText;

    translation.fromLanguage = fromLanguage;
    translation.toLanguage = toLanguage;
    
    return translation;
}

+ (UIColor *)colorForText:(NSString *)text {
    
    NSString *firstChar = [text substringToIndex:1];
    
    if (text.length == 0) {
        return [UIColor defaultResultColor];
    }
    
    if ([firstChar isEqualToString:@"%"] ||
        [text rangeOfString:@"parse error:"].location != NSNotFound ||
        [text rangeOfString:@"["].location != NSNotFound) {
        return [UIColor worstResultColor];
    }
    
    if ([firstChar isEqualToString:@"*"]) {
        return [UIColor parseByChunksResultColor];
    }
    
    if ([firstChar isEqualToString:@"+"]) {
        return [UIColor bestResultColor];
    }
    
    return [UIColor defaultResultColor];
}

+ (NSString *)formatTranslation:(NSString *)text {
    
    if (text.length == 0) {
        return text;
    }
    
    NSCharacterSet *charsToRemove = [NSCharacterSet characterSetWithCharactersInString:@"+*% "];
    NSString *trimmedText = [text stringByTrimmingCharactersInSet:charsToRemove];
    
    for (NSString *charToRemove in @[@"[", @"]", @"_"]) {
        trimmedText =[trimmedText stringByReplacingOccurrencesOfString:charToRemove withString:@" "];
    }

    return trimmedText;
}

@end
