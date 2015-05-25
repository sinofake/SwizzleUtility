//
//  SwizzleUtility.h
//  Sinofake
//
//  Created by zhucuirong on 15/5/22.
//  Copyright (c) 2015年 elong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 做方法混淆，最好放在类别方法 + (void)load的dispatch_once闭包中
 */
@interface SwizzleUtility : NSObject
/**
 *  混淆实例方法
 *
 *  @param c       在类别中传[self class]
 *  @param origSEL <#origSEL description#>
 *  @param swizSEL <#swizSEL description#>
 */
void swizzleInstanceMethod(Class c, SEL origSEL, SEL swizSEL);

/**
 *  混淆类方法
 *
 *  @param c       在类别中传object_getClass((id)self)
 *  @param origSEL <#origSEL description#>
 *  @param swizSEL <#swizSEL description#>
 */
void swizzleClassMethod(Class c, SEL origSEL, SEL swizSEL);
@end
