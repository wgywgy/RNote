//
//  AboutUsViewController.m
//  TestNav
//
//  Created by D on 13-8-1.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "AboutUsViewController.h"
#import "UIImage+Rotation.h"
#import "UIColor+NoteAdditions.h"
#import "UIImage+FontAwesome.h"
#import "FAImageView.h"
#import "NSString+FontAwesome.h"

#define appleID 530096786
static NSArray * kFontAwesomeStrings;
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    rect_screen = [[UIScreen mainScreen]bounds];
//    [self addLogo];
    
    UIButton *Btn = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 11, 18)];
        
        [Btn setImage:[UIImage imageNamed:@"Toolbar_back"]
             forState:UIControlStateNormal];

//        [Btn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];

    } else {
        Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 18)];
        
        [Btn setImage:[UIImage imageNamed:@"Toolbar_back"]
             forState:UIControlStateNormal];
//        [Btn setBackgroundImage:[[UIImage imageNamed:@"NavigationButtonBG"]
//                                 resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]
//                       forState:UIControlStateNormal];
    }
    
    [Btn addTarget:self action:@selector(returnHelpCenter:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:Btn];
    self.AboutUsTitle.text = NSLocalizedString(@"XX Studio", @"");
    
//    self.navigationItem.backBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = backItem;
    self.view.backgroundColor = [UIColor tableViewBackgroundColor];
    self.title = NSLocalizedString(@"AboutUs", @"");

//    FAImageView *imageView = [[FAImageView alloc] initWithFrame:CGRectMake(20.f, 20.f, 100.f, 100.f)];
//    imageView.image = nil;
//    [imageView setDefaultIconIdentifier:@"icon-github"];
//    [self.view addSubview:imageView];
//    UIImage *rateImg = [UIImage imageWithIcon:@"icon-star"
//                              backgroundColor:[UIColor clearColor]
//                                    iconColor:[UIColor btnGrayColor]
//                                    iconScale:1
//                                      andSize:CGSizeMake(32, 32)];
//    [self.rateBtn setImage:imageView.image
//                  forState:UIControlStateNormal];
}

- (void)returnHelpCenter:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configureViews
{
    [super configureViews];
    
    if ( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] )
    {
        self.AboutUsTitle.textColor = [UIColor fontNightWhiteColor];
        self.writer.textColor = [UIColor fontNightWhiteColor];
    } else {
        self.AboutUsTitle.textColor = [UIColor fontBlackColor];
        self.writer.textColor = [UIColor fontBlackColor];
    }
}

- (IBAction)viewTwitter:(id)sender {
    UIApplication *app = [UIApplication sharedApplication];
    
    if ([app canOpenURL:[NSURL URLWithString:@"http://weibo.com/u/3106169565"]]) {
        [app openURL:[NSURL URLWithString:@"http://weibo.com/u/3106169565"]];
    }
}

- (IBAction)viewWebsite:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weiranzhang.com"]];
}

- (IBAction)rate:(id)sender {
    //跳转到评价页面
    NSString *url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",appleID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
