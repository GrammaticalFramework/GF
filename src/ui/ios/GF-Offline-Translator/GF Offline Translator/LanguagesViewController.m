//
//  LanguagesViewController.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-27.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "LanguagesViewController.h"
#import "Language.h"
#import "UITableViewCell+Customize.h"

@interface LanguagesViewController ()

@property (nonatomic) NSArray *languages;

@end

@implementation LanguagesViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Removes already used languages
    NSMutableArray *allLanguagesMutableCopy = Language.allLanguages.mutableCopy;
    [allLanguagesMutableCopy removeObjectsInArray:self.currentLanguages];
    self.languages = allLanguagesMutableCopy.copy;
}

#pragma mark - User Interaction

- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.languages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LanguageCell" forIndexPath:indexPath];
    
    Language *language = self.languages[indexPath.row];
    cell.textLabel.text = language.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Language *language = self.languages[indexPath.row];
    
    [self.delegate changeLanguageToLanguage:language isFrom:self.fromLanguage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
