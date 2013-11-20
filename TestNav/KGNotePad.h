//
//  KGNotePad.h
//  KGNotePad
//
//  Created by David Keegan on 2/23/13.
//  Copyright (c) 2013 David Keegan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DDHTextView.h"
@interface KGNotePadTextView : DDHTextView
@end

@interface KGNotePad : UIView

// TODO: figure out how to compute this
// TODO: 8 seems to be a good value for most fonts...
@property (nonatomic) CGFloat lineOffset;
@property (strong, nonatomic) UIColor *verticalLineColor;
@property (strong, nonatomic) UIColor *horizontalLineColor;
@property (strong, nonatomic) UIColor *paperBackgroundColor;
@property (weak, nonatomic, readonly) DDHTextView *textView;

@end
