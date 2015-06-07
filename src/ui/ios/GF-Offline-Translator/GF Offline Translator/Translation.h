//
//  Translation.h
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-06-03.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Language;

typedef NS_ENUM(NSUInteger, TranslationResult) {
    WorstResult,
    BestResult,
    DefaultResult,
    ParseByChunksResult,
    InputSentence
};

@interface Translation : NSObject

@property (nonatomic) NSString *fromText;
@property (nonatomic) NSString *toText;
@property (nonatomic) NSArray *toTexts;
@property (nonatomic) Language *fromLanguage;
@property (nonatomic) Language *toLanguage;
@property (nonatomic) TranslationResult result;

+ (instancetype)translationWithText:(NSString *)fromText
                                    toText:(NSString *)toText
                              fromLanguage:(Language *)fromLanguage
                                toLanguage:(Language *)toLanguage;
- (void)speak;
@end
