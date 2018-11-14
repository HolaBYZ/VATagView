//
//  VATagView.h
//  NTSignMaster
//
//  Created by 栗子哇 on 2018/10/10.
//  Copyright © 2018 NineTonTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VATagViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VATagView : UIView

@property (nonatomic, weak) id<VATagViewDelegate> delegate;

@property (nonatomic, weak) id<VATagViewDataSource> dataSource;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) BOOL isInSearch;

- (void)reloadData;

- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPathArray;

@end

NS_ASSUME_NONNULL_END
