//
//  CustomCell.m
//  TableViewCustom
//
//  Created by D on 13-7-29.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        rect_screen = [[UIScreen mainScreen]bounds];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect bounds = self.bounds;
    self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    
    if (rect_screen.size.height == 480) {
        [self.textLabel setFrame:
         CGRectMake(8, 4, 304, bounds.size.height / 2)];
        [self.detailTextLabel setFrame:CGRectMake(8, bounds.size.height / 2 + 6,
                                                  304, 22)];
    } else {
        [self.textLabel setFrame:
         CGRectMake(8, 6, 304, bounds.size.height / 2)];
        [self.detailTextLabel setFrame:CGRectMake(8, bounds.size.height / 2 + 8,
                                                  304, 22)];
    }
    
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    //    568 480
//    self.textLabel.adjustsFontSizeToFitWidth = YES;
//    self.textLabel.lineBreakMode = NSLineBreakByCharWrapping|NSLineBreakByTruncatingTail;
//    self.textLabel.numberOfLines = 2;
    

}

- (void)didTransitionToState:(UITableViewCellStateMask)state
{
    CGRect bounds = self.bounds;
    if (state == UITableViewCellStateShowingEditControlMask) {
        if (rect_screen.size.height == 480) {
            [self.textLabel setFrame:
             CGRectMake(8, 4, 244, bounds.size.height / 2)];
        } else {
            [self.textLabel setFrame:
             CGRectMake(8, 6, 244, bounds.size.height / 2)];
        }
    }
    if (state == UITableViewCellStateShowingDeleteConfirmationMask) {
        if (rect_screen.size.height == 480) {
            [self.textLabel setFrame:
             CGRectMake(8, 4, 252, bounds.size.height / 2)];
        } else {
            [self.textLabel setFrame:
             CGRectMake(8, 6, 252, bounds.size.height / 2)];
        }
    }
}

- (void)changeBright
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
