//
//  twoViewController.m
//  AOPDemo
//
//  Created by zzw on 16/4/7.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "twoViewController.h"
#import "ReactiveCocoa.h"
#import "EXTScope.h"
@interface twoViewController ()
@property (nonatomic,copy)UITextField *tf;
@property (nonatomic,copy)UILabel * lab;
@end

@implementation twoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 0, 200, 100);
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(print) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 150, 200, 100)];
    _tf.backgroundColor = [UIColor greenColor];
    
    //监听tf
    [_tf.rac_textSignal subscribeNext:^(id x) {
       // NSLog(@"%@",x);
    }];
    
    //映射
    [[_tf.rac_textSignal flattenMap:^RACStream *(id value) {
      return [RACSignal return:[NSString stringWithFormat:@"输出:%@",value]];
    }] subscribeNext:^(id x) {
       // NSLog(@"映射:%@",x);
    }];
    
    
   [[ _tf.rac_textSignal map:^id(id value) {
        return [NSString stringWithFormat:@"%@",value];
    }] subscribeNext:^(id x) {
         NSLog(@"映射:%@",x);
    }];
    
    
    [self.view addSubview:_tf];
    
    _lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 260, 200, 100)];
    _lab.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_lab];
    
    //tf 改变 lab的text改变
    RAC(_lab,text) = _tf.rac_textSignal;
    
    //kvo
    [RACObserve(_lab, text) subscribeNext:^(id x) {
        NSLog(@"text:%@",x);
    }];
    //kvo
    [[_lab rac_valuesAndChangesForKeyPath:@"text" options:NSKeyValueObservingOptionNew observer:nil]subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
    

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
