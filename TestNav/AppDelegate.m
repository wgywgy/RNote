//
//  AppDelegate.m
//  TestNav
//
//  Created by D on 13-7-15.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "AppDelegate.h"

#import "ChoosePhotoViewController.h"

#import "GetPassword1ViewController.h"

#import "MLNavigationController.h"

#import "mainViewController.h"

#import "NotePadViewController.h"

NSString * const TextDidEdit = @"edit";

@implementation AppDelegate

- (void)selectThemeNight
{
    [[ThemeManager sharedInstance]setTheme:kThemeBlack];
}

- (void)selectThemeDay
{
    [[ThemeManager sharedInstance]setTheme:kThemeBlue];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"everLaunched"];
        [defaults setBool:YES forKey:@"firstLaunch"];
        [defaults synchronize];
    } else {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:@"firstLaunch"];
        [defaults synchronize];
    }
    

//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
//        // 这里判断是否第一次 第一次设置密码
//        self.viewController = [[ChoosePhotoViewController alloc]initWithNibName:@"ChoosePhotoViewController"
//                                                                         bundle:nil];
//        
//        MLNavigationController *navCtrl =
//        [[MLNavigationController alloc]initWithRootViewController:self.viewController];
//        self.window.rootViewController = navCtrl;
//        
//        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setBool:YES forKey:@"usePassword"];
//    } else {
//        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"usePassword"]) {
//            //解锁
//            self.secondviewController = [[GetPassword1ViewController alloc]initWithNibName:@"GetPassword1ViewController"
//                          bundle:nil];
//            MLNavigationController *navCtrl =
//            [[MLNavigationController alloc]initWithRootViewController:self.secondviewController];
//            self.window.rootViewController = navCtrl;
//        } else {
//            mainViewController *main = [[mainViewController alloc]init];
//            MLNavigationController *navCtrl =
//            [[MLNavigationController alloc]initWithRootViewController:main];
//            self.window.rootViewController = navCtrl;
//        }
//    }

    if (![UINavigationBar instancesRespondToSelector:
          @selector(setBackgroundImage:forBarMetrics:)]) {
		Swizzle([UINavigationBar class],
				@selector(setBackgroundImage:forBarMetrics:),
				@selector(setCustomizeImage:forBarMetrics:));
	}
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    
//    if ([defaults boolForKey:@"isEditing"]) {
//
//        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//        
//        [defaults setBool:NO forKey:@"isEditing"];
//        [defaults synchronize];
//        
//        [self noticeSaveTxt];
//    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}

- (void)noticeSaveTxt
{
    [[NSNotificationCenter defaultCenter]postNotificationName:TextDidEdit
                                                       object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        // 这里判断是否第一次 第一次设置密码
        self.viewController = [[ChoosePhotoViewController alloc]initWithNibName:@"ChoosePhotoViewController"
                                                                         bundle:nil];
        
        MLNavigationController *navCtrl =
        [[MLNavigationController alloc]initWithRootViewController:self.viewController];
        self.window.rootViewController = navCtrl;
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"usePassword"];
    } else {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"usePassword"]) {
            //解锁
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"password1"]) {
                self.secondviewController = [[GetPassword1ViewController alloc]initWithNibName:@"GetPassword1ViewController" bundle:nil];
                MLNavigationController *navCtrl =
                [[MLNavigationController alloc]initWithRootViewController:self.secondviewController];
                self.window.rootViewController = navCtrl;
            } else {
                self.viewController = [[ChoosePhotoViewController alloc]initWithNibName:@"ChoosePhotoViewController"
                                                                                 bundle:nil];
                
                MLNavigationController *navCtrl =
                [[MLNavigationController alloc]initWithRootViewController:self.viewController];
                self.window.rootViewController = navCtrl;
            }

        } else {
                mainViewController *main = [[mainViewController alloc]init];
                MLNavigationController *navCtrl =
                [[MLNavigationController alloc]initWithRootViewController:main];
                
                self.window.rootViewController = navCtrl;
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
