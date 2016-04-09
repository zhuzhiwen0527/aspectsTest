//
//  ViewController.m
//  AOPDemo
//
//  Created by zzw on 16/4/7.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "ViewController.h"
#import "Aspects.h"
#import "ReactiveCocoa.h"
#import "twoViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 200, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(print) forControlEvents:UIControlEventTouchUpInside];
    [self aspect_hookSelector:@selector(print) withOptions:AspectPositionBefore usingBlock:^{
        [btn setTitle:@"qeq" forState:UIControlStateNormal];
     
    
    }error:NULL];
    
    [self aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionInstead usingBlock:^{
    
        NSLog(@"布局完成！！");
    } error:NULL];
    [self.view addSubview:btn];
    
    RACSignal * siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@(1)];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"取消订阅信号");
        }];
        return nil;
    }];
    [siganl subscribeNext:^(id x) {
        NSLog(@"接受的数据：%@",x);
    }];
}
- (void)print{
  
    NSLog(@"vvvv");
    twoViewController * two = [[twoViewController alloc] init];
    
    
    two.delegateSubject = [RACSubject subject];
    [two.delegateSubject subscribeNext:^(id x) {
        NSLog(@"%@",x);
        
    }];
    
    [self presentViewController:two animated:YES completion:nil];
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
