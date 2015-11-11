//
//  Grammar.h
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-28.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pgf/pgf.h"

@class Language;
@class Translator;

@interface Grammar : NSObject
@property (nonatomic) Language *language;
@property (nonatomic) PgfConcr *concrete;

+ (Grammar *)loadGrammarFromLanguage:(Language *)language withTranslator:(Translator *)translator;

@end
