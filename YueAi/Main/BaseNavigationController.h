//
//  BaseNavigationController.h
//  YueAi
//
//  Created by 郭洪军 on 6/3/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController
{
    BOOL _changing;
}

@property(strong, nonatomic) UIView* alphaView;
@property(strong, nonatomic) UIImageView* avatarKuang;
@property(strong, nonatomic) UIImageView* avatarImageView;
@property(strong, nonatomic) UIView* avatarBackView;

- (void)setAlpha:(CGFloat)alpha;
- (void)setAlpha0;
- (void)setAlpha1;

- (void)setAvatarBackAlpha0;
- (void)setAvatarBackAlpha:(CGFloat)alpha;
- (void)setAvatarBackHeight:(CGFloat)height;
@end
