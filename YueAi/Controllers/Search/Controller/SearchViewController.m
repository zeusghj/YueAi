//
//  SearchViewController.m
//  YueAi
//
//  Created by 郭洪军 on 5/26/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "SearchViewController.h"
#import "GirlCell.h"

@interface SearchViewController ()

@property (strong, nonatomic) UITableView* tableView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* reuseCellId = @"reuseCellId";
    
    GirlCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    if (!cell) {
        cell = [[GirlCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId type:1];
    }
    
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
