//
//  HJ_ChatBubbleVIew.m
//  YueAi
//
//  Created by 郭洪军 on 7/11/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "HJ_ChatBubbleVIew.h"
#import "HJ_ChatBubblePictureView.h"
#import "HJ_ChatBubbleTextView.h"
#import "HJModel.h"

@interface HJ_ChatBubbleView ()

//纯文本
@property (nonatomic, strong)HJ_ChatBubbleTextView* textView;
//图片
@property (nonatomic, strong)HJ_ChatBubblePictureView* pictureView;
@property (nonatomic, strong)NSMutableArray* subViewArray;

@end

@implementation HJ_ChatBubbleView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.pictureView];
        [self addSubview:self.textView];
        [self.subViewArray addObject:self.textView];
        [self.subViewArray addObject:self.pictureView];
        [self updateViewConstraints];
    }
    return self;
}

- (void)updateViewConstraints
{
    //    WEAKSELF;
    if ([self.textView superview]) {
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    
    if ([self.pictureView superview]) {
        [self.pictureView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 40));
        }];
    }
}

- (void)removeFromSuperviewWithOutView:(UIView *)subView
{
    [self.subViewArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![subView isEqual:obj]) {
            [obj removeFromSuperview];
        }
    }];
    
    if (![subView superview]) {
        [self addSubview:subView];
    }
}

#pragma mark - setter 赋值
- (void)setMsgModel:(HJModel *)msgModel
{
    _msgModel = msgModel;
    
    switch (msgModel.msg_Type) {
        case HJ_ChatMessageTypeText:
        {
            [self removeFromSuperviewWithOutView:self.textView];
            [self updateViewConstraints];
            self.textView.msgSources = msgModel.msgSources;
            self.textView.msgTextLabel.text = msgModel.msg;
        }
            break;
        case HJ_ChatRoomTypePicture:
        {
            [self removeFromSuperviewWithOutView:self.pictureView];
            [self updateViewConstraints];
            self.pictureView.msgSources = msgModel.msgSources;
            self.pictureView.pictureUrl = msgModel.msg;
        }
            break;
        default:
            break;
    }
}

#pragma mark - getter
- (HJ_ChatBubblePictureView *)pictureView
{
    if (!_pictureView) {
        _pictureView = [[HJ_ChatBubblePictureView alloc] init];
    }
    return _pictureView;
}

- (HJ_ChatBubbleTextView *)textView
{
    if (!_textView) {
        _textView = [[HJ_ChatBubbleTextView alloc] init];
    }
    return _textView;
}

- (NSMutableArray *)subViewArray
{
    if (!_subViewArray) {
        _subViewArray = [NSMutableArray array];
    }
    return _subViewArray;
}

@end
