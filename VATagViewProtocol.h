//
//  VATagView.h
//  NTSignMaster
//
//  Created by 栗子哇 on 2018/10/10.
//  Copyright © 2018 NineTonTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VATagView;

@protocol VATagViewDataSource <NSObject>

@required
- (NSInteger)numOfItemsFortagView:(VATagView *)tagView;

- (id )tagView:(VATagView *)tagView titleForItemAtIndex:(NSInteger)index;

@end

@protocol VATagViewDelegate <NSObject>

@optional

- (void)tagView:(VATagView *)tagView didSelectedItemAtIndex:(NSInteger)index;

/**
 使用frame布局实现一下代理方法获得填充数据后的正确的高度(高度已内部调整)

 @param tagView tagView
 @param height 高度
 */
- (void)tagView:(VATagView *)tagView heightUpdated:(CGFloat)height;

@end
