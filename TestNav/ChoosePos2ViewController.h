//
//  ChoosePos2ViewController.h
//  TestNav
//
//  Created by D on 13-7-19.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePos2ViewController : BaseViewController
{
    CGRect rect_screen;
    UIImageView *imageView;
    int btnTag;
    CGRect base_img_frame;
    float ios7_height;
}

@property (nonatomic,retain) UIButton *btn1, *btn2, *btn3, *btn4, *btn5, *btn6, *btn7, *btn8, *btn9;

@property (nonatomic) int btnTag;

@end
