//
//  HJ_ChatBubblePictureView.m
//  YueAi
//
//  Created by 郭洪军 on 7/11/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "HJ_ChatBubblePictureView.h"
#import "HJ_ChatMessage.h"

@interface HJ_ChatBubblePictureView ()

@property (nonatomic, strong) UIActivityIndicatorView* sendIndicator;
//背景泡泡图片
@property (nonatomic, strong) UIImageView* pictureImageView;
//背景
@property (nonatomic, strong) UIImageView* bubbleImageView;

@end

@implementation HJ_ChatBubblePictureView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.bubbleImageView];
        [self addSubview:self.pictureImageView];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    [self.bubbleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0)).priorityLow();
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    
    [self.pictureImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.bubbleImageView);
    }];
    [super updateConstraints];
}

- (void)setPictureUrl:(NSString *)pictureUrl
{
    _pictureUrl = pictureUrl;
    self.layer.mask = self.bubbleImageView.layer;
    self.pictureImageView.image = [UIImage imageNamed:pictureUrl];
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

- (UIImageView *)pictureImageView
{
    if (!_pictureImageView) {
        _pictureImageView = [[UIImageView alloc] init];
    }
    return _pictureImageView;
}

- (UIImageView *)bubbleImageView
{
    if (!_bubbleImageView) {
        _bubbleImageView = [[UIImageView alloc] init];
    }
    return _bubbleImageView;
}

@end


