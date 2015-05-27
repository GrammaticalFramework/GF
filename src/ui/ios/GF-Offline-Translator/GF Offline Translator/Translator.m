//
//  Translator.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-28.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "Translator.h"

// Model
#import "Grammar.h"
#import "Translation.h"
#import "MorphAnalyser.h"

// Grammatical Framework
#import "pgf/pgf.h"
#import "gu/mem.h"
#import "gu/exn.h"
#import "gu/file.h"


@interface Translator ()

@end

@implementation Translator

#pragma mark - inits

- (instancetype)init {
    self = [super init];
    if (self) {
        
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path = [bundle pathForResource:@"App" ofType:@"pgf"];
        
        // Create the pool that is used to allocate everything
        _pool = gu_new_pool();
        
        // Create an exception frame that catches all errors.
        _err = gu_new_exn(_pool);
        
        // Read the PGF grammar.
        _pgf = pgf_read([path UTF8String], _pool, _err);
    }
    return self;
}

#pragma mark - Public translation method

- (Translation *)translatePhrase:(NSString *)phrase {
    GuPool *tmpPool = gu_new_pool();
    GuExn *tmpErr = gu_new_exn(tmpPool);
    
    PgfExprEnum *parsedExpressions = [self parsePhrase:phrase startCat:@"Phr" tmpPool:tmpPool tmpErr:tmpErr];
    NSArray *translatedText = nil;
    
    if (parsedExpressions != nil) {
        translatedText = [self linearizeResult:parsedExpressions tmpPool:tmpPool tmpErr:tmpErr];
    } else {
        translatedText = @[[self translateByLookUp:phrase]];
    }
    
    gu_exn_clear(tmpErr);
    gu_pool_free(tmpPool);
    tmpPool = nil;
    tmpErr = nil;
    
    Translation *translation = [Translation translationWithText:phrase
                                                         toText:translatedText.firstObject
                                                   fromLanguage:self.from.language
                                                     toLanguage:self.to.language];
    if (translatedText.count > 1) {
        translation.toTexts = translatedText;
    }
    
    return translation;
}

#pragma mark - Private helpers

- (NSString *)translateByLookUp:(NSString *)phrase {
    NSMutableString *translation = @"%".mutableCopy;
    NSArray *words = [phrase componentsSeparatedByString:@" "];
    
    for (NSString *word in words) {
        NSString *translatedWord = [self translateWord:word];
        [translation appendString: translatedWord ? translatedWord : @" - "];
    }
    return translation.copy;
}

- (NSString *)translateWord:(NSString *)word {
    GuPool *tmpPool = gu_new_pool();
    GuExn *tmpErr = gu_new_exn(tmpPool);
    
    PgfExprEnum *parse = [self parsePhrase:word startCat:@"Chunk" tmpPool:tmpPool tmpErr: tmpErr];
    NSString *translation = @"";
    
    if (parse) {
        translation = [self linearizeResult:parse tmpPool:tmpPool tmpErr:tmpErr].firstObject;
    } else {
        MorphAnalyser *analyser = [[MorphAnalyser alloc] initWithPgf:self.pgf err:self.err to:self.to from:self.from];
        [analyser analysWord:word];
        translation = analyser.bestTranslation;
    }
    
    // Clear up resources
    gu_exn_clear(tmpErr);
    gu_pool_free(tmpPool);
    tmpPool = nil;
    tmpErr = nil;
    
    return translation;
}

- (PgfExprEnum *)parsePhrase:(NSString *)phrase startCat:(NSString *)startCat tmpPool:(GuPool *)tmpPool tmpErr:(GuExn *)tmpErr {
    PgfExprEnum *result = pgf_parse(self.from.concrete, [startCat UTF8String], [phrase UTF8String], tmpErr, tmpPool, tmpPool);
    return gu_ok(tmpErr) ? result : nil;
}

-(NSArray *)linearizeResult:(PgfExprEnum *)result tmpPool:(GuPool *)tmpPool tmpErr:(GuExn *)tmpErr {
    
    NSMutableOrderedSet *translations = [NSMutableOrderedSet new];
    PgfExprProb *ep;
    gu_enum_next(result, &ep, tmpPool);
    
    while (ep) {
        if (translations.count > 10) {
            return translations.objectEnumerator.allObjects;
        }
        PgfExprProb parse = ep[0];
        
        GuStringBuf *stringBuff = gu_string_buf(tmpPool);
        GuOut *tmpOut = gu_string_buf_out(stringBuff);
        pgf_linearize(self.to.concrete, parse.expr, tmpOut, tmpErr);
        [translations addObject:[NSString stringWithUTF8String:gu_string_buf_freeze(stringBuff, tmpPool)]];
        
        gu_out_flush(tmpOut, tmpErr);
        tmpOut = nil;
        
        gu_enum_next(result, &ep, tmpPool);
    }
    
    return translations.objectEnumerator.allObjects;
}

@end
