//
//  HJ_BaseChatRoomCell.m
//  YueAi
//
//  Created by 郭洪军 on 7/11/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "HJ_BaseChatRoomCell.h"
#import "HJModel.h"
#import "HJ_ChatBubbleVIew.h"

@interface HJ_BaseChatRoomCell ()

//气泡
@property (nonatomic, strong)HJ_ChatBubbleView* bubbleView;
//用户名
@property (nonatomic, strong)UILabel* userNameLabel;
//时间戳
@property (nonatomic, strong)UILabel* timeStampLabel;
//用户头像
@property (nonatomic,strong)UIButton *userImageBuuton;
//用户头像位置maker
@property (nonatomic,strong)MASConstraint *userImageMaker;
//msg maker
@property (nonatomic,strong)MASConstraint *msgMaker;

@end

@implementation HJ_BaseChatRoomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.bubbleView];
        [self.contentView addSubview:self.userNameLabel];
        [self.contentView addSubview:self.timestampLabel];
        [self.contentView addSubview:self.userImageBuuton];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KBackgroundColor;
        [self updateCellConstraints];
    }
    return self;
}

- (void)updateCellConstraints
{
    WEAKSELF;
    [self.userImageBuuton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35., 35.));
        if (weakSelf.msgModel.msgSources) {
            [weakSelf.userImageMaker uninstall];
            weakSelf.userImageMaker = make.right.mas_equalTo(weakSelf.contentView).offset(-10);
        }else {
            [weakSelf.userImageMaker uninstall];
            weakSelf.userImageMaker = make.left.mas_equalTo(weakSelf.contentView).offset(10);
        }
        if (!weakSelf.msgModel.showTimestamp) {
            make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(5);
        }else {
            make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(28);
        }
    }];
    
    [self.timestampLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.contentView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.mas_equalTo(weakSelf.contentView).offset(5);
    }];
    
    [self.userNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.userImageBuuton.mas_top).offset(-1);
        make.left.mas_equalTo(weakSelf.userImageBuuton.mas_right).offset(10);
        make.right.mas_lessThanOrEqualTo(SCREEN_WIDTH *.5 - 50);
        make.height.mas_equalTo(16);
    }];
    
    [self.bubbleView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (weakSelf.msgModel.msgSources) {
            [weakSelf.msgMaker uninstall];
            weakSelf.msgMaker = make.right.mas_equalTo(weakSelf.userImageBuuton.mas_left).offset(-10);
        }else {
            [weakSelf.msgMaker uninstall];
            weakSelf.msgMaker = make.left.mas_equalTo(weakSelf.userImageBuuton.mas_right).offset(10);
        }
        
        if (weakSelf.msgModel.msgSources) {
            make.top.mas_equalTo(weakSelf.userImageBuuton.mas_top).priorityHigh();
        }else {
            make.top.mas_equalTo(weakSelf.userImageBuuton.mas_top).offset(15).priorityHigh();
        }
        make.width.mas_equalTo(weakSelf.msgModel.cacheMsgSize.width + 40);
    }];
}

#pragma mark - setter and getter
- (void)setMsgModel:(HJModel *)msgModel
{
    _msgModel = msgModel;
    [self.userImageBuuton setImage:[UIImage imageNamed:msgModel.userIcon] forState:UIControlStateNormal];
    self.userNameLabel.text = msgModel.userName;
    self.userNameLabel.hidden = msgModel.msgSources;
    self.timestampLabel.text = msgModel.timestamp;
    self.timestampLabel.hidden = !msgModel.showTimestamp;
    self.bubbleView.msgModel = msgModel;
    [self updateCellConstraints];
}

- (UIButton *)userImageBuuton
{
    if (!_userImageBuuton) {
        _userImageBuuton = [UIButton buttonWithType:UIButtonTypeCustom];
        _userImageBuuton.imageEdgeInsets = UIEdgeInsetsMake(0.0,0.0, 0.0, 0.0);
    }
    return _userImageBuuton;
}

- (UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.font = DSTEXTFONT(13.);
    }
    return _userNameLabel;
}

- (HJ_ChatBubbleView *)bubbleView
{
    if (!_bubbleView) {
        _bubbleView = [[HJ_ChatBubbleView alloc] init];
    }
    return _bubbleView;
}

- (UILabel *)timestampLabel
{
    if (!_timeStampLabel) {
        _timeStampLabel = [[UILabel alloc] init];
        _timeStampLabel.textAlignment = NSTextAlignmentCenter;
        _timeStampLabel.textColor = UIColorFromRGB(0x949494);
        _timeStampLabel.font = DSTEXTFONT(15.);
    }
    return _timeStampLabel;
}

@end

