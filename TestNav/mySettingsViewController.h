//
//  mySettingsViewController.h
//  TableViewCustom
//
//  Created by D on 13-7-29.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFNetworking.h"
#import "LTHPasscodeViewController.h"

@protocol changeSwitchColorDelegate;
@protocol changeSwitchColorDelegate
- (void)changeColor:(NSString *)color;
@end

@interface mySettingsViewController : BaseViewController
<UITableViewDelegate, UITableViewDataSource, LTHPasscodeViewControllerDelegate>
{
    CGRect rect_screen;
}

@property (strong, nonatomic) UITableView *myTableView;
@property (nonatomic, retain) NSArray * content;
@property (nonatomic, retain) NSArray * picName;
@property (nonatomic, retain) NSDictionary *verResult;

@property (nonatomic, retain) UIButton *doneBtn;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) UILabel *footer;
@property (nonatomic, retain) id<changeSwitchColorDelegate> changeColorDelegate;
@property (nonatomic, retain) AFJSONRequestOperation *operation;

@end
