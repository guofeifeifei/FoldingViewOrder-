//
//  CollectionViewCell.m
//  FoldTableVIewText
//
//  Created by ZZCN77 on 2017/9/12.
//  Copyright © 2017年 co. All rights reserved.
//

#import "CollectionViewCell.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]/// rgb颜色转换（16进制->10进制）
@interface CollectionViewCell(){
    NSString *_titleStr;
    NSString *_detailStr;
}
@end
@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLable = [[UILabel alloc] init];
        self.titleLable.numberOfLines = 1;
        NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15.0f] ,NSForegroundColorAttributeName:UIColorFromRGB(0x444444)};
        self.titleLable.attributedText = [[NSAttributedString alloc]initWithString:@"客户名称ss：" attributes:attrs];
        self.titleLable.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.titleLable];
                self.detailLable = [[UILabel alloc] init];
        self.detailLable.numberOfLines = 0;
        NSDictionary *attrs2 = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15.0f] ,NSForegroundColorAttributeName:UIColorFromRGB(0x444444)};
        self.detailLable.font = [UIFont systemFontOfSize:12];

        self.detailLable.attributedText = [[NSAttributedString alloc]initWithString:@"wangzi" attributes:attrs2];
        [self.contentView addSubview:self.detailLable];

        __weak __typeof(self) weakSelf = self;

        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
        
        [self.detailLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(weakSelf.titleLable.mas_trailing).offset(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];

    }
    return self;
}
- (instancetype)initWithTitleItem:(NSString *)title detail:(NSString *)detail{
    if (self = [super init]) {
        _titleStr = title;
        _detailStr = detail;
         NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15.0f] ,NSForegroundColorAttributeName:UIColorFromRGB(0x444444)};
        self.titleLable.attributedText = [[NSAttributedString alloc]initWithString:_titleStr attributes:attrs];
        
        NSDictionary *attrs2 = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15.0f] ,NSForegroundColorAttributeName:UIColorFromRGB(0x444444)};
        self.detailLable.attributedText = [[NSAttributedString alloc]initWithString:_detailStr attributes:attrs2];
    }
    return self;
}





@end
