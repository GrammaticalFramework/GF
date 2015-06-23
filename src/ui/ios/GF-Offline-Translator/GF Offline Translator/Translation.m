//
//  Translation.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-06-03.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "Translation.h"
#import "Language.h"
#import <AVFoundation/AVFoundation.h>


@implementation Translation

@synthesize toTexts = _toTexts;

+ (instancetype)translationWithText:(NSString *)fromText
                             toText:(NSString *)toText
                       fromLanguage:(Language *)fromLanguage
                         toLanguage:(Language *)toLanguage {
    Translation *translation = [self new];
    
    translation.result = [Translation resultForText:toText];
    
    translation.toText = [Translation formatTranslation:toText];
    translation.fromText = fromText;
    
    translation.fromLanguage = fromLanguage;
    translation.toLanguage = toLanguage;
    
    return translation;
}

+ (TranslationResult)resultForText:(NSString *)text {
    
    NSString *firstChar = [text substringToIndex:1];
    
    if (text.length == 0) {
        return DefaultResult;
    }
    
    if ([firstChar isEqualToString:@"%"] ||
        [text rangeOfString:@"parse error:"].location != NSNotFound ||
        [text rangeOfString:@"["].location != NSNotFound) {
        return WorstResult;
    }
    
    if ([firstChar isEqualToString:@"*"]) {
        return ParseByChunksResult;
    }
    
    if ([firstChar isEqualToString:@"+"]) {
        return BestResult;
    }
    
    return DefaultResult;
}

+ (NSString *)formatTranslation:(NSString *)text {
    
    if (text.length == 0) {
        return text;
    }
    
    NSCharacterSet *charsToRemove = [NSCharacterSet characterSetWithCharactersInString:@"+*% "];
    NSString *trimmedText = [text stringByTrimmingCharactersInSet:charsToRemove];
    
    for (NSString *charToRemove in @[@"[", @"]", @"_"]) {
        trimmedText =[trimmedText stringByReplacingOccurrencesOfString:charToRemove withString:@" "];
    }
    
    return trimmedText;
}

- (void)speak {
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.toText];
    utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:self.toLanguage.bcp];
    
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc] init];
    [synthesizer speakUtterance:utterance];
}

#pragma mark - Setters & getters

- (NSString *)toText {
    if (!_toText) {
        return _fromText;
    }
    return _toText;
}

- (NSArray *)toTexts {
    if (nil) {
        return @[_fromText];
    }
    return _toTexts;
}

- (void)setToTexts:(NSArray *)toTexts {
    NSMutableArray *formatedTexts = [NSMutableArray new];
    for (NSString *text in toTexts) {
        [formatedTexts addObject:[Translation formatTranslation:text]];
    }
    _toTexts = formatedTexts.copy;
}

@end
