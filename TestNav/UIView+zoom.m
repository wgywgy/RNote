//
//  UIView+zoom.m
//  TestNav
//
//  Created by D on 13-7-19.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "UIView+zoom.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (zoom)

- (void)zoom
{
    CGAffineTransform transform;
    transform = CGAffineTransformScale(self.transform,3,3);
    [UIView beginAnimations:@"scale"context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(160, (double)([[UIScreen mainScreen]bounds].size.height /2) -32);
    [self setTransform:transform];
    [UIView commitAnimations];
}

- (void)zoomWithCenter:(CGPoint)mycenter
{
    CGAffineTransform transform;
    transform = CGAffineTransformScale(self.transform,3,3);
    [UIView beginAnimations:@"scale"context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [self setTransform:transform];
    self.center = mycenter;
    [UIView commitAnimations];
}
@end
