//
//  ASPageViewController.h
//  ASPageViewController-OC
//
//  Created by haohao on 16/9/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASPageViewConst.h"
#import "ASTopView.h"
@interface ASPageViewController : UIViewController
//顶部View两边的空间,比如你使用模态进入的时候，可以空出一段距离设置返回按钮等
@property (nonatomic, assign) CGFloat sideBothWidth;
/**
 *  给一个数组用来设置各个item的宽度
 */
@property(nonatomic, strong) NSArray *itemWidthArray;
/**
 *  一键设置item的宽度
 */
@property (nonatomic, assign) CGFloat itemWidth;

//设置顶部试图的style
@property (nonatomic, assign) ASTopViewStyle style;

//设置每一个Item的字体名字
@property (nonatomic, copy) NSString *titleName;
//下划线的颜色
@property (nonatomic, strong) UIColor *lineColor;

//非选中的时候的字体大小
@property (nonatomic, assign) CGFloat normalSize;
//选中的字体大小
@property (nonatomic, assign) CGFloat selectedSize;
//非选中状态的字体颜色
@property (nonatomic, strong) UIColor *normalTitleColor;
//选中状态的字体颜色
@property (nonatomic, strong) UIColor *selectTitleColor;
//上部View的背景色
@property (nonatomic, strong) UIColor *topViewBackGroundColor;
-(id)initWithViewControllerClasses:(NSArray<Class> *)classes andTitles:(NSArray <NSString *> *)titles;
@end
