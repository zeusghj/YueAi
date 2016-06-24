//
//  GirlCell.h
//  YueAi
//
//  Created by 郭洪军 on 6/24/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GirlModel.h"


@interface GirlCell : UITableViewCell

@property (nonatomic, strong) GirlModel *model;

@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) UILabel*     nameLabel;
@property (nonatomic, strong) UILabel*     ageLabel;
@property (nonatomic, strong) UILabel*     addressLabel;
@property (nonatomic, strong) UILabel*     heightLabel;
@property (nonatomic, strong) UILabel*     incomeLabel;
@property (nonatomic, strong) UILabel*     distanceLabel;
@property (nonatomic, strong) UIButton*    sayHiButton;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type;  //type 1, search;   2, nearby

@end
