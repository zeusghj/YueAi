//
//  GDCustomCell.m
//  YueAi
//
//  Created by 郭洪军 on 6/3/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "GDCustomCell.h"

@implementation GDCustomCell

- (void)awakeFromNib
{
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    _imageView.layer.masksToBounds = YES;
}

@end
