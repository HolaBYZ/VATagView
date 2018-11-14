//
//  VATagView.m
//  NTSignMaster
//
//  Created by 栗子哇 on 2018/10/10.
//  Copyright © 2018 NineTonTech. All rights reserved.
//

#import "VATagView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "VATagViewCollectionViewCell.h"
#import "CreateOrderCombosModel.h"
#import "CreateOrderModel.h"
#import "CreateOrderAdditionalModel.h"
#import "CreateOrderRemarkModel.h"

static CGFloat kDefaultCellHeight = 32;

@interface VATagView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

static NSString *tagCell_ID = @"VATagViewCollectionViewCell";
@implementation VATagView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self addSubview:self.collectionView];
        self.cellHeight = kDefaultCellHeight;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        self.cellHeight = kDefaultCellHeight;
    }
    return self;
}

#pragma mark - Layout
/** 适应布局变换 */
- (void) layoutSubviews{
    [super layoutSubviews];
    UICollectionViewLeftAlignedLayout *layout = (UICollectionViewLeftAlignedLayout *)_collectionView.collectionViewLayout;
    [layout invalidateLayout];
    
    _collectionView.frame = self.bounds;
    if (!CGSizeEqualToSize(self.bounds.size, [self intrinsicContentSize])) {
        [self invalidateIntrinsicContentSize];
    }
    CGFloat height = _collectionView.collectionViewLayout.collectionViewContentSize.height;
    if (height != 0 && height != self.bounds.size.height) {
        CGRect frame = self.frame;
        frame.size.height = height;
        self.frame = frame;
        _collectionView.frame = self.bounds;
        if ([self.delegate respondsToSelector:@selector(tagView:heightUpdated:)]) {
            [self.delegate tagView:self heightUpdated:height];
        }
    }
}

- (CGSize)intrinsicContentSize{
    NTLog(@"height---%f",_collectionView.collectionViewLayout.collectionViewContentSize.height);
    return _collectionView.collectionViewLayout.collectionViewContentSize;
}

#pragma mark - Actions
- (void)reloadData {
    [self.collectionView reloadData];
}

- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPathArray{
    [self.collectionView reloadItemsAtIndexPaths:indexPathArray ];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource numOfItemsFortagView:self];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VATagViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tagCell_ID forIndexPath:indexPath];
    [cell setIsInSearch:self.isInSearch];
    id contents = [self.dataSource tagView:self titleForItemAtIndex:indexPath.row];
    if ([contents isKindOfClass:[NSString class]]) {
        cell.content = (NSString *)contents;
    }else if ([contents isKindOfClass:[CreateOrderModel class]]){
        CreateOrderModel *model = (CreateOrderModel *)contents;
        [cell setOrederModel: model];
    }else if ([contents isKindOfClass:[CreateOrderCombosModel class]]){
        CreateOrderCombosModel *model = (CreateOrderCombosModel *)contents;
        cell.combosModel = model;
    }else if ([contents isKindOfClass:[CreateOrderAdditionalModel class]]){
        CreateOrderAdditionalModel *model = (CreateOrderAdditionalModel *)contents;
        cell.additionalModel = model;
    }else if ([contents isKindOfClass:[CreateOrderRemarkModel class]]){
        CreateOrderRemarkModel *model = (CreateOrderRemarkModel *)contents;
        cell.remarkModel = model;
    }
    cell.backgroundView = [self drawConnerView:15. rect:cell.bounds backgroudColor:cell.backgroundColor borderColor:[UIColor whiteColor]];
    return cell;
}

#pragma mark - UI_Style
/** 绘画圆角 解决卡顿*/
-(UIView *)drawConnerView:(CGFloat)cornerRadius rect:(CGRect)frame backgroudColor:(UIColor *)backgroud_color borderColor:(UIColor *)borderColor{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGRect bounds = CGRectInset(frame, 0, 0);
    CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), cornerRadius);
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMinY(bounds), cornerRadius);
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMinX(bounds), CGRectGetMinY(bounds), cornerRadius);
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMinX(bounds), CGRectGetMaxY(bounds), cornerRadius);
    layer.path = pathRef;
    CFRelease(pathRef);
    layer.strokeColor = [borderColor CGColor];
    layer.fillColor = backgroud_color.CGColor;
    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
    [roundView.layer insertSublayer:layer atIndex:0];
    roundView.backgroundColor = UIColor.clearColor;
    return roundView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tagView:didSelectedItemAtIndex:)]) {
        [self.delegate tagView:self didSelectedItemAtIndex:indexPath.row];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    id content = [self.dataSource tagView:self titleForItemAtIndex:indexPath.row];
    NSString *str;
    if ([content isKindOfClass:[NSString class]]) {
        str = (NSString *)content;
    }else if ([content isKindOfClass:[CreateOrderModel class]]){
        CreateOrderModel *model = (CreateOrderModel *)content;
        str = model.title;
    }else if ([content isKindOfClass:[CreateOrderCombosModel class]]){
        CreateOrderCombosModel *model = (CreateOrderCombosModel *)content;
        str = model.title;
    }else if ([content isKindOfClass:[CreateOrderAdditionalModel class]]){
        CreateOrderAdditionalModel *model = (CreateOrderAdditionalModel *)content;
        str = model.title;
    }else if ([content isKindOfClass:[CreateOrderRemarkModel class]]){
        CreateOrderRemarkModel *model = (CreateOrderRemarkModel *)content;
        str = model.title;
    }
    return [VATagViewCollectionViewCell getSizeWithContent: str maxWidth:_collectionView.frame.size.width customHeight:self.cellHeight];
}

#pragma mark - Lazy loading
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, NT_SCREEN_WIDTH - 30, CGRectGetHeight(self.frame)) collectionViewLayout:[[UICollectionViewLeftAlignedLayout alloc] init]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[VATagViewCollectionViewCell class] forCellWithReuseIdentifier:tagCell_ID];
    }
    return _collectionView;
}


@end
