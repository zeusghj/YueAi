//
//  ShowImageView.h
//  YueAi
//
//  Created by 郭洪军 on 6/7/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"

@protocol ShowImageDelegate <NSObject>

- (void)backOnClick;

@end

@interface ShowImageView : UIView<UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) ImageModel* model;
@property (strong, nonatomic) UIImageView* imageView;
@property (weak, nonatomic) id<ShowImageDelegate>delegate;

- (void) changeView;

@end
