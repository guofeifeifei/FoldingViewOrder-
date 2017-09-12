//
//  ViewController.m
//  OrderCollection
//
//  Created by ZZCN77 on 2017/9/12.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "TitleCollectionReusableView.h"
/******* 屏幕尺寸 *******/
#define GFMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define GFMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define GFMainScreenBounds [UIScreen mainScreen].bounds

#define widthScale GFMainScreenWidth / 375.0
#define heightScale GFMainScreenHeight / 667.0
@interface ViewController ()<UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>{
    UICollectionView *_headCollectionView;
    UICollectionView *_collectionView;
    NSMutableArray *_isExpandArray;//记录section是否展开
    NSArray *_titleArray;
    NSArray *_detailArray;
    NSArray *_productTitleArray;
    NSArray *_productDetailArray;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isExpandArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"订单查询";
    
    _titleArray = @[@"订单编号：",@"购买日期：",  @"商品数量：" , @"商品总价：", @"实付总价：" ,@"收货人：", @"备注："];
    _detailArray =@[@"1894002045",@"2017-08-08", @"3", @"399.00", @"399.0",@"童鞋", @"无" ];
    _productTitleArray = @[@"商品编号：",@"商品名称：",@"颜色:", @"型号：", @"商品数量：" , @"商品总价：", @"实付总价：" ,@"注意事项：", @"备注："];
    _productDetailArray =@[@"178054020",@"连衣裙",@"红色", @"M", @"1", @"399.00", @"399.0",@"手洗", @"无" ];

    for (NSInteger i = 0; i < _titleArray.count; i++) {
        [_isExpandArray addObject:@"0"];//0:没展开 1:展开
    }
    [self initProvinceTableView];

}
- (void)initProvinceTableView{

    UICollectionViewFlowLayout * fl = [[UICollectionViewFlowLayout alloc]init];
    fl.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, GFMainScreenHeight) collectionViewLayout:fl];
    fl.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    fl.minimumLineSpacing = 0;
    fl.minimumInteritemSpacing= 0;
    fl.itemSize = CGSizeMake(GFMainScreenWidth/2, 30);
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //顶部偏移120
    _collectionView.contentInset = UIEdgeInsetsMake(120, 0, 0, 0);
    //_collectionView 宽高自动
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView registerClass:[TitleCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionCellIndentider"];
    
    [self.view addSubview:_collectionView];
    
    
    //头部
    // 注意这里设置headerView的头视图的y坐标一定是从"负值"开始,因为headerView是添加在collectionView上的.
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, -120, self.view.frame.size.width, 120)];
    headerView.backgroundColor = [UIColor greenColor];
    UICollectionViewFlowLayout * fl2 = [[UICollectionViewFlowLayout alloc]init];
    fl2.scrollDirection = UICollectionViewScrollDirectionVertical;
    _headCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 120) collectionViewLayout:fl2];
    fl2.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    fl2.minimumLineSpacing = 0;
    fl2.minimumInteritemSpacing= 0;
    fl2.itemSize = CGSizeMake(GFMainScreenWidth/2, 30);
    _headCollectionView.backgroundColor=[UIColor whiteColor];
    _headCollectionView.delegate = self;
    _headCollectionView.dataSource = self;
    
    [_headCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifierTwo"];
    [headerView addSubview:_headCollectionView];
    [_collectionView addSubview:headerView];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView == _collectionView) {
        return 3;
    }else{
        return 1;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _collectionView) {
        if ([_isExpandArray[section]isEqualToString:@"1"]) {
            return  _productTitleArray.count;
        }else{
            return 0;
        }
    }else{
        return _titleArray.count;
    }
    
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _headCollectionView) {
        CollectionViewCell *cell = (CollectionViewCell *)[collectionView  dequeueReusableCellWithReuseIdentifier:@"cellIdentifierTwo" forIndexPath:indexPath];
        cell.titleLable.text = _titleArray[indexPath.row];
        cell.detailLable.text = _detailArray[indexPath.row];
        switch (indexPath.row) {
            case 0:case 1:case 4:case 5:case 8:case 9:case 12:case 13:case 16:case 17:case 20:case 21:
                cell.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
                
                break;
            case 2:case 3:case 6:case 7:case 10:case 11:case 14:case 15:case 18:case 19:case 22:case 23:
                cell.backgroundColor = [UIColor whiteColor];
                
                break;

            default:
                break;
        }
        return cell;
        
    }else{
        CollectionViewCell *cell = (CollectionViewCell *)[collectionView  dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        cell.titleLable.text = _productTitleArray[indexPath.row];
        cell.detailLable.text = _productDetailArray[indexPath.row];
        
        return cell;
        
    }
    return nil;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = nil;
    if (collectionView == _collectionView) {

        TitleCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionCellIndentider" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor whiteColor];
        reusableview = headerView;
        if ([_isExpandArray[indexPath.section] isEqualToString:@"0"]) {
            //未展开
            headerView.selectImageView.image = [UIImage imageNamed:@"off"];
        }else{
            //展开
            headerView.selectImageView.image = [UIImage imageNamed:@"open"];
        }
        headerView.provinceLabel.text = [NSString stringWithFormat:@"商品%ld", (long)indexPath.section];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tap.delegate = self;
        headerView.tag = indexPath.section;
        
        [headerView addGestureRecognizer:tap];
    }
    return reusableview;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (collectionView == _collectionView) {
        
        return CGSizeMake(GFMainScreenWidth, 40);
    }else{
        return CGSizeMake(GFMainScreenWidth, 0);
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    if ([_isExpandArray[tap.view.tag] isEqualToString:@"0"]) {
        //关闭 => 展开
        [_isExpandArray removeObjectAtIndex:tap.view.tag];
        [_isExpandArray insertObject:@"1" atIndex:tap.view.tag];
    }else{
        //展开 => 关闭
        [_isExpandArray removeObjectAtIndex:tap.view.tag];
        [_isExpandArray insertObject:@"0" atIndex:tap.view.tag];
        
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:tap.view.tag];
    NSRange rang = NSMakeRange(indexPath.section, 1);
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:rang];
    [_collectionView reloadSections:set];
    //    [UIView performWithoutAnimation:^{
    //        [_collectionView reloadSections:set];
    //    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
