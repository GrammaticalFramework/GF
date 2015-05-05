//
//  ArrowsButton.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-27.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "ArrowsButton.h"
#import "StyleKitGF.h"

@implementation ArrowsButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [StyleKitGF drawArrowsWithFrame:rect];
}


@end
