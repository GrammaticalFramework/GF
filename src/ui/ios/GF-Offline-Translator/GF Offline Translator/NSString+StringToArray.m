//
//  NSString+stringToArray.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-06-03.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "NSString+stringToArray.h"

@implementation NSString (StringToArray)

- (NSArray *)stringToArray {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < [self length]; i++) {
        NSString *character = [self substringWithRange:NSMakeRange(i, 1)];
        [array addObject:character];
    }
    return array;
}

@end
