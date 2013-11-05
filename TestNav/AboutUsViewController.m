//
//  AboutUsViewController.m
//  TestNav
//
//  Created by D on 13-8-1.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "AboutUsViewController.h"
#import "UIImage+Rotation.h"

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
    [self addLogo];
    
    UIButton *Btn = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20.5)];
        
        [Btn setImage:[UIImage imageNamed:@"UI7NavigationBarBackButton.png"] 
             forState:UIControlStateNormal];

//        [Btn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];

    } else {
        Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 30)];
        
        [Btn setImage:[UIImage imageNamed:@"navigationbar_backup_default.png"]
             forState:UIControlStateNormal];
        [Btn setBackgroundImage:[[UIImage imageNamed:@"NavigationButtonBG"]
                                 resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]
                       forState:UIControlStateNormal];
    }
    
    [Btn addTarget:self action:@selector(returnHelpCenter:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:Btn];
    
    
    self.navigationItem.backBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = backItem;

    self.title = NSLocalizedString(@"AboutUs", @"");
}

- (void)addLogo
{
    UIImageView *logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"aboutUs.png"]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        logo.frame = CGRectMake(8, 80, 304, 88);
    } else {
        logo.frame = CGRectMake(8, 16, 304, 88);
    }
    [self.view addSubview:logo];
}

- (IBAction)returnHelpCenter:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
