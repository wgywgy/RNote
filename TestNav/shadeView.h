//
//  shadeView.h
//  DemoCellColor
//
//  Created by D on 13-3-23.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shadeView : UIView
{
    CGColorRef topColor;
    CGColorRef bottomColor;
}
@property (nonatomic,assign)    CGColorRef topColor;
@property (nonatomic,assign)    CGColorRef bottomColor;

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor,
                        CGColorRef  endColor);
@end
