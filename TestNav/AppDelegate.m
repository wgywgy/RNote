//
//  AppDelegate.m
//  TestNav
//
//  Created by D on 13-7-15.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "AppDelegate.h"

//#import "ChoosePhotoViewController.h"

//#import "GetPassword1ViewController.h"

#import "MLNavigationController.h"

#import "mainViewController.h"

#import "NotePadViewController.h"

#import "LTHPasscodeViewController.h"

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
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

//    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
//        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setBool:YES forKey:@"everLaunched"];
//        [defaults setBool:YES forKey:@"firstLaunch"];
//        [defaults synchronize];
//    } else {
//        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setBool:NO forKey:@"firstLaunch"];
//        [defaults synchronize];
//    }
    

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
    
    mainViewController *main = [[mainViewController alloc]init];
    MLNavigationController *navCtrl =
    [[MLNavigationController alloc]initWithRootViewController:main];
    
    self.window.rootViewController = navCtrl;


    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{


}

- (void)noticeSaveTxt
{
    [[NSNotificationCenter defaultCenter]postNotificationName:TextDidEdit
                                                       object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        // 这里判断是否第一次 第一次设置密码
//        self.viewController = [[ChoosePhotoViewController alloc]initWithNibName:@"ChoosePhotoViewController"
//                                                                         bundle:nil];
        
//        MLNavigationController *navCtrl =
//        [[MLNavigationController alloc]initWithRootViewController:self.viewController];
//        self.window.rootViewController = navCtrl;
        
//        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setBool:YES forKey:@"usePassword"];
//    } else {
//        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"usePassword"]) {
            //解锁
//            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"password1"]) {
//                self.secondviewController = [[GetPassword1ViewController alloc]initWithNibName:@"GetPassword1ViewController" bundle:nil];
//                MLNavigationController *navCtrl =
//                [[MLNavigationController alloc]initWithRootViewController:self.secondviewController];
//                self.window.rootViewController = navCtrl;
//            } else {
//                self.viewController = [[ChoosePhotoViewController alloc]initWithNibName:@"ChoosePhotoViewController"
//                                                                                 bundle:nil];
            
//                MLNavigationController *navCtrl =
//                [[MLNavigationController alloc]initWithRootViewController:self.viewController];
//                self.window.rootViewController = navCtrl;
//            }

//        } else {
//                mainViewController *main = [[mainViewController alloc]init];
//                MLNavigationController *navCtrl =
//                [[MLNavigationController alloc]initWithRootViewController:main];
//            
//                self.window.rootViewController = navCtrl;
//        }
//    }
    if ([LTHPasscodeViewController passcodeExistsInKeychain]) {
		[LTHPasscodeViewController sharedUser];
		if ([LTHPasscodeViewController didPasscodeTimerEnd])
			[[LTHPasscodeViewController sharedUser] showLockscreen];
	}
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
