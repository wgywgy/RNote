//
//  UIColor+NoteAdditions.m
//  TestNav
//
//  Created by D on 13-7-29.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "UIColor+NoteAdditions.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIColor (NoteAdditions)

+ (UIColor *)tableViewBackgroundColor {
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"messages_tableview_background"] ];
}

+ (UIColor *)tableViewDrakBackgroundColor {
    return [UIColor colorWithPatternImage:[[UIImage imageNamed:@"messages_tableview_background"]
                                           imageWithGradientTintColor:[UIColor tableViewDarkBackgroundColor]]];
}

+ (UIColor *)tableViewDarkBackgroundColor
{
    return [UIColor colorWithRed:0.097 green:0.097 blue:0.097 alpha:1.0];
}

+ (UIColor *)paperWhiteColor {
    return UIColorFromRGB(0xf3f2ee);
}

+ (UIColor *)paperDarkGrayColor {
   return [UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0];
}

+ (UIColor *)fontDarkGrayColor {
    return [UIColor colorWithRed:0.247 green:0.247 blue:0.247 alpha:1.0];
}

+ (UIColor *)fontNightWhiteColor {
    return [UIColor colorWithRed:0.510 green:0.510 blue:0.510 alpha:1.0];
}

+ (UIColor *)fontBlackColor {
    return UIColorFromRGB(0x1f0909);
}

+ (UIColor *)boringColor;
{
    static UIColor *color;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:0.380f green:0.376f blue:0.376f alpha:1.000f];
    });
    return color;
}

+ (UIColor *)lineLightBlueColor
{
  return [UIColor colorWithRed:0.8 green:0.863 blue:1 alpha:1];
}

+ (UIColor *)lineLightYellowColor
{
    return [UIColor colorWithRed:0.929 green:0.918 blue:0.831 alpha:1.0];
}

+ (UIColor *)lineLightGrayColor
{
    return [UIColor colorWithRed:0.882 green:0.882 blue:0.882 alpha:1.0];
}

+ (UIColor *)lineLightRedColor
{
   return [UIColor colorWithRed:1 green:0.718 blue:0.718 alpha:1];
}

+ (UIColor *)lineDarkBlueColor {
    return UIColorFromRGB(0x065588);
}

+ (UIColor *)btnGrayColor {
   return [UIColor colorWithRed:0.549 green:0.549 blue:0.549 alpha:1.0];
}

+ (UIColor *)blueNavigationColor {
    return [UIColor colorWithRed:0.227 green:0.478 blue:0.784 alpha:1.0];
}

+ (UIColor *)redNavigationColor {
    return [UIColor colorWithRed:0.663 green:0.078 blue:0.000 alpha:1.0];
}
@end
