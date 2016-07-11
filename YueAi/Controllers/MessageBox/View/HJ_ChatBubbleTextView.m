//
//  HJ_ChatBubbleTextView.m
//  YueAi
//
//  Created by 郭洪军 on 7/11/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "HJ_ChatBubbleTextView.h"

@implementation HJ_ChatBubbleTextView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.bubbleImageView];
        [self addSubview:self.msgTextLabel];
        [self updateViewConstraint];
    }
    return self;
}

- (void)updateViewConstraint
{
    WEAKSELF;
    [self.msgTextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(10, 20, 10, 20));
    }];
    
    [self.msgTextLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.msgTextLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

- (UILabel *)msgTextLabel
{
    if (!_msgTextLabel) {
        _msgTextLabel = [[UILabel alloc] init];
        _msgTextLabel.font = KCHATBUBBLEFONT;
        _msgTextLabel.numberOfLines = 0;
    }
    return _msgTextLabel;
}

@end
