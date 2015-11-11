//
//  Translator.h
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-28.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import <Foundation/Foundation.h>

// Grammitcal framework
#import "pgf.h"

@class Grammar;
@class PhraseTranslation;
@class WordTranslation;
@class Language;

@interface Translator : NSObject

@property (nonatomic) PgfPGF *pgf;
@property (nonatomic) GuOut *fileOut;
@property (nonatomic) GuExn *err;
@property (nonatomic) GuPool *pool;

@property (nonatomic, strong) Grammar *to;
@property (nonatomic, strong) Grammar *from;
@property (nonatomic, strong) Grammar *previous;

- (PhraseTranslation *)translatePhrase:(NSString *)phrase;
- (WordTranslation *)analysWord:(NSString *)word;
- (void)changeLanguageToLanguage:(Language *)language isFrom:(BOOL)isFrom withCompletion:(void (^)(void))completion;

@end
