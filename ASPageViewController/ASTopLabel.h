//
//  ASTopLabel.h
//  ASPageViewController-OC
//
//  Created by haohao on 16/9/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ASTopLabel;
@protocol ASTopLabelDelegate <NSObject>
//点击label的时候，移动到相应的试图控制器
-(void)didClickTopItemScrollToVC:(ASTopLabel *)item;

@end
@interface ASTopLabel : UILabel
//正常状态的字体，默认的是15
@property (nonatomic, assign) CGFloat normalTitleSize;
//选中的时候的字体。默认是18
@property (nonatomic, assign) CGFloat selectedTilteSize;
//正常的字体颜色
@property (nonatomic, strong) UIColor *normalTitleColor;
//选中的时候的字体颜色
@property (nonatomic, strong) UIColor *selectedTitleColor;

@property (nonatomic, assign) BOOL selected;


//设置rate
@property (nonatomic, assign) CGFloat rate;
//代理
@property (nonatomic, weak) id <ASTopLabelDelegate>delegate;

-(void)selectedLabelNOAnimation;
-(void)deselectedlabelNOAnimation;
@end
