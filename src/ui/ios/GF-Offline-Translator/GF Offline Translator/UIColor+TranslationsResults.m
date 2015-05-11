//
//  UIColor+TranslationsResults.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-05-04.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "UIColor+TranslationsResults.h"

@implementation UIColor (TranslationsResults)

+ (UIColor *)colorForResult:(TranslationResult)result {
    switch (result) {
        case BestResult:
            return [UIColor bestResultColor];
        case WorstResult:
            return [UIColor worstResultColor];
        case ParseByChunksResult:
            return [UIColor parseByChunksResultColor];
        default:
            return [UIColor defaultResultColor];
    }
}

+ (UIColor *)worstResultColor {
    return [UIColor colorWithRed:0.695 green:0.000 blue:0.007 alpha:1.000];
}

+ (UIColor *)defaultResultColor {
    return [UIColor colorWithRed:0.996 green:0.988 blue:0.529 alpha:1.000];
}


+ (UIColor *)parseByChunksResultColor {
    return [UIColor redColor];
}

+ (UIColor *)bestResultColor {
    return  [UIColor greenColor];
}

@end
