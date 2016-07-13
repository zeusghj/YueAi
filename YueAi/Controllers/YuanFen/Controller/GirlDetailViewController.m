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
#import "JLPhoto.h"
#import "JLPhotoBrowser.h"
#import "Member.h"
#import "GirlDetailCell.h"
#import "WKProgressHUD.h"

@interface GirlDetailViewController ()<UITableViewDelegate, UITableViewDataSource,
                                       UICollectionViewDelegate, UICollectionViewDataSource,
                                       UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) UITableView* tableView;
@property (strong, nonatomic) UICollectionView* collectionView;
@property (assign, nonatomic) BOOL isShowDetail;

@end

@implementation GirlDetailViewController
{
    UIImageView* _iconHiImageView;
    CGRect frame_first;
    
    WKProgressHUD* _hud;
    
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
    
    [self getUserDetails];
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
        _collectionView.clipsToBounds = NO;
        
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

- (void)getUserDetails
{
    if (!_hud) {
        _hud = [WKProgressHUD showInView:self.view withText:@"加载中" animated:YES];
    }
    
    NSString* requestUrl = [NSString stringWithFormat:@"http://192.168.1.40:5000/user/%@", self.uid];
    NSURL *URL = [NSURL URLWithString:requestUrl];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSDictionary* dict = responseObject;
        
        NSLog(@"userDetail = %@", responseObject);
        GirlDetailModel* model = [[GirlDetailModel alloc]init];
        model.name = dict[@"nickame"];
        model.medals = @[@"doubi", @"vip", @"star", @"mail"];
        model.introUrl = @"";
        model.time = 3;
        NSString* ziliao = [NSString stringWithFormat:@"她在%@, %@, %@, %@", dict[@"address"], dict[@"age"],dict[@"height"],dict[@"weight"]];
        model.ziliao = ziliao ;
        NSString* detail = [NSString stringWithFormat:@"家乡%@, %@学历，收入%@，%@，%@异地恋，%@接受亲密行为，%@小孩，她的魅力部位是%@",dict[@"jiguan"], dict[@"xueli"], dict[@"xinzi"], dict[@"marriage"], dict[@"yidiLove"], dict[@"foreSex"], dict[@"getBaby"], dict[@"meili"]];
        model.detail = detail;
        model.tags = dict[@"tags"];
        NSString* condition = [NSString stringWithFormat:@"年龄:%@\n城市:%@\n身高:%@\n收入:%@\n学历:%@",dict[@"op_age"], dict[@"op_city"], dict[@"op_height"], dict[@"op_income"], dict[@"op_xueli"]];
        model.dubai = dict[@"dubai"];
        model.condition = condition;
        model.iconUrl = dict[@"url"];
        
        NSArray* smallPics = dict[@"smallPhotos"];
        if (smallPics.count == 0) {
            smallPics = [NSArray arrayWithObject:dict[@"url"]];
        }
        
        model.pics = smallPics;
        
        self.model = model;
        
        [self.tableView reloadData];
        [self.collectionView reloadData];
        
        BaseNavigationController* bnvc = (BaseNavigationController *)(self.navigationController);
        [bnvc.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
        
        [_hud dismiss:YES];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"FlyElephant-Error: %@", error);
        
        [_hud dismiss:YES];
    }];
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setContentInset:UIEdgeInsetsMake(365*height_scale, 0, 0, 0)];
        [_tableView setContentOffset:CGPointMake(0, -365*height_scale)];
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

#pragma mark - Methods
-(void)setModel:(GirlDetailModel *)model
{
    _model = model;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.f ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了第 %ld 组， 第 %ld 行", (long)indexPath.section, (long)indexPath.row) ;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* reuseIdentifier = @"reuseCell" ;

    GirlDetailCell* cell = [[GirlDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier cellType:indexPath.row + 1 model:_model showDetail:self.isShowDetail] ;
    
    __weak typeof(self)weakSelf = self;
    
    if (indexPath.row == 3) {
        cell.showDetail = ^(){
            weakSelf.isShowDetail = YES;
            [weakSelf.tableView reloadData];
        };
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
    return self.model.pics.count;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"gdcellid";
    GDCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
//    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"meinv%ld",indexPath.item + 1]] ;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.pics[indexPath.item]]];
    [cell sizeToFit];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *photos = [NSMutableArray array];
    
//    Member* member = [[Member alloc] init];
    
    for (int i=0; i<self.model.pics.count; i++) {
        
        NSIndexPath* ipath = [NSIndexPath indexPathForItem:i inSection:0];
        GDCustomCell *tempCell = (GDCustomCell *)[self collectionView:collectionView cellForItemAtIndexPath:ipath];
        UIImageView *child = tempCell.imageView;
        JLPhoto *photo = [[JLPhoto alloc] init];
        photo.sourceImageView = child;
        photo.bigImgUrl = self.model.pics[i];
        photo.originFrame = CGRectMake(0, 0, SCREEN_WIDTH, 384.f*height_scale);
        photo.tag = i;
        [photos addObject:photo];
        
    }
    
    JLPhotoBrowser *photoBrowser = [[JLPhotoBrowser alloc] init];
    photoBrowser.photos = photos;
    photoBrowser.currentIndex = indexPath.item;
    [photoBrowser show];
    
//    [HJAvatarBrowser showImage:cell.imageView];
    
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
//            self.collectionView.frame = CGRectMake(0, -(100+365)*height_scale  , SCREEN_WIDTH, SCREEN_HEIGHT);
            
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
