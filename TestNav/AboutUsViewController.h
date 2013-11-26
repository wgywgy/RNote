//
//  AboutUsViewController.h
//  TestNav
//
//  Created by D on 13-8-1.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "BaseViewController.h"
#import "RateButton.h"

@interface AboutUsViewController : BaseViewController
{
    CGRect rect_screen;
}
@property (weak, nonatomic) IBOutlet UILabel *AboutUsTitle;
@property (weak, nonatomic) IBOutlet UILabel *writer;
@property (weak, nonatomic) IBOutlet UIButton *website;
@property (weak, nonatomic) IBOutlet UIButton *weibo;
@property (weak, nonatomic) IBOutlet RateButton *rateBtn;
@end
