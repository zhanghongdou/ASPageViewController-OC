//
//  Header.h
//  ASPageViewController-OC
//
//  Created by haohao on 16/9/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define ASItemTitleColorSelected [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1]
#define ASItemTitleColorNormal   [UIColor colorWithRed:0 green:0 blue:0 alpha:1]
//  导航菜单栏的背景颜色
#define ASTopViewBGColor        [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0]
//默认的下划线的颜色
#define ASBottomLineColor              [UIColor redColor]
//设置默认的item的宽度
static CGFloat const ASItemWidth        = 65.0f;
//导航菜单栏的默认高度
static CGFloat const ASItemHeight       = 44.0f;
//  标题的尺寸(选中/非选中)
static CGFloat const ASItemTitleFontSelected = 18.0f;
static CGFloat const ASItemTitlefontNormal   = 15.0f;

//默认下划线的高度
static CGFloat const ASBottomLineHeight   = 2.0f;


//用于设置label的tag值
static CGFloat const ASTopLabelTag   = 8956;