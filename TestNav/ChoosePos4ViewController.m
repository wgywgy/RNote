//
//  ChoosePos4ViewController.m
//  TestNav
//
//  Created by D on 13-7-19.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "ChoosePos4ViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "mainViewController.h"

#import "MBAlertView.h"

@interface ChoosePos4ViewController ()

@end

@implementation ChoosePos4ViewController
@synthesize btnTag,image;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIImage*)captureView:(UIView *)theView frame:(CGRect)fra{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, fra);
    UIImage *i = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return i;
}

- (void)addBtn
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:
//                          [NSString stringWithFormat:@"password.jpg"]]; // 保存文件的名称
//    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
//    UIImageView *tmpImgView=[[UIImageView alloc]initWithImage:img];
    
    UIImageView *tmpImgView = [[UIImageView alloc]initWithImage:image];
    
    switch (btnTag) {
        case 1:
            base_img_frame = CGRectMake(0, 0,
                                        (double)image.size.width /3, (double)image.size.height /3);
            break;
        case 2:
            base_img_frame = CGRectMake((double)image.size.width *1/3, 0,
                                        (double)image.size.width /3, (double)image.size.height /3);
            break;
        case 3:
            base_img_frame = CGRectMake((double)image.size.width *2/3, 0,
                                        (double)image.size.width /3, (double)image.size.height /3);
            break;
        case 4:
            base_img_frame = CGRectMake(0, (double)image.size.height *1/3,
                                        (double)image.size.width /3, (double)image.size.height /3);
            break;
        case 5:
            base_img_frame = CGRectMake((double)image.size.width *1/3, (double)image.size.height *1/3,
                                        (double)image.size.width /3, (double)image.size.height /3);
            break;
        case 6:
            base_img_frame = CGRectMake((double)image.size.width *2/3, (double)image.size.height *1/3,
                                        (double)image.size.width /3, (double)image.size.height /3);
            break;
        case 7:
            base_img_frame = CGRectMake(0, (double)image.size.height *2/3,
                                        (double)image.size.width /3, (double)image.size.height /3);
            break;
        case 8:
            base_img_frame = CGRectMake((double)image.size.width *1/3, (double)image.size.height *2/3,
                                        (double)image.size.width /3, (double)image.size.height /3);
            break;
        case 9:
            base_img_frame = CGRectMake((double)image.size.width *2/3, (double)image.size.height *2/3,
                                        (double)image.size.width /3, (double)image.size.height /3);
            break;
            
        default:
            break;
    }
    
    UIImage *theImage1 =
    [self captureView:tmpImgView
                frame:CGRectMake(0, 0, (double)image.size.width /3, (double)image.size.height /3)];// 切割尺寸
    
    _btn1 = [[UIButton alloc] initWithFrame:CGRectMake(4, 4,
                                                       (double)304 /3, (double)(rect_screen.size.height -80) /3)];
    [_btn1 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn1 setBackgroundImage:theImage1 forState:UIControlStateNormal];
    _btn1.layer.shadowOffset =  CGSizeMake(0, 0);
    _btn1.layer.shadowOpacity = 0.8;
    _btn1.layer.shadowColor =  [UIColor blackColor].CGColor;
    _btn1.layer.shouldRasterize = YES;
    _btn1.tag = 1;
    
    [self.view addSubview:_btn1];
    
    UIImage *theImage2 =
    [self captureView:tmpImgView
                frame:CGRectMake((double)image.size.width *1/3, 0,
                                 (double)image.size.width /3, (double)image.size.height /3)];// 切割尺寸
    
    _btn2 = [[UIButton alloc] initWithFrame:CGRectMake((double)304 *1/3 +8, 4,
                                                       (double)304 /3, (double)(rect_screen.size.height -80)/3)];
    [_btn2 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 setBackgroundImage:theImage2 forState:UIControlStateNormal];
    
    _btn2.layer.shadowOffset =  CGSizeMake(0, 0);
    _btn2.layer.shadowOpacity = 0.8;
    _btn2.layer.shadowColor =  [UIColor blackColor].CGColor;
    _btn2.layer.shouldRasterize = YES;
    _btn2.tag = 2;
    
    [self.view addSubview:_btn2];
    
    UIImage *theImage3 =
    [self captureView:tmpImgView
                frame:CGRectMake((double)image.size.width *2/3, 0,
                                 (double)image.size.width /3, (double)image.size.height /3)];// 切割尺寸
    
    _btn3 = [[UIButton alloc] initWithFrame:CGRectMake((double)304 *2/3 +12, 4,
                                                       (double)304 /3, (double)(rect_screen.size.height -80) /3)];
    [_btn3 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn3 setBackgroundImage:theImage3 forState:UIControlStateNormal];
    
    _btn3.layer.shadowOffset =  CGSizeMake(0, 0);
    _btn3.layer.shadowOpacity = 0.8;
    _btn3.layer.shadowColor =  [UIColor blackColor].CGColor;
    _btn3.layer.shouldRasterize = YES;
    _btn3.tag = 3;
    
    [self.view addSubview:_btn3];
    
    UIImage *theImage4 =
    [self captureView:tmpImgView
                frame:CGRectMake(0, (double)image.size.height *1/3,
                                 (double)image.size.width /3, (double)image.size.height /3)];// 切割尺寸
    
    _btn4 = [[UIButton alloc] initWithFrame:
             CGRectMake(4, (double)(rect_screen.size.height - 80) * 1/3 + 8,
                        (double)304 /3, (double)(rect_screen.size.height -80) /3)];
    [_btn4 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn4 setBackgroundImage:theImage4 forState:UIControlStateNormal];
    
    _btn4.layer.shadowOffset =  CGSizeMake(0, 0);
    _btn4.layer.shadowOpacity = 0.8;
    _btn4.layer.shadowColor =  [UIColor blackColor].CGColor;
    _btn4.layer.shouldRasterize = YES;
    _btn4.tag = 4;
    
    [self.view addSubview:_btn4];
    
    UIImage *theImage5 =
    [self captureView:tmpImgView
                frame:CGRectMake((double)image.size.width *1/3, (double)image.size.height *1/3,
                                 (double)image.size.width /3, (double)image.size.height /3)];// 切割尺寸
    
    _btn5 = [[UIButton alloc] initWithFrame:
             CGRectMake((double)304 *1/3 +8, (double)(rect_screen.size.height - 80) * 1/3 + 8,
                        (double)304 /3, (double)(rect_screen.size.height -80) /3)];
    [_btn5 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn5 setBackgroundImage:theImage5 forState:UIControlStateNormal];
    _btn5.layer.shadowOffset =  CGSizeMake(0, 0);
    _btn5.layer.shadowOpacity = 0.8;
    _btn5.layer.shadowColor =  [UIColor blackColor].CGColor;
    _btn5.layer.shouldRasterize = YES;
    _btn5.tag = 5;
    
    [self.view addSubview:_btn5];
    
    UIImage *theImage6 =
    [self captureView:tmpImgView
                frame:CGRectMake((double)image.size.width *2/3, (double)image.size.height *1/3,
                                 (double)image.size.width /3, (double)image.size.height /3)];// 切割尺寸
    
    _btn6 = [[UIButton alloc] initWithFrame:
             CGRectMake((double)304 *2/3 +12, (double)(rect_screen.size.height - 80) * 1/3 + 8,
                        (double)304 /3, (double)(rect_screen.size.height -80) /3)];
    [_btn6 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn6 setBackgroundImage:theImage6 forState:UIControlStateNormal];
    
    _btn6.layer.shadowOffset =  CGSizeMake(0, 0);
    _btn6.layer.shadowOpacity = 0.8;
    _btn6.layer.shadowColor =  [UIColor blackColor].CGColor;
    _btn6.layer.shouldRasterize = YES;
    _btn6.tag = 6;
    
    [self.view addSubview:_btn6];
    
    UIImage *theImage7 =
    [self captureView:tmpImgView
                frame:CGRectMake(0, (double)image.size.height *2/3,
                                 (double)image.size.width /3, (double)image.size.height /3)];// 切割尺寸
    _btn7 = [[UIButton alloc] initWithFrame:
             CGRectMake(4, (double)(rect_screen.size.height - 80) * 2/3 + 12,
                        (double)304 /3, (double)(rect_screen.size.height -80) /3)];
    [_btn7 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn7 setBackgroundImage:theImage7 forState:UIControlStateNormal];
    
    _btn7.layer.shadowOffset =  CGSizeMake(0, 0);
    _btn7.layer.shadowOpacity = 0.8;
    _btn7.layer.shadowColor =  [UIColor blackColor].CGColor;
    _btn7.layer.shouldRasterize = YES;
    _btn7.tag = 7;
    
    [self.view addSubview:_btn7];
    
    UIImage *theImage8 =
    [self captureView:tmpImgView
                frame:CGRectMake((double)image.size.width *1/3, (double)image.size.height *2/3,
                                 (double)image.size.width /3, (double)image.size.height /3)];// 切割尺寸
    _btn8 = [[UIButton alloc] initWithFrame:
             CGRectMake((double)304 *1/3 +8, (double)(rect_screen.size.height - 80) * 2/3 + 12,
                        (double)304 /3, (double)(rect_screen.size.height -80) /3) ];
    [_btn8 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn8 setBackgroundImage:theImage8 forState:UIControlStateNormal];
    _btn8.layer.shadowOffset =  CGSizeMake(0, 0);
    _btn8.layer.shadowOpacity = 0.8;
    _btn8.layer.shadowColor =  [UIColor blackColor].CGColor;
    _btn8.layer.shouldRasterize = YES;
    _btn8.tag = 8;
    
    [self.view addSubview:_btn8];
    
    UIImage *theImage9 =
    [self captureView:tmpImgView
                frame:CGRectMake((double)image.size.width *2/3, (double)image.size.height *2/3,
                                 (double)image.size.width /3, (double)image.size.height /3)];// 切割尺寸
    _btn9 = [[UIButton alloc] initWithFrame:
             CGRectMake((double)304 *2/3 +12, (double)(rect_screen.size.height - 80) * 2/3 + 12,
                        (double)304 /3, (double)(rect_screen.size.height -80) /3)];
    [_btn9 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn9 setBackgroundImage:theImage9 forState:UIControlStateNormal];
    
    _btn9.layer.shadowOffset =  CGSizeMake(0, 0);
    _btn9.layer.shadowOpacity = 0.8;
    _btn9.layer.shadowColor =  [UIColor blackColor].CGColor;
    _btn9.layer.shouldRasterize = YES;
    _btn9.tag = 9;
    
    [self.view addSubview:_btn9];
    
    imageView=[[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:imageView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"FourthLevel Password", @"");
    
    UIButton *Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 26)];
    [Btn addTarget:self action:@selector(returnHelpCenter:) forControlEvents:UIControlEventTouchUpInside];
    [Btn setImage:[UIImage imageNamed:@"arrow_left.png"]
         forState:UIControlStateNormal];
    [Btn setImageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:Btn];
    
    self.navigationItem.backBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = backItem;
    
    rect_screen = [[UIScreen mainScreen]bounds];
    [self addBtn];
}

-(IBAction)returnHelpCenter:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pressBtn:(UIButton *)sender
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:sender.tag forKey:@"password4"];
    [defaults synchronize];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    MBAlertView *alert = [MBAlertView alertWithBody:NSLocalizedString(@"Are you sure save password", @"")
                                        cancelTitle:NSLocalizedString(@"Cancel",@"")
                                        cancelBlock:^{
                                            [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
                                        }];
    [alert addButtonWithText:NSLocalizedString(@"Ok", @"") type:MBAlertViewItemTypePositive block:^{
        mainViewController *main = [[mainViewController alloc]init];
        [self.navigationController pushViewController:main animated:YES];}];
    [alert addToDisplayQueue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end