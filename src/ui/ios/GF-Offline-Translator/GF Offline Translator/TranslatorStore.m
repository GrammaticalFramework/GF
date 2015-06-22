//
//  TranslatorStore.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-06-22.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "TranslatorStore.h"
#import "AppDelegate.h"

// Model
#import "Translator.h"
#import "Language.h"
#include "Grammar.h"

@implementation TranslatorStore

+ (void)loadTranslatorWithCompletion:(void (^)(Translator *translator))completion {
    
    // Load grammars strings from NSUserDefaults
    NSString *fromLanguageString = [[NSUserDefaults standardUserDefaults] stringForKey:@"FromLanguage"];
    NSString *fromAbbreviationString = [[NSUserDefaults standardUserDefaults] stringForKey:@"FromAbbreviation"];
    NSString *fromBCPString = [[NSUserDefaults standardUserDefaults] stringForKey:@"FromBCP"];
    
    NSString *toLanguageString = [[NSUserDefaults standardUserDefaults] stringForKey:@"toLanguage"];
    NSString *toAbbreviationString = [[NSUserDefaults standardUserDefaults] stringForKey:@"toAbbreviation"];
    NSString *toBCPString = [[NSUserDefaults standardUserDefaults] stringForKey:@"toBCP"];
    
    if (!fromLanguageString) {
        fromLanguageString = @"Swedish";
        fromAbbreviationString = @"Swe";
        fromBCPString = @"sv-SE";
    
        toLanguageString = @"English";
        toAbbreviationString = @"Eng";
        toBCPString = @"en-GB";
    }
    
    // Setup translator
    Language *fromLanguage = [[Language alloc] initWithName:fromLanguageString abbreviation:fromAbbreviationString bcp:fromBCPString];
    Language *toLanguage = [[Language alloc] initWithName:toLanguageString abbreviation:toAbbreviationString bcp:toBCPString];
    __block Translator *translator = [[Translator alloc] init];
    
    dispatch_async(dispatch_queue_create("Load grammars",NULL), ^{
        translator.from = [Grammar loadGrammarFromLanguage:fromLanguage withTranslator:translator];
        translator.to = [Grammar loadGrammarFromLanguage:toLanguage withTranslator:translator];
        
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.translator = translator;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(translator);
        });
    });
}

+ (void)saveCurrentGrammarsFromTranslator:(Translator *)translator {
    
    
    [[NSUserDefaults standardUserDefaults] setObject:translator.from.language.name forKey:@"FromLanguage"];
    [[NSUserDefaults standardUserDefaults] setObject:translator.from.language.abbreviation forKey:@"FromAbbreviation"];
    [[NSUserDefaults standardUserDefaults] setObject:translator.from.language.bcp forKey:@"FromBCP"];
    
    [[NSUserDefaults standardUserDefaults] setObject:translator.to.language.name forKey:@"toLanguage"];
    [[NSUserDefaults standardUserDefaults] setObject:translator.to.language.abbreviation forKey:@"toAbbreviation"];
    [[NSUserDefaults standardUserDefaults] setObject:translator.to.language.bcp forKey:@"toBCP"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)switchLanguage:(Translator *)translator {
    
    Grammar *temp = translator.from;
    translator.from = translator.to;
    translator.to = temp;
}

@end
