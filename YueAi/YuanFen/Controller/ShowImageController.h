//
//  ShowImageController.h
//  YueAi
//
//  Created by 郭洪军 on 6/7/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
#import "ShowImageView.h"

@interface ShowImageController : UIViewController<SwipeViewDataSource, SwipeViewDelegate, ShowImageDelegate>

@property (nonatomic, weak) SwipeView* swipeView;

//图片存储数据
@property (weak, nonatomic) NSArray* data;
//页标
@property NSInteger index;
//类型
@property NSInteger type;
//动画类型
@property NSInteger pop_type;

//创建动画
- (void)showImageView:(CGRect)frame image:(UIImage *)image w:(CGFloat)w h:(CGFloat)h;

@end
