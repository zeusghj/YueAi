//
//  HJ_BaseChatRoomController.m
//  YueAi
//
//  Created by 郭洪军 on 7/6/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "HJ_BaseChatRoomController.h"

static NSString* identifier = @"UITableViewCellIDS";

@interface HJ_BaseChatRoomController ()
{
    //当弹出键盘时，内容会向上滚动，不应该让键盘dissmiss
    BOOL _scrollViewState;
}

@end

@implementation HJ_BaseChatRoomController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KBackgroundColor;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.keyBoardView];
    [self updateViewsConstraintsWithState:YES];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (void)updateViewsConstraintsWithState:(BOOL)state
{
    CGFloat margin = 0.f;
    if (state) {
        margin = self.keyBoardView.frame.size.height;
    }
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, margin, 0));
    }];
}

#pragma mark - setter and getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = KBackgroundColor;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15.f)];
    }
    return _tableView;
}

- (HJ_KeyboardView *)keyBoardView
{
    if (!_keyBoardView) {
        _keyBoardView = [[HJ_KeyboardView alloc] init];
        _keyBoardView.delegate = self;
    }
    return _keyBoardView;
}

#pragma mark - pravite funs
- (void)setTableViewInsetsWithBottomValue:(CGFloat)bottom {
    UIEdgeInsets insets = [self tableViewInsetsWithBottomValue:bottom];
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
}

- (UIEdgeInsets)tableViewInsetsWithBottomValue:(CGFloat)bottom {
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if ([self respondsToSelector:@selector(topLayoutGuide)]) {
        insets.top = self.topLayoutGuide.length;
    }
    insets.bottom = bottom;
    return insets;
}

#pragma mark - DS_KeyboardViewDelegate
- (void)keyBoardInputViewWillShow:(HJ_KeyboardView *)view
{
    _scrollViewState = YES;
    [self updateViewsConstraintsWithState:NO];
    [self setTableViewInsetsWithBottomValue:self.view.frame.size.height
     - self.keyBoardView.frame.origin.y];
    [self scrollViewToBottom];
}

- (void)keyBoardInputViewDidShow:(HJ_KeyboardView *)view
{
    _scrollViewState = NO;
}

- (void)keyBoardInputWillDismiss:(HJ_KeyboardView *)view
{
    [self updateViewsConstraintsWithState:NO];
    [self setTableViewInsetsWithBottomValue:self.view.frame.size.height
     - self.keyBoardView.frame.origin.y];
}

- (void)keyBoardInputDidDismiss:(HJ_KeyboardView *)view
{
}

- (void)scrollViewToBottom
{
    _scrollViewState = YES;
    NSInteger rows = [self.tableView numberOfRowsInSection:0];
    if (rows == 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSourceArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        });
        return;
    }
    if (rows > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:NO];
    }
    _scrollViewState = NO;
}

#pragma mark - UITableViewDelegate  and UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self tableViewScrollViewDidScroll:scrollView];
}

- (void)tableViewScrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_scrollViewState) {
        [self.keyBoardView dismiss];
    }
}

@end











































