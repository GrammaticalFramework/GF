//
//  TranslationOptionsViewController.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-05-11.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "TranslationOptionsViewController.h"
#import "PhraseTranslation.h"
#import "WordTranslation.h"
#import "WebViewController.h"

@implementation TranslationOptionsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.translation.toTexts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier =  @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.translation.toTexts[indexPath.row];
    
    if ([self.translation isMemberOfClass:[WordTranslation class]]) {
        WordTranslation *translation = (WordTranslation *)self.translation;
        NSString *html = translation.html[indexPath.row];
        
        if (html.length > 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
            
    } else if ([self.translation isMemberOfClass:[PhraseTranslation class]]) {
        PhraseTranslation *translation = (PhraseTranslation *)self.translation;
        cell.detailTextLabel.text = translation.sequences[indexPath.row];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"WebView" sender:indexPath];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];

    // WebView
    if ([sender isKindOfClass:[NSIndexPath class]] &&
        [self.translation isMemberOfClass:[WordTranslation class]]) {

        WordTranslation *translation = (WordTranslation *)self.translation;
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        
        WebViewController *webVC = segue.destinationViewController;
        webVC.title = translation.toText;
        webVC.htmlToRender = translation.html[indexPath.row];
    }
}

@end
