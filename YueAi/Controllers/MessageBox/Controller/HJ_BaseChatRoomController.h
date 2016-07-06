//
//  HJ_BaseChatRoomController.h
//  YueAi
//
//  Created by 郭洪军 on 7/6/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJ_KeyboardView.h"

@interface HJ_BaseChatRoomController : UIViewController<UITableViewDataSource,UITableViewDelegate, HJ_KeyboardViewDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) HJ_KeyboardView* keyBoardView;

/**
 * Scroll to the bottom for the first time in msg unread
 */
//- (void)scrollToRow;

/**
 * 滚到底部
 */
- (void)scrollViewToBottom;

@end
