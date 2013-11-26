//
//  mySettingsViewController.m
//  TableViewCustom
//
//  Created by D on 13-7-29.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "mySettingsViewController.h"

#import "SelectThemeViewController.h"

#import "CustomCell.h"

#import <QuartzCore/QuartzCore.h>

#import "MBHUDView.h"

#import "UMFeedbackViewController.h"

#import "AboutUsViewController.h"

#import "ChoosePhotoViewController.h"

#import "SwitchCell.h"

#import "NSURL+urlRequest.h"

#import "UIColor+NoteAdditions.h"

#import "UIImage+Tint.h"

#import "UIImage+Rotation.h"

#import "DownFontViewController.h"

#define appleID 417187788
#define IOS7DIFFHEIGHT ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7 ? 16 : 0)

@interface mySettingsViewController ()

@end

@implementation mySettingsViewController
@synthesize content, doneBtn, footer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.navigationController.navigationBar.translucent = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)initViews
{
    self.title = NSLocalizedString(@"Settings", @"");
    doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 30)];
    [doneBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
//    doneBtn.showsTouchWhenHighlighted = YES;
    [doneBtn setTitle:NSLocalizedString(@"Done", @"") forState:UIControlStateNormal];
    [doneBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:doneBtn];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Done", @"")
//                                                                                style:UIBarButtonItemStyleDone
//                                                                               target:self
//                                                                               action:@selector(close:)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ok.png"]
                                                                                style:UIBarButtonItemStyleDone
                                                                               target:self
                                                                               action:@selector(close:)];
 
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    } else {
        self.navigationItem.leftBarButtonItem = leftItem;
    }

    [doneBtn setBackgroundImage:[[UIImage imageNamed:@"NavigationButtonBG"]
                                      resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]
                                            forState:UIControlStateNormal];
    content = @[
                NSLocalizedString(@"Lock",@""),
                NSLocalizedString(@"Reset Password",@""),
                NSLocalizedString(@"Choose Themes",@""),
                NSLocalizedString(@"Download Font",@""),
                NSLocalizedString(@"About us",@""),
                NSLocalizedString(@"Advice Feedback",@""),
                NSLocalizedString(@"Check Update",@""),
               ];
    rect_screen = [[UIScreen mainScreen]bounds];
    
    CGRect table = CGRectNull;

    table = CGRectMake(0, -IOS7DIFFHEIGHT, 320, rect_screen.size.height +IOS7DIFFHEIGHT);
    
    self.myTableView = [[UITableView alloc] initWithFrame:table
                                                    style:UITableViewStyleGrouped];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.scrollEnabled = NO;
    
    footer = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 33.0f)];
	footer.backgroundColor = [UIColor clearColor];
	footer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	footer.textAlignment = NSTextAlignmentCenter;
    NSString *ver = NSLocalizedString(@"Version", @"");
    ver = [ver stringByAppendingString:[NSString stringWithFormat:@"  %@",
                                 [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]]];

	footer.text = ver;
    footer.shadowColor = [UIColor whiteColor];
	footer.shadowOffset = CGSizeMake(0.0f, 1.0f);

	self.myTableView.tableFooterView = footer;
    
    [self.view addSubview:self.myTableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.myTableView reloadData];
    [self configureTableview];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]postNotificationName:dragBackStatusOpen
                                                       object:nil];
}

- (void)close:(id)sender {
	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellId";
    static NSString * switchCellId = @"cellId2";
    _picName = @[
                 @"key.png",
                 @"locked.png",
                 @"theme.png",
                 @"quill",
                 @"aboutUs.png",
                 @"feedBack.png",
                 @"update.png"
                 ];
    
    SwitchCell *cell = nil;
    if (indexPath.row == 0 && indexPath.section == 0) {
        [tableView dequeueReusableCellWithIdentifier:switchCellId];
        if (cell == nil) {
            cell =
            [[SwitchCell alloc]initWithStyle:UITableViewCellStyleDefault
                             reuseIdentifier:switchCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.parent = self;
        }
    } else {
        [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell =
            [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cellId];
        }
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = content[indexPath.row];
        if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] ) {
            cell.imageView.image = [[UIImage imageNamed:_picName[indexPath.row]]
                                    imageWithTintColor:[UIColor btnGrayColor]];
            cell.textLabel.textColor = [UIColor fontNightWhiteColor];
            cell.backgroundColor = [UIColor paperDarkGrayColor];
            if (indexPath.row == 0) {
                //无箭头
            } else {
                UIImage *accessoryImg = [[UIImage imageNamed:@"listArrow.png"]
                                        imageWithTintColor:[UIColor fontNightWhiteColor]];
                cell.accessoryView = [[UIImageView alloc]initWithImage:accessoryImg];

            }
        } else {
            cell.imageView.image = [UIImage imageNamed:_picName[indexPath.row]];
            cell.textLabel.textColor = [UIColor fontBlackColor];
            cell.backgroundColor = [UIColor paperWhiteColor];
            if (indexPath.row == 0) {
                //无箭头
            } else {
                UIImage *accessoryImg = [UIImage imageNamed:@"listArrow.png"];
                cell.accessoryView = [[UIImageView alloc]initWithImage:accessoryImg];
            }
        }
    }

    if (indexPath.section == 1) {
        cell.textLabel.text = content[indexPath.row + 4];
        if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] ) {
            cell.imageView.image = [[UIImage imageNamed:_picName[indexPath.row +4]]
                                    imageWithTintColor:[UIColor btnGrayColor]];
            cell.textLabel.textColor = [UIColor fontNightWhiteColor];
            cell.backgroundColor = [UIColor paperDarkGrayColor];
            UIImage *accessoryImg = [[UIImage imageNamed:@"listArrow.png"]
                                     imageWithTintColor:[UIColor fontNightWhiteColor]];
            cell.accessoryView = [[UIImageView alloc]initWithImage:accessoryImg];
        } else {
            cell.imageView.image = [UIImage imageNamed:_picName[indexPath.row +4]];
            cell.textLabel.textColor = [UIColor fontBlackColor];
            cell.backgroundColor = [UIColor paperWhiteColor];
            UIImage *accessoryImg = [UIImage imageNamed:@"listArrow.png"];
            cell.accessoryView = [[UIImageView alloc]initWithImage:accessoryImg];
        }
        
        //update Indicatior
        if (indexPath.row == 2) {
            
            CGRect bounds = cell.bounds;
            int diffpad = rect_screen.size.height == 480 ? 16:10;
            _activityIndicator = [[UIActivityIndicatorView alloc]
                                  initWithFrame:CGRectMake(256.0f, bounds.size.height /2 -diffpad, 32.0f, 32.0f)];
            [_activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
            [cell addSubview:_activityIndicator];
        }
        
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectThemeViewController *selectTheme = nil;
    AboutUsViewController *aboutUs = nil;
//    ChoosePhotoViewController *choose = nil;
    DownFontViewController *down = nil;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                break;
            case 1:
                [LTHPasscodeViewController sharedUser].delegate = self;
                
                if ([LTHPasscodeViewController passcodeExistsInKeychain ]) {
                    [[LTHPasscodeViewController sharedUser] showForChangingPasscodeInViewController: self];
                }
                break;
            case 2:
                selectTheme = [[SelectThemeViewController alloc]init];
                [self.navigationController pushViewController:selectTheme animated:YES];
                break;
            case 3:
                down = [[DownFontViewController alloc]init];
                [self.navigationController pushViewController:down animated:YES];
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0:
                aboutUs = [[AboutUsViewController alloc]init];
                [self.navigationController pushViewController:aboutUs animated:YES];
                break;
            case 1:
                [self showNativeFeedbackWithAppkey:@"51e600ea56240bdd7405f390"];
                break;
            case 2:
                [self checkUpdate];
                break;
                
            default:
                break;
        }
    }
}

- (void)showNativeFeedbackWithAppkey:(NSString *)appkey {
    UMFeedbackViewController *feedbackViewController =
    [[UMFeedbackViewController alloc] initWithNibName:@"UMFeedbackViewController" bundle:nil];
    feedbackViewController.appkey = appkey;
    [self.navigationController pushViewController:feedbackViewController animated:YES];
}

- (void)checkUpdate {
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        _activityIndicator = rect_screen.size.height == 480 ?
//                                [[UIActivityIndicatorView alloc]
//                                 initWithFrame:CGRectMake(248.0f, rect_screen.size.height - 148 +40, 32.0f, 32.0f)]
//                                :[[UIActivityIndicatorView alloc]
//                                  initWithFrame:CGRectMake(248.0f, rect_screen.size.height - 181 +40, 32.0f, 32.0f)];
//    } else {
//        if (rect_screen.size.height == 480) {
//            _activityIndicator = [[UIActivityIndicatorView alloc]
//                                  initWithFrame:CGRectMake(248.0f, rect_screen.size.height -64 - 145, 32.0f, 32.0f)];
//        } else {
//            _activityIndicator = [[UIActivityIndicatorView alloc]
//                                  initWithFrame:CGRectMake(248.0f, rect_screen.size.height -64 - 179, 32.0f, 32.0f)];
//        }
//    }
//    [_activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
//    [self.view addSubview:_activityIndicator];
    
    [_activityIndicator startAnimating];
    NSURL *url = [NSURL url:@"http://itunes.apple.com/lookup?id=%d",appleID];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        self.verResult  = (NSDictionary *)JSON;
//                                                        NSLog(@"%@",self.verResult);
                                                        [self check];
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        BOOL cancel = [[self.operation valueForKey:@"cancelled"]boolValue];
                                                        if (cancel) {
                                                            //手动取消，不提示
                                                        } else {
                                                        //连接错误
                                                        [MBHUDView hudWithBody:NSLocalizedString(@"Network Connection Error", @"")type:MBAlertViewHUDTypeExclamationMark hidesAfter:2.0 show:YES];
                                                        }
                                                        [_activityIndicator stopAnimating];
                                                    }];
    
    [self.operation start];
}

- (void)check
{
    NSString *version = @"";
    NSArray *configData = [self.verResult valueForKey:@"results"];
    NSLog(@"%@",self.verResult);
    for (id config in configData)
    {
        version = [config valueForKey:@"version"];
        break;
    }
    NSLog(@"new:%@",version);
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    NSLog(@"now:%@",nowVersion);
    
    //Check your version with the version in app store
    if([nowVersion isEqualToString:version] == NO && version.length > 0)
    {
        [self performSelectorOnMainThread:@selector(AlertNewVersion:)
                               withObject:nil
                            waitUntilDone:NO];
    } else {
        [MBHUDView hudWithBody:NSLocalizedString(@"It is Latest Version", @"")
                          type:MBAlertViewHUDTypeCheckmark
                    hidesAfter:2.0
                          show:YES];
    }
    [_activityIndicator stopAnimating];
}

- (void)AlertNewVersion:(id)sender {
    MBAlertView *alert = [MBAlertView alertWithBody:NSLocalizedString(@"Have New Vesion", @"")
                                        cancelTitle:NSLocalizedString(@"Cancel",@"")
                                        cancelBlock:^{
                                        }];
    [alert addButtonWithText:NSLocalizedString(@"Update", @"") type:MBAlertViewItemTypePositive block:^{
        NSURL *url = [NSURL url:@"https://itunes.apple.com/us/app/xg-ke-hui/id417187788?ls=1&mt=8"];
        [[UIApplication sharedApplication]openURL:url];
    }];
    [alert addToDisplayQueue];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (rect_screen.size.height - 84) / 9;
}

- (IBAction)returnHelpCenter:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configureViews
{
    [super configureViews];

    // apply the theme
    if ( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlue] )
    {
        doneBtn.titleLabel.textColor = [UIColor whiteColor];
    }
    else if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeRed] )
    {
        doneBtn.titleLabel.textColor = [UIColor whiteColor];
    }
    else if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] )
    {
        doneBtn.titleLabel.textColor = [UIColor fontNightWhiteColor];
    }
}

- (void)configureTableview
{
    self.view.backgroundColor = [UIColor tableViewBackgroundColor];
    if ( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlue] )
    {
        self.myTableView.backgroundView = nil;
        self.myTableView.backgroundColor = [UIColor clearColor];

        footer.textColor = [UIColor fontBlackColor];
        footer.shadowColor = [UIColor whiteColor];

    } else if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeRed] ) {
        self.myTableView.backgroundView = nil;
        self.myTableView.backgroundColor = [UIColor clearColor];
        
        footer.textColor = [UIColor fontBlackColor];
        footer.shadowColor = [UIColor whiteColor];
    } else if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] ) {
        self.myTableView.separatorColor = [UIColor fontNightWhiteColor];
        [self.changeColorDelegate changeColor:@"Black"];
        self.myTableView.backgroundView = nil;
        self.myTableView.backgroundColor = [UIColor clearColor];
        
        footer.textColor = [UIColor btnGrayColor];
        footer.shadowColor = [UIColor fontNightWhiteColor];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
