//
//  GirlDetailViewController.m
//  YueAi
//
//  Created by 郭洪军 on 5/30/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "GirlDetailViewController.h"
#import "BaseNavigationController.h"
#import "GDCustomCell.h"
#import "HJAvatarBrowser.h"
#import "ShowImageController.h"

@interface GirlDetailViewController ()<UITableViewDelegate, UITableViewDataSource,
                                       UICollectionViewDelegate, UICollectionViewDataSource,
                                       UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) UITableView* tableView;
@property (strong, nonatomic) UICollectionView* collectionView;

@end

@implementation GirlDetailViewController
{
    UIImageView* _iconHiImageView;
//    BOOL         _isShowImage;
    CGRect frame_first;
}

- (void)dealloc
{
    NSLog(@"GirlDetailViewController dealloc");
}

- (void)viewWillAppear:(BOOL)animated
{
    BaseNavigationController* bnvc = (BaseNavigationController *)(self.navigationController);
    
    [bnvc setAlpha0];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    BaseNavigationController* bnvc = (BaseNavigationController *)(self.navigationController);
    
    [bnvc setAlpha1];
    [bnvc setAvatarBackAlpha0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    [self setNaviBar] ;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView insertSubview:self.collectionView atIndex:0];
    [self.tableView reloadData] ;
    
    [self setTabBar] ;
}

- (void)setNaviBar
{
    UIImage* image = [UIImage imageNamed:@"userspace_more"] ;
    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)] ;
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem ;
}

- (void)setTabBar
{
    UIButton* tabBar = [[UIButton alloc]init] ;
    [tabBar setBackgroundImage:[UIImage imageNamed:@"member_hi_n"] forState:UIControlStateNormal] ;
    [self.view addSubview:tabBar] ;
    
    [tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-10) ;
    }] ;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -(100+365)*height_scale, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
        _collectionView.bounces = NO;
        _collectionView.pagingEnabled = YES;
        
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = _collectionView.bounds.size;
        //定义每个UICollectionView的滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumLineSpacing = 0;
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumInteritemSpacing = 0;
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//上左下右
        
        //注册cell和ReusableView（相当于头部）
        UINib *nib = [UINib nibWithNibName:@"GDCustomCell" bundle: nil];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"gdcellid"];
        
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //背景颜色
        _collectionView.backgroundColor = [UIColor colorWithRed:38.f/255 green:39.f/255 blue:42.f/255 alpha:1];
        
    }
    return _collectionView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView* tempTableView = [[UITableView alloc]init] ;
//        tempTableView.bounces = NO;
        [self.view addSubview:tempTableView] ;
        [tempTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.view);
            make.left.bottom.right.equalTo(self.view) ;
        }] ;
        
        tempTableView.delegate = self;
        tempTableView.dataSource = self ;
       
        _tableView = tempTableView;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView setContentInset:UIEdgeInsetsMake(365*height_scale, 0, 0, 0)];
        [_tableView setContentOffset:CGPointMake(0, -365*height_scale)];
//        NSLog(@"tableView.frame = %@", NSStringFromCGRect(_tableView.frame));
    }
    
    return _tableView ;
}

- (void)moreAction
{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"取消"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  NSLog(@"点击了 \"取消\" 按钮") ;
                              }];
    
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:@"关注"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  NSLog(@"点击了 \"关注\" 按钮") ;
                              }];
    
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:@"拉黑"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  NSLog(@"点击了 \"拉黑\" 按钮") ;
                              }];
    
    UIAlertAction* button3 = [UIAlertAction
                              actionWithTitle:@"举报"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  NSLog(@"点击了 \"举报\" 按钮") ;
                              }];
    
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    [alert addAction:button3];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 150.f ;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了第 %ld 组， 第 %ld 行", indexPath.section, indexPath.row) ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        return 0 ;
    }else
    {
        return 44.f;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* reuseIdentifier = @"reuseCell" ;
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier] ;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] ;
        
    }
    
    return cell ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

/**
 *  UICollectionView delegate and datasource
 */
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"gdcellid";
    GDCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"meinv%ld",indexPath.item + 1]] ;
    [cell sizeToFit];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.section = %ld, indexPath.item = %ld", indexPath.section, indexPath.item);
    
    GDCustomCell *cell = (GDCustomCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
//    [HJAvatarBrowser showImage:cell.imageView];
    
    frame_first = CGRectMake(0, 0, SCREEN_WIDTH, 384*height_scale);
    
    ShowImageController *imgController = [[ShowImageController alloc] init];
    
    NSArray *imgdata6 = @[@[@"http://h.hiphotos.baidu.com/album/scrop%3D236%3Bq%3D90/sign=2fab0be130adcbef056a3959dc921cee/4b90f603738da977c61bb40eb151f8198618e3db.jpg",@"236",@"236"],@[@"http://h.hiphotos.baidu.com/album/scrop%3D236%3Bq%3D90/sign=2fab0be130adcbef056a3959dc921cee/4b90f603738da977c61bb40eb151f8198618e3db.jpg",@"236",@"236"],@[@"http://h.hiphotos.baidu.com/album/scrop%3D236%3Bq%3D90/sign=2fab0be130adcbef056a3959dc921cee/4b90f603738da977c61bb40eb151f8198618e3db.jpg",@"236",@"236"],@[@"http://h.hiphotos.baidu.com/album/scrop%3D236%3Bq%3D90/sign=2fab0be130adcbef056a3959dc921cee/4b90f603738da977c61bb40eb151f8198618e3db.jpg",@"236",@"236"],@[@"http://h.hiphotos.baidu.com/album/scrop%3D236%3Bq%3D90/sign=2fab0be130adcbef056a3959dc921cee/4b90f603738da977c61bb40eb151f8198618e3db.jpg",@"236",@"236"],@[@"http://h.hiphotos.baidu.com/album/scrop%3D236%3Bq%3D90/sign=2fab0be130adcbef056a3959dc921cee/4b90f603738da977c61bb40eb151f8198618e3db.jpg",@"236",@"236"]];
    
    NSMutableArray *addimg = [NSMutableArray new];
    for (int i = 0; i < [imgdata6 count]; i++) {
        ImageModel *model = [ImageModel new];
        model.imageUrl = [[imgdata6 objectAtIndex:i] objectAtIndex:0];
        model.width = [[[imgdata6 objectAtIndex:i] objectAtIndex:1] floatValue];
        model.height = [[[imgdata6 objectAtIndex:i] objectAtIndex:2] floatValue];
        [addimg addObject:model];
    }
    imgController.data = (NSArray *)addimg;
    
    [self presentViewController:imgController animated:NO completion:^{
        
    }];
    [imgController showImageView:frame_first image:cell.imageView.image w:358 h:440];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        //collection view
    }else
    {
        //table View
        CGFloat alpha = 0.0;
        BaseNavigationController* bnvc = (BaseNavigationController *)(self.navigationController);
        
        CGFloat offsetY = scrollView.contentOffset.y;
        
        NSLog(@"offsetY = %lf", offsetY) ;
        
        if (offsetY > -365.f*height_scale) {
            self.collectionView.frame = CGRectMake(0, -100*height_scale + offsetY  , SCREEN_WIDTH, SCREEN_HEIGHT);
            
            if (offsetY > -300.f*height_scale) {
                
                if (offsetY < -130) {
                    alpha = fabs(-64.f / (offsetY + 130 - 64))  ;
                    [bnvc setAvatarBackAlpha:alpha];
                }else
                {
                    [bnvc setAvatarBackAlpha:1.f];
                }
                
                if (offsetY < -130) {
                    [bnvc setAvatarBackHeight:-offsetY];
                }else
                {
                    [bnvc setAvatarBackHeight:130.f];
                }
                
            }else
            {
                [bnvc setAvatarBackAlpha0];
                [bnvc setAvatarBackHeight:300.f*height_scale];
            }
            
        }else
        {
            self.collectionView.frame = CGRectMake(0, -(100+365)*height_scale  , SCREEN_WIDTH, SCREEN_HEIGHT);
        }
        
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        //collection view
    }else
    {
        //table View
        
//        CGFloat offsetY = scrollView.contentOffset.y;
//        
//        CGFloat deltaY =  (offsetY + 365*SCREEN_WIDTH/320.0)*0.1 ;
//        
//        if (deltaY < -5) {
//            
//            if (!_isShowImage) {
//                _isShowImage = YES;
//                _tableView.contentInset = UIEdgeInsetsMake(SCREEN_HEIGHT, 0, 0, 0);
//                _tableView.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
//                self.collectionView.frame = CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
//            }
//        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        //collection view
    }else
    {
        CGFloat offsetY = scrollView.contentOffset.y;
        
        if (offsetY > -365.f*height_scale) {
            self.collectionView.frame = CGRectMake(0, -100*height_scale + offsetY  , SCREEN_WIDTH, SCREEN_HEIGHT);
        }else
        {
            [UIView animateWithDuration:0.2f animations:^{
                self.collectionView.frame = CGRectMake(0, -(100+365)*height_scale  , SCREEN_WIDTH, SCREEN_HEIGHT);
            }];
            
        }
    }
    
}

@end
