
//
//  ASPageViewController.m
//  ASPageViewController-OC
//
//  Created by haohao on 16/9/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASPageViewController.h"

@interface ASPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate, ASTopViewDelegate>
{
    UIPageViewController *_pageViewController;
    NSArray<Class> *_classesArray;
    NSMutableArray *_vcArray;
    NSArray<NSString *> *_titleArray;
    //记录当前的索引
    NSInteger _currentVCIndex;
    //顶部的View
    ASTopView *_topView;
    //顶部View两边的空隙
    CGFloat _sideWidth;
    //每一个Item的宽度
    NSMutableArray *_itemWidthArrayInternal;
    //设置一个变量用来划分是点击滑动还是侧滑滑动
    BOOL _isClick;
    //用来接收点击的label的下标值
    NSInteger _willToIndex;
}
@end

@implementation ASPageViewController


-(void)setSideBothWidth:(CGFloat)sideWidth
{
    _sideWidth = sideWidth;
}
//创建实例方法
-(id)initWithViewControllerClasses:(NSArray<Class> *)classes andTitles:(NSArray <NSString *> *)titles
{
    if (self = [super init]) {
        NSAssert(classes.count == titles.count, @"You set the number of the controller and the title number is inconsistent");
        _itemWidthArrayInternal = [NSMutableArray arrayWithCapacity:titles.count];
        _vcArray = [NSMutableArray arrayWithCapacity:titles.count];
        _classesArray = [NSArray arrayWithArray:classes];
        _titleArray = [NSArray arrayWithArray:titles];
        self.style = ASTopViewStyleLine;
        self.lineColor = ASBottomLineColor;
        self.normalSize = ASItemTitlefontNormal;
        self.selectedSize = ASItemTitleFontSelected;
        self.normalTitleColor = ASItemTitleColorNormal;
        self.selectTitleColor = ASItemTitleColorSelected;
        //创建试图实例
        [self creatVC];
    }
    return self;
}
//MARK:创建试图实例
-(void)creatVC
{
    for (int i = 0; i < _classesArray.count; i++) {
        [_vcArray addObject:[[_classesArray[i] alloc]init]];
    }
}

//创建各部分UI
-(void)creatUI
{
    //实例化pageViewController控制器
    [self creatPageViewController];
}

//MARK: 实例化pageViewController控制器
-(void)creatPageViewController
{
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    //指定第一个VC
    [_pageViewController setViewControllers:@[_vcArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    //设置代理
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    //设置pageViewControler的frame
    [self setPageViewControllerFrame];
    
    //给pageViewController上面的ScrollView添加代理
    for (UIView *view in _pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [view setValue:self forKey:@"delegate"];
            break;
        }
    }
    [self.view addSubview:_pageViewController.view];
}

//MARK: 设置pageViewControler的frame
-(void)setPageViewControllerFrame
{
    //没有导航栏的时候为nil
    UIView *tabBar = self.tabBarController.tabBar ? self.tabBarController.tabBar : self.navigationController.toolbar;
    CGFloat height = tabBar && !tabBar.hidden ? CGRectGetHeight(tabBar.frame) : 0;
    if (self.navigationController.navigationBar) {
        //默认44的高度给顶部的View
        _pageViewController.view.frame = CGRectMake(0, 64 + ASItemHeight, kScreenWidth, kScreenHeight - 64 - height - ASItemHeight);
    }else{
        _pageViewController.view.frame = CGRectMake(0, 20 + ASItemHeight, kScreenWidth, kScreenHeight - 20 - height - ASItemHeight);
    }
}

//MARK: -- UIPageViewController的协议方法
//返回下一个VC
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [_vcArray indexOfObject:viewController];
    if (index == _vcArray.count - 1) {
        return nil;
    }
    return _vcArray[index + 1];
}

//返回上一个VC
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [_vcArray indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    return _vcArray[index - 1];
}

//结束之后调用
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    _currentVCIndex = [_vcArray indexOfObject:_pageViewController.viewControllers[0]];
}

//MARK:scrollView的协议方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isClick) {
        //如果是点击的时候执行这里的方法
        [_topView clickLabelMethod:(int)_currentVCIndex withContentOffSetX:scrollView.contentOffset.x withToIndex:(int)_willToIndex];
        if ((scrollView.contentOffset.x - kScreenWidth) == 0) {
            _isClick = NO;
        }
    }else{
        [_topView hhhhhWithCurrent:(int)_currentVCIndex withconX:scrollView.contentOffset.x];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.itemWidthArray.count > 0) {
        NSAssert(_titleArray.count == self.itemWidthArray.count, @"You set the width of the item array not isEqual to the controllers count");
    }
    if (self.itemWidth > 0) {
        for (int i = 0; i < _titleArray.count; i++) {
            [_itemWidthArrayInternal addObject:@(self.itemWidth)];
        }
    }else{
        for (int i = 0; i < _titleArray.count; i++) {
            [_itemWidthArrayInternal addObject:@(ASItemWidth)];
        }
    }
    //创建各部分组件
    [self creatUI];
    
    //创建顶部的View
    [self creatTopView];
}

//创建顶部的View
-(void)creatTopView
{
    CGFloat topViewY;
    if (self.navigationController.navigationBar) {
        topViewY = 64;
    }else{
        topViewY = 20;
    }

    _topView = [[ASTopView alloc]initWithFrame:CGRectMake(_sideWidth, topViewY, kScreenWidth - _sideWidth * 2, ASItemHeight) andTitles:_titleArray];
    if (self.topViewBackGroundColor) {
        _topView.topBackColor = self.topViewBackGroundColor;
    }
    _topView.delegate = self;
    _topView.style = self.style;
    _topView.lineColor = self.lineColor;
    _topView.normalSize = self.normalSize;
    _topView.selectedSize = self.selectedSize;
    _topView.normalItemTitleColor = self.normalTitleColor;
    _topView.selectItemTitleColor = self.selectTitleColor;
    if (_itemWidthArrayInternal.count > 0) {
        if (self.itemWidthArray.count > 0) {
            [_itemWidthArrayInternal removeAllObjects];
            [_itemWidthArrayInternal addObjectsFromArray:self.itemWidthArray];
        }
    }
    //需要计算一下，如果设置的总宽度没有达到界面的宽度的时候，这个时候我们必须计算，加空格
    CGFloat max = 0.0;
    for (int i = 0; i < _itemWidthArrayInternal.count; i++) {
        max = max + [_itemWidthArrayInternal[i] floatValue];
    }
    _topView.itemWidthArray = [NSArray arrayWithArray:_itemWidthArrayInternal];
    [self.view addSubview:_topView];
}

-(void)scrollTopDestinationVC:(NSInteger)index
{
    _isClick = YES;
    _willToIndex = index;
    [_pageViewController setViewControllers:@[_vcArray[index]] direction:index < _currentVCIndex animated:YES completion:^(BOOL finished) {
        _currentVCIndex = index;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
