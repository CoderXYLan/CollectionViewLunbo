//
//  ViewController.m
//  collectionViewLunbo
//
//  Created by LXY on 2021/6/2.
//

#import "ViewController.h"
#import "LunboCell.h"
#import "AlanLunboLayout.h"
#import "Masonry.h"

static NSString *const cellId = @"lunboId";
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSArray *sourceArray;
@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger currentIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *sourceArray = @[
        @{
            @"imageName" : @"1.jpeg"
        },
        @{
            @"imageName" : @"2.jpeg"
            
        },
        @{
            @"imageName" : @"3.jpeg"
            
        },
        
    ];
    _sourceArray = sourceArray;
    
    
    NSArray *dataArray = @[
     
        @{
            @"imageName" : @"3.jpeg"
            
        },
        @{
            @"imageName" : @"1.jpeg"
        },
        @{
            @"imageName" : @"2.jpeg"
        },
        @{
            @"imageName" : @"3.jpeg"
            
        },
        @{
            @"imageName" : @"1.jpeg"
        },
        
    ];
    
    self.dataArray = dataArray;
    
    AlanLunboLayout *flow = [[AlanLunboLayout alloc] init];
    CGFloat space = 20;
    flow.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, 120);
    flow.minimumLineSpacing = 20;
    flow.minimumInteritemSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 88, [UIScreen mainScreen].bounds.size.width - 2 * space, 120) collectionViewLayout: flow];
    self.collectionView.pagingEnabled = NO;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView.backgroundColor = [UIColor purpleColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
//    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[LunboCell class] forCellWithReuseIdentifier:cellId];
    [self.view addSubview:self.collectionView];
//    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    _pageControl = pageControl;
    pageControl.numberOfPages = self.sourceArray.count;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:pageControl];
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.collectionView.mas_bottom).offset(-5);
        make.centerX.mas_equalTo(self.collectionView.mas_centerX).offset(0);
    }];
    [self addTimer];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LunboCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.contentView.layer.cornerRadius = 20;
    cell.contentView.backgroundColor = [UIColor grayColor];
    NSDictionary *tempDict = self.dataArray[indexPath.row];
    cell.dataDict = tempDict;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        CGFloat space = 20;
        CGFloat pageWidth = [UIScreen mainScreen].bounds.size.width - space * 2 + 20;
        // 第几张图片
//        NSInteger index = (int)(scrollView.contentOffset.x / pageWidth + 0.5) + 1;
        NSInteger index = (int)(scrollView.contentOffset.x / pageWidth) ;
    self.currentIndex = index;
    if (scrollView.contentOffset.x > pageWidth * (self.dataArray.count - 1)) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }else if(scrollView.contentOffset.x < 1) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.dataArray.count - 2  inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
    
}
//
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //[_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentMiddleIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];不会触发此方法
    CGFloat space = 20;
    CGFloat pageWidth = [UIScreen mainScreen].bounds.size.width - space * 2 + 20;
    // 第几张图片
    NSInteger index = (int)(scrollView.contentOffset.x / pageWidth) ;
    
//    self.pageControl.currentPage = index /self.dataArray.count;
    if (index == 0) {
        self.pageControl.currentPage = self.sourceArray.count - 1;
    }else if(index == self.dataArray.count - 1){
        self.pageControl.currentPage = 0;
        
    }else {
        self.pageControl.currentPage = index - 1;
       
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
   
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGFloat space = 20;
    CGFloat pageWidth = [UIScreen mainScreen].bounds.size.width - space * 2 + 20;
    // 第几张图片
    NSInteger index = (int)(scrollView.contentOffset.x / pageWidth) ;

//    self.pageControl.currentPage = index /self.dataArray.count;
    if (index == 0) {
        self.pageControl.currentPage = self.sourceArray.count - 1;
    }else if(index == self.dataArray.count - 1){
        self.pageControl.currentPage = 0;

    }else {
        self.pageControl.currentPage = index - 1;

    }

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage{
    
    //分页动画
    NSInteger currentMiddleIndex= [_collectionView indexPathForItemAtPoint:CGPointMake(_collectionView.contentOffset.x + self.collectionView.frame.size.width/2, 0)].row;
    
    CGFloat space = 20;
    CGFloat pageWidth = [UIScreen mainScreen].bounds.size.width - space * 2 + 20;
    NSInteger index = (int)(self.collectionView.contentOffset.x / pageWidth) ;
    
    
    if (index == self.dataArray.count - 1) {
        currentMiddleIndex = 1;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentMiddleIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    
    NSIndexPath * nextIndexPath = [NSIndexPath indexPathForRow:(currentMiddleIndex + 1) inSection:0];
    [_collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end
