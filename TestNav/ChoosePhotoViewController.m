//
//  ViewController.m
//  TestNav
//
//  Created by D on 13-7-15.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "ChoosePhotoViewController.h"
#import "ChoosePositionViewController.h"
#import "MBHUDView.h"

#import <QuartzCore/QuartzCore.h>

#import "UIImage+Rotation.h"
#import "UIColor+NoteAdditions.h"

@interface ChoosePhotoViewController ()

@end

@implementation ChoosePhotoViewController
@synthesize rect_screen;//pickerArray = _pickerArray;
@synthesize nextBtn;
- (CAGradientLayer *)drawButtonGradient:(UIButton *)sender
{
    //绘制渐变
    CAGradientLayer *layer = [CAGradientLayer layer];
    
    layer.colors = [NSArray arrayWithObjects:
                    (id)[[UIColor colorWithRed:1 green:1 blue:1 alpha:1] CGColor],
                    (id)[[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1] CGColor],
                    nil];
    
    layer.locations = [NSArray arrayWithObjects:
                       [NSNumber numberWithFloat:0],
                       [NSNumber numberWithFloat:1.0],
                       nil];
    
    layer.startPoint        = CGPointMake(0, 0);
    layer.frame             = sender.layer.bounds;
    
    layer.endPoint          = CGPointMake(0, 1);
    layer.contentsGravity   = kCAGravityResize;
    return layer;
}

- (void)addChoosePicBtn
{
    choosePictureBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    choosePictureBtn.frame = CGRectMake(8,rect_screen.size.height -64 -8 -44 +ios7_height, 304, 44);
    
    choosePictureBtn.layer.cornerRadius = 10;
    choosePictureBtn.layer.borderColor = [UIColor blackColor].CGColor;
    choosePictureBtn.layer.borderWidth = 1.0f;
    choosePictureBtn.layer.masksToBounds = YES;
    
    CAGradientLayer *layer = [self drawButtonGradient:choosePictureBtn];
    [choosePictureBtn.layer insertSublayer:layer below:choosePictureBtn.titleLabel.layer];
    
    [choosePictureBtn setTitle:NSLocalizedString(@"Take Photo", @"") forState:UIControlStateNormal];
    [choosePictureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [choosePictureBtn setTitleColor:[UIColor colorWithRed:15.0/255.0 green:119.0/255.0 blue:189.0/255.0 alpha:1.0]
                           forState:UIControlStateHighlighted];
    
    [choosePictureBtn addTarget:self action:@selector(choosePicBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choosePictureBtn];
}

//- (void)addChooseLevelBtn
//{
//    _chooseLevelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    
//    _chooseLevelBtn.frame = CGRectMake(8,rect_screen.size.height -64 -8 -44, 304, 44);
//    
//    _chooseLevelBtn.layer.cornerRadius = 7;
//    _chooseLevelBtn.layer.borderColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1].CGColor;
//    _chooseLevelBtn.layer.borderWidth = 1.0f;
//    _chooseLevelBtn.layer.masksToBounds = YES;
//    
//    CAGradientLayer *layer = [self drawButtonGradient:_chooseLevelBtn];
//    [_chooseLevelBtn.layer insertSublayer:layer below:_chooseLevelBtn.titleLabel.layer];
//    
//    [_chooseLevelBtn setTitle:@"选择密码层数" forState:UIControlStateNormal];
//    [_chooseLevelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_chooseLevelBtn setTitleColor:[UIColor colorWithRed:15.0/255.0 green:119.0/255.0 blue:189.0/255.0 alpha:1.0]
//                          forState:UIControlStateHighlighted];
//    
//    [_chooseLevelBtn addTarget:self action:@selector(chooseLevelBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_chooseLevelBtn];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Set Password", @"");
    rect_screen = [[UIScreen mainScreen]bounds];
    self.view.backgroundColor = [UIColor tableViewBackgroundColor];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        ios7_height = 64;
    } else {
        ios7_height = 0;
    }
    
//    [self addChoosePicBtn];
   
    nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 30)];
    [nextBtn addTarget:self action:@selector(chooseLevel:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setImage:
     [UIImage image:[UIImage imageNamed:@"navigationbar_backup_default.png"] rotation:UIImageOrientationDown]
             forState:UIControlStateNormal];
    
    [nextBtn setBackgroundImage:[[UIImage imageNamed:@"NavigationButtonBG"]
                             resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]
                   forState:UIControlStateNormal];

//    [nextBtn setBackgroundImage:bg forState:UIControlStateNormal];
//    [nextBtn setTitle:NSLocalizedString(@"Next", @"") forState:UIControlStateNormal];
//    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:nextBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    nextBtn.enabled = FALSE;
    
    self.photoView = [[UIImageView alloc]init];
    if (rect_screen.size.height == 480) {
        self.photoView.frame = CGRectMake(12, 12 +ios7_height,
                                          296, rect_screen.size.height * 0.64);
    } else {
        self.photoView.frame = CGRectMake(12, 12 +ios7_height,
                                          296, rect_screen.size.height * 0.7);
    }

    [self.view addSubview:self.photoView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.photoView.frame.origin.x -4,
                                                            self.photoView.frame.origin.y -4,
                                                            self.photoView.frame.size.width +8,
                                                            self.photoView.frame.size.height +8)];
    
//    pickerArray = @[@"两级",@"三级",@"四级"];
//    _selectCityField.hidden = YES;
//    
//    _selectCityPicker = [[UIPickerView alloc] init];
//    [_selectCityPicker sizeToFit];
//    _selectCityPicker.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
//    _selectCityPicker.delegate = self;
//    _selectCityPicker.dataSource = self;
//    _selectCityPicker.showsSelectionIndicator = YES;
    
	view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
                            UIViewAutoresizingFlexibleRightMargin ;
    
	view.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
	view.layer.borderWidth = 4.0;
	view.layer.shadowOffset = CGSizeMake(0, 3);
	view.layer.shadowOpacity = 0.7;
	view.layer.shouldRasterize = YES;
    
    view.backgroundColor = [UIColor btnGrayColor];
    
    // shadow
    UIBezierPath *path = [UIBezierPath bezierPath];
	
	CGPoint topLeft		 = view.bounds.origin;
	CGPoint bottomLeft	 = CGPointMake(0.0, CGRectGetHeight(view.bounds) + 10);
	CGPoint bottomMiddle = CGPointMake(CGRectGetWidth(view.bounds) / 2, CGRectGetHeight(view.bounds) - 5);
	CGPoint bottomRight	 = CGPointMake(CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds) + 10);
	CGPoint topRight	 = CGPointMake(CGRectGetWidth(view.bounds), 0.0);
	
	[path moveToPoint:topLeft];
	[path addLineToPoint:bottomLeft];
	[path addQuadCurveToPoint:bottomRight
				 controlPoint:bottomMiddle];
	[path addLineToPoint:topRight];
	[path addLineToPoint:topLeft];
	[path closePath];
	
	view.layer.shadowPath = path.CGPath;
	[self.view insertSubview:view atIndex:0];
    
    //添加选择照片按钮
    choosePictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    choosePictureBtn.frame = CGRectMake(2, 240, 304, 44);
    [choosePictureBtn setTitle:NSLocalizedString(@"Take Photo", @"") forState:UIControlStateNormal];
    choosePictureBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    choosePictureBtn.titleLabel.textColor = [UIColor paperWhiteColor];
    
    [choosePictureBtn addTarget:self action:@selector(choosePicBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:choosePictureBtn];

    //标签
    UILabel * levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, rect_screen.size.height -64 -46 -48 +ios7_height,
                                                                    304, 44)];
    levelLabel.text = NSLocalizedString(@"Choose Password Level", @"");
    levelLabel.font = [UIFont boldSystemFontOfSize:14];
    levelLabel.backgroundColor = [UIColor clearColor];
    levelLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:levelLabel];

    NSArray *segmentTextContent = [NSArray arrayWithObjects:
                                   NSLocalizedString(@"TwoLevel", @""),
                                   NSLocalizedString(@"ThreeLevel", @""),
                                   NSLocalizedString(@"FourLevel", @""),
                                   nil];
    
    //分段选择器
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBordered;
    segmentedControl.frame =  CGRectMake(8, rect_screen.size.height -64 -12 -44 +ios7_height, 304, 44);
    [segmentedControl addTarget:self action:@selector(SetSegment:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:2 forKey:@"passwordLevel"];
    [defaults synchronize];
}

- (IBAction) SetSegment : (id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSInteger segment = segmentedControl.selectedSegmentIndex;
    
//    NSLog(@"%d",segment);
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:segment + 2 forKey:@"passwordLevel"];
    [defaults synchronize];

//    else
//    {
//        [switchView setHidden:YES];
//    }
//    
}

//- (IBAction)chooseLevelBtnPressed:(id)sender
//{
//    [_selectCityField becomeFirstResponder];
//}

- (IBAction)choosePicBtnPressed:(id)sender {
    UIActionSheet *choosePhotoActionSheet;
    weakSelf = self;

    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        choosePhotoActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Take Photo", @"")
                                                             delegate:weakSelf
                                                    cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"To take pictures", @""),
                                                                      NSLocalizedString(@"Go to library", @""), nil];
    } else {
        choosePhotoActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Take Photo", @"")
                                                             delegate:weakSelf
                                                    cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"Go to library", @""), nil];
    }

    [choosePhotoActionSheet showInView:self.view];
}

- (IBAction)chooseLevel:(id)sender
{
//    int passwordLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"passwordLevel"];
//    if (passwordLevel < 2) {
//        [MBHUDView hudWithBody:@"您还没有选择密码层数" type:MBAlertViewHUDTypeExclamationMark hidesAfter:2.0 show:YES];
//    } else if (result == FALSE) {
    if (result == FALSE) {
        [MBHUDView hudWithBody:@"You don't have a picture" type:MBAlertViewHUDTypeExclamationMark hidesAfter:2.0 show:YES];
    } else {
        ChoosePositionViewController *mychooseLevelController = [[ChoosePositionViewController alloc]init];
        [self.navigationController pushViewController:mychooseLevelController animated:YES];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = 0;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1:
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 2:
                return;
        }
    } else {
        if (buttonIndex == 1) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = weakSelf;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:nil];
	self.photo = [info objectForKey:UIImagePickerControllerEditedImage];
    self.photoView.image = self.photo;
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"password.jpg"]]; // 保存文件的名称
    result = [UIImagePNGRepresentation(self.photo) writeToFile:filePath
                                                    atomically:YES]; // 保存成功会返回YES
    if (result) {
        nextBtn.enabled = TRUE;
        [choosePictureBtn removeFromSuperview];
    }
//    NSLog(@"%d",result);
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    //当指定的单元格需要编辑时，自定义pickerview键盘
//    
//    _selectCityField.inputView = _selectCityPicker;
//    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
//    keyboardDoneButtonView.barStyle = UIBarStyleBlack;
//    keyboardDoneButtonView.translucent = YES;
//    keyboardDoneButtonView.tintColor = nil;
//    [keyboardDoneButtonView sizeToFit];
//    UIBarButtonItem* cancle = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"")
//                                                               style:UIBarButtonItemStyleBordered target:self
//                                                              action:@selector(cancelSelectCity:)];
//    
//    UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
//                                                                                  target:nil
//                                                                                  action:nil];
//    UIBarButtonItem* select = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Ok", @"")
//                                                               style:UIBarButtonItemStyleDone target:self
//                                                              action:@selector(selectButton:)];
//    
//    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:cancle,spaceBarItem,select, nil]];
//    _selectCityField.inputAccessoryView = keyboardDoneButtonView;
//    
//    return YES;
//}

//-(void)cancelSelectCity:(id)sender
//{
//    [_selectCityField resignFirstResponder];
//    _selectCityField.text = @"";
//}
//
//- (IBAction)selectButton:(id)sender {
//    [_selectCityField resignFirstResponder];
//    NSInteger row = [_selectCityPicker selectedRowInComponent:0];
//    
//    //保存密码有几级 0 1 2
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setInteger:row + 2 forKey:@"passwordLevel"];
//    [defaults synchronize];
////    NSLog(@"%d",row);
//}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
