//
//  LunboCell.m
//  collectionViewLunbo
//
//  Created by LXY on 2021/6/2.
//

#import "LunboCell.h"

@interface LunboCell ()
@property (nonatomic, strong)UIImageView *imageV;
@end

@implementation LunboCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    _imageV = imageV;
    [self.contentView addSubview:imageV];
}

- (void)setDataDict:(NSDictionary *)dataDict{
    self.imageV.image = [UIImage imageNamed:dataDict[@"imageName"]];
}

@end
