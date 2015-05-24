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

// Grammatical Framework
#import "pgf/pgf.h"
#import "gu/mem.h"
#import "gu/exn.h"
#import "gu/file.h"

typedef struct {
    PgfMorphoCallback callback;
    PgfPGF* pgf;
    PgfConcr* src;
    PgfConcr* tgt;
} PgfLinLemmasCallback;

NSString *morphWord;

void print_lemma(PgfMorphoCallback* _self,
                 PgfCId lemma, GuString analysis, prob_t prob,
                 GuExn* err) {
    PgfLinLemmasCallback* this = gu_container(_self, PgfMorphoCallback, callback);
    
    // Here we print the lemmas. One and the same lemma could
    // appear several times if there are different analyses.
    // In this case "barn" is child but it could be in singular,
    // in plural or it could be used as a compound form.
    // Duplications should be eliminated in the user interface.
    
    if (morphWord) {
        return;
    }
    
    printf("%s (%s)\n", lemma, analysis);
    
    GuPool* tmp_pool = gu_new_pool();
    GuStringBuf* buf = gu_string_buf(tmp_pool);
    GuOut* out = gu_string_buf_out(buf);
    
    // Now we build an expression from the lemma.
    PgfApplication app = {lemma, 0};
    PgfExpr expr = pgf_expr_apply(&app, tmp_pool);
    
    // Now we linearize the expression in the source language
    pgf_linearize(this->src, expr, out, err);
    
    if (pgf_has_linearization(this->tgt, lemma))
        gu_puts(" - ", out, err);
    else
        gu_puts(" ", out, err);
    
    if (pgf_has_linearization(this->tgt, lemma)) {
        gu_puts(". ", out, err);
        
        // Now we linearize the expression in the target language
        // This is the only thing that needs to be done for
        // visualization in the first view. Everything else
        // is useful only for the second view which shows
        // inflection tables and alternative translations.
        pgf_linearize(this->tgt, expr, out, err);
    } else {
        gu_puts(".", out, err);
    }
    
    // Finally we get the string which is used for describing
    // the different lexical entries in the translations view
    GuString s = gu_string_buf_freeze(buf, tmp_pool);
    printf("entry: %s\n", s);
    
    morphWord = [NSString stringWithUTF8String:s];
    
    printf("\n");
    gu_pool_free(tmp_pool);
}

void translate_word(PgfPGF* pgf, GuString word, GuExn* err)
{
    PgfConcr* swe = pgf_get_language(pgf, "AppSwe");
    PgfConcr* eng = pgf_get_language(pgf, "AppEng");
    PgfLinLemmasCallback callback = { { print_lemma }, pgf, swe, eng };
    pgf_lookup_morpho(swe, word, &callback.callback, err);
}

@interface Translator ()

@end

@implementation Translator

#pragma mark - inits

- (void)morph {
    GuPool* pool = gu_new_pool();
    
    GuExn* err = gu_new_exn(pool);
    translate_word(self.pgf, "barn", err);
    
    gu_pool_free(pool);
}

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
        [translation appendString:translatedWord];
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
        
        PgfLinLemmasCallback callback = { { print_lemma }, self.pgf, self.from.concrete, self.to.concrete };
        pgf_lookup_morpho(self.from.concrete, [word UTF8String], &callback.callback, self.err);
        translation = [[morphWord componentsSeparatedByString:@" "].lastObject stringByAppendingString:@" "];
        morphWord = nil;
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
    
    do {
        PgfExprProb parse = ep[0];
        
        GuStringBuf *stringBuff = gu_string_buf(tmpPool);
        GuOut *tmpOut = gu_string_buf_out(stringBuff);
        pgf_linearize(self.to.concrete, parse.expr, tmpOut, tmpErr);
        [translations addObject:[NSString stringWithUTF8String:gu_string_buf_freeze(stringBuff, tmpPool)]];
        
        gu_out_flush(tmpOut, tmpErr);
        tmpOut = nil;
        
        gu_enum_next(result, &ep, tmpPool);
    } while (ep);
    
    return translations.objectEnumerator.allObjects;
}

@end
