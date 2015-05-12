//
//  TranslationOptionsViewController.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-05-11.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "TranslationOptionsViewController.h"
#import "Translation.h"

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
    
    return cell;
}

@end
