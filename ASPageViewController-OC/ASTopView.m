//
//  SSTopView.m
//  SSPageViewController-OC
//
//  Created by haohao on 16/9/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASTopView.h"

@interface ASTopView()<ASTopLabelDelegate>
{
    //title数组
    NSArray *_titlesArray;
    UIScrollView *_scrollView;
    //下划线View
    ASTopLine *_bottomLine;
    NSMutableArray *_eachItemFrameArray;
    //需要设置的空格的大小
    CGFloat _addSpace;
    //用来保存当前所在的label
    ASTopLabel *_selectLabel;
    
    //设置一个数组存储所有的label
    NSMutableArray *_allLabelArray;
    //设置一个保存上一次的label
    ASTopLabel *_lastLabel;
}
@end

@implementation ASTopView

-(id)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles
{
    if (self = [super initWithFrame:frame]) {
        //        self.backgroundColor = [UIColor whiteColor];
        _allLabelArray = [NSMutableArray array];
        _titlesArray = [NSArray arrayWithArray:titles];
        _eachItemFrameArray = [NSMutableArray array];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //创建View上面的ScrollerView
    [self creatScrollView];
    //创建scrollView上面的每一个Item的frame
    [self creatItem];
    [self creatWidthStyle];
    //创建上面的每一个label
    [self creatItemLabel];
}

//MARK:创建View上面的ScrollerView
-(void)creatScrollView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator =NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.scrollsToTop = NO;
    if (self.topBackColor) {
        _scrollView.backgroundColor = self.topBackColor;
    }
    [self addSubview:_scrollView];
}

-(void)creatWidthStyle
{
    switch (self.style) {
        case ASTopViewStyleLine:
            //创建下划线的view
            [self creatBottomLine];
            break;
        case ASTopViewStyleNOLine:
            
            break;
        default:
            break;
    }
}

-(void)creatBottomLine
{
    //宽度设置为和scrollView的contentsize相等
    _bottomLine = [[ASTopLine alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 2, _scrollView.contentSize.width, ASBottomLineHeight)];
    _bottomLine.backgroundColor = [UIColor whiteColor];
    _bottomLine.color = self.lineColor.CGColor;
    //    有了这个宽度之后我们就来分配的每一个item的frame
    _bottomLine.itemFrames = _eachItemFrameArray;
    [_scrollView addSubview:_bottomLine];
    [_bottomLine setwithCurrentIndex:0 WithContentOffSetX:kScreenWidth WithTopSpaceWidth:self.topSpaceWidth];
}

//点击label的时候执行的方法
-(void)clickLabelMethod:(int)currentIndex withContentOffSetX:(CGFloat)contentOffSetX withToIndex:(int)toIndex
{
    [_bottomLine clickLabelWithCurrentIndex:currentIndex withContentOffSetX:contentOffSetX WithTopSpaceWidth:self.topSpaceWidth withToIndex:toIndex];
    //下面是用来操作上面的label的状态的
    NSInteger currentTag = currentIndex + ASTopLabelTag;
    NSInteger toTag = ASTopLabelTag + toIndex;
    if ((contentOffSetX - kScreenWidth) != 0) {
        ASTopLabel *currentLabel = (ASTopLabel *)[self viewWithTag:currentTag];
        ASTopLabel *nextlabel = (ASTopLabel *)[self viewWithTag:toTag];
        _selectLabel = nextlabel;
        _lastLabel = currentLabel;
        //求出rate
        CGFloat rate = (fabs(contentOffSetX - kScreenWidth)) / kScreenWidth;
        
        for (ASTopLabel *label in _allLabelArray) {
            if (label == currentLabel || label == nextlabel) {
                
            }else{
                label.rate = 0;
            }
        }
        currentLabel.rate = 1 - rate;
        nextlabel.rate = rate;
    }else{
        ASTopLabel *currentLabel = (ASTopLabel *)[self viewWithTag:currentTag];
        ASTopLabel *nextlabel = (ASTopLabel *)[self viewWithTag:toTag];
        _selectLabel = nextlabel;
        _lastLabel = currentLabel;
        for (ASTopLabel *label in _allLabelArray) {
            if (label == currentLabel || label == nextlabel) {
                
            }else{
                label.rate = 0;
            }
        }
    }
    if ((contentOffSetX - kScreenWidth) == 0 && _lastLabel.tag - ASTopLabelTag != currentIndex) {
        _selectLabel.rate = 1;
        _lastLabel.rate = 0;
    }
    [self refreshCurrenrItemToCenter];
}

//手动滑动的时候执行的方法
-(void)hhhhhWithCurrent:(int)curindex withconX:(CGFloat)XXX
{
    [_bottomLine setwithCurrentIndex:curindex WithContentOffSetX:XXX WithTopSpaceWidth:self.topSpaceWidth];
    //下面是用来操作上面的label的状态的
    NSInteger currentTag = curindex + ASTopLabelTag;
    if ((XXX - kScreenWidth) < 0) {
        ASTopLabel *currentLabel = (ASTopLabel *)[self viewWithTag:currentTag];
        ASTopLabel *nextlabel = (ASTopLabel *)[self viewWithTag:currentTag - 1];
        _selectLabel = nextlabel;
        _lastLabel = currentLabel;
        //求出rate
        CGFloat rate = (fabs(XXX - kScreenWidth)) / kScreenWidth;
        for (ASTopLabel *label in _allLabelArray) {
            if (label == currentLabel || label == nextlabel) {
                
            }else{
                label.rate = 0;
            }
        }
        currentLabel.rate = 1 - rate;
        nextlabel.rate = rate;
    }
    if ((XXX - kScreenWidth) > 0) {
        ASTopLabel *currentLabel = (ASTopLabel *)[self viewWithTag:currentTag];
        ASTopLabel *nextlabel = (ASTopLabel *)[self viewWithTag:currentTag + 1];
        //去最后一个
        if (curindex == self.itemWidthArray.count - 1) {
            _selectLabel = (ASTopLabel *)[self viewWithTag:self.itemWidthArray.count - 1 + ASTopLabelTag];
        }else{
            _selectLabel = nextlabel;
        }
        _lastLabel = currentLabel;
        //求出rate
        CGFloat rate = (fabs(XXX - kScreenWidth)) / kScreenWidth;
        
        for (ASTopLabel *label in _allLabelArray) {
            if (label == currentLabel || label == nextlabel) {
                
            }else{
                label.rate = 0;
            }
        }
        currentLabel.rate = 1 - rate;
        nextlabel.rate = rate;
    }
    if ((XXX - kScreenWidth) == 0 && _lastLabel.tag - ASTopLabelTag != curindex) {
        _selectLabel.rate = 1;
        _lastLabel.rate = 0;
    }
    [self refreshCurrenrItemToCenter];
}

//MARK: 创建ScrollView上面的item
-(void)creatItem
{
    //设置每一个item的frame
    CGFloat max = 0.0;
    for (int i = 0; i < self.itemWidthArray.count; i++) {
        max += [self.itemWidthArray[i] floatValue];
    }
    if (max < kScreenWidth) {
        //        有空格
        //得出空格的大小
        _addSpace = (kScreenWidth - max) / (self.itemWidthArray.count + 1);
        for (int i = 0; i < self.itemWidthArray.count; i++) {
            CGFloat X = 0.0;
            for (int j = 0; j < i; j++) {
                X = X +[self.itemWidthArray[j] floatValue];
            }
            CGRect rect = CGRectMake(X + _addSpace * (i + 1), 0, [self.itemWidthArray[i] floatValue], ASBottomLineHeight);
            [_eachItemFrameArray addObject:[NSValue valueWithCGRect:rect]];
        }
    }else{
        //这个时候就没有空格
        for (int i = 0; i < self.itemWidthArray.count; i++) {
            CGFloat X = 0.0;
            for (int j = 0; j < i; j++) {
                X += [self.itemWidthArray[j] floatValue];
            }
            CGRect rect = CGRectMake(X, 0, [self.itemWidthArray[i] floatValue], ASBottomLineHeight);
            [_eachItemFrameArray addObject:[NSValue valueWithCGRect:rect]];
        }
    }
    
    _scrollView.contentSize = CGSizeMake([_eachItemFrameArray.lastObject CGRectValue].origin.x + [self.itemWidthArray.lastObject floatValue] + _addSpace, 0);
}
//创建上面的每一个label
-(void)creatItemLabel
{
    for (int i = 0; i < _eachItemFrameArray.count; i++) {
        CGRect frame = [_eachItemFrameArray[i] CGRectValue];
        ASTopLabel *label = [[ASTopLabel alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, ASItemHeight - ASBottomLineHeight)];
        label.tag = ASTopLabelTag + i;
        label.text = _titlesArray[i];
        label.delegate = self;
        label.textAlignment = NSTextAlignmentCenter;
        label.normalTitleSize = self.normalSize;
        label.selectedTilteSize = self.selectedSize;
        label.normalTitleColor = self.normalItemTitleColor;
        label.selectedTitleColor = self.selectItemTitleColor;
        label.userInteractionEnabled = YES;
        [_allLabelArray addObject:label];
        //调用方法设置第一个选中状态，其他的不是选中状态
        if (i == 0) {
            [label selectedLabelNOAnimation];
        }else{
            [label deselectedlabelNOAnimation];
        }
        [_scrollView addSubview:label];
    }
}

//刷新item的位置，使其处于中心位置
-(void)refreshCurrenrItemToCenter
{
    CGRect willToLabelFrame = _selectLabel.frame;
    CGFloat itemX = willToLabelFrame.origin.x;
    CGFloat width = _scrollView.frame.size.width;
    CGSize contentSize = _scrollView.contentSize;
    //X轴的坐标在界面一般以上的时候考虑是否滑动scrollView使其位于中间
    if (itemX > width/2) {
        //
        CGFloat targetX = 0.0;
        if ((contentSize.width - itemX) <= width/2) {
            targetX = contentSize.width - width;
        }else{
            targetX = willToLabelFrame.origin.x - width / 2 + willToLabelFrame.size.width / 2;
        }
        if (targetX + width > contentSize.width) {
            targetX = contentSize.width - width;
        }
        [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES];
    }else{
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

//MARK: SSTopLabelDelegate
-(void)didClickTopItemScrollToVC:(ASTopLabel *)item
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollTopDestinationVC:)]) {
        [self.delegate scrollTopDestinationVC:(item.tag - ASTopLabelTag)];
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
