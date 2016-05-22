//
//  UIViewController+swizzling.m
//  AOPDemo
//
//  Created by zzw on 16/5/22.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "UIViewController+swizzling.h"
#import <objc/runtime.h>
@implementation UIViewController (swizzling)
+(void)load{

    [self swizzleMethod:@selector(viewWillAppear:) withMethod:@selector(my_viewWillAppear:)];

}

+ (void)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            
            method_exchangeImplementations(originalMethod , swizzledMethod);
            
        }
    });

}

- (void)my_viewWillAppear:(BOOL)animated{

    NSLog(@"已经交换了");
}
@end
