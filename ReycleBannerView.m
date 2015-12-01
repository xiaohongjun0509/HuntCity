//
//  ReycleCollectionView.m
//  HuntCity
//
//  Created by hongjunxiao on 15/11/25.
//  Copyright © 2015年 XHJ. All rights reserved.
//


#define RANDOM (arc4random() % 255) / 255.0

#define RANDOMCOLOR [UIColor colorWithRed:RANDOM green:RANDOM blue:RANDOM alpha:1]

#import "ReycleBannerView.h"

@interface ReycleBannerView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *wrappedDataSource;


@end

@implementation ReycleBannerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self customSubView];
        [self customPageControl];
        
    }
    return self;
}


- (void)customSubView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetWidth(self.frame));
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:_collectionView];
}


- (void)customPageControl{
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    pageControl.bounds = CGRectMake(0, 0, self.bounds.size.width, 20);
    pageControl.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height - 10);
    [self addSubview:pageControl];
    _pageControl = pageControl;
}

- (void)setImageArray:(NSArray *)imageArray{
    NSInteger count = imageArray.count;
    if (count == 0) {
        return;
    }
//    _imageArray = imageArray;
    
    if(self.needRecycle){//开启了循环滚动
        if (count == 1) {
            self.wrappedDataSource = [imageArray mutableCopy];
        }else{
            NSMutableArray *mArray = [NSMutableArray arrayWithArray:imageArray];
            [mArray insertObject:imageArray[0] atIndex:mArray.count - 1];
            [mArray insertObject:imageArray[imageArray.count - 1] atIndex:0];
            self.wrappedDataSource = mArray;
        }
    }else{
        self.wrappedDataSource = [imageArray mutableCopy];
    }
    [self.collectionView reloadData];
    
    if (self.needRecycle && imageArray.count > 1) {
        [self.collectionView setNeedsLayout];
        [self.collectionView layoutIfNeeded];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        self.pageControl.currentPage = 1;
    }
    
    if (self.preSelectedIndex != 0 && self.preSelectedIndex < imageArray.count) {
        [self.collectionView setNeedsLayout];
        [self.collectionView layoutIfNeeded];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.preSelectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    self.pageControl.numberOfPages = imageArray.count;
    self.pageControl.currentPage = 0;
    
}

#pragma mark - UICollectionView dataSource and delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = RANDOMCOLOR;
    return  cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.collectionView.bounds.size;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.wrappedDataSource.count;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = scrollView.contentOffset.x / self.collectionView.bounds.size.width;
}


//Animation为YES的时候才会调用这个方法。http://blog.lessfun.com/blog/2013/12/06/detect-uiscrollview-did-end-scrolling-animate/
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (currentPage == 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.wrappedDataSource.count - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        self.pageControl.currentPage = self.wrappedDataSource.count - 2;
    }
    if (currentPage == self.wrappedDataSource.count - 2) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        self.pageControl.currentPage = 0;
    }
}




@end
