//
//  Translation.h
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-05-04.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Language, UIColor;

typedef NS_ENUM(NSUInteger, TranslationResult) {
    WorstResult,
    BestResult,
    DefaultResult,
    ParseByChunksResult
};

@interface Translation : NSObject

@property (nonatomic) NSString *fromText;
@property (nonatomic) NSString *toText;
@property (nonatomic) NSArray *toTexts;
@property (nonatomic) Language *fromLanguage;
@property (nonatomic) Language *toLanguage;
@property (nonatomic) TranslationResult result;

+ (Translation *)translationWithText:(NSString *)fromText
                              toText:(NSString *)toText
                        fromLanguage:(Language *)fromLanguage
                          toLanguage:(Language *)toLanguage;

@end
