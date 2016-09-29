//
//  ASTopLine.m
//  ASPageViewController-OC
//
//  Created by haohao on 16/9/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASTopLine.h"
#import "ASPageViewConst.h"
@interface ASTopLine()
{
    CGFloat _progress;
    int _index;
    CGFloat _contentOffSetX;
    //空格的宽度
    CGFloat _spaceWidth;
    //加一个字段用来区分是滑动还是点击动
    BOOL _isClick;
    NSInteger _toInerIndex;
}
@end
@implementation ASTopLine
//手动滑动的时候执行的方法
-(void)setwithCurrentIndex:(int)index WithContentOffSetX:(CGFloat) setX WithTopSpaceWidth:(CGFloat)spaceWidth
{
    _isClick = NO;
    _index = index;
    _contentOffSetX = setX;
    if (_index == 0 && (_contentOffSetX - kScreenWidth) < 0) {
        return;
    }
    [self setNeedsDisplay];
}

//点击的时候执行的方法
-(void)clickLabelWithCurrentIndex:(int)index withContentOffSetX:(CGFloat)offSetX WithTopSpaceWidth:(CGFloat)spaceWidth withToIndex:(int)toIndex
{
    _isClick = YES;
    _index = index;
    _contentOffSetX = offSetX;
    _toInerIndex = toIndex;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //为了这里的绘图方便，还是直接传递每一个item的frame吧，这边就好计算了
    
    //获得当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //求出两个端点的坐标
    CGFloat constY = self.frame.size.height / 2;
    //比例 = （偏移量 - 屏幕宽度） / 屏幕宽度
    CGFloat ratio = (_contentOffSetX - kScreenWidth) / kScreenWidth;
    //请求需要走的路程
    CGRect currentFrame = [self.itemFrames[_index] CGRectValue];
    CGFloat currentWidth = [self.itemFrames[_index] CGRectValue].size.width;
    CGFloat currentX = currentFrame.origin.x;
    int nextIndex = 0;
    CGFloat startX = 0.0;
    CGFloat endX = 0.0;
    if (_isClick) {
        CGRect clickCurrentFrame = [self.itemFrames[_index] CGRectValue];
        CGRect clickToframe = [self.itemFrames[_toInerIndex] CGRectValue];
        CGFloat clickCurrentX = clickCurrentFrame.origin.x;
        CGFloat clickToX = clickToframe.origin.x;
        CGFloat clickCurrentWidth = clickCurrentFrame.size.width;
        CGFloat clickToWidth = clickToframe.size.width;
        if (ratio < 0) {
            startX = clickCurrentX - (clickToX - clickCurrentX) * ratio;
            endX = startX + clickCurrentWidth - (clickToWidth - clickCurrentWidth) * ratio;
        }else{
            startX = clickCurrentX + (clickToX - clickCurrentX) * ratio;
            endX = startX + clickCurrentWidth + (clickToWidth - clickCurrentWidth) * ratio;
        }
    }else{
        //先解决滑动的时候的问题
        if (_contentOffSetX - kScreenWidth < 0) {
            nextIndex = _index - 1 >= 0 ? _index - 1  : 0;
            CGFloat nextWidth = [self.itemFrames[nextIndex] CGRectValue].size.width;
            CGFloat nextX =[self.itemFrames[nextIndex] CGRectValue].origin.x;
            CGFloat currentFinX = [self.itemFrames[_index] CGRectValue].origin.x;
            //得到每一刻开始的X
            startX = currentFinX - (nextX- currentX) * ratio;
            //尾巴
            endX = startX + currentWidth - (nextWidth - currentWidth) * ratio;
        }else{
            nextIndex = _index + 1 < self.itemFrames.count ? _index + 1  : (int)self.itemFrames.count - 1;
            CGFloat nextWidth = [self.itemFrames[nextIndex] CGRectValue].size.width;
            CGFloat nextX = [self.itemFrames[nextIndex] CGRectValue].origin.x;
            //得到每一刻开始的X
            startX = currentX + (nextX - currentX) * ratio;
            //尾巴我们要保证在startX，然后加上一个长度就是当前的长度，然后再拿下一个长度-当前的长度，乘以相应的比率，是增加还是减少
            endX = startX + currentWidth + (nextWidth - currentWidth) * ratio;
        }

    }
    CGContextMoveToPoint(context, startX, constY);
    CGContextAddLineToPoint(context, endX, constY);
    CGContextSetLineWidth(context, self.frame.size.height);
    CGContextSetStrokeColorWithColor(context, self.color);
    CGContextStrokePath(context);
}
@end
