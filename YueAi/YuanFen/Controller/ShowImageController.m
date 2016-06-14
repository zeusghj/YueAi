//
//  ShowImageController.m
//  YueAi
//
//  Created by 郭洪军 on 6/7/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "ShowImageController.h"

#define SCROLLMAR 20
#define TABLEVIEWMAR 10
#define COLLECTIONMAR 8
#define MXIMAR 4

@interface ShowImageController (){
    CGSize bigSize;
    CGSize smallSize;
    UIImageView* imageView;
    CGRect zframe;
    CGRect wframe;
}

@end

@implementation ShowImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self swipeView];
    
}

- (SwipeView *)swipeView
{
    if (!_swipeView) {
        SwipeView* tempView = [[SwipeView alloc] init];
        [self.view addSubview:tempView];
        
        [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.view);
            make.right.equalTo(self.view).offset(20);
        }];
        
        _swipeView = tempView;
        _swipeView.dataSource = self;
        _swipeView.delegate = self;
        _swipeView.pagingEnabled = YES;
        
    }
    
    return _swipeView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //return the total number of items in the carousel
    
    NSLog(@"data.count = %lu", (unsigned long)_data.count);
    
    return [_data count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    ShowImageView *showimage;
    if (view == nil)
    {
        showimage = [[ShowImageView alloc] init];
        showimage.model = [_data objectAtIndex:index];
        showimage.delegate = self;
    }else{
        showimage = (ShowImageView *)view;
        showimage.model = [_data objectAtIndex:index];
        showimage.delegate = self;
        [showimage changeView];
    }
    
    return showimage;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    NSLog(@"swipeView.bounds.size = %@", NSStringFromCGSize(_swipeView.bounds.size));
    
    return swipeView.bounds.size;
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    //update page control page
    NSLog(@"%ld",swipeView.currentPage);
    NSUInteger page = swipeView.currentPage;
    ImageModel *model = [_data objectAtIndex:page];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    NSInteger a1 = _index % 3;
    NSInteger a = page % 3;
    NSInteger chax = a - a1;
    NSInteger b1 = _index /3;
    NSInteger b = page / 3;
    NSInteger chay = b - b1;
    CGFloat x = zframe.origin.x + (chax * (zframe.size.width + MXIMAR));
    CGFloat y = zframe.origin.y + (chay * (zframe.size.height + MXIMAR));
    wframe = CGRectMake(x, y, zframe.size.width, zframe.size.height);
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"Selected item at index %ld", index);
}

- (void)dealloc
{
    _swipeView.delegate = nil;
    _swipeView.dataSource = nil;
}

-(void)showImageView:(CGRect) initframe image:(UIImage *) image w:(CGFloat )w h :(CGFloat) h{
    if (w == 0) {
        w = 1000;
    }
    if (h == 0) {
        h = 1000;
    }
    CGRect frame = [UIScreen mainScreen].bounds;
    zframe = initframe;
    imageView = [[UIImageView alloc] initWithFrame:initframe];
    imageView.image = image;
    imageView.clipsToBounds = YES;
    imageView.backgroundColor = [UIColor lightGrayColor];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    CGFloat iwidth = w;
    CGFloat iheight = h;
    if (iwidth > iheight) {
        CGFloat h = initframe.size.height;
        CGFloat w = iwidth / iheight * h;
        smallSize = CGSizeMake(w, h);
    }else{
        CGFloat w = initframe.size.width;
        CGFloat h = iheight / iwidth * w;
        smallSize = CGSizeMake(w, h);
    }
    if ((frame.size.height / frame.size.width) < (iheight / iwidth)) {
        CGFloat h = frame.size.height;
        CGFloat w = iwidth / iheight * h;
        bigSize = CGSizeMake(w, h);
    }else{
        CGFloat w = frame.size.width;
        CGFloat h = iheight / iwidth * w;
        bigSize = CGSizeMake(w, h);
    }
}

-(void)goBig{
    imageView.bounds = CGRectMake(0, 0, bigSize.width, bigSize.height);
    //markwyb隐藏NavBar
    CGFloat d = smallSize.height / bigSize.height;
    if (smallSize.width > smallSize.height) {
        d = smallSize.width / bigSize.width;
    }
    imageView.layer.transform = CATransform3DMakeScale(d, d, 1);
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:d initialSpringVelocity:d options:UIViewAnimationOptionCurveEaseInOut animations:^{
        imageView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        [_swipeView setHidden:NO];
        
        NSLog(@"swipeView.frame = %@", NSStringFromCGRect(_swipeView.frame));
        
        [_swipeView scrollToPage:_index duration:0.0];
        
        NSLog(@"imageView.frame = %@", NSStringFromCGRect(imageView.frame));
        
        [imageView setHidden:YES];
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    CGPoint point = self.view.center;
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        imageView.center = point;
//        
//    } completion:^(BOOL finished) {
//        
//        imageView.clipsToBounds = false;
//        [self goBig];
//        
//    }];
}

-(void)backOnClick{
    [self didbig];
}

-(void)didbig{
    [imageView setHidden:NO];
    [_swipeView setHidden:YES];
    CGFloat d = smallSize.height / bigSize.height;
    if (smallSize.width > smallSize.height) {
        d = smallSize.width / bigSize.width;
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        imageView.layer.transform = CATransform3DMakeScale(d,d,1.0);
        imageView.clipsToBounds = YES;
    } completion:^(BOOL finished) {
        [self goSmall];
    }];
}

-(void)goSmall{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (wframe.size.width != 0) {
            imageView.frame = wframe;
        }else{
            imageView.frame = zframe;
        }
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

@end

