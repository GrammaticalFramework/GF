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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.languages = Language.allLanguages;
}

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
    
    // Setup flag image
    NSString *imageName = language.abbreviation;
    [cell.imageView setImage:[UIImage imageNamed:imageName]];
    [cell sizeImageViewToSize:CGSizeMake(35, 20)];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Language *language = self.languages[indexPath.row];
    
    if (self.fromLanguage) {
        [self.delegate changeFromLanguageToLanguage:language];
    } else {
        [self.delegate changeToLanguageToLanguage:language];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
