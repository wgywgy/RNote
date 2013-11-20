//
//  mainViewController.h
//  TestNav
//
//  Created by D on 13-7-19.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KOMovingBarViewController.h"

@class shadeView;
@interface mainViewController : BaseViewController
                                <UITableViewDataSource,
                                UITableViewDelegate,
                                UISearchBarDelegate>
{
    CGRect rect_screen;
    NSArray *allItems;
    NSMutableArray* Notes;
    NSArray *searchResults;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

//@property (nonatomic, copy) NSArray *allItems;
@property (nonatomic, copy) NSArray *searchResults;

@property (nonatomic, retain) UIButton *addNoteBtn;
@property (nonatomic, retain) UIButton *editNoteBtn;
@property (nonatomic, retain) UIButton *doneBtn;
@property (nonatomic, retain) UIButton *settingBtn;

@property (nonatomic, retain) NSMutableArray *listNameArray;

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *noContentView;
@property (nonatomic, strong) UILabel *sadFace;
@property (nonatomic, strong) UILabel *sorry;

@property (nonatomic, retain) NSMutableArray* Notes;

@property (nonatomic, retain) UIButton *backBtn;
//@property (nonatomic, retain) shadeView *myListShade;
//@property (nonatomic, retain) UISearchBar *searchBar;

@end
