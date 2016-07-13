//
//  HJ_BaseChatRoomController.h
//  YueAi
//
//  Created by 郭洪军 on 7/6/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJ_KeyboardView.h"

@interface HJ_BaseChatRoomController : UIViewController<UITableViewDataSource, UITableViewDelegate, HJ_KeyboardViewDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) HJ_KeyboardView* keyBoardView;

@property (nonatomic, strong) NSMutableArray* msgArray;
@property (nonatomic, strong) NSArray *dataSourceArray;

/**
 * 滚到底部
 */
- (void)scrollViewToBottom;

@end
