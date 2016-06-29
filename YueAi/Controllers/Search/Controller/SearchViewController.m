//
//  SearchViewController.m
//  YueAi
//
//  Created by 郭洪军 on 5/26/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "SearchViewController.h"
#import "GirlCell.h"
#import "GirlModel.h"
#import "MJRefresh.h"
#import "WKProgressHUD.h"

@interface SearchViewController ()

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* users;

@end

@implementation SearchViewController
{
    WKProgressHUD* _hud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    
    [self setupRefresh];
    
}

- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray new];
    }
    
    return _users;
}

- (void)setupRefresh
{
    // 下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //进行登录操作
        if (!_hud) {
            _hud = [WKProgressHUD showInView:self.view withText:@"加载中" animated:YES];
        }
        
        NSURL *URL = [NSURL URLWithString:@"http://192.168.1.40:5000/user/?limit=16"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            if (self.users.count != 0) {
                [_users removeAllObjects];
            }
            
            NSArray* arr = responseObject;
            for (int i=0; i<arr.count; ++i) {
                NSDictionary* dict = arr[i];
                GirlModel* model = [GirlModel new];
                model.iconUrl = dict[@"url"];
                model.name = dict[@"nickame"];
                model.age = @"18岁";
                model.address = dict[@"address"];
                model.height = dict[@"height"];
                model.income = dict[@"xinzi"];
                model.tags = dict[@"tags"];
                
                [self.users addObject:model];                
            }
            
            [self.tableView reloadData];
            
            NSLog(@"FlyElephant-JSON: %@", arr);
            
            [self.tableView.header endRefreshing];
            [_hud dismiss:YES];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"FlyElephant-Error: %@", error);
            
            [self.tableView.header endRefreshing];
            [_hud dismiss:YES];
        }];
        
    }];
    
    //上拉刷新
    self.tableView.footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        if (!_hud) {
            _hud = [WKProgressHUD showInView:self.view withText:@"加载中" animated:YES];
        }
        
        NSString* requestUrl = [NSString stringWithFormat:@"http://192.168.1.40:5000/user/?limit=16&offset=%lu", (unsigned long)self.users.count];
        NSURL *URL = [NSURL URLWithString:requestUrl];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            NSArray* arr = responseObject;
            for (int i=0; i<arr.count; ++i) {
                NSDictionary* dict = arr[i];
                GirlModel* model = [GirlModel new];
                model.iconUrl = dict[@"url"];
                model.name = dict[@"nickame"];
                model.age = @"18岁";
                model.address = dict[@"address"];
                model.height = dict[@"height"];
                model.income = dict[@"xinzi"];
                model.tags = dict[@"tags"];
                
                [self.users addObject:model];
            }
            
            [self.tableView reloadData];
            
            [self.tableView.footer endRefreshing];
            [_hud dismiss:YES];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"FlyElephant-Error: %@", error);
            
            [self.tableView.footer endRefreshing];
            [_hud dismiss:YES];
        }];
    }];
    
    [self.tableView.header beginRefreshing];
}

- (void)setUpTableView
{
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* reuseCellId = @"reuseCellId";
    
    GirlCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    if (!cell) {
        cell = [[GirlCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId type:1];
    }
    
    GirlModel* model = self.users[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView select row at indexpath.row = %ld", indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86.f;
}

@end
