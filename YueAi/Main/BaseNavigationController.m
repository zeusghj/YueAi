//
//  BaseNavigationController.m
//  YueAi
//
//  Created by 郭洪军 on 6/3/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.navigationBar.frame;
    
    _alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height + 20)];
    _alphaView.backgroundColor = [UIColor colorWithRed:42.f/255 green:36.f/255 blue:43.f/255 alpha:1];
    
    _avatarBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 300*height_scale)];
    _avatarBackView.backgroundColor = [UIColor colorWithRed:42.f/255 green:36.f/255 blue:43.f/255 alpha:1];
    _avatarBackView.alpha = 0;
    _avatarBackView.userInteractionEnabled = NO;
    
    _avatarKuang = [[UIImageView alloc]init];
    _avatarKuang.image = [UIImage imageNamed:@"register_qa_guide_icon"];
    [_avatarBackView addSubview:_avatarKuang];
    
    _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(28.f, 28.f, 74.f, 74.f)];
//    _avatarImageView.image = [UIImage imageNamed:@"meinv1_icon"];
    [_avatarImageView.layer setCornerRadius:CGRectGetHeight([_avatarImageView bounds]) / 2];
    _avatarImageView.layer.masksToBounds = YES;
    [_avatarKuang addSubview:_avatarImageView];
    
    [self.view insertSubview:_alphaView belowSubview:self.navigationBar];
    [self.view insertSubview:_avatarBackView belowSubview:self.navigationBar];
    
    [_avatarKuang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_alphaView);
        make.top.equalTo(_alphaView);
    }];
    
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    self.navigationBar.layer.masksToBounds = YES;
    
}

- (void)setAlpha:(CGFloat)alpha{
    _alphaView.alpha = alpha;
}

- (void)setAlpha0
{
    [UIView animateWithDuration:0.5 animations:^{
        _alphaView.alpha = 0.0;
    } completion:^(BOOL finished) {
        _changing = NO;
    }];
}

- (void)setAlpha1
{
    [UIView animateWithDuration:0.5 animations:^{
        _alphaView.alpha = 1.0;
    } completion:^(BOOL finished) {
        _changing = NO;
    }];
}

- (void)setAvatarBackAlpha0
{
    [UIView animateWithDuration:0.5 animations:^{
        _avatarBackView.alpha = 0.0;
    } completion:^(BOOL finished) {
        _changing = NO;
    }];
}

- (void)setAvatarBackAlpha:(CGFloat)alpha
{
    _avatarBackView.alpha = alpha;
}

- (void)setAvatarBackHeight:(CGFloat)height
{
    _avatarBackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
}




@end
