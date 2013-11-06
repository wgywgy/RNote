//
//  SwitchCell.h
//  TestNav
//
//  Created by D on 13-8-1.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KLSwitch.h"

#import "mySettingsViewController.h"
#import "LTHPasscodeViewController.h"

@interface SwitchCell : UITableViewCell <LTHPasscodeViewControllerDelegate>//<changeSwitchColorDelegate>
{
        CGRect rect_screen;
        UIViewController *parent;
}

@property (nonatomic, retain) UISwitch *switchView;
@property (nonatomic, retain) UIViewController *parent;
@end
