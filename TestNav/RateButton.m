//
//  RateButton.m
//  TestNav
//
//  Created by D on 13-11-25.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "RateButton.h"
#import "UIColor+NoteAdditions.h"

@interface RateButton ()
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *mainColor;
@end

@implementation RateButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    [self setTitleColor:[UIColor titleTextColor] forState:UIControlStateNormal];
    self.titleLabel.highlightedTextColor = [UIColor titleTextColor];
    self.titleLabel.textColor = [UIColor titleTextColor];
    self.titleLabel.shadowColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
}


- (void)drawRect:(CGRect)rect {
    if ([[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack]) {
        [self drawLightTheme];
    } else {
        [self drawDarkTheme];
    }
}

- (void)drawDarkTheme {
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* baseGradientBottomColor = [UIColor colorWithRed: 0.122 green: 0.122 blue: 0.122 alpha: 1];
    UIColor* buttonColor = [UIColor colorWithRed: 0.184 green: 0.184 blue: 0.184 alpha: 1];
    
    //// Gradient Declarations
    NSArray* baseGradientColors = [NSArray arrayWithObjects:
                                   (id)buttonColor.CGColor,
                                   (id)baseGradientBottomColor.CGColor, nil];
    CGFloat baseGradientLocations[] = {0, 1};
    CGGradientRef baseGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)baseGradientColors, baseGradientLocations);
    
    //// Shadow Declarations
    //    UIColor* buttonShadow = iconShadow;
    //    CGSize buttonShadowOffset = CGSizeMake(0.1, -0.1);
    //    CGFloat buttonShadowBlurRadius = 2;
    
    //// Frames
    CGRect frame = self.bounds;
    
    
    //// Button
    {
        //// ButtonRectangle Drawing
        CGRect buttonRectangleRect = CGRectMake(CGRectGetMinX(frame) + 2, CGRectGetMinY(frame) + 1, CGRectGetWidth(frame) - 4, CGRectGetHeight(frame) - 3);
        UIBezierPath* buttonRectanglePath = [UIBezierPath bezierPathWithRoundedRect: buttonRectangleRect cornerRadius: 3];
        CGContextSaveGState(context);
        //        CGContextSetShadowWithColor(context, buttonShadowOffset, buttonShadowBlurRadius, buttonShadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [buttonRectanglePath addClip];
        CGContextDrawLinearGradient(context, baseGradient,
                                    CGPointMake(CGRectGetMidX(buttonRectangleRect), CGRectGetMinY(buttonRectangleRect)),
                                    CGPointMake(CGRectGetMidX(buttonRectangleRect), CGRectGetMaxY(buttonRectangleRect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
    }
}

- (void)drawLightTheme {
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* baseGradientBottomColor = [UIColor colorWithRed: 0.945 green: 0.945 blue: 0.945 alpha: 1];
    UIColor* buttonColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* iconShadow = [UIColor colorWithRed: 0.2 green: 0.2 blue: 0.2 alpha: 1];
    
    //// Gradient Declarations
    NSArray* baseGradientColors = [NSArray arrayWithObjects:
                                   (id)buttonColor.CGColor,
                                   (id)baseGradientBottomColor.CGColor, nil];
    CGFloat baseGradientLocations[] = {0, 1};
    CGGradientRef baseGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)baseGradientColors, baseGradientLocations);
    
    //// Shadow Declarations
    UIColor* buttonShadow = iconShadow;
    CGSize buttonShadowOffset = CGSizeMake(0.1, -0.1);
    CGFloat buttonShadowBlurRadius = 2;
    
    //// Frames
    CGRect frame = self.bounds;
    
    
    //// Button
    {
        //// ButtonRectangle Drawing
        CGRect buttonRectangleRect = CGRectMake(CGRectGetMinX(frame) + 2, CGRectGetMinY(frame) + 1, CGRectGetWidth(frame) - 4, CGRectGetHeight(frame) - 3);
        UIBezierPath* buttonRectanglePath = [UIBezierPath bezierPathWithRoundedRect: buttonRectangleRect cornerRadius: 3];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, buttonShadowOffset, buttonShadowBlurRadius, buttonShadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [buttonRectanglePath addClip];
        CGContextDrawLinearGradient(context, baseGradient,
                                    CGPointMake(CGRectGetMidX(buttonRectangleRect), CGRectGetMinY(buttonRectangleRect)),
                                    CGPointMake(CGRectGetMidX(buttonRectangleRect), CGRectGetMaxY(buttonRectangleRect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
    }
    
    //// Cleanup
    CGGradientRelease(baseGradient);
    CGColorSpaceRelease(colorSpace);
}

@end
