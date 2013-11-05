//
//  ChoosePositionViewController.h
//  TestNav
//
//  Created by D on 13-7-17.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePositionViewController : BaseViewController
{
    CGRect rect_screen;
//    UIImageView *imageView;
    float ios7_height;
}

@property (nonatomic, retain) UIView *theView;
@property (nonatomic, retain) UIImageView *tmpImgView;
@property (nonatomic, retain) UIButton *btn1, *btn2, *btn3, *btn4, *btn5, *btn6, *btn7, *btn8, *btn9;
@end