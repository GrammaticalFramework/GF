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
    return @[
             [[Language alloc] initWithName:@"Bulgarian"    abbreviation:@"Bul"     andBcp:@"en-GB"],
             [[Language alloc] initWithName:@"Chinese"      abbreviation:@"Chi"     andBcp:@"zh-CN"],
             [[Language alloc] initWithName:@"Dutch"        abbreviation:@"Dut"     andBcp:@"nl-NL"],
             [[Language alloc] initWithName:@"English"      abbreviation:@"Eng"     andBcp:@"en-GB"],
             [[Language alloc] initWithName:@"Finnish"      abbreviation:@"Fin"     andBcp:@"fi-FI"],
             [[Language alloc] initWithName:@"French"       abbreviation:@"Fre"     andBcp:@"fr-FR"],
             [[Language alloc] initWithName:@"German"       abbreviation:@"Ger"     andBcp:@"de-DE"],
             [[Language alloc] initWithName:@"Hindi"        abbreviation:@"Hin"     andBcp:@"hi-IN"],
             [[Language alloc] initWithName:@"Italian"      abbreviation:@"Ita"     andBcp:@"it-IT"],
             [[Language alloc] initWithName:@"Japanese"     abbreviation:@"Jpn"     andBcp:@"ja-JP"],
             [[Language alloc] initWithName:@"Spanish"      abbreviation:@"Spa"     andBcp:@"es-ES"],
             [[Language alloc] initWithName:@"Swedish"      abbreviation:@"Swe"     andBcp:@"sv-SE"],
             [[Language alloc] initWithName:@"Thai"         abbreviation:@"Tha"     andBcp:@"th-TH"]
             ];
}

@end
