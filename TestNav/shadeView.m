//
//  shadeView.m
//  DemoCellColor
//
//  Created by D on 13-3-23.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "shadeView.h"

@implementation shadeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    topColor = [UIColor colorWithRed:43/255.0 green:155/255.0
                                             blue:230/255.0 alpha:1.0].CGColor;
    bottomColor = [UIColor colorWithRed:15.0/255.0 green:119.0/255.0
                                                blue:189.0/255.0 alpha:1.0].CGColor;
    CGRect paperRect = self.bounds;
    drawLinearGradient(context, paperRect, topColor, bottomColor);
}

void drawLinearGradient(CGContextRef context, CGRect rect,
                        CGColorRef startColor, CGColorRef  endColor) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = [NSArray arrayWithObjects:(__bridge id)startColor, (__bridge id)endColor, nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
                                                        (__bridge CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);

}
@end
