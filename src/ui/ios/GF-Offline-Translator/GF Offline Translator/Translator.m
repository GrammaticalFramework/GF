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
#import "PhraseTranslation.h"
#import "WordTranslation.h"
#import "MorphAnalyser.h"
#import "Language.h"


// Grammatical Framework
#import "pgf/literals.h"
#import "pgf/pgf.h"
#import "gu/mem.h"
#import "gu/exn.h"
#import "gu/file.h"


@interface Translator ()

@property (nonatomic, strong) NSArray *sequences;

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

- (NSString *)getSequance:(NSString *)phrase ep:(PgfExprProb *)ep tmpErr:(GuExn *)tmpErr tmpPool:(GuPool *)tmpPool {
    
    
    
    GuPool* tmp_pool = gu_new_pool();
    GuStringBuf* buf = gu_string_buf(tmp_pool);
    GuOut* outt = gu_string_buf_out(buf);
    
    
    
    // Write out the abstract syntax tree
    gu_printf(outt, self.err, "", [phrase UTF8String]);
    pgf_print_expr(ep->expr, NULL, 0, outt, self.err);
    gu_putc('\n', outt, self.err);
    
    //    pgf_linearize(self.to.concrete, html_expr, html_out, err);
    GuString lin = gu_string_buf_freeze(buf, tmp_pool);
    
    NSString *string = [NSString stringWithUTF8String:lin];
    NSLog(@"%@", string);
    
    gu_exn_clear(tmpErr);
    gu_pool_free(tmp_pool);
    tmpPool = nil;
    tmpErr = nil;
    
    return string;
}

- (PhraseTranslation *)translatePhrase:(NSString *)phrase {
    
    GuPool *tmpPool = gu_new_pool();
    GuExn *tmpErr = gu_new_exn(tmpPool);
    
    PgfExprEnum *parsedExpressions = [self parsePhrase:[phrase stringByAppendingString:@" "] startCat:@"Phr" tmpPool:tmpPool tmpErr:tmpErr];
    NSArray *translatedText = nil;
    
    if (parsedExpressions != nil) {
        translatedText = [self linearizeResult:parsedExpressions tmpPool:tmpPool tmpErr:tmpErr];
        if (translatedText.count == 0) {
            translatedText = @[[self translateByLookUp:phrase]];
        }
    } else {
        translatedText = @[[self translateByLookUp:phrase]];
    }
    
    
    
    PhraseTranslation *translation = [PhraseTranslation translationWithText:phrase
                                                         toText:translatedText.firstObject
                                                   fromLanguage:self.from.language
                                                     toLanguage:self.to.language];

    translation.toTexts = translatedText;
    translation.sequences = self.sequences;

    if ([translation.toLanguage.bcp isEqualToString:@"th-TH"] ||
        [translation.toLanguage.bcp isEqualToString:@"ja-JP"] ||
        [translation.toLanguage.bcp isEqualToString:@"zh-CN"]) {
        
        NSMutableArray *trimmedArray = @[].mutableCopy;
        
        for (NSString *string in translation.toTexts) {
            NSString *trimmed = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            [trimmedArray addObject:trimmed];
        }
        NSString *trimmed = [translation.toText stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        translation.toText = trimmed;
        translation.toTexts = trimmedArray.copy;
    }
    
    return translation;
}

- (WordTranslation *)analysWord:(NSString *)word; {
    
    MorphAnalyser *analyser = [[MorphAnalyser alloc] initWithPgf:self.pgf err:self.err to:self.to from:self.from];
    [analyser analysWord:word];
    
    WordTranslation *translation = [WordTranslation translationWithText:word
                                                                  toText:analyser.bestTranslation
                                                            fromLanguage:self.from.language
                                                              toLanguage:self.to.language];
    
    translation.toTexts = analyser.analysedWords;
    translation.html = analyser.html;
    
    return translation;
}

#pragma mark - Private helpers

- (NSString *)translateByLookUp:(NSString *)phrase {
    NSMutableString *translation = @"%".mutableCopy;
    NSArray *words = [phrase componentsSeparatedByString:@" "];
    
    for (NSString *word in words) {
        NSString *translatedWord = [self translateWord:word];
        [translation appendString: translatedWord ? [NSString stringWithFormat:@" %@", translatedWord] : [NSString stringWithFormat:@" %@", word]];
    }
    return translation.copy;
}

- (NSString *)translateWord:(NSString *)word {
    GuPool *tmpPool = gu_new_pool();
    GuExn *tmpErr = gu_new_exn(tmpPool);
    
    PgfExprEnum *parse = [self parsePhrase:word startCat:@"Chunk" tmpPool:tmpPool tmpErr: tmpErr];
    NSString *translation = @"";
    
    if (parse) {
        NSArray *results = [self linearizeResult:parse tmpPool:tmpPool tmpErr:tmpErr];
        
        if (results.count) {
            translation = results.firstObject;
        } else {
            translation = [self translateByLookUp:word];
        }
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
    
    PgfCallbacksMap* callbacks =
    pgf_new_callbacks_map(self.from.concrete, tmpPool);
    pgf_callbacks_map_add_literal(self.from.concrete, callbacks,
                                  "PN", &pgf_nerc_literal_callback);
    
    pgf_callbacks_map_add_literal(self.from.concrete, callbacks,
                                  "Symb", &pgf_unknown_literal_callback);
    
    PgfExprEnum *result = pgf_parse_with_heuristics(self.from.concrete, "Phr", [phrase UTF8String],
                                       -1, callbacks,
                                       tmpErr, tmpPool, tmpPool);
    
    
    
//    PgfExprEnum *result = pgf_parse(self.from.concrete, [startCat UTF8String], [phrase UTF8String], tmpErr, tmpPool, tmpPool);
    return gu_ok(tmpErr) ? result : nil;
}

-(NSArray *)linearizeResult:(PgfExprEnum *)result tmpPool:(GuPool *)tmpPool tmpErr:(GuExn *)tmpErr {
    
    NSMutableArray *translations = [NSMutableArray new];
    NSMutableArray *sequences = [NSMutableArray new];
    
    PgfExprProb *ep;
    gu_enum_next(result, &ep, tmpPool);
    
    
    // If null reutrun empty array
    if (!ep) {
        return @[];
    }
    
    for (int i = 0; i <= 10 && ep != nil; i++) {
        PgfExprProb parse = ep[0];

        // Get translation
        GuStringBuf *stringBuff = gu_string_buf(tmpPool);
        GuOut *tmpOut = gu_string_buf_out(stringBuff);
        pgf_linearize(self.to.concrete, parse.expr, tmpOut, tmpErr);
        
        // Get sequence
        GuString lin = gu_string_buf_freeze(stringBuff, tmpPool);
        NSString *phrase = [NSString stringWithUTF8String:lin];
        
        NSString *translated = [NSString stringWithUTF8String:gu_string_buf_freeze(stringBuff, tmpPool)];
        
        NSInteger resultIndex = [translations indexOfObjectPassingTest:^BOOL(NSString *str, NSUInteger idx, BOOL *stop) {
            return [str isEqualToString:translated];
        }];
        
        if (resultIndex == NSNotFound) {
            [translations addObject:translated];
            [sequences addObject:[self getSequance:phrase ep:ep tmpErr:tmpErr tmpPool:tmpPool]];
        }
        
        gu_out_flush(tmpOut, tmpErr);
        tmpOut = nil;
        
        gu_enum_next(result, &ep, tmpPool);
    }
    self.sequences = [sequences copy];
    
    return [translations copy];
}

- (void)changeLanguageToLanguage:(Language *)language isFrom:(BOOL)isFrom withCompletion:(void (^)(void))completion {
    
    dispatch_async(dispatch_queue_create("Load grammars",NULL), ^{
        if ([self.previous.language isEqualToLanguage:language]) {
            Grammar *temp = isFrom ? self.from : self.to;
            if (isFrom) {
                self.from = self.previous;
            } else {
                self.to = self.previous;
            }
            self.previous = temp;
        } else {
            self.previous = isFrom ? self.from : self.to;
            if (isFrom) {
                self.from = [Grammar loadGrammarFromLanguage:language withTranslator:self];
            } else {
                self.to = [Grammar loadGrammarFromLanguage:language withTranslator:self];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    });
}


@end
