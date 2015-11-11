//
//  WebViewController.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-05-25.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "WebViewController.h"
#import "MorphAnalyser.h"


@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadHTMLString:self.htmlToRender baseURL:nil];
}

@end
