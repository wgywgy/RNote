//
//  ViewController.h
//  TestNav
//
//  Created by D on 13-7-15.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePhotoViewController : BaseViewController//<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIButton *choosePictureBtn;
    CGRect rect_screen;
    __weak id weakSelf;
    BOOL result; //选择图片结果
    NSArray *pickerArray;
    float ios7_height;
}
@property(nonatomic,retain) UIImage* photo;
@property(nonatomic,retain) UIImageView* photoView;

@property (nonatomic,assign) CGRect rect_screen;

//@property (nonatomic,retain) NSArray *pickerArray;

@property(nonatomic,retain) UIButton *chooseLevelBtn;
@property(nonatomic,retain) UIButton *nextBtn;

//@property(nonatomic,strong) IBOutlet UITextField * selectCityField;//选择城市的第一响应者
//@property(nonatomic,strong)UIPickerView * selectCityPicker;  //选择城市用的picker

@end
