//
//  UIViewController+Swizzle.m
//  SwizzleUtility
//
//  Created by zhucuirong on 15/5/22.
//  Copyright (c) 2015年 elong. All rights reserved.
//

#import "UIViewController+Swizzle.h"
#import "SwizzleUtility.h"

@implementation UIViewController (Swizzle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleInstanceMethod([self class], @selector(viewWillAppear:), @selector(ss_viewWillAppear:));
    });
}

#pragma mark - Method Swizzling
/**
 咋看上去是会导致无限循环的。但令人惊奇的是，并没有出现这种情况。在swizzling的过程中，方法中的[self ss_viewWillAppear:animated]已经被重新指定到UIViewController类的-viewWillAppear:中。在这种情况下，不会产生无限循环。不过如果我们调用的是[self viewWillAppear:animated]，则会产生无限循环，因为这个方法的实现在运行时已经被重新指定为ss_viewWillAppear:了。
 */
- (void)ss_viewWillAppear:(BOOL)animated {
    [self ss_viewWillAppear:animated];
    NSLog(@"<%s: %d> %s", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __func__);

}

@end
