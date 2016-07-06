//
//  MessageBoxViewController.m
//  YueAi
//
//  Created by 郭洪军 on 5/26/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "MessageBoxViewController.h"
#import "HJ_BaseChatRoomController.h"

@interface MessageBoxViewController ()

@end

@implementation MessageBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton* button = [[UIButton alloc] init];
    [button setTitle:@"聊天" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goChat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
}

- (void)goChat
{
    HJ_BaseChatRoomController *chatRoom = [[HJ_BaseChatRoomController alloc] init];
    chatRoom.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatRoom animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
