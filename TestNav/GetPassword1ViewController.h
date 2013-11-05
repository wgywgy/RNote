//
//  GetPassword1ViewController.h
//  TestNav
//
//  Created by D on 13-7-23.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetPassword1ViewController : BaseViewController
{
    CGRect rect_screen;
//    UIImageView *imageView;
    int currentLevel;
}
@property (nonatomic, retain) UIImageView *tmpImgView;
@property (nonatomic, retain) UIImage *img;
@property (nonatomic)CGPoint center9;

@property (nonatomic,retain) UIButton *btn1, *btn2, *btn3, *btn4, *btn5, *btn6, *btn7, *btn8, *btn9;
- (void)zoomPasswordBackgroudWithTag:(int)posTag;
- (void)zoomTransPasswordBackgroudWithTag:(int)posTag;
@end
