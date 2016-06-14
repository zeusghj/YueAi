//
//  ShowImageView.m
//  YueAi
//
//  Created by 郭洪军 on 6/7/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "ShowImageView.h"

@implementation ShowImageView
{
    CGFloat currentScale;
}

- (id) init
{
    if (self = [super init]) {
        [self scrollView];
    }
    
    return self;
}

- (void)setModel:(ImageModel *)model
{
    _model = model;
    
    [self addView];
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self addSubview:scrollView];
        
        _scrollView = scrollView;
        _scrollView.delegate = self;
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.right.equalTo(self).offset(-20);
        }];
    }
    
    return _scrollView;
}

- (void)addView
{
    if (_model.width == 0) {
        _model.width = 1000;
    }
    if (_model.height == 0) {
        _model.height = 1000;
    }
    CGRect rect;
    _imageView = [[UIImageView alloc] init];
    [_imageView setBackgroundColor:[UIColor lightGrayColor]];
    rect.size.width = _model.width;
    rect.size.height = _model.height;
    if (_model.width < BOUNDS.width) {
        rect.size.width = BOUNDS.width * 2;
        CGFloat p = _model.width/_model.height;
        rect.size.height = (BOUNDS.width/p)* 2;
    }
    [_imageView setFrame:rect];
    [self.scrollView setContentSize:[_imageView frame].size];
    [_scrollView setMinimumZoomScale:[_scrollView frame].size.width / [_imageView frame].size.width ];
    [_scrollView setZoomScale:0.0];
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:@"img_pic_jz"]];
    [_imageView setImage:[UIImage imageNamed:@"meinv1"]];
    [_scrollView addSubview:_imageView];
    
    NSLog(@"scrollView.frame = %@, _imageView.frame = %@", NSStringFromCGRect(_scrollView.frame), NSStringFromCGRect(_imageView.frame));
    
    UITapGestureRecognizer *tapImgView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgViewHandle)];
    tapImgView.numberOfTapsRequired = 1;
    tapImgView.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapImgView];
    
    UITapGestureRecognizer *tapImgViewTwice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgViewHandleTwice:)];
    tapImgViewTwice.numberOfTapsRequired = 2;
    tapImgViewTwice.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapImgViewTwice];
    [tapImgView requireGestureRecognizerToFail:tapImgViewTwice];
}

-(void)changeView{
    [_imageView removeFromSuperview];
    [self addView];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    currentScale = scale;
    NSLog(@"回调-%f",currentScale);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

#pragma mark - tap
-(void)tapImgViewHandle{
    if (currentScale > 0.6) {
        currentScale = 0.0;
        [self.scrollView setZoomScale:0.0 animated:YES];
    }else{
        [_delegate backOnClick];
    }
}

-(void)tapImgViewHandleTwice:(UIGestureRecognizer *)sender{
    
    CGPoint touchPoint = [sender locationInView:self.scrollView];
    NSLog(@"%f",touchPoint.x);
    if(currentScale > 0.6){
        currentScale = 0.0;
        [self.scrollView setZoomScale:0.0 animated:YES];
    }else{
        currentScale = 2.0;
        [self.scrollView zoomToRect:CGRectMake(touchPoint.x*4, touchPoint.y*4, 1, 1) animated:YES];
    }
    
}
//实现图片在缩放过程中居中

- (void)scrollViewDidZoom:(UIScrollView *)scrollView1
{
    CGFloat offsetX = (scrollView1.bounds.size.width > scrollView1.contentSize.width)?(scrollView1.bounds.size.width - scrollView1.contentSize.width)/2 : 0.0;
    
    CGFloat offsetY = (scrollView1.bounds.size.height > scrollView1.contentSize.height)?(scrollView1.bounds.size.height - scrollView1.contentSize.height)/2 : 0.0;
    
    _imageView.center = CGPointMake(scrollView1.contentSize.width/2 + offsetX,scrollView1.contentSize.height/2 + offsetY);
    
}

- (void)drawRect:(CGRect)rect {
    [self addView];
}



@end
