//
//  SwizzleUtility.m
//  Sinofake
//
//  Created by zhucuirong on 15/5/22.
//  Copyright (c) 2015年 elong. All rights reserved.
//

#import "SwizzleUtility.h"
#import <objc/runtime.h>

@implementation SwizzleUtility
void swizzleInstanceMethod(Class c, SEL origSEL, SEL swizSEL) {
    Method originalMethod = class_getInstanceMethod(c, origSEL);
    Method swizzledMethod = class_getInstanceMethod(c, swizSEL);
    
    // When swizzling a class method, use the following:
    // Class class = object_getClass((id)self);
    // ...
    // Method originalMethod = class_getClassMethod(class, originalSelector);
    // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    if (!originalMethod || !swizzledMethod) {
        return;
    }
    
    BOOL didAddMethod =
    class_addMethod(c,
                    origSEL,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(c,
                            swizSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

void swizzleClassMethod(Class c, SEL origSEL, SEL swizSEL) {
    Method originalMethod = class_getClassMethod(c, origSEL);
    Method swizzledMethod = class_getClassMethod(c, swizSEL);
    if (!originalMethod || !swizzledMethod) {
        return;
    }
    
    BOOL didAddMethod =
    class_addMethod(c,
                    origSEL,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(c,
                            swizSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
