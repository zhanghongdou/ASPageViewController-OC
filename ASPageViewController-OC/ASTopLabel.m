//
//  ASTopLabel.m
//  ASPageViewController-OC
//
//  Created by haohao on 16/9/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASTopLabel.h"

@interface ASTopLabel ()
{
    CGFloat _selectedRed, _selectedGreen, _selectedBlue, _selectedAlpha;
    CGFloat _normalRed, _normalGreen, _normalBlue, _normalAlpha;
}
@end

@implementation ASTopLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.normalTitleColor = [UIColor blackColor];
        self.selectedTitleColor = [UIColor blackColor];
        self.normalTitleSize = 15.0f;
        self.selectedTilteSize = 18.0f;
    }
    return self;
}

-(void)setRate:(CGFloat)rate
{
    _rate = rate;
    CGFloat r = _normalRed + (_selectedRed - _normalRed) * rate;
    CGFloat g = _normalGreen + (_selectedGreen - _normalGreen) * rate;
    CGFloat b = _normalBlue + (_selectedBlue - _normalBlue) * rate;
    CGFloat a = _normalAlpha + (_selectedAlpha - _normalAlpha) * rate;
    self.textColor = [UIColor colorWithRed:r green:g blue:b alpha:a];
    CGFloat minScale = self.normalTitleSize / self.selectedTilteSize;
    CGFloat trueScale = minScale + (1 - minScale)*rate;
    //选中和非选中的时候，字体不一样大的时候，就会出现放大缩小的动画
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}

//用于刚开始的时候的选中状态
-(void)selectedLabelNOAnimation
{
    self.rate = 1.0;
    _selected = YES;
}

//用于刚开始的时候的非选中状态
-(void)deselectedlabelNOAnimation
{
    self.rate = 0;
    _selected = NO;
}

-(void)setNormalTitleColor:(UIColor *)normalTitleColor
{
    _normalTitleColor = normalTitleColor;
    [normalTitleColor getRed:&_normalRed green:&_normalGreen blue:&_normalBlue alpha:&_normalAlpha];
}


-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    _selectedTitleColor = selectedTitleColor;
    [selectedTitleColor getRed:&_selectedRed green:&_selectedGreen blue:&_selectedBlue alpha:&_selectedAlpha];
}

//点击的时候调用协议方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickTopItemScrollToVC:)]) {
        [self.delegate didClickTopItemScrollToVC:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
