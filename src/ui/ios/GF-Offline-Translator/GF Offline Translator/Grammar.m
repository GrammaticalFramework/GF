//
//  Grammar.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-28.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "Grammar.h"
#import "Translator.h"
#import "Language.h"

// Grammatical Framework
#import "pgf/pgf.h"
#import "gu/mem.h"
#import "gu/exn.h"
#import "gu/file.h"

@implementation Grammar

+ (Grammar *)loadGrammarFromLanguage:(Language *)language withTranslator:(Translator *)translator {
    Grammar *grammar = [Grammar new];
    
    // Load the file
    NSString *appLanguage = [NSString stringWithFormat:@"App%@",language.abbreviation];
    
    PgfConcr *concr = pgf_get_language(translator.pgf, [appLanguage UTF8String]);
    NSString *path = [[NSBundle mainBundle] pathForResource:appLanguage ofType:@"pgf_c"];
    FILE *file = fopen([path UTF8String], "r");
    
    GuIn *guIn = gu_file_in(file, translator.pool);
    
    pgf_concrete_load(concr, guIn, translator.err);
    
    grammar.concrete = concr;
    grammar.language = language;
    
    return grammar;
}

- (void)dealloc {
    pgf_concrete_unload(self.concrete);
}

@end
