//
//  GirlCell.m
//  YueAi
//
//  Created by 郭洪军 on 6/24/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "GirlCell.h"

@interface GirlCell ()

@property (assign, nonatomic) NSInteger type;

@end

@implementation GirlCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.type = type;
        
        _iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconImageView];
        _iconImageView.image = [UIImage imageNamed:@"girl_3"];
        _iconImageView.layer.cornerRadius = 35.f;
        _iconImageView.layer.masksToBounds = YES;
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(12);
            make.centerY.equalTo(self.contentView);
            make.width.height.equalTo(@70);
        }];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"老迟到的小虾米" ;
        _nameLabel.font = [UIFont systemFontOfSize:14.f];
        _nameLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_iconImageView.mas_right).offset(10);
            make.top.equalTo(self.contentView).offset(9);
        }];

        if (_type == 1) {
            
        }else if(_type == 2)
        {
            UIImageView* gpsicon = [[UIImageView alloc] init];
            gpsicon.image = [UIImage imageNamed:@"nearby_location_gps"];
            [self.contentView addSubview:gpsicon];
            [gpsicon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_nameLabel.mas_right).offset(10);
                make.centerY.equalTo(_nameLabel);
            }];
            
            _distanceLabel = [[UILabel alloc] init];
            _distanceLabel.text = @"1.05km";
            _distanceLabel.textColor = [UIColor lightGrayColor];
            _distanceLabel.font = [UIFont systemFontOfSize:10.f];
            [self.contentView addSubview:_distanceLabel];
            [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_nameLabel);
                make.left.equalTo(gpsicon.mas_right).offset(5);
            }];
        }
        
        _ageLabel = [[UILabel alloc] init];
        _ageLabel.text = @"24岁" ;
        _ageLabel.textColor = [UIColor lightGrayColor];
        _ageLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_ageLabel];
        [_ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel);
            make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        }];
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = @"北京" ;
        _addressLabel.textColor = [UIColor lightGrayColor];
        _addressLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_ageLabel.mas_right).offset(8);
            make.top.equalTo(_ageLabel);
        }];
        
        _heightLabel = [[UILabel alloc] init];
        _heightLabel.text = @"162cm" ;
        _heightLabel.textColor = [UIColor lightGrayColor];
        _heightLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_heightLabel];
        [_heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel);
            make.top.equalTo(_ageLabel.mas_bottom).offset(5);
        }];
        
        _incomeLabel = [[UILabel alloc] init];
        _incomeLabel.text = @"2000-5000元" ;
        _incomeLabel.textColor = [UIColor lightGrayColor];
        _incomeLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_incomeLabel];
        [_incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_heightLabel.mas_right).offset(8);
            make.top.equalTo(_heightLabel);
        }];
        
        _sayHiButton = [[UIButton alloc]init];
        [_sayHiButton setBackgroundImage:[UIImage imageNamed:@"list_item_user_btn_bg_default"] forState:UIControlStateNormal];
        [self.contentView addSubview:_sayHiButton];
        [_sayHiButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
        }];
        
    }
    
    return self;
}

- (void)setModel:(GirlModel *)model
{
    _model = model;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.iconUrl]];
    _nameLabel.text     = _model.name;
    _ageLabel.text      = _model.age;
    _addressLabel.text  = _model.address;
    _heightLabel.text   = _model.height;
    _incomeLabel.text   = _model.income;
    _distanceLabel.text = _model.distance;
    
    NSArray* tags = _model.tags;
    CGSize maxSize = CGSizeMake(SCREEN_WIDTH - 12 - 70 - 10 - 80, 20);
    
    NSMutableArray* sizeArr = [NSMutableArray new];
    for (int i=0; i<tags.count; ++i) {
        NSString* text = tags[i];
        
        CGSize titleSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
        [sizeArr addObject:[NSValue valueWithCGSize:titleSize]];
    }
    
    for (UIView* view in self.contentView.subviews) {
        if (view.tag == 51) {
            [view removeFromSuperview];
        }
    }
    
    UILabel* lastLabel = nil;
    for (int i = 0; i<tags.count; ++i) {
        
        if (i>4) {   //标签多余5个有可能超出屏幕了
            return;
        }
        
        NSString* text = tags[i];
        
        CGSize titleSize = [sizeArr[i] CGSizeValue];
        CGFloat titleWidth = titleSize.width + 10;
        
        UILabel* label = [[UILabel alloc] init];
        label.text = text;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:10.f];
        label.layer.cornerRadius = 8.f;
        label.layer.borderWidth = 0.5;
        label.layer.borderColor = [UIColor lightGrayColor].CGColor;
        label.layer.masksToBounds = YES;
        label.tag = 51;
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastLabel == nil) {
                make.left.equalTo(_nameLabel);
                make.size.mas_equalTo(CGSizeMake(titleWidth, titleSize.height +4));
                make.top.equalTo(_heightLabel.mas_bottom).offset(5);
            }else
            {
                make.left.equalTo(lastLabel.mas_right).offset(10);
                make.size.mas_equalTo(CGSizeMake(titleWidth, titleSize.height +4));
                make.top.equalTo(lastLabel);
            }
        }];
        
        lastLabel = label;
    }
    
}

@end
