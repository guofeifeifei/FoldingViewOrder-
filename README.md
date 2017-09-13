# FoldingViewOrder-
![image.gif](/Image/image.gif)

先创建一个UICollectionView, UICollectionView的顶部偏移120高度，来做为UICollectionView的头部试图，在头部添加一个UICollectionView。
```object-C
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
````
实现UICollectionViewDataSource、UICollectionViewDelegate
确定有几个区域，先判断是哪一个UICollectionView， 如果是头部UICollectionView，区数为1，如果是_collectionView，区数是3；
````object-C
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView == _collectionView) {
        return 3;
    }else{
        return 1;
    }
    return 0;
}
````
确定每个区有多少行，先判断是哪一个UICollectionView， 如果是头部UICollectionView，行数为_titleArray.count； 如果是_collectionView，先判断下拉列表是否打开，如果是打开的行数为 _productTitleArray.count，如果不打开行数就为0；
````
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
````
添加区头内容，使用区头首先需要注册TitleCollectionReusableView，上面我已经注册过了，如果没有注册，区头就会不出来。这里加了一个一个判断，主要是将区头添加到_collectionView，如果不加判断我们的头部试图也会有区头。
````
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
````
区头的大小设置,要判断一个加大小添加到有区头的UICollectionView上去，要不然会崩溃的
````
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (collectionView == _collectionView) {
        
        return CGSizeMake(GFMainScreenWidth, 40);
    }else{
        return CGSizeMake(GFMainScreenWidth, 0);
    }
}
````
加载cell， 判断不同的UICollectionView，加载不同样式、内容的cell
````
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
````
添加区头的点击下拉或者关闭方法，现将开关数组的属性调整，然后刷新当前区域的内容
````

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

}
````
详细内容：http://www.jianshu.com/p/d2a43da6e25f
