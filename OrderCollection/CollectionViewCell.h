//
//  CollectionViewCell.h
//  FoldTableVIewText
//
//  Created by ZZCN77 on 2017/9/12.
//  Copyright © 2017年 co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *detailLable;
- (instancetype)initWithTitleItem:(NSString *)title detail:(NSString *)detail;
@end
