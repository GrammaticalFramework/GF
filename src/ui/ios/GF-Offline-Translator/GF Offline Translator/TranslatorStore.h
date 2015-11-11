//
//  TranslatorStore.h
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-06-22.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Translator;

@interface TranslatorStore : NSObject

/**
 *  Loads a translator with the last saved grammars on a background thread, if can't find anyone it loads defaults grammars wich are
 *  Swedish -> English.
 *
 *  @param completion A completion block with the loaded grammars
 */
+ (void)loadTranslatorWithCompletion:(void (^)(Translator *translator))completion;

/**
 *  Saves the current grammars names to NSUserDefaults.
 *
 *  @param translator The translator that contains the current grammars.
 */
+ (void)saveCurrentGrammarsFromTranslator:(Translator *)translator;

+ (void)switchLanguage:(Translator *)translator;

@end
