//
//  TitleCollectionReusableView.m
//  FoldTableVIewText
//
//  Created by ZZCN77 on 2017/9/12.
//  Copyright © 2017年 co. All rights reserved.
//

#import "TitleCollectionReusableView.h"
/******* 屏幕尺寸 *******/
#define GFMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define GFMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define GFMainScreenBounds [UIScreen mainScreen].bounds

#define widthScale GFMainScreenWidth / 375.0
#define heightScale GFMainScreenHeight / 667.0
@implementation TitleCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, GFMainScreenWidth, 40)];
        headerView.backgroundColor =[UIColor whiteColor];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, GFMainScreenWidth - 20, 30)];
        //	147,112,219
        bgView.backgroundColor = [UIColor colorWithRed:147.0/255.0 green:112.0/255.0 blue:219.0/255.0 alpha:1.0];
        [headerView addSubview:bgView];
       _provinceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 26)];
        _provinceLabel.textColor = [UIColor whiteColor];
        _provinceLabel.text = @"商品1";
        [headerView addSubview:_provinceLabel];
        _selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(GFMainScreenWidth - 20 - 26, 10, 18, 18)];
        _selectImageView.image = [UIImage imageNamed:@"off"];

        [headerView addSubview:_selectImageView];
        [self addSubview:headerView];
    }
    return self;
}
@end
