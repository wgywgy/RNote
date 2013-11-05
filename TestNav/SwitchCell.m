//
//  SwitchCell.m
//  TestNav
//
//  Created by D on 13-8-1.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "SwitchCell.h"
#import "UIColor+NoteAdditions.h"

#define kBlueColor [UIColor colorWithRed:129/255.0 green: 198/255.0 blue: 221/255.0 alpha: 1.0]
#define IOS7DIFFPADLEFT ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7 ? 320 -34 : 320 -52)
#define DIFFPADTOP ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7 ? 16 : 28)

@implementation SwitchCell
@synthesize switchView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect bounds = self.bounds;
        NSLog(@"bounds:%f",self.bounds.size.height);
//        if (bounds.size.height == 480) {
//            switchView = [[UISwitch alloc] initWithFrame:
//                          CGRectMake(320 - 62, bounds.size.height/2 - 14,
//                                     self.frame.size.width, self.frame.size.height)];
//        } else {
//            switchView = [[UISwitch alloc] initWithFrame:
//                          CGRectMake(320 - 96, bounds.size.height/2 - 12,
//                                     self.frame.size.width, self.frame.size.height)];
//        }
        rect_screen = [[UIScreen mainScreen]bounds];
        switchView = [[UISwitch alloc]init];
        if (rect_screen.size.height > 480) {
            switchView.center = CGPointMake(IOS7DIFFPADLEFT, bounds.size.height/2 +6);
        } else {
            switchView.center = CGPointMake(IOS7DIFFPADLEFT, bounds.size.height/2 +2);
        }
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        BOOL saveStatus = [defaults boolForKey:@"usePassword"];
        
        //    [switchView setOn:saveStatus animated: YES];
        switchView.on = saveStatus;
        [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:switchView];
//        UIImage *accessoryImg = [[UIImage imageNamed:@"hideKeyboard.png"]
//                                 imageWithTintColor:[UIColor fontNightWhiteColor]];
//        accessoryImg = [UIImage image:accessoryImg rotation:UIImageOrientationLeft];
//        cell.accessoryView = [[UIImageView alloc]initWithImage:accessoryImg];
//        self.accessoryView = nil;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];


//    switchView.tintColor = [UIColor paperWhiteColor];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        //        self.edgesForExtendedLayout = UIRectEdgeNone;
//        switchView = [[KLSwitch alloc]initWithFrame: CGRectMake(320 - 74, bounds.size.height/2 - 13,
//                                                                60, 26)];
//    } else {
//    switchView = [[KLSwitch alloc]initWithFrame: CGRectMake(320 - 78, bounds.size.height/2 - 13,
//                                       60, 26)];
//    }
    
//    [switchView setDidChangeHandler:^(BOOL isOn) {
//        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//        if (isOn) {
//            [defaults setBool:YES forKey:@"usePassword"];
//        }else {
//            [defaults setBool:NO forKey:@"usePassword"];
//        }
//
//    }];
    

//    self.accessoryType = UITableViewCellAccessoryNone;
}

//- (void)changeColor:(NSString *)color
//{
////    NSLog(@"color%@",color);
//    if ([color isEqualToString:@"Black"]) {
////        switchView = [[KLSwitch alloc]initWithFrame: CGRectMake(320 - 78, bounds.size.height/2 - 13,
////                                                                     60, 26)];
//        [switchView setOnTintColor: kBlueColor];
//        [switchView setTintColor:[UIColor paperDarkGrayColor]];
//        [switchView setContrastColor:[UIColor btnGrayColor]];
//        [switchView setThumbBorderColor:[UIColor btnGrayColor]];
////        [self addSubview:switchView];
//    }
//    
//}

- (void)switchAction:(id)sender
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];

    BOOL isButtonOn = [switchView isOn];
    if (isButtonOn) {
        [defaults setBool:YES forKey:@"usePassword"];
    } else {
        [defaults setBool:NO forKey:@"usePassword"];
    }
    [defaults synchronize];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end