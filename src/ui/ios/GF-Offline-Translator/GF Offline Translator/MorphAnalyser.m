//
//  MorphAnalyser.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-05-24.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "MorphAnalyser.h"

// Model
#import "Grammar.h"

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

NSMutableArray *morphWords;
NSMutableArray *htmls;

void print_lemma(PgfMorphoCallback* _self,
                 PgfCId lemma, GuString analysis, prob_t prob,
                 GuExn* err) {
    
    PgfLinLemmasCallback* this = gu_container(_self, PgfMorphoCallback, callback);
    
    // Here we print the lemmas. One and the same lemma could
    // appear several times if there are different analyses.
    // In this case "barn" is child but it could be in singular,
    // in plural or it could be used as a compound form.
    // Duplications should be eliminated in the user interface.
    
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
    
    // Here we extract the type of the lemma
    // N for nouns, V,V2,V3,V2V,... for verbs, A for adjectives,
    // Prep for prepositions, etc.
    PgfType* ty = pgf_function_type(this->pgf, lemma);
    
    NSString *inflectionCid = [NSString stringWithFormat:@"Inflection%@",
                               [NSString stringWithUTF8String:ty->cid]];
    
    BOOL hasLinearization = pgf_has_linearization(this->tgt, [inflectionCid UTF8String]);
    
    // Here we get the tag that should be shown in the UI
    {
        // The purpose of this buffer is to just construct an expression.
        // Maybe there is an easier way in ObjectiveC
        GuStringBuf* expr_buf = gu_string_buf(tmp_pool);
        GuOut* expr_out = gu_string_buf_out(expr_buf);
        

        
        if (hasLinearization) {
            gu_printf(expr_out, err, "MkTag (Inflection%s %s)",ty->cid ,lemma);
            GuString s = gu_string_buf_freeze(expr_buf, tmp_pool);
            GuIn* in = gu_string_in(s, tmp_pool);
            PgfExpr tag_expr = pgf_read_expr(in, tmp_pool, err);
            
            pgf_linearize(this->tgt, tag_expr, out, err);
            
            gu_puts(". ", out, err);
        }
    }
    
    if (pgf_has_linearization(this->tgt, lemma)) {
        
        
        // Now we linearize the expression in the target language
        // This is the only thing that needs to be done for
        // visualization in the first view. Everything else
        // is useful only for the second view which shows
        // inflection tables and alternative translations.
        pgf_linearize(this->tgt, expr, out, err);
    } else {
//        gu_puts(".", out, err);
    }
    
    // Finally we get the string which is used for describing
    // the different lexical entries in the translations view
    GuString s = gu_string_buf_freeze(buf, tmp_pool);
    printf("entry: %s\n", s);
    
    NSString *translation = [NSString stringWithUTF8String:s];
    if ([morphWords containsObject:translation]) { //||
//        [[translation stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] hasSuffix:@"."]) {
        return;
    }

    [morphWords addObject:translation];
    
    // Here we get the html for the inflection table
    if (hasLinearization) {
        // The purpose of this buffer is to just construct an expression.
        // Maybe there is an easier way in ObjectiveC
        GuStringBuf* expr_buf = gu_string_buf(tmp_pool);
        GuOut* expr_out = gu_string_buf_out(expr_buf);
        gu_printf(expr_out, err, "MkDocument \"\" (Inflection%s %s) \"\"",ty->cid, lemma);
        GuString s = gu_string_buf_freeze(expr_buf, tmp_pool);
        GuIn* in = gu_string_in(s, tmp_pool);
        PgfExpr html_expr = pgf_read_expr(in, tmp_pool, err);
        
        GuStringBuf* html_buf = gu_string_buf(tmp_pool);
        GuOut* html_out = gu_string_buf_out(html_buf);
        pgf_linearize(this->tgt, html_expr, html_out, err);
        GuString lin = gu_string_buf_freeze(html_buf, tmp_pool);
        printf("html:\n%s\n", lin);
        
        NSString *htmlString = [NSString stringWithUTF8String:lin];
        
        if (htmlString.length > 0) {
            NSMutableString *html = [NSMutableString stringWithString: @"<html><head><title></title></head><body style=\"background:transparent;\">"];
            [html appendString:htmlString];
            [html appendString:@"</body></html>"];
            [htmls addObject:html];
        }
    } else {
        [htmls addObject:@""];
    }
    
    printf("\n");
    gu_pool_free(tmp_pool);
}


@implementation MorphAnalyser

- (instancetype)initWithPgf:(PgfPGF *)pgf err:(GuExn *)err to:(Grammar *)to from:(Grammar *)from {
    self = [super init];
    
    if (self) {
        _pgf = pgf;
        _err = err;
        _to = to;
        _from = from;
    }
    return self;
}


- (NSString *)bestTranslation {
    if (self.analysedWords.count) {
        for (NSString *translation in self.analysedWords) {
            if (![[translation stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] hasSuffix:@"."]) {
                return [[translation componentsSeparatedByString:@" "].lastObject stringByAppendingString:@" "];
            }
        }
    }
    return nil;
}

- (void)analysWord:(NSString *)word {
    
    morphWords = [NSMutableArray new];
    htmls = [NSMutableArray new];

    PgfLinLemmasCallback callback = { { print_lemma }, self.pgf, self.from.concrete, self.to.concrete };
    pgf_lookup_morpho(self.from.concrete, [word UTF8String], &callback.callback, self.err);

    _analysedWords = morphWords;
    _html = htmls;
    
    htmls = nil;
    morphWords = nil;
}


@end
