//
//  UIToolView.m
//  segmentView
//
//  Created by D on 13-11-13.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "UIToolView.h"
#import "UIColor+ToolViewColor.h"
#import "UIColor+NoteAdditions.h"
#import "PPiFlatSegmentedControl.h"
#import "SevenSwitch.h"
#import "CustomCell.h"

#define IOS7DIFFHEIGHT ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7 ? 64 : 0)
#define NUMBER_ITEMS_ON_LOAD 250

@implementation UIToolView

#pragma mark - View lifecycle -
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    rect_screen = [[UIScreen mainScreen]bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.286 green:0.290 blue:0.294 alpha:1.0];
        
        self.myTableview = [[UITableView alloc]initWithFrame:
                            CGRectMake(0, BARHEIGHT, 320, self.frame.size.height -BARHEIGHT)];
        self.myTableview.delegate = self;
        self.myTableview.dataSource = self;
        
        self.backgroundView = [[UIView alloc]initWithFrame:
                               CGRectMake(0, 0, 320, self.bounds.size.height)];
        [self addSubview:self.backgroundView];

        SevenSwitch *mySwitch2 = [[SevenSwitch alloc] initWithFrame:CGRectMake(254, 6, 60, 28)];
        
        [mySwitch2 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        mySwitch2.offImage = [UIImage imageNamed:@"switch1_gird.png"];
        mySwitch2.onImage = [UIImage imageNamed:@"switch1_list.png"];
        mySwitch2.onTintColor = [UIColor colorWithRed:0.086 green:0.086 blue:0.086 alpha:1.0];
        mySwitch2.activeColor = [UIColor colorWithRed:0.086 green:0.086 blue:0.086 alpha:1.0];
        
        mySwitch2.inactiveColor = [UIColor colorWithRed:0.086 green:0.086 blue:0.086 alpha:1.0];
        mySwitch2.borderColor = [UIColor colorWithRed:0.122 green:0.125 blue:0.125 alpha:1.0];
        mySwitch2.thumbTintColor = [UIColor colorWithRed:0.286 green:0.290 blue:0.294 alpha:1.0];
        mySwitch2.shadowColor = [UIColor colorWithRed:0.122 green:0.125 blue:0.125 alpha:1.0];
        [self.backgroundView addSubview:mySwitch2];
        
        // turn the switch on with animation
        [mySwitch2 setOn:NO animated:YES];
        
        _segmented=
        [[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(6, 6, 216, 28)
                                                 items:@[@{@"text":@"我的"},
                                                         @{@"text":@"朋友"},
                                                         @{@"text":@"消息"}
                                                         ]
                                          iconPosition:IconPositionRight
                                     andSelectionBlock:^(NSUInteger segmentIndex) {
                                         selectIndex = segmentIndex;
                                         NSLog(@"%d",selectIndex);
                                         if (mySwitch2.on) {
                                             if (selectIndex == 0) {
                                                 _currentData = self.segOneArray;
                                             } else if (selectIndex == 1) {
                                                 _currentData = self.segTwoArray;
                                             } else if (selectIndex == 2) {
                                                 _currentData = self.segThreeArray;
                                             }
                                             [_gmGridView reloadData];
                                         } else {
                                             [self.myTableview reloadData];
                                         }
                                     }];
        _segmented.color=[UIColor colorWithRed:0.286 green:0.290 blue:0.294 alpha:1.0];
        _segmented.borderWidth=1;
        _segmented.borderColor=[UIColor colorWithRed:0.122 green:0.125 blue:0.125 alpha:1.0];
        _segmented.selectedColor=[UIColor colorWithRed:0.086 green:0.086 blue:0.086 alpha:1.0];
        _segmented.textAttributes=@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],
                                   NSForegroundColorAttributeName:[UIColor colorWithRed:0.804 green:0.804 blue:0.804 alpha:1.0]};
        _segmented.selectedTextAttributes=@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],
                                           NSForegroundColorAttributeName:[UIColor whiteColor]};
        [self.backgroundView addSubview:_segmented];
        
        [self.backgroundView addSubview:self.myTableview];
        
        [self configureTableview];
    }
    return self;
}

#pragma mark - UITableview Delegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selectIndex == 0) {
        return _segOneArray.count;
    } else if (selectIndex == 1) {
        return _segTwoArray.count;
    } else if (selectIndex == 2) {
        return _segThreeArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellId";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if ( cell == nil ) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    [self prepareCell:cell atIndexPath:indexPath];
    return cell;
}

- (UITableViewCell *)prepareCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [self configureTableViewCell:cell];

    if (selectIndex == 0) {
        cell.textLabel.text = _segOneArray[indexPath.row];
    } else if (selectIndex == 1) {
        cell.textLabel.text = _segTwoArray[indexPath.row];
    } else if (selectIndex == 2) {
        cell.textLabel.text = _segThreeArray[indexPath.row];
    }
    cell.detailTextLabel.text = @"fakeText";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (rect_screen.size.height - 64) / 5;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
//        return NO;
//    }
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - Switch Method -
- (void)switchChanged:(SevenSwitch *)sender {
    NSLog(@"Changed value to: %@", sender.on ? @"ON" : @"OFF");
    if (sender.on) {
        self.myTableview.hidden = YES;
    
        if (selectIndex == 0) {
            _currentData = self.segOneArray;
        } else if (selectIndex == 1) {
            _currentData = self.segTwoArray;
        } else if (selectIndex == 2) {
            _currentData = self.segThreeArray;
        }
    
        NSInteger spacing = 12;
        
        GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:CGRectMake(0, BARHEIGHT,
                                                                              320, self.bounds.size.height -  BARHEIGHT)];
        gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        gmGridView.backgroundColor = [UIColor blueColor];
        [self.backgroundView addSubview:gmGridView];
        _gmGridView = gmGridView;
        
        _gmGridView.style = GMGridViewStyleSwap;
        _gmGridView.itemSpacing = spacing;
        _gmGridView.minEdgeInsets = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
        _gmGridView.centerGrid = YES;
        _gmGridView.actionDelegate = self;
        _gmGridView.sortingDelegate = self;
        _gmGridView.dataSource = self;
        
        _gmGridView.mainSuperView = self.backgroundView;
        [_gmGridView reloadData];
    } else {
        [_gmGridView removeFromSuperview];
        self.myTableview.hidden = NO;
        [self.myTableview reloadData];
    }
}

#pragma mark - GMGridViewDataSource -
- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [_currentData count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return CGSizeMake(128, 136);
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        view.backgroundColor = [UIColor lightGrayColor];
        view.layer.masksToBounds = NO;
        view.layer.cornerRadius = 8;
        
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.text = (NSString *)[_currentData objectAtIndex:index];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.highlightedTextColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    [cell.contentView addSubview:label];
    
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return YES; //index % 2 == 0;
}

#pragma mark - GMGridViewActionDelegate -
- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    NSLog(@"Did tap at index %d", position);
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    NSLog(@"Tap on empty space");
}

- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Are you sure you want to delete this item?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    
    [alert show];
    
    _lastDeleteItemIndexAsked = index;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [_currentData removeObjectAtIndex:_lastDeleteItemIndexAsked];
        [_gmGridView removeObjectAtIndex:_lastDeleteItemIndexAsked withAnimation:GMGridViewItemAnimationFade];
    }
}

#pragma mark - GMGridViewSortingDelegate -
- (void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor blackColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil
     ];
}

- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor grayColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil
     ];
}

- (BOOL)GMGridView:(GMGridView *)gridView
shouldAllowShakingBehaviorWhenMovingCell:(GMGridViewCell *)cell
           atIndex:(NSInteger)index
{
    return YES;
}

- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex
{
    NSObject *object = [_currentData objectAtIndex:oldIndex];
    [_currentData removeObject:object];
    [_currentData insertObject:object atIndex:newIndex];
}

- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
{
    [_currentData exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
}

#pragma mark - DraggableGridViewTransformingDelegate -
- (void)GMGridView:(GMGridView *)gridView didStartTransformingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor blueColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil];
}

- (void)GMGridView:(GMGridView *)gridView didEndTransformingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor redColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil];
}

#pragma mark - Theme Change -
- (void)configureTableViewCell:(UITableViewCell *)aCell
{
    if ( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlue] )
    {
        aCell.textLabel.textColor = [UIColor fontBlackColor];
        aCell.detailTextLabel.textColor = [UIColor blueNavigationColor];
        
        aCell.backgroundColor = [UIColor clearColor];
    }
    else if ( [[[ThemeManager sharedInstance] theme] isEqual: kThemeRed] )
    {
        aCell.textLabel.textColor = [UIColor fontBlackColor];
        aCell.detailTextLabel.textColor = [UIColor redNavigationColor];
        
        aCell.backgroundColor = [UIColor clearColor];
        
    }
    else if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] )
    {
        aCell.textLabel.textColor = [UIColor btnGrayColor];
        aCell.detailTextLabel.textColor = [UIColor btnGrayColor];
        
        aCell.backgroundColor = [UIColor paperDarkGrayColor];
    }
}


- (void)configureTableview
{
    if ( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlue] )
    {
        self.myTableview.backgroundColor = [UIColor paperWhiteColor];
        self.backgroundColor = [UIColor paperWhiteColor];
        self.myTableview.separatorColor = [UIColor lineLightGrayColor];
        self.myTableview.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        for (UITableViewCell *aCell in self.myTableview.subviews) {
            if ([aCell isKindOfClass:[UITableViewCell class]]) {
                aCell.textLabel.textColor = [UIColor fontBlackColor];
            }
        }
    }
    else if ( [[[ThemeManager sharedInstance] theme] isEqual: kThemeRed] )
    {
        //        self.myTableView.backgroundColor = [UIColor paperWhiteColor];
        self.backgroundColor = [UIColor paperWhiteColor];
        self.myTableview.separatorColor = [UIColor lineLightGrayColor];
        self.myTableview.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        for (UITableViewCell *aCell in self.myTableview.subviews) {
            if ([aCell isKindOfClass:[UITableViewCell class]]) {
                aCell.textLabel.textColor = [UIColor fontBlackColor];
            }
        }
    }
    else if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] )
    {
        //        self.myTableView.backgroundColor = [UIColor redColor];
        self.backgroundColor = [UIColor paperDarkGrayColor];
        self.myTableview.separatorColor = [UIColor fontDarkGrayColor];
        self.myTableview.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        for (UITableViewCell *aCell in self.myTableview.subviews) {
            if ([aCell isKindOfClass:[UITableViewCell class]]) {
                aCell.textLabel.textColor = [UIColor btnGrayColor];
            }
        }
    }
}
@end