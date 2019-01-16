//
//  MenuControlView.m
//  SSMenuScrollView
//
//  Created by feng on 2017/8/23.
//  Copyright © 2017年 YY. All rights reserved.
//


#import "MenuControlView.h"
#import "CustomerScrollViewModel.h"
#import "NJHomeMarketCollectionViewCell.h"
//轮播间隔
static CGFloat ScrollInterval = 3.0f;

@interface MenuControlView()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout>{

    CGRect _frame;
    NSTimer *_timer;

}
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UICollectionView *collectionView;
/// 一页可容纳的最多Item数目
@property (nonatomic,assign) NSInteger numberOfSinglePage;
@end

@implementation MenuControlView


- (instancetype)initWithFrame:(CGRect)frame withmacCol:(NSInteger )maxCol maxRow:(NSInteger )maxRow
{
    if (self = [super initWithFrame:frame]) {
        _frame = frame;
        _frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        _maxRow = maxRow==0?1:maxRow;
        _maxCol = maxCol==0?1:maxCol;
    }
    return self;
}

- (void)setViews
{
    //添加到主视图
    [self addSubview:self.collectionView];
    self.numberOfSinglePage = _maxCol * _maxRow;
    
    NSInteger pageCount = _dataArray.count / self.numberOfSinglePage;
    if (_dataArray.count % self.numberOfSinglePage > 0) {
        pageCount += 1;
    }
    self.pageControl.numberOfPages = pageCount;//指定页面个数
    self.pageControl.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
    [self addSubview:self.pageControl];
    _timer = [NSTimer scheduledTimerWithTimeInterval:ScrollInterval target:self selector:@selector(showNext) userInfo:nil repeats:true];
}

- (void)setDataArray:(NSArray *)dataArray{
    
    _dataArray = dataArray;
    [self setViews];
    [self.collectionView reloadData];
    
}
#pragma mark 轮播方法
//自动显示下一个
- (void)showNext {
    int page = (int)_collectionView.contentOffset.x / self.frame.size.width;
    page++;
    if (page < self.pageControl.numberOfPages)
    {
        [_collectionView setContentOffset:CGPointMake(page * self.frame.size.width, 0) animated:YES];
        self.pageControl.currentPage = page;
    }else if (page == self.pageControl.numberOfPages){
        [_collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
        self.pageControl.currentPage = 0;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
}
//自动轮播结束
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
}


#pragma mark - UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NJHomeMarketCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NJHomeMarketCollectionViewCell" forIndexPath:indexPath];
    CustomerScrollViewModel * model = _dataArray[indexPath.row];
    cell.titleLab.text = model.name;
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (collectionView.frame.size.width - 40)/ _maxCol;
    CGFloat height = collectionView.frame.size.height/ _maxRow;
    return CGSizeMake(width, height);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(menuControlViewDeleagte:index:)]) {
        [_delegate menuControlViewDeleagte:self index:indexPath.row];
    }
}


- (void)pageChange:(UIPageControl *)pageControl{
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, _frame.size.height-10, _frame.size.width, 10);
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.backgroundColor = [UIColor whiteColor];
        [_pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置滚动方向为垂直滚动，说明方块是从左上到右下的布局排列方式
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 20;
        //创建容器视图
        CGRect frame = CGRectMake(0, 0, _frame.size.width, _frame.size.height-10);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame
                                                              collectionViewLayout:layout];
        _collectionView.delegate = self;//设置代理
        _collectionView.dataSource = self;//设置数据源
        _collectionView.backgroundColor = [UIColor whiteColor];//设置背景，默认为黑色
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"NJHomeMarketCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NJHomeMarketCollectionViewCell"];
        
    }
    return _collectionView;
}
-(void)dealloc{
    [_timer invalidate];
}
@end
