//
//  AlanLunboLayout.m
//  collectionViewLunbo
//
//  Created by LXY on 2021/6/2.
//

#import "AlanLunboLayout.h"

@implementation AlanLunboLayout

//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
//
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//    /*
//     if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal){
//     // 计算 CollectionView 的中点
//     CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
//     for (UICollectionViewLayoutAttributes *attrs in array){
//     // 计算 cell 中点的 x 值 与 centerX 的差值
//     CGFloat delta = ABS(centerX - attrs.center.x);
//     CGFloat scale = 1 - delta / self.collectionView.frame.size.width;
//     scale = 1;
//     attrs.transform = CGAffineTransformMakeScale(scale, scale);
//     }
//     }else{
//     CGFloat centerY = self.collectionView.contentOffset.y + self.collectionView.frame.size.height * 0.5;
//     for (UICollectionViewLayoutAttributes *attrs in array){
//     // 计算 cell 中点的 y 值 与 centerY 的差值
//     CGFloat delta = ABS(centerY - attrs.center.y);
//     CGFloat scale = 1 - delta / self.collectionView.frame.size.height;
//     scale = 1;
//     attrs.transform = CGAffineTransformMakeScale(scale, scale);
//     }
//     }
//     */
//    return array;
//}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}


  - (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
   
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);

    NSArray *layoutAtts = [super layoutAttributesForElementsInRect:rect];
    CGFloat minMargin = MAXFLOAT;
    CGFloat collectionViewCenterX = self.collectionView.frame.size.width * 0.5;
    CGFloat contentOffsetX = proposedContentOffset.x;
//    CGFloat contentOffsetX = self.collectionView.contentOffset.x;

    for (UICollectionViewLayoutAttributes *layoutAtt in layoutAtts) {
        
        CGFloat margin = layoutAtt.center.x - contentOffsetX - collectionViewCenterX;
        if (ABS(margin) < ABS(minMargin)) {
            minMargin = margin;
        }
    }

    proposedContentOffset.x += minMargin;
    
//    proposedContentOffset.x / self.collectionView.frame.size.width
    
    return proposedContentOffset;
}

@end
