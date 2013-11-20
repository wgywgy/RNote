//
//  SelectThemeViewController.m
//  TestNav
//
//  Created by D on 13-7-31.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "SelectThemeViewController.h"

#import "UIColor+NoteAdditions.h"

#define IOS7DIFFHEIGHT ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7 ? 64 : 0)

@interface SelectThemeViewController ()

@end

@implementation SelectThemeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Theme", @"");
//    int height = 0;
    UIButton *Btn = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        height = 64;

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
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:Btn];
    [Btn   addTarget:self action:@selector(returnHelpCenter:)
    forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.backBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = backItem;
    
    for ( int i = 0; i<[[self themes] count]; i++ )
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*100 + 10, IOS7DIFFHEIGHT, 100, 100);
        button.tag = i;
        
        NSString *image = [NSString stringWithFormat: @"resource/skin_set_%@",
                           [[self themes] objectAtIndex:i]];
        
        [button setImage:IMAGE(image)
                forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(selectThemeAtIndex:)
         forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    

}

- (void)configureBackgroundView
{
    if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] ) {
        self.view.backgroundColor = [UIColor paperDarkGrayColor];
    } else {
        self.view.backgroundColor = [UIColor tableViewBackgroundColor];
    }
    
}

- (void)configureViews
{
    [self configureBackgroundView];
}

- (IBAction)returnHelpCenter:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)themes
{
    return @[kThemeRed, kThemeBlack, kThemeBlue];
}

- (void)selectThemeAtIndex:(UIButton *)sender
{
    [[ThemeManager sharedInstance]
     setTheme:[[self themes] objectAtIndex:sender.tag]];
    [self configureBackgroundView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
