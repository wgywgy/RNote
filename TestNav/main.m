//
//  main.m
//  TestNav
//
//  Created by D on 13-7-15.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

#import "CDITableViewCellDeleteConfirmationControl.h"

#import <objc/runtime.h>

int main(int argc, char *argv[])
{
    @autoreleasepool {
//        Class deleteControl = NSClassFromString([NSString stringWithFormat:@"_%@DeleteConfirmationControl", @"UITableViewCell"]);
//		if (deleteControl) {
//			Method drawRect = class_getInstanceMethod(deleteControl, @selector(drawRect:));
//			Method drawRectCustom = class_getInstanceMethod([CDITableViewCellDeleteConfirmationControl class], @selector(drawRectCustom:));
//			method_exchangeImplementations(drawRect, drawRectCustom);
//		}

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}