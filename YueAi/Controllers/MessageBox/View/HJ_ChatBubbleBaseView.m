//
//  HJ_ChatBubbleBaseView.m
//  YueAi
//
//  Created by 郭洪军 on 7/11/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "HJ_ChatBubbleBaseView.h"

@implementation HJ_ChatBubbleBaseView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.bubbleImageView];
        [self updateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    [self.bubbleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    [super updateConstraints];
}

- (void)setMsgSources:(BOOL)msgSources
{
    _msgSources = msgSources;
    UIImage *img = nil;
    if (msgSources) {
        img = [UIImage imageNamed:@"weChatBubble_Sending_icon.png"];
    }else {
        img = [UIImage imageNamed:@"weChatBubble_Receiving_icon.png"];
    }
    self.bubbleImageView.image = DS_STRETCH_IMAGE(img,UIEdgeInsetsMake(30, 28, 85, 28));
}

- (UIImageView *)bubbleImageView
{
    if (!_bubbleImageView) {
        _bubbleImageView = [[UIImageView alloc] init];
        [_bubbleImageView setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    return _bubbleImageView;
}

@end
