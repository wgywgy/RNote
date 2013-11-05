//
//  GetPassword1ViewController.m
//  TestNav
//
//  Created by D on 13-7-23.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "GetPassword1ViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "MBHUDView.h"

#import "UIView+zoom.h"

#import "mainViewController.h"

@interface GetPassword1ViewController ()

@end

@implementation GetPassword1ViewController
@synthesize tmpImgView,img,center9;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UIImage*)captureViewframe:(CGRect)fra{
    UIGraphicsBeginImageContext(tmpImgView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [tmpImgView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef ref = CGImageCreateWithImageInRect(image.CGImage, fra);
    UIImage *i = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return i;
}

- (UIImage*)captureView:(UIView *)theView frame:(CGRect)fra{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef ref = CGImageCreateWithImageInRect(image.CGImage, fra);
    UIImage *i = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return i;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    rect_screen = [[UIScreen mainScreen]bounds];
//    self.title = NSLocalizedString(@"Password", @"");
    self.title = NSLocalizedString(@"FirstLevel Password", @"");
    self.navigationItem.backBarButtonItem = nil;
    [self addBtn];
    currentLevel = 1;
}

- (void)initViews
{
    [super initViews];
}

- (void)configureViews
{
    [super configureViews];
    
    // apply the theme
    if ( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlue] )
    {
//        _label.textColor = [UIColor blueColor];
//        NSLog(@"blue");
    }
    else if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] )
    {
//        _label.textColor = [UIColor blackColor];
//        NSLog(@"blue");
    }
}


- (void)addBtn
{
    img = [self getPasswordImage];
    tmpImgView=[[UIImageView alloc]initWithImage:img];
    tmpImgView.frame = CGRectMake(0, 0, rect_screen.size.width, rect_screen.size.height-64);
    [self.view addSubview:tmpImgView];
    
//    switch (btnTag) {
//        case 1:
//            base_img_frame = CGRectMake(0, 0, img.size.width /3, img.size.height /3);
//            break;
//        case 2:
//            base_img_frame = CGRectMake(img.size.width *1/3, 0, img.size.width /3, img.size.height /3);
//            break;
//        case 3:
//            base_img_frame = CGRectMake(img.size.width *2/3, 0, img.size.width /3, img.size.height /3);
//            break;
//        case 4:
//            base_img_frame = CGRectMake(0, img.size.height *1/3, img.size.width /3, img.size.height /3);
//            break;
//        case 5:
//            base_img_frame = CGRectMake(img.size.width *1/3, img.size.height *1/3, img.size.width /3, img.size.height /3);
//            break;
//        case 6:
//            base_img_frame = CGRectMake(img.size.width *2/3, img.size.height *1/3, img.size.width /3, img.size.height /3);
//            break;
//        case 7:
//            base_img_frame = CGRectMake(0, img.size.height *2/3, img.size.width /3, img.size.height /3);
//            break;
//        case 8:
//            base_img_frame = CGRectMake(img.size.width *1/3, img.size.height *2/3, img.size.width /3, img.size.height /3);
//            break;
//        case 9:
//            base_img_frame = CGRectMake(img.size.width *2/3, img.size.height *2/3, img.size.width /3, img.size.height /3);
//            break;
//            
//        default:
//            break;
//    }
    
//    UIImage *theImage1 =
//    [self captureViewframe:CGRectMake(0, 0,
//                                      (double)img.size.width /3, (double)img.size.height /3)];// 切割尺寸
    
//    _btn1 = [[UIButton alloc] initWithFrame:CGRectMake(4, 4, 304 /3, (rect_screen.size.height -80) /3)];
    _btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,
                                                       (double)320 /3, (double)(rect_screen.size.height -64) /3)];
    [_btn1 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_btn1 setBackgroundImage:theImage1 forState:UIControlStateNormal];
//    _btn1.layer.shadowOffset =  CGSizeMake(0, 0);
//    _btn1.layer.shadowOpacity = 0.8;
//    _btn1.layer.shadowColor =  [UIColor blackColor].CGColor;
//    _btn1.layer.shouldRasterize = YES;
    _btn1.tag = 1;
    
    [self.view addSubview:_btn1];
    
//    theImage1 =
//    [self captureViewframe:CGRectMake((double)img.size.width *1/3, 0,
//                                      (double)img.size.width /3, (double)img.size.height /3)];// 切割尺寸
    
//    _btn2 = [[UIButton alloc] initWithFrame:CGRectMake(304 *1/3 +8, 4, 304 /3, (rect_screen.size.height -80)/3)];
    _btn2 = [[UIButton alloc] initWithFrame:CGRectMake((double)320 *1/3, 0,
                                                       (double)320 /3, (double)(rect_screen.size.height-64) /3)];
    [_btn2 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_btn2 setBackgroundImage:theImage1 forState:UIControlStateNormal];
//    _btn2.layer.shadowOffset =  CGSizeMake(0, 0);
//    _btn2.layer.shadowOpacity = 0.8;
//    _btn2.layer.shadowColor = [UIColor blackColor].CGColor;
//    _btn2.layer.shouldRasterize = YES;
    _btn2.tag = 2;
    
    [self.view addSubview:_btn2];
    
//    theImage1 =
//    [self captureViewframe:CGRectMake((double)img.size.width *2/3, 0,
//                                      (double)img.size.width /3, (double)img.size.height /3)];// 切割尺寸
    
    _btn3 = [[UIButton alloc] initWithFrame:CGRectMake((double)320 *2/3, 0,
                                                       (double)320 /3, (double)(rect_screen.size.height -64) /3)];
//    _btn3 = [[UIButton alloc] initWithFrame:CGRectMake(304 *2/3 +12, 4, 304 /3, (rect_screen.size.height -80) /3)];
    [_btn3 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_btn3 setBackgroundImage:theImage1 forState:UIControlStateNormal];
    
//    _btn3.layer.shadowOffset =  CGSizeMake(0, 0);
//    _btn3.layer.shadowOpacity = 0.8;
//    _btn3.layer.shadowColor =  [UIColor blackColor].CGColor;
//    _btn3.layer.shouldRasterize = YES;
    _btn3.tag = 3;
    
    [self.view addSubview:_btn3];
    
//    theImage1 =
//    [self captureViewframe:CGRectMake(0, (double)img.size.height *1/3,
//                                      (double)img.size.width /3, (double)img.size.height /3)];// 切割尺寸
    
    _btn4 = [[UIButton alloc] initWithFrame:
             CGRectMake(0, (double)(rect_screen.size.height-64) *1/3,
                        (double)320 /3, (double)(rect_screen.size.height-64) /3)];
    [_btn4 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_btn4 setBackgroundImage:theImage1 forState:UIControlStateNormal];
    
//    _btn4.layer.shadowOffset =  CGSizeMake(0, 0);
//    _btn4.layer.shadowOpacity = 0.8;
//    _btn4.layer.shadowColor =  [UIColor blackColor].CGColor;
//    _btn4.layer.shouldRasterize = YES;
    _btn4.tag = 4;
    
    [self.view addSubview:_btn4];
    
//    theImage1 =
//    [self captureViewframe:CGRectMake((double)img.size.width *1/3, (double)img.size.height *1/3,
//                                      (double)img.size.width /3, (double)img.size.height /3)];// 切割尺寸
    
    _btn5 = [[UIButton alloc] initWithFrame:
             CGRectMake((double)320 *1/3, (double)(rect_screen.size.height - 64) * 1/3,
                        (double)320 /3, (double)(rect_screen.size.height -64) /3)];
    [_btn5 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_btn5 setBackgroundImage:theImage1 forState:UIControlStateNormal];
//    _btn5.layer.shadowOffset =  CGSizeMake(0, 0);
//    _btn5.layer.shadowOpacity = 0.8;
//    _btn5.layer.shadowColor =  [UIColor blackColor].CGColor;
//    _btn5.layer.shouldRasterize = YES;
    _btn5.tag = 5;
    
    [self.view addSubview:_btn5];
    
//    theImage1 =
//    [self captureViewframe:CGRectMake((double)img.size.width *2/3, (double)img.size.height *1/3,
//                                      (double)img.size.width /3, (double)img.size.height /3)];// 切割尺寸
    
    _btn6 = [[UIButton alloc] initWithFrame:
             CGRectMake((double)320 *2/3, (double)(rect_screen.size.height -64) * 1/3,
                        (double)320 /3, (double)(rect_screen.size.height -64) /3)];
    [_btn6 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_btn6 setBackgroundImage:theImage1 forState:UIControlStateNormal];
    
//    _btn6.layer.shadowOffset =  CGSizeMake(0, 0);
//    _btn6.layer.shadowOpacity = 0.8;
//    _btn6.layer.shadowColor =  [UIColor blackColor].CGColor;
//    _btn6.layer.shouldRasterize = YES;
    _btn6.tag = 6;
    
    [self.view addSubview:_btn6];
    
//    theImage1 =
//    [self captureViewframe:CGRectMake(0, (double)img.size.height *2/3,
//                                      (double)img.size.width /3, (double)img.size.height /3)];// 切割尺寸
    _btn7 = [[UIButton alloc] initWithFrame:
             CGRectMake(0, (double)(rect_screen.size.height -64) * 2/3,
                        (double)320 /3, (double)(rect_screen.size.height -64) /3)];
    [_btn7 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_btn7 setBackgroundImage:theImage1 forState:UIControlStateNormal];
    
//    _btn7.layer.shadowOffset =  CGSizeMake(0, 0);
//    _btn7.layer.shadowOpacity = 0.8;
//    _btn7.layer.shadowColor =  [UIColor blackColor].CGColor;
//    _btn7.layer.shouldRasterize = YES;
    _btn7.tag = 7;
    
    [self.view addSubview:_btn7];
    
//    theImage1 =
//    [self captureViewframe:CGRectMake((double)img.size.width *1/3, (double)img.size.height *2/3,
//                                      (double)img.size.width /3, (double)img.size.height /3)];// 切割尺寸
    _btn8 = [[UIButton alloc] initWithFrame:
             CGRectMake((double)320 *1/3, (double)(rect_screen.size.height -64) * 2/3,
                        (double)320 /3, (double)(rect_screen.size.height -64) /3) ];
    [_btn8 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_btn8 setBackgroundImage:theImage1 forState:UIControlStateNormal];
//    _btn8.layer.shadowOffset =  CGSizeMake(0, 0);
//    _btn8.layer.shadowOpacity = 0.8;
//    _btn8.layer.shadowColor =  [UIColor blackColor].CGColor;
//    _btn8.layer.shouldRasterize = YES;
    _btn8.tag = 8;
    
    [self.view addSubview:_btn8];
    
//    theImage1 =
//    [self captureViewframe:CGRectMake((double)img.size.width *2/3, (double)img.size.height *2/3,
//                                      (double)img.size.width /3, (double)img.size.height /3)];// 切割尺寸
    _btn9 = [[UIButton alloc] initWithFrame:
             CGRectMake((double)320 *2/3, (double)(rect_screen.size.height -64) * 2/3,
                        (double)320 /3, (double)(rect_screen.size.height -64) /3)];
    [_btn9 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_btn9 setBackgroundImage:theImage1 forState:UIControlStateNormal];
//    _btn9.layer.shadowOffset =  CGSizeMake(0, 0);
//    _btn9.layer.shadowOpacity = 0.8;
//    _btn9.layer.shadowColor =  [UIColor blackColor].CGColor;
//    _btn9.layer.shouldRasterize = YES;
    _btn9.tag = 9;
    
    [self.view addSubview:_btn9];
    
//    imageView=[[UIImageView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:imageView];
    [_btn9.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
    
    [_btn9.layer setBorderColor:colorref];
    CFRelease(colorref);
    CFRelease(colorSpace);
    
}

- (int)getPasswordLevel {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"passwordLevel"];
}

- (UIImage *)getPasswordImage {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"password.jpg"]]; // 保存文件的名称
    return [UIImage imageWithContentsOfFile:filePath];
}

- (NSArray *)themes
{
    return @[kThemeBlack, kThemeBlue];
}


- (void)pressBtn:(UIButton *)sender
{
//    [self selectThemeAtIndex:0];
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    int passwordLevel = [defaults integerForKey:@"passwordLevel"];
//    int password = 0;
//    switch (currentLevel) {
//        case 1:
//            password = [defaults integerForKey:@"password1"];
//            break;
//        case 2:
//            self.title = NSLocalizedString(@"SecondLevel Password", @"");
//            password = [defaults integerForKey:@"password2"];
//            break;
//        case 3:
//            self.title = NSLocalizedString(@"ThirdLevel Password", @"");
//            password = [defaults integerForKey:@"password3"];
//            break;
//        case 4:
//            self.title = NSLocalizedString(@"FourthLevel Password", @"");
//            password = [defaults integerForKey:@"password4"];
//            break;
//            
//        default:
//            break;
//    }
//    
//    NSLog(@"%d",password);
//    if (sender.tag == password) {
//        NSLog(@"passwordLevel:%d, current:%d",passwordLevel,currentLevel);
//        
//        if (currentLevel < passwordLevel) {
//            switch (currentLevel) {
//                case 1:
//                    [self zoomPasswordBackgroudWithTag:sender.tag];
//                    break;
//                case 2:
//                    [self zoomTransPasswordBackgroudWithTag:sender.tag];
//                    break;
//                case 3:
//                    [self zoomPasswordBackgroudWithTag:sender.tag];
//                    break;
//                case 4:
//                    break;
//                    
//                default:
//                    break;
//            }
//        } else {
            mainViewController *main = [[mainViewController alloc]init];
            [self.navigationController pushViewController:main animated:YES];
//    [self.navigationController presentViewController:main animated:YES completion:nil];
//        }
//        currentLevel++;
//    } else {
//        [MBHUDView hudWithBody:NSLocalizedString(@"Wrong Password", @"")
//                          type:MBAlertViewHUDTypeExclamationMark hidesAfter:2.0 show:YES];
//    }
}

- (void)zoomPasswordBackgroudWithTag:(int)posTag
{
//    CGRect smallFrame = CGRectMake(0, 0, 0, 0);
    CGPoint center = CGPointMake(0, 0);

    switch (posTag) {
        case 1:
            center = CGPointMake((double)_btn1.frame.size.width /2*5 +160,
                                 (double)_btn1.frame.size.height /2 +rect_screen.size.height +64);
            center9 = center;
            break;
        case 2:
            center = CGPointMake((double)_btn2.frame.size.width /2 *3,
                                 (double)_btn2.frame.size.height /2 +rect_screen.size.height +64);
            break;
        case 3:
//            smallFrame = CGRectMake((double)img.size.width *2/3, 0,
//                                    (double)img.size.width /3, (double)img.size.height /3);
//            tmpImgView.frame = _btn3.frame;
            center = CGPointMake((double)_btn3.frame.size.width /2 -160,
                                 (double)_btn3.frame.size.height /2 +rect_screen.size.height +64);
            break;
        case 4:
//            smallFrame = CGRectMake(0, (double)img.size.height *1/3,
//                                    (double)img.size.width /3, (double)img.size.height /3);
            //            tmpImgView.frame = _btn4.frame;
            center = CGPointMake((double)_btn4.frame.size.width /2*5 +160,
                                 (double)_btn4.frame.size.height /2 *3 );
            break;
        case 5:
//            smallFrame = CGRectMake((double)img.size.width *1/3, (double)img.size.height *1/3,
//                                    (double)img.size.width /3, (double)img.size.height /3);
//            tmpImgView.frame = _btn5.frame;
            center = CGPointMake((double)_btn5.frame.size.width /2 *3,
                                 (double)_btn5.frame.size.height /2 *3);
            break;
        case 6:
//            tmpImgView.frame = _btn6.frame;
            center = CGPointMake((double)_btn6.frame.size.width /2 -160, (double)_btn6.frame.size.height /2 *3);
            break;
        case 7:
//            smallFrame = CGRectMake(0, (double)img.size.height *2/3,
//                                    (double)img.size.width /3, (double)img.size.height /3);
//            center = CGPointMake((double)_btn7.frame.size.width /2, (double)_btn7.frame.size.height /2 *5);
            center = CGPointMake((double)_btn9.frame.size.width /2 *5 + 160,
                                 (double)_btn9.frame.size.height /2 *5 -rect_screen.size.height -64 );

//            tmpImgView.frame = _btn7.frame;
            break;
        case 8:
//            smallFrame = CGRectMake((double)img.size.width *1/3, (double)img.size.height *2/3,
//                                    (double)img.size.width /3, (double)img.size.height /3);
            center = CGPointMake((double)_btn8.frame.size.width /2 *3,
                                 (double)_btn8.frame.size.height /2 *5-rect_screen.size.height -64);
//            tmpImgView.frame = _btn8.frame;
            break;
        case 9:
//            smallFrame = CGRectMake((double)img.size.width *2/3, (double)img.size.height *2/3,
//                                    (double)img.size.width /3, (double)img.size.height /3);
//            tmpImgView.frame = _btn9.frame;
            center = CGPointMake((double)_btn9.frame.size.width /2 - 160,
                                 (double)_btn9.frame.size.height /2 *5 -rect_screen.size.height -64 );
//            center = CGPointMake((double)_btn9.frame.size.width /2 *5 + 160,
//                                 (double)_btn9.frame.size.height /2 *5 -rect_screen.size.height -64 );
            center9 = center;
            break;
            
        default:
            break;
    }
//    NSLog(@"%f,%f,%f,%f",smallFrame.origin.x, smallFrame.origin.y, img.size.width,img.size.height);
    
//    tmpImgView.image = img;
//    tmpImgView.frame = _btn5.frame;
//    [self.view addSubview:tmpAdd];
    NSLog(@"%f,%f",center.x,center.y);
    [tmpImgView zoomWithCenter:center];
    tmpImgView.image = [self captureViewframe:CGRectMake(0,0,320,rect_screen.size.height -64)];
//    tmpImgView.frame = CGRectMake(0,0,320,rect_screen.size.height -64);
//    tmpImgView.center = center;
    //    UIImage *theImage1 =
//    [self captureView:tmpImgView frame:_btn5.frame];// 切割尺寸
//    tmpImgView.image = theImage1;
    //    tmpImgView.image = theImage1;
//    tmpImgView.frame = _btn5.frame;

//    tmpImgView
//    [tmpImgView zoom];
}

- (void)zoomTransPasswordBackgroudWithTag:(int)posTag {
    CGPoint center = CGPointMake(0, 0);
//    CGPoint center1 = CGPointMake(0, 0);
    
    switch (posTag) {
        case 1:
//            center1 = CGPointMake((double)_btn1.frame.size.width /2 + 160,
//                                 (double)_btn1.frame.size.height /2 *5 -rect_screen.size.height -64 );
            break;
        case 2:
            center = CGPointMake((double)_btn2.frame.size.width /2 *3,
                                 (double)_btn2.frame.size.height /2 +rect_screen.size.height +64);
            break;
        case 3:
            center = CGPointMake((double)_btn3.frame.size.width /2 -160,
                                 (double)_btn3.frame.size.height /2 +rect_screen.size.height +64);
            break;
        case 4:
            center = CGPointMake((double)_btn4.frame.size.width /2*5 +160,
                                 (double)_btn4.frame.size.height /2 *3 );
            break;
        case 5:
            center = CGPointMake((double)_btn5.frame.size.width /2 *3,
                                 (double)_btn5.frame.size.height /2 *3);
            break;
        case 6:
            center = CGPointMake((double)_btn6.frame.size.width /2 -160, (double)_btn6.frame.size.height /2 *3);
            break;
        case 7:
            center = CGPointMake((double)_btn9.frame.size.width /2 *5 + 160,
                                 (double)_btn9.frame.size.height /2 *5 -rect_screen.size.height -64 );
            break;
        case 8:
            center = CGPointMake((double)_btn8.frame.size.width /2 *3,
                                 (double)_btn8.frame.size.height /2 *5-rect_screen.size.height -64);
            break;
        case 9:
//            center = CGPointMake(-1 * (double)_btn9.frame.size.width /2 - 160,
//                                 -1 * (double)_btn9.frame.size.height /2 *5 -rect_screen.size.height -64 );
            center = CGPointMake((double)_btn9.frame.size.width /2*5 +160,
                                 (double)_btn9.frame.size.height /2 +rect_screen.size.height +64);
            break;
            
        default:
            break;
    }
    NSLog(@"%f,%f",center.x,center.y);
            center = center9;
    [tmpImgView zoomWithCenter:center];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
