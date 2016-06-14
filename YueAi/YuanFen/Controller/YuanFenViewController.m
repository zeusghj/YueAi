//
//  YuanFenViewController.m
//  YueAi
//
//  Created by 郭洪军 on 5/26/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "YuanFenViewController.h"
#import "GirlDetailViewController.h"
#import "YFCustomCell.h"

@interface YuanFenViewController ()

@property(weak, nonatomic)UICollectionView* collectionView;

@end

@implementation YuanFenViewController

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH / 320 * 50);//头部大小
        
        UICollectionView*  tempCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
        
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-8)/2, (SCREEN_WIDTH-8)/2);
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumLineSpacing = 0;
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumInteritemSpacing = 0;
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 4, 0, 4);//上左下右
        
        //注册cell和ReusableView（相当于头部）
        UINib *nib = [UINib nibWithNibName:@"YFCustomCell" bundle: nil];
        [tempCollectionView registerNib:nib forCellWithReuseIdentifier:@"cellnib"];
        [tempCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        
        //设置代理
        tempCollectionView.delegate = self;
        tempCollectionView.dataSource = self;
        
        //背景颜色
        tempCollectionView.backgroundColor = [UIColor whiteColor];
        //自适应大小
        tempCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:tempCollectionView];
        _collectionView = tempCollectionView;
        
        
    }
    return _collectionView;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Yuanfen View will appear");
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"Yuanfen View did appear") ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self collectionView];
}

#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellnib";
    YFCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"girl_%ld",indexPath.item]] ;
    [cell sizeToFit];
    
    return cell;
}

#pragma mark 头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    
    if (headerView.subviews) {
        for (id view in headerView.subviews) {
            [view removeFromSuperview];
        }
    }
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:headerView.bounds];
    imageView.image = [UIImage imageNamed:@"destiny_advert_01"];
    [headerView addSubview:imageView];

    return headerView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage* image = [UIImage imageNamed:@"common_navbar_back"];
    
    GirlDetailViewController* gdController = [[GirlDetailViewController alloc]init];
    
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    [temporaryBarButtonItem setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [temporaryBarButtonItem setBackButtonTitlePositionAdjustment:UIOffsetMake(-400.f, 0) forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    gdController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:gdController animated:YES];
}


@end











