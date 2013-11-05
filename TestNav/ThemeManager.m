//
//  ThemeManager.m
//  SkinnedUI
//
//  Created by QFish on 12/3/12.
//  Copyright (c) 2012 QFish.Net. All rights reserved.
//

#import "ThemeManager.h"

NSString * const ThemeDidChangeNotification = @"change";

@implementation ThemeManager

@synthesize theme = _theme;

+ (ThemeManager *)sharedInstance
{
    static dispatch_once_t once;
    static ThemeManager *instance = nil;
    dispatch_once( &once, ^{ instance = [[ThemeManager alloc] init]; } );
    return instance;
}

- (NSString *)theme
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    _theme = [defaults objectForKey:@"Theme"];
//    NSLog(@"theme:%@",_theme);
    if ( _theme == nil ) {
        return @"Blue";
    }
    return _theme;
}

- (void)setTheme:(NSString *)theme
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:theme forKey:@"Theme"];
    [defaults synchronize];
//    _theme = [theme copy];
    _theme = theme;
    ThemeStatus status = ThemeStatusDidChange;

    [[NSNotificationCenter defaultCenter]postNotificationName:ThemeDidChangeNotification
                                                       object:[NSNumber numberWithInt:status]];
}

- (UIImage *)imageWithImageName:(NSString *)imageName
{
    NSString *directory = [NSString stringWithFormat:@"%@/%@", @"resource", [self theme]];

    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName
                                                          ofType:@"png"
                                                     inDirectory:directory];
//    NSLog(@"img: %@",[UIImage imageWithContentsOfFile:imagePath]);
//    NSLog(@"imgPath: %@",imagePath);
//    NSLog(@"imgPath: %@",directory);
    return [UIImage imageWithContentsOfFile:imagePath];
}

@end
