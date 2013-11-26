//
//  NotePadViewController.m
//  TestNav
//
//  Created by D on 13-8-1.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "NotePadViewController.h"

#import "AWActionSheet.h"

#import "KGNotePad.h"

#import "UIImage+Tint.h"

#import "WHMailActivity.h"
#import "WHTextActivity.h"

#import <QuartzCore/QuartzCore.h>

@interface NotePadViewController ()
<UIActionSheetDelegate,AWActionSheetDelegate>

@end

@implementation NotePadViewController

@synthesize screenLockBtn, paperButton, backBtn, notePad, notePadID;
@synthesize Notedict, noteArray, NoteTextCount, sliderFont,shareBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)setRightItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        [paperButton setBackgroundImage:[[UIImage imageNamed:@"NavigationButtonBG"]
                                         resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]
                               forState:UIControlStateNormal];
        [paperButton setImage:[UIImage imageNamed:@"paper.png"] forState:UIControlStateNormal];
        
        [screenLockBtn setBackgroundImage:[[UIImage imageNamed:@"NavigationButtonBG"]
                                              resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]
                                    forState:UIControlStateNormal];
        [screenLockBtn setImage:[UIImage imageNamed:@"unlockedScreen.png"] forState:UIControlStateNormal];
    } else {
        [paperButton setImage:[UIImage imageNamed:@"file.png"] forState:UIControlStateNormal];
        
        [screenLockBtn setImage:[UIImage imageNamed:@"unlock.png"] forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:dragBackStatusOpen
                                                       object:nil];
    [self setNavigationItem];
    
    UIView *myView = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 68, 40)];
    } else {
        myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    }

    paperButton = [[UIButton alloc]initWithFrame:CGRectMake(12, 6, 30, 30)];

  
    [paperButton addTarget:self action:@selector(clickPaperButton)
          forControlEvents:UIControlEventTouchUpInside];
    
    screenLockBtn = [[UIButton alloc]initWithFrame:CGRectMake(48, 6, 30, 30)];
   
    [screenLockBtn addTarget:self action:@selector(clickLockBtn)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self setRightItem];
    
    [myView addSubview:paperButton];
    [myView addSubview:screenLockBtn];
    
    UIBarButtonItem *myBtn = [[UIBarButtonItem alloc] initWithCustomView:myView];
    self.navigationItem.rightBarButtonItem = myBtn;
    
    rect_screen = [[UIScreen mainScreen]bounds];
    [self initNoteView];
    
    notePad.textView.delegate = self;
    

    
//    self.scrollForHideNavigation = notePad.textView;
//    [notePad.textView setContentOffset:CGPointMake(0, -43)];
//    self.notePad.textView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
    
    paperColor = @[[UIColor paperDarkGrayColor],
                   [UIColor whiteColor],
                   [UIColor paperWhiteColor],
                   [UIColor blueColor],
                   [UIColor orangeColor],
                   [UIColor purpleColor]];
    
    textColor = @[[UIColor fontBlackColor],
                  [UIColor fontNightWhiteColor],
                  [UIColor darkGrayColor],
                  [UIColor whiteColor]];
    
    [self configureNotePad];
    [self configureKeyboardView];
    
    if(self.Notedict != nil){
		notePad.textView.text = [Notedict objectForKey:@"Text"];
        NoteTextCount = notePad.textView.text.length;
	}
    
    popView = [[UILabel alloc]initWithFrame:CGRectMake(sliderFont.frame.origin.x, sliderFont.frame.origin.y-20, 70, 20)];
    [popView setTextAlignment:NSTextAlignmentCenter];
    [popView setBackgroundColor:[UIColor clearColor]];
    [popView setAlpha:0.f];
    
    [self regitserAsObserver];
 
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (notePad.textView.text.length <= 0) {
        [notePad.textView becomeFirstResponder];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    [self unregisterAsObserver];
    [super viewDidDisappear:animated];
}

- (IBAction)didSelectShare:(id)sender {
    NSMutableArray *activityItems = [NSMutableArray array];
 
    //  For Mail
    [activityItems addObject:[WHMailActivityItem mailActivityItemWithSelectionHandler:^(MFMailComposeViewController *mailController) {
        [mailController setSubject:[NSString stringWithFormat:@"%@%@%@",
                                    NSLocalizedString(@"At", @""),self.title,NSLocalizedString(@"notes", @"")]];
        [mailController setMessageBody:notePad.textView.text isHTML:NO];

        mailController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }]];
    
    //  For texting
    [activityItems addObject:[WHTextActivityItem textActivityItemWithSelectionHandler:^(MFMessageComposeViewController *messageController) {
        [messageController setBody:notePad.textView.text];
        messageController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }]];
    
    //  For everything else
    [activityItems addObject:notePad.textView.text];
    
    NSArray *activities = (@[
                             [[WHMailActivity alloc] init],
                             [[WHTextActivity alloc] init]   // keep in mind that texting is broken on the simulator...
                             ]);
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc]
                                                    initWithActivityItems:activityItems
                                                    applicationActivities:activities];
    activityController.excludedActivityTypes = (@[
                                                  UIActivityTypeAssignToContact,
                                                  UIActivityTypeMail,
                                                  UIActivityTypeMessage,
                                                  UIActivityTypePrint,
                                                  UIActivityTypeSaveToCameraRoll
                                                  ]);
    
    [self presentViewController:activityController animated:YES completion:NULL];
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    NSTimeInterval animationDuration =
    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        frame = CGRectMake(0, 0, 320, rect_screen.size.height);
    } else {
        frame = CGRectMake(0, 0, 320, rect_screen.size.height - 64);
    }
    frame.size.height -= keyboardRect.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
//    self.navigationController.navigationBar.frame =
//    CGRectMake(0,-44,
//               self.navigationController.navigationBar.frame.size.width,
//               self.navigationController.navigationBar.frame.size.height);
    self.notePad.frame = frame;
    [UIView commitAnimations];
    self.view.backgroundColor = [UIColor paperWhiteColor];
//    [self.navigationController setNavigationBarHidden:YES];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.size.height += keyboardRect.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
//    self.navigationController.navigationBar.frame =
//    CGRectMake(0,20,
//               self.navigationController.navigationBar.frame.size.width,
//               self.navigationController.navigationBar.frame.size.height);
    self.view.frame = frame;
    [UIView commitAnimations];
//    [self.navigationController setNavigationBarHidden:NO];
}

//- (void)saveTitle
//{
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:[self getsubText] forKey:[NSString stringWithFormat:@"Note%dTitle",notePadID]];
//    NSLog(@"noteId:%@", [NSString stringWithFormat:@"Note%dTitle",notePadID]);
//    [defaults synchronize];
//}

- (NSString *)getsubText
{
    NSString *subText = @"";
    
    if (notePad.textView.text.length >= 14) {
        subText = [notePad.textView.text substringWithRange:NSMakeRange(0, 14)];
        return [NSString stringWithFormat:@"%@...",subText];
    } else {
        return notePad.textView.text;
    }
}

- (void)clickLockBtn
{
    if ([UIApplication sharedApplication].idleTimerDisabled == YES) {
        [UIApplication sharedApplication].idleTimerDisabled = NO;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            [screenLockBtn setImage:[UIImage imageNamed:@"unlock.png"]
                              forState:UIControlStateNormal];
        } else {
            [screenLockBtn setImage:[UIImage imageNamed:@"unlockedScreen.png"]
                              forState:UIControlStateNormal];
        }
    } else {
        [UIApplication sharedApplication].idleTimerDisabled = YES;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            [screenLockBtn setImage:[UIImage imageNamed:@"lock.png"]
                              forState:UIControlStateNormal];
        } else {
            [screenLockBtn setImage:[UIImage imageNamed:@"lockedScreen.png"]
                              forState:UIControlStateNormal];
        }
    }
}

- (void)clickPaperButton
{
    [self getNoteTextEdit];
    [notePad.textView resignFirstResponder];
    AWActionSheet *sheet = [[AWActionSheet alloc] initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    [sheet showInView:self.view];
    sheet.delegate = self;
}

- (void)getNoteTextEdit
{
    if (notePad.textView.isFirstResponder) {
        didEdit = YES;
    } else {
        didEdit = NO;
    }
}

- (void)initNoteView
{
    NSString *fileName = [[self documentsPath] stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"Note%dTxt",notePadID]];
    notePad.textView.text = [self readFromFile:fileName];

    fontSize = [self getFontSize];
    notePad.textView.font = [UIFont systemFontOfSize:fontSize];
    notePad.lineOffset = 7.82;
}

- (int)getFontSize
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:@"fontSize"]?
                [defaults integerForKey:@"fontSize"]:20;
}

- (void)saveFontSize:(int)myfontSize
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:myfontSize forKey:@"fontSize"];
    [defaults synchronize];
}

- (void)setNavigationItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        //     没有边框
        backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 11, 18)];

        [backBtn setImage:[UIImage imageNamed:@"Toolbar_back"]
                 forState:UIControlStateNormal];
    } else {
        backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 18)];
    }
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    [backBtn addTarget:self
                action:@selector(returnHelpCenter:)
      forControlEvents:UIControlEventTouchUpInside];
    [self configureBackViewBtn:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)configureBackViewBtn:(UIButton *)aBtn
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        return;
    }
    if( [[[ThemeManager sharedInstance] theme] isEqual:kThemeBlack] )
    {
        [aBtn setImage:[[UIImage imageNamed:@"Toolbar_back.png"]
                        imageWithTintColor:[UIColor btnGrayColor]]
              forState:UIControlStateNormal];
    } else {
        [aBtn setImage:[UIImage imageNamed:@"Toolbar_back.png"]
              forState:UIControlStateNormal];
    }
}

- (void)configureKeyboardView
{
    if( [[[ThemeManager sharedInstance] theme] isEqual:kThemeBlack] )
    {
        self.notePad.textView.keyboardAppearance = UIKeyboardAppearanceAlert;
        [self showKeyboardBackground:NO];
    } else {
        self.notePad.textView.keyboardAppearance = UIKeyboardAppearanceDefault;
        [self showKeyboardBackground:YES];
    }
}

- (int)numberOfItemsInActionSheet
{
    return 6;
}

- (void)returnHelpCenter:(id)sender
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:NO forKey:@"isEditing"];
    [defaults synchronize];
    
    if (self.notePad.textView.text.length > 0
        && NoteTextCount != self.notePad.textView.text.length) {
        [self savePlist];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[AWActionSheetCell alloc] init];
    
    [cell.iconView setBackgroundColor:paperColor[index]];
    
//    NSLog(@"index:%d",index);
    if (index == 0) {
        cell.AText.textColor = textColor[1];
    } else if (index == 1 || index == 2) {
        cell.AText.textColor = textColor[0];
    } else {
        cell.AText.textColor = textColor[3];
    }
    
    cell.index = index;
    return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
//    [UIApplication sharedApplication].idleTimerDisabled = NO;
//        self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
 
    self.navigationController.navigationBar.frame = CGRectMake(0, 20, 320, 44);
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self hiddenKeyBoard];
    notePad.frame = CGRectMake(0, 0, 320, rect_screen.size.height);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [UIApplication sharedApplication].idleTimerDisabled = NO;
}

-(void)DidTapOnItemAtIndex:(NSInteger)index
{
    if (didEdit) {
        [notePad.textView becomeFirstResponder];
    }
    
    notePad.paperBackgroundColor = paperColor[index];
    
    //黑色背景
    if (index == 0) {
        notePad.textView.textColor = textColor[1];
        notePad.horizontalLineColor = textColor[1];
        notePad.verticalLineColor = textColor[1];
    //纯白背景
    } else if (index == 1 ) {
        notePad.textView.textColor = textColor[0];
        notePad.horizontalLineColor = [UIColor lineLightRedColor];
        notePad.verticalLineColor = [UIColor lineLightBlueColor];
    //纸色背景
    } else if (index == 2) {
        notePad.textView.textColor = textColor[0];
        notePad.horizontalLineColor = [UIColor lineLightRedColor];
        notePad.verticalLineColor = [UIColor lineLightGrayColor];
    } else {
        notePad.textView.textColor = textColor[3];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if (didEdit) {
            [notePad.textView becomeFirstResponder];
        }
    }
}

- (void)hiddenKeyBoard
{
    [notePad.textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    [toolBar sizeToFit];
    
    UIButton *addFontSizeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [addFontSizeBtn addTarget:self action:@selector(addFontSize) forControlEvents:UIControlEventTouchUpInside];
    [addFontSizeBtn setTitle:@"A+" forState:UIControlStateNormal];

    UIBarButtonItem *addFontSizer = [[UIBarButtonItem alloc]initWithCustomView:addFontSizeBtn];
    
    shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(didSelectShare:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sharer = [[UIBarButtonItem alloc]initWithCustomView:shareBtn];
    
    UIBarButtonItem *spacer =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                  target:self
                                                  action:nil];

    UIButton *Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [Btn addTarget:self action:@selector(hiddenKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [Btn setImage:[UIImage imageNamed:@"hideKeyboard.png"]
         forState:UIControlStateNormal];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//     没有边框
        [addFontSizeBtn setTitleEdgeInsets:UIEdgeInsetsMake(2, -8, 0, 0)];
        [Btn setImageEdgeInsets:UIEdgeInsetsMake(2, 16, 0, 0)];
    } else {
        [Btn setBackgroundImage:[[UIImage imageNamed:@"NavigationButtonBG"]
                                 resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]
                       forState:UIControlStateNormal];
        [addFontSizeBtn setBackgroundImage:[[UIImage imageNamed:@"NavigationButtonBG"]
                                 resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]
                       forState:UIControlStateNormal];
        addFontSizeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithCustomView:Btn];
    
    NSArray *items = @[addFontSizer, sharer, spacer, done];
    [toolBar setItems:items animated:NO];
    notePad.textView.inputAccessoryView = toolBar;
    
    [self addFontSlider];
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"isEditing"];
    [defaults synchronize];
}

- (void)addFontSlider
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        sliderFont = [[UISlider alloc]initWithFrame:CGRectMake(48, 6, 224, 10)];
    } else {
        sliderFont = [[UISlider alloc]initWithFrame:CGRectMake(48, 10, 224, 10)];
    }
    
    sliderFont.minimumValue = 16;
    sliderFont.maximumValue = 44;
    sliderFont.value = [self getFontSize];
    [sliderFont addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];
    //    sliderFont.minimumValueImage = [UIImage imageNamed:];
    //    sliderFont.maximumTrackTintColor = [UIImage imageNamed:];
    
    [notePad.textView.inputAccessoryView addSubview:sliderFont];
    
    sliderFont.hidden = YES;
}

- (void)addFontSize
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;
    
    [[sliderFont layer] addAnimation:animation forKey:@"animation"];

    if (sliderFont.hidden == NO) {
        sliderFont.hidden = YES;
        shareBtn.hidden = NO;
    } else {
        sliderFont.hidden = NO;
        shareBtn.hidden = YES;
    }
}

- (IBAction)updateValue:(UISlider *)sender{
    float f = sender.value; //读取滑块的值
    [notePad.textView setFont:[UIFont systemFontOfSize:f + 2]];
    [self saveFontSize:f + 2];
    
    UIImageView *imageView = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        imageView = [sliderFont.subviews objectAtIndex:1];
    } else {
        imageView = [sliderFont.subviews objectAtIndex:2];
    }
    CGRect theRect = [self.view convertRect:imageView.frame fromView:imageView.superview];
    
    [popView setFrame:CGRectMake(theRect.origin.x - 20, theRect.origin.y - 24,
                                 popView.frame.size.width, popView.frame.size.height)];
    
    NSInteger v = sliderFont.value+0.5;
    [popView setText:[NSString stringWithFormat:@"%d",v]];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [popView setAlpha:1.f];
                     }
                     completion:^(BOOL finished){
                         // 动画结束时的处理
                     }];
    
    [timer invalidate];
    timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(disPopView)
                                           userInfo:nil repeats:NO];
}

- (void)disPopView{
    [UIView animateWithDuration:0.5
                     animations:^{
                         [popView setAlpha:0.f];
                     }
                     completion:^(BOOL finished){
                         // 动画结束时的处理
                     }];
    
}

- (void)subFontSize
{
    int myfontSize = [self getFontSize];
    if (myfontSize < 16) {
        return;
    }
    [notePad.textView setFont:[UIFont systemFontOfSize:myfontSize - 2]];
    [self saveFontSize:myfontSize - 2];
}

//- (void)hideKeyboard:(id)sender
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [UIView beginAnimations:nil context:context];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    [UIView setAnimationDuration:0.3];
//    [[self keyboardWindow] setAlpha:0];
//    [UIView commitAnimations];
//    //当手指离开屏幕时，恢复不透明
//    if ([(UIPinchGestureRecognizer *)sender state] == UIGestureRecognizerStateEnded) {
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        [UIView beginAnimations:nil context:context];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//        [UIView setAnimationDuration:1.0];
//
//        [[self keyboardWindow] setAlpha:1];
//        [UIView commitAnimations];
//        
//        return;
//    }
//}

- (void)configureNotePad
{
    if( [[[ThemeManager sharedInstance] theme] isEqual:kThemeBlack] )
    {
        notePad.textView.textColor = textColor[1];
        notePad.horizontalLineColor = textColor[1];
        notePad.verticalLineColor = textColor[1];
        
        notePad.paperBackgroundColor = paperColor[0];
        

        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
            [screenLockBtn setImage:[[UIImage imageNamed:@"unlockedScreen.png"]
                                        imageWithTintColor:[UIColor btnGrayColor]]
                              forState:UIControlStateNormal];
            [paperButton setImage:[[UIImage imageNamed:@"paper.png"]
                                   imageWithTintColor:[UIColor btnGrayColor]]
                         forState:UIControlStateNormal];
        } else {
            [screenLockBtn setImage:[[UIImage imageNamed:@"unlock.png"]
                                        imageWithTintColor:[UIColor btnGrayColor]]
                              forState:UIControlStateNormal];
            [paperButton setImage:[[UIImage imageNamed:@"file.png"]
                                   imageWithTintColor:[UIColor btnGrayColor]]
                         forState:UIControlStateNormal];
        }

        [self configureBackViewBtn:backBtn];
        self.view.backgroundColor = [UIColor paperDarkGrayColor];
    } else {
        notePad.textView.textColor = textColor[0];
        notePad.horizontalLineColor = [UIColor lineLightRedColor];
        notePad.verticalLineColor = [UIColor lineLightGrayColor];
        notePad.paperBackgroundColor = paperColor[2];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
            [screenLockBtn setImage:[UIImage imageNamed:@"unlockedScreen.png"]
                              forState:UIControlStateNormal];
            
            [paperButton setImage:[UIImage imageNamed:@"paper.png"] forState:UIControlStateNormal];
        } else {
            [screenLockBtn setImage:[UIImage imageNamed:@"unlock.png"]
                              forState:UIControlStateNormal];
            [paperButton setImage:[UIImage imageNamed:@"file.png"] forState:UIControlStateNormal];
        }
        
        [self configureBackViewBtn:backBtn];
        self.view.backgroundColor = [UIColor paperWhiteColor];
    }
}

- (UIWindow *)keyboardWindow {
    NSArray *arr = [UIApplication sharedApplication].windows;
    for(UIWindow *w in arr) {
        NSString *wc = NSStringFromClass([w class]);
        if([wc isEqualToString:@"UITextEffectsWindow"]) {
            return w;
        }
    }
    return nil;
}

#pragma mark - Shake
- (BOOL) canBecomeFirstResponder
{
    return YES;
}

- (NSArray *)themes
{
    return @[kThemeRed, kThemeBlack, kThemeBlue];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        if( [[[ThemeManager sharedInstance] theme] isEqual:kThemeBlack] ) {
            [[ThemeManager sharedInstance] setTheme:kThemeBlue];
        } else{
            [[ThemeManager sharedInstance] setTheme:kThemeBlack];
        }
        [self configureNotePad];
        [self configureKeyboardView];
//        if (notePad.textView.isFirstResponder == YES) {
//            [self hiddenKeyBoard];
//            [notePad.textView becomeFirstResponder];
//        }
    }
}

-(NSArray*)subviewsOfView:(UIView*)view withType:(NSString*)type{
    NSString *prefix = [NSString stringWithFormat:@"<%@",type];
    NSMutableArray *subviewArray = [NSMutableArray array];
    for (UIView *subview in view.subviews) {
        NSArray *tempArray = [self subviewsOfView:subview withType:type];
        for (UIView *view in tempArray) {
            [subviewArray addObject:view];
        }
    }
    if ([[view description]hasPrefix:prefix]) {
        [subviewArray addObject:view];
    }
    return [NSArray arrayWithArray:subviewArray];
}

-(void)showKeyboardBackground:(BOOL)status{
    for (UIWindow *keyboardWindow in [[UIApplication sharedApplication] windows]) {
        for (UIView *keyboard in [keyboardWindow subviews]) {
            for (UIView *view in [self subviewsOfView:keyboard withType:@"UIKBBackgroundView"]) {
                view.hidden = status;
            }
        }
    }
}

#pragma mark - File
- (void) writeToFile:(NSString *)text withFileName:(NSString *)filePath{

    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:text];
    [array writeToFile:filePath atomically:YES];
}

- (NSString *) readFromFile:(NSString *)filepath{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]){
        NSArray *content = [[NSArray alloc] initWithContentsOfFile:filepath];
        NSString *data = [[NSString alloc] initWithFormat:@"%@", [content objectAtIndex:0]];
        return data;
    } else {
        return nil;
    }
}

- (NSString *) documentsPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsdir = [paths objectAtIndex:0];
    return documentsdir;
}


- (void) savePlist{

    // Create a new  dictionary for the new values
    NSMutableDictionary* newNote = [[NSMutableDictionary alloc] init];
    
    [newNote setValue:notePad.textView.text forKey:@"Text"];
    [newNote setObject:[NSDate date] forKey:@"CDate"];
    
    if(self.Notedict != nil){
        // We're working with an exisitng note, so let's remove
        // it from the array to get ready for a new one
        [self.noteArray removeObject:Notedict];
        self.Notedict = nil; //This will release our reference too
    }
    
    // Add it to the master  array and release our reference
    [self.noteArray addObject:newNote];
    
    // Sort the array since we just aded a new drink
    NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:@"CDate" ascending:NO selector:@selector(compare:)];
    [self.noteArray sortUsingDescriptors:[NSArray arrayWithObject:nameSorter]];
    
//    NSLog(@"noteAry:%@",noteArray);
    
    NSString *documentDirectory = [self applicationDocumentsDirectory];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.plist"];
    
    [self.noteArray writeToFile:path atomically:YES];
}

- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)regitserAsObserver
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(savePlist)
                   name:TextDidEdit
                 object:nil];
}

- (void)unregisterAsObserver
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}


@end
