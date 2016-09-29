//
//  ViewController.m
//  ASPageViewController-OC
//
//  Created by haohao on 16/9/29.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ViewController.h"
#import "A1ViewController.h"
#import "A2ViewController.h"
#import "A3ViewController.h"
#import "A4ViewController.h"
#import "A5ViewController.h"
#import "ASPageViewController.h"
@interface ViewController ()
{
    ASPageViewController *vc;
}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //实例化
    vc = [[ASPageViewController alloc]initWithViewControllerClasses:@[[A1ViewController class], [A2ViewController class], [A3ViewController class], [A4ViewController class], [A5ViewController class]] andTitles:@[@"控制1",@"控制2",@"控制3",@"控制4",@"控制5"]];
    //设置每一个item的宽度
    vc.itemWidth = 90;
    //设置样式（有下划线）
    vc.style = ASTopViewStyleLine;
    //（无下划线）
    //    vc.style = ASTopViewStyleNOLine;
    //设置两边空出的宽度
    //    vc.sideBothWidth = 20;
    //设置正常的字体颜色
    //    vc.normalTitleColor = [UIColor orangeColor];
    //设置选中的时候的字体颜色
    //    vc.selectTitleColor = [UIColor blueColor];
    //设置上部item的背景色
    //    vc.topViewBackGroundColor = [UIColor yellowColor];
    //设置下划线的颜色
    //    vc.lineColor = [UIColor blueColor];
    //设置所有item的宽度数组
    //    vc.itemWidthArray = @[@(150),@(80),@(70),@(90),@(150)];
    
}
- (IBAction)btnClick:(id)sender {
    [self.navigationController pushViewController:vc animated:YES];
    //    [self presentViewController:vc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

