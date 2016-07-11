//
//  HJ_ChatBubbleBaseView.h
//  YueAi
//
//  Created by 郭洪军 on 7/11/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJ_ChatMessage.h"

@interface HJ_ChatBubbleBaseView : UIView

//背景
@property (nonatomic,strong)UIImageView *bubbleImageView;
//消息来自自己还是其他人
@property (nonatomic,assign)BOOL msgSources;

@end
