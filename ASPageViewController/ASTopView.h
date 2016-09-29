//
//  ASTopView.h
//  ASPageViewController-OC
//
//  Created by haohao on 16/9/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASTopLabel.h"
#import "ASTopLine.h"
#import "ASPageViewConst.h"

//设置一个代理，在label的代理方法里面之心，下部VC的转换
@protocol ASTopViewDelegate <NSObject>

-(void)scrollTopDestinationVC:(NSInteger)index;
@end
@interface ASTopView : UIView

typedef NS_ENUM(NSUInteger, ASTopViewStyle) {
    ASTopViewStyleLine,//有下划线的时候
    ASTopViewStyleNOLine,//没有下划线的时候
};
//背景的颜色
@property (nonatomic, strong) UIColor *topBackColor;
//顶部试图的style
@property (nonatomic, assign) ASTopViewStyle style;
//设置每一个Item的字体名字
@property (nonatomic, copy) NSString *itemTitleName;
//下划线的颜色
@property (nonatomic, strong) UIColor *lineColor;

//非选中的时候的字体大小
@property (nonatomic, assign) CGFloat normalSize;
//选中的字体大小
@property (nonatomic, assign) CGFloat selectedSize;
//非选中状态的字体颜色
@property (nonatomic, strong) UIColor *normalItemTitleColor;
//选中状态的字体颜色
@property (nonatomic, strong) UIColor *selectItemTitleColor;

//每一个Item的宽度
@property (nonatomic, strong) NSArray *itemWidthArray;

//需要添加的空格的宽度
@property (nonatomic, assign) CGFloat topSpaceWidth;

@property (nonatomic, weak) id<ASTopViewDelegate> delegate;

-(void)hhhhhWithCurrent:(int)curindex withconX:(CGFloat)XXX;
-(id)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles;
-(void)clickLabelMethod:(int)currentIndex withContentOffSetX:(CGFloat)contentOffSetX withToIndex:(int)toIndex;
@end
