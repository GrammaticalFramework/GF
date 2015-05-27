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
    
    
    
    [self.webView loadHTMLString:@"<html><head><title></title></head><body style=\"background:transparent;\"><h1> Noun </h1> <p>  </p> <table rules=all border=yes> <tr> <th> </th> <th> nom </th> <th> gen </th> </tr> <tr> <th> sg </th> <td> cake </td> <td> cake's </td> </tr> <tr> <th> pl </th> <td> cakes </td> <td> cakes' </td> </tr> </table> <p>  </p></body></html>" baseURL:nil];
}

@end
