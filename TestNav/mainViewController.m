//
//  mainViewController.m
//  TestNav
//
//  Created by D on 13-7-19.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "mainViewController.h"

#import "mySettingsViewController.h"

#import "CustomCell.h"

#import "NotePadViewController.h"

#import "shadeView.h"

#import "UIImage+Tint.h"

#import <QuartzCore/QuartzCore.h>

#import "RMEIdeasPullDownControl.h"

#define kLastSelected @"kLastSelected"
#define kBrandName @"brandName"
#define kBrandValue @"brandValue"
#define kfoundedDate @"foundedDate"

typedef enum
{
    AtoZ = 0,
    ZtoA,
    HighestToLowest,
    LowestToHighest,
    OldestToNewest,
    NewestToOldest
}
TableSortSortCriteria;

@interface mainViewController ()//<RMEIdeasPullDownControlDataSource,
                                //RMEIdeasPullDownControlProtocol>

//@property (strong, nonatomic) RMEIdeasPullDownControl *rmeideasPullDownControl;
@property (strong, nonatomic) NSArray *sortTitlesArray;

@end

@implementation mainViewController
@synthesize doneBtn, settingBtn, noContentView, sorry, sadFace, searchBar;
@synthesize searchDisplayController, searchResults, Notes;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillTerminate:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];

//    self.Notes = [[NSMutableArray alloc]initWithCapacity:0];
//    self.view.backgroundColor = [UIColor paperWhiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
//    [self setNeedsStatusBarAppearanceUpdate];
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleBlackOpaque;
//}

- (void)addNoContentViewWithAnimation:(BOOL)animate
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        noContentView = [[UIView alloc]initWithFrame:
                         CGRectMake(0, 64, 320, rect_screen.size.height - 64)];
    } else {
        noContentView = [[UIView alloc]initWithFrame:
                         CGRectMake(0, 0, 320, rect_screen.size.height - 64)];
    }
    
    if (animate == YES) {
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.3;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionFade;
        
        [[self.view layer] addAnimation:animation forKey:@"animation"];
    }
    
    sadFace = [[UILabel alloc]initWithFrame:CGRectMake(28, rect_screen.size.height -64 -122, 296, 44)];
    sadFace.text = @":(";
    sadFace.backgroundColor = [UIColor clearColor];
    sadFace.font = [UIFont boldSystemFontOfSize:46];
    [noContentView addSubview:sadFace];
    
    sorry = [[UILabel alloc]initWithFrame:CGRectMake(28, rect_screen.size.height -64 -64, 320, 44)];
    sorry.text = NSLocalizedString(@"You do not have notes", @"");
    sorry.backgroundColor = [UIColor clearColor];
    sorry.font = [UIFont boldSystemFontOfSize:24];
    [noContentView addSubview:sorry];
    [self.view addSubview:noContentView];
}

- (void)initViews
{
    _addNoteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 30)];
    [_addNoteBtn addTarget:self action:@selector(addNote:) forControlEvents:UIControlEventTouchUpInside];
    [_addNoteBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
    [_addNoteBtn setBackgroundImage:[[UIImage imageNamed:@"NavigationButtonBG"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]
                           forState:UIControlStateNormal];
    
    _editNoteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 56, 30)];
    [_editNoteBtn addTarget:self action:@selector(toggleEditMode:) forControlEvents:UIControlEventTouchUpInside];
    [_editNoteBtn setTitle:NSLocalizedString(@"Edit", @"") forState:UIControlStateNormal];
    _editNoteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    
    [_editNoteBtn setBackgroundImage:[[UIImage imageNamed:@"NavigationButtonBG"]
                                      resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]
                            forState:UIControlStateNormal];

    doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 56, 30)];
    [doneBtn addTarget:self action:@selector(toggleEditMode:) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setTitle:NSLocalizedString(@"Done", @"") forState:UIControlStateNormal];
    [doneBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [doneBtn setBackgroundImage:[[UIImage imageNamed:@"NavigationButtonBG"]
                                 resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]
                       forState:UIControlStateNormal];
    
    settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 30)];
    [settingBtn addTarget:self action:@selector(showSettings:) forControlEvents:UIControlEventTouchUpInside];

    [self setEditing:NO animated:NO];
    self.title = NSLocalizedString(@"apptitle", @"");
    rect_screen = [[UIScreen mainScreen]bounds];
    
//    _listNameArray = [@[
//                      @"The max length of every cell aaa", @"每个单元格支持的最大长度", @"Earth",
//                      @"Mars", @"Jupiter", @"Saturn",
//                      @"Uranus", @"Neptune" ,@"a"
//                      ] mutableCopy];
    //滚动条偏移
//    self.myTableView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
    
//    self.myTableView.frame = CGRectMake(0, 100, 320, rect_screen.size.height - 64);
    
    NSString *documentDirectory = [self applicationDocumentsDirectory];
	NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.plist"];
	
	NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
	self.Notes = tmpArray;
    
    //没有内容时覆盖图层
    NSLog(@"Notes:%@",self.Notes);
    if (self.Notes.count == 0) {
        [self addNoContentViewWithAnimation:NO];
    }
    
    //Create an array of titles to display as different functions are selected by the user.
    self.sortTitlesArray = @[@"Listed from A - Z", @"Listed from Z - A", @"Brand value: HIGHEST - LOWEST", @"Brand value: LOWEST - HIGHEST", @"Founded: OLDEST - NEWEST", @"Founded: NEWEST - OLDEST"];
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [self.myTableView setContentOffset:CGPointMake(0, 44)];
//    }
//    self.rmeideasPullDownControl = [[RMEIdeasPullDownControl alloc] initWithDataSource:self
//                                                                              delegate:self
//                                                                      clientScrollView:self.myTableView];
    
//    CGRect originalFrame = self.rmeideasPullDownControl.frame;
//    self.rmeideasPullDownControl.frame = CGRectMake(0.0, 44.0, originalFrame.size.width, originalFrame.size.height);
    
    //It is recommended that the control is placed behind the client scrollView. Remember to make its background transparent.
//    [self.view insertSubview:self.rmeideasPullDownControl belowSubview:self.myTableView];
    
}

- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//    self.navigationController.navigationBar.frame = CGRectMake(0, 20, 320, 44);
    if (self.Notes.count > 0) {
        noContentView.hidden = YES;
        [self.myTableView reloadData];
        [self configureViews];
    }
    
//    NSMutableArray *titleArray = [[NSMutableArray alloc]initWithCapacity:0];
//    for (int i = 1; i <= [self getNotePadID]; i++) {
//        [titleArray addObject:[self getTitleWithNoteId:i]];
//    }
//    NSLog(@"title:%@",titleArray);
    
//    self.allItems = self.Notes;
//     [[self.Notes objectAtIndex:indexPath.row ]objectForKey:@"Text"];
    NSMutableArray *titleArray = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i < self.Notes.count; i++) {
        [titleArray addObject:self.Notes[i][@"Text"]];
    }
    

    NSLog(@"%@",self.Notes);
    [self configureTableViewCover:self.myTableView];

    //Tell the control what selection to make. In this case we use NSUserDefaults to save and retrieve last selection made.
//    [self.rmeideasPullDownControl selectControlAtIndex:
//     [[NSUserDefaults standardUserDefaults] integerForKey:kLastSelected]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]postNotificationName:dragBackStatus
                                                       object:nil];
    __weak id weakSelf = self;
    self.searchDisplayController.delegate = weakSelf;
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.searchDisplayController.delegate = nil; 
}

- (void)addNote:(id)sender
{
    [self createList:sender];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	
    [self.myTableView setEditing:editing animated:animated];
    

    if (editing) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            self.navigationItem.leftBarButtonItem =
            [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Done", @"")
                                            style:UIBarButtonItemStyleDone
                                           target:self
                                           action:@selector(toggleEditMode:)];
            
            self.navigationItem.leftBarButtonItem.tintColor = [UIColor paperWhiteColor];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:settingBtn];
            self.navigationItem.rightBarButtonItem.tintColor = [UIColor paperWhiteColor];
        } else {
            [settingBtn setBackgroundImage:[[UIImage imageNamed:@"NavigationButtonBG"]
                                            resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]
                                  forState:UIControlStateNormal];
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:doneBtn];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:settingBtn];
        }
    } else {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            self.navigationItem.leftBarButtonItem =
            [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Edit", @"")
                                            style:UIBarButtonItemStyleDone
                                           target:self
                                           action:@selector(toggleEditMode:)];
            self.navigationItem.leftBarButtonItem.tintColor = [UIColor paperWhiteColor];
            self.navigationItem.rightBarButtonItem =
            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                         target:self
                                                         action:@selector(addNote:)];
            self.navigationItem.rightBarButtonItem.tintColor = [UIColor paperWhiteColor];
        } else {
            [settingBtn setBackgroundImage:[[UIImage imageNamed:@"NavigationButtonBG"]
                                            resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]
                                  forState:UIControlStateNormal];
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_editNoteBtn];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_addNoteBtn];
        }
    }
    
    [self configureButton];
    
//    UIImage *backButtonImage = [UIImage imageNamed:@"arrow_back.png"];
//    backButtonImage = [backButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem * backButton = [[UIBarButtonItem alloc]
//                                    initWithImage:backButtonImage
//                                    style:UIBarButtonItemStylePlain
//                                    target:nil
//                                    action:nil];
//    [[self navigationItem] setBackBarButtonItem:backButton];
}

- (void)toggleEditMode:(id)sender {
	[self setEditing:!self.editing animated:YES];
}

- (void)showSettings:(id)sender {
	mySettingsViewController *viewController = [[mySettingsViewController alloc]initWithNibName:@"mySettingsViewController" bundle:nil];
	MLNavigationController *navigationController = [[MLNavigationController alloc] initWithRootViewController:viewController];
	navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self toggleEditMode:self];
    
	[self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

- (NSString *)getTitleWithNoteId:(int)noteId
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:[NSString stringWithFormat:@"Note%dTitle",noteId]];
}

- (void)filterContentForSearchText:(NSString*)searchText
                             scope:(NSString*)scope {
    NSPredicate *search = [NSPredicate predicateWithFormat:@"(Text contains[c] %@)",searchText];
    NSArray *filtered = [self.Notes filteredArrayUsingPredicate:search];
    self.searchResults = filtered;
}

-(void)configureSearchResultTableView:(UISearchDisplayController *)controller
{
    if ( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] )
    {
        [controller.searchResultsTableView setBackgroundColor:[UIColor paperDarkGrayColor]];
        [controller.searchResultsTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        [controller.searchResultsTableView setSeparatorColor:[UIColor btnGrayColor]];
    } else {
        [controller.searchResultsTableView setBackgroundColor:[UIColor paperWhiteColor]];
        [controller.searchResultsTableView setIndicatorStyle:UIScrollViewIndicatorStyleDefault];
        [controller.searchResultsTableView setSeparatorColor:[UIColor lineLightGrayColor]];
    }
        [controller.searchResultsTableView setRowHeight:(rect_screen.size.height - 64) / 5];
    [self configureTableViewCover:controller.searchResultsTableView];
}

#pragma mark - UISearchDisplayController delegate methods
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar                                                      selectedScopeButtonIndex]]];
    
    [self configureSearchResultTableView:controller];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption {
    
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:searchOption]];
    
    return YES;
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        return [self.searchResults count];
    }else{
        return [self.Notes count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellId";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell =
        [[CustomCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                         reuseIdentifier:cellId];
    }
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        
//        NSLog(@"res:%@",self.searchResults);
        cell.textLabel.text = self.searchResults[indexPath.row][@"Text"];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat: @"yyyy-MM-dd HH:mm"];
        
        NSDate *dateTmp;
        dateTmp = self.searchResults[indexPath.row][@"CDate"];
        cell.detailTextLabel.text = [dateFormat stringFromDate: dateTmp];
        
    }else{
        cell.textLabel.text = [[self.Notes objectAtIndex:indexPath.row ]objectForKey:@"Text"];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat: @"yyyy-MM-dd HH:mm"];
        
        NSDate *dateTmp;
        dateTmp = [[self.Notes objectAtIndex:indexPath.row ]objectForKey:@"CDate"];
        cell.detailTextLabel.text = [dateFormat stringFromDate: dateTmp];
    }
    
    cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    [self configureTableViewCell:cell];
//
////    return cell;
//
//    UIView * subview = [[XXView alloc] init];
//    subview.userInteractionEnabled = NO;// 不设为NO会屏蔽cell的点击事件
//    subview.backgroundColor = [UIColor clearColor];// 设为透明从而使得cell.backgroundColor有效.
//    subview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [cell.contentView addSubview:subview];// cell.contentView是个readonly属性,所以别想着替换contentView了.
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotePadViewController *notePad = [[NotePadViewController alloc]init];
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        notePad.Notedict = [self.searchResults objectAtIndex:indexPath.row];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat: @"yyyy-MM-dd"];
        
        NSDate *dateTmp;
        dateTmp = self.searchResults[indexPath.row][@"CDate"];
        notePad.title = [dateFormat stringFromDate: dateTmp];
    } else {
        notePad.Notedict = [self.Notes objectAtIndex:indexPath.row];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat: @"yyyy-MM-dd"];
        
        NSDate *dateTmp;
        dateTmp = self.Notes[indexPath.row][@"CDate"];
        notePad.title = [dateFormat stringFromDate: dateTmp];
        
    }
    notePad.noteArray = self.Notes;
    
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:notePad animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (rect_screen.size.height - 64) / 5;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        return NO;
    }
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void) tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toIndexPath:(NSIndexPath *)destinationIndexPath
{
	if (sourceIndexPath.row == destinationIndexPath.row) {
		return;
	}
	
    NSUInteger fromRow = [sourceIndexPath row];
    NSUInteger toRow = [destinationIndexPath row];
    id object = self.Notes[fromRow];
    [self.Notes removeObjectAtIndex:fromRow];
//    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:sourceIndexPath]
//                     withRowAnimation:UITableViewRowAnimationFade];
    [self.Notes insertObject:object atIndex:toRow];
    
    //id object = [self.list objectAtIndex:fromRow];
    //[self.list removeObjectAtIndex:fromRow];
    //[self.list insertObject:object atIndex:toRow];
}

-  (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.Notes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationNone];
        
        if (self.Notes.count == 0) {
            if (self.noContentView == nil) {
                [self addNoContentViewWithAnimation:YES];
                [self configureNoContentView];
            } else {
                CATransition *animation = [CATransition animation];
                animation.delegate = self;
                animation.duration = 0.3;
                animation.timingFunction = UIViewAnimationCurveEaseInOut;
                animation.type = kCATransitionFade;
                
                [[self.noContentView layer] addAnimation:animation forKey:@"animation"];
                
                self.noContentView.hidden = NO;
                [self configureTableViewCover:tableView];
            }
        }
        [self configureTableViewCover:tableView];
        
        NSString *documentDirectory = [self applicationDocumentsDirectory];
        NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.plist"];
        
        [self.Notes writeToFile:path atomically:YES];
    }
}

- (NSString *) documentsPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsdir = [paths objectAtIndex:0];
    return documentsdir;
}

- (NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return NSLocalizedString(@"Delete", @"");
}

- (void)deleteFileWithPath:(NSString *)aPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:aPath error:nil];
}

//文件重命名
- (void)renameFile:(NSString *)filePath andNewFile:(NSString *)filePath2
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    [fileMgr moveItemAtPath:filePath toPath:filePath2 error:nil];
}

- (void)changeNoteId:(int)i
{
    NSString *fileName = [[self documentsPath] stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"Note%dTxt",i + 1]];
    NSString *newFileName = [[self documentsPath] stringByAppendingPathComponent:
                             [NSString stringWithFormat:@"Note%dTxt",i]];
    [self renameFile:fileName andNewFile:newFileName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createList:(id)sender {
    NotePadViewController *notePad = [[NotePadViewController alloc]init];
#pragma mark - warnning
    if (self.Notes == nil) {
        self.Notes = [[NSMutableArray alloc]initWithCapacity:0];
    }
	notePad.noteArray = self.Notes;
    
    NSLog(@"note:%@ notes:%@",notePad.noteArray, self.Notes);
    
    notePad.title = [self getDateAndTime];
    [self.navigationController pushViewController:notePad animated:YES];

    return;
}

- (NSString *)getDateAndTime
{
    NSDate* now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit;
    NSDateComponents *dd = [cal components:unitFlags fromDate:now];
    int y = [dd year];
    int m = [dd month];
    int d = [dd day];
    
    int hour = [dd hour];
    int min = [dd minute];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    int noteId = [defaults integerForKey:@"NoteId"];
    [defaults setInteger:d forKey:[NSString stringWithFormat:@"Note%dDay",noteId]];
    [defaults setInteger:y forKey:[NSString stringWithFormat:@"Note%dYear",noteId]];
    [defaults setInteger:m forKey:[NSString stringWithFormat:@"Note%dMonth",noteId]];
        
    [defaults setInteger:hour forKey:[NSString stringWithFormat:@"Note%dHour",noteId]];
    [defaults setInteger:min forKey:[NSString stringWithFormat:@"Note%dMin",noteId]];
    [defaults synchronize];
    
    return [NSString stringWithFormat:@"%d-%d-%d", y, m, d];
}

- (void)configureViews
{
    [super configureViews];
    
    // apply the theme
    [self configureButton];
    NSLog(@"self.Notes:%@",self.Notes);
    if (self.Notes.count > 0) {
//        NSLog(@"id:%d",[self getNotePadID]);
        [self configureTableview];
    } else {
        [self configureNoContentView];
    }
    
    [self configureSearchBar];
}

- (void)configureTableview
{
    if ( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlue] )
    {
//        self.myTableView.backgroundColor = [UIColor paperWhiteColor];
        self.view.backgroundColor = [UIColor paperWhiteColor];
        self.myTableView.separatorColor = [UIColor lineLightGrayColor];
        self.myTableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        for (UITableViewCell *aCell in self.myTableView.subviews) {
            if ([aCell isKindOfClass:[UITableViewCell class]]) {
                aCell.textLabel.textColor = [UIColor fontBlackColor];
            }
        }
    }
    else if ( [[[ThemeManager sharedInstance] theme] isEqual: kThemeRed] )
    {
//        self.myTableView.backgroundColor = [UIColor paperWhiteColor];
        self.view.backgroundColor = [UIColor paperWhiteColor];
        self.myTableView.separatorColor = [UIColor lineLightGrayColor];
        self.myTableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        for (UITableViewCell *aCell in self.myTableView.subviews) {
            if ([aCell isKindOfClass:[UITableViewCell class]]) {
                aCell.textLabel.textColor = [UIColor fontBlackColor];
            }
        }
    }
    else if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] )
    {
//        self.myTableView.backgroundColor = [UIColor redColor];
        self.view.backgroundColor = [UIColor paperDarkGrayColor];
        self.myTableView.separatorColor = [UIColor fontDarkGrayColor];
        self.myTableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        for (UITableViewCell *aCell in self.myTableView.subviews) {
            if ([aCell isKindOfClass:[UITableViewCell class]]) {
                aCell.textLabel.textColor = [UIColor btnGrayColor];
            }
        }
    }
}

- (void)configureTableViewCover:(UITableView *)aTableView
{
    NSLog(@"count%d",self.Notes.count);
    if (self.Notes.count < 5) {
        UIView *view = [[UIView alloc] initWithFrame:
                        CGRectMake(0, 0,
                                   CGRectGetWidth(self.myTableView.frame),
                                   (rect_screen.size.height - 64) / 5 * (5 - self.Notes.count))];
        [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] ) {
            [view setBackgroundColor:[UIColor paperDarkGrayColor]];
        } else {
            [view setBackgroundColor:[UIColor paperWhiteColor]];
        }
        
        aTableView.tableFooterView = view;
        aTableView.backgroundColor = [UIColor paperWhiteColor];
    }
}

- (void)configureNoContentView
{
    if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] ) {
        noContentView.backgroundColor = [UIColor tableViewDrakBackgroundColor];
        sorry.textColor = [UIColor fontNightWhiteColor];
        sadFace.textColor = [UIColor fontNightWhiteColor];
    } else {
        noContentView.backgroundColor = [UIColor tableViewBackgroundColor];
        sorry.textColor = [UIColor fontBlackColor];
        sadFace.textColor = [UIColor fontBlackColor];
    }
}

- (void)configureTableViewCell:(UITableViewCell *)aCell
{

    if ( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlue] )
    {
        aCell.textLabel.textColor = [UIColor fontBlackColor];
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//            aCell.detailTextLabel.textColor = [UIColor colorWithRed:0.435 green:0.725 blue:1.000 alpha:1.0];
//        } else {
            aCell.detailTextLabel.textColor = [UIColor blueNavigationColor];
//        }

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

- (void)configureButton
{
    if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] )
    {

        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            [settingBtn setImage:[[UIImage imageNamed:@"config.png"]
                                  imageWithTintColor:[UIColor btnGrayColor]]
                        forState:UIControlStateNormal];
            [settingBtn setImageEdgeInsets:UIEdgeInsetsMake(-2, 16, 0, 0)];
        } else {
            [settingBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
            _editNoteBtn.titleLabel.textColor = [UIColor btnGrayColor];
            doneBtn.titleLabel.textColor = [UIColor btnGrayColor];
            [_addNoteBtn setImage:[[UIImage imageNamed:@"plus.png"]
                                   imageWithTintColor:[UIColor btnGrayColor]]
                         forState:UIControlStateNormal];
            [settingBtn setImage:[[UIImage imageNamed:@"settings.png"]
                                  imageWithTintColor:[UIColor btnGrayColor]]
                        forState:UIControlStateNormal];
        }
    } else {

        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            [settingBtn setImage:[UIImage imageNamed:@"config.png"]
                        forState:UIControlStateNormal];
            [settingBtn setImage:[[UIImage imageNamed:@"configSelected"] imageWithTintColor:[UIColor lightGrayColor]]
                        forState:UIControlStateHighlighted];
            [settingBtn setImageEdgeInsets:UIEdgeInsetsMake(-2, 16, 0, 0)];
        } else {
            [settingBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
            _editNoteBtn.titleLabel.textColor = [UIColor whiteColor];
            doneBtn.titleLabel.textColor = [UIColor whiteColor];
            [_addNoteBtn setImage:[UIImage imageNamed:@"plus.png"]
                         forState:UIControlStateNormal];
            [settingBtn setImage:[UIImage imageNamed:@"settings.png"]
                        forState:UIControlStateNormal];
        }
    }
}

- (void)configureSearchBar
{
    if( [[[ThemeManager sharedInstance] theme] isEqual: kThemeBlack] )
    {
        self.searchBar.barStyle = UIBarStyleBlack;
        [self.searchBar setSearchFieldBackgroundPositionAdjustment:UIOffsetMake(0, -1)];
        [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"searchField.png"]
                                             forState:UIControlStateNormal];
        [self.searchBar setImage:[UIImage imageNamed:@"searchFieldIcon.png"]
                forSearchBarIcon:UISearchBarIconSearch
                           state:UIControlStateNormal];
        
        for (UIView *aView in self.searchBar.subviews) {
            if ([aView isKindOfClass:NSClassFromString(@"UITextField")]) {
                ((UITextField *)aView).textColor = [UIColor lineLightGrayColor];
                UIColor *color = [UIColor lineLightGrayColor];
                ((UITextField *)aView).attributedPlaceholder =
                [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Search", @"")
                                                attributes:@{NSForegroundColorAttributeName: color}];
                break;
            }
        }
    } else {
        self.searchBar.barStyle = UIBarStyleDefault;
        [self.searchBar setSearchFieldBackgroundImage:[[UIImage imageNamed:@"searchField.png"]
                                                       imageWithTintColor:[UIColor paperWhiteColor]]
                                             forState:UIControlStateNormal];
        [self.searchBar setImage:[UIImage imageNamed:@"searchFieldIcon.png"]
                forSearchBarIcon:UISearchBarIconSearch
                           state:UIControlStateNormal];

        for (UIView *aView in self.searchBar.subviews) {
            if ([aView isKindOfClass:NSClassFromString(@"UITextField")]) {
                ((UITextField *)aView).textColor = [UIColor blackColor];
                UIColor *color = [UIColor btnGrayColor];
                ((UITextField *)aView).attributedPlaceholder =
                [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Search", @"")
                                                attributes:@{NSForegroundColorAttributeName: color}];
                break;
            }
        }

    }
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
//    [sectionView setBackgroundColor:[UIColor paperWhiteColor]];
//    
//    //增加UILabel
//    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 18)];
//    [dateLabel setTextColor:[UIColor blackColor]];
//    [dateLabel setBackgroundColor:[UIColor clearColor]];
//    dateLabel.text = @"2012年 3月";
//    dateLabel.textAlignment = NSTextAlignmentCenter;
//
//    [sectionView addSubview:dateLabel];
//    return sectionView;  
//}

- (void)scrollToTopAnimated:(BOOL)animated {
	[self.myTableView setContentOffset:CGPointMake(0.0f, 0.0f) animated:animated];
}

-(void) applicationWillTerminate: (NSNotification *)notification {
	
//	NSLog(@"got app will terminate");
	NSString *documentDirectory = [self applicationDocumentsDirectory];
	NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.plist"];
	
	[self.Notes writeToFile:path atomically:YES];
}

#pragma mark - RMEIdeasePullDownControl DataSource and Delegate methods
//- (void) rmeIdeasPullDownControl:(RMEIdeasPullDownControl*)rmeIdeasPullDownControl
//          selectedControlAtIndex:(NSUInteger)controlIndex
//{
//    NSSortDescriptor *sortDescriptor = nil;
//    NSArray *sortDescriptors = nil;
//    
//    switch (controlIndex)
//    {
//        case AtoZ:
//            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kBrandName ascending:YES];
//            sortDescriptors = @[sortDescriptor];
//            break;
//            
//        case ZtoA:
//            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kBrandName ascending:NO];
//            sortDescriptors = @[sortDescriptor];
//            break;
//            
//        case HighestToLowest:
//            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kBrandValue ascending:NO];
//            sortDescriptors = @[sortDescriptor];
//            break;
//            
//        case LowestToHighest:
//            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kBrandValue ascending:YES];
//            sortDescriptors = @[sortDescriptor];
//            break;
//            
//        case OldestToNewest:
//            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kfoundedDate ascending:YES];
//            sortDescriptors = @[sortDescriptor];
//            break;
//            
//        case NewestToOldest:
//            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kfoundedDate ascending:NO];
//            sortDescriptors = @[sortDescriptor];
//            break;
//            
//        default:
//            break;
//    }
////    [self.myTableView setContentOffset:CGPointMake(0, -44)];
////    self.Notes = [self.Notes sortedArrayUsingDescriptors:sortDescriptors];
//    [self.myTableView reloadData];
//    
//}

- (NSUInteger) numberOfButtonsRequired:(RMEIdeasPullDownControl*)rmeIdeasPullDownControl
{
    return 6;
}

- (UIImage*)rmeIdeasPullDownControl:(RMEIdeasPullDownControl*)rmeIdeasPullDownControl
             imageForControlAtIndex:(NSUInteger)controlIndex
{
    UIImage *image0 = [UIImage imageNamed:@"SortAZ.png"];
    UIImage *image1 = [UIImage imageNamed:@"SortZA.png"];
    UIImage *image2 = [UIImage imageNamed:@"HighLow.png"];
    UIImage *image3 = [UIImage imageNamed:@"LowHigh.png"];
    UIImage *image4 = [UIImage imageNamed:@"OldNew.png"];
    UIImage *image5 = [UIImage imageNamed:@"NewOld.png"];
    
    NSArray *imagesArray = @[image0, image1, image2, image3, image4, image5];
    return imagesArray[controlIndex];
}

- (UIImage*)rmeIdeasPullDownControl:(RMEIdeasPullDownControl*)rmeIdeasPullDownControl
     selectedImageForControlAtIndex:(NSUInteger)controlIndex
{
    UIImage *image0 = [UIImage imageNamed:@"SortAZSelected.png"];
    UIImage *image1 = [UIImage imageNamed:@"SortZASelected.png"];
    UIImage *image2 = [UIImage imageNamed:@"HighLowSelected.png"];
    UIImage *image3 = [UIImage imageNamed:@"LowHighSelected.png"];
    UIImage *image4 = [UIImage imageNamed:@"OldNewSelected.png"];
    UIImage *image5 = [UIImage imageNamed:@"NewOldSelected.png"];
    
    NSArray *imagesArray = @[image0, image1, image2, image3, image4, image5];
    return imagesArray[controlIndex];
}

- (NSString*)rmeIdeasPullDownControl:(RMEIdeasPullDownControl*)rmeIdeasPullDownControl
              titleForControlAtIndex:(NSUInteger)controlIndex
{
    return self.sortTitlesArray[controlIndex];
}

@end