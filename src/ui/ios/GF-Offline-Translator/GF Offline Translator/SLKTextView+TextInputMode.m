//
//  SLKTextView+TextInputMode.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-05-05.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "SLKTextView+TextInputMode.h"
#import <objc/runtime.h>

@implementation SLKTextView (TextInputMode)

static char userDefinedKeyboardLanguageKey;

- (NSString *)userDefinedKeyboardLanguage {
    return objc_getAssociatedObject(self, &userDefinedKeyboardLanguageKey);
}

- (void)setUserDefinedKeyboardLanguage:(NSString *)aString {
    objc_setAssociatedObject(self, &userDefinedKeyboardLanguageKey, aString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITextInputMode *) textInputMode {
    for (UITextInputMode *tim in [UITextInputMode activeInputModes]) {
        if ([[SLKTextView langFromLocale:self.userDefinedKeyboardLanguage] isEqualToString:[SLKTextView langFromLocale:tim.primaryLanguage]])  {
            return tim;
        }
    }
    return [super textInputMode];
}

+ (NSString *)langFromLocale:(NSString *)locale {
    NSRange rangeOne = [locale rangeOfString:@"_"];
    if (rangeOne.length == 0)
        rangeOne.location = locale.length;

    NSRange rangeTwo = [locale rangeOfString:@"-"];
    if (rangeTwo.length == 0)
        rangeTwo.location = locale.length;
    
    return [[locale substringToIndex:MIN(rangeOne.location, rangeTwo.location)] lowercaseString];
}

@end
