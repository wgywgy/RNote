//
//  UIToolView.h
//  segmentView
//
//  Created by D on 13-11-13.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMGridView.h"
#import <QuartzCore/QuartzCore.h>

#define BARHEIGHT 40
@class PPiFlatSegmentedControl;
@interface UIToolView : UIView<UITableViewDataSource,UITableViewDelegate,
                            GMGridViewDataSource, GMGridViewSortingDelegate, GMGridViewActionDelegate>
{
    int selectIndex;
    __gm_weak GMGridView *_gmGridView;
    UINavigationController *_optionsNav;
    UIPopoverController *_optionsPopOver;
    
    NSMutableArray *_data;
    __gm_weak NSMutableArray *_currentData;
    NSInteger _lastDeleteItemIndexAsked;
    CGRect rect_screen;
}

@property (nonatomic, retain) NSMutableArray *segOneArray, *segTwoArray, *segThreeArray;
@property (nonatomic, retain) PPiFlatSegmentedControl *segmented;
@property (nonatomic, retain) UITableView *myTableview;
@property (nonatomic, retain) UIView *backgroundView;
@end
