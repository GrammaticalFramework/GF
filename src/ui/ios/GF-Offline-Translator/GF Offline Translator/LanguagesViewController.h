//
//  LanguagesViewController.h
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-27.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TranslationTextViewController.h"
@class Language;


@interface LanguagesViewController : UITableViewController
@property (nonatomic, weak) id<TranslationTextViewControllerDelegate> delegate;
@property (nonatomic) NSArray *currentLanguages;
@property (nonatomic) BOOL fromLanguage;

@end
