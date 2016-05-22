//
//  UIViewController+swizzling.h
//  AOPDemo
//
//  Created by zzw on 16/5/22.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (swizzling)
- (void)my_viewWillAppear:(BOOL)animated;
@end
