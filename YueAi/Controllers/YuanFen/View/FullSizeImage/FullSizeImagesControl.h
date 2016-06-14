////
////  FullSizeImagesControl.h
////  YueAi
////
////  Created by 郭洪军 on 6/6/16.
////  Copyright © 2016 郭洪军. All rights reserved.
////
//
//@protocol FullSizeImagesControlDelegate;
//
//@interface FullSizeImagesControl : UIControl<UIScrollViewDelegate, UIGestureRecognizerDelegate>
//
//@property (nonatomic, strong) id<FullSizeImagesControlDelegate> delegate;
//
//@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) UIPageControl *pageControl;
//@property (nonatomic, strong) UIImageView* imageView;
//
//@property (nonatomic, strong) NSArray *imageURLs;
//@property (nonatomic, strong) NSMutableArray *imageViews;
//@property (nonatomic, strong) NSMutableArray *scrollViews;
//@property (nonatomic, strong) NSArray *images;
//
//@property (nonatomic, assign) NSInteger currentPage;
//
//- (void)showImages:(NSArray *)images URLs:(NSArray *)imageURLs fromView:(UIView *)view index:(NSInteger )index completed:(void (^)(void))completed;
//- (void)showImage:(UIImage *)image imageURL:(NSString *)imageURL fromView:(UIView *)view;
//
//@end
//
//
//
//@protocol FullSizeImagesControlDelegate
//
//@optional
//
//- (NSArray *)sourceViews;
//
//- (void)fullSizeImagesControlDidLongPress:(NSInteger )index;
//
//@end
