//
//  ViewController.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-27.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "ViewController.h"
#import "pgf/pgf.h"
#import "gu/mem.h"
#import "gu/exn.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"App" ofType:@"pgf" inDirectory:@"grammars"];
    
    
    // Create the pool that is used to allocate everything
    GuPool* pool = gu_new_pool();
    // test
    
    // Create an exception frame that catches all errors.
    GuExn* err = gu_new_exn(pool);
    
    // Read the PGF grammar.
    PgfPGF* pgf = pgf_read([path UTF8String], pool, err);

    
    printf("%p", pgf);
}

@end
