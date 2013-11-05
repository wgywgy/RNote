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

@interface SwitchCell : UITableViewCell //<changeSwitchColorDelegate>
{
        CGRect rect_screen;
}
@property (nonatomic, retain) UISwitch *switchView;
@end
