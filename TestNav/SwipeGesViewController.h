//
//  SwipeGesViewController.h
//  TestNav
//
//  Created by D on 13-9-2.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeGesViewController : UIViewController <
                                    UIGestureRecognizerDelegate>
{
    CGRect rect_screen;
}

@property (nonatomic, retain) UIImage * arrow;
@property (nonatomic, retain) UIImageView *arrowView;
@end
