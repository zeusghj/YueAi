//
//  YFCustomCell.m
//  YueAi
//
//  Created by 郭洪军 on 5/27/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "YFCustomCell.h"

@implementation YFCustomCell

- (void)awakeFromNib {
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.layer.masksToBounds = YES;
}

- (void)setModel:(YFCustomCellModel *)model
{
    _model = model;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.iconUrl]];
}

@end

@implementation YFCustomCellModel

@end
