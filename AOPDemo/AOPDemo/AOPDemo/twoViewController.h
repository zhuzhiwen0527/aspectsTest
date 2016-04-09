//
//  twoViewController.h
//  AOPDemo
//
//  Created by zzw on 16/4/7.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"
@interface twoViewController : UIViewController
@property (nonatomic,strong) RACSubject * delegateSubject;
@end
