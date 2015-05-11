//
//  UITableViewCell+Customize.m
//  GF Offline Translator
//
//  Created by Cenny Davidsson on 2015-05-11.
//  Copyright (c) 2015 Grammatical Framework. All rights reserved.
//

#import "UITableViewCell+Customize.h"

@implementation UITableViewCell (Customize)

- (void)sizeImageViewToSize:(CGSize)size {

    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, size.width, size.height);
    [self.imageView.image drawInRect:imageRect];
    self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
