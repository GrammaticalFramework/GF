//
//  Language.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-28.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "Language.h"

@implementation Language

- (instancetype)initWithName:(NSString *)name
                abbreviation:(NSString *)abbreviation
                      andBcp:(NSString *)bcp {
    self = [super init];
    if (self) {
        _name           = name;
        _abbreviation   = abbreviation;
        _bcp            = bcp;
    }
    return self;
}

+ (NSArray *)allLanguages {
    return @[];
}

@end
