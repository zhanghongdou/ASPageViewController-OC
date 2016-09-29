//
//  ASTopLine.h
//  ASPageViewController-OC
//
//  Created by haohao on 16/9/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASTopLine : UIView
//设置下划线的颜色
@property (nonatomic, assign) CGColorRef color;
//用来显示设置绘图的位置，形成动画
@property (nonatomic, assign) CGFloat progress;
//每一次滑动结束之后下划线应该在的位置
@property (nonatomic, strong) NSArray *itemFrames;
-(void)setwithCurrentIndex:(int)index WithContentOffSetX:(CGFloat) setX WithTopSpaceWidth:(CGFloat)spaceWidth;
-(void)clickLabelWithCurrentIndex:(int)index withContentOffSetX:(CGFloat)offSetX WithTopSpaceWidth:(CGFloat)spaceWidth withToIndex:(int)toIndex;
@end
