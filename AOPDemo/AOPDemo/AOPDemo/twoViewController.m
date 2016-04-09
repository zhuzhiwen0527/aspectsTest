//
//  twoViewController.m
//  AOPDemo
//
//  Created by zzw on 16/4/7.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "twoViewController.h"

@interface twoViewController ()

@end

@implementation twoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 200, 100);
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(print) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)print{

    if (self.delegateSubject) {
        [self.delegateSubject sendNext:@"返回"];
    }

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
