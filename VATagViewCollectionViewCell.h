//
//  VATagViewCollectionViewCell.h
//  NTSignMaster
//
//  Created by 栗子哇 on 2018/10/10.
//  Copyright © 2018 NineTonTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CreateOrderModel , CreateOrderCombosModel , CreateOrderAdditionalModel ,CreateOrderRemarkModel;

NS_ASSUME_NONNULL_BEGIN

@interface VATagViewCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) CreateOrderModel *orederModel;

@property (nonatomic, strong) CreateOrderCombosModel *combosModel;

@property (nonatomic, strong) CreateOrderAdditionalModel *additionalModel;

@property (nonatomic , strong) CreateOrderRemarkModel *remarkModel;

@property (nonatomic, strong) UILabel *tagLabel;

@property (nonatomic, assign) BOOL isInSearch;

+ (CGSize) getSizeWithContent:(NSString *) content maxWidth:(CGFloat)maxWidth customHeight:(CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
