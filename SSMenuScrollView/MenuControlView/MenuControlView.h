//
//  MenuControlView.h
//  SSMenuScrollView
//
//  Created by feng on 2017/8/23.
//  Copyright © 2017年 YY. All rights reserved.
//


#import <UIKit/UIKit.h>

@class MenuControlView;
@protocol MenuControlViewDeleagte <NSObject>

@optional

@required

- (void)menuControlViewDeleagte:(MenuControlView *)MenuControlViewDeleagte index:(NSInteger )index;

@end

@interface MenuControlView : UIView

@property (nonatomic,assign) id<MenuControlViewDeleagte> delegate;
@property (nonatomic,assign) NSInteger maxCol; // 列
@property (nonatomic,assign) NSInteger maxRow; // 行
@property (strong, nonatomic) NSArray *dataArray;

- (instancetype)initWithFrame:(CGRect)frame withmacCol:(NSInteger )maxCol maxRow:(NSInteger )maxRow;
@end
