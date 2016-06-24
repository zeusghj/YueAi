//
//  GirlDetailCell.m
//  YueAi
//
//  Created by 郭洪军 on 6/14/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "GirlDetailCell.h"
#import "AudioManager.h"

#define ICON_LEFT_MARGIN   15
#define TITLE_LEFT_MARGIN  10

@interface GirlDetailCell ()

@property (nonatomic, assign)NSInteger cellType;
@property (nonatomic, strong)GirlDetailModel* model;

@property (nonatomic, strong)UIColor* lineColor;

@end

@implementation GirlDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(NSInteger)type model:(GirlDetailModel *)model showDetail:(BOOL)show
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _cellType = type;
        _model = model;
        
        _iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconImageView];
        
        if (_cellType == 1) {
            [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(ICON_LEFT_MARGIN);
                make.top.equalTo(self.contentView).offset(30);
                make.bottom.equalTo(self.contentView).offset(-10);
                make.width.equalTo(@17);
            }];
            
            _typeNameLabel = [[UILabel alloc]init];
            _typeNameLabel.font = [UIFont boldSystemFontOfSize:22.f];
            _typeNameLabel.text = _model.name;
            [self.contentView addSubview:_typeNameLabel];
            [_typeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_iconImageView.mas_right).offset(TITLE_LEFT_MARGIN);
                make.centerY.equalTo(_iconImageView);
            }];
            
            UIImageView* lastImageView = nil;
            
            for (int i=0; i<_model.medals.count; ++i) {
                UIImageView* imageView = [[UIImageView alloc]init];
                UIImage* image = nil;
                [self.contentView addSubview:imageView];
                NSString* str = _model.medals[i];
                if ([str isEqualToString:@"doubi"]) {
                    image = [UIImage imageNamed:@"medal_icons_doubi"];
                }else if ([str isEqualToString:@"vip"])
                {
                    image = [UIImage imageNamed:@"medal_icons_vip"];
                }else if ([str isEqualToString:@"star"])
                {
                    image = [UIImage imageNamed:@"medal_icons_star_01"];
                }else if ([str isEqualToString:@"mail"])
                {
                    image = [UIImage imageNamed:@"medal_icons_mail_member"];
                }
                imageView.image = image;
                
                if (!lastImageView) {
                    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(_typeNameLabel.mas_right).offset(10);
                        make.centerY.equalTo(_typeNameLabel);
                    }];
                }else
                {
                    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(lastImageView.mas_right).offset(3);
                        make.centerY.equalTo(lastImageView);
                    }];
                }
                
                lastImageView = imageView;
            }
            
            _iconImageView.image = [UIImage imageNamed:@"otherspace_user"];
        }else if (_cellType == 2)
        {
            [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(ICON_LEFT_MARGIN);
                make.top.equalTo(self.contentView).offset(12);
                make.bottom.equalTo(self.contentView).offset(-12);
                make.width.equalTo(@17);
            }];
            
            _typeNameLabel = [[UILabel alloc]init];
            _typeNameLabel.text = @"自我介绍";
            _typeNameLabel.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:_typeNameLabel];
            [_typeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_iconImageView.mas_right).offset(TITLE_LEFT_MARGIN);
                make.centerY.equalTo(_iconImageView);
            }];
            
            UIImageView* imgView2 = [[UIImageView alloc]init];
            imgView2.image = [[UIImage imageNamed:@"wave_bg9"]resizableImageWithCapInsets:UIEdgeInsetsMake(16, 17, 16, 17) resizingMode:UIImageResizingModeStretch];
            [self.contentView addSubview:imgView2];
            imgView2.userInteractionEnabled = YES;
            [imgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_typeNameLabel.mas_left).offset(85);
                make.width.equalTo(@150);
                make.centerY.equalTo(_typeNameLabel);
            }];
            
            UIImageView* imgView3 = [[UIImageView alloc] init];
            imgView3.image = [UIImage imageNamed:@"wave03"];
            [imgView2 addSubview:imgView3];
            imgView3.userInteractionEnabled = YES;
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playAudio:)];
            [imgView3 addGestureRecognizer:tap];
            [imgView3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(imgView2);
                make.left.equalTo(imgView2).offset(2);
            }];
            
            UILabel* timeLb = [[UILabel alloc] init];
            timeLb.text = [NSString stringWithFormat:@"%ldS", _model.time];
            timeLb.textColor = [UIColor lightGrayColor];
            [imgView2 addSubview:timeLb];
            [timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(imgView2);
            }];
            
            _iconImageView.image = [UIImage imageNamed:@"otherspace_microphone"];
        }else if (_cellType == 3)
        {
            [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(ICON_LEFT_MARGIN);
                //                make.centerY.equalTo(self.contentView);
                make.top.equalTo(self.contentView).offset(10);
                make.bottom.equalTo(self.contentView).offset(-10);
                make.width.equalTo(@17);
            }];
            
            _typeNameLabel = [[UILabel alloc]init];
            _typeNameLabel.text = @"新鲜事";
            _typeNameLabel.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:_typeNameLabel];
            
            [_typeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_iconImageView.mas_right).offset(TITLE_LEFT_MARGIN);
                make.centerY.equalTo(_iconImageView);
            }];
            
            _iconImageView.image = [UIImage imageNamed:@"otherspace_fresh"];
        }else if (_cellType == 4)
        {
            [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(ICON_LEFT_MARGIN);
                make.top.equalTo(self.contentView).offset(10);
                make.width.equalTo(@17);
            }];
            
            _typeNameLabel = [[UILabel alloc]init];
            _typeNameLabel.text = @"资料";
            _typeNameLabel.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:_typeNameLabel];
            [_typeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_iconImageView.mas_right).offset(TITLE_LEFT_MARGIN);
                make.centerY.equalTo(_iconImageView);
            }];
            
            UILabel* ziliaoLb = [[UILabel alloc] init];
            ziliaoLb.numberOfLines = 0;
            ziliaoLb.text = _model.ziliao;
            [self.contentView addSubview:ziliaoLb];
            [ziliaoLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_typeNameLabel.mas_left).offset(85);
                make.right.equalTo(self.contentView).offset(-10);
                make.top.equalTo(_typeNameLabel);
            }];
            
            if (!show) {
                UIImageView* imgViewbg = [[UIImageView alloc]init];
                imgViewbg.image = [[UIImage imageNamed:@"more_text_bg"]resizableImageWithCapInsets:UIEdgeInsetsMake(16, 17, 16, 17) resizingMode:UIImageResizingModeStretch];
                [self.contentView addSubview:imgViewbg];
                imgViewbg.userInteractionEnabled = YES;
                UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMoreMessage:)];
                [imgViewbg addGestureRecognizer:tap];
                [imgViewbg mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(_typeNameLabel.mas_left).offset(85);
                    make.top.equalTo(ziliaoLb.mas_bottom).offset(10);
                    make.width.equalTo(@130);
                    make.bottom.equalTo(self.contentView).offset(-5);
                }];
                
                UILabel* moreLb = [[UILabel alloc] init];
                moreLb.text = @"更多详细资料";
                moreLb.textColor = [UIColor lightGrayColor];
                [imgViewbg addSubview:moreLb];
                [moreLb mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(imgViewbg).offset(5);
                    make.centerY.equalTo(imgViewbg);
                }];
                
                UIImageView* imgViewarrow = [[UIImageView alloc]init];
                imgViewarrow.image = [UIImage imageNamed:@"more_text_arrowdown"];
                [imgViewbg addSubview:imgViewarrow];
                [imgViewarrow mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(imgViewbg.mas_right).offset(-5);
                    make.centerY.equalTo(imgViewbg);
                }];
            }else
            {
                UILabel* detailLb = [[UILabel alloc] init];
                detailLb.numberOfLines = 0;
                detailLb.text = _model.detail;
                [self.contentView addSubview:detailLb];
                [detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(_typeNameLabel.mas_left).offset(85);
                    make.right.equalTo(self.contentView).offset(-20);
                    make.top.equalTo(ziliaoLb.mas_bottom).offset(10);
                    make.bottom.equalTo(self.contentView).offset(-5);
                }];
            }
            
            _iconImageView.image = [UIImage imageNamed:@"member_info_icon"];
        }else if (_cellType == 5)
        {
            [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(ICON_LEFT_MARGIN);
                make.top.equalTo(self.contentView).offset(10);
                make.width.equalTo(@17);
            }];
            
            _typeNameLabel = [[UILabel alloc]init];
            _typeNameLabel.text = @"标签";
            _typeNameLabel.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:_typeNameLabel];
            [_typeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_iconImageView.mas_right).offset(TITLE_LEFT_MARGIN);
                make.centerY.equalTo(_iconImageView);
            }];
            
            CGSize maxSize = CGSizeMake(SCREEN_WIDTH - 130 - 10, 25);
            
            NSMutableArray* sizeArr = [NSMutableArray new];
            for (int i=0; i<_model.tags.count; ++i) {
                NSString* text = _model.tags[i];
                
                CGSize titleSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
                [sizeArr addObject:[NSValue valueWithCGSize:titleSize]];
            }
            
            NSArray* arrs = [self getLinesFromSizes:sizeArr];        //总的行数
            UILabel* lastLabel = nil;
            int item = 0;
            
            for (int i = 0; i<arrs.count; ++i) {
                NSArray* arr = arrs[i];
                for (int j=0; j<arr.count; ++j) {
                    NSString* text = _model.tags[item];
                    
                    CGSize titleSize = [arr[j] CGSizeValue];
                    CGFloat titleWidth = titleSize.width + 10;
                    
                    UILabel* label = [[UILabel alloc] init];
                    label.text = text;
                    label.textAlignment = NSTextAlignmentCenter;
                    label.textColor = [UIColor whiteColor];
                    label.backgroundColor = [UIColor darkGrayColor];
                    label.layer.cornerRadius = 12.f;
                    label.layer.masksToBounds = YES;
                    [self.contentView addSubview:label];
                    
                    [label mas_makeConstraints:^(MASConstraintMaker *make) {
                        if (lastLabel == nil) {
                            make.left.equalTo(_typeNameLabel.mas_left).offset(85);
                            make.size.mas_equalTo(CGSizeMake(titleWidth, titleSize.height +4));
                            make.top.equalTo(_typeNameLabel).offset(-2);
                            
                        }else
                        {
                            if (j==0) {
                                make.left.equalTo(_typeNameLabel.mas_left).offset(85);
                                make.size.mas_equalTo(CGSizeMake(titleWidth, titleSize.height +4));
                                make.top.equalTo(lastLabel.mas_bottom).offset(5);
                            }else
                            {
                                make.left.equalTo(lastLabel.mas_right).offset(5);
                                make.size.mas_equalTo(CGSizeMake(titleWidth, titleSize.height +4));
                                make.centerY.equalTo(lastLabel);
                            }
                            
                        }
                        
                        if (item == sizeArr.count - 1) {
                            make.bottom.equalTo(self.contentView).offset(-10);
                        }
                    }];
                    
                    lastLabel = label;
                    
                    item += 1;
                }
            }
            
            
            
            _iconImageView.image = [UIImage imageNamed:@"otherspace_tag_icon"];
        }else if (_cellType == 6)
        {
            [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(ICON_LEFT_MARGIN);
                make.top.equalTo(self.contentView).offset(10);
                make.width.equalTo(@17);
            }];
            
            _typeNameLabel = [[UILabel alloc]init];
            _typeNameLabel.text = @"征友条件";
            _typeNameLabel.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:_typeNameLabel];
            [_typeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_iconImageView.mas_right).offset(TITLE_LEFT_MARGIN);
                make.centerY.equalTo(_iconImageView);
            }];
            
            UILabel* conLb = [[UILabel alloc] init];
            conLb.numberOfLines = 0;
            conLb.text = _model.condition;
            [self.contentView addSubview:conLb];
            [conLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_typeNameLabel.mas_left).offset(85);
                make.right.equalTo(self.contentView).offset(-20);
                make.top.equalTo(_typeNameLabel);
                make.bottom.equalTo(self.contentView).offset(-5);
            }];
            
            _iconImageView.image = [UIImage imageNamed:@"otherspace_condition"];
        }else if (_cellType == 7)
        {
            [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(ICON_LEFT_MARGIN);
                make.top.equalTo(self.contentView).offset(10);
                make.width.equalTo(@17);
            }];
            
            _typeNameLabel = [[UILabel alloc]init];
            _typeNameLabel.text = @"在线状态";
            _typeNameLabel.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:_typeNameLabel];
            [_typeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_iconImageView.mas_right).offset(TITLE_LEFT_MARGIN);
                make.centerY.equalTo(_iconImageView);
            }];
            
            UIButton* btn = [[UIButton alloc] init];
            [btn setImage:[UIImage imageNamed:@"medal_icons_vip"] forState:UIControlStateNormal];
            [btn setTitle:@"开通会员" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(openVip) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:[UIColor colorWithRed:250.f/255 green:157.f/255 blue:76.f/255 alpha:1] forState:UIControlStateNormal];
            [self.contentView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_typeNameLabel.mas_left).offset(85);
                make.center.equalTo(_typeNameLabel);
                make.width.equalTo(@90);
            }];
            
            UILabel* lb = [[UILabel alloc] init];
            lb.numberOfLines = 0;
            lb.text = @"查看Ta在线状态";
            [self.contentView addSubview:lb];
            [lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(btn.mas_right).offset(10);
                make.right.equalTo(self.contentView);
                make.top.equalTo(_typeNameLabel);
                make.bottom.equalTo(self.contentView).offset(-50);
            }];
            
            _iconImageView.image = [UIImage imageNamed:@"otherspace_state"];
        }
        
    }
    
    return self;
}

/**
 *  根据传入的表签的尺寸，计算这些标签有几行
 */
- (NSMutableArray *)getLinesFromSizes:(NSArray *)sizes
{
    NSMutableArray* arrs = [NSMutableArray new];
    CGFloat   widths = 0.f;
    NSMutableArray* xiaoArr = [NSMutableArray new];
    for (int i=0; i<sizes.count; ++i) {
        
        CGFloat width = [sizes[i] CGSizeValue].width;
        
        widths += width + 10 + 5;
        if (widths < SCREEN_WIDTH - 130 - 10) {
            [xiaoArr addObject:sizes[i]];
        }else
        {
            [arrs addObject:xiaoArr];
            widths = width;
            xiaoArr = [NSMutableArray new];
            [xiaoArr addObject:sizes[i]];
        }
    }
    
    [arrs addObject:xiaoArr];
    
    return arrs;
}

/**
 *  开通会员方法
 */
- (void)openVip
{
    NSLog(@"开通会员");
}

/**
 *  播放自我介绍
 */
- (void)playAudio:(UITapGestureRecognizer *)tap
{
    UIImageView* view = (UIImageView*)tap.view;
    
    NSArray *imagesArray = [NSArray arrayWithObjects:
                           [UIImage imageNamed:@"wave04"],
                           [UIImage imageNamed:@"wave01"],
                           [UIImage imageNamed:@"wave02"],
                           [UIImage imageNamed:@"wave03"],nil];
    
    view.animationImages = imagesArray;
    view.animationDuration = 1;
    view.animationRepeatCount = 13;
    [view startAnimating];
    
    [[AudioManager getInstance] play];
}

/**
 * 显示更多详细信息
 */
- (void)showMoreMessage:(UIGestureRecognizer *)tap
{
    if (self.showDetail) {
        self.showDetail();
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if(!self.lineColor)
    {
        self.lineColor = [UIColor colorWithRed:221.f/250 green:221.f/250 blue:221.f/250 alpha:1];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetLineWidth(context, 0.5);
    CGContextMoveToPoint(context, _iconImageView.frame.origin.x + _iconImageView.frame.size.width/2, 0);
    CGContextAddLineToPoint(context, _iconImageView.frame.origin.x + _iconImageView.frame.size.width/2, rect.size.height);
    CGContextStrokePath(context);
}

@end
