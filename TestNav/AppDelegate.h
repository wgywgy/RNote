//
//  AppDelegate.h
//  TestNav
//
//  Created by D on 13-7-15.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const TextDidEdit;

//@class ChoosePhotoViewController;
//@class GetPassword1ViewController;

@class LTHPasscodeViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    LTHPasscodeViewController *_passcodeController;
}
@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) ChoosePhotoViewController *viewController;
//@property (strong, nonatomic) GetPassword1ViewController *secondviewController;

@end
