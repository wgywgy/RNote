//
//  SwipeGesViewController.m
//  TestNav
//
//  Created by D on 13-9-2.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "SwipeGesViewController.h"

#import "UIColor+NoteAdditions.h"

#import "UIImage+Rotation.h"

@interface SwipeGesViewController ()

@end

@implementation SwipeGesViewController
@synthesize arrow, arrowView;

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
    rect_screen = [[UIScreen mainScreen]bounds];
    self.title = NSLocalizedString(@"Choose A Gesture", @"");
    
    UIButton *Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 30)];
    [Btn addTarget:self action:@selector(returnHelpCenter:) forControlEvents:UIControlEventTouchUpInside];
    [Btn setImage:[UIImage imageNamed:@"navigationbar_backup_default.png"]
         forState:UIControlStateNormal];
    [Btn setBackgroundImage:[[UIImage imageNamed:@"NavigationButtonBG"]
                             resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]
                   forState:UIControlStateNormal];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:Btn];
    
    self.navigationItem.backBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.view.backgroundColor = [UIColor paperWhiteColor];
    
    UIButton *direction = [UIButton buttonWithType:UIButtonTypeCustom];
    direction.frame = CGRectMake(0, 0, 320, rect_screen.size.height -64);
    direction.backgroundColor = [UIColor paperDarkGrayColor];
    [self.view addSubview:direction];
    
    UISwipeGestureRecognizer * mypan =
    [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                           action:@selector(handleSwipeFrom:)];
    [mypan setDirection:(UISwipeGestureRecognizerDirectionRight)];
    mypan.delegate = self;
    
    [direction addGestureRecognizer:mypan];
    
    mypan = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                           action:@selector(handleSwipeFrom:)];
    [mypan setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [direction addGestureRecognizer:mypan];
    
    mypan = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(handleSwipeFrom:)];
    [mypan setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [direction addGestureRecognizer:mypan];

    mypan = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(handleSwipeFrom:)];
    [mypan setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [direction addGestureRecognizer:mypan];
    
    arrow = [UIImage imageNamed:@"navigationbar_backup_default"];
    arrowView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 32)];
    arrowView.center = CGPointMake(160, rect_screen.size.height /2 -64);
    [self.view addSubview:arrowView];
    
    [arrowView setAlpha:0.0f];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Swipe received.");

    if (recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"向下滑动");
        //执行程序
        [self swipeAnimationWithDrection:@"Down"];
    }
    if (recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
        
        NSLog(@"向上滑动");
        //执行程序
        [self swipeAnimationWithDrection:@"Up"];
    }
    if (recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"向左滑动");
        //执行程序
        [self swipeAnimationWithDrection:@"Left"];
    }
    if (recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@"向右滑动");
        //执行程序
        [self swipeAnimationWithDrection:@"Right"];
    }
}

- (void)swipeAnimationWithDrection:(NSString *)Direction
{

    if ([Direction isEqualToString:@"Down"]) {
        arrowView.image = [UIImage image:arrow rotation:UIImageOrientationLeft];
    }
    if ([Direction isEqualToString:@"Left"]) {
        arrowView.image = arrow;
    }
    if ([Direction isEqualToString:@"Right"]) {
        arrowView.image = [UIImage image:arrow rotation:UIImageOrientationDown];
    }
    if ([Direction isEqualToString:@"Up"]) {
        arrowView.image = [UIImage image:arrow rotation:UIImageOrientationRight];
    }


    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.38];
    [arrowView setAlpha:1.0f];
    
    [UIView commitAnimations];

}

-(IBAction)returnHelpCenter:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
