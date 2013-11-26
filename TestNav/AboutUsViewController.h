//
//  AboutUsViewController.h
//  TestNav
//
//  Created by D on 13-8-1.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "BaseViewController.h"
#import "RateButton.h"
#import <StoreKit/StoreKit.h>

@interface AboutUsViewController : BaseViewController <SKStoreProductViewControllerDelegate>
{
    CGRect rect_screen;
}
@property (weak, nonatomic) IBOutlet UILabel *AboutUsTitle;
@property (weak, nonatomic) IBOutlet UILabel *writer;
@property (weak, nonatomic) IBOutlet UIButton *website;
@property (weak, nonatomic) IBOutlet UIButton *weibo;
@property (weak, nonatomic) IBOutlet RateButton *rateBtn;
@property (nonatomic, retain) SKStoreProductViewController *storeProductViewContorller;
@end
