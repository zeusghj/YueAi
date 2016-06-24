//
//  GirlDetailCell.h
//  YueAi
//
//  Created by 郭洪军 on 6/14/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GirlDetailModel.h"

typedef void (^ShowDetailCallBack)();

@interface GirlDetailCell : UITableViewCell

//左侧icon小图标
@property(nonatomic, strong) UIImageView* iconImageView;

//cell类型标签
@property(nonatomic, strong) UILabel* typeNameLabel;

//cell 详细内容标签
@property(nonatomic, strong) UILabel* typeDetailLabel;

@property(nonatomic, copy) ShowDetailCallBack showDetail;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(NSInteger)type model:(GirlDetailModel*)model showDetail:(BOOL)show;



@end
