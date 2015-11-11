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
#import "SentenceTranslationUITableViewCell.h"

@implementation TranslationOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 19;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.translation.toTexts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([self.translation isMemberOfClass:[WordTranslation class]]) {
      
        NSString *identifier =  @"Basic";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
        WordTranslation *translation = (WordTranslation *)self.translation;
        NSString *html = translation.html[indexPath.row];
        
        cell.textLabel.text = translation.toTexts[indexPath.row];
        
        if (html.length > 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        return cell;
    } else if ([self.translation isMemberOfClass:[PhraseTranslation class]]) {
        
        NSString *identifier =  @"Cell";
        
        SentenceTranslationUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
        PhraseTranslation *translation = (PhraseTranslation *)self.translation;
        
        [cell configureCellWithSentenceInTableView:tableView
                                   withTranslation:translation.toTexts[indexPath.row]
                                           andTree:translation.sequences[indexPath.row]];
        return cell;
    }
    
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.translation isMemberOfClass:[WordTranslation class]]) {
        WordTranslation *translation = (WordTranslation *)self.translation;
        NSString *html = translation.html[indexPath.row];
        
        if (html.length > 0) {
            [self performSegueWithIdentifier:@"WebView" sender:indexPath];
        }
    }
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
