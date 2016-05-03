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
@property (nonatomic,strong)RACCommand * command;
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

    
    [self racExample];
}



-(void)racExample{

    //创建信号
    RACSignal * siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        //发送数据
        [subscriber sendNext:@(1)];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"取消订阅信号");
        }];
        return nil;
    }];
    //订阅信号
    [siganl subscribeNext:^(id x) {
        NSLog(@"接受的数据：%@",x);
    }];
    
    
    RACReplaySubject *replasubject = [RACReplaySubject subject];
    [replasubject sendNext:@8];
    [replasubject sendNext:@9];
    
    [replasubject subscribeNext:^(id x) {
        
        //  NSLog(@"%@",x);
    }];
    [replasubject subscribeNext:^(id x) {
        
        // NSLog(@"%@",x);
    }];
    
    /**
     *  数组遍历
     */
    NSArray * numbers =@[@"a",@"b",@"c"];
    
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
        // NSLog(@"%@",x);
    }];
    
    /**
     *  字典遍历
     */
    NSDictionary * dict = @{@"1":@"a",@"2":@"b",@"3":@"c",@"4":@"d"};
    
    [dict.rac_sequence.signal subscribeNext:^(RACTuple * x) {
        NSLog(@"%@",x[0]);
        NSLog(@"%@",x[1]);
        
    }];
    
    //事件处理
    
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        NSLog(@"执行命令");
        //   return [RACSignal empty];
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"请求数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    _command = command;
    
    
    
    [command.executionSignals subscribeNext:^(id x) {
        
        
        [x subscribeNext:^(id x) {
            
            NSLog(@"%@",x);
            
        }];
    }];
    
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [[command.executing skip:1] subscribeNext:^(id x) {
        if ([x boolValue] == YES) {
            NSLog(@"正在执行");
        }else{
            
            NSLog(@"执行完毕");
        }
    }];
    [self.command execute:nil];
    
    //代理
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0,  0, 100, 100);
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"bbbb" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    
    [[btn rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
        
        NSLog(@"点击蓝色按钮");
    }];
    [[btn rac_valuesAndChangesForKeyPath:@"currentTitle" options:NSKeyValueObservingOptionNew observer:nil]subscribeNext:^(id x) {
        
        NSLog(@"%@",btn.currentTitle);
    }];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"按钮被点击了");
    }];
    
}
- (void)btnClick:(UIButton*)btn{
    NSLog(@"clickBtn");
    [btn setTitle:@"zxzxzxzx" forState:UIControlStateNormal];
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
