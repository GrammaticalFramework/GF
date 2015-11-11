//
//  MorphAnalyser.h
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-05-24.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import <Foundation/Foundation.h>

// Grammitcal framework
#import "pgf.h"

@class Grammar;

@interface MorphAnalyser : NSObject

@property (nonatomic) PgfPGF *pgf;
@property (nonatomic) GuExn *err;

@property (nonatomic, strong) Grammar *to;
@property (nonatomic, strong) Grammar *from;

@property (nonatomic, readonly) NSArray *analysedWords;
@property (nonatomic, readonly) NSString *bestTranslation;
@property (nonatomic, readonly) NSMutableArray *html;


- (instancetype)initWithPgf:(PgfPGF *)pgf err:(GuExn *)err to:(Grammar *)to from:(Grammar *)from;
- (void)analysWord:(NSString *)word;

@end
