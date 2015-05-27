//
//  UIColor+TranslationsResults.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-05-04.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "UIColor+TranslationsResults.h"

@implementation UIColor (TranslationsResults)

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (UIColor *)colorForResult:(TranslationResult)result {
    switch (result) {
        case BestResult:
            return [UIColor bestResultColor];
        case WorstResult:
            return [UIColor worstResultColor];
        case ParseByChunksResult:
            return [UIColor parseByChunksResultColor];
        case InputSentence:
            return [UIColor inputSentenceColor];
        default:
            return [UIColor defaultResultColor];
    }
}

+ (UIColor *)worstResultColor {
    return [UIColor colorFromHexString:@"#FF303e"];
}

+ (UIColor *)defaultResultColor {
    return [UIColor colorFromHexString:@"#FFFF99"];
}


+ (UIColor *)parseByChunksResultColor {
    return [UIColor colorFromHexString:@"#FFB2A5"];
}

+ (UIColor *)bestResultColor {
    return  [UIColor colorFromHexString:@"#75CD75"];
}

+ (UIColor *)inputSentenceColor {
    return [UIColor colorFromHexString:@"#CDCDED"];
}

@end
