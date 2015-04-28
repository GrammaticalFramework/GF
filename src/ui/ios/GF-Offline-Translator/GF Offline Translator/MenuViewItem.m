//
//  MenuViewItem.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-04-28.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "MenuViewItem.h"
#import "StyleKitGF.h"

@implementation MenuViewItem


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [StyleKitGF drawMenyWithFrame:rect];
}


@end
