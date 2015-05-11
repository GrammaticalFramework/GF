//
//  Language.h
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-28.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Language : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *abbreviation;
@property (nonatomic, copy) NSString *bcp;


- (instancetype)initWithName:(NSString *)name
                abbreviation:(NSString *)abbreviation
                         bcp:(NSString *)bcp;

- (BOOL)isEqualToLanguage:(Language *)language;
+ (NSArray *)allLanguages;

@end
