////
////  FullSizeImagesControl.m
////  YueAi
////
////  Created by 郭洪军 on 6/6/16.
////  Copyright © 2016 郭洪军. All rights reserved.
////
//
//#import "FullSizeImagesControl.h"
//#import "UIImageView+WebCache.h"
//
//static CGFloat kMargin = 20.0;
//
//@implementation FullSizeImagesControl
//
//#pragma mark - property
//
//- (UIScrollView *)scrollView {
//    
//    if (!_scrollView) {
//        
//        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
//        _scrollView.pagingEnabled = YES;
//        _scrollView.bounces = YES;
//        _scrollView.delegate = self;
//        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.showsVerticalScrollIndicator = NO;
//    }
//    return _scrollView;
//}
//
//- (UIPageControl *)pageControl {
//    
//    if (!_pageControl) {
//        
//        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
////        _pageControl.currentPageIndicatorTintColor = [DR6StyleManager globalStyleManager].windowTintColor;
////        _pageControl.pageIndicatorTintColor = [DR6StyleManager globalStyleManager].imageBackgroundColor;
//        _pageControl.userInteractionEnabled = NO;
//    }
//    return _pageControl;
//}
//
//- (UIImageView*)imageView{
//    if (!_imageView) {
//        _imageView = [[UIImageView alloc]init];
//    }
//    return _imageView;
//}
//
//
//- (NSMutableArray *)imageViews {
//    
//    if (!_imageViews) {
//        _imageViews = [NSMutableArray arrayWithCapacity:0];
//    }
//    return _imageViews;
//}
//
//- (NSMutableArray *)scrollViews {
//    
//    if (!_scrollViews) {
//        _scrollViews = [NSMutableArray arrayWithCapacity:0];
//    }
//    return _scrollViews;
//}
//
//- (void)setImageURLs:(NSArray *)imageURLs {
//    _imageURLs = imageURLs;
//    
//    self.scrollView.frame = CGRectMake(0, 0, self.frame.size.width + kMargin, self.frame.size.height);
//    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * imageURLs.count, 0);
//    [self addSubview:self.scrollView];
//    
//    for (int i = 0; i < imageURLs.count; i++) {
//        
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        __weak typeof(UIImageView) *weakimageView = imageView;
//        
//        UIScrollView *imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
//        imageScrollView.delegate  = self;
//        imageScrollView.bounces = YES;
//        
//        imageScrollView.showsHorizontalScrollIndicator = NO;
//        imageScrollView.showsVerticalScrollIndicator = NO;
//        
//        if (self.images.count > i) {
//            imageView.image = self.images[i];
//            imageView.frame = CGRectMake(0, 0, imageScrollView.frame.size.width, imageScrollView.frame.size.height);
//            imageView.center = imageScrollView.center;
//        }
//        
//        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//        activityView.center = imageScrollView.center;
//        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
//        [activityView startAnimating];
//        
//        [imageView addSubview:activityView];
//        [imageScrollView addSubview:imageView];
//        
//        [imageView sd_setImageWithURL:imageURLs[i] placeholderImage:imageView.image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            if (image) {
//                if ((self.frame.size.height - weakimageView.image.size.height * self.frame.size.width / weakimageView.image.size.width) >= 0) {
//                    weakimageView.frame = CGRectMake(0, (self.frame.size.height - weakimageView.image.size.height * self.frame.size.width / weakimageView.image.size.width)/2, self.frame.size.width, weakimageView.image.size.height * self.frame.size.width / weakimageView.image.size.width);
//                }else
//                {
//                    weakimageView.frame = CGRectMake((self.frame.size.width - self.frame.size.height / weakimageView.image.size.height * weakimageView.image.size.width) / 2.0, 0, self.frame.size.height/ weakimageView.image.size.height * weakimageView.image.size.width, self.frame.size.height);
//                }
//                
//                imageScrollView.maximumZoomScale = (self.scrollView.frame.size.height / weakimageView.frame.size.height > 1.5 ? self.frame.size.height / weakimageView.frame.size.height : self.frame.size.width / weakimageView.frame.size.width >= 2.0 ? self.frame.size.width / weakimageView.frame.size.width : 2.0);
//                imageScrollView.minimumZoomScale = 1.0;
//                
//                [self.imageViews addObject:weakimageView];
//                
//                [activityView stopAnimating];
//            }
//        }];
//            
//        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
//        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//        doubleTapGesture.numberOfTapsRequired = 2;
//        [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
//        
//        [imageScrollView addGestureRecognizer:doubleTapGesture];
//        [imageScrollView addGestureRecognizer:singleTapGesture];
//        
//        [imageScrollView setContentSize:CGSizeMake(imageView.frame.size.width, imageView.frame.size.height)];
//        
//        [self.scrollView addSubview:imageScrollView];
//        [self.scrollViews addObject:imageScrollView];
//    }
//    
//    CGFloat pageControlHeight = 10.0;
//    CGFloat margin = 30.0;
//    
//    if (imageURLs.count > 1) {
//        self.pageControl.frame = CGRectMake(0, self.frame.size.height - margin, self.frame.size.width, pageControlHeight);
//        [self addSubview:_pageControl];
//    }
//    
//}
//
//#pragma mark - public
//
//- (void)showImages:(NSArray *)images URLs:(NSArray *)imageURLs fromView:(UIView *)view index:(NSInteger )index completed:(void (^)(void))completed {
//    
//    UIImage *presentingImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageURLs[index]];
//    if (imageURLs.count <= 0 && !presentingImage) {
//        return;
//    }
//    
//    self.pageControl.numberOfPages = imageURLs.count;
//    self.pageControl.currentPage = index;
//    
//    self.images = images;
//    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageURLs[index]]];
//    [self addSubview:self.imageView];
//    
//    UIView *keyWindow = [UIApplication sharedApplication].keyWindow;
//    CGRect rect = [view.superview convertRect:view.frame toView:keyWindow];
//    self.imageView.frame = rect;
//    
//    self.alpha = 0;
//    self.backgroundColor = [UIColor clearColor];
//    
//    [keyWindow addSubview:self];
//    
//    CGFloat startRadius = view.layer.cornerRadius;
//    CGFloat endRadius = 0;
//    if (startRadius) {
//        self.imageView.layer.cornerRadius = startRadius;
//    }
//    
//    [UIView animateWithDuration:0.2
//                          delay:0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         
//                         self.alpha = 1;
//                         self.backgroundColor = [UIColor blackColor];
//                         
//                     } completion:^(BOOL finished) {
//                         
//                         CGFloat duration = 0.3;
//                         
//                         if (startRadius) {
//                             
//                             CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
//                             
//                             animation.delegate = self;
//                             
//                             animation.fromValue = @(startRadius);
//                             animation.toValue = @(endRadius);
//                             animation.duration = duration;
//                             [self.imageView.layer addAnimation:animation forKey:@"cornerRadius"];
//                             self.imageView.layer.cornerRadius = 0;
//                         }
//                         
//                         self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//                         
//                         if (!self.imageView.image) {
//                             
//                             self.imageURLs = imageURLs;
//                             self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * index, 0);
//                             self.pageControl.currentPage = index;
//                             self.imageView.image = self.images[index];
//                             self.imageView.frame = [self finalRectForImage:self.images[index]];
//                             self.imageView.hidden = YES;
//                             return ;
//                         }
//                         
//                         [UIView animateWithDuration:duration
//                                               delay:0
//                                             options:7 << 16
//                                          animations:^{
//                                              
//                                              self.imageView.frame = [self finalRectForImage:presentingImage];
//                                          } completion:^(BOOL finished) {
//                                              
//                                              self.imageView.layer.cornerRadius = endRadius;
//                                              if (![NSStringFromCGRect(self.imageView.frame) isEqualToString:NSStringFromCGRect([self finalRectForImage:presentingImage])]) {
//                                                  return ;
//                                              }
//                                              
//                                              self.imageURLs = imageURLs;
//                                              self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * index, 0);
//                                              self.pageControl.currentPage = index;
//                                              self.currentPage = index;
//                                              self.imageView.hidden = YES;
//                                              
//                                              completed();
//                                          }];
//                     }];
//    
//    
//}
//
//- (CGRect)finalRectForImage:(UIImage *)image
//{
//    CGRect rect = CGRectZero;
//    
//    rect = CGRectMake(0, (SCREEN_HEIGHT - image.size.height * SCREEN_WIDTH/image.size.width)/2, SCREEN_WIDTH, image.size.height * SCREEN_WIDTH/image.size.width);
//    
//    return rect;
//}
//
//- (void)showImage:(UIImage *)image imageURL:(NSString *)imageURL fromView:(UIView *)view {
//    
//    [self showImages:[NSArray arrayWithObject:image] URLs:[NSArray arrayWithObject:imageURL] fromView:view index:0 completed:^{
//        
//    }];
//}
//
//
//- (void)pressed:(id)sender {
//    
//    UIView *sourceView = nil;
//    
//    if ([self.delegate]) {
//        <#statements#>
//    }
//    
//    if ([self.delegate respondsToSelector:@selector(sourceView)]) {
//        sourceView = [self.delegate sourceView];
//    } else if ([self.delegate respondsToSelector:@selector(sourceViews)]) {
//        
//        if (self.pageControl.currentPage < [self.delegate sourceViews].count) {
//            sourceView = (UIView *)[self.delegate sourceViews][self.pageControl.currentPage];
//        }
//        
//    }
//    
//    self.imageView.hidden = NO;
//    [self.scrollView removeFromSuperview];
//    [self.pageControl removeFromSuperview];
//    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    //    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
//    
//    CGFloat duration = 0.3;
//    CGFloat startRadius = sourceView.layer.cornerRadius;
//    CGFloat endRadius = 0;
//    
//    UIView *rootView = [UIApplication sharedApplication].keyWindow;
//    CGRect rect = self.imageView.frame;
//    
//    if (sourceView) {
//        rect = [sourceView.superview convertRect:sourceView.frame toView:rootView];
//        if (startRadius) {
//            self.imageView.layer.cornerRadius = endRadius;
//            
//            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
//            
//            animation.fromValue = @(endRadius);
//            animation.toValue = @(startRadius);
//            animation.duration = duration;
//            [self.imageView.layer addAnimation:animation forKey:@"cornerRadius"];
//            self.imageView.layer.cornerRadius = startRadius;
//        }
//    }
//    
//    [UIView animateWithDuration:duration
//                          delay:0
//                        options:7 << 16
//                     animations:^{
//                         
//                         [self imageShrink];
//                         self.imageView.frame = rect;
//                     } completion:^(BOOL finished) {
//                         
//                         [UIView animateWithDuration:0.2
//                                               delay:0
//                                             options:UIViewAnimationOptionCurveLinear
//                                          animations:^{
//                                              
//                                              self.alpha = 0;
//                                              self.backgroundColor = [UIColor clearColor];
//                                          } completion:^(BOOL finished) {
//                                              
//                                              [self removeFromSuperview];
//                                          }];
//                     }];
//}
//
//- (void)longPressed:(UILongPressGestureRecognizer *)presser {
//    
//    if (presser.state == UIGestureRecognizerStateBegan && [self.delegate respondsToSelector:@selector(fullSizeImagesControlDidLongPress:)]) {
//        [self.delegate fullSizeImagesControlDidLongPress:self.pageControl.currentPage];
//    }
//}
//
//- (void)handleDoubleTap:(UIGestureRecognizer *)gesture {
//    
//    float newScale;
//    UIScrollView *scrollView = (UIScrollView *)gesture.view;
//    
//    if (scrollView.zoomScale == 1.0) {
//        newScale = scrollView.maximumZoomScale;
//    }
//    else{
//        newScale = 1.0 / scrollView.maximumZoomScale;
//    }
//    
//    CGRect zoomRect = [self zoomRectForScale:newScale withCenter: [gesture locationInView:(UIScrollView *)gesture.view]];
//    [(UIScrollView *)gesture.view zoomToRect:zoomRect animated:YES];
//    
//}
//
//- (void)handleSingleTap:(UIGestureRecognizer *)gesture {
//    
//    UIScrollView *scrollView = (UIScrollView *)gesture.view;
//    
//    if (scrollView.zoomScale != 1.0) {
//        self.imageView.frame = CGRectMake(-scrollView.contentOffset.x, -scrollView.contentOffset.y, scrollView.contentSize.width, scrollView.contentSize.height);
//    }
//    
//    self.imageView.hidden = NO;
//    [self.scrollView removeFromSuperview];
//    [self.pageControl removeFromSuperview];
//    [self pressed:self];
//}
//
//#pragma mark - private
//
//- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
//{
//    
//    CGRect zoomRect;
//    zoomRect.size.height = self.frame.size.height / scale;
//    zoomRect.size.width  = self.frame.size.width  / scale;
//    zoomRect.origin.x = center.x - zoomRect.size.width / 2.0;
//    zoomRect.origin.y = center.y - zoomRect.size.height / 2.0;
//    return zoomRect;
//}
//
//#pragma mark - UIScrollViewDelegate
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    
//    [_pageControl setCurrentPage:_scrollView.contentOffset.x / _scrollView.frame.size.width];
//    
//    if (self.currentPage == self.pageControl.currentPage) {
//        return;
//    }
//    
//    if (self.scrollView == scrollView) {
//        
//        for (UIScrollView *imagescrollView in self.scrollViews) {
//            
//            if ([imagescrollView isKindOfClass:[UIScrollView class]]) {
//                
//                imagescrollView.zoomScale = 1.0;
//            }
//        }
//        self.currentPage = self.pageControl.currentPage;
//    }
//    
//    if (self.pageControl.currentPage < _imageViews.count) {
//        
//        UIImageView *imageView = _imageViews[self.pageControl.currentPage];
//        self.imageView.image = imageView.image;
//        self.imageView.frame = imageView.frame;
//    }
//}
//
//
//#pragma mark - UIScrollViewZoom
//
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    if (scrollView != self.scrollView) {
//        if (self.imageViews.count == self.scrollViews.count) {
//            UIImageView *imageView = [self.imageViews objectAtIndex:[self.scrollViews indexOfObject:scrollView]];
//            return imageView;
//        }
//    }
//    return nil;
//}
//
//- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
//    
//    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
//    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
//    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
//    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
//    
//    UIImageView *imageView = [self.imageViews objectAtIndex:[self.scrollViews indexOfObject:scrollView]];
//    imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
//}
//
//@end
