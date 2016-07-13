//
//  HJ_KeyboardEmjView.m
//  YueAi
//
//  Created by 郭洪军 on 7/12/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "HJ_KeyboardEmjView.h"

#pragma mark - CLASS:EmojiCell
@interface EmojiCell : UICollectionViewCell

@property (nonatomic, weak) UILabel *emojiLabel;

@end

@implementation EmojiCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UILabel* emojiLabel = [[UILabel alloc] init];
        emojiLabel.userInteractionEnabled = YES;
        emojiLabel.font = [UIFont systemFontOfSize:30];
        [self.contentView addSubview:self.emojiLabel = emojiLabel];
        [self.emojiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
    }
    
    return self;
}

@end

#pragma mark - CLASS:EmojiKeyboardView

@interface HJ_KeyboardEmjView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray* emojiArray;
@property (nonatomic, weak)   UICollectionView* collectionView;
@property (nonatomic, weak)   UIPageControl* pageControl;

@end

@implementation HJ_KeyboardEmjView

- (instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH / 2)]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"plist"];
        self.emojiArray = [NSArray arrayWithContentsOfFile:path];
        
        [self createView];
    }
    
    return self;
}

- (void)createView {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(10);
    }];
}

#pragma mark - getter methods
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 20)/6, (SCREEN_WIDTH/2-30)/3);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 20, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        [collectionView registerClass:[EmojiCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:_collectionView = collectionView];
    }
    
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        UIPageControl* pageControl = [[UIPageControl alloc] init];
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        pageControl.numberOfPages = self.emojiArray.count;
        pageControl.enabled = NO;
        [self addSubview:_pageControl = pageControl];
    }
    
    return _pageControl;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x/SCREEN_WIDTH;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.emojiArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.emojiArray[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EmojiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.emojiLabel.text = self.emojiArray[indexPath.section][indexPath.row];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = self.emojiArray[indexPath.section][indexPath.row];
    if ([text isEqualToString:@"🔙"]) {
        [self.inputDelegate deleteBackward];
    } else {
        [self.inputDelegate insertText:text];
    }
}

@end

