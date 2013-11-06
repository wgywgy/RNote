//
//  BaseViewController.m
//  SkinnedUI
//
//  Created by QFish on 12/2/12.
//  Copyright (c) 2012 http://QFish.Net All rights reserved.
//

#import "BaseViewController.h"

#import "UIColor+NoteAdditions.h"

#import "DeviceSystem.h"

@interface BaseViewController ()

@property (assign, nonatomic) BOOL didAppear;

@end

@implementation BaseViewController

- (void)dealloc
{
    // unregister as observer for theme status
    [self unregisterAsObserver];
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {

        self.didAppear = NO;
        
        // register as observer for theme status
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlue] )
    {
        NSDictionary * dict = @{UITextAttributeTextColor:[UIColor whiteColor]};
        self.navigationController.navigationBar.titleTextAttributes = dict;
    }
    else if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeRed] )
    {
        NSDictionary * dict = @{UITextAttributeTextColor:[UIColor whiteColor]};

        self.navigationController.navigationBar.titleTextAttributes = dict;
    }
    else if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] ) {
        NSDictionary * dict = @{UITextAttributeTextColor:[UIColor fontNightWhiteColor]};
        self.navigationController.navigationBar.titleTextAttributes = dict;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self regitserAsObserver];
    [self initViews];
    [self configureViews];
//    [self.navigationController.navigationBar setBackgroundImage:ThemeImage(@"header_bg") forBarMetrics:UIBarMetricsDefault];
//    self.edgesForExtendedLayout = UIRectEdgeBottom;
//    self.edges
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Theme Methods

- (void)initViews
{
    // may do nothing, implement by the subclass
}

- (void)configureViews
{
    // set the background of navigationbar
    // 检测系统版本
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        [self setNeedsStatusBarAppearanceUpdate];
        if ( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlue] )
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                self.navigationController.navigationBar.barTintColor =
                [UIColor colorWithRed:0.048 green:0.539 blue:1.000 alpha:1.0];
            }

            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        if ( [[[ThemeManager sharedInstance] theme] isEqual:kThemeRed]) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                self.navigationController.navigationBar.barTintColor =
                [UIColor redColor];
            }
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
        if ( [[[ThemeManager sharedInstance] theme] isEqual:kThemeBlack]) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                self.navigationController.navigationBar.barTintColor =
                [UIColor blackColor];
            }
        }
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    else {

        [self.navigationController.navigationBar setBackgroundImage:ThemeImage(@"header_bg")
                                            forBarMetrics:UIBarMetricsDefault];
    }
    
//    if ( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlue] )
//    {
        NSDictionary * dict = @{UITextAttributeTextColor:[UIColor whiteColor]};
        self.navigationController.navigationBar.titleTextAttributes = dict;
//    }
//    else if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeRed] )
//    {
//        NSDictionary * dict = @{UITextAttributeTextColor:[UIColor whiteColor]};
//        self.navigationController.navigationBar.titleTextAttributes = dict;
//    }
//    else if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] ) {
//        NSDictionary * dict = @{UITextAttributeTextColor:[UIColor fontNightWhiteColor]};
//        self.navigationController.navigationBar.titleTextAttributes = dict;
//    }
}

- (void)changeTextColor
{
    
}

- (void)changeBackGround
{
    
}

- (void)regitserAsObserver
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(configureViews)
                   name:ThemeDidChangeNotification
                 object:nil];
}

- (void)unregisterAsObserver
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

@end
