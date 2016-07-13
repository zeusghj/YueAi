//
//  HJ_BaseChatRoomController.m
//  YueAi
//
//  Created by 郭洪军 on 7/6/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "HJ_BaseChatRoomController.h"
#import "HJModel.h"
#import "HJ_UserHeader.h"
#import "HJ_BaseChatRoomCell.h"
#import "HJ_ChatRoomManager.h"

static NSString* identifier = @"HJ_BaseChatRoomCell";

@interface HJ_BaseChatRoomController ()
{
    //当弹出键盘时，内容会向上滚动，此时不能让键盘dissmiss
    BOOL _scrollViewState;
}

@end

@implementation HJ_BaseChatRoomController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KBackgroundColor;
    [self registerTableViewCellClass];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.keyBoardView];
    [self updateViewsConstraintsWithState:YES];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (NSMutableArray *)msgArray
{
    if (!_msgArray) {
        _msgArray = [NSMutableArray new];
    }
    
    return _msgArray;
}

- (void)registerTableViewCellClass
{
    [self.tableView registerClass:[HJ_BaseChatRoomCell class] forCellReuseIdentifier:identifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

- (void)keyBoardInputViewWillDismiss:(HJ_KeyboardView *)view
{
    [self updateViewsConstraintsWithState:NO];
    [self setTableViewInsetsWithBottomValue:self.view.frame.size.height
     - self.keyBoardView.frame.origin.y];
}

- (void)keyBoardInputViewDidDismiss:(HJ_KeyboardView *)view
{
}

- (void)scrollViewToBottom
{
    _scrollViewState = YES;
    NSInteger rows = [self.tableView numberOfRowsInSection:0];
    if (rows == 0) {
        return;
    }
    if (rows > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:NO];
    }
    _scrollViewState = NO;
}

#pragma mark - HJ_KeyboardViewDelegate
- (void)keyBoardSendMsgTextView:(HJ_KeyboardView *)view sendMsgText:(NSString *)text
{
    HJModel *model = [self cofigMsgStrcutWithMsg:text];
    NSMutableArray *array = [self.msgArray mutableCopy];
    [array addObject:model];
    self.msgArray = array;
    self.dataSourceArray = [self.msgArray mutableCopy];
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:1];
    [indexPaths addObject:[NSIndexPath indexPathForRow:self.dataSourceArray.count - 1 inSection:0]];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
    [self scrollViewToBottom];
}

#pragma mark - 组建消息结构体
- (HJModel *)cofigMsgStrcutWithMsg:(NSString *)msg
{
    static int i = 1;
    
    HJModel *model = [[HJModel alloc] init];
    HJ_UserTool *user = [HJ_UserTool shareInstance];
    model.userIcon = user.userModel.icon;
    
    if (i % 2 == 1) {
        model.msgSources = YES;
    }else
    {
        model.msgSources = NO;
    }
    
    i ++;
    
    model.userName = user.userModel.name;
    model.msg = msg;
    model.msg_Type = 1;
    model.timestamp = @"18:43";
    model.showTimestamp = YES;
    model.chatMsgId = user.userModel.userId;
    return model;
}

#pragma mark - UITableViewDelegate  and UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJ_BaseChatRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.msgModel = self.dataSourceArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJModel *msg = self.dataSourceArray[indexPath.row];
    if (msg.cacheMsgSize.height <= 0.f) {
        return [HJ_ChatRoomManager calculateCellHeightWithMsg:msg];
    }
    return msg.cacheMsgSize.height;
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
