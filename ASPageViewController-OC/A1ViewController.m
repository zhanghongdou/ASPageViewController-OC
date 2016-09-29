//
//  A1ViewController.m
//  SSPageViewController-OC
//
//  Created by haohao on 16/9/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "A1ViewController.h"

@interface A1ViewController ()

@end

@implementation A1ViewController
//如果使用的是故事版的话，需要加入这个方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        A1ViewController *a1= [storyBoard instantiateViewControllerWithIdentifier:@"A1ViewController"];
        return a1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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
