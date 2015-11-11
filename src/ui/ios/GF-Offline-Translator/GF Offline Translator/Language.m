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
                         bcp:(NSString *)bcp {
    self = [super init];
    if (self) {
        _name           = name;
        _abbreviation   = abbreviation;
        _bcp            = bcp;
    }
    return self;
}

- (BOOL)isEqualToLanguage:(Language *)language {
    if (!language) {
        return NO;
    }
    
    BOOL haveEqualNames = (!self.name && !language.name) || [self.name isEqualToString:language.name];
    BOOL haveEqualBcp   = (!self.bcp && !language.bcp) || [self.bcp isEqualToString:language.bcp];
    
    return haveEqualNames && haveEqualBcp;
}

+ (NSArray *)allLanguages {
    return @[
             [[Language alloc] initWithName:@"Bulgarian"    abbreviation:@"Bul"     bcp:@"en-GB"],
             [[Language alloc] initWithName:@"Chinese"      abbreviation:@"Chi"     bcp:@"zh-CN"],
             [[Language alloc] initWithName:@"Catalan"      abbreviation:@"Cat"     bcp:@"ca-ES"],
             [[Language alloc] initWithName:@"Dutch"        abbreviation:@"Dut"     bcp:@"nl-NL"],
             [[Language alloc] initWithName:@"English"      abbreviation:@"Eng"     bcp:@"en-GB"],
	     [[Language alloc] initWithName:@"Estonian"     abbreviation:@"Est"     bcp:@"es-EE"],
             [[Language alloc] initWithName:@"Finnish"      abbreviation:@"Fin"     bcp:@"fi-FI"],
             [[Language alloc] initWithName:@"French"       abbreviation:@"Fre"     bcp:@"fr-FR"],
             [[Language alloc] initWithName:@"German"       abbreviation:@"Ger"     bcp:@"de-DE"],
             [[Language alloc] initWithName:@"Hindi"        abbreviation:@"Hin"     bcp:@"hi-IN"],
             [[Language alloc] initWithName:@"Italian"      abbreviation:@"Ita"     bcp:@"it-IT"],
             [[Language alloc] initWithName:@"Japanese"     abbreviation:@"Jpn"     bcp:@"ja-JP"],
             [[Language alloc] initWithName:@"Spanish"      abbreviation:@"Spa"     bcp:@"es-ES"],
             [[Language alloc] initWithName:@"Swedish"      abbreviation:@"Swe"     bcp:@"sv-SE"],
             [[Language alloc] initWithName:@"Thai"         abbreviation:@"Tha"     bcp:@"th-TH"]
             ];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[Language class]]) {
        return NO;
    }
    
    return [self isEqualToLanguage:(Language *)object];
}

- (NSUInteger)hash {
    return [self.name hash] ^ [self.bcp hash];
}

@end
