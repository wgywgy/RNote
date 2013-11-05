//
//  NotePadViewController.h
//  TestNav
//
//  Created by D on 13-8-1.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "KOMovingBarViewController.h"

#import "UIColor+NoteAdditions.h"

#import "AppDelegate.h"
//@protocol KeyBoardWithToolBarDelegate <NSObject>
//
//@optional
//- (void)calcContentOffset:(NSInteger)offset;
//- (void)didClickDoneButton;
//
//- (void)onEditingComponent:(UIView *)component withOffset:(float)offset;
//
//@end

@class KGNotePad;
@interface NotePadViewController : BaseViewController
                                   <UIActionSheetDelegate,
                                    UITextViewDelegate,
                                    UITextFieldDelegate>
//                                    UIGestureRecognizerDelegate> 
//                                    UIScrollViewDelegate>
{
    CGRect rect_screen;
    BOOL didEdit;
    NSArray *paperColor;
    NSArray *textColor;
    UIBarButtonItem     *_doneButtonItem;               //完成按钮
    UIBarButtonItem     *_spaceButtonItem;              //空白按钮
    int fontSize;
    
//    BOOL isKeyboardOn;
//    UIWindow *keyboardWindow; // set in UIKeyboardDidShowNotification
//    
//    CGPoint beginOffset;
//    CGRect beginKeyboard;
//    CGRect beginView;
//    CGFloat currentOffset;
//    CGFloat maxOffset;
//    
//    CGFloat dragVelocity;
//    BOOL hideKeyboard;
    int notePadID;
	NSDictionary *Notedict;
	NSMutableArray *noteArray;
    
    int NoteTextCount;
    
    NSTimer *timer;
    UILabel *popView;
}

@property (nonatomic, retain) UIButton *paperButton;
@property (nonatomic, retain) UIButton *screenLockBtn;
@property (nonatomic, retain) UIButton *backBtn;
@property (nonatomic, retain) UIButton *shareBtn;

//@property (nonatomic, assign) id<KeyBoardWithToolBarDelegate> delegate;

@property (weak, nonatomic) IBOutlet KGNotePad *notePad;
@property (assign, nonatomic) int notePadID;
@property (assign, nonatomic) int NoteTextCount;

@property (nonatomic, retain) NSMutableArray* noteArray;
@property (nonatomic, retain) NSDictionary *Notedict;

@property (nonatomic, retain) UISlider * sliderFont;

//- (void)hiddenKeyBoard;

//- (UIWindow *)myWindow;
//- (UIWindow *)keyboardWindow;

@end
